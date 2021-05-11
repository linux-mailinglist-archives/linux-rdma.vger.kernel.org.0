Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86758379F4D
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 07:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhEKFtp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 01:49:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229925AbhEKFtp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 01:49:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFD4361924;
        Tue, 11 May 2021 05:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620712119;
        bh=OsRPfybbZafM9vgJGAID+qSAxmGOO0Q+WhancS9hDTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g6GlEGwhdoBno/KBb4mtmpsFmpx/nlfHsaCe7vTf1RbeIvdrkMht6omz63XXNgRah
         MbId516zKxcwKSVVTNEqi+YyFUHvBQ17ePDdfIEnH5fWgG4CTOaS6OOduhdMogQSKe
         R9osCeli7IHnHRfBgpEb/YGO29uZ2WCsjR9tBmBz3h9u0bCnmt3HcqK5UGY14gNHUz
         AX+X2q+dd7olMVy8sKnrWX5N/Max4zJtmNrtLIJeOJ7Due+t7I9YQbZvWfbqnPYrZv
         sDnWsPChgHLT+JTUIXnjCDXDwWxrOYZq5WBdbjx4GHNohGHjAs0SxIj3PC3Dpv1dOL
         g+rt+bdxiowiQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-rdma@vger.kernel.org, Shay Drory <shayd@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-rc 1/5] RDMA/mlx5: Verify that DM operation is reasonable
Date:   Tue, 11 May 2021 08:48:27 +0300
Message-Id: <458b1d7710c3cf01360c8771893f483665569786.1620711734.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1620711734.git.leonro@nvidia.com>
References: <cover.1620711734.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@nvidia.com>

Fix the below complain from smatch by verify that DM operation is not
greater than 31.

divers/infiniband/hw/mlx5/dm.c:220 mlx5_ib_handler_MLX5_IB_METHOD_DM_MAP_OP_ADDR()
error: undefined (user controlled) shift '(((1))) << op'

Fixes: cea85fa5dbc2 ("RDMA/mlx5: Add support in MEMIC operations")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/dm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/dm.c b/drivers/infiniband/hw/mlx5/dm.c
index 094bf85589db..001d766cf291 100644
--- a/drivers/infiniband/hw/mlx5/dm.c
+++ b/drivers/infiniband/hw/mlx5/dm.c
@@ -217,6 +217,9 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DM_MAP_OP_ADDR)(
 	if (err)
 		return err;
 
+	if (op >= BITS_PER_TYPE(u32))
+		return -EOPNOTSUPP;
+
 	if (!(MLX5_CAP_DEV_MEM(dev->mdev, memic_operations) & BIT(op)))
 		return -EOPNOTSUPP;
 
-- 
2.31.1

