{{/*
Expand the name of the chart.
*/}}
{{- define "splunk-connect-for-snmp.scheduler.name" -}}
{{- default (printf "%s-%s" .Chart.Name "scheduler")  .Values.scheduler.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "splunk-connect-for-snmp.scheduler.fullname" -}}
{{- if .Values.scheduler.fullnameOverride }}
{{- .Values.scheduler.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default (printf "%s-%s" .Chart.Name "scheduler") .Values.scheduler.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "splunk-connect-for-snmp.scheduler.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "splunk-connect-for-snmp.scheduler.labels" -}}
helm.sh/chart: {{ include "splunk-connect-for-snmp.scheduler.chart" . }}
{{ include "splunk-connect-for-snmp.scheduler.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "splunk-connect-for-snmp.scheduler.selectorLabels" -}}
app.kubernetes.io/name: {{ include "splunk-connect-for-snmp.scheduler.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}


{{/*
Create the name of the service account to use
*/}}

{{- define "splunk-connect-for-snmp.scheduler.serviceAccountCreate" -}}
{{- if (.Values.scheduler.serviceAccount).create }}
{{- default .Values.scheduler.serviceAccount.create }}
{{- else }}
{{- default "false" }}
{{- end }}
{{- end }}

{{- define "splunk-connect-for-snmp.scheduler.serviceAccountAnnotations" -}}
{{- if (.Values.scheduler.serviceAccount).annotations }}
{{- default .Values.scheduler.serviceAccount.annotations }}
{{- else }}
{{- default nil }}
{{- end }}
{{- end }}

{{- define "splunk-connect-for-snmp.scheduler.serviceAccountName" -}}
{{- if (include "splunk-connect-for-snmp.scheduler.serviceAccountCreate" .) }}
{{- default (include "splunk-connect-for-snmp.scheduler.fullname" .) (.Values.scheduler.serviceAccount).name }}
{{- else }}
{{- default "default" }}
{{- end }}
{{- end }}

{{- define "splunk-connect-for-snmp.scheduler.podAntiAffinity" -}}
{{- if (.Values.scheduler.podAntiAffinity) }}
{{- default .Values.scheduler.podAntiAffinity }}
{{- else }}
{{- default "soft" }}
{{- end }}
{{- end }}