Return-Path: <linux-rdma+bounces-20364-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sC3CFAGEAWoFcAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20364-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 09:23:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F06A509142
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 09:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 249BD3008C2C
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 07:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF9E37F72A;
	Mon, 11 May 2026 07:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IytD5vNM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952A337E304;
	Mon, 11 May 2026 07:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484202; cv=none; b=qyYjNCQQSPnYcfCeK/iJS7RFTxGo/V2EdK4VMn9LfGNpxL+tIyv/ml8WT9TcOdw1ICe3hZNyisIs9RhhSAJ3GeCBj/lkqZq1bF2lcxcjXGe1JDH+RP41Px0qjPiRZFyPdpkfPBPQL9pDTxIqdR4bhbEz3CjTcLxpBCL16dwnk1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484202; c=relaxed/simple;
	bh=XkGvGrsW34CnyZuYL7NiQ+yLafte2JkU0JbkJ3MSh5g=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iq851J5++ZikZnSgAYuPxfJSI6zK59X1weTgK82DDgF+oi5UaXrqetWYP0iGIJMW8Qget+O0bWPWxj7eFxKbHCZofhD0ou5jCjQIk2OKbpguKQF8wf7A60FID66iatjwSfYYYDiacDMLhPB9MXxufvigTwRp/8Sgra7ta8YNY9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IytD5vNM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50556C2BCF5;
	Mon, 11 May 2026 07:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778484201;
	bh=XkGvGrsW34CnyZuYL7NiQ+yLafte2JkU0JbkJ3MSh5g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=IytD5vNM6HQjWEVRQ/g2kRM7vKurZEmYxXoNd8xPW/ehrkpSkGFsXIroHezLPTvoW
	 BSswaoPUd+azm1r9f2wShTFuX+DzTbTxfF6GGD7b6CgeVT5yOsXcRkELQ9NrNiag76
	 an5nlNpsZmRho3zkRdmGX7Pr8theFqOWCMmSUlskzzdRWIug6czEXPkDcIbc9wSnV8
	 J3BT6RrDb1aAKdBr1lDV8wS9yiRSi56mWSpgzqY7xnTmubkEBOlj55y25L4SVDf4DM
	 ntIncxEdFQxkbtEA7q9U+sYyW/+N0c6Uyg61BLI6MBhwa13OQkuoje1CWri6C1yL50
	 UT5g5CZl40TEg==
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
Subject: [PATCH net-next v1 6/9] selftests: rds: Add helper function verify_hashes() in test.py
Date: Mon, 11 May 2026 00:23:13 -0700
Message-Id: <20260511072316.1174045-7-achender@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260511072316.1174045-1-achender@kernel.org>
References: <20260511072316.1174045-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0F06A509142
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
	TAGGED_FROM(0.00)[bounces-20364-lists,linux-rdma=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,test.py:url]
X-Rspamd-Action: no action

Hoist the verify hashes logic in test.py into a helper function,
verify_hashes().  This is a preparatory refactoring for the rds over
ROCE series that helps modularize the send/recv logic. Breaking up the
logic now will help avoid large function pylint errors later.  No
functional changes are introduced in this patch.

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/test.py | 33 ++++++++++++-------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
index 2e06e95827dd..6a7a5fe20034 100755
--- a/tools/testing/selftests/net/rds/test.py
+++ b/tools/testing/selftests/net/rds/test.py
@@ -152,6 +152,21 @@ def check_info(socks):
 
     ksft_pr(f"getsockopt(): {nr_success}/{nr_error}")
 
+def verify_hashes(snd_hashes, rcv_hashes):
+    """Compare send/recv hashes per (sender, receiver) pair."""
+    for key, snd_hash in snd_hashes.items():
+        rcv_hash = rcv_hashes.get(key)
+        if rcv_hash is None:
+            ksft_pr("FAIL: No data received")
+            return 1
+        if snd_hash.hexdigest() != rcv_hash.hexdigest():
+            ksft_pr("FAIL: Send/recv mismatch")
+            ksft_pr("hash expected:", snd_hash.hexdigest())
+            ksft_pr("hash received:", rcv_hash.hexdigest())
+            return 1
+        ksft_pr(f"{key[0]}/{key[1]}: ok")
+    return 0
+
 def stop_pcaps():
     """Stop tcpdump processes.
 
@@ -310,23 +325,7 @@ stop_pcaps()
 
 # We're done sending and receiving stuff, now let's check if what
 # we received is what we sent.
-RC = 0
-for (sender, receiver), send_hash in send_hashes.items():
-    recv_hash = recv_hashes.get((sender, receiver))
-
-    if recv_hash is None:
-        ksft_pr("FAIL: No data received")
-        RC = 1
-        break
-
-    if send_hash.hexdigest() != recv_hash.hexdigest():
-        ksft_pr("FAIL: Send/recv mismatch")
-        ksft_pr("hash expected:", send_hash.hexdigest())
-        ksft_pr("hash received:", recv_hash.hexdigest())
-        RC = 1
-        break
-
-    ksft_pr(f"{sender}/{receiver}: ok")
+RC = verify_hashes(send_hashes, recv_hashes)
 
 if RC == 0:
     ksft_pr("Success")
-- 
2.25.1


