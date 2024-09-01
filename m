Return-Path: <linux-rdma+bounces-4675-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31097967417
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Sep 2024 02:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55A351C2111A
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Sep 2024 00:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1EB200C7;
	Sun,  1 Sep 2024 00:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dlowhxzg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02011EA84;
	Sun,  1 Sep 2024 00:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725152138; cv=fail; b=elL0lb0tJjt/21OBZSUC3nbqocUO75CPvOdqdspIHXpNSGH31ocIPi+T1ax7US72MXrE/9Gded1o0O5UIXRyP842k2wB1UTouDLXNou/kp7UAZqSX2gk5sv0YX2GMOngD52BIGgKaPLtIHciMYdvyfQejQ6sB3s3EXVBSqqK2ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725152138; c=relaxed/simple;
	bh=exQUCzCsUh8vUNI77lXsnJOkj/32LqF8lI1fL7jsaDE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F95MGe4SCY+SQfFFSrqV5J8bNbzN7sgC+TJeqHdaoVDSK6ZP7/yc4AFobJzLWSCVX/yULxqJmhI1WpJQZvwTf9LK0z36q0ASep0sIVI6dA8C3XV9bGxj2tiyzjPtyd6B4ej+W5zIZ2r/kahWH/s8niTQf8Uuxn0IcAD4TXusAs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dlowhxzg; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJ0CElZyVu7WWmx/5rLefka+a/NWrbABOrEAGRwoy5X4Ql3bFKHG6cN+v2UmcNGIXaJ61Qce5ZXJ72CvnEDeCJ0rm2suCJ3R79IrUFfxT7Y83vW3SYitXikJHh8/+2l0VY0r7gUbQRirjcb14gFSvXlcx+CRV956cO8gf+OeXeN3dTzwFzAHCFLAiBLB4r/mFJz4CvJtPSReY27kDA3cmFOkFc0tOUweVcfQ5XC9jLlEdXJ5fpXZ7fB2i4RpG2dj2/mcqXON3pt3IXc6GXXK38oV8Fr75WgQj40cZ52F7Ey7NTZi97WdUAAt9Kjb7LIvUXE+0tiYQrU0el6CzHOz8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhQzdYo2Xa19yX7s3+o6V1Xm4os1GgVPzTsKjUwaFvk=;
 b=n2xyV6oKQs+Fd1h2zsLMHzMYpT8UPsOM4Xyy4ST79De9V6Zs3xV/wW5SvgEep+9BMzwkf3ihFILtIHYuQ1kb/VD1RodDDfs7UKDbWfcVIPXYIDlYhtU1oYTzdr8wV+gDf46jCfqMnqaX8twrTNRij1Mgwpnl5ld1x/sCd2ihmmXt7fRiZcfqpz1Rd1i+IOHc4GTXmrFsVHWjQwYc6wEKioRfOF41dguFVfvByetUQ1gINr4FcVk5CWZLQnjXbK1kGGRLtXet0clDO864XkgnpjWOCiSCl3iBUGildQFwim4MugxD739S40XpTgpuyYr1f2CPtaj0MReKQUNJ/b+l1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhQzdYo2Xa19yX7s3+o6V1Xm4os1GgVPzTsKjUwaFvk=;
 b=dlowhxzgm5I/8RkSceQK2OKzkHtTYbMC2DB3bZC+n97O5pWd/lYiZhVIctp2mk5HmIZPUmnJizRwR5xDzPm09cnMGAz2/d8/y0jo4VZ9WG+LBvuZ7ICtl0cscSiZ/+gOYAaxFdyBS1laU4xE7Mae8W0NcQUhJLh9dXJE+NAWdaXyCki3JHQ04kaI3kzUaZ7FtAUpoy8KscJ1hNivtxhGHBCpm9eXo/aROw4kJYcAIuBN0YP1WO29WmVApyC2AiYTAQef3ObVXqCt+OwjBh9PnjwU/VwT1YV/Eo1cl/GhZT98q6G2Kv1E9pshVe/5PN93m3pGwKl0XpbT/eQzYfDstw==
Received: from BN0PR08CA0005.namprd08.prod.outlook.com (2603:10b6:408:142::20)
 by PH7PR12MB6881.namprd12.prod.outlook.com (2603:10b6:510:1b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Sun, 1 Sep
 2024 00:55:34 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::63) by BN0PR08CA0005.outlook.office365.com
 (2603:10b6:408:142::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.21 via Frontend
 Transport; Sun, 1 Sep 2024 00:55:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Sun, 1 Sep 2024 00:55:33 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 31 Aug
 2024 17:55:28 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 31 Aug 2024 17:55:27 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 31 Aug 2024 17:55:25 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <dsahern@gmail.com>, <leonro@nvidia.com>
CC: <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	Chiara Meiohas <cmeiohas@nvidia.com>, Michael Guralnik
	<michaelgur@nvidia.com>
Subject: [RFC iproute2-next 2/4] rdma: Add support for rdma monitor
Date: Sun, 1 Sep 2024 03:54:54 +0300
Message-ID: <20240901005456.25275-3-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20240901005456.25275-1-michaelgur@nvidia.com>
References: <20240901005456.25275-1-michaelgur@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|PH7PR12MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: 0511e5d1-ed59-40bc-76c8-08dcca20c8bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CBU+Rnhu7OlGEnUleK7+KRNbsk//RMxi9Bi15rE7ivWbqXGSyKUCisxYtJUJ?=
 =?us-ascii?Q?6D7tcHe8IOmf5US26JhD1yvLYFhkSwad0Q91WfQaEYZKuaQ9ek8W2vQYUvBb?=
 =?us-ascii?Q?YPwpZvqMeJYdp/FB+hSLc4hB2g0HrbUWdssR9CA2n/siPBYjLsQ5C/pirTgt?=
 =?us-ascii?Q?8uu8jPgwN7jE/yk4MEUh+0n+lgy5pU2PdGpELgLY4N9NWig36KXC2TctnZPT?=
 =?us-ascii?Q?PZCAAlgO0nE16J7jlhmdkVU0juHYXBjbOYv8TCeouzr4Xwflfgd96/VBdw/G?=
 =?us-ascii?Q?xAThpso4p4w5tUV3/FNFCWF2AmHCws7V8Ki06EBJyQPdK635FmfhN14ZQrEx?=
 =?us-ascii?Q?qG49Tw1q9g2/ydhembNgxoC/rddi1mN50B93Yoffe7BpH0T3cBsSnvrMKbqe?=
 =?us-ascii?Q?DX2bKArUvcEJiwVqKezFXn2v139Rycopvw6MmToGPKu+H29bjLoMKZ2viEVx?=
 =?us-ascii?Q?3H4rnisL++zP9oeOOJ5z73bKFtBAB2P64u9y8BXxQQo7vGdzlYbhutPRBmls?=
 =?us-ascii?Q?CQ9D0SGrzT2sPYhPsEm7PFSwQ4YJXJmYalNyfM3SzQFJUTA3e9IpauA10Y4M?=
 =?us-ascii?Q?iyrjryeSJ0qh6cU8urOG9s9hcl0YBX1CrFJ5oWVoNK2hIJHcv5HXLIqEwwkm?=
 =?us-ascii?Q?yuMKjJUxDXLBK/xKUcWFVI8MVLtdgW5yluwGuATU4u/QSzCBG/HRL7qlcklw?=
 =?us-ascii?Q?K4nr7m3terPJQwoRRDq1F7Aqi1bkkrGxv0dvAXWs/Os56G+M4r0uLaNZlUYX?=
 =?us-ascii?Q?xHLeCvUwZxv51wK5cuo/g/zh8YjkN848D/XmTaNzFKYuqYbUdkjv8gik8tXS?=
 =?us-ascii?Q?WLa/7notXOS1RdZv8pn139WK2Y1TctF1tDGuxwudIAL5ccZX1C2MPcLpcegW?=
 =?us-ascii?Q?0MQFVnBDdkSGwT3d8z/5vs15FMunMnLez+qjKysUjFRrvMZd5vH9BMJf0EGK?=
 =?us-ascii?Q?h1pOy/CPy4Ud3WUQoYGtBK6/y4a/NojEpS3/+EMWoKPF2LJmDEt0rg0Jq6QT?=
 =?us-ascii?Q?n2Ap2DEBnLpzWjlmH+HB6IZp3Je3in0rg6Qm+SB64Q9zBFN0B7PR3B2k09tk?=
 =?us-ascii?Q?rZicXusZlcThO0dXtvfeh+eYX70ORKndUL9fENxZyMmmdxkhYXzXBrRqkqiM?=
 =?us-ascii?Q?5gA+rVfQbgkYV5sX+H+da0IqbrbH5pDwMzhFqX0m4proAl58WkcHEFB4gqPg?=
 =?us-ascii?Q?ppXU+JQIOKvi7HL6zKTAV3iJ2Iz1ba+bp6aSUMyR4ypZhiDpizpiE8HUbdi8?=
 =?us-ascii?Q?cmuWtf/K5vit9QmZHs7kNED3ePxv8TB1T7l73TrjcXDiG4bBSvTU4yq6uPFH?=
 =?us-ascii?Q?01oH8AgsNvJP5wLdxtPqfVw2m+SE1EaSUZ+rmsPeVFjsWVYaAncYMEs6CXnw?=
 =?us-ascii?Q?aHTYtEeb7bxFNDLqffaEqi6RSh/GclyEBZxdc348RujDm16g2LNbcfefHLXH?=
 =?us-ascii?Q?r6LItaPeALCizqJvr49Yuocg1sHQCqeL?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2024 00:55:33.3295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0511e5d1-ed59-40bc-76c8-08dcca20c8bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6881

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
[UNREGISTER]	dev 3
[UNREGISTER]	dev 0

$modprobe mlx5_ib
[REGISTER]	dev 4
[NETDEV_ATTACH]	dev 4 port 1 netdev 4
[REGISTER]	dev 5
[NETDEV_ATTACH]	dev 5 port 1 netdev 5

$ devlink dev eswitch set pci/0000:08:00.0 mode switchdev
[UNREGISTER]	dev 4
[REGISTER]	dev 6
[NETDEV_ATTACH]	dev 6 port 6 netdev 4

$ echo 4 > /sys/class/net/eth2/device/sriov_numvfs
[NETDEV_ATTACH]	dev 6 port 2 netdev 7
[NETDEV_ATTACH]	dev 6 port 3 netdev 8
[NETDEV_ATTACH]	dev 6 port 4 netdev 9
[NETDEV_ATTACH]	dev 6 port 5 netdev 10
[REGISTER]	dev 7
[NETDEV_ATTACH]	dev 7 port 1 netdev 11
[REGISTER]	dev 8
[NETDEV_ATTACH]	dev 8 port 1 netdev 12
[REGISTER]	dev 9
[NETDEV_ATTACH]	dev 9 port 1 netdev 13
[REGISTER]	dev 10
[NETDEV_ATTACH]	dev 10 port 1 netdev 14

$ echo 0 > /sys/class/net/eth2/device/sriov_numvfs
[UNREGISTER]	dev 7
[UNREGISTER]	dev 8
[UNREGISTER]	dev 9
[UNREGISTER]	dev 10
[NETDEV_DETACH]	dev 6 port 2
[NETDEV_DETACH]	dev 6 port 3
[NETDEV_DETACH]	dev 6 port 4
[NETDEV_DETACH]	dev 6 port 5

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
---
 include/mnl_utils.h     |   1 +
 lib/mnl_utils.c         |   5 ++
 man/man8/rdma-monitor.8 |  51 ++++++++++++
 man/man8/rdma.8         |   7 +-
 rdma/Makefile           |   3 +-
 rdma/monitor.c          | 167 ++++++++++++++++++++++++++++++++++++++++
 rdma/rdma.c             |   3 +-
 rdma/rdma.h             |   1 +
 rdma/utils.c            |   1 +
 9 files changed, 236 insertions(+), 3 deletions(-)
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
index 00000000..d74727a0
--- /dev/null
+++ b/rdma/monitor.c
@@ -0,0 +1,167 @@
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
+static const char *event_type_to_str(uint8_t etype)
+{
+	static const char *const event_types_str[] = { "[REGISTER]",
+						       "[UNREGISTER]",
+						       "[NETDEV_ATTACH]",
+						       "[NETDEV_DETACH]" };
+
+	if (etype < ARRAY_SIZE(event_types_str))
+		return event_types_str[etype];
+
+	return "[UNKNOWN]";
+}
+
+static int mon_show_rdma_register(struct nlattr **tb)
+{
+	enum rdma_nl_event_type etype;
+	uint32_t rdma_idx;
+
+	if (!tb[RDMA_NLDEV_ATTR_DEV_INDEX])
+		return MNL_CB_ERROR;
+
+	rdma_idx = mnl_attr_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]);
+	etype = mnl_attr_get_u8(tb[RDMA_NLDEV_ATTR_EVENT_TYPE]);
+
+	open_json_object(NULL);
+	print_string(PRINT_ANY, "event_type", "%s\t",
+		     event_type_to_str(etype));
+	print_uint(PRINT_ANY, "rdma_index", "dev %u", rdma_idx);
+	close_json_object();
+	newline();
+	fflush(stdout);
+
+	return MNL_CB_OK;
+}
+
+static int mon_show_netdev_association(struct nlattr **tb)
+{
+	uint32_t rdma_idx, port, net_idx;
+	enum rdma_nl_event_type etype;
+
+	if (!tb[RDMA_NLDEV_ATTR_DEV_INDEX] || !tb[RDMA_NLDEV_ATTR_PORT_INDEX]) {
+		return MNL_CB_ERROR;
+	}
+
+	rdma_idx = mnl_attr_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]);
+	port = mnl_attr_get_u32(tb[RDMA_NLDEV_ATTR_PORT_INDEX]);
+	etype = mnl_attr_get_u8(tb[RDMA_NLDEV_ATTR_EVENT_TYPE]);
+
+	open_json_object(NULL);
+	print_string(PRINT_ANY, "event_type", "%s\t", event_type_to_str(etype));
+	print_uint(PRINT_ANY, "rdma_index", "dev %u", rdma_idx);
+	print_uint(PRINT_ANY, "port", " port %u", port);
+
+	if (etype == RDMA_NETDEV_ATTACH_EVENT) {
+		net_idx = mnl_attr_get_u32(tb[RDMA_NLDEV_ATTR_NDEV_INDEX]);
+		print_uint(PRINT_ANY, "netdev_index", " netdev %u", net_idx);
+	}
+	close_json_object();
+	newline();
+	fflush(stdout);
+
+	return MNL_CB_OK;
+}
+
+static int mon_show_cb(const struct nlmsghdr *nlh, void *data)
+{
+	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX + 1] = {};
+	enum rdma_nl_event_type etype;
+
+	mnl_attr_parse(nlh, 0, rd_attr_cb, tb);
+	if (!tb[RDMA_NLDEV_ATTR_EVENT_TYPE])
+		return MNL_CB_ERROR;
+
+	etype = mnl_attr_get_u8(tb[RDMA_NLDEV_ATTR_EVENT_TYPE]);
+
+	switch (etype) {
+		case RDMA_REGISTER_EVENT:
+		case RDMA_UNREGISTER_EVENT:
+			return mon_show_rdma_register(tb);
+		case RDMA_NETDEV_ATTACH_EVENT:
+		case RDMA_NETDEV_DETACH_EVENT:
+			return mon_show_netdev_association(tb);
+		default:
+			return MNL_CB_ERROR;
+	}
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
+		printf("Buffer allocation failed\n");
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
2.17.2


