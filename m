Return-Path: <linux-rdma+bounces-11153-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 914F9AD3C93
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 17:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C013E1896E4E
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 15:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DB724110F;
	Tue, 10 Jun 2025 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gKveozQ2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9639241105;
	Tue, 10 Jun 2025 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568571; cv=fail; b=QcxE+lxnsaewT3nMXzPCm6eGo0Xajkv+DnnV2H5HnMcQfz5ywSZaERQ4ldqvcGeSPVVRZxszauV6/yOLrqkf59G8QI/BPI4SOwQqxGpL/BsweCbuxT6pzhHbsox4Qc+JKxbGfAFvvPknqljCAYJNfJtcxywNpKkE+gJS5WwhKJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568571; c=relaxed/simple;
	bh=sCR8j7ypm60q5ZsaOUwN2B3tCEcKwbbH+JU7mmJgXtg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xz3u++qRftCBJur756jCHNTbkbALTuet5PZrUxrxASgKsj5Pdm19AOxHTm7Ca/w1uReZc/gjqNmDXmrxj5K/nGWRF4eswuDT4DUaAfolujT/HeqDStphsuNQVDKwVTyXp9bk0qe0IVDECoyuHQ42XHijCTApQmkCovn2v5DfnHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gKveozQ2; arc=fail smtp.client-ip=40.107.101.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFMqjWDFvtuMExF0MEoHpLMkSiyS8jOBF85fK8EEcfLS2BlhhoZkNgdDunPnhgYTogP7lGG/Ny4XXBLWJKCzBjZeOD36jZzdPXYxyCWIbvJBLRzCZq0+TpTAAJ3md5qNBNrRLFsx2hwJHezsnq0Cebg0FgeVcd4tlF5DbAxGuN+WZExc0BSWutKYnaW/RzxaMD056VauzjaCgv3LeChvUnmULfW4VRl2/63kC2qzuY/sYfJk0Pgwolbh4un5iAxKgbox/I0rOSyDRKEp2+s6OoScJMpAwnBS6yQX0dAuYvn3Cq6XVz4f0mxFQZpSmRN/fa80I1EWWCju1DqLI/P7qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gD5ukszi5/X6e2dSG4zLINF5n+5UjJrG7JHjh5mCBE=;
 b=de4mM0lzw/OstmNQ5XVSiXOqsCZfjUd0TQkkjFRlMVGA9pXrfseZ25CdV3xB92Sg0hur95yAR9cF9uHv8ONPpHlxe1H4/nYfiFi8xQMoVjvYYL0WwQg6cSYOotmyzC0otz6NFSBKioiT1kTVLXdkCQrXbpPTqqzdljJA43t320ZzZbUCG9MoXDMzDyrjTbOja4djo0BnQuZW9TL23tLH3/wXgFn5WYfy2xOBR/Of5/wqcOdUJymsnmpVmzpl36aNqQ985Xut6bC51GPUGzRopbJA7SzwffoAFFRC+HDIp+jONp+vqNL6dmPyLKzci0n/OknZghWaCS1aTdJOIWizpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gD5ukszi5/X6e2dSG4zLINF5n+5UjJrG7JHjh5mCBE=;
 b=gKveozQ2CXLkjY445eSV3Y2VHjg5VsuuT5jlm1iG7BPEoPEKKY7IJQO8Ydqcf1H71xW6QdfBy90IwnTOBwm/mSNIPxlxRjeQt6dcWhLGH5HUlWPHgC5hBCUX4gWvQJtVg6zmB7MotdVAgivGDs0Li58pXf2ZqUWCpv8VSb0+55X7AvXHVBI+T8PJ/EGdpzB3zloIN8O0V6sCxk+uwAaSyPy4yuLCAdjrKr0rD2I6uFb3Wr6Or4uKC5KnTDi9iNly4NstUNKNHyiIJhLlRUcs2PVVkHse5HQRMo6474Pi60Zy6RqA85iJCxEUyrDJL25a/g9gKDYyDInuBWlPsKgCfw==
Received: from MW4PR04CA0355.namprd04.prod.outlook.com (2603:10b6:303:8a::30)
 by DM4PR12MB7576.namprd12.prod.outlook.com (2603:10b6:8:10c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.37; Tue, 10 Jun
 2025 15:16:06 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::55) by MW4PR04CA0355.outlook.office365.com
 (2603:10b6:303:8a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 10 Jun 2025 15:16:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 15:16:05 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 08:15:41 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 10 Jun
 2025 08:15:41 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 10
 Jun 2025 08:15:37 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, "Gavi
 Teitz" <gavi@nvidia.com>, Roi Dayan <roid@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net 3/9] net/mlx5: Fix return value when searching for existing flow group
Date: Tue, 10 Jun 2025 18:15:08 +0300
Message-ID: <20250610151514.1094735-4-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|DM4PR12MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: 1be8bbe4-dded-487a-b538-08dda831b8a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?33v9hm0oi/my1Ew6xMgYz14NduEdbj5smOTglaf0yTWQ6Z9A/JHMGmA+IIDX?=
 =?us-ascii?Q?ojZVAW3sI1nBICC8+0XDIBFHxNFSBVZk5Lx86U6aqypozAnTEvt36CzFtSYF?=
 =?us-ascii?Q?MgBvnHmIZsivEEZiuTVFgegddNTrFeWSbqShPA+m+42iqJP1Lrfe/KigsjwT?=
 =?us-ascii?Q?1Qy+y4U+2Xo46ma+Qdizj8R5vyG0PwlSZvtbOBWtZQSciMl5G547vTIE5uLd?=
 =?us-ascii?Q?t+/x03iJXHK6aMuTtTwnS/1AMfTmwR/pTvfR1hJM+5fIMOn4/zbinz9gPt1n?=
 =?us-ascii?Q?7KH99fb/o5r66QKbdyCjw/13ZSbwoq9TR04rnyyoi7sfELpwaJE4JBptDWQW?=
 =?us-ascii?Q?b2myHVDMkWXQJJnxEjiVW+FDcQQdtQkhEyExansalerrJgZsKy7WGiA58LFa?=
 =?us-ascii?Q?FlAhX31OheKbx+HivPZlGmEhOZ1rqSJW1+pk360NWSmtk53LyOTrMLzP8S2I?=
 =?us-ascii?Q?PDIIWKckb17vs4tvcyG1C4uOSrx/nBwB+GIJ7z/lvvGuVn8P7pGDghdFQMXb?=
 =?us-ascii?Q?50MoN+cf/xuB6wycSy9Jw2evcsjaGeqqHV0ZiEKmyR5r1BSONx0/WeRlp8bq?=
 =?us-ascii?Q?QlD5ThX8eyB9ol4FjOQMNyltm+sfiVOw/5Rx/F0T/FUHh365q7h3eI4p+xeD?=
 =?us-ascii?Q?RYn7/tr0I0CgQfGan9SApZWwZX2Xg43G4UUL1+Iyv1uupPIAcBcqiQ+6x9A+?=
 =?us-ascii?Q?/XDcbPdB+zzBqvaZoDM+hbbz5scmwuALHHA+qL5uRk29SHmXJJXtNeQOHigD?=
 =?us-ascii?Q?M8z1ZB/nzvk5Oqs7+keh9w5pj4SlNP7QeEYO0Ytt8a8vtbd2cuQFMWUvT7mn?=
 =?us-ascii?Q?So9N4Q1V5FV2PppHy4rNQEDJguTHQ4EPtR32HZ2AdbaDw1k8GjGgzEsqysfa?=
 =?us-ascii?Q?FLK5b/RjCuaWFGuSnOG28ZGGO3E9EqecoLvYF5FzScV5Sl86pspFL4hOAJOW?=
 =?us-ascii?Q?kTDIEfQfJq+iR1Oq1OW4PuFd7H8TfU50fKuFtp+70l0Pc2iQP2TtAed2GbGs?=
 =?us-ascii?Q?KOYlUSOZM4b9CEtczHactGBWKfv6KXvSTbYByiP8p1clRuocru+gCzmp9bhY?=
 =?us-ascii?Q?14+1rzxbfK+vOcNqMGvFVsMUWvby+R8uDYdbQB+GsYYr0R7FN5CrTt3rhT06?=
 =?us-ascii?Q?L6dNiR5mDyyNcy1w70cZ/UoxLr4EiZiItjUBM+32+44lRB67IY8LNKw1pecu?=
 =?us-ascii?Q?2r2lXu6msx5Z1qXHoxNF7nj0i1q3uuDfiY/vukjg4/aouRxdouCqgrgfMLIh?=
 =?us-ascii?Q?K1nCFg4xcxTIY3ZUHayX0hUt4LLQbqT/d9z48SDIVecKbUR8nmfCW0AICQ4X?=
 =?us-ascii?Q?yg7s6pisTal/L+FUDsOU6gGMTSnwP905NFBaANexlClYrDKGzfB2pAZNRjB2?=
 =?us-ascii?Q?JzL/4mQNJ5BUWrGHEiiR8TLT1IIBr8LXpkxjaoMksu3Js4FqK9DxeiWMn4CR?=
 =?us-ascii?Q?gjiw/6DNKt5hGSsjBeVsWILAvUr34ZaSiwHhSYJoUi727ECDXcQmz1P0m/dT?=
 =?us-ascii?Q?9Z2ZxOKXqUkYTe3Lpe5NVIobG5DUcR7t8ld7?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:16:05.9461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be8bbe4-dded-487a-b538-08dda831b8a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7576

From: Patrisious Haddad <phaddad@nvidia.com>

When attempting to add a rule to an existing flow group, if a matching
flow group exists but is not active, the error code returned should be
EAGAIN, so that the rule can be added to the matching flow group once
it is active, rather than ENOENT, which indicates that no matching
flow group was found.

Fixes: bd71b08ec2ee ("net/mlx5: Support multiple updates of steering rules in parallel")
Signed-off-by: Gavi Teitz <gavi@nvidia.com>
Signed-off-by: Roi Dayan <roid@nvidia.com>
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 23a7e8e7adfa..a8046200d376 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -2228,6 +2228,7 @@ try_add_to_existing_fg(struct mlx5_flow_table *ft,
 	struct mlx5_flow_handle *rule;
 	struct match_list *iter;
 	bool take_write = false;
+	bool try_again = false;
 	struct fs_fte *fte;
 	u64  version = 0;
 	int err;
@@ -2292,6 +2293,7 @@ try_add_to_existing_fg(struct mlx5_flow_table *ft,
 		nested_down_write_ref_node(&g->node, FS_LOCK_PARENT);
 
 		if (!g->node.active) {
+			try_again = true;
 			up_write_ref_node(&g->node, false);
 			continue;
 		}
@@ -2313,7 +2315,8 @@ try_add_to_existing_fg(struct mlx5_flow_table *ft,
 			tree_put_node(&fte->node, false);
 		return rule;
 	}
-	rule = ERR_PTR(-ENOENT);
+	err = try_again ? -EAGAIN : -ENOENT;
+	rule = ERR_PTR(err);
 out:
 	kmem_cache_free(steering->ftes_cache, fte);
 	return rule;
-- 
2.34.1


