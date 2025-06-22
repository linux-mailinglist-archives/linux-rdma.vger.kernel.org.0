Return-Path: <linux-rdma+bounces-11525-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E1DAE310C
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Jun 2025 19:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B55563B06C9
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Jun 2025 17:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F56213220;
	Sun, 22 Jun 2025 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SfhsA/iF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912E520FA86;
	Sun, 22 Jun 2025 17:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750612997; cv=fail; b=UmGIk8nu2awcUahOAaWiigK1N23YgI4OMHyWhWHU5Lt88sSHfD9qkVTTLJEabaN+dBB1VWUZh/Tn2cx8svj0MhTO1rYrf2gdfFNYH2pi0/4PMe5JqFymw+Oa3XjjDFnJZMxb+G4dQS85hFu0RRSpjLZg8fJlKUGLZz91f24BimU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750612997; c=relaxed/simple;
	bh=8/c2mhYCy5W0ouxskrlqgiZ4J+mE8AYfwxVbe3BEDzM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B58JSlc/ULITvxw/fVMWN7DCK9DSWz4I2UtL1WOYYr28Nx1dRyVpeR3QuxI+J+j30k7un1vZM5QnufvZBnl/7RqDS6BvR1nIjidryIb8F2OCRzJHTPB/+F/+7IA9R8CBz/Lke8jD8zVFe7EcBU2iEI7ti6XPmK/OsE+6dKmQ1X0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SfhsA/iF; arc=fail smtp.client-ip=40.107.236.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yw0OGRFK1wyChs053KyirUcslEP0Izf5FZVaIXBZge0xBqyfjLeqYN+RNXxMK2E8WDjKjIGEn+QpotgZs0S4QV4xx1iWqdUTl1sQS+3CyfffW59kubXVLg5WLWd4xfioILKp25l0ZjNT0md958CMdeR0LErgJy6QZAOFBEKqaGLpFHqqstqfOJw2+1UmZD28c2ZLYQez+j233KiYnikTJK6q3I6OlXnczVKELvbUniVmVBMO+tXIcrGSdPQM5fbiqRvhMR77RuAVkCtk/9Yvx7zpe1FeluqQ/hU5ckrAmeKRl5Cm5jhhTXyHfRjskMwZN3OdSx9Fro5sPVKOzCKCfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMq8l0xHYUDgnwpz10rB2NzvLJKEUsybDaVcUKvYK/M=;
 b=fFJUbdkbknyoKMvVGAWeatbrEPlHHxBu6WuIWOcZ9yp1dd+MVTCd/2f3ZuBBdS5ufaKIM+LZhWKLsxBj6ryLefdyhwpftDqz8P4pkAJFMMqL942QDUxeMhuB3iAr3e0X3FJqnWLXX43ZjkG/bX1hEaEURHOWEEi27vEIJokAy2Z4VBuo1S/xByJD5nkH2HdNYZIL3eHvT4gw+ORGNNMLBydbDOQBveR/W31ValawSTQxoN8D17Mh69Y/G7BLVodyOd2XbDmLRbsO65L/uPycv2euiCwNn0PUwjqairDVLDaIM7e2NHdlTQ0Hiw6MFH8/+I1wtzWJTLuc+OL7yjktBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMq8l0xHYUDgnwpz10rB2NzvLJKEUsybDaVcUKvYK/M=;
 b=SfhsA/iF+gXJ4S/TD6e84M0UDny4sxAbASA0ps/nIz9Jktu1l4Xq543Y4OAbbxMwxKFeFnD1ZSPZvN8JyJfiYZgCdRSVnCCOT2WZ+qh6L7kP/skZxmiqMTdth0GjwFrN5atFZJdOtGOoQzw6hAvnapXV56b6uuPEnXWjHmt/CnLiZL5D0WCF3Rrvt7n4odRsEpUgoAcHLpnhV5sokHEOF4iUDPrkdn+3diZf4YSul16XXNhw5RBcdw8Qxj8QoS5IdI6gwky7lUVDrGwq6nLf1cP1pvlGZtmNNgsBWjq9UAuKc8wCGjxxogjwnXlMxo126v/APSS1ly0bMLz7Y/RsZQ==
Received: from MW4PR04CA0088.namprd04.prod.outlook.com (2603:10b6:303:6b::33)
 by LV3PR12MB9187.namprd12.prod.outlook.com (2603:10b6:408:194::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Sun, 22 Jun
 2025 17:23:11 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:303:6b:cafe::c7) by MW4PR04CA0088.outlook.office365.com
 (2603:10b6:303:6b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.28 via Frontend Transport; Sun,
 22 Jun 2025 17:23:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Sun, 22 Jun 2025 17:23:10 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 22 Jun
 2025 10:23:10 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 22 Jun 2025 10:23:09 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 22 Jun 2025 10:23:05 -0700
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
Subject: [PATCH net-next v2 7/8] net/mlx5: HWS, Shrink empty matchers
Date: Sun, 22 Jun 2025 20:22:25 +0300
Message-ID: <20250622172226.4174-8-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|LV3PR12MB9187:EE_
X-MS-Office365-Filtering-Correlation-Id: b36affba-64bb-4317-4de9-08ddb1b1763d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|30052699003|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sYGo6uSGLlBhIT881fOgyoevFUusPYYXVV+IsLeWbuzHmhWulEs/ad3E9g0t?=
 =?us-ascii?Q?TMbyU7Nqi4XGfbREN6sBlc/1ZPV2KqfqcVwD2q44loPhgipn+URObxLL26EU?=
 =?us-ascii?Q?lGgDE8Fk3O4eGB4OpSNrp3hti58Me7L1lW21pOOxpVIdlE/BFmKWdznJsNkW?=
 =?us-ascii?Q?nU/ic2yI8qyx4qBpbezCCMftkSTtZOYUryUY7AL23vN4gMqas+ntJ/mb1mWP?=
 =?us-ascii?Q?fJZ717I+uHUN/xK/TjBNLxntA4FPxMolS6v4VjzniSb0kH7N27IhcF+NeIJj?=
 =?us-ascii?Q?Y51SlI5hlJoZ4RYO4hgFJI2v/PdLMQDUYT9mZ9PQzfKmCYdf5TOBXVblmmUI?=
 =?us-ascii?Q?WGwOR2VjNnhBhYzouFa83m0KJQ1LtbB1EiMOktuFiOHgKwCy3lF34cEzNvNx?=
 =?us-ascii?Q?+uPW70l8ykirXidtZSNyXOHi9w6nznTBzFvbi8EO9Gz6gLS+zAeCCFzuP+k8?=
 =?us-ascii?Q?r9rY0cE2a4ZtaCB8UoBRPdEm/Q/SjsV5GB7APXYvmADgohdElQ/pZ9fnWVMF?=
 =?us-ascii?Q?BC01aL/s4ylAmobiPqOgCNer17Zc2FBabSZGF1Wq8igjhaw7eYQvZttVCQXa?=
 =?us-ascii?Q?3TQ8RET8vebW7OQfmJPq/IdkNmpoILghGy6COuC8RmWp2WKUMavgFG8SK8wW?=
 =?us-ascii?Q?F7xRwyhuKOZHo6V5tdfTv1urKod32Wwja5xbN3SoZMDeBKw54Xv8kwtPrwcY?=
 =?us-ascii?Q?8iL/Zt3Wlguv0S8DXF2IOQSXXKUsF9nt//O8NxgybYdOotRoD22TiZ++ISsu?=
 =?us-ascii?Q?Ap4FeSAlvo0awdBUl/fOKrNz18IIN5nKdlC6ZTNeUFCdcHR4TTzX7g/gL2Hu?=
 =?us-ascii?Q?j79FdAVqjF3C20CSY2d3CE2i+GEDivkQjjLQrSmyFUE7jj2vZBZo9oC1CzUn?=
 =?us-ascii?Q?H1te604ZXFL1deZC3vRrnzcTQ8Agd4wUu2/y7rGRUPzpRRj5pXp/FZelH/L6?=
 =?us-ascii?Q?mhKE2TW2CJef84Qvd1wFd5T3Bns4VwJ4T8tmBpzSsxb1HhmZSP3K+5sfGfLZ?=
 =?us-ascii?Q?IYntLw8OPL16HO3chpfjvL5wsHEy2fEUmwTNr8q7Qj03Hxhfmi4aSqO+hDMJ?=
 =?us-ascii?Q?5zDU+77lfnVkA8bFHUwBXxv0qItCKs7mLhBQhxfZ3zUX/4cxp8XB+4Lbnunb?=
 =?us-ascii?Q?0e6oP851OlsjD9qpYcFkyHmbjJ/FfiyhCORPgV3PPUS6BpGkJIU2U2w9wCJQ?=
 =?us-ascii?Q?jZXgARIHHg03C3yz/x+Ja0MzqkDLGNMJCT3mpfiD3S695trFXAbrolKJgLBc?=
 =?us-ascii?Q?hBpq3kyB6oAhN3k2vRaudsmJOAf9LYUygyriUJhsxUopXSgxyRe7keXS1KB5?=
 =?us-ascii?Q?hASV+bO/UVBCYJkI9KQfa1VU2LnD6QzrPukdaWergqCkD9GC5XbBOWhDqdgs?=
 =?us-ascii?Q?CezE51S/Wn6AyOZTI+9MpvWPcHKdi7+yDT0/g75jX+VOtpEln2MdE/pxguIL?=
 =?us-ascii?Q?Y6+cuKb+ASAHqJ1IHDaLMNSVCxdEcCMnM8i/gHpkZkFYv8JDS3ekmhDSGNeA?=
 =?us-ascii?Q?ITqf6VsR0eeA/H2R9wnakqKC1tmYE5hdNDV8?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(30052699003)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2025 17:23:10.6632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b36affba-64bb-4317-4de9-08ddb1b1763d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9187

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Matcher size is dynamic: it starts at initial size, and then it grows
through rehash as more and more rules are added to this matcher.
When rules are deleted, matcher's size is not decreased. Rehash
approach is greedy. The idea is: if the matcher got to a certain size
at some point, chances are - it will get to this size again, so it is
better to avoid costly rehash operations whenever possible.

However, when all the rules of the matcher are deleted, this should
be viewed as special case. If the matcher actually got to the point
where it has zero rules, it might be an indication that some usecase
from the past is no longer happening. This is where some ICM can be
freed.

This patch handles this case: when a number of rules in a matcher
goes down to zero, the matcher's tables are shrunk to the initial
size.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Vlad Dogaru <vdogaru@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/bwc.c     | 68 ++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
index 0a7903cf75e8..b7098c7d2112 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
@@ -3,6 +3,8 @@
 
 #include "internal.h"
 
+static int hws_bwc_matcher_move(struct mlx5hws_bwc_matcher *bwc_matcher);
+
 static u16 hws_bwc_gen_queue_idx(struct mlx5hws_context *ctx)
 {
 	/* assign random queue */
@@ -409,6 +411,70 @@ static void hws_bwc_rule_cnt_dec(struct mlx5hws_bwc_rule *bwc_rule)
 		atomic_dec(&bwc_matcher->tx_size.num_of_rules);
 }
 
+static int
+hws_bwc_matcher_rehash_shrink(struct mlx5hws_bwc_matcher *bwc_matcher)
+{
+	struct mlx5hws_bwc_matcher_size *rx_size = &bwc_matcher->rx_size;
+	struct mlx5hws_bwc_matcher_size *tx_size = &bwc_matcher->tx_size;
+
+	/* It is possible that another thread has added a rule.
+	 * Need to check again if we really need rehash/shrink.
+	 */
+	if (atomic_read(&rx_size->num_of_rules) ||
+	    atomic_read(&tx_size->num_of_rules))
+		return 0;
+
+	/* If the current matcher RX/TX size is already at its initial size. */
+	if (rx_size->size_log == MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG &&
+	    tx_size->size_log == MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG)
+		return 0;
+
+	/* Now we've done all the checking - do the shrinking:
+	 *  - reset match RTC size to the initial size
+	 *  - create new matcher
+	 *  - move the rules, which will not do anything as the matcher is empty
+	 *  - destroy the old matcher
+	 */
+
+	rx_size->size_log = MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG;
+	tx_size->size_log = MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG;
+
+	return hws_bwc_matcher_move(bwc_matcher);
+}
+
+static int hws_bwc_rule_cnt_dec_with_shrink(struct mlx5hws_bwc_rule *bwc_rule,
+					    u16 bwc_queue_idx)
+{
+	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
+	struct mlx5hws_context *ctx = bwc_matcher->matcher->tbl->ctx;
+	struct mutex *queue_lock; /* Protect the queue */
+	int ret;
+
+	hws_bwc_rule_cnt_dec(bwc_rule);
+
+	if (atomic_read(&bwc_matcher->rx_size.num_of_rules) ||
+	    atomic_read(&bwc_matcher->tx_size.num_of_rules))
+		return 0;
+
+	/* Matcher has no more rules - shrink it to save ICM. */
+
+	queue_lock = hws_bwc_get_queue_lock(ctx, bwc_queue_idx);
+	mutex_unlock(queue_lock);
+
+	hws_bwc_lock_all_queues(ctx);
+	ret = hws_bwc_matcher_rehash_shrink(bwc_matcher);
+	hws_bwc_unlock_all_queues(ctx);
+
+	mutex_lock(queue_lock);
+
+	if (unlikely(ret))
+		mlx5hws_err(ctx,
+			    "BWC rule deletion: shrinking empty matcher failed (%d)\n",
+			    ret);
+
+	return ret;
+}
+
 int mlx5hws_bwc_rule_destroy_simple(struct mlx5hws_bwc_rule *bwc_rule)
 {
 	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
@@ -425,8 +491,8 @@ int mlx5hws_bwc_rule_destroy_simple(struct mlx5hws_bwc_rule *bwc_rule)
 	mutex_lock(queue_lock);
 
 	ret = hws_bwc_rule_destroy_hws_sync(bwc_rule, &attr);
-	hws_bwc_rule_cnt_dec(bwc_rule);
 	hws_bwc_rule_list_remove(bwc_rule);
+	hws_bwc_rule_cnt_dec_with_shrink(bwc_rule, idx);
 
 	mutex_unlock(queue_lock);
 
-- 
2.34.1


