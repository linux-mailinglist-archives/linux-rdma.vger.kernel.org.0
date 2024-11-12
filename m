Return-Path: <linux-rdma+bounces-5941-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A173E9C5292
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2024 10:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3138C1F23379
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2024 09:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7150B2123DD;
	Tue, 12 Nov 2024 09:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oKDybohd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A554420E325;
	Tue, 12 Nov 2024 09:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731405539; cv=fail; b=KIVimMV/yipbVK1xamj8oJe3h846iyJkyEHbFfpOiKIK+VdJyKcOsG9pPu0movb4ut6AEFxXUpwqIUOAzgmxbbGwSzGZHZgHOE5fx0I4WjAv8WLnUJX8m1I8WvQtl1t5gzTrqxKjbQWeiEutsSrVzaqSkpgqZhXpOj0xf1tXUjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731405539; c=relaxed/simple;
	bh=iPW7bQX5l7u+lwKNP0atLgDL1J7fbS5dRq0uzIeg/wU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iR5uoU1bkjQ4OUYHbJw7bh288hufbjrqS4MBCpjZ+9CGcHchTUMpDkk6qdQD2Lq16LQY2bpcFhaNlo2uD2834FihLRMWQMogid4L4fGNu+mYkIIr3/EZeij4QCXp8ttRFxc11wi4ZuOFDfOo7IqIuUA5PTOYkJrYucyaAwe8uJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oKDybohd; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAVAkZFoMNszkvTy9LcomIYxtrzkivh/mtQFfK2myDbxIaRAxwa0LzK78U02fLCz5dKtyn4MS/8PgmEMfmd0A176wbc99ie1YGFv+tPg0be8uIajm/hBkmmn72BWo86lsZHrBiNsFgyJ3f0b9JHDE1uhCFt5SYJSJUbDtAaEMfu5TzUGALZwby7/4adgf1W0801IcZ8ij4MEoQLLQgZSTpCYoUqkPf/tliub/GPLC1a82Xl6mcCtVKyh3dR1m5YI010sO0YS9aPct/IryjzQr37fK6nTiHB7C8NWXj1zZs1+JYDjlIQ9estmkxAbGlJFwEk3DnTF9nJ9qxe4ZeNV4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEDL3LDQGJnT1jEhNaSq3U8O2GbQfuwLuV3kptKChe0=;
 b=kkgxtnc3ADfeMS/vSxjsAtmwHrH+ETrUTSOTdptPSAvJuv951hktOK41xKNtM1eSXjYyVfxbr8v4dOj78AS77/4WhuKZOnXgGduTfBrXQ1Q4aRcyuuyln6BYHQWOH22PtUoqRY8EBKtQvYYJLCImQaQoxYiT4bfY8sSb9VOc8Ofsrd5FYknGzs8pVbFIDJeQJNUlbT6AWIFzImDUfxY1pUhuR1GM0A5dyosvEOlkCLMLr9PqGCw1sGhz7d/BjOSsgWJiJ29myk1osyjlc1gD9Bp6OhpC4PShB/NhwwXYfKg9mYotfnigeWvfhyK/9BYMm9F0lms4hsTRoTycu40JFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEDL3LDQGJnT1jEhNaSq3U8O2GbQfuwLuV3kptKChe0=;
 b=oKDybohdBX1jI6MZafvNDDzGC/FXugGl78/LxEPoE2XGpj8Q6bzfuyL+SlX7nn56XdesZNEZnyVjMMX1Q18UVu76yXaq5cwJoh9GlXfHRvjejpDVK7pepemiElhZ/NKPwtbXmQv/ypNAmTWMbgp+LPXqLIsKUSIQPhZiCZI5fngGmGilIRBgoZWfavyVdUCoPHP8XrDPnFMjuiqvRdJunCPt/FAqrnjEEISQYiq7FmMq3/CjER3M7xsWD9HwR0y02/gHJw7yLEKzfZGdVtNM99iAh/AzowQTmiEBAX2bX+JseqwMwsnx2FRaA5TMHXRnVE1eK4BOvCJB01xFdgwSVA==
Received: from CH0P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::28)
 by SJ1PR12MB6340.namprd12.prod.outlook.com (2603:10b6:a03:453::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 09:58:42 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::bf) by CH0P221CA0011.outlook.office365.com
 (2603:10b6:610:11c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Tue, 12 Nov 2024 09:58:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 09:58:41 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 12 Nov
 2024 01:58:30 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 12 Nov 2024 01:58:30 -0800
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 12 Nov 2024 01:58:28 -0800
From: Chiara Meiohas <cmeioahs@nvidia.com>
To: <dsahern@gmail.com>, <leonro@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <jgg@nvidia.com>,
	<stephen@networkplumber.org>, Chiara Meiohas <cmeiohas@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>
Subject: [PATCH v3 iproute2-next 1/5] rdma: Add support for rdma monitor
Date: Tue, 12 Nov 2024 11:57:58 +0200
Message-ID: <20241112095802.2355220-2-cmeioahs@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241112095802.2355220-1-cmeioahs@nvidia.com>
References: <20241112095802.2355220-1-cmeioahs@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|SJ1PR12MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: a8157a4e-4809-41ea-2cdd-08dd0300968d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|61400799027|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hSFg1OSO96VSODEyiAxMTlDqaPmkzF96g7QG7Xf17Cm3U756AFoMH1g2Qb1O?=
 =?us-ascii?Q?9tQ1pU3N9JX2n4oC+lg5OrkG78QQ1LDeXqTKWdp9ZrpeaVdZOQjUnk1mycdP?=
 =?us-ascii?Q?9wzsYx5r67GSW5/Ke0av0z0zPApG3tmvBRlQUCkdxi8cpv8BVXR8q4iagU5s?=
 =?us-ascii?Q?vZQkhZoOOqXSGI4B5c8saJu2DNPuNqdtb/J8dXdA12t1HaAyCid/1eM+Q2Yj?=
 =?us-ascii?Q?Cf+etgXUyaLVhTS6Sro8FzsQwrNCFMCWbCVa0nKN15kYZB7MeXiXmnu1Zie1?=
 =?us-ascii?Q?VySXltWGc0P9ic6ixOdi/3q3+DiXr0L3NAgm73Ci7NGjX3rRZK8NCroy7sh5?=
 =?us-ascii?Q?yEUc1WKpkEMpG/rBSaa7eepEMFEjRIipyNv5ANt2px0eF2uX3/6Ic6nPPEv3?=
 =?us-ascii?Q?50mhN+kuBg79jjwWcpm6fw+GAg2tewCs7WiobGVEU+98pFREGfHFBT6o0zYG?=
 =?us-ascii?Q?2PyzR52HMFq1A3CA/O9nHhXslIw+9AjVj71QxSKxduPHE9eXysz9EacqOHf9?=
 =?us-ascii?Q?SSMJvdr4BQxegKmf40GD3cY7UOfnL0LBq0BH0HahvVaBJj17AHsq+job1jnA?=
 =?us-ascii?Q?aLNDt+GNFgwWog1/wwWWGAm4DLtAadIbsMSGwQipdDzR6kbW0yd0J48X5t5Y?=
 =?us-ascii?Q?t5/5QDEGYaRO4NIab/4DiHnxoGpMmMgqlETq/2XAaXa5jb1j1yqS5OM3d+tY?=
 =?us-ascii?Q?zvt6l7V5sEnIdwLCCZb6M0B2/ETDDCuDEEXCJ7WnXEQtFVMbt66e76cmr6sU?=
 =?us-ascii?Q?0iDBpZ83VeLVA8g+6zGhGF7gVq4f37NAwUVdpCyFuZ/j1xHOUpaAlnLAdz79?=
 =?us-ascii?Q?qbP0bZaeH1V7sZ6zs5DkPuUW4Vsdbt4omwbh0gALVHgLnREJU7kDO0XGsMlt?=
 =?us-ascii?Q?K4swZrt9zIcB7S9Y9+znVzBJ7QwnwAV6Nc2//T33VFxVIPM3wpfqwZghwq99?=
 =?us-ascii?Q?R3BEk0VgwPySjRq0wqoB9Kivjvev8VRUu7r81gNKmeaLMBTgnHUa9Sb69S34?=
 =?us-ascii?Q?LjhO32cJtzGJB8rF6vZbsmdfagpDIASX7EH9FCZNyUAfzwovIk9nw+6FPlp7?=
 =?us-ascii?Q?bZa/eEO3p+ya95YaM/uuUiloOTb+Oewcy3dg1MdgB92Ky8x90saasJqeBB4f?=
 =?us-ascii?Q?rNKXZXQstfTqOIg9gKuIh1245ir5+GJ+z55qWCu7Wg6ix1029qQ799y4eNS1?=
 =?us-ascii?Q?NAcnRcwwEajSPkfNw0WbOQTD/53zPBx3kavTai0ycMREoQ5T1FuzZFG63hmB?=
 =?us-ascii?Q?GkKbHZfStJeLtJjzpjvtx9segGrxM+a/XPpMbnccC1ealQHFPT6nmwg3u5kY?=
 =?us-ascii?Q?cGkIzc/Ppi/GAJLG4M5eoLVepJeZAotpJbJmg5MGWdDyhn9uuI998Lul88Ml?=
 =?us-ascii?Q?/H899WOmvwfZecU5Klclh68zEvEzrA1JZSVUAS4eyjZ+8mYQoA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(61400799027)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 09:58:41.5790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8157a4e-4809-41ea-2cdd-08dd0300968d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6340

From: Chiara Meiohas <cmeiohas@nvidia.com>

Introduce a new command for RDMA event monitoring.
This patch adds a new attribute "event_type" which describes
the event recieved. Add a new NETLINK_RDMA multicast group
and processes listening to this multicast group receive RDMA
events.

The event types supported are IB device registration/unregistration
and net device attachment/detachment.

Example output of rdma monitor and the commands which trigger
the events:

$ rdma monitor
$ rmmod mlx5_ib
[UNREGISTER]    dev 3 rocep8s0f1
[UNREGISTER]    dev 2 rocep8s0f0

$modprobe mlx5_ib
[REGISTER]      dev 4 mlx5_0
[NETDEV_ATTACH] dev 4 mlx5_0 port 1 netdev 4 eth2
[REGISTER]      dev 5 mlx5_1
[NETDEV_ATTACH] dev 5 mlx5_1 port 1 netdev 5 eth3

$ devlink dev eswitch set pci/0000:08:00.0 mode switchdev
[UNREGISTER]    dev 4 rocep8s0f0
[REGISTER]      dev 6 mlx5_0
[NETDEV_ATTACH] dev 6 mlx5_0 port 30 netdev 4 eth2

$ echo 4 > /sys/class/net/eth2/device/sriov_numvfs
[NETDEV_ATTACH] dev 6 rdmap8s0f0 port 2 netdev 7 eth4
[NETDEV_ATTACH] dev 6 rdmap8s0f0 port 3 netdev 8 eth5
[NETDEV_ATTACH] dev 6 rdmap8s0f0 port 4 netdev 9 eth6
[NETDEV_ATTACH] dev 6 rdmap8s0f0 port 5 netdev 10 eth7
[REGISTER]      dev 7 mlx5_0
[NETDEV_ATTACH] dev 7 mlx5_0 port 1 netdev 11 eth8
[REGISTER]      dev 8 mlx5_0
[NETDEV_ATTACH] dev 8 mlx5_0 port 1 netdev 12 eth9
[REGISTER]      dev 9 mlx5_0
[NETDEV_ATTACH] dev 9 mlx5_0 port 1 netdev 13 eth10
[REGISTER]      dev 10 mlx5_0
[NETDEV_ATTACH] dev 10 mlx5_0 port 1 netdev 14 eth11

$ echo 0 > /sys/class/net/eth2/device/sriov_numvfs
[UNREGISTER]    dev 7 rocep8s0f0v0
[UNREGISTER]    dev 8 rocep8s0f0v1
[UNREGISTER]    dev 9 rocep8s0f0v2
[UNREGISTER]    dev 10 rocep8s0f0v3
[NETDEV_DETACH] dev 6 rdmap8s0f0 port 2
[NETDEV_DETACH] dev 6 rdmap8s0f0 port 3
[NETDEV_DETACH] dev 6 rdmap8s0f0 port 4
[NETDEV_DETACH] dev 6 rdmap8s0f0 port 5

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
---
 include/mnl_utils.h     |   1 +
 lib/mnl_utils.c         |   5 +
 man/man8/rdma-monitor.8 |  51 ++++++++++
 man/man8/rdma.8         |   7 +-
 rdma/Makefile           |   3 +-
 rdma/monitor.c          | 207 ++++++++++++++++++++++++++++++++++++++++
 rdma/rdma.c             |   3 +-
 rdma/rdma.h             |   1 +
 rdma/utils.c            |   1 +
 9 files changed, 276 insertions(+), 3 deletions(-)
 create mode 100644 man/man8/rdma-monitor.8
 create mode 100644 rdma/monitor.c

diff --git a/include/mnl_utils.h b/include/mnl_utils.h
index 76fe1dfe..0ddf2932 100644
--- a/include/mnl_utils.h
+++ b/include/mnl_utils.h
@@ -24,6 +24,7 @@ int mnlu_gen_socket_sndrcv(struct mnlu_gen_socket *nlg, const struct nlmsghdr *n
 			   mnl_cb_t data_cb, void *data);
 
 struct mnl_socket *mnlu_socket_open(int bus);
+int mnl_add_nl_group(struct mnl_socket *nl, unsigned int group);
 struct nlmsghdr *mnlu_msg_prepare(void *buf, uint32_t nlmsg_type, uint16_t flags,
 				  void *extra_header, size_t extra_header_size);
 int mnlu_socket_recv_run(struct mnl_socket *nl, unsigned int seq, void *buf, size_t buf_size,
diff --git a/lib/mnl_utils.c b/lib/mnl_utils.c
index 6c8f527e..5f6671bf 100644
--- a/lib/mnl_utils.c
+++ b/lib/mnl_utils.c
@@ -35,6 +35,11 @@ err_bind:
 	return NULL;
 }
 
+int mnl_add_nl_group(struct mnl_socket *nl, unsigned int group)
+{
+	return mnl_socket_bind(nl, group, MNL_SOCKET_AUTOPID);
+}
+
 struct nlmsghdr *mnlu_msg_prepare(void *buf, uint32_t nlmsg_type, uint16_t flags,
 				  void *extra_header, size_t extra_header_size)
 {
diff --git a/man/man8/rdma-monitor.8 b/man/man8/rdma-monitor.8
new file mode 100644
index 00000000..d445cba0
--- /dev/null
+++ b/man/man8/rdma-monitor.8
@@ -0,0 +1,51 @@
+.TH RDMA\-MONITOR 8 "22 Jul 2024" "iproute2" "Linux"
+.SH NAME
+rdma-monitor \- RDMA events monitoring
+.SH SYNOPSIS
+.sp
+.ad l
+.in +8
+.ti -8
+.B rdma
+.RI "[ " OPTIONS " ]"
+.B monitor
+.RI " { " help " }"
+.sp
+
+.ti -8
+.IR OPTIONS " := { "
+\fB\-V\fR[\fIersion\fR] }
+
+.ti -8
+.B rdma monitor
+
+.ti -8
+.B rdma monitor help
+
+.SH "DESCRIPTION"
+.SS rdma monitor - utility can monitor RDMA device events on all RDMA devices.
+.PP
+.B rdma
+opens an RDMA Netlink socket, listens on it and dumps the event info.
+
+The event types supported are RDMA device registration/unregistration
+and net device attachment/detachment.
+
+.SH "EXAMPLES"
+.PP
+rdma monitor
+.RS 4
+Listen for events of all RDMA devices
+.RE
+.PP
+
+.SH SEE ALSO
+.BR rdma (8),
+.BR rdma-link (8),
+.BR rdma-resource (8),
+.BR rdma-system (8),
+.BR rdma-statistic (8),
+.br
+
+.SH AUTHOR
+Chiara Meiohas <cmeiohas@nvidia.com>
diff --git a/man/man8/rdma.8 b/man/man8/rdma.8
index 5088b9ec..df86284d 100644
--- a/man/man8/rdma.8
+++ b/man/man8/rdma.8
@@ -19,7 +19,7 @@ rdma \- RDMA tool
 
 .ti -8
 .IR OBJECT " := { "
-.BR dev " | " link " | " resource " | " system " | " statistic " }"
+.BR dev " | " link " | " resource " | " system " | " statistic " | " monitor " }"
 .sp
 
 .ti -8
@@ -94,6 +94,10 @@ character.
 .B statistic
 - RDMA counter statistic related.
 
+.TP
+.B monitor
+- RDMA events monitor
+
 .PP
 The names of all objects may be written in full or
 abbreviated form, for example
@@ -133,6 +137,7 @@ Exit status is 0 if command was successful or a positive integer upon failure.
 .BR rdma-resource (8),
 .BR rdma-system (8),
 .BR rdma-statistic (8),
+.BR rdma-monitor (8),
 .br
 
 .SH REPORTING BUGS
diff --git a/rdma/Makefile b/rdma/Makefile
index 37d904a7..ed3c1c1c 100644
--- a/rdma/Makefile
+++ b/rdma/Makefile
@@ -4,7 +4,8 @@ include ../config.mk
 CFLAGS += -I./include/uapi/
 
 RDMA_OBJ = rdma.o utils.o dev.o link.o res.o res-pd.o res-mr.o res-cq.o \
-	   res-cmid.o res-qp.o sys.o stat.o stat-mr.o res-ctx.o res-srq.o
+	   res-cmid.o res-qp.o sys.o stat.o stat-mr.o res-ctx.o res-srq.o \
+	   monitor.o
 
 TARGETS += rdma
 
diff --git a/rdma/monitor.c b/rdma/monitor.c
new file mode 100644
index 00000000..8c14d575
--- /dev/null
+++ b/rdma/monitor.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * monitor.c	RDMA tool
+ * Authors:     Chiara Meiohas <cmeiohas@nvidia.com>
+ */
+
+#include "rdma.h"
+#include "utils.h"
+
+static int mon_is_supported_cb(const struct nlmsghdr *nlh, void *data)
+{
+	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX] = {};
+	uint8_t *is_sup = data;
+
+	mnl_attr_parse(nlh, 0, rd_attr_cb, tb);
+	if (tb[RDMA_NLDEV_SYS_ATTR_MONITOR_MODE])
+		*is_sup = mnl_attr_get_u8(tb[RDMA_NLDEV_SYS_ATTR_MONITOR_MODE]);
+
+	return MNL_CB_OK;
+}
+
+static int mon_is_supported(struct rd *rd, uint8_t *is_sup)
+{
+	uint32_t seq;
+	int ret;
+
+	*is_sup = 0;
+	rd_prepare_msg(rd, RDMA_NLDEV_CMD_SYS_GET,
+		       &seq, (NLM_F_REQUEST | NLM_F_ACK));
+	ret = rd_send_msg(rd);
+	if (ret)
+		return ret;
+
+	return rd_recv_msg(rd, mon_is_supported_cb, is_sup, seq);
+}
+
+static void mon_print_event_type(struct nlattr **tb)
+{
+	const char *const event_types_str[] = {
+		[RDMA_REGISTER_EVENT] = "[REGISTER]",
+		[RDMA_UNREGISTER_EVENT] = "[UNREGISTER]",
+		[RDMA_NETDEV_ATTACH_EVENT] = "[NETDEV_ATTACH]",
+		[RDMA_NETDEV_DETACH_EVENT] = "[NETDEV_DETACH]",
+	};
+	enum rdma_nl_notify_event_type etype;
+	char unknown_type[32];
+
+	if (!tb[RDMA_NLDEV_ATTR_EVENT_TYPE])
+		return;
+
+	etype = mnl_attr_get_u8(tb[RDMA_NLDEV_ATTR_EVENT_TYPE]);
+	if (etype < ARRAY_SIZE(event_types_str) && event_types_str[etype]) {
+		print_string(PRINT_ANY, "event_type", "%s\t",
+			     event_types_str[etype]);
+	} else {
+		snprintf(unknown_type, sizeof(unknown_type), "[UNKNOWN 0x%02x]",
+			 etype);
+		print_string(PRINT_ANY, "event_type", "%s\t", unknown_type);
+	}
+}
+
+static int mon_print_dev(struct nlattr **tb)
+{
+	const char *name;
+	uint32_t idx;
+
+	if (tb[RDMA_NLDEV_ATTR_DEV_INDEX]) {
+		idx = mnl_attr_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]);
+		print_uint(PRINT_ANY, "rdma_index", "dev %u", idx);
+	}
+
+	if(tb[RDMA_NLDEV_ATTR_DEV_NAME]) {
+		name = mnl_attr_get_str(tb[RDMA_NLDEV_ATTR_DEV_NAME]);
+		print_string(PRINT_ANY, "rdma_dev", " %s", name);
+	}
+
+	return 0;
+}
+
+static void mon_print_port_idx(struct nlattr **tb)
+{
+	uint32_t port;
+
+	if (tb[RDMA_NLDEV_ATTR_PORT_INDEX]) {
+		port = mnl_attr_get_u32(tb[RDMA_NLDEV_ATTR_PORT_INDEX]);
+		print_uint(PRINT_ANY, "port", " port %u", port);
+	}
+}
+
+static void mon_print_netdev(struct nlattr **tb)
+{
+	uint32_t netdev_idx;
+	const char *name;
+
+	if (tb[RDMA_NLDEV_ATTR_NDEV_INDEX]) {
+		netdev_idx = mnl_attr_get_u32(tb[RDMA_NLDEV_ATTR_NDEV_INDEX]);
+		print_uint(PRINT_ANY, "netdev_idx", " netdev %u", netdev_idx);
+	}
+
+	if(tb[RDMA_NLDEV_ATTR_NDEV_NAME]) {
+		name = mnl_attr_get_str(tb[RDMA_NLDEV_ATTR_NDEV_NAME]);
+		print_string(PRINT_ANY, "netdev_name", " %s", name);
+	}
+}
+
+static int mon_show_cb(const struct nlmsghdr *nlh, void *data)
+{
+	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX + 1] = {};
+
+	mnl_attr_parse(nlh, 0, rd_attr_cb, tb);
+	if (!tb[RDMA_NLDEV_ATTR_EVENT_TYPE])
+		return MNL_CB_ERROR;
+
+	open_json_object(NULL);
+
+	mon_print_event_type(tb);
+	mon_print_dev(tb);
+	mon_print_port_idx(tb);
+	mon_print_netdev(tb);
+
+	close_json_object();
+	newline();
+	fflush(stdout);
+
+	return MNL_CB_OK;
+}
+
+static int mon_show(struct rd* rd)
+{
+	unsigned int groups = 0;
+	uint8_t is_sup = 0;
+	int one = 1;
+	char *buf;
+	int err;
+
+	err = mon_is_supported(rd, &is_sup);
+	if (err) {
+		pr_err("Failed to check if RDMA monitoring is supported\n");
+		return err;
+	}
+
+	if (!is_sup) {
+		pr_err("RDMA monitoring is not supported by the kernel\n");
+		return -ENOENT;
+	}
+
+	buf = malloc(MNL_SOCKET_BUFFER_SIZE);
+	if (!buf) {
+		pr_err("Buffer allocation failed\n");
+		return -ENOMEM;
+	}
+
+	rd->nl = mnl_socket_open(NETLINK_RDMA);
+	if (!rd->nl) {
+		pr_err("Failed to open NETLINK_RDMA socket. Error: %s\n",
+		       strerror(errno));
+		err = -ENODEV;
+		goto err_free;
+	}
+	mnl_socket_setsockopt(rd->nl, NETLINK_CAP_ACK, &one, sizeof(one));
+	mnl_socket_setsockopt(rd->nl, NETLINK_EXT_ACK, &one, sizeof(one));
+
+	groups |= nl_mgrp(RDMA_NL_GROUP_NOTIFY);
+
+	err = mnl_add_nl_group(rd->nl, groups);
+	if (err < 0) {
+		pr_err("Failed to add NETLINK_RDMA multicast group. Error: %s\n",
+		       strerror(errno));
+		goto err_close;
+	}
+	new_json_obj(json);
+
+	err = mnlu_socket_recv_run(rd->nl, 0, buf, MNL_SOCKET_BUFFER_SIZE,
+				   mon_show_cb, rd);
+	if (err) {
+		pr_err("Failed to listen to rdma socket\n");
+		goto err_free_json;
+	}
+
+	return 0;
+
+err_free_json:
+	delete_json_obj();
+err_close:
+	mnl_socket_close(rd->nl);
+err_free:
+	free(buf);
+	return err;
+}
+
+static int mon_help(struct rd *rd)
+{
+	pr_out("Usage: rdma monitor [ -j ]\n");
+	return 0;
+}
+
+int cmd_mon(struct rd *rd)
+{
+	const struct rd_cmd cmds[] = {
+		{ NULL,		mon_show },
+		{ "help",	mon_help },
+		{ 0 }
+	};
+
+	return rd_exec_cmd(rd, cmds, "mon command");
+}
+
diff --git a/rdma/rdma.c b/rdma/rdma.c
index 131c6b2a..253ac58b 100644
--- a/rdma/rdma.c
+++ b/rdma/rdma.c
@@ -15,7 +15,7 @@ static void help(char *name)
 {
 	pr_out("Usage: %s [ OPTIONS ] OBJECT { COMMAND | help }\n"
 	       "       %s [ -f[orce] ] -b[atch] filename\n"
-	       "where  OBJECT := { dev | link | resource | system | statistic | help }\n"
+	       "where  OBJECT := { dev | link | resource | monitor | system | statistic | help }\n"
 	       "       OPTIONS := { -V[ersion] | -d[etails] | -j[son] | -p[retty] | -r[aw]}\n", name, name);
 }
 
@@ -35,6 +35,7 @@ static int rd_cmd(struct rd *rd, int argc, char **argv)
 		{ "resource",	cmd_res },
 		{ "system",	cmd_sys },
 		{ "statistic",	cmd_stat },
+		{ "monitor",	cmd_mon },
 		{ 0 }
 	};
 
diff --git a/rdma/rdma.h b/rdma/rdma.h
index d224ec57..fb037bcf 100644
--- a/rdma/rdma.h
+++ b/rdma/rdma.h
@@ -98,6 +98,7 @@ int cmd_link(struct rd *rd);
 int cmd_res(struct rd *rd);
 int cmd_sys(struct rd *rd);
 int cmd_stat(struct rd *rd);
+int cmd_mon(struct rd* rd);
 int rd_exec_cmd(struct rd *rd, const struct rd_cmd *c, const char *str);
 int rd_exec_dev(struct rd *rd, int (*cb)(struct rd *rd));
 int rd_exec_require_dev(struct rd *rd, int (*cb)(struct rd *rd));
diff --git a/rdma/utils.c b/rdma/utils.c
index 4d3803b5..bc104e0f 100644
--- a/rdma/utils.c
+++ b/rdma/utils.c
@@ -477,6 +477,7 @@ static const enum mnl_attr_data_type nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_SYS_ATTR_PRIVILEGED_QKEY_MODE] = MNL_TYPE_U8,
 	[RDMA_NLDEV_ATTR_DEV_TYPE] = MNL_TYPE_U8,
 	[RDMA_NLDEV_ATTR_PARENT_NAME] = MNL_TYPE_STRING,
+	[RDMA_NLDEV_ATTR_EVENT_TYPE] = MNL_TYPE_U8,
 };
 
 static int rd_attr_check(const struct nlattr *attr, int *typep)
-- 
2.44.0


