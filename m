Return-Path: <linux-rdma+bounces-20645-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAQIAy1RBWo+UwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20645-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 06:35:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5FF53DB99
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 06:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A0E63077CBA
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 04:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0C23AE71E;
	Thu, 14 May 2026 04:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBQCMTsI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5CA3AD52B;
	Thu, 14 May 2026 04:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778733218; cv=none; b=E6gHNe8V2N24TnjzOt9ppD2gHtVgUclL6d9HTRYhf3kRLEgXrrJeY5EgHKKJYV2QH7Kpvk/PMoN0HmN/WmIABauJ/f7VMMQNnsN/QyEO/sXQmj4LN8BIijCm0dRIeT+mbVyXV07nvPRX7agT2l4aWkQNLGHMeO3p3bXENFM6qVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778733218; c=relaxed/simple;
	bh=ri6T+gST1A+iRFKnaMn+jUGtkPEX6ZLbdJ2CFcslTDA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ukxzygk/mDM7wcaqLJzQJtj0j/rdR2FixuzKBI4hFjAK7naDsVh/Oybfc7tplFF0E00VL0rr09RJn7XMgthFpy02/AV4ztxP8Xo/Eu9LH3Jc2pV1Tm+iWCfsgYo3jYQY4Ec17EyVsEs+ca/OATJvYUBq86YKgXNlV9IJJh84Cm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBQCMTsI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BFADC2BCC7;
	Thu, 14 May 2026 04:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778733218;
	bh=ri6T+gST1A+iRFKnaMn+jUGtkPEX6ZLbdJ2CFcslTDA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EBQCMTsIKdlZi/h7hMjBKztUivHc8b40aS61/jiJ+bGYqYKAiuVBMX+eIdx+OyIuY
	 /7nHePoVyaQG99kAsfankANF9rdAmEUVgGW96NXCSe6DRaWFuCHIdrdultbxjnoI3h
	 MmnO3+bd5SMNAXKAbbcDwHgQxYu6J6FeK0mcUB16YvMphPrQ/gABgL/3V8gWWv5brv
	 OTsq2m02Vbg7VEX3Xkn2n6FjG7a/AV6ifIHw0H17hnPKUrLE0HKWchFrA4TfS2CoBw
	 XHK+nEFXCnB3ZB2ZjaRhQ7ekgI+HcSH+Yek1r+9Eo+IhVbfVa7tPt0srM5p2uw4OhR
	 8u8in48+21I0Q==
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
Subject: [PATCH net-next v2 9/9] selftests: rds: Add ROCE support to run.sh
Date: Wed, 13 May 2026 21:33:30 -0700
Message-Id: <20260514043330.1718969-10-achender@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260514043330.1718969-1-achender@kernel.org>
References: <20260514043330.1718969-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7D5FF53DB99
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-20645-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,config.sh:url,run.sh:url]
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
 tools/testing/selftests/net/rds/run.sh    | 53 ++++++++++++++++++++++-
 2 files changed, 64 insertions(+), 4 deletions(-)

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
index 424fd57401d8..a9a74e80cf46 100755
--- a/tools/testing/selftests/net/rds/run.sh
+++ b/tools/testing/selftests/net/rds/run.sh
@@ -101,6 +101,16 @@ check_conf_enabled() {
 		exit 4
 	fi
 }
+
+check_rdma_conf_enabled() {
+	if ! grep -x "$1=y" "$kconfig" > /dev/null 2>&1; then
+		echo "selftests: [SKIP] rdma transport requires $1 enabled"
+		echo "To enable, run " \
+		     "tools/testing/selftests/net/rds/config.sh -r and rebuild"
+		exit 4
+	fi
+}
+
 check_conf_disabled() {
 	if grep -x "$1=y" "$kconfig" > /dev/null 2>&1; then
 		echo "selftests: [SKIP] This test requires $1 disabled"
@@ -117,6 +127,28 @@ check_conf() {
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
+		echo "selftests: [SKIP] rdma transport requires the 'rdma'" \
+		      " tool (iproute2)"
+		exit 4
+	fi
+}
+
 check_env()
 {
 	if ! test -d "$obj_dir"; then
@@ -153,8 +185,10 @@ check_env()
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
@@ -171,9 +205,12 @@ while getopts "d:l:c:u:t:" opt; do
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
@@ -183,9 +220,21 @@ while getopts "d:l:c:u:t:" opt; do
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


