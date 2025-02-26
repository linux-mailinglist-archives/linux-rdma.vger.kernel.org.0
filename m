Return-Path: <linux-rdma+bounces-8140-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EED12A45F23
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 13:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3058A7ACCB5
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 12:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B467E218845;
	Wed, 26 Feb 2025 12:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ibRDPJZe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAE02192F0;
	Wed, 26 Feb 2025 12:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572823; cv=fail; b=FdjZW3gG8wCFZ1fDmW23juqEu61HlE2+S6QizeqzF230InmVqkvVOPW0CniufuZ89RENp/5TKiem2aMnhVLoCaAKXzuWU26zp5Mop6E1OzSYOvBW6yrQ+c/YTs2MkrBexUg3bWROpsGRNWXgAbo8OS9RqAWAPU/xW/EWnkCVWAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572823; c=relaxed/simple;
	bh=y3VJiONxsn/t3KhkNesvKxKWrH0VKgzNMYMt7+ppBGk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ho/6680ozgp8Cl73pz2du/i3K5eJP+r2KXExCJCI6ojK4tDFCS/tR1GhHDdCv+PyzrR5tP52v0E0vxaSfSZud0PMu/Od/EpwxL1DbXrYtSlLni+1D7lgWyBi/DztZewOSqKJKyEZNNE5P5nAdukU+4PCezqPQ9j5kAlfB5JLw/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ibRDPJZe; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P33w6ulJ+VziLaROL6c69mivYENDLHAG8qyEWNpU+9w460I4Ifdz7tgld6niLdUnEneTPsclpybfqkfEf4JufhOSZSPle8vwnMOlNUzPPZpd7TdS5Y9UEWY4V5sjI5jR+mtzyj/XKHho9SqJfOnMScMBUI4LnmEjVYu+URfD1z4Qs5CqQ3LDeUlniWs4P/yblDwXKwAXrcfHH+KT77WUW2SC5gawBKf6AavvUvsVMb0XtzSdSZ7qX5fbIDukaDlQVUumTT2jo4egc9bmLibVTkyWAWo65yp10Vm2pzYQlr5897rJWR0KNmBWAqw80MyoJpK/r4c4pA+B7Ce5sp+FfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHUnOPf59BiFTZ+RmRs9Gu0/+QYSJY2niCh8yHfcDbw=;
 b=JsbuunBnjszsOTVjREoSsJxAnOb7mnAMVGUiIVgrb1tdqgHWvyruHFVPgSshYzhNv3vlBqtShboMQe1LDQY9talNCKlkZFgEHPu+32rpmayHL4x/+lf38McrBCwdn1ihJFJA74UB7/oinQXbdSaYXTMixeagCNOmLoIe/eM64GGzQuGMrJS9prgpsNNmeoB8XptDWFdvFFRkL6EAm2CGTyF7fhGcAv/f1zDfe+julO+HPIsw5gP4O60nuF2TKQBFI23a3oCOiVpx/qKS2MGdlqK1VherdMjyMAcY3JOV6nWj2DurKQA7hxbcuf8VAxIf99PXcHBFOTPCVmtoC1lJRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHUnOPf59BiFTZ+RmRs9Gu0/+QYSJY2niCh8yHfcDbw=;
 b=ibRDPJZe/QCTwyE2j1gnYr15J56wV7lBaHS9WavNemzkpDkJnJcekVOBmdJQLYBiYp9ov/xpJ+TuQ0UGYyBpnLeVzI58NnbO1obkov5RTyuzMGqyDv0VOdbqZ2r05UHa5sT67p5Ul9uZFfIX/afDKxDmtvZPetmDcJa+MuKIESwhO/SBudzfbmte7Co5oXQSbyMuEde5REfRdIj0jLelg7Qet3VEDiqlUT5rtaWIQ9KwmBW+dONLQv9mR4tp9OY+5ZLZ+UsIZMCF3tQkvdmRYkvdz1gkfYa0mbRbzhMrdujbfFymvWn17JDJQj1nnSDtPVegkym6vo13tSt0VGs4RA==
Received: from MW4PR02CA0017.namprd02.prod.outlook.com (2603:10b6:303:16d::24)
 by MW3PR12MB4476.namprd12.prod.outlook.com (2603:10b6:303:2d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Wed, 26 Feb
 2025 12:26:56 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:303:16d:cafe::1b) by MW4PR02CA0017.outlook.office365.com
 (2603:10b6:303:16d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Wed,
 26 Feb 2025 12:26:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 12:26:56 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 04:26:46 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Feb 2025 04:26:46 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 26 Feb 2025 04:26:42 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Tariq
 Toukan" <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Shahar Shitrit
	<shshitrit@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: [PATCH net-next 3/4] net/mlx5: Expose crr in health buffer
Date: Wed, 26 Feb 2025 14:25:42 +0200
Message-ID: <20250226122543.147594-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250226122543.147594-1-tariqt@nvidia.com>
References: <20250226122543.147594-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|MW3PR12MB4476:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c5c931-d032-495e-142f-08dd5660dbe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LepueS3laHd799/jIR+qsljIXzwECbYpkrlUgfU46z6qohZVSNeo4ref+uHp?=
 =?us-ascii?Q?dv+I0DPRyOJXZHeruz7AssAp54pMKT/XwLJl2U0h4wE+sseoHqvFPvCgvT8m?=
 =?us-ascii?Q?umcjUJWSILVOtGGo9E0eY3zoA5Drye+s1afJRalkqJQe8ZrNm7AkvsK6M0Ft?=
 =?us-ascii?Q?puh6PlD/x5T9y/TbSDHnKQB7ptkemQ2lpCtG8kLMIBrVuaG6NasGIRyJ8T7S?=
 =?us-ascii?Q?p1mvwNXRb3fTiAcnY7I4dQMs/bl7a1Y3ghG6OlxRWVf9gMJnOs7/IXKjfd8f?=
 =?us-ascii?Q?0qvM09bs9AaYZhDAyc6c3pd56u9LAkSmdzMoewbmElwFF/H/LRkfIzAEAI5E?=
 =?us-ascii?Q?dh3VoytDgKUFzIgASifXAu9bCWFNgf5kpw5m7iMcjKPhi1cNj3alYVr3piMh?=
 =?us-ascii?Q?RvdeMlZmnJ1q8ooNRSxlGt0kgKEZgWKmb6TUy2gdoQlnM4No71zwPiCIpBUN?=
 =?us-ascii?Q?3JGm8Tp223P8WeMr9B1CCJFv3+Gl9ebDwkTyFrVBdF4TK91mYxspdZnmdcOh?=
 =?us-ascii?Q?zEJxllv/NTSFtzv45h4fVpn+Fec09GUs1scey5HCC1OefKuU5lPYuNrBQN4p?=
 =?us-ascii?Q?uLPL2FUNSjNFjWYtLE4v+20bX79khEiqb99K6FuNzv68A34FcAhJClgG+hjc?=
 =?us-ascii?Q?imAoatnRKFUZZgRJ3/r6dsSVfOgTkWSSass0vrGNp+HJTEeJlkMg5g4VFzGH?=
 =?us-ascii?Q?vFHQ70+FT0TdIUCGTU/H+P/FCdMW58y8sTqh+2BZ6Q3AwAtMkuzG6NWunmOy?=
 =?us-ascii?Q?pOylLnvDQJu+a8EeAhrr5PoUy9KfQ4weQakFuDl81jNgOWuKQ2GJb7y1CVwe?=
 =?us-ascii?Q?IkMC+fUsWyFngemVkRJ49XyF3Sm2PbAJJUSZeY/Fw5KE1jpT0tfrUQTE6Ejq?=
 =?us-ascii?Q?AvZ64YU48EAohnD2vSXq49y40xz2ZLEJq/vxpp57HPGzb6oVGX+bkrunpxOH?=
 =?us-ascii?Q?uWuWh/74ImmzgdxLH5GKFR8yMu2GAmgD7JqtrQldJHgreKsnqWUsZXRqPp5L?=
 =?us-ascii?Q?iBMeRlFtomjfQLunSvo6cqVQzi0YIprRfRmQVA4bfoRsHMam+VA0ldA+w5hX?=
 =?us-ascii?Q?WqCgeBW9ygbG7lYuW+DSd97VwGM5pnNwCt1Z0uvUOH4+UVr6u2qkhpry7/O/?=
 =?us-ascii?Q?d0i5aimaoG6oiqsz0lhzp0CIspOvQEEovqXDG8lqhnsv4im1jKuiYGVdwhxC?=
 =?us-ascii?Q?tXxuRhcYtJ6bXAQ+TAB4y8Puf+fS/gAf9RW8OuDnEP5yPRBE9LP/48t87F8Z?=
 =?us-ascii?Q?5hWiu5guA4Jf5VxEnoaMLxtLjpiWW+bpl7ymzeR6oUTpH5YyQNTvifWG96DD?=
 =?us-ascii?Q?fOhXT6dV6D5gPYvGQH5yBTb/16+z+TmjJADUz6NM9dSgcVNSEXMn9hVcEV01?=
 =?us-ascii?Q?siLWZm/3BowdOvU7cpbVozJxyRwwcZa0sFtztWUIi9WBaWiCK+0vSFpMLe2b?=
 =?us-ascii?Q?r5IW9K4jJWevr5YRvhpt7Mx6kuxefWpbU6FJ07m4RvslTEf7Fhz0gyDpPLgy?=
 =?us-ascii?Q?1laJtssRgI9QOlU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 12:26:56.2197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c5c931-d032-495e-142f-08dd5660dbe2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4476

From: Shahar Shitrit <shshitrit@nvidia.com>

Expose crr bit in struct health buffer. When set, it indicates that
the error cannot be recovered without flow involving a cold reset.
Add its value to the health buffer info log.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/health.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/health.c b/drivers/net/ethernet/mellanox/mlx5/core/health.c
index 665cbce89175..c7ff646e0865 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -96,6 +96,11 @@ static int mlx5_health_get_rfr(u8 rfr_severity)
 	return rfr_severity >> MLX5_RFR_BIT_OFFSET;
 }
 
+static int mlx5_health_get_crr(u8 rfr_severity)
+{
+	return (rfr_severity >> MLX5_CRR_BIT_OFFSET) & 0x01;
+}
+
 static bool sensor_fw_synd_rfr(struct mlx5_core_dev *dev)
 {
 	struct mlx5_core_health *health = &dev->priv.health;
@@ -442,12 +447,15 @@ static void print_health_info(struct mlx5_core_dev *dev)
 	mlx5_log(dev, severity, "time %u\n", ioread32be(&h->time));
 	mlx5_log(dev, severity, "hw_id 0x%08x\n", ioread32be(&h->hw_id));
 	mlx5_log(dev, severity, "rfr %d\n", mlx5_health_get_rfr(rfr_severity));
+	mlx5_log(dev, severity, "crr %d\n", mlx5_health_get_crr(rfr_severity));
 	mlx5_log(dev, severity, "severity %d (%s)\n", severity, mlx5_loglevel_str(severity));
 	mlx5_log(dev, severity, "irisc_index %d\n", ioread8(&h->irisc_index));
 	mlx5_log(dev, severity, "synd 0x%x: %s\n", ioread8(&h->synd),
 		 hsynd_str(ioread8(&h->synd)));
 	mlx5_log(dev, severity, "ext_synd 0x%04x\n", ioread16be(&h->ext_synd));
 	mlx5_log(dev, severity, "raw fw_ver 0x%08x\n", ioread32be(&h->fw_ver));
+	if (mlx5_health_get_crr(rfr_severity))
+		mlx5_core_warn(dev, "Cold reset is required\n");
 }
 
 static int
-- 
2.45.0


