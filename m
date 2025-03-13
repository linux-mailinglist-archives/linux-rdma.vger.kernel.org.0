Return-Path: <linux-rdma+bounces-8668-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD732A5F7D4
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 15:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9E319C3909
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 14:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB5C267F5E;
	Thu, 13 Mar 2025 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKhzhcxv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C93613BC3F
	for <linux-rdma@vger.kernel.org>; Thu, 13 Mar 2025 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875622; cv=none; b=BrRmelSpOx1+hV0PxEQemgY+4rVyfxT7XwUWSZVH45G/1wZOfjdu+t8F9yDVmcfUmIrwj2yx0Tj2oq09GaX7uiykzCNPHuKxRjx99fpcmo9mUPHrVtbuZ9QwtrrCNDqUfS/3uWkxxkzmY3QWLhEucKQE5yy5wpl0gNnXHzc3eLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875622; c=relaxed/simple;
	bh=MtCJB5Y3rgMVUXJPyuTvoJV7QtGWk47luedfVkC6WQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=abC1lWaSxOm4K2RlnIFWmHXW8KLcWtJVVsWxh5IsrdjzGZbt7LbiUh/MjeUqF9IzhrQfnbKIjid9aHe6HQme6LyL5AOqw/d/a2T0docdUvHTcfufFk1NmU8hQit0eD1kzn58KhDkl3UNRHrsu8K5ocSfy8g/zSOhhsL4ub/pkz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKhzhcxv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C1CC4CEE5;
	Thu, 13 Mar 2025 14:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741875622;
	bh=MtCJB5Y3rgMVUXJPyuTvoJV7QtGWk47luedfVkC6WQ4=;
	h=From:To:Cc:Subject:Date:From;
	b=IKhzhcxv9jTDklwRaEnLXWx7YB67dBEQcalQDiDIiPXPOf7teV7+2VM09+jrn8VZz
	 jNnpcq7K4Q5T8vjCBpmwFFi3DJUSvqGL5ERXZJ8r6atiqG6ti1f0SG2jnr7YQhB+U8
	 5po4bhxNZeE6RD0dATpGlLskuaryirSPg5DiMepXWNSQET9FvQgbafTvlTaKsbQuPA
	 U0dp2XgZK2HjIS3K/4l2g6cPiKEy8Kxrs+CPolBI1vRfNzXdDY/zz2kX8V7LspsC/C
	 hwdkv7uRzEknUakBSnxaGKX5Gn64L8aoEU5IDVhwtv8KG+TnbKd4Z+TSl8gkbpw2KG
	 BtpSNOtY7ST8Q==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Maher Sanalla <msanalla@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] IB/mad: Check available slots before posting receive WRs
Date: Thu, 13 Mar 2025 16:20:17 +0200
Message-ID: <c4984ba3c3a98a5711a558bccefcad789587ecf1.1741875592.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Maher Sanalla <msanalla@nvidia.com>

The ib_post_receive_mads() function handles posting receive work
requests (WRs) to MAD QPs and is called in two cases:
1) When a MAD port is opened.
2) When a receive WQE is consumed upon receiving a new MAD.

Whereas, if MADs arrive during the port open phase, a race condition
might cause an extra WR to be posted, exceeding the QP’s capacity.
This leads to failures such as:
infiniband mlx5_0: ib_post_recv failed: -12
infiniband mlx5_0: Couldn't post receive WRs
infiniband mlx5_0: Couldn't start port
infiniband mlx5_0: Couldn't open port 1

Fix this by checking the current receive count before posting a new WR.
If the QP’s receive queue is full, do not post additional WRs.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/mad.c | 38 ++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 3dc31640f53a..c089c99ed419 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -2906,11 +2906,11 @@ static int ib_mad_post_receive_mads(struct ib_mad_qp_info *qp_info,
 				    struct ib_mad_private *mad)
 {
 	unsigned long flags;
-	int post, ret;
 	struct ib_mad_private *mad_priv;
 	struct ib_sge sg_list;
 	struct ib_recv_wr recv_wr;
 	struct ib_mad_queue *recv_queue = &qp_info->recv_queue;
+	int ret = 0;
 
 	/* Initialize common scatter list fields */
 	sg_list.lkey = qp_info->port_priv->pd->local_dma_lkey;
@@ -2920,7 +2920,7 @@ static int ib_mad_post_receive_mads(struct ib_mad_qp_info *qp_info,
 	recv_wr.sg_list = &sg_list;
 	recv_wr.num_sge = 1;
 
-	do {
+	while (true) {
 		/* Allocate and map receive buffer */
 		if (mad) {
 			mad_priv = mad;
@@ -2928,10 +2928,8 @@ static int ib_mad_post_receive_mads(struct ib_mad_qp_info *qp_info,
 		} else {
 			mad_priv = alloc_mad_private(port_mad_size(qp_info->port_priv),
 						     GFP_ATOMIC);
-			if (!mad_priv) {
-				ret = -ENOMEM;
-				break;
-			}
+			if (!mad_priv)
+				return -ENOMEM;
 		}
 		sg_list.length = mad_priv_dma_size(mad_priv);
 		sg_list.addr = ib_dma_map_single(qp_info->port_priv->device,
@@ -2940,37 +2938,41 @@ static int ib_mad_post_receive_mads(struct ib_mad_qp_info *qp_info,
 						 DMA_FROM_DEVICE);
 		if (unlikely(ib_dma_mapping_error(qp_info->port_priv->device,
 						  sg_list.addr))) {
-			kfree(mad_priv);
 			ret = -ENOMEM;
-			break;
+			goto free_mad_priv;
 		}
 		mad_priv->header.mapping = sg_list.addr;
 		mad_priv->header.mad_list.mad_queue = recv_queue;
 		mad_priv->header.mad_list.cqe.done = ib_mad_recv_done;
 		recv_wr.wr_cqe = &mad_priv->header.mad_list.cqe;
-
-		/* Post receive WR */
 		spin_lock_irqsave(&recv_queue->lock, flags);
-		post = (++recv_queue->count < recv_queue->max_active);
-		list_add_tail(&mad_priv->header.mad_list.list, &recv_queue->list);
+		if (recv_queue->count >= recv_queue->max_active) {
+			/* Fully populated the receive queue */
+			spin_unlock_irqrestore(&recv_queue->lock, flags);
+			break;
+		}
+		recv_queue->count++;
+		list_add_tail(&mad_priv->header.mad_list.list,
+			      &recv_queue->list);
 		spin_unlock_irqrestore(&recv_queue->lock, flags);
+
 		ret = ib_post_recv(qp_info->qp, &recv_wr, NULL);
 		if (ret) {
 			spin_lock_irqsave(&recv_queue->lock, flags);
 			list_del(&mad_priv->header.mad_list.list);
 			recv_queue->count--;
 			spin_unlock_irqrestore(&recv_queue->lock, flags);
-			ib_dma_unmap_single(qp_info->port_priv->device,
-					    mad_priv->header.mapping,
-					    mad_priv_dma_size(mad_priv),
-					    DMA_FROM_DEVICE);
-			kfree(mad_priv);
 			dev_err(&qp_info->port_priv->device->dev,
 				"ib_post_recv failed: %d\n", ret);
 			break;
 		}
-	} while (post);
+	}
 
+	ib_dma_unmap_single(qp_info->port_priv->device,
+			    mad_priv->header.mapping,
+			    mad_priv_dma_size(mad_priv), DMA_FROM_DEVICE);
+free_mad_priv:
+	kfree(mad_priv);
 	return ret;
 }
 
-- 
2.48.1


