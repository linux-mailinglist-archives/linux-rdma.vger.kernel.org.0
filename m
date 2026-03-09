Return-Path: <linux-rdma+bounces-17775-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEA+FCGsrmntHQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17775-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 12:16:49 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF83237BB2
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 12:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4718B303D67D
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 11:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0760139B4A1;
	Mon,  9 Mar 2026 11:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cd4Qu2Qq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B962339B49B;
	Mon,  9 Mar 2026 11:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773054938; cv=none; b=mV2RxSo8T0JKaQ8whSxnAkD4FCwgPGElHwmUjr9wRfJHSujW9eNesiCnXxk5CVyoonBmDufEHJyWFjISGEz2Z4I1gZ7wuQJNUMaqjscrk3ZFho0nqFRCu/0xxDj5EkTGfsQnfs9uq0An9f/L8SL0eMFX45SjMzWrJRLH3rCL/rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773054938; c=relaxed/simple;
	bh=S9SXkqh0jZ7DCmptgsdJJmECrldsV8hZlxHrOWU+6z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ruMzdpjI4D7K9FWMYmYwswO0i8WvMpeInDivLdNeYkNnooZf/PV1VcMfHQ+l5HS9pDLu+B7FrL2nWIZtgOFAACPNgmEf6vGk7GXh4hQPiyyCSIlJWQVZ/QH2/ZbYYRkregxXiXlIIJREy+FzCKrhJc05gntuEQfHEVlRQ1Vfe/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cd4Qu2Qq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B29C2BC9E;
	Mon,  9 Mar 2026 11:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773054938;
	bh=S9SXkqh0jZ7DCmptgsdJJmECrldsV8hZlxHrOWU+6z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cd4Qu2QqjEqBHUxJwEfd4MdQNLC916btCHsFgwudmCHTwOhxr7WM2kbIW9CHHb7Pf
	 8y6IuTYcP5J6f6F9sT5ZPzqfyhUZ5ZLsOMML00bJSHkFcbIRzXamIs87K3o1cBf43Y
	 D8NUmZ+4H4p046FUix3j90wLBQUAbdwuS1TsLPf1MmKXekjZJ6Vie6htBDgGTBgtRl
	 OsX+y5jep5QB7IOUPorCfVCCwCuIO7/RB1XIggsjVJCxl28VxoFOrDzU1dMVbebVj7
	 7ENNt+j/+0/N7faguaNaPHBORK19rAOS0/hVgO/SidOlbvfuJ569yJU9Ks7wYjM1nz
	 RvpkDSd+YDhYw==
From: Leon Romanovsky <leon@kernel.org>
To: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Chiara Meiohas <cmeiohas@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>
Subject: [PATCH 2/3] RDMA/mlx5: Invoke fw_validate_cmd LSM hook for DEVX commands
Date: Mon,  9 Mar 2026 13:15:19 +0200
Message-ID: <20260309-fw-lsm-hook-v1-2-4a6422e63725@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309-fw-lsm-hook-v1-0-4a6422e63725@nvidia.com>
References: <20260309-fw-lsm-hook-v1-0-4a6422e63725@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BBF83237BB2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17775-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.920];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Chiara Meiohas <cmeiohas@nvidia.com>

DEVX is an RDMA uverbs extension that allows userspace to submit
firmware command buffers. The driver inspects the command and then
passes the buffer through for firmware execution.

Call security_fw_validate_cmd() before dispatching firmware commands
through DEVX.

This allows security modules to implement custom policies and
enforce per-command security policy on user-triggered firmware
commands. For example, a BPF LSM program could restrict specific
firmware operations to privileged users.

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/devx.c | 52 ++++++++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 0066b2738ac89..48a2c4b4ad4eb 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -18,6 +18,7 @@
 #include "devx.h"
 #include "qp.h"
 #include <linux/xarray.h>
+#include <linux/security.h>
 
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
+	err = security_fw_validate_cmd(cmd_in, cmd_in_len, &dev->ib_dev.dev,
+				       FW_CMD_CLASS_UVERBS, RDMA_DRIVER_MLX5);
+	if (err)
+		return err;
+
+	err = mlx5_cmd_do(dev->mdev, cmd_in, cmd_in_len, cmd_out, cmd_out_len);
 	if (err && err != -EREMOTEIO)
 		return err;
 
@@ -1570,6 +1576,12 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_CREATE)(
 		devx_set_umem_valid(cmd_in);
 	}
 
+	err = security_fw_validate_cmd(cmd_in, cmd_in_len,
+				       &dev->ib_dev.dev,
+				       FW_CMD_CLASS_UVERBS, RDMA_DRIVER_MLX5);
+	if (err)
+		goto obj_free;
+
 	if (opcode == MLX5_CMD_OP_CREATE_DCT) {
 		obj->flags |= DEVX_OBJ_FLAGS_DCT;
 		err = mlx5_core_create_dct(dev, &obj->core_dct, cmd_in,
@@ -1582,8 +1594,8 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_CREATE)(
 				     cmd_in, cmd_in_len, cmd_out,
 				     cmd_out_len);
 	} else {
-		err = mlx5_cmd_do(dev->mdev, cmd_in, cmd_in_len,
-				  cmd_out, cmd_out_len);
+		err = mlx5_cmd_do(dev->mdev, cmd_in, cmd_in_len, cmd_out,
+				  cmd_out_len);
 	}
 
 	if (err == -EREMOTEIO)
@@ -1646,6 +1658,8 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_MODIFY)(
 	struct uverbs_attr_bundle *attrs)
 {
 	void *cmd_in = uverbs_attr_get_alloced_ptr(attrs, MLX5_IB_ATTR_DEVX_OBJ_MODIFY_CMD_IN);
+	int cmd_in_len = uverbs_attr_get_len(attrs,
+					MLX5_IB_ATTR_DEVX_OBJ_MODIFY_CMD_IN);
 	int cmd_out_len = uverbs_attr_get_len(attrs,
 					MLX5_IB_ATTR_DEVX_OBJ_MODIFY_CMD_OUT);
 	struct ib_uobject *uobj = uverbs_attr_get_uobject(attrs,
@@ -1676,9 +1690,12 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_MODIFY)(
 
 	MLX5_SET(general_obj_in_cmd_hdr, cmd_in, uid, uid);
 	devx_set_umem_valid(cmd_in);
+	err = security_fw_validate_cmd(cmd_in, cmd_in_len, &mdev->ib_dev.dev,
+				       FW_CMD_CLASS_UVERBS, RDMA_DRIVER_MLX5);
+	if (err)
+		return err;
 
-	err = mlx5_cmd_do(mdev->mdev, cmd_in,
-			  uverbs_attr_get_len(attrs, MLX5_IB_ATTR_DEVX_OBJ_MODIFY_CMD_IN),
+	err = mlx5_cmd_do(mdev->mdev, cmd_in, cmd_in_len,
 			  cmd_out, cmd_out_len);
 	if (err && err != -EREMOTEIO)
 		return err;
@@ -1693,6 +1710,8 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_QUERY)(
 	struct uverbs_attr_bundle *attrs)
 {
 	void *cmd_in = uverbs_attr_get_alloced_ptr(attrs, MLX5_IB_ATTR_DEVX_OBJ_QUERY_CMD_IN);
+	int cmd_in_len = uverbs_attr_get_len(attrs,
+					     MLX5_IB_ATTR_DEVX_OBJ_QUERY_CMD_IN);
 	int cmd_out_len = uverbs_attr_get_len(attrs,
 					      MLX5_IB_ATTR_DEVX_OBJ_QUERY_CMD_OUT);
 	struct ib_uobject *uobj = uverbs_attr_get_uobject(attrs,
@@ -1722,8 +1741,12 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_QUERY)(
 		return PTR_ERR(cmd_out);
 
 	MLX5_SET(general_obj_in_cmd_hdr, cmd_in, uid, uid);
-	err = mlx5_cmd_do(mdev->mdev, cmd_in,
-			  uverbs_attr_get_len(attrs, MLX5_IB_ATTR_DEVX_OBJ_QUERY_CMD_IN),
+	err = security_fw_validate_cmd(cmd_in, cmd_in_len, &mdev->ib_dev.dev,
+				       FW_CMD_CLASS_UVERBS, RDMA_DRIVER_MLX5);
+	if (err)
+		return err;
+
+	err = mlx5_cmd_do(mdev->mdev, cmd_in, cmd_in_len,
 			  cmd_out, cmd_out_len);
 	if (err && err != -EREMOTEIO)
 		return err;
@@ -1832,6 +1855,8 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_ASYNC_QUERY)(
 {
 	void *cmd_in = uverbs_attr_get_alloced_ptr(attrs,
 				MLX5_IB_ATTR_DEVX_OBJ_QUERY_ASYNC_CMD_IN);
+	int cmd_in_len = uverbs_attr_get_len(attrs,
+				MLX5_IB_ATTR_DEVX_OBJ_QUERY_ASYNC_CMD_IN);
 	struct ib_uobject *uobj = uverbs_attr_get_uobject(
 				attrs,
 				MLX5_IB_ATTR_DEVX_OBJ_QUERY_ASYNC_HANDLE);
@@ -1894,9 +1919,12 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_ASYNC_QUERY)(
 	async_data->ev_file = ev_file;
 
 	MLX5_SET(general_obj_in_cmd_hdr, cmd_in, uid, uid);
-	err = mlx5_cmd_exec_cb(&ev_file->async_ctx, cmd_in,
-		    uverbs_attr_get_len(attrs,
-				MLX5_IB_ATTR_DEVX_OBJ_QUERY_ASYNC_CMD_IN),
+	err = security_fw_validate_cmd(cmd_in, cmd_in_len, &mdev->ib_dev.dev,
+				       FW_CMD_CLASS_UVERBS, RDMA_DRIVER_MLX5);
+	if (err)
+		goto free_async;
+
+	err = mlx5_cmd_exec_cb(&ev_file->async_ctx, cmd_in, cmd_in_len,
 		    async_data->hdr.out_data,
 		    async_data->cmd_out_len,
 		    devx_query_callback, &async_data->cb_work);

-- 
2.53.0


