#!/bin/bash

cat <<EOF
{
  "Live Image": "20110207T205331Z",
  "Manufacturer": "Dell",
  "Product": "PowerEdge C2100",
  "Serial Number": "000ABC1",
  "UUID": "00000000-abcd-0000-fedc-ba9876543210",
  "CPU Type": "Intel(R) Xeon(R) CPU E5620 @ 2.40GHz",
  "CPU Physical Cores": 2,
  "CPU Total Cores": 16,
  "MiB of Memory": 49143,
  "Disks": {
    "c2t1d0": {"Size in GB": 2394},
    "c2t0d0": {"Size in GB": 299}
  },
  "Boot Parameters": {
    "console": "text",
    "headnode": "true"
  },
  "Network Interfaces": {
    "igb3": {"MAC Address": "be:ef:be:ef:be:ef", "NIC Names": []},
    "igb1": {"MAC Address": "01:23:45:67:89:ab", "NIC Names": ["admin"]},
    "igb2": {"MAC Address": "de:ad:de:ad:de:ad", "NIC Names": []},
    "igb0": {"MAC Address": "ba:db:ad:ba:db:ad", "NIC Names": []}
  }
}
EOF
