{{- define "rttys.config" -}}
addr-dev: :{{ .Values.services.rttys.ports.dev.targetPort }}
addr-user: :{{ .Values.services.rttys.ports.user.targetPort }}
addr-web: :{{ .Values.services.rttys.ports.web.targetPort }}
{{ if .Values.config.webRedirUrl }}
web-redir-url: {{ .Values.config.webRedirUrl }}
{{ end }}
http-username: {{ .Values.config.httpUsername }}
http-password: {{ .Values.config.httpPassword }}
ssl-cert: /rttys/certs/restapi-cert.pem
ssl-key: /rttys/certs/restapi-key.pem
ssl-ca: /rttys/certs/restapi-ca.pem
token: {{ .Values.config.token }}
white-list: {{ .Values.config.whiteList }}
db: {{ .Values.mysql.auth.username }}:{{ .Values.mysql.auth.password }}@tcp({{ if .Values.mysql.enabled }}{{ .Release.Name }}-mysql{{ else }}{{ .Values.mysql.host }}{{ end }})/{{ .Values.mysql.auth.database }}
{{- end -}}
