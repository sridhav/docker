{{ define "config" -}}
[logging]
default = FILE:/var/log/krb5libs.log
kdc = FILE:/var/log/krb5kdc.log
admin_server = FILE:/var/log/kadmind.log

[libdefaults]
dns_lookup_realm = {{ or .dns_lookup_realm "false" }}
ticket_lifetime = {{ or .ticket_lifetime "24h" }}
renew_lifetime = {{ or .renew_lifetime "7d" }}
forwardable = {{ or .forwardable "true" }}
rdns = {{ or .rdns "false" }}
default_realm = {{ or .realm_name "example.com" }}

[realms]
{{ or .realm_name "example.com" | ToUpper }} = {
  kdc = {{ or .kdc_server "kerberos.example.com" }}
  admin_server = {{ or .kdc_server "kerberos.example.com" }}
}

[domain_realm]
.{{ or .realm_name "example.com" }} = {{ or .realm_name "example.com" | ToUpper }}
{{ or .realm_name "example.com" }} = {{ or .realm_name "example.com" | ToUpper }}
{{ end -}}