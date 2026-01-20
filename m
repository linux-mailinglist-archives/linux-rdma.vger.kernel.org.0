Return-Path: <linux-rdma+bounces-15754-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79436D3C243
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 09:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE0F06036BB
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 08:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF753D3D1C;
	Tue, 20 Jan 2026 08:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mux36M/M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012038.outbound.protection.outlook.com [40.107.209.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99143D3D0C;
	Tue, 20 Jan 2026 08:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768897066; cv=fail; b=p7WzKPBkTffqTq5lmw5YZt7tWVQfOvsiqIgzwRx6ty7s+eAifHRmFtmymKq0PIdTsdnmY+i0AjhR7t/6XjztIlZqTtmRQRVE343wePn4tSSCFN4J+tK/ZHTXU5RPh+0Tiih7wHyYIy/xy8nC+RupLffzNCd3rT/BANfHum8D4Gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768897066; c=relaxed/simple;
	bh=zFQcYKFsWt7tpLnBR2Is7NDbN8RHneJqq6bmDrnmzcQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QgLWkAGeFlOjh0KwEosoM6o2zQhJj3GoC0HyKRWFrzetixTCMvcl95HLOthqEMPTX5ROZo6kOKgCT8/DzMZAet1MGBfxpfLdpM+A35SBbO74hzd5TlaywGdWq6SM3aR60RVPf6vvTzLdxSXIhgG1zL6hVH8FAVBP3eDpRdCpDzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mux36M/M; arc=fail smtp.client-ip=40.107.209.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKFfJMV3nZG8R007pZS+z6L/OI5BiTJ1dox7/z/2rNqSEkoC3Ejz+s4CPQUxjcq2V/caPjaEYR9KZWyLf+fQsfQmhPfrQXlQVeF9GM+HjbSWYJbgTtnw+Mfei4tu1/iZQxlCArw9CtvQRyd6s7U5pp1gVpT98NCAvEb4O8Bb9sbk2bzjuj/hymCjeYof5BUTn+BADRKmdyIy8oiTbb+Zvysm3KZKlq/SFlxm89oROw3wus+vj5VGoHQMZfqIKVBP40palBuue2xOQRdMB/iM46xdWajNWLqDTrQKygzhER07/VQxyJlZ9hjZAlM2NinjEPEJlrIFy8IHpR1k90zOUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6xbZvJ5pj/y4nHpCKK04LPYZ61YncZb30ReygTfO7U=;
 b=RNAHXqioufBB9nj9PsPfA7znZa4BB4EjYPPpZoZV1T4wRK8X+Ig4zaGVXtenAq0dgAJIxDXKvJhg2YwtfjU0L7UbZh5Xh1DdRc2/IeW5gJG0ZhaPHz8m5HoKi524vt2+o2XIc4v8+hkKA/libozBxtM0/DkGBDkjfSwAyx92ozwSujjmX7MhjasBBoLCdjdgBanBU18uKybWRbZl1jJq4WXZXTLd6BPlOj6ZU1iOozV22WE/so+mPfF+fWJbeoqA+1xo+Q3nhw/wZHTttEPmcpgzGd0BH1VNcKXR0WZB1hsohLgM6rqrHNzXWGLbRCxMoztz6xUUq5bQhMG/qeK0Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6xbZvJ5pj/y4nHpCKK04LPYZ61YncZb30ReygTfO7U=;
 b=Mux36M/MYhqOz2jZwhqnhi9tkXbMfIrAXPhunFbcVu4WthFscCXE45Lp4XTIPLgIiaDN1FaVgXcFg0DXl5eXa3jb7Xov3fTBhAz5jEAiHMgwQaeUkTKNZNDdx+nO5QHmSuYB+Jw76T15vfysBR04xo88691UE8eW+CAvtzF4ssdONXkYMJod5fN2idcSBfHfAuZsv32aKqNB39jZXacIArjojG2F79EF6w2GVykv7QXGWpZfRh12u32PlXUAapetZCAtO+xxftSj8E4AFsZJ29y2pjnFvRa2rqZoL5vdXtzEJTSn+isrfbTDeqnF7d5bzixEBfvgUIZdGJn7AEVrAw==
Received: from CH0P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::14)
 by BL3PR12MB6619.namprd12.prod.outlook.com (2603:10b6:208:38e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.9; Tue, 20 Jan
 2026 08:17:40 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::a0) by CH0P221CA0004.outlook.office365.com
 (2603:10b6:610:11c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 08:17:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 08:17:40 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 00:17:26 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 00:17:26 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 20
 Jan 2026 00:17:22 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Parav Pandit <parav@nvidia.com>, Shay Drori
	<shayd@nvidia.com>
Subject: [PATCH net 3/4] net/mlx5: Fix vhca_id access call trace use before alloc
Date: Tue, 20 Jan 2026 10:16:53 +0200
Message-ID: <20260120081654.1639138-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260120081654.1639138-1-tariqt@nvidia.com>
References: <20260120081654.1639138-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|BL3PR12MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: da48fc59-225d-4466-e272-08de57fc60f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vYGc42YvpRTaUsKzEi0FWjqJe0Hp17jP7uTDBH5k/QbJOzrBKDFBTQAFYe3u?=
 =?us-ascii?Q?iSrS68xgmgbAB8HOQZ2gT9c875hWa7liEIWLC+zNQgLiFtQEPIlUniFYNHo1?=
 =?us-ascii?Q?OFvB5YWcM+t3vPm0JjpDQ62j2jhZMwrrZf5B/JMCaouqvwtUgiL4PLsza6rs?=
 =?us-ascii?Q?TkUvq6jQ94VimjfaBnUYwZg5X+4DTLv9bt2JjDe9urc6lHYec0fTJuvuKvfE?=
 =?us-ascii?Q?19XFekerP6ZhDrfQSx3QoD495x7sSsFqc2R4H+CehDVOkN/ve0lD6bw/VPcv?=
 =?us-ascii?Q?ZmOrSWJ8s2Ig9U1bS524G6yK0oZ8UavOLSGDrrUwE+XUlkBBFmOPsgw+FXkI?=
 =?us-ascii?Q?ryqt86GGnTs5l8foXofR3K4s6+ezU5vpqEllxXBSV9LDYCIeDIZfho7IqCaL?=
 =?us-ascii?Q?8UIE26rP4VyYLY5ZlgkyEBBqd7JY+n97LH9QMzJm7DGBBOTJJHz7Sw3G6Vgc?=
 =?us-ascii?Q?VBhvEiL0JriONo+y63Esm5V70jaoBsgzkGCyyzepzGTs7bODvHYpHUIayFaf?=
 =?us-ascii?Q?5XNrIW0dLxabSBE1S3eZ9rT4yFxOVp/CLMGjuhq1t7QmwmdrZ2RxJgPUV/Y2?=
 =?us-ascii?Q?1UHVHyHR4GVRwCdoPR5D4p3Vyn9UNwDQUsF+EfZfI8JMQEBxuaPrJRQLeiGs?=
 =?us-ascii?Q?DdIXj2DRRa3eCLEEhJ1BKESKbud7YFMfRqNNYYvfNUE3CzNBfUgwPsgigUL3?=
 =?us-ascii?Q?ZTSKwMTHNavcf+PNr68eYhdQgYXlmjqlbltJp5QasMnmkK7E7mN5DcXHlbTn?=
 =?us-ascii?Q?2mzIl4Ne/VakVcYQ1Vc7qvp5yoxgi91aJ1mcPqZtPhswUwUQwI/jI69ZfInw?=
 =?us-ascii?Q?46m4fcfD+pgwNiHe99MrTroJRiP0io6nSe+VGKNZD+Krrfe4rPl0r4EJJcig?=
 =?us-ascii?Q?N8W0tdlQwgxKzS8gejPzzv3zx1O2bs/vSN4Rx0P6TqDP5sAA/xwUdMeJzM0X?=
 =?us-ascii?Q?f/Cr35Sn8OjYsvmwfFeFHc/xAQtKluDprcQ65KlAH59hjJPqhbBpWj9qe0Mg?=
 =?us-ascii?Q?WguADequTtS9X4Mcq6t5v2AFPQZZTuj4ejQlSJa2+37O0rd2tb5XO+y7pDF6?=
 =?us-ascii?Q?9L/u3rgClBQnRcdZy7HFZXEVRxDTqti8lSbIhNKhV26nsvZoXFPG4kdSZnKT?=
 =?us-ascii?Q?H4mUuuQlqoinKAQIvASzoQ8tJvZ1iHlUmvpcO7kjBmSrD14UcwFgfE1FN32U?=
 =?us-ascii?Q?QrW1Cty80NiRn2uRDM3L+HvBJIkJb3OuEft2z2pDHenDczGihgsINhxc9CRE?=
 =?us-ascii?Q?vJYYoAQgwvLvKdPrPAkLXwE5wUXzsR3q5fEnb218p5UVoVrxA4CBsXcqlqns?=
 =?us-ascii?Q?dgAnKM0olXz+yosR5T+gJjIZML8m67DmyD4cs2FP6BznF3JprbJ7gkyXB72E?=
 =?us-ascii?Q?tKCAWD9JsTZ0pxS10hu1qNhrGRkDscmk5eu33gI8No9x6FD4FBgb6uoDhkRq?=
 =?us-ascii?Q?NMf/lVoO+ZlfcLzsXNggn7tHhQhfeSCQm7h+MX30QvCV9a/OEkGE8mfHdmyA?=
 =?us-ascii?Q?qq2GlGEXqgYXEKJFl7YSD5ZxIsyJyVIR77eYzzf2NPnpX9Z7wGZByvA9Gqfv?=
 =?us-ascii?Q?eu9Wu8+6s6NG1aZhI+mLy7ofBGu6MZs7LuFxoGO1n0Jx1jQvS33Cvj196oif?=
 =?us-ascii?Q?7neOSzrG+bcXj8ekERKNs+2iuhLB8LOKF6+i6d7EjeYqd1HPCysq7SfqcH3T?=
 =?us-ascii?Q?f5qkpw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 08:17:40.2192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da48fc59-225d-4466-e272-08de57fc60f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6619

From: Parav Pandit <parav@nvidia.com>

HCA CAP structure is allocated in mlx5_hca_caps_alloc().
mlx5_mdev_init()
  mlx5_hca_caps_alloc()

And HCA CAP is read from the device in mlx5_init_one().

The vhca_id's debugfs file is published even before above two
operations are done.
Due to this when user reads the vhca id before the initialization,
following call trace is observed.

Fix this by deferring debugfs publication until the HCA CAP is
allocated and read from the device.

BUG: kernel NULL pointer dereference, address: 0000000000000004
PGD 0 P4D 0
Oops: Oops: 0000 [#1] SMP PTI
CPU: 23 UID: 0 PID: 6605 Comm: cat Kdump: loaded Not tainted 6.18.0-rc7-sf+ #110 PREEMPT(full)
Hardware name: Supermicro SYS-6028U-TR4+/X10DRU-i+, BIOS 2.0b 08/09/2016
RIP: 0010:vhca_id_show+0x17/0x30 [mlx5_core]
Code: cb 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 48 8b 47 70 48 c7 c6 45 f0 12 c1 48 8b 80 70 03 00 00 <8b> 50 04 0f ca 0f b7 d2 e8 8c 82 47 cb 31 c0 c3 cc cc cc cc 0f 1f
RSP: 0018:ffffd37f4f337d40 EFLAGS: 00010203
RAX: 0000000000000000 RBX: ffff8f18445c9b40 RCX: 0000000000000001
RDX: ffff8f1109825180 RSI: ffffffffc112f045 RDI: ffff8f18445c9b40
RBP: 0000000000000000 R08: 0000645eac0d2928 R09: 0000000000000006
R10: ffffd37f4f337d48 R11: 0000000000000000 R12: ffffd37f4f337dd8
R13: ffffd37f4f337db0 R14: ffff8f18445c9b68 R15: 0000000000000001
FS:  00007f3eea099580(0000) GS:ffff8f2090f1f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000004 CR3: 00000008b64e4006 CR4: 00000000003726f0
Call Trace:
 <TASK>
 seq_read_iter+0x11f/0x4f0
 ? _raw_spin_unlock+0x15/0x30
 ? do_anonymous_page+0x104/0x810
 seq_read+0xf6/0x120
 ? srso_alias_untrain_ret+0x1/0x10
 full_proxy_read+0x5c/0x90
 vfs_read+0xad/0x320
 ? handle_mm_fault+0x1ab/0x290
 ksys_read+0x52/0xd0
 do_syscall_64+0x61/0x11e0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fixes: dd3dd7263cde ("net/mlx5: Expose vhca_id to debugfs")
Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/debugfs.c    | 16 ++++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/main.c   | 14 +++-----------
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h  |  1 +
 .../ethernet/mellanox/mlx5/core/sf/dev/driver.c  |  1 +
 4 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c b/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
index 36806e813c33..1301c56e20d6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/debugfs.c
@@ -613,3 +613,19 @@ void mlx5_debug_cq_remove(struct mlx5_core_dev *dev, struct mlx5_core_cq *cq)
 		cq->dbg = NULL;
 	}
 }
+
+static int vhca_id_show(struct seq_file *file, void *priv)
+{
+	struct mlx5_core_dev *dev = file->private;
+
+	seq_printf(file, "0x%x\n", MLX5_CAP_GEN(dev, vhca_id));
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(vhca_id);
+
+void mlx5_vhca_debugfs_init(struct mlx5_core_dev *dev)
+{
+	debugfs_create_file("vhca_id", 0400, dev->priv.dbg.dbg_root, dev,
+			    &vhca_id_fops);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 4209da722f9a..55b4e0cceae2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1806,16 +1806,6 @@ static int mlx5_hca_caps_alloc(struct mlx5_core_dev *dev)
 	return -ENOMEM;
 }
 
-static int vhca_id_show(struct seq_file *file, void *priv)
-{
-	struct mlx5_core_dev *dev = file->private;
-
-	seq_printf(file, "0x%x\n", MLX5_CAP_GEN(dev, vhca_id));
-	return 0;
-}
-
-DEFINE_SHOW_ATTRIBUTE(vhca_id);
-
 static int mlx5_notifiers_init(struct mlx5_core_dev *dev)
 {
 	int err;
@@ -1884,7 +1874,7 @@ int mlx5_mdev_init(struct mlx5_core_dev *dev, int profile_idx)
 	priv->numa_node = dev_to_node(mlx5_core_dma_dev(dev));
 	priv->dbg.dbg_root = debugfs_create_dir(dev_name(dev->device),
 						mlx5_debugfs_root);
-	debugfs_create_file("vhca_id", 0400, priv->dbg.dbg_root, dev, &vhca_id_fops);
+
 	INIT_LIST_HEAD(&priv->traps);
 
 	err = mlx5_cmd_init(dev);
@@ -2022,6 +2012,8 @@ static int probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err_init_one;
 	}
 
+	mlx5_vhca_debugfs_init(dev);
+
 	pci_save_state(pdev);
 	return 0;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index cfebc110c02f..6d41d2e5a278 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -258,6 +258,7 @@ int mlx5_wait_for_pages(struct mlx5_core_dev *dev, int *pages);
 void mlx5_cmd_flush(struct mlx5_core_dev *dev);
 void mlx5_cq_debugfs_init(struct mlx5_core_dev *dev);
 void mlx5_cq_debugfs_cleanup(struct mlx5_core_dev *dev);
+void mlx5_vhca_debugfs_init(struct mlx5_core_dev *dev);
 
 int mlx5_query_pcam_reg(struct mlx5_core_dev *dev, u32 *pcam, u8 feature_group,
 			u8 access_reg_group);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
index b706f1486504..c45540fe7d9d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
@@ -76,6 +76,7 @@ static int mlx5_sf_dev_probe(struct auxiliary_device *adev, const struct auxilia
 		goto init_one_err;
 	}
 
+	mlx5_vhca_debugfs_init(mdev);
 	return 0;
 
 init_one_err:
-- 
2.44.0


