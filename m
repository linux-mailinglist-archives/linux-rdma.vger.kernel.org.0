Return-Path: <linux-rdma+bounces-18830-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aM/ZDGRiy2nCHAYAu9opvQ
	(envelope-from <linux-rdma+bounces-18830-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 07:57:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7461364477
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 07:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33B8C30683A5
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 05:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129AB40DFCA;
	Tue, 31 Mar 2026 05:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8H84but"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C591B28002B;
	Tue, 31 Mar 2026 05:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774936621; cv=none; b=MBcdqDyJXbdbfZgWTy2c+FbBSSCBBMkphi9hFKooGpkMCM1dqRq+85QBc4uAqFZAlq167joTr6UT0oY4xzGVjl1UlYDLYdDNgPKJKmNyxVGq9NsMKegGka4rVXilXvZJ/05NR09YwjjTrohEvlsGdjWk2eQd7jlwBljBIGgjHLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774936621; c=relaxed/simple;
	bh=2sUVXWm6gNzbVe8kaPMIgxN7RRU36ux1iye5UqtO5zY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iCeiQ23xA60bBzs7eblNRcSjI7ZhTakfXCBOHhIk2wJZUn6KFaW7Hynlk6m4fEOVHDMIxwUOhxKIt5T5gIj4u5gnyoJpxU0n8FyQHGpJbROAjAqSLSVVS6kxQNCmPlYQT0zBXXx9tBtWQAfK+3TnTDyUWYHwm5UfHZ7X0yW4Bf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8H84but; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21EFC2BCB2;
	Tue, 31 Mar 2026 05:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774936621;
	bh=2sUVXWm6gNzbVe8kaPMIgxN7RRU36ux1iye5UqtO5zY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b8H84butCoPCRLEFvp8G0bCPS9e/YZqXvfcgpLlYxU8v0Q2hb9g2cQrGUEBxjOoQK
	 v6kqvevV2I22huT1MSDikjrDpi5lN2aUjU6u8nXblALEoExcZ6ZHZQzm/hhkJP0v8a
	 SHIncaR3H+a0IZAhk5WMueCzUUAbmG7xxZWDhoUQM0tUMF1/O6B1voDl5ozOnX0yJW
	 xWj4mIK/thjVdMF2aOVCQBZ2DrXI+hDa/CKniLrY9v6PDuasX8RlU6vwC1XjOiCSc/
	 /YkcC7XHb+oMDBNtxMkpyh6MuutaDDJn7rcsh2BKn8cX6N5A1pWheExXoiLMujfqBX
	 Y27YV0xzQmHWg==
From: Leon Romanovsky <leon@kernel.org>
To: KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Chiara Meiohas <cmeiohas@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 3/4] RDMA/mlx5: Externally validate FW commands supplied in DEVX interface
Date: Tue, 31 Mar 2026 08:56:35 +0300
Message-ID: <20260331-fw-lsm-hook-v2-3-78504703df1f@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331-fw-lsm-hook-v2-0-78504703df1f@nvidia.com>
References: <20260331-fw-lsm-hook-v2-0-78504703df1f@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18830-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,google.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,ziepe.ca,nvidia.com,intel.com,huawei.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,huawei.com:email,nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7461364477
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chiara Meiohas <cmeiohas@nvidia.com>

DEVX is an RDMA uverbs extension that allows userspace to submit
firmware command buffers. The driver inspects the command and then
passes the buffer through for firmware execution.

Call bpf_lsm_fw_validate_cmd() before dispatching firmware commands
through DEVX.

This allows BPF programs to implement custom policies and enforce
per-command security policy on user-triggered firmware commands.
For example, a BPF program could restrict specific firmware
operations to privileged users.

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/devx.c | 49 +++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 0066b2738ac89..b7a2e19987018 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -18,6 +18,7 @@
 #include "devx.h"
 #include "qp.h"
 #include <linux/xarray.h>
+#include <linux/bpf_lsm.h>
 
 #define UVERBS_MODULE_NAME mlx5_ib
 #include <rdma/uverbs_named_ioctl.h>
@@ -1111,6 +1112,8 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OTHER)(
 	struct mlx5_ib_dev *dev;
 	void *cmd_in = uverbs_attr_get_alloced_ptr(
 		attrs, MLX5_IB_ATTR_DEVX_OTHER_CMD_IN);
+	int cmd_in_len = uverbs_attr_get_len(attrs,
+					MLX5_IB_ATTR_DEVX_OTHER_CMD_IN);
 	int cmd_out_len = uverbs_attr_get_len(attrs,
 					MLX5_IB_ATTR_DEVX_OTHER_CMD_OUT);
 	void *cmd_out;
@@ -1135,9 +1138,12 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OTHER)(
 		return PTR_ERR(cmd_out);
 
 	MLX5_SET(general_obj_in_cmd_hdr, cmd_in, uid, uid);
-	err = mlx5_cmd_do(dev->mdev, cmd_in,
-			  uverbs_attr_get_len(attrs, MLX5_IB_ATTR_DEVX_OTHER_CMD_IN),
-			  cmd_out, cmd_out_len);
+	err = bpf_lsm_fw_validate_cmd(cmd_in, cmd_in_len, &dev->ib_dev.dev,
+				      FW_CMD_CLASS_UVERBS, RDMA_DRIVER_MLX5);
+	if (err)
+		return err;
+
+	err = mlx5_cmd_do(dev->mdev, cmd_in, cmd_in_len, cmd_out, cmd_out_len);
 	if (err && err != -EREMOTEIO)
 		return err;
 
@@ -1570,6 +1576,11 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_CREATE)(
 		devx_set_umem_valid(cmd_in);
 	}
 
+	err = bpf_lsm_fw_validate_cmd(cmd_in, cmd_in_len, &dev->ib_dev.dev,
+				      FW_CMD_CLASS_UVERBS, RDMA_DRIVER_MLX5);
+	if (err)
+		goto obj_free;
+
 	if (opcode == MLX5_CMD_OP_CREATE_DCT) {
 		obj->flags |= DEVX_OBJ_FLAGS_DCT;
 		err = mlx5_core_create_dct(dev, &obj->core_dct, cmd_in,
@@ -1646,6 +1657,8 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_MODIFY)(
 	struct uverbs_attr_bundle *attrs)
 {
 	void *cmd_in = uverbs_attr_get_alloced_ptr(attrs, MLX5_IB_ATTR_DEVX_OBJ_MODIFY_CMD_IN);
+	int cmd_in_len = uverbs_attr_get_len(attrs,
+					MLX5_IB_ATTR_DEVX_OBJ_MODIFY_CMD_IN);
 	int cmd_out_len = uverbs_attr_get_len(attrs,
 					MLX5_IB_ATTR_DEVX_OBJ_MODIFY_CMD_OUT);
 	struct ib_uobject *uobj = uverbs_attr_get_uobject(attrs,
@@ -1676,10 +1689,12 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_MODIFY)(
 
 	MLX5_SET(general_obj_in_cmd_hdr, cmd_in, uid, uid);
 	devx_set_umem_valid(cmd_in);
+	err = bpf_lsm_fw_validate_cmd(cmd_in, cmd_in_len, &mdev->ib_dev.dev,
+				      FW_CMD_CLASS_UVERBS, RDMA_DRIVER_MLX5);
+	if (err)
+		return err;
 
-	err = mlx5_cmd_do(mdev->mdev, cmd_in,
-			  uverbs_attr_get_len(attrs, MLX5_IB_ATTR_DEVX_OBJ_MODIFY_CMD_IN),
-			  cmd_out, cmd_out_len);
+	err = mlx5_cmd_do(mdev->mdev, cmd_in, cmd_in_len, cmd_out, cmd_out_len);
 	if (err && err != -EREMOTEIO)
 		return err;
 
@@ -1693,6 +1708,8 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_QUERY)(
 	struct uverbs_attr_bundle *attrs)
 {
 	void *cmd_in = uverbs_attr_get_alloced_ptr(attrs, MLX5_IB_ATTR_DEVX_OBJ_QUERY_CMD_IN);
+	int cmd_in_len = uverbs_attr_get_len(attrs,
+					     MLX5_IB_ATTR_DEVX_OBJ_QUERY_CMD_IN);
 	int cmd_out_len = uverbs_attr_get_len(attrs,
 					      MLX5_IB_ATTR_DEVX_OBJ_QUERY_CMD_OUT);
 	struct ib_uobject *uobj = uverbs_attr_get_uobject(attrs,
@@ -1722,9 +1739,12 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_QUERY)(
 		return PTR_ERR(cmd_out);
 
 	MLX5_SET(general_obj_in_cmd_hdr, cmd_in, uid, uid);
-	err = mlx5_cmd_do(mdev->mdev, cmd_in,
-			  uverbs_attr_get_len(attrs, MLX5_IB_ATTR_DEVX_OBJ_QUERY_CMD_IN),
-			  cmd_out, cmd_out_len);
+	err = bpf_lsm_fw_validate_cmd(cmd_in, cmd_in_len, &mdev->ib_dev.dev,
+				      FW_CMD_CLASS_UVERBS, RDMA_DRIVER_MLX5);
+	if (err)
+		return err;
+
+	err = mlx5_cmd_do(mdev->mdev, cmd_in, cmd_in_len, cmd_out, cmd_out_len);
 	if (err && err != -EREMOTEIO)
 		return err;
 
@@ -1832,6 +1852,8 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_ASYNC_QUERY)(
 {
 	void *cmd_in = uverbs_attr_get_alloced_ptr(attrs,
 				MLX5_IB_ATTR_DEVX_OBJ_QUERY_ASYNC_CMD_IN);
+	int cmd_in_len = uverbs_attr_get_len(attrs,
+				MLX5_IB_ATTR_DEVX_OBJ_QUERY_ASYNC_CMD_IN);
 	struct ib_uobject *uobj = uverbs_attr_get_uobject(
 				attrs,
 				MLX5_IB_ATTR_DEVX_OBJ_QUERY_ASYNC_HANDLE);
@@ -1894,9 +1916,12 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_ASYNC_QUERY)(
 	async_data->ev_file = ev_file;
 
 	MLX5_SET(general_obj_in_cmd_hdr, cmd_in, uid, uid);
-	err = mlx5_cmd_exec_cb(&ev_file->async_ctx, cmd_in,
-		    uverbs_attr_get_len(attrs,
-				MLX5_IB_ATTR_DEVX_OBJ_QUERY_ASYNC_CMD_IN),
+	err = bpf_lsm_fw_validate_cmd(cmd_in, cmd_in_len, &mdev->ib_dev.dev,
+				      FW_CMD_CLASS_UVERBS, RDMA_DRIVER_MLX5);
+	if (err)
+		goto free_async;
+
+	err = mlx5_cmd_exec_cb(&ev_file->async_ctx, cmd_in, cmd_in_len,
 		    async_data->hdr.out_data,
 		    async_data->cmd_out_len,
 		    devx_query_callback, &async_data->cb_work);

-- 
2.53.0


