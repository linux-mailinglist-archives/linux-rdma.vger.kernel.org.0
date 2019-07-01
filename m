Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACE823218
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 13:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732590AbfETLTE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 07:19:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:33964 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730640AbfETLTE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 May 2019 07:19:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CEF1EAEF1;
        Mon, 20 May 2019 11:19:02 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 7104DE0184; Mon, 20 May 2019 13:19:02 +0200 (CEST)
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH] mlx5: avoid 64-bit division
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Ariel Levkovich <lariel@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <20190520111902.7104DE0184@unicorn.suse.cz>
Date:   Mon, 20 May 2019 13:19:02 +0200 (CEST)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Commit 25c13324d03d ("IB/mlx5: Add steering SW ICM device memory type")
breaks i386 build by introducing three 64-bit divisions. As the divisor
is MLX5_SW_ICM_BLOCK_SIZE() which is always a power of 2, we can replace
the division with bit operations.

Fixes: 25c13324d03d ("IB/mlx5: Add steering SW ICM device memory type")
Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 drivers/infiniband/hw/mlx5/cmd.c  | 9 +++++++--
 drivers/infiniband/hw/mlx5/main.c | 2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cmd.c b/drivers/infiniband/hw/mlx5/cmd.c
index e3ec79b8f7f5..6c8645033102 100644
--- a/drivers/infiniband/hw/mlx5/cmd.c
+++ b/drivers/infiniband/hw/mlx5/cmd.c
@@ -190,12 +190,12 @@ int mlx5_cmd_alloc_sw_icm(struct mlx5_dm *dm, int type, u64 length,
 			  u16 uid, phys_addr_t *addr, u32 *obj_id)
 {
 	struct mlx5_core_dev *dev = dm->dev;
-	u32 num_blocks = DIV_ROUND_UP(length, MLX5_SW_ICM_BLOCK_SIZE(dev));
 	u32 out[MLX5_ST_SZ_DW(general_obj_out_cmd_hdr)] = {};
 	u32 in[MLX5_ST_SZ_DW(create_sw_icm_in)] = {};
 	unsigned long *block_map;
 	u64 icm_start_addr;
 	u32 log_icm_size;
+	u32 num_blocks;
 	u32 max_blocks;
 	u64 block_idx;
 	void *sw_icm;
@@ -224,6 +224,8 @@ int mlx5_cmd_alloc_sw_icm(struct mlx5_dm *dm, int type, u64 length,
 		return -EINVAL;
 	}
 
+	num_blocks = (length + MLX5_SW_ICM_BLOCK_SIZE(dev) - 1) >>
+		     MLX5_LOG_SW_ICM_BLOCK_SIZE(dev);
 	max_blocks = BIT(log_icm_size - MLX5_LOG_SW_ICM_BLOCK_SIZE(dev));
 	spin_lock(&dm->lock);
 	block_idx = bitmap_find_next_zero_area(block_map,
@@ -266,13 +268,16 @@ int mlx5_cmd_dealloc_sw_icm(struct mlx5_dm *dm, int type, u64 length,
 			    u16 uid, phys_addr_t addr, u32 obj_id)
 {
 	struct mlx5_core_dev *dev = dm->dev;
-	u32 num_blocks = DIV_ROUND_UP(length, MLX5_SW_ICM_BLOCK_SIZE(dev));
 	u32 out[MLX5_ST_SZ_DW(general_obj_out_cmd_hdr)] = {};
 	u32 in[MLX5_ST_SZ_DW(general_obj_in_cmd_hdr)] = {};
 	unsigned long *block_map;
+	u32 num_blocks;
 	u64 start_idx;
 	int err;
 
+	num_blocks = (length + MLX5_SW_ICM_BLOCK_SIZE(dev) - 1) >>
+		     MLX5_LOG_SW_ICM_BLOCK_SIZE(dev);
+
 	switch (type) {
 	case MLX5_IB_UAPI_DM_TYPE_STEERING_SW_ICM:
 		start_idx =
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index abac70ad5c7c..340290b883fe 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2344,7 +2344,7 @@ static int handle_alloc_dm_sw_icm(struct ib_ucontext *ctx,
 	/* Allocation size must a multiple of the basic block size
 	 * and a power of 2.
 	 */
-	act_size = roundup(attr->length, MLX5_SW_ICM_BLOCK_SIZE(dm_db->dev));
+	act_size = round_up(attr->length, MLX5_SW_ICM_BLOCK_SIZE(dm_db->dev));
 	act_size = roundup_pow_of_two(act_size);
 
 	dm->size = act_size;
-- 
2.21.0

