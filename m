Return-Path: <linux-rdma+bounces-15218-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 965EFCDDD13
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Dec 2025 14:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D90D330336A5
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Dec 2025 13:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB0631ED69;
	Thu, 25 Dec 2025 13:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mpx1gwKY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010070.outbound.protection.outlook.com [52.101.46.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C1E1E572F;
	Thu, 25 Dec 2025 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766669261; cv=fail; b=OwOSRrSagFeFhohpqHyFQWzbocIrDUfHjb7oe5vvykFeFZM7Rqw4Y5kDAsl8elvs/GIWg35zgWzwkiTvNg0BZ4kzs0Au7pK+F+JPfvWMu+QBzQQaYydzNLtaV1oU4xQJsR3eQRYyqjwbh9slFC+F7Dda8V6+SaBHSFsH8B6G4p4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766669261; c=relaxed/simple;
	bh=w61YJGg9qT/yHkm0Q+e89KzKZBLP4xL25hiYtIHxTI0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aNDJbv0ED5lj1kYoCHF+ijo7kHDQk39gt/RTZXd0DfUzIxTHu85MST/0dITCxcDLOpRu9RaZYVMrxpLY60ucm4gK+hUBnoShBEMl4bYsGFsIk3HbjFwlolFFfp2mCyW+qIdW6MT6FoEleLUpNLzo4hIz4SXUPcC04WL/usuJS6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mpx1gwKY; arc=fail smtp.client-ip=52.101.46.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8a4/zydoLVit5OZnw58SrMPRcONO5EzgPvZhYX3RnjrAR9Wu3irpvoxRY+YmySLLFVXrJ+jAl8B6fB0tXk986B6nSjZKzuMWLlFezMQo+fQpOmRyfX2LanysnQf6xVH5o7qRrxJK7h7/dAQcJyvMF64UE3uMupV2fq1cMqh8uwk05yqYrLEIamqY+kcZmzvtrsCzy9mpH2cJNhyAjtVk+rTomchQgt4vY5p3ERp2ATEb2kkix0HKNSxwek+mnoC3xbWQ0HG6VD+woCbnpOx9sylRlr5U68qboETmwWRsjSPjauGhpCWE3rhHtczyO5G/8cdQRlliqLYJfxqfTjICA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCnwP+qz/1C0+vp22e378RwuaEQ/BSBvAWEyFnx04Hw=;
 b=XTg2P+uqAhtFvxpF8ICMnFFYA84l2OJX6jleRiQu83GBe3upBgk7+bqGReZqpUGgBSiFF1drjl5OAddMPnTnJcdkgfL+XArLMqs5XydUzulmFXLzBng1pn5yCcTBGuSyAcfPz/RP2Ah7W5BV0TaDtdssENKb3Gv4w5oNjqAwUIa9wLOhaPUer4Ran0XHOUTTGPPjGLgEnITIV5i03u+K8oQIPif70s3wKRczURRj9w7APA/Qr30O+Bm7fXWjfJuXD0atGAt0a2awY7ZWvuT4+pl6dGQ8S0grcx7hpxvMMypYY9NPBJPMSjNJIzgnvx4NKrieDqTmmx0C5TyWe0KVEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCnwP+qz/1C0+vp22e378RwuaEQ/BSBvAWEyFnx04Hw=;
 b=Mpx1gwKY1E9VfdSOeRxm065qp0gaEUX7MUaUeLTZJfRJcJtwSwRTScZAJjM4dh2xDhw4etPKorOYCzoq6kfkeXLZh/Q8Dqrta4cW+e5SReglq0B6FXt9M7Y6mvvqKfTkrtDMZIZnTxSTjJW+FTdsi1WW7uJZmqO7Tf2V/tETa7c8mpLEBivizXqvhri334sGY3sHZVNmXWiN36Dg5+mjbConB1SBTIhY8ANxqHFvIJ/pPqqZ3P3OK1pORgOUGYWt3JhEqgKq7bmGFHzVNF56CaDd8vgEvjcHgdRLj4igmDiYKq5YLtDYdLush4gHtdO8gOsqp4yzR0d6afGuakilnA==
Received: from SJ0PR03CA0230.namprd03.prod.outlook.com (2603:10b6:a03:39f::25)
 by DM4PR12MB7767.namprd12.prod.outlook.com (2603:10b6:8:100::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.12; Thu, 25 Dec
 2025 13:27:36 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::79) by SJ0PR03CA0230.outlook.office365.com
 (2603:10b6:a03:39f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.11 via Frontend Transport; Thu,
 25 Dec 2025 13:27:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Thu, 25 Dec 2025 13:27:36 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Dec
 2025 05:27:36 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 25 Dec 2025 05:27:35 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 25 Dec 2025 05:27:31 -0800
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Alexei Lazar
	<alazar@nvidia.com>
Subject: [PATCH net 2/5] net/mlx5e: Don't gate FEC histograms on ppcnt_statistical_group
Date: Thu, 25 Dec 2025 15:27:14 +0200
Message-ID: <20251225132717.358820-3-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251225132717.358820-1-mbloch@nvidia.com>
References: <20251225132717.358820-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|DM4PR12MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: b4953cf0-8088-46e2-c399-08de43b95e71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WYRMULzXtw7h5ErIV0z4uGwsVF8eFOfuAzwvmHZalNGGZDauM0WCxS8ix3bx?=
 =?us-ascii?Q?lece93zYk9xlwgHcS1pu/9VDKlelY1JFkzh9fgLpPHHvR/+jC2g8PE6p5Xvj?=
 =?us-ascii?Q?1TuegbGVg7fh5EFgk6iz6iT9d20HXHl4F8jJawvfu3oLH6mt7BCEQoypGr4b?=
 =?us-ascii?Q?YASz9aomT5QRCIEoBxjm3DBtX1gnaTLLkR3AWH0+DYVjsVqYnnEluF9K5ORC?=
 =?us-ascii?Q?aptmRXgt5M7wqorzHlTSS9CE3C2u55qZ+BxNw/mwEFjwsPsGrd25Feyy/m8A?=
 =?us-ascii?Q?CFncSkMfeuTicLxXHsmahnQXopBcBvSk9TogyMJNvhkDykCPov1d41AczmYf?=
 =?us-ascii?Q?Ngvf+8DCWN5S3dyK8Gu1hIyczFB5fpIMZ+r6CEyHybd+xnmzyGZuGbCUPRVz?=
 =?us-ascii?Q?V965luTTOy1SjUbIn9A/Ony1FwXND+nUuAkph5FOS1QULwHtKBj1XtklyY4C?=
 =?us-ascii?Q?lCGJd+4rTOv9fVgv5dEIW8b/XoABU8ZzDlXVfMC2w0CzFjGXmU9axHTVEsR1?=
 =?us-ascii?Q?SmV9Hc8ldpscUkQrmNnlm6UjzbE5VZaoXtygu6SwAGSQ/LsApiNEtFeG1Q/r?=
 =?us-ascii?Q?DUAea0KEanStb6esCfkxgR+RrKDFcWtScFLzIf+nSpcshzZ/wIDEk3TRk40Z?=
 =?us-ascii?Q?M/CZHaeplm9dQ19gteHFn2fXRki9+hyG4uG5xyvp79r8jFOnNHoLlGsiU1bl?=
 =?us-ascii?Q?3G167bA3pck+vqpYcaB0zbuFi0y2XL+7KVXcX1BVtcpLTZ/sFA304xg463PP?=
 =?us-ascii?Q?AcFvjP+tW7ZQcZevH7t33Vs3rawsF6hkU7uI6FRy/lOgifDHUkDjm5VKyVY1?=
 =?us-ascii?Q?uAp9ixV9QIYXA17HSohYRW1YjJGyFTKyQ7WTpw5LIUP24B9mSlByO4eBUn0d?=
 =?us-ascii?Q?za6PXJkY39b4tBUoaS7zTfJwAa5yn3zR5g/1YhGJoBAf+4eyOhLAEgRK5Ik8?=
 =?us-ascii?Q?9wU8UJDqumhyfwpuswMY1CexI2NTqAhPyierrQjP4lt1EgTrkwsJlbEx1Nc1?=
 =?us-ascii?Q?qI1m909DZTCmF/kNFZ/w84CeoX0BJA8JxiNALUhROwQ6JqTgm6QQ3+CW8ya7?=
 =?us-ascii?Q?yUp420aiKjUkY84II7SqIiSA/xpPjfJCPyb5LaOxi/etZusdeY9J0IPUcKpw?=
 =?us-ascii?Q?EHKOyNDKJtbJ60A26LQnktAP4Ch4k8PVIYXeSL3PJTRSkkn4bDT3Yo0k2CFN?=
 =?us-ascii?Q?L0+XTuVGNpw0YnpNeXD4Yw8ELBIYk31XFItZis7yX2gyvP59OQvI+032Ylqt?=
 =?us-ascii?Q?+Hjnaji+vdt5O+Sm1cn8Pjpjw5obmM3Hp2NCfuj2dlHGS2zymaNJq0FbbQQU?=
 =?us-ascii?Q?0wdaO3xNAAFL+mzFuYow+FC0GKgrExDF+jowMK+ygNhlE40/jR4uz7gYXYKe?=
 =?us-ascii?Q?vb5PP4XScmGLwgzhswolQONuny3210T789foTS5E3S67V1VK2YVdpZL4mTz1?=
 =?us-ascii?Q?kWPS2EaiDt2evdEJY111GqK6Dy/is80IkJ1uBaTrhoQNXhOFbjLAivYy+r9r?=
 =?us-ascii?Q?ACXrplRhKcWJs4874ZuTWDZguO3CkLVdgzeJ3lsnCQQZcjuWf82HuIDIBEj2?=
 =?us-ascii?Q?IwK3lqJb/iDep7PP2sg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2025 13:27:36.5444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4953cf0-8088-46e2-c399-08de43b95e71
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7767

From: Alexei Lazar <alazar@nvidia.com>

Currently, the ppcnt_statistical_group capability check
incorrectly gates access to FEC histogram statistics.
This capability applies only to statistical and physical
counter groups, not for histogram data.

Restrict the ppcnt_statistical_group check to the
Physical_Layer_Counters and Physical_Layer_Statistical_Counters
groups.
Histogram statistics access remains gated by the pphcr
capability.

The issue is harmless as of today, as it happens that
ppcnt_statistical_group is set on all existing devices that
have pphcr set.

Fixes: 6b81b8a0b197 ("net/mlx5e: Don't query FEC statistics when FEC is disabled")
Signed-off-by: Alexei Lazar <alazar@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index a2802cfc9b98..a8af84fc9763 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -1608,12 +1608,13 @@ void mlx5e_stats_fec_get(struct mlx5e_priv *priv,
 {
 	int mode = fec_active_mode(priv->mdev);
 
-	if (mode == MLX5E_FEC_NOFEC ||
-	    !MLX5_CAP_PCAM_FEATURE(priv->mdev, ppcnt_statistical_group))
+	if (mode == MLX5E_FEC_NOFEC)
 		return;
 
-	fec_set_corrected_bits_total(priv, fec_stats);
-	fec_set_block_stats(priv, mode, fec_stats);
+	if (MLX5_CAP_PCAM_FEATURE(priv->mdev, ppcnt_statistical_group)) {
+		fec_set_corrected_bits_total(priv, fec_stats);
+		fec_set_block_stats(priv, mode, fec_stats);
+	}
 
 	if (MLX5_CAP_PCAM_REG(priv->mdev, pphcr))
 		fec_set_histograms_stats(priv, mode, hist);
-- 
2.34.1


