Return-Path: <linux-rdma+bounces-19699-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Hc4K1Y08WkgegEAu9opvQ
	(envelope-from <linux-rdma+bounces-19699-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:27:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC9F48C940
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 15D8D301809A
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 22:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153AC388E46;
	Tue, 28 Apr 2026 22:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHgn9VaV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C849938239B;
	Tue, 28 Apr 2026 22:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777415243; cv=none; b=EB3zISzd435WMUK/vvIw3iJKHtNxgxdZmjViihCieyTPZrgMpLhB5pOobmU6MFudnrqs5Yrr6yoAroGy2N2hPbth7+2PbiDz6GgOy3mPmdpfiGIp9740kSxkfyrbrGDnq7TQMPXbqjRDUFrr7F+wGUTrUxNKgamRRwwrNPThEtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777415243; c=relaxed/simple;
	bh=OT182rWBpEf7KODSzPQcLkzia7cbfVmufjFSVAQBTgA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rVCBjhzuodB9CD5W2zyDMJHrbb2gR9IQrHn1Esbtoj5bw02Lbq7aypuKH2xKK67t4S+wEHdWHS+sTow08o3kaF3G2XH3VtGR3qePP/NgZ9n0eZWqz7j8WC9VEnbezTBN1Vh2Qao0c5n67ZnWtBJmQsdCMp3QsGMyuHNbbVYwLUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHgn9VaV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D69AC2BCAF;
	Tue, 28 Apr 2026 22:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777415242;
	bh=OT182rWBpEf7KODSzPQcLkzia7cbfVmufjFSVAQBTgA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WHgn9VaV5nTy/iR6IaHGxYIwd76SfTPgb34fKuhbJxenM95xOV5Sor4Xeju1QoyWq
	 UAU1+TA2bBZ6l+yzKac4+D+asry8ZQsRJBc9P4ppmlNYmHf7K0JTQrqbnkDKs/NDlk
	 30srbyUXC4N6oVS2A7kGzIztz1ptkCHo9anxe04FF5OvVNH68U3btdZf6FIu1YDzqu
	 lJxX5Ut/gE10C5JqsAVPVRo1B76Vfj1zjq0OMR23FRWhWqTFk3xUgK5O95Mu9NuzB/
	 OkeojcQry7HAz5rdr2b1ZyfEhTH+O0XjuNpdTIjXoxFt6HFhWbJN4Gt2zpJMkr9o6U
	 i2Gfti+c0JOeQ==
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
Subject: [PATCH net-next v2 6/7] selftests: rds: Collect pcaps on timeout
Date: Tue, 28 Apr 2026 15:27:15 -0700
Message-Id: <20260428222716.2960871-7-achender@kernel.org>
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
X-Rspamd-Queue-Id: 7BC9F48C940
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19699-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

The timeout signal handler for the rds selftests currently just
exits when the time limit is exceeded, and forgets to collect the
network dumps.  Which can be valueable for discerning why the test
timed out in the first place.  Fix this by hoisting the network
dump collection into a helper function, and call it from the
signal handler before exiting

Signed-off-by: Allison Henderson <achender@kernel.org>
---
 tools/testing/selftests/net/rds/test.py | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
index d48533505f0f..1c7aebddeb61 100755
--- a/tools/testing/selftests/net/rds/test.py
+++ b/tools/testing/selftests/net/rds/test.py
@@ -70,11 +70,21 @@ def netns_socket(netns, *sock_args):
     u1.close()
     return socket.fromfd(fds[0], *sock_args)
 
+def collect_pcaps():
+    """Stop tcpdump processes and move their pcaps into the log dir."""
+    print("Stopping network packet captures")
+    for proc, tmp_path, dest_path, fno in tcpdump_procs:
+        proc.terminate()
+        proc.wait()
+        os.close(fno)
+        shutil.move(tmp_path, dest_path)
+
 def signal_handler(_sig, _frame):
     """
     Test timed out signal handler
     """
     print('Test timed out')
+    collect_pcaps()
     sys.exit(1)
 
 #Parse out command line arguments.  We take an optional
@@ -251,13 +261,7 @@ for s in sockets:
                 pass
 
 print(f"getsockopt(): {nr_success}/{nr_error}")
-
-print("Stopping network packet captures")
-for p, pcap_tmp, pcap, fd in tcpdump_procs:
-    p.terminate()
-    p.wait()
-    os.close(fd)
-    shutil.move(pcap_tmp, pcap)
+collect_pcaps()
 
 # We're done sending and receiving stuff, now let's check if what
 # we received is what we sent.
-- 
2.25.1


