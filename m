Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70DA83CF5FA
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 10:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbhGTHhM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jul 2021 03:37:12 -0400
Received: from mail-bn8nam11on2044.outbound.protection.outlook.com ([40.107.236.44]:51259
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234394AbhGTHhJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Jul 2021 03:37:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUAhodNUVpbf/1yGGXDmXrsZzfUguc/MWhNbJHD1ehhDjpleVn1N+hV42DT1sbgic0PIZmKBEIaJQOrdxhvZMK1Fh0cUtrtKccajXQe35N8147hcm7zMTTnXFzKN0k5nPsfJoyAFuWDugDJYZ9kS5nwBDTZPJrDFmIcarPhBx89EoZ5YgVo4pM1MGnPqx0PlXQqqq81AyE7lDnnbAdzRrksyDZrQkfahl4/hAsG3+ceF6WkNniTmtSZR7zD9F5T3WVlGIKHsbsqp6odFVV9xmSJCx6WgtfAPG2jQXqzV3UKEWxfd5NUwkpttg/UNkX1WxEeSIiJShQBY5nvZupve9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gk7cuq9rzuZCGrqzxs4VBvOwzGD2ECczov1NvjQ8Gkc=;
 b=GvvOXzaabwsrRb3LzMDZ2CXASk+VYBfhXV7jh2SGZGzWuuINqHBD9PsvK6cydeGqtiotDphx0gMm/kDDFfhtMS4xCmB/QaKfIhnNKPi73DKAcQEwDXekdEE/K4eZrJvD/YsFFjTLSAhQOiVpFuV0k9BUqxI+Z2IGr/0ZNe3yP23tzxN5Rlh7RX/U1TEgyd5OLn5UH7x7XRzDI08osfPCsspBVlG3h0IvOw/R0ahN28S/1TKuypS2dsFylLMlTEvJNvECZfSflYAWg8BZbEP/Y4pFmKPuR6KnxPVFKgtkdbhxWOKyu1h9/KRlCLjvwC0crYUNDsFEzeR1X5wk7DhdGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gk7cuq9rzuZCGrqzxs4VBvOwzGD2ECczov1NvjQ8Gkc=;
 b=JXABQiiHQ12Xi9ggvDXyghUv5irapNysAmQklyqgTOhcexL3Rk8KpLd6rA8rT3OY2a28xm/SVlQCsr0dPIrgd0QlP52aBaBT1UysJ/guL0db2AoWL0zrZpLNsflgdaKc07U2emuqkhc3DfswHL+IhbDiwz4mhjcc8sb+bmHfUxL2P0Ek1FN8cE3S6D/pwJX/IsOHAZp+vWRpBdLcjtKVW4wYDF8+3gyGezEDABlepdfMooe65zUEjbgYJnWIm+9WmZqQeMViGNKtaheLgCDjRpI1aa0ohk5hiMNedrsNE+NUrYq2lqTjrM0NXSklqVK8lFOrBeX+IUOlNqywK/KDpg==
Received: from BN1PR10CA0004.namprd10.prod.outlook.com (2603:10b6:408:e0::9)
 by CH0PR12MB5298.namprd12.prod.outlook.com (2603:10b6:610:d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 20 Jul
 2021 08:17:46 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::79) by BN1PR10CA0004.outlook.office365.com
 (2603:10b6:408:e0::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Tue, 20 Jul 2021 08:17:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 08:17:46 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 08:17:45 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Jul 2021 01:17:43 -0700
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <markzhang@nvidia.com>, <edwards@nvidia.com>
Subject: [PATCH rdma-core 08/27] mlx5: vfio setup function support
Date:   Tue, 20 Jul 2021 11:16:28 +0300
Message-ID: <20210720081647.1980-9-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210720081647.1980-1-yishaih@nvidia.com>
References: <20210720081647.1980-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80e73930-7d3c-4ca7-4fda-08d94b56db3b
X-MS-TrafficTypeDiagnostic: CH0PR12MB5298:
X-Microsoft-Antispam-PRVS: <CH0PR12MB52985CB9B09E34A2E6D74B86C3E29@CH0PR12MB5298.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:323;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sZSwmYBmnPi0sJQG6+ft5pVs+HWVDpMrWesTMzMIRE05Is4NWIB55hc/C8JVKy1SpaScmGitIyO7T7gwfMwtYXxXkgmJxaU6Ob8U+JgpX+Etr6yOlE24bYTIDMSGcsn5m7CyJHMVy4XEY6+RRb6NabrLWsbJCmTzQ9xdWA3i2n0NhBACghUCbKL7QwIfdHn6tbYHqirrtCapWNJbWsEywWlCz2LZR9aamy4MFFkmQN5GMA4arwU1oayrP9kOcpCyNDn4Mf9NhYcsOHDEt/jWC6ZzW8Rh3TykUcwnbDpsKVBc4xrixuKFRz1x4KN+2PlXnc1HZAIbkGwaozgbLdLOtK7MRjQPiProwZKxvQ4V0xaVr32bLjV1co2eaElX/rihoTtjxVAHUeppLHJKLlGsPGPNFj3wNQzFDK8/CkzU6nfRcZQHkZxaG6xRm0whfzb7RS09hbsP9voqUxJtSjTYwweLQAaDFpBJsPzkv+s4v2pWY2zYKIyHGVYaDm14mzZTZTa57LcAiag4z5UMB9CKHxoLI+DcYBKvHJVm12WFk7um6uzZk2mZg2kyTMqGkFgLDnv7daweRPk9bRhmfaGZV5GBDkZOVJ56IKCD2blwGD4cWHgeop9CWZZlKveQcQaS4RPxHPMKgfl84b4YSIA5lGI1DonFONtZPYrBCl2AjqTI+YFe/2Q314moOytGIwcqoXYogscfnc5++X1k55xXyQ==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(36840700001)(46966006)(82310400003)(36756003)(336012)(70586007)(70206006)(30864003)(7636003)(1076003)(7696005)(83380400001)(2906002)(47076005)(6916009)(36860700001)(82740400003)(4326008)(186003)(478600001)(86362001)(426003)(356005)(36906005)(2616005)(5660300002)(8936002)(316002)(26005)(54906003)(107886003)(8676002)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 08:17:46.5384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e73930-7d3c-4ca7-4fda-08d94b56db3b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5298
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Setup device function support by following the required command sequence
and steps based on the device specification.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 providers/mlx5/mlx5_ifc.h  | 215 +++++++++++++++++++++++++++++++++++++++
 providers/mlx5/mlx5_vfio.c | 246 +++++++++++++++++++++++++++++++++++++++++++++
 providers/mlx5/mlx5_vfio.h |  16 +++
 providers/mlx5/mlx5dv.h    |   4 +
 4 files changed, 481 insertions(+)

diff --git a/providers/mlx5/mlx5_ifc.h b/providers/mlx5/mlx5_ifc.h
index aef6196..ac741cd 100644
--- a/providers/mlx5/mlx5_ifc.h
+++ b/providers/mlx5/mlx5_ifc.h
@@ -41,6 +41,13 @@ enum mlx5_cap_mode {
 
 enum {
 	MLX5_CMD_OP_QUERY_HCA_CAP = 0x100,
+	MLX5_CMD_OP_INIT_HCA = 0x102,
+	MLX5_CMD_OP_TEARDOWN_HCA = 0x103,
+	MLX5_CMD_OP_ENABLE_HCA = 0x104,
+	MLX5_CMD_OP_QUERY_PAGES = 0x107,
+	MLX5_CMD_OP_MANAGE_PAGES = 0x108,
+	MLX5_CMD_OP_QUERY_ISSI = 0x10a,
+	MLX5_CMD_OP_SET_ISSI = 0x10b,
 	MLX5_CMD_OP_CREATE_MKEY = 0x200,
 	MLX5_CMD_OP_CREATE_QP = 0x500,
 	MLX5_CMD_OP_RST2INIT_QP = 0x502,
@@ -55,6 +62,7 @@ enum {
 	MLX5_CMD_OP_QUERY_ESW_VPORT_CONTEXT = 0x752,
 	MLX5_CMD_OP_QUERY_NIC_VPORT_CONTEXT = 0x754,
 	MLX5_CMD_OP_QUERY_ROCE_ADDRESS = 0x760,
+	MLX5_CMD_OP_ACCESS_REG = 0x805,
 	MLX5_CMD_OP_QUERY_LAG = 0x842,
 	MLX5_CMD_OP_CREATE_TIR = 0x900,
 	MLX5_CMD_OP_MODIFY_SQ = 0x905,
@@ -92,6 +100,16 @@ enum {
 	MLX5_CMD_STAT_BAD_SIZE_OUTS_CQES_ERR = 0x40,
 };
 
+enum {
+	MLX5_PAGES_CANT_GIVE = 0,
+	MLX5_PAGES_GIVE = 1,
+	MLX5_PAGES_TAKE = 2,
+};
+
+enum {
+	MLX5_REG_HOST_ENDIANNESS = 0x7004,
+};
+
 struct mlx5_ifc_atomic_caps_bits {
 	u8         reserved_at_0[0x40];
 
@@ -4131,4 +4149,201 @@ struct mlx5_ifc_mbox_in_bits {
 	u8	reserved_at_40[0x40];
 };
 
+struct mlx5_ifc_enable_hca_in_bits {
+	u8         opcode[0x10];
+	u8         reserved_at_10[0x10];
+
+	u8         reserved_at_20[0x10];
+	u8         op_mod[0x10];
+
+	u8         reserved_at_40[0x10];
+	u8         function_id[0x10];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_enable_hca_out_bits {
+	u8         status[0x8];
+	u8         reserved_at_8[0x18];
+
+	u8         syndrome[0x20];
+
+	u8         reserved_at_40[0x20];
+};
+
+struct mlx5_ifc_query_issi_out_bits {
+	u8         status[0x8];
+	u8         reserved_at_8[0x18];
+
+	u8         syndrome[0x20];
+
+	u8         reserved_at_40[0x10];
+	u8         current_issi[0x10];
+
+	u8         reserved_at_60[0xa0];
+
+	u8         reserved_at_100[76][0x8];
+	u8         supported_issi_dw0[0x20];
+};
+
+struct mlx5_ifc_query_issi_in_bits {
+	u8         opcode[0x10];
+	u8         reserved_at_10[0x10];
+
+	u8         reserved_at_20[0x10];
+	u8         op_mod[0x10];
+
+	u8         reserved_at_40[0x40];
+};
+
+struct mlx5_ifc_set_issi_out_bits {
+	u8         status[0x8];
+	u8         reserved_at_8[0x18];
+
+	u8         syndrome[0x20];
+
+	u8         reserved_at_40[0x40];
+};
+
+struct mlx5_ifc_set_issi_in_bits {
+	u8         opcode[0x10];
+	u8         reserved_at_10[0x10];
+
+	u8         reserved_at_20[0x10];
+	u8         op_mod[0x10];
+
+	u8         reserved_at_40[0x10];
+	u8         current_issi[0x10];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_query_pages_out_bits {
+	u8         status[0x8];
+	u8         reserved_at_8[0x18];
+
+	u8         syndrome[0x20];
+
+	u8	   embedded_cpu_function[0x01];
+	u8	   reserved_bits[0x0f];
+	u8	   function_id[0x10];
+
+	u8	   num_pages[0x20];
+};
+
+struct mlx5_ifc_query_pages_in_bits {
+	u8	opcode[0x10];
+	u8	reserved_at_10[0x10];
+
+	u8	reserved_at_20[0x10];
+	u8	op_mod[0x10];
+
+	u8	reserved_at_40[0x10];
+	u8	function_id[0x10];
+
+	u8	reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_manage_pages_out_bits {
+	u8         status[0x8];
+	u8         reserved_at_8[0x18];
+
+	u8         syndrome[0x20];
+
+	u8         output_num_entries[0x20];
+
+	u8         reserved_at_60[0x20];
+
+	u8         pas[][0x40];
+};
+
+struct mlx5_ifc_manage_pages_in_bits {
+	u8         opcode[0x10];
+	u8         reserved_at_10[0x10];
+
+	u8         reserved_at_20[0x10];
+	u8         op_mod[0x10];
+
+	u8         embedded_cpu_function[0x1];
+	u8         reserved_at_41[0xf];
+	u8         function_id[0x10];
+
+	u8         input_num_entries[0x20];
+
+	u8         pas[][0x40];
+};
+
+struct mlx5_ifc_teardown_hca_out_bits {
+	u8         status[0x8];
+	u8         reserved_at_8[0x18];
+
+	u8         syndrome[0x20];
+
+	u8         reserved_at_40[0x3f];
+
+	u8         state[0x1];
+};
+
+enum {
+	MLX5_TEARDOWN_HCA_IN_PROFILE_GRACEFUL_CLOSE = 0x0,
+};
+
+struct mlx5_ifc_teardown_hca_in_bits {
+	u8         opcode[0x10];
+	u8         reserved_at_10[0x10];
+
+	u8         reserved_at_20[0x10];
+	u8         op_mod[0x10];
+
+	u8         reserved_at_40[0x10];
+	u8         profile[0x10];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_init_hca_out_bits {
+	u8         status[0x8];
+	u8         reserved_at_8[0x18];
+
+	u8         syndrome[0x20];
+
+	u8         reserved_at_40[0x40];
+};
+
+struct mlx5_ifc_init_hca_in_bits {
+	u8         opcode[0x10];
+	u8         reserved_at_10[0x10];
+
+	u8         reserved_at_20[0x10];
+	u8         op_mod[0x10];
+
+	u8         reserved_at_40[0x40];
+};
+
+struct mlx5_ifc_access_register_out_bits {
+	u8         status[0x8];
+	u8         reserved_at_8[0x18];
+
+	u8         syndrome[0x20];
+
+	u8         reserved_at_40[0x40];
+
+	u8         register_data[][0x20];
+};
+
+struct mlx5_ifc_access_register_in_bits {
+	u8         opcode[0x10];
+	u8         reserved_at_10[0x10];
+
+	u8         reserved_at_20[0x10];
+	u8         op_mod[0x10];
+
+	u8         reserved_at_40[0x10];
+	u8         register_id[0x10];
+
+	u8         argument[0x20];
+
+	u8         register_data[][0x20];
+};
+
 #endif /* MLX5_IFC_H */
diff --git a/providers/mlx5/mlx5_vfio.c b/providers/mlx5/mlx5_vfio.c
index 37f06a9..4d12807 100644
--- a/providers/mlx5/mlx5_vfio.c
+++ b/providers/mlx5/mlx5_vfio.c
@@ -988,6 +988,246 @@ close_cont:
 	return -1;
 }
 
+static int mlx5_vfio_enable_hca(struct mlx5_vfio_context *ctx)
+{
+	uint32_t in[DEVX_ST_SZ_DW(enable_hca_in)] = {};
+	uint32_t out[DEVX_ST_SZ_DW(enable_hca_out)] = {};
+
+	DEVX_SET(enable_hca_in, in, opcode, MLX5_CMD_OP_ENABLE_HCA);
+	return mlx5_vfio_cmd_exec(ctx, in, sizeof(in), out, sizeof(out), 0);
+}
+
+static int mlx5_vfio_set_issi(struct mlx5_vfio_context *ctx)
+{
+	uint32_t query_in[DEVX_ST_SZ_DW(query_issi_in)] = {};
+	uint32_t query_out[DEVX_ST_SZ_DW(query_issi_out)] = {};
+	uint32_t set_in[DEVX_ST_SZ_DW(set_issi_in)] = {};
+	uint32_t set_out[DEVX_ST_SZ_DW(set_issi_out)] = {};
+	uint32_t sup_issi;
+	int err;
+
+	DEVX_SET(query_issi_in, query_in, opcode, MLX5_CMD_OP_QUERY_ISSI);
+	err = mlx5_vfio_cmd_exec(ctx, query_in, sizeof(query_in), query_out,
+				 sizeof(query_out), 0);
+	if (err)
+		return err;
+
+	sup_issi = DEVX_GET(query_issi_out, query_out, supported_issi_dw0);
+
+	if (!(sup_issi & (1 << 1))) {
+		errno = EOPNOTSUPP;
+		return errno;
+	}
+
+	DEVX_SET(set_issi_in, set_in, opcode, MLX5_CMD_OP_SET_ISSI);
+	DEVX_SET(set_issi_in, set_in, current_issi, 1);
+	return mlx5_vfio_cmd_exec(ctx, set_in, sizeof(set_in), set_out,
+				  sizeof(set_out), 0);
+}
+
+static int mlx5_vfio_give_pages(struct mlx5_vfio_context *ctx,
+				uint16_t func_id,
+				int32_t npages)
+{
+	int32_t out[DEVX_ST_SZ_DW(manage_pages_out)] = {};
+	int inlen = DEVX_ST_SZ_BYTES(manage_pages_in);
+	int i, err;
+	int32_t *in;
+	uint64_t iova;
+
+	inlen += npages * DEVX_FLD_SZ_BYTES(manage_pages_in, pas[0]);
+	in = calloc(1, inlen);
+	if (!in) {
+		errno = ENOMEM;
+		return errno;
+	}
+
+	for (i = 0; i < npages; i++) {
+		err = mlx5_vfio_alloc_page(ctx, &iova);
+		if (err)
+			goto err;
+
+		DEVX_ARRAY_SET64(manage_pages_in, in, pas, i, iova);
+	}
+
+	DEVX_SET(manage_pages_in, in, opcode, MLX5_CMD_OP_MANAGE_PAGES);
+	DEVX_SET(manage_pages_in, in, op_mod, MLX5_PAGES_GIVE);
+	DEVX_SET(manage_pages_in, in, function_id, func_id);
+	DEVX_SET(manage_pages_in, in, input_num_entries, npages);
+
+	err = mlx5_vfio_cmd_exec(ctx, in, inlen, out, sizeof(out),
+				 MLX5_MAX_COMMANDS - 1);
+	if (!err)
+		goto end;
+err:
+	for (i--; i >= 0; i--)
+		mlx5_vfio_free_page(ctx, DEVX_GET64(manage_pages_in, in, pas[i]));
+end:
+	free(in);
+	return err;
+}
+
+static int mlx5_vfio_query_pages(struct mlx5_vfio_context *ctx, int boot,
+				 uint16_t *func_id, int32_t *npages)
+{
+	uint32_t query_pages_in[DEVX_ST_SZ_DW(query_pages_in)] = {};
+	uint32_t query_pages_out[DEVX_ST_SZ_DW(query_pages_out)] = {};
+	int ret;
+
+	DEVX_SET(query_pages_in, query_pages_in, opcode, MLX5_CMD_OP_QUERY_PAGES);
+	DEVX_SET(query_pages_in, query_pages_in, op_mod, boot ? 0x01 : 0x02);
+
+	ret = mlx5_vfio_cmd_exec(ctx, query_pages_in, sizeof(query_pages_in),
+				 query_pages_out, sizeof(query_pages_out), 0);
+	if (ret)
+		return ret;
+
+	*npages = DEVX_GET(query_pages_out, query_pages_out, num_pages);
+	*func_id = DEVX_GET(query_pages_out, query_pages_out, function_id);
+
+	return 0;
+}
+
+static int mlx5_vfio_satisfy_startup_pages(struct mlx5_vfio_context *ctx,
+					   int boot)
+{
+	uint16_t function_id;
+	int32_t npages = 0;
+	int ret;
+
+	ret = mlx5_vfio_query_pages(ctx, boot, &function_id, &npages);
+	if (ret)
+		return ret;
+
+	return mlx5_vfio_give_pages(ctx, function_id, npages);
+}
+
+static int mlx5_vfio_access_reg(struct mlx5_vfio_context *ctx, void *data_in,
+				int size_in, void *data_out, int size_out,
+				uint16_t reg_id, int arg, int write)
+{
+	int outlen = DEVX_ST_SZ_BYTES(access_register_out) + size_out;
+	int inlen = DEVX_ST_SZ_BYTES(access_register_in) + size_in;
+	int err = ENOMEM;
+	uint32_t *out = NULL;
+	uint32_t *in = NULL;
+	void *data;
+
+	in = calloc(1, inlen);
+	out = calloc(1, outlen);
+	if (!in || !out) {
+		errno = ENOMEM;
+		goto out;
+	}
+
+	data = DEVX_ADDR_OF(access_register_in, in, register_data);
+	memcpy(data, data_in, size_in);
+
+	DEVX_SET(access_register_in, in, opcode, MLX5_CMD_OP_ACCESS_REG);
+	DEVX_SET(access_register_in, in, op_mod, !write);
+	DEVX_SET(access_register_in, in, argument, arg);
+	DEVX_SET(access_register_in, in, register_id, reg_id);
+
+	err = mlx5_vfio_cmd_exec(ctx, in, inlen, out, outlen, 0);
+	if (err)
+		goto out;
+
+	data = DEVX_ADDR_OF(access_register_out, out, register_data);
+	memcpy(data_out, data, size_out);
+
+out:
+	free(out);
+	free(in);
+	return err;
+}
+
+static int mlx5_vfio_set_hca_ctrl(struct mlx5_vfio_context *ctx)
+{
+	struct mlx5_reg_host_endianness he_in = {};
+	struct mlx5_reg_host_endianness he_out = {};
+
+	he_in.he = MLX5_SET_HOST_ENDIANNESS;
+	return mlx5_vfio_access_reg(ctx, &he_in, sizeof(he_in),
+				    &he_out, sizeof(he_out),
+				    MLX5_REG_HOST_ENDIANNESS, 0, 1);
+}
+
+static int mlx5_vfio_init_hca(struct mlx5_vfio_context *ctx)
+{
+	uint32_t in[DEVX_ST_SZ_DW(init_hca_in)] = {};
+	uint32_t out[DEVX_ST_SZ_DW(init_hca_out)] = {};
+
+	DEVX_SET(init_hca_in, in, opcode, MLX5_CMD_OP_INIT_HCA);
+	return mlx5_vfio_cmd_exec(ctx, in, sizeof(in), out, sizeof(out), 0);
+}
+
+static int fw_initializing(struct mlx5_init_seg *init_seg)
+{
+	return be32toh(init_seg->initializing) >> 31;
+}
+
+static int wait_fw_init(struct mlx5_init_seg *init_seg, uint32_t max_wait_mili)
+{
+	int num_loops = max_wait_mili / FW_INIT_WAIT_MS;
+	int loop = 0;
+
+	while (fw_initializing(init_seg)) {
+		usleep(FW_INIT_WAIT_MS * 1000);
+		loop++;
+		if (loop == num_loops) {
+			errno = EBUSY;
+			return errno;
+		}
+	}
+
+	return 0;
+}
+
+static int mlx5_vfio_teardown_hca(struct mlx5_vfio_context *ctx)
+{
+	uint32_t in[DEVX_ST_SZ_DW(teardown_hca_in)] = {};
+	uint32_t out[DEVX_ST_SZ_DW(teardown_hca_out)] = {};
+
+	DEVX_SET(teardown_hca_in, in, opcode, MLX5_CMD_OP_TEARDOWN_HCA);
+	DEVX_SET(teardown_hca_in, in, profile, MLX5_TEARDOWN_HCA_IN_PROFILE_GRACEFUL_CLOSE);
+	return mlx5_vfio_cmd_exec(ctx, in, sizeof(in), out, sizeof(out), 0);
+}
+
+static int mlx5_vfio_setup_function(struct mlx5_vfio_context *ctx)
+{
+	int err;
+
+	err = wait_fw_init(ctx->bar_map, FW_PRE_INIT_TIMEOUT_MILI);
+	if (err)
+		return err;
+
+	err = mlx5_vfio_enable_hca(ctx);
+	if (err)
+		return err;
+
+	err = mlx5_vfio_set_issi(ctx);
+	if (err)
+		return err;
+
+	err = mlx5_vfio_satisfy_startup_pages(ctx, 1);
+	if (err)
+		return err;
+
+	err = mlx5_vfio_set_hca_ctrl(ctx);
+	if (err)
+		return err;
+
+	err = mlx5_vfio_satisfy_startup_pages(ctx, 0);
+	if (err)
+		return err;
+
+	err = mlx5_vfio_init_hca(ctx);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 static void mlx5_vfio_uninit_context(struct mlx5_vfio_context *ctx)
 {
 	mlx5_close_debug_file(ctx->dbg_fp);
@@ -1000,6 +1240,7 @@ static void mlx5_vfio_free_context(struct ibv_context *ibctx)
 {
 	struct mlx5_vfio_context *ctx = to_mvfio_ctx(ibctx);
 
+	mlx5_vfio_teardown_hca(ctx);
 	mlx5_vfio_clean_cmd_interface(ctx);
 	mlx5_vfio_clean_device_dma(ctx);
 	mlx5_vfio_uninit_bar0(ctx);
@@ -1040,9 +1281,14 @@ mlx5_vfio_alloc_context(struct ibv_device *ibdev,
 	if (mlx5_vfio_init_cmd_interface(mctx))
 		goto err_dma;
 
+	if (mlx5_vfio_setup_function(mctx))
+		goto clean_cmd;
+
 	verbs_set_ops(&mctx->vctx, &mlx5_vfio_common_ops);
 	return &mctx->vctx;
 
+clean_cmd:
+	mlx5_vfio_clean_cmd_interface(mctx);
 err_dma:
 	mlx5_vfio_clean_device_dma(mctx);
 err_bar:
diff --git a/providers/mlx5/mlx5_vfio.h b/providers/mlx5/mlx5_vfio.h
index 392ddcb..36b1f40 100644
--- a/providers/mlx5/mlx5_vfio.h
+++ b/providers/mlx5/mlx5_vfio.h
@@ -13,6 +13,9 @@
 #include <infiniband/driver.h>
 #include <util/interval_set.h>
 
+#define FW_INIT_WAIT_MS 2
+#define FW_PRE_INIT_TIMEOUT_MILI 120000
+
 enum {
 	MLX5_MAX_COMMANDS = 32,
 	MLX5_CMD_DATA_BLOCK_SIZE = 512,
@@ -32,6 +35,19 @@ struct mlx5_vfio_device {
 	uint32_t flags;
 };
 
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+#define MLX5_SET_HOST_ENDIANNESS 0
+#elif __BYTE_ORDER == __BIG_ENDIAN
+#define MLX5_SET_HOST_ENDIANNESS 0x80
+#else
+#error Host endianness not defined
+#endif
+
+struct mlx5_reg_host_endianness {
+	uint8_t he;
+	uint8_t rsvd[15];
+};
+
 struct health_buffer {
 	__be32		assert_var[5];
 	__be32		rsvd0[3];
diff --git a/providers/mlx5/mlx5dv.h b/providers/mlx5/mlx5dv.h
index e657527..6aaea37 100644
--- a/providers/mlx5/mlx5dv.h
+++ b/providers/mlx5/mlx5dv.h
@@ -1687,6 +1687,10 @@ static inline uint64_t _devx_get64(const void *p, size_t bit_off)
 
 #define DEVX_GET64(typ, p, fld) _devx_get64(p, __devx_bit_off(typ, fld))
 
+#define DEVX_ARRAY_SET64(typ, p, fld, idx, v) do { \
+	DEVX_SET64(typ, p, fld[idx], v); \
+} while (0)
+
 struct mlx5dv_dr_domain;
 struct mlx5dv_dr_table;
 struct mlx5dv_dr_matcher;
-- 
1.8.3.1

