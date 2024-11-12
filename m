Return-Path: <linux-rdma+bounces-5943-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4B59C5295
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2024 11:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9050A1F218C9
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Nov 2024 10:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC1F2123EA;
	Tue, 12 Nov 2024 09:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O48i5FHH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DF820E337;
	Tue, 12 Nov 2024 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731405557; cv=fail; b=AwEAYLDzz789C5vePFh7zJcj8O0TZOSa33FvXUHyuauCI+TGWF0DVYXQH7JTiCkiOHCQwNPs+C85QMaRFY95vEOq6ZExP0/SEHPh4+WFun2aw+bEcTNIY77lO377yYjqxvsK5S2gBveQmB1uF6GUT+0fgYYneLbOPrN1KmOD+qI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731405557; c=relaxed/simple;
	bh=UFzmybd5CINut2snZ89G6l1Sc+X0nLuZRMEYV7yGPWM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uR/sWLHU7P1rHcs1QaUuO4YjAcy8iuQ+r1Fmwr0afUYFy+Gsrq8Qv0Cy3gYskDXi+Hd887mkhLI0n7+7Nn2shl3On0D3QGlE8QExIIwXGmem5ApoWm9N0nMjL2sQB6JDqtJVJheiRVi+BJuAAZJ8IjzcZudreY5ayhyaE497pi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O48i5FHH; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RseiTH9sO4nYmfcceHYXozxa32Se2U5V8mPdZAzTEIgLn4C3So3MU/ULvpZCXkeh3cqmnyXMyuQp/PbatCGeB1MA7MiFruK9gFroc7FqpBNXcfnzhboyJ4e8XGTZYdpyHJLEl6BWkMcmegSRMZdfY7XTmtoT0q6YCh7eASieVG/MOZ5tnjjXNNurZSlvbmMJvz6rGsd/pObxFi7Oe/jCh2zr0mdNZ014AQc35FUOYfHiVTJX6rDXnIeBNuJIKNsgztmeV2qYlZy7qoiM2juReSpBTdlLbobhT+M9xZRJ54D0utsH9Ud4st3wBKIpptMw7HWtfamtQtsaYp8lQbm10Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W25mBNHOOWlyGTa1da1mskKLnu4+rIC6/5XskelSX/g=;
 b=Z3Bi6cggSgIvpnfJxcuUPgICm09r/jGezKcxtLTsHE2KdpYcscQl6W/GUWImSRUWV/2qJHZGtFrXVwNCxsPxvXjstglukTFVerXg4xqWGLufvvYQhYA/KGkzuLZ8uDJb5HaH0MGIKt4FhOV5bpymoiawsJm65+NF6YtJqwPh+Se89a+ePuFyhhdtLCt666JQpzHGUuM1i4WkWZczyo5cI1NW77EGSqy8VWHXnAezggk5GfLvXEYZ3E8ZLo/6KTp46KLvE1ePK3bmf61QOHG4E4lxuZeOqftRnknEdNRFwVSd64n0uQePycK3KPvuFWKHzx9VHpSGcv8XyVGzIgcW+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W25mBNHOOWlyGTa1da1mskKLnu4+rIC6/5XskelSX/g=;
 b=O48i5FHHjwzFwCN3y5EOBhtn8LbmR7b3gJTCClEpKIsGQ/KrIlv44yhGvKx3maYzB54iIi6yTFjxVZO8vgFDXZmEp3H9EBW6yRU7ICZ4kuTii9VVoT2tYsNA2RMG65hLsJSCl6zqQYhHRdyreEQvsfSCFvbPFT08FX55VogRdjf2IFDEGaQZjr+eLwhqgItkBAGpqUSzvDZo1uYVWgWb7KCwn2gagMfy6+h3imanYuEfMx36VrVjdZq6IQWgypVLlGpnu+WATUBTycNKjXk0p+3Zadvsug1pFgFxHIy5QEfBu3KrbIkY6NQQx10HcAHBSzs7KA1HYYbFP0jKX5lMCg==
Received: from DM6PR03CA0099.namprd03.prod.outlook.com (2603:10b6:5:333::32)
 by LV8PR12MB9449.namprd12.prod.outlook.com (2603:10b6:408:204::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Tue, 12 Nov
 2024 09:59:04 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:5:333:cafe::a9) by DM6PR03CA0099.outlook.office365.com
 (2603:10b6:5:333::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Tue, 12 Nov 2024 09:59:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 09:59:04 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 12 Nov
 2024 01:58:55 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 12 Nov 2024 01:58:54 -0800
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 12 Nov 2024 01:58:52 -0800
From: Chiara Meiohas <cmeioahs@nvidia.com>
To: <dsahern@gmail.com>, <leonro@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <jgg@nvidia.com>,
	<stephen@networkplumber.org>, Chiara Meiohas <cmeiohas@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>
Subject: [PATCH v3 iproute2-next 5/5] rdma: Add IB device and net device rename events
Date: Tue, 12 Nov 2024 11:58:02 +0200
Message-ID: <20241112095802.2355220-6-cmeioahs@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|LV8PR12MB9449:EE_
X-MS-Office365-Filtering-Correlation-Id: ce56e13e-0208-4059-e1d1-08dd0300a421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cmgc2To5LZ+NNxEzbrb4Nhpk1FP3yGhHlx4kth5qJAufRy1hLrnyuBymSyGG?=
 =?us-ascii?Q?pneb7qfHD+yuF49fbtgIjiQG9QW9nDaI0t4gFfGYYSIVlWtMbDRoZCoL8r/V?=
 =?us-ascii?Q?A3pqbBjd9OlJQ9L1IW63F+lxry9fNhbgOMpRUVVteV5CdDu8+E7A/HhFQUB8?=
 =?us-ascii?Q?X6xcGR4slZQdIUaPKhvX71PIHrCtJ3IJ633wfPqB0c5Q6oSTOaCVraMwq8dJ?=
 =?us-ascii?Q?VIZqsFq6GCp9e1hlnzQKjUjkDLgGSqVkfd7PS7uuZ1wCoYGDXATqXC18Lv5Z?=
 =?us-ascii?Q?ZLqlrZ2Yxmmqvm+N8w0EB19Ge2Al3o5Ch5lBddZtpdlYW0t/hJdJKA1hCre7?=
 =?us-ascii?Q?mlFv2CBUouLcr81A/Ny+D2tmuJSocU5GMnP9s0QENY2HytnM7+XciaIJ4uRv?=
 =?us-ascii?Q?bd2L2zRWS7aywgEVhJI1CRU8UuBiAuue51mevLYO+++zniAonP9kdU4qZnNn?=
 =?us-ascii?Q?j5P7pivlddMRcaS5LaBe+p9suj1LdCwEuvsMHdt/t4B5jkZ/kaCz/RltC85o?=
 =?us-ascii?Q?kKzCYHTbc2L5ucjir9hJ1g25++MZen0HibswVdKniRpe96DRxQAcGC1HsFKm?=
 =?us-ascii?Q?oD5DUP4QGGXpwbIuJXoKwUfiPoVVQluFdTpbEXXVvThxXGsm4w+x4DMjbZId?=
 =?us-ascii?Q?MBhVOJ37mAsXsJDUcetzAFN1MNDeXaMpOAE8KJyYLzvOQVjYNmehBXcSM5RY?=
 =?us-ascii?Q?EESABm+kkOEKyMJIR9thDEQPydAURPZI1ZOmCM9WLra7p914WuTcxAo5Zfhr?=
 =?us-ascii?Q?ygxX+i3bpop5aNDU1fEAJJHfSnv5L0CL21Zfyte8In8w48G2TfZAKJqIfbeV?=
 =?us-ascii?Q?8nLhsos5a/xCRcP2vlhfQiQPL5CFSFub6KTC4Ad+f19TupTq+DtRbOenXPc0?=
 =?us-ascii?Q?3KPlOFmv8jFopMVMdrYufQFIoC3n4fY8iyiq2VHBecozoFancCNDrYluUkUm?=
 =?us-ascii?Q?JkORJbwmtDotumQ76E4mvfXPdBMQXSgjomSNSwYUZqO0DgS9jcrQPYj1qsPj?=
 =?us-ascii?Q?sU5X247wHYvVlCKciJ9TJK6C58iXZgI5ONLlivIL1uBhPiM62GOg818D25iM?=
 =?us-ascii?Q?Kvk0eMxoqG4YoiRIBbXnbsS2Q7phngmqAnUiWD8+dZEfMYMu4RSMtdi7LqN7?=
 =?us-ascii?Q?ZcVqK2QkfysB2H8WKDpre41h8shbUUVpHxtzHCWxrhKyrH3X8jr21vtS8x8s?=
 =?us-ascii?Q?lOgGn/7A1r6P68BDnN6CYk2bxAzvfgpjSJC8WBqfyzddet9rE/x3DTqPWulp?=
 =?us-ascii?Q?0c+VMMXAyXrQC+uqpJuA7BJYRqabRvqmrEy3gJIfHcxW9BcO833WmKv8gjlB?=
 =?us-ascii?Q?9ocgjas9PjFNv+NCz/Bbb1NEtXnDQfldDetinHlJ56M1CPD27APAOQpMxME0?=
 =?us-ascii?Q?f22/b6XAZ8nldkbOo+AMXY2HfNsOqn7wst67QKB/gwklKZIHXw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(61400799027);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 09:59:04.3796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce56e13e-0208-4059-e1d1-08dd0300a421
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9449

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
index 8c14d575..fc80f7d8 100644
--- a/rdma/monitor.c
+++ b/rdma/monitor.c
@@ -41,6 +41,8 @@ static void mon_print_event_type(struct nlattr **tb)
 		[RDMA_UNREGISTER_EVENT] = "[UNREGISTER]",
 		[RDMA_NETDEV_ATTACH_EVENT] = "[NETDEV_ATTACH]",
 		[RDMA_NETDEV_DETACH_EVENT] = "[NETDEV_DETACH]",
+		[RDMA_RENAME_EVENT] = "[RENAME]",
+		[RDMA_NETDEV_RENAME_EVENT] = "[NETDEV_RENAME]",
 	};
 	enum rdma_nl_notify_event_type etype;
 	char unknown_type[32];
-- 
2.44.0


