Return-Path: <linux-rdma+bounces-10275-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA33AB2A91
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 21:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BF1D1739EB
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 19:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8F726462A;
	Sun, 11 May 2025 19:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bWvEojXd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170B519F127;
	Sun, 11 May 2025 19:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746992378; cv=fail; b=J7T7lFNPA5qihtbQQaCu6pA5prsMEkS0NtmDxL+F5SdPSgR0t6yPAuh8N6S4tqKyKpT7T7x4pjwF8ZUfmwBhJkMPNwLvgUTQx5Vk5DgbCAgmoQEliOZbHZjGtlO2WeRPmM1+aaM/H/k0yHwwZeLNq+zJUIy8NFUd+waCwpQ20Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746992378; c=relaxed/simple;
	bh=r08CAYIKIbug4W5xr4egQ3lhdK3DTg+qDuTHPq5fV3o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F7AMKa//R8lzMFNE1ES3OAOOSvDiGXoO1bGvXrsdC7ydWxF9LhbB/NH/4UAbf51LL7Dnf4+bjZEtI5Da8akcMoqSmVzaqmtB5lBtYm/YN50RcrMLfWo1LQ35/M/FE75vA55E4GlZueEUiWv2Gfl10mVav5aXeXzMCVoFXix+aeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bWvEojXd; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SX8pFnJRmfDghqxEyqJ527bwfVS773Wa7xXIgnY6t0FKoK7NiFiy30wr94a6hFtAxthYzWGn55gdtqPuD9TP8En2DYNIP+69FYbkQufUZBPEh4WIJvYVeInp8u1jayPPaATn5e2Z3P9jAVJwXznuhc67CzGyyxE2PmPkHhjC3lPhuZ0zA6bx+12zr34YYIcfmXL+2NRj7Ne2y/7mYHWaEfYwMY/l728t7n+V6mxMGJKqOxa+9dMvmPYkYvcjp0tU4r88fYCRHXWm8hBQx7+p9HUOpOEM3Cs3PewICD3lMcdo0Mzn0wvIVYaHGuc15xqGlqO8RH7LNS1vN9WZB2hbFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uN0oTzUqJRdJUkeEnbi+T6lgoMaud9mE1Xeh8fwW7JE=;
 b=sNIbQPTKzQG2OuQkrpHzCWgOemsajOLOfx/f0ZB+fFyf3bNtWW3zbMzZZZtBKUTJ8jnz+O1yCMJLPDvFr3hMyvOgSUy0nbmIPJiKwNWWcZ6nhLTQy7h0iOuJgMww8Am56mmUzYavpvKE/DlFEGZgKJesPxMNdnPk2Y/Edy7h5sc0bAssJoP6IAT+sK1hSkvuRn5tYW/9PLvA61x5unlxMJVH+0b4ZN2VPseXredfHe3W+cNi3GM1Th1Pm/+JSZMcH1dOsaf6r4T6O8PT8a9wcb/JgCSVep3hlwh5n1VJTcSDB9qGAkyrO91X7OV7/hTMYGKXd6/BfLFGcg7gaNQ4iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uN0oTzUqJRdJUkeEnbi+T6lgoMaud9mE1Xeh8fwW7JE=;
 b=bWvEojXdaV5ibt7O6ZSItIFiWh3RwwZoZBuDFgPe0tJATbmRwO9ZE5rnatEtwAL9ME/jQTPml+L0eR2odkXzSS0e/g9JjhJBN78gOR8mqzy+X7Bi44itYG/mWeOzq5znsI5XDxkHU8K0mOVWhNd52mskzzIr3yFcN2YXxMdI0e74L7av4YcNhOTZf7MkzoTRauqeh12OJul6iYSpzBUmH59C8JIDBkU72RP4CnO0ObJZ+vykrJHEVVh7eFDRWCX9/lpop0AB5Y7JR5WLwVy+kzWJ6I9PxPvy4VxY/n2bO6PfZ/xzDBDoUQ23EqS7xchd2b8PCfd72+kQAwSLdN8Opg==
Received: from MN0P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::16)
 by DM4PR12MB5915.namprd12.prod.outlook.com (2603:10b6:8:68::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Sun, 11 May
 2025 19:39:32 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::36) by MN0P220CA0018.outlook.office365.com
 (2603:10b6:208:52e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.28 via Frontend Transport; Sun,
 11 May 2025 19:39:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Sun, 11 May 2025 19:39:31 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 11 May
 2025 12:39:27 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 11 May
 2025 12:39:26 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 11
 May 2025 12:39:23 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next 06/10] net/mlx5: HWS, force rehash when rule insertion failed
Date: Sun, 11 May 2025 22:38:06 +0300
Message-ID: <1746992290-568936-7-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1746992290-568936-1-git-send-email-tariqt@nvidia.com>
References: <1746992290-568936-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|DM4PR12MB5915:EE_
X-MS-Office365-Filtering-Correlation-Id: 779f00d3-5f2f-49e0-1005-08dd90c38d05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|30052699003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cvAVHfzGlDRzE/7X8VWKU5rVMY1fFmIPiIrEnPwNCXmUXI/NF7YVrXm64/UC?=
 =?us-ascii?Q?mbopo+curAMsKs8rpFpVYPGUCiziteq7BW9nFjBuaxHNiHvZO9pjuIxuh2eP?=
 =?us-ascii?Q?g6zSXq3GIwrpEPLE/emng9wgoIW3rgGHNUUOKlMnhiah1mZ4cvG2lie0/J9+?=
 =?us-ascii?Q?rWiS9VUG6ECC/FiQs63AXvxYA81S4FWFLxizjgEsHe4ZQoC9yMhrRy+G3un+?=
 =?us-ascii?Q?iDdRtOkDfvx5ciF6HmoPr51evQtUUvvMIUdY7T80kir+qyWrKZ3lWVrSYSjc?=
 =?us-ascii?Q?ZIs6j2ul+6QsqOr5OoT2HNMyM41lj7tE0at2xLmjoblJbINsw4i/VMc9QG/E?=
 =?us-ascii?Q?XIB1Kz4OBKadL55oAbL/2zjIyBww8LhoTA8UDhb3yMWVN5i2UoCj0txSuJ6I?=
 =?us-ascii?Q?Z1A6FAbMRN+fZNNbcmyZvDw15szLN9PEGNCmwLXA0N85WaUd0H7IQOJlOuQM?=
 =?us-ascii?Q?erLFuZG0G/JzznjkO/59fEHHE+nnJ/N0a24hdxmlTDAztDuh1zYSgAkJ+gGk?=
 =?us-ascii?Q?OdMxsswlM9ClLI6YYQhaI8kLqWELXrk7CHUseKysuy0JrXPEppICPizxSGUG?=
 =?us-ascii?Q?+zRLalcDL+yR/kCefH7tHYDMIod8gamlxPl0tgoyKKjuNGpC3ucNKKY8NRs9?=
 =?us-ascii?Q?b5OTNAsLDJtXM7+wz0JSK6jRsf8CsaOzdhByVlMPP/unH9q3A7gK86Hsjma6?=
 =?us-ascii?Q?vqbW1c5W0fS5LL9GJzxDjr4AnrPDjZhPvG/y4AcvvKHugUAUQTfMuWxdMMgb?=
 =?us-ascii?Q?eeJ9ebbqpTkPaeAGO2PjydNKUHcd4TGfFR3B4T0fRJv0s5IU3UbGTjk8syZL?=
 =?us-ascii?Q?LxTSVpOL2vvHhsNkarZm72NiNLA94KU5x36HVxRDuizN4jhGpN1P5QoUqfnJ?=
 =?us-ascii?Q?2Z/wq2gLzr6LqtslYeCxZWZIGxaJJi97w+IBfjg2uGXuIgzrdALnUI4JW8XR?=
 =?us-ascii?Q?DbynEBAI8KXnxUr6MtqmVuxCNknXG8IS+vnhB8YtzQ/YvTq4aZfTcnLbIwe3?=
 =?us-ascii?Q?XiSTwDd50E6MfL3UIIl1/KTi3eCQyLtspgSU279H9bKMgzgigdJgYXmkfVmA?=
 =?us-ascii?Q?AOKERpSx3Aj2XN24oA/B4a64iWWH1iGRUiPn45CFHkSWhnJ7cY0+1vBA2Mfa?=
 =?us-ascii?Q?ieNr2wUHSRvAinS6HwFLeJmE4I6iNJLYR1Hm2u0mk3VOnTDUJ0sFnIR7xGWu?=
 =?us-ascii?Q?cT6PlrFEnskS63t2MPf6Rj/LBOJfP9irwKSowdg+RQxvRHdDy/+xITU0jhoc?=
 =?us-ascii?Q?Mnfhh+cOYDxyI3z483eq2pY9pzkWQQbrHgsJ7V2lfwrQbj3fSPyfVHswYcIw?=
 =?us-ascii?Q?Hl3fVDjRU2tAc1dP7VynLWGlEmIb4hrzPc7K04YInEw8mtkuQQRpl+KZpuhw?=
 =?us-ascii?Q?IhgGEgl5Esu18ljXfXZgf5YsNEQ/ZWteRfQJzv9qn3lfi4Y3vubQRNGr9MlF?=
 =?us-ascii?Q?spvqUsIxKt2o0frZKtVq0X9HJPr3PSiEnawBj8G26SjOnrj0oCEyP/+CLO2I?=
 =?us-ascii?Q?t78dOVXoxvfohtkewziTAGiloyjZ7utu3yvE?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(30052699003)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2025 19:39:31.3602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 779f00d3-5f2f-49e0-1005-08dd90c38d05
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5915

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Rules are inserted into hash table in accordance with their hash index.
When a certain number of rules is reached, the table is rehashed:
a bigger new table is allocated and all the rules are moved there.
But sometimes a new rule can't be inserted into the hash table
because its index is full, even though the number of rules in the
table is well below the threshold. The hash function is not perfect,
so such cases are not rare. When that happens, we want to do the same
rehash, in order to increase the table size and lower the probability
for such cases.

This patch fixes the usecase where rule insertion was failing, but
rehash couldn't be initiated due to low number of rules: it adds flag
that denotes that rehash is required, even if the number of rules in
the table is below the rehash threshold.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c    | 8 ++++++--
 .../net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h    | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
index d70db6948dbb..dce2605fc99b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
@@ -169,6 +169,7 @@ mlx5hws_bwc_matcher_create(struct mlx5hws_table *table,
 		return NULL;
 
 	atomic_set(&bwc_matcher->num_of_rules, 0);
+	atomic_set(&bwc_matcher->rehash_required, false);
 
 	/* Check if the required match params can be all matched
 	 * in single STE, otherwise complex matcher is needed.
@@ -769,9 +770,9 @@ hws_bwc_matcher_rehash_size(struct mlx5hws_bwc_matcher *bwc_matcher)
 
 	/* It is possible that other rule has already performed rehash.
 	 * Need to check again if we really need rehash.
-	 * If the reason for rehash was size, but not any more - skip rehash.
 	 */
-	if (!hws_bwc_matcher_rehash_size_needed(bwc_matcher,
+	if (!atomic_read(&bwc_matcher->rehash_required) &&
+	    !hws_bwc_matcher_rehash_size_needed(bwc_matcher,
 						atomic_read(&bwc_matcher->num_of_rules)))
 		return 0;
 
@@ -782,6 +783,8 @@ hws_bwc_matcher_rehash_size(struct mlx5hws_bwc_matcher *bwc_matcher)
 	 *  - destroy the old matcher
 	 */
 
+	atomic_set(&bwc_matcher->rehash_required, false);
+
 	ret = hws_bwc_matcher_extend_size(bwc_matcher);
 	if (ret)
 		return ret;
@@ -875,6 +878,7 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 	 * Try rehash by size and insert rule again - last chance.
 	 */
 
+	atomic_set(&bwc_matcher->rehash_required, true);
 	mutex_unlock(queue_lock);
 
 	hws_bwc_lock_all_queues(ctx);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
index cf2b65146317..d21fc247a510 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
@@ -30,6 +30,7 @@ struct mlx5hws_bwc_matcher {
 	u8 size_log;
 	u32 priority;
 	atomic_t num_of_rules;
+	atomic_t rehash_required;
 	struct list_head *rules;
 };
 
-- 
2.31.1


