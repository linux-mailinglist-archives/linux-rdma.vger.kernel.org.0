Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BD11C6979
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 08:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgEFGzZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 02:55:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbgEFGzY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 May 2020 02:55:24 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC3F3206F9;
        Wed,  6 May 2020 06:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588748122;
        bh=I3mzCazUB5Zm9uvHdo5X2O6/3cATw5J3lN5Qw8Rav/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wL8Kl5wA+TuZaIAiiqU8RzL5ZYmRONdXyRLDOshyNprxhkar8EL3RGi4ZjId7HpBA
         +KvjWmvE4eqtQ60D5IV63k5KKLqDQpke128apJbFOdCK/lMQCEOS6tZG3m0+Nq/NKP
         POhXemQtQsyeV6oQZrbMVznE/eV/gTK7zJgV2Yno=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 1/3] RDMA/mlx5: Update mlx5_ib to use new cmd interface
Date:   Wed,  6 May 2020 09:55:11 +0300
Message-Id: <20200506065513.4668-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200506065513.4668-1-leon@kernel.org>
References: <20200506065513.4668-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Reuse newly introduced mlx5_cmd_exec_in() and mlx5_cmd_exec_inout()
to reduce code duplication in mlx5_ib module.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/cmd.c     | 114 ++++++++------------------
 drivers/infiniband/hw/mlx5/cmd.h     |   4 +-
 drivers/infiniband/hw/mlx5/cong.c    |   4 +-
 drivers/infiniband/hw/mlx5/main.c    |   5 +-
 drivers/infiniband/hw/mlx5/odp.c     |   5 +-
 drivers/infiniband/hw/mlx5/srq_cmd.c | 115 ++++++++++++---------------
 6 files changed, 91 insertions(+), 156 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cmd.c b/drivers/infiniband/hw/mlx5/cmd.c
index a2fcbc49131e..cc24c711e92a 100644
--- a/drivers/infiniband/hw/mlx5/cmd.c
+++ b/drivers/infiniband/hw/mlx5/cmd.c
@@ -1,46 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
- * Copyright (c) 2017, Mellanox Technologies. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *      - Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *
- *      - Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
+ * Copyright (c) 2017-2020, Mellanox Technologies inc. All rights reserved.
  */
 
 #include "cmd.h"
 
 int mlx5_cmd_dump_fill_mkey(struct mlx5_core_dev *dev, u32 *mkey)
 {
-	u32 out[MLX5_ST_SZ_DW(query_special_contexts_out)] = {0};
-	u32 in[MLX5_ST_SZ_DW(query_special_contexts_in)]   = {0};
+	u32 out[MLX5_ST_SZ_DW(query_special_contexts_out)] = {};
+	u32 in[MLX5_ST_SZ_DW(query_special_contexts_in)] = {};
 	int err;
 
 	MLX5_SET(query_special_contexts_in, in, opcode,
 		 MLX5_CMD_OP_QUERY_SPECIAL_CONTEXTS);
-	err = mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+	err = mlx5_cmd_exec_inout(dev, query_special_contexts, in, out);
 	if (!err)
 		*mkey = MLX5_GET(query_special_contexts_out, out,
 				 dump_fill_mkey);
@@ -50,12 +23,12 @@ int mlx5_cmd_dump_fill_mkey(struct mlx5_core_dev *dev, u32 *mkey)
 int mlx5_cmd_null_mkey(struct mlx5_core_dev *dev, u32 *null_mkey)
 {
 	u32 out[MLX5_ST_SZ_DW(query_special_contexts_out)] = {};
-	u32 in[MLX5_ST_SZ_DW(query_special_contexts_in)]   = {};
+	u32 in[MLX5_ST_SZ_DW(query_special_contexts_in)] = {};
 	int err;
 
 	MLX5_SET(query_special_contexts_in, in, opcode,
 		 MLX5_CMD_OP_QUERY_SPECIAL_CONTEXTS);
-	err = mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+	err = mlx5_cmd_exec_inout(dev, query_special_contexts, in, out);
 	if (!err)
 		*null_mkey = MLX5_GET(query_special_contexts_out, out,
 				      null_mkey);
@@ -63,23 +36,15 @@ int mlx5_cmd_null_mkey(struct mlx5_core_dev *dev, u32 *null_mkey)
 }
 
 int mlx5_cmd_query_cong_params(struct mlx5_core_dev *dev, int cong_point,
-			       void *out, int out_size)
+			       void *out)
 {
-	u32 in[MLX5_ST_SZ_DW(query_cong_params_in)] = { };
+	u32 in[MLX5_ST_SZ_DW(query_cong_params_in)] = {};
 
 	MLX5_SET(query_cong_params_in, in, opcode,
 		 MLX5_CMD_OP_QUERY_CONG_PARAMS);
 	MLX5_SET(query_cong_params_in, in, cong_protocol, cong_point);
 
-	return mlx5_cmd_exec(dev, in, sizeof(in), out, out_size);
-}
-
-int mlx5_cmd_modify_cong_params(struct mlx5_core_dev *dev,
-				void *in, int in_size)
-{
-	u32 out[MLX5_ST_SZ_DW(modify_cong_params_out)] = { };
-
-	return mlx5_cmd_exec(dev, in, in_size, out, sizeof(out));
+	return mlx5_cmd_exec_inout(dev, query_cong_params, in, out);
 }
 
 int mlx5_cmd_alloc_memic(struct mlx5_dm *dm, phys_addr_t *addr,
@@ -133,7 +98,7 @@ int mlx5_cmd_alloc_memic(struct mlx5_dm *dm, phys_addr_t *addr,
 		MLX5_SET64(alloc_memic_in, in, range_start_addr,
 			   hw_start_addr + (page_idx * PAGE_SIZE));
 
-		ret = mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+		ret = mlx5_cmd_exec_inout(dev, alloc_memic, in, out);
 		if (ret) {
 			spin_lock(&dm->lock);
 			bitmap_clear(dm->memic_alloc_pages,
@@ -162,8 +127,7 @@ void mlx5_cmd_dealloc_memic(struct mlx5_dm *dm, phys_addr_t addr, u64 length)
 	struct mlx5_core_dev *dev = dm->dev;
 	u64 hw_start_addr = MLX5_CAP64_DEV_MEM(dev, memic_bar_start_addr);
 	u32 num_pages = DIV_ROUND_UP(length, PAGE_SIZE);
-	u32 out[MLX5_ST_SZ_DW(dealloc_memic_out)] = {0};
-	u32 in[MLX5_ST_SZ_DW(dealloc_memic_in)] = {0};
+	u32 in[MLX5_ST_SZ_DW(dealloc_memic_in)] = {};
 	u64 start_page_idx;
 	int err;
 
@@ -174,7 +138,7 @@ void mlx5_cmd_dealloc_memic(struct mlx5_dm *dm, phys_addr_t addr, u64 length)
 	MLX5_SET64(dealloc_memic_in, in, memic_start_addr, addr);
 	MLX5_SET(dealloc_memic_in, in, memic_size, length);
 
-	err =  mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+	err =  mlx5_cmd_exec_in(dev, dealloc_memic, in);
 	if (err)
 		return;
 
@@ -198,49 +162,46 @@ int mlx5_cmd_query_ext_ppcnt_counters(struct mlx5_core_dev *dev, void *out)
 
 void mlx5_cmd_destroy_tir(struct mlx5_core_dev *dev, u32 tirn, u16 uid)
 {
-	u32 in[MLX5_ST_SZ_DW(destroy_tir_in)]   = {};
-	u32 out[MLX5_ST_SZ_DW(destroy_tir_out)] = {};
+	u32 in[MLX5_ST_SZ_DW(destroy_tir_in)] = {};
 
 	MLX5_SET(destroy_tir_in, in, opcode, MLX5_CMD_OP_DESTROY_TIR);
 	MLX5_SET(destroy_tir_in, in, tirn, tirn);
 	MLX5_SET(destroy_tir_in, in, uid, uid);
-	mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+	mlx5_cmd_exec_in(dev, destroy_tir, in);
 }
 
 void mlx5_cmd_destroy_tis(struct mlx5_core_dev *dev, u32 tisn, u16 uid)
 {
-	u32 in[MLX5_ST_SZ_DW(destroy_tis_in)]   = {0};
-	u32 out[MLX5_ST_SZ_DW(destroy_tis_out)] = {0};
+	u32 in[MLX5_ST_SZ_DW(destroy_tis_in)] = {};
 
 	MLX5_SET(destroy_tis_in, in, opcode, MLX5_CMD_OP_DESTROY_TIS);
 	MLX5_SET(destroy_tis_in, in, tisn, tisn);
 	MLX5_SET(destroy_tis_in, in, uid, uid);
-	mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+	mlx5_cmd_exec_in(dev, destroy_tis, in);
 }
 
 void mlx5_cmd_destroy_rqt(struct mlx5_core_dev *dev, u32 rqtn, u16 uid)
 {
-	u32 in[MLX5_ST_SZ_DW(destroy_rqt_in)]   = {};
-	u32 out[MLX5_ST_SZ_DW(destroy_rqt_out)] = {};
+	u32 in[MLX5_ST_SZ_DW(destroy_rqt_in)] = {};
 
 	MLX5_SET(destroy_rqt_in, in, opcode, MLX5_CMD_OP_DESTROY_RQT);
 	MLX5_SET(destroy_rqt_in, in, rqtn, rqtn);
 	MLX5_SET(destroy_rqt_in, in, uid, uid);
-	mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+	mlx5_cmd_exec_in(dev, destroy_rqt, in);
 }
 
 int mlx5_cmd_alloc_transport_domain(struct mlx5_core_dev *dev, u32 *tdn,
 				    u16 uid)
 {
-	u32 in[MLX5_ST_SZ_DW(alloc_transport_domain_in)]   = {0};
-	u32 out[MLX5_ST_SZ_DW(alloc_transport_domain_out)] = {0};
+	u32 in[MLX5_ST_SZ_DW(alloc_transport_domain_in)] = {};
+	u32 out[MLX5_ST_SZ_DW(alloc_transport_domain_out)] = {};
 	int err;
 
 	MLX5_SET(alloc_transport_domain_in, in, opcode,
 		 MLX5_CMD_OP_ALLOC_TRANSPORT_DOMAIN);
 	MLX5_SET(alloc_transport_domain_in, in, uid, uid);
 
-	err = mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+	err = mlx5_cmd_exec_inout(dev, alloc_transport_domain, in, out);
 	if (!err)
 		*tdn = MLX5_GET(alloc_transport_domain_out, out,
 				transport_domain);
@@ -251,32 +212,29 @@ int mlx5_cmd_alloc_transport_domain(struct mlx5_core_dev *dev, u32 *tdn,
 void mlx5_cmd_dealloc_transport_domain(struct mlx5_core_dev *dev, u32 tdn,
 				       u16 uid)
 {
-	u32 in[MLX5_ST_SZ_DW(dealloc_transport_domain_in)]   = {0};
-	u32 out[MLX5_ST_SZ_DW(dealloc_transport_domain_out)] = {0};
+	u32 in[MLX5_ST_SZ_DW(dealloc_transport_domain_in)] = {};
 
 	MLX5_SET(dealloc_transport_domain_in, in, opcode,
 		 MLX5_CMD_OP_DEALLOC_TRANSPORT_DOMAIN);
 	MLX5_SET(dealloc_transport_domain_in, in, uid, uid);
 	MLX5_SET(dealloc_transport_domain_in, in, transport_domain, tdn);
-	mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+	mlx5_cmd_exec_in(dev, dealloc_transport_domain, in);
 }
 
 void mlx5_cmd_dealloc_pd(struct mlx5_core_dev *dev, u32 pdn, u16 uid)
 {
-	u32 out[MLX5_ST_SZ_DW(dealloc_pd_out)] = {};
-	u32 in[MLX5_ST_SZ_DW(dealloc_pd_in)]   = {};
+	u32 in[MLX5_ST_SZ_DW(dealloc_pd_in)] = {};
 
 	MLX5_SET(dealloc_pd_in, in, opcode, MLX5_CMD_OP_DEALLOC_PD);
 	MLX5_SET(dealloc_pd_in, in, pd, pdn);
 	MLX5_SET(dealloc_pd_in, in, uid, uid);
-	mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+	mlx5_cmd_exec_in(dev, dealloc_pd, in);
 }
 
 int mlx5_cmd_attach_mcg(struct mlx5_core_dev *dev, union ib_gid *mgid,
 			u32 qpn, u16 uid)
 {
-	u32 out[MLX5_ST_SZ_DW(attach_to_mcg_out)] = {};
-	u32 in[MLX5_ST_SZ_DW(attach_to_mcg_in)]   = {};
+	u32 in[MLX5_ST_SZ_DW(attach_to_mcg_in)] = {};
 	void *gid;
 
 	MLX5_SET(attach_to_mcg_in, in, opcode, MLX5_CMD_OP_ATTACH_TO_MCG);
@@ -284,14 +242,13 @@ int mlx5_cmd_attach_mcg(struct mlx5_core_dev *dev, union ib_gid *mgid,
 	MLX5_SET(attach_to_mcg_in, in, uid, uid);
 	gid = MLX5_ADDR_OF(attach_to_mcg_in, in, multicast_gid);
 	memcpy(gid, mgid, sizeof(*mgid));
-	return mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+	return mlx5_cmd_exec_in(dev, attach_to_mcg, in);
 }
 
 int mlx5_cmd_detach_mcg(struct mlx5_core_dev *dev, union ib_gid *mgid,
 			u32 qpn, u16 uid)
 {
-	u32 out[MLX5_ST_SZ_DW(detach_from_mcg_out)] = {};
-	u32 in[MLX5_ST_SZ_DW(detach_from_mcg_in)]   = {};
+	u32 in[MLX5_ST_SZ_DW(detach_from_mcg_in)] = {};
 	void *gid;
 
 	MLX5_SET(detach_from_mcg_in, in, opcode, MLX5_CMD_OP_DETACH_FROM_MCG);
@@ -299,18 +256,18 @@ int mlx5_cmd_detach_mcg(struct mlx5_core_dev *dev, union ib_gid *mgid,
 	MLX5_SET(detach_from_mcg_in, in, uid, uid);
 	gid = MLX5_ADDR_OF(detach_from_mcg_in, in, multicast_gid);
 	memcpy(gid, mgid, sizeof(*mgid));
-	return mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+	return mlx5_cmd_exec_in(dev, detach_from_mcg, in);
 }
 
 int mlx5_cmd_xrcd_alloc(struct mlx5_core_dev *dev, u32 *xrcdn, u16 uid)
 {
 	u32 out[MLX5_ST_SZ_DW(alloc_xrcd_out)] = {};
-	u32 in[MLX5_ST_SZ_DW(alloc_xrcd_in)]   = {};
+	u32 in[MLX5_ST_SZ_DW(alloc_xrcd_in)] = {};
 	int err;
 
 	MLX5_SET(alloc_xrcd_in, in, opcode, MLX5_CMD_OP_ALLOC_XRCD);
 	MLX5_SET(alloc_xrcd_in, in, uid, uid);
-	err = mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+	err = mlx5_cmd_exec_inout(dev, alloc_xrcd, in, out);
 	if (!err)
 		*xrcdn = MLX5_GET(alloc_xrcd_out, out, xrcd);
 	return err;
@@ -318,13 +275,12 @@ int mlx5_cmd_xrcd_alloc(struct mlx5_core_dev *dev, u32 *xrcdn, u16 uid)
 
 int mlx5_cmd_xrcd_dealloc(struct mlx5_core_dev *dev, u32 xrcdn, u16 uid)
 {
-	u32 out[MLX5_ST_SZ_DW(dealloc_xrcd_out)] = {};
-	u32 in[MLX5_ST_SZ_DW(dealloc_xrcd_in)]   = {};
+	u32 in[MLX5_ST_SZ_DW(dealloc_xrcd_in)] = {};
 
 	MLX5_SET(dealloc_xrcd_in, in, opcode, MLX5_CMD_OP_DEALLOC_XRCD);
 	MLX5_SET(dealloc_xrcd_in, in, xrcd, xrcdn);
 	MLX5_SET(dealloc_xrcd_in, in, uid, uid);
-	return mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
+	return mlx5_cmd_exec_in(dev, dealloc_xrcd, in);
 }
 
 int mlx5_cmd_mad_ifc(struct mlx5_core_dev *dev, const void *inb, void *outb,
@@ -350,7 +306,7 @@ int mlx5_cmd_mad_ifc(struct mlx5_core_dev *dev, const void *inb, void *outb,
 	data = MLX5_ADDR_OF(mad_ifc_in, in, mad);
 	memcpy(data, inb, MLX5_FLD_SZ_BYTES(mad_ifc_in, mad));
 
-	err = mlx5_cmd_exec(dev, in, inlen, out, outlen);
+	err = mlx5_cmd_exec_inout(dev, mad_ifc, in, out);
 	if (err)
 		goto out;
 
diff --git a/drivers/infiniband/hw/mlx5/cmd.h b/drivers/infiniband/hw/mlx5/cmd.h
index 43079b18d9b4..f4d8558db434 100644
--- a/drivers/infiniband/hw/mlx5/cmd.h
+++ b/drivers/infiniband/hw/mlx5/cmd.h
@@ -40,10 +40,8 @@
 int mlx5_cmd_dump_fill_mkey(struct mlx5_core_dev *dev, u32 *mkey);
 int mlx5_cmd_null_mkey(struct mlx5_core_dev *dev, u32 *null_mkey);
 int mlx5_cmd_query_cong_params(struct mlx5_core_dev *dev, int cong_point,
-			       void *out, int out_size);
+			       void *out);
 int mlx5_cmd_query_ext_ppcnt_counters(struct mlx5_core_dev *dev, void *out);
-int mlx5_cmd_modify_cong_params(struct mlx5_core_dev *mdev,
-				void *in, int in_size);
 int mlx5_cmd_alloc_memic(struct mlx5_dm *dm, phys_addr_t *addr,
 			 u64 length, u32 alignment);
 void mlx5_cmd_dealloc_memic(struct mlx5_dm *dm, phys_addr_t addr, u64 length);
diff --git a/drivers/infiniband/hw/mlx5/cong.c b/drivers/infiniband/hw/mlx5/cong.c
index de4da92b81a6..b9291e482428 100644
--- a/drivers/infiniband/hw/mlx5/cong.c
+++ b/drivers/infiniband/hw/mlx5/cong.c
@@ -290,7 +290,7 @@ static int mlx5_ib_get_cc_params(struct mlx5_ib_dev *dev, u8 port_num,
 
 	node = mlx5_ib_param_to_node(offset);
 
-	err = mlx5_cmd_query_cong_params(mdev, node, out, outlen);
+	err = mlx5_cmd_query_cong_params(mdev, node, out);
 	if (err)
 		goto free;
 
@@ -339,7 +339,7 @@ static int mlx5_ib_set_cc_params(struct mlx5_ib_dev *dev, u8 port_num,
 	MLX5_SET(field_select_r_roce_rp, field, field_select_r_roce_rp,
 		 attr_mask);
 
-	err = mlx5_cmd_modify_cong_params(mdev, in, inlen);
+	err = mlx5_cmd_exec_in(dev->mdev, modify_cong_params, in);
 	kvfree(in);
 alloc_err:
 	mlx5_ib_put_native_port_mdev(dev, port_num + 1);
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index d9ae2dd0c654..d7ca38cda326 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2562,7 +2562,7 @@ static int mlx5_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	struct mlx5_ib_alloc_pd_resp resp;
 	int err;
 	u32 out[MLX5_ST_SZ_DW(alloc_pd_out)] = {};
-	u32 in[MLX5_ST_SZ_DW(alloc_pd_in)]   = {};
+	u32 in[MLX5_ST_SZ_DW(alloc_pd_in)] = {};
 	u16 uid = 0;
 	struct mlx5_ib_ucontext *context = rdma_udata_to_drv_context(
 		udata, struct mlx5_ib_ucontext, ibucontext);
@@ -2570,8 +2570,7 @@ static int mlx5_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	uid = context ? context->devx_uid : 0;
 	MLX5_SET(alloc_pd_in, in, opcode, MLX5_CMD_OP_ALLOC_PD);
 	MLX5_SET(alloc_pd_in, in, uid, uid);
-	err = mlx5_cmd_exec(to_mdev(ibdev)->mdev, in, sizeof(in),
-			    out, sizeof(out));
+	err = mlx5_cmd_exec_inout(to_mdev(ibdev)->mdev, alloc_pd, in, out);
 	if (err)
 		return err;
 
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 70577d546567..7d2ec9ee5097 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -447,8 +447,7 @@ static void mlx5_ib_page_fault_resume(struct mlx5_ib_dev *dev,
 {
 	int wq_num = pfault->event_subtype == MLX5_PFAULT_SUBTYPE_WQE ?
 		     pfault->wqe.wq_num : pfault->token;
-	u32 out[MLX5_ST_SZ_DW(page_fault_resume_out)] = { };
-	u32 in[MLX5_ST_SZ_DW(page_fault_resume_in)]   = { };
+	u32 in[MLX5_ST_SZ_DW(page_fault_resume_in)] = {};
 	int err;
 
 	MLX5_SET(page_fault_resume_in, in, opcode, MLX5_CMD_OP_PAGE_FAULT_RESUME);
@@ -457,7 +456,7 @@ static void mlx5_ib_page_fault_resume(struct mlx5_ib_dev *dev,
 	MLX5_SET(page_fault_resume_in, in, wq_number, wq_num);
 	MLX5_SET(page_fault_resume_in, in, error, !!error);
 
-	err = mlx5_cmd_exec(dev->mdev, in, sizeof(in), out, sizeof(out));
+	err = mlx5_cmd_exec_in(dev->mdev, page_fault_resume, in);
 	if (err)
 		mlx5_ib_err(dev, "Failed to resolve the page fault on WQ 0x%x err %d\n",
 			    wq_num, err);
diff --git a/drivers/infiniband/hw/mlx5/srq_cmd.c b/drivers/infiniband/hw/mlx5/srq_cmd.c
index c851570791af..bc50a712bf2e 100644
--- a/drivers/infiniband/hw/mlx5/srq_cmd.c
+++ b/drivers/infiniband/hw/mlx5/srq_cmd.c
@@ -132,38 +132,33 @@ static int create_srq_cmd(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq,
 
 static int destroy_srq_cmd(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq)
 {
-	u32 srq_in[MLX5_ST_SZ_DW(destroy_srq_in)] = {0};
-	u32 srq_out[MLX5_ST_SZ_DW(destroy_srq_out)] = {0};
+	u32 in[MLX5_ST_SZ_DW(destroy_srq_in)] = {};
 
-	MLX5_SET(destroy_srq_in, srq_in, opcode,
-		 MLX5_CMD_OP_DESTROY_SRQ);
-	MLX5_SET(destroy_srq_in, srq_in, srqn, srq->srqn);
-	MLX5_SET(destroy_srq_in, srq_in, uid, srq->uid);
+	MLX5_SET(destroy_srq_in, in, opcode, MLX5_CMD_OP_DESTROY_SRQ);
+	MLX5_SET(destroy_srq_in, in, srqn, srq->srqn);
+	MLX5_SET(destroy_srq_in, in, uid, srq->uid);
 
-	return mlx5_cmd_exec(dev->mdev, srq_in, sizeof(srq_in), srq_out,
-			     sizeof(srq_out));
+	return mlx5_cmd_exec_in(dev->mdev, destroy_srq, in);
 }
 
 static int arm_srq_cmd(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq,
 		       u16 lwm, int is_srq)
 {
-	u32 srq_in[MLX5_ST_SZ_DW(arm_rq_in)] = {0};
-	u32 srq_out[MLX5_ST_SZ_DW(arm_rq_out)] = {0};
+	u32 in[MLX5_ST_SZ_DW(arm_rq_in)] = {};
 
-	MLX5_SET(arm_rq_in, srq_in, opcode, MLX5_CMD_OP_ARM_RQ);
-	MLX5_SET(arm_rq_in, srq_in, op_mod, MLX5_ARM_RQ_IN_OP_MOD_SRQ);
-	MLX5_SET(arm_rq_in, srq_in, srq_number, srq->srqn);
-	MLX5_SET(arm_rq_in, srq_in, lwm,      lwm);
-	MLX5_SET(arm_rq_in, srq_in, uid, srq->uid);
+	MLX5_SET(arm_rq_in, in, opcode, MLX5_CMD_OP_ARM_RQ);
+	MLX5_SET(arm_rq_in, in, op_mod, MLX5_ARM_RQ_IN_OP_MOD_SRQ);
+	MLX5_SET(arm_rq_in, in, srq_number, srq->srqn);
+	MLX5_SET(arm_rq_in, in, lwm, lwm);
+	MLX5_SET(arm_rq_in, in, uid, srq->uid);
 
-	return mlx5_cmd_exec(dev->mdev, srq_in, sizeof(srq_in), srq_out,
-			     sizeof(srq_out));
+	return mlx5_cmd_exec_in(dev->mdev, arm_rq, in);
 }
 
 static int query_srq_cmd(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq,
 			 struct mlx5_srq_attr *out)
 {
-	u32 srq_in[MLX5_ST_SZ_DW(query_srq_in)] = {0};
+	u32 in[MLX5_ST_SZ_DW(query_srq_in)] = {};
 	u32 *srq_out;
 	void *srqc;
 	int err;
@@ -172,20 +167,18 @@ static int query_srq_cmd(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq,
 	if (!srq_out)
 		return -ENOMEM;
 
-	MLX5_SET(query_srq_in, srq_in, opcode,
-		 MLX5_CMD_OP_QUERY_SRQ);
-	MLX5_SET(query_srq_in, srq_in, srqn, srq->srqn);
-	err = mlx5_cmd_exec(dev->mdev, srq_in, sizeof(srq_in), srq_out,
-			    MLX5_ST_SZ_BYTES(query_srq_out));
+	MLX5_SET(query_srq_in, in, opcode, MLX5_CMD_OP_QUERY_SRQ);
+	MLX5_SET(query_srq_in, in, srqn, srq->srqn);
+	err = mlx5_cmd_exec_inout(dev->mdev, query_srq, in, out);
 	if (err)
 		goto out;
 
-	srqc = MLX5_ADDR_OF(query_srq_out, srq_out, srq_context_entry);
+	srqc = MLX5_ADDR_OF(query_srq_out, out, srq_context_entry);
 	get_srqc(srqc, out);
 	if (MLX5_GET(srqc, srqc, state) != MLX5_SRQC_STATE_GOOD)
 		out->flags |= MLX5_SRQ_FLAG_ERR;
 out:
-	kvfree(srq_out);
+	kvfree(out);
 	return err;
 }
 
@@ -234,39 +227,35 @@ static int create_xrc_srq_cmd(struct mlx5_ib_dev *dev,
 static int destroy_xrc_srq_cmd(struct mlx5_ib_dev *dev,
 			       struct mlx5_core_srq *srq)
 {
-	u32 xrcsrq_in[MLX5_ST_SZ_DW(destroy_xrc_srq_in)]   = {0};
-	u32 xrcsrq_out[MLX5_ST_SZ_DW(destroy_xrc_srq_out)] = {0};
+	u32 in[MLX5_ST_SZ_DW(destroy_xrc_srq_in)] = {};
 
-	MLX5_SET(destroy_xrc_srq_in, xrcsrq_in, opcode,
-		 MLX5_CMD_OP_DESTROY_XRC_SRQ);
-	MLX5_SET(destroy_xrc_srq_in, xrcsrq_in, xrc_srqn, srq->srqn);
-	MLX5_SET(destroy_xrc_srq_in, xrcsrq_in, uid, srq->uid);
+	MLX5_SET(destroy_xrc_srq_in, in, opcode, MLX5_CMD_OP_DESTROY_XRC_SRQ);
+	MLX5_SET(destroy_xrc_srq_in, in, xrc_srqn, srq->srqn);
+	MLX5_SET(destroy_xrc_srq_in, in, uid, srq->uid);
 
-	return mlx5_cmd_exec(dev->mdev, xrcsrq_in, sizeof(xrcsrq_in),
-			     xrcsrq_out, sizeof(xrcsrq_out));
+	return mlx5_cmd_exec_in(dev->mdev, destroy_xrc_srq, in);
 }
 
 static int arm_xrc_srq_cmd(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq,
 			   u16 lwm)
 {
-	u32 xrcsrq_in[MLX5_ST_SZ_DW(arm_xrc_srq_in)]   = {0};
-	u32 xrcsrq_out[MLX5_ST_SZ_DW(arm_xrc_srq_out)] = {0};
+	u32 in[MLX5_ST_SZ_DW(arm_xrc_srq_in)] = {};
 
-	MLX5_SET(arm_xrc_srq_in, xrcsrq_in, opcode,   MLX5_CMD_OP_ARM_XRC_SRQ);
-	MLX5_SET(arm_xrc_srq_in, xrcsrq_in, op_mod,   MLX5_ARM_XRC_SRQ_IN_OP_MOD_XRC_SRQ);
-	MLX5_SET(arm_xrc_srq_in, xrcsrq_in, xrc_srqn, srq->srqn);
-	MLX5_SET(arm_xrc_srq_in, xrcsrq_in, lwm,      lwm);
-	MLX5_SET(arm_xrc_srq_in, xrcsrq_in, uid, srq->uid);
+	MLX5_SET(arm_xrc_srq_in, in, opcode, MLX5_CMD_OP_ARM_XRC_SRQ);
+	MLX5_SET(arm_xrc_srq_in, in, op_mod,
+		 MLX5_ARM_XRC_SRQ_IN_OP_MOD_XRC_SRQ);
+	MLX5_SET(arm_xrc_srq_in, in, xrc_srqn, srq->srqn);
+	MLX5_SET(arm_xrc_srq_in, in, lwm, lwm);
+	MLX5_SET(arm_xrc_srq_in, in, uid, srq->uid);
 
-	return  mlx5_cmd_exec(dev->mdev, xrcsrq_in, sizeof(xrcsrq_in),
-			      xrcsrq_out, sizeof(xrcsrq_out));
+	return  mlx5_cmd_exec_in(dev->mdev, arm_xrc_srq, in);
 }
 
 static int query_xrc_srq_cmd(struct mlx5_ib_dev *dev,
 			     struct mlx5_core_srq *srq,
 			     struct mlx5_srq_attr *out)
 {
-	u32 xrcsrq_in[MLX5_ST_SZ_DW(query_xrc_srq_in)];
+	u32 in[MLX5_ST_SZ_DW(query_xrc_srq_in)] = {};
 	u32 *xrcsrq_out;
 	void *xrc_srqc;
 	int err;
@@ -274,14 +263,11 @@ static int query_xrc_srq_cmd(struct mlx5_ib_dev *dev,
 	xrcsrq_out = kvzalloc(MLX5_ST_SZ_BYTES(query_xrc_srq_out), GFP_KERNEL);
 	if (!xrcsrq_out)
 		return -ENOMEM;
-	memset(xrcsrq_in, 0, sizeof(xrcsrq_in));
 
-	MLX5_SET(query_xrc_srq_in, xrcsrq_in, opcode,
-		 MLX5_CMD_OP_QUERY_XRC_SRQ);
-	MLX5_SET(query_xrc_srq_in, xrcsrq_in, xrc_srqn, srq->srqn);
+	MLX5_SET(query_xrc_srq_in, in, opcode, MLX5_CMD_OP_QUERY_XRC_SRQ);
+	MLX5_SET(query_xrc_srq_in, in, xrc_srqn, srq->srqn);
 
-	err = mlx5_cmd_exec(dev->mdev, xrcsrq_in, sizeof(xrcsrq_in),
-			    xrcsrq_out, MLX5_ST_SZ_BYTES(query_xrc_srq_out));
+	err = mlx5_cmd_exec_inout(dev->mdev, query_xrc_srq, in, xrcsrq_out);
 	if (err)
 		goto out;
 
@@ -341,13 +327,12 @@ static int create_rmp_cmd(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq,
 
 static int destroy_rmp_cmd(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq)
 {
-	u32 in[MLX5_ST_SZ_DW(destroy_rmp_in)]   = {};
-	u32 out[MLX5_ST_SZ_DW(destroy_rmp_out)] = {};
+	u32 in[MLX5_ST_SZ_DW(destroy_rmp_in)] = {};
 
 	MLX5_SET(destroy_rmp_in, in, opcode, MLX5_CMD_OP_DESTROY_RMP);
 	MLX5_SET(destroy_rmp_in, in, rmpn, srq->srqn);
 	MLX5_SET(destroy_rmp_in, in, uid, srq->uid);
-	return mlx5_cmd_exec(dev->mdev, in, sizeof(in), out, sizeof(out));
+	return mlx5_cmd_exec_in(dev->mdev, destroy_rmp, in);
 }
 
 static int arm_rmp_cmd(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq,
@@ -384,7 +369,7 @@ static int arm_rmp_cmd(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq,
 	MLX5_SET(rmpc, rmpc, state, MLX5_RMPC_STATE_RDY);
 	MLX5_SET(modify_rmp_in, in, opcode, MLX5_CMD_OP_MODIFY_RMP);
 
-	err = mlx5_cmd_exec(dev->mdev, in, inlen, out, outlen);
+	err = mlx5_cmd_exec_inout(dev->mdev, modify_rmp, in, out);
 
 out:
 	kvfree(in);
@@ -414,7 +399,7 @@ static int query_rmp_cmd(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq,
 
 	MLX5_SET(query_rmp_in, rmp_in, opcode, MLX5_CMD_OP_QUERY_RMP);
 	MLX5_SET(query_rmp_in, rmp_in, rmpn,   srq->srqn);
-	err = mlx5_cmd_exec(dev->mdev, rmp_in, inlen, rmp_out, outlen);
+	err = mlx5_cmd_exec_inout(dev->mdev, query_rmp, rmp_in, rmp_out);
 	if (err)
 		goto out;
 
@@ -477,36 +462,34 @@ static int create_xrq_cmd(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq,
 
 static int destroy_xrq_cmd(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq)
 {
-	u32 in[MLX5_ST_SZ_DW(destroy_xrq_in)] = {0};
-	u32 out[MLX5_ST_SZ_DW(destroy_xrq_out)] = {0};
+	u32 in[MLX5_ST_SZ_DW(destroy_xrq_in)] = {};
 
 	MLX5_SET(destroy_xrq_in, in, opcode, MLX5_CMD_OP_DESTROY_XRQ);
-	MLX5_SET(destroy_xrq_in, in, xrqn,   srq->srqn);
+	MLX5_SET(destroy_xrq_in, in, xrqn, srq->srqn);
 	MLX5_SET(destroy_xrq_in, in, uid, srq->uid);
 
-	return mlx5_cmd_exec(dev->mdev, in, sizeof(in), out, sizeof(out));
+	return mlx5_cmd_exec_in(dev->mdev, destroy_xrq, in);
 }
 
 static int arm_xrq_cmd(struct mlx5_ib_dev *dev,
 		       struct mlx5_core_srq *srq,
 		       u16 lwm)
 {
-	u32 out[MLX5_ST_SZ_DW(arm_rq_out)] = {0};
-	u32 in[MLX5_ST_SZ_DW(arm_rq_in)] = {0};
+	u32 in[MLX5_ST_SZ_DW(arm_rq_in)] = {};
 
-	MLX5_SET(arm_rq_in, in, opcode,     MLX5_CMD_OP_ARM_RQ);
-	MLX5_SET(arm_rq_in, in, op_mod,     MLX5_ARM_RQ_IN_OP_MOD_XRQ);
+	MLX5_SET(arm_rq_in, in, opcode, MLX5_CMD_OP_ARM_RQ);
+	MLX5_SET(arm_rq_in, in, op_mod, MLX5_ARM_RQ_IN_OP_MOD_XRQ);
 	MLX5_SET(arm_rq_in, in, srq_number, srq->srqn);
-	MLX5_SET(arm_rq_in, in, lwm,	    lwm);
+	MLX5_SET(arm_rq_in, in, lwm, lwm);
 	MLX5_SET(arm_rq_in, in, uid, srq->uid);
 
-	return mlx5_cmd_exec(dev->mdev, in, sizeof(in), out, sizeof(out));
+	return mlx5_cmd_exec_in(dev->mdev, arm_rq, in);
 }
 
 static int query_xrq_cmd(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq,
 			 struct mlx5_srq_attr *out)
 {
-	u32 in[MLX5_ST_SZ_DW(query_xrq_in)] = {0};
+	u32 in[MLX5_ST_SZ_DW(query_xrq_in)] = {};
 	u32 *xrq_out;
 	int outlen = MLX5_ST_SZ_BYTES(query_xrq_out);
 	void *xrqc;
@@ -519,7 +502,7 @@ static int query_xrq_cmd(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq,
 	MLX5_SET(query_xrq_in, in, opcode, MLX5_CMD_OP_QUERY_XRQ);
 	MLX5_SET(query_xrq_in, in, xrqn, srq->srqn);
 
-	err = mlx5_cmd_exec(dev->mdev, in, sizeof(in), xrq_out, outlen);
+	err = mlx5_cmd_exec_inout(dev->mdev, query_xrq, in, xrq_out);
 	if (err)
 		goto out;
 
-- 
2.26.2

