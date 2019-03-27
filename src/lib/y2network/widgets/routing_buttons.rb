require "cwm/common_widgets"
require "y2network/dialogs/route"
require "y2network/route"

Yast.import "Routing"

module Y2Network
  module Widgets
    class AddRoute < CWM::PushButton
      def initialize(table)
        @table = table
        textdomain "network"
      end

      def label
        _("Ad&d")
      end

      def handle
        route = Y2Network::Route.new
        res = Y2Network::Dialogs::Route.run(route, Yast::Routing.GetDevices + ["-"])
        @table.add_route(route) if res == :ok

        nil
      end
    end

    class EditRoute < CWM::PushButton
      def initialize(table)
        @table = table
        textdomain "network"
      end

      def label
        _("&Edit")
      end

      def handle
        route = @table.selected_route.dup
        res = Y2Network::Dialogs::Route.run(route, Yast::Routing.GetDevices + ["-"])
        @table.replace_route(route) if res == :ok

        nil
      end
    end

    class DeleteRoute < CWM::PushButton
      def initialize(table)
        @table = table
        textdomain "network"
      end

      def label
        _("De&lete")
      end

      def handle
        @table.delete_route

        nil
      end
    end
  end
end
