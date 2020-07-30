Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D19232DBA
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jul 2020 10:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbgG3IOL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jul 2020 04:14:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730085AbgG3IMu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 Jul 2020 04:12:50 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C39E52074B;
        Thu, 30 Jul 2020 08:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596096769;
        bh=5jpW/+KCCtax0kmTbanxYPDvGqG93hqKSwfddIHcapM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MVX+vcoq7scOyFBkscvGxDyVfgkJ+H8EYqZ/LR4mLFoj3y+qNxDaQXVGfatp7oIHV
         /BRjrYiU/mAE+Gc1SIBNOIZnJjjH+PXTRLVf9GxzRWDirLKsY8MTT9TUJEvmV348OK
         llZtBB68eeVNOii9n17DEm0RiXirmXZnDiFu5wX4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 2/3] RDMA/mlx5: Replace open-coded offsetofend() macro
Date:   Thu, 30 Jul 2020 11:12:34 +0300
Message-Id: <20200730081235.1581127-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200730081235.1581127-1-leon@kernel.org>
References: <20200730081235.1581127-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Clean mlx5_ib from open-coded implementations of offsetofend.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/ah.c |  4 ++--
 drivers/infiniband/hw/mlx5/fs.c | 12 ++++--------
 drivers/infiniband/hw/mlx5/mr.c |  4 ++--
 drivers/infiniband/hw/mlx5/qp.c | 20 +++++++++++---------
 4 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/ah.c b/drivers/infiniband/hw/mlx5/ah.c
index 59e5ec39b447..4a60e693a04d 100644
--- a/drivers/infiniband/hw/mlx5/ah.c
+++ b/drivers/infiniband/hw/mlx5/ah.c
@@ -106,8 +106,8 @@ int mlx5_ib_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 	if (ah_type == RDMA_AH_ATTR_TYPE_ROCE && udata) {
 		int err;
 		struct mlx5_ib_create_ah_resp resp = {};
-		u32 min_resp_len = offsetof(typeof(resp), dmac) +
-				   sizeof(resp.dmac);
+		u32 min_resp_len =
+			offsetofend(struct mlx5_ib_create_ah_resp, dmac);
 
 		if (udata->outlen < min_resp_len)
 			return -EINVAL;
diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
index 922037b55393..4182c1ab81cc 100644
--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -136,12 +136,9 @@ static int check_mpls_supp_fields(u32 field_support, const __be32 *set_mask)
 #define LAST_COUNTERS_FIELD counters
 
 /* Field is the last supported field */
-#define FIELDS_NOT_SUPPORTED(filter, field)\
-	memchr_inv((void *)&filter.field  +\
-		   sizeof(filter.field), 0,\
-		   sizeof(filter) -\
-		   offsetof(typeof(filter), field) -\
-		   sizeof(filter.field))
+#define FIELDS_NOT_SUPPORTED(filter, field)                                    \
+	memchr_inv((void *)&filter.field + sizeof(filter.field), 0,            \
+		   sizeof(filter) - offsetofend(typeof(filter), field))
 
 int parse_flow_flow_action(struct mlx5_ib_flow_action *maction,
 			   bool is_egress,
@@ -1165,8 +1162,7 @@ static struct ib_flow *mlx5_ib_create_flow(struct ib_qp *qp,
 	int underlay_qpn;
 
 	if (udata && udata->inlen) {
-		min_ucmd_sz = offsetof(typeof(ucmd_hdr), reserved) +
-				sizeof(ucmd_hdr.reserved);
+		min_ucmd_sz = offsetofend(struct mlx5_ib_create_flow, reserved);
 		if (udata->inlen < min_ucmd_sz)
 			return ERR_PTR(-EOPNOTSUPP);
 
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 1e9f38305093..fde8fc2b6b5b 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -2047,8 +2047,8 @@ struct ib_mw *mlx5_ib_alloc_mw(struct ib_pd *pd, enum ib_mw_type type,
 	mw->ibmw.rkey = mw->mmkey.key;
 	mw->ndescs = ndescs;
 
-	resp.response_length = min(offsetof(typeof(resp), response_length) +
-				   sizeof(resp.response_length), udata->outlen);
+	resp.response_length =
+		min(offsetofend(typeof(resp), response_length), udata->outlen);
 	if (resp.response_length) {
 		err = ib_copy_to_udata(udata, &resp, resp.response_length);
 		if (err) {
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 433557774ddd..aefafce17c3c 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4953,8 +4953,8 @@ static int prepare_user_rq(struct ib_pd *pd,
 	int err;
 	size_t required_cmd_sz;
 
-	required_cmd_sz = offsetof(typeof(ucmd), single_stride_log_num_of_bytes)
-		+ sizeof(ucmd.single_stride_log_num_of_bytes);
+	required_cmd_sz = offsetofend(struct mlx5_ib_create_wq,
+				      single_stride_log_num_of_bytes);
 	if (udata->inlen < required_cmd_sz) {
 		mlx5_ib_dbg(dev, "invalid inlen\n");
 		return -EINVAL;
@@ -5038,7 +5038,7 @@ struct ib_wq *mlx5_ib_create_wq(struct ib_pd *pd,
 	if (!udata)
 		return ERR_PTR(-ENOSYS);
 
-	min_resp_len = offsetof(typeof(resp), reserved) + sizeof(resp.reserved);
+	min_resp_len = offsetofend(struct mlx5_ib_create_wq_resp, reserved);
 	if (udata->outlen && udata->outlen < min_resp_len)
 		return ERR_PTR(-EINVAL);
 
@@ -5068,8 +5068,8 @@ struct ib_wq *mlx5_ib_create_wq(struct ib_pd *pd,
 	rwq->ibwq.wq_num = rwq->core_qp.qpn;
 	rwq->ibwq.state = IB_WQS_RESET;
 	if (udata->outlen) {
-		resp.response_length = offsetof(typeof(resp), response_length) +
-				sizeof(resp.response_length);
+		resp.response_length = offsetofend(
+			struct mlx5_ib_create_wq_resp, response_length);
 		err = ib_copy_to_udata(udata, &resp, resp.response_length);
 		if (err)
 			goto err_copy;
@@ -5126,7 +5126,8 @@ struct ib_rwq_ind_table *mlx5_ib_create_rwq_ind_table(struct ib_device *device,
 		return ERR_PTR(-EINVAL);
 	}
 
-	min_resp_len = offsetof(typeof(resp), reserved) + sizeof(resp.reserved);
+	min_resp_len =
+		offsetofend(struct mlx5_ib_create_rwq_ind_tbl_resp, reserved);
 	if (udata->outlen && udata->outlen < min_resp_len)
 		return ERR_PTR(-EINVAL);
 
@@ -5160,8 +5161,9 @@ struct ib_rwq_ind_table *mlx5_ib_create_rwq_ind_table(struct ib_device *device,
 
 	rwq_ind_tbl->ib_rwq_ind_tbl.ind_tbl_num = rwq_ind_tbl->rqtn;
 	if (udata->outlen) {
-		resp.response_length = offsetof(typeof(resp), response_length) +
-					sizeof(resp.response_length);
+		resp.response_length =
+			offsetofend(struct mlx5_ib_create_rwq_ind_tbl_resp,
+				    response_length);
 		err = ib_copy_to_udata(udata, &resp, resp.response_length);
 		if (err)
 			goto err_copy;
@@ -5201,7 +5203,7 @@ int mlx5_ib_modify_wq(struct ib_wq *wq, struct ib_wq_attr *wq_attr,
 	void *rqc;
 	void *in;
 
-	required_cmd_sz = offsetof(typeof(ucmd), reserved) + sizeof(ucmd.reserved);
+	required_cmd_sz = offsetofend(struct mlx5_ib_modify_wq, reserved);
 	if (udata->inlen < required_cmd_sz)
 		return -EINVAL;
 
-- 
2.26.2

