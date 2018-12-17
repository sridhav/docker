{{ define "config" -}}
{{ range $key, $value := . -}}
{{ $key }}={{ $value }}
{{end -}}
{{end -}}