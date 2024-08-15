{{/*
Define o nome completo do release.
*/}}
{{- define "giropopsSenhas.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Define o nome do ServiceAccount.
*/}}
{{- define "giropopsSenhas.serviceAccountName" -}}
{{- .Values.serviceAccount.name | default "default-service-account" -}}
{{- end -}}

{{/*
Define os labels para o selector.
*/}}
{{- define "giropopsSenhas.selectorLabels" -}}
app: {{ include "giropopsSenhas.fullname" . }}
{{- end -}}

{{/*
Define os labels para o deployment.
*/}}
{{- define "giropopsSenhas.labels" -}}
app: {{ include "giropopsSenhas.fullname" . }}
{{- end -}}

