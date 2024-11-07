Return-Path: <linux-rdma+bounces-5830-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC889BFF9A
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 09:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924AE1F227DE
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 08:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A14C1CC17A;
	Thu,  7 Nov 2024 08:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D2yzhX0r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5942C158218;
	Thu,  7 Nov 2024 08:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730966682; cv=fail; b=k+NUq/5XoHX6cu57cK5dvAZtoWgYx5YWJ1msta1jKMt9I3auOBT7FPjtwBo/9crbQ3p4jm4we8K12AIpxXItocRM66hxFOH+o3cAX4ynbabm5a42ye+ttX9/AU3w2KNBzx0CCCaVknJd/1xcdaiQ7jcK857TcHEOSF3IPAscR04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730966682; c=relaxed/simple;
	bh=SVNIWps5/CD6PDZXOhCzaZf5cWOhTQh0VBdZsZ22b8k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/gRURZtxawCHFlECzM0IxFhUgdRH+8+W9UeoxITSzsNclYAM+tEnsQdYCsnYHBo7fOEqcGFn0Py0ea5N6j5wvhRPrNf19XesBbAk6IT0S1lLzm4IJQX1TaB9UEQGsTTcf6RNDNbf28K5L5nNWnkMEGxoCnG5qnHy7KMtQeVVMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D2yzhX0r; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCic+WZFLEK1wsvBDFNutTZnhz6HQ0oC4b2csbK0Zyit4MmDSpxgeUfbkTkDSKO2dQsizisiKv1Zc96PY1op8AqtrY+8xiKeBlbh8wcMtj9uDQtrUy7qEPJn89gg7XUpN4ly7HKBpxcSqkXJ+CQNjbTeAARVMseC1lQ5pxArHBvN4Zoh8D3/A1PzjPS6285VvRpJV7H360YVPYie0Sp/dIHZSfCpHHgVuewJX7bOTeg+o8WCvMwnY76e8gHj13QJQFodF8ftokXAc/zJD9EekgEqwCw+/BbTw1Gz2OlGHz0NhytLQOXAu3WK+bzyOe8YYZLGMzCb18bvwGv4G/MXKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xs39hZvpY2LV4NMPM3LsUdPEbndxf02SZTL0IlWRr0E=;
 b=Tk81ysK1qjjqiefF5cFpy2Tp4qj7lKB9IBeIwC+5evQy8rwYD/NDokGhDddDeI3xnuK+PHxUBilhh2b0AekCa3R0QBREvzwNpcGvpkk+fBA4+spuEE97SolYgYOzmQgn3ra9yVNzee7nXKLjKDuZdxDUjEP4nrnkMN9KbZD4i/HTcdLYOZoku9pUaEJzZm7v6HHOSEoisBpTALOupgERiVmmDvQL3icjH5OkiWvqINu1j6bG3CqPhmXvETGVtrRaJGuGxQjKINxKwhsI7W/ncWODo8rB1TzxSn+vQzxFTq2lZGZaSEUCCNyiZJ4Ut/0m0SFPGOxFShx59nNsYwjwdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xs39hZvpY2LV4NMPM3LsUdPEbndxf02SZTL0IlWRr0E=;
 b=D2yzhX0rEEzni+VJOMDtW4vdiMJHSIJC/waf27v4d/D0xO7xbwuDzo2TVlB5PMRUVFEEGJeqUO4eTZiEjx+3gWFHR0hZC5Rnq4qfJCF9K7Z8xnS0NK9anJKxb8M2N5w1Qd+/FnqrrUpUfhpLuLGN1CoJaIxLGPhwT4tblnC883oM44X0kl+4GpDNlIgko3+YS0deQ3/lgFgwVwASzecpiUDVYxfaLQJbrwvgRsvoX0loru51nt+yX95FDTRDINF53AuVdL3HnfL4uHOKaBuAE1cBOpO/X40qy1fjX2c2pKe0GwmsJ8y/+wXSKZlZyj0TP/A8VGHYIYGSME0FsuFDVQ==
Received: from SJ0PR13CA0117.namprd13.prod.outlook.com (2603:10b6:a03:2c5::32)
 by PH0PR12MB7862.namprd12.prod.outlook.com (2603:10b6:510:26d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Thu, 7 Nov
 2024 08:04:38 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::bd) by SJ0PR13CA0117.outlook.office365.com
 (2603:10b6:a03:2c5::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.10 via Frontend
 Transport; Thu, 7 Nov 2024 08:04:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 08:04:38 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 00:04:30 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 00:04:29 -0800
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 00:04:27 -0800
From: Chiara Meiohas <cmeioahs@nvidia.com>
To: <dsahern@gmail.com>, <leonro@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <jgg@nvidia.com>,
	<stephen@networkplumber.org>, Chiara Meiohas <cmeiohas@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>
Subject: [PATCH v2 iproute2-next 5/5] rdma: Add IB device and net device rename events
Date: Thu, 7 Nov 2024 10:02:48 +0200
Message-ID: <20241107080248.2028680-6-cmeioahs@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241107080248.2028680-1-cmeioahs@nvidia.com>
References: <20241107080248.2028680-1-cmeioahs@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|PH0PR12MB7862:EE_
X-MS-Office365-Filtering-Correlation-Id: a34a5b30-8e30-4227-88e1-08dcff02d397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|61400799027|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gnk89LvbLkdN9XKqNFWN3WNUlmo8khq3S4zphvf9wTKg/IuwBT6zEjXtkbfq?=
 =?us-ascii?Q?mVuWZN901r9ZI3LXgGOuWfFg43IjUNh+yklETsVWvO23AmSnF36KQ2Ykjr6M?=
 =?us-ascii?Q?5JyaXXB1FdmcUcYdHE2sh6jOvMTJf6V7pLwklq5IJezXUIisqqUIac3UX5Pa?=
 =?us-ascii?Q?5TB6Z3qJI0Tk9pAWX02iUdnwCdOuGc78qXu7i+1FvL0VKbcJmGTBpfqjOYmw?=
 =?us-ascii?Q?qOULZ56LzC7yUmB5XUwuF3Ke1f8OTPcg10UOFHV16ZttGV4mYZdya4Et/R9U?=
 =?us-ascii?Q?QH4UGeC2H0WVZs1Ya2VJP7q98fuWyS4dFrcpfYLOs9opM6xxQqi1+QthMkzf?=
 =?us-ascii?Q?k2E3BYFKwTRD82BDuTUn7UA85Ka0RWfMD1IJlcpYvLtbUTEME394fmrZsEPa?=
 =?us-ascii?Q?MkxUC6xYmauT/KFD35d09fm/Y6ul/m0+IAdAUrHhXLktsE9NlkmoLHLh8mGs?=
 =?us-ascii?Q?YYzuKeeknNybWmCPAAjwePbvG/EdFHmncxBo/xZCH2ZdDIw89dtOyMQUPsGi?=
 =?us-ascii?Q?GCR6lhdEsrqqENG40AfoYtKE3XBnlTF7X8R4WgGeT2ZNur6qNFz0m1hMkyLb?=
 =?us-ascii?Q?mIvh9PR/Whbsk6iksjc3aK1QhCE8pA0WRCc2ZPY/3RlDOUqHqdeiu36jD8nx?=
 =?us-ascii?Q?dGShp0AZ45fqBXxKrlnFLmdAU33+3IG7nx3nDn/14vzWnsx3fk+HBgEtSIGD?=
 =?us-ascii?Q?Wm47lR/B8JGXiQBc75CKDxk1tHvf0hORoySavNcqDixCKzjYUly+/2bwRTQi?=
 =?us-ascii?Q?z/CsPYsGDBO9GDqO8M9U3G6Uw5uGvD4nQvkYkdxZ/xNF6c8TTtHmB7L+Ezni?=
 =?us-ascii?Q?E0UtUflCD9+LZX04P92FuB4UDAGGl5c5k2JV3m6IMiJ6PiPiLGfLc5z+l+Nj?=
 =?us-ascii?Q?rO4LuvXcSctgbpVXD+T90/6OgRekO0dADp9ubGaF85TEXhFqEui/yrkOfdRs?=
 =?us-ascii?Q?tNB3O061vtix5mqdvMvEP9AWEqFn8FBeRqUaACnKDN6eTCKk+JdWn4U5E/0i?=
 =?us-ascii?Q?KmuSCIRYhtjMaZdxJ6QBbPPsGyRWFhVXATOf+Iruk0aiuahLdlFasibTI1no?=
 =?us-ascii?Q?Zp8TMWjr+Y5r5uc9Lc01ACPMz4E8I1M9lVBSutNaqYb6UwYYeGCkZoK7itmj?=
 =?us-ascii?Q?zJLRFufAD0IAt4ZwCAnMe+JgjxnvKuFo3QIkQ9zvpMOs5P2Llf+uooC8qlw2?=
 =?us-ascii?Q?o0+KtlmfBaT4/8b4FshTkTDdX3JjREqF68gFnxOs4F5YpUbuS57tHH7aPO0u?=
 =?us-ascii?Q?nGKalqmdHPSHPX0KZMpl+8HzeHs0Oz1TTGzrGkNV/55gvxEVtrQyWZiTZ4PT?=
 =?us-ascii?Q?Qx0bF+4rvAPmXNMkAlq+pkgPFQPRYvTxwQdziYo02XJDKjL9mOGxU2F5EUUt?=
 =?us-ascii?Q?btq+ewdbD51d2dZX8AN7+4kmvb3cgr0T64XpadFWxtGWmHXuMA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(61400799027)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 08:04:38.4552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a34a5b30-8e30-4227-88e1-08dcff02d397
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7862

From: Chiara Meiohas <cmeiohas@nvidia.com>

rdma monitor displays the IB device name and the netdevice
name when displaying event info. Since users can modiy these
names, we track and notify on renaming events.

$ rdma monitor
$ rmmod mlx5_ib
[UNREGISTER]    dev 1  rocep8s0f1
[UNREGISTER]    dev 0  rocep8s0f0

$ modprobe mlx5_ib
[REGISTER]      dev 2  mlx5_0
[NETDEV_ATTACH] dev 2  mlx5_0 port 1 netdev 4 eth2
[REGISTER]      dev 3  mlx5_1
[NETDEV_ATTACH] dev 3  mlx5_1 port 1 netdev 5 eth3
[RENAME]        dev 2  rocep8s0f0
[RENAME]        dev 3  rocep8s0f1

$ devlink dev eswitch set pci/0000:08:00.0 mode switchdev
[UNREGISTER]    dev 2  rocep8s0f0
[REGISTER]      dev 4  mlx5_0
[NETDEV_ATTACH] dev 4  mlx5_0 port 30 netdev 4 eth2
[RENAME]        dev 4  rdmap8s0f0

$ echo 4 > /sys/class/net/eth2/device/sriov_numvfs
[NETDEV_ATTACH] dev 4  rdmap8s0f0 port 2 netdev 7 eth4
[NETDEV_ATTACH] dev 4  rdmap8s0f0 port 3 netdev 8 eth5
[NETDEV_ATTACH] dev 4  rdmap8s0f0 port 4 netdev 9 eth6
[NETDEV_ATTACH] dev 4  rdmap8s0f0 port 5 netdev 10 eth7
[REGISTER]      dev 5  mlx5_0
[NETDEV_ATTACH] dev 5  mlx5_0 port 1 netdev 11 eth8
[REGISTER]      dev 6  mlx5_1
[NETDEV_ATTACH] dev 6  mlx5_1 port 1 netdev 12 eth9
[RENAME]        dev 5  rocep8s0f0v0
[RENAME]        dev 6  rocep8s0f0v1
[REGISTER]      dev 7  mlx5_0
[NETDEV_ATTACH] dev 7  mlx5_0 port 1 netdev 13 eth10
[RENAME]        dev 7  rocep8s0f0v2
[REGISTER]      dev 8  mlx5_0
[NETDEV_ATTACH] dev 8  mlx5_0 port 1 netdev 14 eth11
[RENAME]        dev 8  rocep8s0f0v3

$ ip link set eth2 name myeth2
[NETDEV_RENAME]	 netdev 4 myeth2

$ ip link set eth1 name myeth1

** no events received, because eth1 is not attached to
   an IB device **

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 rdma/monitor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rdma/monitor.c b/rdma/monitor.c
index 0a2d3053..cc2d42d9 100644
--- a/rdma/monitor.c
+++ b/rdma/monitor.c
@@ -16,6 +16,8 @@ static void mon_print_event_type(struct nlattr **tb)
 		"[UNREGISTER]",
 		"[NETDEV_ATTACH]",
 		"[NETDEV_DETACH]",
+		"[RENAME]",
+		"[NETDEV_RENAME]",
 	};
 	enum rdma_nl_notify_event_type etype;
 	static char unknown_type[32];
-- 
2.44.0


