Return-Path: <linux-rdma+bounces-11151-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D48CAD3CC5
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 17:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF1453AF642
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 15:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9D8239E91;
	Tue, 10 Jun 2025 15:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XCEEp8C6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0FB23816B;
	Tue, 10 Jun 2025 15:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568557; cv=fail; b=aMPi0enLvEZHWXOs4/M1Pmt5h7TE4Mez7JpLflIbwy7c1VHqqimoJiXbu0gL1EblCloHxgsWt6mg2St6qhdJ1g8vVOXUFzvZ78b5jkZeZyuXCLjVw/fpXBPfFn6AB/4L7Cv9bBavvXbZHXSZFgxL+5Wgio3oobphePRjSV8TTOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568557; c=relaxed/simple;
	bh=TFICOknkcTvZ7zj0XAu13r6pz354AFf/qVtazl5vIcI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F1B0oajBUG2771fKd7NVAC88pVnbiXXwJfGL1UbqaanZ1e8yCVCffw9UyYKwLqgEQ1JbpohJfq5/RPG91zrxx1fEOFnO/2HsnX4MIL6yvwVi9IGI0CJU0d0ziB3fcORyDukxke0uc+k07cOX0L6EJ+vVHGUC7V3S5nar2dwd4JU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XCEEp8C6; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wL97OeRcmIO+CphOlTZW/wdTGELBIaFHpDo/OYOH/3WWEOQie/Ojv50cbV3oIDH4hfkyaN2z4zYzklnkt4LBO5NlFiDQf3Jonf9/EBCoXmHUdLujSgIyDuU0+lJthEcOVVWaQlGGBjrbBnkS/RTLo6Ugm3FsQhF+nohePsYBlt4FZAmBnbQTGjthOuTKNaijfKK4jcWrspdXIc7zvWg/6tksDAw+xQV9MksVvx7IsPFmHIT3w299GlIZPtBPNcaYirC/TM+UBoEEYpO9vq75Js63mmpJ2N81oclRZ/C/chkc70nWCNyjOHc67Kx7v6ffz0iBRsGm74tf42YnbGjbpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXfbfprq0BBsdMz85X1XlSdeIMBG+oohlmaqeVJIWQg=;
 b=WAt/QQsoLeYQqvNNCqUGG9ZPRS3dyhAybAOIqpdk7XPtn3PYCXL/xTDOXYCu6kIY/Ui80ds/pDEocq5IIuMnJv/OAgvqF+ABR8grV+SjFaJsvRNtGuKs5Hqk0KxN8uBQudeZT9tb4yYSHTeqbAQAqH59nKT3mgmHe4PAok1O/pXlqo7qNCadUmunVLABHC09wWH/0GACwXOuqMUEp4NnT5Jf+JRPo7jOXfyZ2aUAcbVxqb6BmUDczYOgbwjg3js7FhEFSipBIPYEXiAqMimUfDgIIVVVwuhIGzlKzU2Z3ruoqWaS6wuZT1982ltaAJIwn0xfwL1EbozOtiCyaGw1Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXfbfprq0BBsdMz85X1XlSdeIMBG+oohlmaqeVJIWQg=;
 b=XCEEp8C6cah2m64QsF/gD4O3mZgyrfuTM/j3qTb4HR4LKcxhVOkeOJeUtZkQMbUYDlHnyo+8zSI9jB20NeeXN59ISvv/ws/YTGr5Wrkd9thSw63y0uiWQrLzEzGz5WT6xzpitZihHceS4hL0EUw0OWCAuiAuDnYBcsA4oUAfsq1bvKVjDnSiU3KmKupEUV3mJoxlUz8lnO3ACCWJpjk84dEWFolZYvnF5dmssx+PcLC7Bq0KYpkf/IR23GnRsYupwhvvYDFwgdjxx/RvlYzpdBtF+mzGa6FOlO0F9ntPZs1vLThpslQ6+wlKhRJ+6DVLP6iLxF724zFDIsHHF4e8eQ==
Received: from SJ0PR03CA0189.namprd03.prod.outlook.com (2603:10b6:a03:2ef::14)
 by SJ0PR12MB7034.namprd12.prod.outlook.com (2603:10b6:a03:449::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Tue, 10 Jun
 2025 15:15:52 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::33) by SJ0PR03CA0189.outlook.office365.com
 (2603:10b6:a03:2ef::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.34 via Frontend Transport; Tue,
 10 Jun 2025 15:15:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 15:15:52 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 08:15:30 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 10 Jun
 2025 08:15:29 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 10
 Jun 2025 08:15:25 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net 1/9] net/mlx5: Ensure fw pages are always allocated on same NUMA
Date: Tue, 10 Jun 2025 18:15:06 +0300
Message-ID: <20250610151514.1094735-2-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610151514.1094735-1-mbloch@nvidia.com>
References: <20250610151514.1094735-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|SJ0PR12MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c2d8d35-6e39-4346-38e6-08dda831b055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S8jni8dmqOXHXAnR70K/UpYRtL+RVuCKSPSibC4q8fJMyCLjB5t9AxRpxHIg?=
 =?us-ascii?Q?WlTvvv9g7yU53GIqhuj7EJ7f+xfIC6lqfDwTNMrqkn7vGta8Hv2vafy6TCZA?=
 =?us-ascii?Q?kVdd1MKUHUhfwiIRhQC6tJfy+i8ZcUXumRgHNorSnZW05AUKG/ueVEexT96J?=
 =?us-ascii?Q?+SqN4Op/fIUSUEJkfYZvxsVPUXIRtOIMeDbkdkNIBrAOO7vL1B67Op8NfYEA?=
 =?us-ascii?Q?gXU7Vol13gn47x/nd4YsRuhnkKLsEQ4BwRBrXz7LWG8YSb3DFeFdjPt6gsfA?=
 =?us-ascii?Q?olhqZSekdVGkR0F/V2uOWJtbdTEaMBDhrLowNSycOSsPYCD10mBU3KMxSwZF?=
 =?us-ascii?Q?YbvQKaAyZW1t50gp0QhEmbAJBUxPzcvtP2Bx1h+5tTuZAtT4yb5r1kaNBwMf?=
 =?us-ascii?Q?cdC4hpXGnIzwNiP2xrQ5PchWpzjCPpdnTY8KwtObtkBBvIUnOKvuCOajYhPS?=
 =?us-ascii?Q?rFnziqz4X7fUZeIQpzbyizc/OnnzlqyP8TJ2wf26uwz78Vd2hyn5i2ZXUHnc?=
 =?us-ascii?Q?uwKOUUyUdRlJ3AuebBOi1wbXxTj+mVZmJPEQncIFqzzVX4K9aSrTWdK3DPPy?=
 =?us-ascii?Q?Ke7jqWngBZRLaDJYp5L/w86RDpxf0QAWvrYpUrYbnnJgmxm1ZKmdtGLZxfb+?=
 =?us-ascii?Q?0HPWa+EoMX1YJqxZeR2iFQYEotFwhoS8YU4By7lG6Tb9HQp4GIXx2gzUJrrY?=
 =?us-ascii?Q?KCn9ChUSWP7BqlAASV7XxuoV+j8uYZ0fhRhgzS+uFbMUihTTlIxzFyVuWowI?=
 =?us-ascii?Q?X1YiBqwzU3sNeSTah+w8sSETqS8YvEF57qcFCgJa8CsWHlP71aPj3YQKQrRC?=
 =?us-ascii?Q?2gfJ//vBQ+GvulN8TQsdbKDKXagthIlVcSAK9JlSAzlPJcyNtWzjnls6Dorr?=
 =?us-ascii?Q?ZsMIZJsWzmD6JZPWv3oMwV0TkLYXBjHd9qnMifCUdoJAikF3hyMT/RZyqjTU?=
 =?us-ascii?Q?D4CL+bcobFxYFUnYIEqRngB0siChDB8iEhan7FUdhYRXNUiDAY+VI9CPJwk0?=
 =?us-ascii?Q?cO15z0SkE9cXyaZPUV/T7CXQP7KgUF6zjB11eFuT/r4OTEaNVtmelvtlVfHi?=
 =?us-ascii?Q?mol36lyGYyToSCAW60nqu2DUPvcEubUQ060sKHsNjblMUQPe7V3V4Z08Zmby?=
 =?us-ascii?Q?uYPACIXrcHLIr2qMn8eN9dBUAtuqp5okyK2GJJnogArqGivGyJvNe4e28r8i?=
 =?us-ascii?Q?qodDNEAZurJ5zNjAYsTs4qhRwxsHRD1qrj6E2ljxTMHfCTc0I+vok44K9b5O?=
 =?us-ascii?Q?7UTaF78iruhsBjFq1rr1RSNj2yQYalms/gHObgSiFYi5dljBf4jMhHYeiPSk?=
 =?us-ascii?Q?kya44uGnwQ72+97v8rMJCkbRAbAr16xJ2nuAzVd8SNXaonVUePSjce1OZRoB?=
 =?us-ascii?Q?rUF/r+z/PGuTu0kwDvxaEuicppYje2NcbI79fV/FzpdU330UvmO6udKjkxCh?=
 =?us-ascii?Q?pq2LOALwX/++FzRP1QD2cme3fia1JfNveh9Mrg2ja1GP3ipFCmdeFniPnSCY?=
 =?us-ascii?Q?C1vgFTswr4q8dwdWmdi/IDRnf8LxAOtBXhr1?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:15:52.0312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c2d8d35-6e39-4346-38e6-08dda831b055
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7034

From: Moshe Shemesh <moshe@nvidia.com>

When firmware asks the driver to allocate more pages, using event of
give_pages, the driver should always allocate it from same NUMA, the
original device NUMA. Current code uses dev_to_node() which can result
in different NUMA as it is changed by other driver flows, such as
mlx5_dma_zalloc_coherent_node(). Instead, use saved numa node for
allocating firmware pages.

Fixes: 311c7c71c9bb ("net/mlx5e: Allocate DMA coherent memory on reader NUMA node")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
index 972e8e9df585..9bc9bd83c232 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
@@ -291,7 +291,7 @@ static void free_4k(struct mlx5_core_dev *dev, u64 addr, u32 function)
 static int alloc_system_page(struct mlx5_core_dev *dev, u32 function)
 {
 	struct device *device = mlx5_core_dma_dev(dev);
-	int nid = dev_to_node(device);
+	int nid = dev->priv.numa_node;
 	struct page *page;
 	u64 zero_addr = 1;
 	u64 addr;
-- 
2.34.1


