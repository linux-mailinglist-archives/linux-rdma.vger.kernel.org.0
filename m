Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4462D8D4C
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Dec 2020 14:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394686AbgLMNbO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Dec 2020 08:31:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:54620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394683AbgLMNbG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 13 Dec 2020 08:31:06 -0500
From:   Leon Romanovsky <leon@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc 1/5] RDMA/mlx5: Fix MR cache memory leak
Date:   Sun, 13 Dec 2020 15:29:36 +0200
Message-Id: <20201213132940.345554-2-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201213132940.345554-1-leon@kernel.org>
References: <20201213132940.345554-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@nvidia.com>

If the MR cache entry invalidation failed, then we detach this entry
from the cache, therefore we must to free the memory as well.

  comm "python3", pid 15325, jiffies 4298483783 (age 1787.596s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 40 62 12 f4 82 88 ff ff  ........b……
    00 22 08 00 00 22 08 00 00 00 00 00 00 00 00 00  .“…”……….

  backtrace:

    [<00000000d8e423b0>] alloc_cache_mr+0x23/0xc0 [mlx5_ib]
    [<000000001f21304c>] create_cache_mr+0x3f/0xf0 [mlx5_ib]
    [<000000009d6b45dc>] mlx5_ib_alloc_implicit_mr+0x41/0×210 [mlx5_ib]
    [<00000000879d0d68>] mlx5_ib_reg_user_mr+0x9e/0×6e0 [mlx5_ib]
    [<00000000be74bf89>] create_qp+0x2fc/0xf00 [ib_uverbs]
    [<000000001a532d22>] ib_uverbs_handler_UVERBS_METHOD_COUNTERS_READ+0x1d9/0×230 [ib_uverbs]
    [<0000000070f46001>] rdma_alloc_commit_uobject+0xb5/0×120 [ib_uverbs]
    [<000000006d8a0b38>] uverbs_alloc+0x2b/0xf0 [ib_uverbs]
    [<00000000075217c9>] ksysioctl+0x234/0×7d0
    [<00000000eb5c120b>] __x64_sys_ioctl+0x16/0×20
    [<00000000db135b48>] do_syscall_64+0x59/0×2e0

Fixes: 1769c4c57548 ("RDMA/mlx5: Always remove MRs from the cache before destroying them")
Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 80e3047110a8..479543ebf697 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -644,6 +644,7 @@ void mlx5_mr_cache_free(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 	if (mlx5_mr_cache_invalidate(mr)) {
 		detach_mr_from_cache(mr);
 		destroy_mkey(dev, mr);
+		kfree(mr);
 		return;
 	}

--
2.29.2

