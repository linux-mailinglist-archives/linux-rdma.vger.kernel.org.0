Return-Path: <linux-rdma+bounces-12899-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C39B3B3446B
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 16:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 837522A243F
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 14:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAA930275C;
	Mon, 25 Aug 2025 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OuXXUMNM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5A33019D9;
	Mon, 25 Aug 2025 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132555; cv=fail; b=ucYgXsa5QJkkougrSP3XJVyKLPeKp1XwSPBO33W46Q8ValRKzfZqragCIWMxG9vXV54Tt5QrkQfthqZAQwRy2Ho68/Wvhe6xyqEpbskiyW2ST7ReANRb0jf2embyaSI3251HDL12TDS+GR3BUoXQ9kGb6XfxjK5SQz39P5fi9XI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132555; c=relaxed/simple;
	bh=xkloYycYEuzq1yPnEWRCtgsREm2mhHpXpA8Y32AeLmU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LT8Xz+J3VQk4hA6+AcocsFs4hQfU4XSWmRJEeOTAFrgrN9PHdQcdj9vWwgefFPiJdepI8SVMLoV5mFAlToAyx10Ft1sQhYI7i+oIAG3s+zmJwDV0OW2Z9bsz6UsqiEDJR2sKbsXNLjNrvtFSgXNYMEZKdJGDxea3de1CDcSOjiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OuXXUMNM; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+zPcz7CbyEvvUVXxKZQA1VaYBf868hOIHPTxfWgP8lA3pOCVjVGjhQHZ5GrPG0md9v+VxfYZFTqwisDq2ENaE+b3/EodmSP63lPREBpYmPJVdZhlXsoVQMcwCjfKxZ3aJQvD2+YiFf1mdE+1ZF6F/rT9JtC5APe68msKlRtVTyqsB/IeRUP2nvDbK0RDXslm/3rWolxq/0bG9SK4S90Pv0tXJKBrHS8gsigpQeXy72ZH1PinTJRujlYsl0C0f314Eb6e3mbeGBDdOidvt4mhaeegGqnjzyui7Dr4t7dbuDpswsUsT9YCYASJA4ng+M1su7AMLTibI6G+BlpEOUWKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVVmdQEo/gi6VrsYWXO+pqIIhhmIcXTmtUQ31mY8+DU=;
 b=mJUDb9ilIHVeYTEOaI4NGnMLCkk5JaqBBM3r/BdtKRrU8qtauZyILMHWKTiM/bdqoxcfQcjSqCJfcV0wj/bSaBudVEh+8VnArgnHvDm8m52K6Inv1nqrBhuQadbm+50ONMiU5XOwEIVkGYwBuH5YJgmxiZPpLwem6b/LpxvGo6V4AqYASnL4/Xq0HzPt5h+QicYh+yVe9uWn6tFjzggM3ArsWUOIi/ISgJgJgx35YdA/Evju5i53RN6GER4EBQa2KhlF8uCuNUZlOmqBZEQr1NmxMRCRZ9tDZoMkntPDb7UsecFbGlrCoULC0r1pZmZU3ncOwWDrJNE+lXPijEffGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVVmdQEo/gi6VrsYWXO+pqIIhhmIcXTmtUQ31mY8+DU=;
 b=OuXXUMNMaE9v/yed1Ihb9UTJRHGYp/kchaAMqu0qHrykPt0pfiaeyZ/4aYeBAd2Oq+V9M0pomBxhW2+MVqoIW2GSn98JPzxQVeYwCIj8BcN+fTvPyxJ/YdLSqnkGEGj/nQFKaMeWrtQywOi44hCXYHdHX/SBuVDxxyBKYGDYtzjGv/HezrVTpNRvn1flVcf5XPgv09kfoPxiAB3tKTaP4KnAhISt5rrzK2oqujH3+aiXITvaVwn1qTT4ILiB4QNOuSWbU8RJf3HKOITBzWZT5AaQVeFeGwmcfoQDvtYd34jlG0hiieB7Xx84dHIrPCMiRa29uVPXe4+jbh74sqGHmw==
Received: from CH0PR13CA0044.namprd13.prod.outlook.com (2603:10b6:610:b2::19)
 by IA1PR12MB7688.namprd12.prod.outlook.com (2603:10b6:208:420::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Mon, 25 Aug
 2025 14:35:48 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::34) by CH0PR13CA0044.outlook.office365.com
 (2603:10b6:610:b2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.10 via Frontend Transport; Mon,
 25 Aug 2025 14:35:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Mon, 25 Aug 2025 14:35:47 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 25 Aug
 2025 07:35:29 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 25 Aug 2025 07:35:28 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 25 Aug 2025 07:35:25 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>,
	<linux-rdma@vger.kernel.org>, Alexei Lazar <alazar@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net V2 09/11] net/mlx5e: Update and set Xon/Xoff upon MTU set
Date: Mon, 25 Aug 2025 17:34:32 +0300
Message-ID: <20250825143435.598584-10-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825143435.598584-1-mbloch@nvidia.com>
References: <20250825143435.598584-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|IA1PR12MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb2793d-6b61-4efc-9dd7-08dde3e4ae97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bfiuVIlMaULLcJIGnB46PAdXTm/q/v/oyD0tB7WAzx7AmcjVob09D6FnedA2?=
 =?us-ascii?Q?oRli959d2R2MHpBHvUrrHvcGtMb8FMmASPUQ2/2uWeQqvP0SwTZojqcEWvH6?=
 =?us-ascii?Q?a0LuwH01Y4/FaDMcuAmZINRwhEmSbawzJNiXZFrNDUFTa/W8675EklC3E1QH?=
 =?us-ascii?Q?N32lOGY2p/vEBUeaquWY8/Kvu7Fhnwm91lwPlHFEKufYvtH5gOu7kIMwaZoa?=
 =?us-ascii?Q?mS6UxoamQIwqwRhZ33C51EcjkNgsuUBhkvPJ5E69YHq74PvTH3jqlGS5Naae?=
 =?us-ascii?Q?ZMil/9lTgS/J6xj5oOgjwPyJ5+cnJLnWxPKHcy8doN0U3LU7gHc80URHmF1K?=
 =?us-ascii?Q?Fi1khlXjqnPc6cksDQlPl5PvPTX5rCpkJtfwe7kSGiKvlG0Wjx15jffuKZic?=
 =?us-ascii?Q?OsFOCqZpPMJnLdtlizV35fQC0pUTrbSzHOyO18jy25+Q9lB1QJEYVPtbPOvB?=
 =?us-ascii?Q?MkRRNXH5gOOZdn7I1+HYUUY36UideF4KMg7jBGj8Bp5jtcNOG+PGKnIgzxKS?=
 =?us-ascii?Q?9quZtGJqpLgOypZ7KDQQIXIG1IANBvFU6rVb//DH9KQmxsKkR0H9il/92tmh?=
 =?us-ascii?Q?IqKKzWgSIMu+Lf/6vu/abxdeaMEy3fCVewv3nAANV8T4OQSUPEibJjRMzsxQ?=
 =?us-ascii?Q?f+6L6VusWc3brwj6So4zeJeZ2y7Anw0DPB5P3XWPlyBNqx3Bls/ZIKI2244W?=
 =?us-ascii?Q?2w8TvOXDtRQXbkP6FgHGJON9MeRGMyd00WhyGhELvfGI6lcDfiTD/XNJqXiL?=
 =?us-ascii?Q?PmTD7+CiLwSlz08W2W5M/pDC8ec/W0wsRi180luXd57tXHbBXrvO0EBFNV7X?=
 =?us-ascii?Q?E+63Lf/Q2uHjsn2pw75+xMV82ZZBpMy5K3sWuX0G3Rl+ci08M62YZzNKu81M?=
 =?us-ascii?Q?mN2mbgflI4cvp7KfRxI2zmJJHB7zLJFZNYzVI1MmfAhI0ek4riwO2+HkwPRH?=
 =?us-ascii?Q?7c6c9SrTWdPdIEQzuggiBMoZ078Z6DhG0jaMLDRa1AuUoeYqgpiWL1TpIf6R?=
 =?us-ascii?Q?2iiHSa/EjfpzYTLbP03kX69E/RXOyI0lY065T6Z/sSgxThLw8b8unR+nZdx7?=
 =?us-ascii?Q?WCYam+Xiz3ogyqF8WXMJ7m6JMCEkBSH2c47tKuAkQP1c5oNvPDyDmW4m+NqD?=
 =?us-ascii?Q?PV23AoXfeFr9VbzNSVZ0W5sXrJEOKC1tNjkTJigo3+yeE2+CATvE0aiFtvTy?=
 =?us-ascii?Q?QfzkrakVT9QM1d8u3yfIYssf+OXJtvQHACcfzhYt9p8KNkxxXnVekpxTNSzr?=
 =?us-ascii?Q?lynXfFGN8EQRZr2S6hYVVSgqR1evvnaNz1ekAt9K1ctOhe/lmJDEW1umcxOw?=
 =?us-ascii?Q?vOlDzoTJqUFIl+dgyAF2MexI9c3vpeaPbxkHRKJALaodjRVjecVqqC/LUEBc?=
 =?us-ascii?Q?vvFyCH/hBdcxPhXcNkFBwcHTktdAvPu3fjIxU0oeyycdhFxZlVwjLPWyCYod?=
 =?us-ascii?Q?VeXsvmKJlI8Fv2oI2vx9av1+Qo7zs+PUmuyAcjsu3RiGLCGr40tImD+eQaIy?=
 =?us-ascii?Q?BtvESySLMuL8b6XOlAGNM0A+r+PLUO26144a?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 14:35:47.6019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb2793d-6b61-4efc-9dd7-08dde3e4ae97
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7688

From: Alexei Lazar <alazar@nvidia.com>

Xon/Xoff sizes are derived from calculation that include the MTU size.
Set Xon/Xoff when MTU is set.
If Xon/Xoff fails, set the previous MTU.

Fixes: 0696d60853d5 ("net/mlx5e: Receive buffer configuration")
Signed-off-by: Alexei Lazar <alazar@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../mellanox/mlx5/core/en/port_buffer.h         | 12 ++++++++++++
 .../net/ethernet/mellanox/mlx5/core/en_main.c   | 17 ++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h
index f4a19ffbb641..66d276a1be83 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h
@@ -66,11 +66,23 @@ struct mlx5e_port_buffer {
 	struct mlx5e_bufferx_reg  buffer[MLX5E_MAX_NETWORK_BUFFER];
 };
 
+#ifdef CONFIG_MLX5_CORE_EN_DCB
 int mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
 				    u32 change, unsigned int mtu,
 				    struct ieee_pfc *pfc,
 				    u32 *buffer_size,
 				    u8 *prio2buffer);
+#else
+static inline int
+mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
+				u32 change, unsigned int mtu,
+				void *pfc,
+				u32 *buffer_size,
+				u8 *prio2buffer)
+{
+	return 0;
+}
+#endif
 
 int mlx5e_port_query_buffer(struct mlx5e_priv *priv,
 			    struct mlx5e_port_buffer *port_buffer);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 21bb88c5d3dc..15eded36b872 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -49,6 +49,7 @@
 #include "en.h"
 #include "en/dim.h"
 #include "en/txrx.h"
+#include "en/port_buffer.h"
 #include "en_tc.h"
 #include "en_rep.h"
 #include "en_accel/ipsec.h"
@@ -3040,9 +3041,11 @@ int mlx5e_set_dev_port_mtu(struct mlx5e_priv *priv)
 	struct mlx5e_params *params = &priv->channels.params;
 	struct net_device *netdev = priv->netdev;
 	struct mlx5_core_dev *mdev = priv->mdev;
-	u16 mtu;
+	u16 mtu, prev_mtu;
 	int err;
 
+	mlx5e_query_mtu(mdev, params, &prev_mtu);
+
 	err = mlx5e_set_mtu(mdev, params, params->sw_mtu);
 	if (err)
 		return err;
@@ -3052,6 +3055,18 @@ int mlx5e_set_dev_port_mtu(struct mlx5e_priv *priv)
 		netdev_warn(netdev, "%s: VPort MTU %d is different than netdev mtu %d\n",
 			    __func__, mtu, params->sw_mtu);
 
+	if (mtu != prev_mtu && MLX5_BUFFER_SUPPORTED(mdev)) {
+		err = mlx5e_port_manual_buffer_config(priv, 0, mtu,
+						      NULL, NULL, NULL);
+		if (err) {
+			netdev_warn(netdev, "%s: Failed to set Xon/Xoff values with MTU %d (err %d), setting back to previous MTU %d\n",
+				    __func__, mtu, err, prev_mtu);
+
+			mlx5e_set_mtu(mdev, params, prev_mtu);
+			return err;
+		}
+	}
+
 	params->sw_mtu = mtu;
 	return 0;
 }
-- 
2.34.1


