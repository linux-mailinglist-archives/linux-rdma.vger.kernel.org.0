Return-Path: <linux-rdma+bounces-11842-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 975C3AF5FFE
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 19:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E91924A4F3D
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 17:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE0630B987;
	Wed,  2 Jul 2025 17:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l5kYlbyL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8C5309DD2;
	Wed,  2 Jul 2025 17:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751477242; cv=fail; b=Myh0JhnoU2YUGVvXYJvTsfWAYjNIDJjqWj4dxVUsRQREihL1YtEH9E7oVTQ6i32O9UUtl+srlPNc0oRGrNFGjCpiXI9ie5W2EPyANaGa2IefJ2Kb4lxL2UGcDs1KLLZ+ha9pHAemLhZj8dWi6iM6W6KyNuVVvSNsHa3dLp1vI+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751477242; c=relaxed/simple;
	bh=wwtrxLCh6Dp5MBqnHKZ5FE1GcqmzM6UW81/n6leaRGk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VcsnHQca/eRRbPF/UA1Lwu1wX1ssimyQ44iZ6MfoeJevRIsfER7mTL76q2l03Nyy+NHKE6VwX4ovLVnsu7DNGPaAwvOIXM39iJR0W97Fqiu8wylCv5e8sQnd8yEU/hVJvN6/mffRIdXGOwnQTUfndGgGWLjNMB93X3jd0YVXC1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l5kYlbyL; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qfa7MtClBrt4pcYDRY6oAKmtf7RqIxcgoYFcTyDo/u1d2up4vJwUbbWY278t5MgQtsXEfmGMSjp+9rstYGwOFAQQCwxAvX0fjOHzTQ3bXVBPmJ5p8O9TDY4n0Tr3vnpYcs3NM2yLpf5D+8gKsgA+PBG9Fainvii5LvtLVP1im+xMyTuRKNHQFiI96PgVeAElv+7jdnyLSv97UK4/gKW9ROVtlyxAtHQRKk1S/E33QcdHE0h2hjwE0Ztx9Hcbcrc8bdsgLrirtiFNN9mJRH4ngOm680Agk3ZeraEG9W+0HmrwngFDGYrQ0kSQCA7JzLIMSkeKG/wsy09/L3b8IfSSqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhFyP043ZG9z3x0YFAHbRvJpMUALxWGlb2nuEudxRxA=;
 b=VTZnrkbuARA7cspx6l3KkPO3Ku7VMlGYNcL/t5tQOSJf2cQZXgOxdZS2N6rLv/T+dCEnMa729n1DElylpg1rr2NYwc5u4+P6NBmj3GQ0vJsdsewrVGl6cDoFTYYWELkW1tLxADqI07cKne4UrPX/pYlMXoshY+ljUiKdPp5LY7hjYI4tllF4tbVv7ixfPJTFsi2V7/WdQoGP2r44JTcKjKHZPnaK5eOT/tAFEf1dGO4gVb9oq9zWwp5+Jk80xq7T126M9JzvwmW7jStzpegVoA2UPU0WxHG4ErWjFwWVJgWC/iDcmA7KdEUwcUASWwckzJd4kOcNIRtUrO8Mxf2APw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhFyP043ZG9z3x0YFAHbRvJpMUALxWGlb2nuEudxRxA=;
 b=l5kYlbyLDD2wGgpmiQkP59n4o0GGo+/fjHuXDF/mTUa+P/8hIqh4ysYjtlKsn2OcK2DdmViTeKwvijC99s+zEikF/qIYVZCDz6QYoK7p/TN3UiVOU87KDk7sqapcT/ZpgZaPh1sl+GxIKYKf3v2I14k+i6tzy3JhrVnZsxExiTqyaA5pkA+06yWHQajIUkrVbrIPI5Wlq1n8vnlPzzsAlQ1dS9yxVx8P6pWsTYBa8Ho6Z2aRsu01paxu6cbDzBlQiVielYWjNXq0iYQW6c/R6cUv9VWNHSWiT4pibHSV0xIx3kzwxbfbHVAdaz2wPYC+Pu6+TVgNEBjI6rFsPPJLFw==
Received: from MW4PR02CA0008.namprd02.prod.outlook.com (2603:10b6:303:16d::27)
 by MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 17:27:17 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:303:16d:cafe::22) by MW4PR02CA0008.outlook.office365.com
 (2603:10b6:303:16d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.21 via Frontend Transport; Wed,
 2 Jul 2025 17:27:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.20 via Frontend Transport; Wed, 2 Jul 2025 17:27:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 2 Jul 2025
 10:27:03 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 2 Jul
 2025 10:27:02 -0700
Received: from f42.dev-l-178 (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 2 Jul
 2025 10:26:58 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: <almasrymina@google.com>, <asml.silence@gmail.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Dragos Tatulea <dtatulea@nvidia.com>, <cratiu@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC net-next 4/4] net/mlx5e: Enable HDS zerocopy flows for SFs
Date: Wed, 2 Jul 2025 20:24:26 +0300
Message-ID: <20250702172433.1738947-5-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250702172433.1738947-1-dtatulea@nvidia.com>
References: <20250702172433.1738947-1-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|MN2PR12MB4128:EE_
X-MS-Office365-Filtering-Correlation-Id: 27781aa9-70f9-4935-540c-08ddb98db197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iC4q1Wx0UCeMQrFaXzwvFpoVBl4YIORitnCyCzSDrZJ8yl6P0AjXodCc7I5W?=
 =?us-ascii?Q?JibGX9ndedUQW78k1plPxUR0b/CbImOELpnpLFqxRl8V/6nm+CJlbIBJWxWU?=
 =?us-ascii?Q?GeDsYSOTecp45UJ/ZfLc0/eW6SEqw5YZkCVgRJBjxbFHn3fpFazOa761qf6j?=
 =?us-ascii?Q?GISFbSlbsBQ9XlFnkJd9KjzylRJhxQBEoIV6PDkzUOPdHpEcJ7535hwNHsSF?=
 =?us-ascii?Q?atI41q41VJWSLLUP9eyLhflo4dLFDuLpkkWtDKOeS98NGQp9LEehXNEqNnO3?=
 =?us-ascii?Q?fN15uhWTX0XgKDHVdF8FynRTLQ1/vcCCE7e0gurmkYhCssjYIOUjbzQAc5TT?=
 =?us-ascii?Q?xMyu1RXfQ0pTWxbwTQIuXgKZg+HbcH5a8PkOIjE9ipzf0pMlgXNWIyqh9SUK?=
 =?us-ascii?Q?OITl3vMPrPgqESmpehoMgBjBUxO7LZu5ulUlYz2aj8xMlH+MmacYUGNOrOF5?=
 =?us-ascii?Q?ahvrBaeDKJS5IHZKSkEkWFbXw/fzWVOgES7RcQttawQpk+UFPJt1h/LKOVdW?=
 =?us-ascii?Q?OHPm4+KTHn1K6WMKflrN91vueJplLJZWnNBvpj/foQ3vLsh8eosbon2BcK+t?=
 =?us-ascii?Q?+TGHYY2Y9CsZhJgYL6XBkl/n/HyLM4AQW7eyzGVdclZw3qfMzyuaVallYLCP?=
 =?us-ascii?Q?xB+2iAdIdtczrlOKL9L0TmdXmY64F31y2sEcm8beBBLzxecbCWDZVzhx9iI4?=
 =?us-ascii?Q?yrhxLvd92f4sw1TNc5uI0yW8nRBtMnyKMzx5dJPMS2og/Bru5qduZbXMUpCG?=
 =?us-ascii?Q?hBUhDyQHa+qItUUBD++9P0CV7ytfWgkLG6+7FPPn4xnG+OQBNaKQeVFYVE4W?=
 =?us-ascii?Q?iG3y411XGbUIsAIt2lzlNyYVdNnbU1XH+4oRs9fLdAy6HytFt4shgwfnrTUG?=
 =?us-ascii?Q?g6EbuaMNANUjux3P0danN20ARo6QyjVhDbgkT+XmYHyQ86md1q4LnzkMp3eF?=
 =?us-ascii?Q?QbbvCaZ0edALeBEJeDC7N3ryP53jurUYKiUXC00d2a1F24yRWI2TMmtp23hg?=
 =?us-ascii?Q?CsKQ7UIKzoMdCnM7aLA4b5Btjr6d/0Jv3BbpZyRwdba0vWrDREV5gf6iBj4S?=
 =?us-ascii?Q?B2qnPtt2HkmLLQO7dSKbGXc7zxR6PbwmbBKho7v5S93EfIlT5reVcQWUeP6w?=
 =?us-ascii?Q?5704QtryTPNawv9mKnFSExnv+KNhIOduValpv7E8imOgcodl4u+ByYLrigXM?=
 =?us-ascii?Q?+WX1FlWzw7F605jlr+labJbbnCNLp1bOfWrvhoPmT6CN/fes+KJOD+TlOJ7U?=
 =?us-ascii?Q?RRZURpQv7Ct2LZzfJDaPkCQd57UHUG//c/tAbBltKSQ5vV8yS4yA5tXteFCj?=
 =?us-ascii?Q?EnVkHrrFPM0R68qzpK+4Q3Zr4mCjfBkiQnlitnCi/biMzTGOkeTBkuDaeouV?=
 =?us-ascii?Q?qHh8z1RxY61ngHbTUHMMtw0ve0wV4EnVZbUPo+9iBVG5XT17OFhaxWFxc/Wj?=
 =?us-ascii?Q?5bhyZZuDTVeUNLoT8aD9WpJymHKEzWkiFX+b+agX7Jv5zom3d9U5qsTs5bM2?=
 =?us-ascii?Q?DW4pBsVPVjdhAJKpBshJ/+Wch4rVGGRu6p0kLBgzm0ZekVSopdh7na3BwQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 17:27:17.6041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27781aa9-70f9-4935-540c-08ddb98db197
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4128

An SF has an auxiliary device as a parent. This type of device can't be
used for zerocopy DMA mapping operations. A PCI device is required.

Use the new netdev dma_dev functionality to expose the actual PCI device
to be used for DMA. Always set it to keep things generic.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index e8e5b347f9b2..c4e45205fba4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5841,6 +5841,9 @@ static int mlx5e_nic_init(struct mlx5_core_dev *mdev,
 	/* update XDP supported features */
 	mlx5e_set_xdp_feature(netdev);
 
+	/* Set pci device for dma. Useful for SFs. */
+	netdev->dma_dev = &mdev->pdev->dev;
+
 	if (take_rtnl)
 		rtnl_unlock();
 
-- 
2.50.0


