Return-Path: <linux-rdma+bounces-4664-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D54149658A5
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 09:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BBBD1F262F6
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 07:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3E016B390;
	Fri, 30 Aug 2024 07:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D2mWfaiV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D69E16B38B
	for <linux-rdma@vger.kernel.org>; Fri, 30 Aug 2024 07:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003126; cv=fail; b=gsjWnuSY2nK5lkQjjU4zX1lWI92C/ibazlKc6aQ5H+FH+cfnTqzKPA1vD3kpGuh9lUasxxE0HF0c4O1yoq3htUGuM/HkRQhUn0RfweYQEPL81/iwlO2fMaITwQNoDnBnJkH5LWtVPdF+jY4er+VluDbeVyg0W9kPy7cWfU7T6UQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003126; c=relaxed/simple;
	bh=QiX9r8v8Am7Cw8S5F6697UK1l+U4FuTjeBwd3sQRyzM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VBfSgaebvpC4fqwVh7S+wEQUlIqInwMPmrhViD20TtSFurJqvmZ1l5zhP0MHyUmweFKGF0UhOZEeZ456ta+ir0n0y77l/x3maX9j0teBPipSp0kLf6So3V6MH+RqhfoF8xnBOL/Vhptdv9149Me8mz2S2OPXahxn/H8DZg2ndkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D2mWfaiV; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kI5XmcBc8v1e3opoWh1KrzamM6I+AmASyKdX4LHjmyjtA282hMxwXSTRwCfv5ZiKlz+kCdSArCkZsfGiMbnxT2ro+JNoKIXhVIYOgVFEW2Tw0RVGWOQ7s43ImiLcbsDtWlZxLskpFqDYjDpVqlJVaFaPs1MOarjU1vpbD7YXxfaIlO9L1uwu713ZOARArGNvt+0yCflHVoFkSV9TQ93pUuGlpZmFUsryzNv60IK42kcYtVZfMie6XSamjBFqIVgG+uBRRzWfbHxUVwr0UMMrTM/eXoLoz7TkwBd/QJjBUdAWsiQCV+xZ6IEGC3YIMMXBa1z8jR2oxseZWzccF+p8iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WM98OpYaBWrGP/uyMHl9VBSg7oci8BT4A/3KzuA1+ag=;
 b=OFNUsLhG/f/4VDv36OS+v75hAsCF7EnLdzRw8RrWyTqwVkJeyiz1jEcBeTP/ueTF/eRZXbbbnzjjnC04Sjwcgmsdyz2T7VGnu1CEUgUmKMThjBxiwdzOC+odf77zatokpgN59Ux7Ml2oWm1E5atMsZIacwEZ6UhWAlbTJlB3atEMpTSdqJA8EMBb2GBcxbKkH7RT5PBv0HcLeOA72fR5VaJ4HF8deWkl406D7CJ3s9+dl/Y2+t4inkMjzBozahpABZtZ39CDhTjBo6jRNln3hZgdHCO7sUzPP9jRdJDRsk5lV7A1VMJowNxlVyLth17bTfvR4yy/M/rlIQoAOX4MLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WM98OpYaBWrGP/uyMHl9VBSg7oci8BT4A/3KzuA1+ag=;
 b=D2mWfaiVoXiKhQPI3ZunY0Og4KoHL0oUu+FxOz3nhk3pxj8gSAOVc4iFyOEG8E7U8Wti5Ce/IZyztM24nR6IC4Blz6pwUwIHv8QKCKTMZ/yWUXwdNXQR/9QR8yP3hoSbICtCPhabnPyIab57rkfgFDA1o5QkLup5Nq0MUF0O5cF8KSHTxpwnmwTthjDbUX1bq/mZ+VrCgGqQmkc8YSZDp0LaLBZx2Ai/GG4e1I+uWGcx820qYbW4r4/xozVEzs2w5LAw1T8OwcBmWs3GLAIXMSkBUema/0SP69Rpf3qIsbH1rvxrc8F86ZXMsr0qGME+Sf9ksPbC1Gwt0STxfaYVhw==
Received: from MW4PR03CA0182.namprd03.prod.outlook.com (2603:10b6:303:b8::7)
 by SA1PR12MB8917.namprd12.prod.outlook.com (2603:10b6:806:386::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 07:31:58 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:b8:cafe::95) by MW4PR03CA0182.outlook.office365.com
 (2603:10b6:303:b8::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Fri, 30 Aug 2024 07:31:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.2 via Frontend Transport; Fri, 30 Aug 2024 07:31:58 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 30 Aug
 2024 00:31:47 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 30 Aug
 2024 00:31:46 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 30 Aug
 2024 00:31:44 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <leonro@nvidia.com>, <mbloch@nvidia.com>,
	<cmeiohas@nvidia.com>, <msanalla@nvidia.com>, Michael Guralnik
	<michaelgur@nvidia.com>
Subject: [PATCH rdma-next v2 5/7] RDMA/mlx5: Use IB set_netdev and get_netdev functions
Date: Fri, 30 Aug 2024 10:31:28 +0300
Message-ID: <20240830073130.29982-6-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20240830073130.29982-1-michaelgur@nvidia.com>
References: <20240830073130.29982-1-michaelgur@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|SA1PR12MB8917:EE_
X-MS-Office365-Filtering-Correlation-Id: 061eb3fc-b2f9-42af-e74b-08dcc8c5d4b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?whMaKVH/qh2C9PpD4lCV6gyQM0+6+vjR+wOs15EH46qnVwdq+SZvsU9TY04i?=
 =?us-ascii?Q?IfG8b3wLMTe7QTApoHgDMQUcNeyqAeBo5LQB2Fv4ahbcLEd3N5QlmRZ2RkEw?=
 =?us-ascii?Q?viDBGPv+TyzsmzJgQLohFQ5laf5cVldqKaeQHOzYWPc9MYpxYGPEKaQyp4dw?=
 =?us-ascii?Q?oidLum5ej6jY7rQs3J8TT0ku9xsaS/4Jjkplp5oNqy+5vSnfxa/pp/1UzSuL?=
 =?us-ascii?Q?o6J+Co9YfJPNQ4ofRPtg1bCw3t+n0egGzXkd5zcg/yfBe98DXtazG0cgH/e9?=
 =?us-ascii?Q?XCnnFC56z/A5GYkUTO1Q8+TZiO4vpq0M5P68Wc85W7RhJyESihweKFVfDCad?=
 =?us-ascii?Q?jLO1SGVm/zK6TNgddZcolynuMTdmrijAr6TvjHEOZLcDoJKdZQkgl+7A+ylS?=
 =?us-ascii?Q?48tN7ZBtvjiJgj7w/xGoG/zOlZSQ7I7Kmsy1/1w2jl+G+tzI/5mV2ToQDpLx?=
 =?us-ascii?Q?fG0xw4lxf/8a4dUoKPOFxrVW5duYEAvFzIFsgF8ZQWNox4AjZN7sR9I87uL1?=
 =?us-ascii?Q?9zuKoX7lBh/I+z5E+eRKxoyh2BLCjv9q6ImTrZdbU0pBrZgP8YjXTVp4zQPB?=
 =?us-ascii?Q?eZ/nMvU5AeNegMNCO9DcdaXnU1T20Yh9MK4lVzHwKVEaHASDA04cifGZiYQY?=
 =?us-ascii?Q?bqCWQ2+Yq7gP6/84xEHDkpgNqFyMWCeOXLHdZBl1znUujdiTlt0LB/z9RCS2?=
 =?us-ascii?Q?dHIFYyfVwxQ57Z5pJojD+Jh53RegZL2GmN6QZTWfdmNecHT4t9ik+YofsCgI?=
 =?us-ascii?Q?1wWv86iaMggGW4NziYU8LgIM1+l9AznfyRWQ4L/g9zGd/pX5w3aZTAXi7n7j?=
 =?us-ascii?Q?D2LwSUS72IhGdoypDMkbrJkz0gukz3s5h1gl6hi8Qdk5WRH7MOoviviHfLt8?=
 =?us-ascii?Q?KWd4W57lVwR4etSKQynjDEIAim+MSlosSCHNky2wfdZiyoo7KriujMy26vPg?=
 =?us-ascii?Q?HfSf7zETS3qcVqlSZT/QLSipus2mJyQGfjo9+F1SQHTpCe8retFCV7gszWxW?=
 =?us-ascii?Q?bRlr6PoqdDhd/2vul0q+3mIvFnPvX4RygoFAx9msr+EZccHlBk7NTIsm3g+9?=
 =?us-ascii?Q?KSytja8e/Su0rSxnh1yQPCbXJ+RhmXgANk8iHgdVSievXk+hVzcAByqV77Dd?=
 =?us-ascii?Q?yAwLfNsXohC2QuYU3oTr05aKFm82uhaRsOC4h7OlnG2pmNEtsHtuElRt+tCw?=
 =?us-ascii?Q?3772g686rh6HxrFGCpW3+7PNghpwnOXzKCPgECUzyCOvZHuRjj4+CK2Ok9PW?=
 =?us-ascii?Q?qPJ5/oyX193RbNKobrJ9NAGN34ubNITbPlUaL0y49as8PB2eeK4oYFR23yVx?=
 =?us-ascii?Q?lcSYbgfuVZKWncYA7rt0Dahzk6F4lBXsdOUFV7ti1uYA8Sys3UxivuOFQBaE?=
 =?us-ascii?Q?HysY7XD36AW09nNmrn4YrVIW4eLihOlVTuMs+6UiDvc3vVbISCYJ36KrMwYD?=
 =?us-ascii?Q?CjoU27hCnTLGFXeSEnFALvSGkSwm3+wG?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 07:31:58.1149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 061eb3fc-b2f9-42af-e74b-08dcc8c5d4b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8917

From: Chiara Meiohas <cmeiohas@nvidia.com>

The IB layer provides a common interface to store and get net
devices associated to an IB device port (ib_device_set_netdev()
and ib_device_get_netdev()).
Previously, mlx5_ib stored and managed the associated net devices
internally.

Replace internal net device management in mlx5_ib with
ib_device_set_netdev() when attaching/detaching  a net device and
ib_device_get_netdev() when retrieving the net device.

Export ib_device_get_netdev().

For mlx5 representors/PFs/VFs and lag creation we replace the netdev
assignments with the IB set/get netdev functions.

In active-backup mode lag the active slave net device is stored in the
lag itself. To assure the net device stored in a lag bond IB device is
the active slave we implement the following:
- mlx5_core: when modifying the slave of a bond we send the internal driver event
  MLX5_DRIVER_EVENT_ACTIVE_BACKUP_LAG_CHANGE_LOWERSTATE.
- mlx5_ib: when catching the event call ib_device_set_netdev()

This patch also ensures the correct IB events are sent in switchdev lag.

While at it, when in multiport eswitch mode, only a single IB device is
created for all ports. The said IB device will receive all netdev events
of its VFs once loaded, thus to avoid overwriting the mapping of PF IB
device to PF netdev, ignore NETDEV_REGISTER events if the ib device has
already been mapped to a netdev.

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/device.c              |   4 +
 drivers/infiniband/hw/mlx5/ib_rep.c           |  23 +--
 drivers/infiniband/hw/mlx5/main.c             | 183 ++++++++++++------
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   3 +-
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c |  76 ++++----
 include/linux/mlx5/device.h                   |   1 +
 include/linux/mlx5/driver.h                   |   2 +-
 include/rdma/ib_verbs.h                       |   2 +
 8 files changed, 191 insertions(+), 103 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 583047457de2..b2fc5a13577c 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2236,6 +2236,9 @@ struct net_device *ib_device_get_netdev(struct ib_device *ib_dev,
 	if (!rdma_is_port_valid(ib_dev, port))
 		return NULL;
 
+	if (!ib_dev->port_data)
+		return NULL;
+
 	pdata = &ib_dev->port_data[port];
 
 	/*
@@ -2264,6 +2267,7 @@ struct net_device *ib_device_get_netdev(struct ib_device *ib_dev,
 
 	return res;
 }
+EXPORT_SYMBOL(ib_device_get_netdev);
 
 /**
  * ib_device_get_by_netdev - Find an IB device associated with a netdev
diff --git a/drivers/infiniband/hw/mlx5/ib_rep.c b/drivers/infiniband/hw/mlx5/ib_rep.c
index 1ad934685d80..49af1cfbe6d1 100644
--- a/drivers/infiniband/hw/mlx5/ib_rep.c
+++ b/drivers/infiniband/hw/mlx5/ib_rep.c
@@ -13,6 +13,7 @@ mlx5_ib_set_vport_rep(struct mlx5_core_dev *dev,
 		      int vport_index)
 {
 	struct mlx5_ib_dev *ibdev;
+	struct net_device *ndev;
 
 	ibdev = mlx5_eswitch_uplink_get_proto_dev(dev->priv.eswitch, REP_IB);
 	if (!ibdev)
@@ -20,12 +21,9 @@ mlx5_ib_set_vport_rep(struct mlx5_core_dev *dev,
 
 	ibdev->port[vport_index].rep = rep;
 	rep->rep_data[REP_IB].priv = ibdev;
-	write_lock(&ibdev->port[vport_index].roce.netdev_lock);
-	ibdev->port[vport_index].roce.netdev =
-		mlx5_ib_get_rep_netdev(rep->esw, rep->vport);
-	write_unlock(&ibdev->port[vport_index].roce.netdev_lock);
+	ndev = mlx5_ib_get_rep_netdev(rep->esw, rep->vport);
 
-	return 0;
+	return ib_device_set_netdev(&ibdev->ib_dev, ndev, vport_index + 1);
 }
 
 static void mlx5_ib_register_peer_vport_reps(struct mlx5_core_dev *mdev);
@@ -104,11 +102,15 @@ mlx5_ib_vport_rep_load(struct mlx5_core_dev *dev, struct mlx5_eswitch_rep *rep)
 	ibdev->is_rep = true;
 	vport_index = rep->vport_index;
 	ibdev->port[vport_index].rep = rep;
-	ibdev->ib_dev.phys_port_cnt = num_ports;
-	ibdev->port[vport_index].roce.netdev =
-		mlx5_ib_get_rep_netdev(lag_master->priv.eswitch, rep->vport);
 	ibdev->mdev = lag_master;
 	ibdev->num_ports = num_ports;
+	ibdev->ib_dev.phys_port_cnt = num_ports;
+	ret = ib_device_set_netdev(&ibdev->ib_dev,
+			mlx5_ib_get_rep_netdev(lag_master->priv.eswitch,
+					       rep->vport),
+			vport_index + 1);
+	if (ret)
+		goto fail_add;
 
 	ret = __mlx5_ib_add(ibdev, profile);
 	if (ret)
@@ -161,9 +163,8 @@ mlx5_ib_vport_rep_unload(struct mlx5_eswitch_rep *rep)
 	}
 
 	port = &dev->port[vport_index];
-	write_lock(&port->roce.netdev_lock);
-	port->roce.netdev = NULL;
-	write_unlock(&port->roce.netdev_lock);
+
+	ib_device_set_netdev(&dev->ib_dev, NULL, vport_index + 1);
 	rep->rep_data[REP_IB].priv = NULL;
 	port->rep = NULL;
 
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 1046c92212c7..a750f61513d4 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -147,16 +147,52 @@ static struct mlx5_roce *mlx5_get_rep_roce(struct mlx5_ib_dev *dev,
 
 		if (upper && port->rep->vport == MLX5_VPORT_UPLINK)
 			continue;
-
-		read_lock(&port->roce.netdev_lock);
-		rep_ndev = mlx5_ib_get_rep_netdev(port->rep->esw,
-						  port->rep->vport);
-		if (rep_ndev == ndev) {
-			read_unlock(&port->roce.netdev_lock);
+		rep_ndev = ib_device_get_netdev(&dev->ib_dev, i + 1);
+		if (rep_ndev && rep_ndev == ndev) {
+			dev_put(rep_ndev);
 			*port_num = i + 1;
 			return &port->roce;
 		}
-		read_unlock(&port->roce.netdev_lock);
+
+		dev_put(rep_ndev);
+	}
+
+	return NULL;
+}
+
+static bool mlx5_netdev_send_event(struct mlx5_ib_dev *dev,
+				   struct net_device *ndev,
+				   struct net_device *upper,
+				   struct net_device *ib_ndev)
+{
+	if (!dev->ib_active)
+		return false;
+
+	/* Event is about our upper device */
+	if (upper == ndev)
+		return true;
+
+	/* RDMA device is not in lag and not in switchdev */
+	if (!dev->is_rep && !upper && ndev == ib_ndev)
+		return true;
+
+	/* RDMA devie is in switchdev */
+	if (dev->is_rep && ndev == ib_ndev)
+		return true;
+
+	return false;
+}
+
+static struct net_device *mlx5_ib_get_rep_uplink_netdev(struct mlx5_ib_dev *ibdev)
+{
+	struct mlx5_ib_port *port;
+	int i;
+
+	for (i = 0; i < ibdev->num_ports; i++) {
+		port = &ibdev->port[i];
+		if (port->rep && port->rep->vport == MLX5_VPORT_UPLINK) {
+			return ib_device_get_netdev(&ibdev->ib_dev, i + 1);
+		}
 	}
 
 	return NULL;
@@ -168,6 +204,7 @@ static int mlx5_netdev_event(struct notifier_block *this,
 	struct mlx5_roce *roce = container_of(this, struct mlx5_roce, nb);
 	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
 	u32 port_num = roce->native_port_num;
+	struct net_device *ib_ndev = NULL;
 	struct mlx5_core_dev *mdev;
 	struct mlx5_ib_dev *ibdev;
 
@@ -181,29 +218,38 @@ static int mlx5_netdev_event(struct notifier_block *this,
 		/* Should already be registered during the load */
 		if (ibdev->is_rep)
 			break;
-		write_lock(&roce->netdev_lock);
+
+		ib_ndev = ib_device_get_netdev(&ibdev->ib_dev, port_num);
+		/* Exit if already registered */
+		if (ib_ndev)
+			goto put_ndev;
+
 		if (ndev->dev.parent == mdev->device)
-			roce->netdev = ndev;
-		write_unlock(&roce->netdev_lock);
+			ib_device_set_netdev(&ibdev->ib_dev, ndev, port_num);
 		break;
 
 	case NETDEV_UNREGISTER:
 		/* In case of reps, ib device goes away before the netdevs */
-		write_lock(&roce->netdev_lock);
-		if (roce->netdev == ndev)
-			roce->netdev = NULL;
-		write_unlock(&roce->netdev_lock);
-		break;
+		if (ibdev->is_rep)
+			break;
+		ib_ndev = ib_device_get_netdev(&ibdev->ib_dev, port_num);
+		if (ib_ndev == ndev)
+			ib_device_set_netdev(&ibdev->ib_dev, NULL, port_num);
+		goto put_ndev;
 
 	case NETDEV_CHANGE:
 	case NETDEV_UP:
 	case NETDEV_DOWN: {
 		struct net_device *upper = NULL;
 
-		if (mlx5_lag_is_roce(mdev)) {
+		if (mlx5_lag_is_roce(mdev) || mlx5_lag_is_sriov(mdev)) {
 			struct net_device *lag_ndev;
 
-			lag_ndev = mlx5_lag_get_roce_netdev(mdev);
+			if(mlx5_lag_is_roce(mdev))
+				lag_ndev = ib_device_get_netdev(&ibdev->ib_dev, 1);
+			else /* sriov lag */
+				lag_ndev = mlx5_ib_get_rep_uplink_netdev(ibdev);
+
 			if (lag_ndev) {
 				upper = netdev_master_upper_dev_get(lag_ndev);
 				dev_put(lag_ndev);
@@ -216,18 +262,19 @@ static int mlx5_netdev_event(struct notifier_block *this,
 			roce = mlx5_get_rep_roce(ibdev, ndev, upper, &port_num);
 		if (!roce)
 			return NOTIFY_DONE;
-		if ((upper == ndev ||
-		     ((!upper || ibdev->is_rep) && ndev == roce->netdev)) &&
-		    ibdev->ib_active) {
+
+		ib_ndev = ib_device_get_netdev(&ibdev->ib_dev, port_num);
+
+		if (mlx5_netdev_send_event(ibdev, ndev, upper, ib_ndev)) {
 			struct ib_event ibev = { };
 			enum ib_port_state port_state;
 
 			if (get_port_state(&ibdev->ib_dev, port_num,
 					   &port_state))
-				goto done;
+				goto put_ndev;
 
 			if (roce->last_port_state == port_state)
-				goto done;
+				goto put_ndev;
 
 			roce->last_port_state = port_state;
 			ibev.device = &ibdev->ib_dev;
@@ -236,7 +283,7 @@ static int mlx5_netdev_event(struct notifier_block *this,
 			else if (port_state == IB_PORT_ACTIVE)
 				ibev.event = IB_EVENT_PORT_ACTIVE;
 			else
-				goto done;
+				goto put_ndev;
 
 			ibev.element.port_num = port_num;
 			ib_dispatch_event(&ibev);
@@ -247,39 +294,13 @@ static int mlx5_netdev_event(struct notifier_block *this,
 	default:
 		break;
 	}
+put_ndev:
+	dev_put(ib_ndev);
 done:
 	mlx5_ib_put_native_port_mdev(ibdev, port_num);
 	return NOTIFY_DONE;
 }
 
-static struct net_device *mlx5_ib_get_netdev(struct ib_device *device,
-					     u32 port_num)
-{
-	struct mlx5_ib_dev *ibdev = to_mdev(device);
-	struct net_device *ndev;
-	struct mlx5_core_dev *mdev;
-
-	mdev = mlx5_ib_get_native_port_mdev(ibdev, port_num, NULL);
-	if (!mdev)
-		return NULL;
-
-	if (mlx5_lag_is_roce(mdev)) {
-		ndev = mlx5_lag_get_roce_netdev(mdev);
-		goto out;
-	}
-
-	/* Ensure ndev does not disappear before we invoke dev_hold()
-	 */
-	read_lock(&ibdev->port[port_num - 1].roce.netdev_lock);
-	ndev = ibdev->port[port_num - 1].roce.netdev;
-	dev_hold(ndev);
-	read_unlock(&ibdev->port[port_num - 1].roce.netdev_lock);
-
-out:
-	mlx5_ib_put_native_port_mdev(ibdev, port_num);
-	return ndev;
-}
-
 struct mlx5_core_dev *mlx5_ib_get_native_port_mdev(struct mlx5_ib_dev *ibdev,
 						   u32 ib_port_num,
 						   u32 *native_port_num)
@@ -554,7 +575,7 @@ static int mlx5_query_port_roce(struct ib_device *device, u32 port_num,
 	if (!put_mdev)
 		goto out;
 
-	ndev = mlx5_ib_get_netdev(device, port_num);
+	ndev = ib_device_get_netdev(device, port_num);
 	if (!ndev)
 		goto out;
 
@@ -3185,6 +3206,60 @@ static void get_dev_fw_str(struct ib_device *ibdev, char *str)
 		 fw_rev_sub(dev->mdev));
 }
 
+static int lag_event(struct notifier_block *nb, unsigned long event, void *data)
+{
+	struct mlx5_ib_dev *dev = container_of(nb, struct mlx5_ib_dev,
+					       lag_events);
+	struct mlx5_core_dev *mdev = dev->mdev;
+	struct mlx5_ib_port *port;
+	struct net_device *ndev;
+	int  i, err;
+	int portnum;
+
+	portnum = 0;
+	switch (event) {
+	case MLX5_DRIVER_EVENT_ACTIVE_BACKUP_LAG_CHANGE_LOWERSTATE:
+		ndev = data;
+		if (ndev) {
+			if (!mlx5_lag_is_roce(mdev)) {
+				// sriov lag
+				for (i = 0; i < dev->num_ports; i++) {
+					port = &dev->port[i];
+					if (port->rep && port->rep->vport ==
+					    MLX5_VPORT_UPLINK) {
+						portnum = i;
+						break;
+					}
+				}
+			}
+			err = ib_device_set_netdev(&dev->ib_dev, ndev,
+						   portnum + 1);
+			dev_put(ndev);
+			if (err)
+				return err;
+			/* Rescan gids after new netdev assignment */
+			rdma_roce_rescan_device(&dev->ib_dev);
+		}
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+	return NOTIFY_OK;
+}
+
+static void mlx5e_lag_event_register(struct mlx5_ib_dev *dev)
+{
+	dev->lag_events.notifier_call = lag_event;
+	blocking_notifier_chain_register(&dev->mdev->priv.lag_nh,
+					 &dev->lag_events);
+}
+
+static void mlx5e_lag_event_unregister(struct mlx5_ib_dev *dev)
+{
+	blocking_notifier_chain_unregister(&dev->mdev->priv.lag_nh,
+					   &dev->lag_events);
+}
+
 static int mlx5_eth_lag_init(struct mlx5_ib_dev *dev)
 {
 	struct mlx5_core_dev *mdev = dev->mdev;
@@ -3206,6 +3281,7 @@ static int mlx5_eth_lag_init(struct mlx5_ib_dev *dev)
 		goto err_destroy_vport_lag;
 	}
 
+	mlx5e_lag_event_register(dev);
 	dev->flow_db->lag_demux_ft = ft;
 	dev->lag_ports = mlx5_lag_get_num_ports(mdev);
 	dev->lag_active = true;
@@ -3223,6 +3299,7 @@ static void mlx5_eth_lag_cleanup(struct mlx5_ib_dev *dev)
 	if (dev->lag_active) {
 		dev->lag_active = false;
 
+		mlx5e_lag_event_unregister(dev);
 		mlx5_destroy_flow_table(dev->flow_db->lag_demux_ft);
 		dev->flow_db->lag_demux_ft = NULL;
 
@@ -3937,7 +4014,6 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
 
 	for (i = 0; i < dev->num_ports; i++) {
 		spin_lock_init(&dev->port[i].mp.mpi_lock);
-		rwlock_init(&dev->port[i].roce.netdev_lock);
 		dev->port[i].roce.dev = dev;
 		dev->port[i].roce.native_port_num = i + 1;
 		dev->port[i].roce.last_port_state = IB_PORT_DOWN;
@@ -4202,7 +4278,6 @@ static const struct ib_device_ops mlx5_ib_dev_common_roce_ops = {
 	.create_wq = mlx5_ib_create_wq,
 	.destroy_rwq_ind_table = mlx5_ib_destroy_rwq_ind_table,
 	.destroy_wq = mlx5_ib_destroy_wq,
-	.get_netdev = mlx5_ib_get_netdev,
 	.modify_wq = mlx5_ib_modify_wq,
 
 	INIT_RDMA_OBJ_SIZE(ib_rwq_ind_table, mlx5_ib_rwq_ind_table,
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 47df41800ac5..262ade50be57 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -901,8 +901,6 @@ struct mlx5_roce {
 	/* Protect mlx5_ib_get_netdev from invoking dev_hold() with a NULL
 	 * netdev pointer
 	 */
-	rwlock_t		netdev_lock;
-	struct net_device	*netdev;
 	struct notifier_block	nb;
 	struct netdev_net_notifier nn;
 	struct notifier_block	mdev_nb;
@@ -1151,6 +1149,7 @@ struct mlx5_ib_dev {
 	/* protect accessing data_direct_dev */
 	struct mutex			data_direct_lock;
 	struct notifier_block		mdev_events;
+	struct notifier_block           lag_events;
 	int				num_ports;
 	/* serialize update of capability mask
 	 */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index cf8045b92689..8577db3308cc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -445,6 +445,34 @@ static int _mlx5_modify_lag(struct mlx5_lag *ldev, u8 *ports)
 	return mlx5_cmd_modify_lag(dev0, ldev->ports, ports);
 }
 
+static struct net_device *mlx5_lag_active_backup_get_netdev(struct mlx5_core_dev *dev)
+{
+	struct net_device *ndev = NULL;
+	struct mlx5_lag *ldev;
+	unsigned long flags;
+	int i;
+
+	spin_lock_irqsave(&lag_lock, flags);
+	ldev = mlx5_lag_dev(dev);
+
+	if (!ldev)
+		goto unlock;
+
+	for (i = 0; i < ldev->ports; i++)
+		if (ldev->tracker.netdev_state[i].tx_enabled)
+			ndev = ldev->pf[i].netdev;
+	if (!ndev)
+		ndev = ldev->pf[ldev->ports - 1].netdev;
+
+	if (ndev)
+		dev_hold(ndev);
+
+unlock:
+	spin_unlock_irqrestore(&lag_lock, flags);
+
+	return ndev;
+}
+
 void mlx5_modify_lag(struct mlx5_lag *ldev,
 		     struct lag_tracker *tracker)
 {
@@ -477,9 +505,18 @@ void mlx5_modify_lag(struct mlx5_lag *ldev,
 		}
 	}
 
-	if (tracker->tx_type == NETDEV_LAG_TX_TYPE_ACTIVEBACKUP &&
-	    !(ldev->mode == MLX5_LAG_MODE_ROCE))
-		mlx5_lag_drop_rule_setup(ldev, tracker);
+	if (tracker->tx_type == NETDEV_LAG_TX_TYPE_ACTIVEBACKUP) {
+		struct net_device *ndev = mlx5_lag_active_backup_get_netdev(dev0);
+
+		if(!(ldev->mode == MLX5_LAG_MODE_ROCE))
+			mlx5_lag_drop_rule_setup(ldev, tracker);
+		/** Only sriov and roce lag should have tracker->tx_type set so
+		 *  no need to check the mode
+		 */
+		blocking_notifier_call_chain(&dev0->priv.lag_nh,
+					     MLX5_DRIVER_EVENT_ACTIVE_BACKUP_LAG_CHANGE_LOWERSTATE,
+					     ndev);
+	}
 }
 
 static int mlx5_lag_set_port_sel_mode_roce(struct mlx5_lag *ldev,
@@ -613,6 +650,7 @@ static int mlx5_create_lag(struct mlx5_lag *ldev,
 			mlx5_core_err(dev0,
 				      "Failed to deactivate RoCE LAG; driver restart required\n");
 	}
+	BLOCKING_INIT_NOTIFIER_HEAD(&dev0->priv.lag_nh);
 
 	return err;
 }
@@ -1492,38 +1530,6 @@ void mlx5_lag_enable_change(struct mlx5_core_dev *dev)
 	mlx5_queue_bond_work(ldev, 0);
 }
 
-struct net_device *mlx5_lag_get_roce_netdev(struct mlx5_core_dev *dev)
-{
-	struct net_device *ndev = NULL;
-	struct mlx5_lag *ldev;
-	unsigned long flags;
-	int i;
-
-	spin_lock_irqsave(&lag_lock, flags);
-	ldev = mlx5_lag_dev(dev);
-
-	if (!(ldev && __mlx5_lag_is_roce(ldev)))
-		goto unlock;
-
-	if (ldev->tracker.tx_type == NETDEV_LAG_TX_TYPE_ACTIVEBACKUP) {
-		for (i = 0; i < ldev->ports; i++)
-			if (ldev->tracker.netdev_state[i].tx_enabled)
-				ndev = ldev->pf[i].netdev;
-		if (!ndev)
-			ndev = ldev->pf[ldev->ports - 1].netdev;
-	} else {
-		ndev = ldev->pf[MLX5_LAG_P1].netdev;
-	}
-	if (ndev)
-		dev_hold(ndev);
-
-unlock:
-	spin_unlock_irqrestore(&lag_lock, flags);
-
-	return ndev;
-}
-EXPORT_SYMBOL(mlx5_lag_get_roce_netdev);
-
 u8 mlx5_lag_get_slave_port(struct mlx5_core_dev *dev,
 			   struct net_device *slave)
 {
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index 57c9b18c3adb..dac33cfe9c0c 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -371,6 +371,7 @@ enum mlx5_driver_event {
 	MLX5_DRIVER_EVENT_SF_PEER_DEVLINK,
 	MLX5_DRIVER_EVENT_AFFILIATION_DONE,
 	MLX5_DRIVER_EVENT_AFFILIATION_REMOVED,
+	MLX5_DRIVER_EVENT_ACTIVE_BACKUP_LAG_CHANGE_LOWERSTATE,
 };
 
 enum {
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index a96438ded15f..46a7a3d11048 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -643,6 +643,7 @@ struct mlx5_priv {
 	struct mlx5_sf_hw_table *sf_hw_table;
 	struct mlx5_sf_table *sf_table;
 #endif
+	struct blocking_notifier_head lag_nh;
 };
 
 enum mlx5_device_state {
@@ -1181,7 +1182,6 @@ bool mlx5_lag_mode_is_hash(struct mlx5_core_dev *dev);
 bool mlx5_lag_is_master(struct mlx5_core_dev *dev);
 bool mlx5_lag_is_shared_fdb(struct mlx5_core_dev *dev);
 bool mlx5_lag_is_mpesw(struct mlx5_core_dev *dev);
-struct net_device *mlx5_lag_get_roce_netdev(struct mlx5_core_dev *dev);
 u8 mlx5_lag_get_slave_port(struct mlx5_core_dev *dev,
 			   struct net_device *slave);
 int mlx5_lag_query_cong_counters(struct mlx5_core_dev *dev,
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index a1dcf812d787..aa8ede439905 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4453,6 +4453,8 @@ struct net_device *ib_get_net_dev_by_params(struct ib_device *dev, u32 port,
 					    const struct sockaddr *addr);
 int ib_device_set_netdev(struct ib_device *ib_dev, struct net_device *ndev,
 			 unsigned int port);
+struct net_device *ib_device_get_netdev(struct ib_device *ib_dev,
+					u32 port);
 struct ib_wq *ib_create_wq(struct ib_pd *pd,
 			   struct ib_wq_init_attr *init_attr);
 int ib_destroy_wq_user(struct ib_wq *wq, struct ib_udata *udata);
-- 
2.17.2


