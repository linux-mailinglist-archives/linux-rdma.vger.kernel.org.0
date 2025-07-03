Return-Path: <linux-rdma+bounces-11889-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21973AF8102
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 21:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36A2E586806
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 19:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5553F301144;
	Thu,  3 Jul 2025 18:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qq2UEg1Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3B32FF488;
	Thu,  3 Jul 2025 18:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751569022; cv=fail; b=KcJotEIWoSgxRXUZGeLr9ZviD9zuQmg8rLK8bjPtdQfULtfEgNf5FX7w2EO9/lT5toUD1SwtCyPxu0X/MR/Uf3YZNOEb5Nx2Temydyli76eSj6pEhP+DYSd3Gp2UnXwCUBEaD281WKe4j71Vl108scfVCU48Wz75fxyTQS6uG5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751569022; c=relaxed/simple;
	bh=ZFlzzmmDDOlSnB9v0t28jLr+RjkMSOYEWSJCeraDsKw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OHK/PhPEF1tJTiyXzsg9jDku/pu153oXrY3hHk3u5LHP8JbQV1RvcxOeVqOWDef30+alGw8cyeZ5rSOh2WmVu54V7oAkXJARC257JpHQPgGOfVaZ2ZEtRhQXwqJp1tNoIfMHQei5qYwQ7HIHAriQggqM7xaLH5NE+Pfi/LIHQgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qq2UEg1Q; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BeWTKyi8ylJNBvMu2Geh7UK8VfFRKJaVq26CtxaqOUr6SZVMHGzsA68QyU9w0IgdpkdAiTqwCqlKVhaQIScatWXM8Dj3ZoTUyL36AVl1g4CbF1j5pQjZITVDWj5xVpTNXVEBPmjhebUZjfX+aBEq3g4CSOaZB1ZB3bIsQnrCNF10DIdXx7rW2mH4vXq4R2x9W4nd0/ehFTVHMwZc+6KTF3NsBqGyc4ou05l5hTz/easUXHfv7qB97bYZwkTZXAEn3gReJZ98KDuzOD8eu5sk+IznhATsW0WwFlog9PDfKQwvO+YxY0XrB0nGs6viJB9SGSlI+ZFHOJh8nyLVv+vYSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MH3f8wWgul/qYlNJOI+V7eIUYtUSo5h3D959Zpcuutg=;
 b=HaaI38szDZmkhZzQIfSYFuwSxquM0T7iB/pofIytXVGtmEhl1AfyC3F5U6jtRvtXKbkAPUGdtUZXP156cHjphj8IRc9mC8tKGD00uGURPQkmaX7s/OnDs3/+/cDtidULbrZrDsBtzNals7xxOhzExFTmG4DnuwBEE2VbKFM7mh3z+C5TDyGye7JwWVcAVmwTmK7W+OBtggEwsrGUx71RqOroLwDvrijG8zRYBjbkJCu28QW3GWSdJaeuHq4DGfWXyRjZ0DRPZ4TctZY4y74OLZzO6qsbQBX41fUFxPFOh/iRucNEh6F5qDN1djsJT0dFv0FYsQcrvRMpg86brMxhjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MH3f8wWgul/qYlNJOI+V7eIUYtUSo5h3D959Zpcuutg=;
 b=qq2UEg1QocXeVlZzOucGEfq64EgMVB5dh7QDnzu4jLfiM9o7baqgREPgfjY3JAXfj6KQrprZ7PJsx8KT+JzUIZoK7sjjQqnn1smTsabf2JoXVpkUFA1jhDYD7Hg7JH7cohm1v/o/cLRu3PNSovsBgALsCWegN/p0PsQAkpFWZqdFD0hOHNhQQjPQhwLhqfqpJwVvYg7wvjsmU8H0IwioiZ+m2FNRftymABe5KXPqtgQWVj/tqHmf1ney4Ymd42KmmTCxwiaBnHV63C4SZqx/Uy6WewFzzlwg8e2neumIkw73CVtKVEY5uxS77JGl/sA4LUaMLXyGCExc02Ya/SuPng==
Received: from BN7PR02CA0027.namprd02.prod.outlook.com (2603:10b6:408:20::40)
 by MN2PR12MB4190.namprd12.prod.outlook.com (2603:10b6:208:1dd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Thu, 3 Jul
 2025 18:56:57 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:20:cafe::10) by BN7PR02CA0027.outlook.office365.com
 (2603:10b6:408:20::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.21 via Frontend Transport; Thu,
 3 Jul 2025 18:56:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Thu, 3 Jul 2025 18:56:57 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 3 Jul 2025
 11:56:42 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 3 Jul
 2025 11:56:41 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 3 Jul
 2025 11:56:37 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Yevgeny Kliteynik <kliteyn@nvidia.com>, "Vlad
 Dogaru" <vdogaru@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v3 09/10] net/mlx5: HWS, Shrink empty matchers
Date: Thu, 3 Jul 2025 21:54:30 +0300
Message-ID: <20250703185431.445571-10-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250703185431.445571-1-mbloch@nvidia.com>
References: <20250703185431.445571-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|MN2PR12MB4190:EE_
X-MS-Office365-Filtering-Correlation-Id: 3655c19b-2d8f-4a3a-abcc-08ddba636279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UiSY59Pl3e7VM1txPko4ab1QBT/ZD9LXzelO5FyX7bES2XlTx2Q/EgqYAZSS?=
 =?us-ascii?Q?QxCv78vdDvUK+IWosHmBV/N7nTcKnrfH4VKJ21jrtJNnTApUOUFP2QX+GibS?=
 =?us-ascii?Q?sejBhiSKSdem5dEt8zeFZRAwlm9A8JHTSIhH/xX6red12eSFCcCDmMeWexrs?=
 =?us-ascii?Q?okiCYjhkEPhU94OPGjrNLZ+2Fyy8tOMD7fN99GZkc1gKIoSprihCpT2lEXYX?=
 =?us-ascii?Q?2M4RnaWcu3mzuk1dOExvw1nRvpPSTOOFxcpq+EG0NqCgP4NayPv9E8smcHMR?=
 =?us-ascii?Q?F/5oKQYyqSrSYAQ2JrwuueKBfVmv0ic9LbNeI+gYmDlBf/Pn/bEUxbvyB4K7?=
 =?us-ascii?Q?O0jGNg658+tyyWalMxkBLLEnfguGAN6gtk2EqLBZg4A0VOp6WqFSjCKfhsqc?=
 =?us-ascii?Q?DxCDZDFvluaqwxWUm4w3igIw7Wj9k0F4jQl6slmPXm7o+SL9jZR9WfXaXcnc?=
 =?us-ascii?Q?BithZ+9+EUsW+e5cnzA4YmN47cmtIJ2u9pggEebRkNQ2En1+ZwXMY3jqLKIY?=
 =?us-ascii?Q?r7efrMMnzWwJAUfbMqJHRRqOhL885erJiVniEBvn6bCRs2SiE2DmWL750Mz0?=
 =?us-ascii?Q?3IzsYuTs4G7oWValuhc+devUARhjJXJe+lwZ9yZPPWcOamyqXdvT3YP9TA0/?=
 =?us-ascii?Q?b4KYIf6DYMcCYlNA+M2oULqmHfrdYwVNTkZhez4Gc3v6jTqWjST9cFI8lCtq?=
 =?us-ascii?Q?wA/b3c0J64kfOsIONsVfAl+Ext9//GUnOEy51A0fJSux9kWQpZ5DfFIF1qWI?=
 =?us-ascii?Q?0RX+JODFYykBC0SqKZwiAWHnn3a9atqwhaT8b6C4fkVtnxEWLE9iP8SZtLAT?=
 =?us-ascii?Q?AGyuyA/3zJNnGTtQ5StoqjU2wmucXCj5zwxj12N/9M64ugscdBnOqU3Z0bmL?=
 =?us-ascii?Q?mYHAykt9DT45fJqq5/PsfcSpwWJcLroJEA/gtyNwiozOka4+TfJM7rx34qyf?=
 =?us-ascii?Q?KtIbElp48qaMiAmUjcsf8eydoGDxalOLvagupF2GuDmoOWNJNNO9COyNwz7l?=
 =?us-ascii?Q?T8YLPPl5nnMgkAYQd5wJqbIq3njBEEWWBjwvZuZKKK1dXbmWPsgNfpI3CAPi?=
 =?us-ascii?Q?3tTcMoRNpUdGdj1j7Dm8DurpghRi8tdqQDnqBSoSzuHTIV0Aqfg6DH2ZOiHH?=
 =?us-ascii?Q?KHZnWbLfqF0S8LVwQTLYndHupFibGwLEyRNlE5Tjj8OL06D43clxL6KRmu5A?=
 =?us-ascii?Q?4EAZ2tlnkWedszn+MQEQ1Ox70RC9pQWRdvoW0CZ4dLDHviPO6WHz/WI+2bjM?=
 =?us-ascii?Q?KU5Fzo1q2hT8sICGIOLigWcGhqXukgMOonC+XwJEF/cnY35YteXdUWWCx3oo?=
 =?us-ascii?Q?MQRtiWIWNW8aaaNLw51C91upykJXHzOinO4K1qvDM/emN9QP50NfJy1xHCVb?=
 =?us-ascii?Q?w2vCeuG65i0g7Cs/xKTf48xHsndjE2PDpH0putGw5Wd07BO+4jwIuNln1iQr?=
 =?us-ascii?Q?gr6osPbMMEGzFNNJN2/FDlw0HQSyU6zRu0XePUWwaVySqxMqH8n5dWgYcByB?=
 =?us-ascii?Q?WMVdqXA58R4JNQxApE7vLiskq94f5E8dz6gl?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 18:56:57.1300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3655c19b-2d8f-4a3a-abcc-08ddba636279
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4190

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
 .../mellanox/mlx5/core/steering/hws/bwc.c     | 66 ++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
index 15d817cbcd9d..92de4b761a83 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
@@ -533,6 +533,70 @@ static void hws_bwc_rule_cnt_dec(struct mlx5hws_bwc_rule *bwc_rule)
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
@@ -549,8 +613,8 @@ int mlx5hws_bwc_rule_destroy_simple(struct mlx5hws_bwc_rule *bwc_rule)
 	mutex_lock(queue_lock);
 
 	ret = hws_bwc_rule_destroy_hws_sync(bwc_rule, &attr);
-	hws_bwc_rule_cnt_dec(bwc_rule);
 	hws_bwc_rule_list_remove(bwc_rule);
+	hws_bwc_rule_cnt_dec_with_shrink(bwc_rule, idx);
 
 	mutex_unlock(queue_lock);
 
-- 
2.34.1


