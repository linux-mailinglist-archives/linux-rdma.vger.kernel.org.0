Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 981FF18988E
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 10:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgCRJxR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 05:53:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726786AbgCRJxQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Mar 2020 05:53:16 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFBFA20770;
        Wed, 18 Mar 2020 09:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584525196;
        bh=mP41DDgl9D//RkTC6ZwoAyKvMCCX6ppWI9puM5jyu1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H76KUCij4TuqhxeBQ0FaHA2eHRN8zu2Ye1z0qV3Sgtbv5jFbhaXuU2pK7tnIF1ikK
         zlCFCvSOvIcgQOf4e4iem9YUZSTNto6MO1HIq2E21jzL5X3hLV5blVy5LYeiTHXAoa
         N9Xm9Rit8nLGph7k3u49sAcgoiBqyA69shW5QVZc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Mark Zhang <markz@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next 4/6] RDMA/cma: Initialize the flow label of CM's route path record
Date:   Wed, 18 Mar 2020 11:52:58 +0200
Message-Id: <20200318095300.45574-5-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200318095300.45574-1-leon@kernel.org>
References: <20200318095300.45574-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markz@mellanox.com>

If flow label is not set by the user or it's not IPv4, initialize it with
the cma src/dst based on the "Kernighan and Ritchie's hash function".

Signed-off-by: Mark Zhang <markz@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cma.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index a051cc169e9c..8924b2f8e299 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -2910,6 +2910,24 @@ static int iboe_tos_to_sl(struct net_device *ndev, int tos)
 		return 0;
 }
 
+static __be32 cma_get_roce_udp_flow_label(struct rdma_id_private *id_priv)
+{
+	struct sockaddr_in6 *addr6;
+	u16 dport, sport;
+	u32 hash, fl;
+
+	addr6 = (struct sockaddr_in6 *)cma_src_addr(id_priv);
+	fl = be32_to_cpu(addr6->sin6_flowinfo) & IB_GRH_FLOWLABEL_MASK;
+	if ((cma_family(id_priv) != AF_INET6) || !fl) {
+		dport = be16_to_cpu(cma_port(cma_dst_addr(id_priv)));
+		sport = be16_to_cpu(cma_port(cma_src_addr(id_priv)));
+		hash = (u32)sport * 31 + dport;
+		fl = hash & IB_GRH_FLOWLABEL_MASK;
+	}
+
+	return cpu_to_be32(fl);
+}
+
 static int cma_resolve_iboe_route(struct rdma_id_private *id_priv)
 {
 	struct rdma_route *route = &id_priv->id.route;
@@ -2976,6 +2994,11 @@ static int cma_resolve_iboe_route(struct rdma_id_private *id_priv)
 		goto err2;
 	}
 
+	if (rdma_protocol_roce_udp_encap(id_priv->id.device,
+					 id_priv->id.port_num))
+		route->path_rec->flow_label =
+			cma_get_roce_udp_flow_label(id_priv);
+
 	cma_init_resolve_route_work(work, id_priv);
 	queue_work(cma_wq, &work->work);
 
-- 
2.24.1

