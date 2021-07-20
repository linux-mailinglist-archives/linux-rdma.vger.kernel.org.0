Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E6A3CF5FB
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 10:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbhGTHhW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jul 2021 03:37:22 -0400
Received: from mail-bn1nam07on2058.outbound.protection.outlook.com ([40.107.212.58]:62368
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234050AbhGTHhP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Jul 2021 03:37:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIER9AqN4o3VdakDr71+vpHjEghdKnaJyCQskbYpGWqUScgmpj0i/L4FvoiQOky3D1tf75FD+5Hd8ZoQCaysEuXeKjobMlwH1nhumayzuyg6q3oiOir1/kQrqnyWpS/efJ9M8spAvRPdomdqJJAqZ5Tez80zh+VMh0iHrPksiO7rrTbdvEEnDsU3CpSPN1sPdca9Uk92/ynfbEiLQXCOlEJPkbAF1N9CRLUSMfbsydXE8LZB6Cda4aOCCdOP1OBGx4LbHedEg2IQ3HDknvE0luijHx47dwxrjLmIStbgrF150mtLsZ3j7d/Jbf0DL/KW//iPEjGncW8HYhlHP+ycMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuraWl8UnE7DbmVyung9SGulSvCynK147j9pSkHZkOo=;
 b=NgVBtJfDF02z6VfFqjE0gAmC12G0IdhB8s9RxAmDokyOKyA6PicR+WWNgnzFXYVgYOm2ImmA7kvjj3R8OxPQiImkX+8yKPC40Jhbf5IYF4/u7qpfTJMlkSBFp6Xi10xtG4kdMRwYV/ShjyQ5e8Qe9pcal/wYBAHUPTvtWgI5KXFFr9gwqjOS9N91ZEq848UjSC0W6WZruPCqcBYw9CxjsQKTqBkDKk+ls1uHFxrS61r8DXBDPze5s0V0gSrShJqEEEx+lLMbeIlt0518w6HUIcFiJ1RUKyZMkr3R8AadcHiIAHxaQB5fayQmMPU6Bo5eDrcTg+0aJfBG7WtdAWh10w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuraWl8UnE7DbmVyung9SGulSvCynK147j9pSkHZkOo=;
 b=kvQ4g/var7AcWvLievoPwURtqnJH2dshZES9z1wks4BwkgGOkrUVkFmjowl/sflz8Fe5GrpkWYuGD+VcJGZuokmQEQP1cPx58FDHFQbo219SY3LmeL4zVITZ+P9Oz3DX5TLCScWyr1YY7ec8obcdurSkZEqgqvqK35kZyqucVJfqmjPhCQvrXcdx0/CZphEf+5cyn4ty6Giig2/syWBRSj0O8opq1EundLNCcd8xOxATd/oj9WEHk4msgE6oioKktQcmXcLiesrw4JUIsdXB5VxNT87tfb7Nfq3wFuttPLOowRMdozo7rITZHVLv+ZL0zyY4fmJisxO7/pCYFu2eog==
Received: from BN9PR03CA0882.namprd03.prod.outlook.com (2603:10b6:408:13c::17)
 by MN2PR12MB3552.namprd12.prod.outlook.com (2603:10b6:208:ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Tue, 20 Jul
 2021 08:17:52 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::34) by BN9PR03CA0882.outlook.office365.com
 (2603:10b6:408:13c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Tue, 20 Jul 2021 08:17:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 08:17:52 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 08:17:51 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 08:17:50 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Jul 2021 01:17:48 -0700
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <markzhang@nvidia.com>, <edwards@nvidia.com>
Subject: [PATCH rdma-core 10/27] mlx5: Support fast teardown over vfio
Date:   Tue, 20 Jul 2021 11:16:30 +0300
Message-ID: <20210720081647.1980-11-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210720081647.1980-1-yishaih@nvidia.com>
References: <20210720081647.1980-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e827220b-3620-4965-f349-08d94b56deac
X-MS-TrafficTypeDiagnostic: MN2PR12MB3552:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3552D1E684C082BCA76CD9CEC3E29@MN2PR12MB3552.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2TNn03z8pdh2sGIWqFNlFV78wcwQTQ6li19wYFlyhSWSJrzgXaErMDhONvmiW9IhVd9skq33jMmcU5sjba2pkdP9Z4GDLmg7NrIqmlGZjGkFlG+eCBYYgAIP3DVvVrtZGrJTw+za00HPx9SRItUetqjcfLoCf5quORIiLMdOlV1a+OKhs3P3miZrBFqJsMdeGNwnj3zoVreEGHi62VWBKPKcXnH8uXE7AXKCfZ9+u707BsbKyRtqzUrDAjmOGAcgq1ez+aLqDjkFtSWcjP/nIugxoyh/JIw41i6H0m5ZFx15Q+ucq8PF7SJ6vYoQiypbO532btZdSrQGSsABrkdj3e/4c3AWyxudGITMqNd9L2AnyU3b/uqRJ+Fuj4i7JUCcg5GZGOGMVmqkGGjavG21o6fnZgvJ1z1QElc5qB7L5ZVIK1eZ7Ky0lj239g8fbKp+VfgfKzeWu21cz13QfHqTv8bVmOGLGWQ/Jf8ujPABY730jJNvupXgryyKjIj+edSB5zd2D6rgvkfyd+U2uCujj9ys/KyywKhkg5cEq11rnFAvoEwixgR0w36LLNOKRV1GBDl/lDPbJlmr0xqZm5zeZiOpcnw2m0/tQkK94mSnfKy44NfVRXbzR5aASGlu9oqLMTXFZzLoC1/weWiOB+2pNFs9LlTmzw7fg3E4K6EYyibnjfsgpGMt7WkUe7qtv5PSKg7/ljNNWkUn42018XvYcw==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(46966006)(36840700001)(186003)(7696005)(2616005)(36906005)(5660300002)(316002)(54906003)(336012)(478600001)(426003)(1076003)(86362001)(26005)(8936002)(2906002)(4326008)(107886003)(36860700001)(6916009)(8676002)(6666004)(47076005)(356005)(7636003)(83380400001)(82740400003)(82310400003)(70206006)(36756003)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 08:17:52.3063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e827220b-3620-4965-f349-08d94b56deac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3552
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markzhang@nvidia.com>

Add vfio fast teardown support; If it fails then do regular teardown.

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 providers/mlx5/mlx5_ifc.h  |  5 +++
 providers/mlx5/mlx5_vfio.c | 76 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/providers/mlx5/mlx5_ifc.h b/providers/mlx5/mlx5_ifc.h
index 082ac1f..4b7a4c2 100644
--- a/providers/mlx5/mlx5_ifc.h
+++ b/providers/mlx5/mlx5_ifc.h
@@ -4286,6 +4286,10 @@ struct mlx5_ifc_manage_pages_in_bits {
 	u8         pas[][0x40];
 };
 
+enum {
+	MLX5_TEARDOWN_HCA_OUT_FORCE_STATE_FAIL = 0x1,
+};
+
 struct mlx5_ifc_teardown_hca_out_bits {
 	u8         status[0x8];
 	u8         reserved_at_8[0x18];
@@ -4299,6 +4303,7 @@ struct mlx5_ifc_teardown_hca_out_bits {
 
 enum {
 	MLX5_TEARDOWN_HCA_IN_PROFILE_GRACEFUL_CLOSE = 0x0,
+	MLX5_TEARDOWN_HCA_IN_PROFILE_PREPARE_FAST_TEARDOWN = 0x2,
 };
 
 struct mlx5_ifc_teardown_hca_in_bits {
diff --git a/providers/mlx5/mlx5_vfio.c b/providers/mlx5/mlx5_vfio.c
index bd128c2..97d3ce6 100644
--- a/providers/mlx5/mlx5_vfio.c
+++ b/providers/mlx5/mlx5_vfio.c
@@ -1354,7 +1354,7 @@ static int wait_fw_init(struct mlx5_init_seg *init_seg, uint32_t max_wait_mili)
 	return 0;
 }
 
-static int mlx5_vfio_teardown_hca(struct mlx5_vfio_context *ctx)
+static int mlx5_vfio_teardown_hca_regular(struct mlx5_vfio_context *ctx)
 {
 	uint32_t in[DEVX_ST_SZ_DW(teardown_hca_in)] = {};
 	uint32_t out[DEVX_ST_SZ_DW(teardown_hca_out)] = {};
@@ -1364,6 +1364,80 @@ static int mlx5_vfio_teardown_hca(struct mlx5_vfio_context *ctx)
 	return mlx5_vfio_cmd_exec(ctx, in, sizeof(in), out, sizeof(out), 0);
 }
 
+enum mlx5_cmd_addr_l_sz_offset {
+	MLX5_NIC_IFC_OFFSET = 8,
+};
+
+enum {
+	MLX5_NIC_IFC_DISABLED = 1,
+};
+
+static uint8_t mlx5_vfio_get_nic_state(struct mlx5_vfio_context *ctx)
+{
+	return (be32toh(mmio_read32_be(&ctx->bar_map->cmdq_addr_l_sz)) >> 8) & 7;
+}
+
+static void mlx5_vfio_set_nic_state(struct mlx5_vfio_context *ctx, uint8_t state)
+{
+	uint32_t cur_cmdq_addr_l_sz;
+
+	cur_cmdq_addr_l_sz = be32toh(mmio_read32_be(&ctx->bar_map->cmdq_addr_l_sz));
+	mmio_write32_be(&ctx->bar_map->cmdq_addr_l_sz,
+			htobe32((cur_cmdq_addr_l_sz & 0xFFFFF000) |
+				state << MLX5_NIC_IFC_OFFSET));
+}
+
+#define MLX5_FAST_TEARDOWN_WAIT_MS 3000
+#define MLX5_FAST_TEARDOWN_WAIT_ONCE_MS 1
+static int mlx5_vfio_teardown_hca_fast(struct mlx5_vfio_context *ctx)
+{
+	uint32_t out[DEVX_ST_SZ_DW(teardown_hca_out)] = {};
+	uint32_t in[DEVX_ST_SZ_DW(teardown_hca_in)] = {};
+	int waited = 0, state, ret;
+
+	DEVX_SET(teardown_hca_in, in, opcode, MLX5_CMD_OP_TEARDOWN_HCA);
+	DEVX_SET(teardown_hca_in, in, profile,
+		 MLX5_TEARDOWN_HCA_IN_PROFILE_PREPARE_FAST_TEARDOWN);
+	ret = mlx5_vfio_cmd_exec(ctx, in, sizeof(in), out, sizeof(out), 0);
+	if (ret)
+		return ret;
+
+	state = DEVX_GET(teardown_hca_out, out, state);
+	if (state == MLX5_TEARDOWN_HCA_OUT_FORCE_STATE_FAIL) {
+		mlx5_err(ctx->dbg_fp, "teardown with fast mode failed\n");
+		return EIO;
+	}
+
+	mlx5_vfio_set_nic_state(ctx, MLX5_NIC_IFC_DISABLED);
+	do {
+		if (mlx5_vfio_get_nic_state(ctx) == MLX5_NIC_IFC_DISABLED)
+			break;
+		usleep(MLX5_FAST_TEARDOWN_WAIT_ONCE_MS * 1000);
+		waited += MLX5_FAST_TEARDOWN_WAIT_ONCE_MS;
+	} while (waited < MLX5_FAST_TEARDOWN_WAIT_MS);
+
+	if (mlx5_vfio_get_nic_state(ctx) != MLX5_NIC_IFC_DISABLED) {
+		mlx5_err(ctx->dbg_fp, "NIC IFC still %d after %ums.\n",
+			 mlx5_vfio_get_nic_state(ctx), waited);
+		return EIO;
+	}
+
+	return 0;
+}
+
+static int mlx5_vfio_teardown_hca(struct mlx5_vfio_context *ctx)
+{
+	int err;
+
+	if (MLX5_VFIO_CAP_GEN(ctx, fast_teardown)) {
+		err = mlx5_vfio_teardown_hca_fast(ctx);
+		if (!err)
+			return 0;
+	}
+
+	return mlx5_vfio_teardown_hca_regular(ctx);
+}
+
 static int mlx5_vfio_setup_function(struct mlx5_vfio_context *ctx)
 {
 	int err;
-- 
1.8.3.1

