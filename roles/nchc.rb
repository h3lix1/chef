name "nchc"
description "Role applied to all servers at NCHC"

default_attributes(
  :accounts => {
    :users => {
      :steven => { :status => :administrator },
      :ceasar => { :status => :administrator }
    }
  },
  :hosted_by => "NCHC",
  :location => "Hsinchu, Taiwan",
  :networking => {
    :nameservers => ["8.8.8.8", "8.8.4.4"],
    :roles => {
      :external => {
        :zone => "nc"
      }
    }
  }
)

override_attributes(
  :ntp => {
    :servers => ["0.tw.pool.ntp.org", "1.tw.pool.ntp.org", "europe.pool.ntp.org"]
  }
)

run_list(
  "role[tw]"
)
