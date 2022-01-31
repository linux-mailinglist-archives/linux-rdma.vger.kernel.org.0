Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FF44A5211
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jan 2022 23:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiAaWKG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jan 2022 17:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbiAaWKG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jan 2022 17:10:06 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB38FC061714
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 14:10:05 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id q14-20020a05683022ce00b005a6162a1620so1663773otc.0
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 14:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VL/GI+7qpsdeG8zENV6IvqpyCn40bfNnpv7eZSvf4D4=;
        b=G3Ic6T6FHsiQleosjRUQVrXLjw1ukTSDfNrvC/JaaExLCGGcA35add8yjwlbo+BDBv
         skYpA7ylRl4fJ2e1TMfmo1GDq6fQCNeaPA6jvhgfFHqxzhgSYYTyiaxzzChaLNt1EXDm
         trv5XOrAVpEQ5tKCHMtTuce2QS8FawwL8PHla8wONmYMeItyNkFnLZIvCJKZ+kk5jOR2
         ODq3E3yTcG6jx/vmBXvoy/OEzIQ5GnFmo7Ghrp8QlyHsGBk3z+WJ7+7dcwQNvnbxeujt
         X4EnSBLQaXUiOBpqfdajr1sqPJnU42t2bt8L7IjeUpcIVAwRAo5ZEalTKZJ2A/D/xwVD
         iZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VL/GI+7qpsdeG8zENV6IvqpyCn40bfNnpv7eZSvf4D4=;
        b=8BOqEdjb6uCrVwEJTuZW1CwVj9k5tQbzmJmwF7pAy/4rjVHgLkNJ5/EGJHnQsxq/fo
         L/z/zb/FNppWr2xqxAa4UQRtuOFjMzuPHOTVMRNAtgoGjcKlkM9rGZILYYNX3bji5t41
         5SNiTiw5HuQ+paIELhhXZX4heqYL5mSnT9jt8AkawEgpH4BBSGMzf3h6uvDh3ZfD0bND
         W/BoS7Y+jR0hFKOO2nvo5QsKhQeQ08FHYiSpMwh6P1fd0XAIjX0ldQG5X0HvplampxRA
         UObo4SPfpXjnzhe4jjfNxLcYKUqvX1qjOnVlf+/Zonf4jzVZAmOIMmmBcLriE/DIXfuR
         F/IQ==
X-Gm-Message-State: AOAM532oa0jOmpEWZpKkUGHD7Z/KispBQ4Wi2EK4MKZ9h5cg3wNGkX6C
        X8JwZBtI9DGv5HCAWE2YXBpkPub9WRk=
X-Google-Smtp-Source: ABdhPJymwHTOT9A27Rg9jkYjfE8xP2Dq7qJUu/i0caDiH1r2fjXizK29hVwwDPxKSwpuneLsXwKd6Q==
X-Received: by 2002:a9d:6e0f:: with SMTP id e15mr11968294otr.103.1643667004979;
        Mon, 31 Jan 2022 14:10:04 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-5c63-4cee-84ac-42bc.res6.spectrum.com. [2603:8081:140c:1a00:5c63:4cee:84ac:42bc])
        by smtp.googlemail.com with ESMTPSA id t21sm8304929otq.81.2022.01.31.14.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:10:04 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v10 01/17] RDMA/rxe: Move rxe_mcast_add/delete to rxe_mcast.c
Date:   Mon, 31 Jan 2022 16:08:34 -0600
Message-Id: <20220131220849.10170-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220131220849.10170-1-rpearsonhpe@gmail.com>
References: <20220131220849.10170-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Move rxe_mcast_add and rxe_mcast_delete from rxe_net.c to rxe_mcast.c,
make static and remove declarations from rxe_loc.h.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_loc.h   |  2 --
 drivers/infiniband/sw/rxe/rxe_mcast.c | 18 ++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_net.c   | 18 ------------------
 3 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index b1e174afb1d4..bcec33c3c3b7 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -106,8 +106,6 @@ int rxe_prepare(struct rxe_pkt_info *pkt, struct sk_buff *skb);
 int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 		    struct sk_buff *skb);
 const char *rxe_parent_name(struct rxe_dev *rxe, unsigned int port_num);
-int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid);
-int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid);
 
 /* rxe_qp.c */
 int rxe_qp_chk_init(struct rxe_dev *rxe, struct ib_qp_init_attr *init);
diff --git a/drivers/infiniband/sw/rxe/rxe_mcast.c b/drivers/infiniband/sw/rxe/rxe_mcast.c
index bd1ac88b8700..e5689c161984 100644
--- a/drivers/infiniband/sw/rxe/rxe_mcast.c
+++ b/drivers/infiniband/sw/rxe/rxe_mcast.c
@@ -7,6 +7,24 @@
 #include "rxe.h"
 #include "rxe_loc.h"
 
+static int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid)
+{
+	unsigned char ll_addr[ETH_ALEN];
+
+	ipv6_eth_mc_map((struct in6_addr *)mgid->raw, ll_addr);
+
+	return dev_mc_add(rxe->ndev, ll_addr);
+}
+
+static int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid)
+{
+	unsigned char ll_addr[ETH_ALEN];
+
+	ipv6_eth_mc_map((struct in6_addr *)mgid->raw, ll_addr);
+
+	return dev_mc_del(rxe->ndev, ll_addr);
+}
+
 /* caller should hold mc_grp_pool->pool_lock */
 static struct rxe_mc_grp *create_grp(struct rxe_dev *rxe,
 				     struct rxe_pool *pool,
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index be72bdbfb4ba..a8cfa7160478 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -20,24 +20,6 @@
 
 static struct rxe_recv_sockets recv_sockets;
 
-int rxe_mcast_add(struct rxe_dev *rxe, union ib_gid *mgid)
-{
-	unsigned char ll_addr[ETH_ALEN];
-
-	ipv6_eth_mc_map((struct in6_addr *)mgid->raw, ll_addr);
-
-	return dev_mc_add(rxe->ndev, ll_addr);
-}
-
-int rxe_mcast_delete(struct rxe_dev *rxe, union ib_gid *mgid)
-{
-	unsigned char ll_addr[ETH_ALEN];
-
-	ipv6_eth_mc_map((struct in6_addr *)mgid->raw, ll_addr);
-
-	return dev_mc_del(rxe->ndev, ll_addr);
-}
-
 static struct dst_entry *rxe_find_route4(struct net_device *ndev,
 				  struct in_addr *saddr,
 				  struct in_addr *daddr)
-- 
2.32.0

