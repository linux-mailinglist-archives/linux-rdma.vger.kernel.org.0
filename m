Return-Path: <linux-rdma+bounces-1146-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0199B86859A
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Feb 2024 02:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB59280C10
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Feb 2024 01:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8314A28;
	Tue, 27 Feb 2024 01:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dSqDarq5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8134431;
	Tue, 27 Feb 2024 01:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708996318; cv=none; b=geW07KZ6o8PElMKWU5jBhQ5jrEMBHbawpaDXQueae6njxbkfa1fSON/KOud74fok5KDub/6JevB8ejEywtKHue/6xPWQHSB7e5irtTUoxFXsWlCkLa2PdH85htFsOvwEpAIMC+QWOFTuNNymG8LotDVbrk6aqfPcfYXm8++Y30k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708996318; c=relaxed/simple;
	bh=vay2VEAyTqvCkGswPS4QOIoBT2b0IYWYIZGp/yNIJnw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B4A+jPhFsPTm2nk/xF9qd4QuEULUtCI//sgc5YWEMPpEcUQyfy+3CL315shw+bsBlSTEBF9LypZIFpsymsb5or0R3A/r4AHmlfO/8P+4IYB7Z+zmlGMzWO2WyohJ4CzD7WbSriMg3avvaHKtbsGb1pjEBoKG5i2HKJWqeuK2U9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=dSqDarq5; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708996314; x=1740532314;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vLWlDHaOzS3uEVenflKacTWEx1B/0qcpvGK1bRwXcjQ=;
  b=dSqDarq57tWc9Hf0a4kJohfn0Fj4OI7ABn/RUEzosWWPWTNjlV74uh/p
   xcme/4BqkZjrBTFd3oM1VXKkeHHgdavOGTika6GHAGt5yCFn0RV/wLVR3
   +SMauOoZKC4dnGYYXjwBLSurL3+2wNERdbcjxGcHM1A++CkWvRC8Y39zT
   k=;
X-IronPort-AV: E=Sophos;i="6.06,187,1705363200"; 
   d="scan'208";a="640634277"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 01:11:51 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:55504]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.27:2525] with esmtp (Farcaster)
 id 8f1355e5-1eae-4fb8-a862-6aa5c5b499ba; Tue, 27 Feb 2024 01:11:50 +0000 (UTC)
X-Farcaster-Flow-ID: 8f1355e5-1eae-4fb8-a862-6aa5c5b499ba
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 01:11:47 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 27 Feb 2024 01:11:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Allison Henderson <allison.henderson@oracle.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<rds-devel@oss.oracle.com>
Subject: [PATCH v2 net 2/5] Revert "tcp: Clean up kernel listener's reqsk in inet_twsk_purge()"
Date: Mon, 26 Feb 2024 17:10:38 -0800
Message-ID: <20240227011041.97375-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240227011041.97375-1-kuniyu@amazon.com>
References: <20240227011041.97375-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB004.ant.amazon.com (10.13.138.57) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

This reverts commit 740ea3c4a0b2e326b23d7cdf05472a0e92aa39bc.

The change actually fixed a use-after-free of struct net by kernel
listener's reqsk in per-netns ehash.

However, the fix was incomplete, as the same issue exists for the
global ehash.

We should have fixed it on the RDS side without slowing down netns
dismantle for the normal TCP use case.

The following patches will fix the issue on the RDS side.

Fixes: 740ea3c4a0b2 ("tcp: Clean up kernel listener's reqsk in inet_twsk_purge()")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/inet_timewait_sock.c | 16 +---------------
 net/ipv4/tcp_minisocks.c      |  9 ++++-----
 2 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 00cbebaa2c68..6b65f5f97478 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -277,22 +277,8 @@ void inet_twsk_purge(struct inet_hashinfo *hashinfo, int family)
 		rcu_read_lock();
 restart:
 		sk_nulls_for_each_rcu(sk, node, &head->chain) {
-			if (sk->sk_state != TCP_TIME_WAIT) {
-				/* A kernel listener socket might not hold refcnt for net,
-				 * so reqsk_timer_handler() could be fired after net is
-				 * freed.  Userspace listener and reqsk never exist here.
-				 */
-				if (unlikely(sk->sk_state == TCP_NEW_SYN_RECV &&
-					     hashinfo->pernet)) {
-					struct request_sock *req = inet_reqsk(sk);
-
-					inet_csk_reqsk_queue_drop_and_put(req->rsk_listener, req);
-
-					goto restart;
-				}
-
+			if (sk->sk_state != TCP_TIME_WAIT)
 				continue;
-			}
 
 			tw = inet_twsk(sk);
 			if ((tw->tw_family != family) ||
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 9e85f2a0bddd..baecfa4c70ef 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -394,14 +394,13 @@ void tcp_twsk_purge(struct list_head *net_exit_list, int family)
 	struct net *net;
 
 	list_for_each_entry(net, net_exit_list, exit_list) {
+		/* The last refcount is decremented in tcp_sk_exit_batch() */
+		if (refcount_read(&net->ipv4.tcp_death_row.tw_refcount) == 1)
+			continue;
+
 		if (net->ipv4.tcp_death_row.hashinfo->pernet) {
-			/* Even if tw_refcount == 1, we must clean up kernel reqsk */
 			inet_twsk_purge(net->ipv4.tcp_death_row.hashinfo, family);
 		} else if (!purged_once) {
-			/* The last refcount is decremented in tcp_sk_exit_batch() */
-			if (refcount_read(&net->ipv4.tcp_death_row.tw_refcount) == 1)
-				continue;
-
 			inet_twsk_purge(&tcp_hashinfo, family);
 			purged_once = true;
 		}
-- 
2.30.2


