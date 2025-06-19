Return-Path: <linux-rdma+bounces-11457-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257A3AE0470
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 13:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78FCD7A9EF6
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 11:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEAC23C4FF;
	Thu, 19 Jun 2025 11:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Td2xmXcA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F23723B628;
	Thu, 19 Jun 2025 11:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750334147; cv=fail; b=FblbxI116aglHHvXCu1CjEdNteqjQDS9gaKAoKRYa60gBqMw/6n7+uwi841fIZ+lnurWpZ2+ZnC7q8TdSMTa0CXMGHczjqoSotMexDHm/JZ+I8t6QVa1jN6TZ4yARwIeAd/lpH9ny0Tm1Q8jQpiQfdoq31PZbMwWI2DfaB0Yqbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750334147; c=relaxed/simple;
	bh=o7Y7spP00k8mf3YNz28dsXKvbhEvZChAJ9PDCpNKJ7g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=liw6tSknJn/nfHfXLg/glPHGy+byYkHM5eDhkQ9ewB2lwSe4n/e3kFta1m2okhGAIxOLz2g/ikHnHOxYJoO/PTnTt2WdNWgCYQE2W89uDfwNFm7yxq9Oa8QyPL7pnvc+3hHTgHEBG4a1vRV9MIefDNIFOEWlOaDhblCF+203tvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Td2xmXcA; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DksYeIy/8H5ydb+qzQ8ty5UgeeDLBZw3YwE1zvB3xbDJ2Fd/9jddqqXUfVUmSd8hkLrxgqJ1CouM30VfLg1Zci+CdGszx+FBO9m0sm1EnBG/ZRuSW8HcX6SXqfOiSqgG5NCy6CZL4lssJE40/5okvkbuVzjsgxsTPyxyqYzjvUet5PsYGdkPNwIW3ygSX9WW+6h247Lg64daVtEn82fY/zGUaMBjnlRIJN8ykkpyNqaNBkdpe6Xh7hzjDGU9035ryX4mX0gm7AIdTYf4sC/2hbTnkBmN44BlzmmhUjLMlxil6p2CLgPrfROZcNq5ZuO6b6S4x0rK2+ip7oUUbUSC0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IN2gHI60crUvovSObiD5nbWNFXK9Y6+IOmJtadNw4Gw=;
 b=KGK4WlBEhe3VpiNAKvYnky1H6XF3FCeCVRuWpAQRoJVVOxxdIztXx/59uPNEkciDXyW/LfR5tqE1vt29nM9G1M0mva651M18D/Pih2mguU5hPBUdDHO7yg6HGa2parISM2WhXQI6winsGIx/zgRIxjD6pOcMgRzCZKr9xiDNRd4yRjJHDiiDucwwO26DaDNII/6ME8S36Id/rhc81u/5Ka6vwP1w2Annl52r3ag4VexAdw4qCGSpeXYIadTiVp3Uhm6Tz8uerCd2OAVa/l3A4XNyfQA2utadnvOXz/z00sB7QC5/ihA8FCHqgR2alLPHnK9/xn9ezaNKCehDJyZK4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IN2gHI60crUvovSObiD5nbWNFXK9Y6+IOmJtadNw4Gw=;
 b=Td2xmXcAkeV1HRyhWuZ0euMuW03r6qXMJJ17G1fycVW8btKsfrcc3U069wSjFvAxBn3VIy6exiKc2Dc4nGw4Gtn7E4gJ0y0T7A6sTh1ZUApEpJRra5YNJHPQk+an0FFAA6ioqx/wb45YzTeGI9uszzZQmhYm9nLjtLM5RTpxY1cTYFkKhsp2Lj0175Isy00GSkLQgcAxPIAmUEH3uKNamDN35S0OLlr+ISoFvpKNW1xeiLpyW36sDblQrHOtJCuDBeIn+BisILP4DgpFBTl9v0gGs49e7nN3B3NbE0Du4WV/SM4W4p6/bN4fLUu7uIkApqk+0Fs9O0L9lC6iawPZXQ==
Received: from BYAPR07CA0001.namprd07.prod.outlook.com (2603:10b6:a02:bc::14)
 by BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Thu, 19 Jun
 2025 11:55:41 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a02:bc:cafe::58) by BYAPR07CA0001.outlook.office365.com
 (2603:10b6:a02:bc::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.29 via Frontend Transport; Thu,
 19 Jun 2025 11:55:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21 via Frontend Transport; Thu, 19 Jun 2025 11:55:41 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Jun
 2025 04:55:37 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 19 Jun 2025 04:55:36 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 19 Jun 2025 04:55:32 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Yevgeny
 Kliteynik" <kliteyn@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net-next 2/8] net/mlx5: HWS, remove incorrect comment
Date: Thu, 19 Jun 2025 14:55:16 +0300
Message-ID: <20250619115522.68469-3-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250619115522.68469-1-mbloch@nvidia.com>
References: <20250619115522.68469-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|BL3PR12MB6571:EE_
X-MS-Office365-Filtering-Correlation-Id: 72bccca3-8145-47eb-51d7-08ddaf283716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|30052699003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6racs5nZZn1zyOg5HYxDAU3xXwjcSSmOLsIzuAyL6IfXAbjdEQMsVpap7rdL?=
 =?us-ascii?Q?UwM8sPBpvSiNI3f4168DZb9MCuBjp+7byTNhIH0I4R5WqNcBvrs1JlmPSXNW?=
 =?us-ascii?Q?sr/g4/bvVrAm1KLLQWn4VRhcncDFZwTPI8cQBcBvEGjZRbtjOlOe8K5mohDU?=
 =?us-ascii?Q?V0WTJ7WAZZzxVa7W32S1Em5J6gcdYuy2EAOWGtsxlJsYbEZAVn1WKAbaSOW+?=
 =?us-ascii?Q?6UHVXR78b+NI5fFuUeRwA8T6JSD+y4qGbrGOKvAB2srEXhqiR8JuOo8QP2oJ?=
 =?us-ascii?Q?FoXIjvZuA5k7a7vNyg2m0Z4cEQLPDlw8WiGDyV+VGEUN4GFY+gwTmB8jEK4W?=
 =?us-ascii?Q?3Ff8M6Ug+73nleBTzxg2v7jTpJ+E4A6mCkbN7zedjPghdHtT2u9XabsE9iEH?=
 =?us-ascii?Q?HlcXa2Eup8/Bea8TnU8SI/+deJAZ1IAqyUl6BALWQl7UR3e4DR7cc+fC2rNv?=
 =?us-ascii?Q?HMM5lp+NSfWgvfqvKokDk0bQVrBnovTVuNGTyUhX0BCycHcuj0Lc0nJXtbBZ?=
 =?us-ascii?Q?LpGCh14PxSyOdpfX9spvar32kfkXG8JznaJf6yJA+SlkRJBzwwC/p0hRMZJc?=
 =?us-ascii?Q?WvWoXPhIp2L1ongadDdV3C/XL58nTbQQmiai+Ofyj84WVFamA8t23JQ2ESBp?=
 =?us-ascii?Q?Vqt+uHJwE2KmJB0w4XLkFU/8tQcXWWQSfr75h9qqr15LRp3FQNjlvhCMyY7L?=
 =?us-ascii?Q?KAQM0C2SkQGutaFVv7YOZ1FFQprEtDw/vuJzKyzyj+chzJxIFfg/tZwNibCy?=
 =?us-ascii?Q?3xwvqGMno94UteHjSckJK/MmWhw4sLEDinHP6wqKkxACCHu9vmmfFnmimqjp?=
 =?us-ascii?Q?ahur92yjfv5gkZkVwMJ+jbrcl5WayFinVo1wh58cT21EcFu20J8/ajdQYtgI?=
 =?us-ascii?Q?UFsFWohvm4rspOkL2HWI5G4AXLXpMbXFfe6RBGeWQLhAQDQUPyc6uqrXa6Am?=
 =?us-ascii?Q?bN0LGGPPrJ1TenoZfORgD7liXwwB55rc481VmRZi2wNrHftNZw8CmdeeDD5C?=
 =?us-ascii?Q?Wv6pXNeX9HmR/KYewUu+0ll9804jDZcfLn26JxwCkj45eJU25tDiAz52dq0H?=
 =?us-ascii?Q?o75y0q9UAxcE5RqQ2g3XzomKQGx5Wrjtm6nCGbJ2HjtzWXW/86atbmFoh4dn?=
 =?us-ascii?Q?tNyG2TdymKczXdgFTyuST9vAnFpf7jOKW/WfacEpc/qPS3cmh+FbFvjOKfHN?=
 =?us-ascii?Q?9YZC98CJhdSuNlOrgJb3IBSl/fuKX7x/U/YLx3KfzlwnEqap9bQk+lddW08t?=
 =?us-ascii?Q?gn7KXDm6EIR4NasIRzY/aa0HV4tAmWi607wJqYzoPJzhXAyScYwErZcZnOeF?=
 =?us-ascii?Q?WCK8PdsQU1DPRiPlvzZRe5Gmejf4NTtfSC4a548unkgIXT+J03IQ8JHpZuC4?=
 =?us-ascii?Q?P3JTYSwyPQWSdFeqNS1RafVqQnp9GS6H79hrFFvlri6PMbYDQSQbEVLC3pQt?=
 =?us-ascii?Q?Tmjo1/o+yBYoTIrA5iFXBbJKjqpzbvG8RtoOqoHxVoxKNhU7n0pTdi2jWxa4?=
 =?us-ascii?Q?tC6M4JHynUokBoJycgU4Tn+cLta4V6iNFbtJ?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(30052699003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 11:55:41.3978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72bccca3-8145-47eb-51d7-08ddaf283716
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6571

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Removing incorrect comment section that is probably some
copy-paste artifact.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Vlad Dogaru <vdogaru@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
index 9e057f808ea5..665e6e285db5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
@@ -876,8 +876,6 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 
 	/* At this point the rule wasn't added.
 	 * It could be because there was collision, or some other problem.
-	 * If we don't dive deeper than API, the only thing we know is that
-	 * the status of completion is RTE_FLOW_OP_ERROR.
 	 * Try rehash by size and insert rule again - last chance.
 	 */
 
-- 
2.34.1


