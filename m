Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 830AD27E3A
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2019 15:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbfEWNgE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 May 2019 09:36:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730028AbfEWNgE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 May 2019 09:36:04 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B17DD20863;
        Thu, 23 May 2019 13:36:02 +0000 (UTC)
Date:   Thu, 23 May 2019 09:36:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] RDMA/mlx5: Use DIV_ROUND_UP_ULL macro to allow 32 bit
 to build
Message-ID: <20190523093601.39c7dcf2@gandalf.local.home>
In-Reply-To: <20190523084812.325454f6@gandalf.local.home>
References: <20190522145450.25ff483d@gandalf.local.home>
        <20190523065803.GB30439@unicorn.suse.cz>
        <20190523084812.325454f6@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 23 May 2019 08:48:12 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I think I'll go and just add a roundup_64()!

Perhaps something like this?

diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index 34a998012bf6..cdacfe1f732c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -143,14 +143,6 @@ nouveau_bo_del_ttm(struct ttm_buffer_object *bo)
 	kfree(nvbo);
 }
 
-static inline u64
-roundup_64(u64 x, u32 y)
-{
-	x += y - 1;
-	do_div(x, y);
-	return x * y;
-}
-
 static void
 nouveau_bo_fixup_align(struct nouveau_bo *nvbo, u32 flags,
 		       int *align, u64 *size)
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
index abac70ad5c7c..2d48c0e55ed2 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2344,7 +2344,7 @@ static int handle_alloc_dm_sw_icm(struct ib_ucontext *ctx,
 	/* Allocation size must a multiple of the basic block size
 	 * and a power of 2.
 	 */
-	act_size = roundup(attr->length, MLX5_SW_ICM_BLOCK_SIZE(dm_db->dev));
+	act_size = roundup_64(attr->length, MLX5_SW_ICM_BLOCK_SIZE(dm_db->dev));
 	act_size = roundup_pow_of_two(act_size);
 
 	dm->size = act_size;
diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
index edbd5a210df2..13de9d49bd52 100644
--- a/fs/xfs/xfs_linux.h
+++ b/fs/xfs/xfs_linux.h
@@ -207,13 +207,6 @@ static inline xfs_dev_t linux_to_xfs_dev_t(dev_t dev)
 #define xfs_sort(a,n,s,fn)	sort(a,n,s,fn,NULL)
 #define xfs_stack_trace()	dump_stack()
 
-static inline uint64_t roundup_64(uint64_t x, uint32_t y)
-{
-	x += y - 1;
-	do_div(x, y);
-	return x * y;
-}
-
 static inline uint64_t howmany_64(uint64_t x, uint32_t y)
 {
 	x += y - 1;
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 74b1ee9027f5..cd0063629357 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -115,6 +115,20 @@
 	(((x) + (__y - 1)) / __y) * __y;		\
 }							\
 )
+
+#if BITS_PER_LONG == 32
+# define roundup_64(x, y) (				\
+{							\
+	typeof(y) __y = y;				\
+	typeof(x) __x = (x) + (__y - 1);		\
+	do_div(__x, __y);				\
+	__x * __y;					\
+}							\
+)
+#else
+# define roundup_64(x, y)	roundup(x, y)
+#endif
+
 /**
  * rounddown - round down to next specified multiple
  * @x: the value to round


-- Steve
