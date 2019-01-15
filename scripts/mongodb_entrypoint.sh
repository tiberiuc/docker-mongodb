#!/bin/bash

set -euo pipefail

# reinitialize supervisord.conf with geth args

tee -a >/etc/supervisord.conf <<EOF
[supervisord]
nodaemon=true

[program:backup]
command=/usr/local/bin/backup_agent -backup=/usr/local/bin/backup.sh -restore=/usr/local/bin/restore_backup.sh
stdout_logfile=/dev/stdout
stdout_logfile_maxbytes=0
stderr_logfile=/dev/stderr
stderr_logfile_maxbytes=0

[program:mongodb]
command=/usr/local/bin/start_mongodb.sh $@
stdout_logfile=/dev/stdout
stdout_logfile_maxbytes=0
stderr_logfile=/dev/stderr
stderr_logfile_maxbytes=0

EOF


/usr/bin/supervisord -c /etc/supervisord.conf
