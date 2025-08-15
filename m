Return-Path: <linux-rdma+bounces-12781-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FC3B2869C
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Aug 2025 21:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F63D4E42A1
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Aug 2025 19:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4EC29B8DD;
	Fri, 15 Aug 2025 19:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJcQ0y8f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA82298CB7;
	Fri, 15 Aug 2025 19:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755287347; cv=none; b=P6rM2V/cLIsfBTZfCWxkn9euWvkEn5N4LNBajogOJrUFoUke0VyUCUFq4GWuLx5sTa2VIeN+Y8tV6AtsSVEZb/HNsL56VeW95sFCOLLFFh+rB4LjQC93pGUtKaavPYJhBFS6idsUOPXTpjb7MlDtDbyudeaLExH35C9QC8RHTJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755287347; c=relaxed/simple;
	bh=ZdMwwDi44CBlBL96tREaUSFD4UvArqAeYJ7b4CXbswg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T0BIrxl/aQHEUS/O02raM6MMWPyn07NDGAbueox5eKk6bc7+J3lrtV9PRAk7xZbI+iphROpYNvFrucsI3Ck+c3d+O9JBATi3lo9FB1el3SJyrZXIChBIeR+0FWlYfi4NJEz8FuA2oBzKGVfYDVqLssZ6I+Mj7daSc6T0kRO33Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJcQ0y8f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7422FC4CEEB;
	Fri, 15 Aug 2025 19:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755287346;
	bh=ZdMwwDi44CBlBL96tREaUSFD4UvArqAeYJ7b4CXbswg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sJcQ0y8fpbYUBRi7KYhe8AX3rFY8ng2b1HTPpaZ4DIl6mbWPtiR0hQZhwuvBpAJUp
	 WEEjmkhjFgPDW737Aku91n8X/LqNLGUKLvRhP+sZurrNZsz0Z03Gun3kjgzC0+ESLI
	 qKrbVCeiXYtpx75nhpL/W499raun8TFI5RZpgHim1p8csC3WR08qHw5KlYo5+uxLrv
	 PrHJUIJqTCeJh7WzrvpW1gnq2yNXADgvMmjyhZQmYQC+ey1tTa0/gMNBbUzMBUxiX6
	 LJrNEXJY5yeLnVPOc6KJsMLGCsysN3C1bz9wJnxl0tYm7ORwKhYdUy3Fk0oqKRMnF0
	 E7g8Q+JHRHewQ==
From: Saeed Mahameed <saeed@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Parav Pandit <parav@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Jack Morgenstein <jackm@nvidia.com>,
	Alexei Lazar <alazar@nvidia.com>
Subject: [PATCH mlx5-next 1/4] net/mlx5: mlx5_ifc, Add hardware definitions needed for adjacent vports
Date: Fri, 15 Aug 2025 12:48:58 -0700
Message-ID: <20250815194901.298689-2-saeed@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815194901.298689-1-saeed@kernel.org>
References: <20250815194901.298689-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Next patches will implement the discovery and creation of adjacent
functions vports, this patch introduces the hardware structures
definitions needed for the driver implementation.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Jack Morgenstein <jackm@nvidia.com>
Signed-off-by: Alexei Lazar <alazar@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 133 +++++++++++++++++++++++++++++++++-
 1 file changed, 129 insertions(+), 4 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 8360d9011d4f..44d497272162 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -189,6 +189,9 @@ enum {
 	MLX5_CMD_OP_QUERY_XRQ_ERROR_PARAMS        = 0x727,
 	MLX5_CMD_OP_RELEASE_XRQ_ERROR             = 0x729,
 	MLX5_CMD_OP_MODIFY_XRQ                    = 0x72a,
+	MLX5_CMD_OPCODE_QUERY_DELEGATED_VHCA      = 0x732,
+	MLX5_CMD_OPCODE_CREATE_ESW_VPORT          = 0x733,
+	MLX5_CMD_OPCODE_DESTROY_ESW_VPORT         = 0x734,
 	MLX5_CMD_OP_QUERY_ESW_FUNCTIONS           = 0x740,
 	MLX5_CMD_OP_QUERY_VPORT_STATE             = 0x750,
 	MLX5_CMD_OP_MODIFY_VPORT_STATE            = 0x751,
@@ -2207,7 +2210,19 @@ struct mlx5_ifc_cmd_hca_cap_2_bits {
 
 	u8	   reserved_at_440[0x8];
 	u8	   max_num_eqs_24b[0x18];
-	u8	   reserved_at_460[0x3a0];
+
+	u8         reserved_at_460[0x160];
+
+	u8         query_adjacent_functions_id[0x1];
+	u8         ingress_egress_esw_vport_connect[0x1];
+	u8         function_id_type_vhca_id[0x1];
+	u8         reserved_at_5c3[0xd];
+	u8         delegate_vhca_management_profiles[0x10];
+
+	u8         delegated_vhca_max[0x10];
+	u8         delegate_vhca_max[0x10];
+
+	u8         reserved_at_600[0x200];
 };
 
 enum mlx5_ifc_flow_destination_type {
@@ -5159,7 +5174,9 @@ struct mlx5_ifc_set_hca_cap_in_bits {
 
 	u8         other_function[0x1];
 	u8         ec_vf_function[0x1];
-	u8         reserved_at_42[0xe];
+	u8         reserved_at_42[0x1];
+	u8         function_id_type[0x1];
+	u8         reserved_at_44[0xc];
 	u8         function_id[0x10];
 
 	u8         reserved_at_60[0x20];
@@ -6357,7 +6374,9 @@ struct mlx5_ifc_query_hca_cap_in_bits {
 
 	u8         other_function[0x1];
 	u8         ec_vf_function[0x1];
-	u8         reserved_at_42[0xe];
+	u8         reserved_at_42[0x1];
+	u8         function_id_type[0x1];
+	u8         reserved_at_44[0xc];
 	u8         function_id[0x10];
 
 	u8         reserved_at_60[0x20];
@@ -6983,6 +7002,28 @@ struct mlx5_ifc_query_esw_vport_context_in_bits {
 	u8         reserved_at_60[0x20];
 };
 
+struct mlx5_ifc_destroy_esw_vport_out_bits {
+	u8         status[0x8];
+	u8         reserved_at_8[0x18];
+
+	u8         syndrome[0x20];
+
+	u8         reserved_at_40[0x20];
+};
+
+struct mlx5_ifc_destroy_esw_vport_in_bits {
+	u8         opcode[0x10];
+	u8         uid[0x10];
+
+	u8         reserved_at_20[0x10];
+	u8         op_mod[0x10];
+
+	u8         reserved_at_40[0x10];
+	u8         vport_num[0x10];
+
+	u8         reserved_at_60[0x20];
+};
+
 struct mlx5_ifc_modify_esw_vport_context_out_bits {
 	u8         status[0x8];
 	u8         reserved_at_8[0x18];
@@ -7484,6 +7525,85 @@ struct mlx5_ifc_query_adapter_in_bits {
 	u8         reserved_at_40[0x40];
 };
 
+struct mlx5_ifc_function_vhca_rid_info_reg_bits {
+	u8         host_number[0x8];
+	u8         host_pci_device_function[0x8];
+	u8         host_pci_bus[0x8];
+	u8         reserved_at_18[0x3];
+	u8         pci_bus_assigned[0x1];
+	u8         function_type[0x4];
+
+	u8         parent_pci_device_function[0x8];
+	u8         parent_pci_bus[0x8];
+	u8         vhca_id[0x10];
+
+	u8         reserved_at_40[0x10];
+	u8         function_id[0x10];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_delegated_function_vhca_rid_info_bits {
+	struct mlx5_ifc_function_vhca_rid_info_reg_bits function_vhca_rid_info;
+
+	u8         reserved_at_80[0x18];
+	u8         manage_profile[0x8];
+
+	u8         reserved_at_a0[0x60];
+};
+
+struct mlx5_ifc_query_delegated_vhca_out_bits {
+	u8         status[0x8];
+	u8         reserved_at_8[0x18];
+
+	u8         syndrome[0x20];
+
+	u8         reserved_at_40[0x20];
+
+	u8         reserved_at_60[0x10];
+	u8         functions_count[0x10];
+
+	u8         reserved_at_80[0x80];
+
+	struct mlx5_ifc_delegated_function_vhca_rid_info_bits
+			delegated_function_vhca_rid_info[];
+};
+
+struct mlx5_ifc_query_delegated_vhca_in_bits {
+	u8         opcode[0x10];
+	u8         uid[0x10];
+
+	u8         reserved_at_20[0x10];
+	u8         op_mod[0x10];
+
+	u8         reserved_at_40[0x40];
+};
+
+struct mlx5_ifc_create_esw_vport_out_bits {
+	u8         status[0x8];
+	u8         reserved_at_8[0x18];
+
+	u8         syndrome[0x20];
+
+	u8         reserved_at_40[0x20];
+
+	u8         reserved_at_60[0x10];
+	u8         vport_num[0x10];
+};
+
+struct mlx5_ifc_create_esw_vport_in_bits {
+	u8         opcode[0x10];
+	u8         reserved_at_10[0x10];
+
+	u8         reserved_at_20[0x10];
+	u8         op_mod[0x10];
+
+	u8         reserved_at_40[0x10];
+	u8         managed_vhca_id[0x10];
+
+	u8         reserved_at_60[0x20];
+};
+
 struct mlx5_ifc_qp_2rst_out_bits {
 	u8         status[0x8];
 	u8         reserved_at_8[0x18];
@@ -7611,7 +7731,12 @@ struct mlx5_ifc_modify_vport_state_in_bits {
 	u8         reserved_at_41[0xf];
 	u8         vport_number[0x10];
 
-	u8         reserved_at_60[0x18];
+	u8         reserved_at_60[0x10];
+	u8         ingress_connect[0x1];
+	u8         egress_connect[0x1];
+	u8         ingress_connect_valid[0x1];
+	u8         egress_connect_valid[0x1];
+	u8         reserved_at_74[0x4];
 	u8         admin_state[0x4];
 	u8         reserved_at_7c[0x4];
 };
-- 
2.50.1


