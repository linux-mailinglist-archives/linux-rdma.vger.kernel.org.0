Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518271FC7D7
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2020 09:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgFQHqi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jun 2020 03:46:38 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:37747 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726542AbgFQHqg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jun 2020 03:46:36 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with SMTP; 17 Jun 2020 10:46:29 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 05H7kTwU017656;
        Wed, 17 Jun 2020 10:46:29 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 05H7kTew007199;
        Wed, 17 Jun 2020 10:46:29 +0300
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 05H7kTTJ007198;
        Wed, 17 Jun 2020 10:46:29 +0300
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, yishaih@mellanox.com, maorg@mellanox.com
Subject: [PATCH rdma-core 10/13] mlx5: Implement the import/unimport MR verbs
Date:   Wed, 17 Jun 2020 10:45:53 +0300
Message-Id: <1592379956-7043-11-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1592379956-7043-1-git-send-email-yishaih@mellanox.com>
References: <1592379956-7043-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Implement the import/unimport MR verbs based on their definition as
described in the man page.

It uses the query MR KABI to retrieve the original MR properties based
on its given handle.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
---
 libibverbs/cmd_mr.c          | 35 +++++++++++++++++++++++++++++++++++
 libibverbs/driver.h          |  3 +++
 libibverbs/libibverbs.map.in |  1 +
 providers/mlx5/mlx5.c        |  2 ++
 providers/mlx5/mlx5.h        |  3 +++
 providers/mlx5/verbs.c       | 24 ++++++++++++++++++++++++
 6 files changed, 68 insertions(+)

diff --git a/libibverbs/cmd_mr.c b/libibverbs/cmd_mr.c
index cb729b6..6984948 100644
--- a/libibverbs/cmd_mr.c
+++ b/libibverbs/cmd_mr.c
@@ -85,3 +85,38 @@ int ibv_cmd_dereg_mr(struct verbs_mr *vmr)
 		return ret;
 	return 0;
 }
+
+int ibv_cmd_query_mr(struct ibv_pd *pd, struct verbs_mr *vmr,
+		     uint32_t mr_handle)
+{
+	DECLARE_FBCMD_BUFFER(cmd, UVERBS_OBJECT_MR,
+			     UVERBS_METHOD_QUERY_MR,
+			     5, NULL);
+	struct ibv_mr *mr = &vmr->ibv_mr;
+	uint64_t iova;
+	int ret;
+
+	fill_attr_in_obj(cmd, UVERBS_ATTR_QUERY_MR_HANDLE, mr_handle);
+	fill_attr_out_ptr(cmd, UVERBS_ATTR_QUERY_MR_RESP_LKEY,
+			  &mr->lkey);
+	fill_attr_out_ptr(cmd, UVERBS_ATTR_QUERY_MR_RESP_RKEY,
+			  &mr->rkey);
+	fill_attr_out_ptr(cmd, UVERBS_ATTR_QUERY_MR_RESP_LENGTH,
+			  &mr->length);
+	/* The iova may be used down the road, let's have it ready from kernel */
+	fill_attr_out_ptr(cmd, UVERBS_ATTR_QUERY_MR_RESP_IOVA,
+			  &iova);
+
+	ret = execute_ioctl(pd->context, cmd);
+	if (ret)
+		return ret;
+
+	mr->handle  = mr_handle;
+	mr->context = pd->context;
+	mr->pd = pd;
+	mr->addr = NULL;
+
+	vmr->mr_type = IBV_MR_TYPE_IMPORTED_MR;
+	return 0;
+}
+
diff --git a/libibverbs/driver.h b/libibverbs/driver.h
index 0edff0b..094891d 100644
--- a/libibverbs/driver.h
+++ b/libibverbs/driver.h
@@ -80,6 +80,7 @@ enum ibv_gid_type {
 enum ibv_mr_type {
 	IBV_MR_TYPE_MR,
 	IBV_MR_TYPE_NULL_MR,
+	IBV_MR_TYPE_IMPORTED_MR,
 };
 
 struct verbs_mr {
@@ -476,6 +477,8 @@ int ibv_cmd_rereg_mr(struct verbs_mr *vmr, uint32_t flags, void *addr,
 		     size_t cmd_sz, struct ib_uverbs_rereg_mr_resp *resp,
 		     size_t resp_sz);
 int ibv_cmd_dereg_mr(struct verbs_mr *vmr);
+int ibv_cmd_query_mr(struct ibv_pd *pd, struct verbs_mr *vmr,
+		     uint32_t mr_handle);
 int ibv_cmd_advise_mr(struct ibv_pd *pd,
 		      enum ibv_advise_mr_advice advice,
 		      uint32_t flags,
diff --git a/libibverbs/libibverbs.map.in b/libibverbs/libibverbs.map.in
index 5f52a9e..0d4f820 100644
--- a/libibverbs/libibverbs.map.in
+++ b/libibverbs/libibverbs.map.in
@@ -197,6 +197,7 @@ IBVERBS_PRIVATE_@IBVERBS_PABI_VERSION@ {
 		ibv_cmd_query_context;
 		ibv_cmd_query_device;
 		ibv_cmd_query_device_ex;
+		ibv_cmd_query_mr;
 		ibv_cmd_query_port;
 		ibv_cmd_query_qp;
 		ibv_cmd_query_srq;
diff --git a/providers/mlx5/mlx5.c b/providers/mlx5/mlx5.c
index 4067204..2413387 100644
--- a/providers/mlx5/mlx5.c
+++ b/providers/mlx5/mlx5.c
@@ -148,6 +148,7 @@ static const struct verbs_context_ops mlx5_ctx_common_ops = {
 	.destroy_wq = mlx5_destroy_wq,
 	.free_dm = mlx5_free_dm,
 	.get_srq_num = mlx5_get_srq_num,
+	.import_mr = mlx5_import_mr,
 	.import_pd = mlx5_import_pd,
 	.modify_cq = mlx5_modify_cq,
 	.modify_flow_action_esp = mlx5_modify_flow_action_esp,
@@ -160,6 +161,7 @@ static const struct verbs_context_ops mlx5_ctx_common_ops = {
 	.query_rt_values = mlx5_query_rt_values,
 	.read_counters = mlx5_read_counters,
 	.reg_dm_mr = mlx5_reg_dm_mr,
+	.unimport_mr = mlx5_unimport_mr,
 	.unimport_pd = mlx5_unimport_pd,
 	.alloc_null_mr = mlx5_alloc_null_mr,
 	.free_context = mlx5_free_context,
diff --git a/providers/mlx5/mlx5.h b/providers/mlx5/mlx5.h
index f2344c5..654c164 100644
--- a/providers/mlx5/mlx5.h
+++ b/providers/mlx5/mlx5.h
@@ -1023,6 +1023,9 @@ int mlx5_advise_mr(struct ibv_pd *pd,
 		   uint32_t flags,
 		   struct ibv_sge *sg_list,
 		   uint32_t num_sges);
+struct ibv_mr *mlx5_import_mr(struct ibv_pd *pd,
+			      uint32_t mr_handle);
+void mlx5_unimport_mr(struct ibv_mr *mr);
 struct ibv_pd *mlx5_import_pd(struct ibv_context *context,
 			      uint32_t pd_handle);
 void mlx5_unimport_pd(struct ibv_pd *pd);
diff --git a/providers/mlx5/verbs.c b/providers/mlx5/verbs.c
index b2c54ba..972b783 100644
--- a/providers/mlx5/verbs.c
+++ b/providers/mlx5/verbs.c
@@ -756,6 +756,30 @@ void mlx5_unimport_pd(struct ibv_pd *pd)
 		assert(false);
 }
 
+struct ibv_mr *mlx5_import_mr(struct ibv_pd *pd,
+			      uint32_t mr_handle)
+{
+	struct mlx5_mr *mr;
+	int ret;
+
+	mr = calloc(1, sizeof *mr);
+	if (!mr)
+		return NULL;
+
+	ret = ibv_cmd_query_mr(pd, &mr->vmr, mr_handle);
+	if (ret) {
+		free(mr);
+		return NULL;
+	}
+
+	return &mr->vmr.ibv_mr;
+}
+
+void mlx5_unimport_mr(struct ibv_mr *ibmr)
+{
+	free(to_mmr(ibmr));
+}
+
 struct ibv_mw *mlx5_alloc_mw(struct ibv_pd *pd, enum ibv_mw_type type)
 {
 	struct ibv_mw *mw;
-- 
1.8.3.1

