Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01EAF11483
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2019 09:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbfEBHsS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 May 2019 03:48:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbfEBHsR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 May 2019 03:48:17 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0CD42133F;
        Thu,  2 May 2019 07:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556783297;
        bh=a+wj9xLzpgrdoYwEbsKi7nP+GrbcTSL4XG+AJdJ5q3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y03cHMfVYFpZSH1e1iGzyiGlYcrrYx0mN8X0ehT6xjNTF5+liSFNNUmHJQvJMF6Fy
         jEcIEVzmhRa1ua2RDo7JNx39N8OgFgV/CysKv789DLWYuQTV351XypN8a/gnzuzbr7
         T/YHJ5LjcA0V0MoYrMj/1gcqhQ2qhEo9DHVZVv0Y=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Huy Nguyen <huyn@mellanox.com>, Martin Wilck <mwilck@suse.com>,
        Parav Pandit <parav@mellanox.com>
Subject: [PATCH rdma-next v2 1/7] RDMA/rxe: Consider skb reserve space based on netdev of GID
Date:   Thu,  2 May 2019 10:48:01 +0300
Message-Id: <20190502074807.26566-2-leon@kernel.org>
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

Always consider the skb reserve space based on netdevice of the GID
attribute, regardless of vlan or non vlan netdevice.

Fixes: 43c9fc509fa5 ("rdma_rxe: make rxe work over 802.1q VLAN devices")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/sw/rxe/rxe_net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index f186b92ba45b..c44139788afc 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -481,8 +481,9 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 	if (unlikely(!skb))
 		goto out;
 
-	skb_reserve(skb, hdr_len + LL_RESERVED_SPACE(rxe->ndev));
+	skb_reserve(skb, hdr_len + LL_RESERVED_SPACE(ndev));
 
+	/* FIXME: hold reference to this netdev until life of this skb. */
 	skb->dev	= ndev;
 	if (av->network_type == RDMA_NETWORK_IPV4)
 		skb->protocol = htons(ETH_P_IP);
-- 
2.20.1

