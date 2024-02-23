Return-Path: <linux-rdma+bounces-1113-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1A686196C
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Feb 2024 18:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F3C51F26370
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Feb 2024 17:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E426013790F;
	Fri, 23 Feb 2024 17:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rHx0MSbH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C677812E1F9;
	Fri, 23 Feb 2024 17:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709144; cv=none; b=sM03/XwH4CfkXcIyeDMJxLhz0u4FZycdLzyEaDU+9j1lw+91Xok8BGBfai7oDw/f9GQy3d8Ph1U/OWaKT4VkrNhKy4jrmq/T6VXLvrF4nGbqFGdRBg4t7Vb3BK4dvV9ZxycfmrMH7I04dMLaZp0Z3D/MrQ+GUd8I+/fUbm3fZVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709144; c=relaxed/simple;
	bh=NUFFREkH1oGrARHPTuD2vdos5a4yP9QoLdU8ayBpCPg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nwRMXTuU9YRP5hNyMwKLySrtMCuzM5nLe6A7jQeHiGRFCmvM0Y5l19a34gNGwymUxpFJzQ22zNWpDz0vBAih8hTn0ZRDt1HVJgbkAUyQAzJXf8PPd7cNG8gT2JwHcAgdDWbFwUWp85XzhViqUQLWC/wrgw/+z6HeQdhgc7FcC10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=rHx0MSbH; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708709143; x=1740245143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oBcUd27l1bI77yNrWKPQ+fD+nkfhnSto6MAlhz41Btk=;
  b=rHx0MSbHgzLkX95Nia/VSrl45EK1zqqt8u9Pgq5UHGXkmW7f3rMZib/8
   KOJm6Y5jV4cbDDYHBKZZjtpBO8vwX5G2WaA+eKOsYOJAgczo5bDYGden9
   GCntV+H0l3Uz6vpGjq89a/dAYvOYBy0B1CKQMwnyIevBpMT6dQUF/x6YQ
   8=;
X-IronPort-AV: E=Sophos;i="6.06,180,1705363200"; 
   d="scan'208";a="615177852"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 17:25:40 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:38671]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.177:2525] with esmtp (Farcaster)
 id 52c93b90-82dd-4a82-967f-642820bb91fa; Fri, 23 Feb 2024 17:25:38 +0000 (UTC)
X-Farcaster-Flow-ID: 52c93b90-82dd-4a82-967f-642820bb91fa
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 17:25:34 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 17:25:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Allison Henderson <allison.henderson@oracle.com>
CC: Sowmini Varadhan <sowmini.varadhan@oracle.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<rds-devel@oss.oracle.com>
Subject: [PATCH v1 net 1/2] Revert "tcp: Clean up kernel listener's reqsk in inet_twsk_purge()"
Date: Fri, 23 Feb 2024 09:24:47 -0800
Message-ID: <20240223172448.94084-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240223172448.94084-1-kuniyu@amazon.com>
References: <20240223172448.94084-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

This reverts commit 740ea3c4a0b2e326b23d7cdf05472a0e92aa39bc.

The change actually fixed a use-after-free of struct net by kernel
listener's reqsk in per-netns ehash.

However, the fix was incomplete, as the same issue exists for the
global ehash.

We should have fixed it on the RDS side without slowing down netns
dismantle for the normal TCP use case.

The next patch fixes the issue on the RDS side.

Fixes: 740ea3c4a0b2 ("tcp: Clean up kernel listener's reqsk in inet_twsk_purge()")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/inet_timewait_sock.c | 15 +--------------
 net/ipv4/tcp_minisocks.c      |  9 ++++-----
 2 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 5befa4de5b24..e7a1698c6b22 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -277,21 +277,8 @@ void inet_twsk_purge(struct inet_hashinfo *hashinfo, int family)
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
-				}
-
+			if (sk->sk_state != TCP_TIME_WAIT)
 				continue;
-			}
-
 			tw = inet_twsk(sk);
 			if ((tw->tw_family != family) ||
 				refcount_read(&twsk_net(tw)->ns.count))
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


