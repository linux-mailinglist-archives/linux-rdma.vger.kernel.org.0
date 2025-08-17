Return-Path: <linux-rdma+bounces-12799-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3BCB294FF
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Aug 2025 22:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3257B189AFFC
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Aug 2025 20:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F752FE076;
	Sun, 17 Aug 2025 20:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TbiklarD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFB5221DB1;
	Sun, 17 Aug 2025 20:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755462231; cv=fail; b=O/TQHFq1FE9268WvZyZ+ouhkOZjbkuVZXnJ8eQJQel8NDX1hpEcBTvM7v/XNKq+Cp4SZdOSdcEZtVAW0neemeFKsGWNBw/BBaczNzRILySyOL3VjFiB2aDQZnwptPRDC/JbES/mKO6CS4HPoRczepZeLrMXTT5w5Dgc3LTD4HBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755462231; c=relaxed/simple;
	bh=VD2P1Z/cuyXaxU+/BujTt9sPH/DOmYmpjfzlYrGdMeU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tb5gVSGif6ovwcqMoENim8DKhajiFwIXEydn8HcEDCCqXIxmayPP31kmxMzsOv1ktqi772cZ5om2RZpaRkEY7O0xkxM3+/Z9gRpYL+rT9cz0Ae3wckMUhdXZ8xpW2NfJvDwrRV6KcH9vczfMJ46y15YWBX+N+8xEgkaHa4oTNW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TbiklarD; arc=fail smtp.client-ip=40.107.236.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Af4ExIpWqJybiVfm8VivshaJP9SLzth2YYbPREm/UtmAfX+u58Mq3zVgtsR2TEdDtqWDTcVW/R0TwF3s4TqNeWu0GLJFPTlKM40ebmjqb+tj/jMvhLPFJdlgUlwUwMrGDJN7nShirQ6hamRqHMMGDmW2d3QeMTvstnglGHmi0V1wB1jkhTyB2o0AHQ0aBXAjE+806Z2bdz/enox+qEZQxccA4cNhkyYOdomWgfH0bfJ9z/SykDroNRZAXMvh0ZxmDXRnPnDMU/+X/HHeIUfpOop37Z41QvBcrrxlZPHLeZSXznnOEiF28RsnP5NX7XFYsf36x9NCzBOV1a8hpLwB7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1n27i7KQlUF8crVOrOU0N6l9II3c77PwH65A0ZTtD0=;
 b=muTlpk4wLOFKSY4hdINo0HnvxUTLZbLrpW51xHHSfL1qUfGEXAjD28LAjb8D3lTgNLagKvrhpTQhPAE1lCLygLkxRCvwZwId2PhezXcqbNbKYTz8/FqHGGdTosZYPJiVuDTt5QD907xx4F0EqfM/i/weHpohUrMk7fjZQkcX1q67erBfwlpXQHWCMjV2507g63TvgGje9a15dzG222W9zwhrsacpyd6IP3tN5fDrHcVjMqyVjirWR8pRN9G08QQmoSZkrPvhjt+wlw24O95capQ03igR85f4dY3sQiLQKQ62VgPeA9HFM7fDQA+3egPuur+9QTgWbYbSa3yC9pEDgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1n27i7KQlUF8crVOrOU0N6l9II3c77PwH65A0ZTtD0=;
 b=TbiklarD1WSpJOxju7repmPUf2mRwHuBfdUMqOejxi4j2c4Zgup5LyYpXfcqfYUy/VByIDJz+U2zSfaymBpmafT5FPW458h3ZyrlwoHuxMqFNV6ZRyMWj8V/R2l7Nk0FU/l4Qdywdeq1o7bzVT/Eor7ZoPRImIxae1t3wBzRKTxXjDrr2OeYy463FspoQvOwPMD8gRNc4UVvFkaGnCq70Qh9IiAY2+lhhTPm29pfNbqo5vVRLWnoOlykzyay8JZq4iTa11AJxY9OMnDkwEoIHtrJCCkRAvALJUIC2cejt5vswv4F2zcsBERGReeLjdkg5CcUI5ufkwgoVDX5PIlxjQ==
Received: from BN9PR03CA0127.namprd03.prod.outlook.com (2603:10b6:408:fe::12)
 by BL3PR12MB6403.namprd12.prod.outlook.com (2603:10b6:208:3b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Sun, 17 Aug
 2025 20:23:42 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:408:fe:cafe::ba) by BN9PR03CA0127.outlook.office365.com
 (2603:10b6:408:fe::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Sun,
 17 Aug 2025 20:23:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Sun, 17 Aug 2025 20:23:42 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 17 Aug
 2025 13:23:40 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 17 Aug 2025 13:23:39 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 17 Aug 2025 13:23:36 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net 2/7] net/mlx5: HWS, fix simple rules rehash error flow
Date: Sun, 17 Aug 2025 23:23:18 +0300
Message-ID: <20250817202323.308604-3-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|BL3PR12MB6403:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a09e03-8057-4fd0-4c0e-08ddddcbf592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Kgm2k+7tByXQ8dwx07OAglLE33B1haURd31KySv6htUkAxQMFNC+IJopmFY?=
 =?us-ascii?Q?XrwJ0OCy+CfqDmToHXKCpIVnhsFIE+YKdfmQ8wW+vGxHACQlO2wuSoRZvE4L?=
 =?us-ascii?Q?qiet8sd0EoD9pf6+fIVkyPbRm/ZnSiqejdQzHoMkFKxA1QmHRWu57CgBQz/b?=
 =?us-ascii?Q?IIuZpA8PDsn7DCLAxqPbGr4eleyKH9Oeieg5mXXcUZA0m9bH47W4L+Hh7GUQ?=
 =?us-ascii?Q?jrNgvhWAFKzumuTEiCk8StWp3kYjQ2RNAl9Eejx/YkG+HceKyGC9lwEwm8xO?=
 =?us-ascii?Q?daqfKtT0Jhz43/zOgXy6eivlkwH9Fp2UN6dOX4xQ8LuzRsmglaBEI6Cd0Q4x?=
 =?us-ascii?Q?Uv6M0cMQJyiBCz4zb8FC4eHNc78kNolDF9VT/BW/EeL9mBP63W12bTXU3BAM?=
 =?us-ascii?Q?gveSc+6aAbjxdkYowPPtM0Bb6yx+OhLXX9X4WnCbFx/cD9DGDQKFMkY0Q64K?=
 =?us-ascii?Q?Z0TLZEmPXWvd5dSyZ6LG3pPKIckJ5qgH/JW/jG9RzeFZqGxKagawraua0WB0?=
 =?us-ascii?Q?6JtHkzDcrq8M8hQu+NvjH5Ud7acNdrn2SLd6AIE6Zj8gYr6mZc9gJjWFyeih?=
 =?us-ascii?Q?dWPZnf8O2z6NyWrY6cw0kZ6Abwezcu8cwq3vwD6kbOscikrcDrZRDaWJcqJt?=
 =?us-ascii?Q?JLxKs+ymKixVqVhcPkfCzeL1ONpsC9yDMXZ3gqUK8J97yYbreJIGotdGB3D/?=
 =?us-ascii?Q?YuX44ODx5UT+khjiYSZUNmwN9WiE4pDi6m4LL3B33dDijHTROWAUpnLmm+qx?=
 =?us-ascii?Q?DUDeP/T5wnP/q+6iKLRdJT29UXTqasPZD/KjBxLLtPN5O829KAToDkVX6reA?=
 =?us-ascii?Q?iFFYWQpzlCxnVmL3oBzVoIBOa9zuX9zpIOnkfRF5FuDm1T9AfI1PJa7VqO3F?=
 =?us-ascii?Q?Z3vIe7oWg5RdA7EYTdRqGpzf90xEI1tXUhP/KI6JOIrbuA/xuKWgQrpWG4ZX?=
 =?us-ascii?Q?k9tWIt13xdMX7NI8y1zWzyl18DTokVxZxntgTqc4cY9chCstPUxYwmvuJWmG?=
 =?us-ascii?Q?0Mvtfheba11HMq4rUtdXTw98sgoxvq4hdmk2XG1gat25tvHm+FA+iWWN3Vw6?=
 =?us-ascii?Q?UBI9imR1OoRZ0zYnQwKm88S/96lej1vpphKas01HXMpr1yfk6lj2RrmaKvtA?=
 =?us-ascii?Q?EvDkUkFHWlu+EQM9mFOyFWJhfS49vW2yyF9bRjw3X+TqncncGnhcS1xYhbr/?=
 =?us-ascii?Q?UBEb7OM1B2Pp33pJ6hitAhoWqXGUi/0MGc4w8bnuYpGs5Glepn4SLziIV1x3?=
 =?us-ascii?Q?b3aOehO4UcmZouZcUShl4ixenpADJ2Dwnf2zHoYzaQQZ/0tdV3r2NN0tRAoW?=
 =?us-ascii?Q?GqjdGJF011UEuFKu4GwJpZRqj94q7uxjUlBQa2Rea8sgh6mswnQF3wpeQtje?=
 =?us-ascii?Q?xtpUdHpHzrl6XqBt0z8eyh9SXQOjGwP9t9YdA6sOwc5a7xEAB1T5f8WfKc8M?=
 =?us-ascii?Q?tsvXpYVa9YlsSsLdYCONPq1g+8FcpYgjeW/XbFbsgJY7MqU+kfrPny74KUvD?=
 =?us-ascii?Q?yTOEeeOE5T+3KjxVVcOo2uOK7lbKBoQZmuv1?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2025 20:23:42.2466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a09e03-8057-4fd0-4c0e-08ddddcbf592
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6403

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Moving rules from matcher to matcher should not fail.
However, if it does fail due to various reasons, the error flow
should allow the kernel to continue functioning (albeit with broken
steering rules) instead of going into series of soft lock-ups or
some other problematic behaviour.

This patch fixes the error flow for moving simple rules:
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

Fixes: ef94799a8741 ("net/mlx5: HWS, rework rehash loop")
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Vlad Dogaru <vdogaru@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/bwc.c     | 61 +++++++++++++------
 1 file changed, 43 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
index 92de4b761a83..0219a49b2326 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
@@ -74,9 +74,9 @@ static void hws_bwc_matcher_init_attr(struct mlx5hws_bwc_matcher *bwc_matcher,
 static int
 hws_bwc_matcher_move_all_simple(struct mlx5hws_bwc_matcher *bwc_matcher)
 {
-	bool move_error = false, poll_error = false, drain_error = false;
 	struct mlx5hws_context *ctx = bwc_matcher->matcher->tbl->ctx;
 	struct mlx5hws_matcher *matcher = bwc_matcher->matcher;
+	int drain_error = 0, move_error = 0, poll_error = 0;
 	u16 bwc_queues = mlx5hws_bwc_queues(ctx);
 	struct mlx5hws_rule_attr rule_attr;
 	struct mlx5hws_bwc_rule *bwc_rule;
@@ -99,11 +99,15 @@ hws_bwc_matcher_move_all_simple(struct mlx5hws_bwc_matcher *bwc_matcher)
 			ret = mlx5hws_matcher_resize_rule_move(matcher,
 							       bwc_rule->rule,
 							       &rule_attr);
-			if (unlikely(ret && !move_error)) {
-				mlx5hws_err(ctx,
-					    "Moving BWC rule: move failed (%d), attempting to move rest of the rules\n",
-					    ret);
-				move_error = true;
+			if (unlikely(ret)) {
+				if (!move_error) {
+					mlx5hws_err(ctx,
+						    "Moving BWC rule: move failed (%d), attempting to move rest of the rules\n",
+						    ret);
+					move_error = ret;
+				}
+				/* Rule wasn't queued, no need to poll */
+				continue;
 			}
 
 			pending_rules++;
@@ -111,11 +115,19 @@ hws_bwc_matcher_move_all_simple(struct mlx5hws_bwc_matcher *bwc_matcher)
 						     rule_attr.queue_id,
 						     &pending_rules,
 						     false);
-			if (unlikely(ret && !poll_error)) {
-				mlx5hws_err(ctx,
-					    "Moving BWC rule: poll failed (%d), attempting to move rest of the rules\n",
-					    ret);
-				poll_error = true;
+			if (unlikely(ret)) {
+				if (ret == -ETIMEDOUT) {
+					mlx5hws_err(ctx,
+						    "Moving BWC rule: timeout polling for completions (%d), aborting rehash\n",
+						    ret);
+					return ret;
+				}
+				if (!poll_error) {
+					mlx5hws_err(ctx,
+						    "Moving BWC rule: polling for completions failed (%d), attempting to move rest of the rules\n",
+						    ret);
+					poll_error = ret;
+				}
 			}
 		}
 
@@ -126,17 +138,30 @@ hws_bwc_matcher_move_all_simple(struct mlx5hws_bwc_matcher *bwc_matcher)
 						     rule_attr.queue_id,
 						     &pending_rules,
 						     true);
-			if (unlikely(ret && !drain_error)) {
-				mlx5hws_err(ctx,
-					    "Moving BWC rule: drain failed (%d), attempting to move rest of the rules\n",
-					    ret);
-				drain_error = true;
+			if (unlikely(ret)) {
+				if (ret == -ETIMEDOUT) {
+					mlx5hws_err(ctx,
+						    "Moving bwc rule: timeout draining completions (%d), aborting rehash\n",
+						    ret);
+					return ret;
+				}
+				if (!drain_error) {
+					mlx5hws_err(ctx,
+						    "Moving bwc rule: drain failed (%d), attempting to move rest of the rules\n",
+						    ret);
+					drain_error = ret;
+				}
 			}
 		}
 	}
 
-	if (move_error || poll_error || drain_error)
-		ret = -EINVAL;
+	/* Return the first error that happened */
+	if (unlikely(move_error))
+		return move_error;
+	if (unlikely(poll_error))
+		return poll_error;
+	if (unlikely(drain_error))
+		return drain_error;
 
 	return ret;
 }
-- 
2.34.1


