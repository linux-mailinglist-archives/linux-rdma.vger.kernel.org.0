Return-Path: <linux-rdma+bounces-8149-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED475A45FFF
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 14:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D4A8177BCE
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 13:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BFF21C19B;
	Wed, 26 Feb 2025 13:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cU7SlpPb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E501221C177;
	Wed, 26 Feb 2025 13:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740574909; cv=none; b=m3E7yFXEb/rQ2sPHEMb7nDA5YbakDHxRPkzBWmWCC/pFThZDZv9nQoy6wdMnaTnczTnPYfG6BXdihpjsDdJ83qjs+NRz6w+P1A8FrFaydVdxV1nefPp3Bp4X9FQaLCgw9K2uKSgkGv08t+Wfa1h+SaTgAVQmk96QDrJtHZR/4EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740574909; c=relaxed/simple;
	bh=quP7fx/zgxWVwFd4/AVhRpxYL+EUfx6plsoSV5h1Rhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IozlM2B4YkO22NUkyQC8pki0PRrWt+UPiC6prQqmwldgJwxqtQlDQc/dKqWZJu7mEJIjrMM1m0rmM5OUtyc+99LSjUckSXY6/93U9yd3/LUugL1dXpSGL6++gREHBRjZH2nWRRRvH6PaduqivTRYV8y707jlwkEdoxWIDiIjQ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cU7SlpPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3667C4CEE8;
	Wed, 26 Feb 2025 13:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740574908;
	bh=quP7fx/zgxWVwFd4/AVhRpxYL+EUfx6plsoSV5h1Rhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cU7SlpPbrrLa4IzfQ2uY8G0CNbqhlOicMfle763ixG6Sy10YxAbjJSSSi2dEu+gYK
	 vzIBu/xkhRTsACw7o5aerHFKThMdujYtT2Dj+jXjWIYUK3AK19ihbA2tOw0CCVpJJv
	 rSLQUQt0r4usKc8MF2sMZmCsV+x1Kml2MDRcaD1lmbA2dx3U5z4AU+pOewb+pOamUw
	 NDe3Qr3QUqJ2A8X9aZ8suMhjnFgGKkJvNC9/NwiduWlLiXJvv+1ZXTpCPl5PeISQmC
	 qOn8RJIUL85BxtQBqnaLXO+zQ/8k3FsEeUm5V42Icbo5lWf44sLVb8hr5I1BNvZl8D
	 pEft89BXCjP8w==
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
Subject: [PATCH mlx5-next 2/5] net/mlx5: Allow the throttle mechanism to be more dynamic
Date: Wed, 26 Feb 2025 15:01:06 +0200
Message-ID: <055d975edeb816ac4c0fd1e665c6157d11947d26.1740574103.git.leon@kernel.org>
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

Previously, throttle commands were identified and limited based on
opcode. These commands were limited to half the command slots using a
semaphore, and callback commands checked the opcode to determine
semaphore release.

To allow exceptions, we introduce a variable to indicate when the
throttle lock is held. This allows scenarios where throttle commands
are not limited. Callback functions use this variable to determine
if the throttle semaphore needs to be released.

This patch contains no functional changes. It's a preparation for the
next patch.

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 43 +++++++++++++------
 include/linux/mlx5/driver.h                   |  1 +
 2 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index e733b81e18a2..19c0c15c7e08 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -1881,7 +1881,7 @@ static int cmd_exec(struct mlx5_core_dev *dev, void *in, int in_size, void *out,
 {
 	struct mlx5_cmd_msg *inb, *outb;
 	u16 opcode = in_to_opcode(in);
-	bool throttle_op;
+	bool throttle_locked = false;
 	int pages_queue;
 	gfp_t gfp;
 	u8 token;
@@ -1890,12 +1890,12 @@ static int cmd_exec(struct mlx5_core_dev *dev, void *in, int in_size, void *out,
 	if (mlx5_cmd_is_down(dev) || !opcode_allowed(&dev->cmd, opcode))
 		return -ENXIO;
 
-	throttle_op = mlx5_cmd_is_throttle_opcode(opcode);
-	if (throttle_op) {
-		if (callback) {
-			if (down_trylock(&dev->cmd.vars.throttle_sem))
-				return -EBUSY;
-		} else {
+	if (!callback) {
+		/* The semaphore is already held for callback commands. It was
+		 * acquired in mlx5_cmd_exec_cb()
+		 */
+		if (mlx5_cmd_is_throttle_opcode(opcode)) {
+			throttle_locked = true;
 			down(&dev->cmd.vars.throttle_sem);
 		}
 	}
@@ -1941,7 +1941,7 @@ static int cmd_exec(struct mlx5_core_dev *dev, void *in, int in_size, void *out,
 out_in:
 	free_msg(dev, inb);
 out_up:
-	if (throttle_op)
+	if (throttle_locked)
 		up(&dev->cmd.vars.throttle_sem);
 	return err;
 }
@@ -2104,17 +2104,17 @@ static void mlx5_cmd_exec_cb_handler(int status, void *_work)
 	struct mlx5_async_work *work = _work;
 	struct mlx5_async_ctx *ctx;
 	struct mlx5_core_dev *dev;
-	u16 opcode;
+	bool throttle_locked;
 
 	ctx = work->ctx;
 	dev = ctx->dev;
-	opcode = work->opcode;
+	throttle_locked = work->throttle_locked;
 	status = cmd_status_err(dev, status, work->opcode, work->op_mod, work->out);
 	work->user_callback(status, work);
 	/* Can't access "work" from this point on. It could have been freed in
 	 * the callback.
 	 */
-	if (mlx5_cmd_is_throttle_opcode(opcode))
+	if (throttle_locked)
 		up(&dev->cmd.vars.throttle_sem);
 	if (atomic_dec_and_test(&ctx->num_inflight))
 		complete(&ctx->inflight_done);
@@ -2131,11 +2131,30 @@ int mlx5_cmd_exec_cb(struct mlx5_async_ctx *ctx, void *in, int in_size,
 	work->opcode = in_to_opcode(in);
 	work->op_mod = MLX5_GET(mbox_in, in, op_mod);
 	work->out = out;
+	work->throttle_locked = false;
 	if (WARN_ON(!atomic_inc_not_zero(&ctx->num_inflight)))
 		return -EIO;
+
+	if (mlx5_cmd_is_throttle_opcode(in_to_opcode(in))) {
+		if (down_trylock(&ctx->dev->cmd.vars.throttle_sem)) {
+			ret = -EBUSY;
+			goto dec_num_inflight;
+		}
+		work->throttle_locked = true;
+	}
+
 	ret = cmd_exec(ctx->dev, in, in_size, out, out_size,
 		       mlx5_cmd_exec_cb_handler, work, false);
-	if (ret && atomic_dec_and_test(&ctx->num_inflight))
+	if (ret)
+		goto sem_up;
+
+	return 0;
+
+sem_up:
+	if (work->throttle_locked)
+		up(&ctx->dev->cmd.vars.throttle_sem);
+dec_num_inflight:
+	if (atomic_dec_and_test(&ctx->num_inflight))
 		complete(&ctx->inflight_done);
 
 	return ret;
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index af86097641b0..876d6b03a87a 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -989,6 +989,7 @@ struct mlx5_async_work {
 	mlx5_async_cbk_t user_callback;
 	u16 opcode; /* cmd opcode */
 	u16 op_mod; /* cmd op_mod */
+	u8 throttle_locked:1;
 	void *out; /* pointer to the cmd output buffer */
 };
 
-- 
2.48.1


