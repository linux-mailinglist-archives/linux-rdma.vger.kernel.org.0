Return-Path: <linux-rdma+bounces-7823-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 828DBA3B6FD
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 10:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57539189E44E
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 09:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56E31DF98E;
	Wed, 19 Feb 2025 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oYqlWdMt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D661CAA85;
	Wed, 19 Feb 2025 08:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955584; cv=fail; b=iTZK2a1iuzaeLnAL/oTNwMRjDwwr5l9jhTQCvj1hMk1raJmuefL3c8ncLSpEVi6Kl2iZGCMTNTiq/1iXgFxM/OfxMnZC5lCdA+FkFKgZFKlK7saiuRvOwYnU03MJc1YKfvdpcpQVp8qdIw3KRwlIdTt4iKSuer/vy11J1UZNSpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955584; c=relaxed/simple;
	bh=qmbo2u66MoJbxJ/GdaCmntr3PtKUyXK28d5S3XoHmYQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G9j6LCdR1YKgUugfsTL71Atykkd1fIzdFcUhO+MmcfIxfXizV/EjSXssUL3vU2QfkEER0gG4C2GdQlFxD3N4cGBjv97aOJYK74gT1FJ/AyO434u0cUoNM6g2n75n7FQQbZt4rtr+gKpEO1w0C3UkC3xgrVoy6qRmsZ6xrXepIcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oYqlWdMt; arc=fail smtp.client-ip=40.107.100.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVfFotFYsak4I5pqactxvmSaadP1W99Uk6rULRNLmb4MCijXoX50P4+JZlWW/TDM6GhWqEpuOhbqbocXUJWMROPQPTt8YiJXI/TZ7t0spOU6tKXyXsIK0Lk6ZQoyIU4eFBtlXMjU7FPiNo3oLfvUt5n25mq1kL8ObHk+9arLb8rI3nMYHsRevMjkoG6GJwba3YtIn1YJiatIk1OvjSJ9laFTrw4/ERRlNtZNOy2a5UoNAP5FivPwNpRputxa1NO/UOSYCrfhA/1OhYpzy+4FUTrquhulDGRNhqdte2RzdelBbubpSAX/j9u2E5T3O92kk84NnY4DvmPMXW1/acZ7sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kw6B2ha5KfFEctfGxMAzCSPyi9Waiikareq8lKKnOww=;
 b=attwfpj7Zbxym1gvpatxNWQv9Z0477AzE4iIiuBH6T7kawI2s1+Huye5UoyYaGef6U1vunXqm3aug1AWFHYv4KLCFyAwZDKtnYskO8kQZFtCCVxnWgSo16fKmHGfOYYV1el14/OtQC6JTusnJWBU/F7fszkXtB/sGkRrWg6rtBkFtEMoQHy93eQgjJLh+QrLcwWUA45lqdCI25AZFZ1CAgqXDR5ZB9OQwaOKIVRAECzoLIjjP2eur8HeFmjLUQpYLSwRvJnunvQSYptN4VjBkAE/LtHQKs/ts5PjtO0fCSlPHsY7D4wX/iw81JMlJ7Vddk00lNBps47Si6CKDCoVLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kw6B2ha5KfFEctfGxMAzCSPyi9Waiikareq8lKKnOww=;
 b=oYqlWdMteJJmq1PiNqddxyX8I4d8WQuuBHHDjmDpYRY/aZDAHVbDs0m4sWIwuqezrGV/v/t6qWTvgcpxUn/u8PGe1VArS+/Vnc7wuB8OKqk4Sfc7L4W7Fe3xB58+3RI1zkRQ1uk/lzw+1r72cL1GMaHfSxmghpqBESb0vMZOcaHhgbcVk18BZQvcQkOzDoAasBDh4bQLKDIVXM+0KPk+GU16V8dlyEPcjqdtsvLhQlQaGKXKhJigoCaVaTnEq9ZVLNHSNmPjYbLICfsWuQUAyAVYCi6Nh3HKYu4lFzaGTfNgUjLyFrhFxlEUe8rMxaFNswhAASzMx1TCSVbFFIaHxA==
Received: from BL1P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::11)
 by PH0PR12MB8822.namprd12.prod.outlook.com (2603:10b6:510:28d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 08:59:38 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::31) by BL1P223CA0006.outlook.office365.com
 (2603:10b6:208:2c4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Wed,
 19 Feb 2025 08:59:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 08:59:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Feb
 2025 00:59:24 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Feb
 2025 00:59:23 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 19
 Feb 2025 00:59:20 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Leon Romanovsky <leonro@nvidia.com>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Shahar Shitrit <shshitrit@nvidia.com>
Subject: [PATCH mlx5-next 1/2] net/mlx5: Add new health syndrome error and crr bit offset
Date: Wed, 19 Feb 2025 10:58:07 +0200
Message-ID: <20250219085808.349923-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250219085808.349923-1-tariqt@nvidia.com>
References: <20250219085808.349923-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|PH0PR12MB8822:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d88ed78-8501-429f-0fd9-08dd50c3bd7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VijGsrEI4/eDBxKDwYZG8x3T1Psq6jtHeGobexbSRSCumGP4g5GAXwtecNLA?=
 =?us-ascii?Q?0lxpGAqypsrRqr3Z7dQDc9tvp+fjrxYZD3/Z1qQ4rEDSilyKIJQFfjr/VbNG?=
 =?us-ascii?Q?jH/GpbYTkUIcBtnIE+df/O1a7Bq4rmsSpYaHuLWyFthRQ8XNWTu6d4MkZMdV?=
 =?us-ascii?Q?omEY4hQ3t4k1IgJxGPhaPjV4ZYZA5AftrHJPU6Qbx/ssr8vIufe417R6I8zZ?=
 =?us-ascii?Q?UwH66jC0uAbNt+esg130oE6FQjYzXxfKsmPWHkaXRXwQEI9JwgIE/YuxTGmg?=
 =?us-ascii?Q?avUI8i1dHOhZN2EHnhZVHvE7rUUI2s2+q3akWuws1Zro128JA6ntPQn1THCt?=
 =?us-ascii?Q?qfyNRN6Ol1WbH2OPJthiAi8zMtE4Ytmmz1doUxvpVJDK1UJoIRyZJFfSeJwe?=
 =?us-ascii?Q?OtvnZIAyedLey15aqghM5fUTjyDso96MOYvIBEggbJsRkF/Lqm8RmCPE2Rgc?=
 =?us-ascii?Q?W69VFvZXngbyTEVprSuNBmjixk8cbIARn5mesELXGOPS8T7iQ5miVuQ5iv2s?=
 =?us-ascii?Q?Y59lXJnAR4CF/fK/yuVAZSz+ktUJ0WNLEjkhC574/WXh5YHBv/ACFtacIlqn?=
 =?us-ascii?Q?MirUfLvnFf0e8R0rfl11VKTTZjZFDgbe83wMtjiJjcNPTWxXjfP0T9m3lAy9?=
 =?us-ascii?Q?Csy4J1VITkhiXLnx/6cDDOK+u8EF5rGflq/cwVjvJo5SXkt8RhFbXpWeo7zI?=
 =?us-ascii?Q?szKrtPJLbG95YthbLYwF7AuD1AJZ5dd0F1llH5KciMBsitX+lgJQF74yn2BH?=
 =?us-ascii?Q?qtMZ/4ENuP3iYijeqFWYbiMTHBsigreTs/tWntziBDGo2MLREb+h7gE0vR2g?=
 =?us-ascii?Q?S6KT94W3pREBU3FNb+qg2Cd/MZdjbG657+0QWnXD+D2cPMT8x5AAggcEyYNP?=
 =?us-ascii?Q?avpwdbATk211RLQjOOiezo61/XLLj7In+g+OnT+pFF+FVF51BhJVNxomUYFk?=
 =?us-ascii?Q?b8n3iJosMmKf8TrzuDTi2UrPL4hOiSWQf2rSaa6aWcBbt/nyuJuTCQTPbpCl?=
 =?us-ascii?Q?RJ47/1Ubvz4AUI/KbFNq3PPzjm+qudNZXz0X6HGzntxu95rVS2kyDIFGfrI+?=
 =?us-ascii?Q?Ff12mVcqnpKwn7OoBpFdHztPxkqUD8/to0VlMJlhi7CpUuu4FckWkCTrlkvA?=
 =?us-ascii?Q?KKTVe6MEkLm63Ia6DVheTMdrl749jVT+HvXPVjraTKgS2G80qkYCuscny/hi?=
 =?us-ascii?Q?eQE5rtrSqAvci+nZqCwJMgamNwxysgmB+aCLwwwJWPForIAeCoiXyUInZW2+?=
 =?us-ascii?Q?MwG853qJY//sfVgue+tVtJnhwrNBsDhWKQ75pYnIApDy9PSl58ivK9i+WMaW?=
 =?us-ascii?Q?1wJuRKGeg93aQbRDj2bm06g+qfxeC3dmeARH9SulZESPeqzukt/ym3GCHb1V?=
 =?us-ascii?Q?ZRfGJsor31D271V4uNWthF7EO5RMJKV3cl/Y4jNeHpn35zFAZ4BSFrTj6oB6?=
 =?us-ascii?Q?sSmu7dz4xxYtpqyNFSwFUTwsGRdUIFqmkNUMvdfKMyf/NSIIOgbJehnF4FHC?=
 =?us-ascii?Q?ARA/ZKj4A1zsFPc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 08:59:38.2316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d88ed78-8501-429f-0fd9-08dd50c3bd7c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8822

From: Shahar Shitrit <shshitrit@nvidia.com>

Add new error value for trust lockdown in health syndrome enum.
Also, include the offset for crr bit in the health buffer layout.

These changes prepare for downstream patches that update health
event handling.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/device.h   | 1 +
 include/linux/mlx5/mlx5_ifc.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index 0c48b20f818a..fd37f4e54d76 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -538,6 +538,7 @@ struct mlx5_cmd_layout {
 };
 
 enum mlx5_rfr_severity_bit_offsets {
+	MLX5_CRR_BIT_OFFSET = 0x6,
 	MLX5_RFR_BIT_OFFSET = 0x7,
 };
 
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 4f3716e124c9..cc2875e843f7 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -11119,6 +11119,7 @@ enum {
 	MLX5_INITIAL_SEG_HEALTH_SYNDROME_FFSER_ERR                    = 0xf,
 	MLX5_INITIAL_SEG_HEALTH_SYNDROME_HIGH_TEMP_ERR                = 0x10,
 	MLX5_INITIAL_SEG_HEALTH_SYNDROME_ICM_PCI_POISONED_ERR         = 0x12,
+	MLX5_INITIAL_SEG_HEALTH_SYNDROME_TRUST_LOCKDOWN_ERR           = 0x13,
 };
 
 struct mlx5_ifc_initial_seg_bits {
-- 
2.45.0


