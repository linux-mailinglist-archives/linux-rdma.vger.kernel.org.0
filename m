Return-Path: <linux-rdma+bounces-19896-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOugLrYx+GlBrQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19896-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 07:42:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0BA4B89A3
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 07:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 48EAD30066AE
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 05:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5592D286D57;
	Mon,  4 May 2026 05:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfTBHwxL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FBE29994B;
	Mon,  4 May 2026 05:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777873308; cv=none; b=AVkjl08WZiSY4RO8CZPFlag9rK84ZAmcfb1LDVO9caGCXT9YIYmSwX4O9DaqIJFWBQ19Lc3oNFl5DoRi1W4pErHQpq4pszvaSIlxUGdjPzZlh/EuW52nt2IfFPo/ft4siExks1iZXfBwfrG7xKXltnXpCvnSG7+FP9ddrVdBAzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777873308; c=relaxed/simple;
	bh=rHk7J5Bd8xBXa22V2XXeTL+fsIlMMaCfKSCxLeNDQsI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qQlOzs9k4ca370Y5AupCMhPF+c/BeNO17UR/Ip2RuBvz9o7mHd9TQviczQ4jEDx1/BOF6862CMxSFjhtWMGcSprQ0bOZMNG840A6NERG0pmimXdpyXH9ZrWP4eGCQmko4dE/BcbNtvQb3/6XvhV0vpFna0ZWCNzajmqUDspw5II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfTBHwxL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DA8C2BCF6;
	Mon,  4 May 2026 05:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777873307;
	bh=rHk7J5Bd8xBXa22V2XXeTL+fsIlMMaCfKSCxLeNDQsI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZfTBHwxLpMy6DzFEVTuTkZ9+ZztJEJdORb85kahYGDQQj7iEyX9UIKiqZ5/kEsDJB
	 E1lMEiMM6skfxrYNRwSUIoBI6teMmL0n4BOMgkAAjWm7Y/Wmqy7F0fcN5wljWAVVdH
	 gnN5HZ5nunoYUjAJIttemK7AlhrJY4F1TTpNjJBEC/DaBCkRjgm6N7dcVYbSpsc51J
	 glQldDXEhbVYXyhO/7NVHfBa59Y9PU0jzTVRSdbOqYgASEzX9Qf0yPsIchRk7e98bV
	 +57KUuE5ox8ZH7sSe+zc4S69Pf+oHNHp8FWHOBvTwdpFvl62BVDguYtQr3DdV2A+fm
	 /pdhFNikMEqjw==
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
Subject: [PATCH net-next v3 04/10] selftests: rds: Add timeout flag to run.sh
Date: Sun,  3 May 2026 22:41:37 -0700
Message-Id: <20260504054143.4027538-5-achender@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260504054143.4027538-1-achender@kernel.org>
References: <20260504054143.4027538-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5A0BA4B89A3
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-19896-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,run.sh:url]

Add a -t flag to run.sh to optionally override the default
timeout.  The --timeout flag is already supported in test.py,
so just add the shorthand -t flag

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/README.txt |  4 +++-
 tools/testing/selftests/net/rds/run.sh     | 11 ++++++++---
 tools/testing/selftests/net/rds/test.py    |  2 +-
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/rds/README.txt b/tools/testing/selftests/net/rds/README.txt
index 8df6cc35dd10..be9c7e25694e 100644
--- a/tools/testing/selftests/net/rds/README.txt
+++ b/tools/testing/selftests/net/rds/README.txt
@@ -12,7 +12,7 @@ kernel may optionally be configured to omit the coverage report as well.
 
 USAGE:
 	run.sh [-d logdir] [-l packet_loss] [-c packet_corruption]
-	       [-u packet_duplicate]
+	       [-u packet_duplicate] [-t timeout]
 
 OPTIONS:
 	-d	Log directory.  Defaults to tools/testing/selftests/net/rds/rds_logs
@@ -23,6 +23,8 @@ OPTIONS:
 
 	-u	Simulates a percentage of packet duplication.
 
+	-t	Test timeout.  Defaults to tools/testing/selftests/net/rds/settings
+
 EXAMPLE:
 
     # Create a suitable gcov enabled .config
diff --git a/tools/testing/selftests/net/rds/run.sh b/tools/testing/selftests/net/rds/run.sh
index 73a9b986b0ef..bc2e53126aab 100755
--- a/tools/testing/selftests/net/rds/run.sh
+++ b/tools/testing/selftests/net/rds/run.sh
@@ -154,8 +154,9 @@ LOG_DIR="$current_dir"/rds_logs
 PLOSS=0
 PCORRUPT=0
 PDUP=0
+TIMEOUT=$timeout
 GENERATE_GCOV_REPORT=1
-while getopts "d:l:c:u:" opt; do
+while getopts "d:l:c:u:t:" opt; do
   case ${opt} in
     d)
       LOG_DIR=${OPTARG}
@@ -166,12 +167,15 @@ while getopts "d:l:c:u:" opt; do
     c)
       PCORRUPT=${OPTARG}
       ;;
+    t)
+      TIMEOUT=${OPTARG}
+      ;;
     u)
       PDUP=${OPTARG}
       ;;
     :)
       echo "USAGE: run.sh [-d logdir] [-l packet_loss] [-c packet_corruption]" \
-           "[-u packet_duplicate]"
+           "[-u packet_duplicate] [-t timeout]"
       exit 1
       ;;
     ?)
@@ -198,7 +202,8 @@ echo running RDS tests...
 echo Traces will be logged to "$TRACE_FILE"
 rm -f "$TRACE_FILE"
 strace -T -tt -o "$TRACE_FILE" python3 "$(dirname "$0")/test.py" \
-	--timeout "$timeout" -d "$LOG_DIR" -l "$PLOSS" -c "$PCORRUPT" -u "$PDUP"
+	-t "$TIMEOUT" -d "$LOG_DIR" -l "$PLOSS" -c "$PCORRUPT" \
+	-u "$PDUP"
 
 test_rc=$?
 dmesg > "${LOG_DIR}/dmesg.out"
diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
index 4b6ffbb3a81c..d48533505f0f 100755
--- a/tools/testing/selftests/net/rds/test.py
+++ b/tools/testing/selftests/net/rds/test.py
@@ -83,7 +83,7 @@ parser = argparse.ArgumentParser(description="init script args",
                   formatter_class=argparse.ArgumentDefaultsHelpFormatter)
 parser.add_argument("-d", "--logdir", action="store",
                     help="directory to store logs", default="/tmp")
-parser.add_argument('--timeout', help="timeout to terminate hung test",
+parser.add_argument('-t', '--timeout', help="timeout to terminate hung test",
                     type=int, default=0)
 parser.add_argument('-l', '--loss', help="Simulate tcp packet loss",
                     type=int, default=0)
-- 
2.25.1


