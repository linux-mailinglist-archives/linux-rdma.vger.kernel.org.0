Return-Path: <linux-rdma+bounces-252-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 613DC804356
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 01:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 836501C20BAA
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 00:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD7C393;
	Tue,  5 Dec 2023 00:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gsk3ZZEw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136A9AC
	for <linux-rdma@vger.kernel.org>; Mon,  4 Dec 2023 16:26:25 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1faf152a1dbso2827166fac.0
        for <linux-rdma@vger.kernel.org>; Mon, 04 Dec 2023 16:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701735984; x=1702340784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VyY4gAFnlXRgWPxP9SMwMMju7nkj3UkGC1u3lDyzCZM=;
        b=Gsk3ZZEw87vjA677ZkxTHY0dJg1H5WgGCKHBcCOG7QED2gilD/t/0MkfyA87pEYdvW
         wY6+4ByUlw6/adjlHPYpMzTq5ITy7eUdLUq5odeoK4DIuczOB6z8xMtLSuam36c1w4gf
         r6/KrHjNXS8hYPOE4GjATORaoA6kIhsrZZvi25Ms5lFQgSozSAVgYgdE67643NazOujl
         Os2Zr0xlqEDnT5bCHBoK9KkBaCE//jMFIfxOIV8wGpA+nWcPHESH08Q7J9WGcvTmsBbK
         PS2O1q+q9hkxEUFoeTmplZx0DTRzOODSOYllq7WfLyarhgnBOLawYnpya+0UdJZhpbpA
         NwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701735984; x=1702340784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VyY4gAFnlXRgWPxP9SMwMMju7nkj3UkGC1u3lDyzCZM=;
        b=QKzDOFJj488mHkHUc1f3OH4E+98a6Tp4Xrced4TZN3+27jsxnGV7KNnB2WWnH+G+cP
         qt7Wn+1Ub4ro8LK40ju/SswVf1f2qzfvThBclebYYrhpLY177dF/sE60tykBn0zpfoEx
         V+vJuugj7HH7B9si78PEBLgWIwO0Gni/8BwkfLYZgfxTkRsA5r5HAZN8Vkcto15jlEgR
         FHsdAS9NWOYaciqEAk/SYUNXadEh565+Bdd9KDWca00P60qJsKkgiGeODclJpZg7iCaV
         kSrSh+wAsAaUJMMEnlqmXcx0ZutGIa2FA+ZJODpcs0HfTAciIWq1PtYNnt+1IV5OTIOK
         gJhg==
X-Gm-Message-State: AOJu0Yw+mf75t8vFvZ2JJd52KkOLR8+hk9NN+Hy2vebYFgrrzo+LqeMT
	efpB5klKo6SkJFEstanEiHE=
X-Google-Smtp-Source: AGHT+IE93HZSVo63t0aN+7n3ld/EEJzR/l4T0BurpalCp5d/MV/kXDj9aUwMvj8rHFjcBE3ya0+EVQ==
X-Received: by 2002:a05:6870:d621:b0:1fb:75b:2fb7 with SMTP id a33-20020a056870d62100b001fb075b2fb7mr5933156oaq.78.1701735984111;
        Mon, 04 Dec 2023 16:26:24 -0800 (PST)
Received: from bob-3900x.lan (2603-8081-1405-679b-e463-fe8f-1aa8-6edb.res6.spectrum.com. [2603:8081:1405:679b:e463:fe8f:1aa8:6edb])
        by smtp.gmail.com with ESMTPSA id se6-20020a05687122c600b001faf09f0899sm2524844oab.24.2023.12.04.16.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 16:26:23 -0800 (PST)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: jgg@nvidia.com,
	yanjun.zhu@linux.dev,
	linux-rdma@vger.kernel.org
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v5 3/7] RDMA/rxe: Register IP mcast address
Date: Mon,  4 Dec 2023 18:26:10 -0600
Message-Id: <20231205002613.10219-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.40.1
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
 drivers/infiniband/sw/rxe/rxe_mcast.c | 119 +++++++++++++++++++++-----
 drivers/infiniband/sw/rxe/rxe_net.c   |   2 +-
 drivers/infiniband/sw/rxe/rxe_net.h   |   1 +
 drivers/infiniband/sw/rxe/rxe_verbs.h |   1 +
 4 files changed, 102 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 86cc2e18a7fd..54735d07cee5 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -19,38 +19,116 @@
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
+	spin_lock_bh(&sk->sk_lock.slock);
+	rtnl_lock();
+	ipv6_sock_mc_drop(sk, rxe->ndev->ifindex, addr6);
+	rtnl_unlock();
+	spin_unlock_bh(&sk->sk_lock.slock);
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
@@ -164,6 +242,7 @@ static void __rxe_init_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
 {
 	kref_init(&mcg->ref_cnt);
 	memcpy(&mcg->mgid, mgid, sizeof(mcg->mgid));
+	mcg->is_ipv6 = !ipv6_addr_v4mapped((struct in6_addr *)mgid);
 	INIT_LIST_HEAD(&mcg->qp_list);
 	mcg->rxe = rxe;
 
@@ -225,7 +304,7 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
 	spin_unlock_bh(&rxe->mcg_lock);
 
 	/* add mcast address outside of lock */
-	err = rxe_mcast_add(rxe, mgid);
+	err = rxe_mcast_add(mcg);
 	if (!err)
 		return mcg;
 
@@ -273,7 +352,7 @@ static void __rxe_destroy_mcg(struct rxe_mcg *mcg)
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


