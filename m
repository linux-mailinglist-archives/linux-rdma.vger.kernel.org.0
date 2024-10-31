Return-Path: <linux-rdma+bounces-5659-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 382C49B799E
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 12:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E535128582E
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 11:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE5719ABC4;
	Thu, 31 Oct 2024 11:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKVZFhDR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39E0198A39
	for <linux-rdma@vger.kernel.org>; Thu, 31 Oct 2024 11:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730373788; cv=none; b=aJ2oA3WTZ6dbKf3jymRZFTYB7h5mIt/7f0n/nTuo8KYPYY8JE0VPPGulmHRvIr8+QmTjccTvq9DEhPDrZzhkpY5YnK1itlrvhbBnuxArO8TtlY1pvhQVyvEaLv0qCjUIlaDczL7RTD3jJKPckM1J6RJ4lK9X7QUz1BLAaapmwrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730373788; c=relaxed/simple;
	bh=KDdgZRia5kujS6lvjeZl+psaLwqGTkLo1U6EJv7NBbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YTe8qEQ3h2AD8mPt4psWyryNnmwlAguGiyhTRy9F48w+IojA+9+OTIKLgrI4TvfmyvnkygPpBp9FlGRf9VdAr7Bz0MKdANhH/E+NVHCHx6cJA4+vLj+15SyqkSl6e5ZLrAxzjaHxIOZxRp8E83Q8GpFNdiMO37KvwedvrZ9G6b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKVZFhDR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5169C4CED6;
	Thu, 31 Oct 2024 11:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730373788;
	bh=KDdgZRia5kujS6lvjeZl+psaLwqGTkLo1U6EJv7NBbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jKVZFhDRWK0abvLMkyaG0b51ylnWsaeGYHGcqoPLfJJGUAm256h7hJ1qL/YZQx8yG
	 7t1rEPr8rlw3wwb9VB+2ycnxZpz1vrbo53hq8fwbFA0sfZVEN6HC1SwiBz2yyVpBkt
	 FuCm7faCyb1SbNSfdOx/31x75FJF3bMuvm2K18/RcwxeuwRk08WWh1Xs8i0F/cjBt5
	 7n8+enWM4x2sF5uSXgdNtAmkQ1gzgyTnvusXS9wxsm8wgq09TJiB0SS1kWLFjIuoTa
	 zVGzzM1VtcWbNtIZoP9Z9kEh6g3omNjy/ir6yNVNnBRwTElIrw/iMOs/hANRzrLQS6
	 OtGPU17zLoW2A==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 3/3] RDMA/mlx5: Add implementation for ufile_hw_cleanup device operation
Date: Thu, 31 Oct 2024 13:22:53 +0200
Message-ID: <2f82675d0412542cba1c47a6b86f589521ae41e1.1730373303.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1730373303.git.leon@kernel.org>
References: <cover.1730373303.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

Implement the device API for ufile_hw_cleanup operation, which
iterates over the ufile uobjects lists, and attempts to destroy
DevX QPs, by issuing up to 8 commands in parallel.

This function is responsible only for cleaning the FW resources of the
QP, and doesn't necessarily cleanup all of its resources.
Hence the normal serialized cleanup flow is still executed after it
in __uverbs_cleanup_ufile() to cleanup the remaining resources and
handle the cleanup of SW objects.

In order to avoid double cleanup for the FW resources, new DevX flag
was added DEVX_OBJ_FLAGS_HW_FREED, which marks the object's FW resources
as already freed.

Since QP destruction is the most time-consuming operation in FW,
parallelizing it reduces the cleanup time of applications that use
DevX QPs.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/devx.c | 93 ++++++++++++++++++++++++++++++-
 drivers/infiniband/hw/mlx5/devx.h |  4 ++
 drivers/infiniband/hw/mlx5/main.c |  1 +
 3 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 5027a39ab1dd..a4a661e533bf 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -27,6 +27,19 @@ enum devx_obj_flags {
 	DEVX_OBJ_FLAGS_INDIRECT_MKEY = 1 << 0,
 	DEVX_OBJ_FLAGS_DCT = 1 << 1,
 	DEVX_OBJ_FLAGS_CQ = 1 << 2,
+	DEVX_OBJ_FLAGS_HW_FREED = 1 << 3,
+};
+
+#define MAX_ASYNC_CMDS 8
+
+struct mlx5_async_cmd {
+	struct ib_uobject *uobject;
+	void *in;
+	int in_size;
+	u32 out[MLX5_ST_SZ_DW(general_obj_out_cmd_hdr)];
+	int err;
+	struct mlx5_async_work cb_work;
+	struct completion comp;
 };
 
 struct devx_async_data {
@@ -1405,7 +1418,9 @@ static int devx_obj_cleanup(struct ib_uobject *uobject,
 		 */
 		mlx5r_deref_wait_odp_mkey(&obj->mkey);
 
-	if (obj->flags & DEVX_OBJ_FLAGS_DCT)
+	if (obj->flags & DEVX_OBJ_FLAGS_HW_FREED)
+		ret = 0;
+	else if (obj->flags & DEVX_OBJ_FLAGS_DCT)
 		ret = mlx5_core_destroy_dct(obj->ib_dev, &obj->core_dct);
 	else if (obj->flags & DEVX_OBJ_FLAGS_CQ)
 		ret = mlx5_core_destroy_cq(obj->ib_dev->mdev, &obj->core_cq);
@@ -2596,6 +2611,82 @@ void mlx5_ib_devx_cleanup(struct mlx5_ib_dev *dev)
 	}
 }
 
+static void devx_async_destroy_cb(int status, struct mlx5_async_work *context)
+{
+	struct mlx5_async_cmd *devx_out = container_of(context,
+					  struct mlx5_async_cmd, cb_work);
+	struct devx_obj *obj = devx_out->uobject->object;
+
+	if (!status)
+		obj->flags |= DEVX_OBJ_FLAGS_HW_FREED;
+
+	complete(&devx_out->comp);
+}
+
+static void devx_async_destroy(struct mlx5_ib_dev *dev,
+			       struct mlx5_async_cmd *cmd)
+{
+	init_completion(&cmd->comp);
+	cmd->err = mlx5_cmd_exec_cb(&dev->async_ctx, cmd->in, cmd->in_size,
+				    &cmd->out, sizeof(cmd->out),
+				    devx_async_destroy_cb, &cmd->cb_work);
+}
+
+static void devx_wait_async_destroy(struct mlx5_async_cmd *cmd)
+{
+	if (!cmd->err)
+		wait_for_completion(&cmd->comp);
+	atomic_set(&cmd->uobject->usecnt, 0);
+}
+
+void mlx5_ib_ufile_hw_cleanup(struct ib_uverbs_file *ufile)
+{
+	struct mlx5_async_cmd async_cmd[MAX_ASYNC_CMDS];
+	struct ib_ucontext *ucontext = ufile->ucontext;
+	struct ib_device *device = ucontext->device;
+	struct mlx5_ib_dev *dev = to_mdev(device);
+	struct ib_uobject *uobject;
+	struct devx_obj *obj;
+	int head = 0;
+	int tail = 0;
+
+	list_for_each_entry(uobject, &ufile->uobjects, list) {
+		WARN_ON(uverbs_try_lock_object(uobject, UVERBS_LOOKUP_WRITE));
+
+		/*
+		 * Currently we only support QP destruction, if other objects
+		 * are to be destroyed need to add type synchronization to the
+		 * cleanup algorithm and handle pre/post FW cleanup for the
+		 * new types if needed.
+		 */
+		if (uobj_get_object_id(uobject) != MLX5_IB_OBJECT_DEVX_OBJ ||
+		    (get_dec_obj_type(uobject->object, MLX5_EVENT_TYPE_MAX) !=
+		     MLX5_OBJ_TYPE_QP)) {
+			atomic_set(&uobject->usecnt, 0);
+			continue;
+		}
+
+		obj = uobject->object;
+
+		async_cmd[tail % MAX_ASYNC_CMDS].in = obj->dinbox;
+		async_cmd[tail % MAX_ASYNC_CMDS].in_size = obj->dinlen;
+		async_cmd[tail % MAX_ASYNC_CMDS].uobject = uobject;
+
+		devx_async_destroy(dev, &async_cmd[tail % MAX_ASYNC_CMDS]);
+		tail++;
+
+		if (tail - head == MAX_ASYNC_CMDS) {
+			devx_wait_async_destroy(&async_cmd[head % MAX_ASYNC_CMDS]);
+			head++;
+		}
+	}
+
+	while (head != tail) {
+		devx_wait_async_destroy(&async_cmd[head % MAX_ASYNC_CMDS]);
+		head++;
+	}
+}
+
 static ssize_t devx_async_cmd_event_read(struct file *filp, char __user *buf,
 					 size_t count, loff_t *pos)
 {
diff --git a/drivers/infiniband/hw/mlx5/devx.h b/drivers/infiniband/hw/mlx5/devx.h
index ee2213275fd6..1344bf4c9d21 100644
--- a/drivers/infiniband/hw/mlx5/devx.h
+++ b/drivers/infiniband/hw/mlx5/devx.h
@@ -28,6 +28,7 @@ int mlx5_ib_devx_create(struct mlx5_ib_dev *dev, bool is_user);
 void mlx5_ib_devx_destroy(struct mlx5_ib_dev *dev, u16 uid);
 int mlx5_ib_devx_init(struct mlx5_ib_dev *dev);
 void mlx5_ib_devx_cleanup(struct mlx5_ib_dev *dev);
+void mlx5_ib_ufile_hw_cleanup(struct ib_uverbs_file *ufile);
 #else
 static inline int mlx5_ib_devx_create(struct mlx5_ib_dev *dev, bool is_user)
 {
@@ -41,5 +42,8 @@ static inline int mlx5_ib_devx_init(struct mlx5_ib_dev *dev)
 static inline void mlx5_ib_devx_cleanup(struct mlx5_ib_dev *dev)
 {
 }
+static inline void mlx5_ib_ufile_hw_cleanup(struct ib_uverbs_file *ufile)
+{
+}
 #endif
 #endif /* _MLX5_IB_DEVX_H */
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 5038c52b79aa..65da5df05d02 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4149,6 +4149,7 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.req_notify_cq = mlx5_ib_arm_cq,
 	.rereg_user_mr = mlx5_ib_rereg_user_mr,
 	.resize_cq = mlx5_ib_resize_cq,
+	.ufile_hw_cleanup = mlx5_ib_ufile_hw_cleanup,
 
 	INIT_RDMA_OBJ_SIZE(ib_ah, mlx5_ib_ah, ibah),
 	INIT_RDMA_OBJ_SIZE(ib_counters, mlx5_ib_mcounters, ibcntrs),
-- 
2.46.2


