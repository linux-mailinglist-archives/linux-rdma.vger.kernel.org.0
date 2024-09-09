Return-Path: <linux-rdma+bounces-4838-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6563997211C
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 19:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCADBB23986
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 17:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42039189520;
	Mon,  9 Sep 2024 17:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U85ybWto"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2143717E010
	for <linux-rdma@vger.kernel.org>; Mon,  9 Sep 2024 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725903080; cv=fail; b=uFrRmsSt+/4PT22H92+c148et2LbEMEanW/1JoPVQm7aR4NZPYjSf0/QDl5Vb9xiJQ3IN1UCcnezkMsRReaHOGdap4AKjQoGBFYdqnyOyFwdsQhXf8Apgg6C6pN3VUp2n4Zf5S0PhQh3svzYcWknSK9Q8N0VsODyFKP1KkNGW6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725903080; c=relaxed/simple;
	bh=HASvvHgjHHyklVdaWbDBea5XwO1dQEe5vXS++kQZABM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ORueApJoY3Gd8zGEqk5/Etmi3pD6EtILphnnlIA21oYtMnSaAsHO4a76ssHtci1MUkE6Lu2V6BibEDGVt6jm1eXdjFQE/7p63hD/8eenWHrvVF/144wUsPTqYb2CxOMDgsEz0gts4cQrA2o6ji/y4BTUtOOGFlWjWgUR5qC+Q1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U85ybWto; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBFhaWU77vrsJ585ZX2ipF9CLjtW1TW7s6nJgVxyuToM/wvI+EE3iyqcv13rgItBudXGIzwrI3TratjywhVNNzQURzSVB8XcEEI1XNFVzOvbWMHylE1kLGztSH3HLmG7CW1LEitkC9omXxvAG+KgazOTgBsPAOuiIkrK7AhBS3+DjRFQdhOvE10YSO3Pv6DXKc7Q/JDjNyM8Fhp+UhF7pXrGHy5wdlmjztdnT24psChFv5Vdg8GYeT7KIQIhwxTwP4SHdrRnx7GiETSXMsnhDpYA+znAw3Zqo1lNdd4rxQYNyI4oZY0euvZVVVvYq5mjQ4wez2vLTvYV6lPiIoFkkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K475JZZ4hVhTQpymAscLug6pbEw0e9+LmpBWRjbRQnw=;
 b=B98VJRugTXdmmsfvVHBZ2/dvq/QtXLLujKYf+hbvqUgPfp3D2mGMog8PE4BKYiW/eSgYIdntdJZi11g9qYOTgflgqNQghPD9mO72Sx7JdDLJCqXIb+WHJlt4X9qCGj7l47N9OBVuOaF6FHPZNlCGVWz3+RNvHpggv9CXL45xRhIYBGrVC4ZOM+CUkGyhRYBkhv7U0zjt4tsPUnXlPl89l81t1ZRO78HJybhCuwJnH8XLV4pEUC05wkp2pcZ5C6Nra0kQ1CWLFUCIrNPNLQEbv1sNh6cbD0QtRDwt4XuK/ENsA1n+G1fO/sEStCeqL1x5FIdYdiDZDHNJ2LSplWNySw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K475JZZ4hVhTQpymAscLug6pbEw0e9+LmpBWRjbRQnw=;
 b=U85ybWto858Iam5QtbC2C68DlYIMHFNUl/CHu/7SnMq1qdnmzO2FmbIyHw+Odm3rbH/XmKxMop10qI40gotFsxbleWBumW9ws1a4h08opPZiPqK1r2PkSYGzJBtvSEuQXEUKl6pGV+Rb1HlKIphvKcl5qgqa6uQM8z8sHIGoPPw8NW7fJnc2/ljOtrW2OV1wGwID0PIYnGJQTgv0EkQBa9db02gH1PjDt1VMxzICw4V7VL0m8K4kUHsS5B90aII73bcYudUPOB/9RoIRKKhmdmfmQmO1vESINdWFxL3DnpVhAcaYr0E52kSZqVeEDkohUXvwY9WB72OFT+dHlrP2KA==
Received: from MN2PR17CA0019.namprd17.prod.outlook.com (2603:10b6:208:15e::32)
 by IA1PR12MB7759.namprd12.prod.outlook.com (2603:10b6:208:420::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 9 Sep
 2024 17:31:12 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:15e:cafe::47) by MN2PR17CA0019.outlook.office365.com
 (2603:10b6:208:15e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Mon, 9 Sep 2024 17:31:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 17:31:11 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Sep 2024
 10:30:49 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Sep 2024
 10:30:49 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 9 Sep
 2024 10:30:47 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <leonro@nvidia.com>, <mbloch@nvidia.com>,
	<cmeiohas@nvidia.com>, <msanalla@nvidia.com>, <dsahern@gmail.com>, "Michael
 Guralnik" <michaelgur@nvidia.com>
Subject: [PATCH v3 rdma-next 6/7] RDMA/nldev: Add support for RDMA monitoring
Date: Mon, 9 Sep 2024 20:30:24 +0300
Message-ID: <20240909173025.30422-7-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20240909173025.30422-1-michaelgur@nvidia.com>
References: <20240909173025.30422-1-michaelgur@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|IA1PR12MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: 34066451-016f-495a-6bbd-08dcd0f5331c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sznf8tncEQFQKP8mvASjmuqqj/vyFW3Eu1GlKUsZhyeLaQ8YJIJLLOSqkrGU?=
 =?us-ascii?Q?giihNBKU9vCJuYnnZtQs5UukdeCXKNCt3xE+naJMPL0wGrlIS3fPuDd67zln?=
 =?us-ascii?Q?alGUgGasPmVdbdwlEfcCycta8Rr7cHK0Ua4c4LJ9v5S7pAw2ooFieif4oHQb?=
 =?us-ascii?Q?NND93heuJWo1aUX+loAtctQr58yVNwxG14zHcRwqkXuxkaGuycW/aYIGwG+3?=
 =?us-ascii?Q?noP+1rHDz9kDvTrK3E71QPiP7vx5Z4ESAmFET5KqRG3Gk8MdK+DjevOd5O82?=
 =?us-ascii?Q?aI07dDFgvbXfkmbi5d0VWWUYC9sxOc6gu25Lq+gJh56ihT4H7pfl62vun8D5?=
 =?us-ascii?Q?BnAkHsfZV+CtnPURC5077T3jWpwedl7krYbprqAmdviA6T+99vwFmqPtGAfj?=
 =?us-ascii?Q?Y/ak+sGNJmf5LU6k0g952BMOAZyJCg9MDxYTmBiMwaHaPlgwZxpwFwrt9knL?=
 =?us-ascii?Q?leyTNp/QtYiCJ7+QERduTsKZ489iZ3wiy7FxAup054mQNcj2lja2Dh+tsoHl?=
 =?us-ascii?Q?pMgAez0EBgP4gUHbDj/WRh6by8qLMNFt2R6BpjKYYxTQsgNIqLc6XDXAlIMg?=
 =?us-ascii?Q?GZIA++5IhX2AIxUDGRTJOwH9N9kfcUAjPG953AvlhacWbVINzlJ7pyYu51VA?=
 =?us-ascii?Q?9CewTaQKi4jeV7KmGEJzS0sXwaly8+5vKM7UqkGmc9VS0X+DFL01MSjz2fGy?=
 =?us-ascii?Q?r/FdhrSs6oTZj0Rwd+JMPE13R/1/rSS4SrcNj0UnmFik6HuKdkFX2f0/J4L/?=
 =?us-ascii?Q?MUUJcOouwsdW+zkKuwyjs+wIbEVQ/VkJcmWG3fSwgFp4RAKAxDgLDptwrBZ6?=
 =?us-ascii?Q?heIO5uchc09a5NFCL5T/rGBOjb7ZZHXWgnvn14nnxrv5fKHeuuKtH4Y6Tquj?=
 =?us-ascii?Q?BwYEjcJpEKa4/M9K7womAETW7FRkzLZvmWKQ/Px18jr3etjYSm/xU9GHj1Zi?=
 =?us-ascii?Q?vwXDeCiU+BLUTTrlxOHJNaAX3ZUgw6huT2/vaz9cFzznKzfxEjANSJDnmyNT?=
 =?us-ascii?Q?CGUPm+fYz+/mMGQF3IXNkZkzs17eFfSl3+WYDr0fHPFuvrgftNPB0gLtrlpv?=
 =?us-ascii?Q?wWfodB8pBmO0JRMlQoEtItceqTkyd5XfAu0bb2IBxabb5iJn6OqkbRceOvXT?=
 =?us-ascii?Q?IKp8PCVrrTazcqjgNAOqWArs/C/lqz4O04Y/JuN2q4SO1fa5F2SJj93PBeam?=
 =?us-ascii?Q?jvlir6hZc3WcSWtYy13hdve6CZn6NQV77xv7GqvwpJISghZOxD3GE17CZezk?=
 =?us-ascii?Q?V2wRgKuyWvaVkO5UUfvKtHPlqUtobWncgJdla5tC4mM/PO04rxginH0BLQBU?=
 =?us-ascii?Q?uXeuycgq/MzspKLsf8iwREIKaxleMbSP2ckCaBEBLgfQUznut6grwauH992Z?=
 =?us-ascii?Q?0q94vP3MVUZLcr/Aqn5vmOZy5QEoFVhsQrXdNfwl2jP45+HigxGrxRIlKujF?=
 =?us-ascii?Q?EKpeJOoProIO+7d1QJnh+ZPvRkKA6LN2?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 17:31:11.9864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34066451-016f-495a-6bbd-08dcd0f5331c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7759

From: Chiara Meiohas <cmeiohas@nvidia.com>

Introduce a new netlink command to allow rdma event monitoring.
The rdma events supported now are IB device
registration/unregistration and net device attachment/detachment.

Example output of rdma monitor and the commands which trigger
the events:

$ rdma monitor
$ rmmod mlx5_ib
[UNREGISTER]	ibdev_idx 1 ibdev rocep8s0f1
[UNREGISTER]	ibdev_idx 0 ibdev rocep8s0f0

$ modprobe mlx5_ib
[REGISTER]	ibdev_idx 2 ibdev mlx5_0
[NETDEV_ATTACH]	ibdev_idx 2 ibdev mlx5_0 port 1 netdev_idx 4 netdev eth2
[REGISTER]	ibdev_idx 3 ibdev mlx5_1
[NETDEV_ATTACH]	ibdev_idx 3 ibdev mlx5_1 port 1 netdev_idx 5 netdev eth3

$ devlink dev eswitch set pci/0000:08:00.0 mode switchdev
[UNREGISTER]	ibdev_idx 2 ibdev rocep8s0f0
[REGISTER]	ibdev_idx 4 ibdev mlx5_0
[NETDEV_ATTACH]	ibdev_idx 4 ibdev mlx5_0 port 30 netdev_idx 4 netdev eth2

$ echo 4 > /sys/class/net/eth2/device/sriov_numvfs
[NETDEV_ATTACH]	ibdev_idx 4 ibdev rdmap8s0f0 port 2 netdev_idx 7 netdev eth4
[NETDEV_ATTACH]	ibdev_idx 4 ibdev rdmap8s0f0 port 3 netdev_idx 8 netdev eth5
[NETDEV_ATTACH]	ibdev_idx 4 ibdev rdmap8s0f0 port 4 netdev_idx 9 netdev eth6
[NETDEV_ATTACH]	ibdev_idx 4 ibdev rdmap8s0f0 port 5 netdev_idx 10 netdev eth7
[REGISTER]	ibdev_idx 5 ibdev mlx5_0
[NETDEV_ATTACH]	ibdev_idx 5 ibdev mlx5_0 port 1 netdev_idx 11 netdev eth8
[REGISTER]	ibdev_idx 6 ibdev mlx5_0
[NETDEV_ATTACH]	ibdev_idx 6 ibdev mlx5_0 port 1 netdev_idx 12 netdev eth9
[REGISTER]	ibdev_idx 7 ibdev mlx5_0
[NETDEV_ATTACH]	ibdev_idx 7 ibdev mlx5_0 port 1 netdev_idx 13 netdev eth10
[REGISTER]	ibdev_idx 8 ibdev mlx5_0
[NETDEV_ATTACH]	ibdev_idx 8 ibdev mlx5_0 port 1 netdev_idx 14 netdev eth11

$ echo 0 > /sys/class/net/eth2/device/sriov_numvfs
[UNREGISTER]	ibdev_idx 5 ibdev rocep8s0f0v0
[UNREGISTER]	ibdev_idx 6 ibdev rocep8s0f0v1
[UNREGISTER]	ibdev_idx 7 ibdev rocep8s0f0v2
[UNREGISTER]	ibdev_idx 8 ibdev rocep8s0f0v3
[NETDEV_DETACH]	ibdev_idx 4 ibdev rdmap8s0f0 port 2
[NETDEV_DETACH]	ibdev_idx 4 ibdev rdmap8s0f0 port 3
[NETDEV_DETACH]	ibdev_idx 4 ibdev rdmap8s0f0 port 4
[NETDEV_DETACH]	ibdev_idx 4 ibdev rdmap8s0f0 port 5

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/device.c  |  38 +++++++++
 drivers/infiniband/core/netlink.c |   1 +
 drivers/infiniband/core/nldev.c   | 124 ++++++++++++++++++++++++++++++
 include/rdma/rdma_netlink.h       |  12 +++
 include/uapi/rdma/rdma_netlink.h  |  15 ++++
 5 files changed, 190 insertions(+)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 9e765c79a892..d571b78d1bcc 100644
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
index 4d4a1f90e484..30b0fd54a7d3 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -170,6 +170,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_DEV_TYPE]		= { .type = NLA_U8 },
 	[RDMA_NLDEV_ATTR_PARENT_NAME]		= { .type = NLA_NUL_STRING },
 	[RDMA_NLDEV_ATTR_NAME_ASSIGN_TYPE]	= { .type = NLA_U8 },
+	[RDMA_NLDEV_ATTR_EVENT_TYPE]		= { .type = NLA_U8 },
 };
 
 static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
@@ -2722,6 +2723,129 @@ static const struct rdma_nl_cbs nldev_cb_table[RDMA_NLDEV_NUM_OPS] = {
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
+
+	ret = nla_put_string(msg, RDMA_NLDEV_ATTR_DEV_NAME,
+			     dev_name(&device->dev));
+	if (ret)
+		goto out;
+
+	ret = nla_put_u32(msg, RDMA_NLDEV_ATTR_PORT_INDEX, port);
+	if (ret)
+		goto out;
+
+	if (netdev) {
+		ret = nla_put_u32(msg,
+				  RDMA_NLDEV_ATTR_NDEV_INDEX, netdev->ifindex);
+		if (ret)
+			goto out;
+
+		ret = nla_put_string(msg,
+				     RDMA_NLDEV_ATTR_NDEV_NAME, netdev->name);
+	}
+
+out:
+	dev_put(netdev);
+	return ret;
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
+		ret = fill_nldev_handle(skb, device);
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
+		break;
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


