Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F6F3CF5FD
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 10:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbhGTHhb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jul 2021 03:37:31 -0400
Received: from mail-bn8nam11on2055.outbound.protection.outlook.com ([40.107.236.55]:54513
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234289AbhGTHhQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Jul 2021 03:37:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUG+mM1o2IMrscYWIaxZBAA5V7IrZjxqOZfL29ub5vs0+d/SgOGPNWFUSbPIvSCEjtBg+HTaXrbtJAQT1zZB0in4JLK1beTrRiBa/U1zYhUzQ3su5VukcqfhjFmERRexK4ldiqKCeddUwrDcRvXtr0vtc1dGSet/Mao1GnhGueSiSiJRwDAIGJ4GPJT8YBwiixanJ7XLjmeFzpU96nzBU5nlxYashOllsNmkOnO3zUZ634ZxjVEykVMnrJjiimmZ8LhUek67/8oNHgz8kYzZ3WofBHrgxtPG+OyjMrvqISNCOpBaspg2nj6cw2QmXHDI38Z2UEH1GeMNI+i+xOPY+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3V7FwVwmLJmr7mtLq2QO/UdP19yOxPNfMcfPFOnqdQ=;
 b=lkA88/MzgKUZboLJh9lCx+Y1iVPfOm9QJnc5kTjxLl4asGCyQyns2743VBBpL5tbmShKZmqygawBfU9QEegEb4OMa9sn8dCVaaYpBTxd+OYA98PcwCFRgCYheTGpQU6qdhwcZmWV1OHvnYTbRSIVCEOKJFKD5/vyxnvOkFMiXOxupaBeuD/2502JFrEozeea9J5W3XvAQr+kZk7iUb11yHIVbNR33voTy9fC/SZqucXe4OyplOkpolkvqSj1CZlg+G9w/4MYuOjD+tOaywb/YJHHJgBN49Pg888OsH/wPojq3yrhYjYAoteEzGFgz5/M7Z8LuVCdeGp1HnLvXoLThg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3V7FwVwmLJmr7mtLq2QO/UdP19yOxPNfMcfPFOnqdQ=;
 b=K9Ry4yy8mTYP7ulaFSdR73ml6deH3Z9xA7ZvoTJEgCradrAsuOhaYAWA1DDCJE9jCoR2jB9QERrGh3dFIZH4U/75zVruukRdj98qnj0Pz+im8qzbAatxDxYobdz0yvhiQk3aA2kGgXTM99NFxhxVeyn/5+SnsHHvPaiSKiUEXJzNS3sThHuoS1y+8F986poLc4NovwqsEt53ODYygJmje19e8lqEkX1qOKcz61J/2GCHE5tR/zIDysVRtVXnOCkB5iqRB0pi5Lpf+knhlmiVfWADt8njazWjDXgk+naD8p5VwtExScwugfeGxOwx1bHwiC8SqIHZwCNCumJ1UNbYCg==
Received: from MWHPR22CA0061.namprd22.prod.outlook.com (2603:10b6:300:12a::23)
 by BY5PR12MB4020.namprd12.prod.outlook.com (2603:10b6:a03:196::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Tue, 20 Jul
 2021 08:17:53 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::93) by MWHPR22CA0061.outlook.office365.com
 (2603:10b6:300:12a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Tue, 20 Jul 2021 08:17:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 08:17:53 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 08:17:48 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Jul 2021 01:17:46 -0700
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <markzhang@nvidia.com>, <edwards@nvidia.com>
Subject: [PATCH rdma-core 09/27] mlx5: vfio setup basic caps
Date:   Tue, 20 Jul 2021 11:16:29 +0300
Message-ID: <20210720081647.1980-10-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210720081647.1980-1-yishaih@nvidia.com>
References: <20210720081647.1980-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8888e00f-14e5-4256-aee1-08d94b56df1a
X-MS-TrafficTypeDiagnostic: BY5PR12MB4020:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4020066120764B0D06C93025C3E29@BY5PR12MB4020.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RRzRr3+VCf6LReyiNv8VIwpxx+I08UMGd+eO9nB9oqfuMc+/kD9PQjDXCZU9MekjmcosLnsShgEBTkNO45cgkWCKuWVevS+xw2lo0E1f7BdkfLfphsgtibUsRuWfcUKDp/MdMF87iV/rftV7qs3YFNXa4U8a6Bmj6nS2I6cxeKm3LUyLcarzLOfYB7gqcuangypR/6BHU54l+pYc9tzHRgvWvF/4zsQRn92SoNQr8cMCf8uAmb+9m38WO26cpuFf+0o+EbsUcenZowOYiwH/ChtlAaasXqfQuQiHYpH2/0bIZAYtlTv7rrEApmBabfIg8NXJY+oGohFCYv0quiiwnbYDeEOPjxfeQVMxAhki5zkCxc+XPso1CKTmMUoeurv7nNCUObbO+WvRZ/kvgkXLxXQZGaswPjYNGTVGZ09dk7GYwCJgldi/n0qPUv4h8Y57AIEkybV/k/QD+kIQM+r3hUYIUKJVahg3aYRI5U83k+aqLJySLD68sF65r+g95PCaGxNifDhwKhfrsT8lyDtcEPzeFtA+vxhf5XLQuMIsbAN1zVNvpyi96XQ+EK1hImRRbS/VgIT7baSPeFF6D98c1UfWxVvP+bsPBtDoNYDkGlkwuIPcU2CRJFPbgx+k798KyyeBDYnnl2Af1Y2goK0yKRtUQFncg3AkYWJb2+eSQFf3ywsPdghWhnx33KjuiV9Tu8AXCcmr1mEXO4HLG5Q3yg==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(46966006)(36840700001)(107886003)(82310400003)(6916009)(186003)(7696005)(36906005)(4326008)(36860700001)(2906002)(47076005)(26005)(54906003)(36756003)(86362001)(6666004)(83380400001)(316002)(70206006)(478600001)(70586007)(8676002)(82740400003)(336012)(8936002)(30864003)(7636003)(2616005)(1076003)(5660300002)(426003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 08:17:53.0665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8888e00f-14e5-4256-aee1-08d94b56df1a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4020
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Set basic caps that are required to initialize the device properly.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 providers/mlx5/mlx5_ifc.h  |  87 ++++++++++++++++++++-
 providers/mlx5/mlx5_vfio.c | 185 ++++++++++++++++++++++++++++++++++++++++++++-
 providers/mlx5/mlx5_vfio.h |  21 +++++
 3 files changed, 290 insertions(+), 3 deletions(-)

diff --git a/providers/mlx5/mlx5_ifc.h b/providers/mlx5/mlx5_ifc.h
index ac741cd..082ac1f 100644
--- a/providers/mlx5/mlx5_ifc.h
+++ b/providers/mlx5/mlx5_ifc.h
@@ -36,6 +36,7 @@
 #define u8 uint8_t
 
 enum mlx5_cap_mode {
+	HCA_CAP_OPMOD_GET_MAX = 0,
 	HCA_CAP_OPMOD_GET_CUR	= 1,
 };
 
@@ -46,6 +47,7 @@ enum {
 	MLX5_CMD_OP_ENABLE_HCA = 0x104,
 	MLX5_CMD_OP_QUERY_PAGES = 0x107,
 	MLX5_CMD_OP_MANAGE_PAGES = 0x108,
+	MLX5_CMD_OP_SET_HCA_CAP = 0x109,
 	MLX5_CMD_OP_QUERY_ISSI = 0x10a,
 	MLX5_CMD_OP_SET_ISSI = 0x10b,
 	MLX5_CMD_OP_CREATE_MKEY = 0x200,
@@ -61,6 +63,7 @@ enum {
 	MLX5_CMD_OP_QUERY_DCT = 0x713,
 	MLX5_CMD_OP_QUERY_ESW_VPORT_CONTEXT = 0x752,
 	MLX5_CMD_OP_QUERY_NIC_VPORT_CONTEXT = 0x754,
+	MLX5_CMD_OP_MODIFY_NIC_VPORT_CONTEXT = 0x755,
 	MLX5_CMD_OP_QUERY_ROCE_ADDRESS = 0x760,
 	MLX5_CMD_OP_ACCESS_REG = 0x805,
 	MLX5_CMD_OP_QUERY_LAG = 0x842,
@@ -110,6 +113,11 @@ enum {
 	MLX5_REG_HOST_ENDIANNESS = 0x7004,
 };
 
+enum {
+	MLX5_CAP_PORT_TYPE_IB  = 0x0,
+	MLX5_CAP_PORT_TYPE_ETH = 0x1,
+};
+
 struct mlx5_ifc_atomic_caps_bits {
 	u8         reserved_at_0[0x40];
 
@@ -140,7 +148,8 @@ struct mlx5_ifc_atomic_caps_bits {
 };
 
 struct mlx5_ifc_roce_cap_bits {
-	u8         reserved_0[0x5];
+	u8         reserved_0[0x4];
+	u8         sw_r_roce_src_udp_port[0x1];
 	u8         fl_rc_qp_when_roce_disabled[0x1];
 	u8         fl_rc_qp_when_roce_enabled[0x1];
 	u8         reserved_at_7[0x17];
@@ -912,7 +921,8 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         uar_4k[0x1];
 	u8         reserved_at_241[0x9];
 	u8         uar_sz[0x6];
-	u8         reserved_at_250[0x3];
+	u8         reserved_at_250[0x2];
+	u8         umem_uid_0[0x1];
 	u8         log_max_dc_cnak_qps[0x5];
 	u8         log_pg_sz[0x8];
 
@@ -1339,8 +1349,11 @@ struct mlx5_ifc_query_hca_cap_in_bits {
 };
 
 enum mlx5_cap_type {
+	MLX5_CAP_GENERAL = 0,
 	MLX5_CAP_ODP = 2,
 	MLX5_CAP_ATOMIC = 3,
+	MLX5_CAP_ROCE,
+	MLX5_CAP_NUM,
 };
 
 enum {
@@ -4346,4 +4359,74 @@ struct mlx5_ifc_access_register_in_bits {
 	u8         register_data[][0x20];
 };
 
+struct mlx5_ifc_modify_nic_vport_context_out_bits {
+	u8         status[0x8];
+	u8         reserved_at_8[0x18];
+
+	u8         syndrome[0x20];
+
+	u8         reserved_at_40[0x40];
+};
+
+struct mlx5_ifc_modify_nic_vport_field_select_bits {
+	u8         reserved_at_0[0x12];
+	u8         affiliation[0x1];
+	u8         reserved_at_13[0x1];
+	u8         disable_uc_local_lb[0x1];
+	u8         disable_mc_local_lb[0x1];
+	u8         node_guid[0x1];
+	u8         port_guid[0x1];
+	u8         min_inline[0x1];
+	u8         mtu[0x1];
+	u8         change_event[0x1];
+	u8         promisc[0x1];
+	u8         permanent_address[0x1];
+	u8         addresses_list[0x1];
+	u8         roce_en[0x1];
+	u8         reserved_at_1f[0x1];
+};
+
+struct mlx5_ifc_modify_nic_vport_context_in_bits {
+	u8         opcode[0x10];
+	u8         reserved_at_10[0x10];
+
+	u8         reserved_at_20[0x10];
+	u8         op_mod[0x10];
+
+	u8         other_vport[0x1];
+	u8         reserved_at_41[0xf];
+	u8         vport_number[0x10];
+
+	struct mlx5_ifc_modify_nic_vport_field_select_bits field_select;
+
+	u8         reserved_at_80[0x780];
+
+	struct mlx5_ifc_nic_vport_context_bits nic_vport_context;
+};
+
+struct mlx5_ifc_set_hca_cap_out_bits {
+	u8         status[0x8];
+	u8         reserved_at_8[0x18];
+
+	u8         syndrome[0x20];
+
+	u8         reserved_at_40[0x40];
+};
+
+struct mlx5_ifc_set_hca_cap_in_bits {
+	u8         opcode[0x10];
+	u8         reserved_at_10[0x10];
+
+	u8         reserved_at_20[0x10];
+	u8         op_mod[0x10];
+
+	u8         other_function[0x1];
+	u8         reserved_at_41[0xf];
+	u8         function_id[0x10];
+
+	u8         reserved_at_60[0x20];
+
+	union mlx5_ifc_hca_cap_union_bits capability;
+};
+
 #endif /* MLX5_IFC_H */
diff --git a/providers/mlx5/mlx5_vfio.c b/providers/mlx5/mlx5_vfio.c
index 4d12807..bd128c2 100644
--- a/providers/mlx5/mlx5_vfio.c
+++ b/providers/mlx5/mlx5_vfio.c
@@ -1141,6 +1141,177 @@ out:
 	return err;
 }
 
+static int mlx5_vfio_get_caps_mode(struct mlx5_vfio_context *ctx,
+				   enum mlx5_cap_type cap_type,
+				   enum mlx5_cap_mode cap_mode)
+{
+	uint8_t in[DEVX_ST_SZ_BYTES(query_hca_cap_in)] = {};
+	int out_sz = DEVX_ST_SZ_BYTES(query_hca_cap_out);
+	void *out, *hca_caps;
+	uint16_t opmod = (cap_type << 1) | (cap_mode & 0x01);
+	int err;
+
+	out = calloc(1, out_sz);
+	if (!out) {
+		errno = ENOMEM;
+		return errno;
+	}
+
+	DEVX_SET(query_hca_cap_in, in, opcode, MLX5_CMD_OP_QUERY_HCA_CAP);
+	DEVX_SET(query_hca_cap_in, in, op_mod, opmod);
+	err = mlx5_vfio_cmd_exec(ctx, in, sizeof(in), out, out_sz, 0);
+	if (err)
+		goto query_ex;
+
+	hca_caps = DEVX_ADDR_OF(query_hca_cap_out, out, capability);
+
+	switch (cap_mode) {
+	case HCA_CAP_OPMOD_GET_MAX:
+		memcpy(ctx->caps.hca_max[cap_type], hca_caps,
+		       DEVX_UN_SZ_BYTES(hca_cap_union));
+		break;
+	case HCA_CAP_OPMOD_GET_CUR:
+		memcpy(ctx->caps.hca_cur[cap_type], hca_caps,
+		       DEVX_UN_SZ_BYTES(hca_cap_union));
+		break;
+	default:
+		err = EINVAL;
+		assert(false);
+		break;
+	}
+
+query_ex:
+	free(out);
+	return err;
+}
+
+enum mlx5_vport_roce_state {
+	MLX5_VPORT_ROCE_DISABLED = 0,
+	MLX5_VPORT_ROCE_ENABLED  = 1,
+};
+
+static int mlx5_vfio_nic_vport_update_roce_state(struct mlx5_vfio_context *ctx,
+						 enum mlx5_vport_roce_state state)
+{
+	uint32_t out[DEVX_ST_SZ_DW(modify_nic_vport_context_out)] = {};
+	int inlen = DEVX_ST_SZ_BYTES(modify_nic_vport_context_in);
+	void *in;
+	int err;
+
+	in = calloc(1, inlen);
+	if (!in) {
+		errno = ENOMEM;
+		return errno;
+	}
+
+	DEVX_SET(modify_nic_vport_context_in, in, field_select.roce_en, 1);
+	DEVX_SET(modify_nic_vport_context_in, in, nic_vport_context.roce_en,
+		 state);
+	DEVX_SET(modify_nic_vport_context_in, in, opcode,
+		 MLX5_CMD_OP_MODIFY_NIC_VPORT_CONTEXT);
+
+	err = mlx5_vfio_cmd_exec(ctx, in, inlen, out, sizeof(out), 0);
+
+	free(in);
+
+	return err;
+}
+
+static int mlx5_vfio_get_caps(struct mlx5_vfio_context *ctx, enum mlx5_cap_type cap_type)
+{
+	int ret;
+
+	ret = mlx5_vfio_get_caps_mode(ctx, cap_type, HCA_CAP_OPMOD_GET_CUR);
+	if (ret)
+		return ret;
+
+	return mlx5_vfio_get_caps_mode(ctx, cap_type, HCA_CAP_OPMOD_GET_MAX);
+}
+
+static int handle_hca_cap_roce(struct mlx5_vfio_context *ctx, void *set_ctx,
+			       int ctx_size)
+{
+	int err;
+	uint32_t out[DEVX_ST_SZ_DW(set_hca_cap_out)] = {};
+	void *set_hca_cap;
+
+	if (!MLX5_VFIO_CAP_GEN(ctx, roce))
+		return 0;
+
+	err = mlx5_vfio_get_caps(ctx, MLX5_CAP_ROCE);
+	if (err)
+		return err;
+
+	if (MLX5_VFIO_CAP_ROCE(ctx, sw_r_roce_src_udp_port) ||
+	    !MLX5_VFIO_CAP_ROCE_MAX(ctx, sw_r_roce_src_udp_port))
+		return 0;
+
+	set_hca_cap = DEVX_ADDR_OF(set_hca_cap_in, set_ctx, capability);
+	memcpy(set_hca_cap, ctx->caps.hca_cur[MLX5_CAP_ROCE],
+	       DEVX_ST_SZ_BYTES(roce_cap));
+	DEVX_SET(roce_cap, set_hca_cap, sw_r_roce_src_udp_port, 1);
+	DEVX_SET(set_hca_cap_in, set_ctx, opcode, MLX5_CMD_OP_SET_HCA_CAP);
+	DEVX_SET(set_hca_cap_in, set_ctx, op_mod, MLX5_SET_HCA_CAP_OP_MOD_ROCE);
+	return mlx5_vfio_cmd_exec(ctx, set_ctx, ctx_size, out, sizeof(out), 0);
+}
+
+static int handle_hca_cap(struct mlx5_vfio_context *ctx, void *set_ctx, int set_sz)
+{
+	struct mlx5_vfio_device *dev = to_mvfio_dev(ctx->vctx.context.device);
+	int sys_page_shift = ilog32(dev->page_size - 1);
+	uint32_t out[DEVX_ST_SZ_DW(set_hca_cap_out)] = {};
+	void *set_hca_cap;
+	int err;
+
+	err = mlx5_vfio_get_caps(ctx, MLX5_CAP_GENERAL);
+	if (err)
+		return err;
+
+	set_hca_cap = DEVX_ADDR_OF(set_hca_cap_in, set_ctx,
+				   capability);
+	memcpy(set_hca_cap, ctx->caps.hca_cur[MLX5_CAP_GENERAL],
+	       DEVX_ST_SZ_BYTES(cmd_hca_cap));
+
+	/* disable cmdif checksum */
+	DEVX_SET(cmd_hca_cap, set_hca_cap, cmdif_checksum, 0);
+
+	if (dev->flags & MLX5DV_VFIO_CTX_FLAGS_INIT_LINK_DOWN)
+		DEVX_SET(cmd_hca_cap, set_hca_cap, disable_link_up_by_init_hca, 1);
+
+	DEVX_SET(cmd_hca_cap, set_hca_cap, log_uar_page_sz, sys_page_shift - 12);
+
+	if (MLX5_VFIO_CAP_GEN_MAX(ctx, mkey_by_name))
+		DEVX_SET(cmd_hca_cap, set_hca_cap, mkey_by_name, 1);
+
+	DEVX_SET(set_hca_cap_in, set_ctx, opcode, MLX5_CMD_OP_SET_HCA_CAP);
+	DEVX_SET(set_hca_cap_in, set_ctx, op_mod, MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE);
+
+	return mlx5_vfio_cmd_exec(ctx, set_ctx, set_sz, out, sizeof(out), 0);
+}
+
+static int set_hca_cap(struct mlx5_vfio_context *ctx)
+{
+	int set_sz = DEVX_ST_SZ_BYTES(set_hca_cap_in);
+	void *set_ctx;
+	int err;
+
+	set_ctx = calloc(1, set_sz);
+	if (!set_ctx) {
+		errno = ENOMEM;
+		return errno;
+	}
+
+	err = handle_hca_cap(ctx, set_ctx, set_sz);
+	if (err)
+		goto out;
+
+	memset(set_ctx, 0, set_sz);
+	err = handle_hca_cap_roce(ctx, set_ctx, set_sz);
+out:
+	free(set_ctx);
+	return err;
+}
+
 static int mlx5_vfio_set_hca_ctrl(struct mlx5_vfio_context *ctx)
 {
 	struct mlx5_reg_host_endianness he_in = {};
@@ -1217,6 +1388,15 @@ static int mlx5_vfio_setup_function(struct mlx5_vfio_context *ctx)
 	if (err)
 		return err;
 
+	err = set_hca_cap(ctx);
+	if (err)
+		return err;
+
+	if (!MLX5_VFIO_CAP_GEN(ctx, umem_uid_0)) {
+		errno = EOPNOTSUPP;
+		return errno;
+	}
+
 	err = mlx5_vfio_satisfy_startup_pages(ctx, 0);
 	if (err)
 		return err;
@@ -1225,7 +1405,10 @@ static int mlx5_vfio_setup_function(struct mlx5_vfio_context *ctx)
 	if (err)
 		return err;
 
-	return 0;
+	if (MLX5_VFIO_CAP_GEN(ctx, port_type) == MLX5_CAP_PORT_TYPE_ETH)
+		err = mlx5_vfio_nic_vport_update_roce_state(ctx, MLX5_VPORT_ROCE_ENABLED);
+
+	return err;
 }
 
 static void mlx5_vfio_uninit_context(struct mlx5_vfio_context *ctx)
diff --git a/providers/mlx5/mlx5_vfio.h b/providers/mlx5/mlx5_vfio.h
index 36b1f40..225c1b9 100644
--- a/providers/mlx5/mlx5_vfio.h
+++ b/providers/mlx5/mlx5_vfio.h
@@ -12,6 +12,7 @@
 
 #include <infiniband/driver.h>
 #include <util/interval_set.h>
+#include "mlx5_ifc.h"
 
 #define FW_INIT_WAIT_MS 2
 #define FW_PRE_INIT_TIMEOUT_MILI 120000
@@ -43,6 +44,22 @@ struct mlx5_vfio_device {
 #error Host endianness not defined
 #endif
 
+/* GET Dev Caps macros */
+#define MLX5_VFIO_CAP_GEN(ctx, cap) \
+	DEVX_GET(cmd_hca_cap, ctx->caps.hca_cur[MLX5_CAP_GENERAL], cap)
+
+#define MLX5_VFIO_CAP_GEN_64(mdev, cap) \
+	DEVX_GET64(cmd_hca_cap, mdev->caps.hca_cur[MLX5_CAP_GENERAL], cap)
+
+#define MLX5_VFIO_CAP_GEN_MAX(ctx, cap) \
+	DEVX_GET(cmd_hca_cap, ctx->caps.hca_max[MLX5_CAP_GENERAL], cap)
+
+#define MLX5_VFIO_CAP_ROCE(ctx, cap) \
+	DEVX_GET(roce_cap, ctx->caps.hca_cur[MLX5_CAP_ROCE], cap)
+
+#define MLX5_VFIO_CAP_ROCE_MAX(ctx, cap) \
+	DEVX_GET(roce_cap, ctx->caps.hca_max[MLX5_CAP_ROCE], cap)
+
 struct mlx5_reg_host_endianness {
 	uint8_t he;
 	uint8_t rsvd[15];
@@ -162,6 +179,10 @@ struct mlx5_vfio_context {
 	size_t bar_map_size;
 	struct mlx5_vfio_cmd cmd;
 	bool have_eq;
+	struct {
+		uint32_t hca_cur[MLX5_CAP_NUM][DEVX_UN_SZ_DW(hca_cap_union)];
+		uint32_t hca_max[MLX5_CAP_NUM][DEVX_UN_SZ_DW(hca_cap_union)];
+	} caps;
 };
 
 static inline struct mlx5_vfio_device *to_mvfio_dev(struct ibv_device *ibdev)
-- 
1.8.3.1

