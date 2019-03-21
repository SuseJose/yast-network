# Copyright (c) [2019] SUSE LLC
#
# All Rights Reserved.
#
# This program is free software; you can redistribute it and/or modify it
# under the terms of version 2 of the GNU General Public License as published
# by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
# more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, contact SUSE LLC.
#
# To contact SUSE LLC about this file by physical or electronic mail, you may
# find current contact information at www.suse.com.
require "y2network/interface"

module Y2Network
  # This class represents the current network configuration including interfaces,
  # routes, etc.
  #
  # @example Reading from wicked
  #   config = Y2Network::Config.from(:sysconfig)
  #   config.interfaces.map(&:name) #=> ["lo", eth0", "wlan0"]
  class Config
    # @return [Array<Interface>]
    attr_reader :interfaces
    # @return [Array<RoutingTable>]
    attr_reader :routing_tables

    # @param source [Symbol] Source to read the configuration from
    class << self
      def from(source)
        builder = ConfigReader.for(source)
        builder.network_config
      end
    end

    # @param devices [Array<Device>]
    def initialize(interfaces:, routing_tables:)
      @interfaces = interfaces
      @routing_tables = routing_tables
    end

    # Routes in the configuration
    #
    # Convenience method to iterate through the routes in all routing tables.
    #
    # @return [Array<Route>] List of routes which are defined in the configuration
    def routes
      routing_tables.flat_map(&:to_a)
    end
  end
end
