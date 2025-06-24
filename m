Return-Path: <linux-rdma+bounces-11579-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E119AE647F
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 14:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 400701926CFC
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 12:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9132129C33B;
	Tue, 24 Jun 2025 12:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0WWLIh5Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CFA295522;
	Tue, 24 Jun 2025 12:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750767268; cv=fail; b=mdKBzGbDV8qi+cEYqcRyNWB5G+repufC51YmyYuer439g0DWQJiNIzg1wdLJG9/f3w+Zjki/HFJhYcYw80R+iv+6gOvwsyGj4MFU86losqCBjTM2vb9khsEdJ4YaTIgzUda5v3Zky7MSH1/Kfs6RSlrVCAhWi8RuG64xm9ieZwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750767268; c=relaxed/simple;
	bh=mQk2Ly5n9m40SbR/lHKiR77PH/TeCsNL1ZTwJcUqkL4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N4Rb8+bMkZCv3AOGmcZkkoqgYQkZ/B/FtGq/ZXJHMV4L5nODhuXmYaFWZ3JpukmkWKO81Z2ClmR7efPK2bIaP1kauUCFLi6Xq1eh//3VDJwUXjfG786qKse+f6kfv6i0FAinJm+fZDFe6Mr5oY0mGijkzec8p1DWH4CnvDqIp8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0WWLIh5Q; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXh+kYXWuoTxsgPdeHezVt0vBxYcXrNY0VkT6C72f+M5V4wXSoND4/4HaIzIn7RZVGWMYAyghXjJoll4m35aDbK5WoMO1JA4nMvyMpqXUqDuTfGnw5+ipZc3tL2vBmfdmdth0H9VDkRVOvGnSYh6DcBtkixk4KPIrLLLZBKQLZ5cg9VueHl8o4upvdqKjk3RAgdG4PR9/bYl4rUkXdyJrw06jWMPGmLJ0uDL1bQua8iko6UfeKnQCQ5fi5Yf6p0CxMC42AYgLEm6aYBbOAKidZyHaH8yIc8jx7JgUbMxRFGJr8d+LV0vspZNhwD5HPyXb7sBOrpX+THeyrU/JMReOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3eSJzB60vGpYiLqPNi7GLZsxIOcBeUPgQGPdHEVrBMo=;
 b=JKj9cWd8XdzZbsliZEsWvLkN39BZYr1cXZwc0FBySrez4u4b8QFywF+ysbLIYumb56J1FEN/r6p+F6M6r+wUuVbn+nCvKHZUM9b77D64x8HZKZpUpr1kjqHKmVE0dP2gVfHZlEsXKVpV56ZbE016cspbhgsAsK2hzHJCwHHaR9dYIWu7wdN9d+rg/qsqqZN473tgv2Poz6v4s17Tc9bifPnH1E+qu11fxjJqB0ftBrTYGLGqMiWuJU6IJa0NL/NqkzWlizCEaXnjN44fnFXd0B9XlnKcjqDjNWr8DhepUrsYeytKMSHHHiyD9s50fnmH19AfvcE/XDimHLtOX4A72g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eSJzB60vGpYiLqPNi7GLZsxIOcBeUPgQGPdHEVrBMo=;
 b=0WWLIh5Q0PVXU4XX0SRrdPtPyst8+PGJpv5Dh1gv42rcN9JZjOyT9M46ZF/01dLdYlOOiUX4LBCyRHChTo3xKiLucAfVJEa4gPxTSOon9tVMq8ofTtZOzPEQ175me2kxG/AxW9KJdp44kDz0j/6l6ntHy5K6dwH0lz3vJlfoHMs=
Received: from CH3P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::25)
 by LV9PR12MB9832.namprd12.prod.outlook.com (2603:10b6:408:2f3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Tue, 24 Jun
 2025 12:14:23 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::8d) by CH3P220CA0027.outlook.office365.com
 (2603:10b6:610:1e8::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.16 via Frontend Transport; Tue,
 24 Jun 2025 12:14:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 12:14:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 07:14:23 -0500
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 24 Jun 2025 07:14:18 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, Andrew Boyer <andrew.boyer@amd.com>
Subject: [PATCH v3 12/14] RDMA/ionic: Register device ops for miscellaneous functionality
Date: Tue, 24 Jun 2025 17:43:13 +0530
Message-ID: <20250624121315.739049-13-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624121315.739049-1-abhijit.gangurde@amd.com>
References: <20250624121315.739049-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: abhijit.gangurde@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|LV9PR12MB9832:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f89e711-9329-449d-5931-08ddb318a811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S8uBmDD9Q4bB+wWnmtzqH5mcShsXmvDxC02YEsZ+FXBJ6OXTDPJ5NteBkRdj?=
 =?us-ascii?Q?Zq4BgYgZn64w+PlIeD+eZd46Qfucq0CyezYfA6XvH55ZKZoDM71voEuOJDLA?=
 =?us-ascii?Q?h01VrNmcLXhYmciJ1QE88zhuJj0vFAvyjeZAvcxQrR454X0da0ZzSQjWfDx3?=
 =?us-ascii?Q?rtp4exrxEKsamCLoEfJLV0OgzbpT1hI8iP/3WgtIVvO+8bFKBVFbyWeJd+/+?=
 =?us-ascii?Q?tw7kM0/rzjo2Wh9oJPQwjcFIcGm0pp+CJ64xrGgGtoeWxnlMgZaeO2oZFWst?=
 =?us-ascii?Q?9Q7eo/taaloXdZwEMCNDgfvPsgorLH8Gpnmq/aB2pK1Zb8yH88Pwx2txUgAe?=
 =?us-ascii?Q?kMMcyX+9idpZb1rVLQg8DB2tTj1CeDHBu+jEzeVNMveCoLb5D1iqpzte48tl?=
 =?us-ascii?Q?rlnoSoLZnAEPFm1xYdlIAIfk3RQ8cwuwms4rTvJuaYN2c3JZ5X854mbvHuB8?=
 =?us-ascii?Q?zVn1MFPrfu2MYHH3vOuMM6qjQBJiqYj7tWDPLzNBx896IiuVSXe9A2tDwptG?=
 =?us-ascii?Q?xTw7/YG9p+KQG5UOW5bir1Hs1akjcmWgs2NjD9AobPo6UEQ27AwBZi3nuiJc?=
 =?us-ascii?Q?fYU4WtoBiyiZlD1BG5yntzlXVFk7vUgsw93+8e4QMusepCtyb92aiPKUwO1h?=
 =?us-ascii?Q?eD9q2vkynQKlpBNfRZIacuSV4pQuWFgvtrIVrlDnr4VxgItaDH+8t+388Wmk?=
 =?us-ascii?Q?PuT6UQf4xHOvdR8BaWSfV8zHJzidB/GIV6x7SVxo6Rhdg65JbYkb6GryqSBL?=
 =?us-ascii?Q?aZv7gKSaHV3FEjS3+W2Pzs8H+f4Fq1x6qUDGxT/y8po3lsZQlgSqk3xBh2LO?=
 =?us-ascii?Q?2y1IKTaJ3DNkz1WL5CxzqO7uDfPGKNF+lyr8pqhl3/pt21++Jsw2U02B7EG0?=
 =?us-ascii?Q?YFU6kC7I6StbZG2jUMwYTEGNvABYDPr+5ByCR0uKSDjV7rPF4LJJ7pDNIY4P?=
 =?us-ascii?Q?t/RkTCtXOwWZretmVGspUX7WMVtV90nntRChWHaygofYIsZhv93vfF4OoLDF?=
 =?us-ascii?Q?p2AbFFLdtWthcQcIY2hWELmvUDxFcpGAhuXfDD1MExjFe0KZdcm9dDdPz2jJ?=
 =?us-ascii?Q?8wC5T/IC9aiJAaAv7TqqLjMybzRoNZaF2louLRC7MHu+RDbWfhGTlxU8nmN6?=
 =?us-ascii?Q?6AKaXBteFY4e4iVedOyHMa2q9g+VwpHR/PM3DiiPKTVhKg/pM1SvRrpVPNkY?=
 =?us-ascii?Q?u1TuVeZt5LSRR/yhXxpJi4da4xJkw4iobejWm+4WXBAN1PpKpo+bA//GlyJd?=
 =?us-ascii?Q?KAyry2AuE6+yMmfPxV4yWcs7+6SCiPjPANxWErupczGx68nlmBEagH1BMJHh?=
 =?us-ascii?Q?T1A8X3mOGwnKP2fTfmT3FEKaOBjaVb/gQRI8ofpI4xIIxTVFxaarpWuhU8Uw?=
 =?us-ascii?Q?Ax3ETDkdfs6ht65PKwisnKduXNEU8hMxVNxRv2bXAZsy9VYi77+QTMpRRv6k?=
 =?us-ascii?Q?L8adQPOb8tA9b+Wn7Arw0sBxCosEl5wvlGJMlkLkK2tRs9CooHvAVGWhq/63?=
 =?us-ascii?Q?nr8Ib78hGEJ6og0T9LImQ5AdBJLCOe7p1iF8j/s0t0RmHXSal1rjMw6s+w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 12:14:23.6243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f89e711-9329-449d-5931-08ddb318a811
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9832

Implement idbdev ops for device and port information.

Co-developed-by: Andrew Boyer <andrew.boyer@amd.com>
Signed-off-by: Andrew Boyer <andrew.boyer@amd.com>
Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
v2->v3
  - Registered main ib ops at once
  - Removed uverbs_cmd_mask

 drivers/infiniband/hw/ionic/ionic_ibdev.c   | 210 ++++++++++++++++++++
 drivers/infiniband/hw/ionic/ionic_ibdev.h   |   5 +
 drivers/infiniband/hw/ionic/ionic_lif_cfg.c |  10 +
 drivers/infiniband/hw/ionic/ionic_lif_cfg.h |   2 +
 4 files changed, 227 insertions(+)

diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.c b/drivers/infiniband/hw/ionic/ionic_ibdev.c
index d719994cfe38..2d5e04d796bb 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.c
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.c
@@ -3,7 +3,11 @@
 
 #include <linux/module.h>
 #include <linux/printk.h>
+#include <linux/pci.h>
+#include <linux/irq.h>
 #include <net/addrconf.h>
+#include <rdma/ib_addr.h>
+#include <rdma/ib_mad.h>
 
 #include "ionic_ibdev.h"
 
@@ -15,6 +19,201 @@ MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS("NET_IONIC");
 
+static int ionic_query_device(struct ib_device *ibdev,
+			      struct ib_device_attr *attr,
+			      struct ib_udata *udata)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibdev);
+
+	addrconf_ifid_eui48((u8 *)&attr->sys_image_guid,
+			    ionic_lif_netdev(dev->lif_cfg.lif));
+	attr->max_mr_size = dev->lif_cfg.npts_per_lif * PAGE_SIZE / 2;
+	attr->page_size_cap = dev->lif_cfg.page_size_supported;
+
+	attr->vendor_id = to_pci_dev(dev->lif_cfg.hwdev)->vendor;
+	attr->vendor_part_id = to_pci_dev(dev->lif_cfg.hwdev)->device;
+
+	attr->hw_ver = ionic_lif_asic_rev(dev->lif_cfg.lif);
+	attr->fw_ver = 0;
+	attr->max_qp = dev->lif_cfg.qp_count;
+	attr->max_qp_wr = IONIC_MAX_DEPTH;
+	attr->device_cap_flags =
+		IB_DEVICE_MEM_WINDOW |
+		IB_DEVICE_MEM_MGT_EXTENSIONS |
+		IB_DEVICE_MEM_WINDOW_TYPE_2B |
+		0;
+	attr->max_send_sge =
+		min(ionic_v1_send_wqe_max_sge(dev->lif_cfg.max_stride, 0, false),
+		    IONIC_SPEC_HIGH);
+	attr->max_recv_sge =
+		min(ionic_v1_recv_wqe_max_sge(dev->lif_cfg.max_stride, 0, false),
+		    IONIC_SPEC_HIGH);
+	attr->max_sge_rd = attr->max_send_sge;
+	attr->max_cq = dev->lif_cfg.cq_count / dev->lif_cfg.udma_count;
+	attr->max_cqe = IONIC_MAX_CQ_DEPTH - IONIC_CQ_GRACE;
+	attr->max_mr = dev->lif_cfg.nmrs_per_lif;
+	attr->max_pd = IONIC_MAX_PD;
+	attr->max_qp_rd_atom = IONIC_MAX_RD_ATOM;
+	attr->max_ee_rd_atom = 0;
+	attr->max_res_rd_atom = IONIC_MAX_RD_ATOM;
+	attr->max_qp_init_rd_atom = IONIC_MAX_RD_ATOM;
+	attr->max_ee_init_rd_atom = 0;
+	attr->atomic_cap = IB_ATOMIC_GLOB;
+	attr->masked_atomic_cap = IB_ATOMIC_GLOB;
+	attr->max_mw = dev->lif_cfg.nmrs_per_lif;
+	attr->max_mcast_grp = 0;
+	attr->max_mcast_qp_attach = 0;
+	attr->max_ah = dev->lif_cfg.nahs_per_lif;
+	attr->max_fast_reg_page_list_len = dev->lif_cfg.npts_per_lif / 2;
+	attr->max_pkeys = IONIC_PKEY_TBL_LEN;
+
+	return 0;
+}
+
+static int ionic_query_port(struct ib_device *ibdev, u32 port,
+			    struct ib_port_attr *attr)
+{
+	struct net_device *ndev;
+
+	if (port != 1)
+		return -EINVAL;
+
+	ndev = ib_device_get_netdev(ibdev, port);
+
+	if (netif_running(ndev) && netif_carrier_ok(ndev)) {
+		attr->state = IB_PORT_ACTIVE;
+		attr->phys_state = IB_PORT_PHYS_STATE_LINK_UP;
+	} else if (netif_running(ndev)) {
+		attr->state = IB_PORT_DOWN;
+		attr->phys_state = IB_PORT_PHYS_STATE_POLLING;
+	} else {
+		attr->state = IB_PORT_DOWN;
+		attr->phys_state = IB_PORT_PHYS_STATE_DISABLED;
+	}
+
+	attr->max_mtu = iboe_get_mtu(ndev->max_mtu);
+	attr->active_mtu = min(attr->max_mtu, iboe_get_mtu(ndev->mtu));
+	attr->gid_tbl_len = IONIC_GID_TBL_LEN;
+	attr->ip_gids = true;
+	attr->port_cap_flags = 0;
+	attr->max_msg_sz = 0x80000000;
+	attr->pkey_tbl_len = IONIC_PKEY_TBL_LEN;
+	attr->max_vl_num = 1;
+	attr->subnet_prefix = 0xfe80000000000000ull;
+
+	dev_put(ndev);
+
+	return ib_get_eth_speed(ibdev, port,
+				&attr->active_speed,
+				&attr->active_width);
+}
+
+static enum rdma_link_layer ionic_get_link_layer(struct ib_device *ibdev,
+						 u32 port)
+{
+	return IB_LINK_LAYER_ETHERNET;
+}
+
+static int ionic_query_pkey(struct ib_device *ibdev, u32 port, u16 index,
+			    u16 *pkey)
+{
+	if (port != 1)
+		return -EINVAL;
+
+	if (index != 0)
+		return -EINVAL;
+
+	*pkey = IB_DEFAULT_PKEY_FULL;
+
+	return 0;
+}
+
+static int ionic_modify_device(struct ib_device *ibdev, int mask,
+			       struct ib_device_modify *attr)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibdev);
+
+	if (mask & ~IB_DEVICE_MODIFY_NODE_DESC)
+		return -EOPNOTSUPP;
+
+	if (mask & IB_DEVICE_MODIFY_NODE_DESC)
+		memcpy(dev->ibdev.node_desc, attr->node_desc,
+		       IB_DEVICE_NODE_DESC_MAX);
+
+	return 0;
+}
+
+static int ionic_get_port_immutable(struct ib_device *ibdev, u32 port,
+				    struct ib_port_immutable *attr)
+{
+	if (port != 1)
+		return -EINVAL;
+
+	attr->core_cap_flags = RDMA_CORE_PORT_IBA_ROCE_UDP_ENCAP;
+
+	attr->pkey_tbl_len = IONIC_PKEY_TBL_LEN;
+	attr->gid_tbl_len = IONIC_GID_TBL_LEN;
+	attr->max_mad_size = IB_MGMT_MAD_SIZE;
+
+	return 0;
+}
+
+static void ionic_get_dev_fw_str(struct ib_device *ibdev, char *str)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibdev);
+
+	ionic_lif_fw_version(dev->lif_cfg.lif, str, IB_FW_VERSION_NAME_MAX);
+}
+
+static const struct cpumask *ionic_get_vector_affinity(struct ib_device *ibdev,
+						       int comp_vector)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibdev);
+
+	if (comp_vector < 0 || comp_vector >= dev->lif_cfg.eq_count)
+		return NULL;
+
+	return irq_get_affinity_mask(dev->eq_vec[comp_vector]->irq);
+}
+
+static ssize_t hw_rev_show(struct device *device, struct device_attribute *attr,
+			   char *buf)
+{
+	struct ionic_ibdev *dev =
+		rdma_device_to_drv_device(device, struct ionic_ibdev, ibdev);
+
+	return sysfs_emit(buf, "0x%x\n", ionic_lif_asic_rev(dev->lif_cfg.lif));
+}
+static DEVICE_ATTR_RO(hw_rev);
+
+static ssize_t hca_type_show(struct device *device,
+			     struct device_attribute *attr, char *buf)
+{
+	struct ionic_ibdev *dev =
+		rdma_device_to_drv_device(device, struct ionic_ibdev, ibdev);
+
+	return sysfs_emit(buf, "%s\n", dev->ibdev.node_desc);
+}
+static DEVICE_ATTR_RO(hca_type);
+
+static struct attribute *ionic_rdma_attributes[] = {
+	&dev_attr_hw_rev.attr,
+	&dev_attr_hca_type.attr,
+	NULL
+};
+
+static const struct attribute_group ionic_rdma_attr_group = {
+	.attrs = ionic_rdma_attributes,
+};
+
+static void ionic_disassociate_ucontext(struct ib_ucontext *ibcontext)
+{
+	/*
+	 * Dummy define disassociate_ucontext so that it does not
+	 * wait for user context before cleaning up hw resources.
+	 */
+}
+
 static const struct ib_device_ops ionic_dev_ops = {
 	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_IONIC,
@@ -50,6 +249,17 @@ static const struct ib_device_ops ionic_dev_ops = {
 	.poll_cq = ionic_poll_cq,
 	.req_notify_cq = ionic_req_notify_cq,
 
+	.query_device = ionic_query_device,
+	.query_port = ionic_query_port,
+	.get_link_layer = ionic_get_link_layer,
+	.query_pkey = ionic_query_pkey,
+	.modify_device = ionic_modify_device,
+	.get_port_immutable = ionic_get_port_immutable,
+	.get_dev_fw_str = ionic_get_dev_fw_str,
+	.get_vector_affinity = ionic_get_vector_affinity,
+	.device_group = &ionic_rdma_attr_group,
+	.disassociate_ucontext = ionic_disassociate_ucontext,
+
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, ionic_ctx, ibctx),
 	INIT_RDMA_OBJ_SIZE(ib_pd, ionic_pd, ibpd),
 	INIT_RDMA_OBJ_SIZE(ib_ah, ionic_ah, ibah),
diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.h b/drivers/infiniband/hw/ionic/ionic_ibdev.h
index 8020aca1b13f..0d35fe021b87 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.h
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.h
@@ -32,6 +32,11 @@
 #define IONIC_AQ_COUNT 4
 #define IONIC_EQ_ISR_BUDGET 10
 #define IONIC_EQ_WORK_BUDGET 1000
+#define IONIC_MAX_RD_ATOM 16
+#define IONIC_PKEY_TBL_LEN 1
+#define IONIC_GID_TBL_LEN 256
+
+#define IONIC_SPEC_HIGH 8
 #define IONIC_MAX_PD 1024
 #define IONIC_SPEC_HIGH 8
 #define IONIC_SQCMB_ORDER 5
diff --git a/drivers/infiniband/hw/ionic/ionic_lif_cfg.c b/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
index 386af7d351d7..59312d060751 100644
--- a/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
+++ b/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
@@ -116,3 +116,13 @@ int ionic_version_check(const struct device *dev, struct ionic_lif *lif)
 
 	return 0;
 }
+
+void ionic_lif_fw_version(struct ionic_lif *lif, char *str, size_t len)
+{
+	strscpy(str, lif->ionic->idev.dev_info.fw_version, len);
+}
+
+u8 ionic_lif_asic_rev(struct ionic_lif *lif)
+{
+	return lif->ionic->idev.dev_info.asic_rev;
+}
diff --git a/drivers/infiniband/hw/ionic/ionic_lif_cfg.h b/drivers/infiniband/hw/ionic/ionic_lif_cfg.h
index b095637c54cf..f92d8aee5af9 100644
--- a/drivers/infiniband/hw/ionic/ionic_lif_cfg.h
+++ b/drivers/infiniband/hw/ionic/ionic_lif_cfg.h
@@ -61,5 +61,7 @@ struct ionic_lif_cfg {
 int ionic_version_check(const struct device *dev, struct ionic_lif *lif);
 void ionic_fill_lif_cfg(struct ionic_lif *lif, struct ionic_lif_cfg *cfg);
 struct net_device *ionic_lif_netdev(struct ionic_lif *lif);
+void ionic_lif_fw_version(struct ionic_lif *lif, char *str, size_t len);
+u8 ionic_lif_asic_rev(struct ionic_lif *lif);
 
 #endif /* _IONIC_LIF_CFG_H_ */
-- 
2.43.0


