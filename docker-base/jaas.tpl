{{ define "config" -}}
{{ or .server_name "Server" }} {
    {{ or .server_login_class "com.sun.security.auth.module.Krb5LoginModule" }} required
    useKeyTab={{ or .server_use_keytab "true" }}
    storeKey={{ or .server_store_key "true" }}
    keyTab={{ or .server_keytab "/etc/security/keytabs/kafka.keytab" }}
    principal={{ or .server_principal "kafka" }};
};
{{ end -}}

{{ define "config2" -}}
{{ or .client_name "Client" }} {
    {{ or .client_login_class "com.sun.security.auth.module.Krb5LoginModule" }} required
    useKeyTab={{ or .client_use_keytab "true" }}
    storeKey={{ or .client_store_key "true" }}
    keyTab={{ or .client_keytab "/etc/security/keytabs/kafka.keytab" }}
    principal={{ or .client_principal "kafka" }};
};
{{ end -}}