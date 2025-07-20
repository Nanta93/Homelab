:local cfzoneid "XXXXXXXXXXXXXXXXXXXXXXX"
:local cfdnsrecordid "XXXXXXXXXXXXXXXXXXXXXXX"
:local cftoken "XXXXXXXXXXXXXXXXXXXXXXX"
:local cfdnshost "DOMAIN.COM"

:local publicinterface "PPPoE"

:local ipfresh [ /ip address get [ find where interface=$publicinterface ] address ]
:set ipfresh [:pick $ipfresh 0 [:find $ipfresh "/" -1]]

:log info "[Cloudflare DDNS] IP detected: $ipfresh"

:local cfurl "https://api.cloudflare.com/client/v4/zones/$cfzoneid/dns_records/$cfdnsrecordid"
:local cfHeader "Authorization: Bearer $cftoken,Content-Type: application/json"

:local response [/tool fetch url="$cfurl" http-header-field="$cfHeader" output=user as-value]
:local data [:deserialize from=json ($response->"data")]
:local ipddns "$($data->"result"->"content")"
:log info "[Cloudflare DDNS] IP from DNS: $ipddns"

:if ($ipddns != $ipfresh) do={
   :local dateTime ([ /system clock get date ] . " " . [ / system clock get time ]);
   :local cfDataDNS "{\"type\":\"A\",\"name\":\"$cfdnshost\",\"content\":\"$ipfresh\",\"ttl\":60,\"proxied\":true,\"comment\":\"last update: $dateTime\"}"
   /tool fetch url="$cfurl" http-data="$cfDataDNS" http-header-field="$cfHeader" http-method=put keep-result=no
   :log info "[Cloudflare DDNS] DNS record updated"
}
