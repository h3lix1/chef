name "vial"
description "Master role applied to vial"

default_attributes(
  :apt => {
    :sources => ["postgresql"]
  },
  :devices => {
    :ssd_samsung => {
      :comment => "Tune scheduler for SSD",
      :type => "block",
      :bus => "ata",
      :serial => "SAMSUNG_MZ7LM960HCHP-*",
      :attrs => {
        "queue/scheduler" => "noop",
        "queue/nr_requests" => "256",
        "queue/read_ahead_kb" => "2048"
      }
    }
  },
  :hardware => {
    :modules => %w[nct6775],
    :sensors => {
      "nct6779-isa-0290" => {
        :volts => {
          "in0" => { :ignore => true },
          "in1" => { :ignore => true },
          "in4" => { :ignore => true },
          "in5" => { :ignore => true },
          "in6" => { :ignore => true },
          "in9" => { :ignore => true },
          "in10" => { :ignore => true },
          "in11" => { :ignore => true },
          "in12" => { :ignore => true },
          "in13" => { :ignore => true },
          "in14" => { :ignore => true }
        },
        :fans => {
          "fan1" => { :ignore => true },
          "fan2" => { :ignore => true }
        },
        :temps => {
          "temp1" => { :ignore => true },
          "temp2" => { :ignore => true },
          "temp5" => { :ignore => true },
          "temp6" => { :ignore => true },
          "temp7" => { :ignore => true },
          "temp8" => { :ignore => true },
          "temp9" => { :ignore => true },
          "temp10" => { :ignore => true }
        }
      }
    }
  },
  :networking => {
    :interfaces => {
      :external_ipv4 => {
        :interface => "eth0",
        :role => :external,
        :family => :inet,
        :address => "138.201.195.31",
        :prefix => "26",
        :gateway => "138.201.195.1"
      },
      :external_ipv6 => {
        :interface => "eth0",
        :role => :external,
        :family => :inet6,
        :address => "2a01:4f8:172:3cde::2",
        :prefix => "64",
        :gateway => "fe80::1"
      }
    }
  },
  :postgresql => {
    :versions => ["9.6"],
    :settings => {
      :defaults => {
        :shared_buffers => "8GB",
        :maintenance_work_mem => "7144MB",
        :effective_cache_size => "16GB"
      }
    }
  },
  :sysctl => {
    :postgres => {
      :comment => "Increase shared memory for postgres",
      :parameters => {
        "kernel.shmmax" => 9 * 1024 * 1024 * 1024,
        "kernel.shmall" => 9 * 1024 * 1024 * 1024 / 4096
      }
    }
  },
  :tile => {
    :database => {
      :cluster => "9.6/main"
    },
    :node_file => "/store/database/nodes",
    :styles => {
      :default => {
        :tile_directories => [
          { :name => "/store/tiles/default", :min_zoom => 0, :max_zoom => 19 }
        ]
      }
    }
  }
)

run_list(
  "role[hetzner]",
  "role[tile]"
)
