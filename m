Return-Path: <linux-rdma+bounces-9250-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF34A80D4A
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 16:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910371B62443
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 14:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D011D79A3;
	Tue,  8 Apr 2025 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OJiTWOCw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044481C863C;
	Tue,  8 Apr 2025 14:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744120956; cv=fail; b=mG9stSP9yBxSwxhbyyCZ7AZkZY7oUlTXAoKC8EUhKslnTPPjGlnkC3h2iw2WTq/KitYmEWg/zixKfh0eTGhYpkim4yhTEHbRj0COG/sRA1g0sx2cTX3xfIP29vBfjkNuF7yksVH62a8+bKgFg4S4mdG2u0RKDbilc2SrbD9Sgdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744120956; c=relaxed/simple;
	bh=xHhlC068bjEaQ0eCoJR3KSlzC3Uo4PamLm6llla8/bA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tf8JFtL0PO8YfNw0AkgfzHNmjldzmPuHn0Nu22QsvcgiQPXv2UphzouQ1NO0r+V4duI2GGRzktrdQ6BcKxxhsokDNm6USNkGPMCUECN0Q4HdgzTlyNlU42ZUJD16GMsVxJHSF+PAtbsAusMRlaIiuaANUL6WP4rpogejAPT1Eoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OJiTWOCw; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=On6fUiDEcBSNublzST+yoysQoQhatHEDjz8mAFLbggiHdRbXdGW/6/Quq/8VZyP/GIz8m5CPh1cb19o/5KVjMiznRAAU5F9L6lE9cQjOYGaxXyIQIli/WIPV+YJ4EKaXA3txHuWPurn18lb1O92P+QmI+qmOBz75dY+fdOqT56iD3sUba6irf2fqPBHtR3hhhWjWIO76PJnah/2G7q9xnqdO8BpeQ0VpiX74JK9Wsd07J09xIWHApCBmmGe76ZoadT/uqYi/vwaa875ha/15FAvTNITohNj5YWRD44AeyV/cUOYopImPe+OJFk5AoBVdYhd65YA17PO734XYRWqTgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arpfpvHe0lPUthAjXpg0Br66FKRAmWT5oVWZZm4Xau4=;
 b=uZkWg14Sv61foTb3nNBD2RYzv7IOKDKHEEyE325YSlqoIXeJt2X4u2xn17txoHeo+apaZBSWdBizXsJAM0rteIk2x33Tb779iXpTmMfrPrJAdv4Mfbs34Klns0H0Iz1CMDzwdOwpXmgRoqmBcKqGbAzTtjCf8+eGnoo6FZdqRBaJFcXV8Rk0lehxLzEqahwB0nPxHen3Yq2OgqDqCr07HRGE0cer8KcaDiO0SRTf9IDJQinSkmWmXIM+d4vp4cp8icF9ZarBfIf8/+1dGAL9Te3z8PW3tp+3gSzyTdTIrTw/BvGHjcQdtns2xXfw+e5DddW3dn9pU1Z+VJ7HK192gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arpfpvHe0lPUthAjXpg0Br66FKRAmWT5oVWZZm4Xau4=;
 b=OJiTWOCwtWPqobUVtZOu93kNE5JqTP9PBYasO/dx9pSIBb5MtBx10oYDCNd4D5D18FYmA5qc/HYhZswseF6cpI9jyRSt8ixLkdfSezoMSW1nUx+Fh4O4WmNc0c3ArADMdawLjO0v0JSzk9NktKcRB4D8sS2Powc/Ath1CxTcAQWKJG5dWbxr2F8ECITvC+if5G2mGdqVg5I7cE+u9/pEIxmn9AoF0QLPOx2ibeLyx4Sdp2qbVDQ6YkoU7jMWYKARD+w+d95YBdFDquW0EHL5CEFdv3ZUqCCG9HU2ezRexwTgeFmKnd8AScojf2GKmxxxjbhAfatjqugq4cCiN7TZeA==
Received: from BN7PR06CA0057.namprd06.prod.outlook.com (2603:10b6:408:34::34)
 by SN7PR12MB7418.namprd12.prod.outlook.com (2603:10b6:806:2a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 8 Apr
 2025 14:02:24 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:34:cafe::a2) by BN7PR06CA0057.outlook.office365.com
 (2603:10b6:408:34::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.19 via Frontend Transport; Tue,
 8 Apr 2025 14:02:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 14:02:23 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Apr 2025
 07:02:04 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 8 Apr
 2025 07:02:04 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 8 Apr
 2025 07:01:59 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: [PATCH net-next 01/12] net/mlx5: HWS, Fix matcher action template attach
Date: Tue, 8 Apr 2025 17:00:45 +0300
Message-ID: <1744120856-341328-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1744120856-341328-1-git-send-email-tariqt@nvidia.com>
References: <1744120856-341328-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|SN7PR12MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: a99ec006-527d-4927-3f4d-08dd76a5fcc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d2f0gzh7NLUNFFykTNn5K6cIW4QMYuzk3/yKl7BsONRNLzezil2vGWz5mcO0?=
 =?us-ascii?Q?Yo6MuUqT9BIwfbgxvloj3j+yrjYmEoRq/vmUDoyW9FewMLGqi3Q+e611TUqU?=
 =?us-ascii?Q?Q/+JVZLkgbGY29cWJZvUIcux79sbccCGLnCt4NiY134oT7JVndxufoBqPhXM?=
 =?us-ascii?Q?HOUBtVJBjsVw5rejIYYotBpcPXaoMW2EbptSwf7BJpvF3s4QUEavRrWx4rYw?=
 =?us-ascii?Q?9TyRqMk6OnJz/2emks+ifP02cpgW3VAX0Mr9jpgqlISRuDqO80Xkm2JGP4dZ?=
 =?us-ascii?Q?pPZkH4fIEydycwjz0nfjwjDeuPR3VG3c3Yb3EHNucEKcul8pbzg4hD9okSth?=
 =?us-ascii?Q?srCzDt1jjAKomCQ4b1EH6qK2QhbmP+sglvAXz7dln2GR28KEv14cTZnGZtUS?=
 =?us-ascii?Q?X6qjmCynuXOqdx/bbKYr7igombP2KoJ8aciGafJMcBbu1hDVKW6FYAUjVK3E?=
 =?us-ascii?Q?B7MqeHWNpiTd9vkkSNjtA+pb15P59XKHUGEnn+DixWmNHLxkaNOlsS/uBRKt?=
 =?us-ascii?Q?sHvsV6535ft92lq+BBlRr31Q2NCDfVxqUWkX5ta3Jf5dtEY4ID1EHLN5MrvA?=
 =?us-ascii?Q?pCpG9hQYTvhR7JDCTehbGdhKlmMe4wkevgZlqSxJ9Cgvw0MJj83hxWQS4cnt?=
 =?us-ascii?Q?mer//BrC8zSdekNguRRHa2vXu9o94t6Rvoe/7Kk+pz1rqTF64IHp5YhnGLvr?=
 =?us-ascii?Q?sis0QOM1BYaQgqHkGwSZ8WlDTM9p7+KwtBhTWCU0h2RJrS0W6UrxnfRAqvo8?=
 =?us-ascii?Q?IQWjiIJoL7fxaBren8R7OiTo6fqgxtt1gf/hD61k5hW7L096rwAknDjgQ69J?=
 =?us-ascii?Q?G2paT/hYH9PWpG6Okr6GlJL1JywlVNk4nleVw1ZoYnwleNMtceGV54dwNJ1d?=
 =?us-ascii?Q?jEfZJAkqcuR00qVO9cd3vOdEsSLItn5tjAtRn2HwtnUwsb6ZXoWHyUMwzCTm?=
 =?us-ascii?Q?iyB1ahGQ9W1sM+/zJZwm0YSUTLZ8WmF6QxbOMJU3kwDye11JUaNz0Z3AiDh4?=
 =?us-ascii?Q?EQKnwLJU3EW9yDGRPb/2AeFDQIbW2TwSGUuynqRqwPKzTH9TwJxVD0Ya4+1/?=
 =?us-ascii?Q?FhMRUZhBzGfW0s5UYNWf8Q91le7ditTk4J1wUBqizChBZ0aMioyjbPkdtFMk?=
 =?us-ascii?Q?ioEf86ay82/iX79t9+hjogwk8a1Dt2RNO5yX2nnbS2BLURJ0iu+Evf8252lO?=
 =?us-ascii?Q?RTIyY1bLCpxo8+TSxUgoPdSa5xzcSaaN2+o+Oc+LJHbe1sSj0uTxowcZoy/N?=
 =?us-ascii?Q?rB3DEFJj8MoFdFihLf4l4Mnk9/BrHYgg58cuq2hx7WbEdSyVkRJkt9nxFBmG?=
 =?us-ascii?Q?OwlRTEwfjdjr8LzcSjaqGQNJAxTNToUL0WEOdlqkZyKIsqdAQXT4XuqWbT03?=
 =?us-ascii?Q?AbRsHG7Wq7F56xhOKmLhFkGSk0SdNDFfV/jFotbMCZulLP0YMyBlHm9g888G?=
 =?us-ascii?Q?wstoePnY3oqVhGsN27WIRw9zIQ32E//zgFo9p/szSxsrCd79RKueqJNVQd23?=
 =?us-ascii?Q?072+s3Oi6C9phRQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 14:02:23.6873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a99ec006-527d-4927-3f4d-08dd76a5fcc2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7418

From: Vlad Dogaru <vdogaru@nvidia.com>

The procedure of attaching an action template to an existing matcher had
a few issues:

1. Attaching accidentally overran the `at` array in bwc_matcher, which
   would result in memory corruption. This bug wasn't triggered, but it
   is possible to trigger it by attaching action templates beyond the
   initial buffer size of 8. Fix this by converting to a dynamically
   sized buffer and reallocating if needed.

2. Similarly, the `at` array inside the native matcher was never
   reallocated. Fix this the same as above.

3. The bwc layer treated any error in action template attach as a signal
   that the matcher should be rehashed to account for a larger number of
   action STEs. In reality, there are other unrelated errors that can
   arise and they should be propagated upstack. Fix this by adding a
   `need_rehash` output parameter that's orthogonal to error codes.

Fixes: 2111bb970c78 ("net/mlx5: HWS, added backward-compatible API handling")
Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/bwc.c     | 55 ++++++++++++++++---
 .../mellanox/mlx5/core/steering/hws/bwc.h     |  9 ++-
 .../mellanox/mlx5/core/steering/hws/matcher.c | 48 +++++++++++++---
 .../mellanox/mlx5/core/steering/hws/matcher.h |  4 ++
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h |  5 +-
 5 files changed, 97 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
index 19dce1ba512d..32de8bfc7644 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
@@ -90,13 +90,19 @@ int mlx5hws_bwc_matcher_create_simple(struct mlx5hws_bwc_matcher *bwc_matcher,
 	bwc_matcher->priority = priority;
 	bwc_matcher->size_log = MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG;
 
+	bwc_matcher->size_of_at_array = MLX5HWS_BWC_MATCHER_ATTACH_AT_NUM;
+	bwc_matcher->at = kcalloc(bwc_matcher->size_of_at_array,
+				  sizeof(*bwc_matcher->at), GFP_KERNEL);
+	if (!bwc_matcher->at)
+		goto free_bwc_matcher_rules;
+
 	/* create dummy action template */
 	bwc_matcher->at[0] =
 		mlx5hws_action_template_create(action_types ?
 					       action_types : init_action_types);
 	if (!bwc_matcher->at[0]) {
 		mlx5hws_err(table->ctx, "BWC matcher: failed creating action template\n");
-		goto free_bwc_matcher_rules;
+		goto free_bwc_matcher_at_array;
 	}
 
 	bwc_matcher->num_of_at = 1;
@@ -126,6 +132,8 @@ int mlx5hws_bwc_matcher_create_simple(struct mlx5hws_bwc_matcher *bwc_matcher,
 	mlx5hws_match_template_destroy(bwc_matcher->mt);
 free_at:
 	mlx5hws_action_template_destroy(bwc_matcher->at[0]);
+free_bwc_matcher_at_array:
+	kfree(bwc_matcher->at);
 free_bwc_matcher_rules:
 	kfree(bwc_matcher->rules);
 err:
@@ -192,6 +200,7 @@ int mlx5hws_bwc_matcher_destroy_simple(struct mlx5hws_bwc_matcher *bwc_matcher)
 
 	for (i = 0; i < bwc_matcher->num_of_at; i++)
 		mlx5hws_action_template_destroy(bwc_matcher->at[i]);
+	kfree(bwc_matcher->at);
 
 	mlx5hws_match_template_destroy(bwc_matcher->mt);
 	kfree(bwc_matcher->rules);
@@ -520,6 +529,23 @@ hws_bwc_matcher_extend_at(struct mlx5hws_bwc_matcher *bwc_matcher,
 			  struct mlx5hws_rule_action rule_actions[])
 {
 	enum mlx5hws_action_type action_types[MLX5HWS_BWC_MAX_ACTS];
+	void *p;
+
+	if (unlikely(bwc_matcher->num_of_at >= bwc_matcher->size_of_at_array)) {
+		if (bwc_matcher->size_of_at_array >= MLX5HWS_MATCHER_MAX_AT)
+			return -ENOMEM;
+		bwc_matcher->size_of_at_array *= 2;
+		p = krealloc(bwc_matcher->at,
+			     bwc_matcher->size_of_at_array *
+				     sizeof(*bwc_matcher->at),
+			     __GFP_ZERO | GFP_KERNEL);
+		if (!p) {
+			bwc_matcher->size_of_at_array /= 2;
+			return -ENOMEM;
+		}
+
+		bwc_matcher->at = p;
+	}
 
 	hws_bwc_rule_actions_to_action_types(rule_actions, action_types);
 
@@ -777,6 +803,7 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 	struct mlx5hws_rule_attr rule_attr;
 	struct mutex *queue_lock; /* Protect the queue */
 	u32 num_of_rules;
+	bool need_rehash;
 	int ret = 0;
 	int at_idx;
 
@@ -803,10 +830,14 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 		at_idx = bwc_matcher->num_of_at - 1;
 
 		ret = mlx5hws_matcher_attach_at(bwc_matcher->matcher,
-						bwc_matcher->at[at_idx]);
+						bwc_matcher->at[at_idx],
+						&need_rehash);
 		if (unlikely(ret)) {
-			/* Action template attach failed, possibly due to
-			 * requiring more action STEs.
+			hws_bwc_unlock_all_queues(ctx);
+			return ret;
+		}
+		if (unlikely(need_rehash)) {
+			/* The new action template requires more action STEs.
 			 * Need to attempt creating new matcher with all
 			 * the action templates, including the new one.
 			 */
@@ -942,6 +973,7 @@ hws_bwc_rule_action_update(struct mlx5hws_bwc_rule *bwc_rule,
 	struct mlx5hws_context *ctx = bwc_matcher->matcher->tbl->ctx;
 	struct mlx5hws_rule_attr rule_attr;
 	struct mutex *queue_lock; /* Protect the queue */
+	bool need_rehash;
 	int at_idx, ret;
 	u16 idx;
 
@@ -973,12 +1005,17 @@ hws_bwc_rule_action_update(struct mlx5hws_bwc_rule *bwc_rule,
 			at_idx = bwc_matcher->num_of_at - 1;
 
 			ret = mlx5hws_matcher_attach_at(bwc_matcher->matcher,
-							bwc_matcher->at[at_idx]);
+							bwc_matcher->at[at_idx],
+							&need_rehash);
 			if (unlikely(ret)) {
-				/* Action template attach failed, possibly due to
-				 * requiring more action STEs.
-				 * Need to attempt creating new matcher with all
-				 * the action templates, including the new one.
+				hws_bwc_unlock_all_queues(ctx);
+				return ret;
+			}
+			if (unlikely(need_rehash)) {
+				/* The new action template requires more action
+				 * STEs. Need to attempt creating new matcher
+				 * with all the action templates, including the
+				 * new one.
 				 */
 				ret = hws_bwc_matcher_rehash_at(bwc_matcher);
 				if (unlikely(ret)) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
index 47f7ed141553..bb0cf4b922ce 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
@@ -10,9 +10,7 @@
 #define MLX5HWS_BWC_MATCHER_REHASH_BURST_TH 32
 
 /* Max number of AT attach operations for the same matcher.
- * When the limit is reached, next attempt to attach new AT
- * will result in creation of a new matcher and moving all
- * the rules to this matcher.
+ * When the limit is reached, a larger buffer is allocated for the ATs.
  */
 #define MLX5HWS_BWC_MATCHER_ATTACH_AT_NUM 8
 
@@ -23,10 +21,11 @@
 struct mlx5hws_bwc_matcher {
 	struct mlx5hws_matcher *matcher;
 	struct mlx5hws_match_template *mt;
-	struct mlx5hws_action_template *at[MLX5HWS_BWC_MATCHER_ATTACH_AT_NUM];
-	u32 priority;
+	struct mlx5hws_action_template **at;
 	u8 num_of_at;
+	u8 size_of_at_array;
 	u8 size_log;
+	u32 priority;
 	atomic_t num_of_rules;
 	struct list_head *rules;
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
index b61864b32053..37a4497048a6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
@@ -905,18 +905,48 @@ static int hws_matcher_uninit(struct mlx5hws_matcher *matcher)
 	return 0;
 }
 
+static int hws_matcher_grow_at_array(struct mlx5hws_matcher *matcher)
+{
+	void *p;
+
+	if (matcher->size_of_at_array >= MLX5HWS_MATCHER_MAX_AT)
+		return -ENOMEM;
+
+	matcher->size_of_at_array *= 2;
+	p = krealloc(matcher->at,
+		     matcher->size_of_at_array * sizeof(*matcher->at),
+		     __GFP_ZERO | GFP_KERNEL);
+	if (!p) {
+		matcher->size_of_at_array /= 2;
+		return -ENOMEM;
+	}
+
+	matcher->at = p;
+
+	return 0;
+}
+
 int mlx5hws_matcher_attach_at(struct mlx5hws_matcher *matcher,
-			      struct mlx5hws_action_template *at)
+			      struct mlx5hws_action_template *at,
+			      bool *need_rehash)
 {
 	bool is_jumbo = mlx5hws_matcher_mt_is_jumbo(matcher->mt);
 	struct mlx5hws_context *ctx = matcher->tbl->ctx;
 	u32 required_stes;
 	int ret;
 
-	if (!matcher->attr.max_num_of_at_attach) {
-		mlx5hws_dbg(ctx, "Num of current at (%d) exceed allowed value\n",
-			    matcher->num_of_at);
-		return -EOPNOTSUPP;
+	*need_rehash = false;
+
+	if (unlikely(matcher->num_of_at >= matcher->size_of_at_array)) {
+		ret = hws_matcher_grow_at_array(matcher);
+		if (ret)
+			return ret;
+
+		if (matcher->col_matcher) {
+			ret = hws_matcher_grow_at_array(matcher->col_matcher);
+			if (ret)
+				return ret;
+		}
 	}
 
 	ret = hws_matcher_check_and_process_at(matcher, at);
@@ -927,12 +957,11 @@ int mlx5hws_matcher_attach_at(struct mlx5hws_matcher *matcher,
 	if (matcher->action_ste.max_stes < required_stes) {
 		mlx5hws_dbg(ctx, "Required STEs [%d] exceeds initial action template STE [%d]\n",
 			    required_stes, matcher->action_ste.max_stes);
-		return -ENOMEM;
+		*need_rehash = true;
 	}
 
 	matcher->at[matcher->num_of_at] = *at;
 	matcher->num_of_at += 1;
-	matcher->attr.max_num_of_at_attach -= 1;
 
 	if (matcher->col_matcher)
 		matcher->col_matcher->num_of_at = matcher->num_of_at;
@@ -960,8 +989,9 @@ hws_matcher_set_templates(struct mlx5hws_matcher *matcher,
 	if (!matcher->mt)
 		return -ENOMEM;
 
-	matcher->at = kvcalloc(num_of_at + matcher->attr.max_num_of_at_attach,
-			       sizeof(*matcher->at),
+	matcher->size_of_at_array =
+		num_of_at + matcher->attr.max_num_of_at_attach;
+	matcher->at = kvcalloc(matcher->size_of_at_array, sizeof(*matcher->at),
 			       GFP_KERNEL);
 	if (!matcher->at) {
 		mlx5hws_err(ctx, "Failed to allocate action template array\n");
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h
index 020de70270c5..20b32012c418 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h
@@ -23,6 +23,9 @@
  */
 #define MLX5HWS_MATCHER_ACTION_RTC_UPDATE_MULT 1
 
+/* Maximum number of action templates that can be attached to a matcher. */
+#define MLX5HWS_MATCHER_MAX_AT 128
+
 enum mlx5hws_matcher_offset {
 	MLX5HWS_MATCHER_OFFSET_TAG_DW1 = 12,
 	MLX5HWS_MATCHER_OFFSET_TAG_DW0 = 13,
@@ -72,6 +75,7 @@ struct mlx5hws_matcher {
 	struct mlx5hws_match_template *mt;
 	struct mlx5hws_action_template *at;
 	u8 num_of_at;
+	u8 size_of_at_array;
 	u8 num_of_mt;
 	/* enum mlx5hws_matcher_flags */
 	u8 flags;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
index 5121951f2778..8ed8a715a2eb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
@@ -399,11 +399,14 @@ int mlx5hws_matcher_destroy(struct mlx5hws_matcher *matcher);
  *
  * @matcher: Matcher to attach the action template to.
  * @at: Action template to be attached to the matcher.
+ * @need_rehash: Output parameter that tells callers if the matcher needs to be
+ * rehashed.
  *
  * Return: Zero on success, non-zero otherwise.
  */
 int mlx5hws_matcher_attach_at(struct mlx5hws_matcher *matcher,
-			      struct mlx5hws_action_template *at);
+			      struct mlx5hws_action_template *at,
+			      bool *need_rehash);
 
 /**
  * mlx5hws_matcher_resize_set_target - Link two matchers and enable moving rules.
-- 
2.31.1


