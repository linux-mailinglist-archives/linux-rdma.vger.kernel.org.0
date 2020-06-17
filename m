Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB8A1FC7D8
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2020 09:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgFQHqh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jun 2020 03:46:37 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:37739 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726331AbgFQHqg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 17 Jun 2020 03:46:36 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from yishaih@mellanox.com)
        with SMTP; 17 Jun 2020 10:46:29 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [10.7.2.17])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 05H7kT0h017650;
        Wed, 17 Jun 2020 10:46:29 +0300
Received: from vnc17.mtl.labs.mlnx (vnc17.mtl.labs.mlnx [127.0.0.1])
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8) with ESMTP id 05H7kTDD007191;
        Wed, 17 Jun 2020 10:46:29 +0300
Received: (from yishaih@localhost)
        by vnc17.mtl.labs.mlnx (8.13.8/8.13.8/Submit) id 05H7kTvG007189;
        Wed, 17 Jun 2020 10:46:29 +0300
From:   Yishai Hadas <yishaih@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, yishaih@mellanox.com, maorg@mellanox.com
Subject: [PATCH rdma-core 08/13] mlx5: Implement the import/unimport PD verbs
Date:   Wed, 17 Jun 2020 10:45:51 +0300
Message-Id: <1592379956-7043-9-git-send-email-yishaih@mellanox.com>
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1592379956-7043-1-git-send-email-yishaih@mellanox.com>
References: <1592379956-7043-1-git-send-email-yishaih@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Implement the import/unimport PD verbs based on their definition as
described in the man page.

It uses the query PD KABI to retrieve the original PD properties based
on its given handle.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
---
 providers/mlx5/mlx5.c  |  2 ++
 providers/mlx5/mlx5.h  |  3 +++
 providers/mlx5/verbs.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/providers/mlx5/mlx5.c b/providers/mlx5/mlx5.c
index dbd86c0..4067204 100644
--- a/providers/mlx5/mlx5.c
+++ b/providers/mlx5/mlx5.c
@@ -148,6 +148,7 @@ static const struct verbs_context_ops mlx5_ctx_common_ops = {
 	.destroy_wq = mlx5_destroy_wq,
 	.free_dm = mlx5_free_dm,
 	.get_srq_num = mlx5_get_srq_num,
+	.import_pd = mlx5_import_pd,
 	.modify_cq = mlx5_modify_cq,
 	.modify_flow_action_esp = mlx5_modify_flow_action_esp,
 	.modify_qp_rate_limit = mlx5_modify_qp_rate_limit,
@@ -159,6 +160,7 @@ static const struct verbs_context_ops mlx5_ctx_common_ops = {
 	.query_rt_values = mlx5_query_rt_values,
 	.read_counters = mlx5_read_counters,
 	.reg_dm_mr = mlx5_reg_dm_mr,
+	.unimport_pd = mlx5_unimport_pd,
 	.alloc_null_mr = mlx5_alloc_null_mr,
 	.free_context = mlx5_free_context,
 };
diff --git a/providers/mlx5/mlx5.h b/providers/mlx5/mlx5.h
index bce8aa2..f2344c5 100644
--- a/providers/mlx5/mlx5.h
+++ b/providers/mlx5/mlx5.h
@@ -1023,6 +1023,9 @@ int mlx5_advise_mr(struct ibv_pd *pd,
 		   uint32_t flags,
 		   struct ibv_sge *sg_list,
 		   uint32_t num_sges);
+struct ibv_pd *mlx5_import_pd(struct ibv_context *context,
+			      uint32_t pd_handle);
+void mlx5_unimport_pd(struct ibv_pd *pd);
 int mlx5_qp_fill_wr_pfns(struct mlx5_qp *mqp,
 			 const struct ibv_qp_init_attr_ex *attr,
 			 const struct mlx5dv_qp_init_attr *mlx5_attr);
diff --git a/providers/mlx5/verbs.c b/providers/mlx5/verbs.c
index 0bdb34f..b2c54ba 100644
--- a/providers/mlx5/verbs.c
+++ b/providers/mlx5/verbs.c
@@ -556,26 +556,39 @@ static int mlx5_dealloc_parent_domain(struct mlx5_parent_domain *mparent_domain)
 	return 0;
 }
 
-int mlx5_free_pd(struct ibv_pd *pd)
+static int _mlx5_free_pd(struct ibv_pd *pd, bool unimport)
 {
 	int ret;
 	struct mlx5_parent_domain *mparent_domain = to_mparent_domain(pd);
 	struct mlx5_pd *mpd = to_mpd(pd);
 
-	if (mparent_domain)
+	if (mparent_domain) {
+		if (unimport)
+			return EINVAL;
+
 		return mlx5_dealloc_parent_domain(mparent_domain);
+	}
 
 	if (atomic_load(&mpd->refcount) > 1)
 		return EBUSY;
 
+	if (unimport)
+		goto end;
+
 	ret = ibv_cmd_dealloc_pd(pd);
 	if (ret)
 		return ret;
 
+end:
 	free(mpd);
 	return 0;
 }
 
+int mlx5_free_pd(struct ibv_pd *pd)
+{
+	return _mlx5_free_pd(pd, false);
+}
+
 struct ibv_mr *mlx5_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
 			   uint64_t hca_va, int acc)
 {
@@ -706,6 +719,43 @@ int mlx5_advise_mr(struct ibv_pd *pd,
 	return ibv_cmd_advise_mr(pd, advice, flags, sg_list, num_sge);
 }
 
+struct ibv_pd *mlx5_import_pd(struct ibv_context *context,
+			      uint32_t pd_handle)
+{
+	DECLARE_COMMAND_BUFFER(cmd,
+			       UVERBS_OBJECT_PD,
+			       MLX5_IB_METHOD_PD_QUERY,
+			       2);
+
+	struct mlx5_pd *pd;
+	int ret;
+
+	pd = calloc(1, sizeof *pd);
+	if (!pd)
+		return NULL;
+
+	fill_attr_in_obj(cmd, MLX5_IB_ATTR_QUERY_PD_HANDLE, pd_handle);
+	fill_attr_out_ptr(cmd, MLX5_IB_ATTR_QUERY_PD_RESP_PDN, &pd->pdn);
+
+	ret = execute_ioctl(context, cmd);
+	if (ret) {
+		free(pd);
+		return NULL;
+	}
+
+	pd->ibv_pd.context = context;
+	pd->ibv_pd.handle = pd_handle;
+	atomic_init(&pd->refcount, 1);
+
+	return &pd->ibv_pd;
+}
+
+void mlx5_unimport_pd(struct ibv_pd *pd)
+{
+	if (_mlx5_free_pd(pd, true))
+		assert(false);
+}
+
 struct ibv_mw *mlx5_alloc_mw(struct ibv_pd *pd, enum ibv_mw_type type)
 {
 	struct ibv_mw *mw;
-- 
1.8.3.1

