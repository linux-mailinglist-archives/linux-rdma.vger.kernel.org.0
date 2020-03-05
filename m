Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E209517A867
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2020 16:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgCEPB1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Mar 2020 10:01:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:46806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbgCEPB1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Mar 2020 10:01:27 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 431C420848;
        Thu,  5 Mar 2020 15:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583420486;
        bh=RcQ6loenLi2u2fEUFKUX9w1hCpU5w7aF2mSESoYI2Mo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ks4I3cYKqiS7axFRNK1BQqUbT8MlPmtwc5xWbNdISA4MiPXN86LnJhPdfTYwtQcH7
         nvQNsdMwbmTp+FGDJ2vQcQDDU2U7DFoJCAn8aeI9Aq9N2aYq49+J0Tmhay6QcFFPbf
         Ki0YCBakJmKPKxvD54fb30sOfIOneo1hh+01fOC0=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Gal Pressman <galpress@amazon.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-next 2/9] RDMA: Promote field_avail() macro to be general code
Date:   Thu,  5 Mar 2020 17:00:58 +0200
Message-Id: <20200305150105.207959-3-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305150105.207959-1-leon@kernel.org>
References: <20200305150105.207959-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Main usage of such macro is to check user <-> kernel communication
in order to ensure that user supplied enough space to read/write
tested field.

The field_avail() macro is used by several RDMA drivers and in next
patches will be used for RDMA-CM code as well, so being general enough,
let's promote the code to in kernel.h

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Reviewed-by: Mark Zhang <markz@mellanox.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c |  3 --
 drivers/infiniband/hw/mlx4/main.c     |  7 ++---
 drivers/infiniband/hw/mlx5/main.c     | 41 +++++++++++++--------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h  | 18 ++++++------
 include/linux/kernel.h                | 18 ++++++++++++
 5 files changed, 48 insertions(+), 39 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index bf3120f140f7..ce89428f5af5 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -144,9 +144,6 @@ static inline bool is_rdma_read_cap(struct efa_dev *dev)
 	return dev->dev_attr.device_caps & EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_RDMA_READ_MASK;
 }

-#define field_avail(x, fld, sz) (offsetof(typeof(x), fld) + \
-				 sizeof_field(typeof(x), fld) <= (sz))
-
 #define is_reserved_cleared(reserved) \
 	!memchr_inv(reserved, 0, sizeof(reserved))

diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
index 2f5d9b181848..d63743d96196 100644
--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -434,9 +434,6 @@ int mlx4_ib_gid_index_to_real_index(struct mlx4_ib_dev *ibdev,
 	return real_index;
 }

-#define field_avail(type, fld, sz) (offsetof(type, fld) + \
-				    sizeof(((type *)0)->fld) <= (sz))
-
 static int mlx4_ib_query_device(struct ib_device *ibdev,
 				struct ib_device_attr *props,
 				struct ib_udata *uhw)
@@ -602,7 +599,7 @@ static int mlx4_ib_query_device(struct ib_device *ibdev,
 			sizeof(struct mlx4_wqe_data_seg);
 	}

-	if (field_avail(typeof(resp), rss_caps, uhw->outlen)) {
+	if (field_avail(resp, rss_caps, uhw->outlen)) {
 		if (props->rss_caps.supported_qpts) {
 			resp.rss_caps.rx_hash_function =
 				MLX4_IB_RX_HASH_FUNC_TOEPLITZ;
@@ -626,7 +623,7 @@ static int mlx4_ib_query_device(struct ib_device *ibdev,
 				       sizeof(resp.rss_caps);
 	}

-	if (field_avail(typeof(resp), tso_caps, uhw->outlen)) {
+	if (field_avail(resp, tso_caps, uhw->outlen)) {
 		if (dev->dev->caps.max_gso_sz &&
 		    ((mlx4_ib_port_link_layer(ibdev, 1) ==
 		    IB_LINK_LAYER_ETHERNET) ||
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 709ef3f57a06..879664797a80 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -898,7 +898,7 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 			props->raw_packet_caps |=
 				IB_RAW_PACKET_CAP_CVLAN_STRIPPING;

-		if (field_avail(typeof(resp), tso_caps, uhw_outlen)) {
+		if (field_avail(resp, tso_caps, uhw_outlen)) {
 			max_tso = MLX5_CAP_ETH(mdev, max_lso_cap);
 			if (max_tso) {
 				resp.tso_caps.max_tso = 1 << max_tso;
@@ -908,7 +908,7 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 			}
 		}

-		if (field_avail(typeof(resp), rss_caps, uhw_outlen)) {
+		if (field_avail(resp, rss_caps, uhw_outlen)) {
 			resp.rss_caps.rx_hash_function =
 						MLX5_RX_HASH_FUNC_TOEPLITZ;
 			resp.rss_caps.rx_hash_fields_mask =
@@ -928,9 +928,9 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 			resp.response_length += sizeof(resp.rss_caps);
 		}
 	} else {
-		if (field_avail(typeof(resp), tso_caps, uhw_outlen))
+		if (field_avail(resp, tso_caps, uhw_outlen))
 			resp.response_length += sizeof(resp.tso_caps);
-		if (field_avail(typeof(resp), rss_caps, uhw_outlen))
+		if (field_avail(resp, rss_caps, uhw_outlen))
 			resp.response_length += sizeof(resp.rss_caps);
 	}

@@ -1072,7 +1072,7 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 						MLX5_MAX_CQ_PERIOD;
 	}

-	if (field_avail(typeof(resp), cqe_comp_caps, uhw_outlen)) {
+	if (field_avail(resp, cqe_comp_caps, uhw_outlen)) {
 		resp.response_length += sizeof(resp.cqe_comp_caps);

 		if (MLX5_CAP_GEN(dev->mdev, cqe_compression)) {
@@ -1090,8 +1090,7 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 		}
 	}

-	if (field_avail(typeof(resp), packet_pacing_caps, uhw_outlen) &&
-	    raw_support) {
+	if (field_avail(resp, packet_pacing_caps, uhw_outlen) && raw_support) {
 		if (MLX5_CAP_QOS(mdev, packet_pacing) &&
 		    MLX5_CAP_GEN(mdev, qos)) {
 			resp.packet_pacing_caps.qp_rate_limit_max =
@@ -1108,7 +1107,7 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 		resp.response_length += sizeof(resp.packet_pacing_caps);
 	}

-	if (field_avail(typeof(resp), mlx5_ib_support_multi_pkt_send_wqes,
+	if (field_avail(resp, mlx5_ib_support_multi_pkt_send_wqes,
 			uhw_outlen)) {
 		if (MLX5_CAP_ETH(mdev, multi_pkt_send_wqe))
 			resp.mlx5_ib_support_multi_pkt_send_wqes =
@@ -1122,7 +1121,7 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 			sizeof(resp.mlx5_ib_support_multi_pkt_send_wqes);
 	}

-	if (field_avail(typeof(resp), flags, uhw_outlen)) {
+	if (field_avail(resp, flags, uhw_outlen)) {
 		resp.response_length += sizeof(resp.flags);

 		if (MLX5_CAP_GEN(mdev, cqe_compression_128))
@@ -1138,7 +1137,7 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 		resp.flags |= MLX5_IB_QUERY_DEV_RESP_FLAGS_SCAT2CQE_DCT;
 	}

-	if (field_avail(typeof(resp), sw_parsing_caps, uhw_outlen)) {
+	if (field_avail(resp, sw_parsing_caps, uhw_outlen)) {
 		resp.response_length += sizeof(resp.sw_parsing_caps);
 		if (MLX5_CAP_ETH(mdev, swp)) {
 			resp.sw_parsing_caps.sw_parsing_offloads |=
@@ -1158,7 +1157,7 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 		}
 	}

-	if (field_avail(typeof(resp), striding_rq_caps, uhw_outlen) &&
+	if (field_avail(resp, striding_rq_caps, uhw_outlen) &&
 	    raw_support) {
 		resp.response_length += sizeof(resp.striding_rq_caps);
 		if (MLX5_CAP_GEN(mdev, striding_rq)) {
@@ -1181,7 +1180,7 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 		}
 	}

-	if (field_avail(typeof(resp), tunnel_offloads_caps, uhw_outlen)) {
+	if (field_avail(resp, tunnel_offloads_caps, uhw_outlen)) {
 		resp.response_length += sizeof(resp.tunnel_offloads_caps);
 		if (MLX5_CAP_ETH(mdev, tunnel_stateless_vxlan))
 			resp.tunnel_offloads_caps |=
@@ -1901,16 +1900,16 @@ static int mlx5_ib_alloc_ucontext(struct ib_ucontext *uctx,
 	resp.tot_bfregs = req.total_num_bfregs;
 	resp.num_ports = dev->num_ports;

-	if (field_avail(typeof(resp), cqe_version, udata->outlen))
+	if (field_avail(resp, cqe_version, udata->outlen))
 		resp.response_length += sizeof(resp.cqe_version);

-	if (field_avail(typeof(resp), cmds_supp_uhw, udata->outlen)) {
+	if (field_avail(resp, cmds_supp_uhw, udata->outlen)) {
 		resp.cmds_supp_uhw |= MLX5_USER_CMDS_SUPP_UHW_QUERY_DEVICE |
 				      MLX5_USER_CMDS_SUPP_UHW_CREATE_AH;
 		resp.response_length += sizeof(resp.cmds_supp_uhw);
 	}

-	if (field_avail(typeof(resp), eth_min_inline, udata->outlen)) {
+	if (field_avail(resp, eth_min_inline, udata->outlen)) {
 		if (mlx5_ib_port_link_layer(ibdev, 1) == IB_LINK_LAYER_ETHERNET) {
 			mlx5_query_min_inline(dev->mdev, &resp.eth_min_inline);
 			resp.eth_min_inline++;
@@ -1918,7 +1917,7 @@ static int mlx5_ib_alloc_ucontext(struct ib_ucontext *uctx,
 		resp.response_length += sizeof(resp.eth_min_inline);
 	}

-	if (field_avail(typeof(resp), clock_info_versions, udata->outlen)) {
+	if (field_avail(resp, clock_info_versions, udata->outlen)) {
 		if (mdev->clock_info)
 			resp.clock_info_versions = BIT(MLX5_IB_CLOCK_INFO_V1);
 		resp.response_length += sizeof(resp.clock_info_versions);
@@ -1930,7 +1929,7 @@ static int mlx5_ib_alloc_ucontext(struct ib_ucontext *uctx,
 	 * pretend we don't support reading the HCA's core clock. This is also
 	 * forced by mmap function.
 	 */
-	if (field_avail(typeof(resp), hca_core_clock_offset, udata->outlen)) {
+	if (field_avail(resp, hca_core_clock_offset, udata->outlen)) {
 		if (PAGE_SIZE <= 4096) {
 			resp.comp_mask |=
 				MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_CORE_CLOCK_OFFSET;
@@ -1940,18 +1939,18 @@ static int mlx5_ib_alloc_ucontext(struct ib_ucontext *uctx,
 		resp.response_length += sizeof(resp.hca_core_clock_offset);
 	}

-	if (field_avail(typeof(resp), log_uar_size, udata->outlen))
+	if (field_avail(resp, log_uar_size, udata->outlen))
 		resp.response_length += sizeof(resp.log_uar_size);

-	if (field_avail(typeof(resp), num_uars_per_page, udata->outlen))
+	if (field_avail(resp, num_uars_per_page, udata->outlen))
 		resp.response_length += sizeof(resp.num_uars_per_page);

-	if (field_avail(typeof(resp), num_dyn_bfregs, udata->outlen)) {
+	if (field_avail(resp, num_dyn_bfregs, udata->outlen)) {
 		resp.num_dyn_bfregs = bfregi->num_dyn_bfregs;
 		resp.response_length += sizeof(resp.num_dyn_bfregs);
 	}

-	if (field_avail(typeof(resp), dump_fill_mkey, udata->outlen)) {
+	if (field_avail(resp, dump_fill_mkey, udata->outlen)) {
 		if (MLX5_CAP_GEN(dev->mdev, dump_fill_mkey)) {
 			resp.dump_fill_mkey = dump_fill_mkey;
 			resp.comp_mask |=
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 3976071a5dc9..347e7dfa6060 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -64,8 +64,6 @@
 	dev_warn(&(_dev)->ib_dev.dev, "%s:%d:(pid %d): " format, __func__,     \
 		 __LINE__, current->pid, ##arg)

-#define field_avail(type, fld, sz) (offsetof(type, fld) +		\
-				    sizeof(((type *)0)->fld) <= (sz))
 #define MLX5_IB_DEFAULT_UIDX 0xffffff
 #define MLX5_USER_ASSIGNED_UIDX_MASK __mlx5_mask(qpc, user_index)

@@ -1471,13 +1469,13 @@ static inline int get_qp_user_index(struct mlx5_ib_ucontext *ucontext,
 				    u32 *user_index)
 {
 	u8 cqe_version = ucontext->cqe_version;
+	struct mlx5_ib_create_qp qp;

-	if (field_avail(struct mlx5_ib_create_qp, uidx, inlen) &&
-	    !cqe_version && (ucmd->uidx == MLX5_IB_DEFAULT_UIDX))
+	if (field_avail(qp, uidx, inlen) && !cqe_version &&
+	    (ucmd->uidx == MLX5_IB_DEFAULT_UIDX))
 		return 0;

-	if (!!(field_avail(struct mlx5_ib_create_qp, uidx, inlen) !=
-	       !!cqe_version))
+	if (field_avail(qp, uidx, inlen) != !!cqe_version)
 		return -EINVAL;

 	return verify_assign_uidx(cqe_version, ucmd->uidx, user_index);
@@ -1489,13 +1487,13 @@ static inline int get_srq_user_index(struct mlx5_ib_ucontext *ucontext,
 				     u32 *user_index)
 {
 	u8 cqe_version = ucontext->cqe_version;
+	struct mlx5_ib_create_srq srq;

-	if (field_avail(struct mlx5_ib_create_srq, uidx, inlen) &&
-	    !cqe_version && (ucmd->uidx == MLX5_IB_DEFAULT_UIDX))
+	if (field_avail(srq, uidx, inlen) && !cqe_version &&
+	    (ucmd->uidx == MLX5_IB_DEFAULT_UIDX))
 		return 0;

-	if (!!(field_avail(struct mlx5_ib_create_srq, uidx, inlen) !=
-	       !!cqe_version))
+	if (field_avail(srq, uidx, inlen) != !!cqe_version)
 		return -EINVAL;

 	return verify_assign_uidx(cqe_version, ucmd->uidx, user_index);
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 0d9db2a14f44..699648837750 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -79,6 +79,24 @@
  */
 #define round_down(x, y) ((x) & ~__round_mask(x, y))

+/**
+ * FIELD_SIZEOF - get the size of a struct's field
+ * @t: the target struct
+ * @f: the target struct's field
+ * Return: the size of @f in the struct definition without having a
+ * declared instance of @t.
+ */
+#define FIELD_SIZEOF(t, f) (sizeof(((t*)0)->f))
+
+/**
+ * field_avail - check if specific field exists in provided data
+ * @x: the source data, usually struct received from the user
+ * @fld: field name
+ * @sz: size of the data
+ */
+#define field_avail(x, fld, sz) \
+	(offsetof(typeof(x), fld) + FIELD_SIZEOF(typeof(x), fld) <= (sz))
+
 #define typeof_member(T, m)	typeof(((T*)0)->m)

 #define DIV_ROUND_UP __KERNEL_DIV_ROUND_UP
--
2.24.1

