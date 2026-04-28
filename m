Return-Path: <linux-rdma+bounces-19696-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eO+5FVE08WkgegEAu9opvQ
	(envelope-from <linux-rdma+bounces-19696-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:27:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3782648C936
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF44B301860B
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 22:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989153806B0;
	Tue, 28 Apr 2026 22:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuCIPKhy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5882D37FF78;
	Tue, 28 Apr 2026 22:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777415241; cv=none; b=LU/AJHdIQG6idreMTLK20z/wIYvovfGVGi1WQpHAlGr2Z5UMaBozcxd8aBiNURoODjdA+ZdZUWunFu68/Ta8Kja0lyRZpZzhwCKZf0EoU37p9VRCqN7zmROr5u7HfmgOT7EFsUrwiJlEbN03Z8Tv2jbx8GtddVnC8Lf95QZVDnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777415241; c=relaxed/simple;
	bh=2utQJxdXMpqbfn1vYXbFKp/QQs9TbRxerBVU9wZIyec=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DPFcgPdZ8YnXEb7yPE35GZS5kOgHWK/7RCF0ivNq3r4SFZsVPt7wF6uLFVgD+qpwDZDuif2wtvD5RRADCc0wHUkcnPRjF8uB+SNkWB5bLb7Sm8kPiaTOPo82EQcOo+xdp1AloAZfMgjZJ0A+fgIJljpYymUn90Wsv3PKSNCkiVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuCIPKhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC96C2BCB3;
	Tue, 28 Apr 2026 22:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777415241;
	bh=2utQJxdXMpqbfn1vYXbFKp/QQs9TbRxerBVU9wZIyec=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=iuCIPKhypZLfDoMUhn+QueT21rKnI1zocUe6/FahUV5um86buLkxsIUD6Ha5iHdVV
	 Nz9+6IisDOWbTXWhEzfBBAZGux7+tKi/ZNZKoCHkzVC1kt40q9RFS18e3GXC3gYMOq
	 0jevKPXeqyyFtGlba4czkduvT1yP0J84BzDIuJQGAmJwzTTwpedWVEneSIq2mEGQMc
	 5ZelibmKJkd5noZ4KHOZbv+4Qnga3VCKFTsOdnSV1b6CEp8rPM/dBcovtcXHXnKjy2
	 PL7jhoxQrAPKia7/tqLTctClde5rWaWBXlfWeCqa3zz+IGIELpcDlEF0iEW+2y+WSY
	 pU3d22Jm3+B9A==
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
Subject: [PATCH net-next v2 4/7] selftests: rds: Add timeout flag to run.sh
Date: Tue, 28 Apr 2026 15:27:13 -0700
Message-Id: <20260428222716.2960871-5-achender@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260428222716.2960871-1-achender@kernel.org>
References: <20260428222716.2960871-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3782648C936
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19696-lists,linux-rdma=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Add a -t flag to run.sh to optionally override the default
timeout.  The --timeout flag is already supported in test.py,
so just add the shorthand -t flag

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/run.sh  | 11 ++++++++---
 tools/testing/selftests/net/rds/test.py |  2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

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


