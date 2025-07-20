# Cloudflare-DDNS using Mikrotik 

Reference:
- https://www.reddit.com/r/mikrotik/comments/1hjan62/comment/m37r8wc/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button

Guides:  
- https://youtu.be/QqxA9vscknc?si=dTR15TzzEXGebA_S 
- https://mikrotikmasters.com/how-to-use-ddns-on-cloudflare-dns/ 
- https://github.com/bajodel/mikrotik-cloudflare-dns

Script tested on RB750GR3 version 7.19

This script update cloudflare A record when there is a change in mikrotik public ip

Requirements:
- Zone ID
- API Token Edit
- Record ID
- Domain name (dns host)

Record ID can be obtain using this line in mikrotik terminal: \
/tool/fetch url="https://api.cloudflare.com/client/v4/zones/<ZONE ID>/dns_records" http-header-field="Authorization: Bearer <READ API TOKEN>" http-method=get output=user
