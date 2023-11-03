Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71137E0A75
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Nov 2023 21:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjKCUoI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Nov 2023 16:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjKCUoH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Nov 2023 16:44:07 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB12DD55
        for <linux-rdma@vger.kernel.org>; Fri,  3 Nov 2023 13:44:03 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-5875c300becso1312028eaf.0
        for <linux-rdma@vger.kernel.org>; Fri, 03 Nov 2023 13:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699044242; x=1699649042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onyBDs2hKF+yBSOnXMmcCbSkYhsJtvSRzOBTKUXR9Rc=;
        b=Bhqz58YtnP7ugginGBOgCSHcIesoTFPZPqdba583blR5dkdRYKoKTlnDrXtKXUNpIR
         9CU2dC5G9T4uoX5+Eh9Z2itwM9wtEjyCaAgwAg4DSSUM18EUppOfAv9YoQKaMRL8PxmV
         0LQzjOQf6bJArnrciO7TdlVdHlz/1D2fbOOApghN32kUKejXPiPwrGqXX9VuJKhpqDR2
         eTk+GTEs4alxFu6rrmqxktsMBLKTkVAujlg0Ex3/+awbVaqr/Piz+ncETZxlBzexYXvo
         rWTlCZIGzG6J0EkfQ8AZAKgvvCJJRNVxaNJtghsatiMkwT9lamIV991AGp8HXS2xMT8L
         Bk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699044242; x=1699649042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=onyBDs2hKF+yBSOnXMmcCbSkYhsJtvSRzOBTKUXR9Rc=;
        b=dxq8obXHEeqFxIFwHa/GjhIXsXvEKuQmDwvXVzQcjE/N45Yf+i586iRyZOMfTDRjaX
         5lLxyQPtO6yud6/5skQU0u6u3uWKrDVyyqpzrYT1IKfz2zG22tiKN3zUvF+lcukJrLdj
         OVpidT3Qm7Ft1Mq10sijJkZ0yk+1+zZdc8PXzJGqj+YEIxt7b1tS+AOfOFpdi4w5CFTo
         i9/gJHZXssVTyxKBWGFOjIiWM/2TheDVL5Cko2RHo4J9OmWP3STXa76fnDvpC3sfHRLM
         Rd21EzlFMXhSBbUTa+5xJyFwq0maqZ38ZXVgZx4lgVrooc2CTCq25+UDxMmVke5/5yT1
         +kgQ==
X-Gm-Message-State: AOJu0Yy9zs7K49q4ZemKie4yLbJO5Ew7d22QLWXfgPFwpMcvmu91rV4K
        i8lfZixduGPQaGy/4UtAKcQ=
X-Google-Smtp-Source: AGHT+IFN5Bm8xE6tc6MYKiRN+Dwn4Qm9Y7oyOp6a4wBqihBaxCUY6IYnoy8UMU7xuofiapME0p6w7Q==
X-Received: by 2002:a05:6820:200e:b0:57b:469d:8af6 with SMTP id by14-20020a056820200e00b0057b469d8af6mr24767736oob.4.1699044241358;
        Fri, 03 Nov 2023 13:44:01 -0700 (PDT)
Received: from bob-3900x.lan (2603-8081-1405-679b-6bc0-11b9-c519-2c18.res6.spectrum.com. [2603:8081:1405:679b:6bc0:11b9:c519:2c18])
        by smtp.gmail.com with ESMTPSA id v9-20020a4ae049000000b00581e5b78ce5sm447766oos.38.2023.11.03.13.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 13:44:00 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, yanjun.zhu@linux.dev, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 3/6] RDMA/rxe: Register IP mcast address
Date:   Fri,  3 Nov 2023 15:43:22 -0500
Message-Id: <20231103204324.9606-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231103204324.9606-1-rpearsonhpe@gmail.com>
References: <20231103204324.9606-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add code to rxe_mcast_add() and rxe_mcast_del() to register/deregister
the IP multicast address. This is required for multicast traffic to
reach the rxe driver.

Fixes: 6090a0c4c7c6 ("RDMA/rxe: Cleanup rxe_mcast.c")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mcast.c | 110 +++++++++++++++++++++-----
 drivers/infiniband/sw/rxe/rxe_net.c   |   2 +-
 drivers/infiniband/sw/rxe/rxe_net.h   |   1 +
 drivers/infiniband/sw/rxe/rxe_verbs.h |   1 +
 4 files changed, 93 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index 86cc2e18a7fd..ec757b955979 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -19,38 +19,107 @@
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
+/* register mcast IP and MAC addresses with net stack */
+static int rxe_mcast_add6(struct rxe_dev *rxe, union ib_gid *mgid)
 {
 	unsigned char ll_addr[ETH_ALEN];
+	struct in6_addr *addr6 = (struct in6_addr *)mgid;
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
+	ipv6_sock_mc_drop(recv_sockets.sk6->sk, rxe->ndev->ifindex, addr6);
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
+	struct ip_mreqn imr = {};
 	unsigned char ll_addr[ETH_ALEN];
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
+	ip_mc_leave_group(recv_sockets.sk4->sk, &imr);
+err_out:
+	return err;
+}
+
+/* deregister mcast IP and MAC addresses with net stack */
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
+	struct ip_mreqn imr = {};
+	unsigned char ll_addr[ETH_ALEN];
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
@@ -164,6 +233,7 @@ static void __rxe_init_mcg(struct rxe_dev *rxe, union ib_gid *mgid,
 {
 	kref_init(&mcg->ref_cnt);
 	memcpy(&mcg->mgid, mgid, sizeof(mcg->mgid));
+	mcg->is_ipv6 = !ipv6_addr_v4mapped((struct in6_addr *)mgid);
 	INIT_LIST_HEAD(&mcg->qp_list);
 	mcg->rxe = rxe;
 
@@ -225,7 +295,7 @@ static struct rxe_mcg *rxe_get_mcg(struct rxe_dev *rxe, union ib_gid *mgid)
 	spin_unlock_bh(&rxe->mcg_lock);
 
 	/* add mcast address outside of lock */
-	err = rxe_mcast_add(rxe, mgid);
+	err = rxe_mcast_add(mcg);
 	if (!err)
 		return mcg;
 
@@ -273,7 +343,7 @@ static void __rxe_destroy_mcg(struct rxe_mcg *mcg)
 static void rxe_destroy_mcg(struct rxe_mcg *mcg)
 {
 	/* delete mcast address outside of lock */
-	rxe_mcast_del(mcg->rxe, &mcg->mgid);
+	rxe_mcast_del(mcg);
 
 	spin_lock_bh(&mcg->rxe->mcg_lock);
 	__rxe_destroy_mcg(mcg);
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 2fad56fc95e7..36617d07fddf 100644
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

