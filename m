Return-Path: <linux-rdma+bounces-13370-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E0EB57AFE
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 14:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B5C54E2131
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 12:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E840315D58;
	Mon, 15 Sep 2025 12:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MlHvvRNo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010043.outbound.protection.outlook.com [40.93.198.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F15D315D44;
	Mon, 15 Sep 2025 12:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757939151; cv=fail; b=NHCwgxzQRSBIcrf5gFEHV7EpMJJoL/UQ7Dj2h/kDu4R95jD6VtfVr+18BFsF8Asjv+AIFB8C4vPWakoktBxxLC3w3P3PMNivpWLDANjOdIXi+PC9UUnQZoUgvYovEuTSHi4bsIvZR9IHA3Qv0HTM513rKA0BP3wwRCL24WuaZ+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757939151; c=relaxed/simple;
	bh=F05T9BQbot3O+79I0GvwH/WhVWFWqthlmHB7j15A6yA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OXPRcNiR34chS/hQG5deXk+r7pafNya8hR9VpXSKqfvyuSbULK7H2hmAq95MJbTXn106L7dHTisCs4CQpxqle8cGfEtVYV2YqHEmaawsCUcilOWZ55SDOQoAW2wY93r4VG9Am2NdIoJDKJOifZHsqFuuKUG0Y6KEA6gEizaKJ6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MlHvvRNo; arc=fail smtp.client-ip=40.93.198.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qKzTHESdWQpklVRkFnPfLRRaiRb0rl3KAGtOnCdXL+TTnZ9a+loXaHG9QC3PJoggqF9RfIRCZvKJIEDp4MG8f7DrFZ/xJQTCOGJxyAfR1doOZjt16dgx7HX8EDH8jtSnTaP9WRH2Jx0PlYh6sm3rfVNow/8+aR+utIkmoYR2FxzwkAWrRcfXDZqEI6Qq7Orwub041HUQo33hyg2+L2h5vFtgPRTbzSVSL1/iQqWYghk7+LsXHgXitfS1chEhU7mcvvfa1Uvm2i8nZ673laZA0CvknXAVCpF314K7WgvPcLdY61n04cNRjP+j/VdDTp0UoI29JarhTQ1yodn3uz2fzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uKiLr0TTg3LXlJfWoEuzdymZRP8lQF89GzurWeMp6E=;
 b=LawLZf+d4ib/iBp3H6rceiOCRyJzd9VRILsiCYZE/JJCSQgzAMK8qHqLz2pATyHbYi0vPNjZrBoAPMNR/TO80USLkNsu4pwfE4bhfJlu1M1vC7bO56kuI7OCBEqKlTj78Dk3hf7leFk8gEr4AlaoGVPgWA0zVRUXtP0j6NXVc2+3GbhWPNFaWDAHse73fiOG7O3J972pdZkxFciCHd4U76lEct71DzPdDxmaJUtxD02ZXvLzNHXlNo8c1Iv8Nd0wVCWW2c8NsGJ5xz3teWLLhf/OwvqWOtF5sowOU67rZnSoKGFDUeNBcNSPmimT/Ik6MzsMplx4g2uPkX6TWNsEuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uKiLr0TTg3LXlJfWoEuzdymZRP8lQF89GzurWeMp6E=;
 b=MlHvvRNoaOrtsWASaE3IyUPKEbByBAhO2VfOhKRCRF3Ye5MUvYujmRkGnDdhpZUpJZXG8n5GF6B17KvFIdotM/wkGyggDSKYiqq/3a3r+xxRTuLlaa5MWSygnxYFcHGSfx4vhpNMGX+t0/OmVyH1on7aKWvvGbcPraNtB4llNOhRds1jv1GopjLA4nsYPRSvSZoISbjzvN2Uc+t2NUGtrvULSXigUnjNhPfQcJdskDgJpsIcFd1tckSElGEuRZrWG2S4tph+p0Inhmm1Z850rjWixWogME54qL6liCaYSLEEmuzOHoL5V5V6EgSQgyWs8GFj/dmxCuKY7+EwIMeozQ==
Received: from BL1PR13CA0195.namprd13.prod.outlook.com (2603:10b6:208:2be::20)
 by CH3PR12MB7569.namprd12.prod.outlook.com (2603:10b6:610:146::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 12:25:46 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2be:cafe::e8) by BL1PR13CA0195.outlook.office365.com
 (2603:10b6:208:2be::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12 via Frontend Transport; Mon,
 15 Sep 2025 12:25:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 12:25:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 05:25:31 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 05:25:30 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 15
 Sep 2025 05:25:26 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>
Subject: [PATCH net V2 2/3] net/mlx5e: Prevent entering switchdev mode with inconsistent netns
Date: Mon, 15 Sep 2025 15:24:33 +0300
Message-ID: <1757939074-617281-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1757939074-617281-1-git-send-email-tariqt@nvidia.com>
References: <1757939074-617281-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|CH3PR12MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: 3545b550-f67f-4ff0-a1f4-08ddf452ff5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2lGamxrNm0A5BFmPq+aNSrxgTGDbAglwmlZcO4XxHkQsl6cC9n/KQT8nHTEW?=
 =?us-ascii?Q?tPESsMvUPA+udRsJZG7dTrOgwPWrF8QLiAW0w87JitufYzms82Ii/rUj+bWp?=
 =?us-ascii?Q?YSnqOHaGf9gZ0oSdTTNZch3bMfQ3LNpwvB2fbeXSnOtudqBTDBLckKn4SxCz?=
 =?us-ascii?Q?h7LKrDCYKfMfMi1YBOsF/+oRqLAFsJQ1R16gUylp6XXkFqHbJbpT1FmPaexX?=
 =?us-ascii?Q?w4IYILSvjNcQtIB0/tH6MmK+M21A9cFkKAo8py0XF81HgtB2c+HmcPReEshT?=
 =?us-ascii?Q?mHbjLe9ATmFVywJ/myCmoeGC+fnqAa3nukuA1N7+tfavKeMLpYhaDZ3qwXa4?=
 =?us-ascii?Q?6KYxOYfFvUexzVV7w1D2RWc5ctJ13b8j6CydrQ8wPGYXCLama/wTRJsY7fX0?=
 =?us-ascii?Q?Ji+zmNFlqeimL3bgGZUEaI3y/zuu/Uvr2T/aKV6aVhMnv2RCdQUuvpKmCrlQ?=
 =?us-ascii?Q?LGBgIp/+8NLptavmaqjdUMQxtg8b4UEps/q/x8PtqwxC2tMJ9z57ampLzjvG?=
 =?us-ascii?Q?DSIRTqdIAWedxLd6q1FhPhcZsrRMV8oHkPVvJstcGZJQj8ZF+mUAOPgQZypI?=
 =?us-ascii?Q?DCeR2RFtkYKzTSX5kvQWiMRQI5eHdVr+CfzSbh1t3fx9lc5Fo5hnH73dTH+F?=
 =?us-ascii?Q?qp8n59e4Vt44unw0T72Xm2hTVOTwZW4K6lH7czoJvd5L7PS1LDkTNyKLjn0Z?=
 =?us-ascii?Q?CXX7MyDXRin8mZ01oEsBBbo/y0WJ+38+3pPUpIJ1iDwN+U3BLPkRfh3r5aKg?=
 =?us-ascii?Q?oahN5UwhMnQ3IMUzYHDwWT58FoFqt0fokX+k5T+i214jN3GhyKVYMOa+Sipe?=
 =?us-ascii?Q?xmHdzn5PNNY7TZG28NxqBBtTFmOwsLG5yhMPa/++kO5kpmzIOuXPMDeQMY5N?=
 =?us-ascii?Q?lytNsx27rnSIlIqjArpo4dj2a1HCHyC/EiT/2uqQ0LC3BNZ2wJiRERWnNWYE?=
 =?us-ascii?Q?xki+xRMYdhmrYOZ6P2LFbz4wQR8/e5tUqiPsBSv/mPsLYFAos8IOEpLChzgc?=
 =?us-ascii?Q?EJFvSarbgd1o1lZVOB7pD4UqEf4gJ5nfW0x6gEttmKNTTqXl1tlwxpN969+f?=
 =?us-ascii?Q?zzXapGZr9ld8V042DeF4kYS4bINoAIoSwXqpigGso5S8Q7ftyrtyxJdDILS8?=
 =?us-ascii?Q?LNWFRCdgMh6FDqOjX/l50WPy7irK1Wjhuhksus+EZ6bYUsRqUosP4WfrcMRc?=
 =?us-ascii?Q?zGjPoffsTbE/k+NKkgKXH4FiFbOcaKFg2c4PqcvF9n6iXERZHwepGkEHwroZ?=
 =?us-ascii?Q?MvmMgWGQWPFfgQ7rw2GmrLfi55ED95TdpY4YBdB3p1AR6qlCxW949PvuzwdP?=
 =?us-ascii?Q?sRUnhgbK/2S0PEIJ3yB+dTrIU0KAGVNxZBGkJpv1issomy6Q8VKD3NQPRjwz?=
 =?us-ascii?Q?i/XyuNe6vu5d8gK1FBhal+7GJBjxmcpLFhm55ghIV2vWdEg9TgpA9ShAFd56?=
 =?us-ascii?Q?ZBPQS0RUCNviGFb65QvrJQXpaJeqf3kIvtCaWUBfZRsd69QMXfdHoijI5Zfs?=
 =?us-ascii?Q?Y3+IcJ3wsnfAdTe5vKRBPEbqwdEBligtDciL?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 12:25:46.3596
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3545b550-f67f-4ff0-a1f4-08ddf452ff5f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7569

From: Jianbo Liu <jianbol@nvidia.com>

When a PF enters switchdev mode, its netdevice becomes the uplink
representor but remains in its current network namespace. All other
representors (VFs, SFs) are created in the netns of the devlink
instance.

If the PF's netns has been moved and differs from the devlink's netns,
enabling switchdev mode would create a state where the OVS control
plane (ovs-vsctl) cannot manage the switch because the PF uplink
representor and the other representors are split across different
namespaces.

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


