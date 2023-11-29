Return-Path: <linux-rdma+bounces-146-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF057FE0F9
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Nov 2023 21:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFEEA1C209DD
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Nov 2023 20:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC8360ECE;
	Wed, 29 Nov 2023 20:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3hlblOT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B2D10E0
	for <linux-rdma@vger.kernel.org>; Wed, 29 Nov 2023 12:26:28 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-58d4968c362so143533eaf.0
        for <linux-rdma@vger.kernel.org>; Wed, 29 Nov 2023 12:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701289588; x=1701894388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddedcRRBLiVSLexUYYT8YVATiw9+52DOaOKUt89pFfs=;
        b=W3hlblOT/l+jWNMNOvuQxIzysSw3qD0L/hs1QV5F8DtM6s9P3JZJRvSmBBqWvQMzpS
         yrBleIAKO3ueT4XBkDU3t/OAPORSSz3abX8L6nHT2gx0iHmKYadzCUEHHwMjlzxdXfvI
         eLmN80q8Y26e555uluMof04SES/oUFGGIVq0WnydtqMiY2WpVscIAWJ3xic/VSsr8obm
         PFjMrE5qOmHDGBJQvCfqh15/P5fPPnE6pSDd7pQ1egu7K03Ki4LVWJrCNGCw1fwu6IWy
         F3dmG6XVJtaCRK5vcZvPcLHH4syvoL/6R+7SqUrGCYq4DjJflAKnyv0tOaqxS8SsJphx
         aANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701289588; x=1701894388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddedcRRBLiVSLexUYYT8YVATiw9+52DOaOKUt89pFfs=;
        b=YNuGmGO/CELaBxpcZossCNLm82AHwpJC4gpNvyFCPcbTk8WBXpVTw84PEJvXmcLf2G
         5zgpsPYYm5hlnbjHQosqEtzb29TSEDbu5fhK9JX57Yhf2b4gHdrpNrZH/6IHi3kGy2su
         ksTQrsAirLrXGyl3waCEEV8Qz/TpXyW7a4ozp4W1lzDHHp4dCvmVtGin7ZbWdXg/Cnog
         rqJF8XNgas5wZz6ekTh36O3wYgaTa7M0t7ElY0BtTlKbKpu1FHlUg/WHDNZ/7CY9MDAL
         jNcCkUzNHSiaLSexpN/wqdXIO9wQ3t/pcMu/SL3Yece4GCkrWcbtKpugsvlKiuZZlraZ
         bN6Q==
X-Gm-Message-State: AOJu0Yzr3W7i4/1s+g44txqQlruVWhL+EZMXn6QwTkRtjajsX/9KeZ2P
	Str6Z9QFBq9JdF3J9Rjg6Z8=
X-Google-Smtp-Source: AGHT+IHyGBy+8BZxOhgZn9F7G546DWaz+rzN4c50R1H8AwVJDRVj19mQOryviTrvsiC9ckTJ1n+LQw==
X-Received: by 2002:a05:6820:294:b0:58d:c250:cb1d with SMTP id q20-20020a056820029400b0058dc250cb1dmr4053416ood.2.1701289587870;
        Wed, 29 Nov 2023 12:26:27 -0800 (PST)
Received: from bob-3900x.lan (2603-8081-1405-679b-6755-34f8-2ed3-56ec.res6.spectrum.com. [2603:8081:1405:679b:6755:34f8:2ed3:56ec])
        by smtp.gmail.com with ESMTPSA id 126-20020a4a0684000000b0058ab906ae38sm2473867ooj.2.2023.11.29.12.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 12:26:27 -0800 (PST)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: jgg@nvidia.com,
	yanjun.zhu@linux.dev,
	linux-rdma@vger.kernel.org
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 3/7] RDMA/rxe: Register IP mcast address
Date: Wed, 29 Nov 2023 14:25:55 -0600
Message-Id: <20231129202558.31682-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231129202558.31682-1-rpearsonhpe@gmail.com>
References: <20231129202558.31682-1-rpearsonhpe@gmail.com>
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
 drivers/infiniband/sw/rxe/rxe_mcast.c | 112 +++++++++++++++++++++-----
 drivers/infiniband/sw/rxe/rxe_net.c   |   2 +-
 drivers/infiniband/sw/rxe/rxe_net.h   |   1 +
 drivers/infiniband/sw/rxe/rxe_verbs.h |   1 +
 4 files changed, 95 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 86cc2e18a7fd..a6575381878d 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -19,38 +19,109 @@
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
 	unsigned char ll_addr[ETH_ALEN];
+	int err;
+
+	rtnl_lock();
+	err = ipv6_sock_mc_join(recv_sockets.sk6->sk, rxe->ndev->ifindex,
+				addr6);
+	rtnl_unlock();
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
+	unsigned char ll_addr[ETH_ALEN];
+	int err, err2;
 
 	ipv6_eth_mc_map((struct in6_addr *)mgid->raw, ll_addr);
+	err = dev_mc_del(rxe->ndev, ll_addr);
+
+	rtnl_lock();
+	err2 = ipv6_sock_mc_drop(recv_sockets.sk6->sk,
+			rxe->ndev->ifindex, (struct in6_addr *)mgid);
+	rtnl_unlock();
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
@@ -164,6 +235,7 @@ static void __rxe_init_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
 {
 	kref_init(&mcg->ref_cnt);
 	memcpy(&mcg->mgid, mgid, sizeof(mcg->mgid));
+	mcg->is_ipv6 = !ipv6_addr_v4mapped((struct in6_addr *)mgid);
 	INIT_LIST_HEAD(&mcg->qp_list);
 	mcg->rxe = rxe;
 
@@ -225,7 +297,7 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
 	spin_unlock_bh(&rxe->mcg_lock);
 
 	/* add mcast address outside of lock */
-	err = rxe_mcast_add(rxe, mgid);
+	err = rxe_mcast_add(mcg);
 	if (!err)
 		return mcg;
 
@@ -273,7 +345,7 @@ static void __rxe_destroy_mcg(struct rxe_mcg *mcg)
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


