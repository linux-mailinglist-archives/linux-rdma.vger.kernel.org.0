Return-Path: <linux-rdma+bounces-12804-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 913C4B2950B
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Aug 2025 22:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB7FD2041E2
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Aug 2025 20:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA6C2FC874;
	Sun, 17 Aug 2025 20:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H1i9xJ9b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7122F1FD5;
	Sun, 17 Aug 2025 20:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755462259; cv=fail; b=q5HFfl/O1iHdTRPEKb38lN3tImPrM3uKpIQpVPvnBQGawX/0shSIDWXmpI1lZpVQjVtbKyTH4+n/qX6PsyalP/M5Hiwzb5mlyp9RO0rV1JMVGMgTXD/DSr/F9/AYmSvWhJ6tVrINpf2Tmb7WQ6szvs3obZ8gOxR1F74LvpoyMiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755462259; c=relaxed/simple;
	bh=NeaP+Vfv5MEX7XsS4Mp3pY2uXzxrsWELPeyKAtHoNRc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NyBYHdlg5+VQ2lI/aybIaAVR6kirHSgOAizRMKiL/CROyaaaM+X2hs/5SF1Y0GA7QzyrMCbSCPIg4qZt6apq4WVR5H3gKf35I9hRMGHOJctmHMTYwSAaw0V+7fjtjN0Ah7koE3IVIiDhtTFmmUMK4L+xA//JnrHxRieaRIe3OTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H1i9xJ9b; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sItE1PX0lwKpLm7kFSSI6qPeLAJKN92j8BUmAHKV0IJ6HLbaa58b422v2p7pwu3RSLiivSyjCidSqCRlVEnsQeC0e9240yYNBzmsF0InFFUNgMLSAZnJ5IpwO2mlmopStutDJ9HGveOncprjZYsc04CQXZzapCqHe0f20yFjit/ZjTsJWikpHxoPhNM5Pp669i4F7D8bkHNHgrvRJ83/YOCUjdGeo7rDue2WG+vDhb6CcUtSJufJ6wnyk4ROyF3mRBzZhl882RKlqe1zyP8lRcnUvrz1s/q5/NNXTLFNqdBkD5XN0UmEWLBnfsJ5dJLMStNarT/8HqrEk8nBFH9Kyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CH68TnLa0WRJVmu5FBbi7rcZOFb9AFkC7Vd03K/6aFw=;
 b=nCHzhfe/mbI5YrmWUpvNSWWRFaCZ2lQlna12M9YfDyRY+sdNqWymsJRaLMggZyrzgZTvvDee2CnBFYBpb9Cjg520h/AoZ8RHTLYOj5HqgFMpzdxMj7p4hiZ+3rIW+y52i++nA37A4VYrMwf1uKZQLAvVi8Unkac69Pa9sLy3PAg6rdVBcQSYnhl4fVLqUeq3DQOfp4cYJZ26yLbb2eVxGFkDofUUnV3yqwieIp7EeJOZvwpuWHVQojBNBtp0JsjD0HtHluI4PJfNzA0STj+fcyjLQgu0tYSPUI2EkBvnhhaPG/+PE/X93kYKDZBSsifbK6+CRu3cGcpkhm0bAINclQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CH68TnLa0WRJVmu5FBbi7rcZOFb9AFkC7Vd03K/6aFw=;
 b=H1i9xJ9bxDi84MOoKQ/rsmKiuqA4p8a1lPLpVgOZGyJIykM+/DOHTRB/aRVjae+fKqLRejSsDp3F0FZdflG3YEz9N4E4D0xtUTj6YgmA/KbCvKAhzTXsw69GASXEq0n2m5bXZyd+AtMQIy51CtXQfuIKUexHJ0RQAE/QpJjAOsuUE5Bsei5dQZM721Q1XStUHzQMMl8qswyLiSxhi4rFFxGZCC6QQE1gOOCtXxQ4MBgRk5XSSxh8ug5+QrNq4yELvtfHTtruae3aY0m+T2QKnjsETF1LxM8Bk4W09OyKVApqgzS5Hm1yZUUXUpa0aZPcdoHvMFg6O7fAaw6Er2iQdw==
Received: from BN9PR03CA0374.namprd03.prod.outlook.com (2603:10b6:408:f7::19)
 by BY5PR12MB4259.namprd12.prod.outlook.com (2603:10b6:a03:202::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Sun, 17 Aug
 2025 20:24:14 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:408:f7:cafe::cf) by BN9PR03CA0374.outlook.office365.com
 (2603:10b6:408:f7::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.21 via Frontend Transport; Sun,
 17 Aug 2025 20:24:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Sun, 17 Aug 2025 20:24:13 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 17 Aug
 2025 13:24:04 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 17 Aug 2025 13:24:03 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 17 Aug 2025 13:24:00 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>
Subject: [PATCH net 7/7] net/mlx5: CT: Use the correct counter offset
Date: Sun, 17 Aug 2025 23:23:23 +0300
Message-ID: <20250817202323.308604-8-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|BY5PR12MB4259:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a641647-b84c-4ccb-c539-08ddddcc0853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gp8N0qcV5aJS1hzALX/e80DStKcFeCPEViQL9WmGpfLm8AetZHd1aIyYuQzQ?=
 =?us-ascii?Q?kMy8xuCHHeyTJgJUJ3OeVCTFMP8pcx9KhpM03uXMu83m+uARGpWjDk2o6MJq?=
 =?us-ascii?Q?URlxRvy96S3ahV2n8BKxQAjp5aOypmvmtOnC5w7RJIP+avC+XAYRwB6mxViK?=
 =?us-ascii?Q?uvwq38aHK05zHBsS0LnQGUw6d8f17CJkSwHJzb5NjJ4b3pHs/XPNw+J+ZeC6?=
 =?us-ascii?Q?Lk4pfebHj6VBsUAixSxaXQsFc3qQZzexw8J1IBAU6PFY1rvV5lxCNzdU0mIB?=
 =?us-ascii?Q?B9OI9J5Jb0dKC4b9OCOtvBRehOFPIFLWbUZHKpKOGVbZ8uJyB7MVwqA9CQzs?=
 =?us-ascii?Q?wDAf49vsiw/K5mOejNVcA4w2RoF+dgjo+X7UqYipNBE1k2q9QOVTfuST6fP4?=
 =?us-ascii?Q?6Qnt0fQTBUeq148Xu/tzEyYZ+d4J3TI2WICpisNyMHa4yAxb8/h/mkiPK3zT?=
 =?us-ascii?Q?vHu7UQL8I2lN17ys2zqVNTlSticHLGRfAFli7A9p9R2la4juttGBeSKxrpkS?=
 =?us-ascii?Q?KUsBdYJ1XL7H1hnmbQEHulWYjhP1dAMU1Fktc+8IMXW9z4Q0pQTMH4Yt+JTY?=
 =?us-ascii?Q?P/gmhfG+3GM5ukHOq7zigDf4ZmChb1nHXzhHzvoNWIdHMAMIkweC9VlK96MM?=
 =?us-ascii?Q?V42Howudrc5yKSP9CtUW7QrxUxlVojBJngqj8yQUWDf5Z7rWm5ULLLDigRmN?=
 =?us-ascii?Q?NQXcMlO0mR+Qf+q0HOF/h0uCMeKbxdjroorMS3iMvEJ3zi7fXnn7PvCk+0aP?=
 =?us-ascii?Q?i6+nZrSRxICC/wEbIqAn3WAk9/PlJGmPh00jdZcukDsVHHpxcjcHZECp/z1e?=
 =?us-ascii?Q?BDjFDrm6koI2oTm+BjjL8L73RpehdFdS4DnwpLtFmsMft9NrHkHM0T8ljKZ6?=
 =?us-ascii?Q?APHbEKu+hSmqgSAAaxoy/qYhBfhG+ZCu5hLU/0I9rkgXB7WKGl5qju0iKgCe?=
 =?us-ascii?Q?40sxThNuAuma5vioewuetVQkIpuMgyFsK0WL5QdzJclU6ZDJJQBzy55vuhJB?=
 =?us-ascii?Q?PIiA4hSIdyGEh02W9viUiDYM3Ft1VfrFtPC0Dc1nGysy2iAu2HACRl4gi6VT?=
 =?us-ascii?Q?C6O/fpE69fDWp9Kbga9+cZ/5iG9fvwNrX+SDFbZlbA5zuUhMGHY9JhzXhyVe?=
 =?us-ascii?Q?+XYRUH4MXJbgPtgrBIeSe1lQdZWvrGgvopaaiCKb16sfZeCOxAQXaQ8xtmHR?=
 =?us-ascii?Q?KS/dAs8+M+JMgPiEe4+kSx/u4J+SzfFG2gdbiW6BHnHUPui4TlvAcslLad/+?=
 =?us-ascii?Q?ouIyXFh7QVAFh3zLlXbVsNYWbXQ1FAucnUC/RMb6FvvLZ75FxQfbebxgGi8m?=
 =?us-ascii?Q?XQl0cPbuaz/CoUv0FVQ5hY1svBi2MeeyHoaKbPJnJ1cFWC71AxgxivB0DgBh?=
 =?us-ascii?Q?8xkJP6GoTAaO7VuizznYRgT+3RPIyYnuwawlZ70o9eTa3TMICG2Sqmgr6jtQ?=
 =?us-ascii?Q?wO0onvtgev9nfPNDZkFyO6Ij3U56UiJL3K+8ppV5gCzjzkV8HhOtRBqT3G3V?=
 =?us-ascii?Q?k+BLZiGckgdQPvYG/3FZIbqZ0WDINObuuc07?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2025 20:24:13.7304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a641647-b84c-4ccb-c539-08ddddcc0853
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4259

From: Vlad Dogaru <vdogaru@nvidia.com>

Specifying the counter action is not enough, as it is used by multiple
counters that were allocated in a bulk. By omitting the offset, rules
will be associated with a different counter from the same bulk.
Subsequently, the CT subsystem checks the correct counter, assumes that
no traffic has triggered the rule, and ages out the rule. The end result
is intermittent offloading of long lived connections, as rules are aged
out then promptly re-added.

Fix this by specifying the correct offset along with the counter rule.

Fixes: 34eea5b12a10 ("net/mlx5e: CT: Add initial support for Hardware Steering")
Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_hmfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_hmfs.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_hmfs.c
index a4263137fef5..01d522b02947 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_hmfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_hmfs.c
@@ -173,6 +173,8 @@ static void mlx5_ct_fs_hmfs_fill_rule_actions(struct mlx5_ct_fs_hmfs *fs_hmfs,
 
 	memset(rule_actions, 0, NUM_CT_HMFS_RULES * sizeof(*rule_actions));
 	rule_actions[0].action = mlx5_fc_get_hws_action(fs_hmfs->ctx, attr->counter);
+	rule_actions[0].counter.offset =
+		attr->counter->id - attr->counter->bulk->base_id;
 	/* Modify header is special, it may require extra arguments outside the action itself. */
 	if (mh_action->mh_data) {
 		rule_actions[1].modify_header.offset = mh_action->mh_data->offset;
-- 
2.34.1


