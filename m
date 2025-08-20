Return-Path: <linux-rdma+bounces-12835-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DE9B2DDDE
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 15:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 704604E53E2
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 13:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68550322764;
	Wed, 20 Aug 2025 13:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hl6xwO30"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6A372617;
	Wed, 20 Aug 2025 13:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755696796; cv=fail; b=Q2A/1SfxTtqR6hRTO8Y8o7hSiijqVPA2k0I9mFDDkzkvwKeMyFPaFYQYiT6AWcZF3/KQpQ6foSEa9hT816Tqbi2zDahMCPr2k3vyW5yf3lA4PLWxfX4NZDEn3pI5rrGdUznqHfWTIFH4Sk/K1qhzaZp4rUPxQU9YofXOrsIzyOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755696796; c=relaxed/simple;
	bh=wMpdBoH9MQqH40FfSIdb/YaOqgGGHf7EyjkRM+cWTJw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+qP7qyOZ82V8NUtNYAfhl/Yn4WVrKz8nuC4hdPC4MBJ72JV5un17/ffEHLDJmxkYPKNVXqOZfy/GfSeM64M9HiEPUKslRYGKsg91LsvafER7CT+9drt1c9zGbF5CduC+IgkH4Gtm/J1rMxCBPmbswaL24p6y7gk/0XdlbIv8M4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hl6xwO30; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5jZ2VL0kVHlkeFQPDNw8IoeceMxSBlSedEn5HDkase7ESKw5E0HYhg2mIsbdr8y/DgztUg/JTQNDw/H6C5DRpjgQN8BbXjUlnMpSMj9z22p5CRfnWeYhPjZH4sCK5i5P0/qLFW6UcHmWPfpILt7bLsGoSnQls+PsGqYjeOsrjiPHQt40ynywF2pwHUaYDNUEVr4H/1vfc6rmKvPVkd2aji0iyy69BoWa/kv7PLNE9wbK+ngEnf/Tsc6NOsNDLHxxYV3wn/59/SZ/R3ycWvmZvP25UaKZuIWaKsrls7dLYy7bkbMX9lRmaCOqe39I93gZlRevoi9DCxdyrNZI+pUcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTYnvJVkttrcVr1q/Bx4+5/X7LecRqfX1OCce41F0KY=;
 b=S0hNc5dV2VUwWGpJmK0e0VPMDU4Jqa/zOmiPi5/o8NaZ/1eRdkIAXIH3yiXfP1Ttqumy21KPEuyYSmNuG4ZwN+wzq6qZGbK5Udutddg8/K6+r+r6000bjCYNjTJM8FQKacUyHOqfzEGiYUbaksbuuIB6u3HL3gmpMwMiVKReOFtjLi2LkKtzHr2zVPx6ZJUjxxVZfyuT1POOQMzY+mKrB/NALhGikvv6Qi+AZqplC5i5ql2MGSroVflFtKd9MgRwA14Hr8C5N9QjXfPGVm8/WfdWtQytmouESQtldOWahSyf5EmVKNmqeNN9aOw+E1hCE/PsMHf+Xj1Gq6mWI7uSGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTYnvJVkttrcVr1q/Bx4+5/X7LecRqfX1OCce41F0KY=;
 b=Hl6xwO30nFF9W1VlV7chC7WJg2xTM5dds3fAJvkp5QidqqzWvolCsUDe3leTLcBT63/TEmvdls2d/7bA63eELVH2jHY4vD8ATvFboTN8MVpEz8lLEs/NBZFC+If0FpNKhnOe+Xa8+VfVQp48DOMNvVfEZDApzaLGoDxO7bF4SOIlKFTZxakMxCaIe5hDdwsKPr62tkQdmhtNJeC0MrUxR+55ossf834g1p57wlnY5JnXPT0zLCY057FRzywaAIgqhrFgJRoY476cziE3rJe1LEPWgNaima1PD7FmsJqC9sevH3Bmr6Cr+69Bx9FF250Ey+RI0ZVMZH5l2nlLzfRrBg==
Received: from MW2PR2101CA0012.namprd21.prod.outlook.com (2603:10b6:302:1::25)
 by DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 13:33:10 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:302:1:cafe::80) by MW2PR2101CA0012.outlook.office365.com
 (2603:10b6:302:1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.6 via Frontend Transport; Wed,
 20 Aug 2025 13:33:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 13:33:09 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 06:32:47 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 06:32:46 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 20
 Aug 2025 06:32:42 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, <przemyslaw.kitszel@intel.com>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH V2 net 5/8] net/mlx5: Fix QoS reference leak in vport enable error path
Date: Wed, 20 Aug 2025 16:32:06 +0300
Message-ID: <20250820133209.389065-6-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820133209.389065-1-mbloch@nvidia.com>
References: <20250820133209.389065-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|DM6PR12MB4401:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e851e36-88bc-486c-8335-08dddfee1aa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W2h9JjXR1jkKSOUs5eA8QSNaGXSNdqEEjMg+PMMdgxjrhOoCO8i+n7r2tUdY?=
 =?us-ascii?Q?z+J7dBQZhe0Qp/wS5w5qXRTQ7EzckO2AMe1lwZLniicGC5/4Mpdw9GH/wyIB?=
 =?us-ascii?Q?ncfUz/KLBAUlWVnT8KvS3jRlHIvrZ5nTpcQaGrjaPQvsFrI26Etc8XM+od6Y?=
 =?us-ascii?Q?y0q7WCOMTheHuZt28S2BDQPbctStiSBROxMX76EVuyUUw8mZc4ufOlWq6/pb?=
 =?us-ascii?Q?gX409O5WIIHR8iwcD26MSlwSEWOlm1/atGLDqzgQUF9dlz1USgzK9bs/A2p8?=
 =?us-ascii?Q?x3hKpfQ0OT7vxXQ+CS81A8j7Gnhv9ouROpU8YsSREgr9tXwhFcjWqcnpbJRL?=
 =?us-ascii?Q?eQTa4RSuKCB6BwKJXocrCVhyX2lU0y3HJpoHBbYUUUJW+0J7Yq91ozHZS0Zk?=
 =?us-ascii?Q?pyny3GIQoC/VcukIe/0+ygiW9bFXLrOKyaa76pSjeXQ2i6VaDMldVehVcYF5?=
 =?us-ascii?Q?stJd3fPgfxKeW3xNTSdG8BCVRSYPXCeWKf3GNY0YrqyQb5Yeo7z6XGJOEzRg?=
 =?us-ascii?Q?nVveZvXx9Adtd++pbFJLFqKPwP82PQYraUSewoOmaeANuNl5l779/0X0z/bu?=
 =?us-ascii?Q?S+XbS+wL96fa9hW1LfzlwR6Uj5wtakeE1jc7rSjXMoiyl2Fy+1sq1YO3WEpU?=
 =?us-ascii?Q?t6hVjq65yWKFRlY1Xb271fYbSc3s0r9x649D3EUc6JyvzVw8aWmEaYe5X+kU?=
 =?us-ascii?Q?+ATiqkgmxyWuf+bPf2CJzlxORDORMqR+iVFg7yT8WCSr8pSkCd5jBF03NSOm?=
 =?us-ascii?Q?9D7kWxaV+9O9p1YkatloHajGECX84ckxJtyOzy0kMLSrsTeXa2qEG1X4wI1L?=
 =?us-ascii?Q?Y4tEYoRIlhBzBjJ1jbZR/FBx1m2I6Qdz0DTFwBkWYOu5jpAh7n2Tbu0004VG?=
 =?us-ascii?Q?jvKdb17mL8HDKesgmndmIiPy5uSgW0P3KFImKqJhyqm6RfySwnIxPMdrD7hJ?=
 =?us-ascii?Q?jaiK2T/9yrK9GKdcE1X+4iNZPIdVD5fuxb962Y5xAudbmwmAgPgPr/Xm/v7S?=
 =?us-ascii?Q?+L/zXOkS23w1ncAAze6LzXGzhoKgGNY31/cj3ai3+NadrAS3+sP62udR7ZGl?=
 =?us-ascii?Q?/S9v7vGJQwZdilBjarlpVYUNTY421RedHnToh12CGyJCjfWu0ZEswbGPlB5/?=
 =?us-ascii?Q?zHuMDg0IjJY+YC50Njm1pZ3A99+iGmlolKvdWn0Dllw7t2WmHE8Nq/nWRdbM?=
 =?us-ascii?Q?GKQXlBui+PcSfmBPyTSUqZBW6Pyvzw/A9SmEfjBsT1pj2rHAxqWAdEvYF8/A?=
 =?us-ascii?Q?0u7N1cPIagNl47//xiZ89wMfOpw057VqikRmlCVAmHVTvY3U83BcJviFx+aM?=
 =?us-ascii?Q?wfV0p4QdZAcHpRmZ4b7x0pnqrzKf1VxTUalaij3xn4sehMco2HgqUUNtFhaw?=
 =?us-ascii?Q?g1Zc7IRu7HzVLtBc6XJ+koFm8o7CvNlLc55nrsBo4Ws7vbW18W69nSKEnQts?=
 =?us-ascii?Q?LE1oFFiWbUxStiPZrMWBL37M+wjSzZeZrimwNyvLAM7IrsnLi2s2zmB0/cM7?=
 =?us-ascii?Q?/O1laFsvkBxZELcyCUithzZervvE/kbrodqF?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 13:33:09.7383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e851e36-88bc-486c-8335-08dddfee1aa4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4401

From: Carolina Jubran <cjubran@nvidia.com>

Add missing esw_qos_put() call when __esw_qos_alloc_node() fails in
mlx5_esw_qos_vport_enable().

Fixes: be034baba83e ("net/mlx5: Make vport QoS enablement more flexible for future extensions")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 452a948a3e6d..41aec07bb6c2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -1109,8 +1109,10 @@ static int mlx5_esw_qos_vport_enable(struct mlx5_vport *vport, enum sched_node_t
 
 	parent_esw = parent ? parent->esw : esw;
 	sched_node = __esw_qos_alloc_node(parent_esw, 0, type, parent);
-	if (!sched_node)
+	if (!sched_node) {
+		esw_qos_put(esw);
 		return -ENOMEM;
+	}
 	if (!parent)
 		list_add_tail(&sched_node->entry, &esw->qos.domain->nodes);
 
-- 
2.34.1


