Return-Path: <linux-rdma+bounces-18429-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QF6xAAPLvGnT2wIAu9opvQ
	(envelope-from <linux-rdma+bounces-18429-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 05:20:19 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8905E2D5C1C
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 05:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E1FA30E6B27
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 04:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C0B2EC0A6;
	Fri, 20 Mar 2026 04:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlAVjXEz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59412EACF2;
	Fri, 20 Mar 2026 04:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773980318; cv=none; b=m0jBt1ZS1/iefJktGRS3Ykdu4XdPbIylT5y0JWxZFQjo/wWRECLAUT12IMY10r5F1eSAQOeeqif6z5k4rs9EeVXVnzYZkbafqiTqCGtL/D9+Zho7+WM39OQbAYETFO2kVtbgwPV/Jd7U5N3Tr+cVKDggzFyv29+QAsjuINsS5U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773980318; c=relaxed/simple;
	bh=8Viogy5I6XdIOcsQgFjSY4jrz9LKSIZECDVq9Eqxz70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6Aq5euG6h1W9Xtg13eara2nPkKpoL75iI1KGiX/oh8ltLteXuaeM/3SKDUNsPMAnK8NqtroBt0bzTcFXBA7gLHip9jdvpR3MNg46SNoKfLk7zxvEy47qcmMc4cr2wPU3iPrHyqnxg+y93VfoVhgcM2ffIwJbBn7FgaXU/sZAW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlAVjXEz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F467C19425;
	Fri, 20 Mar 2026 04:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773980317;
	bh=8Viogy5I6XdIOcsQgFjSY4jrz9LKSIZECDVq9Eqxz70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jlAVjXEzbhXH2HVFPFh83+mTlx02lBdtTJlQOlFLCfz38o7jz4YHxZFQZB+Xg/xo1
	 zSGLKGxHORXuVVyI544qK9jBHJ9YtK20FSFKjHV+ueWWorKvVFAzbyaLFBeL4u1vFw
	 1/henN0oAYusxJOa/gplRwewxSehTzwHtUvqlalX4DiVvQW523mdtqsp5beVpF5zDJ
	 WLL1MHheNYKTRkuYdgYRnDSEvF0k1lGYJcw6cSH1tYxzmH1KEbp0MOtyUYY4LHWBam
	 hftN+fDOhjVO7S3N4a/eAJ9Fvs3QbNCs7C8iD+IBFxDju5tzWgm4otSgwRqyy8o2Pk
	 A4D/tsZv+uCvg==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	rds-devel@oss.oracle.com,
	kuba@kernel.org,
	shuah@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	allison.henderson@oracle.com
Subject: [PATCH net-next v3 2/2] selftests: rds: Add -c config option to rds/config.sh
Date: Thu, 19 Mar 2026 21:18:34 -0700
Message-ID: <20260320041834.2761069-3-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320041834.2761069-1-achender@kernel.org>
References: <20260320041834.2761069-1-achender@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-18429-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.984];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[config.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8905E2D5C1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch adds a new -c flag to config.sh that enables callers
to specify the file path of the config they would like to update.
If no config is specified, the default will be the .config of the
current directory.

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/README.txt |  5 ++-
 tools/testing/selftests/net/rds/config.sh  | 37 +++++++++++++---------
 2 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/net/rds/README.txt b/tools/testing/selftests/net/rds/README.txt
index cbde2951ab13..c6fe003d503b 100644
--- a/tools/testing/selftests/net/rds/README.txt
+++ b/tools/testing/selftests/net/rds/README.txt
@@ -31,8 +31,11 @@ EXAMPLE:
     # Alternatly create a gcov disabled .config
     tools/testing/selftests/net/rds/config.sh
 
+    # Config paths may also be specified with the -c flag
+    tools/testing/selftests/net/rds/config.sh -c .config.local
+
     # build the kernel
-    vng --build  --config tools/testing/selftests/net/config
+    vng --build --config .config
 
     # launch the tests in a VM
     vng -v --rwdir ./ --run . --user root --cpus 4 -- \
diff --git a/tools/testing/selftests/net/rds/config.sh b/tools/testing/selftests/net/rds/config.sh
index 791c8dbe1095..29a79314dd60 100755
--- a/tools/testing/selftests/net/rds/config.sh
+++ b/tools/testing/selftests/net/rds/config.sh
@@ -6,15 +6,20 @@ set -u
 set -x
 
 unset KBUILD_OUTPUT
+CONF_FILE=""
+FLAGS=()
 
 GENERATE_GCOV_REPORT=0
-while getopts "g" opt; do
+while getopts "gc:" opt; do
   case ${opt} in
     g)
       GENERATE_GCOV_REPORT=1
       ;;
+    c)
+      CONF_FILE=$OPTARG
+      ;;
     :)
-      echo "USAGE: config.sh [-g]"
+      echo "USAGE: config.sh [-g] [-c config]"
       exit 1
       ;;
     ?)
@@ -24,30 +29,32 @@ while getopts "g" opt; do
   esac
 done
 
-CONF_FILE="tools/testing/selftests/net/config"
+if [[ "$CONF_FILE" != "" ]]; then
+	FLAGS=(--file "$CONF_FILE")
+fi
 
 # no modules
-scripts/config --file "$CONF_FILE" --disable CONFIG_MODULES
+scripts/config "${FLAGS[@]}" --disable CONFIG_MODULES
 
 # enable RDS
-scripts/config --file "$CONF_FILE" --enable CONFIG_RDS
-scripts/config --file "$CONF_FILE" --enable CONFIG_RDS_TCP
+scripts/config "${FLAGS[@]}" --enable CONFIG_RDS
+scripts/config "${FLAGS[@]}" --enable CONFIG_RDS_TCP
 
 if [ "$GENERATE_GCOV_REPORT" -eq 1 ]; then
 	# instrument RDS and only RDS
-	scripts/config --file "$CONF_FILE" --enable CONFIG_GCOV_KERNEL
-	scripts/config --file "$CONF_FILE" --disable GCOV_PROFILE_ALL
-	scripts/config --file "$CONF_FILE" --enable GCOV_PROFILE_RDS
+	scripts/config "${FLAGS[@]}" --enable CONFIG_GCOV_KERNEL
+	scripts/config "${FLAGS[@]}" --disable GCOV_PROFILE_ALL
+	scripts/config "${FLAGS[@]}" --enable GCOV_PROFILE_RDS
 else
-	scripts/config --file "$CONF_FILE" --disable CONFIG_GCOV_KERNEL
-	scripts/config --file "$CONF_FILE" --disable GCOV_PROFILE_ALL
-	scripts/config --file "$CONF_FILE" --disable GCOV_PROFILE_RDS
+	scripts/config "${FLAGS[@]}" --disable CONFIG_GCOV_KERNEL
+	scripts/config "${FLAGS[@]}" --disable GCOV_PROFILE_ALL
+	scripts/config "${FLAGS[@]}" --disable GCOV_PROFILE_RDS
 fi
 
 # need network namespaces to run tests with veth network interfaces
-scripts/config --file "$CONF_FILE" --enable CONFIG_NET_NS
-scripts/config --file "$CONF_FILE" --enable CONFIG_VETH
+scripts/config "${FLAGS[@]}" --enable CONFIG_NET_NS
+scripts/config "${FLAGS[@]}" --enable CONFIG_VETH
 
 # simulate packet loss
-scripts/config --file "$CONF_FILE" --enable CONFIG_NET_SCH_NETEM
+scripts/config "${FLAGS[@]}" --enable CONFIG_NET_SCH_NETEM
 
-- 
2.43.0


