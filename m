Return-Path: <linux-rdma+bounces-17689-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHTgJjIQrWmBxwEAu9opvQ
	(envelope-from <linux-rdma+bounces-17689-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 06:59:14 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC2722E9FC
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 06:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78A6C302DE75
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 05:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7C533260E;
	Sun,  8 Mar 2026 05:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bR6nKexV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A18331218;
	Sun,  8 Mar 2026 05:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772949518; cv=none; b=q9qp598rPhUA4MlOgfZBDWQXwjC/ss4+pYEbzZL5FVd/KlKWUla0xBOY7ovDukYPJDAYK+3TOUd0WoqkwH6nNszFEMBpS3TjqU2dplgAu27/Q3D3CAwsU+LBvIi6rAPFi+OkMpJ2EbAUeIO+ne4CiDSXWuaYVcuXQfaGanzRczQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772949518; c=relaxed/simple;
	bh=WPGUC4WMxq1iI6jn2yU9uwE8K/wukrU/Xz0S8+5d5Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ay36EPKXp+VXxKX1NuMrNvl2lFqGSudkfcMb69HLvzCqGsPIlQYYcLgovwhVHQudduHS3sg0avq1cp95SHXjI1is//t3muOtgEuu4KT9QhV48FCjTUE3MM9X/3tW7ZQt6hs0JSNFeOAsFqnYIPhHBnOTJV31rHLB3QQwrJam3vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bR6nKexV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0711C2BC86;
	Sun,  8 Mar 2026 05:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772949518;
	bh=WPGUC4WMxq1iI6jn2yU9uwE8K/wukrU/Xz0S8+5d5Zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bR6nKexVj3mC6mPeOIGpgNggBOfzO7SaxD5Brs2d58YOLJQDQeurHcMfcab34MDLC
	 UjYtkyB89NTrsFce/lZd7VNOd0keuXV+ZHvG7Im9Cm9v0NPB6IVAef8vkPYiLqt2KA
	 p/kgmas3BoPbmeWL5wsxer7hRb1ninIHu18oEqNB7j1Kjw8MYObjraGa8nNWvZLkq8
	 sncOUR8Gfk+mxUcfQrUO17KAtMRViP/A7Wx6ChdQ8NjeEm5MJiGaUMgBE/q4CDLD+i
	 4oHChPJJLgMeNq+au/3FJSxmQrCqmTgjRoS/WmCvSB32zxKWqynmWgHTDGmGDlu+Rn
	 +6NUkxjQpIS2g==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	rds-devel@oss.oracle.com,
	kuba@kernel.org,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	allison.henderson@oracle.com
Subject: [PATCH net-next v1 2/3] selftests: rds: Add ksft timeout
Date: Sat,  7 Mar 2026 22:58:34 -0700
Message-ID: <20260308055835.1338257-3-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260308055835.1338257-1-achender@kernel.org>
References: <20260308055835.1338257-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1AC2722E9FC
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
	TAGGED_FROM(0.00)[bounces-17689-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.981];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[run.sh:url,test.py:url]
X-Rspamd-Action: no action

rds/run.sh sets a timer of 400s when calling test.py.  However when
tests are run through ksft, a default 45s timer is applied.  Fix this
by adding a ksft timeout in tools/testing/selftests/net/rds/settings

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/Makefile | 1 +
 tools/testing/selftests/net/rds/run.sh   | 7 +++++--
 tools/testing/selftests/net/rds/settings | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/rds/Makefile b/tools/testing/selftests/net/rds/Makefile
index 762845cc973c..8f9d81a18a1b 100644
--- a/tools/testing/selftests/net/rds/Makefile
+++ b/tools/testing/selftests/net/rds/Makefile
@@ -8,6 +8,7 @@ TEST_PROGS := run.sh
 TEST_FILES := \
 	include.sh \
 	test.py \
+	settings \
 # end of TEST_FILES
 
 EXTRA_CLEAN := \
diff --git a/tools/testing/selftests/net/rds/run.sh b/tools/testing/selftests/net/rds/run.sh
index 8aee244f582a..897d17d1b8db 100755
--- a/tools/testing/selftests/net/rds/run.sh
+++ b/tools/testing/selftests/net/rds/run.sh
@@ -19,6 +19,9 @@ if test -f "$build_include"; then
 	build_dir="$mk_build_dir"
 fi
 
+# Source settings for timeout value (also used by ksft runner)
+source "$current_dir"/settings
+
 # This test requires kernel source and the *.gcda data therein
 # Locate the top level of the kernel source, and the net/rds
 # subfolder with the appropriate *.gcno object files
@@ -194,8 +197,8 @@ set +e
 echo running RDS tests...
 echo Traces will be logged to "$TRACE_FILE"
 rm -f "$TRACE_FILE"
-strace -T -tt -o "$TRACE_FILE" python3 "$(dirname "$0")/test.py" --timeout 400 -d "$LOG_DIR" \
-       -l "$PLOSS" -c "$PCORRUPT" -u "$PDUP"
+strace -T -tt -o "$TRACE_FILE" python3 "$(dirname "$0")/test.py" \
+	--timeout "$timeout" -d "$LOG_DIR" -l "$PLOSS" -c "$PCORRUPT" -u "$PDUP"
 
 test_rc=$?
 dmesg > "${LOG_DIR}/dmesg.out"
diff --git a/tools/testing/selftests/net/rds/settings b/tools/testing/selftests/net/rds/settings
new file mode 100644
index 000000000000..d2009a64589c
--- /dev/null
+++ b/tools/testing/selftests/net/rds/settings
@@ -0,0 +1 @@
+timeout=400
-- 
2.43.0


