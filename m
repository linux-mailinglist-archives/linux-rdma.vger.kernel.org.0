Return-Path: <linux-rdma+bounces-13558-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F42B8FAF7
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 11:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E94EB18914C0
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 09:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E1A2F3C2C;
	Mon, 22 Sep 2025 09:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a9btgII1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010064.outbound.protection.outlook.com [40.93.198.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A6A283CBE;
	Mon, 22 Sep 2025 09:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758531738; cv=fail; b=kzyDSB4+66rLxF41n9DNQ2mAJ+pWSWjzcVvY4+/K48KcgPf2P1ETNZ0pdyOiaUfupp9lEJTEGsKIjIO75m5xla2gtwfDDA7NNds6uMIztzBSKNQpAkVL0euHB89U9w+MSKHU//Ngg5krcWyPGgXnD+Zbv5NCoL4oSkVoujW3jpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758531738; c=relaxed/simple;
	bh=iRgqBTg35nmXXTB9eIo3o+8CJFDYpAtKECXX5XiO2os=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nvw367JLmnByfFwK4ds4TzbspyjUAReYaJYsmfNsBeRRKrt+KHvHXdJEqS0TOotd0rzwVDWi46GG6mtlweayO6SgknvbAEYhSPEGOB/2kf86CnbKqtgY9ZtHxTaQ8PWkr1NO5Jg4JoybRVGRH3T1w4MRgOQLGU8qhAr8Z+G4U2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a9btgII1; arc=fail smtp.client-ip=40.93.198.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZTPEpuSPysG9iBrI9U/0HvoXuLrcdqzxSsE66dFt8HkDok+7MyD3tcuQEw3qPKN4kbsdM0OAlCGaTStPH1hgFamrZIr7+A3TqhrX6R1H9noGudR9GXjFrhnX0G+TdP8JGlxduKRNiWNw1bvzXUYNW8dpuvTKLqObeXUygMzCiNtDS3/zfwLHY/8cO3bLtznjbjWrwlh9xUswa5c7OfOGnuxNlFreXpQUT3mVMn53gt6hY0wgp6K75elzJMhP0ixl10tKuBymoNwfEbfv/DJJw9vhrB9dSqAS9CXDYprx4B2bgTqdX5SbJrpLbSq7s+TzBNc5wJmnibreLTrdLTNhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0YIf/8ZbcjvyF8WwAhiSPPivm20MJ69ieNYerRqsSM=;
 b=k0LO8h6s7OgPrfrLHXBL/bZ28xqMdlBLOKNYbyll7lSHwxmxuEEriHQMbxZ34tmE69uMCY2BtFvZC7M9HhX/JUJM10N7lfSCxVXWV/FJ6beFMEC3I0aFxokH/3f6zlDwRDLV1FnE1mo8TM1hriEcwR/bwxI+eabRZngBZwsj9rchtrlGSICmHTCexlDsy9Nx3Pl6ou7Q3de65V4wExwCFKfOgbTWU8PpxljQidLG4GL35KcGLSnioTqoSgARqZ6uBOQScS+q6faJFipASXsMTgOVpMgwY/IaAsU1+p3zoUDeoctzw44tSRU0NbwUUmINduw3dspS46kjdl/+OMckUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0YIf/8ZbcjvyF8WwAhiSPPivm20MJ69ieNYerRqsSM=;
 b=a9btgII1i3lRr60Kr0ThlghxQ1l3Kjjb0H/vOdxpfKqqCg4e/8VNemjN7lDxL4Hjq0o4yRA9rJZSEzrKYgyLKRsAegKy4G0BPpvrx+/MSVetPclWCGVti1vvX1wme2RCAEiDTRYpY4GtHOHGsaFAjQ6mu7LlxpHevctDEQYd0xhxcXLma6X7KlpHQJlEw6tomwdYiCu7E0b6Ii4ZEWVLQMK2rO0gj4/3xnlDMwkqPulBLYZfFSeVERSjGgDDyFFrc+vwfheRyNc2DxzWtmLaPUMpO1zetJ3G42EQGFzAPjuJ9yz2CxuIu7uPDctQKQuGlyXCDYiYT+sN5CFxUhjWgQ==
Received: from CH2PR18CA0021.namprd18.prod.outlook.com (2603:10b6:610:4f::31)
 by DM4PR12MB7622.namprd12.prod.outlook.com (2603:10b6:8:109::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 09:01:59 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::90) by CH2PR18CA0021.outlook.office365.com
 (2603:10b6:610:4f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Mon,
 22 Sep 2025 09:01:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 09:01:58 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 22 Sep
 2025 02:01:46 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 22 Sep 2025 02:01:45 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Sep 2025 02:01:41 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>
Subject: [PATCH net-next 1/7] net/mlx5: HWS, Generalize complex matchers
Date: Mon, 22 Sep 2025 12:01:05 +0300
Message-ID: <1758531671-819655-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1758531671-819655-1-git-send-email-tariqt@nvidia.com>
References: <1758531671-819655-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|DM4PR12MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dfdc9de-d606-4ee6-0fd9-08ddf9b6b01e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NpMZJnlhbiND3relKwG/4ia4dDez/l3WaFrHUXp6DN6EkUGdeqpAYKDbEaI2?=
 =?us-ascii?Q?ZiD+0xE59WWtAho50+2zyB1IZFljXyh+NinVbQli2ZiWPlTjt0IaKmEeypIG?=
 =?us-ascii?Q?+XXv1AaIg4Wv/BsZbONY2syCEPx4TudkzZqDDU2O3MtKRe3o0gYLBpgXDGho?=
 =?us-ascii?Q?cF6ZXEiPFvXXuai/TIng7Ai4t0IYAS+PPIP9xgmXcYlDmZSqBeCJMWdfEsFj?=
 =?us-ascii?Q?h0yn+Zt86RrHDHd9qp0afrS078tAQzUw1G/aYCLSDBNnDfRLZ+QVevBkniD/?=
 =?us-ascii?Q?ht5qXaKt/bk6zmsodyr2BEasqHQDEXkeDaHfw/z1S3yJ+O/mbrox5dRCLmy9?=
 =?us-ascii?Q?egthCa/cfkYk1ddm2A6Wd5KiCT+nPibZDR/NScWrbztX5TVP9uS4iZkNwvym?=
 =?us-ascii?Q?D8UDnZpbap3YFlkKxmCluuHG7uRNPjk2LclLsv4b+aY/6HbR3lx5uVpiAcpT?=
 =?us-ascii?Q?mOUnYzwwSiDJNYJeV/nn0ALwdYHhhN/WGdssI3tKpswqO08ZMoGrianiorik?=
 =?us-ascii?Q?2mMDWDlkBUv/sQApQGudBmoC3DDVTN9cC/AkVRPLo7xmONGLZIm5+RQWkYfK?=
 =?us-ascii?Q?9SWGh8YK6u/G84TGZ2WHoIs549nZ102/5LKmBln5LZRaS2QtY5J1YrAjryp+?=
 =?us-ascii?Q?CvWhxb8PefQV6tTu038Gma+QQ35Tn63WTQLp6BR0lcCC+nVdb7RLT2ty/R5m?=
 =?us-ascii?Q?430zxenRpEIt397DEig5sMrAnEsV8rn8mPqWeaUuKWNtlxQVkVhqVO3oscBs?=
 =?us-ascii?Q?pkgMRUJ0fz4raEVyTHqa9NQXdtkNXdfpexcDsxQwVmd0kLZuW1w3ALPbXTW0?=
 =?us-ascii?Q?2MkkPDV2glAvMcL5y98I6n/dl2T0U/b6PCyVHtrZnsNGyLAewSEfCn9iaGQ4?=
 =?us-ascii?Q?fiL3ri69bBhV2Y8dw5h6MO13Joa2IqAs5GgOW8F78cpF5GOjQCXlkjlng/i6?=
 =?us-ascii?Q?oPf1qpYu9KnNHencHRTvnQiuD6O+4B3oUfNfq/QwLSWHiiG7FT2Pk5tKmyTh?=
 =?us-ascii?Q?Pbfle32CIi5nNcvoXcb8UCqccf2mRnaO3TbcfkgflNzeozvZD4JOk89CG9tC?=
 =?us-ascii?Q?hhuuHEFtS1iaaY7aOIOzhm7OsdCsLAr7u7SdofMNSwiLpsGQJPDT5W75nJW5?=
 =?us-ascii?Q?JMYmRdWh5XotOOpo4uzQDdCAkJxG4XDuQ7lvzy0OKHRTgUXEbvIbUCIftPSb?=
 =?us-ascii?Q?cdgZxIwc5vrj/KaRQHCRFJmijj3tNHJbFzutHYr+Jm5Nf4ibHKcCWaxn726B?=
 =?us-ascii?Q?XaIc/NifXEOBerjb05DLTlqVh6iymI+pFtvD46gaE7Tq+APzH2NCwisn2mEe?=
 =?us-ascii?Q?YGDaewQBePEri1/0myqU5YPO7VnnN5D9cZle087B1iAsLVglHirgpZDkBa/d?=
 =?us-ascii?Q?DCwDB6+KL9FSy30ueGo+SPL5rbGmzx3BIcCIvc/R6sk82O2A2QVLF56C+tiZ?=
 =?us-ascii?Q?1lo5vb+T5X6UzpTSjwL1SXmyzNLIr2bAHVgOBuDYDygl8whBwjSlA3KKxYrO?=
 =?us-ascii?Q?wO2p3iJJQ2MViXmvNjgAtyPr0P+zoERUJpXt?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 09:01:58.9091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dfdc9de-d606-4ee6-0fd9-08ddf9b6b01e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7622

From: Vlad Dogaru <vdogaru@nvidia.com>

The existing solution of complex matchers splits the match parameters
across two, and exactly two, matchers. For some rather extreme cases
(e.g. IPv6-in-IPv6 tunnels), even two matchers are not enough.

Generalize complex matchers to up to 4 submatchers, and allow easy
extension to more if needed. This resulted in rewriting a large part
of the high-level complex matchers logic, but the original concepts
were rock solid and still hold.

Key characteristics of the new implementation:

* Rework complex matchers to include multiple submatchers. All
  submatchers but the first are isolated, in keeping with the existing
  paradigm of handing off to specialized matchers that are not otherwise
  reachable by regular rules.

* Similarly, rework complex rules to allow splitting them into more than
  two simple rules. Rules continue to be refcounted to allow for
  multiple complex rules matching on identical parts of the match
  params.

* Rely on the match tag, as opposed to the entire match_param, to hash
  subrules. This results in lower memory usage.

* Prefer to split the original user-supplied match parameters rather
  than the internal field descriptors. This avoids the awkward
  transition back and forth between the two formats.

* Allow splitting multi-dword fields across matchers. The only
  restrictions that the new implementation impose are: a) any fragment
  of an IP address must be accompanied by a match on the IP version; and
  b) a single lower dword of an IPv6 address cannot be present in a
  submatcher as it would be interpreted as an IPv4 address.

* Employ a greedy algorithm to split the match params, as opposed to
  complete search. The results are not optimal, but the algorithm is now
  linear compared to exponential. Consequently, we see complex matcher
  creation time drops two orders of magnitude in our tests.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/bwc.c     |   37 +-
 .../mellanox/mlx5/core/steering/hws/bwc.h     |   21 +-
 .../mlx5/core/steering/hws/bwc_complex.c      | 1821 +++++++----------
 .../mlx5/core/steering/hws/bwc_complex.h      |   60 +-
 .../mellanox/mlx5/core/steering/hws/definer.c |   87 +-
 .../mellanox/mlx5/core/steering/hws/definer.h |    9 +-
 6 files changed, 837 insertions(+), 1198 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
index adeccc588e5d..6ef0c4be27e1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
@@ -51,9 +51,6 @@ static void hws_bwc_matcher_init_attr(struct mlx5hws_bwc_matcher *bwc_matcher,
 				      u8 size_log_rx, u8 size_log_tx,
 				      struct mlx5hws_matcher_attr *attr)
 {
-	struct mlx5hws_bwc_matcher *first_matcher =
-		bwc_matcher->complex_first_bwc_matcher;
-
 	memset(attr, 0, sizeof(*attr));
 
 	attr->priority = priority;
@@ -66,9 +63,6 @@ static void hws_bwc_matcher_init_attr(struct mlx5hws_bwc_matcher *bwc_matcher,
 	attr->size[MLX5HWS_MATCHER_SIZE_TYPE_TX].rule.num_log = size_log_tx;
 	attr->resizable = true;
 	attr->max_num_of_at_attach = MLX5HWS_BWC_MATCHER_ATTACH_AT_NUM;
-
-	attr->isolated_matcher_end_ft_id =
-		first_matcher ? first_matcher->matcher->end_ft_id : 0;
 }
 
 static int
@@ -171,10 +165,16 @@ hws_bwc_matcher_move_all_simple(struct mlx5hws_bwc_matcher *bwc_matcher)
 
 static int hws_bwc_matcher_move_all(struct mlx5hws_bwc_matcher *bwc_matcher)
 {
-	if (!bwc_matcher->complex)
+	switch (bwc_matcher->matcher_type) {
+	case MLX5HWS_BWC_MATCHER_SIMPLE:
 		return hws_bwc_matcher_move_all_simple(bwc_matcher);
-
-	return mlx5hws_bwc_matcher_move_all_complex(bwc_matcher);
+	case MLX5HWS_BWC_MATCHER_COMPLEX_FIRST:
+		return mlx5hws_bwc_matcher_complex_move_first(bwc_matcher);
+	case MLX5HWS_BWC_MATCHER_COMPLEX_SUBMATCHER:
+		return mlx5hws_bwc_matcher_complex_move(bwc_matcher);
+	default:
+		return -EINVAL;
+	}
 }
 
 static int hws_bwc_matcher_move(struct mlx5hws_bwc_matcher *bwc_matcher)
@@ -249,6 +249,7 @@ int mlx5hws_bwc_matcher_create_simple(struct mlx5hws_bwc_matcher *bwc_matcher,
 				  bwc_matcher->tx_size.size_log,
 				  &attr);
 
+	bwc_matcher->matcher_type = MLX5HWS_BWC_MATCHER_SIMPLE;
 	bwc_matcher->priority = priority;
 
 	bwc_matcher->size_of_at_array = MLX5HWS_BWC_MATCHER_ATTACH_AT_NUM;
@@ -393,7 +394,7 @@ int mlx5hws_bwc_matcher_destroy(struct mlx5hws_bwc_matcher *bwc_matcher)
 			    "BWC matcher destroy: matcher still has %u RX and %u TX rules\n",
 			    rx_rules, tx_rules);
 
-	if (bwc_matcher->complex)
+	if (bwc_matcher->matcher_type == MLX5HWS_BWC_MATCHER_COMPLEX_FIRST)
 		mlx5hws_bwc_matcher_destroy_complex(bwc_matcher);
 	else
 		mlx5hws_bwc_matcher_destroy_simple(bwc_matcher);
@@ -651,7 +652,8 @@ int mlx5hws_bwc_rule_destroy_simple(struct mlx5hws_bwc_rule *bwc_rule)
 
 int mlx5hws_bwc_rule_destroy(struct mlx5hws_bwc_rule *bwc_rule)
 {
-	bool is_complex = !!bwc_rule->bwc_matcher->complex;
+	bool is_complex = bwc_rule->bwc_matcher->matcher_type ==
+			  MLX5HWS_BWC_MATCHER_COMPLEX_FIRST;
 	int ret = 0;
 
 	if (is_complex)
@@ -1147,7 +1149,7 @@ mlx5hws_bwc_rule_create(struct mlx5hws_bwc_matcher *bwc_matcher,
 
 	bwc_queue_idx = hws_bwc_gen_queue_idx(ctx);
 
-	if (bwc_matcher->complex)
+	if (bwc_matcher->matcher_type == MLX5HWS_BWC_MATCHER_COMPLEX_FIRST)
 		ret = mlx5hws_bwc_rule_create_complex(bwc_rule,
 						      params,
 						      flow_source,
@@ -1216,10 +1218,9 @@ int mlx5hws_bwc_rule_action_update(struct mlx5hws_bwc_rule *bwc_rule,
 		return -EINVAL;
 	}
 
-	/* For complex rule, the update should happen on the second matcher */
-	if (bwc_rule->isolated_bwc_rule)
-		return hws_bwc_rule_action_update(bwc_rule->isolated_bwc_rule,
-						  rule_actions);
-	else
-		return hws_bwc_rule_action_update(bwc_rule, rule_actions);
+	/* For complex rules, the update should happen on the last subrule. */
+	while (bwc_rule->next_subrule)
+		bwc_rule = bwc_rule->next_subrule;
+
+	return hws_bwc_rule_action_update(bwc_rule, rule_actions);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
index af391d70c14f..b905511f5c53 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
@@ -18,6 +18,21 @@
 
 #define MLX5HWS_BWC_POLLING_TIMEOUT 60
 
+enum mlx5hws_bwc_matcher_type {
+	/* Standalone bwc matcher. */
+	MLX5HWS_BWC_MATCHER_SIMPLE,
+	/* The first matcher of a complex matcher. When rules are inserted into
+	 * a matcher of this type, they are split into subrules and inserted
+	 * into their corresponding submatchers.
+	 */
+	MLX5HWS_BWC_MATCHER_COMPLEX_FIRST,
+	/* A submatcher that is part of a complex matcher. For most purposes
+	 * these are treated as simple matchers, except when it comes to moving
+	 * rules during resize.
+	 */
+	MLX5HWS_BWC_MATCHER_COMPLEX_SUBMATCHER,
+};
+
 struct mlx5hws_bwc_matcher_complex_data;
 
 struct mlx5hws_bwc_matcher_size {
@@ -31,9 +46,9 @@ struct mlx5hws_bwc_matcher {
 	struct mlx5hws_match_template *mt;
 	struct mlx5hws_action_template **at;
 	struct mlx5hws_bwc_matcher_complex_data *complex;
-	struct mlx5hws_bwc_matcher *complex_first_bwc_matcher;
 	u8 num_of_at;
 	u8 size_of_at_array;
+	enum mlx5hws_bwc_matcher_type matcher_type;
 	u32 priority;
 	struct mlx5hws_bwc_matcher_size rx_size;
 	struct mlx5hws_bwc_matcher_size tx_size;
@@ -43,8 +58,8 @@ struct mlx5hws_bwc_matcher {
 struct mlx5hws_bwc_rule {
 	struct mlx5hws_bwc_matcher *bwc_matcher;
 	struct mlx5hws_rule *rule;
-	struct mlx5hws_bwc_rule *isolated_bwc_rule;
-	struct mlx5hws_bwc_complex_rule_hash_node *complex_hash_node;
+	struct mlx5hws_bwc_rule *next_subrule;
+	struct mlx5hws_bwc_complex_subrule_data *subrule_data;
 	u32 flow_source;
 	u16 bwc_queue_idx;
 	bool skip_rx;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c
index 14e79579c719..6115c0273fdb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c
@@ -3,25 +3,27 @@
 
 #include "internal.h"
 
-#define HWS_CLEAR_MATCH_PARAM(mask, field) \
-	MLX5_SET(fte_match_param, (mask)->match_buf, field, 0)
-
-#define HWS_SZ_MATCH_PARAM (MLX5_ST_SZ_DW_MATCH_PARAM * 4)
-
-static const struct rhashtable_params hws_refcount_hash = {
-	.key_len = sizeof_field(struct mlx5hws_bwc_complex_rule_hash_node,
-				match_buf),
-	.key_offset = offsetof(struct mlx5hws_bwc_complex_rule_hash_node,
-			       match_buf),
-	.head_offset = offsetof(struct mlx5hws_bwc_complex_rule_hash_node,
-				hash_node),
-	.automatic_shrinking = true,
-	.min_size = 1,
+/* We chain submatchers by applying three rules on a subrule: modify header (to
+ * set register C6), jump to table (to the next submatcher) and the mandatory
+ * last rule.
+ */
+#define HWS_NUM_CHAIN_ACTIONS 3
+
+static const struct rhashtable_params hws_rules_hash_params = {
+	.key_len = sizeof_field(struct mlx5hws_bwc_complex_subrule_data,
+				match_tag),
+	.key_offset =
+		offsetof(struct mlx5hws_bwc_complex_subrule_data, match_tag),
+	.head_offset =
+		offsetof(struct mlx5hws_bwc_complex_subrule_data, hash_node),
+	.automatic_shrinking = true, .min_size = 1,
 };
 
-bool mlx5hws_bwc_match_params_is_complex(struct mlx5hws_context *ctx,
-					 u8 match_criteria_enable,
-					 struct mlx5hws_match_parameters *mask)
+static bool
+hws_match_params_exceeds_definer(struct mlx5hws_context *ctx,
+				 u8 match_criteria_enable,
+				 struct mlx5hws_match_parameters *mask,
+				 bool allow_jumbo)
 {
 	struct mlx5hws_definer match_layout = {0};
 	struct mlx5hws_match_template *mt;
@@ -36,11 +38,11 @@ bool mlx5hws_bwc_match_params_is_complex(struct mlx5hws_context *ctx,
 					   mask->match_sz,
 					   match_criteria_enable);
 	if (!mt) {
-		mlx5hws_err(ctx, "BWC: failed creating match template\n");
+		mlx5hws_err(ctx, "Complex matcher: failed creating match template\n");
 		return false;
 	}
 
-	ret = mlx5hws_definer_calc_layout(ctx, mt, &match_layout);
+	ret = mlx5hws_definer_calc_layout(ctx, mt, &match_layout, allow_jumbo);
 	if (ret) {
 		/* The only case that we're interested in is E2BIG,
 		 * which means that the match parameters need to be
@@ -64,825 +66,481 @@ bool mlx5hws_bwc_match_params_is_complex(struct mlx5hws_context *ctx,
 	return is_complex;
 }
 
-static void
-hws_bwc_matcher_complex_params_clear_fld(struct mlx5hws_context *ctx,
-					 enum mlx5hws_definer_fname fname,
+bool mlx5hws_bwc_match_params_is_complex(struct mlx5hws_context *ctx,
+					 u8 match_criteria_enable,
 					 struct mlx5hws_match_parameters *mask)
 {
-	struct mlx5hws_cmd_query_caps *caps = ctx->caps;
-
-	switch (fname) {
-	case MLX5HWS_DEFINER_FNAME_ETH_TYPE_O:
-	case MLX5HWS_DEFINER_FNAME_ETH_TYPE_I:
-	case MLX5HWS_DEFINER_FNAME_ETH_L3_TYPE_O:
-	case MLX5HWS_DEFINER_FNAME_ETH_L3_TYPE_I:
-	case MLX5HWS_DEFINER_FNAME_IP_VERSION_O:
-	case MLX5HWS_DEFINER_FNAME_IP_VERSION_I:
-		/* Because of the strict requirements for IP address matching
-		 * that require ethtype/ip_version matching as well, don't clear
-		 * these fields - have them in both parts of the complex matcher
-		 */
-		break;
-	case MLX5HWS_DEFINER_FNAME_ETH_SMAC_47_16_O:
-		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.smac_47_16);
-		break;
-	case MLX5HWS_DEFINER_FNAME_ETH_SMAC_47_16_I:
-		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.smac_47_16);
-		break;
-	case MLX5HWS_DEFINER_FNAME_ETH_SMAC_15_0_O:
-		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.smac_15_0);
-		break;
-	case MLX5HWS_DEFINER_FNAME_ETH_SMAC_15_0_I:
-		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.smac_15_0);
-		break;
-	case MLX5HWS_DEFINER_FNAME_ETH_DMAC_47_16_O:
-		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.dmac_47_16);
-		break;
-	case MLX5HWS_DEFINER_FNAME_ETH_DMAC_47_16_I:
-		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.dmac_47_16);
-		break;
-	case MLX5HWS_DEFINER_FNAME_ETH_DMAC_15_0_O:
-		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.dmac_15_0);
-		break;
-	case MLX5HWS_DEFINER_FNAME_ETH_DMAC_15_0_I:
-		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.dmac_15_0);
-		break;
-	case MLX5HWS_DEFINER_FNAME_VLAN_TYPE_O:
-		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.cvlan_tag);
-		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.svlan_tag);
-		break;
-	case MLX5HWS_DEFINER_FNAME_VLAN_TYPE_I:
-		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.cvlan_tag);
-		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.svlan_tag);
-		break;
-	case MLX5HWS_DEFINER_FNAME_VLAN_FIRST_PRIO_O:
-		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.first_prio);
-		break;
-	case MLX5HWS_DEFINER_FNAME_VLAN_FIRST_PRIO_I:
-		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.first_prio);
-		break;
-	case MLX5HWS_DEFINER_FNAME_VLAN_CFI_O:
-		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.first_cfi);
-		break;
-	case MLX5HWS_DEFINER_FNAME_VLAN_CFI_I:
-		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.first_cfi);
-		break;
-	case MLX5HWS_DEFINER_FNAME_VLAN_ID_O:
-		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.first_vid);
-		break;
-	case MLX5HWS_DEFINER_FNAME_VLAN_ID_I:
-		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.first_vid);
-		break;
-	case MLX5HWS_DEFINER_FNAME_VLAN_SECOND_TYPE_O:
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      misc_parameters.outer_second_cvlan_tag);
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      misc_parameters.outer_second_svlan_tag);
-		break;
-	case MLX5HWS_DEFINER_FNAME_VLAN_SECOND_TYPE_I:
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      misc_parameters.inner_second_cvlan_tag);
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      misc_parameters.inner_second_svlan_tag);
-		break;
-	case MLX5HWS_DEFINER_FNAME_VLAN_SECOND_PRIO_O:
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters.outer_second_prio);
-		break;
-	case MLX5HWS_DEFINER_FNAME_VLAN_SECOND_PRIO_I:
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters.inner_second_prio);
-		break;
-	case MLX5HWS_DEFINER_FNAME_VLAN_SECOND_CFI_O:
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters.outer_second_cfi);
-		break;
-	case MLX5HWS_DEFINER_FNAME_VLAN_SECOND_CFI_I:
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters.inner_second_cfi);
-		break;
-	case MLX5HWS_DEFINER_FNAME_VLAN_SECOND_ID_O:
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters.outer_second_vid);
-		break;
-	case MLX5HWS_DEFINER_FNAME_VLAN_SECOND_ID_I:
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters.inner_second_vid);
-		break;
-	case MLX5HWS_DEFINER_FNAME_IPV4_IHL_O:
-		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.ipv4_ihl);
-		break;
-	case MLX5HWS_DEFINER_FNAME_IPV4_IHL_I:
-		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.ipv4_ihl);
-		break;
-	case MLX5HWS_DEFINER_FNAME_IP_DSCP_O:
-		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.ip_dscp);
-		break;
-	case MLX5HWS_DEFINER_FNAME_IP_DSCP_I:
-		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.ip_dscp);
-		break;
-	case MLX5HWS_DEFINER_FNAME_IP_ECN_O:
-		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.ip_ecn);
-		break;
-	case MLX5HWS_DEFINER_FNAME_IP_ECN_I:
-		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.ip_ecn);
-		break;
-	case MLX5HWS_DEFINER_FNAME_IP_TTL_O:
-		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.ttl_hoplimit);
-		break;
-	case MLX5HWS_DEFINER_FNAME_IP_TTL_I:
-		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.ttl_hoplimit);
-		break;
-	case MLX5HWS_DEFINER_FNAME_IPV4_DST_O:
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      outer_headers.dst_ipv4_dst_ipv6.ipv6_simple_layout.ipv6_31_0);
-		break;
-	case MLX5HWS_DEFINER_FNAME_IPV4_SRC_O:
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      outer_headers.src_ipv4_src_ipv6.ipv6_simple_layout.ipv6_31_0);
-		break;
-	case MLX5HWS_DEFINER_FNAME_IPV4_DST_I:
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      inner_headers.dst_ipv4_dst_ipv6.ipv6_simple_layout.ipv6_31_0);
-		break;
-	case MLX5HWS_DEFINER_FNAME_IPV4_SRC_I:
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      inner_headers.src_ipv4_src_ipv6.ipv6_simple_layout.ipv6_31_0);
-		break;
-	case MLX5HWS_DEFINER_FNAME_IP_FRAG_O:
-		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.frag);
-		break;
-	case MLX5HWS_DEFINER_FNAME_IP_FRAG_I:
-		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.frag);
-		break;
-	case MLX5HWS_DEFINER_FNAME_IPV6_FLOW_LABEL_O:
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      misc_parameters.outer_ipv6_flow_label);
-		break;
-	case MLX5HWS_DEFINER_FNAME_IPV6_FLOW_LABEL_I:
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      misc_parameters.inner_ipv6_flow_label);
-		break;
-	case MLX5HWS_DEFINER_FNAME_IPV6_DST_127_96_O:
-	case MLX5HWS_DEFINER_FNAME_IPV6_DST_95_64_O:
-	case MLX5HWS_DEFINER_FNAME_IPV6_DST_63_32_O:
-	case MLX5HWS_DEFINER_FNAME_IPV6_DST_31_0_O:
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      outer_headers.dst_ipv4_dst_ipv6.ipv6_simple_layout.ipv6_127_96);
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      outer_headers.dst_ipv4_dst_ipv6.ipv6_simple_layout.ipv6_95_64);
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      outer_headers.dst_ipv4_dst_ipv6.ipv6_simple_layout.ipv6_63_32);
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      outer_headers.dst_ipv4_dst_ipv6.ipv6_simple_layout.ipv6_31_0);
-		break;
-	case MLX5HWS_DEFINER_FNAME_IPV6_SRC_127_96_O:
-	case MLX5HWS_DEFINER_FNAME_IPV6_SRC_95_64_O:
-	case MLX5HWS_DEFINER_FNAME_IPV6_SRC_63_32_O:
-	case MLX5HWS_DEFINER_FNAME_IPV6_SRC_31_0_O:
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      outer_headers.src_ipv4_src_ipv6.ipv6_simple_layout.ipv6_127_96);
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      outer_headers.src_ipv4_src_ipv6.ipv6_simple_layout.ipv6_95_64);
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      outer_headers.src_ipv4_src_ipv6.ipv6_simple_layout.ipv6_63_32);
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      outer_headers.src_ipv4_src_ipv6.ipv6_simple_layout.ipv6_31_0);
-		break;
-	case MLX5HWS_DEFINER_FNAME_IPV6_DST_127_96_I:
-	case MLX5HWS_DEFINER_FNAME_IPV6_DST_95_64_I:
-	case MLX5HWS_DEFINER_FNAME_IPV6_DST_63_32_I:
-	case MLX5HWS_DEFINER_FNAME_IPV6_DST_31_0_I:
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      inner_headers.dst_ipv4_dst_ipv6.ipv6_simple_layout.ipv6_127_96);
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      inner_headers.dst_ipv4_dst_ipv6.ipv6_simple_layout.ipv6_95_64);
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      inner_headers.dst_ipv4_dst_ipv6.ipv6_simple_layout.ipv6_63_32);
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      inner_headers.dst_ipv4_dst_ipv6.ipv6_simple_layout.ipv6_31_0);
-		break;
-	case MLX5HWS_DEFINER_FNAME_IPV6_SRC_127_96_I:
-	case MLX5HWS_DEFINER_FNAME_IPV6_SRC_95_64_I:
-	case MLX5HWS_DEFINER_FNAME_IPV6_SRC_63_32_I:
-	case MLX5HWS_DEFINER_FNAME_IPV6_SRC_31_0_I:
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      inner_headers.src_ipv4_src_ipv6.ipv6_simple_layout.ipv6_127_96);
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      inner_headers.src_ipv4_src_ipv6.ipv6_simple_layout.ipv6_95_64);
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      inner_headers.src_ipv4_src_ipv6.ipv6_simple_layout.ipv6_63_32);
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      inner_headers.src_ipv4_src_ipv6.ipv6_simple_layout.ipv6_31_0);
-		break;
-	case MLX5HWS_DEFINER_FNAME_IP_PROTOCOL_O:
-		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.ip_protocol);
-		break;
-	case MLX5HWS_DEFINER_FNAME_IP_PROTOCOL_I:
-		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.ip_protocol);
-		break;
-	case MLX5HWS_DEFINER_FNAME_L4_SPORT_O:
-		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.tcp_sport);
-		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.udp_sport);
-		break;
-	case MLX5HWS_DEFINER_FNAME_L4_SPORT_I:
-		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.tcp_dport);
-		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.udp_dport);
-		break;
-	case MLX5HWS_DEFINER_FNAME_L4_DPORT_O:
-		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.tcp_dport);
-		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.udp_dport);
-		break;
-	case MLX5HWS_DEFINER_FNAME_L4_DPORT_I:
-		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.tcp_dport);
-		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.udp_dport);
-		break;
-	case MLX5HWS_DEFINER_FNAME_TCP_FLAGS_O:
-		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.tcp_flags);
-		break;
-	case MLX5HWS_DEFINER_FNAME_TCP_ACK_NUM:
-	case MLX5HWS_DEFINER_FNAME_TCP_SEQ_NUM:
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      misc_parameters_3.outer_tcp_seq_num);
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      misc_parameters_3.outer_tcp_ack_num);
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      misc_parameters_3.inner_tcp_seq_num);
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      misc_parameters_3.inner_tcp_ack_num);
-		break;
-	case MLX5HWS_DEFINER_FNAME_GTP_TEID:
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_3.gtpu_teid);
-		break;
-	case MLX5HWS_DEFINER_FNAME_GTP_MSG_TYPE:
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_3.gtpu_msg_type);
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_3.gtpu_msg_flags);
-		break;
-	case MLX5HWS_DEFINER_FNAME_GTPU_FIRST_EXT_DW0:
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      misc_parameters_3.gtpu_first_ext_dw_0);
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_3.gtpu_dw_0);
-		break;
-	case MLX5HWS_DEFINER_FNAME_GTPU_DW2:
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_3.gtpu_dw_2);
-		break;
-	case MLX5HWS_DEFINER_FNAME_FLEX_PARSER_0:
-	case MLX5HWS_DEFINER_FNAME_FLEX_PARSER_1:
-	case MLX5HWS_DEFINER_FNAME_FLEX_PARSER_2:
-	case MLX5HWS_DEFINER_FNAME_FLEX_PARSER_3:
-	case MLX5HWS_DEFINER_FNAME_FLEX_PARSER_4:
-	case MLX5HWS_DEFINER_FNAME_FLEX_PARSER_5:
-	case MLX5HWS_DEFINER_FNAME_FLEX_PARSER_6:
-	case MLX5HWS_DEFINER_FNAME_FLEX_PARSER_7:
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      misc_parameters_2.outer_first_mpls_over_gre);
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      misc_parameters_2.outer_first_mpls_over_udp);
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      misc_parameters_3.geneve_tlv_option_0_data);
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      misc_parameters_4.prog_sample_field_id_0);
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      misc_parameters_4.prog_sample_field_value_0);
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      misc_parameters_4.prog_sample_field_value_1);
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      misc_parameters_4.prog_sample_field_id_2);
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      misc_parameters_4.prog_sample_field_value_2);
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      misc_parameters_4.prog_sample_field_id_3);
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      misc_parameters_4.prog_sample_field_value_3);
-		break;
-	case MLX5HWS_DEFINER_FNAME_VXLAN_VNI:
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters.vxlan_vni);
-		break;
-	case MLX5HWS_DEFINER_FNAME_VXLAN_GPE_FLAGS:
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      misc_parameters_3.outer_vxlan_gpe_flags);
-		break;
-	case MLX5HWS_DEFINER_FNAME_VXLAN_GPE_RSVD0:
-		break;
-	case MLX5HWS_DEFINER_FNAME_VXLAN_GPE_PROTO:
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      misc_parameters_3.outer_vxlan_gpe_next_protocol);
-		break;
-	case MLX5HWS_DEFINER_FNAME_VXLAN_GPE_VNI:
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      misc_parameters_3.outer_vxlan_gpe_vni);
-		break;
-	case MLX5HWS_DEFINER_FNAME_GENEVE_OPT_LEN:
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters.geneve_opt_len);
-		break;
-	case MLX5HWS_DEFINER_FNAME_GENEVE_OAM:
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters.geneve_oam);
-		break;
-	case MLX5HWS_DEFINER_FNAME_GENEVE_PROTO:
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      misc_parameters.geneve_protocol_type);
-		break;
-	case MLX5HWS_DEFINER_FNAME_GENEVE_VNI:
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters.geneve_vni);
-		break;
-	case MLX5HWS_DEFINER_FNAME_SOURCE_QP:
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters.source_sqn);
-		break;
-	case MLX5HWS_DEFINER_FNAME_SOURCE_GVMI:
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters.source_port);
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      misc_parameters.source_eswitch_owner_vhca_id);
-		break;
-	case MLX5HWS_DEFINER_FNAME_REG_0:
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_2.metadata_reg_c_0);
-		break;
-	case MLX5HWS_DEFINER_FNAME_REG_1:
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_2.metadata_reg_c_1);
-		break;
-	case MLX5HWS_DEFINER_FNAME_REG_2:
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_2.metadata_reg_c_2);
-		break;
-	case MLX5HWS_DEFINER_FNAME_REG_3:
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_2.metadata_reg_c_3);
-		break;
-	case MLX5HWS_DEFINER_FNAME_REG_4:
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_2.metadata_reg_c_4);
-		break;
-	case MLX5HWS_DEFINER_FNAME_REG_5:
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_2.metadata_reg_c_5);
-		break;
-	case MLX5HWS_DEFINER_FNAME_REG_7:
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_2.metadata_reg_c_7);
-		break;
-	case MLX5HWS_DEFINER_FNAME_REG_A:
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_2.metadata_reg_a);
-		break;
-	case MLX5HWS_DEFINER_FNAME_GRE_C:
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters.gre_c_present);
-		break;
-	case MLX5HWS_DEFINER_FNAME_GRE_K:
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters.gre_k_present);
-		break;
-	case MLX5HWS_DEFINER_FNAME_GRE_S:
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters.gre_s_present);
-		break;
-	case MLX5HWS_DEFINER_FNAME_GRE_PROTOCOL:
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters.gre_protocol);
-		break;
-	case MLX5HWS_DEFINER_FNAME_GRE_OPT_KEY:
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters.gre_key.key);
-		break;
-	case MLX5HWS_DEFINER_FNAME_ICMP_DW1:
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_3.icmp_header_data);
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_3.icmp_type);
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_3.icmp_code);
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      misc_parameters_3.icmpv6_header_data);
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_3.icmpv6_type);
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_3.icmpv6_code);
-		break;
-	case MLX5HWS_DEFINER_FNAME_MPLS0_O:
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_2.outer_first_mpls);
-		break;
-	case MLX5HWS_DEFINER_FNAME_MPLS0_I:
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_2.inner_first_mpls);
-		break;
-	case MLX5HWS_DEFINER_FNAME_TNL_HDR_0:
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_5.tunnel_header_0);
-		break;
-	case MLX5HWS_DEFINER_FNAME_TNL_HDR_1:
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_5.tunnel_header_1);
-		break;
-	case MLX5HWS_DEFINER_FNAME_TNL_HDR_2:
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_5.tunnel_header_2);
-		break;
-	case MLX5HWS_DEFINER_FNAME_TNL_HDR_3:
-		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_5.tunnel_header_3);
-		break;
-	case MLX5HWS_DEFINER_FNAME_FLEX_PARSER0_OK:
-	case MLX5HWS_DEFINER_FNAME_FLEX_PARSER1_OK:
-	case MLX5HWS_DEFINER_FNAME_FLEX_PARSER2_OK:
-	case MLX5HWS_DEFINER_FNAME_FLEX_PARSER3_OK:
-	case MLX5HWS_DEFINER_FNAME_FLEX_PARSER4_OK:
-	case MLX5HWS_DEFINER_FNAME_FLEX_PARSER5_OK:
-	case MLX5HWS_DEFINER_FNAME_FLEX_PARSER6_OK:
-	case MLX5HWS_DEFINER_FNAME_FLEX_PARSER7_OK:
-		/* assuming this is flex parser for geneve option */
-		if ((fname == MLX5HWS_DEFINER_FNAME_FLEX_PARSER0_OK &&
-		     ctx->caps->flex_parser_id_geneve_tlv_option_0 != 0) ||
-		    (fname == MLX5HWS_DEFINER_FNAME_FLEX_PARSER1_OK &&
-		     ctx->caps->flex_parser_id_geneve_tlv_option_0 != 1) ||
-		    (fname == MLX5HWS_DEFINER_FNAME_FLEX_PARSER2_OK &&
-		     ctx->caps->flex_parser_id_geneve_tlv_option_0 != 2) ||
-		    (fname == MLX5HWS_DEFINER_FNAME_FLEX_PARSER3_OK &&
-		     ctx->caps->flex_parser_id_geneve_tlv_option_0 != 3) ||
-		    (fname == MLX5HWS_DEFINER_FNAME_FLEX_PARSER4_OK &&
-		     ctx->caps->flex_parser_id_geneve_tlv_option_0 != 4) ||
-		    (fname == MLX5HWS_DEFINER_FNAME_FLEX_PARSER5_OK &&
-		     ctx->caps->flex_parser_id_geneve_tlv_option_0 != 5) ||
-		    (fname == MLX5HWS_DEFINER_FNAME_FLEX_PARSER6_OK &&
-		     ctx->caps->flex_parser_id_geneve_tlv_option_0 != 6) ||
-		    (fname == MLX5HWS_DEFINER_FNAME_FLEX_PARSER7_OK &&
-		     ctx->caps->flex_parser_id_geneve_tlv_option_0 != 7)) {
-			mlx5hws_err(ctx,
-				    "Complex params: unsupported field %s (%d), flex parser ID for geneve is %d\n",
-				    mlx5hws_definer_fname_to_str(fname), fname,
-				    caps->flex_parser_id_geneve_tlv_option_0);
-			break;
-		}
-		HWS_CLEAR_MATCH_PARAM(mask,
-				      misc_parameters.geneve_tlv_option_0_exist);
-		break;
-	case MLX5HWS_DEFINER_FNAME_REG_6:
-	default:
-		mlx5hws_err(ctx, "Complex params: unsupported field %s (%d)\n",
-			    mlx5hws_definer_fname_to_str(fname), fname);
-		break;
-	}
+	return hws_match_params_exceeds_definer(ctx, match_criteria_enable,
+						mask, true);
 }
 
-static bool
-hws_bwc_matcher_complex_params_comb_is_valid(struct mlx5hws_definer_fc *fc,
-					     int fc_sz,
-					     u32 combination_num)
+static int
+hws_get_last_set_dword_idx(const struct mlx5hws_match_parameters *mask)
 {
-	bool m1[MLX5HWS_DEFINER_FNAME_MAX] = {0};
-	bool m2[MLX5HWS_DEFINER_FNAME_MAX] = {0};
-	bool is_first_matcher;
 	int i;
 
-	for (i = 0; i < fc_sz; i++) {
-		is_first_matcher = !(combination_num & BIT(i));
-		if (is_first_matcher)
-			m1[fc[i].fname] = true;
-		else
-			m2[fc[i].fname] = true;
-	}
-
-	/* Not all the fields can be split into separate matchers.
-	 * Some should be together on the same matcher.
-	 * For example, IPv6 parts - the whole IPv6 address should be on the
-	 * same matcher in order for us to deduce if it's IPv6 or IPv4 address.
-	 */
-	if (m1[MLX5HWS_DEFINER_FNAME_IP_FRAG_O] &&
-	    (m2[MLX5HWS_DEFINER_FNAME_ETH_SMAC_15_0_O] ||
-	     m2[MLX5HWS_DEFINER_FNAME_ETH_SMAC_47_16_O] ||
-	     m2[MLX5HWS_DEFINER_FNAME_ETH_DMAC_15_0_O] ||
-	     m2[MLX5HWS_DEFINER_FNAME_ETH_DMAC_47_16_O]))
-		return false;
-
-	if (m2[MLX5HWS_DEFINER_FNAME_IP_FRAG_O] &&
-	    (m1[MLX5HWS_DEFINER_FNAME_ETH_SMAC_15_0_O] ||
-	     m1[MLX5HWS_DEFINER_FNAME_ETH_SMAC_47_16_O] ||
-	     m1[MLX5HWS_DEFINER_FNAME_ETH_DMAC_15_0_O] ||
-	     m1[MLX5HWS_DEFINER_FNAME_ETH_DMAC_47_16_O]))
-		return false;
+	for (i = mask->match_sz / 4 - 1; i >= 0; i--)
+		if (mask->match_buf[i])
+			return i;
 
-	if (m1[MLX5HWS_DEFINER_FNAME_IP_FRAG_I] &&
-	    (m2[MLX5HWS_DEFINER_FNAME_ETH_SMAC_47_16_I] ||
-	     m2[MLX5HWS_DEFINER_FNAME_ETH_SMAC_15_0_I] ||
-	     m2[MLX5HWS_DEFINER_FNAME_ETH_DMAC_47_16_I] ||
-	     m2[MLX5HWS_DEFINER_FNAME_ETH_DMAC_15_0_I]))
-		return false;
+	return -1;
+}
 
-	if (m2[MLX5HWS_DEFINER_FNAME_IP_FRAG_I] &&
-	    (m1[MLX5HWS_DEFINER_FNAME_ETH_SMAC_47_16_I] ||
-	     m1[MLX5HWS_DEFINER_FNAME_ETH_SMAC_15_0_I] ||
-	     m1[MLX5HWS_DEFINER_FNAME_ETH_DMAC_47_16_I] ||
-	     m1[MLX5HWS_DEFINER_FNAME_ETH_DMAC_15_0_I]))
-		return false;
+static bool hws_match_mask_is_empty(const struct mlx5hws_match_parameters *mask)
+{
+	return hws_get_last_set_dword_idx(mask) == -1;
+}
 
-	/* Don't split outer IPv6 dest address. */
-	if ((m1[MLX5HWS_DEFINER_FNAME_IPV6_DST_127_96_O] ||
-	     m1[MLX5HWS_DEFINER_FNAME_IPV6_DST_95_64_O] ||
-	     m1[MLX5HWS_DEFINER_FNAME_IPV6_DST_63_32_O] ||
-	     m1[MLX5HWS_DEFINER_FNAME_IPV6_DST_31_0_O]) &&
-	    (m2[MLX5HWS_DEFINER_FNAME_IPV6_DST_127_96_O] ||
-	     m2[MLX5HWS_DEFINER_FNAME_IPV6_DST_95_64_O] ||
-	     m2[MLX5HWS_DEFINER_FNAME_IPV6_DST_63_32_O] ||
-	     m2[MLX5HWS_DEFINER_FNAME_IPV6_DST_31_0_O]))
-		return false;
+static bool hws_dword_is_inner_ipaddr_off(int dword_off)
+{
+	/* IPv4 and IPv6 addresses share the same entry via a union, and the
+	 * source and dest addresses are contiguous in the fte_match_param. So
+	 * we need to check 8 words.
+	 */
+	static const int inner_ip_dword_off =
+		__mlx5_dw_off(fte_match_param, inner_headers.src_ipv4_src_ipv6);
 
-	/* Don't split outer IPv6 source address. */
-	if ((m1[MLX5HWS_DEFINER_FNAME_IPV6_SRC_127_96_O] ||
-	     m1[MLX5HWS_DEFINER_FNAME_IPV6_SRC_95_64_O] ||
-	     m1[MLX5HWS_DEFINER_FNAME_IPV6_SRC_63_32_O] ||
-	     m1[MLX5HWS_DEFINER_FNAME_IPV6_SRC_31_0_O]) &&
-	    (m2[MLX5HWS_DEFINER_FNAME_IPV6_SRC_127_96_O] ||
-	     m2[MLX5HWS_DEFINER_FNAME_IPV6_SRC_95_64_O] ||
-	     m2[MLX5HWS_DEFINER_FNAME_IPV6_SRC_63_32_O] ||
-	     m2[MLX5HWS_DEFINER_FNAME_IPV6_SRC_31_0_O]))
-		return false;
+	return dword_off >= inner_ip_dword_off &&
+	       dword_off < inner_ip_dword_off + 8;
+}
 
-	/* Don't split inner IPv6 dest address. */
-	if ((m1[MLX5HWS_DEFINER_FNAME_IPV6_DST_127_96_I] ||
-	     m1[MLX5HWS_DEFINER_FNAME_IPV6_DST_95_64_I] ||
-	     m1[MLX5HWS_DEFINER_FNAME_IPV6_DST_63_32_I] ||
-	     m1[MLX5HWS_DEFINER_FNAME_IPV6_DST_31_0_I]) &&
-	    (m2[MLX5HWS_DEFINER_FNAME_IPV6_DST_127_96_I] ||
-	     m2[MLX5HWS_DEFINER_FNAME_IPV6_DST_95_64_I] ||
-	     m2[MLX5HWS_DEFINER_FNAME_IPV6_DST_63_32_I] ||
-	     m2[MLX5HWS_DEFINER_FNAME_IPV6_DST_31_0_I]))
-		return false;
+static bool hws_dword_is_outer_ipaddr_off(int dword_off)
+{
+	static const int outer_ip_dword_off =
+		__mlx5_dw_off(fte_match_param, outer_headers.src_ipv4_src_ipv6);
 
-	/* Don't split inner IPv6 source address. */
-	if ((m1[MLX5HWS_DEFINER_FNAME_IPV6_SRC_127_96_I] ||
-	     m1[MLX5HWS_DEFINER_FNAME_IPV6_SRC_95_64_I] ||
-	     m1[MLX5HWS_DEFINER_FNAME_IPV6_SRC_63_32_I] ||
-	     m1[MLX5HWS_DEFINER_FNAME_IPV6_SRC_31_0_I]) &&
-	    (m2[MLX5HWS_DEFINER_FNAME_IPV6_SRC_127_96_I] ||
-	     m2[MLX5HWS_DEFINER_FNAME_IPV6_SRC_95_64_I] ||
-	     m2[MLX5HWS_DEFINER_FNAME_IPV6_SRC_63_32_I] ||
-	     m2[MLX5HWS_DEFINER_FNAME_IPV6_SRC_31_0_I]))
-		return false;
+	return dword_off >= outer_ip_dword_off &&
+	       dword_off < outer_ip_dword_off + 8;
+}
 
-	/* Don't split GRE parameters. */
-	if ((m1[MLX5HWS_DEFINER_FNAME_GRE_C] ||
-	     m1[MLX5HWS_DEFINER_FNAME_GRE_K] ||
-	     m1[MLX5HWS_DEFINER_FNAME_GRE_S] ||
-	     m1[MLX5HWS_DEFINER_FNAME_GRE_PROTOCOL]) &&
-	    (m2[MLX5HWS_DEFINER_FNAME_GRE_C] ||
-	     m2[MLX5HWS_DEFINER_FNAME_GRE_K] ||
-	     m2[MLX5HWS_DEFINER_FNAME_GRE_S] ||
-	     m2[MLX5HWS_DEFINER_FNAME_GRE_PROTOCOL]))
-		return false;
+static void hws_add_dword_to_mask(struct mlx5hws_match_parameters *mask,
+				  const struct mlx5hws_match_parameters *orig,
+				  int dword_idx, bool *added_inner_ipv,
+				  bool *added_outer_ipv)
+{
+	mask->match_buf[dword_idx] |= orig->match_buf[dword_idx];
 
-	/* Don't split TCP ack/seq numbers. */
-	if ((m1[MLX5HWS_DEFINER_FNAME_TCP_ACK_NUM] ||
-	     m1[MLX5HWS_DEFINER_FNAME_TCP_SEQ_NUM]) &&
-	    (m2[MLX5HWS_DEFINER_FNAME_TCP_ACK_NUM] ||
-	     m2[MLX5HWS_DEFINER_FNAME_TCP_SEQ_NUM]))
-		return false;
+	*added_inner_ipv = false;
+	*added_outer_ipv = false;
 
-	/* Don't split flex parser. */
-	if ((m1[MLX5HWS_DEFINER_FNAME_FLEX_PARSER_0] ||
-	     m1[MLX5HWS_DEFINER_FNAME_FLEX_PARSER_1] ||
-	     m1[MLX5HWS_DEFINER_FNAME_FLEX_PARSER_2] ||
-	     m1[MLX5HWS_DEFINER_FNAME_FLEX_PARSER_3] ||
-	     m1[MLX5HWS_DEFINER_FNAME_FLEX_PARSER_4] ||
-	     m1[MLX5HWS_DEFINER_FNAME_FLEX_PARSER_5] ||
-	     m1[MLX5HWS_DEFINER_FNAME_FLEX_PARSER_6] ||
-	     m1[MLX5HWS_DEFINER_FNAME_FLEX_PARSER_7]) &&
-	    (m2[MLX5HWS_DEFINER_FNAME_FLEX_PARSER_0] ||
-	     m2[MLX5HWS_DEFINER_FNAME_FLEX_PARSER_1] ||
-	     m2[MLX5HWS_DEFINER_FNAME_FLEX_PARSER_2] ||
-	     m2[MLX5HWS_DEFINER_FNAME_FLEX_PARSER_3] ||
-	     m2[MLX5HWS_DEFINER_FNAME_FLEX_PARSER_4] ||
-	     m2[MLX5HWS_DEFINER_FNAME_FLEX_PARSER_5] ||
-	     m2[MLX5HWS_DEFINER_FNAME_FLEX_PARSER_6] ||
-	     m2[MLX5HWS_DEFINER_FNAME_FLEX_PARSER_7]))
-		return false;
+	/* Any IP address fragment must be accompanied by a match on IP version.
+	 * Use the `added_ipv` variables to keep track if we added IP versions
+	 * specifically for this dword, so that we can roll them back if the
+	 * match params become too large to fit into a definer.
+	 */
+	if (hws_dword_is_inner_ipaddr_off(dword_idx) &&
+	    !MLX5_GET(fte_match_param, mask->match_buf,
+		      inner_headers.ip_version)) {
+		MLX5_SET(fte_match_param, mask->match_buf,
+			 inner_headers.ip_version, 0xf);
+		*added_inner_ipv = true;
+	}
+	if (hws_dword_is_outer_ipaddr_off(dword_idx) &&
+	    !MLX5_GET(fte_match_param, mask->match_buf,
+		      outer_headers.ip_version)) {
+		MLX5_SET(fte_match_param, mask->match_buf,
+			 outer_headers.ip_version, 0xf);
+		*added_outer_ipv = true;
+	}
+}
 
-	return true;
+static void hws_remove_dword_from_mask(struct mlx5hws_match_parameters *mask,
+				       int dword_idx, bool added_inner_ipv,
+				       bool added_outer_ipv)
+{
+	mask->match_buf[dword_idx] = 0;
+	if (added_inner_ipv)
+		MLX5_SET(fte_match_param, mask->match_buf,
+			 inner_headers.ip_version, 0);
+	if (added_outer_ipv)
+		MLX5_SET(fte_match_param, mask->match_buf,
+			 outer_headers.ip_version, 0);
 }
 
-static void
-hws_bwc_matcher_complex_params_comb_create(struct mlx5hws_context *ctx,
-					   struct mlx5hws_match_parameters *m,
-					   struct mlx5hws_match_parameters *m1,
-					   struct mlx5hws_match_parameters *m2,
-					   struct mlx5hws_definer_fc *fc,
-					   int fc_sz,
-					   u32 combination_num)
+/* Avoid leaving a single lower dword in `mask` if there are others present in
+ * `orig`. Splitting IPv6 addresses like this causes them to be interpreted as
+ * IPv4.
+ */
+static void hws_avoid_ipv6_split_of(struct mlx5hws_match_parameters *orig,
+				    struct mlx5hws_match_parameters *mask,
+				    int off)
 {
-	bool is_first_matcher;
-	int i;
+	/* Masks are allocated to a full fte_match_param, but it can't hurt to
+	 * double check.
+	 */
+	if (orig->match_sz <= off + 3 || mask->match_sz <= off + 3)
+		return;
 
-	memcpy(m1->match_buf, m->match_buf, m->match_sz);
-	memcpy(m2->match_buf, m->match_buf, m->match_sz);
+	/* Lower dword is not set, nothing to do. */
+	if (!mask->match_buf[off + 3])
+		return;
 
-	for (i = 0; i < fc_sz; i++) {
-		is_first_matcher = !(combination_num & BIT(i));
-		hws_bwc_matcher_complex_params_clear_fld(ctx,
-							 fc[i].fname,
-							 is_first_matcher ?
-							 m2 : m1);
-	}
+	/* Higher dwords also present in `mask`, no ambiguity. */
+	if (mask->match_buf[off] || mask->match_buf[off + 1] ||
+	    mask->match_buf[off + 2])
+		return;
+
+	/* There are no higher dwords in `orig`, i.e. we match on IPv4. */
+	if (!orig->match_buf[off] && !orig->match_buf[off + 1] &&
+	    !orig->match_buf[off + 2])
+		return;
 
-	MLX5_SET(fte_match_param, m2->match_buf,
-		 misc_parameters_2.metadata_reg_c_6, -1);
+	/* Put the lower dword back in `orig`. It is always safe to do this, the
+	 * dword will just be picked up in the next submask.
+	 */
+	orig->match_buf[off + 3] = mask->match_buf[off + 3];
+	mask->match_buf[off + 3] = 0;
 }
 
-static void
-hws_bwc_matcher_complex_params_destroy(struct mlx5hws_match_parameters *mask_1,
-				       struct mlx5hws_match_parameters *mask_2)
+static void hws_avoid_ipv6_split(struct mlx5hws_match_parameters *orig,
+				 struct mlx5hws_match_parameters *mask)
 {
-	kfree(mask_1->match_buf);
-	kfree(mask_2->match_buf);
+	hws_avoid_ipv6_split_of(orig, mask,
+				__mlx5_dw_off(fte_match_param,
+					      outer_headers.src_ipv4_src_ipv6));
+	hws_avoid_ipv6_split_of(orig, mask,
+				__mlx5_dw_off(fte_match_param,
+					      outer_headers.dst_ipv4_dst_ipv6));
+	hws_avoid_ipv6_split_of(orig, mask,
+				__mlx5_dw_off(fte_match_param,
+					      inner_headers.src_ipv4_src_ipv6));
+	hws_avoid_ipv6_split_of(orig, mask,
+				__mlx5_dw_off(fte_match_param,
+					      inner_headers.dst_ipv4_dst_ipv6));
 }
 
-static int
-hws_bwc_matcher_complex_params_create(struct mlx5hws_context *ctx,
-				      u8 match_criteria,
-				      struct mlx5hws_match_parameters *mask,
-				      struct mlx5hws_match_parameters *mask_1,
-				      struct mlx5hws_match_parameters *mask_2)
+/* Build a subset of the `orig` match parameters into `mask`. This subset is
+ * guaranteed to fit in a single definer an as such is a candidate for being a
+ * part of a complex matcher. Upon successful execution, the match params that
+ * go into `mask` are cleared from `orig`.
+ */
+static int hws_get_simple_params(struct mlx5hws_context *ctx, u8 match_criteria,
+				 struct mlx5hws_match_parameters *orig,
+				 struct mlx5hws_match_parameters *mask)
 {
-	struct mlx5hws_definer_fc *fc;
-	u32 num_of_combinations;
-	int fc_sz = 0;
-	int res = 0;
-	u32 i;
-
-	if (MLX5_GET(fte_match_param, mask->match_buf,
-		     misc_parameters_2.metadata_reg_c_6)) {
-		mlx5hws_err(ctx, "Complex matcher: REG_C_6 matching is reserved\n");
-		res = -EINVAL;
-		goto out;
-	}
+	bool added_inner_ipv, added_outer_ipv;
+	int dword_idx;
+	u32 *backup;
+	int ret;
 
-	mask_1->match_buf = kzalloc(MLX5_ST_SZ_BYTES(fte_match_param),
-				    GFP_KERNEL);
-	mask_2->match_buf = kzalloc(MLX5_ST_SZ_BYTES(fte_match_param),
-				    GFP_KERNEL);
-	if (!mask_1->match_buf || !mask_2->match_buf) {
-		mlx5hws_err(ctx, "Complex matcher: failed to allocate match_param\n");
-		res = -ENOMEM;
-		goto free_params;
-	}
+	dword_idx = hws_get_last_set_dword_idx(orig);
+	/* Nothing to do, we consumed all of the match params before. */
+	if (dword_idx == -1)
+		return 0;
 
-	mask_1->match_sz = mask->match_sz;
-	mask_2->match_sz = mask->match_sz;
+	backup = kzalloc(MLX5_ST_SZ_BYTES(fte_match_param), GFP_KERNEL);
+	if (!backup)
+		return -ENOMEM;
 
-	fc = mlx5hws_definer_conv_match_params_to_compressed_fc(ctx,
-								match_criteria,
-								mask->match_buf,
-								&fc_sz);
-	if (!fc) {
-		res = -ENOMEM;
-		goto free_params;
-	}
+	while (1) {
+		dword_idx = hws_get_last_set_dword_idx(orig);
+		/* Nothing to do, we consumed all of the original match params
+		 * into this subset, which still fits into a single matcher.
+		 */
+		if (dword_idx == -1) {
+			ret = 0;
+			goto free_backup;
+		}
 
-	if (fc_sz >= sizeof(num_of_combinations) * BITS_PER_BYTE) {
-		mlx5hws_err(ctx,
-			    "Complex matcher: too many match parameters (%d)\n",
-			    fc_sz);
-		res = -EINVAL;
-		goto free_fc;
+		memcpy(backup, mask->match_buf, mask->match_sz);
+
+		/* Try to add this dword to the current subset. */
+		hws_add_dword_to_mask(mask, orig, dword_idx, &added_inner_ipv,
+				      &added_outer_ipv);
+
+		if (hws_match_params_exceeds_definer(ctx, match_criteria, mask,
+						     false)) {
+			/* We just added a match param that makes the definer
+			 * too large. Revert and return what we had before.
+			 * Note that we can't just zero out the affected fields,
+			 * because it's possible that the dword we're looking at
+			 * wasn't zero before (e.g. it included auto-added
+			 * matches in IP version. This is why we employ the
+			 * rather cumbersome memcpy for backing up.
+			 */
+			memcpy(mask->match_buf, backup, mask->match_sz);
+			/* Possible future improvement: We can't add any more
+			 * dwords, but it may be possible to squeeze in
+			 * individual bytes, as definers have special slots for
+			 * those.
+			 *
+			 * For now, keep the code simple. This results in an
+			 * extra submatcher in some cases, but it's good enough.
+			 */
+			ret = 0;
+			break;
+		}
+
+		/* The current subset of match params still fits in a single
+		 * definer. Remove the dword from the original mask.
+		 *
+		 * Also remove any explicit match on IP version if we just
+		 * included one here. We will still automatically add it to
+		 * accompany any IP address fragment, but do not need to
+		 * consider it by itself.
+		 */
+		hws_remove_dword_from_mask(orig, dword_idx, added_inner_ipv,
+					   added_outer_ipv);
 	}
 
-	/* We have list of all the match fields from the match parameter.
-	 * Now try all the possibilities of splitting them into two match
-	 * buffers and look for the supported combination.
+	/* Make sure we have not picked up a single lower dword of an IPv6
+	 * address, as the firmware will erroneously treat it as an IPv4
+	 * address.
 	 */
-	num_of_combinations = 1 << fc_sz;
+	hws_avoid_ipv6_split(orig, mask);
 
-	/* Start from combination at index 1 - we know that 0 is unsupported */
-	for (i = 1; i < num_of_combinations; i++) {
-		if (!hws_bwc_matcher_complex_params_comb_is_valid(fc, fc_sz, i))
-			continue;
+free_backup:
+	kfree(backup);
 
-		hws_bwc_matcher_complex_params_comb_create(ctx,
-							   mask, mask_1, mask_2,
-							   fc, fc_sz, i);
-		/* We now have two separate sets of match params.
-		 * Check if each of them can be used in its own matcher.
+	return ret;
+}
+
+static int
+hws_bwc_matcher_split_mask(struct mlx5hws_context *ctx, u8 match_criteria,
+			   const struct mlx5hws_match_parameters *mask,
+			   struct mlx5hws_match_parameters *submasks,
+			   int *num_submasks)
+{
+	struct mlx5hws_match_parameters mask_copy;
+	int ret, i = 0;
+
+	mask_copy.match_sz = MLX5_ST_SZ_BYTES(fte_match_param);
+	mask_copy.match_buf = kzalloc(mask_copy.match_sz, GFP_KERNEL);
+	if (!mask_copy.match_buf)
+		return -ENOMEM;
+
+	memcpy(mask_copy.match_buf, mask->match_buf, mask->match_sz);
+
+	while (!hws_match_mask_is_empty(&mask_copy)) {
+		if (i >= MLX5HWS_BWC_COMPLEX_MAX_SUBMATCHERS) {
+			mlx5hws_err(ctx,
+				    "Complex matcher: mask too large for %d matchers\n",
+				    MLX5HWS_BWC_COMPLEX_MAX_SUBMATCHERS);
+			ret = -E2BIG;
+			goto free_copy;
+		}
+		/* All but the first matcher need to match on register C6 to
+		 * connect pieces of the complex rule together.
 		 */
-		if (!mlx5hws_bwc_match_params_is_complex(ctx,
-							 match_criteria,
-							 mask_1) &&
-		    !mlx5hws_bwc_match_params_is_complex(ctx,
-							 match_criteria,
-							 mask_2))
-			break;
+		if (i > 0) {
+			MLX5_SET(fte_match_param, submasks[i].match_buf,
+				 misc_parameters_2.metadata_reg_c_6, -1);
+			match_criteria |= MLX5HWS_DEFINER_MATCH_CRITERIA_MISC2;
+		}
+		ret = hws_get_simple_params(ctx, match_criteria, &mask_copy,
+					    &submasks[i]);
+		if (ret < 0)
+			goto free_copy;
+		i++;
 	}
 
-	if (i == num_of_combinations) {
-		/* We've scanned all the combinations, but to no avail */
-		mlx5hws_err(ctx, "Complex matcher: couldn't find match params combination\n");
-		res = -EINVAL;
-		goto free_fc;
-	}
+	*num_submasks = i;
+	ret = 0;
 
-	kfree(fc);
-	return 0;
+free_copy:
+	kfree(mask_copy.match_buf);
 
-free_fc:
-	kfree(fc);
-free_params:
-	hws_bwc_matcher_complex_params_destroy(mask_1, mask_2);
-out:
-	return res;
+	return ret;
 }
 
-static int
-hws_bwc_isolated_table_create(struct mlx5hws_bwc_matcher *bwc_matcher,
-			      struct mlx5hws_table *table)
+static struct mlx5hws_table *
+hws_isolated_table_create(const struct mlx5hws_bwc_matcher *cmatcher)
 {
+	struct mlx5hws_bwc_complex_submatcher *first_subm;
 	struct mlx5hws_cmd_ft_modify_attr ft_attr = {0};
-	struct mlx5hws_context *ctx = table->ctx;
 	struct mlx5hws_table_attr tbl_attr = {0};
-	struct mlx5hws_table *isolated_tbl;
-	int ret = 0;
+	struct mlx5hws_table *orig_tbl;
+	struct mlx5hws_context *ctx;
+	struct mlx5hws_table *tbl;
+	int ret;
 
-	tbl_attr.type = table->type;
-	tbl_attr.level = table->level;
+	first_subm = &cmatcher->complex->submatchers[0];
+	orig_tbl = first_subm->tbl;
+	ctx = orig_tbl->ctx;
 
-	bwc_matcher->complex->isolated_tbl =
-		mlx5hws_table_create(ctx, &tbl_attr);
-	isolated_tbl = bwc_matcher->complex->isolated_tbl;
-	if (!isolated_tbl)
-		return -EINVAL;
+	tbl_attr.type = orig_tbl->type;
+	tbl_attr.level = orig_tbl->level;
+	tbl = mlx5hws_table_create(ctx, &tbl_attr);
+	if (!tbl)
+		return ERR_PTR(-EINVAL);
 
-	/* Set the default miss of the isolated table to
-	 * point to the end anchor of the original matcher.
+	/* Set the default miss of the isolated table to point
+	 * to the end anchor of the original matcher.
 	 */
-	mlx5hws_cmd_set_attr_connect_miss_tbl(ctx,
-					      isolated_tbl->fw_ft_type,
-					      isolated_tbl->type,
-					      &ft_attr);
-	ft_attr.table_miss_id = bwc_matcher->matcher->end_ft_id;
-
-	ret = mlx5hws_cmd_flow_table_modify(ctx->mdev,
-					    &ft_attr,
-					    isolated_tbl->ft_id);
+	mlx5hws_cmd_set_attr_connect_miss_tbl(ctx, tbl->fw_ft_type,
+					      tbl->type, &ft_attr);
+	ft_attr.table_miss_id = first_subm->bwc_matcher->matcher->end_ft_id;
+
+	ret = mlx5hws_cmd_flow_table_modify(ctx->mdev, &ft_attr, tbl->ft_id);
 	if (ret) {
-		mlx5hws_err(ctx, "Failed setting isolated tbl default miss\n");
+		mlx5hws_err(ctx, "Complex matcher: failed to set isolated tbl default miss\n");
 		goto destroy_tbl;
 	}
 
-	return 0;
+	return tbl;
 
 destroy_tbl:
-	mlx5hws_table_destroy(isolated_tbl);
-	return ret;
+	mlx5hws_table_destroy(tbl);
+
+	return ERR_PTR(ret);
 }
 
-static void hws_bwc_isolated_table_destroy(struct mlx5hws_table *isolated_tbl)
+static int hws_submatcher_init_first(struct mlx5hws_bwc_matcher *cmatcher,
+				     struct mlx5hws_table *table, u32 priority,
+				     u8 match_criteria,
+				     struct mlx5hws_match_parameters *mask)
 {
-	/* This table is isolated - no table is pointing to it, no need to
-	 * disconnect it from anywhere, it won't affect any other table's miss.
+	enum mlx5hws_action_type action_types[HWS_NUM_CHAIN_ACTIONS];
+	struct mlx5hws_bwc_complex_submatcher *subm;
+	int ret;
+
+	subm = &cmatcher->complex->submatchers[0];
+
+	/* The first submatcher lives in the original table and does not have an
+	 * associated jump to table action. It also points to the outer complex
+	 * matcher.
 	 */
-	mlx5hws_table_destroy(isolated_tbl);
+	subm->tbl = table;
+	subm->action_tbl = NULL;
+	subm->bwc_matcher = cmatcher;
+
+	action_types[0] = MLX5HWS_ACTION_TYP_MODIFY_HDR;
+	action_types[1] = MLX5HWS_ACTION_TYP_TBL;
+	action_types[2] = MLX5HWS_ACTION_TYP_LAST;
+
+	ret = mlx5hws_bwc_matcher_create_simple(subm->bwc_matcher, subm->tbl,
+						priority, match_criteria, mask,
+						action_types);
+	if (ret)
+		return ret;
+
+	subm->bwc_matcher->matcher_type = MLX5HWS_BWC_MATCHER_COMPLEX_FIRST;
+
+	ret = rhashtable_init(&subm->rules_hash, &hws_rules_hash_params);
+	if (ret)
+		goto destroy_matcher;
+	mutex_init(&subm->hash_lock);
+	ida_init(&subm->chain_ida);
+
+	return 0;
+
+destroy_matcher:
+	mlx5hws_bwc_matcher_destroy_simple(subm->bwc_matcher);
+
+	return ret;
 }
 
-static int
-hws_bwc_isolated_matcher_create(struct mlx5hws_bwc_matcher *bwc_matcher,
-				struct mlx5hws_table *table,
-				u8 match_criteria_enable,
-				struct mlx5hws_match_parameters *mask)
+static int hws_submatcher_init(struct mlx5hws_bwc_matcher *cmatcher, int idx,
+			       struct mlx5hws_table *table, u32 priority,
+			       u8 match_criteria,
+			       struct mlx5hws_match_parameters *mask)
 {
-	struct mlx5hws_table *isolated_tbl = bwc_matcher->complex->isolated_tbl;
-	struct mlx5hws_bwc_matcher *isolated_bwc_matcher;
-	struct mlx5hws_context *ctx = table->ctx;
+	enum mlx5hws_action_type action_types[HWS_NUM_CHAIN_ACTIONS];
+	struct mlx5hws_bwc_complex_submatcher *subm;
+	bool is_last;
 	int ret;
 
-	isolated_bwc_matcher = kzalloc(sizeof(*bwc_matcher), GFP_KERNEL);
-	if (!isolated_bwc_matcher)
-		return -ENOMEM;
+	if (!idx)
+		return hws_submatcher_init_first(cmatcher, table, priority,
+						 match_criteria, mask);
 
-	bwc_matcher->complex->isolated_bwc_matcher = isolated_bwc_matcher;
+	subm = &cmatcher->complex->submatchers[idx];
+	is_last = idx == cmatcher->complex->num_submatchers - 1;
 
-	/* Isolated BWC matcher needs access to the first BWC matcher */
-	isolated_bwc_matcher->complex_first_bwc_matcher = bwc_matcher;
+	subm->tbl = hws_isolated_table_create(cmatcher);
+	if (IS_ERR(subm->tbl))
+		return PTR_ERR(subm->tbl);
 
-	/* Isolated matcher needs to match on REG_C_6,
-	 * so make sure its criteria bit is on.
+	subm->action_tbl =
+		mlx5hws_action_create_dest_table(subm->tbl->ctx, subm->tbl,
+						 MLX5HWS_ACTION_FLAG_HWS_FDB);
+	if (!subm->action_tbl) {
+		ret = -EINVAL;
+		goto destroy_tbl;
+	}
+
+	subm->bwc_matcher = kzalloc(sizeof(*subm->bwc_matcher), GFP_KERNEL);
+	if (!subm->bwc_matcher) {
+		ret = -ENOMEM;
+		goto destroy_action;
+	}
+
+	/* Every matcher other than the first also matches of register C6 to
+	 * bind subrules together in the complex rule using the chain ids.
 	 */
-	match_criteria_enable |= MLX5HWS_DEFINER_MATCH_CRITERIA_MISC2;
-
-	ret = mlx5hws_bwc_matcher_create_simple(isolated_bwc_matcher,
-						isolated_tbl,
-						0,
-						match_criteria_enable,
-						mask,
-						NULL);
-	if (ret) {
-		mlx5hws_err(ctx, "Complex matcher: failed creating isolated BWC matcher\n");
+	match_criteria |= MLX5HWS_DEFINER_MATCH_CRITERIA_MISC2;
+
+	action_types[0] = MLX5HWS_ACTION_TYP_MODIFY_HDR;
+	action_types[1] = MLX5HWS_ACTION_TYP_TBL;
+	action_types[2] = MLX5HWS_ACTION_TYP_LAST;
+
+	/* Every matcher other than the last sets register C6 and jumps to the
+	 * next submatcher's table. The final submatcher will use the
+	 * user-supplied actions and will attach an action template at rule
+	 * insertion time.
+	 */
+	ret = mlx5hws_bwc_matcher_create_simple(subm->bwc_matcher, subm->tbl,
+						priority, match_criteria, mask,
+						is_last ? NULL : action_types);
+	if (ret)
 		goto free_matcher;
-	}
+
+	subm->bwc_matcher->matcher_type =
+		MLX5HWS_BWC_MATCHER_COMPLEX_SUBMATCHER;
+
+	ret = rhashtable_init(&subm->rules_hash, &hws_rules_hash_params);
+	if (ret)
+		goto destroy_matcher;
+	mutex_init(&subm->hash_lock);
+	ida_init(&subm->chain_ida);
 
 	return 0;
 
+destroy_matcher:
+	mlx5hws_bwc_matcher_destroy_simple(subm->bwc_matcher);
 free_matcher:
-	kfree(bwc_matcher->complex->isolated_bwc_matcher);
+	kfree(subm->bwc_matcher);
+destroy_action:
+	mlx5hws_action_destroy(subm->action_tbl);
+destroy_tbl:
+	mlx5hws_table_destroy(subm->tbl);
+
 	return ret;
 }
 
-static void
-hws_bwc_isolated_matcher_destroy(struct mlx5hws_bwc_matcher *bwc_matcher)
+static void hws_submatcher_destroy(struct mlx5hws_bwc_matcher *cmatcher,
+				   int idx)
 {
-	mlx5hws_bwc_matcher_destroy_simple(bwc_matcher);
-	kfree(bwc_matcher);
+	struct mlx5hws_bwc_complex_submatcher *subm;
+
+	subm = &cmatcher->complex->submatchers[idx];
+
+	ida_destroy(&subm->chain_ida);
+	mutex_destroy(&subm->hash_lock);
+	rhashtable_destroy(&subm->rules_hash);
+
+	if (subm->bwc_matcher) {
+		mlx5hws_bwc_matcher_destroy_simple(subm->bwc_matcher);
+		if (idx)
+			kfree(subm->bwc_matcher);
+	}
+
+	/* We own all of the isolated tables, but not the original one. */
+	if (idx) {
+		mlx5hws_action_destroy(subm->action_tbl);
+		mlx5hws_table_destroy(subm->tbl);
+	}
 }
 
 static int
-hws_bwc_isolated_actions_create(struct mlx5hws_bwc_matcher *bwc_matcher,
-				struct mlx5hws_table *table)
+hws_complex_data_actions_init(struct mlx5hws_bwc_matcher_complex_data *cdata)
 {
-	struct mlx5hws_table *isolated_tbl = bwc_matcher->complex->isolated_tbl;
+	struct mlx5hws_context *ctx = cdata->submatchers[0].tbl->ctx;
 	u8 modify_hdr_action[MLX5_ST_SZ_BYTES(set_action_in)] = {0};
-	struct mlx5hws_context *ctx = table->ctx;
 	struct mlx5hws_action_mh_pattern ptrn;
 	int ret = 0;
 
-	/* Create action to jump to isolated table */
-
-	bwc_matcher->complex->action_go_to_tbl =
-		mlx5hws_action_create_dest_table(ctx,
-						 isolated_tbl,
-						 MLX5HWS_ACTION_FLAG_HWS_FDB);
-	if (!bwc_matcher->complex->action_go_to_tbl) {
-		mlx5hws_err(ctx, "Complex matcher: failed to create go-to-tbl action\n");
-		return -EINVAL;
-	}
-
 	/* Create modify header action to set REG_C_6 */
-
 	MLX5_SET(set_action_in, modify_hdr_action,
 		 action_type, MLX5_MODIFICATION_TYPE_SET);
 	MLX5_SET(set_action_in, modify_hdr_action,
@@ -895,19 +553,18 @@ hws_bwc_isolated_actions_create(struct mlx5hws_bwc_matcher *bwc_matcher,
 	ptrn.data = (void *)modify_hdr_action;
 	ptrn.sz = MLX5HWS_ACTION_DOUBLE_SIZE;
 
-	bwc_matcher->complex->action_metadata =
+	cdata->action_metadata =
 		mlx5hws_action_create_modify_header(ctx, 1, &ptrn, 0,
 						    MLX5HWS_ACTION_FLAG_HWS_FDB);
-	if (!bwc_matcher->complex->action_metadata) {
-		ret = -EINVAL;
-		goto destroy_action_go_to_tbl;
+	if (!cdata->action_metadata) {
+		mlx5hws_err(ctx, "Complex matcher: failed to create set reg C6 action\n");
+		return -EINVAL;
 	}
 
 	/* Create last action */
-
-	bwc_matcher->complex->action_last =
+	cdata->action_last =
 		mlx5hws_action_create_last(ctx, MLX5HWS_ACTION_FLAG_HWS_FDB);
-	if (!bwc_matcher->complex->action_last) {
+	if (!cdata->action_last) {
 		mlx5hws_err(ctx, "Complex matcher: failed to create last action\n");
 		ret = -EINVAL;
 		goto destroy_action_metadata;
@@ -916,196 +573,130 @@ hws_bwc_isolated_actions_create(struct mlx5hws_bwc_matcher *bwc_matcher,
 	return 0;
 
 destroy_action_metadata:
-	mlx5hws_action_destroy(bwc_matcher->complex->action_metadata);
-destroy_action_go_to_tbl:
-	mlx5hws_action_destroy(bwc_matcher->complex->action_go_to_tbl);
+	mlx5hws_action_destroy(cdata->action_metadata);
+
 	return ret;
 }
 
 static void
-hws_bwc_isolated_actions_destroy(struct mlx5hws_bwc_matcher *bwc_matcher)
+hws_complex_data_actions_destroy(struct mlx5hws_bwc_matcher_complex_data *cdata)
 {
-	mlx5hws_action_destroy(bwc_matcher->complex->action_last);
-	mlx5hws_action_destroy(bwc_matcher->complex->action_metadata);
-	mlx5hws_action_destroy(bwc_matcher->complex->action_go_to_tbl);
+	mlx5hws_action_destroy(cdata->action_last);
+	mlx5hws_action_destroy(cdata->action_metadata);
 }
 
 int mlx5hws_bwc_matcher_create_complex(struct mlx5hws_bwc_matcher *bwc_matcher,
 				       struct mlx5hws_table *table,
-				       u32 priority,
-				       u8 match_criteria_enable,
+				       u32 priority, u8 match_criteria_enable,
 				       struct mlx5hws_match_parameters *mask)
 {
-	enum mlx5hws_action_type complex_init_action_types[3];
-	struct mlx5hws_bwc_matcher *isolated_bwc_matcher;
-	struct mlx5hws_match_parameters mask_1 = {0};
-	struct mlx5hws_match_parameters mask_2 = {0};
+	struct mlx5hws_match_parameters
+		submasks[MLX5HWS_BWC_COMPLEX_MAX_SUBMATCHERS] = {0};
+	struct mlx5hws_bwc_matcher_complex_data *cdata;
 	struct mlx5hws_context *ctx = table->ctx;
-	int ret;
-
-	ret = hws_bwc_matcher_complex_params_create(table->ctx,
-						    match_criteria_enable,
-						    mask, &mask_1, &mask_2);
-	if (ret)
-		goto err;
-
-	bwc_matcher->complex =
-		kzalloc(sizeof(*bwc_matcher->complex), GFP_KERNEL);
-	if (!bwc_matcher->complex) {
-		ret = -ENOMEM;
-		goto free_masks;
-	}
+	int num_submatchers;
+	int i, ret;
 
-	ret = rhashtable_init(&bwc_matcher->complex->refcount_hash,
-			      &hws_refcount_hash);
-	if (ret) {
-		mlx5hws_err(ctx, "Complex matcher: failed to initialize rhashtable\n");
-		goto free_complex;
+	for (i = 0; i < ARRAY_SIZE(submasks); i++) {
+		submasks[i].match_sz = MLX5_ST_SZ_BYTES(fte_match_param);
+		submasks[i].match_buf = kzalloc(submasks[i].match_sz,
+						GFP_KERNEL);
+		if (!submasks[i].match_buf) {
+			ret = -ENOMEM;
+			goto free_submasks;
+		}
 	}
 
-	mutex_init(&bwc_matcher->complex->hash_lock);
-	ida_init(&bwc_matcher->complex->metadata_ida);
-
-	/* Create initial action template for the first matcher.
-	 * Usually the initial AT is just dummy, but in case of complex
-	 * matcher we know exactly which actions should it have.
-	 */
-
-	complex_init_action_types[0] = MLX5HWS_ACTION_TYP_MODIFY_HDR;
-	complex_init_action_types[1] = MLX5HWS_ACTION_TYP_TBL;
-	complex_init_action_types[2] = MLX5HWS_ACTION_TYP_LAST;
-
-	/* Create the first matcher */
-
-	ret = mlx5hws_bwc_matcher_create_simple(bwc_matcher,
-						table,
-						priority,
-						match_criteria_enable,
-						&mask_1,
-						complex_init_action_types);
+	ret = hws_bwc_matcher_split_mask(ctx, match_criteria_enable, mask,
+					 submasks, &num_submatchers);
 	if (ret)
-		goto destroy_ida;
+		goto free_submasks;
 
-	/* Create isolated table to hold the second isolated matcher */
-
-	ret = hws_bwc_isolated_table_create(bwc_matcher, table);
-	if (ret) {
-		mlx5hws_err(ctx, "Complex matcher: failed creating isolated table\n");
-		goto destroy_first_matcher;
+	cdata = kzalloc(sizeof(*cdata), GFP_KERNEL);
+	if (!cdata) {
+		ret = -ENOMEM;
+		goto free_submasks;
 	}
 
-	/* Now create the second BWC matcher - the isolated one */
+	bwc_matcher->complex = cdata;
+	cdata->num_submatchers = num_submatchers;
 
-	ret = hws_bwc_isolated_matcher_create(bwc_matcher, table,
-					      match_criteria_enable, &mask_2);
-	if (ret) {
-		mlx5hws_err(ctx, "Complex matcher: failed creating isolated matcher\n");
-		goto destroy_isolated_tbl;
+	for (i = 0; i < num_submatchers; i++) {
+		ret = hws_submatcher_init(bwc_matcher, i, table, priority,
+					  match_criteria_enable, &submasks[i]);
+		if (ret)
+			goto destroy_submatchers;
 	}
 
-	/* Create action for isolated matcher's rules */
-
-	ret = hws_bwc_isolated_actions_create(bwc_matcher, table);
-	if (ret) {
-		mlx5hws_err(ctx, "Complex matcher: failed creating isolated actions\n");
-		goto destroy_isolated_matcher;
-	}
+	ret = hws_complex_data_actions_init(cdata);
+	if (ret)
+		goto destroy_submatchers;
 
-	hws_bwc_matcher_complex_params_destroy(&mask_1, &mask_2);
-	return 0;
+	ret = 0;
+	goto free_submasks;
 
-destroy_isolated_matcher:
-	isolated_bwc_matcher = bwc_matcher->complex->isolated_bwc_matcher;
-	hws_bwc_isolated_matcher_destroy(isolated_bwc_matcher);
-destroy_isolated_tbl:
-	hws_bwc_isolated_table_destroy(bwc_matcher->complex->isolated_tbl);
-destroy_first_matcher:
-	mlx5hws_bwc_matcher_destroy_simple(bwc_matcher);
-destroy_ida:
-	ida_destroy(&bwc_matcher->complex->metadata_ida);
-	mutex_destroy(&bwc_matcher->complex->hash_lock);
-	rhashtable_destroy(&bwc_matcher->complex->refcount_hash);
-free_complex:
-	kfree(bwc_matcher->complex);
+destroy_submatchers:
+	while (i--)
+		hws_submatcher_destroy(bwc_matcher, i);
+	kfree(cdata);
 	bwc_matcher->complex = NULL;
-free_masks:
-	hws_bwc_matcher_complex_params_destroy(&mask_1, &mask_2);
-err:
+
+free_submasks:
+	for (i = 0; i < ARRAY_SIZE(submasks); i++)
+		kfree(submasks[i].match_buf);
+
 	return ret;
 }
 
 void
 mlx5hws_bwc_matcher_destroy_complex(struct mlx5hws_bwc_matcher *bwc_matcher)
 {
-	struct mlx5hws_bwc_matcher *isolated_bwc_matcher =
-		bwc_matcher->complex->isolated_bwc_matcher;
-
-	hws_bwc_isolated_actions_destroy(bwc_matcher);
-	hws_bwc_isolated_matcher_destroy(isolated_bwc_matcher);
-	hws_bwc_isolated_table_destroy(bwc_matcher->complex->isolated_tbl);
-	mlx5hws_bwc_matcher_destroy_simple(bwc_matcher);
-	ida_destroy(&bwc_matcher->complex->metadata_ida);
-	mutex_destroy(&bwc_matcher->complex->hash_lock);
-	rhashtable_destroy(&bwc_matcher->complex->refcount_hash);
+	int i;
+
+	hws_complex_data_actions_destroy(bwc_matcher->complex);
+	for (i = 0; i < bwc_matcher->complex->num_submatchers; i++)
+		hws_submatcher_destroy(bwc_matcher, i);
 	kfree(bwc_matcher->complex);
 	bwc_matcher->complex = NULL;
 }
 
-static void
-hws_bwc_matcher_complex_hash_lock(struct mlx5hws_bwc_matcher *bwc_matcher)
-{
-	mutex_lock(&bwc_matcher->complex->hash_lock);
-}
-
-static void
-hws_bwc_matcher_complex_hash_unlock(struct mlx5hws_bwc_matcher *bwc_matcher)
-{
-	mutex_unlock(&bwc_matcher->complex->hash_lock);
-}
-
 static int
-hws_bwc_rule_complex_hash_node_get(struct mlx5hws_bwc_rule *bwc_rule,
-				   struct mlx5hws_match_parameters *params)
+hws_complex_get_subrule_data(struct mlx5hws_bwc_rule *bwc_rule,
+			     struct mlx5hws_bwc_complex_submatcher *subm,
+			     u32 *match_params)
+__must_hold(&subm->hash_lock)
 {
-	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
-	struct mlx5hws_bwc_complex_rule_hash_node *node, *old_node;
-	struct rhashtable *refcount_hash;
-	int ret, i;
-
-	bwc_rule->complex_hash_node = NULL;
+	struct mlx5hws_bwc_matcher *bwc_matcher = subm->bwc_matcher;
+	struct mlx5hws_bwc_complex_subrule_data *sr_data, *old_data;
+	struct mlx5hws_match_template *mt;
+	int ret;
 
-	node = kzalloc(sizeof(*node), GFP_KERNEL);
-	if (unlikely(!node))
+	sr_data = kzalloc(sizeof(*sr_data), GFP_KERNEL);
+	if (!sr_data)
 		return -ENOMEM;
 
-	ret = ida_alloc(&bwc_matcher->complex->metadata_ida, GFP_KERNEL);
+	ret = ida_alloc(&subm->chain_ida, GFP_KERNEL);
 	if (ret < 0)
-		goto err_free_node;
-	node->tag = ret;
+		goto free_sr_data;
+	sr_data->chain_id = ret;
 
-	refcount_set(&node->refcount, 1);
+	refcount_set(&sr_data->refcount, 1);
 
-	/* Clear match buffer - turn off all the unrelated fields
-	 * in accordance with the match params mask for the first
-	 * matcher out of the two parts of the complex matcher.
-	 * The resulting mask is the key for the hash.
-	 */
-	for (i = 0; i < MLX5_ST_SZ_DW_MATCH_PARAM; i++)
-		node->match_buf[i] = params->match_buf[i] &
-				     bwc_matcher->mt->match_param[i];
-
-	refcount_hash = &bwc_matcher->complex->refcount_hash;
-	old_node = rhashtable_lookup_get_insert_fast(refcount_hash,
-						     &node->hash_node,
-						     hws_refcount_hash);
-	if (IS_ERR(old_node)) {
-		ret = PTR_ERR(old_node);
-		goto err_free_ida;
+	mt  = bwc_matcher->matcher->mt;
+	mlx5hws_definer_create_tag(match_params, mt->fc, mt->fc_sz,
+				   (u8 *)&sr_data->match_tag);
+
+	old_data = rhashtable_lookup_get_insert_fast(&subm->rules_hash,
+						     &sr_data->hash_node,
+						     hws_rules_hash_params);
+	if (IS_ERR(old_data)) {
+		ret = PTR_ERR(old_data);
+		goto free_ida;
 	}
 
-	if (old_node) {
+	if (old_data) {
 		/* Rule with the same tag already exists - update refcount */
-		refcount_inc(&old_node->refcount);
+		refcount_inc(&old_data->refcount);
 		/* Let the new rule use the same tag as the existing rule.
 		 * Note that we don't have any indication for the rule creation
 		 * process that a rule with similar matching params already
@@ -1114,247 +705,283 @@ hws_bwc_rule_complex_hash_node_get(struct mlx5hws_bwc_rule *bwc_rule,
 		 * There's some performance advantage in skipping such cases,
 		 * so this is left for future optimizations.
 		 */
-		ida_free(&bwc_matcher->complex->metadata_ida, node->tag);
-		kfree(node);
-		node = old_node;
+		bwc_rule->subrule_data = old_data;
+		ret = 0;
+		goto free_ida;
 	}
 
-	bwc_rule->complex_hash_node = node;
+	bwc_rule->subrule_data = sr_data;
 	return 0;
 
-err_free_ida:
-	ida_free(&bwc_matcher->complex->metadata_ida, node->tag);
-err_free_node:
-	kfree(node);
+free_ida:
+	ida_free(&subm->chain_ida, sr_data->chain_id);
+free_sr_data:
+	kfree(sr_data);
+
 	return ret;
 }
 
 static void
-hws_bwc_rule_complex_hash_node_put(struct mlx5hws_bwc_rule *bwc_rule,
-				   bool *is_last_rule)
+hws_complex_put_subrule_data(struct mlx5hws_bwc_rule *bwc_rule,
+			     struct mlx5hws_bwc_complex_submatcher *subm,
+			     bool *is_last_rule)
+__must_hold(&subm->hash_lock)
 {
-	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
-	struct mlx5hws_bwc_complex_rule_hash_node *node;
+	struct mlx5hws_bwc_complex_subrule_data *sr_data;
 
 	if (is_last_rule)
 		*is_last_rule = false;
 
-	node = bwc_rule->complex_hash_node;
-	if (refcount_dec_and_test(&node->refcount)) {
-		rhashtable_remove_fast(&bwc_matcher->complex->refcount_hash,
-				       &node->hash_node,
-				       hws_refcount_hash);
-		ida_free(&bwc_matcher->complex->metadata_ida, node->tag);
-		kfree(node);
+	sr_data = bwc_rule->subrule_data;
+	if (refcount_dec_and_test(&sr_data->refcount)) {
+		rhashtable_remove_fast(&subm->rules_hash,
+				       &sr_data->hash_node,
+				       hws_rules_hash_params);
+		ida_free(&subm->chain_ida, sr_data->chain_id);
+		kfree(sr_data);
 		if (is_last_rule)
 			*is_last_rule = true;
 	}
 
-	bwc_rule->complex_hash_node = NULL;
+	bwc_rule->subrule_data = NULL;
 }
 
-int mlx5hws_bwc_rule_create_complex(struct mlx5hws_bwc_rule *bwc_rule,
-				    struct mlx5hws_match_parameters *params,
-				    u32 flow_source,
-				    struct mlx5hws_rule_action rule_actions[],
-				    u16 bwc_queue_idx)
+static int hws_complex_subrule_create(struct mlx5hws_bwc_matcher *cmatcher,
+				      struct mlx5hws_bwc_rule *subrule,
+				      u32 *match_params, u32 flow_source,
+				      int bwc_queue_idx, int subm_idx,
+				      struct mlx5hws_rule_action *actions,
+				      u32 *chain_id)
 {
-	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
-	struct mlx5hws_context *ctx = bwc_matcher->matcher->tbl->ctx;
+	struct mlx5hws_rule_action chain_actions[HWS_NUM_CHAIN_ACTIONS] = {0};
 	u8 modify_hdr_action[MLX5_ST_SZ_BYTES(set_action_in)] = {0};
-	struct mlx5hws_rule_action rule_actions_1[3] = {0};
-	struct mlx5hws_bwc_matcher *isolated_bwc_matcher;
-	u32 *match_buf_2;
-	u32 metadata_val;
-	int ret = 0;
+	struct mlx5hws_bwc_matcher_complex_data *cdata;
+	struct mlx5hws_bwc_complex_submatcher *subm;
+	int ret;
 
-	isolated_bwc_matcher = bwc_matcher->complex->isolated_bwc_matcher;
-	bwc_rule->isolated_bwc_rule =
-		mlx5hws_bwc_rule_alloc(isolated_bwc_matcher);
-	if (unlikely(!bwc_rule->isolated_bwc_rule))
-		return -ENOMEM;
+	cdata = cmatcher->complex;
+	subm = &cdata->submatchers[subm_idx];
 
-	hws_bwc_matcher_complex_hash_lock(bwc_matcher);
+	mutex_lock(&subm->hash_lock);
 
-	/* Get a new hash node for this complex rule.
-	 * If this is a unique set of match params for the first matcher,
-	 * we will get a new hash node with newly allocated IDA.
-	 * Otherwise we will get an existing node with IDA and updated refcount.
-	 */
-	ret = hws_bwc_rule_complex_hash_node_get(bwc_rule, params);
-	if (unlikely(ret)) {
-		mlx5hws_err(ctx, "Complex rule: failed getting RHT node for this rule\n");
-		goto free_isolated_rule;
+	ret = hws_complex_get_subrule_data(subrule, subm, match_params);
+	if (ret)
+		goto unlock;
+
+	*chain_id = subrule->subrule_data->chain_id;
+
+	if (!actions) {
+		MLX5_SET(set_action_in, modify_hdr_action, data, *chain_id);
+		chain_actions[0].action = cdata->action_metadata;
+		chain_actions[0].modify_header.data = modify_hdr_action;
+		chain_actions[1].action =
+			cdata->submatchers[subm_idx + 1].action_tbl;
+		chain_actions[2].action = cdata->action_last;
+		actions = chain_actions;
 	}
 
-	/* No need to clear match buffer's fields in accordance to what
-	 * will actually be matched on first and second matchers.
-	 * Both matchers were created with the appropriate masks
-	 * and each of them holds the appropriate field copy array,
-	 * so rule creation will use only the fields that will be copied
-	 * in accordance with setters in field copy array.
-	 * We do, however, need to temporary allocate match buffer
-	 * for the second (isolated) rule in order to not modify
-	 * user's match params buffer.
-	 */
-
-	match_buf_2 = kmemdup(params->match_buf,
-			      MLX5_ST_SZ_BYTES(fte_match_param),
-			      GFP_KERNEL);
-	if (unlikely(!match_buf_2)) {
-		mlx5hws_err(ctx, "Complex rule: failed allocating match_buf\n");
-		ret = -ENOMEM;
-		goto hash_node_put;
+	ret = mlx5hws_bwc_rule_create_simple(subrule, match_params, actions,
+					     flow_source, bwc_queue_idx);
+	if (ret) {
+		goto put_subrule_data;
+		goto unlock;
 	}
 
-	/* On 2nd matcher, use unique 32-bit ID as a matching tag */
-	metadata_val = bwc_rule->complex_hash_node->tag;
-	MLX5_SET(fte_match_param, match_buf_2,
-		 misc_parameters_2.metadata_reg_c_6, metadata_val);
-
-	/* Isolated rule's rule_actions contain all the original actions */
-	ret = mlx5hws_bwc_rule_create_simple(bwc_rule->isolated_bwc_rule,
-					     match_buf_2,
-					     rule_actions,
-					     flow_source,
-					     bwc_queue_idx);
-	kfree(match_buf_2);
-	if (unlikely(ret)) {
-		mlx5hws_err(ctx,
-			    "Complex rule: failed creating isolated BWC rule (%d)\n",
-			    ret);
-		goto hash_node_put;
-	}
+	ret = 0;
+	goto unlock;
 
-	/* First rule's rule_actions contain setting metadata and
-	 * jump to isolated table that contains the second matcher.
-	 * Set metadata value to a unique value for this rule.
-	 */
+put_subrule_data:
+	hws_complex_put_subrule_data(subrule, subm, NULL);
+unlock:
+	mutex_unlock(&subm->hash_lock);
 
-	MLX5_SET(set_action_in, modify_hdr_action,
-		 action_type, MLX5_MODIFICATION_TYPE_SET);
-	MLX5_SET(set_action_in, modify_hdr_action,
-		 field, MLX5_MODI_META_REG_C_6);
-	MLX5_SET(set_action_in, modify_hdr_action,
-		 length, 0); /* zero means length of 32 */
-	MLX5_SET(set_action_in, modify_hdr_action,
-		 offset, 0);
-	MLX5_SET(set_action_in, modify_hdr_action,
-		 data, metadata_val);
+	return ret;
+}
 
-	rule_actions_1[0].action = bwc_matcher->complex->action_metadata;
-	rule_actions_1[0].modify_header.offset = 0;
-	rule_actions_1[0].modify_header.data = modify_hdr_action;
+static int hws_complex_subrule_destroy(struct mlx5hws_bwc_rule *bwc_rule,
+				       struct mlx5hws_bwc_matcher *cmatcher,
+				       int subm_idx)
+{
+	struct mlx5hws_bwc_matcher_complex_data *cdata;
+	struct mlx5hws_bwc_complex_submatcher *subm;
+	struct mlx5hws_context *ctx;
+	bool is_last_rule;
+	int ret = 0;
 
-	rule_actions_1[1].action = bwc_matcher->complex->action_go_to_tbl;
-	rule_actions_1[2].action = bwc_matcher->complex->action_last;
+	cdata = cmatcher->complex;
+	subm = &cdata->submatchers[subm_idx];
+	ctx = subm->tbl->ctx;
 
-	ret = mlx5hws_bwc_rule_create_simple(bwc_rule,
-					     params->match_buf,
-					     rule_actions_1,
-					     flow_source,
-					     bwc_queue_idx);
+	mutex_lock(&subm->hash_lock);
 
-	if (unlikely(ret)) {
+	hws_complex_put_subrule_data(bwc_rule, subm, &is_last_rule);
+	bwc_rule->rule->skip_delete = !is_last_rule;
+	ret = mlx5hws_bwc_rule_destroy_simple(bwc_rule);
+	if (unlikely(ret))
 		mlx5hws_err(ctx,
-			    "Complex rule: failed creating first BWC rule (%d)\n",
-			    ret);
-		goto destroy_isolated_rule;
-	}
+			    "Complex rule: failed to delete subrule %d (%d)\n",
+			    subm_idx, ret);
 
-	hws_bwc_matcher_complex_hash_unlock(bwc_matcher);
+	if (subm_idx)
+		mlx5hws_bwc_rule_free(bwc_rule);
 
-	return 0;
+	mutex_unlock(&subm->hash_lock);
 
-destroy_isolated_rule:
-	mlx5hws_bwc_rule_destroy_simple(bwc_rule->isolated_bwc_rule);
-hash_node_put:
-	hws_bwc_rule_complex_hash_node_put(bwc_rule, NULL);
-free_isolated_rule:
-	hws_bwc_matcher_complex_hash_unlock(bwc_matcher);
-	mlx5hws_bwc_rule_free(bwc_rule->isolated_bwc_rule);
 	return ret;
 }
 
-int mlx5hws_bwc_rule_destroy_complex(struct mlx5hws_bwc_rule *bwc_rule)
+int mlx5hws_bwc_rule_create_complex(struct mlx5hws_bwc_rule *bwc_rule,
+				    struct mlx5hws_match_parameters *params,
+				    u32 flow_source,
+				    struct mlx5hws_rule_action rule_actions[],
+				    u16 bwc_queue_idx)
 {
-	struct mlx5hws_context *ctx = bwc_rule->bwc_matcher->matcher->tbl->ctx;
-	struct mlx5hws_bwc_rule *isolated_bwc_rule;
-	int ret_isolated, ret;
-	bool is_last_rule;
+	struct mlx5hws_bwc_rule
+		*subrules[MLX5HWS_BWC_COMPLEX_MAX_SUBMATCHERS] = {0};
+	struct mlx5hws_bwc_matcher *cmatcher = bwc_rule->bwc_matcher;
+	struct mlx5hws_bwc_matcher_complex_data *cdata;
+	struct mlx5hws_rule_action *subrule_actions;
+	struct mlx5hws_bwc_complex_submatcher *subm;
+	struct mlx5hws_bwc_rule *subrule;
+	u32 *match_params;
+	u32 chain_id;
+	int i, ret;
 
-	hws_bwc_matcher_complex_hash_lock(bwc_rule->bwc_matcher);
+	cdata = cmatcher->complex;
+	if (!cdata)
+		return -EINVAL;
 
-	hws_bwc_rule_complex_hash_node_put(bwc_rule, &is_last_rule);
-	bwc_rule->rule->skip_delete = !is_last_rule;
+	/* Duplicate user data because we will modify it to set register C6
+	 * values. For the same reason, make sure that we allocate a full
+	 * match_param even if the user gave us fewer bytes. We need to ensure
+	 * there is space for the match on C6.
+	 */
+	match_params = kzalloc(MLX5_ST_SZ_BYTES(fte_match_param), GFP_KERNEL);
+	if (!match_params)
+		return -ENOMEM;
 
-	ret = mlx5hws_bwc_rule_destroy_simple(bwc_rule);
-	if (unlikely(ret))
-		mlx5hws_err(ctx, "BWC complex rule: failed destroying first rule\n");
+	memcpy(match_params, params->match_buf, params->match_sz);
+
+	ret = hws_complex_subrule_create(cmatcher, bwc_rule, match_params,
+					 flow_source, bwc_queue_idx, 0,
+					 NULL, &chain_id);
+	if (ret)
+		goto free_match_params;
+	subrules[0] = bwc_rule;
+
+	for (i = 1; i < cdata->num_submatchers; i++) {
+		subm = &cdata->submatchers[i];
+		subrule = mlx5hws_bwc_rule_alloc(subm->bwc_matcher);
+		if (!subrule) {
+			ret = -ENOMEM;
+			goto destroy_subrules;
+		}
+
+		/* Match on the previous subrule's chain_id. This is how
+		 * subrules are connected in steering.
+		 */
+		MLX5_SET(fte_match_param, match_params,
+			 misc_parameters_2.metadata_reg_c_6, chain_id);
+
+		/* The last subrule uses the complex rule's user-specified
+		 * actions. Everything else uses the chaining rules based on the
+		 * next table and chain_id.
+		 */
+		subrule_actions =
+			i == cdata->num_submatchers - 1 ? rule_actions : NULL;
+
+		ret = hws_complex_subrule_create(cmatcher, subrule,
+						 match_params, flow_source,
+						 bwc_queue_idx, i,
+						 subrule_actions, &chain_id);
+		if (ret) {
+			mlx5hws_bwc_rule_free(subrule);
+			goto destroy_subrules;
+		}
+
+		subrules[i] = subrule;
+	}
+
+	for (i = 0; i < cdata->num_submatchers - 1; i++)
+		subrules[i]->next_subrule = subrules[i + 1];
 
-	isolated_bwc_rule = bwc_rule->isolated_bwc_rule;
-	ret_isolated = mlx5hws_bwc_rule_destroy_simple(isolated_bwc_rule);
-	if (unlikely(ret_isolated))
-		mlx5hws_err(ctx, "BWC complex rule: failed destroying second (isolated) rule\n");
+	kfree(match_params);
 
-	hws_bwc_matcher_complex_hash_unlock(bwc_rule->bwc_matcher);
+	return 0;
 
-	mlx5hws_bwc_rule_free(isolated_bwc_rule);
+destroy_subrules:
+	while (i--)
+		hws_complex_subrule_destroy(subrules[i], cmatcher, i);
+free_match_params:
+	kfree(match_params);
 
-	return ret || ret_isolated;
+	return ret;
 }
 
-static void
-hws_bwc_matcher_clear_hash_rtcs(struct mlx5hws_bwc_matcher *bwc_matcher)
+int mlx5hws_bwc_rule_destroy_complex(struct mlx5hws_bwc_rule *bwc_rule)
 {
-	struct mlx5hws_bwc_complex_rule_hash_node *node;
-	struct rhashtable_iter iter;
+	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
+	struct mlx5hws_bwc_rule
+		*subrules[MLX5HWS_BWC_COMPLEX_MAX_SUBMATCHERS] = {0};
+	struct mlx5hws_bwc_matcher_complex_data *cdata;
+	int i, err, ret_val;
+
+	cdata = bwc_matcher->complex;
+
+	/* Construct a list of all the subrules we need to destroy. */
+	subrules[0] = bwc_rule;
+	for (i = 1; i < cdata->num_submatchers; i++)
+		subrules[i] = subrules[i - 1]->next_subrule;
+
+	ret_val = 0;
+	for (i = 0; i < cdata->num_submatchers; i++) {
+		err = hws_complex_subrule_destroy(subrules[i], bwc_matcher, i);
+		/* If something goes wrong, plow along to destroy all of the
+		 * subrules but return an error upstack.
+		 */
+		if (unlikely(err))
+			ret_val = err;
+	}
 
-	rhashtable_walk_enter(&bwc_matcher->complex->refcount_hash, &iter);
-	rhashtable_walk_start(&iter);
+	return ret_val;
+}
 
-	while ((node = rhashtable_walk_next(&iter)) != NULL) {
-		if (IS_ERR(node))
+static void
+hws_bwc_matcher_init_move(struct mlx5hws_bwc_matcher *bwc_matcher)
+{
+	struct mlx5hws_context *ctx = bwc_matcher->matcher->tbl->ctx;
+	u16 bwc_queues = mlx5hws_bwc_queues(ctx);
+	struct mlx5hws_bwc_rule *bwc_rule;
+	struct list_head *rules_list;
+	int i;
+
+	for (i = 0; i < bwc_queues; i++) {
+		rules_list = &bwc_matcher->rules[i];
+		if (list_empty(rules_list))
 			continue;
-		node->rtc_valid = false;
-	}
 
-	rhashtable_walk_stop(&iter);
-	rhashtable_walk_exit(&iter);
+		list_for_each_entry(bwc_rule, rules_list, list_node) {
+			if (!bwc_rule->subrule_data)
+				continue;
+			bwc_rule->subrule_data->was_moved = false;
+		}
+	}
 }
 
-int
-mlx5hws_bwc_matcher_move_all_complex(struct mlx5hws_bwc_matcher *bwc_matcher)
+int mlx5hws_bwc_matcher_complex_move(struct mlx5hws_bwc_matcher *bwc_matcher)
 {
 	struct mlx5hws_context *ctx = bwc_matcher->matcher->tbl->ctx;
 	struct mlx5hws_matcher *matcher = bwc_matcher->matcher;
 	u16 bwc_queues = mlx5hws_bwc_queues(ctx);
 	struct mlx5hws_bwc_rule *tmp_bwc_rule;
 	struct mlx5hws_rule_attr rule_attr;
-	struct mlx5hws_table *isolated_tbl;
 	int move_error = 0, poll_error = 0;
 	struct mlx5hws_rule *tmp_rule;
 	struct list_head *rules_list;
 	u32 expected_completions = 1;
-	u32 end_ft_id;
-	int i, ret;
+	int i, ret = 0;
 
-	/* We are rehashing the matcher that is the first part of the complex
-	 * matcher. Need to update the isolated matcher to point to the end_ft
-	 * of this new matcher. This needs to be done before moving any rules
-	 * to prevent possible steering loops.
-	 */
-	isolated_tbl = bwc_matcher->complex->isolated_tbl;
-	end_ft_id = bwc_matcher->matcher->resize_dst->end_ft_id;
-	ret = mlx5hws_matcher_update_end_ft_isolated(isolated_tbl, end_ft_id);
-	if (ret) {
-		mlx5hws_err(ctx,
-			    "Failed updating end_ft of isolated matcher (%d)\n",
-			    ret);
-		return ret;
-	}
-
-	hws_bwc_matcher_clear_hash_rtcs(bwc_matcher);
+	hws_bwc_matcher_init_move(bwc_matcher);
 
 	mlx5hws_bwc_rule_fill_attr(bwc_matcher, 0, 0, &rule_attr);
 
@@ -1369,15 +996,15 @@ mlx5hws_bwc_matcher_move_all_complex(struct mlx5hws_bwc_matcher *bwc_matcher)
 			/* Check if a rule with similar tag has already
 			 * been moved.
 			 */
-			if (tmp_bwc_rule->complex_hash_node->rtc_valid) {
-				/* This rule is a duplicate of rule with similar
-				 * tag that has already been moved earlier.
-				 * Just update this rule's RTCs.
+			if (tmp_bwc_rule->subrule_data->was_moved) {
+				/* This rule is a duplicate of rule with
+				 * identical tag that has already been moved
+				 * earlier. Just update this rule's RTCs.
 				 */
 				tmp_bwc_rule->rule->rtc_0 =
-					tmp_bwc_rule->complex_hash_node->rtc_0;
+					tmp_bwc_rule->subrule_data->rtc_0;
 				tmp_bwc_rule->rule->rtc_1 =
-					tmp_bwc_rule->complex_hash_node->rtc_1;
+					tmp_bwc_rule->subrule_data->rtc_1;
 				tmp_bwc_rule->rule->matcher =
 					tmp_bwc_rule->rule->matcher->resize_dst;
 				continue;
@@ -1425,12 +1052,12 @@ mlx5hws_bwc_matcher_move_all_complex(struct mlx5hws_bwc_matcher *bwc_matcher)
 			/* Done moving the rule to the new matcher,
 			 * now update RTCs for all the duplicated rules.
 			 */
-			tmp_bwc_rule->complex_hash_node->rtc_0 =
+			tmp_bwc_rule->subrule_data->rtc_0 =
 				tmp_bwc_rule->rule->rtc_0;
-			tmp_bwc_rule->complex_hash_node->rtc_1 =
+			tmp_bwc_rule->subrule_data->rtc_1 =
 				tmp_bwc_rule->rule->rtc_1;
 
-			tmp_bwc_rule->complex_hash_node->rtc_valid = true;
+			tmp_bwc_rule->subrule_data->was_moved = true;
 		}
 	}
 
@@ -1442,3 +1069,35 @@ mlx5hws_bwc_matcher_move_all_complex(struct mlx5hws_bwc_matcher *bwc_matcher)
 
 	return ret;
 }
+
+int
+mlx5hws_bwc_matcher_complex_move_first(struct mlx5hws_bwc_matcher *bwc_matcher)
+{
+	struct mlx5hws_context *ctx = bwc_matcher->matcher->tbl->ctx;
+	struct mlx5hws_bwc_matcher_complex_data *cdata;
+	struct mlx5hws_table *isolated_tbl;
+	u32 end_ft_id;
+	int i, ret;
+
+	cdata = bwc_matcher->complex;
+
+	/* We are rehashing the first submatcher. We need to update the
+	 * subsequent submatchers to point to the end_ft of this new matcher.
+	 * This needs to be done before moving any rules to prevent possible
+	 * steering loops.
+	 */
+	end_ft_id = bwc_matcher->matcher->resize_dst->end_ft_id;
+	for (i = 1; i < cdata->num_submatchers; i++) {
+		isolated_tbl = cdata->submatchers[i].tbl;
+		ret = mlx5hws_matcher_update_end_ft_isolated(isolated_tbl,
+							     end_ft_id);
+		if (ret) {
+			mlx5hws_err(ctx,
+				    "Complex matcher: failed updating end_ft of isolated matcher (%d)\n",
+				    ret);
+			return ret;
+		}
+	}
+
+	return mlx5hws_bwc_matcher_complex_move(bwc_matcher);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.h
index a6887c7e39d5..d07de631ce9f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.h
@@ -4,25 +4,60 @@
 #ifndef HWS_BWC_COMPLEX_H_
 #define HWS_BWC_COMPLEX_H_
 
-struct mlx5hws_bwc_complex_rule_hash_node {
-	u32 match_buf[MLX5_ST_SZ_DW_MATCH_PARAM];
-	u32 tag;
+#define MLX5HWS_BWC_COMPLEX_MAX_SUBMATCHERS 4
+
+/* A matcher can't contain two rules with the same match tag, but it is possible
+ * that two different complex rules' subrules have the same match tag. In that
+ * case, those subrules correspond to a single rule, and we need to refcount.
+ */
+struct mlx5hws_bwc_complex_subrule_data {
+	struct mlx5hws_rule_match_tag match_tag;
 	refcount_t refcount;
-	bool rtc_valid;
+	/* The chain_id is what glues individual subrules into larger complex
+	 * rules. It is the value that this subrule writes to register C6, and
+	 * that the next subrule matches against.
+	 */
+	u32 chain_id;
 	u32 rtc_0;
 	u32 rtc_1;
+	/* During rehash we iterate through all the subrules to move them. But
+	 * two or more subrules can share the same physical rule in the
+	 * submatcher, so we use `was_moved` to keep track if a given rule was
+	 * already moved.
+	 */
+	bool was_moved;
 	struct rhash_head hash_node;
 };
 
+struct mlx5hws_bwc_complex_submatcher {
+	/* Isolated table that the matcher lives in. Not set for the first
+	 * matcher, which lives in the original table.
+	 */
+	struct mlx5hws_table *tbl;
+	/* Match a rule with this action to go to `tbl`. This is set in all
+	 * submatchers but the first.
+	 */
+	struct mlx5hws_action *action_tbl;
+	/* This submatcher's simple matcher. The first submatcher points to the
+	 * outer (complex) matcher.
+	 */
+	struct mlx5hws_bwc_matcher *bwc_matcher;
+	struct rhashtable rules_hash;
+	struct ida chain_ida;
+	struct mutex hash_lock; /* Protect the hash and ida. */
+};
+
 struct mlx5hws_bwc_matcher_complex_data {
-	struct mlx5hws_table *isolated_tbl;
-	struct mlx5hws_bwc_matcher *isolated_bwc_matcher;
+	struct mlx5hws_bwc_complex_submatcher
+		submatchers[MLX5HWS_BWC_COMPLEX_MAX_SUBMATCHERS];
+	int num_submatchers;
+	/* Actions used by all but the last submatcher to point to the next
+	 * submatcher in the chain. The last submatcher uses the action template
+	 * from the complex matcher, to perform the actions that the user
+	 * originally requested.
+	 */
 	struct mlx5hws_action *action_metadata;
-	struct mlx5hws_action *action_go_to_tbl;
 	struct mlx5hws_action *action_last;
-	struct rhashtable refcount_hash;
-	struct mutex hash_lock; /* Protect the refcount rhashtable */
-	struct ida metadata_ida;
 };
 
 bool mlx5hws_bwc_match_params_is_complex(struct mlx5hws_context *ctx,
@@ -37,7 +72,10 @@ int mlx5hws_bwc_matcher_create_complex(struct mlx5hws_bwc_matcher *bwc_matcher,
 
 void mlx5hws_bwc_matcher_destroy_complex(struct mlx5hws_bwc_matcher *bwc_matcher);
 
-int mlx5hws_bwc_matcher_move_all_complex(struct mlx5hws_bwc_matcher *bwc_matcher);
+int mlx5hws_bwc_matcher_complex_move(struct mlx5hws_bwc_matcher *bwc_matcher);
+
+int
+mlx5hws_bwc_matcher_complex_move_first(struct mlx5hws_bwc_matcher *bwc_matcher);
 
 int mlx5hws_bwc_rule_create_complex(struct mlx5hws_bwc_rule *bwc_rule,
 				    struct mlx5hws_match_parameters *params,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
index c4bb6967f74d..82fd122d4284 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
@@ -1831,80 +1831,6 @@ hws_definer_conv_match_params_to_hl(struct mlx5hws_context *ctx,
 	return ret;
 }
 
-struct mlx5hws_definer_fc *
-mlx5hws_definer_conv_match_params_to_compressed_fc(struct mlx5hws_context *ctx,
-						   u8 match_criteria_enable,
-						   u32 *match_param,
-						   int *fc_sz)
-{
-	struct mlx5hws_definer_fc *compressed_fc = NULL;
-	struct mlx5hws_definer_conv_data cd = {0};
-	struct mlx5hws_definer_fc *fc;
-	int ret;
-
-	fc = hws_definer_alloc_fc(ctx, MLX5HWS_DEFINER_FNAME_MAX);
-	if (!fc)
-		return NULL;
-
-	cd.fc = fc;
-	cd.ctx = ctx;
-
-	if (match_criteria_enable & MLX5HWS_DEFINER_MATCH_CRITERIA_OUTER) {
-		ret = hws_definer_conv_outer(&cd, match_param);
-		if (ret)
-			goto err_free_fc;
-	}
-
-	if (match_criteria_enable & MLX5HWS_DEFINER_MATCH_CRITERIA_INNER) {
-		ret = hws_definer_conv_inner(&cd, match_param);
-		if (ret)
-			goto err_free_fc;
-	}
-
-	if (match_criteria_enable & MLX5HWS_DEFINER_MATCH_CRITERIA_MISC) {
-		ret = hws_definer_conv_misc(&cd, match_param);
-		if (ret)
-			goto err_free_fc;
-	}
-
-	if (match_criteria_enable & MLX5HWS_DEFINER_MATCH_CRITERIA_MISC2) {
-		ret = hws_definer_conv_misc2(&cd, match_param);
-		if (ret)
-			goto err_free_fc;
-	}
-
-	if (match_criteria_enable & MLX5HWS_DEFINER_MATCH_CRITERIA_MISC3) {
-		ret = hws_definer_conv_misc3(&cd, match_param);
-		if (ret)
-			goto err_free_fc;
-	}
-
-	if (match_criteria_enable & MLX5HWS_DEFINER_MATCH_CRITERIA_MISC4) {
-		ret = hws_definer_conv_misc4(&cd, match_param);
-		if (ret)
-			goto err_free_fc;
-	}
-
-	if (match_criteria_enable & MLX5HWS_DEFINER_MATCH_CRITERIA_MISC5) {
-		ret = hws_definer_conv_misc5(&cd, match_param);
-		if (ret)
-			goto err_free_fc;
-	}
-
-	/* Allocate fc array on mt */
-	compressed_fc = hws_definer_alloc_compressed_fc(fc);
-	if (!compressed_fc) {
-		mlx5hws_err(ctx,
-			    "Convert to compressed fc: failed to set field copy to match template\n");
-		goto err_free_fc;
-	}
-	*fc_sz = hws_definer_get_fc_size(fc);
-
-err_free_fc:
-	kfree(fc);
-	return compressed_fc;
-}
-
 static int
 hws_definer_find_byte_in_tag(struct mlx5hws_definer *definer,
 			     u32 hl_byte_off,
@@ -2067,7 +1993,7 @@ hws_definer_copy_sel_ctrl(struct mlx5hws_definer_sel_ctrl *ctrl,
 static int
 hws_definer_find_best_match_fit(struct mlx5hws_context *ctx,
 				struct mlx5hws_definer *definer,
-				u8 *hl)
+				u8 *hl, bool allow_jumbo)
 {
 	struct mlx5hws_definer_sel_ctrl ctrl = {0};
 	bool found;
@@ -2084,6 +2010,9 @@ hws_definer_find_best_match_fit(struct mlx5hws_context *ctx,
 		return 0;
 	}
 
+	if (!allow_jumbo)
+		return -E2BIG;
+
 	/* Try to create a full/limited jumbo definer */
 	ctrl.allowed_full_dw = ctx->caps->full_dw_jumbo_support ? DW_SELECTORS :
 								  DW_SELECTORS_MATCH;
@@ -2160,7 +2089,8 @@ int mlx5hws_definer_compare(struct mlx5hws_definer *definer_a,
 int
 mlx5hws_definer_calc_layout(struct mlx5hws_context *ctx,
 			    struct mlx5hws_match_template *mt,
-			    struct mlx5hws_definer *match_definer)
+			    struct mlx5hws_definer *match_definer,
+			    bool allow_jumbo)
 {
 	u8 *match_hl;
 	int ret;
@@ -2182,7 +2112,8 @@ mlx5hws_definer_calc_layout(struct mlx5hws_context *ctx,
 	}
 
 	/* Find the match definer layout for header layout match union */
-	ret = hws_definer_find_best_match_fit(ctx, match_definer, match_hl);
+	ret = hws_definer_find_best_match_fit(ctx, match_definer, match_hl,
+					      allow_jumbo);
 	if (ret) {
 		if (ret == -E2BIG)
 			mlx5hws_dbg(ctx,
@@ -2370,7 +2301,7 @@ int mlx5hws_definer_mt_init(struct mlx5hws_context *ctx,
 	struct mlx5hws_definer match_layout = {0};
 	int ret;
 
-	ret = mlx5hws_definer_calc_layout(ctx, mt, &match_layout);
+	ret = mlx5hws_definer_calc_layout(ctx, mt, &match_layout, true);
 	if (ret) {
 		mlx5hws_err(ctx, "Failed to calculate matcher definer layout\n");
 		return ret;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.h
index 62da55389331..141f3eb2e307 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.h
@@ -823,13 +823,8 @@ void mlx5hws_definer_free(struct mlx5hws_context *ctx,
 
 int mlx5hws_definer_calc_layout(struct mlx5hws_context *ctx,
 				struct mlx5hws_match_template *mt,
-				struct mlx5hws_definer *match_definer);
-
-struct mlx5hws_definer_fc *
-mlx5hws_definer_conv_match_params_to_compressed_fc(struct mlx5hws_context *ctx,
-						   u8 match_criteria_enable,
-						   u32 *match_param,
-						   int *fc_sz);
+				struct mlx5hws_definer *match_definer,
+				bool allow_jumbo);
 
 const char *mlx5hws_definer_fname_to_str(enum mlx5hws_definer_fname fname);
 
-- 
2.31.1


