Return-Path: <linux-rdma+bounces-13269-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C44DB52998
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 09:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A52D9580E18
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 07:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE12626B942;
	Thu, 11 Sep 2025 07:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gO8JqwUk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48DD265614;
	Thu, 11 Sep 2025 07:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757574656; cv=fail; b=a+cJ7PJsqc9Af53aiXFw0xWSDrDGFzL3S2Vw37GdInIlgVmpqqR/zs8o/RCzG9abNhzAYWx+r5fhc0PnJf/pNjsMDbzd7YV1wMCsc6wxbhmc10QM4oI5wUugpkV/NbuXhRdBWXPQZio2KQ2E+O9ttL6ynY5k5yUY5x2MgBqo2UU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757574656; c=relaxed/simple;
	bh=Y+wXRF07RPDuftHoOJd3vuY1V9KTpZXApAtRzbO95P8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mQoGm4yqP3JvMAf+WD2pG1CfroDX2bikhCyKO5WTFOCSLqATm5vyqvPrGEXRf5H4gcjNscgxMlgbmOUT2uNStkOH0Kr0dwB7M3hsfdRqcxJAQ/wK8M6cgQ6ApLykAAEdA7cHFPAI1vBS6hKTTNfSVELLLThUJ5B9g7gh6hAGZfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gO8JqwUk; arc=fail smtp.client-ip=40.107.95.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6QC0V8uvmyaYtAIEf0Jnne9JKvRDS2n0Nn5rTSDhZItjFhMpYWzoWvW09AcxuibqG0OVwtUDNJDpozz5T4W3iLrKtnK/uMlE1XYcp9W9ALfq84sWqSqoo3w82CYyCz/JM1Dbx6O8M/B75Z13ftwReyUCUUzgeTrDoJ3ZZgB/Os8PzTM0RkD00uRThj7/utzls2yvVvPi1mdLoP/UM2QhcacAmCaXUUv15bk1pNUD6MgdAyanH1+A+jCEO27CQevHoelLPTC+L1b3STbjK9haeOgPjZX9tpFdq2OuilUXbeRKMw6TIk+E8ZPaejRXiMoQu+xyazYQH0ENThPG74oQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOYtz9FHLCd5gYWWWzNvYK9I/W2ZU6MdbN4FP/arZso=;
 b=fZdjPYZYoH9UAJ7ZID1Ve7aPAbek5eDvUaeG97IHz9LBKuR2FYf9J/rBJbloBwMuqUuBMKLGqbPVREakQBKoD54cNaThIwuIVmdUFnEyGYsVadWlQKRkOoIWll2r1rdq0/WgGFJ5CnrRlXWHRFzUrfhmbjAbgvQrqFxQ0QYPH3R388MFS8clplxJn2+0KuYFqgahEXAAV65sQpITdDd8P7w2+eXyfrl44Op/335gDepbhVlyCG0Evcs9VgEBV7HeEtDanxDJUUkqR51vXexOgExKk/NFljdZdIdtcoq+IaneFgxSo3sUi+ilwxIVGi1U5QPzvVM1sie7YzzCQ9v4xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOYtz9FHLCd5gYWWWzNvYK9I/W2ZU6MdbN4FP/arZso=;
 b=gO8JqwUkPfBtBYqf4eKcbDyiq+M5BhtsBzRuhzexNB2SHPB0ScvVUfO0Ew+XAg3irzWiwUoOgrAai4AIf8/tid3OyEKnw9n2Awi80JT5adYDaShfrsBdXSWcDA0YTnlAzle5FwcHWSDsTW2plBCz+kSSJ2IgElYDrpWogml05PQke/Na7TffG+4gZvGDllT3R46i+i67bBQE86uSWHGGCoLICR0lBQ4hLmni8Tgo0Tn+0/Oduf+dj7i706C+m6yR5E7Hr74j/BcmlXE7jaJlZalS2wkl7Jy+XmUQjRTK3d9+3iPhueZxdniLid9xpAPe8JbINYf/4qvfx7ZMVz4UGw==
Received: from CH2PR10CA0004.namprd10.prod.outlook.com (2603:10b6:610:4c::14)
 by MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 07:10:51 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::ac) by CH2PR10CA0004.outlook.office365.com
 (2603:10b6:610:4c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.16 via Frontend Transport; Thu,
 11 Sep 2025 07:10:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 07:10:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 11 Sep
 2025 00:10:36 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 11 Sep
 2025 00:10:36 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 11
 Sep 2025 00:10:32 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Tariq Toukan <tariqt@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>, Sabrina Dubroca <sd@queasysnail.net>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>
Subject: [PATCH mlx5-next 1/3] net/mlx5: Remove VLAN insertion fields from WQE Ether segment
Date: Thu, 11 Sep 2025 10:10:17 +0300
Message-ID: <1757574619-604874-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1757574619-604874-1-git-send-email-tariqt@nvidia.com>
References: <1757574619-604874-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|MN2PR12MB4078:EE_
X-MS-Office365-Filtering-Correlation-Id: cd390eda-a96f-46e2-494d-08ddf1025763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a30IjHTMer9KTu5SDGhuPg6D6+LlpjvYKL5RqGUSk3PTC019kxyB2I9ZXJs6?=
 =?us-ascii?Q?L6pxtuOOnIcYw6Ycjyo5pVVTkh/gkpjq5MFRQjcwxcVQ/RclIpvL0s/6Qrjj?=
 =?us-ascii?Q?XiomBG5WFzS9nrq2Avtq9p8pjuOBKKdWjJsnCxpcceQqVmLVA/XvUmmKGxTQ?=
 =?us-ascii?Q?Txtb5Y2iHg1JHYsWGzYGR9K8iWZbhEJ7PUICFbK+igHhP0/v0MDgFopU+QE0?=
 =?us-ascii?Q?wQts5v59qsOm/g+2ek8MKITB3jYibsTIXgq4306nX6//cw1kl7XcieBETiIW?=
 =?us-ascii?Q?kfny47kR1sVlVVr5GPOfnB4tHJul3s/4NWQDd2dLq0L8bosuG8Fh8NuTjM3z?=
 =?us-ascii?Q?jClxV7pMX2HC7WFwOtXxTTHVesfZwb4cgd3rktinL0g4fTPATSPaSVLo6/Dh?=
 =?us-ascii?Q?8MbB6LDnZMCihnDG7ZLrcWQj+qsr0osYWjUKKvFstN6aVS1j3pwlLEvO8evr?=
 =?us-ascii?Q?WWoOZfN1o7jw0L2e3qXFTa7xuBf/hj0+9YzFKVON+4DW6oy95zZ3Xf/iyujQ?=
 =?us-ascii?Q?7GJqSOcyyXqamBZB/YRgEeua8XBnp8cXbjd1/cqm8VAbavliFvNBajqTK9ni?=
 =?us-ascii?Q?qHk0LiEksdF+eurhmaoMg6SBeoiFQrRcvnHa96L2NYHWedHLOiKfX3vr/LTj?=
 =?us-ascii?Q?IsjJvILhO0Le4xwajcYTY6dY4rccwekqEBDCp7vZI1juN5Tkc9NVmjRiiPft?=
 =?us-ascii?Q?zZxbH0gZM0/Zlut7uNxh80mg/fEBzdZij+a36uAQlghGeIDAxQXp3UlVPLKF?=
 =?us-ascii?Q?u2FcTXHWWDqYnpJ9Y7Z3pBhwM6W2Nh6I4+WiH4eJ/B8+nNKbeFLLcvByW0Qg?=
 =?us-ascii?Q?4f7OQsbdfr4pILxSGrzj6JaQl/lBUnmcEsIAVolyE4fnMxk3lzAxmWkiN9US?=
 =?us-ascii?Q?8WCrKRH0vCTGwl2EZlvQEcwPYtCpeNoFG4kwlhhHmO+PCheUtBv2xUtiV3II?=
 =?us-ascii?Q?NjCDiLBllhzfNB811jikWCV16X+2ArT0eUZayAnxCp37eHhkh0rZ3xknWB9q?=
 =?us-ascii?Q?zquODaLMDtW34OLJGbXN/0QbLRZ3EhopOdbwUtHizINttNqLPZTJ5MHVSh6x?=
 =?us-ascii?Q?BUDj0IdFN1hRIxS98AeBm3egA8ssbR99TX/iOmB1W2Viv9IebSWmEwcmuitd?=
 =?us-ascii?Q?gAADSDmxILF1WpxH28f7pq7X2L6Bnipg92pV2BaVGTkw6Jp/AoqFkw+XpzNx?=
 =?us-ascii?Q?LCupS6d+QE1aKA0h8fgRuK63GzhV83O2/AsJI8ohevMaFlZQPZyd/ptRgk4x?=
 =?us-ascii?Q?ebh9RaP0CScDJAFTqGvhawp/WV1nV47sF1XO8+sGWqGuIlXQrFbGtzxtDpWQ?=
 =?us-ascii?Q?uSCIM3QEQLEiSfLKLG7Tw8TTglCe4UwFOke1SZ2nr6ikAEQpKIlRykClR8XN?=
 =?us-ascii?Q?9XdHf5sjEAQC3NsurdO4HCL6/kT3OSq1akeQoQchW5ivNjJf6Gwcrp9t7XDK?=
 =?us-ascii?Q?FD36d5K/tJHuR6pzWH2taQvf1ZWWJ/ec5QJOyttW8d/5RyAjk7VOM/HAw8lm?=
 =?us-ascii?Q?wpPX9axYZfBP85IgmSpKT9V2ZHfhU3vbOO5C?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 07:10:51.3747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd390eda-a96f-46e2-494d-08ddf1025763
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4078

From: Carolina Jubran <cjubran@nvidia.com>

Now that the driver no longer uses VLAN TX insertion via the WQE
Ethernet segment, the related fields and flags can be removed.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/qp.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/mlx5/qp.h b/include/linux/mlx5/qp.h
index fc7eeff99a8a..5546c7bd2c83 100644
--- a/include/linux/mlx5/qp.h
+++ b/include/linux/mlx5/qp.h
@@ -237,13 +237,11 @@ enum {
 };
 
 enum {
-	MLX5_ETH_WQE_SVLAN              = 1 << 0,
 	MLX5_ETH_WQE_TRAILER_HDR_OUTER_IP_ASSOC = 1 << 26,
 	MLX5_ETH_WQE_TRAILER_HDR_OUTER_L4_ASSOC = 1 << 27,
 	MLX5_ETH_WQE_TRAILER_HDR_INNER_IP_ASSOC = 3 << 26,
 	MLX5_ETH_WQE_TRAILER_HDR_INNER_L4_ASSOC = 1 << 28,
 	MLX5_ETH_WQE_INSERT_TRAILER     = 1 << 30,
-	MLX5_ETH_WQE_INSERT_VLAN        = 1 << 15,
 };
 
 enum {
@@ -275,10 +273,6 @@ struct mlx5_wqe_eth_seg {
 				DECLARE_FLEX_ARRAY(u8, data);
 			};
 		} inline_hdr;
-		struct {
-			__be16 type;
-			__be16 vlan_tci;
-		} insert;
 		__be32 trailer;
 	};
 };
-- 
2.31.1


