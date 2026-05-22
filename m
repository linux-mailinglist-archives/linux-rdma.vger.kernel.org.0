Return-Path: <linux-rdma+bounces-21165-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eVM7MJ7QEGrHeAYAu9opvQ
	(envelope-from <linux-rdma+bounces-21165-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 23:54:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 384965BAC5A
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 23:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC4013012BCB
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 21:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F8238F630;
	Fri, 22 May 2026 21:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yka62m9o"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFB8386C2C;
	Fri, 22 May 2026 21:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779486873; cv=none; b=snu0ImUhpnfBnzXPflhzStSqKW17I3+v0YZsac/mRFwnSXxPWUn3Y6ei5L7sHLsoZvTzIkYCgyt2CDkbV+FLpKWjiZIX/r68AfuvQ2ijxm70Z3eY4PLLGSS0TneRFRbq8c+JoxffymMDWfgjVjousZyLfJkhvf/v4+RPvl/UAjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779486873; c=relaxed/simple;
	bh=j7nRuqnXcZJNRjq7kC8k0OlSETVxaXxrRahg/JjnWIw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=foUPwj6M3XNFmgcCSfVpA6cr6a/yHpDzrizHz9zWhG+wwnuEzGY1ujRbFJxws/eFCgP2uZBp+qbMmu9AJeMTeewMG8aEOdWQC2fMmK/jbHxV8qkdF7jyi0XPNzCM034gETWS4Vl5cdh18gnkqr/3MXMjxcpvkvlv3t5KbVzqIFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yka62m9o; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8C31F00A3D;
	Fri, 22 May 2026 21:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779486872;
	bh=tOsV39lQ/2uWWlaoDOkZ8p6RLrN1VkZSWZDN3gudKro=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=Yka62m9oqbkS0lq31dMYl/8cuMC60zWQCpT8w+0imDyiCgPMpbiJRnmkn6sjv4HNT
	 tpug6QHVMVZqhs3665zsg/je49z2StPlh/We0UT+Cza21E8q429drA126eRBrqYVoQ
	 YTT1t6rkksaGIM++po/dOlhF6k8N7XytnRdcUwSMfzXDQpmwYJLoIss+zI1fWDMNhP
	 Gl0HzUufupgTJUk+QTr/89ArBw3XuZ/XDWXzPV+pISj8f62zanrpc40AfsYEofPYoW
	 e2uaTTS5Zwf65r0lFYtB1L16V5wjw0tQdLjIw89XJT356AhpABYondTu+8N7fVDGj+
	 3l8WxNXIV7qqw==
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
Subject: [PATCH net-next v1 1/3] selftests: rds: add per-transport run wrappers
Date: Fri, 22 May 2026 14:54:28 -0700
Message-Id: <20260522215430.3748226-2-achender@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260522215430.3748226-1-achender@kernel.org>
References: <20260522215430.3748226-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21165-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[rds_rdma_run.sh:url,run.sh:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 384965BAC5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch renames run.sh to rds_run.sh, and then adds two wrapper
scripts, rds_rdma_run.sh and rds_tcp_run.sh which run rds_run.sh with
the corresponding transport option, rdma or tcp respectively.  These
wrapper scripts are added to TEST_PROGS in place of run.sh so that they
run and report as a separate test results on the netdev CI dashboard.

Listing the wrappers in TEST_PROGS also gives the framework a
self-describing name for each test. The underlying rds_run.sh remains
directly usable with the full set of options.

Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/Makefile            |  6 +++++-
 tools/testing/selftests/net/rds/README.txt          | 13 +++++++++----
 tools/testing/selftests/net/rds/rds_rdma_run.sh     | 11 +++++++++++
 .../selftests/net/rds/{run.sh => rds_run.sh}        |  4 ++--
 tools/testing/selftests/net/rds/rds_tcp_run.sh      | 11 +++++++++++
 5 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/rds/Makefile b/tools/testing/selftests/net/rds/Makefile
index fe363be8e3586..b176e637fc55b 100644
--- a/tools/testing/selftests/net/rds/Makefile
+++ b/tools/testing/selftests/net/rds/Makefile
@@ -3,9 +3,13 @@
 all:
 	@echo mk_build_dir="$(shell pwd)" > include.sh
 
-TEST_PROGS := run.sh
+TEST_PROGS := \
+	rds_tcp_run.sh \
+	rds_rdma_run.sh \
+# end of TEST_PROGS
 
 TEST_FILES := \
+	rds_run.sh \
 	include.sh \
 	settings \
 	test.py \
diff --git a/tools/testing/selftests/net/rds/README.txt b/tools/testing/selftests/net/rds/README.txt
index bac6f15a80d52..2296568c39444 100644
--- a/tools/testing/selftests/net/rds/README.txt
+++ b/tools/testing/selftests/net/rds/README.txt
@@ -13,10 +13,15 @@ with the necessary gcov options; pass -r to also enable the kernel
 configs required for the RDMA transport.  The kernel may optionally be
 configured to omit the coverage report as well.
 
+The test framework runs the rds_tcp_run.sh and rds_rdma_run.sh wrappers,
+which invoke rds_run.sh with the matching transport so that the tcp and
+rdma results are reported independently.  rds_run.sh may also be run
+directly with the options below.
+
 USAGE:
-	run.sh [-d logdir] [-l packet_loss] [-c packet_corruption]
-	       [-u packet_duplicate] [-t timeout]
-	       [-T tcp|rdma|tcp,rdma]
+	rds_run.sh [-d logdir] [-l packet_loss] [-c packet_corruption]
+	           [-u packet_duplicate] [-t timeout]
+	           [-T tcp|rdma|tcp,rdma]
 
 OPTIONS:
 	-d	Log directory.  If set, logs will be stored in the
@@ -73,5 +78,5 @@ EXAMPLE:
         "export PYTHONPATH=tools/testing/selftests/net/; \
          export SUDO_USER=example_user; \
          export RDS_LOG_DIR=tools/testing/selftests/net/rds/rds_logs; \
-         tools/testing/selftests/net/rds/run.sh -T tcp,rdma"
+         tools/testing/selftests/net/rds/rds_run.sh -T tcp,rdma"
 
diff --git a/tools/testing/selftests/net/rds/rds_rdma_run.sh b/tools/testing/selftests/net/rds/rds_rdma_run.sh
new file mode 100755
index 0000000000000..eddd389431573
--- /dev/null
+++ b/tools/testing/selftests/net/rds/rds_rdma_run.sh
@@ -0,0 +1,11 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Runs the RDS selftest over the RDMA (RoCE/RXE) transport.
+#
+# This is a wrapper script for rds_run.sh to run and report results when using
+# the -T rdma option
+#
+# Exits with the kselftest SKIP code if rds RDMA prerequisites are not met
+
+exec "$(dirname "$0")/rds_run.sh" -T rdma "$@"
diff --git a/tools/testing/selftests/net/rds/run.sh b/tools/testing/selftests/net/rds/rds_run.sh
similarity index 98%
rename from tools/testing/selftests/net/rds/run.sh
rename to tools/testing/selftests/net/rds/rds_run.sh
index 07af2f927a2a7..ef16039be1ae5 100755
--- a/tools/testing/selftests/net/rds/run.sh
+++ b/tools/testing/selftests/net/rds/rds_run.sh
@@ -209,7 +209,7 @@ while getopts "d:l:c:u:t:T:" opt; do
       TRANSPORT=${OPTARG}
       ;;
     :)
-      echo "USAGE: run.sh [-d logdir] [-l packet_loss] [-c packet_corruption]" \
+      echo "USAGE: rds_run.sh [-d logdir] [-l packet_loss] [-c packet_corruption]" \
            "[-u packet_duplicate] [-t timeout] [-T tcp|rdma|tcp,rdma]"
       exit 1
       ;;
@@ -224,7 +224,7 @@ done
 IFS=',' read -ra transports <<< "$TRANSPORT"
 for t in "${transports[@]}"; do
     if [ "$t" != "tcp" ] && [ "$t" != "rdma" ]; then
-        echo "run.sh: unknown transport '$t' (expected tcp or rdma)"
+        echo "rds_run.sh: unknown transport '$t' (expected tcp or rdma)"
         exit 1
     fi
 done
diff --git a/tools/testing/selftests/net/rds/rds_tcp_run.sh b/tools/testing/selftests/net/rds/rds_tcp_run.sh
new file mode 100755
index 0000000000000..fad4d047aac61
--- /dev/null
+++ b/tools/testing/selftests/net/rds/rds_tcp_run.sh
@@ -0,0 +1,11 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Runs the RDS selftest over the TCP transport.
+#
+# This is a wrapper script for rds_run.sh to run and report results when using
+# the -T tcp option
+#
+# Exits with the kselftest SKIP code if rds TCP prerequisites are not met
+
+exec "$(dirname "$0")/rds_run.sh" -T tcp "$@"
-- 
2.25.1


