Return-Path: <linux-rdma+bounces-320-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F36809153
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 20:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F22DB20BBC
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 19:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3624F8BA;
	Thu,  7 Dec 2023 19:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erpPWC/C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FC11709;
	Thu,  7 Dec 2023 11:30:19 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-5906c569a1fso484843eaf.1;
        Thu, 07 Dec 2023 11:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701977418; x=1702582218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCo25qT9AtztM6NlEg7BzkQzG2uRIBLOVHP87eaH1kE=;
        b=erpPWC/CktsiZevgUN7TBFNb2j9aycgWXDWiYpG9ITJLj6l+2d7J93Gvb/eUjGIOxT
         N8U6mjS1zO8sGHtipCTDq33d8r8MhnppifhOb9X7okRnsOpgKaXhPQ9eYGL1TakXti9G
         OKMlHE2XBMZf/gBGjXfMgHoKVW9zecWs6DPcIHPEC7peM/kerrKN118xD9/SuYpjBkAa
         XlfR5ZcjO3AMKrIKNQWm/l4mgp7ghAvt7d0iErW1d8HVBjRDshOScnwNkgWTPZ2zTZuK
         ydnZ1BS82ug/06AqpgEmV0PRXd9/aozGSRJLPW5VZA9tQy3ScyL4wlNLcjZc37GIKNAi
         ZLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701977418; x=1702582218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cCo25qT9AtztM6NlEg7BzkQzG2uRIBLOVHP87eaH1kE=;
        b=fUCUvcVYw0N17A2yLjzAiigTcT7quuGydoOFHVNZ9IsZhDEuagS5gez5F3RVXm3zFl
         lGICneU6Q4sujjFROc8hDxDqPkO8ziCTgiVtTkxoC0unAJL1ErTiT7Q6FNas4Wq9kr9y
         uk6waxGLcyuHEXjyWuGoFZZ9Nbun9/K2+bK2UonMkTLuWlqFa4SFCl5dOPsiabjGMDPN
         U8TOokJHW0RV+p8+avN1msgkKOmkSt+m9u/ryBMAFeIXUgDMiKcHxX9bTl9gVHKMeoBZ
         eRPiyfRGs2n3iX1E4qoLncDNj7sGDh2EPxF2PjSFjlW8qyjbAcYKLb+4QWwrwR4gMY3a
         yXLQ==
X-Gm-Message-State: AOJu0Yy2J3xECCdGMTIG7yv5dDb471QcoQChroMuunA0jdV6Z4aM2bU8
	co2A6T00T4QrSRAYWMTWK42TnruXkfY=
X-Google-Smtp-Source: AGHT+IGhBJASZsmYPKpG4D+3+g59MiW5kLirD/JA8XkbLAxYoGEwXgqs9hOVLuf23DdweQppuoN/cg==
X-Received: by 2002:a05:6870:d8d0:b0:1fa:fadc:4d25 with SMTP id of16-20020a056870d8d000b001fafadc4d25mr1555789oac.22.1701977418689;
        Thu, 07 Dec 2023 11:30:18 -0800 (PST)
Received: from bob-3900x.lan (2603-8081-1405-679b-ca1f-53fd-59c8-8b84.res6.spectrum.com. [2603:8081:1405:679b:ca1f:53fd:59c8:8b84])
        by smtp.gmail.com with ESMTPSA id mp23-20020a056871329700b001fb634b546dsm92347oac.14.2023.12.07.11.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 11:30:17 -0800 (PST)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: jgg@nvidia.com,
	yanjun.zhu@linux.dev,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	dsahern@kernel.org,
	rain.1986.08.12@gmail.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v6 3/7] RDMA/rxe: Register IP mcast address
Date: Thu,  7 Dec 2023 13:29:04 -0600
Message-Id: <20231207192907.10113-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231207192907.10113-1-rpearsonhpe@gmail.com>
References: <20231207192907.10113-1-rpearsonhpe@gmail.com>
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
index 86cc2e18a7fd..5236761892dd 100644
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
+	lock_sock(sk);
+	rtnl_lock();
+	err = ipv6_sock_mc_join(sk, rxe->ndev->ifindex, addr6);
+	rtnl_unlock();
+	release_sock(sk);
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
+	lock_sock(sk);
+	rtnl_lock();
+	ipv6_sock_mc_drop(sk, rxe->ndev->ifindex, addr6);
+	rtnl_unlock();
+	release_sock(sk);
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
+	lock_sock(sk);
+	rtnl_lock();
+	err2 = ipv6_sock_mc_drop(sk, rxe->ndev->ifindex,
+			(struct in6_addr *)mgid);
+	rtnl_unlock();
+	release_sock(sk);
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


