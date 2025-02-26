Return-Path: <linux-rdma+bounces-8148-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD96BA45FFB
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 14:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D33E178406
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 13:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238FB21ABDF;
	Wed, 26 Feb 2025 13:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgARJ/11"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D332514B959;
	Wed, 26 Feb 2025 13:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740574903; cv=none; b=SmUk1cOUY57wvKegLba8ajpByIvBu1wbjk0OWNPlftK6U00tpsqkwauPdvpJsd1KA3UJ4y68Q22Wf/aJEngPBQ0NPhDCfcqjSIR012AuW3OWK9LGEznVE0VBGOFSjT2ID25CPUAxyerf6hrLkP6vfltUhNq9+sNNuF4pMQE3984=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740574903; c=relaxed/simple;
	bh=EqbrLsCFTRVDotSbdoxGXMXUvKjNc7bp80vRT9MWbH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJLIqXkYfHHOSZhTmh4qQ1czX3TujnINmltFNwwH1nul/gvTSZHvsgmce1PCwm6MitPexNoACr+KPgAyQWQBdm7QscZe2CzEAWeZf17rxMufA/EnFEXAFGDvhfdMHvc+hYhZSQhIFFSx8R7UHSeYUnglOzKsiXUOUg+ZhgUxDbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgARJ/11; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C343C4CED6;
	Wed, 26 Feb 2025 13:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740574903;
	bh=EqbrLsCFTRVDotSbdoxGXMXUvKjNc7bp80vRT9MWbH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UgARJ/111BcVuYz+b/2KDSeI1B3FNqWBoZkmMXJvpfUs4uwvKxWY9v02yZkfELNu5
	 mIa3sxkw362Qx4JAOa76cGs+s26zCztjJK6HiDdlCgS8NFFPvm+f2DSrusT6qzeFji
	 uVFPH55rfq853FRLem6BfNf9+SGi/7i4Shp3hYQmBBUqgHngBNsiaLYT5ohUH9STDl
	 YCX6fWvRHSltnI+zIExFz5/xMLn95lHoNuhc7epNCu+kuNZW6z2sC6p/6fhTRNQ0Cf
	 fIOYHLkUWWBVCVsDYy4NEo+p0DNYTNmeGWlPBr6O4vmi6qGcQMb2ykmeOhayisSpGe
	 ZFbs1DLse8ptA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Chiara Meiohas <cmeiohas@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	Moshe Shemesh <moshe@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH mlx5-next 3/5] net/mlx5: Limit non-privileged commands
Date: Wed, 26 Feb 2025 15:01:07 +0200
Message-ID: <d2f3dd9a0dbad3c9f2b4bb0723837995e4e06de2.1740574103.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740574103.git.leon@kernel.org>
References: <cover.1740574103.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chiara Meiohas <cmeiohas@nvidia.com>

Limit non-privileged UID commands to half of the available command slots
when privileged UIDs are present.
Privileged throttle commands will not be limited.

Use an xarray to store privileged UIDs. Add insert and remove functions
for privileged UIDs management.

Non-user commands (with uid 0) are not limited.

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 85 +++++++++++++++++--
 include/linux/mlx5/driver.h                   |  5 ++
 2 files changed, 82 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index 19c0c15c7e08..e53dbdc0a7a1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -94,6 +94,11 @@ static u16 in_to_opcode(void *in)
 	return MLX5_GET(mbox_in, in, opcode);
 }
 
+static u16 in_to_uid(void *in)
+{
+	return MLX5_GET(mbox_in, in, uid);
+}
+
 /* Returns true for opcodes that might be triggered very frequently and throttle
  * the command interface. Limit their command slots usage.
  */
@@ -823,7 +828,7 @@ static void cmd_status_print(struct mlx5_core_dev *dev, void *in, void *out)
 
 	opcode = in_to_opcode(in);
 	op_mod = MLX5_GET(mbox_in, in, op_mod);
-	uid    = MLX5_GET(mbox_in, in, uid);
+	uid    = in_to_uid(in);
 	status = MLX5_GET(mbox_out, out, status);
 
 	if (!uid && opcode != MLX5_CMD_OP_DESTROY_MKEY &&
@@ -1871,6 +1876,17 @@ static int is_manage_pages(void *in)
 	return in_to_opcode(in) == MLX5_CMD_OP_MANAGE_PAGES;
 }
 
+static bool mlx5_has_privileged_uid(struct mlx5_core_dev *dev)
+{
+	return !xa_empty(&dev->cmd.vars.privileged_uids);
+}
+
+static bool mlx5_cmd_is_privileged_uid(struct mlx5_core_dev *dev,
+				       u16 uid)
+{
+	return !!xa_load(&dev->cmd.vars.privileged_uids, uid);
+}
+
 /*  Notes:
  *    1. Callback functions may not sleep
  *    2. Page queue commands do not support asynchrous completion
@@ -1882,6 +1898,8 @@ static int cmd_exec(struct mlx5_core_dev *dev, void *in, int in_size, void *out,
 	struct mlx5_cmd_msg *inb, *outb;
 	u16 opcode = in_to_opcode(in);
 	bool throttle_locked = false;
+	bool unpriv_locked = false;
+	u16 uid = in_to_uid(in);
 	int pages_queue;
 	gfp_t gfp;
 	u8 token;
@@ -1894,7 +1912,12 @@ static int cmd_exec(struct mlx5_core_dev *dev, void *in, int in_size, void *out,
 		/* The semaphore is already held for callback commands. It was
 		 * acquired in mlx5_cmd_exec_cb()
 		 */
-		if (mlx5_cmd_is_throttle_opcode(opcode)) {
+		if (uid && mlx5_has_privileged_uid(dev)) {
+			if (!mlx5_cmd_is_privileged_uid(dev, uid)) {
+				unpriv_locked = true;
+				down(&dev->cmd.vars.unprivileged_sem);
+			}
+		} else if (mlx5_cmd_is_throttle_opcode(opcode)) {
 			throttle_locked = true;
 			down(&dev->cmd.vars.throttle_sem);
 		}
@@ -1943,6 +1966,9 @@ static int cmd_exec(struct mlx5_core_dev *dev, void *in, int in_size, void *out,
 out_up:
 	if (throttle_locked)
 		up(&dev->cmd.vars.throttle_sem);
+	if (unpriv_locked)
+		up(&dev->cmd.vars.unprivileged_sem);
+
 	return err;
 }
 
@@ -2105,10 +2131,12 @@ static void mlx5_cmd_exec_cb_handler(int status, void *_work)
 	struct mlx5_async_ctx *ctx;
 	struct mlx5_core_dev *dev;
 	bool throttle_locked;
+	bool unpriv_locked;
 
 	ctx = work->ctx;
 	dev = ctx->dev;
 	throttle_locked = work->throttle_locked;
+	unpriv_locked = work->unpriv_locked;
 	status = cmd_status_err(dev, status, work->opcode, work->op_mod, work->out);
 	work->user_callback(status, work);
 	/* Can't access "work" from this point on. It could have been freed in
@@ -2116,6 +2144,8 @@ static void mlx5_cmd_exec_cb_handler(int status, void *_work)
 	 */
 	if (throttle_locked)
 		up(&dev->cmd.vars.throttle_sem);
+	if (unpriv_locked)
+		up(&dev->cmd.vars.unprivileged_sem);
 	if (atomic_dec_and_test(&ctx->num_inflight))
 		complete(&ctx->inflight_done);
 }
@@ -2124,6 +2154,8 @@ int mlx5_cmd_exec_cb(struct mlx5_async_ctx *ctx, void *in, int in_size,
 		     void *out, int out_size, mlx5_async_cbk_t callback,
 		     struct mlx5_async_work *work)
 {
+	struct mlx5_core_dev *dev = ctx->dev;
+	u16 uid;
 	int ret;
 
 	work->ctx = ctx;
@@ -2132,18 +2164,29 @@ int mlx5_cmd_exec_cb(struct mlx5_async_ctx *ctx, void *in, int in_size,
 	work->op_mod = MLX5_GET(mbox_in, in, op_mod);
 	work->out = out;
 	work->throttle_locked = false;
+	work->unpriv_locked = false;
+	uid = in_to_uid(in);
+
 	if (WARN_ON(!atomic_inc_not_zero(&ctx->num_inflight)))
 		return -EIO;
 
-	if (mlx5_cmd_is_throttle_opcode(in_to_opcode(in))) {
-		if (down_trylock(&ctx->dev->cmd.vars.throttle_sem)) {
+	if (uid && mlx5_has_privileged_uid(dev)) {
+		if (!mlx5_cmd_is_privileged_uid(dev, uid)) {
+			if (down_trylock(&dev->cmd.vars.unprivileged_sem)) {
+				ret = -EBUSY;
+				goto dec_num_inflight;
+			}
+			work->unpriv_locked = true;
+		}
+	} else if (mlx5_cmd_is_throttle_opcode(in_to_opcode(in))) {
+		if (down_trylock(&dev->cmd.vars.throttle_sem)) {
 			ret = -EBUSY;
 			goto dec_num_inflight;
 		}
 		work->throttle_locked = true;
 	}
 
-	ret = cmd_exec(ctx->dev, in, in_size, out, out_size,
+	ret = cmd_exec(dev, in, in_size, out, out_size,
 		       mlx5_cmd_exec_cb_handler, work, false);
 	if (ret)
 		goto sem_up;
@@ -2152,7 +2195,9 @@ int mlx5_cmd_exec_cb(struct mlx5_async_ctx *ctx, void *in, int in_size,
 
 sem_up:
 	if (work->throttle_locked)
-		up(&ctx->dev->cmd.vars.throttle_sem);
+		up(&dev->cmd.vars.throttle_sem);
+	if (work->unpriv_locked)
+		up(&dev->cmd.vars.unprivileged_sem);
 dec_num_inflight:
 	if (atomic_dec_and_test(&ctx->num_inflight))
 		complete(&ctx->inflight_done);
@@ -2390,10 +2435,16 @@ int mlx5_cmd_enable(struct mlx5_core_dev *dev)
 	sema_init(&cmd->vars.sem, cmd->vars.max_reg_cmds);
 	sema_init(&cmd->vars.pages_sem, 1);
 	sema_init(&cmd->vars.throttle_sem, DIV_ROUND_UP(cmd->vars.max_reg_cmds, 2));
+	sema_init(&cmd->vars.unprivileged_sem,
+		  DIV_ROUND_UP(cmd->vars.max_reg_cmds, 2));
+
+	xa_init(&cmd->vars.privileged_uids);
 
 	cmd->pool = dma_pool_create("mlx5_cmd", mlx5_core_dma_dev(dev), size, align, 0);
-	if (!cmd->pool)
-		return -ENOMEM;
+	if (!cmd->pool) {
+		err = -ENOMEM;
+		goto err_destroy_xa;
+	}
 
 	err = alloc_cmd_page(dev, cmd);
 	if (err)
@@ -2427,6 +2478,8 @@ int mlx5_cmd_enable(struct mlx5_core_dev *dev)
 	free_cmd_page(dev, cmd);
 err_free_pool:
 	dma_pool_destroy(cmd->pool);
+err_destroy_xa:
+	xa_destroy(&dev->cmd.vars.privileged_uids);
 	return err;
 }
 
@@ -2439,6 +2492,7 @@ void mlx5_cmd_disable(struct mlx5_core_dev *dev)
 	destroy_msg_cache(dev);
 	free_cmd_page(dev, cmd);
 	dma_pool_destroy(cmd->pool);
+	xa_destroy(&dev->cmd.vars.privileged_uids);
 }
 
 void mlx5_cmd_set_state(struct mlx5_core_dev *dev,
@@ -2446,3 +2500,18 @@ void mlx5_cmd_set_state(struct mlx5_core_dev *dev,
 {
 	dev->cmd.state = cmdif_state;
 }
+
+int mlx5_cmd_add_privileged_uid(struct mlx5_core_dev *dev, u16 uid)
+{
+	return xa_insert(&dev->cmd.vars.privileged_uids, uid,
+			 xa_mk_value(uid), GFP_KERNEL);
+}
+EXPORT_SYMBOL(mlx5_cmd_add_privileged_uid);
+
+void mlx5_cmd_remove_privileged_uid(struct mlx5_core_dev *dev, u16 uid)
+{
+	void *data = xa_erase(&dev->cmd.vars.privileged_uids, uid);
+
+	WARN(!data, "Privileged UID %u does not exist\n", uid);
+}
+EXPORT_SYMBOL(mlx5_cmd_remove_privileged_uid);
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 876d6b03a87a..4f593a61220d 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -305,6 +305,8 @@ struct mlx5_cmd {
 		struct semaphore sem;
 		struct semaphore pages_sem;
 		struct semaphore throttle_sem;
+		struct semaphore unprivileged_sem;
+		struct xarray	privileged_uids;
 	} vars;
 	enum mlx5_cmdif_state	state;
 	void	       *cmd_alloc_buf;
@@ -990,6 +992,7 @@ struct mlx5_async_work {
 	u16 opcode; /* cmd opcode */
 	u16 op_mod; /* cmd op_mod */
 	u8 throttle_locked:1;
+	u8 unpriv_locked:1;
 	void *out; /* pointer to the cmd output buffer */
 };
 
@@ -1020,6 +1023,8 @@ int mlx5_cmd_exec(struct mlx5_core_dev *dev, void *in, int in_size, void *out,
 int mlx5_cmd_exec_polling(struct mlx5_core_dev *dev, void *in, int in_size,
 			  void *out, int out_size);
 bool mlx5_cmd_is_down(struct mlx5_core_dev *dev);
+int mlx5_cmd_add_privileged_uid(struct mlx5_core_dev *dev, u16 uid);
+void mlx5_cmd_remove_privileged_uid(struct mlx5_core_dev *dev, u16 uid);
 
 void mlx5_core_uplink_netdev_set(struct mlx5_core_dev *mdev, struct net_device *netdev);
 void mlx5_core_uplink_netdev_event_replay(struct mlx5_core_dev *mdev);
-- 
2.48.1


