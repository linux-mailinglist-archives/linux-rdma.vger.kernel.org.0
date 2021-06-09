Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5158A3A1A5A
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 18:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbhFIQCA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Jun 2021 12:02:00 -0400
Received: from mail-bn8nam12on2081.outbound.protection.outlook.com ([40.107.237.81]:60608
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237210AbhFIQB5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Jun 2021 12:01:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPp6Zpn13Mh6MsUExu9jeQl50dePRDy+UpgCS3WHcezLf764hwlsVqcnVhK4wAJrrFY3re6A0LytFddu2v1/FS1lzVibRdRiRSoizTwxWGwZfyA0MtWscaJHv4ccXQ61LYm8fzmhv+JaF/DAs2dw4V9ybIfxN04JqX3A7r3uNQrFF4+UVUe404WYpnKA7iYk2svSeQLLtqdSYCUPFC9m81eOwVfvsAwlsQC7xy4TJRxkUaR7gP0AZyqpRaG6H1j8nBFBjZWeU9NZ+f5U2C2+H0uJG3S5ITJyS8f82SrH+BBn3icgC0F/QRFQ1JG8LuKBOpKRbTAmUuYnsmmByBI/Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuGtotfy1BrVIDKPnfEmFFRm4LkPgHSBeizo+fcTHDM=;
 b=mHS/fHKsACuueT6VE0f3FgmQegsSU/yqoEKxY3lveBqj8AWarHur7vob3ZSm2fybJBm9jomb2/uHwO2jGUqPiNCcIMaKXrM65/IYJQvY/ZeLNj+sW1CK3j+Z7vRdZpO+irqyf7UVqEIkANfj1D812UDmLeTXAhy1RzuKs7JIkD3k+ul77hGTlMFDO7vvhpaznCfElBGnuOz8JWhLOEN+EsfU3/WFZcMjMmx8lQxSgCCZiEwQy3v0IlKf0ZMBD8vZ2LqHMytS1Wfl2mBGXwne4fCwTn0jBD/V7jBsJp6K/JNVDejli0XGtWWeyE6wmsv3pbdqGSKk6vdkcXQYBiIx6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuGtotfy1BrVIDKPnfEmFFRm4LkPgHSBeizo+fcTHDM=;
 b=YfFDopYT+BqBAJ0IgpAFKMEd7dO5EIFQRwDQweZY2rBYkxYaWQj1PKkS2fVGk85bB6vVh+jrMy4t6OyXH+w8wlFeCIWdToY9OVKDjblUfyBA4w+UzYD4fBcFLhdt52NfqgW4XfuqOSF+BqMMfTO8Ae53BZvtJYuAwxPwxxrkkJSx2H0YyVkleqR95Uf8hB/4IFto4NSPYdrtXg0pfUboaabuHTP5vkhSsbdDVI9X740gXpcWOt68jNjMgHa1U3q9jo4XlOYtfhlbcHE59g34w/11sbDItPbH0gFYLblUMXE8LqBTz+oic2e6k42REEKqVeZ40YEMYJY7BrZsKwgQog==
Received: from MW4PR03CA0336.namprd03.prod.outlook.com (2603:10b6:303:dc::11)
 by BL0PR12MB2419.namprd12.prod.outlook.com (2603:10b6:207:44::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Wed, 9 Jun
 2021 16:00:00 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::bf) by MW4PR03CA0336.outlook.office365.com
 (2603:10b6:303:dc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend
 Transport; Wed, 9 Jun 2021 16:00:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 16:00:00 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 9 Jun
 2021 15:59:59 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Jun 2021 15:59:54 +0000
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@mellanox.com>, <yishaih@mellanox.com>, <maorg@mellanox.com>,
        <phaddad@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-core 2/4] mlx5: Implement ibv_query_qp_data_in_order() verb
Date:   Wed, 9 Jun 2021 18:59:30 +0300
Message-ID: <20210609155932.218005-3-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210609155932.218005-1-yishaih@nvidia.com>
References: <20210609155932.218005-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8a90bf9-3b6c-4794-77e3-08d92b5fa2ed
X-MS-TrafficTypeDiagnostic: BL0PR12MB2419:
X-Microsoft-Antispam-PRVS: <BL0PR12MB241967FC015078178D9FEC43C3369@BL0PR12MB2419.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BClgm/y90Pgh2k1Ly99U9I1fzl9grUSHSnxFtzcoyL1jkdiKDylGwBltsYBzcovy+XsjIbart/ogmJ9/XFSLpsK+cw/pjSL4vwPnKdT0EiBUYn6tuka0pVw40cAb8oarfs+9y6wc4eMow2AeYb/s2U+Ew8zBluTXtmuSL7qZGZpk5lLmlSJHYZFHfnY7hfXodB0N8jhxKzcuVthOZaJfyvWhBcT27mc00Y5W95ishg0mEYN4aCkAEZ48yBtrBc/E7Vc4u04ZNvKGPd9rJdgxvyCilejJkhCMHzOmwshps8Ivr6mHmp9UcAO8OcmINmsQgaub6ocf5lZ5hEE+XE0AQlEGacKdk8L1jTlGKZaXBQqrkzCoBD3Ax8cwJCKQb2/MC4BIfrQinmc0XtzyuIvM5Qlx0EPAfykGSw70fL5RAEgMgMqOGAa9MZXvO+FFsT8Kwt8vxbdWcGOMpY12z+sAZXIR37zhnrnDiWORJtp6vo0u1bHRAfHP8wUuP7HcuYbtcZYuSl1UBNb1+ms6Vsl9KbRAwP16kJMO2DZnK2ixXIGB6pxnOG356tmHjxeyIJcCcWHqo0dUA5bNWYNVeFrsXh+aHbeSy0uL4X6rA7UGtiW6AR6hC5OYf7in8bKfQ0dVOMWTLfwuzzHwFSxAgjrA/9zMCQPdAph70KuYlsoOeNc=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(36840700001)(46966006)(8936002)(26005)(336012)(1076003)(82310400003)(426003)(2906002)(7696005)(5660300002)(54906003)(47076005)(36756003)(70206006)(186003)(70586007)(7636003)(356005)(82740400003)(107886003)(36906005)(6916009)(4326008)(36860700001)(2616005)(6666004)(83380400001)(8676002)(86362001)(478600001)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 16:00:00.3875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a90bf9-3b6c-4794-77e3-08d92b5fa2ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2419
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Patrisious Haddad <phaddad@nvidia.com>

Implement the ibv_query_qp_data_in_order() verb by using DEVX to read
from firmware the 'in_order_data' capability.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 providers/mlx5/mlx5.c     |  1 +
 providers/mlx5/mlx5.h     |  3 +++
 providers/mlx5/mlx5_ifc.h | 39 +++++++++++++++++++++++++++++++--
 providers/mlx5/verbs.c    | 55 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/providers/mlx5/mlx5.c b/providers/mlx5/mlx5.c
index 8ef305e..75ffde9 100644
--- a/providers/mlx5/mlx5.c
+++ b/providers/mlx5/mlx5.c
@@ -167,6 +167,7 @@ static const struct verbs_context_ops mlx5_ctx_common_ops = {
 	.unimport_dm = mlx5_unimport_dm,
 	.unimport_mr = mlx5_unimport_mr,
 	.unimport_pd = mlx5_unimport_pd,
+	.query_qp_data_in_order = mlx5_query_qp_data_in_order,
 };
 
 static const struct verbs_context_ops mlx5_ctx_cqev1_ops = {
diff --git a/providers/mlx5/mlx5.h b/providers/mlx5/mlx5.h
index f6c74df..bfa66ab 100644
--- a/providers/mlx5/mlx5.h
+++ b/providers/mlx5/mlx5.h
@@ -398,6 +398,7 @@ struct mlx5_context {
 	struct mlx5_bf			*nc_uar;
 	void				*cq_uar_reg;
 	struct mlx5_reserved_qpns	reserved_qpns;
+	uint8_t				qp_data_in_order_cap:1;
 };
 
 struct mlx5_bitmap {
@@ -1088,6 +1089,8 @@ struct ibv_qp *mlx5_create_qp(struct ibv_pd *pd, struct ibv_qp_init_attr *attr);
 int mlx5_query_qp(struct ibv_qp *qp, struct ibv_qp_attr *attr,
 		  int attr_mask,
 		  struct ibv_qp_init_attr *init_attr);
+int mlx5_query_qp_data_in_order(struct ibv_qp *qp, enum ibv_wr_opcode op,
+				uint32_t flags);
 int mlx5_modify_qp(struct ibv_qp *qp, struct ibv_qp_attr *attr,
 		   int attr_mask);
 int mlx5_modify_qp_rate_limit(struct ibv_qp *qp,
diff --git a/providers/mlx5/mlx5_ifc.h b/providers/mlx5/mlx5_ifc.h
index 35be5ba..302788f 100644
--- a/providers/mlx5/mlx5_ifc.h
+++ b/providers/mlx5/mlx5_ifc.h
@@ -51,6 +51,7 @@ enum {
 	MLX5_CMD_OP_INIT2INIT_QP = 0x50e,
 	MLX5_CMD_OP_CREATE_PSV = 0x600,
 	MLX5_CMD_OP_DESTROY_PSV = 0x601,
+	MLX5_CMD_OP_QUERY_DCT = 0x713,
 	MLX5_CMD_OP_QUERY_ESW_VPORT_CONTEXT = 0x752,
 	MLX5_CMD_OP_QUERY_NIC_VPORT_CONTEXT = 0x754,
 	MLX5_CMD_OP_QUERY_ROCE_ADDRESS = 0x760,
@@ -641,7 +642,11 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         reserved_at_21[0xf];
 	u8         vhca_id[0x10];
 
-	u8         reserved_at_40[0x40];
+	u8         reserved_at_40[0x20];
+
+	u8         reserved_at_60[0x2];
+	u8         qp_data_in_order[0x1];
+	u8         reserved_at_63[0x1d];
 
 	u8         log_max_srq_sz[0x8];
 	u8         log_max_qp_sz[0x8];
@@ -2654,6 +2659,12 @@ enum {
 	MLX5_ACTION_IN_FIELD_OUT_GTPU_TEID     = 0x6E,
 };
 
+struct mlx5_ifc_dctc_bits {
+	u8         reserved_at_0[0x1d];
+	u8         data_in_order[0x1];
+	u8         reserved_at_1e[0x362];
+};
+
 struct mlx5_ifc_packet_reformat_context_in_bits {
 	u8	reserved_at_0[0x5];
 	u8	reformat_type[0x3];
@@ -3040,7 +3051,7 @@ struct mlx5_ifc_qpc_bits {
 	u8         log_sq_size[0x4];
 	u8         reserved_at_55[0x3];
 	u8         ts_format[0x2];
-	u8         reserved_at_5a[0x1];
+	u8         data_in_order[0x1];
 	u8         rlky[0x1];
 	u8         ulp_stateless_offload_mode[0x4];
 
@@ -3409,6 +3420,30 @@ struct mlx5_ifc_query_qp_in_bits {
 	u8         reserved_at_60[0x20];
 };
 
+struct mlx5_ifc_query_dct_out_bits {
+	u8         status[0x8];
+	u8         reserved_at_8[0x18];
+
+	u8         syndrome[0x20];
+
+	u8         reserved_at_40[0x40];
+
+	struct mlx5_ifc_dctc_bits dctc;
+};
+
+struct mlx5_ifc_query_dct_in_bits {
+	u8         opcode[0x10];
+	u8         reserved_at_10[0x10];
+
+	u8         reserved_at_20[0x10];
+	u8         op_mod[0x10];
+
+	u8         reserved_at_40[0x8];
+	u8         dctn[0x18];
+
+	u8         reserved_at_60[0x20];
+};
+
 struct mlx5_ifc_tisc_bits {
 	u8         strict_lag_tx_port_affinity[0x1];
 	u8         tls_en[0x1];
diff --git a/providers/mlx5/verbs.c b/providers/mlx5/verbs.c
index 8fcef62..88f4c3c 100644
--- a/providers/mlx5/verbs.c
+++ b/providers/mlx5/verbs.c
@@ -2674,6 +2674,57 @@ free:
 	return 0;
 }
 
+static int query_dct_in_order(struct ibv_qp *qp)
+{
+	uint32_t in_dct[DEVX_ST_SZ_DW(query_dct_in)] = {};
+	uint32_t out_dct[DEVX_ST_SZ_DW(query_dct_out)] = {};
+	int ret;
+
+	DEVX_SET(query_dct_in, in_dct, opcode, MLX5_CMD_OP_QUERY_DCT);
+	DEVX_SET(query_dct_in, in_dct, dctn, qp->qp_num);
+	ret = mlx5dv_devx_qp_query(qp, in_dct, sizeof(in_dct), out_dct,
+				   sizeof(out_dct));
+	if (ret)
+		return 0;
+
+	return DEVX_GET(query_dct_out, out_dct, dctc.data_in_order);
+}
+
+int mlx5_query_qp_data_in_order(struct ibv_qp *qp, enum ibv_wr_opcode op,
+				uint32_t flags)
+{
+	uint32_t in_qp[DEVX_ST_SZ_DW(query_qp_in)] = {};
+	uint32_t out_qp[DEVX_ST_SZ_DW(query_qp_out)] = {};
+	struct mlx5_context *mctx = to_mctx(qp->context);
+	struct mlx5_qp *mqp = to_mqp(qp);
+	int ret;
+
+/* Currently this API is only supported for x86 architectures since most
+ * non-x86 platforms are known to be OOO and need to do a per-platform study.
+ */
+#if !defined(__i386__) && !defined(__x86_64__)
+	return 0;
+#endif
+
+	if (flags || !mctx->qp_data_in_order_cap)
+		return 0;
+
+	if (mqp->dc_type == MLX5DV_DCTYPE_DCT)
+		return query_dct_in_order(qp);
+
+	if (qp->state != IBV_QPS_RTS)
+		return 0;
+
+	DEVX_SET(query_qp_in, in_qp, opcode, MLX5_CMD_OP_QUERY_QP);
+	DEVX_SET(query_qp_in, in_qp, qpn, qp->qp_num);
+	ret = mlx5dv_devx_qp_query(qp, in_qp, sizeof(in_qp), out_qp,
+				   sizeof(out_qp));
+	if (ret)
+		return 0;
+
+	return DEVX_GET(query_qp_out, out_qp, qpc.data_in_order);
+}
+
 int mlx5_query_qp(struct ibv_qp *ibqp, struct ibv_qp_attr *attr,
 		  int attr_mask, struct ibv_qp_init_attr *init_attr)
 {
@@ -3584,6 +3635,10 @@ static void get_hca_general_caps(struct mlx5_context *mctx)
 	if (ret)
 		return;
 
+	mctx->qp_data_in_order_cap =
+		DEVX_GET(query_hca_cap_out, out,
+			 capability.cmd_hca_cap.qp_data_in_order);
+
 	mctx->entropy_caps.num_lag_ports =
 		DEVX_GET(query_hca_cap_out, out,
 			 capability.cmd_hca_cap.num_lag_ports);
-- 
1.8.3.1

