{{/*
Expand the name of the chart.
*/}}
{{- define "fireworks-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*does not works*/}}
{{- define "fireworks-app.is-dev-env" -}}
{{- if eq .Values.infra.env "dev" }}
true
{{- else }}
false
{{- end }}
{{- end }}

{{- define "fireworks-app.is-dev-env-2" -}}
{{- if eq .Values.infra.env "dev" }}
{{ include "fireworks-app.dev" . }}
{{- else if eq .Values.infra.env "pro" }}
{{ include "fireworks-app.pro" . }}
{{- end }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "fireworks-app.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
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
{{- define "fireworks-app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "fireworks-app.labels" -}}
helm.sh/chart: {{ include "fireworks-app.chart" . }}
{{ include "fireworks-app.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "fireworks-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "fireworks-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "fireworks-app.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "fireworks-app.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Compose toRepo URL
*/}}
{{- define "fireworks-app.toRepoUrl" -}}
{{- printf "%s/%s/%s" .Values.git.toRepo.scmUrl .Values.git.toRepo.org .Values.git.toRepo.name }}
{{- end }}

{{/*
Compose fromRepo URL
*/}}
{{- define "fireworks-app.fromRepoUrl" -}}
{{- printf "%s/%s/%s" .Values.git.fromRepo.scmUrl .Values.git.fromRepo.org .Values.git.fromRepo.name }}
{{- end }}