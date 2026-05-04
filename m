Return-Path: <linux-rdma+bounces-19900-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2A+TLxMy+Gl1rQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19900-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 07:43:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A554B8A6D
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 07:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EF4E3022924
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 05:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D124F29AAEA;
	Mon,  4 May 2026 05:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxnQdYq2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932C2277C81;
	Mon,  4 May 2026 05:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777873310; cv=none; b=QjMpnzYArD264bJey9APuBssy7XhGeOaZe3jRq01R442HXOxwtp6tTapODAG4dpURzsolEtNNxviaMGM+70Lnp9yT/yYRp6bgYm/GivJSE1C8aRzJbp6x+2rmnXRO4k2tXkAdamvY8KyPhFt/GgyDqtTgRSbHKLNnx2gWkbknLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777873310; c=relaxed/simple;
	bh=L3Sot7e5iY2B6BA0Y7EJ7d72qlutg4wPCr87yV/MqyU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T0ClQncsPH8X2uoYsg91Uj4FRl5alDQFzGhQ/w840NNht0InVpBwTtut2+vd5/xIHPzMqZ9vIAsvnc1ZfwFsMR1SoY+F2eoKNXISHCwvKiDj1YHe3VOtHBvuAoIOozsStiEwJULgSAb29TLuCkxhftUChbBlLKr1aNVtQ9rX6Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxnQdYq2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7071C32781;
	Mon,  4 May 2026 05:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777873310;
	bh=L3Sot7e5iY2B6BA0Y7EJ7d72qlutg4wPCr87yV/MqyU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BxnQdYq2JALaOjcmOLfDPqZCrtSGx+2PGUQlcU0C5oOhhw1RlOuOdg83H7KjglKZD
	 joDRsv6mlHsL0XAlTauG6HvNR/M2QeWM+DDi+UpRLyQSNdldjEBU8GXmLnz+KhOrB8
	 P3kLsSvV9DOBRBGz/YembgrHWdu07+uFuRvHbsaIwwd8oM3GffEBy/89sHgk2YlTO2
	 vitdG660msVCqlCUtIaqGsi85ZeTjivI+7rNbhzebp+9lj9ws8XqXaR2OpWRbjcvzr
	 bWtKSlA//adGe3uiXCIf+cuSJcqR7nlWLV6Yym2x1pInNHoqW/P3wS13y5nXzAsLqt
	 brG/64hjTVmZw==
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
Subject: [PATCH net-next v3 08/10] selftests: rds: Stop tcpdump on timeout
Date: Sun,  3 May 2026 22:41:41 -0700
Message-Id: <20260504054143.4027538-9-achender@kernel.org>
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
X-Rspamd-Queue-Id: 81A554B8A6D
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-19900-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

The timeout signal handler for the rds selftests currently just
exits when the time limit is exceeded, and forgets to stop the
network dumps.  Fix this by hoisting the tcpdump terminate commands
into a helper function, and call it from the signal handler before
exiting

Bound proc.wait() with a timeout (and fall back to proc.kill())
so an unresponsive tcpdump cannot hang the timeout path itself.

We also pop() tcpdump_procs as we iterate, so stop_pcaps() is safe
to call from both the normal cleanup path and the signal handler,
since the second invocation simply has nothing to do

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/test.py | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
index a7be57ef6ece..faf751863478 100755
--- a/tools/testing/selftests/net/rds/test.py
+++ b/tools/testing/selftests/net/rds/test.py
@@ -68,11 +68,29 @@ def netns_socket(netns, *sock_args):
     u1.close()
     return socket.fromfd(fds[0], *sock_args)
 
+def stop_pcaps():
+    """Stop tcpdump processes.
+
+    We use pop() here to drain the list in the event that the test
+    completes after the signal handler is fired.  List will be empty
+    if logdir is not set
+    """
+    print("Stopping network packet captures")
+    while tcpdump_procs:
+        proc = tcpdump_procs.pop()
+        proc.terminate()
+        try:
+            proc.wait(timeout=5)
+        except subprocess.TimeoutExpired:
+            proc.kill()
+            proc.wait()
+
 def signal_handler(_sig, _frame):
     """
     Test timed out signal handler
     """
     print('Test timed out')
+    stop_pcaps()
     sys.exit(1)
 
 #Parse out command line arguments.  We take an optional
@@ -255,11 +273,7 @@ for s in sockets:
 
 print(f"getsockopt(): {nr_success}/{nr_error}")
 
-if logdir is not None:
-    print("Stopping network packet captures")
-    for p in tcpdump_procs:
-        p.terminate()
-        p.wait()
+stop_pcaps()
 
 # We're done sending and receiving stuff, now let's check if what
 # we received is what we sent.
-- 
2.25.1


