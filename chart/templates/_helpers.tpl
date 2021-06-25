{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "rttys.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "rttys.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "rttys.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "rttys.config" -}}
addr-dev: :{{ .Values.services.rttys.ports.dev.targetPort }}
addr-user: :{{ .Values.services.rttys.ports.user.targetPort }}
addr-web: :{{ .Values.services.rttys.ports.web.targetPort }}
{{ if .Values.config.webRedirUrl }}
web-redir-url: {{ .Values.config.webRedirUrl }}
{{ end }}
ssl-cert: /rttys/certs/restapi-cert.pem
ssl-key: /rttys/certs/restapi-key.pem
ssl-ca: /rttys/certs/restapi-ca.pem
token: {{ .Values.config.token }}
white-list: {{ .Values.config.whiteList }}
db: {{ .Values.mysql.auth.username }}:{{ .Values.mysql.auth.password }}@tcp({{ if .Values.mysql.enabled }}{{ .Release.Name }}-mysql{{ else }}{{ .Values.mysql.host }}{{ end }})/{{ .Values.mysql.auth.database }}
{{- end -}}
