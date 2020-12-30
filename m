Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F8B2E78CA
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Dec 2020 14:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgL3NCQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Dec 2020 08:02:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:53012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbgL3NCQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 30 Dec 2020 08:02:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0495F22227;
        Wed, 30 Dec 2020 13:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609333294;
        bh=Mnzl8uz51V5PG6LJbwFqxLv06wn7fugFm3Y+lylMak4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OxQOe0pNUAw3wccKv0TwLpSkt/6+kgT89EzVz5pKN4lfiWTP+LTP2oL4h9cLF82o6
         HexL6pcOBY/KQpPpDcvksW0UhptXWDd1/9/3rBB7Lp78N3MIk6+UeV+9+pDfZZuY9B
         U0Cx7881vF2Tn9cwYu1ou11BVtor5lyGyuMsB9HM2vnBtVn9bG6P/NswSwpuL2O4Y4
         F05aX7r82n41ROekgsXft6YvqJwJ55lfkaSYjDbkl33/D5JxhQTybFc/YLIqjFqLpx
         7yAnNMtief5VnqLa3pIFE9zIN0bsjKStob9Wht+dlphLNUm+qWjRui5VXbD0a75rnC
         iYb4wyypxzj8g==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yishai Hadas <yishaih@nvidia.com>, linux-rdma@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH mlx5-next 3/3] RDMA/mlx5: Use strict get/set operations for obj_id
Date:   Wed, 30 Dec 2020 15:01:21 +0200
Message-Id: <20201230130121.180350-4-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201230130121.180350-1-leon@kernel.org>
References: <20201230130121.180350-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@nvidia.com>

Use strict get/set operations for obj_id based on the specific object
type. This comes to prevent any miss match between the general header to
the legacy header commands.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/devx.c | 199 ++++++++++++++++++++++--------
 1 file changed, 146 insertions(+), 53 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 21a25f0c7640..ef69541a5075 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -94,13 +94,13 @@ struct devx_umem {
 	struct mlx5_core_dev		*mdev;
 	struct ib_umem			*umem;
 	u32				dinlen;
-	u32				dinbox[MLX5_ST_SZ_DW(general_obj_in_cmd_hdr)];
+	u32				dinbox[MLX5_ST_SZ_DW(destroy_umem_in)];
 };

 struct devx_umem_reg_cmd {
 	void				*in;
 	u32				inlen;
-	u32				out[MLX5_ST_SZ_DW(general_obj_out_cmd_hdr)];
+	u32				out[MLX5_ST_SZ_DW(create_umem_out)];
 };

 static struct mlx5_ib_ucontext *
@@ -111,8 +111,8 @@ devx_ufile2uctx(const struct uverbs_attr_bundle *attrs)

 int mlx5_ib_devx_create(struct mlx5_ib_dev *dev, bool is_user)
 {
-	u32 in[MLX5_ST_SZ_DW(create_uctx_in)] = {0};
-	u32 out[MLX5_ST_SZ_DW(general_obj_out_cmd_hdr)] = {0};
+	u32 in[MLX5_ST_SZ_DW(create_uctx_in)] = {};
+	u32 out[MLX5_ST_SZ_DW(create_uctx_out)] = {};
 	void *uctx;
 	int err;
 	u16 uid;
@@ -138,14 +138,14 @@ int mlx5_ib_devx_create(struct mlx5_ib_dev *dev, bool is_user)
 	if (err)
 		return err;

-	uid = MLX5_GET(general_obj_out_cmd_hdr, out, obj_id);
+	uid = MLX5_GET(create_uctx_out, out, uid);
 	return uid;
 }

 void mlx5_ib_devx_destroy(struct mlx5_ib_dev *dev, u16 uid)
 {
-	u32 in[MLX5_ST_SZ_DW(destroy_uctx_in)] = {0};
-	u32 out[MLX5_ST_SZ_DW(general_obj_out_cmd_hdr)] = {0};
+	u32 in[MLX5_ST_SZ_DW(destroy_uctx_in)] = {};
+	u32 out[MLX5_ST_SZ_DW(destroy_uctx_out)] = {};

 	MLX5_SET(destroy_uctx_in, in, opcode, MLX5_CMD_OP_DESTROY_UCTX);
 	MLX5_SET(destroy_uctx_in, in, uid, uid);
@@ -288,6 +288,80 @@ static u64 get_enc_obj_id(u32 opcode, u32 obj_id)
 	return ((u64)opcode << 32) | obj_id;
 }

+static u32 devx_get_created_obj_id(const void *in, const void *out, u16 opcode)
+{
+	switch (opcode) {
+	case MLX5_CMD_OP_CREATE_GENERAL_OBJECT:
+		return MLX5_GET(general_obj_out_cmd_hdr, out, obj_id);
+	case MLX5_CMD_OP_CREATE_UMEM:
+		return MLX5_GET(create_umem_out, out, umem_id);
+	case MLX5_CMD_OP_CREATE_MKEY:
+		return MLX5_GET(create_mkey_out, out, mkey_index);
+	case MLX5_CMD_OP_CREATE_CQ:
+		return MLX5_GET(create_cq_out, out, cqn);
+	case MLX5_CMD_OP_ALLOC_PD:
+		return MLX5_GET(alloc_pd_out, out, pd);
+	case MLX5_CMD_OP_ALLOC_TRANSPORT_DOMAIN:
+		return MLX5_GET(alloc_transport_domain_out, out,
+				transport_domain);
+	case MLX5_CMD_OP_CREATE_RMP:
+		return MLX5_GET(create_rmp_out, out, rmpn);
+	case MLX5_CMD_OP_CREATE_SQ:
+		return MLX5_GET(create_sq_out, out, sqn);
+	case MLX5_CMD_OP_CREATE_RQ:
+		return MLX5_GET(create_rq_out, out, rqn);
+	case MLX5_CMD_OP_CREATE_RQT:
+		return MLX5_GET(create_rqt_out, out, rqtn);
+	case MLX5_CMD_OP_CREATE_TIR:
+		return MLX5_GET(create_tir_out, out, tirn);
+	case MLX5_CMD_OP_CREATE_TIS:
+		return MLX5_GET(create_tis_out, out, tisn);
+	case MLX5_CMD_OP_ALLOC_Q_COUNTER:
+		return MLX5_GET(alloc_q_counter_out, out, counter_set_id);
+	case MLX5_CMD_OP_CREATE_FLOW_TABLE:
+		return MLX5_GET(create_flow_table_out, out, table_id);
+	case MLX5_CMD_OP_CREATE_FLOW_GROUP:
+		return MLX5_GET(create_flow_group_out, out, group_id);
+	case MLX5_CMD_OP_SET_FLOW_TABLE_ENTRY:
+		return MLX5_GET(set_fte_in, in, flow_index);
+	case MLX5_CMD_OP_ALLOC_FLOW_COUNTER:
+		return MLX5_GET(alloc_flow_counter_out, out, flow_counter_id);
+	case MLX5_CMD_OP_ALLOC_PACKET_REFORMAT_CONTEXT:
+		return MLX5_GET(alloc_packet_reformat_context_out, out,
+				packet_reformat_id);
+	case MLX5_CMD_OP_ALLOC_MODIFY_HEADER_CONTEXT:
+		return MLX5_GET(alloc_modify_header_context_out, out,
+				modify_header_id);
+	case MLX5_CMD_OP_CREATE_SCHEDULING_ELEMENT:
+		return MLX5_GET(create_scheduling_element_out, out,
+				scheduling_element_id);
+	case MLX5_CMD_OP_ADD_VXLAN_UDP_DPORT:
+		return MLX5_GET(add_vxlan_udp_dport_in, in, vxlan_udp_port);
+	case MLX5_CMD_OP_SET_L2_TABLE_ENTRY:
+		return MLX5_GET(set_l2_table_entry_in, in, table_index);
+	case MLX5_CMD_OP_CREATE_QP:
+		return MLX5_GET(create_qp_out, out, qpn);
+	case MLX5_CMD_OP_CREATE_SRQ:
+		return MLX5_GET(create_srq_out, out, srqn);
+	case MLX5_CMD_OP_CREATE_XRC_SRQ:
+		return MLX5_GET(create_xrc_srq_out, out, xrc_srqn);
+	case MLX5_CMD_OP_CREATE_DCT:
+		return MLX5_GET(create_dct_out, out, dctn);
+	case MLX5_CMD_OP_CREATE_XRQ:
+		return MLX5_GET(create_xrq_out, out, xrqn);
+	case MLX5_CMD_OP_ATTACH_TO_MCG:
+		return MLX5_GET(attach_to_mcg_in, in, qpn);
+	case MLX5_CMD_OP_ALLOC_XRCD:
+		return MLX5_GET(alloc_xrcd_out, out, xrcd);
+	case MLX5_CMD_OP_CREATE_PSV:
+		return MLX5_GET(create_psv_out, out, psv0_index);
+	default:
+		/* The entry must match to one of the devx_is_obj_create_cmd */
+		WARN_ON(true);
+		return 0;
+	}
+}
+
 static u64 devx_get_obj_id(const void *in)
 {
 	u16 opcode = MLX5_GET(general_obj_in_cmd_hdr, in, opcode);
@@ -399,8 +473,8 @@ static u64 devx_get_obj_id(const void *in)
 		break;
 	case MLX5_CMD_OP_QUERY_MODIFY_HEADER_CONTEXT:
 		obj_id = get_enc_obj_id(MLX5_CMD_OP_ALLOC_MODIFY_HEADER_CONTEXT,
-					MLX5_GET(general_obj_in_cmd_hdr, in,
-						 obj_id));
+					MLX5_GET(query_modify_header_context_in,
+						 in, modify_header_id));
 		break;
 	case MLX5_CMD_OP_QUERY_SCHEDULING_ELEMENT:
 		obj_id = get_enc_obj_id(MLX5_CMD_OP_CREATE_SCHEDULING_ELEMENT,
@@ -1019,65 +1093,76 @@ static void devx_obj_build_destroy_cmd(void *in, void *out, void *din,
 				       u32 *dinlen,
 				       u32 *obj_id)
 {
-	u16 obj_type = MLX5_GET(general_obj_in_cmd_hdr, in, obj_type);
+	u16 opcode = MLX5_GET(general_obj_in_cmd_hdr, in, opcode);
 	u16 uid = MLX5_GET(general_obj_in_cmd_hdr, in, uid);

-	*obj_id = MLX5_GET(general_obj_out_cmd_hdr, out, obj_id);
+	*obj_id = devx_get_created_obj_id(in, out, opcode);
 	*dinlen = MLX5_ST_SZ_BYTES(general_obj_in_cmd_hdr);
-
-	MLX5_SET(general_obj_in_cmd_hdr, din, obj_id, *obj_id);
 	MLX5_SET(general_obj_in_cmd_hdr, din, uid, uid);

-	switch (MLX5_GET(general_obj_in_cmd_hdr, in, opcode)) {
+	switch (opcode) {
 	case MLX5_CMD_OP_CREATE_GENERAL_OBJECT:
 		MLX5_SET(general_obj_in_cmd_hdr, din, opcode, MLX5_CMD_OP_DESTROY_GENERAL_OBJECT);
-		MLX5_SET(general_obj_in_cmd_hdr, din, obj_type, obj_type);
+		MLX5_SET(general_obj_in_cmd_hdr, din, obj_id, *obj_id);
+		MLX5_SET(general_obj_in_cmd_hdr, din, obj_type,
+			 MLX5_GET(general_obj_in_cmd_hdr, in, obj_type));
 		break;

 	case MLX5_CMD_OP_CREATE_UMEM:
-		MLX5_SET(general_obj_in_cmd_hdr, din, opcode,
+		MLX5_SET(destroy_umem_in, din, opcode,
 			 MLX5_CMD_OP_DESTROY_UMEM);
+		MLX5_SET(destroy_umem_in, din, umem_id, *obj_id);
 		break;
 	case MLX5_CMD_OP_CREATE_MKEY:
-		MLX5_SET(general_obj_in_cmd_hdr, din, opcode, MLX5_CMD_OP_DESTROY_MKEY);
+		MLX5_SET(destroy_mkey_in, din, opcode,
+			 MLX5_CMD_OP_DESTROY_MKEY);
+		MLX5_SET(destroy_mkey_in, in, mkey_index, *obj_id);
 		break;
 	case MLX5_CMD_OP_CREATE_CQ:
-		MLX5_SET(general_obj_in_cmd_hdr, din, opcode, MLX5_CMD_OP_DESTROY_CQ);
+		MLX5_SET(destroy_cq_in, din, opcode, MLX5_CMD_OP_DESTROY_CQ);
+		MLX5_SET(destroy_cq_in, din, cqn, *obj_id);
 		break;
 	case MLX5_CMD_OP_ALLOC_PD:
-		MLX5_SET(general_obj_in_cmd_hdr, din, opcode, MLX5_CMD_OP_DEALLOC_PD);
+		MLX5_SET(dealloc_pd_in, din, opcode, MLX5_CMD_OP_DEALLOC_PD);
+		MLX5_SET(dealloc_pd_in, din, pd, *obj_id);
 		break;
 	case MLX5_CMD_OP_ALLOC_TRANSPORT_DOMAIN:
-		MLX5_SET(general_obj_in_cmd_hdr, din, opcode,
+		MLX5_SET(dealloc_transport_domain_in, din, opcode,
 			 MLX5_CMD_OP_DEALLOC_TRANSPORT_DOMAIN);
+		MLX5_SET(dealloc_transport_domain_in, din, transport_domain,
+			 *obj_id);
 		break;
 	case MLX5_CMD_OP_CREATE_RMP:
-		MLX5_SET(general_obj_in_cmd_hdr, din, opcode, MLX5_CMD_OP_DESTROY_RMP);
+		MLX5_SET(destroy_rmp_in, din, opcode, MLX5_CMD_OP_DESTROY_RMP);
+		MLX5_SET(destroy_rmp_in, din, rmpn, *obj_id);
 		break;
 	case MLX5_CMD_OP_CREATE_SQ:
-		MLX5_SET(general_obj_in_cmd_hdr, din, opcode, MLX5_CMD_OP_DESTROY_SQ);
+		MLX5_SET(destroy_sq_in, din, opcode, MLX5_CMD_OP_DESTROY_SQ);
+		MLX5_SET(destroy_sq_in, din, sqn, *obj_id);
 		break;
 	case MLX5_CMD_OP_CREATE_RQ:
-		MLX5_SET(general_obj_in_cmd_hdr, din, opcode, MLX5_CMD_OP_DESTROY_RQ);
+		MLX5_SET(destroy_rq_in, din, opcode, MLX5_CMD_OP_DESTROY_RQ);
+		MLX5_SET(destroy_rq_in, din, rqn, *obj_id);
 		break;
 	case MLX5_CMD_OP_CREATE_RQT:
-		MLX5_SET(general_obj_in_cmd_hdr, din, opcode, MLX5_CMD_OP_DESTROY_RQT);
+		MLX5_SET(destroy_rqt_in, din, opcode, MLX5_CMD_OP_DESTROY_RQT);
+		MLX5_SET(destroy_rqt_in, din, rqtn, *obj_id);
 		break;
 	case MLX5_CMD_OP_CREATE_TIR:
-		*obj_id = MLX5_GET(create_tir_out, out, tirn);
 		MLX5_SET(destroy_tir_in, din, opcode, MLX5_CMD_OP_DESTROY_TIR);
 		MLX5_SET(destroy_tir_in, din, tirn, *obj_id);
 		break;
 	case MLX5_CMD_OP_CREATE_TIS:
-		MLX5_SET(general_obj_in_cmd_hdr, din, opcode, MLX5_CMD_OP_DESTROY_TIS);
+		MLX5_SET(destroy_tis_in, din, opcode, MLX5_CMD_OP_DESTROY_TIS);
+		MLX5_SET(destroy_tis_in, din, tisn, *obj_id);
 		break;
 	case MLX5_CMD_OP_ALLOC_Q_COUNTER:
-		MLX5_SET(general_obj_in_cmd_hdr, din, opcode,
+		MLX5_SET(dealloc_q_counter_in, din, opcode,
 			 MLX5_CMD_OP_DEALLOC_Q_COUNTER);
+		MLX5_SET(dealloc_q_counter_in, din, counter_set_id, *obj_id);
 		break;
 	case MLX5_CMD_OP_CREATE_FLOW_TABLE:
 		*dinlen = MLX5_ST_SZ_BYTES(destroy_flow_table_in);
-		*obj_id = MLX5_GET(create_flow_table_out, out, table_id);
 		MLX5_SET(destroy_flow_table_in, din, other_vport,
 			 MLX5_GET(create_flow_table_in,  in, other_vport));
 		MLX5_SET(destroy_flow_table_in, din, vport_number,
@@ -1085,12 +1170,11 @@ static void devx_obj_build_destroy_cmd(void *in, void *out, void *din,
 		MLX5_SET(destroy_flow_table_in, din, table_type,
 			 MLX5_GET(create_flow_table_in,  in, table_type));
 		MLX5_SET(destroy_flow_table_in, din, table_id, *obj_id);
-		MLX5_SET(general_obj_in_cmd_hdr, din, opcode,
+		MLX5_SET(destroy_flow_table_in, din, opcode,
 			 MLX5_CMD_OP_DESTROY_FLOW_TABLE);
 		break;
 	case MLX5_CMD_OP_CREATE_FLOW_GROUP:
 		*dinlen = MLX5_ST_SZ_BYTES(destroy_flow_group_in);
-		*obj_id = MLX5_GET(create_flow_group_out, out, group_id);
 		MLX5_SET(destroy_flow_group_in, din, other_vport,
 			 MLX5_GET(create_flow_group_in, in, other_vport));
 		MLX5_SET(destroy_flow_group_in, din, vport_number,
@@ -1100,12 +1184,11 @@ static void devx_obj_build_destroy_cmd(void *in, void *out, void *din,
 		MLX5_SET(destroy_flow_group_in, din, table_id,
 			 MLX5_GET(create_flow_group_in, in, table_id));
 		MLX5_SET(destroy_flow_group_in, din, group_id, *obj_id);
-		MLX5_SET(general_obj_in_cmd_hdr, din, opcode,
+		MLX5_SET(destroy_flow_group_in, din, opcode,
 			 MLX5_CMD_OP_DESTROY_FLOW_GROUP);
 		break;
 	case MLX5_CMD_OP_SET_FLOW_TABLE_ENTRY:
 		*dinlen = MLX5_ST_SZ_BYTES(delete_fte_in);
-		*obj_id = MLX5_GET(set_fte_in, in, flow_index);
 		MLX5_SET(delete_fte_in, din, other_vport,
 			 MLX5_GET(set_fte_in,  in, other_vport));
 		MLX5_SET(delete_fte_in, din, vport_number,
@@ -1115,63 +1198,70 @@ static void devx_obj_build_destroy_cmd(void *in, void *out, void *din,
 		MLX5_SET(delete_fte_in, din, table_id,
 			 MLX5_GET(set_fte_in, in, table_id));
 		MLX5_SET(delete_fte_in, din, flow_index, *obj_id);
-		MLX5_SET(general_obj_in_cmd_hdr, din, opcode,
+		MLX5_SET(delete_fte_in, din, opcode,
 			 MLX5_CMD_OP_DELETE_FLOW_TABLE_ENTRY);
 		break;
 	case MLX5_CMD_OP_ALLOC_FLOW_COUNTER:
-		MLX5_SET(general_obj_in_cmd_hdr, din, opcode,
+		MLX5_SET(dealloc_flow_counter_in, din, opcode,
 			 MLX5_CMD_OP_DEALLOC_FLOW_COUNTER);
+		MLX5_SET(dealloc_flow_counter_in, din, flow_counter_id,
+			 *obj_id);
 		break;
 	case MLX5_CMD_OP_ALLOC_PACKET_REFORMAT_CONTEXT:
-		MLX5_SET(general_obj_in_cmd_hdr, din, opcode,
+		MLX5_SET(dealloc_packet_reformat_context_in, din, opcode,
 			 MLX5_CMD_OP_DEALLOC_PACKET_REFORMAT_CONTEXT);
+		MLX5_SET(dealloc_packet_reformat_context_in, din,
+			 packet_reformat_id, *obj_id);
 		break;
 	case MLX5_CMD_OP_ALLOC_MODIFY_HEADER_CONTEXT:
-		MLX5_SET(general_obj_in_cmd_hdr, din, opcode,
+		MLX5_SET(dealloc_modify_header_context_in, din, opcode,
 			 MLX5_CMD_OP_DEALLOC_MODIFY_HEADER_CONTEXT);
+		MLX5_SET(dealloc_modify_header_context_in, din,
+			 modify_header_id, *obj_id);
 		break;
 	case MLX5_CMD_OP_CREATE_SCHEDULING_ELEMENT:
 		*dinlen = MLX5_ST_SZ_BYTES(destroy_scheduling_element_in);
-		*obj_id = MLX5_GET(create_scheduling_element_out, out,
-				   scheduling_element_id);
 		MLX5_SET(destroy_scheduling_element_in, din,
 			 scheduling_hierarchy,
 			 MLX5_GET(create_scheduling_element_in, in,
 				  scheduling_hierarchy));
 		MLX5_SET(destroy_scheduling_element_in, din,
 			 scheduling_element_id, *obj_id);
-		MLX5_SET(general_obj_in_cmd_hdr, din, opcode,
+		MLX5_SET(destroy_scheduling_element_in, din, opcode,
 			 MLX5_CMD_OP_DESTROY_SCHEDULING_ELEMENT);
 		break;
 	case MLX5_CMD_OP_ADD_VXLAN_UDP_DPORT:
 		*dinlen = MLX5_ST_SZ_BYTES(delete_vxlan_udp_dport_in);
-		*obj_id = MLX5_GET(add_vxlan_udp_dport_in, in, vxlan_udp_port);
 		MLX5_SET(delete_vxlan_udp_dport_in, din, vxlan_udp_port, *obj_id);
-		MLX5_SET(general_obj_in_cmd_hdr, din, opcode,
+		MLX5_SET(delete_vxlan_udp_dport_in, din, opcode,
 			 MLX5_CMD_OP_DELETE_VXLAN_UDP_DPORT);
 		break;
 	case MLX5_CMD_OP_SET_L2_TABLE_ENTRY:
 		*dinlen = MLX5_ST_SZ_BYTES(delete_l2_table_entry_in);
-		*obj_id = MLX5_GET(set_l2_table_entry_in, in, table_index);
 		MLX5_SET(delete_l2_table_entry_in, din, table_index, *obj_id);
-		MLX5_SET(general_obj_in_cmd_hdr, din, opcode,
+		MLX5_SET(delete_l2_table_entry_in, din, opcode,
 			 MLX5_CMD_OP_DELETE_L2_TABLE_ENTRY);
 		break;
 	case MLX5_CMD_OP_CREATE_QP:
-		MLX5_SET(general_obj_in_cmd_hdr, din, opcode, MLX5_CMD_OP_DESTROY_QP);
+		MLX5_SET(destroy_qp_in, din, opcode, MLX5_CMD_OP_DESTROY_QP);
+		MLX5_SET(destroy_qp_in, din, qpn, *obj_id);
 		break;
 	case MLX5_CMD_OP_CREATE_SRQ:
-		MLX5_SET(general_obj_in_cmd_hdr, din, opcode, MLX5_CMD_OP_DESTROY_SRQ);
+		MLX5_SET(destroy_srq_in, din, opcode, MLX5_CMD_OP_DESTROY_SRQ);
+		MLX5_SET(destroy_srq_in, din, srqn, *obj_id);
 		break;
 	case MLX5_CMD_OP_CREATE_XRC_SRQ:
-		MLX5_SET(general_obj_in_cmd_hdr, din, opcode,
+		MLX5_SET(destroy_xrc_srq_in, din, opcode,
 			 MLX5_CMD_OP_DESTROY_XRC_SRQ);
+		MLX5_SET(destroy_xrc_srq_in, din, xrc_srqn, *obj_id);
 		break;
 	case MLX5_CMD_OP_CREATE_DCT:
-		MLX5_SET(general_obj_in_cmd_hdr, din, opcode, MLX5_CMD_OP_DESTROY_DCT);
+		MLX5_SET(destroy_dct_in, din, opcode, MLX5_CMD_OP_DESTROY_DCT);
+		MLX5_SET(destroy_dct_in, din, dctn, *obj_id);
 		break;
 	case MLX5_CMD_OP_CREATE_XRQ:
-		MLX5_SET(general_obj_in_cmd_hdr, din, opcode, MLX5_CMD_OP_DESTROY_XRQ);
+		MLX5_SET(destroy_xrq_in, din, opcode, MLX5_CMD_OP_DESTROY_XRQ);
+		MLX5_SET(destroy_xrq_in, din, xrqn, *obj_id);
 		break;
 	case MLX5_CMD_OP_ATTACH_TO_MCG:
 		*dinlen = MLX5_ST_SZ_BYTES(detach_from_mcg_in);
@@ -1180,16 +1270,19 @@ static void devx_obj_build_destroy_cmd(void *in, void *out, void *din,
 		memcpy(MLX5_ADDR_OF(detach_from_mcg_in, din, multicast_gid),
 		       MLX5_ADDR_OF(attach_to_mcg_in, in, multicast_gid),
 		       MLX5_FLD_SZ_BYTES(attach_to_mcg_in, multicast_gid));
-		MLX5_SET(general_obj_in_cmd_hdr, din, opcode, MLX5_CMD_OP_DETACH_FROM_MCG);
+		MLX5_SET(detach_from_mcg_in, din, opcode,
+			 MLX5_CMD_OP_DETACH_FROM_MCG);
+		MLX5_SET(detach_from_mcg_in, din, qpn, *obj_id);
 		break;
 	case MLX5_CMD_OP_ALLOC_XRCD:
-		MLX5_SET(general_obj_in_cmd_hdr, din, opcode, MLX5_CMD_OP_DEALLOC_XRCD);
+		MLX5_SET(dealloc_xrcd_in, din, opcode,
+			 MLX5_CMD_OP_DEALLOC_XRCD);
+		MLX5_SET(dealloc_xrcd_in, din, xrcd, *obj_id);
 		break;
 	case MLX5_CMD_OP_CREATE_PSV:
-		MLX5_SET(general_obj_in_cmd_hdr, din, opcode,
+		MLX5_SET(destroy_psv_in, din, opcode,
 			 MLX5_CMD_OP_DESTROY_PSV);
-		MLX5_SET(destroy_psv_in, din, psvn,
-			 MLX5_GET(create_psv_out, out, psv0_index));
+		MLX5_SET(destroy_psv_in, din, psvn, *obj_id);
 		break;
 	default:
 		/* The entry must match to one of the devx_is_obj_create_cmd */
--
2.29.2

