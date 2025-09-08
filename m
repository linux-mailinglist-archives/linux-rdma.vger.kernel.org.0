Return-Path: <linux-rdma+bounces-13156-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A588B48995
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 12:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69C911688D2
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 10:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3B12FB091;
	Mon,  8 Sep 2025 10:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lZNYAohz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5732F6590;
	Mon,  8 Sep 2025 10:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757326081; cv=fail; b=ILTBfZ+lm459c91gLpOeksoNa8qqNsqbz4QkzV6PmZnTz11ZdVvkBWWy36WC6SHOgkycAvL2RAjb+vasGLuvbsFfRJJilpx+TDWfbrp/3U6cy3TbPv5hSLFE+6HPzh2h7gZsW5/gXCEWUxDMDCp4GItrqQDCNFws0/PWkI9ggfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757326081; c=relaxed/simple;
	bh=YSWaW7dxlXLfcI8EOSPqjY0EbwaxD2n2uEEliZs1gyY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U3bcmPFUaAXVXGaBm4GoqAvi91kdYUKlFBq7SGR/ENeGWjD32AGcJu490TWneo4a1sS9oR6KSQ5dvHFb7PZAyabhvBa+0BxjCTUxqm/ds4EQPt/5yNxwRoarNcc9GGZGp4WPceT4lb5mawJEfdJL9AsofCz0dXtWX//xC4qATsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lZNYAohz; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lx4GO1RgTpR1HoQ4aqA0HOkdgbVHl/Vm/7j6+JRxVHWILbuDvEvLpf2fWzf/HvgMGMB2jwYD0NGhli8anU60Vdkfi4p42sQjO1hoo+E2gXvAuDsaePTwGaAhXEAtLKEhZYR9RTemWMfl8nRHYeQ/hQfQ32pzSQZ6vse12BX9wcn1wCFWut11l0DYwggePt9+gziHPXt0wzXA0Mw47JlqipMTaFoTjotFCLI+miPbPnSFpW1mdGyGj7vPJoSk11H8iSAVQgLttdKAR8lnHrIzLTTaZWlAOpyuYH+OxOX+uPgfVyn7C2oVFljju9AP5VynC7cb8XmvHzXpr4OgXbbB0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDjlB+jwEYEGUjyAYYxW88jgvbb0Q+q23GHAkC02GLE=;
 b=Eb7FZ/v/8lIhMzW+9Pfs3lFLLjCjIVFajJN1NyUg6FYIK1epxaMqtmgscnLku6fBGFelxFAqcIw5Y2+mWb9vtH7XUxusXtc3Yl7cLTCLarZjV7fIIkabTAvJGxhrxTLdC7lDqLn033Z8KMgJZOxkFu3HtyFAUQI9OIj9bWCTocgqySbzvrj3l7BtEa6RzdeS5mNck++sDp85oR0fPX1M832NhsLAE7+H2uNz3UD1KVGc2fBeEteVHI8ZRNw2hYxFiR7zUljuAq/sEj4PwyozwxZsguRSUdjDffpXeplysQbjywkSSQZ2HsO6tdl/ytyoFKyWrkU5P+JsZR7Osj3xIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDjlB+jwEYEGUjyAYYxW88jgvbb0Q+q23GHAkC02GLE=;
 b=lZNYAohzPtTU26K0zF2PNo2ClfgJABprd9t6DnH20WlCShueCVcgrBaxUKQdw0HTLG1Xgb4tQCuJddqdHpkIrJNNlt/pCk6jsJK/H2y9Ygqhke0BbD700vrJWW3JwUjWYAMfLPSqyUjhznXTb7+pgjyaAxvlw5A+8TvJ/EZgsqelONJlgg4hQ0SS+QyNT8LjJH+aQB+Pw3qmJZ2I4q1pgckz0QjI5wtN97XXqsWwY4SBLexzOYhKDoBJgB63QKfk6Ot05/ndND1Tcx08YKOD0NV1/K8/EpO5g5uy9dOXdDUpFTrE1G4zOO/2VcOvC2FxOg7ivTm8T2BXpB6FE/saXw==
Received: from DM6PR11CA0021.namprd11.prod.outlook.com (2603:10b6:5:190::34)
 by CY3PR12MB9605.namprd12.prod.outlook.com (2603:10b6:930:103::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 10:07:55 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:190:cafe::32) by DM6PR11CA0021.outlook.office365.com
 (2603:10b6:5:190::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 10:07:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 10:07:55 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 03:07:33 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 03:07:32 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 8 Sep
 2025 03:07:27 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>
Subject: [PATCH net 2/3] net/mlx5e: Prevent entering switchdev mode with inconsistent netns
Date: Mon, 8 Sep 2025 13:07:05 +0300
Message-ID: <1757326026-536849-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1757326026-536849-1-git-send-email-tariqt@nvidia.com>
References: <1757326026-536849-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|CY3PR12MB9605:EE_
X-MS-Office365-Filtering-Correlation-Id: 4acdb3a5-93b7-432a-e330-08ddeebf94c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8DT3Dk1ULT7GjUGwRVj6Ti9MPtaef+kD+Y2Hlg6UP22RNs9+JurD6vsJVOY9?=
 =?us-ascii?Q?GTkCYen5Pgnz3P+tYsC/BG9pJQAc0q4wvKBELdl2xQGKUvtg0rhnEfRmBWnc?=
 =?us-ascii?Q?W5ywikCgcB8qQzQvB2XWelDl7MZ1yd+mynp7JmNlvGXkJpIFON8Af6l8PLAW?=
 =?us-ascii?Q?ZIjH4fYRtrqHBTQ8R3GwvQcMYIHay93IT+HhPM1VDPVRvJU/N1BWzRUttY4j?=
 =?us-ascii?Q?OvrAgYnVNxIzPu9g7EkprnwvV8lSR56SZq/4m82LBFBKGoyT6fGZq9HOUOWs?=
 =?us-ascii?Q?Eu+/NX5d8xw50BnBYVndiifSxwJI8YgSB7mvhHQOTaiRRzkmbqdUmkeilANL?=
 =?us-ascii?Q?NaPCHfV3S4YXMwR+NuSMvQ+S83s/2MwN9nC3i/d7zi7Vgc7TnCN+zR4oRAge?=
 =?us-ascii?Q?6oIk8UuzQ0N4FyIL/aJb97xb9S0Tno6WuzlGthA0EPpEwY2fyOo6lb0a5JXi?=
 =?us-ascii?Q?d2S1g9aRIvgmYlOStIGmfayPu6aBN4qut8kWsGCGtx208DU1ZSGp0jk6oWK7?=
 =?us-ascii?Q?bZ9ujS+2gq5YtmTjQJ2UCSjQt0UX+ozRH9B9d3UogXZhSJvjP5gslBcQa4Je?=
 =?us-ascii?Q?rrDy97zKIotENDicUu5xIdJQx+FWxANdOHGSg8ECn3Hy3dk3ME5Ib/afcIlh?=
 =?us-ascii?Q?o7bbeG5pu7jaAv4XWXAPZnezkqrG5Ya+/1eabrlcKYLKTKc/aXqdgmrMywmv?=
 =?us-ascii?Q?O5D83o8vuIsGk0v3EPCxjeNqLdkjsbyR7mQ6oHTka/XY42WO8nMNkffsNcRP?=
 =?us-ascii?Q?VweqAVDa6jhPb5PcGlauJPG5Z3LbGsT0pgjKldvjsrntycA6ZCln+nwovsIy?=
 =?us-ascii?Q?ZdSyqgZg5rEsYjmszgSDMCkzGuik2F0yErAUXWulVHc+4FswxlgjAfYWsW9o?=
 =?us-ascii?Q?a6+aMBBkzQjRLimYckWA0kSPuD07QLVByN5s9uh/k06wPDPYeac92p64Y12n?=
 =?us-ascii?Q?iKPjMpEufuM/KgYkmAaUKEvHqND0t+B2NEr5YaXGEglNRJYocCJZsDYf/8Zm?=
 =?us-ascii?Q?XvuCeYgDiHSskJqcXYl3V9aUG+Iz9kzzs64Ao/09m/LreFSrtXUTNg+08o9f?=
 =?us-ascii?Q?K9WO4Pb9GBRqeokgBNICCm6QhAaLGrfPI4dGipHG1qDmoc8VwicgLaF4TpLG?=
 =?us-ascii?Q?CKc4bZROOgo0Ok5M6PAgDqszURGx5MXZ2+OLxfpP9x6DkjmNNXqGd7PIKCOw?=
 =?us-ascii?Q?eZCQjSi6xnECqcHkm0kKKF8wW+Rc3q3uy4b4NpP+0vKdmHiFvPOxNA0HfQFj?=
 =?us-ascii?Q?eV2ku5CVRIVax3A5/z/5Og0g2MHfcyx6OXM1xzJjbf1QY7meKB2zcDZCDnYt?=
 =?us-ascii?Q?4mVy4LEIaayt8HUXzz3mNtkY4NpRcqpYGg2FoGoMZGwRLfUE+aqlGB1n8n3Z?=
 =?us-ascii?Q?AYoDME/IodRpyECUalusDtJe4GtMaq1TemWrw7ld1M0AHKHVBQbrGbH8+wOH?=
 =?us-ascii?Q?w5Tj/6DapQ3iy91VovfNzo3FygUJYfUGhlBoo/bm0wT19ofUD0aP8t0Duknq?=
 =?us-ascii?Q?nbzq80+RbftBVKGdM1qYA5P9Ql42Ttbb7T4Z?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 10:07:55.6883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4acdb3a5-93b7-432a-e330-08ddeebf94c2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9605

From: Jianbo Liu <jianbol@nvidia.com>

When a PF enters switchdev mode, its netdevice becomes the uplink
representor but remains in its current network namespace. All other
representors (VFs, SFs) are created in the netns of the devlink
instance.

If the PF's netns has been moved and differs from the devlink's netns,
enabling switchdev mode would create an invalid state where
representors and PF exist in different namespaces.

To prevent this inconsistent configuration, block the request to enter
switchdev mode if the PF netdevice's netns does not match the netns of
its devlink instance.

As part of this change, the PF's netns is first marked as immutable.
This prevents race conditions where the netns could be changed after
the check is performed but before the mode transition is complete, and
it aligns the PF's behavior with that of the final uplink representor.

Fixes: 71c6eaebf06a ("net/mlx5e: Set netdev name space on creation")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/eswitch_offloads.c     | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index bee906661282..b204ed459760 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3739,6 +3739,29 @@ void mlx5_eswitch_unblock_mode(struct mlx5_core_dev *dev)
 	up_write(&esw->mode_lock);
 }
 
+/* Returns false only when uplink netdev exists and its netns is different from
+ * devlink's netns. True for all others so entering switchdev mode is allowed.
+ */
+static bool mlx5_devlink_netdev_netns_immutable_set(struct devlink *devlink,
+						    bool immutable)
+{
+	struct mlx5_core_dev *mdev = devlink_priv(devlink);
+	struct net_device *netdev;
+	bool ret;
+
+	netdev = mlx5_uplink_netdev_get(mdev);
+	if (!netdev)
+		return true;
+
+	rtnl_lock();
+	netdev->netns_immutable = immutable;
+	ret = net_eq(dev_net(netdev), devlink_net(devlink));
+	rtnl_unlock();
+
+	mlx5_uplink_netdev_put(mdev, netdev);
+	return ret;
+}
+
 int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 				  struct netlink_ext_ack *extack)
 {
@@ -3781,6 +3804,14 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 	esw->eswitch_operation_in_progress = true;
 	up_write(&esw->mode_lock);
 
+	if (mode == DEVLINK_ESWITCH_MODE_SWITCHDEV &&
+	    !mlx5_devlink_netdev_netns_immutable_set(devlink, true)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Can't change E-Switch mode to switchdev when netdev net namespace has diverged from the devlink's.");
+		err = -EINVAL;
+		goto skip;
+	}
+
 	if (mode == DEVLINK_ESWITCH_MODE_LEGACY)
 		esw->dev->priv.flags |= MLX5_PRIV_FLAGS_SWITCH_LEGACY;
 	mlx5_eswitch_disable_locked(esw);
@@ -3799,6 +3830,8 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 	}
 
 skip:
+	if (mode == DEVLINK_ESWITCH_MODE_SWITCHDEV && err)
+		mlx5_devlink_netdev_netns_immutable_set(devlink, false);
 	down_write(&esw->mode_lock);
 	esw->eswitch_operation_in_progress = false;
 unlock:
-- 
2.31.1


