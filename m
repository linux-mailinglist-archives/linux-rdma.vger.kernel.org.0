Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7859CB05
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2019 09:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbfHZHyj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Aug 2019 03:54:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727674AbfHZHyi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Aug 2019 03:54:38 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EBA320874;
        Mon, 26 Aug 2019 07:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566806078;
        bh=5CpPvydFqxvmfQ1yTpWgV10PymVJLDKsLcWc6N97l6E=;
        h=From:To:Cc:Subject:Date:From;
        b=OfGuoC0ytN3nOh7s4GrZVyoDKDBOww7vqavLDQAM4dnrZ9VecUM4ZaTK0KT5TfaBj
         WSo5bhtg2IG4T2nQgsdQVg+eYeUdjXvnKr+xrrNcDvU7scYhLc8ZG91KC86/UK8SBA
         cNMt5bXxQ/LHgVvegLXDfRnnQU+njqXMkRry31tw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Michael Guralnik <michaelgur@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH rdma-core] mlx5: Report ODP capabilities for DC transport
Date:   Mon, 26 Aug 2019 10:54:31 +0300
Message-Id: <20190826075431.19717-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Michael Guralnik <michaelgur@mellanox.com>

Report ODP capabilities for DC through mlx5dv_query_device.

Signed-off-by: Michael Guralnik <michaelgur@mellanox.com>
Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 PR: https://github.com/linux-rdma/rdma-core/pull/570
 Kernel: https://lore.kernel.org/linux-rdma/20190819120815.21225-1-leon@kernel.org
---
 providers/mlx5/man/mlx5dv_query_device.3 |  5 +++
 providers/mlx5/mlx5.c                    | 42 ++++++++++++++++++++++++
 providers/mlx5/mlx5_ifc.h                | 33 +++++++++++++++++++
 providers/mlx5/mlx5dv.h                  |  2 ++
 4 files changed, 82 insertions(+)

diff --git a/providers/mlx5/man/mlx5dv_query_device.3 b/providers/mlx5/man/mlx5dv_query_device.3
index 64415a1c4..73353f302 100644
--- a/providers/mlx5/man/mlx5dv_query_device.3
+++ b/providers/mlx5/man/mlx5dv_query_device.3
@@ -49,6 +49,9 @@ struct mlx5dv_cqe_comp_caps     cqe_comp_caps;
 struct mlx5dv_sw_parsing_caps sw_parsing_caps;
 uint32_t	tunnel_offloads_caps;
 uint32_t        max_dynamic_bfregs /* max blue-flame registers that can be dynamiclly allocated */
+uint64_t        max_clock_info_update_nsec;
+uint32_t        flow_action_flags; /* use enum mlx5dv_flow_action_cap_flags */
+uint32_t        dc_odp_caps; /* use enum ibv_odp_transport_cap_bits */
 .in -8
 };

@@ -77,6 +80,8 @@ MLX5DV_CONTEXT_MASK_STRIDING_RQ         = 1 << 2,
 MLX5DV_CONTEXT_MASK_TUNNEL_OFFLOADS     = 1 << 3,
 MLX5DV_CONTEXT_MASK_DYN_BFREGS          = 1 << 4,
 MLX5DV_CONTEXT_MASK_CLOCK_INFO_UPDATE   = 1 << 5,
+MLX5DV_CONTEXT_MASK_FLOW_ACTION_FLAGS   = 1 << 6,
+MLX5DV_CONTEXT_MASK_DC_ODP_CAPS         = 1 << 7,
 .in -8
 };

diff --git a/providers/mlx5/mlx5.c b/providers/mlx5/mlx5.c
index 291e7ee0a..1e6733737 100644
--- a/providers/mlx5/mlx5.c
+++ b/providers/mlx5/mlx5.c
@@ -47,6 +47,7 @@
 #include "mlx5.h"
 #include "mlx5-abi.h"
 #include "wqe.h"
+#include "mlx5_ifc.h"

 #ifndef PCI_VENDOR_ID_MELLANOX
 #define PCI_VENDOR_ID_MELLANOX			0x15b3
@@ -672,6 +673,42 @@ static void mlx5_map_clock_info(struct mlx5_device *mdev,
 		context->clock_info_page = clock_info_page;
 }

+static uint32_t get_dc_odp_caps(struct ibv_context *ctx)
+{
+	uint32_t in[DEVX_ST_SZ_DW(query_hca_cap_in)] = {};
+	uint32_t out[DEVX_ST_SZ_DW(query_hca_cap_out)] = {};
+	uint16_t opmod = (MLX5_CAP_ODP << 1) | HCA_CAP_OPMOD_GET_CUR;
+	uint32_t ret;
+
+	DEVX_SET(query_hca_cap_in, in, opcode, MLX5_CMD_OP_QUERY_HCA_CAP);
+	DEVX_SET(query_hca_cap_in, in, op_mod, opmod);
+
+	ret = mlx5dv_devx_general_cmd(ctx, in, sizeof(in), out, sizeof(out));
+	if (ret)
+		return 0;
+
+	if (DEVX_GET(query_hca_cap_out, out,
+		     capability.odp_cap.dc_odp_caps.send))
+		ret |= IBV_ODP_SUPPORT_SEND;
+	if (DEVX_GET(query_hca_cap_out, out,
+		     capability.odp_cap.dc_odp_caps.receive))
+		ret |= IBV_ODP_SUPPORT_RECV;
+	if (DEVX_GET(query_hca_cap_out, out,
+		     capability.odp_cap.dc_odp_caps.write))
+		ret |= IBV_ODP_SUPPORT_WRITE;
+	if (DEVX_GET(query_hca_cap_out, out,
+		     capability.odp_cap.dc_odp_caps.read))
+		ret |= IBV_ODP_SUPPORT_READ;
+	if (DEVX_GET(query_hca_cap_out, out,
+		     capability.odp_cap.dc_odp_caps.atomic))
+		ret |= IBV_ODP_SUPPORT_ATOMIC;
+	if (DEVX_GET(query_hca_cap_out, out,
+		     capability.odp_cap.dc_odp_caps.srq_receive))
+		ret |= IBV_ODP_SUPPORT_SRQ_RECV;
+
+	return ret;
+}
+
 int mlx5dv_query_device(struct ibv_context *ctx_in,
 			 struct mlx5dv_context *attrs_out)
 {
@@ -741,6 +778,11 @@ int mlx5dv_query_device(struct ibv_context *ctx_in,
 		comp_mask_out |= MLX5DV_CONTEXT_MASK_FLOW_ACTION_FLAGS;
 	}

+	if (attrs_out->comp_mask & MLX5DV_CONTEXT_MASK_DC_ODP_CAPS) {
+		attrs_out->dc_odp_caps = get_dc_odp_caps(ctx_in);
+		comp_mask_out |= MLX5DV_CONTEXT_MASK_DC_ODP_CAPS;
+	}
+
 	attrs_out->comp_mask = comp_mask_out;

 	return 0;
diff --git a/providers/mlx5/mlx5_ifc.h b/providers/mlx5/mlx5_ifc.h
index 5a1c85d21..c8e11dd2b 100644
--- a/providers/mlx5/mlx5_ifc.h
+++ b/providers/mlx5/mlx5_ifc.h
@@ -972,12 +972,44 @@ struct mlx5_ifc_flow_table_eswitch_cap_bits {
 	u8      reserved_at_1900[0x6700];
 };

+struct mlx5_ifc_odp_per_transport_service_cap_bits {
+	u8         send[0x1];
+	u8         receive[0x1];
+	u8         write[0x1];
+	u8         read[0x1];
+	u8         atomic[0x1];
+	u8         srq_receive[0x1];
+	u8         reserved_at_6[0x1a];
+};
+
+struct mlx5_ifc_odp_cap_bits {
+	u8         reserved_at_0[0x40];
+
+	u8         sig[0x1];
+	u8         reserved_at_41[0x1f];
+
+	u8         reserved_at_60[0x20];
+
+	struct mlx5_ifc_odp_per_transport_service_cap_bits rc_odp_caps;
+
+	struct mlx5_ifc_odp_per_transport_service_cap_bits uc_odp_caps;
+
+	struct mlx5_ifc_odp_per_transport_service_cap_bits ud_odp_caps;
+
+	struct mlx5_ifc_odp_per_transport_service_cap_bits xrc_odp_caps;
+
+	struct mlx5_ifc_odp_per_transport_service_cap_bits dc_odp_caps;
+
+	u8         reserved_at_120[0x6e0];
+};
+
 union mlx5_ifc_hca_cap_union_bits {
 	struct mlx5_ifc_atomic_caps_bits atomic_caps;
 	struct mlx5_ifc_cmd_hca_cap_bits cmd_hca_cap;
 	struct mlx5_ifc_flow_table_nic_cap_bits flow_table_nic_cap;
 	struct mlx5_ifc_flow_table_eswitch_cap_bits flow_table_eswitch_cap;
 	struct mlx5_ifc_device_mem_cap_bits device_mem_cap;
+	struct mlx5_ifc_odp_cap_bits odp_cap;
 	u8         reserved_at_0[0x8000];
 };

@@ -1007,6 +1039,7 @@ struct mlx5_ifc_query_hca_cap_in_bits {
 };

 enum mlx5_cap_type {
+	MLX5_CAP_ODP = 2,
 	MLX5_CAP_ATOMIC = 3,
 };

diff --git a/providers/mlx5/mlx5dv.h b/providers/mlx5/mlx5dv.h
index 8e620b962..d5e8e0c16 100644
--- a/providers/mlx5/mlx5dv.h
+++ b/providers/mlx5/mlx5dv.h
@@ -72,6 +72,7 @@ enum mlx5dv_context_comp_mask {
 	MLX5DV_CONTEXT_MASK_DYN_BFREGS		= 1 << 4,
 	MLX5DV_CONTEXT_MASK_CLOCK_INFO_UPDATE	= 1 << 5,
 	MLX5DV_CONTEXT_MASK_FLOW_ACTION_FLAGS	= 1 << 6,
+	MLX5DV_CONTEXT_MASK_DC_ODP_CAPS		= 1 << 7,
 };

 struct mlx5dv_cqe_comp_caps {
@@ -122,6 +123,7 @@ struct mlx5dv_context {
 	uint32_t	max_dynamic_bfregs;
 	uint64_t	max_clock_info_update_nsec;
 	uint32_t        flow_action_flags; /* use enum mlx5dv_flow_action_cap_flags */
+	uint32_t	dc_odp_caps; /* use enum ibv_odp_transport_cap_bits */
 };

 enum mlx5dv_context_flags {
--
2.20.1

