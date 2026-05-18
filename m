Return-Path: <linux-rdma+bounces-20869-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKrJMQJrCmqN1AQAu9opvQ
	(envelope-from <linux-rdma+bounces-20869-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 03:27:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A475564CF7
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 03:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CAEC301CDA3
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 01:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AB6286405;
	Mon, 18 May 2026 01:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEkjKW9G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC87423505E;
	Mon, 18 May 2026 01:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779067492; cv=none; b=nYk5zHMmjXH9i9h9tNUv9HLYLL70he73Zh70JOKFoHQ569BiCCgv2lH3JK8GkQ4Rhn1AkY0hXOz01Mn4UbM8PCqmGlPzfuwa9zw65fJUpbf2UWBAcGBbSSla4eAX4F/zm/najsrJ436inPHy1/73Hy2feZPq1vwhW9XfyYQX7Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779067492; c=relaxed/simple;
	bh=z8cVcJiPvYJJnaTNGBSrxNoRWSTYxiMXM2DVRVh7az0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YPvjny/XfE5/RqgJM0XK7MylsFm1/8sB3GBcibB9vT38tSbt532McupQDcyvB40Ctjwtz0Db4LVXzW2Agyhaq2cZm69zokwtu880Dh0IHz+79BTUI14OB0QBP2Xgfv5xFwatTqTq1nL6dBgQHXsvamrsJU0HtcFs7BsnCNcOZMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEkjKW9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A10C2BCC9;
	Mon, 18 May 2026 01:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779067492;
	bh=z8cVcJiPvYJJnaTNGBSrxNoRWSTYxiMXM2DVRVh7az0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VEkjKW9GQLp2C6Jwu3iSbACic4krPZspa4JQtONb17ciXyFthyLDIQjWODWd0OCu6
	 kDvKeld4fNEyLQX25KoVVIhXV/1lQe5rVgef1Mtcyb55QAwwPbet2x54mUY1WlWKXQ
	 SEzUqK2yeHgZEXSoc/LAoTbxplPZWj5SZ2Yx677kIZfhcAETb+g8WV7BteKRUKJp6i
	 7pjKl8bOg+2XRvp6vQvKoMuMcve1EHciLVNa3Si5Sj/Vol96Wfniz53Wbv7Xxio7+9
	 /VmAbyYSCKQ7+ho+lEujFqbI4Cduva5m41AJpJ7A4C+T1g1p0Zhoi6EavYJrjmsGKo
	 BjHE+UO3i6cQg==
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
Subject: [PATCH net-next v3 11/11] selftests: rds: Add ROCE support to run.sh
Date: Sun, 17 May 2026 18:24:43 -0700
Message-Id: <20260518012443.2629206-12-achender@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260518012443.2629206-1-achender@kernel.org>
References: <20260518012443.2629206-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8A475564CF7
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
	TAGGED_FROM(0.00)[bounces-20869-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,run.sh:url,config.sh:url]
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
 tools/testing/selftests/net/rds/README.txt | 29 ++++++++----
 tools/testing/selftests/net/rds/config.sh  | 15 +++++-
 tools/testing/selftests/net/rds/run.sh     | 53 +++++++++++++++++++++-
 3 files changed, 84 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/net/rds/README.txt b/tools/testing/selftests/net/rds/README.txt
index 295dc82c0770f..bac6f15a80d52 100644
--- a/tools/testing/selftests/net/rds/README.txt
+++ b/tools/testing/selftests/net/rds/README.txt
@@ -1,18 +1,22 @@
 RDS self-tests
 ==============
 
-These scripts provide a coverage test for RDS-TCP by creating two
-network namespaces and running rds packets between them. A loopback
-network is provisioned with optional probability of packet loss or
-corruption. A workload of 50000 hashes, each 64 characters in size,
-are passed over an RDS socket on this test network. A passing test means
-the RDS-TCP stack was able to recover properly.  The provided config.sh
-can be used to compile the kernel with the necessary gcov options.  The
-kernel may optionally be configured to omit the coverage report as well.
+These scripts provide a coverage test for RDS-TCP and RDS-RDMA (over
+RoCE/RXE) by setting up two endpoints and running RDS packets between
+them. The TCP path creates two network namespaces; the RDMA path uses
+an RXE (soft RoCE) device backed by a veth pair.  A workload of 50000
+hashes, each 64 characters in size, is passed over an RDS socket on
+this test network with an optional probability of packet loss or
+corruption.  A passing test means the RDS stack was able to recover
+properly.  The provided config.sh can be used to compile the kernel
+with the necessary gcov options; pass -r to also enable the kernel
+configs required for the RDMA transport.  The kernel may optionally be
+configured to omit the coverage report as well.
 
 USAGE:
 	run.sh [-d logdir] [-l packet_loss] [-c packet_corruption]
 	       [-u packet_duplicate] [-t timeout]
+	       [-T tcp|rdma|tcp,rdma]
 
 OPTIONS:
 	-d	Log directory.  If set, logs will be stored in the
@@ -27,6 +31,10 @@ OPTIONS:
 
 	-t	Test timeout.  Defaults to tools/testing/selftests/net/rds/settings
 
+	-T	Comma-separated list of transports to test.  Accepts
+		"tcp", "rdma", or "tcp,rdma".  Defaults to "tcp".  Use
+		config.sh -r to enable required RDMA configs
+
 ENV VARIABLES:
 	RDS_LOG_DIR	Log directory.  If set, logs will be stored in
 			the given dir, or skipped if unset. Log dir
@@ -48,6 +56,9 @@ EXAMPLE:
     # Create a suitable gcov enabled .config
     tools/testing/selftests/net/rds/config.sh -g
 
+    # Optionally add RDMA configs (CONFIG_RDS_RDMA, CONFIG_RDMA_RXE)
+    tools/testing/selftests/net/rds/config.sh -r
+
     # Alternatly create a gcov disabled .config
     tools/testing/selftests/net/rds/config.sh
 
@@ -62,5 +73,5 @@ EXAMPLE:
         "export PYTHONPATH=tools/testing/selftests/net/; \
          export SUDO_USER=example_user; \
          export RDS_LOG_DIR=tools/testing/selftests/net/rds/rds_logs; \
-         tools/testing/selftests/net/rds/run.sh"
+         tools/testing/selftests/net/rds/run.sh -T tcp,rdma"
 
diff --git a/tools/testing/selftests/net/rds/config.sh b/tools/testing/selftests/net/rds/config.sh
index 29a79314dd60f..be0668359a070 100755
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
index 424fd57401d88..07af2f927a2a7 100755
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
+           "[-u packet_duplicate] [-t timeout] [-T tcp|rdma|tcp,rdma]"
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


