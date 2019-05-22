Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2AC726A5C
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2019 21:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbfEVTAn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 May 2019 15:00:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728533AbfEVTAn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 22 May 2019 15:00:43 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C222520868;
        Wed, 22 May 2019 18:54:52 +0000 (UTC)
Date:   Wed, 22 May 2019 14:54:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] RDMA/mlx5: Use DIV_ROUND_UP_ULL macro to allow 32 bit to
 build
Message-ID: <20190522145450.25ff483d@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


From: Steven Rostedt (VMware) <rostedt@goodmis.org>

When testing 32 bit x86, my build failed with:

  ERROR: "__udivdi3" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!

It appears that a few non-ULL roundup() calls were made, which uses a
normal division against a 64 bit number. This is fine for x86_64, but
on 32 bit x86, it causes the compiler to look for a helper function
__udivdi3, which we do not have in the kernel, and thus fails to build.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
diff --git a/drivers/infiniband/hw/mlx5/cmd.c b/drivers/infiniband/hw/mlx5/cmd.c
index e3ec79b8f7f5..f080df9934e8 100644
--- a/drivers/infiniband/hw/mlx5/cmd.c
+++ b/drivers/infiniband/hw/mlx5/cmd.c
@@ -190,7 +190,7 @@ int mlx5_cmd_alloc_sw_icm(struct mlx5_dm *dm, int type, u64 length,
 			  u16 uid, phys_addr_t *addr, u32 *obj_id)
 {
 	struct mlx5_core_dev *dev = dm->dev;
-	u32 num_blocks = DIV_ROUND_UP(length, MLX5_SW_ICM_BLOCK_SIZE(dev));
+	u32 num_blocks = DIV_ROUND_UP_ULL(length, MLX5_SW_ICM_BLOCK_SIZE(dev));
 	u32 out[MLX5_ST_SZ_DW(general_obj_out_cmd_hdr)] = {};
 	u32 in[MLX5_ST_SZ_DW(create_sw_icm_in)] = {};
 	unsigned long *block_map;
@@ -266,7 +266,7 @@ int mlx5_cmd_dealloc_sw_icm(struct mlx5_dm *dm, int type, u64 length,
 			    u16 uid, phys_addr_t addr, u32 obj_id)
 {
 	struct mlx5_core_dev *dev = dm->dev;
-	u32 num_blocks = DIV_ROUND_UP(length, MLX5_SW_ICM_BLOCK_SIZE(dev));
+	u32 num_blocks = DIV_ROUND_UP_ULL(length, MLX5_SW_ICM_BLOCK_SIZE(dev));
 	u32 out[MLX5_ST_SZ_DW(general_obj_out_cmd_hdr)] = {};
 	u32 in[MLX5_ST_SZ_DW(general_obj_in_cmd_hdr)] = {};
 	unsigned long *block_map;
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index abac70ad5c7c..40d4c5f7ea43 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2344,7 +2344,7 @@ static int handle_alloc_dm_sw_icm(struct ib_ucontext *ctx,
 	/* Allocation size must a multiple of the basic block size
 	 * and a power of 2.
 	 */
-	act_size = roundup(attr->length, MLX5_SW_ICM_BLOCK_SIZE(dm_db->dev));
+	act_size = DIV_ROUND_UP_ULL(attr->length, MLX5_SW_ICM_BLOCK_SIZE(dm_db->dev));
 	act_size = roundup_pow_of_two(act_size);
 
 	dm->size = act_size;
