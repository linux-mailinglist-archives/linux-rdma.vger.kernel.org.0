Return-Path: <linux-rdma+bounces-20867-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gO7DJ+NqCmqN1AQAu9opvQ
	(envelope-from <linux-rdma+bounces-20867-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 03:26:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4D0564CCF
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 03:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1A263030D08
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 01:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B4E229B38;
	Mon, 18 May 2026 01:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qK+y+xwn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6407827874F;
	Mon, 18 May 2026 01:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779067491; cv=none; b=Y0p3+QBLro7Mqoxgop2vETCFtx7MvRSc8qcV3t/zNhD0LVPPLNw5rKwXdLqGptL3PtcIyD7tC9+7ZnHyAefLuj5B8fbBHsW75zkxfGDWJaitUJitrvBYRAHwkHgpOZvodeT5IlegxUbxa0uklamDbx5n501AkWpltSaxYJD3jY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779067491; c=relaxed/simple;
	bh=LgWsWxZXMn9mGg7AgnmKmeCEHeiVZuBEgETVwRGWG3g=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=diL8DDQzVELffuEUWPCTBgD01L44LAERBu4/Di6t/63m/yhpz3ZloH8r5rcyyY/N+qGwo88d6dHGIMt9dWXXlAd88fUfRZl4YIICyf24Xp037cpCjAKj3o2u/8dpYv6MFOrBg6te8SvfjFeGsuT7fGa/RaN8tlNh/lFV6z0QvuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qK+y+xwn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF312C2BCB3;
	Mon, 18 May 2026 01:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779067491;
	bh=LgWsWxZXMn9mGg7AgnmKmeCEHeiVZuBEgETVwRGWG3g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qK+y+xwntijJYMhNpcI71enm53kHpWvzP7U79XPX91COlQvFmiwaCQF7TkTT6ypEk
	 gsB9leV0z8HNRqJ/V/IB+2JRn4ahnCWgPcwPQ2OO16uz6Ayr5f/S21ZEXPGEO3Ne3h
	 A7c0bgjprmuJFPl/SbmxGR///Z3YuaUzhw4qaI+yx7lNQ7H8zt5xFNl6piIZB+Kfzx
	 9msws5pnlTFrxwtmq3q47+V/KgJnBTIquX0WsIG718/NYyaXfyrPppqKRbZA+RWk8b
	 wdNbGjXKp1eq7tgQ2U3A+3jHgjAxalsZhmHrNlg9xLGkilhpwoXAUHyE9kY+VVj0V5
	 c9elvmT10AqsA==
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
Subject: [PATCH net-next v3 09/11] selftests: rds: Register network teardown via atexit
Date: Sun, 17 May 2026 18:24:41 -0700
Message-Id: <20260518012443.2629206-10-achender@kernel.org>
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
X-Rspamd-Queue-Id: 2D4D0564CCF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-20867-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This patch adds a teardown_tcp() helper that removes net0/net1.
The cmd calls here use fail=False so they can be called from
completed or partially-setup states on error. Also call
teardown_tcp() at the top of setup_tcp() so a previous
interrupted run does not leave net0/net1 lingering and break a
subsequent ip netns add.  Register teardown_tcp() with atexit
before setup_tcp() is invoked.

Likewise, we can simpliy stop_pcaps() handling by registering it
with atexit instead of calling it from the signal handler.

atexit handlers run on any exit path - normal completion, raised
exception, and sys.exit() from the timeout signal handler.  This
guarantees cleanup are called without further wrapping the test
body in a try/finally blocks.

atexit LIFO ordering keeps stop_pcaps before teardown_tcp so
tcpdumps are killed cleanly before their namespaces go away.

This is a preparatory cleanup for the upcoming ROCE patch which
will also register a teardown_rdma() alongside teardown_tcp()

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/test.py | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
index 2188221ee7805..5b699bf87eb25 100755
--- a/tools/testing/selftests/net/rds/test.py
+++ b/tools/testing/selftests/net/rds/test.py
@@ -5,6 +5,7 @@ This module provides functional testing for the net/rds component.
 """
 
 import argparse
+import atexit
 import ctypes
 import errno
 import hashlib
@@ -19,7 +20,7 @@ import sys
 this_dir = os.path.dirname(os.path.realpath(__file__))
 sys.path.append(os.path.join(this_dir, "../"))
 # pylint: disable-next=wrong-import-position,import-error,no-name-in-module
-from lib.py.utils import ip # noqa: E402
+from lib.py.utils import ip, cmd # noqa: E402
 # pylint: disable-next=wrong-import-position,import-error,no-name-in-module
 from lib.py.ksft import ksft_pr # noqa: E402
 
@@ -247,7 +248,6 @@ def signal_handler(_sig, _frame):
     Test timed out signal handler
     """
     ksft_pr("Test timed out")
-    stop_pcaps()
     print("not ok 1 rds selftest")
     sys.exit(1)
 
@@ -256,6 +256,9 @@ def setup_tcp():
     Configure tcp network
     """
 
+    # clean up any leftovers from a previously interrupted run
+    teardown_tcp()
+
     ip(f"netns add {NET0}")
     ip(f"netns add {NET1}")
     ip("link add type veth")
@@ -300,6 +303,17 @@ def setup_tcp():
              corrupt {PACKET_CORRUPTION} loss {PACKET_LOSS} duplicate  \
              {PACKET_DUPLICATE}")
 
+def teardown_tcp():
+    """
+    Tear down the tcp network configured by setup_tcp().
+
+    Removing the namespaces also removes the veth pair, addresses,
+    routes, and netem qdisc that live inside them.  fail=False so
+    this is safe to call in error paths after a partial or complete setup.
+    """
+    cmd(f"ip netns del {NET0}", fail=False)
+    cmd(f"ip netns del {NET1}", fail=False)
+
 #Parse out command line arguments.  We take an optional
 # timeout parameter and an optional log output folder
 parser = argparse.ArgumentParser(description="init script args",
@@ -320,6 +334,11 @@ PACKET_LOSS=str(args.loss)+'%'
 PACKET_CORRUPTION=str(args.corruption)+'%'
 PACKET_DUPLICATE=str(args.duplicate)+'%'
 
+# Register cleanup before setup so a partial-setup crash still tears down
+# whatever state did get created.
+atexit.register(teardown_tcp)
+atexit.register(stop_pcaps)
+
 setup_tcp()
 
 print("TAP version 13")
@@ -335,8 +354,6 @@ ret = snd_rcv_packets(tcp_addrs, [NET0, NET1])
 # cancel timeout
 signal.alarm(0)
 
-stop_pcaps()
-
 if ret == 0:
     ksft_pr("Success")
     print("ok 1 rds selftest")
-- 
2.25.1


