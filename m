Return-Path: <linux-rdma+bounces-10279-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56ABAAB2A99
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 21:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C28EC174EF7
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 19:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748C626658A;
	Sun, 11 May 2025 19:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oIT7BHJk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F61265CB9;
	Sun, 11 May 2025 19:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746992390; cv=fail; b=LdQoD5aiJOm/h5ihlkfumSu/gKOafLUV8l7dz+HmD7emXJZc6GrSFChMgEzebmF463hdKBGNZxwFxbDh3Qr55K8gP5EuiPC38o6Y9OkMs2GlrWtTdVKHFWbRquWZGjG5c72Lr4Mje8J8Pqb0xg9gHDEyrRv6oyeRc2Lgy6l8D9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746992390; c=relaxed/simple;
	bh=ARVVla/T/Hla41dtxM1JinCFQtrjrg9JAR8aPn21QZU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iYFzG3mugTHrRGjJjkDu7cCwUdq2ZWomqrlKnnj5ZhffF1QWLFpfH66u5j5EmSmuN5koubni8VDAZlpFfnVXJ2y4ZC9Bx4bbLAiNk2KN6l+rhrynQmufDChREh4hutuRjhhlA3dKfrhDK0p28QnxlHkVshkLMK6UMf2DONpdb+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oIT7BHJk; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QBeBVm+a05LjTNJJIQafLAWxckKxnfoljeiJl0APf8pi9+l+jAmGZRbGBYkhilWCpj/5X77qXMBpgLgAu9yfsSiENz9Jd0ot3RoxSOl2DV6+ihCM3s48cAx3g2X7RDrI9v1VtUoqeaxU8XmyNu7YTLrNf+6fwACzz/D8UlEfiUZr5RZfdLgV3wAm40md2SFJI2x5D7abgxTvchwvBycrtOxLV+c/GYkIb62VQznj+hNgmFgXUTzrZEF8H8rWIABtx8S/ac/wJiYDzJWmyU1+DCWUL0Rs/zvAyJccEmw8emexqjs6cmsjQg4O/04z+8OjIyfeo76AbKk1mGXNoDeOWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvYVu9cp9fKBEzD6hcJclmPzg++qtD3ha2nSmDD/raA=;
 b=NWjz10D6Q1ZkTHjEqmfVTNXXiqwpJePRlSjxEmTWKZgwhrCNA/W3U6bJLUkMyvIvmV5xFDr+EiM7q8iL5XfO2iGVrEXP1vjEVOnXKul8h9R8N89Q4Jdw9ju8uv5WVQxPH7sG4MoaSQ+YqWTyuTLWchAKycyMSVziBJh6uKahY2yQXlB4UloEV8wNdsbNpbtqiyrT/FHQtQk42buDWFWpz7aoarCtc17glPseeVPa4VRnbnFBzBMI7bXUs+DFQZAcPzA6Gkov6oqjpRVpbuRXo8R/dLkSsimA7yCyDhEt89+mO7ZetQD1UiwozaFpYcMHBrkGCfzovO6EwMobhme1QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvYVu9cp9fKBEzD6hcJclmPzg++qtD3ha2nSmDD/raA=;
 b=oIT7BHJkY6ZWBI/4SMQb1WewewDYyR4SF0E4PV3CHxzsVOhyukzblq7RJktFUTVV/QKz5qX5AwGwnKX1ARgH0+RkU55fOTa5Ojx2N1sKiVgRSQHz/orLSsD9ax4AfdroTPip++L87t8UK3nWF9XjmDTyPY6FU04Kv06G924+U0XkHYrhNMy0mcKG6PMHAi6GLDa8YK7gOyTeehSFDChNqsDy+TU/EPAyNcbQ0qG+IqR60JZEzAjphQLf//AIjTDJuEjVVV0S18QrItkhIrJlDssZmMgbzWVGvKp052AdwSNSprcE2JcfBbeCGmuS3JYc1mKRV+fpOseemrc3otafMw==
Received: from BN0PR07CA0005.namprd07.prod.outlook.com (2603:10b6:408:141::20)
 by DM4PR12MB5939.namprd12.prod.outlook.com (2603:10b6:8:6a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Sun, 11 May
 2025 19:39:43 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::95) by BN0PR07CA0005.outlook.office365.com
 (2603:10b6:408:141::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Sun,
 11 May 2025 19:39:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Sun, 11 May 2025 19:39:42 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 11 May
 2025 12:39:35 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 11 May
 2025 12:39:35 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 11
 May 2025 12:39:31 -0700
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
Subject: [PATCH net-next 08/10] net/mlx5: HWS, fix redundant extension of action templates
Date: Sun, 11 May 2025 22:38:08 +0300
Message-ID: <1746992290-568936-9-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|DM4PR12MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: a73dc059-bd57-499c-e142-08dd90c393ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RYxqVPVuq4b8lewP7eUiE+2ogIx91Dv91UAPItUJpAWuVGGAU2Ku1+zWV7N/?=
 =?us-ascii?Q?NP3V02kI5HpRRNvGvp9LP11Cny534/RmBFWAe4X1WATTPRppNAdjGU2DrZ+y?=
 =?us-ascii?Q?EpsRn23omoKs5DfrO1kPydh6H6T80oXuDC3wsTJ86VIESeybzp3KkSlrsYci?=
 =?us-ascii?Q?T/J5OO8K261TBzXHqAYlruGQU+s+DQAB2gSY3sBr2CrrO9dNkPCsTW8FE+zc?=
 =?us-ascii?Q?khUtsBNuzdSpM60S4sizYtDp+VkD1HTNwITni9HYkAIIl8uqCkVK2PmtajAe?=
 =?us-ascii?Q?C7qtuUCylMpqVHgNo65ibxDnjZWS2wb00+SxjZfmxyCGYqyf8v7TqMZhD0a8?=
 =?us-ascii?Q?oI6ob05onxa+M/vJC59BCZheTyGyqq2krBDEvg15cwTVgzifyXjbDX9fL8eB?=
 =?us-ascii?Q?CaVKb9ebHFQiSIjjkH8vS7RXw/Ns5qbMrQbiT7i4gndv/aBPegRZmloJynI5?=
 =?us-ascii?Q?olZ8k80cWNFapoFrZ0gV/C59IGKmwpt11rtdhYPiCfQqF6MkOsJu3C8uY7Ox?=
 =?us-ascii?Q?ErryZiMBwBP6GBB9JDh6rl1FoOA9nVRUbSdbenkDpObtM2vaCq70DBSqKRrb?=
 =?us-ascii?Q?5WNhoCNHFr6c2Qr0IWMvYvHFDRk+ow+tBwAKZQq/73tZYw7bLNuW5VqhQFmr?=
 =?us-ascii?Q?gprZunQs1tk4IyGekNP/Yoc56ZFTPlwc6ISoj8zAvEC4CaWsEERfvzRbi3JJ?=
 =?us-ascii?Q?PtlPb7evpdExRIsCQTeYs+1tDpVPZUWnF7wVZqeu+wA0uNT8DNgZMP6zRocj?=
 =?us-ascii?Q?/6m7GNGCCDUDsqn2muTuIvkUdsu/5FViukTNbSzDpYyMTtlGqdAyTHHHM9cF?=
 =?us-ascii?Q?H9dJJDlPkH9hv9YK+biA5KfFac41s8kBinSCOWTwiOwCGAcRzNmfbxDlDKSw?=
 =?us-ascii?Q?UiLPp3MF4lIB/0+7Bst06hYrlCwcDKVW4fDSfOwMYy4U4ee6Gvf4iK+GTKwv?=
 =?us-ascii?Q?/JsBP2HXknevwC02qROmBXdVgyf3sH8LYUyFpZMDN0dfR7BXXhmCM7kBygFQ?=
 =?us-ascii?Q?BR/SSrVble8b0TPgYqP3lTIDZsEXZLrqRVDjnWytwZO7hZy55opBBsZeu/7C?=
 =?us-ascii?Q?yuvBbW0QJNjM2uyLPbOooTa+wtnNbrYRsHCGtnI/wxok0C16hvWV/553EZQk?=
 =?us-ascii?Q?3eBH3CsonYKzTtNWwtV/yOeK0Ff0YD3UiAhFzZaV/BhSpIgoqaqLlaqd9GaF?=
 =?us-ascii?Q?RQ+Dlg9VtTS1CNa6q36Li8sq2Fi1rH0P4T/JipcRdR1tkGZaC3kS8ZMYvA2S?=
 =?us-ascii?Q?VlPlZHfHA09b/4VkN3F+AXiCoEWXy8sTP9kuCbpMtIrZFwxVoxNendvkEDdc?=
 =?us-ascii?Q?+YeyXN3rxNsuDUSLVeIh003mp3sheV1UXm1WJjeS96RNd+vCB+M5aN8wlCwK?=
 =?us-ascii?Q?B8x/Mx9kghLVeko6VcTbA0BqAQyYJjV7zVJfvk2z9aavcFG160ZsIZaEF+su?=
 =?us-ascii?Q?JecNa0jnq3t0psYEAcuM5dFhpwzSQhjl2MI+JGXKwUMhJTjppqm12YWXQwOE?=
 =?us-ascii?Q?/xTwJs8lQ9Pou1lsqmpsF33F/iflrVSy0x99?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2025 19:39:42.5085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a73dc059-bd57-499c-e142-08dd90c393ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5939

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

When a rule is inserted into a matcher, we search for the suitable
action template. If such template is not found, action template array
is extended with the new template. However, when several threads are
performing this in parallel, there is a race - we can end up with
extending the action templates array with the same template.

This patch is doing the following:
 - refactor the code to find action template index in rule create and
   update, have the common code in an auxiliary function
 - after locking all the queues, check again if the action template
   array still needs to be extended

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/bwc.c     | 105 +++++++++---------
 1 file changed, 54 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
index 7d991a61eeb3..456fac895f5e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
@@ -789,6 +789,53 @@ hws_bwc_matcher_rehash_size(struct mlx5hws_bwc_matcher *bwc_matcher)
 	return hws_bwc_matcher_move(bwc_matcher);
 }
 
+static int hws_bwc_rule_get_at_idx(struct mlx5hws_bwc_rule *bwc_rule,
+				   struct mlx5hws_rule_action rule_actions[],
+				   u16 bwc_queue_idx)
+{
+	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
+	struct mlx5hws_context *ctx = bwc_matcher->matcher->tbl->ctx;
+	struct mutex *queue_lock; /* Protect the queue */
+	int at_idx, ret;
+
+	/* check if rehash needed due to missing action template */
+	at_idx = hws_bwc_matcher_find_at(bwc_matcher, rule_actions);
+	if (likely(at_idx >= 0))
+		return at_idx;
+
+	/* we need to extend BWC matcher action templates array */
+	queue_lock = hws_bwc_get_queue_lock(ctx, bwc_queue_idx);
+	mutex_unlock(queue_lock);
+	hws_bwc_lock_all_queues(ctx);
+
+	/* check again - perhaps other thread already did extend_at */
+	at_idx = hws_bwc_matcher_find_at(bwc_matcher, rule_actions);
+	if (at_idx >= 0)
+		goto out;
+
+	ret = hws_bwc_matcher_extend_at(bwc_matcher, rule_actions);
+	if (unlikely(ret)) {
+		mlx5hws_err(ctx, "BWC rule: failed extending AT (%d)", ret);
+		at_idx = -EINVAL;
+		goto out;
+	}
+
+	/* action templates array was extended, we need the last idx */
+	at_idx = bwc_matcher->num_of_at - 1;
+	ret = mlx5hws_matcher_attach_at(bwc_matcher->matcher,
+					bwc_matcher->at[at_idx]);
+	if (unlikely(ret)) {
+		mlx5hws_err(ctx, "BWC rule: failed attaching new AT (%d)", ret);
+		at_idx = -EINVAL;
+		goto out;
+	}
+
+out:
+	hws_bwc_unlock_all_queues(ctx);
+	mutex_lock(queue_lock);
+	return at_idx;
+}
+
 int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 				   u32 *match_param,
 				   struct mlx5hws_rule_action rule_actions[],
@@ -809,31 +856,12 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 
 	mutex_lock(queue_lock);
 
-	/* check if rehash needed due to missing action template */
-	at_idx = hws_bwc_matcher_find_at(bwc_matcher, rule_actions);
+	at_idx = hws_bwc_rule_get_at_idx(bwc_rule, rule_actions, bwc_queue_idx);
 	if (unlikely(at_idx < 0)) {
-		/* we need to extend BWC matcher action templates array */
 		mutex_unlock(queue_lock);
-		hws_bwc_lock_all_queues(ctx);
-
-		ret = hws_bwc_matcher_extend_at(bwc_matcher, rule_actions);
-		if (unlikely(ret)) {
-			hws_bwc_unlock_all_queues(ctx);
-			return ret;
-		}
-
-		/* action templates array was extended, we need the last idx */
-		at_idx = bwc_matcher->num_of_at - 1;
-
-		ret = mlx5hws_matcher_attach_at(bwc_matcher->matcher,
-						bwc_matcher->at[at_idx]);
-		if (unlikely(ret)) {
-			hws_bwc_unlock_all_queues(ctx);
-			return ret;
-		}
-
-		hws_bwc_unlock_all_queues(ctx);
-		mutex_lock(queue_lock);
+		mlx5hws_err(ctx, "BWC rule create: failed getting AT (%d)",
+			    ret);
+		return -EINVAL;
 	}
 
 	/* check if number of rules require rehash */
@@ -971,36 +999,11 @@ hws_bwc_rule_action_update(struct mlx5hws_bwc_rule *bwc_rule,
 
 	mutex_lock(queue_lock);
 
-	/* check if rehash needed due to missing action template */
-	at_idx = hws_bwc_matcher_find_at(bwc_matcher, rule_actions);
+	at_idx = hws_bwc_rule_get_at_idx(bwc_rule, rule_actions, idx);
 	if (unlikely(at_idx < 0)) {
-		/* we need to extend BWC matcher action templates array */
 		mutex_unlock(queue_lock);
-		hws_bwc_lock_all_queues(ctx);
-
-		/* check again - perhaps other thread already did extend_at */
-		at_idx = hws_bwc_matcher_find_at(bwc_matcher, rule_actions);
-		if (likely(at_idx < 0)) {
-			ret = hws_bwc_matcher_extend_at(bwc_matcher, rule_actions);
-			if (unlikely(ret)) {
-				hws_bwc_unlock_all_queues(ctx);
-				mlx5hws_err(ctx, "BWC rule update: failed extending AT (%d)", ret);
-				return -EINVAL;
-			}
-
-			/* action templates array was extended, we need the last idx */
-			at_idx = bwc_matcher->num_of_at - 1;
-
-			ret = mlx5hws_matcher_attach_at(bwc_matcher->matcher,
-							bwc_matcher->at[at_idx]);
-			if (unlikely(ret)) {
-				hws_bwc_unlock_all_queues(ctx);
-				return ret;
-			}
-		}
-
-		hws_bwc_unlock_all_queues(ctx);
-		mutex_lock(queue_lock);
+		mlx5hws_err(ctx, "BWC rule update: failed getting AT\n");
+		return -EINVAL;
 	}
 
 	ret = hws_bwc_rule_update_sync(bwc_rule,
-- 
2.31.1


