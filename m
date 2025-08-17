Return-Path: <linux-rdma+bounces-12800-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 563ABB29500
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Aug 2025 22:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 061864E1916
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Aug 2025 20:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CA72FF15E;
	Sun, 17 Aug 2025 20:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KWkOwYm7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9432723F26A;
	Sun, 17 Aug 2025 20:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755462231; cv=fail; b=giXlUJFGuB8h3GmSRL4IldrjWUBRXnZ2AhEAEQeab2HEl/Q9UmtVyqumk41ufv2G5JigPM1NDel3YV3sgtXNtrTZPJEXqZLiX2vaC6cyWkfXGq0Pufmn86FJqXTXQCC4talDayDeJgSAisiqYvTIhJam95EEn1HGpjT21JTyRCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755462231; c=relaxed/simple;
	bh=2TtNVIpm2FQnpNy3noCbxrOAnTZ60OhIzfNE63zJ2Yc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DaU6yObZf2C69OCIOx5EnmaNrPBP63ZZni+nSyQZRni3lmT/H5kHEteOka7X1RQKZ5SHg0lF0hBdZgbD4yjxFK9GhO9ZbYF9NOvSadMySjGMmyG3wHGXf8Ic9GyTOqWlFTGpQGrA8XArQixJSJ2IWBpLLBMTqojuWKHD8GJxEo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KWkOwYm7; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3yl3wn6X3kT6JcKHTnRALEN5ld75LgIHCLgZhSG0AqvwrNNZb7Z5DfgLwLmwyAxh+zdqm/jTtWgzt6N7JzuXBdnYGWwXBbdYaunIVZs48+fBLy66FDILvmXRKrnVY1p4TIxsy/3JR7UuDkIe+sdTJLoVschqj3w80H500vdOIOwjSYRovY90C10tU2zB9o7x1XX2olUkjjSMFHYPf6+L35jlpMtr9uNLrxPw8alc8Q2E6UdJHMmmwXZdwRnxh9e+prfSsGmSYnxlpFWL+l/+n9X6VSLVoSWOmGRqlaCzgdvm0W21VfICacr5x9ja3F9vwJwYJpM4ByEctwP5wgl9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekZxLlnEbfN3tXFvCSOmG5esOOTZMVzwbzKl3Q660Us=;
 b=Cps7q9jlmFCnplWxuraWSBJ/kPYQvjKeCSJSHvra5NVg+arx9E5iP+Qm5nLF9ifQhdG0Lvqyxch7aW3uAGjhBKv+gcPeMIEpnGWL8yoSFjxtALWoVzATIwszit/XRrZl027QAM8TJQ8VJA51WfPbG4UTGpoFlYwhediSpUHN/lnR9FGHfSxCFm/DZnHkBOTSt2kXbnNfZsID7XJmj6JiSPqeeVvql0sY9JByCIolKOvKWuBFm3Rtd8Rz3dG1d2yVcx+s1AEn3Q1iMdvcz7ZcomPol8UjpcWQh7bfDsF4iMNamxJPRRTWthl0QFM3MP4R8rgswuJ8T2h00iAWdEMVFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekZxLlnEbfN3tXFvCSOmG5esOOTZMVzwbzKl3Q660Us=;
 b=KWkOwYm71hgHcYSmQAbQ84NJ75FSBGZeERFEGJKxv8vYgWGuxOVJeabgjksyCwiYeIYUVwyfaPe6lTvM1AHmEsfTnVEsXngGRhaLThkv77f6owB7ZWG525rBJVG6+y+i6pWoL9B2QNUYpJzuU75EAgmJ85Fw/cJTVkVgSnISI8Uqs0RHcaGF+zoRYROacl1ZihBHxHFYrXhCna1ppyDEzWBTeBoSi+wD7TZGTBhUUfP8UZRN+Xh42ZYkqc5DCJjntwlMEf0M4Cdat+/Thskr3THkIbK5Ls8X6wqCMqVFpym5Gxoehijoj53egmD3Sb4aGpDU26OL5SlPI4rl/ZG5sg==
Received: from CH2PR20CA0017.namprd20.prod.outlook.com (2603:10b6:610:58::27)
 by LV3PR12MB9213.namprd12.prod.outlook.com (2603:10b6:408:1a6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Sun, 17 Aug
 2025 20:23:45 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::c) by CH2PR20CA0017.outlook.office365.com
 (2603:10b6:610:58::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Sun,
 17 Aug 2025 20:23:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Sun, 17 Aug 2025 20:23:45 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 17 Aug
 2025 13:23:44 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 17 Aug 2025 13:23:43 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 17 Aug 2025 13:23:40 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net 3/7] net/mlx5: HWS, fix complex rules rehash error flow
Date: Sun, 17 Aug 2025 23:23:19 +0300
Message-ID: <20250817202323.308604-4-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250817202323.308604-1-mbloch@nvidia.com>
References: <20250817202323.308604-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|LV3PR12MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd8cd39-ef74-4369-14d1-08ddddcbf747
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fypewuRk2g1yCGeT5H4W2A96afQTODQckhxpN4o9YtDZJOMioe9IEz77kFa2?=
 =?us-ascii?Q?XJlxRCWK/FXNqn038dK0OSXHz3WdUq+h3PUbnk2P53GQmRLBmJfeGusxOhQ6?=
 =?us-ascii?Q?2oQs1oAiKNyGgXtwXF7It2HrbUIrnRUEwwUwFwcM3vPO0s3IY9vpzi6uXlaG?=
 =?us-ascii?Q?diln5/gKSQypTtnjQBm/vE/2V+tgDEs4LqAYNbOWf6ywbsf1e7yyFR+5O4yE?=
 =?us-ascii?Q?vPjxwOI8KVwzo/v8FSB5FeGCgrUtpzKLBkTAVTKeKxSqQeNbOXk/CbRqX/25?=
 =?us-ascii?Q?FnoRLiksL09K9jHQaRNqypCVaF3qHq9k0ukTQfrYyBPirRtorRJ0EbRzNt5T?=
 =?us-ascii?Q?3A6+0I/BTOkG/yrnldqytpTsuoqBjSZiNDRaRIfCenlV5vp4kVQA3UsDQEml?=
 =?us-ascii?Q?sp1JWqV6f07qlpwsg+1F5f7hbmkUbzt3+n3qRhZIaAauP2DxD5QxwY9yVS9q?=
 =?us-ascii?Q?UvYH4cQdeJJIa64F+9ZM/Od/bIimDe4jtKmAQlbKHrOi2/fRoCrgiBbglPk2?=
 =?us-ascii?Q?rNiFIuL0jwcPEn8JdI+pRg4Lg4340aZYxmIAT9GK2hVlrhJrzsQ7hJPUWjga?=
 =?us-ascii?Q?q6Eg2cXc8x2mtptu+mVRIotMHz5OhVN8qSQZG9/NlzMrW4K8gA/2JikP/oQi?=
 =?us-ascii?Q?vHO/CO8zTra98wbH8XwnKBiBIOF8+ee3d20CjOV314ekXthF5KnANh99ZyKt?=
 =?us-ascii?Q?806t5BA9yzVP03XfKwooY+wHkeMU1CPA8DXNaQdnX0Oz67PLK6GPd380g1Go?=
 =?us-ascii?Q?hYhRK99MJUI6S69Lmlp0THMyajVwX47yBeytj5psy8UyHORzECJzbxGPFBRx?=
 =?us-ascii?Q?1TxftGzxLdodJBuXoz1cfm88P5Ion8L3dvDbJQHQlKNe+VNLlzrhnj3yPzrz?=
 =?us-ascii?Q?tnlAsM2e8WYBB+v+DmEWK+aiBZiyWbTMCrN7Vqd4qnFk08ehnHsv2S5I0ifq?=
 =?us-ascii?Q?eLzaqay3bCL+B7KJ2xZX451eTuczuqXRZhUsc9y0LJlKi9tRvL6KTO01nkNR?=
 =?us-ascii?Q?cFNUtjnW9vN9HsRJv1VYNiejPeyDeUKvbg1b46XpihOZFDi/tVCUKqtT1omC?=
 =?us-ascii?Q?wb8FUI0ykFdMk4tHGXj0wCK9K03pa35HLNHzVEl7INwyFP1txqc1cip/Uq2b?=
 =?us-ascii?Q?m/GaCslaCm8GRNru/fiIZ85Xx7eQPY4m+qWnzG8AOD70Zz1xCH+lWarCq0nE?=
 =?us-ascii?Q?0zLkhHBDS/7jFN0J6SG4H2i/uFiBnMtufCzAqyOPaWyPEATD5WOpBroacS3X?=
 =?us-ascii?Q?5Dlt00IwpMJT/T0i3rLIErjDPgtZo6esGZbuK1RCwHHWTFr3jMlOhNnsmGTP?=
 =?us-ascii?Q?kR6MfGVkcGeUvORqWRsPQ09vDtwNHSHkUmdh7jbitXjUNg0AuTxAMFAQJ8WA?=
 =?us-ascii?Q?7bifNuvnlqMmiXwkUqRQCp31jk/rZ2dP7JWzlHVLBlW3jrzdgCjt5btJVaXx?=
 =?us-ascii?Q?7DeITCOSgrT6pCUBSofhwjKCoyk6Mo9reJ7slpdTIaobMsS8ZaDP6SRzfrLH?=
 =?us-ascii?Q?yWpNfYmPCUN3N8VJJ7dxm+ViKgCRv1Aeaxz6?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2025 20:23:45.1710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd8cd39-ef74-4369-14d1-08ddddcbf747
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9213

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Moving rules from matcher to matcher should not fail.
However, if it does fail due to various reasons, the error flow
should allow the kernel to continue functioning (albeit with broken
steering rules) instead of going into series of soft lock-ups or
some other problematic behaviour.

Similar to the simple rules, complex rules rehash logic suffers
from the same problems. This patch fixes the error flow for moving
complex rules:
 - If new rule creation fails before it was even enqeued, do not
   poll for completion
 - If TIMEOUT happened while moving the rule, no point trying
   to poll for completions for other rules. Something is broken,
   completion won't come, just abort the rehash sequence.
 - If some other completion with error received, don't give up.
   Continue handling rest of the rules to minimize the damage.
 - Make sure that the first error code that was received will
   be actually returned to the caller instead of replacing it
   with the generic error code.

All the aforementioned issues stem from the same bad error flow,
so no point fixing them one by one and leaving partially broken
code - fixing them in one patch.

Fixes: 17e0accac577 ("net/mlx5: HWS, support complex matchers")
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Vlad Dogaru <vdogaru@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../mlx5/core/steering/hws/bwc_complex.c      | 41 +++++++++++++------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c
index ca7501c57468..14e79579c719 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c
@@ -1328,11 +1328,11 @@ mlx5hws_bwc_matcher_move_all_complex(struct mlx5hws_bwc_matcher *bwc_matcher)
 {
 	struct mlx5hws_context *ctx = bwc_matcher->matcher->tbl->ctx;
 	struct mlx5hws_matcher *matcher = bwc_matcher->matcher;
-	bool move_error = false, poll_error = false;
 	u16 bwc_queues = mlx5hws_bwc_queues(ctx);
 	struct mlx5hws_bwc_rule *tmp_bwc_rule;
 	struct mlx5hws_rule_attr rule_attr;
 	struct mlx5hws_table *isolated_tbl;
+	int move_error = 0, poll_error = 0;
 	struct mlx5hws_rule *tmp_rule;
 	struct list_head *rules_list;
 	u32 expected_completions = 1;
@@ -1391,11 +1391,15 @@ mlx5hws_bwc_matcher_move_all_complex(struct mlx5hws_bwc_matcher *bwc_matcher)
 			ret = mlx5hws_matcher_resize_rule_move(matcher,
 							       tmp_rule,
 							       &rule_attr);
-			if (unlikely(ret && !move_error)) {
-				mlx5hws_err(ctx,
-					    "Moving complex BWC rule failed (%d), attempting to move rest of the rules\n",
-					    ret);
-				move_error = true;
+			if (unlikely(ret)) {
+				if (!move_error) {
+					mlx5hws_err(ctx,
+						    "Moving complex BWC rule: move failed (%d), attempting to move rest of the rules\n",
+						    ret);
+					move_error = ret;
+				}
+				/* Rule wasn't queued, no need to poll */
+				continue;
 			}
 
 			expected_completions = 1;
@@ -1403,11 +1407,19 @@ mlx5hws_bwc_matcher_move_all_complex(struct mlx5hws_bwc_matcher *bwc_matcher)
 						     rule_attr.queue_id,
 						     &expected_completions,
 						     true);
-			if (unlikely(ret && !poll_error)) {
-				mlx5hws_err(ctx,
-					    "Moving complex BWC rule: poll failed (%d), attempting to move rest of the rules\n",
-					    ret);
-				poll_error = true;
+			if (unlikely(ret)) {
+				if (ret == -ETIMEDOUT) {
+					mlx5hws_err(ctx,
+						    "Moving complex BWC rule: timeout polling for completions (%d), aborting rehash\n",
+						    ret);
+					return ret;
+				}
+				if (!poll_error) {
+					mlx5hws_err(ctx,
+						    "Moving complex BWC rule: polling for completions failed (%d), attempting to move rest of the rules\n",
+						    ret);
+					poll_error = ret;
+				}
 			}
 
 			/* Done moving the rule to the new matcher,
@@ -1422,8 +1434,11 @@ mlx5hws_bwc_matcher_move_all_complex(struct mlx5hws_bwc_matcher *bwc_matcher)
 		}
 	}
 
-	if (move_error || poll_error)
-		ret = -EINVAL;
+	/* Return the first error that happened */
+	if (unlikely(move_error))
+		return move_error;
+	if (unlikely(poll_error))
+		return poll_error;
 
 	return ret;
 }
-- 
2.34.1


