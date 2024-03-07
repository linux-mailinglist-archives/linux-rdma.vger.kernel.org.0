Return-Path: <linux-rdma+bounces-1329-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BA1875B0D
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Mar 2024 00:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90213282E8B
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Mar 2024 23:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9287B3EA9B;
	Thu,  7 Mar 2024 23:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="oKU41DL3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E30E3D988;
	Thu,  7 Mar 2024 23:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709853756; cv=none; b=M7+euwwLwojGU5nRGm+nNWjGryVOLsNPJ+wU6Rbe11DoMHlF+N1+cRzhA672A2GrT1Zw4NT8p9bhCD4tImhipUNyt19g2dLELpfwNYIXbYGBWhK14F2SnlVyXIMyU/RBt1oHu03JsZi4fgweDZbSbyGgaFNbNMHB+xiHttE+yzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709853756; c=relaxed/simple;
	bh=atQobsK+T8YIVm3pX3bXFJqxMPrO070f5VmImIpJ014=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EN0JVAGbQlkdV/2W7GQ+YY6rb8S0OpbtMwLyZhyLh49fKr2WZD09JhJ/BX0a6Jdq4d+G0IWdKMYo7OnDLmXdykpMWMXQO96exXlhBJ1hwOglQZxheXodwvnKyBLLkYNhp5FiYtYyj/IETzdA3/hfIA7fNDK8YXwiQ/TCMxX7Elw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=oKU41DL3; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709853755; x=1741389755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=msbilLE2ODNYHDBDiXfI9WuDR+c1dAuxbeGxbORJ5rI=;
  b=oKU41DL3/Cr2dfhfXS75Uoe3DBFQrvbDK2m4nrrFTH/CKl176liOcqvr
   sBl0g3eET59ljTTpi6r/y0Li+5Umd9cFjDuGssZhtLQxBMUl+aTkKEckW
   uYfmhD33lu9XyqWY7uUWxTy2I06I77qMkjvFeYQ+fptAPEMK3dDUL1Mtp
   w=;
X-IronPort-AV: E=Sophos;i="6.07,107,1708387200"; 
   d="scan'208";a="618205608"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 23:22:32 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:12081]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.183:2525] with esmtp (Farcaster)
 id fbf02b3a-fd0d-4a78-97aa-f2acc2f7c3bb; Thu, 7 Mar 2024 23:22:31 +0000 (UTC)
X-Farcaster-Flow-ID: fbf02b3a-fd0d-4a78-97aa-f2acc2f7c3bb
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 7 Mar 2024 23:22:30 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.47) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 7 Mar 2024 23:22:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Allison Henderson <allison.henderson@oracle.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<rds-devel@oss.oracle.com>
Subject: [PATCH v4 net 1/2] tcp: Fix use-after-free in inet_twsk_purge().
Date: Thu, 7 Mar 2024 15:21:50 -0800
Message-ID: <20240307232151.55963-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240307232151.55963-1-kuniyu@amazon.com>
References: <20240307232151.55963-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA002.ant.amazon.com (10.13.139.39) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Commit 740ea3c4a0b2 ("tcp: Clean up kernel listener's reqsk in
inet_twsk_purge()") added changes in inet_twsk_purge() to purge
reqsk in per-netns ehash during netns dismantle.

inet_csk_reqsk_queue_drop_and_put() will remove reqsk from per-netns
ehash, but the iteration uses sk_nulls_for_each_rcu(), which is not
safe.  After removing reqsk, we need to restart iteration.

Also, we need to use refcount_inc_not_zero() to check if reqsk is
freed by its timer.

Fixes: 740ea3c4a0b2 ("tcp: Clean up kernel listener's reqsk in inet_twsk_purge()")
Reported-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/inet_timewait_sock.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 5befa4de5b24..c81f83893fc7 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -278,18 +278,32 @@ void inet_twsk_purge(struct inet_hashinfo *hashinfo, int family)
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
-					     hashinfo->pernet)) {
-					struct request_sock *req = inet_reqsk(sk);
 
-					inet_csk_reqsk_queue_drop_and_put(req->rsk_listener, req);
+				if (sk->sk_family != family ||
+				    refcount_read(&sock_net(sk)->ns.count))
+					continue;
+
+				req = inet_reqsk(sk);
+				if (unlikely(!refcount_inc_not_zero(&req->rsk_refcnt)))
+					continue;
+
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
-- 
2.30.2


