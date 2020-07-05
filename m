Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F382A214B22
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2020 10:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgGEIUN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Jul 2020 04:20:13 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:33104 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726600AbgGEIUM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 Jul 2020 04:20:12 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with SMTP; 5 Jul 2020 11:20:05 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0658K50e001726;
        Sun, 5 Jul 2020 11:20:05 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 0658K5OJ009317;
        Sun, 5 Jul 2020 11:20:05 +0300
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 0658K5Q6009316;
        Sun, 5 Jul 2020 11:20:05 +0300
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, yishaih@mellanox.com, maorg@mellanox.com
Subject: [PATCH V1 rdma-core 10/13] mlx5: Implement the import/unimport MR verbs
Date:   Sun,  5 Jul 2020 11:19:46 +0300
Message-Id: <1593937189-8744-11-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1593937189-8744-1-git-send-email-yishaih@mellanox.com>
References: <1593937189-8744-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Implement the import/unimport MR verbs based on their definition as
described in the man page.

It uses the query MR ioctl command to retrieve the original MR
properties based on its given handle.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
---
 libibverbs/cmd_mr.c          | 31 +++++++++++++++++++++++++++++++
 libibverbs/driver.h          |  3 +++
 libibverbs/libibverbs.map.in |  1 +
 providers/mlx5/mlx5.c        |  2 ++
 providers/mlx5/mlx5.h        |  3 +++
 providers/mlx5/verbs.c       | 24 ++++++++++++++++++++++++
 6 files changed, 64 insertions(+)

diff --git a/libibverbs/cmd_mr.c b/libibverbs/cmd_mr.c
index cb729b6..42dbe42 100644
--- a/libibverbs/cmd_mr.c
+++ b/libibverbs/cmd_mr.c
@@ -85,3 +85,34 @@ int ibv_cmd_dereg_mr(struct verbs_mr *vmr)
 		return ret;
 	return 0;
 }
+
+int ibv_cmd_query_mr(struct ibv_pd *pd, struct verbs_mr *vmr,
+		     uint32_t mr_handle)
+{
+	DECLARE_FBCMD_BUFFER(cmd, UVERBS_OBJECT_MR,
+			     UVERBS_METHOD_QUERY_MR,
+			     4, NULL);
+	struct ibv_mr *mr = &vmr->ibv_mr;
+	int ret;
+
+	fill_attr_in_obj(cmd, UVERBS_ATTR_QUERY_MR_HANDLE, mr_handle);
+	fill_attr_out_ptr(cmd, UVERBS_ATTR_QUERY_MR_RESP_LKEY,
+			  &mr->lkey);
+	fill_attr_out_ptr(cmd, UVERBS_ATTR_QUERY_MR_RESP_RKEY,
+			  &mr->rkey);
+	fill_attr_out_ptr(cmd, UVERBS_ATTR_QUERY_MR_RESP_LENGTH,
+			  &mr->length);
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
index 9065605..4436363 100644
--- a/libibverbs/driver.h
+++ b/libibverbs/driver.h
@@ -80,6 +80,7 @@ enum ibv_gid_type {
 enum ibv_mr_type {
 	IBV_MR_TYPE_MR,
 	IBV_MR_TYPE_NULL_MR,
+	IBV_MR_TYPE_IMPORTED_MR,
 };
 
 struct verbs_mr {
@@ -485,6 +486,8 @@ int ibv_cmd_rereg_mr(struct verbs_mr *vmr, uint32_t flags, void *addr,
 		     size_t cmd_sz, struct ib_uverbs_rereg_mr_resp *resp,
 		     size_t resp_sz);
 int ibv_cmd_dereg_mr(struct verbs_mr *vmr);
+int ibv_cmd_query_mr(struct ibv_pd *pd, struct verbs_mr *vmr,
+		     uint32_t mr_handle);
 int ibv_cmd_advise_mr(struct ibv_pd *pd,
 		      enum ibv_advise_mr_advice advice,
 		      uint32_t flags,
diff --git a/libibverbs/libibverbs.map.in b/libibverbs/libibverbs.map.in
index ada856a..3240e00 100644
--- a/libibverbs/libibverbs.map.in
+++ b/libibverbs/libibverbs.map.in
@@ -199,6 +199,7 @@ IBVERBS_PRIVATE_@IBVERBS_PABI_VERSION@ {
 		ibv_cmd_query_context;
 		ibv_cmd_query_device;
 		ibv_cmd_query_device_ex;
+		ibv_cmd_query_mr;
 		ibv_cmd_query_port;
 		ibv_cmd_query_qp;
 		ibv_cmd_query_srq;
diff --git a/providers/mlx5/mlx5.c b/providers/mlx5/mlx5.c
index ea55e0f..0a091f5 100644
--- a/providers/mlx5/mlx5.c
+++ b/providers/mlx5/mlx5.c
@@ -144,6 +144,7 @@ static const struct verbs_context_ops mlx5_ctx_common_ops = {
 	.destroy_wq = mlx5_destroy_wq,
 	.free_dm = mlx5_free_dm,
 	.get_srq_num = mlx5_get_srq_num,
+	.import_mr = mlx5_import_mr,
 	.import_pd = mlx5_import_pd,
 	.modify_cq = mlx5_modify_cq,
 	.modify_flow_action_esp = mlx5_modify_flow_action_esp,
@@ -160,6 +161,7 @@ static const struct verbs_context_ops mlx5_ctx_common_ops = {
 	.alloc_null_mr = mlx5_alloc_null_mr,
 	.free_context = mlx5_free_context,
 	.set_ece = mlx5_set_ece,
+	.unimport_mr = mlx5_unimport_mr,
 	.unimport_pd = mlx5_unimport_pd,
 };
 
diff --git a/providers/mlx5/mlx5.h b/providers/mlx5/mlx5.h
index 3c129d7..939de77 100644
--- a/providers/mlx5/mlx5.h
+++ b/providers/mlx5/mlx5.h
@@ -1040,6 +1040,9 @@ int mlx5_advise_mr(struct ibv_pd *pd,
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
index 81e1ed9..915566a 100644
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

