Return-Path: <linux-rdma+bounces-21611-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHPNKDRlHmrCiwkAu9opvQ
	(envelope-from <linux-rdma+bounces-21611-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 07:08:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9D6628615
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 07:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C09EC304860E
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 05:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E0F2EFD9B;
	Tue,  2 Jun 2026 05:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjxGIpXz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBB52C0268;
	Tue,  2 Jun 2026 05:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780376820; cv=none; b=Em0Fwd2Gglw5+NbkHiMKBlLA/3Zjk3tCQ0A9dp2v2kev5cWd5lehh8UamAco+vy2EF+Co5YYI0j6ZO+tqIEfc9KJDyuVWNqQtqh4+hhl2OOeoD3V4a/IUIb/9afI5O1/PqqLzewCHrI66rth708GEWVtvppEgAYS5jJyW5qHIn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780376820; c=relaxed/simple;
	bh=Ng/YRI9qTJpDyyWSdDS7GUPk66GrEWZB1pm4L9L8+B0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LqVzwMrVg14lFKI2GYYEIZXiLi1tTkRfEMsiFxjfmwnXTwreHnN7uVgvDq8ekBsF3zcKQK/a7kyOVKNQGZpLBmAqh6c7XLMrB1oNA2OBB+02FsyGYlM4i2zaDWL6C1hVFVLUVZtLJRdXRdbQS/i2a1znFphUdyahxSe5esaN/EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjxGIpXz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A531F0089C;
	Tue,  2 Jun 2026 05:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780376819;
	bh=sMsJwU1eYKEyERjMRj/FYdmtrB8q93P68t9Juzw4/iI=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=AjxGIpXzM0q4MkzEjIVBIeeyZnpAC3vw3fgtf0zBqmjbFaWYr0Xch4mgzR704o4C5
	 F+RMLs41SQksCjO03j1sAJOWORp7qNOJM2s7t3dsrZQIKKV0H9diHm4lBmMz7D56xa
	 wq8fUIRqLYCajVrI93IJm+FicILkQ5bJKwEzkDkdb470iCjqHS4nG1znTjpJwCNEO4
	 FPwGhVcofB16yxosK96UaxQlZ+W5DFPV3x8qyDgTeg1ISlmUG3hIZteaXEhOEGgJ9O
	 dopblRT0NdklgYssRxB9r35r/DPPaCPCridYV/ur2oUEB3+HHPrHyF4nU/G8Q6wf/4
	 opc4CB9+Fcy7w==
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
Subject: [PATCH net-next v3 1/4] selftests: rds: Rename run.sh to rds_run.sh
Date: Mon,  1 Jun 2026 22:06:54 -0700
Message-Id: <20260602050657.26389-2-achender@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260602050657.26389-1-achender@kernel.org>
References: <20260602050657.26389-1-achender@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21611-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[run.sh:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,include.sh:url,rds_run.sh:url]
X-Rspamd-Queue-Id: 1C9D6628615
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch renames run.sh to rds_run.sh. This gives the test a
self-describing name that appears in the netdev CI dashboard.

Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/Makefile               | 2 +-
 tools/testing/selftests/net/rds/README.txt             | 8 ++++----
 tools/testing/selftests/net/rds/{run.sh => rds_run.sh} | 7 ++++---
 3 files changed, 9 insertions(+), 8 deletions(-)
 rename tools/testing/selftests/net/rds/{run.sh => rds_run.sh} (96%)

diff --git a/tools/testing/selftests/net/rds/Makefile b/tools/testing/selftests/net/rds/Makefile
index fe363be8e3586..ec10ae24e4cf1 100644
--- a/tools/testing/selftests/net/rds/Makefile
+++ b/tools/testing/selftests/net/rds/Makefile
@@ -3,7 +3,7 @@
 all:
 	@echo mk_build_dir="$(shell pwd)" > include.sh
 
-TEST_PROGS := run.sh
+TEST_PROGS := rds_run.sh
 
 TEST_FILES := \
 	include.sh \
diff --git a/tools/testing/selftests/net/rds/README.txt b/tools/testing/selftests/net/rds/README.txt
index bac6f15a80d52..8aa41148b1b5c 100644
--- a/tools/testing/selftests/net/rds/README.txt
+++ b/tools/testing/selftests/net/rds/README.txt
@@ -14,9 +14,9 @@ configs required for the RDMA transport.  The kernel may optionally be
 configured to omit the coverage report as well.
 
 USAGE:
-	run.sh [-d logdir] [-l packet_loss] [-c packet_corruption]
-	       [-u packet_duplicate] [-t timeout]
-	       [-T tcp|rdma|tcp,rdma]
+	rds_run.sh [-d logdir] [-l packet_loss] [-c packet_corruption]
+	           [-u packet_duplicate] [-t timeout]
+	           [-T tcp|rdma|tcp,rdma]
 
 OPTIONS:
 	-d	Log directory.  If set, logs will be stored in the
@@ -73,5 +73,5 @@ EXAMPLE:
         "export PYTHONPATH=tools/testing/selftests/net/; \
          export SUDO_USER=example_user; \
          export RDS_LOG_DIR=tools/testing/selftests/net/rds/rds_logs; \
-         tools/testing/selftests/net/rds/run.sh -T tcp,rdma"
+         tools/testing/selftests/net/rds/rds_run.sh -T tcp,rdma"
 
diff --git a/tools/testing/selftests/net/rds/run.sh b/tools/testing/selftests/net/rds/rds_run.sh
similarity index 96%
rename from tools/testing/selftests/net/rds/run.sh
rename to tools/testing/selftests/net/rds/rds_run.sh
index 07af2f927a2a7..63080fef492b7 100755
--- a/tools/testing/selftests/net/rds/run.sh
+++ b/tools/testing/selftests/net/rds/rds_run.sh
@@ -209,8 +209,9 @@ while getopts "d:l:c:u:t:T:" opt; do
       TRANSPORT=${OPTARG}
       ;;
     :)
-      echo "USAGE: run.sh [-d logdir] [-l packet_loss] [-c packet_corruption]" \
-           "[-u packet_duplicate] [-t timeout] [-T tcp|rdma|tcp,rdma]"
+      echo "USAGE: rds_run.sh [-d logdir] [-l packet_loss]" \
+           "[-c packet_corruption] [-u packet_duplicate] [-t timeout]" \
+           "[-T tcp|rdma|tcp,rdma]"
       exit 1
       ;;
     ?)
@@ -224,7 +225,7 @@ done
 IFS=',' read -ra transports <<< "$TRANSPORT"
 for t in "${transports[@]}"; do
     if [ "$t" != "tcp" ] && [ "$t" != "rdma" ]; then
-        echo "run.sh: unknown transport '$t' (expected tcp or rdma)"
+        echo "rds_run.sh: unknown transport '$t' (expected tcp or rdma)"
         exit 1
     fi
 done

base-commit: 1a1f055318d82e64485a6ff8420e5f70b4267998
-- 
2.25.1


