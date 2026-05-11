Return-Path: <linux-rdma+bounces-20367-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FjqGwiEAWoFcAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20367-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 09:23:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 195C950914A
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 09:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C1A63007B85
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 07:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6819437E31D;
	Mon, 11 May 2026 07:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikRnaWO0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7487737FF5B;
	Mon, 11 May 2026 07:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484204; cv=none; b=etkbS8pxUFnpEiEupAToJVGAtmzesZUGTB8SCR7HXxy3WlBwpfJQmh4MzBS1yYeTHi572iukwGmGLK1PrJdJiD7AWcTeJFjf5yjCbXkhg9HOttvvhs/TEiFxzyw5GB/fikWPWhmZlf1bUztE5/5YumHuohOHr0qbrguttZpGihI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484204; c=relaxed/simple;
	bh=FLleedy4XprnQ2/qy5ozrIuF85QAQgtIg7eu0TkJUCM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oDpiFM3tx9V323bEbZTxyqwre9w09Ji2mM6p7YWTTL7Gs5T2wdYPEmx3ux8B0POkEubEIH2fHKqzUrlvEGlq1I3ePWTtQ3+JD8MW1vUbNWUWhejOe5FwgcLScRO/Y/owiLMRgZB0zowaUuCSIB19Io8CvEs2JCRPELNK+VRI0IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikRnaWO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72579C2BCFC;
	Mon, 11 May 2026 07:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778484204;
	bh=FLleedy4XprnQ2/qy5ozrIuF85QAQgtIg7eu0TkJUCM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ikRnaWO0z1oYLdG1KRcjj2liQEqp4twC4mz0D2NH1WE6pjUJ5TPDCflcXT+PNum9l
	 FazMXXSbLqgMJKddoijGnAi7OO1w9qpaqRKR5rNbz5M0bLnU6BsTQKMcWOpAYRYbCq
	 6Ck2+f4bKkLx8dRWhnIGhhmWWoKTGgERf8o5SmG/XL/rfC8Bk2QuKTp7o2Dt7MKi0J
	 mQyg8gvCVLAQE+P08fwZAMC/ltm9+smcueQf02p6qX9emQ3MI1YiRqz/J28Eo9hglz
	 Pwrk9C+RKaSlXX7vV95dmH1oD1Htdi2UhxM2uqVFZNVIZlLyCHeRmLSVJaxPasvSxp
	 GyZDOb4oIy2IQ==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	achender@kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Subject: [PATCH net-next v1 9/9] selftests: rds: Add ROCE support to run.sh
Date: Mon, 11 May 2026 00:23:16 -0700
Message-Id: <20260511072316.1174045-10-achender@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260511072316.1174045-1-achender@kernel.org>
References: <20260511072316.1174045-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 195C950914A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-20367-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,config.sh:url]
X-Rspamd-Action: no action

This patch adds support for testing rds rdma over ROCE.  A new
-r flag is added to config.sh which enables the required kernel
configs for rdma.  We also add a -T flag to run.sh, which takes
a transport option, tcp or rdma.  The rdma option will check to
ensure the proper configs have been enabled. The flag is then
passed to test.py, which will run the test over the specified
transport(s)

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/config.sh | 15 ++++++-
 tools/testing/selftests/net/rds/run.sh    | 51 ++++++++++++++++++++++-
 2 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/rds/config.sh b/tools/testing/selftests/net/rds/config.sh
index 29a79314dd60..be0668359a07 100755
--- a/tools/testing/selftests/net/rds/config.sh
+++ b/tools/testing/selftests/net/rds/config.sh
@@ -10,7 +10,8 @@ CONF_FILE=""
 FLAGS=()
 
 GENERATE_GCOV_REPORT=0
-while getopts "gc:" opt; do
+ENABLE_RDMA=0
+while getopts "gc:r" opt; do
   case ${opt} in
     g)
       GENERATE_GCOV_REPORT=1
@@ -18,8 +19,11 @@ while getopts "gc:" opt; do
     c)
       CONF_FILE=$OPTARG
       ;;
+    r)
+      ENABLE_RDMA=1
+      ;;
     :)
-      echo "USAGE: config.sh [-g] [-c config]"
+      echo "USAGE: config.sh [-g] [-c config] [-r]"
       exit 1
       ;;
     ?)
@@ -58,3 +62,10 @@ scripts/config "${FLAGS[@]}" --enable CONFIG_VETH
 # simulate packet loss
 scripts/config "${FLAGS[@]}" --enable CONFIG_NET_SCH_NETEM
 
+if [ "$ENABLE_RDMA" -eq 1 ]; then
+	# enable RDS over InfiniBand / RDMA (rds_rdma test)
+	scripts/config "${FLAGS[@]}" --enable CONFIG_INFINIBAND
+	scripts/config "${FLAGS[@]}" --enable CONFIG_INFINIBAND_ADDR_TRANS
+	scripts/config "${FLAGS[@]}" --enable CONFIG_RDMA_RXE
+	scripts/config "${FLAGS[@]}" --enable CONFIG_RDS_RDMA
+fi
diff --git a/tools/testing/selftests/net/rds/run.sh b/tools/testing/selftests/net/rds/run.sh
index 424fd57401d8..3b69218014d9 100755
--- a/tools/testing/selftests/net/rds/run.sh
+++ b/tools/testing/selftests/net/rds/run.sh
@@ -101,6 +101,15 @@ check_conf_enabled() {
 		exit 4
 	fi
 }
+
+check_rdma_conf_enabled() {
+	if ! grep -x "$1=y" "$kconfig" > /dev/null 2>&1; then
+		echo "selftests: [SKIP] rdma transport requires $1 enabled"
+		echo "To enable, run tools/testing/selftests/net/rds/config.sh -r and rebuild"
+		exit 4
+	fi
+}
+
 check_conf_disabled() {
 	if grep -x "$1=y" "$kconfig" > /dev/null 2>&1; then
 		echo "selftests: [SKIP] This test requires $1 disabled"
@@ -117,6 +126,27 @@ check_conf() {
 	check_conf_disabled CONFIG_MODULES
 }
 
+# Check kernel config and host environment for RDS-RDMA support.
+# Exits with SKIP (4) if the user requested rdma but prerequisites
+# are not met.
+check_rdma_conf()
+{
+	case "$TRANSPORT" in
+	  *rdma*) ;;
+	  *) return ;;
+	esac
+
+	# Kconfig will enforce CONFIG_INFINIBAND_* as dependencies
+	# of CONFIG_RDMA_RXE
+	check_rdma_conf_enabled CONFIG_RDMA_RXE
+	check_rdma_conf_enabled CONFIG_RDS_RDMA
+
+	if ! which rdma > /dev/null 2>&1; then
+		echo "selftests: [SKIP] rdma transport requires the 'rdma' tool (iproute2)"
+		exit 4
+	fi
+}
+
 check_env()
 {
 	if ! test -d "$obj_dir"; then
@@ -153,8 +183,10 @@ check_env()
 LOG_DIR="${RDS_LOG_DIR:-}"
 TIMEOUT=$timeout
 GENERATE_GCOV_REPORT=1
+TRANSPORT=tcp
 FLAGS=()
-while getopts "d:l:c:u:t:" opt; do
+
+while getopts "d:l:c:u:t:T:" opt; do
   case ${opt} in
     d)
       LOG_DIR=${OPTARG}
@@ -171,9 +203,12 @@ while getopts "d:l:c:u:t:" opt; do
     u)
       FLAGS+=("-u" "${OPTARG}")
       ;;
+    T)
+      TRANSPORT=${OPTARG}
+      ;;
     :)
       echo "USAGE: run.sh [-d logdir] [-l packet_loss] [-c packet_corruption]" \
-           "[-u packet_duplicate] [-t timeout]"
+           "[-u packet_duplicate] [-t timeout] [-T tcp[,rdma]]"
       exit 1
       ;;
     ?)
@@ -183,9 +218,21 @@ while getopts "d:l:c:u:t:" opt; do
   esac
 done
 
+# Validate transport tokens
+IFS=',' read -ra transports <<< "$TRANSPORT"
+for t in "${transports[@]}"; do
+    if [ "$t" != "tcp" ] && [ "$t" != "rdma" ]; then
+        echo "run.sh: unknown transport '$t' (expected tcp or rdma)"
+        exit 1
+    fi
+done
+
+FLAGS+=("--transport" "${TRANSPORT}")
+
 check_env
 check_conf
 check_gcov_conf
+check_rdma_conf
 
 TRACE_CMD=()
 if [[ -n "$LOG_DIR" ]]; then
-- 
2.25.1


