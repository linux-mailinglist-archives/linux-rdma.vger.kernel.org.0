Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8881148A
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2019 09:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfEBHsi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 May 2019 03:48:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbfEBHsi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 May 2019 03:48:38 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17E762089E;
        Thu,  2 May 2019 07:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556783317;
        bh=cpulIAq2C09taoQjJ6DLf2Yihnie5ie6Kuh9HCkuL64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sGY8Thutn3CHZawd0t8ZyHeD0beZu31NRlujNuzanI42W4cwnCOeL0uA8yU1hRfGV
         vdb+R5ATu+5PvJkHenV++kpHE00TnPsSvfWfTSQiyav7V5VDm0SzRdhpTzOtYviYjv
         hbNSqe3a5SzSH6Sjwg13iiQguTrB24LgkOqRVs58=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Huy Nguyen <huyn@mellanox.com>, Martin Wilck <mwilck@suse.com>,
        Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-next v2 5/7] RDMA/rxe: Use rdma_read_gid_attr_ndev_rcu to access netdev
Date:   Thu,  2 May 2019 10:48:05 +0300
Message-Id: <20190502074807.26566-6-leon@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502074807.26566-1-leon@kernel.org>
References: <20190502074807.26566-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@mellanox.com>

Use rdma_read_gid_attr_ndev_rcu() to access netdevice attached to GID
entry under rcu lock.

This ensures that while working on the netdevice of the GID, it doesn't
get freed.

Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/sw/rxe/rxe_net.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index c44139788afc..5a3474f9351b 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -458,7 +458,7 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 				int paylen, struct rxe_pkt_info *pkt)
 {
 	unsigned int hdr_len;
-	struct sk_buff *skb;
+	struct sk_buff *skb = NULL;
 	struct net_device *ndev;
 	const struct ib_gid_attr *attr;
 	const int port_num = 1;
@@ -466,7 +466,6 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 	attr = rdma_get_gid_attr(&rxe->ib_dev, port_num, av->grh.sgid_index);
 	if (IS_ERR(attr))
 		return NULL;
-	ndev = attr->ndev;
 
 	if (av->network_type == RDMA_NETWORK_IPV4)
 		hdr_len = ETH_HLEN + sizeof(struct udphdr) +
@@ -475,16 +474,26 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 		hdr_len = ETH_HLEN + sizeof(struct udphdr) +
 			sizeof(struct ipv6hdr);
 
+	rcu_read_lock();
+	ndev = rdma_read_gid_attr_ndev_rcu(attr);
+	if (IS_ERR(ndev)) {
+		rcu_read_unlock();
+		goto out;
+	}
 	skb = alloc_skb(paylen + hdr_len + LL_RESERVED_SPACE(ndev),
 			GFP_ATOMIC);
 
-	if (unlikely(!skb))
+	if (unlikely(!skb)) {
+		rcu_read_unlock();
 		goto out;
+	}
 
 	skb_reserve(skb, hdr_len + LL_RESERVED_SPACE(ndev));
 
 	/* FIXME: hold reference to this netdev until life of this skb. */
 	skb->dev	= ndev;
+	rcu_read_unlock();
+
 	if (av->network_type == RDMA_NETWORK_IPV4)
 		skb->protocol = htons(ETH_P_IP);
 	else
-- 
2.20.1

