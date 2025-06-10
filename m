Return-Path: <linux-rdma+bounces-11149-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD59AD3C9D
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 17:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDBD77B233E
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 15:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEAA242D60;
	Tue, 10 Jun 2025 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j9DJERE8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48E624290D;
	Tue, 10 Jun 2025 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568332; cv=fail; b=rDknkfYv/CCl6nupvkhJgtGN5+5RHnD7Dv4DwjjC+w9UG52+oF4BeaBn07rkAMtt72eQ8O+PLwJxtCHZ7FKJc1rcPH6n97nO1syzN1Egd2lqSjq1LHf3VTmeYwZg36DSBiw2NLhIUkRPZKgxM8qfOfVwQEefXnxR5t91Wp18DhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568332; c=relaxed/simple;
	bh=800E/gChn2LbRF+wMGwgHb7zNZE9elNQ30Lyaq/OI1s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3X4KguOksSd+Cq5xOmcghVypCUSLneufFQfpd97tZeY61DsWKI+bF0SzOJijOz4YNmjz0aZ2ysXDFgQav9e8ejvRff61zqAofGOZrect2lvNzdck4jImkzC1sMYvOvlBk5iw+DMy5d4yGUfeGWvIQPLkoOmTX9SgOb9ecM+O98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j9DJERE8; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8oXgFGuScSoDQjxsHtWERzG5JfFsG/Gkr7qridOvtYpxVrB29I52axB7LCDtLZ8ssNEh9LAmfgSc5TwI6iG9Y7/EKc7TVV7hTXG7Fe1TKrC5oQFUadXanwBw2pnwVlTsT4FM8o68QmRjsfv/vlDtaFmckxQCbuD4X+TZrxPgGEr8fwXrWUx4oTi4fCl936EcrZanBiYsZJpFEtqzkGH6cdoOATqE7YwSVo5hGU+Rro+0Erolg5IUWr3N8BkiemYUk8ao9aJ4TbqUGTi4AqitkFOaOF4XNfT6qgFC276HUrmqDqZHk9We2k1qm4VpeK8oWRDrMwUaxybOpcdm/rg8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fp4OXnxJCwnQ0BwA1z4VvmBiw+0bjL2e+Zv6ncvy3Zk=;
 b=n5zwpI77Tba0YpaNfMgXhOKCv1kcGffMsK1PsL10HpfZ3HVssiIXhutMjPmakK11DFbUepTOtkT2TpTGpa8GWNrJF2smDZ0Vx1eBwEFgqa2qfC2Ncb5SmBxQFyXPlnX53cjyqvEesfYNsq4p7mULhK+9SggWeZLCmMNdMOq9wSwUqPhX5QDAC5pjuBqvxb7YgSFZGCk7TTxnTOBwpRY/N7yaAuNSVR6y/AnwCE9Slx60gmCfUlhwrcAjVQPiYgylAoJJmi6FTFFt2X30JuK2q5qbG5S+XtRPebWFpax3w7Y93bJXzDCPxj+XsUCD3dowN3nnKRo2SraFvovZuSrnbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fp4OXnxJCwnQ0BwA1z4VvmBiw+0bjL2e+Zv6ncvy3Zk=;
 b=j9DJERE8QsSYx7n3WmDfk0v3VLjEUUeq0WIz2mAGSKPkcg4/XaOe0dmkmxZpo9NB92VLZi/noUK028i8SdCZB8PMWT3pA1gNVGMuPK/taunNEreBq17eCwKie1rDtpjBA9hc64mRP6HBQDA4hRxA1EUEbHtAAoC87rcAXS3NTfx42+66RujkBvO/hqzvmcbyH6O8EC+FGPopT1YWX4S73nbDPLxMU/cNrJFe0t7Chltkn3lWsYVRbLddmN/ARfGPhPiNkWNly/Q4lQ6+3CexsB87CIJRRaBapVw7KDiFC0mNTokuYlAqHvM2QKN8+V44mCfp6IfyDSISV+JO6BvZXA==
Received: from PH7PR17CA0042.namprd17.prod.outlook.com (2603:10b6:510:323::21)
 by CH3PR12MB9122.namprd12.prod.outlook.com (2603:10b6:610:196::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.41; Tue, 10 Jun
 2025 15:12:08 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::84) by PH7PR17CA0042.outlook.office365.com
 (2603:10b6:510:323::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 10 Jun 2025 15:12:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 15:12:07 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 08:11:42 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 10 Jun
 2025 08:11:42 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 10
 Jun 2025 08:11:38 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>
Subject: [PATCH net-next v4 11/11] net/mlx5e: Add TX support for netmems
Date: Tue, 10 Jun 2025 18:09:50 +0300
Message-ID: <20250610150950.1094376-12-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610150950.1094376-1-mbloch@nvidia.com>
References: <20250610150950.1094376-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|CH3PR12MB9122:EE_
X-MS-Office365-Filtering-Correlation-Id: 84d915d0-5e27-4fee-34c0-08dda8312a88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CViv52GOH4oq7lfHZ+hqVyqYbw/NOXeAyrd7M3N5G6nhbwGYO/5i+HqQBHDc?=
 =?us-ascii?Q?XxUK0GWXHF/h7GkN8oXv1320wsxz7sKsAqexQzXRsDglUDPNydQlbpsSjkIv?=
 =?us-ascii?Q?mTy2O9eSE76pPxwHZ++/OY/sq8j0TW7NxaQS1J8QtjJgIfXFp7WlH2lJNbuS?=
 =?us-ascii?Q?VvC15ZmzVWd3OICpc3H4KpsfUS/dKBtBXlAMfpHuYW53lU3e5s7EYYsULuZW?=
 =?us-ascii?Q?GYgLUQNtJ0lgtuM7Y+RoTpMJPdvYqFsaGmMOgV4T3YtfPXMmsNgOCfm73gXS?=
 =?us-ascii?Q?CQMjPPCDqLwRyAxfU/ZbBn1WK1xA9OB1Wo4kvEBng6adLhr0B8g6Obr7/+GS?=
 =?us-ascii?Q?sX02g/Rts90n6O6OULE+y37d2wJBo3vHS9CE47BOuE/gMrDmOKZNuaubrvos?=
 =?us-ascii?Q?Xd3VTN5GxUysRWEhuxUQV/CG+loXzqchKWNl8rAfZMZlx/jFLz5T4JJcVvfH?=
 =?us-ascii?Q?cuUVBubOO1KMVtDDC8aRPxPyop5HGAq5+HQRCFcXubI1kkCq5Jd1+UO+utJO?=
 =?us-ascii?Q?aCvR2p7717mn1+nMK/ykvw3uDs5c1RKmpuQw+T4jHo2IjZyr79PZ7aEcjUwu?=
 =?us-ascii?Q?+F2pAy18UsVnK86lcBOq9NhlMUBDlDxzyzJMmpNOzF3HholyIXhiSarHVaLb?=
 =?us-ascii?Q?R7QgNroOyhn/zPP1wTAMtziyNo9veVhlPk/JQHCeMV0FUVd8sH2vZ41g1A0n?=
 =?us-ascii?Q?YUTpKzr1g8Z7m//jeorhDZUL+JknvL8WNxm8dFU3fcuUZixELhWhqfQTZXrO?=
 =?us-ascii?Q?PpknoDmZUu/lOmXvzLKYj81H0XsQqmXmaC3sfIWvB3/cNWQmmEpP35xHcPzK?=
 =?us-ascii?Q?P/ojWi7atSjJ8W6Ynb7l1LpTMhjaBW2yOYeAmjNdAivNXcG5PgJOLjptUgam?=
 =?us-ascii?Q?RBDJlDa0QCJODP5C1oLmKNY6z9FhYgcJt2tqEuorGcPPiqWzWZkq2FO4UWfJ?=
 =?us-ascii?Q?uvHnd9i1RUBAHo9gXOpXsX4OjUJyQPpt2FyTo8PVLBhS9y8tdnmRuhYmcHgb?=
 =?us-ascii?Q?h6U70Mk7MENixLlUpc/JxSncV7ptTIPggdWRPw4q2a5lCBiVvuoUSwQo1q9v?=
 =?us-ascii?Q?8pi39aRPzPKJ4Db1GGLH4sgYz00JPBFPh7Luq3ID+NdGP8pgnNido20XuZo7?=
 =?us-ascii?Q?LNOrxFlboWmSgIIQy/9JxxMir8UQwew139t9pElp6qzl59rjPtt4qgwQCwJP?=
 =?us-ascii?Q?tBxcgwE+s5YS6Xz1YR0/9zM2FnAUeAWPYw83YvNG+sYmWPnNig9yHqmsG70E?=
 =?us-ascii?Q?6jC2qhqitsl9zNZZlarBkiAbdAiA2FZC9TQRqIJUTK4eQnkWK3wpPQ/fEBG8?=
 =?us-ascii?Q?cP2bptwElgS/MUst4HXsPCSxdnRb+6plRwHgDplLww/TagyxHfqflJOb3GY7?=
 =?us-ascii?Q?p6m8Gz01AlRhGB5CYn3rLxok+T/h4gp/pj0TPUyaaJd1NL1cK0tCQ0cgtOFh?=
 =?us-ascii?Q?P+/Md//say9iVMiEmHPVeWIrPBCBX+Ck0dmhr1KnmtmtB7b13Bee/9OTXOWo?=
 =?us-ascii?Q?UEIJ+M2zzN8PiPaFfc679UPDzWybfxibRgN1?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:12:07.5563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d915d0-5e27-4fee-34c0-08dda8312a88
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9122

From: Dragos Tatulea <dtatulea@nvidia.com>

Declare netmem TX support in netdev.

As required, use the netmem aware dma unmapping APIs
for unmapping netmems in tx completion path.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h | 3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index e837c21d3d21..6501252359b0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -362,7 +362,8 @@ mlx5e_tx_dma_unmap(struct device *pdev, struct mlx5e_sq_dma *dma)
 		dma_unmap_single(pdev, dma->addr, dma->size, DMA_TO_DEVICE);
 		break;
 	case MLX5E_DMA_MAP_PAGE:
-		dma_unmap_page(pdev, dma->addr, dma->size, DMA_TO_DEVICE);
+		netmem_dma_unmap_page_attrs(pdev, dma->addr, dma->size,
+					    DMA_TO_DEVICE, 0);
 		break;
 	default:
 		WARN_ONCE(true, "mlx5e_tx_dma_unmap unknown DMA type!\n");
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 026bd479c6dd..1f2973e82733 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5740,6 +5740,8 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 
 	netdev->priv_flags       |= IFF_UNICAST_FLT;
 
+	netdev->netmem_tx = true;
+
 	netif_set_tso_max_size(netdev, GSO_MAX_SIZE);
 	mlx5e_set_xdp_feature(netdev);
 	mlx5e_set_netdev_dev_addr(netdev);
-- 
2.34.1


