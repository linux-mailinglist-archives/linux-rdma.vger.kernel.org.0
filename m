Return-Path: <linux-rdma+bounces-4663-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAA39658A3
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 09:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64EA81C239D5
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 07:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE3B16BE03;
	Fri, 30 Aug 2024 07:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J2Zeyz2F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FF716B39E
	for <linux-rdma@vger.kernel.org>; Fri, 30 Aug 2024 07:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003125; cv=fail; b=Ecf4OWDYmd/KP7eIkpErMIBymEV8JKFqg7AGqno+XSrC2vU77JItlwn8NetrIe1x2J3XjBtKbCNwkMqDKysDoWxcjJ4JbDpc1/odEQzQwuPYJGbrFlTniIo15R65nSe+rhjtQ22okm33nhM3I8u7CWrA4tpgPXfddNqdpvBjiqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003125; c=relaxed/simple;
	bh=tI5Vqg6WttKNUXXE6sGs/gz6VzalD7hxB9dKPvGHL2c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oI9jfc6Fhu3PMVBCtFQLEiN5fi+/+FEwLw6OzcvPEDZ5h0lKhax49RmERPMhR6zwKONV3RXkBAUiGKOPkd+fmRnPChREyXh7lN5cp7+uxtR6dMeopDr1XkTNR2Q0k/HlrHWy5fIKK0DgYPLUXNxBUAQ8VyffwW9gKNvySprt/7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J2Zeyz2F; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ucg9v0Wk2qC7A81wN5QuLJS3T88I8gHIAN76pgWp46ALxDNqGXTwlsZJqeTloXZEqRv2LxvBOZqUx9XQsOw+OZl5yUk7iuUGPexQj+6d40VH/JbTA2zwDBg6M4F8aXZInNkkBMtxQZ3VirsFatbd7askuqctAAUdruiIo6G+6lFRixIpa0+YX3gV24Hz1d01ZezQxM0Kw6S2aYUoGjT8uI5h6WkACkqY+eG/j4CU8c4J465tDn1UWyArgpmwHIulKXG3iVlsxBQNXPRoe4hINRwFjr13sXPGL6AT82j9V6h6EEB4AUn3K6VxDa5KIqJ2s750nkt1LWuyagyREigfNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lQKnX3gSF6vCXhZ0ooU9bw5mXb/7dnBK4LPNMxpKMY=;
 b=y1Su30ZufTTIOQJ1uL7/Fwdo21yqX9MN9HLOZYn+j24sUCTpa5ognB+L/sPEAeQ7CxTla6e/YBXFVW/8TfDl0/4CEg/WaRGLNMGAp4NFquUHG72Zk2SOK5gZVzPUfaSF0deh5n3dKrkfJ+/nb7ahk6SG3Rlgumso0F4yi/0kzuntqL7xJ7HI/rIa4/i6mfrt2mvj8EX7GdPxQUteQUwRMAjAka4swnFFLqmCh8c6SbLQTBqpZfiGLwqy/nGCwM5IMdwZTpBXBMo//8UXiTXKVqgYSb0a9m9jZ5LFuvego1HRKW2oL1A20lnWMTD3O5mt0Ii06OA5ch4t87WLRWBufA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lQKnX3gSF6vCXhZ0ooU9bw5mXb/7dnBK4LPNMxpKMY=;
 b=J2Zeyz2FOswZJpDMbOHt64LHhbKQmB4tvk8YfsCE4M4wzSJ35+pdXtKlsuD51dwiNEHMfKfhN5lNz+WoWm2oIPYDLP2Ouc5cPVmJ3JyHUGOJeVp3/2N8X5hasK+04cRiSkma8Y1F8tmyfdbh2ZTUv9YfJJeZpAWOfCZSQOzxhJzEkhIM35m+bzbslIzpQafHw7KTItVKx3zfsMU+KAsakIdBrKd9bTsWjP2OMQ4MRGU5gEMxGqu3LUX5z3b8SnMWhUmQOKSfCJQNs1euKwuvoEYXSX9WOsw60AjSUqE07Pspiai0WEn+PNqDcqrAVU5QQiKzIW3LiVOOBsoaszl25Q==
Received: from MW4PR04CA0078.namprd04.prod.outlook.com (2603:10b6:303:6b::23)
 by PH7PR12MB9065.namprd12.prod.outlook.com (2603:10b6:510:1f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 30 Aug
 2024 07:31:59 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:6b:cafe::2d) by MW4PR04CA0078.outlook.office365.com
 (2603:10b6:303:6b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20 via Frontend
 Transport; Fri, 30 Aug 2024 07:31:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.2 via Frontend Transport; Fri, 30 Aug 2024 07:31:58 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 30 Aug
 2024 00:31:49 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 30 Aug
 2024 00:31:49 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 30 Aug
 2024 00:31:47 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <leonro@nvidia.com>, <mbloch@nvidia.com>,
	<cmeiohas@nvidia.com>, <msanalla@nvidia.com>, Michael Guralnik
	<michaelgur@nvidia.com>
Subject: [PATCH rdma-next v2 6/7] RDMA/nldev: Add support for RDMA monitoring
Date: Fri, 30 Aug 2024 10:31:29 +0300
Message-ID: <20240830073130.29982-7-michaelgur@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|PH7PR12MB9065:EE_
X-MS-Office365-Filtering-Correlation-Id: e84a3576-36f4-4926-8079-08dcc8c5d51e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?40AdfjrWNk6pL+iA2DgyPsFiwZkOk2zAOkTALMA52uxy3inWp5/uapPKXtD6?=
 =?us-ascii?Q?ylMIFzmLKgnY3JDefAetGX6JUaRsQEjFeRbeX+qHiKX1I1xKST92bpFSQF5P?=
 =?us-ascii?Q?VvTHqA4xHp3TPJFhVGSNGEbFXLZZulcE1tfoaj8y4ljAfWXFFID2AnBPTFjh?=
 =?us-ascii?Q?h0pV8pVcGbXjSTrY7ex+NbfxFb368FC14IPpsqEhjItrdCeKDx7/uSdIUWTd?=
 =?us-ascii?Q?wveVa+ia7zU+7zBJDcEygYRWEm5IYv4d/m1VtD1GnFTR3xq8QXEcpO47g3T/?=
 =?us-ascii?Q?EaZPIxDYjqOkjv0Um5LV6Szyc5XQnk7jbxTJG7VAyYnDbU6IkjDDF4qPz48c?=
 =?us-ascii?Q?OcmNda8vXZ9r7X9p8XbiaTTOY2wZNmP4Y5PCykMY5TiEoYUplsjZy3iodwcI?=
 =?us-ascii?Q?KADzqm14nj5NshKgtCLS0XbNCzunhoFZcuqWxNSWAVwnqpAz7hlnZmibYNdF?=
 =?us-ascii?Q?LTMlYU/+VI+7PoqaEDmuz7sZ4cudJAEWoxW8VZQfND8t/MECldNcHbmSayNi?=
 =?us-ascii?Q?W3BuD/BuZqnFaZG9x111zsbd7xWDQ0SolCyXynXUY04pQyf+wIT5uxWfvXQF?=
 =?us-ascii?Q?TMUK7K5Q48O4aoBQjMteWMDk0y8S0E1552mksmQqd6iR601jTRjlwLKhAN5G?=
 =?us-ascii?Q?6CIWzdk5E1OQeQmpVo2L7nnfuDCMZsRxaCHhW1nSnJrbydGHFs+hJ0pK5w2v?=
 =?us-ascii?Q?y/dSv41jhIciopzovUgZUQywSg1PC1UQbjcmmYjDOc7srSLG7HlOnIGxJdjX?=
 =?us-ascii?Q?YC2ih7dfqzpwwozXn0+csaRGOK1wbaj/NCR4V+MkiF9WY3uTpldk9ZKDS1tz?=
 =?us-ascii?Q?zWA4+klkxmu/7/Y5oIAOgnLNTVG3T7VTIM1Nj3GYiUxKA577gnx5YZpGz8L6?=
 =?us-ascii?Q?IJT6MQY1Af49JxkOi29qYdHajZxt5Grkag+K+8Ih8K0tJLOYSW6x8Ka1EcL5?=
 =?us-ascii?Q?DBSD3RfUG/TLZ3W5TRU2x7ZlwxDxziI0OZ/jChj5ikjee8yLMnmBC3YsbydF?=
 =?us-ascii?Q?fDg4+QYAHVpzBMqIja8VwZpN4Lf9h7Ye9xGJlVYQ8lJpPDIqkm/l7ZkKo5iE?=
 =?us-ascii?Q?70DU0dyFfh5FTxq77es+wyG2dJtCsPr+IlHeRyS6LS9sovgRBSNPG5YHqOX5?=
 =?us-ascii?Q?3+iRbHf/pRWVRBuY59VuL611yCdYnWKwN32/7AdvF2mCP4myZH+TYZIjBrGn?=
 =?us-ascii?Q?Ehmb50u4NY4OD+EGafOFNx5+rpSWLCBSqQdrnEDlwoBPWUgL21yXWtfYxmcZ?=
 =?us-ascii?Q?+QrGMqyTLXXzy0QPONT2zDQQ9oOjqLWaSHTwTE3kO3umfYVdz6Wjm5nkR3JZ?=
 =?us-ascii?Q?alU0mrLwbTZ8QqvsHox/wnLh2/mMsE1jVqavQCT4RdBB4l7lvZTLKrHfuVWW?=
 =?us-ascii?Q?ODCMOl1hyQwQsPz1M+PgADdSZkSjhKsCyr1iGHY3duVG1KxtGbQUk81ZOwpv?=
 =?us-ascii?Q?sRudrhW/9xidEMz7zLJkzJM2ScDmRw/F?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 07:31:58.8488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e84a3576-36f4-4926-8079-08dcc8c5d51e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9065

From: Chiara Meiohas <cmeiohas@nvidia.com>

Introduce a new netlink command to allow rdma event monitoring.
The rdma events supported now are IB device
registration/unregistration and net device attachment/detachment.

Example output of rdma monitor and the commands which trigger
the events:

$ rdma monitor
$ rmmod mlx5_ib
[UNREGISTER]    dev 3
[UNREGISTER]    dev 0

$modprobe mlx5_ib
[REGISTER]      dev 4
[NETDEV_ATTACH] dev 4 port 1 netdev 4
[REGISTER]      dev 5
[NETDEV_ATTACH] dev 5 port 1 netdev 5

$ devlink dev eswitch set pci/0000:08:00.0 mode switchdev
[UNREGISTER]    dev 4
[REGISTER]      dev 6
[NETDEV_ATTACH] dev 6 port 6 netdev 4

$ echo 4 > /sys/class/net/eth2/device/sriov_numvfs
[NETDEV_ATTACH] dev 6 port 2 netdev 7
[NETDEV_ATTACH] dev 6 port 3 netdev 8
[NETDEV_ATTACH] dev 6 port 4 netdev 9
[NETDEV_ATTACH] dev 6 port 5 netdev 10
[REGISTER]      dev 7
[NETDEV_ATTACH] dev 7 port 1 netdev 11
[REGISTER]      dev 8
[NETDEV_ATTACH] dev 8 port 1 netdev 12
[REGISTER]      dev 9
[NETDEV_ATTACH] dev 9 port 1 netdev 13
[REGISTER]      dev 10
[NETDEV_ATTACH] dev 10 port 1 netdev 14

$ echo 0 > /sys/class/net/eth2/device/sriov_numvfs
[UNREGISTER]    dev 7
[UNREGISTER]    dev 8
[UNREGISTER]    dev 9
[UNREGISTER]    dev 10
[NETDEV_DETACH] dev 6 port 2
[NETDEV_DETACH] dev 6 port 3
[NETDEV_DETACH] dev 6 port 4
[NETDEV_DETACH] dev 6 port 5

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/device.c  |  38 ++++++++++
 drivers/infiniband/core/netlink.c |   1 +
 drivers/infiniband/core/nldev.c   | 118 ++++++++++++++++++++++++++++++
 include/rdma/rdma_netlink.h       |  12 +++
 include/uapi/rdma/rdma_netlink.h  |  15 ++++
 5 files changed, 184 insertions(+)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index b2fc5a13577c..2113eb7c7573 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1351,6 +1351,30 @@ static void prevent_dealloc_device(struct ib_device *ib_dev)
 {
 }
 
+static void ib_device_notify_register(struct ib_device *device)
+{
+	struct net_device *netdev;
+	u32 port;
+	int ret;
+
+	ret = rdma_nl_notify_event(device, 0, RDMA_REGISTER_EVENT);
+	if (ret)
+		return;
+
+	rdma_for_each_port(device, port) {
+		netdev = ib_device_get_netdev(device, port);
+		if (!netdev)
+			continue;
+
+		ret = rdma_nl_notify_event(device, port,
+					   RDMA_NETDEV_ATTACH_EVENT);
+		dev_put(netdev);
+		if (ret)
+			return;
+	}
+	return;
+}
+
 /**
  * ib_register_device - Register an IB device with IB core
  * @device: Device to register
@@ -1449,6 +1473,8 @@ int ib_register_device(struct ib_device *device, const char *name,
 	dev_set_uevent_suppress(&device->dev, false);
 	/* Mark for userspace that device is ready */
 	kobject_uevent(&device->dev.kobj, KOBJ_ADD);
+
+	ib_device_notify_register(device);
 	ib_device_put(device);
 
 	return 0;
@@ -1491,6 +1517,7 @@ static void __ib_unregister_device(struct ib_device *ib_dev)
 		goto out;
 
 	disable_device(ib_dev);
+	rdma_nl_notify_event(ib_dev, 0, RDMA_UNREGISTER_EVENT);
 
 	/* Expedite removing unregistered pointers from the hash table */
 	free_netdevs(ib_dev);
@@ -2159,6 +2186,7 @@ static void add_ndev_hash(struct ib_port_data *pdata)
 int ib_device_set_netdev(struct ib_device *ib_dev, struct net_device *ndev,
 			 u32 port)
 {
+	enum rdma_nl_notify_event_type etype;
 	struct net_device *old_ndev;
 	struct ib_port_data *pdata;
 	unsigned long flags;
@@ -2190,6 +2218,16 @@ int ib_device_set_netdev(struct ib_device *ib_dev, struct net_device *ndev,
 	spin_unlock_irqrestore(&pdata->netdev_lock, flags);
 
 	add_ndev_hash(pdata);
+
+	down_read(&devices_rwsem);
+	if (xa_get_mark(&devices, ib_dev->index, DEVICE_REGISTERED) &&
+	    xa_load(&devices, ib_dev->index) == ib_dev) {
+		etype = ndev ?
+			RDMA_NETDEV_ATTACH_EVENT : RDMA_NETDEV_DETACH_EVENT;
+		rdma_nl_notify_event(ib_dev, port, etype);
+	}
+	up_read(&devices_rwsem);
+
 	return 0;
 }
 EXPORT_SYMBOL(ib_device_set_netdev);
diff --git a/drivers/infiniband/core/netlink.c b/drivers/infiniband/core/netlink.c
index ae2db0c70788..def14c54b648 100644
--- a/drivers/infiniband/core/netlink.c
+++ b/drivers/infiniband/core/netlink.c
@@ -311,6 +311,7 @@ int rdma_nl_net_init(struct rdma_dev_net *rnet)
 	struct net *net = read_pnet(&rnet->net);
 	struct netlink_kernel_cfg cfg = {
 		.input	= rdma_nl_rcv,
+		.flags = NL_CFG_F_NONROOT_RECV,
 	};
 	struct sock *nls;
 
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 4d4a1f90e484..b0354bb8ba0d 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -170,6 +170,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_DEV_TYPE]		= { .type = NLA_U8 },
 	[RDMA_NLDEV_ATTR_PARENT_NAME]		= { .type = NLA_NUL_STRING },
 	[RDMA_NLDEV_ATTR_NAME_ASSIGN_TYPE]	= { .type = NLA_U8 },
+	[RDMA_NLDEV_ATTR_EVENT_TYPE]		= { .type = NLA_U8 },
 };
 
 static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
@@ -2722,6 +2723,123 @@ static const struct rdma_nl_cbs nldev_cb_table[RDMA_NLDEV_NUM_OPS] = {
 	},
 };
 
+static int fill_mon_netdev_association(struct sk_buff *msg,
+				       struct ib_device *device, u32 port,
+				       const struct net *net)
+{
+	struct net_device *netdev = ib_device_get_netdev(device, port);
+	int ret = 0;
+
+	if (netdev && !net_eq(dev_net(netdev), net))
+		goto out;
+
+	ret = nla_put_u32(msg, RDMA_NLDEV_ATTR_DEV_INDEX, device->index);
+	if (ret)
+		goto out;
+	ret = nla_put_u32(msg, RDMA_NLDEV_ATTR_PORT_INDEX, port);
+	if (ret)
+		goto out;
+	if (netdev)
+		ret = nla_put_u32(msg, RDMA_NLDEV_ATTR_NDEV_INDEX,
+				  netdev->ifindex);
+
+out:
+	dev_put(netdev);
+	return ret;
+}
+
+static int fill_mon_register(struct sk_buff *msg, struct ib_device *device,
+			     const struct net *net)
+{
+	return nla_put_u32(msg, RDMA_NLDEV_ATTR_DEV_INDEX, device->index);
+}
+
+static void rdma_nl_notify_err_msg(struct ib_device *device, u32 port_num,
+				    enum rdma_nl_notify_event_type type)
+{
+	struct net_device *netdev;
+
+	switch (type) {
+	case RDMA_REGISTER_EVENT:
+		dev_warn_ratelimited(&device->dev,
+				     "Failed to send RDMA monitor register device event\n");
+		break;
+	case RDMA_UNREGISTER_EVENT:
+		dev_warn_ratelimited(&device->dev,
+				     "Failed to send RDMA monitor unregister device event\n");
+		break;
+	case RDMA_NETDEV_ATTACH_EVENT:
+		netdev = ib_device_get_netdev(device, port_num);
+		dev_warn_ratelimited(&device->dev,
+				     "Failed to send RDMA monitor netdev attach event: port %d netdev %d\n",
+				     port_num, netdev->ifindex);
+		dev_put(netdev);
+		break;
+	case RDMA_NETDEV_DETACH_EVENT:
+		dev_warn_ratelimited(&device->dev,
+				     "Failed to send RDMA monitor netdev detach event: port %d\n",
+				     port_num);
+	default:
+		break;
+	};
+}
+
+int rdma_nl_notify_event(struct ib_device *device, u32 port_num,
+			  enum rdma_nl_notify_event_type type)
+{
+	struct sk_buff *skb;
+	struct net *net;
+	int ret = 0;
+	void *nlh;
+
+	net = read_pnet(&device->coredev.rdma_net);
+	if (!net)
+		return -EINVAL;
+
+	skb = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+	nlh = nlmsg_put(skb, 0, 0,
+			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, RDMA_NLDEV_CMD_MONITOR),
+			0, 0);
+
+	switch (type) {
+	case RDMA_REGISTER_EVENT:
+	case RDMA_UNREGISTER_EVENT:
+		ret = fill_mon_register(skb, device, net);
+		if (ret)
+			goto err_free;
+		break;
+	case RDMA_NETDEV_ATTACH_EVENT:
+	case RDMA_NETDEV_DETACH_EVENT:
+		ret = fill_mon_netdev_association(skb, device,
+						  port_num, net);
+		if (ret)
+			goto err_free;
+		break;
+	default:
+		ret = -EINVAL;
+		goto err_free;
+	}
+
+	ret = nla_put_u8(skb, RDMA_NLDEV_ATTR_EVENT_TYPE, type);
+	if (ret)
+		goto err_free;
+
+	nlmsg_end(skb, nlh);
+	ret = rdma_nl_multicast(net, skb, RDMA_NL_GROUP_NOTIFY, GFP_KERNEL);
+	if (ret && ret != -ESRCH) {
+		skb = NULL; /* skb is freed in the netlink send-op handling */
+		goto err_free;
+	}
+	return 0;
+
+err_free:
+	rdma_nl_notify_err_msg(device, port_num, type);
+	nlmsg_free(skb);
+	return ret;
+}
+
 void __init nldev_init(void)
 {
 	rdma_nl_register(RDMA_NL_NLDEV, nldev_cb_table);
diff --git a/include/rdma/rdma_netlink.h b/include/rdma/rdma_netlink.h
index c2a79aeee113..326deaf56d5d 100644
--- a/include/rdma/rdma_netlink.h
+++ b/include/rdma/rdma_netlink.h
@@ -6,6 +6,8 @@
 #include <linux/netlink.h>
 #include <uapi/rdma/rdma_netlink.h>
 
+struct ib_device;
+
 enum {
 	RDMA_NLDEV_ATTR_EMPTY_STRING = 1,
 	RDMA_NLDEV_ATTR_ENTRY_STRLEN = 16,
@@ -110,6 +112,16 @@ int rdma_nl_multicast(struct net *net, struct sk_buff *skb,
  */
 bool rdma_nl_chk_listeners(unsigned int group);
 
+/**
+ * Prepare and send an event message
+ * @ib: the IB device which triggered the event
+ * @port_num: the port number which triggered the event - 0 if unused
+ * @type: the event type
+ * Returns 0 on success or a negative error code
+ */
+int rdma_nl_notify_event(struct ib_device *ib, u32 port_num,
+			 enum rdma_nl_notify_event_type type);
+
 struct rdma_link_ops {
 	struct list_head list;
 	const char *type;
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index 2f37568f5556..5f9636d26050 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -15,6 +15,7 @@ enum {
 enum {
 	RDMA_NL_GROUP_IWPM = 2,
 	RDMA_NL_GROUP_LS,
+	RDMA_NL_GROUP_NOTIFY,
 	RDMA_NL_NUM_GROUPS
 };
 
@@ -305,6 +306,8 @@ enum rdma_nldev_command {
 
 	RDMA_NLDEV_CMD_DELDEV,
 
+	RDMA_NLDEV_CMD_MONITOR,
+
 	RDMA_NLDEV_NUM_OPS
 };
 
@@ -574,6 +577,8 @@ enum rdma_nldev_attr {
 
 	RDMA_NLDEV_ATTR_NAME_ASSIGN_TYPE,	/* u8 */
 
+	RDMA_NLDEV_ATTR_EVENT_TYPE,		/* u8 */
+
 	/*
 	 * Always the end
 	 */
@@ -624,4 +629,14 @@ enum rdma_nl_name_assign_type {
 	RDMA_NAME_ASSIGN_TYPE_USER = 1, /* Provided by user-space */
 };
 
+/*
+ * Supported rdma monitoring event types.
+ */
+enum rdma_nl_notify_event_type {
+	RDMA_REGISTER_EVENT,
+	RDMA_UNREGISTER_EVENT,
+	RDMA_NETDEV_ATTACH_EVENT,
+	RDMA_NETDEV_DETACH_EVENT,
+};
+
 #endif /* _UAPI_RDMA_NETLINK_H */
-- 
2.17.2


