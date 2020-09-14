Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23890269428
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Sep 2020 19:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgINRv6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Sep 2020 13:51:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgINL1B (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 14 Sep 2020 07:27:01 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E226B208DB;
        Mon, 14 Sep 2020 11:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600082821;
        bh=BmuHmhGhGepfE3o2F1iMhe93hNrOJgfv15hcQoThuOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R3be7D/z/HZ9xCp1RfWWFiEiL8TNKISEUju4o/pRQGHhWtWNLptsPVkHR3k7A9uuE
         vq9/XB5c7F8uJS4s+JsYI3Sv5/s1uHzg99TI5PLcAwHiQeVL9QHPqGL5Mr6eaAT25/
         Db+dsika7/qy/MxrJls2qH+whSL2eH1ygBuKP74I=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 1/5] RDMA/mlx5: Remove dead check for EAGAIN after alloc_mr_from_cache()
Date:   Mon, 14 Sep 2020 14:26:49 +0300
Message-Id: <20200914112653.345244-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200914112653.345244-1-leon@kernel.org>
References: <20200914112653.345244-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

alloc_mr_from_cache() no longer returns EAGAIN, this is just dead code
now.

Fixes: aad719dcf379 ("RDMA/mlx5: Allow MRs to be created in the cache synchronously")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 4cedcb8c3b31..6e63c0b36872 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1402,10 +1402,8 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	if (order <= mr_cache_max_order(dev) && use_umr) {
 		mr = alloc_mr_from_cache(pd, umem, virt_addr, length, ncont,
 					 page_shift, order, access_flags);
-		if (PTR_ERR(mr) == -EAGAIN) {
-			mlx5_ib_dbg(dev, "cache empty for order %d\n", order);
+		if (IS_ERR(mr))
 			mr = NULL;
-		}
 	} else if (!MLX5_CAP_GEN(dev->mdev, umr_extended_translation_offset)) {
 		if (access_flags & IB_ACCESS_ON_DEMAND) {
 			err = -EINVAL;
-- 
2.26.2

