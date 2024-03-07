Return-Path: <linux-rdma+bounces-1327-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B01BF875A6A
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Mar 2024 23:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C85C1F23343
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Mar 2024 22:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4001D39FFA;
	Thu,  7 Mar 2024 22:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="eFYHgJ9f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EBA38398;
	Thu,  7 Mar 2024 22:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709851491; cv=none; b=ixgX1NLCt6ip+zSugkZhNvp8Jp6bm659ZgX+EAP10cASJcPQ966oFlloc7Y4M7iF6WVEK5F6jO7wscBU3+UPCFEkMV9G1azhJENXukldL7rGvHG9uVhhfPmhJZkdOvu+CFtXr8jlVPMn8hYrURmCQvzsF+lbGtXpcdzgS1RYYBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709851491; c=relaxed/simple;
	bh=wkD6adteARyJgYYRu3MrdSFmoRw1Q8vJMLBjF+6FE0k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rRPRO6vLSeS/CqFsArp9IHlzSoHk35axKWIOdHYKNwf2ShzTS0AVG8bnydAEmgUzjrsvLQeMGTi7DiC2PqP1uzZdktKFjmfFBvDev8BN6QgduYAtjCuvw9/ibePcJyuRLIlSv4DEd8VIbWwMJjC4bIyvR4sWCPbgbfpu+dMZiwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=eFYHgJ9f; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709851489; x=1741387489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xI4kjzpat6l1cEcy6qPyGgoqE95a14RNNSjI2oOWK4Y=;
  b=eFYHgJ9fHS0R5F3gEZ7AQGbS6JKR/qd3CjFbvC4pMVO7lJrCPTpSPSEM
   DbBM5Q/X1YnLxnmCodEWAi9r3yT6kUbpQv88PAmxELutt90o4N6MTzRkD
   +uiMsnLiBzwWQKw2kgW2fZRPR3hRekVTlRlgEoJlcEvOKHPD8tYBNQJcm
   U=;
X-IronPort-AV: E=Sophos;i="6.07,107,1708387200"; 
   d="scan'208";a="71603403"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 22:44:46 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:1720]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.183:2525] with esmtp (Farcaster)
 id c37515f5-e0aa-4a75-9067-720b0d17c378; Thu, 7 Mar 2024 22:44:40 +0000 (UTC)
X-Farcaster-Flow-ID: c37515f5-e0aa-4a75-9067-720b0d17c378
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 7 Mar 2024 22:44:36 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.47) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 7 Mar 2024 22:44:33 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <allison.henderson@oracle.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <rds-devel@oss.oracle.com>
Subject: Re: [PATCH v3 net 1/2] tcp: Restart iteration after removing reqsk in inet_twsk_purge().
Date: Thu, 7 Mar 2024 14:44:23 -0800
Message-ID: <20240307224423.53315-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CANn89iJP8gy24JOhwvydsDeVieAQFBmL4evt00vtOvW8tPPb7g@mail.gmail.com>
References: <CANn89iJP8gy24JOhwvydsDeVieAQFBmL4evt00vtOvW8tPPb7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D032UWA002.ant.amazon.com (10.13.139.81) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Mar 2024 10:51:15 +0100
> On Thu, Mar 7, 2024 at 12:05 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > Commit 740ea3c4a0b2 ("tcp: Clean up kernel listener's reqsk in
> > inet_twsk_purge()") added changes in inet_twsk_purge() to purge
> > reqsk in per-netns ehash during netns dismantle.
> >
> > inet_csk_reqsk_queue_drop_and_put() will remove reqsk from per-netns
> > ehash, but the iteration uses sk_nulls_for_each_rcu(), which is not
> > safe.
> >
> > After removing reqsk, we need to restart iteration.
> >
> > Note that we need not check net->ns.count here because per-netns
> > ehash does not have reqsk in other live netns.  We will check
> > net->ns.count in the following patch.
> >
> > Fixes: 740ea3c4a0b2 ("tcp: Clean up kernel listener's reqsk in inet_twsk_purge()")
> > Reported-by: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  net/ipv4/inet_timewait_sock.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
> > index 5befa4de5b24..00cbebaa2c68 100644
> > --- a/net/ipv4/inet_timewait_sock.c
> > +++ b/net/ipv4/inet_timewait_sock.c
> > @@ -287,6 +287,8 @@ void inet_twsk_purge(struct inet_hashinfo *hashinfo, int family)
> >                                         struct request_sock *req = inet_reqsk(sk);
> >
> >                                         inet_csk_reqsk_queue_drop_and_put(req->rsk_listener, req);
> > +
> > +                                       goto restart;
> >                                 }
> >
> >                                 continue;
> 
> Note how the RCU rules that I followed for TCP_TIME_WAIT made
> me to grab a reference on tw->tw_refcnt, using refcount_inc_not_zero()
> 
> I think your code had multiple bugs, because
> inet_csk_reqsk_queue_drop_and_put() could cause UAF
> if the timer already fired and refcount went to zero already.

Ugh.. exactly.
I'll post v4 following the TIME_WAIT path.

---8<---
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 961b1917c3eb..c81f83893fc7 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -278,20 +278,32 @@ void inet_twsk_purge(struct inet_hashinfo *hashinfo, int family)
 restart:
 		sk_nulls_for_each_rcu(sk, node, &head->chain) {
 			if (sk->sk_state != TCP_TIME_WAIT) {
+				struct request_sock *req;
+
+				if (likely(sk->sk_state != TCP_NEW_SYN_RECV))
+					continue;
+
 				/* A kernel listener socket might not hold refcnt for net,
 				 * so reqsk_timer_handler() could be fired after net is
 				 * freed.  Userspace listener and reqsk never exist here.
 				 */
-				if (unlikely(sk->sk_state == TCP_NEW_SYN_RECV &&
-					     !refcount_read(&sock_net(sk)->ns.count))) {
-					struct request_sock *req = inet_reqsk(sk);
 
-					inet_csk_reqsk_queue_drop_and_put(req->rsk_listener, req);
+				if (sk->sk_family != family ||
+				    refcount_read(&sock_net(sk)->ns.count))
+					continue;
+
+				req = inet_reqsk(sk);
+				if (unlikely(!refcount_inc_not_zero(&req->rsk_refcnt)))
+					continue;
 
-					goto restart;
+				if (unlikely(sk->sk_family != family ||
+					     refcount_read(&sock_net(sk)->ns.count))) {
+					reqsk_put(req);
+					continue;
 				}
 
-				continue;
+				inet_csk_reqsk_queue_drop_and_put(req->rsk_listener, req);
+				goto restart;
 			}
 
 			tw = inet_twsk(sk);
---8<---


> 
> We also could add sk_nulls_for_each_rcu_safe() to avoid these pesky
> "goto restart;"

I'll post this followup for net-next in the next release cycle.

Thanks!

