Return-Path: <linux-rdma+bounces-10277-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC14DAB2A97
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 21:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58198174F39
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 19:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC6D265CB1;
	Sun, 11 May 2025 19:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OXYPjCpH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F91265632;
	Sun, 11 May 2025 19:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746992387; cv=fail; b=FPJU57zXqx09HYHoD2XkWz+QFPXH+xz7By8mREOSChyn0B7gZcpMjB3f3Woy8WmOSELOQz0bRSWjPHizyY7YrrXvp687lxhxABOrE7RoXYKExqgKaCigdIJgUbxxaieGKOp2Y1zqevuWjUFLx0gVwSxuJji+ZDGWEWLPYEsm2IE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746992387; c=relaxed/simple;
	bh=K5QJXB9gf/Ia4mcXJyKPczGVkQvo7igiOEDjO3ju4mc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K4o166OZ+g6kz+Rkz5cqA7pMTWxBQNGlMh+VsFXFaPllw3PwlFKb6PzscxIAoq8mHGiVHsrxd/tBUL4jL3Mdjgq0NZVMevjvzRbBInXaPOQ53wVUsg3qJIxuqV4DTdYo3ycyfa9/ewSTtIuxFOYgE1kgLsDk1ETvAos5pYtKpOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OXYPjCpH; arc=fail smtp.client-ip=40.107.93.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRu8yJXwZ1HIQLxCpN42lf16nVSvA5O7OUENPNH4MokNs5IBmTgwCjCFQyn+dTnMJTSnDJBlRWH+pEPmiXiPVQhZi0u46mtg1ZqJnaokVHmVv8QuRL5kseKap3+1Zq1TuizEOhDcjuJLOPA92pPFb3tCbe0aL5m1Ub7ggU7kMHLEFKZugTJNadPXpuH9xUCStYbWHTltbNXsPjuHA0Dx0CTGyBGD20JetmlrpjVSWG2QfX/ljPhJp0ZDGDQ/ZUPOajcCr45sPxoE/cZLVB5+EdEJ34ccorFqVRXVYOPudbed8tDz4eOLCQeqma2iQiMqfyhQREpP44hYwDTqWZiLVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rb9LrMBRuH7VlDLfjOEd3QTtnsEac6QzZ+Jkzmco+/I=;
 b=oyu7UWPlxRf2zx/QNEURCm8RIda4BENcKopY91fmJuHl/KqrxIef1tMaV2PaOLqhWDFOwOukqhiIrOMoBsugRmamGzZEvK9WP4/Lgs1kw0wkcbSAICk/t+qt/oIYPgDyKZ9UJ1iyJIqKjBlYcIE1ROAPPmxg8vJnNomw4E6O6XE+ICOotxoK+I3vxbs5zba0kS7NhR+znkLTK4+zaO7tARa7K6FfGx3AoohxPn7Ru0DYDo3xZJdTMuneB4ckMEBb0WdzrYYZKiibEXC7vhZbof9KYUr8V271YxZHbj1/beNvKQXRuYVeEE4rDe+aD84RSUEkXCFeLerWD5BscTbaLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rb9LrMBRuH7VlDLfjOEd3QTtnsEac6QzZ+Jkzmco+/I=;
 b=OXYPjCpHzp5mgEKVlguTdD4Ea0CrHbko9MS1GtGRKl5xFT9XgDNIuYX3QKKsmLh5Rko8xHmCePFh3NQHZF6GDIMrMiJUkMjsmJ9xEYOMzPdV36Ii965Qm6gyW4NU1JFfcnczPkAB7XXffywkxPZDUi4JYISa3LTchA81jc8Jum4ylqgUrdo/hR/1SjO+JlVQLNRu1Lf0BusW04Eh6Ud8RjNvuv0U6NZAWUztzaa9mbcYKiP8DeK/MmIXuDg6VUBA/9cKMUVTHy/nHnJcWeUUGAyQKNncfmmhcpkE8FhRqRqFk1qBK2q+M7Ar2T0cIuh/ayHWqJcY0icEeVYBdxUYOQ==
Received: from BN0PR07CA0030.namprd07.prod.outlook.com (2603:10b6:408:141::13)
 by PH7PR12MB5655.namprd12.prod.outlook.com (2603:10b6:510:138::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Sun, 11 May
 2025 19:39:39 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::68) by BN0PR07CA0030.outlook.office365.com
 (2603:10b6:408:141::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Sun,
 11 May 2025 19:39:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Sun, 11 May 2025 19:39:38 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 11 May
 2025 12:39:31 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 11 May
 2025 12:39:31 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 11
 May 2025 12:39:27 -0700
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
Subject: [PATCH net-next 07/10] net/mlx5: HWS, fix counting of rules in the matcher
Date: Sun, 11 May 2025 22:38:07 +0300
Message-ID: <1746992290-568936-8-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|PH7PR12MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: 1406fbfd-007c-4cbe-020d-08dd90c3914a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qVuPo8hwnnFeZVMjaJdQ/+AW9C8dzRB2XrQHBmFFEOWf+L9QNwJA7y3VlX7u?=
 =?us-ascii?Q?G8NcIB3lqOgNg9v5A6gC054jmHi4nKeiVI4jBvMhd2cQ2Vh5eslcmAtgItSy?=
 =?us-ascii?Q?ot8FH9oNc7nvsJB/8exr4iwQhvjdkDrguys4sd8zoRNVuVvtFgfX2qBU1z2Y?=
 =?us-ascii?Q?O0lmfbqVVfV319mJx37rBD718CbyT6pESmBQVxtKU3eqoZqOr05tF1h03YIu?=
 =?us-ascii?Q?vreTnbnZHB4iinT/fphwRgSCJst5FsB9+iilPQCmfUpFotLqYheugmjJGdHJ?=
 =?us-ascii?Q?VYGvqR2JAG+/z18eS6ZNg18mTNtlZ5NRrqC8ULY2R01wRfdOcfFAXkO6uwmE?=
 =?us-ascii?Q?9+noowCMClmOb4QwqdwZyznvtch50L7VXSUhJ2YjhWiceSRbjhVQNBiGh2A/?=
 =?us-ascii?Q?hsfusM44iMe2sF66QofW00SCP/wTaJ6h4XU1tJbOZnGTlweiQWqZIYjkI6vV?=
 =?us-ascii?Q?tfRVba5VLubd6f7os7bTCSoU9FtOFxwyo3aNYNO2RXfWIzC2AXmeIfd+p/+4?=
 =?us-ascii?Q?YE9MASISikg3iZ49BxycjEtWcE9STHoMjuRo7Yau3o4adFdlLUaY5qF0D/n2?=
 =?us-ascii?Q?bsJmxybVyqfHPv7Zc5gPJG64t+WGl/BeNP3t+3CSb7J305RZK3h+10q18FeJ?=
 =?us-ascii?Q?E4K2D0rtCgb4zgNoZqA4IoPgsaiw/cLdlzsX1+Ud0dPDICJgz8okHAQloMDs?=
 =?us-ascii?Q?HikTKykLR9PGJhG1oirVID34H89hzrUv3gU8zJ1ub3nyoyu/RbIRfhZE0DwV?=
 =?us-ascii?Q?TvhQ+X7It6Ov4kTb9d4cmlw53N72hxlH3XVBsNHVwHU6kOhse3tTuGkuM5oq?=
 =?us-ascii?Q?UJWFS3XQmZq98b34/MkJEjpEPxkL7/Oblo1W+tweo0TLuQWRjDM7QtAYG1Nu?=
 =?us-ascii?Q?d7Ox8S0va/1y6f918wrk4d6/JusAkmdqVGr1+ibnkgRUVw/SOg4pKM5NGw5n?=
 =?us-ascii?Q?Gg/JetAj6DdsXyLzZk8F0Fb1yYdrtDe3s2fBElYl7UvXz/4s2WW3Tvf0jh2Y?=
 =?us-ascii?Q?89b36Kww07EsSpJP9ffppUL3dR5HvCKZ0hdaXS1bUZow3CQhXWZucD2gEjoV?=
 =?us-ascii?Q?B7cWZ+xomtDOqM85xIUJXaJJbub/fzXErIc14TeL0vEzjoDvtACmMYZ3QWUX?=
 =?us-ascii?Q?oLe1+kJoZhtOAOwgoASs8hbxjj60RCQkg1NDT0Hq/c96ObKFT6xryG0ZGQlL?=
 =?us-ascii?Q?VTpKueuaKGUJg8CEtjuhkUxeXCr866G+yCs1LU3qBvaRyJS8qsn6zEUjnwIt?=
 =?us-ascii?Q?bqR+7cNHEzH0beYjbDjKB2iH0E9nxht2fzp++gQCvkOHp3QgAAqPnIQV+sfF?=
 =?us-ascii?Q?BsVcRTKJi4lhDgG8s/KztlvTPs3rc7GotjdschKzvVBoMbvl/efqxOlHxg1P?=
 =?us-ascii?Q?T4Ndr4DD8+tbXpD8QgS/PjkhfaeiLltIFvj/n2LWOLNvuG9E+CvRkULoPAJz?=
 =?us-ascii?Q?AGOgJIjLardl5vQRwas8K8mfW8otp7Z9pcWOeFxr9hGSu9utt03ggMxq+rK/?=
 =?us-ascii?Q?ZKI1KOL4xomljMN8ZJn98QqQoDz2UI2Ztr1Z?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2025 19:39:38.5104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1406fbfd-007c-4cbe-020d-08dd90c3914a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5655

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Currently the counter that counts number of rules in a matcher is
increased only when rule insertion is completed. In a multi-threaded
usecase this can lead to a scenario that many rules can be in process
of insertion in the same matcher, while none of them has completed
the insertion and the rule counter is not updated. This results in
a rule insertion failure for many of them at first attempt, which
leads to all of them requiring rehash and requiring locking of all
the queue locks.

This patch fixes the case by increasing the rule counter in the
beginning of insertion process and decreasing in case of any failure.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
index dce2605fc99b..7d991a61eeb3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
@@ -341,16 +341,12 @@ static void hws_bwc_rule_list_add(struct mlx5hws_bwc_rule *bwc_rule, u16 idx)
 {
 	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
 
-	atomic_inc(&bwc_matcher->num_of_rules);
 	bwc_rule->bwc_queue_idx = idx;
 	list_add(&bwc_rule->list_node, &bwc_matcher->rules[idx]);
 }
 
 static void hws_bwc_rule_list_remove(struct mlx5hws_bwc_rule *bwc_rule)
 {
-	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
-
-	atomic_dec(&bwc_matcher->num_of_rules);
 	list_del_init(&bwc_rule->list_node);
 }
 
@@ -404,6 +400,7 @@ int mlx5hws_bwc_rule_destroy_simple(struct mlx5hws_bwc_rule *bwc_rule)
 	mutex_lock(queue_lock);
 
 	ret = hws_bwc_rule_destroy_hws_sync(bwc_rule, &attr);
+	atomic_dec(&bwc_matcher->num_of_rules);
 	hws_bwc_rule_list_remove(bwc_rule);
 
 	mutex_unlock(queue_lock);
@@ -840,7 +837,7 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 	}
 
 	/* check if number of rules require rehash */
-	num_of_rules = atomic_read(&bwc_matcher->num_of_rules);
+	num_of_rules = atomic_inc_return(&bwc_matcher->num_of_rules);
 
 	if (unlikely(hws_bwc_matcher_rehash_size_needed(bwc_matcher, num_of_rules))) {
 		mutex_unlock(queue_lock);
@@ -854,6 +851,7 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 				    bwc_matcher->size_log - MLX5HWS_BWC_MATCHER_SIZE_LOG_STEP,
 				    bwc_matcher->size_log,
 				    ret);
+			atomic_dec(&bwc_matcher->num_of_rules);
 			return ret;
 		}
 
@@ -887,6 +885,7 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 
 	if (ret) {
 		mlx5hws_err(ctx, "BWC rule insertion: rehash failed (%d)\n", ret);
+		atomic_dec(&bwc_matcher->num_of_rules);
 		return ret;
 	}
 
@@ -902,6 +901,7 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 	if (unlikely(ret)) {
 		mutex_unlock(queue_lock);
 		mlx5hws_err(ctx, "BWC rule insertion failed (%d)\n", ret);
+		atomic_dec(&bwc_matcher->num_of_rules);
 		return ret;
 	}
 
-- 
2.31.1


