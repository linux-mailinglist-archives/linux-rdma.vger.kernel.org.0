Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44D0192205
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 13:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfHSLR4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 07:17:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbfHSLR4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Aug 2019 07:17:56 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD5292085A;
        Mon, 19 Aug 2019 11:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566213475;
        bh=5p/sOk0LjOpZBCV1zE/qeXyKsy+9zRkTskYbo786Njg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oBM1z88n0ulqbO1jqKa45Tf4M27eoLZnBVdWYI2/vUKwiwI9PPL/PBnZe7uY/A0tP
         zDD8TFZ6FNFCCkyOzVVWfDk84KFLiPko+5R5rUZcG2i/X1OHc4q55mSz6Nfcb6JIk/
         HItcaJuEsGhWiGOpcoch/lgjNxwA0D5+YVdBYu9A=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Guy Levi <guyle@mellanox.com>, Moni Shoua <monis@mellanox.com>
Subject: [PATCH rdma-next 12/12] RDMA/mlx5: Use odp instead of mr->umem in pagefault_mr
Date:   Mon, 19 Aug 2019 14:17:10 +0300
Message-Id: <20190819111710.18440-13-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190819111710.18440-1-leon@kernel.org>
References: <20190819111710.18440-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

These are the same thing since mr always comes from odp->private. It is
confusing to reference the same memory via two names.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 70e0a3555f11..8b155a1f0b38 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -603,7 +603,7 @@ static int pagefault_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr,
 	start_idx = (io_virt - (mr->mmkey.iova & page_mask)) >> page_shift;
 	access_mask = ODP_READ_ALLOWED_BIT;
 
-	if (prefetch && !downgrade && !mr->umem->writable) {
+	if (prefetch && !downgrade && !odp->umem.writable) {
 		/* prefetch with write-access must
 		 * be supported by the MR
 		 */
@@ -611,7 +611,7 @@ static int pagefault_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr,
 		goto out;
 	}
 
-	if (mr->umem->writable && !downgrade)
+	if (odp->umem.writable && !downgrade)
 		access_mask |= ODP_WRITE_ALLOWED_BIT;
 
 	current_seq = READ_ONCE(odp->notifiers_seq);
@@ -621,8 +621,8 @@ static int pagefault_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr,
 	 */
 	smp_rmb();
 
-	ret = ib_umem_odp_map_dma_pages(to_ib_umem_odp(mr->umem), io_virt, size,
-					access_mask, current_seq);
+	ret = ib_umem_odp_map_dma_pages(odp, io_virt, size, access_mask,
+					current_seq);
 
 	if (ret < 0)
 		goto out;
@@ -630,8 +630,7 @@ static int pagefault_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr,
 	np = ret;
 
 	mutex_lock(&odp->umem_mutex);
-	if (!ib_umem_mmu_notifier_retry(to_ib_umem_odp(mr->umem),
-					current_seq)) {
+	if (!ib_umem_mmu_notifier_retry(odp, current_seq)) {
 		/*
 		 * No need to check whether the MTTs really belong to
 		 * this MR, since ib_umem_odp_map_dma_pages already
-- 
2.20.1

