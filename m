Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC2BA17F32F
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 10:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgCJJOx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 05:14:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbgCJJOx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Mar 2020 05:14:53 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 113B32467F;
        Tue, 10 Mar 2020 09:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583831692;
        bh=MWY0u1Nu9tmSfpiC3j+HX7xys+JblhYnPogKOy7TTW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rh7jxMk8tVppWOk3LZ4vyJuxrbyxsHEjFHy64Ejnc2CajNbJ6SkdciMFLVQ8sXn+d
         T/QDFWJDe/K27uFomMbC530PV1AaDawI3kICdGaorGTwRhnBrH0WJjGtdg+IIuLXRG
         RZtEKHcWmn5mCA2uvUzzPbN/CgRRnjxAncKRsBms=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 04/11] RDMA/mlx5: Use offsetofend() instead of duplicated variant
Date:   Tue, 10 Mar 2020 11:14:31 +0200
Message-Id: <20200310091438.248429-5-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200310091438.248429-1-leon@kernel.org>
References: <20200310091438.248429-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Convert mlx5 driver to use offsetofend() instead of its
duplicated variant.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c    | 42 ++++++++++++++--------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 16 ++++-------
 2 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 709ef3f57a06..e1d591af301a 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -898,7 +898,7 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 			props->raw_packet_caps |=
 				IB_RAW_PACKET_CAP_CVLAN_STRIPPING;
 
-		if (field_avail(typeof(resp), tso_caps, uhw_outlen)) {
+		if (offsetofend(typeof(resp), tso_caps) <= uhw_outlen) {
 			max_tso = MLX5_CAP_ETH(mdev, max_lso_cap);
 			if (max_tso) {
 				resp.tso_caps.max_tso = 1 << max_tso;
@@ -908,7 +908,7 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 			}
 		}
 
-		if (field_avail(typeof(resp), rss_caps, uhw_outlen)) {
+		if (offsetofend(typeof(resp), rss_caps) <= uhw_outlen) {
 			resp.rss_caps.rx_hash_function =
 						MLX5_RX_HASH_FUNC_TOEPLITZ;
 			resp.rss_caps.rx_hash_fields_mask =
@@ -928,9 +928,9 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 			resp.response_length += sizeof(resp.rss_caps);
 		}
 	} else {
-		if (field_avail(typeof(resp), tso_caps, uhw_outlen))
+		if (offsetofend(typeof(resp), tso_caps) <= uhw_outlen)
 			resp.response_length += sizeof(resp.tso_caps);
-		if (field_avail(typeof(resp), rss_caps, uhw_outlen))
+		if (offsetofend(typeof(resp), rss_caps) <= uhw_outlen)
 			resp.response_length += sizeof(resp.rss_caps);
 	}
 
@@ -1072,7 +1072,7 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 						MLX5_MAX_CQ_PERIOD;
 	}
 
-	if (field_avail(typeof(resp), cqe_comp_caps, uhw_outlen)) {
+	if (offsetofend(typeof(resp), cqe_comp_caps) <= uhw_outlen) {
 		resp.response_length += sizeof(resp.cqe_comp_caps);
 
 		if (MLX5_CAP_GEN(dev->mdev, cqe_compression)) {
@@ -1090,7 +1090,7 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 		}
 	}
 
-	if (field_avail(typeof(resp), packet_pacing_caps, uhw_outlen) &&
+	if (offsetofend(typeof(resp), packet_pacing_caps) <= uhw_outlen &&
 	    raw_support) {
 		if (MLX5_CAP_QOS(mdev, packet_pacing) &&
 		    MLX5_CAP_GEN(mdev, qos)) {
@@ -1108,8 +1108,8 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 		resp.response_length += sizeof(resp.packet_pacing_caps);
 	}
 
-	if (field_avail(typeof(resp), mlx5_ib_support_multi_pkt_send_wqes,
-			uhw_outlen)) {
+	if (offsetofend(typeof(resp), mlx5_ib_support_multi_pkt_send_wqes) <=
+	    uhw_outlen) {
 		if (MLX5_CAP_ETH(mdev, multi_pkt_send_wqe))
 			resp.mlx5_ib_support_multi_pkt_send_wqes =
 				MLX5_IB_ALLOW_MPW;
@@ -1122,7 +1122,7 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 			sizeof(resp.mlx5_ib_support_multi_pkt_send_wqes);
 	}
 
-	if (field_avail(typeof(resp), flags, uhw_outlen)) {
+	if (offsetofend(typeof(resp), flags) <= uhw_outlen) {
 		resp.response_length += sizeof(resp.flags);
 
 		if (MLX5_CAP_GEN(mdev, cqe_compression_128))
@@ -1138,7 +1138,7 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 		resp.flags |= MLX5_IB_QUERY_DEV_RESP_FLAGS_SCAT2CQE_DCT;
 	}
 
-	if (field_avail(typeof(resp), sw_parsing_caps, uhw_outlen)) {
+	if (offsetofend(typeof(resp), sw_parsing_caps) <= uhw_outlen) {
 		resp.response_length += sizeof(resp.sw_parsing_caps);
 		if (MLX5_CAP_ETH(mdev, swp)) {
 			resp.sw_parsing_caps.sw_parsing_offloads |=
@@ -1158,7 +1158,7 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 		}
 	}
 
-	if (field_avail(typeof(resp), striding_rq_caps, uhw_outlen) &&
+	if (offsetofend(typeof(resp), striding_rq_caps) <= uhw_outlen &&
 	    raw_support) {
 		resp.response_length += sizeof(resp.striding_rq_caps);
 		if (MLX5_CAP_GEN(mdev, striding_rq)) {
@@ -1181,7 +1181,7 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 		}
 	}
 
-	if (field_avail(typeof(resp), tunnel_offloads_caps, uhw_outlen)) {
+	if (offsetofend(typeof(resp), tunnel_offloads_caps) <= uhw_outlen) {
 		resp.response_length += sizeof(resp.tunnel_offloads_caps);
 		if (MLX5_CAP_ETH(mdev, tunnel_stateless_vxlan))
 			resp.tunnel_offloads_caps |=
@@ -1901,16 +1901,16 @@ static int mlx5_ib_alloc_ucontext(struct ib_ucontext *uctx,
 	resp.tot_bfregs = req.total_num_bfregs;
 	resp.num_ports = dev->num_ports;
 
-	if (field_avail(typeof(resp), cqe_version, udata->outlen))
+	if (offsetofend(typeof(resp), cqe_version) <= udata->outlen)
 		resp.response_length += sizeof(resp.cqe_version);
 
-	if (field_avail(typeof(resp), cmds_supp_uhw, udata->outlen)) {
+	if (offsetofend(typeof(resp), cmds_supp_uhw) <= udata->outlen) {
 		resp.cmds_supp_uhw |= MLX5_USER_CMDS_SUPP_UHW_QUERY_DEVICE |
 				      MLX5_USER_CMDS_SUPP_UHW_CREATE_AH;
 		resp.response_length += sizeof(resp.cmds_supp_uhw);
 	}
 
-	if (field_avail(typeof(resp), eth_min_inline, udata->outlen)) {
+	if (offsetofend(typeof(resp), eth_min_inline) <= udata->outlen) {
 		if (mlx5_ib_port_link_layer(ibdev, 1) == IB_LINK_LAYER_ETHERNET) {
 			mlx5_query_min_inline(dev->mdev, &resp.eth_min_inline);
 			resp.eth_min_inline++;
@@ -1918,7 +1918,7 @@ static int mlx5_ib_alloc_ucontext(struct ib_ucontext *uctx,
 		resp.response_length += sizeof(resp.eth_min_inline);
 	}
 
-	if (field_avail(typeof(resp), clock_info_versions, udata->outlen)) {
+	if (offsetofend(typeof(resp), clock_info_versions) <= udata->outlen) {
 		if (mdev->clock_info)
 			resp.clock_info_versions = BIT(MLX5_IB_CLOCK_INFO_V1);
 		resp.response_length += sizeof(resp.clock_info_versions);
@@ -1930,7 +1930,7 @@ static int mlx5_ib_alloc_ucontext(struct ib_ucontext *uctx,
 	 * pretend we don't support reading the HCA's core clock. This is also
 	 * forced by mmap function.
 	 */
-	if (field_avail(typeof(resp), hca_core_clock_offset, udata->outlen)) {
+	if (offsetofend(typeof(resp), hca_core_clock_offset) <= udata->outlen) {
 		if (PAGE_SIZE <= 4096) {
 			resp.comp_mask |=
 				MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_CORE_CLOCK_OFFSET;
@@ -1940,18 +1940,18 @@ static int mlx5_ib_alloc_ucontext(struct ib_ucontext *uctx,
 		resp.response_length += sizeof(resp.hca_core_clock_offset);
 	}
 
-	if (field_avail(typeof(resp), log_uar_size, udata->outlen))
+	if (offsetofend(typeof(resp), log_uar_size) <= udata->outlen)
 		resp.response_length += sizeof(resp.log_uar_size);
 
-	if (field_avail(typeof(resp), num_uars_per_page, udata->outlen))
+	if (offsetofend(typeof(resp), num_uars_per_page) <= udata->outlen)
 		resp.response_length += sizeof(resp.num_uars_per_page);
 
-	if (field_avail(typeof(resp), num_dyn_bfregs, udata->outlen)) {
+	if (offsetofend(typeof(resp), num_dyn_bfregs) <= udata->outlen) {
 		resp.num_dyn_bfregs = bfregi->num_dyn_bfregs;
 		resp.response_length += sizeof(resp.num_dyn_bfregs);
 	}
 
-	if (field_avail(typeof(resp), dump_fill_mkey, udata->outlen)) {
+	if (offsetofend(typeof(resp), dump_fill_mkey) <= udata->outlen) {
 		if (MLX5_CAP_GEN(dev->mdev, dump_fill_mkey)) {
 			resp.dump_fill_mkey = dump_fill_mkey;
 			resp.comp_mask |=
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 3976071a5dc9..6d4cf274a764 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -64,8 +64,6 @@
 	dev_warn(&(_dev)->ib_dev.dev, "%s:%d:(pid %d): " format, __func__,     \
 		 __LINE__, current->pid, ##arg)
 
-#define field_avail(type, fld, sz) (offsetof(type, fld) +		\
-				    sizeof(((type *)0)->fld) <= (sz))
 #define MLX5_IB_DEFAULT_UIDX 0xffffff
 #define MLX5_USER_ASSIGNED_UIDX_MASK __mlx5_mask(qpc, user_index)
 
@@ -1472,12 +1470,11 @@ static inline int get_qp_user_index(struct mlx5_ib_ucontext *ucontext,
 {
 	u8 cqe_version = ucontext->cqe_version;
 
-	if (field_avail(struct mlx5_ib_create_qp, uidx, inlen) &&
-	    !cqe_version && (ucmd->uidx == MLX5_IB_DEFAULT_UIDX))
+	if ((offsetofend(typeof(*ucmd), uidx) <= inlen) && !cqe_version &&
+	    (ucmd->uidx == MLX5_IB_DEFAULT_UIDX))
 		return 0;
 
-	if (!!(field_avail(struct mlx5_ib_create_qp, uidx, inlen) !=
-	       !!cqe_version))
+	if ((offsetofend(typeof(*ucmd), uidx) <= inlen) != !!cqe_version)
 		return -EINVAL;
 
 	return verify_assign_uidx(cqe_version, ucmd->uidx, user_index);
@@ -1490,12 +1487,11 @@ static inline int get_srq_user_index(struct mlx5_ib_ucontext *ucontext,
 {
 	u8 cqe_version = ucontext->cqe_version;
 
-	if (field_avail(struct mlx5_ib_create_srq, uidx, inlen) &&
-	    !cqe_version && (ucmd->uidx == MLX5_IB_DEFAULT_UIDX))
+	if ((offsetofend(typeof(*ucmd), uidx) <= inlen) && !cqe_version &&
+	    (ucmd->uidx == MLX5_IB_DEFAULT_UIDX))
 		return 0;
 
-	if (!!(field_avail(struct mlx5_ib_create_srq, uidx, inlen) !=
-	       !!cqe_version))
+	if ((offsetofend(typeof(*ucmd), uidx) <= inlen) != !!cqe_version)
 		return -EINVAL;
 
 	return verify_assign_uidx(cqe_version, ucmd->uidx, user_index);
-- 
2.24.1

