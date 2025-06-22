Return-Path: <linux-rdma+bounces-11520-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DD4AE3100
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Jun 2025 19:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1293A7A4684
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Jun 2025 17:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5601F8BA6;
	Sun, 22 Jun 2025 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mRpxuoWl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E9B1F8ACA;
	Sun, 22 Jun 2025 17:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750612978; cv=fail; b=PTLZxDubd1MBJGffSUhFXsM6+X62LXwq9xzDxzB7SYNSb1yzLDjQxQs4pVF6lzY5o7uaJv2jDl+cgbPUgm1EA5vacH80QuG5m4zLIZ4+iRK1wRNIwOjMDV9XdrW4Xt59oW6bz3MhFCozjhnEvQtfEw+aOwyo1g2F23BHrwanwdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750612978; c=relaxed/simple;
	bh=o7Y7spP00k8mf3YNz28dsXKvbhEvZChAJ9PDCpNKJ7g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FeOjovMOvvRNgH+CGoQuU9o99LFUhzDJxFm6qf0emWXuWWARW57rs0UaJriY+lu583Lzs29r6yd3k2tuEAq7lhcV1kXbFw++t8ZtHUfUQ0OdDzQnqlbOiy+yKRSrJLZsvRXj5vinMocdokXZtA+560MJFPOE3nj0/U7xG5vjdjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mRpxuoWl; arc=fail smtp.client-ip=40.107.95.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmPxygH4uLUQ5ZMqbbsXyEJRBapPbJoGYEizgTiAgbw6nv7YT1zwRy5LZAE8n+w+HZYTKosE3YZdyhEBYyX4bLi9gZfkqdJeOfbScKh3vxHjx2gvtcF+Zl1vFyx4eQwVBsJrC9W7bdWntHiz9tW48An/NHGDxgfsAT5P5196/g5A5640MllxyPGpNupuLKy/YGb2fR7KTDqFoQ7U9iRR2/MgVrWvpzYpVXWboZo8U23poks5wtS4RRvfa91u31EH+lAAVCvtluuZ5SXR+JG74jFZ0zuIAo8hV2S63OVmgGJSQOmCSfMOYhfwo2h63V5RybTcY4s1Sj3ES7mVYmMjBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IN2gHI60crUvovSObiD5nbWNFXK9Y6+IOmJtadNw4Gw=;
 b=xVtKiDgi5hpI2XWclt6pG0Np6fwCrCQMRaO0CMVDYwkOl1Gtwqe71zWgaZfoAYmbsdsQFKndduClXPHZZ4dmUcWOkLY57m7e5UouUQYAbBtNCo3ZmTR2b6t7Z8u74Qq74B4go7d+8dgSTK0W/R96V1NM+/7HCz2/MXDp+cIZ+eqHUdIeMib3T4rOdyESPQI3XV2r7rhXnAxXq3kc6GPZ/UX3s98teq8eODSWRx9MeBaXivUxvllI6s/DMAkHiNqumLKr6pWzUs6pN7FuDz0uHaKtWe0oCcUVUv53Rgsm6tBTUrKUTJv3FPAgrfAj2pUcUH+FtNPXnuC0pSvKidu1XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IN2gHI60crUvovSObiD5nbWNFXK9Y6+IOmJtadNw4Gw=;
 b=mRpxuoWldJI+jhbS0Lv31mH2UJDvIvUEyUWR/h+OxOELAcYM5CQrsoy6uqPqu4Bq0UCaIbvFMqwhsKr36gTUkeJbAcd+mjfp8eZQLH1gpi71E+VYdk6rh/JaHHXnPeRXJmQ13MMvaxRgH/eR3uSehQnWXTXFOPoLlHMCtmHMGZnz8nKlllckmVkSo4SrO3ohTXgzX1j+6pkhPe+5n4h9mfHUQNApO10CESRli+7FxOofaGUUT9QQ/rNLY3DuVYqojkJlncM810jY2dUKAoBjOeq50iILisqRyQE7ux9epWBu9jNk51d0CRgu2NmNqhDAL8+qRcCngPdRGMx1U5TUXg==
Received: from BL0PR01CA0013.prod.exchangelabs.com (2603:10b6:208:71::26) by
 DM4PR12MB6639.namprd12.prod.outlook.com (2603:10b6:8:be::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.28; Sun, 22 Jun 2025 17:22:53 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:208:71:cafe::84) by BL0PR01CA0013.outlook.office365.com
 (2603:10b6:208:71::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.28 via Frontend Transport; Sun,
 22 Jun 2025 17:22:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Sun, 22 Jun 2025 17:22:52 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 22 Jun
 2025 10:22:48 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 22 Jun 2025 10:22:47 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 22 Jun 2025 10:22:44 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net-next v2 2/8] net/mlx5: HWS, remove incorrect comment
Date: Sun, 22 Jun 2025 20:22:20 +0300
Message-ID: <20250622172226.4174-3-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250622172226.4174-1-mbloch@nvidia.com>
References: <20250622172226.4174-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|DM4PR12MB6639:EE_
X-MS-Office365-Filtering-Correlation-Id: a6442690-0acb-49a1-687d-08ddb1b16bb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|30052699003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6cEAZid6G1ChRwaUkMliteF6yBStnc1IH+LwMOgPHUapTTsyNhX+r8vyO7yL?=
 =?us-ascii?Q?EIuvBLiTYyZwdddRLYKSgur8j4AjsxM/djEUUPNJuwHOpV5KOZ3fvgIOVesu?=
 =?us-ascii?Q?JNFMvtHZBygHYmumXjj+M3MBBC0YI2pfuSkix6MW6P01lo5AkCOolUFtqtsJ?=
 =?us-ascii?Q?S6VpCi58x6X3OqbANqtqKxL6JLQlkeNcidK89bd5knjMk+NL3kejTiDfrJOJ?=
 =?us-ascii?Q?t0bdo9WvPFFIOjYkOKWIL2xbirSmxc69Nxybifke28Ze1hx2QA1aMVxRB1iy?=
 =?us-ascii?Q?aN6IB7qmO4V0pld7e3esJp/qd1IPJmYxDjeSs3Ep2pNOMOCDBmHHmPsodxVf?=
 =?us-ascii?Q?6TgVeA+W2zgfBpyBsByen4xGxTYcoN6f3Bd/warBCwWtMbQ5KiIFs457YG+l?=
 =?us-ascii?Q?/NUk6rkHUkHt2dNcBuazDJZoNKsFzb3sAcdCgmSbnrNtnWqU0KPMc7wjcpQ9?=
 =?us-ascii?Q?DcDf338NThpfwDX/3M0WbpD3ubFAkb8UPHu/eLTL5/HKYdv7eBTrqBKaqKd2?=
 =?us-ascii?Q?JfzeHrWWKo3lRs0SoIgRpuoh+Fpr3QIot6GlLvJ+NYtvAqLdhBEV/tZrS/2y?=
 =?us-ascii?Q?buo1dopSySolbE9lShLrkaF4TsH6nscqa5WbZE/yPTcNg55mZgUTFshzNePo?=
 =?us-ascii?Q?o62EeC2k6W7S8prRO1KaBdzqgDg0/mTbtZiBsYRmM0ZVVwncWjOvlOpq8f0e?=
 =?us-ascii?Q?b0YL174TDT0jCxYtJSclphhyBqM2SCHY4HXG+pJQyur3vgZubN+S/34TZGnS?=
 =?us-ascii?Q?wM3TUY2c/EdMUJ51WX5dI16TR9GIjmlwtDiVIy+F7JW5pi7dH/KRPhca4t8E?=
 =?us-ascii?Q?FnfIP2Bnr9kf1N3r/OirHirjGsiwDBfC6ZfsltzixylOdQv346yw+jVzNgRp?=
 =?us-ascii?Q?g/E4UoPVFrYnuQ6Mfk88CZV9GdTtsn/2AY4uAfkQUg13Hvtu6Oqv4I+ieXmN?=
 =?us-ascii?Q?LFxeM2AtkBynYcnwbOOs619p19EmptzUT0H9tcBZAIBn4T7bTdpErDkAjHMz?=
 =?us-ascii?Q?baDX2Fw87++zj2a+H+LR6sSs92CEKX8u2MPhBnZGK/NpJDzTBJ+r0/VWxgmN?=
 =?us-ascii?Q?DEJin13WzDLg4g+mFvj/ikbX7+H45Dd8bdJP63Tlj/4JjYtilr5/ETiS9YTp?=
 =?us-ascii?Q?GURBFf3exvqINVjFhTD80HuCEHypGW4fdySi2gQKqabaQGbJVkmvifKgT4i1?=
 =?us-ascii?Q?gLcHW8nPnUwFGh0TSI4ofFhoHjY96TuDsLkqnE6ZNgkWnE59FhKtrMCoYQV0?=
 =?us-ascii?Q?khowBMVJHVv6lBTXv6k38IOH6NFFjpEBEMDWY4fL/LnmKlEShN6RBC9hxsqi?=
 =?us-ascii?Q?784selVipoAyuitKtg4ZIq26DULH3EcDEW1dF6ykPoV+WSij33iZYyr5rdkq?=
 =?us-ascii?Q?ZXah4uqO55YbOK2HzHw/HYmLjtcEAfxiAsmEzc8FDj57H6rAcbp0Db+lBN64?=
 =?us-ascii?Q?PTkWoJ7HDkQZPXIcOM2hxvhlUIgjCA7T4gnpoFViMslvK5jHi7BSylYvSIDT?=
 =?us-ascii?Q?aD3T1vb1+D0UsFtVSP9lUIoDrSOn3yfdXuhx?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(30052699003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2025 17:22:52.9140
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6442690-0acb-49a1-687d-08ddb1b16bb8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6639

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


