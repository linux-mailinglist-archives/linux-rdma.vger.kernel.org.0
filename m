Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F5420F1CB
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2020 11:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732050AbgF3Jjf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jun 2020 05:39:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731616AbgF3Jjd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jun 2020 05:39:33 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77991206A1;
        Tue, 30 Jun 2020 09:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593509972;
        bh=CI2lMuXPQZBVrunhSLNUQudIeEbHRLr8J1BPeSzgZsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xwj7qr5l4mwLLMX5LjtzB3FGDutF6AzuEuoJSPERzoq/6VY7L1DUYX1wJUj/DK1mC
         xUWr9XI2zvB4Me1BOFvXr5Kg5jldOnx0mJ9A06TffNwuVA2+24oHi6ALAU8lk+hBCi
         8bEDS2NBFZqym3qwuSTEaYP2E+Ll21cdJx25ly0Y=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Yishai Hadas <yishaih@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 4/7] RDMA/mlx5: Refactor mlx5_ib_alloc_ucontext() response
Date:   Tue, 30 Jun 2020 12:39:13 +0300
Message-Id: <20200630093916.332097-5-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200630093916.332097-1-leon@kernel.org>
References: <20200630093916.332097-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@mellanox.com>

Refactor mlx5_ib_alloc_ucontext() to set its response fields in a
cleaner way.

It includes,
- Move the relevant code to a self contained function.
- Calculate the response length once and drop redundant code all around.
- Reuse previously set ucontext fields once preparing the response.

The self contained function will be used in next patch as part of
implementing the query ucontext functionality.

Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c | 196 ++++++++++++++----------------
 1 file changed, 93 insertions(+), 103 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 9dbc87c540e4..1c1f1bfb83f1 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1765,6 +1765,92 @@ static void mlx5_ib_dealloc_transport_domain(struct mlx5_ib_dev *dev, u32 tdn,
 	mlx5_ib_disable_lb(dev, true, false);
 }
 
+static int set_ucontext_resp(struct ib_ucontext *uctx,
+			     struct mlx5_ib_alloc_ucontext_resp *resp)
+{
+	struct ib_device *ibdev = uctx->device;
+	struct mlx5_ib_dev *dev = to_mdev(ibdev);
+	struct mlx5_ib_ucontext *context = to_mucontext(uctx);
+	struct mlx5_bfreg_info *bfregi = &context->bfregi;
+	int err;
+
+	if (MLX5_CAP_GEN(dev->mdev, dump_fill_mkey)) {
+		err = mlx5_cmd_dump_fill_mkey(dev->mdev,
+					      &resp->dump_fill_mkey);
+		if (err)
+			return err;
+		resp->comp_mask |=
+			MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_DUMP_FILL_MKEY;
+	}
+
+	resp->qp_tab_size = 1 << MLX5_CAP_GEN(dev->mdev, log_max_qp);
+	if (dev->wc_support)
+		resp->bf_reg_size = 1 << MLX5_CAP_GEN(dev->mdev,
+						      log_bf_reg_size);
+	resp->cache_line_size = cache_line_size();
+	resp->max_sq_desc_sz = MLX5_CAP_GEN(dev->mdev, max_wqe_sz_sq);
+	resp->max_rq_desc_sz = MLX5_CAP_GEN(dev->mdev, max_wqe_sz_rq);
+	resp->max_send_wqebb = 1 << MLX5_CAP_GEN(dev->mdev, log_max_qp_sz);
+	resp->max_recv_wr = 1 << MLX5_CAP_GEN(dev->mdev, log_max_qp_sz);
+	resp->max_srq_recv_wr = 1 << MLX5_CAP_GEN(dev->mdev, log_max_srq_sz);
+	resp->cqe_version = context->cqe_version;
+	resp->log_uar_size = MLX5_CAP_GEN(dev->mdev, uar_4k) ?
+				MLX5_ADAPTER_PAGE_SHIFT : PAGE_SHIFT;
+	resp->num_uars_per_page = MLX5_CAP_GEN(dev->mdev, uar_4k) ?
+					MLX5_CAP_GEN(dev->mdev,
+						     num_of_uars_per_page) : 1;
+
+	if (mlx5_accel_ipsec_device_caps(dev->mdev) &
+				MLX5_ACCEL_IPSEC_CAP_DEVICE) {
+		if (mlx5_get_flow_namespace(dev->mdev,
+				MLX5_FLOW_NAMESPACE_EGRESS))
+			resp->flow_action_flags |= MLX5_USER_ALLOC_UCONTEXT_FLOW_ACTION_FLAGS_ESP_AES_GCM;
+		if (mlx5_accel_ipsec_device_caps(dev->mdev) &
+				MLX5_ACCEL_IPSEC_CAP_REQUIRED_METADATA)
+			resp->flow_action_flags |= MLX5_USER_ALLOC_UCONTEXT_FLOW_ACTION_FLAGS_ESP_AES_GCM_REQ_METADATA;
+		if (MLX5_CAP_FLOWTABLE(dev->mdev, flow_table_properties_nic_receive.ft_field_support.outer_esp_spi))
+			resp->flow_action_flags |= MLX5_USER_ALLOC_UCONTEXT_FLOW_ACTION_FLAGS_ESP_AES_GCM_SPI_STEERING;
+		if (mlx5_accel_ipsec_device_caps(dev->mdev) &
+				MLX5_ACCEL_IPSEC_CAP_TX_IV_IS_ESN)
+			resp->flow_action_flags |= MLX5_USER_ALLOC_UCONTEXT_FLOW_ACTION_FLAGS_ESP_AES_GCM_TX_IV_IS_ESN;
+		/* MLX5_USER_ALLOC_UCONTEXT_FLOW_ACTION_FLAGS_ESP_AES_GCM_FULL_OFFLOAD is currently always 0 */
+	}
+
+	resp->tot_bfregs = bfregi->lib_uar_dyn ? 0 :
+			bfregi->total_num_bfregs - bfregi->num_dyn_bfregs;
+	resp->num_ports = dev->num_ports;
+	resp->cmds_supp_uhw |= MLX5_USER_CMDS_SUPP_UHW_QUERY_DEVICE |
+				      MLX5_USER_CMDS_SUPP_UHW_CREATE_AH;
+
+	if (mlx5_ib_port_link_layer(ibdev, 1) == IB_LINK_LAYER_ETHERNET) {
+		mlx5_query_min_inline(dev->mdev, &resp->eth_min_inline);
+		resp->eth_min_inline++;
+	}
+
+	if (dev->mdev->clock_info)
+		resp->clock_info_versions = BIT(MLX5_IB_CLOCK_INFO_V1);
+
+	/*
+	 * We don't want to expose information from the PCI bar that is located
+	 * after 4096 bytes, so if the arch only supports larger pages, let's
+	 * pretend we don't support reading the HCA's core clock. This is also
+	 * forced by mmap function.
+	 */
+	if (PAGE_SIZE <= 4096) {
+		resp->comp_mask |=
+			MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_CORE_CLOCK_OFFSET;
+		resp->hca_core_clock_offset =
+			offsetof(struct mlx5_init_seg,
+				 internal_timer_h) % PAGE_SIZE;
+	}
+
+	if (MLX5_CAP_GEN(dev->mdev, ece_support))
+		resp->comp_mask |= MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_ECE;
+
+	resp->num_dyn_bfregs = bfregi->num_dyn_bfregs;
+	return 0;
+}
+
 static int mlx5_ib_alloc_ucontext(struct ib_ucontext *uctx,
 				  struct ib_udata *udata)
 {
@@ -1772,14 +1858,12 @@ static int mlx5_ib_alloc_ucontext(struct ib_ucontext *uctx,
 	struct mlx5_ib_dev *dev = to_mdev(ibdev);
 	struct mlx5_ib_alloc_ucontext_req_v2 req = {};
 	struct mlx5_ib_alloc_ucontext_resp resp = {};
-	struct mlx5_core_dev *mdev = dev->mdev;
 	struct mlx5_ib_ucontext *context = to_mucontext(uctx);
 	struct mlx5_bfreg_info *bfregi;
 	int ver;
 	int err;
 	size_t min_req_v2 = offsetof(struct mlx5_ib_alloc_ucontext_req_v2,
 				     max_cqe_version);
-	u32 dump_fill_mkey;
 	bool lib_uar_4k;
 	bool lib_uar_dyn;
 
@@ -1808,37 +1892,6 @@ static int mlx5_ib_alloc_ucontext(struct ib_ucontext *uctx,
 	if (req.num_low_latency_bfregs > req.total_num_bfregs - 1)
 		return -EINVAL;
 
-	resp.qp_tab_size = 1 << MLX5_CAP_GEN(dev->mdev, log_max_qp);
-	if (dev->wc_support)
-		resp.bf_reg_size = 1 << MLX5_CAP_GEN(dev->mdev, log_bf_reg_size);
-	resp.cache_line_size = cache_line_size();
-	resp.max_sq_desc_sz = MLX5_CAP_GEN(dev->mdev, max_wqe_sz_sq);
-	resp.max_rq_desc_sz = MLX5_CAP_GEN(dev->mdev, max_wqe_sz_rq);
-	resp.max_send_wqebb = 1 << MLX5_CAP_GEN(dev->mdev, log_max_qp_sz);
-	resp.max_recv_wr = 1 << MLX5_CAP_GEN(dev->mdev, log_max_qp_sz);
-	resp.max_srq_recv_wr = 1 << MLX5_CAP_GEN(dev->mdev, log_max_srq_sz);
-	resp.cqe_version = min_t(__u8,
-				 (__u8)MLX5_CAP_GEN(dev->mdev, cqe_version),
-				 req.max_cqe_version);
-	resp.log_uar_size = MLX5_CAP_GEN(dev->mdev, uar_4k) ?
-				MLX5_ADAPTER_PAGE_SHIFT : PAGE_SHIFT;
-	resp.num_uars_per_page = MLX5_CAP_GEN(dev->mdev, uar_4k) ?
-					MLX5_CAP_GEN(dev->mdev, num_of_uars_per_page) : 1;
-	resp.response_length = min(offsetof(typeof(resp), response_length) +
-				   sizeof(resp.response_length), udata->outlen);
-
-	if (mlx5_accel_ipsec_device_caps(dev->mdev) & MLX5_ACCEL_IPSEC_CAP_DEVICE) {
-		if (mlx5_get_flow_namespace(dev->mdev, MLX5_FLOW_NAMESPACE_EGRESS))
-			resp.flow_action_flags |= MLX5_USER_ALLOC_UCONTEXT_FLOW_ACTION_FLAGS_ESP_AES_GCM;
-		if (mlx5_accel_ipsec_device_caps(dev->mdev) & MLX5_ACCEL_IPSEC_CAP_REQUIRED_METADATA)
-			resp.flow_action_flags |= MLX5_USER_ALLOC_UCONTEXT_FLOW_ACTION_FLAGS_ESP_AES_GCM_REQ_METADATA;
-		if (MLX5_CAP_FLOWTABLE(dev->mdev, flow_table_properties_nic_receive.ft_field_support.outer_esp_spi))
-			resp.flow_action_flags |= MLX5_USER_ALLOC_UCONTEXT_FLOW_ACTION_FLAGS_ESP_AES_GCM_SPI_STEERING;
-		if (mlx5_accel_ipsec_device_caps(dev->mdev) & MLX5_ACCEL_IPSEC_CAP_TX_IV_IS_ESN)
-			resp.flow_action_flags |= MLX5_USER_ALLOC_UCONTEXT_FLOW_ACTION_FLAGS_ESP_AES_GCM_TX_IV_IS_ESN;
-		/* MLX5_USER_ALLOC_UCONTEXT_FLOW_ACTION_FLAGS_ESP_AES_GCM_FULL_OFFLOAD is currently always 0 */
-	}
-
 	lib_uar_4k = req.lib_caps & MLX5_LIB_CAP_4K_UAR;
 	lib_uar_dyn = req.lib_caps & MLX5_LIB_CAP_DYN_UAR;
 	bfregi = &context->bfregi;
@@ -1887,87 +1940,24 @@ static int mlx5_ib_alloc_ucontext(struct ib_ucontext *uctx,
 	if (err)
 		goto out_devx;
 
-	if (MLX5_CAP_GEN(dev->mdev, dump_fill_mkey)) {
-		err = mlx5_cmd_dump_fill_mkey(dev->mdev, &dump_fill_mkey);
-		if (err)
-			goto out_mdev;
-	}
-
 	INIT_LIST_HEAD(&context->db_page_list);
 	mutex_init(&context->db_page_mutex);
 
-	resp.tot_bfregs = lib_uar_dyn ? 0 : req.total_num_bfregs;
-	resp.num_ports = dev->num_ports;
-
-	if (offsetofend(typeof(resp), cqe_version) <= udata->outlen)
-		resp.response_length += sizeof(resp.cqe_version);
-
-	if (offsetofend(typeof(resp), cmds_supp_uhw) <= udata->outlen) {
-		resp.cmds_supp_uhw |= MLX5_USER_CMDS_SUPP_UHW_QUERY_DEVICE |
-				      MLX5_USER_CMDS_SUPP_UHW_CREATE_AH;
-		resp.response_length += sizeof(resp.cmds_supp_uhw);
-	}
-
-	if (offsetofend(typeof(resp), eth_min_inline) <= udata->outlen) {
-		if (mlx5_ib_port_link_layer(ibdev, 1) == IB_LINK_LAYER_ETHERNET) {
-			mlx5_query_min_inline(dev->mdev, &resp.eth_min_inline);
-			resp.eth_min_inline++;
-		}
-		resp.response_length += sizeof(resp.eth_min_inline);
-	}
-
-	if (offsetofend(typeof(resp), clock_info_versions) <= udata->outlen) {
-		if (mdev->clock_info)
-			resp.clock_info_versions = BIT(MLX5_IB_CLOCK_INFO_V1);
-		resp.response_length += sizeof(resp.clock_info_versions);
-	}
-
-	/*
-	 * We don't want to expose information from the PCI bar that is located
-	 * after 4096 bytes, so if the arch only supports larger pages, let's
-	 * pretend we don't support reading the HCA's core clock. This is also
-	 * forced by mmap function.
-	 */
-	if (offsetofend(typeof(resp), hca_core_clock_offset) <= udata->outlen) {
-		if (PAGE_SIZE <= 4096) {
-			resp.comp_mask |=
-				MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_CORE_CLOCK_OFFSET;
-			resp.hca_core_clock_offset =
-				offsetof(struct mlx5_init_seg, internal_timer_h) % PAGE_SIZE;
-		}
-		resp.response_length += sizeof(resp.hca_core_clock_offset);
-	}
-
-	if (offsetofend(typeof(resp), log_uar_size) <= udata->outlen)
-		resp.response_length += sizeof(resp.log_uar_size);
-
-	if (offsetofend(typeof(resp), num_uars_per_page) <= udata->outlen)
-		resp.response_length += sizeof(resp.num_uars_per_page);
-
-	if (offsetofend(typeof(resp), num_dyn_bfregs) <= udata->outlen) {
-		resp.num_dyn_bfregs = bfregi->num_dyn_bfregs;
-		resp.response_length += sizeof(resp.num_dyn_bfregs);
-	}
-
-	if (offsetofend(typeof(resp), dump_fill_mkey) <= udata->outlen) {
-		if (MLX5_CAP_GEN(dev->mdev, dump_fill_mkey)) {
-			resp.dump_fill_mkey = dump_fill_mkey;
-			resp.comp_mask |=
-				MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_DUMP_FILL_MKEY;
-		}
-		resp.response_length += sizeof(resp.dump_fill_mkey);
-	}
+	context->cqe_version = min_t(__u8,
+				 (__u8)MLX5_CAP_GEN(dev->mdev, cqe_version),
+				 req.max_cqe_version);
 
-	if (MLX5_CAP_GEN(dev->mdev, ece_support))
-		resp.comp_mask |= MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_ECE;
+	err = set_ucontext_resp(uctx, &resp);
+	if (err)
+		goto out_mdev;
 
+	resp.response_length = min(udata->outlen, sizeof(resp));
 	err = ib_copy_to_udata(udata, &resp, resp.response_length);
 	if (err)
 		goto out_mdev;
 
 	bfregi->ver = ver;
 	bfregi->num_low_latency_bfregs = req.num_low_latency_bfregs;
-	context->cqe_version = resp.cqe_version;
 	context->lib_caps = req.lib_caps;
 	print_lib_caps(dev, context->lib_caps);
 
-- 
2.26.2

