Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8072049ED7E
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jan 2022 22:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344403AbiA0ViI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jan 2022 16:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbiA0ViH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jan 2022 16:38:07 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8C0C061714
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:07 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id s6-20020a0568301e0600b0059ea5472c98so3847610otr.11
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VL/GI+7qpsdeG8zENV6IvqpyCn40bfNnpv7eZSvf4D4=;
        b=LiBvtxj8D/ls5P6rYvV+W6cR7frkdq3sCyopE+eAsVD3pi/sf/og81+0otZ7zktDh9
         VTM86d9DXDj79eTQq4yHeSZX9o2/pSlMzXnJylVpjU50ZGjlFfkNCc/uqNq3GgRYp5j2
         fDf9pFpryMF8IfrDHo1sl8fFF5dw6DVV0+h3eyB2E0OlXIi02wXl7kixuvLP40VpJL8i
         szT/g34cB+DKJlRnP4bxcbbNzdT3cL35vSuF3nK2HX2GL+/SBzOoALdD5OV5RysybhxU
         dshun007zMGNKi8XVF+Y44hXNDkQtxCwd/2iODqgBsMCbj9VoPH+l9UliYbBr5duKcrb
         RhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VL/GI+7qpsdeG8zENV6IvqpyCn40bfNnpv7eZSvf4D4=;
        b=hK3ySqfQCIGB4okt5gS7uRQpnL9ltJbMzCck5I73/QpBbbrxCVHdTGdiDciKjZyNLt
         tzrZROEjhmWVXJbaBc7B91c0HnbdPkjnVnCdQEu3HlI4Xz38DNpNvJ0XvUTfT5v4ptXX
         189U2v5zHPxMELCP0yEVsj/bje+WJjfqQmCnWhY09kXaiGGC/r6Q3GWTNt8oQzuqK5bC
         cwEX58fotD3dJavvUTeYGKmHeKt1Oj4WT3b4PLA9vVVBUVacuHNCkDZxWE64hOQ1JE+8
         Ye9n/yZzje4xDEIBlk0saQC6wiLMrZqLakwpL0AlxOkjXP6l60gRzz6PlclnhYjAKRqU
         oIxw==
X-Gm-Message-State: AOAM530tef2efGxtjwKxqGbBhwk0XI3G4zIYafGRmpR6BQjFiZfS/FHy
        eKL5JZM4G7aVM7V5Xat8SG9tZkl1Md0=
X-Google-Smtp-Source: ABdhPJxg9bGoZDD7kgYFHvsM3FLTtGYSRmmHWcKecYh6wfY4vobrxpTvtkuuO6uofDNub85EqXnZig==
X-Received: by 2002:a05:6830:2708:: with SMTP id j8mr2131903otu.274.1643319486723;
        Thu, 27 Jan 2022 13:38:06 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id v32sm3994677ooj.45.2022.01.27.13.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 13:38:06 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [RFC PATCH v9 01/26] RDMA/rxe: Move rxe_mcast_add/delete to rxe_mcast.c
Date:   Thu, 27 Jan 2022 15:37:30 -0600
Message-Id: <20220127213755.31697-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220127213755.31697-1-rpearsonhpe@gmail.com>
References: <20220127213755.31697-1-rpearsonhpe@gmail.com>
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

