Return-Path: <linux-rdma+bounces-4447-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B48729593E3
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 07:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8C12846C2
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 05:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A5614B978;
	Wed, 21 Aug 2024 05:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GlZmqq5i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A8A155A32
	for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2024 05:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724217056; cv=fail; b=P5zdudTUhluQFG6QG886J41cH8jVgJp14uJX815CURlv+7b4jO4PyYPTq8d58VwyJgQrzuzsZY4oJAdzKy7R3zbF6OvT6Vp/b0EpoYqv1/m/94vm2d8jKfeHfhcFYczuq2ngRhY/027f9JEu2lS3WBjvjpXHypXZtqIsnc/3+Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724217056; c=relaxed/simple;
	bh=0WKga267J6OZR5L3arpGAkNxNVESozhB9ujB1dXARIM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WjtQY+FOIZLdp71FAGJWyt8ElJxaS+nWUTZ2ew7Bz11KpFcvMjgB0tk8a43ttdsUBShedpQVoDsBPwADZxqLShH4DM2B1N2CIEtyOmUiVfZy5Jn6WFa7e763R6ZN6Loefz4rIBSzSni3CId0s0RBF3jYIhdBG1nWbizYG5W18Dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GlZmqq5i; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edrR0irhTXcPtSJ62sZvtgpZ15lVHk6KzvqU2xNXheDptJNHhA9Wds3emAKylArgiNVkLEFhf2wTZG5E9NEhBf8/oU3IICwjR8sTIgPeTWVjjtnaci5rMLcs9V16FY0WwxoXnFgB3gVCqxJFNoh+GORe+zlBVwPs0OimV43J48sQKbtK27RF3dXgFdSuMD2+yj1wxwRM0XJ7INt5LFTVkwITCvOJsJQZ5B6ByO2+OFe9+FAcvPG5/tAPMge8+oqYyYWZMHJpIgEksjLbAiHcDOBgIH0FetrzMSX4fdXwQoHk7G+YYKEtF6TfvnZ1pdDw+6gfgbdgk8S+yAoh1Kypyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HaH+38pdKn7KLTcvy75vWdVLaB2VYrxafhkF16g/lQ=;
 b=LMXqnlo0AOs2p9aTSBn7DQsxbh/JSnXVeFhK/x2zC4gPk2H5d1U5uH390rZjeoq1iDcO3x/3W5roO45OWuPSmgomL0E9ThNxDBfNCmz1PKOI6ZZ6GpOGJaXwJVpMCgGDxfLtw9Z0x9NqrH9/EnMnEndKguQX9I9WJ5MNzAhKIvAEfCi+b2rQq7aIemm7PkHbWO90yi++ZkX6LUBwm5unDsk4DY1A6hnMTB2zuzawh9H0FjUpgAG1BeUnsRUVOl/nvl3B2xs/AkC2/sCOBCQ7goI1DnzbT8Xdv1r5NOIuk+a0hcUCxQCRVyGj4p0LiX0jRb4YAeGIifSfEQ26NYiUdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HaH+38pdKn7KLTcvy75vWdVLaB2VYrxafhkF16g/lQ=;
 b=GlZmqq5iYNchZ3pl4p7r4RQfMlNQuziCBUx9tGNQd44O5GyUb//BfbaG9j4pwolOc/qyz47HmwutjwHqEVkmSJYPi1yi+wDHoFgB+ENFVySFaIHTbrE7Tvhn2qn9mHg0pVs4jdBJOif+mvhGr4Dn4/IATpG0zS7A0GmCb9jNPoPEtUVR3RSfS8HQfRtZsBbjT5+2fE4ATq02Q5uVEkhVOnCPRMczSC0dvNp/MOUOBOmE5V0ovsRcXAgMCFZK2B/W24TmoQ+Vt9zzx51bZaciVFASoZhqWge0GkOUHtLAbAplRnSPRiariVMAhIEfmP6WtcjMJEU17RSUclqwb/1Nbg==
Received: from BY5PR20CA0010.namprd20.prod.outlook.com (2603:10b6:a03:1f4::23)
 by MN6PR12MB8565.namprd12.prod.outlook.com (2603:10b6:208:47d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 05:10:51 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::83) by BY5PR20CA0010.outlook.office365.com
 (2603:10b6:a03:1f4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Wed, 21 Aug 2024 05:10:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Wed, 21 Aug 2024 05:10:50 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 20 Aug
 2024 22:10:40 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 20 Aug
 2024 22:10:39 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 20 Aug
 2024 22:10:37 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <leonro@nvidia.com>, <mbloch@nvidia.com>,
	<cmeiohas@nvidia.com>, <msanalla@nvidia.com>, Michael Guralnik
	<michaelgur@nvidia.com>
Subject: [PATCH rdma-next 6/7] RDMA/nldev: Add support for RDMA monitoring
Date: Wed, 21 Aug 2024 08:10:16 +0300
Message-ID: <20240821051017.7730-7-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20240821051017.7730-1-michaelgur@nvidia.com>
References: <20240821051017.7730-1-michaelgur@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|MN6PR12MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: b6e74086-c724-4d49-16a9-08dcc19f9fcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ql4iecuGybHuBO1ioIUPndIVayR93hBojaJZX26hVYGKKt4EEFnFE3rrYAju?=
 =?us-ascii?Q?NPWptYE6+/KM9ReEnL43IN/wKkv1hKVf7iUixi6K8iEU0GkqfWjzaNqNsngk?=
 =?us-ascii?Q?Ry1n6WEZdlwi5EJEIInJ6zsvmnV8GlNjaKroOAcQnBlKRAU0cBHpMF1fulK+?=
 =?us-ascii?Q?4Ccxa8i6m8KqU9N881b3Uy8Ow+B03calQvYAedehRCpR4lQ2g+/lSpNV16cP?=
 =?us-ascii?Q?+bvGK6R7oUJX60zgTIuSL4fsz8+j0N/oQ5RiUYNgIX0pcdY/S+GtXqZxIxYf?=
 =?us-ascii?Q?qxUpWNB9VGMlU1nlUXsTxE53AyhKDLxU6d+7AqC9wONtxOSR3urjuaczb+8a?=
 =?us-ascii?Q?LSHMjPG6MNt48s3WbcWjcMowQCPQXj3jUhDgzYIOCdt6lwlNHYVqvysQazTI?=
 =?us-ascii?Q?znBnVGtpvXRxS9vZ/xkjm1u7DO3ZCDThoKZYJXAVWQbTEIt8V2kTWI1ii0h6?=
 =?us-ascii?Q?JKRs97Wyq21WUEDXPabQ0EzAnA2rKYNzLMssrHgQ8fWPZXN+Gfnq45Ej3RNT?=
 =?us-ascii?Q?reygNEol/8Z/FhWS1YcgKkDx22Bq7YFm9qqj8QJ2L0x76BZtqP59A0HoRhfF?=
 =?us-ascii?Q?USAtEEfaXnP+p9dDn0szDCF0KctMGhBNeFrshyeMhh2NHhFAk3l1EzzqanOC?=
 =?us-ascii?Q?ZPpjGaE40EPRP577wJjJJ6jEV/4jJEva+8RZujuFOwiphQM/Fi0DMkkKeye/?=
 =?us-ascii?Q?h1xPskf/3FWFKD0g8xgAj+C7tMD7WTa3j3e9terb1Cb3eNlLBlXHd9ARP7yp?=
 =?us-ascii?Q?Nh0gGKvQXDZHxQGsYhD8U0trBvooFrmYn5+mZR6dZkODeIlC/g4sgRNUGUZg?=
 =?us-ascii?Q?6Gpx4Amo7N2i3s500FwHFfAeSli1iBMxZeIQqDgBeq9E+cZyoRS1IYyTVGJ4?=
 =?us-ascii?Q?B4UTdUBzSCsTIOElU/jEJTKYyzqu/WHq+ay91YbVcUqGBKHc4pXdMH+bVSaP?=
 =?us-ascii?Q?CWk5rcBycxuolQdb6t+g0PJ7vZ8UDbG1QQVMGnZbMixn5agB0NtJhDrMtqj5?=
 =?us-ascii?Q?wM1I1lyF21PLYXiN9ZQDOYMmU5czmDKeMoxaZtgEeeqRc0pO9gysgDvG4IOC?=
 =?us-ascii?Q?BvIczsy+P4vcIr97N4prFdxYaY1LaGszywDnWQD8/K/x2GqBwHVwL+Wgimd9?=
 =?us-ascii?Q?BPwL3gS5VcYSrBEJj25VnK3dASSl1o2G14XFcUWONVEWlkD2xwtFGI6M75oR?=
 =?us-ascii?Q?T+qzWfpra57qqYEFcqOrNl5+Wo04pKLsGS0098eMVc5VR4bZh0BLXRd1Mhwv?=
 =?us-ascii?Q?YeDpPQryC0RMy8e1ITJAZylYGI3l7S6Uz5f+GDfCmxwgOTjfy8Qk3b9scqh9?=
 =?us-ascii?Q?xdflAYTU+wFnulpBvlRM9BLWjd/7FHoGSyQSx05HGUu84XyPOP3azqEQ36Ls?=
 =?us-ascii?Q?MQhz1PkdZvsvRo7pDULxRbY39Y/CccWCP7C5nJE0DNw2q8MCCNSYXC8uBMH7?=
 =?us-ascii?Q?uxtCxPdlTgTh/G9YW3rI0NUwrqYPNQwu?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 05:10:50.4565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e74086-c724-4d49-16a9-08dcc19f9fcf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8565

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
 drivers/infiniband/core/nldev.c   | 117 ++++++++++++++++++++++++++++++
 include/rdma/rdma_netlink.h       |  10 +++
 include/uapi/rdma/rdma_netlink.h  |  15 ++++
 5 files changed, 181 insertions(+)

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
index 4d4a1f90e484..5acbde242b97 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -170,6 +170,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_DEV_TYPE]		= { .type = NLA_U8 },
 	[RDMA_NLDEV_ATTR_PARENT_NAME]		= { .type = NLA_NUL_STRING },
 	[RDMA_NLDEV_ATTR_NAME_ASSIGN_TYPE]	= { .type = NLA_U8 },
+	[RDMA_NLDEV_ATTR_EVENT_TYPE]		= { .type = NLA_U8 },
 };
 
 static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
@@ -2722,6 +2723,122 @@ static const struct rdma_nl_cbs nldev_cb_table[RDMA_NLDEV_NUM_OPS] = {
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
index c2a79aeee113..a5b47ca4cd66 100644
--- a/include/rdma/rdma_netlink.h
+++ b/include/rdma/rdma_netlink.h
@@ -110,6 +110,16 @@ int rdma_nl_multicast(struct net *net, struct sk_buff *skb,
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


