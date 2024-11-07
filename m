Return-Path: <linux-rdma+bounces-5827-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 714B29BFF92
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 09:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D7AAB217C0
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 08:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D609199FBA;
	Thu,  7 Nov 2024 08:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SCmHrl91"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7D01993BA;
	Thu,  7 Nov 2024 08:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730966650; cv=fail; b=bW6npuqZ+HgJb1GQsduzXHNkWW+U/b+Vb+0JSQw5g9V2WTwrEl7T9xmkb4djw4m1wszkW2ClgoNYCcwwZJRtOJ5JeuM5TvrCT73HV94tBnEhYnz3BVpv6cCvRlmJM0iGkuys4pRJbTuvVvvUNQsddqsuktKQeX52DPJOolpqCvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730966650; c=relaxed/simple;
	bh=EpT5GDYfXzbcXqW+QrL2A1Zb63v+iFDgCqhqQjbPLlg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dfFdfBOVLUpraRxqP+BWVOlP9JSeESZiA7T068rbWzkIZJTUedYdjkdbfhPdrIfKuKwCDvddYp4tTnEuARr3ZtgYm94DQdSH+0h9tbHs/SwkytBNjbE4BqjEssslB13Td4ECah7HqV6A2ySHs15WfTw1zj7KW915lZ+pcvNmkD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SCmHrl91; arc=fail smtp.client-ip=40.107.101.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jpT+Hic5Gov9J+LJGf7uDUdM9ntbxDkIdQhQT2Ip8MjLIXVz9qb0Esgfsiy15DapyX3oyNlVQofKhDEH9FZIdE27P2YSGWEsyG3CQuJIQQEIe27afeocY/SBiFAcRNEzhBERfyinhdhZZ8XBRqWfCnGbcKCoocDOr54Ptkw6t2fdbt+8k1N2YxQlKNF7DDIZS85o+FkNE/JeJKbNNhprgioTzliMVrmoi8PzBDU5cH3cdub5BgcfMR+Ni8WLaNCm3ArGhNKo3ev1F8vTD3D4fmLNPlbJdx14jVYgv1IUgR4r6VA8ZuYmykrCIwjG4pnOYC4wJjxKkA2Ln8MtQrOqMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDl2WrRvNRCEUDQHanTFdupBH2ua/NdCjZUjl97QooU=;
 b=xK8E4fJ4dVuDQ7BAjuk4zM5mUfbn8BXSlf1ds3vNrzCKnGcWvKiUQaohjwlM4bfFb4Tvtk97sqxWttUbxm3GC+u94JTJ6fA7MpG/KhugGxZTmBaLf8jJTJeyjATAXpP40k0kaytKf0EczmGaySEKTXPk/Lpd5qKT4fPWGQw0Jo3bsLaxD5yoCo4JUGGs9Djnia8wqvZFdyQryt56zXqibwrJFPg1bXqVbNZSSPMkBsm/1071/LXWyCYiqdCzaULFnytB13SeXnt89j6sZ6PRuUggfebdGZYQWwUFbdQhBdtJyf5QRfQaHQk4rJs7AZxCytSFf0w+QP/2vTpqvEywfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDl2WrRvNRCEUDQHanTFdupBH2ua/NdCjZUjl97QooU=;
 b=SCmHrl91vTv8WAY+nkAgVETrqX8wV6QELYz0XPw0WA/KHNrm/FIqGVo38DIuHjEk3Ygmio5pYGxXQ+1sAg/ckKw+u/kMya/DInwvh6XeDVBnIjHtSMiK/kh5f3Kex5cae+ybuWPxzU4ALlraKmJSEInJtrQyvPD8xRGtRGdsaF9ALMmQkwlvDdAL902X//OuTtq1QIaWG9xzp/LU4RAU9BdtKPiPDiTP3gtHsyetMUzvgU3dHlEwJQrIeSVgg0J9Oczkt9SF+2IxbsvCyTQquqlmjLvz2PPcyqEIK/xRHr/HCsZq6ZxtAnC0wy7mHd7eAawF1AWGK4hBH4vE1h0zew==
Received: from SJ0PR13CA0135.namprd13.prod.outlook.com (2603:10b6:a03:2c6::20)
 by MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 08:04:05 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::cd) by SJ0PR13CA0135.outlook.office365.com
 (2603:10b6:a03:2c6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Thu, 7 Nov 2024 08:04:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 08:04:05 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 00:03:58 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 00:03:58 -0800
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 00:03:56 -0800
From: Chiara Meiohas <cmeioahs@nvidia.com>
To: <dsahern@gmail.com>, <leonro@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <jgg@nvidia.com>,
	<stephen@networkplumber.org>, Chiara Meiohas <cmeiohas@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>
Subject: [PATCH v2 iproute2-next 1/5] rdma: Add support for rdma monitor
Date: Thu, 7 Nov 2024 10:02:44 +0200
Message-ID: <20241107080248.2028680-2-cmeioahs@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|MN0PR12MB5713:EE_
X-MS-Office365-Filtering-Correlation-Id: 2485c3fa-770b-4e4b-dd5e-08dcff02bfb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ORZpoiyKwp5WqzX6K6UW6/2q7y2yiZ//qdlFBM3pM7L4aDJkVPjkOrcA1KnO?=
 =?us-ascii?Q?wnZGYN4yYWmTNKD4h+6tNsqMcLarugLB/PABnjERfsrmWf9VBICMY2X8gOLK?=
 =?us-ascii?Q?vqj3uuP5gNZ/G8A8OqF2r3oK565BLb7XPVJbZZqrbSq5DjJtjfz9V1vOhXO7?=
 =?us-ascii?Q?9HcHA4CKy1VZiEsN8TRibq/rzJP074VPXRR8rW0RW6gZTZ3VyN2Y4xlZw0Yn?=
 =?us-ascii?Q?2jOktzQ8pUKwdwHv6K666zlAtyW5XK+8ujd+7gFgqJvvYlBVzpSs7w+Ilgi/?=
 =?us-ascii?Q?7tkPUAy3woCSOiCmOwtaEpSS++Ec41WymDHQttMmzn1F7BEESSxw3i+uuoI4?=
 =?us-ascii?Q?CpwSCWLQ8NzqAEI7+tSFBGmUYrhTLibGZebH3GisgFXXMxs3R2WgKjWBvY3C?=
 =?us-ascii?Q?XjJNz1K7J8jbP68Krr/hT/IpbnsK47sOXEFNHm7lsMKB8hBqFNwp/hA3oJJd?=
 =?us-ascii?Q?WvLvBQGobQrmyAOWsmY+sbmtVjv6UDTMm+YiK5ATkxjUou8vZpDU9jkbinRt?=
 =?us-ascii?Q?gdssH2wSzXxtfbcJaOgHRDP3iA3ryRrCExKeln1RXJZeMOidul9L1kBJCYgw?=
 =?us-ascii?Q?Ao8ItO1NjaDYmyAlzKVRBVImrGddeIV1S9akK5tcuTNp3NqvesqhMwVmc+43?=
 =?us-ascii?Q?QedywqcvEObxGWg246vTdLbpxWHbPYi4BAPpxrEHomn4S2E9Ahd7sfN4WT83?=
 =?us-ascii?Q?KvXHgyquTPm20EXPNX328ppmMudCyp3DNq9fFEgwUCV5sNKZyPWEMisrZwcl?=
 =?us-ascii?Q?lZet4BwWpXPfxdgkqjmiF8xfCvIzX3NIO293yowLbSsY+V0nkh6rr9djBhch?=
 =?us-ascii?Q?5eCkJXrtDWa79WX334FMI+m4nKSuBuFYd5q57kN/h5iXfmbyseD0L6EVeZUc?=
 =?us-ascii?Q?6hIzxlKu3cF0yqLfFYuvIN9Dp/5tLBXgDvOl2uNfZblTfMCKI2lNqLBwu8br?=
 =?us-ascii?Q?ienXiLlnkH2i7TArYcvoQ6nmIUL+AWxrcvFpc+mqbqFvcK51obvBjI02r8SY?=
 =?us-ascii?Q?tVuPz5s6ibi+GD8pHVh/kmYlnUS29D0EAUF+f0/yUcNLy16+86t6TwyRNXD1?=
 =?us-ascii?Q?SYJxBbNRFEVwKA2+Dsp/0vFuG0jKUbJFSMgAXKPEeAVyr2oguxNpBfU2HxGn?=
 =?us-ascii?Q?PnmslKiR988Y/8zl7c7YhTIwkIghfcslDzk6fjF1ssACPJY4Hlu7FesSeFS8?=
 =?us-ascii?Q?M+xCgPeMe8CsFDwInTxYaTLnn9x/0GLgxMxjG4zN75jahS6GoCIj0Mraa5w8?=
 =?us-ascii?Q?VKdQR/uF++NhOpVsVD0/PoDy3gtfV2BYwld2q4OWlu8J9lDYSiGD5kZcbE/R?=
 =?us-ascii?Q?zIiN6SyBethX3BI6IZc3snx+W+JNjhCh0ijJ3AtXDZ6avWVc7bAmceWtMpMP?=
 =?us-ascii?Q?p2H0yOdUuHkpcsNLfbazov76AYC/RF6PGUU2ENv+E1W/2sK90A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 08:04:05.0995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2485c3fa-770b-4e4b-dd5e-08dcff02bfb5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5713

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
 lib/mnl_utils.c         |   5 ++
 man/man8/rdma-monitor.8 |  51 ++++++++++++
 man/man8/rdma.8         |   7 +-
 rdma/Makefile           |   3 +-
 rdma/monitor.c          | 169 ++++++++++++++++++++++++++++++++++++++++
 rdma/rdma.c             |   3 +-
 rdma/rdma.h             |   1 +
 rdma/utils.c            |   1 +
 9 files changed, 238 insertions(+), 3 deletions(-)
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
index 00000000..0a2d3053
--- /dev/null
+++ b/rdma/monitor.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * monitor.c	RDMA tool
+ * Authors:     Chiara Meiohas <cmeiohas@nvidia.com>
+ */
+
+#include "rdma.h"
+
+/* Global utils flags */
+extern int json;
+
+static void mon_print_event_type(struct nlattr **tb)
+{
+	static const char *const event_types_str[] = {
+		"[REGISTER]",
+		"[UNREGISTER]",
+		"[NETDEV_ATTACH]",
+		"[NETDEV_DETACH]",
+	};
+	enum rdma_nl_notify_event_type etype;
+	static char unknown_type[32];
+
+	if (!tb[RDMA_NLDEV_ATTR_EVENT_TYPE])
+		return;
+
+	etype = mnl_attr_get_u8(tb[RDMA_NLDEV_ATTR_EVENT_TYPE]);
+	if (etype < ARRAY_SIZE(event_types_str)) {
+		print_string(PRINT_ANY, "event_type", "%s\t",
+			     event_types_str[etype]);
+	} else {
+		snprintf(unknown_type, sizeof(unknown_type), "[UNKNOWN 0x%02x]", etype);
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
+	int one = 1;
+	char *buf;
+	int err;
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


