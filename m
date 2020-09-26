Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC2827985F
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Sep 2020 12:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgIZKZ1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 26 Sep 2020 06:25:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgIZKZ0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 26 Sep 2020 06:25:26 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6D02238E5;
        Sat, 26 Sep 2020 10:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601115924;
        bh=iPu/DGkD20idjKsooPs2xo7RW2M/4MojOuGgdy/byIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g+F1bXemKRd6u8ddTe9I9oDWKBj320/ORTTGaoBgNtiCoiDY7yuJLA83ygYoGhcp9
         gfwKtDzKyKMVn8n5Iefk5foB1q+S9hfQnFGSYsCg3O6xH7T3KEV5+209HS70zjIhvg
         wvOi6y4D05sCtee8njg0ShXQYaduhHwchuogHFrY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next v1 05/10] RDMA/mlx4: Embed GSI QP into general mlx4_ib QP
Date:   Sat, 26 Sep 2020 13:24:45 +0300
Message-Id: <20200926102450.2966017-6-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200926102450.2966017-1-leon@kernel.org>
References: <20200926102450.2966017-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

Refactor the storage struct of mlx4 GSI QP to be embedded
in mlx4_ib QP. This allows to remove internal memory allocation
of QP struct which is hidden inside the mlx4_ib_create_qp() flow.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx4/mlx4_ib.h |  25 +++-
 drivers/infiniband/hw/mlx4/qp.c      | 166 ++++++++++++---------------
 2 files changed, 100 insertions(+), 91 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
index 70636f70dd8c..2f9b1a6d01eb 100644
--- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
+++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
@@ -299,6 +299,26 @@ struct mlx4_ib_rss {
 	u8			rss_key[MLX4_EN_RSS_KEY_SIZE];
 };
 
+enum {
+	/*
+	 * Largest possible UD header: send with GRH and immediate
+	 * data plus 18 bytes for an Ethernet header with VLAN/802.1Q
+	 * tag.  (LRH would only use 8 bytes, so Ethernet is the
+	 * biggest case)
+	 */
+	MLX4_IB_UD_HEADER_SIZE		= 82,
+	MLX4_IB_LSO_HEADER_SPARE	= 128,
+};
+
+struct mlx4_ib_sqp {
+	int pkey_index;
+	u32 qkey;
+	u32 send_psn;
+	struct ib_ud_header ud_header;
+	u8 header_buf[MLX4_IB_UD_HEADER_SIZE];
+	struct ib_qp *roce_v2_gsi;
+};
+
 struct mlx4_ib_qp {
 	union {
 		struct ib_qp	ibqp;
@@ -344,7 +364,10 @@ struct mlx4_ib_qp {
 	struct mlx4_wqn_range	*wqn_range;
 	/* Number of RSS QP parents that uses this WQ */
 	u32			rss_usecnt;
-	struct mlx4_ib_rss	*rss_ctx;
+	union {
+		struct mlx4_ib_rss *rss_ctx;
+		struct mlx4_ib_sqp *sqp;
+	};
 };
 
 struct mlx4_ib_srq {
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index a52d1e9e97d9..0e3024c2419b 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -67,27 +67,6 @@ enum {
 	MLX4_IB_LINK_TYPE_ETH		= 1
 };
 
-enum {
-	/*
-	 * Largest possible UD header: send with GRH and immediate
-	 * data plus 18 bytes for an Ethernet header with VLAN/802.1Q
-	 * tag.  (LRH would only use 8 bytes, so Ethernet is the
-	 * biggest case)
-	 */
-	MLX4_IB_UD_HEADER_SIZE		= 82,
-	MLX4_IB_LSO_HEADER_SPARE	= 128,
-};
-
-struct mlx4_ib_sqp {
-	struct mlx4_ib_qp	qp;
-	int			pkey_index;
-	u32			qkey;
-	u32			send_psn;
-	struct ib_ud_header	ud_header;
-	u8			header_buf[MLX4_IB_UD_HEADER_SIZE];
-	struct ib_qp		*roce_v2_gsi;
-};
-
 enum {
 	MLX4_IB_MIN_SQ_STRIDE	= 6,
 	MLX4_IB_CACHE_LINE_SIZE	= 64,
@@ -123,11 +102,6 @@ enum mlx4_ib_source_type {
 	MLX4_IB_RWQ_SRC	= 1,
 };
 
-static struct mlx4_ib_sqp *to_msqp(struct mlx4_ib_qp *mqp)
-{
-	return container_of(mqp, struct mlx4_ib_sqp, qp);
-}
-
 static int is_tunnel_qp(struct mlx4_ib_dev *dev, struct mlx4_ib_qp *qp)
 {
 	if (!mlx4_is_master(dev->dev))
@@ -993,7 +967,6 @@ static int create_qp_common(struct ib_pd *pd, struct ib_qp_init_attr *init_attr,
 	struct mlx4_ib_dev *dev = to_mdev(pd->device);
 	int qpn;
 	int err;
-	struct mlx4_ib_sqp *sqp = NULL;
 	struct mlx4_ib_qp *qp;
 	struct mlx4_ib_ucontext *context = rdma_udata_to_drv_context(
 		udata, struct mlx4_ib_ucontext, ibucontext);
@@ -1043,17 +1016,18 @@ static int create_qp_common(struct ib_pd *pd, struct ib_qp_init_attr *init_attr,
 	}
 
 	if (!*caller_qp) {
+		qp = kzalloc(sizeof(struct mlx4_ib_qp), GFP_KERNEL);
+		if (!qp)
+			return -ENOMEM;
+
 		if (qp_type == MLX4_IB_QPT_SMI || qp_type == MLX4_IB_QPT_GSI ||
 		    (qp_type & (MLX4_IB_QPT_PROXY_SMI | MLX4_IB_QPT_PROXY_SMI_OWNER |
 				MLX4_IB_QPT_PROXY_GSI | MLX4_IB_QPT_TUN_SMI_OWNER))) {
-			sqp = kzalloc(sizeof(struct mlx4_ib_sqp), GFP_KERNEL);
-			if (!sqp)
-				return -ENOMEM;
-			qp = &sqp->qp;
-		} else {
-			qp = kzalloc(sizeof(struct mlx4_ib_qp), GFP_KERNEL);
-			if (!qp)
+			qp->sqp = kzalloc(sizeof(struct mlx4_ib_sqp), GFP_KERNEL);
+			if (!qp->sqp) {
+				kfree(qp);
 				return -ENOMEM;
+			}
 		}
 		qp->pri.vid = 0xFFFF;
 		qp->alt.vid = 0xFFFF;
@@ -1291,9 +1265,10 @@ static int create_qp_common(struct ib_pd *pd, struct ib_qp_init_attr *init_attr,
 		mlx4_db_free(dev->dev, &qp->db);
 
 err:
-	if (!sqp && !*caller_qp)
+	if (!*caller_qp) {
+		kfree(qp->sqp);
 		kfree(qp);
-	kfree(sqp);
+	}
 
 	return err;
 }
@@ -1657,7 +1632,8 @@ struct ib_qp *mlx4_ib_create_qp(struct ib_pd *pd,
 	if (!IS_ERR(ibqp) &&
 	    (init_attr->qp_type == IB_QPT_GSI) &&
 	    !(init_attr->create_flags & MLX4_IB_QP_CREATE_ROCE_V2_GSI)) {
-		struct mlx4_ib_sqp *sqp = to_msqp((to_mqp(ibqp)));
+		struct mlx4_ib_qp *qp = to_mqp(ibqp);
+		struct mlx4_ib_sqp *sqp = qp->sqp;
 		int is_eth = rdma_cap_eth_ah(&dev->ib_dev, init_attr->port_num);
 
 		if (is_eth &&
@@ -1669,8 +1645,8 @@ struct ib_qp *mlx4_ib_create_qp(struct ib_pd *pd,
 				pr_err("Failed to create GSI QP for RoCEv2 (%ld)\n", PTR_ERR(sqp->roce_v2_gsi));
 				sqp->roce_v2_gsi = NULL;
 			} else {
-				sqp = to_msqp(to_mqp(sqp->roce_v2_gsi));
-				sqp->qp.flags |= MLX4_IB_ROCE_V2_GSI_QP;
+				to_mqp(sqp->roce_v2_gsi)->flags |=
+					MLX4_IB_ROCE_V2_GSI_QP;
 			}
 
 			init_attr->create_flags &= ~MLX4_IB_QP_CREATE_ROCE_V2_GSI;
@@ -1704,9 +1680,8 @@ static int _mlx4_ib_destroy_qp(struct ib_qp *qp, struct ib_udata *udata)
 	}
 
 	if (is_sqp(dev, mqp))
-		kfree(to_msqp(mqp));
-	else
-		kfree(mqp);
+		kfree(mqp->sqp);
+	kfree(mqp);
 
 	return 0;
 }
@@ -1716,7 +1691,7 @@ int mlx4_ib_destroy_qp(struct ib_qp *qp, struct ib_udata *udata)
 	struct mlx4_ib_qp *mqp = to_mqp(qp);
 
 	if (mqp->mlx4_ib_qp_type == MLX4_IB_QPT_GSI) {
-		struct mlx4_ib_sqp *sqp = to_msqp(mqp);
+		struct mlx4_ib_sqp *sqp = mqp->sqp;
 
 		if (sqp->roce_v2_gsi)
 			ib_destroy_qp(sqp->roce_v2_gsi);
@@ -2578,7 +2553,7 @@ static int __mlx4_ib_modify_qp(void *src, enum mlx4_ib_source_type src_type,
 		qp->alt_port = attr->alt_port_num;
 
 	if (is_sqp(dev, qp))
-		store_sqp_attrs(to_msqp(qp), attr, attr_mask);
+		store_sqp_attrs(qp->sqp, attr, attr_mask);
 
 	/*
 	 * If we moved QP0 to RTR, bring the IB link up; if we moved
@@ -2855,7 +2830,7 @@ int mlx4_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	ret = _mlx4_ib_modify_qp(ibqp, attr, attr_mask, udata);
 
 	if (mqp->mlx4_ib_qp_type == MLX4_IB_QPT_GSI) {
-		struct mlx4_ib_sqp *sqp = to_msqp(mqp);
+		struct mlx4_ib_sqp *sqp = mqp->sqp;
 		int err = 0;
 
 		if (sqp->roce_v2_gsi)
@@ -2880,12 +2855,13 @@ static int vf_get_qp0_qkey(struct mlx4_dev *dev, int qpn, u32 *qkey)
 	return -EINVAL;
 }
 
-static int build_sriov_qp0_header(struct mlx4_ib_sqp *sqp,
+static int build_sriov_qp0_header(struct mlx4_ib_qp *qp,
 				  const struct ib_ud_wr *wr,
 				  void *wqe, unsigned *mlx_seg_len)
 {
-	struct mlx4_ib_dev *mdev = to_mdev(sqp->qp.ibqp.device);
-	struct ib_device *ib_dev = &mdev->ib_dev;
+	struct mlx4_ib_dev *mdev = to_mdev(qp->ibqp.device);
+	struct mlx4_ib_sqp *sqp = qp->sqp;
+	struct ib_device *ib_dev = qp->ibqp.device;
 	struct mlx4_wqe_mlx_seg *mlx = wqe;
 	struct mlx4_wqe_inline_seg *inl = wqe + sizeof *mlx;
 	struct mlx4_ib_ah *ah = to_mah(wr->ah);
@@ -2907,12 +2883,12 @@ static int build_sriov_qp0_header(struct mlx4_ib_sqp *sqp,
 
 	/* for proxy-qp0 sends, need to add in size of tunnel header */
 	/* for tunnel-qp0 sends, tunnel header is already in s/g list */
-	if (sqp->qp.mlx4_ib_qp_type == MLX4_IB_QPT_PROXY_SMI_OWNER)
+	if (qp->mlx4_ib_qp_type == MLX4_IB_QPT_PROXY_SMI_OWNER)
 		send_size += sizeof (struct mlx4_ib_tunnel_header);
 
 	ib_ud_header_init(send_size, 1, 0, 0, 0, 0, 0, 0, &sqp->ud_header);
 
-	if (sqp->qp.mlx4_ib_qp_type == MLX4_IB_QPT_PROXY_SMI_OWNER) {
+	if (qp->mlx4_ib_qp_type == MLX4_IB_QPT_PROXY_SMI_OWNER) {
 		sqp->ud_header.lrh.service_level =
 			be32_to_cpu(ah->av.ib.sl_tclass_flowlabel) >> 28;
 		sqp->ud_header.lrh.destination_lid =
@@ -2929,26 +2905,26 @@ static int build_sriov_qp0_header(struct mlx4_ib_sqp *sqp,
 
 	sqp->ud_header.lrh.virtual_lane    = 0;
 	sqp->ud_header.bth.solicited_event = !!(wr->wr.send_flags & IB_SEND_SOLICITED);
-	err = ib_get_cached_pkey(ib_dev, sqp->qp.port, 0, &pkey);
+	err = ib_get_cached_pkey(ib_dev, qp->port, 0, &pkey);
 	if (err)
 		return err;
 	sqp->ud_header.bth.pkey = cpu_to_be16(pkey);
-	if (sqp->qp.mlx4_ib_qp_type == MLX4_IB_QPT_TUN_SMI_OWNER)
+	if (qp->mlx4_ib_qp_type == MLX4_IB_QPT_TUN_SMI_OWNER)
 		sqp->ud_header.bth.destination_qpn = cpu_to_be32(wr->remote_qpn);
 	else
 		sqp->ud_header.bth.destination_qpn =
-			cpu_to_be32(mdev->dev->caps.spec_qps[sqp->qp.port - 1].qp0_tunnel);
+			cpu_to_be32(mdev->dev->caps.spec_qps[qp->port - 1].qp0_tunnel);
 
 	sqp->ud_header.bth.psn = cpu_to_be32((sqp->send_psn++) & ((1 << 24) - 1));
 	if (mlx4_is_master(mdev->dev)) {
-		if (mlx4_get_parav_qkey(mdev->dev, sqp->qp.mqp.qpn, &qkey))
+		if (mlx4_get_parav_qkey(mdev->dev, qp->mqp.qpn, &qkey))
 			return -EINVAL;
 	} else {
-		if (vf_get_qp0_qkey(mdev->dev, sqp->qp.mqp.qpn, &qkey))
+		if (vf_get_qp0_qkey(mdev->dev, qp->mqp.qpn, &qkey))
 			return -EINVAL;
 	}
 	sqp->ud_header.deth.qkey = cpu_to_be32(qkey);
-	sqp->ud_header.deth.source_qpn = cpu_to_be32(sqp->qp.mqp.qpn);
+	sqp->ud_header.deth.source_qpn = cpu_to_be32(qp->mqp.qpn);
 
 	sqp->ud_header.bth.opcode        = IB_OPCODE_UD_SEND_ONLY;
 	sqp->ud_header.immediate_present = 0;
@@ -3032,10 +3008,11 @@ static int fill_gid_by_hw_index(struct mlx4_ib_dev *ibdev, u8 port_num,
 }
 
 #define MLX4_ROCEV2_QP1_SPORT 0xC000
-static int build_mlx_header(struct mlx4_ib_sqp *sqp, const struct ib_ud_wr *wr,
+static int build_mlx_header(struct mlx4_ib_qp *qp, const struct ib_ud_wr *wr,
 			    void *wqe, unsigned *mlx_seg_len)
 {
-	struct ib_device *ib_dev = sqp->qp.ibqp.device;
+	struct mlx4_ib_sqp *sqp = qp->sqp;
+	struct ib_device *ib_dev = qp->ibqp.device;
 	struct mlx4_ib_dev *ibdev = to_mdev(ib_dev);
 	struct mlx4_wqe_mlx_seg *mlx = wqe;
 	struct mlx4_wqe_ctrl_seg *ctrl = wqe;
@@ -3059,7 +3036,7 @@ static int build_mlx_header(struct mlx4_ib_sqp *sqp, const struct ib_ud_wr *wr,
 	for (i = 0; i < wr->wr.num_sge; ++i)
 		send_size += wr->wr.sg_list[i].length;
 
-	is_eth = rdma_port_get_link_layer(sqp->qp.ibqp.device, sqp->qp.port) == IB_LINK_LAYER_ETHERNET;
+	is_eth = rdma_port_get_link_layer(qp->ibqp.device, qp->port) == IB_LINK_LAYER_ETHERNET;
 	is_grh = mlx4_ib_ah_grh_present(ah);
 	if (is_eth) {
 		enum ib_gid_type gid_type;
@@ -3073,9 +3050,9 @@ static int build_mlx_header(struct mlx4_ib_sqp *sqp, const struct ib_ud_wr *wr,
 			if (err)
 				return err;
 		} else  {
-			err = fill_gid_by_hw_index(ibdev, sqp->qp.port,
-					    ah->av.ib.gid_index,
-					    &sgid, &gid_type);
+			err = fill_gid_by_hw_index(ibdev, qp->port,
+						   ah->av.ib.gid_index, &sgid,
+						   &gid_type);
 			if (!err) {
 				is_udp = gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP;
 				if (is_udp) {
@@ -3120,13 +3097,18 @@ static int build_mlx_header(struct mlx4_ib_sqp *sqp, const struct ib_ud_wr *wr,
 				 * indexes don't necessarily match the hw ones, so
 				 * we must use our own cache
 				 */
-				sqp->ud_header.grh.source_gid.global.subnet_prefix =
-					cpu_to_be64(atomic64_read(&(to_mdev(ib_dev)->sriov.
-								    demux[sqp->qp.port - 1].
-								    subnet_prefix)));
-				sqp->ud_header.grh.source_gid.global.interface_id =
-					to_mdev(ib_dev)->sriov.demux[sqp->qp.port - 1].
-						       guid_cache[ah->av.ib.gid_index];
+				sqp->ud_header.grh.source_gid.global
+					.subnet_prefix =
+					cpu_to_be64(atomic64_read(
+						&(to_mdev(ib_dev)
+							  ->sriov
+							  .demux[qp->port - 1]
+							  .subnet_prefix)));
+				sqp->ud_header.grh.source_gid.global
+					.interface_id =
+					to_mdev(ib_dev)
+						->sriov.demux[qp->port - 1]
+						.guid_cache[ah->av.ib.gid_index];
 			} else {
 				sqp->ud_header.grh.source_gid =
 					ah->ibah.sgid_attr->gid;
@@ -3158,10 +3140,13 @@ static int build_mlx_header(struct mlx4_ib_sqp *sqp, const struct ib_ud_wr *wr,
 	mlx->flags &= cpu_to_be32(MLX4_WQE_CTRL_CQ_UPDATE);
 
 	if (!is_eth) {
-		mlx->flags |= cpu_to_be32((!sqp->qp.ibqp.qp_num ? MLX4_WQE_MLX_VL15 : 0) |
-					  (sqp->ud_header.lrh.destination_lid ==
-					   IB_LID_PERMISSIVE ? MLX4_WQE_MLX_SLR : 0) |
-					  (sqp->ud_header.lrh.service_level << 8));
+		mlx->flags |=
+			cpu_to_be32((!qp->ibqp.qp_num ? MLX4_WQE_MLX_VL15 : 0) |
+				    (sqp->ud_header.lrh.destination_lid ==
+						     IB_LID_PERMISSIVE ?
+					     MLX4_WQE_MLX_SLR :
+					     0) |
+				    (sqp->ud_header.lrh.service_level << 8));
 		if (ah->av.ib.port_pd & cpu_to_be32(0x80000000))
 			mlx->flags |= cpu_to_be32(0x1); /* force loopback */
 		mlx->rlid = sqp->ud_header.lrh.destination_lid;
@@ -3207,21 +3192,23 @@ static int build_mlx_header(struct mlx4_ib_sqp *sqp, const struct ib_ud_wr *wr,
 			sqp->ud_header.vlan.tag = cpu_to_be16(vlan | pcp);
 		}
 	} else {
-		sqp->ud_header.lrh.virtual_lane    = !sqp->qp.ibqp.qp_num ? 15 :
-							sl_to_vl(to_mdev(ib_dev),
-								 sqp->ud_header.lrh.service_level,
-								 sqp->qp.port);
-		if (sqp->qp.ibqp.qp_num && sqp->ud_header.lrh.virtual_lane == 15)
+		sqp->ud_header.lrh.virtual_lane =
+			!qp->ibqp.qp_num ?
+				15 :
+				sl_to_vl(to_mdev(ib_dev),
+					 sqp->ud_header.lrh.service_level,
+					 qp->port);
+		if (qp->ibqp.qp_num && sqp->ud_header.lrh.virtual_lane == 15)
 			return -EINVAL;
 		if (sqp->ud_header.lrh.destination_lid == IB_LID_PERMISSIVE)
 			sqp->ud_header.lrh.source_lid = IB_LID_PERMISSIVE;
 	}
 	sqp->ud_header.bth.solicited_event = !!(wr->wr.send_flags & IB_SEND_SOLICITED);
-	if (!sqp->qp.ibqp.qp_num)
-		err = ib_get_cached_pkey(ib_dev, sqp->qp.port, sqp->pkey_index,
+	if (!qp->ibqp.qp_num)
+		err = ib_get_cached_pkey(ib_dev, qp->port, sqp->pkey_index,
 					 &pkey);
 	else
-		err = ib_get_cached_pkey(ib_dev, sqp->qp.port, wr->pkey_index,
+		err = ib_get_cached_pkey(ib_dev, qp->port, wr->pkey_index,
 					 &pkey);
 	if (err)
 		return err;
@@ -3231,7 +3218,7 @@ static int build_mlx_header(struct mlx4_ib_sqp *sqp, const struct ib_ud_wr *wr,
 	sqp->ud_header.bth.psn = cpu_to_be32((sqp->send_psn++) & ((1 << 24) - 1));
 	sqp->ud_header.deth.qkey = cpu_to_be32(wr->remote_qkey & 0x80000000 ?
 					       sqp->qkey : wr->remote_qkey);
-	sqp->ud_header.deth.source_qpn = cpu_to_be32(sqp->qp.ibqp.qp_num);
+	sqp->ud_header.deth.source_qpn = cpu_to_be32(qp->ibqp.qp_num);
 
 	header_size = ib_ud_header_pack(&sqp->ud_header, sqp->header_buf);
 
@@ -3554,14 +3541,14 @@ static int _mlx4_ib_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 	struct mlx4_ib_dev *mdev = to_mdev(ibqp->device);
 
 	if (qp->mlx4_ib_qp_type == MLX4_IB_QPT_GSI) {
-		struct mlx4_ib_sqp *sqp = to_msqp(qp);
+		struct mlx4_ib_sqp *sqp = qp->sqp;
 
 		if (sqp->roce_v2_gsi) {
 			struct mlx4_ib_ah *ah = to_mah(ud_wr(wr)->ah);
 			enum ib_gid_type gid_type;
 			union ib_gid gid;
 
-			if (!fill_gid_by_hw_index(mdev, sqp->qp.port,
+			if (!fill_gid_by_hw_index(mdev, qp->port,
 					   ah->av.ib.gid_index,
 					   &gid, &gid_type))
 				qp = (gid_type == IB_GID_TYPE_ROCE_UDP_ENCAP) ?
@@ -3681,8 +3668,8 @@ static int _mlx4_ib_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 			break;
 
 		case MLX4_IB_QPT_TUN_SMI_OWNER:
-			err =  build_sriov_qp0_header(to_msqp(qp), ud_wr(wr),
-					ctrl, &seglen);
+			err = build_sriov_qp0_header(qp, ud_wr(wr), ctrl,
+						     &seglen);
 			if (unlikely(err)) {
 				*bad_wr = wr;
 				goto out;
@@ -3718,8 +3705,8 @@ static int _mlx4_ib_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 			break;
 
 		case MLX4_IB_QPT_PROXY_SMI_OWNER:
-			err = build_sriov_qp0_header(to_msqp(qp), ud_wr(wr),
-					ctrl, &seglen);
+			err = build_sriov_qp0_header(qp, ud_wr(wr), ctrl,
+						     &seglen);
 			if (unlikely(err)) {
 				*bad_wr = wr;
 				goto out;
@@ -3752,8 +3739,7 @@ static int _mlx4_ib_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 
 		case MLX4_IB_QPT_SMI:
 		case MLX4_IB_QPT_GSI:
-			err = build_mlx_header(to_msqp(qp), ud_wr(wr), ctrl,
-					&seglen);
+			err = build_mlx_header(qp, ud_wr(wr), ctrl, &seglen);
 			if (unlikely(err)) {
 				*bad_wr = wr;
 				goto out;
-- 
2.26.2

