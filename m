Return-Path: <linux-rdma+bounces-233-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62575803EF6
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Dec 2023 21:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C0ECB20AD6
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Dec 2023 20:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E945A33CE2;
	Mon,  4 Dec 2023 20:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZGDGnOp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBECDCD
	for <linux-rdma@vger.kernel.org>; Mon,  4 Dec 2023 12:04:13 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-58dd6d9ae96so2000879eaf.1
        for <linux-rdma@vger.kernel.org>; Mon, 04 Dec 2023 12:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701720253; x=1702325053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNNdG/PM+AuJDOt1JttFimVCtHWdWlZYU0LPM6zkuxI=;
        b=XZGDGnOpkZGU1SdAPnqoXKusEpwD74vxI7YPImxxeZ5IBQERqgU9aJ+70jnPLUSMWv
         r2Zo1GY3ei5O1ZlKhN1aUsiKeG+I4p8ndBAYa0jq/vwMmpX3vbbq7Ay0ug136IfLViBY
         AK39P6IKsurM1+rvX+nLaVaav8OAFNWGyL3kXmkL4JmOgLSzzQ1s1zwmOBDK/5Gb3BiN
         OBl6qGgiWgajMWXRO0JPQTi96mX2IOjr0+QuxfZqFqp6SWqpVlCbXUJtQaz1KKEE18yb
         5jebiF33g79xIhlUZgb1twZ+AukYOoBfrwbpPCaCjkmsDbpwLluq1Z7HvZsO6vM9UzXM
         QRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701720253; x=1702325053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNNdG/PM+AuJDOt1JttFimVCtHWdWlZYU0LPM6zkuxI=;
        b=N5qCmc09LEy4jAsDu/DPA+zjCCKSPkHHotsYkCx54eG4rZ4SYzcQGfD0klPauK4WEp
         /fOCPxdbMlA4CnSLwe4KHPG8Ox+Jf2W2QoizF/YkYmEcZO5OlmxMVhG5pAzJh75ohk51
         gUcIPla+cGt+X+52uy1hYZpr06WqMlEJO7jumIG3iNbS7yyXFwEDUInaRXY/EejuoQeZ
         JqLy22sjsFBTL9cPaZKY5KSgvd1kfQh0dTSBttw0GofrsWYmFgzZlHpOx8IdDAlEQftE
         lES+KJXb5Eqor171doKz9FK3vCEVLfWCDf9rbt1hMXV3GNy43UeRpPQxWy54J4douEd1
         hqDw==
X-Gm-Message-State: AOJu0YzvJ46QjMbmfMwfIn9HO+APtzVt4is+BMBcqCy4sNEPKl1t2ufP
	f333mSh462W1gQrO0aLwLSQ=
X-Google-Smtp-Source: AGHT+IFbTsa3r1tJi1XvtSrxnx3LmX+jvtToV9grLrgzLMneX7QoKU0XwmKqAkRRl/YPMRYPAVLptQ==
X-Received: by 2002:a4a:ee83:0:b0:58e:1c48:1a62 with SMTP id dk3-20020a4aee83000000b0058e1c481a62mr2765495oob.11.1701720251549;
        Mon, 04 Dec 2023 12:04:11 -0800 (PST)
Received: from bob-3900x.lan (2603-8081-1405-679b-e463-fe8f-1aa8-6edb.res6.spectrum.com. [2603:8081:1405:679b:e463:fe8f:1aa8:6edb])
        by smtp.gmail.com with ESMTPSA id e72-20020a4a554b000000b0054f85f67f31sm537281oob.46.2023.12.04.12.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 12:04:11 -0800 (PST)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: jgg@nvidia.com,
	yanjun.zhu@linux.dev,
	linux-rdma@vger.kernel.org
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v4 3/7] RDMA/rxe: Register IP mcast address
Date: Mon,  4 Dec 2023 14:03:39 -0600
Message-Id: <20231204200342.7125-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231204200342.7125-1-rpearsonhpe@gmail.com>
References: <20231204200342.7125-1-rpearsonhpe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the rdma_rxe driver does not receive mcast packets at all.

Add code to rxe_mcast_add() and rxe_mcast_del() to register/deregister
the IP mcast address. This is required for mcast traffic to reach the
rxe driver when coming from an external source.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v4:
  ipv6_sock_mc_join/drop() expect caller to hold sk->sk_lock. Added code
  to do this. Fixes a lockdep splat reported by Zhu Yanjun.

 drivers/infiniband/sw/rxe/rxe_mcast.c | 117 +++++++++++++++++++++-----
 drivers/infiniband/sw/rxe/rxe_net.c   |   2 +-
 drivers/infiniband/sw/rxe/rxe_net.h   |   1 +
 drivers/infiniband/sw/rxe/rxe_verbs.h |   1 +
 4 files changed, 100 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 86cc2e18a7fd..40c69642a66c 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -19,38 +19,114 @@
  * mcast packets in the rxe receive path.
  */
 
+#include <linux/igmp.h>
+
 #include "rxe.h"
 
-/**
- * rxe_mcast_add - add multicast address to rxe device
- * @rxe: rxe device object
- * @mgid: multicast address as a gid
- *
- * Returns 0 on success else an error
- */
-static int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid)
+static int rxe_mcast_add6(struct rxe_dev *rxe, union ib_gid *mgid)
 {
+	struct in6_addr *addr6 = (struct in6_addr *)mgid;
+	struct sock *sk = recv_sockets.sk6->sk;
 	unsigned char ll_addr[ETH_ALEN];
+	int err;
+
+	spin_lock_bh(&sk->sk_lock.slock);
+	rtnl_lock();
+	err = ipv6_sock_mc_join(sk, rxe->ndev->ifindex, addr6);
+	rtnl_unlock();
+	spin_unlock_bh(&sk->sk_lock.slock);
+	if (err && err != -EADDRINUSE)
+		goto err_out;
 
 	ipv6_eth_mc_map((struct in6_addr *)mgid->raw, ll_addr);
+	err = dev_mc_add(rxe->ndev, ll_addr);
+	if (err)
+		goto err_drop;
+
+	return 0;
 
-	return dev_mc_add(rxe->ndev, ll_addr);
+err_drop:
+	rtnl_lock();
+	ipv6_sock_mc_drop(recv_sockets.sk6->sk, rxe->ndev->ifindex, addr6);
+	rtnl_unlock();
+err_out:
+	return err;
 }
 
-/**
- * rxe_mcast_del - delete multicast address from rxe device
- * @rxe: rxe device object
- * @mgid: multicast address as a gid
- *
- * Returns 0 on success else an error
- */
-static int rxe_mcast_del(struct rxe_dev *rxe, union ib_gid *mgid)
+static int rxe_mcast_add(struct rxe_mcg *mcg)
 {
+	struct rxe_dev *rxe = mcg->rxe;
+	union ib_gid *mgid = &mcg->mgid;
 	unsigned char ll_addr[ETH_ALEN];
+	struct ip_mreqn imr = {};
+	int err;
+
+	if (mcg->is_ipv6)
+		return rxe_mcast_add6(rxe, mgid);
+
+	imr.imr_multiaddr = *(struct in_addr *)(mgid->raw + 12);
+	imr.imr_ifindex = rxe->ndev->ifindex;
+	rtnl_lock();
+	err = ip_mc_join_group(recv_sockets.sk4->sk, &imr);
+	rtnl_unlock();
+	if (err && err != -EADDRINUSE)
+		goto err_out;
+
+	ip_eth_mc_map(imr.imr_multiaddr.s_addr, ll_addr);
+	err = dev_mc_add(rxe->ndev, ll_addr);
+	if (err)
+		goto err_leave;
+
+	return 0;
+
+err_leave:
+	rtnl_lock();
+	ip_mc_leave_group(recv_sockets.sk4->sk, &imr);
+	rtnl_unlock();
+err_out:
+	return err;
+}
+
+static int rxe_mcast_del6(struct rxe_dev *rxe, union ib_gid *mgid)
+{
+	struct sock *sk = recv_sockets.sk6->sk;
+	unsigned char ll_addr[ETH_ALEN];
+	int err, err2;
 
 	ipv6_eth_mc_map((struct in6_addr *)mgid->raw, ll_addr);
+	err = dev_mc_del(rxe->ndev, ll_addr);
+
+	spin_lock_bh(&sk->sk_lock.slock);
+	rtnl_lock();
+	err2 = ipv6_sock_mc_drop(sk, rxe->ndev->ifindex,
+			(struct in6_addr *)mgid);
+	rtnl_unlock();
+	spin_unlock_bh(&sk->sk_lock.slock);
+
+	return err ?: err2;
+}
+
+static int rxe_mcast_del(struct rxe_mcg *mcg)
+{
+	struct rxe_dev *rxe = mcg->rxe;
+	union ib_gid *mgid = &mcg->mgid;
+	unsigned char ll_addr[ETH_ALEN];
+	struct ip_mreqn imr = {};
+	int err, err2;
+
+	if (mcg->is_ipv6)
+		return rxe_mcast_del6(rxe, mgid);
+
+	imr.imr_multiaddr = *(struct in_addr *)(mgid->raw + 12);
+	imr.imr_ifindex = rxe->ndev->ifindex;
+	ip_eth_mc_map(imr.imr_multiaddr.s_addr, ll_addr);
+	err = dev_mc_del(rxe->ndev, ll_addr);
+
+	rtnl_lock();
+	err2 = ip_mc_leave_group(recv_sockets.sk4->sk, &imr);
+	rtnl_unlock();
 
-	return dev_mc_del(rxe->ndev, ll_addr);
+	return err ?: err2;
 }
 
 /**
@@ -164,6 +240,7 @@ static void __rxe_init_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
 {
 	kref_init(&mcg->ref_cnt);
 	memcpy(&mcg->mgid, mgid, sizeof(mcg->mgid));
+	mcg->is_ipv6 = !ipv6_addr_v4mapped((struct in6_addr *)mgid);
 	INIT_LIST_HEAD(&mcg->qp_list);
 	mcg->rxe = rxe;
 
@@ -225,7 +302,7 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
 	spin_unlock_bh(&rxe->mcg_lock);
 
 	/* add mcast address outside of lock */
-	err = rxe_mcast_add(rxe, mgid);
+	err = rxe_mcast_add(mcg);
 	if (!err)
 		return mcg;
 
@@ -273,7 +350,7 @@ static void __rxe_destroy_mcg(struct rxe_mcg *mcg)
 static void rxe_destroy_mcg(struct rxe_mcg *mcg)
 {
 	/* delete mcast address outside of lock */
-	rxe_mcast_del(mcg->rxe, &mcg->mgid);
+	rxe_mcast_del(mcg);
 
 	spin_lock_bh(&mcg->rxe->mcg_lock);
 	__rxe_destroy_mcg(mcg);
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 58c3f3759bf0..b481f8da2002 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -18,7 +18,7 @@
 #include "rxe_net.h"
 #include "rxe_loc.h"
 
-static struct rxe_recv_sockets recv_sockets;
+struct rxe_recv_sockets recv_sockets;
 
 static struct dst_entry *rxe_find_route4(struct rxe_qp *qp,
 					 struct net_device *ndev,
diff --git a/drivers/infiniband/sw/rxe/rxe_net.h b/drivers/infiniband/sw/rxe/rxe_net.h
index 45d80d00f86b..89cee7d5340f 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.h
+++ b/drivers/infiniband/sw/rxe/rxe_net.h
@@ -15,6 +15,7 @@ struct rxe_recv_sockets {
 	struct socket *sk4;
 	struct socket *sk6;
 };
+extern struct rxe_recv_sockets recv_sockets;
 
 int rxe_net_add(const char *ibdev_name, struct net_device *ndev);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index ccb9d19ffe8a..7be9e6232dd9 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -352,6 +352,7 @@ struct rxe_mcg {
 	atomic_t		qp_num;
 	u32			qkey;
 	u16			pkey;
+	bool			is_ipv6;
 };
 
 struct rxe_mca {
-- 
2.40.1


