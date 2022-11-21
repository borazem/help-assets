#! /bin/bash

# IBM script for setting 

export role=$1
export hostname=$2
export ip=$3
export domain=ocp.integracion.grupoib.local

# enter webserver with port if not 80 like 192.168.10.2:8086 or 192.168.10.2 if port is 80
export webserver=10.13.86.80

export dns1=130.30.2.2
export dns2=130.30.2.147
export dns3=10.11.8.10
export dns4=10.11.8.11
export dns5=10.11.8.12
export dns6=10.11.8.13

# ip information for bootstrap
export ipmaskb=23
export gatewayb=10.13.86.1
export dnsb=130.30.2.2,130.30.2.147,10.11.8.10,10.11.8.12,10.11.8.11,10.11.8.13
export ignitionb=bootstrap.ign

# ip information for mastera
export ipmaskma=23
export gatewayma=10.13.86.1
export dnsma=130.30.2.2,130.30.2.147,10.11.8.10,10.11.8.12,10.11.8.11,10.11.8.13
export ignitionma=master.ign
# ip information for masterb
export ipmaskmb=24
export gatewaymb=10.10.61.1
export dnsmb=130.30.2.2,130.30.2.147,10.11.8.10,10.11.8.12,10.11.8.11,10.11.8.13
export ignitionmb=master.ign

# ip information for worker
export ipmaskw=23
export gatewayw=10.13.64.1
export dnsw=130.30.2.2,130.30.2.147,10.11.8.10,10.11.8.12,10.11.8.11,10.11.8.13
export ignitionw=worker.ign

# ###############################################################

if [[ -z "$role" ]] || [[ -z "$hostname" ]] || [[ -z "$ip" ]]
then
    echo "enter role [b|ma|mb|w] as first, HOSTNAME as second and IP as third parameter like 'source ocpi.sh b myhostname 192.168.10.10"
else

   if [[ $role == "b" ]] || [[ $role == "ma" ]] || [[ $role == "mb" ]] || [[ $role == "w" ]]; then

      if [[ $role == "b" ]]; then
        
        export ipmask=$ipmaskb
        export gateway=$gatewayb
        export dns=$dnsb
        export ignition=$ignitionb

      elif [[ $role == "ma" ]]; then
        
        export ipmask=$ipmaskma
        export gateway=$gatewayma
        export dns=$dnsma
        export ignition=$ignitionma

      elif [[ $role == "mb" ]]; then
        
        export ipmask=$ipmaskmb
        export gateway=$gatewaymb
        export dns=$dnsmb
        export ignition=$ignitionmb

      elif [[ $role == "w" ]]; then
        
        export ipmask=$ipmaskw
        export gateway=$gatewayw
        export dns=$dnsw
        export ignition=$ignitionw

      fi 

      # set static gateway IP address
        echo nmcli con modify "Wired connection 1" ipv4.address "$ip/$ipmask"
        nmcli con modify "Wired connection 1" ipv4.address "$ip/$ipmask"
      
      # set static gateway IP address
        echo nmcli con modify "Wired connection 1" ipv4.gateway "$gateway"
        nmcli con modify "Wired connection 1" ipv4.gateway "$gateway"

      # set static DNS IP address
        echo nmcli con modify "Wired connection 1" ipv4.dns "$dns"
        nmcli con modify "Wired connection 1" ipv4.dns "$dns"

      # change ip address method from auto or dhcp to manual
        echo nmcli con modify "Wired connection 1" ipv4.method manual
        nmcli con modify "Wired connection 1" ipv4.method manual

      # make IP setting active
        echo nmcli con up "Wired connection 1"
        nmcli con up "Wired connection 1"


      # set hostname
        echo sudo hostnamectl set-hostname $hostname.$domain
        sudo hostnamectl set-hostname $hostname.$domain

        echo "#########################################"
        echo " Testing settings and accessibility "
        echo "#########################################"

        echo ""
        echo "#### HOSTNAME FQDN"
        hostname

        echo ""
        echo "#### IP ADDRESS"
        echo ip -br a
        ip -br a
        read -p "Pause, press [ENTER] to continue "

        echo ""
        echo "#### DNS resolving IP"
        if [[ -n $dns1 ]]; then
            echo dig +noall +answer @$dns1 -x $ip
            dig +noall +answer @$dns1 -x $ip
            echo nslookup for $dns1
            nslookup $ip $dns1
        fi
        if [[ -n $dns2 ]]; then
            echo dig +noall +answer @$dns2 -x $ip
            dig +noall +answer @$dns2 -x $ip
            echo nslookup for $dns2
            nslookup $ip $dns2
        fi
        if [[ -n $dns3 ]]; then
            echo dig +noall +answer @$dns3 -x $ip
            dig +noall +answer @$dns3 -x $ip
            echo nslookup for $dns3
            nslookup $ip $dns3
        fi
        if [[ -n $dns4 ]]; then
            echo dig +noall +answer @$dns4 -x $ip
            dig +noall +answer @$dns4 -x $ip
            echo nslookup for $dns4
            nslookup $ip $dns4
        fi
        if [[ -n $dns5 ]]; then
            echo dig +noall +answer @$dns5 -x $ip
            dig +noall +answer @$dns5 -x $ip
            echo nslookup for $dns5
            nslookup $ip $dns5
        fi
        if [[ -n $dns6 ]]; then
            echo dig +noall +answer @$dns6 -x $ip
            dig +noall +answer @$dns6 -x $ip
            echo nslookup for $dns6
            nslookup $ip $dns6
        fi
        read -p "Pause, press [ENTER] to continue "

        echo "#### DNS resolving FQDN"
        if [[ -n $dns1 ]]; then
            echo dig +noall +answer @$dns1 $hostname.$domain
            dig +noall +answer @$dns1 $hostname.$domain
        fi
        if [[ -n $dns2 ]]; then
            echo dig +noall +answer @$dns2 $hostname.$domain
            dig +noall +answer @$dns2 $hostname.$domain
        fi
        if [[ -n $dns3 ]]; then
            echo dig +noall +answer @$dns3 $hostname.$domain
            dig +noall +answer @$dns3 $hostname.$domain
        fi
        if [[ -n $dns4 ]]; then
            echo dig +noall +answer @$dns4 $hostname.$domain
            dig +noall +answer @$dns4 $hostname.$domain
        fi
        if [[ -n $dns5 ]]; then
            echo dig +noall +answer @$dns5 $hostname.$domain
            dig +noall +answer @$dns5 $hostname.$domain
        fi
        if [[ -n $dns6 ]]; then
            echo dig +noall +answer @$dns6 $hostname.$domain
            dig +noall +answer @$dns6 $hostname.$domain
        fi
        echo ""
        read -p "Pause, press [ENTER] to continue "


        # run coreos-installer
        echo ""
        echo ""
        read -p "pause before running coreos-installer, press [ENTER] to continue" 

        echo sudo coreos-installer install --ignition-url=http://$webserver/$ignition /dev/sda --insecure-ignition --copy-network --network-dir=/etc/NetworkManager/system-connections/
        sudo coreos-installer install --ignition-url=http://$webserver/$ignition /dev/sda --insecure-ignition --copy-network --network-dir=/etc/NetworkManager/system-connections/
   else
      echo "Not the correct node role was specified!!!"
   fi

fi
