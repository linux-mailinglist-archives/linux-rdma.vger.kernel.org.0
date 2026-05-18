Return-Path: <linux-rdma+bounces-20866-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKkZAZlqCmp+1AQAu9opvQ
	(envelope-from <linux-rdma+bounces-20866-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 03:25:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC2C564C68
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 03:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5052A3008D47
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 01:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AA62773D8;
	Mon, 18 May 2026 01:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvAd+24C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AFF26CE11;
	Mon, 18 May 2026 01:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779067491; cv=none; b=QsgLxC8SfIaxfqc2B7b9cLddtmyjwXLb4VQkKFAR1gjVIldIdfefmywESHwkhj6hGCqqRmD9B7Ic0WVsR4MZfrHDztJ1N5KYOFhG53KW6W5jjgcFdKg4WuagJ8DHM9WyEiOwsRQeXgRDEeZlUlWHEpAFWEYG7bL8fRNQ3U7GQoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779067491; c=relaxed/simple;
	bh=g6QtbzzbjUWO3EenwLABGnFL9V2BfXR/BEBTMZQj45k=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PWZRTbgBSdQzq66xaXKd4+JVUnzrULNEVK/20b7oFvgK/Q1iL/QoYEpu6y+KOYST3fAH7DpyP3bKOkk1gdV9CIqhK3E+BlriFAzgX0zkQfqHLF8d+XwOUuaBKqn2QI6ojF5/QawCR2gzvSEf16Gc6KwfObXVtKadxzi4vRiFkmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvAd+24C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116A6C2BCB0;
	Mon, 18 May 2026 01:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779067490;
	bh=g6QtbzzbjUWO3EenwLABGnFL9V2BfXR/BEBTMZQj45k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NvAd+24CaxRlaV16yp/GD4TmYGazo34qE7mar48dj+KNjByOS/C9DeEuRRlzxHfjj
	 NlqNckvjh04m8F1g0pqUbjLLSktJJWJQ287+xrRnbbk1OWT2ti9l8uT63hDGIkqexq
	 WJO2dwqmHyt+KkI8kGZ7REbcouKwfRZknpSKxKtkRa7d4o4FY3nHSzpVEGn0Fvydbn
	 dT388l2fLJOKZdMrvknQpi+x5NbtAsS+y1UDCHbUTez9HaprvDXuJDTRrSStojLfIx
	 sxw05LOxJtl9Ph1D367HqFeCmw1aVRay8LywXtaPQq4HPz4uj+qNQlfEk6glIBUEYa
	 goQ1r9uBWSxHQ==
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
Subject: [PATCH net-next v3 08/11] selftests: rds: Handle errors in netns_socket
Date: Sun, 17 May 2026 18:24:40 -0700
Message-Id: <20260518012443.2629206-9-achender@kernel.org>
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
X-Rspamd-Queue-Id: 9EC2C564C68
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
	TAGGED_FROM(0.00)[bounces-20866-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Sockets created by child processes in netns_socket may raise
exceptions that are currently not handled by the parent.  If for
example a namespace didn't exist or the rds module didn't load. Because
these exceptions occur with in a child thread, the child thread exits,
but the parent does not check the return status.

Further, allowing the child processes to quietly raise exceptions
will cause problems later if the parent registers clean up functions
with atexit.  Since the child processes inherit the parents handlers,
they may prematurely call the parents cleanup routines without the
parent being aware.

Fix this by all catching exceptions raised by the child processes.
Child errors surface as a non-zero exit status, which are then
properly raised in the parent process.

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/test.py | 27 +++++++++++++------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
index f7d0dba85131e..2188221ee7805 100755
--- a/tools/testing/selftests/net/rds/test.py
+++ b/tools/testing/selftests/net/rds/test.py
@@ -56,27 +56,28 @@ def netns_socket(netns, *sock_args):
 
     child = os.fork()
     if child == 0:
-        # change network namespace
-        with open(f'/var/run/netns/{netns}', encoding='utf-8') as f:
-            try:
+        try:
+            # change network namespace
+            with open(f'/var/run/netns/{netns}', encoding='utf-8') as f:
                 setns(f.fileno(), 0)
-            except IOError as e:
-                print(e.errno)
-                print(e)
-
-        # create socket in target namespace
-        sock = socket.socket(*sock_args)
+            # create socket in target namespace
+            sock = socket.socket(*sock_args)
 
-        # send resulting socket to parent
-        socket.send_fds(u0, [], [sock.fileno()])
+            # send resulting socket to parent
+            socket.send_fds(u0, [], [sock.fileno()])
 
-        os._exit(0)
+            os._exit(0)
+        except BaseException:
+            os._exit(1)
 
     # receive socket from child
     _, fds, _, _ = socket.recv_fds(u1, 0, 1)
-    os.waitpid(child, 0)
+    _, status = os.waitpid(child, 0)
     u0.close()
     u1.close()
+    if not os.WIFEXITED(status) or os.WEXITSTATUS(status) != 0:
+        raise RuntimeError(
+            f"netns_socket child failed in netns {netns} (status={status})")
     return socket.fromfd(fds[0], *sock_args)
 
 def send_burst(socks, ip_addrs, snd_hashes, nr_sent, nr_total):
-- 
2.25.1


