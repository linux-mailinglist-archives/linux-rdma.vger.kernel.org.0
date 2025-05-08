Return-Path: <linux-rdma+bounces-10143-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D83AAF27B
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 07:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7B577BCF62
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 05:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6362288D3;
	Thu,  8 May 2025 05:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZjHwaUwi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F49A2153D2;
	Thu,  8 May 2025 05:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746680502; cv=fail; b=eqJunvFwBq5ftkxb8vqS9DCVIZ9IUDtoirGasKfn1b/5on99QLxP1Pxfa3N8fsWp2A6zOmOfut72B/F9a+BZs2TeUgBrLGQ8oBOw6ku7nJNFG0ozivhJevVYPeD9+9PaZHH6NNQi+HbhQ6/yeO2qjOEI1eGAMILjwpnNiQMmmQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746680502; c=relaxed/simple;
	bh=aI6N7TjAiDQxGrHpQdPjj30src2vNQDwiNZ4U9BBnBU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P9mUwuZXlPZPisTdL2E6InN+oG+wV9iNjdAej3t4fSWib7wKOeLzOt3K89U2uTlgvzplRpP9IB/hQMmQ3DJxCxb7NJYdojPvAA+sjeZIDrwGadlN4L7AGf0Ry4PVfJ4AMiuGQ4cXP5COJRrr6iPKjapsFY7mK+tt63wywlMyB6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZjHwaUwi; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wvqQbcbzLV0ukjxvSQAj17ZXPgLbet8wyp2xNZgnm2CbRGKDj91pbxR+cO5/6Fi80tnwrlFLF5leZKKUJzQHQMAvj6e+C9hb6DA17nCb6GMDBrEhbDqTzVKKNgQWxJ4svpZUBfnyHJfF3NT2IavA/vkTcjm04KfiMYvr4IOAkTm1g6M1rrN8okInDEqDjRpL4oDa5qQrs67mWoPCnWXlmF3ARWOKs1gC0WtKIk3lXpEsyLMp3AjZDdw06C4TRmucokE3IKwZJSKD0yT7LvkqAKD4LSezh0EOS4e1yzPp0uTXKkDGXkYSQvzoGNVrZpDBsJlguEuKaYybdcHygi6Clw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ua3JvKiR60XdGqV7m5mzp4wc0VjcDCorLobviydKFP0=;
 b=MR98O+l0aMS3IKLY688ym31q+gkBm3pdxTqZDKUyDKC4luPitknYBxIQkIN3uix+BlZogtJEbgPRuuHSxbIfQF7i/ptaU9MUXk/Eh7d9/CNqdvjEZFxwDLHDNDVoPS8vnZs1D0W3vRNeqOpcngS8LcBzFXcYd7vJfVTEpg5aul6vf4G3XH2xCrM9TypRXpi2uwj12srNrjuc69w1rKzHsZA+aN/o0egNnA7Zj5d3jPMnp+p0YZmh7DQSSPC4YkO1czPX67GqCcDFNhL8qNZDN4qq6xgc6GFlcVAkZx/NNYKtiG73VEcWF6Zl6UC1jeYP+foTvTavtVAX9sZ514Es5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ua3JvKiR60XdGqV7m5mzp4wc0VjcDCorLobviydKFP0=;
 b=ZjHwaUwiVJehJ2Kz1bider/O+J/GP2wH8eWWzXG3gaPro7tHe8rUsvQvXmOX+ciZYalDpioHq0Og3o6qAywTBcAjvIKkpBe5c9ARQK4Dj/p5h0oJa0xGT0jWTpVvnlYFmbjvqgR5uU4xAIACq7dzj9vyAm8hGINVRBfBApr/I3Y=
Received: from BL1PR13CA0001.namprd13.prod.outlook.com (2603:10b6:208:256::6)
 by CH3PR12MB8970.namprd12.prod.outlook.com (2603:10b6:610:176::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Thu, 8 May
 2025 05:01:30 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::4f) by BL1PR13CA0001.outlook.office365.com
 (2603:10b6:208:256::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.19 via Frontend Transport; Thu,
 8 May 2025 05:01:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 05:01:30 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 00:01:29 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 00:01:29 -0500
Received: from xhdipdslab61.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 8 May 2025 00:01:25 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, Andrew Boyer <andrew.boyer@amd.com>
Subject: [PATCH v2 12/14] RDMA/ionic: Register device ops for miscellaneous functionality
Date: Thu, 8 May 2025 10:29:55 +0530
Message-ID: <20250508045957.2823318-13-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250508045957.2823318-1-abhijit.gangurde@amd.com>
References: <20250508045957.2823318-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|CH3PR12MB8970:EE_
X-MS-Office365-Filtering-Correlation-Id: 79deb0c7-df16-4d97-65ad-08dd8ded653e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|82310400026|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d2p/W2V9p1nyOIDXZHHHuecYn0sSp/G7kMIz3quVaCuUKk6F/xX1/ehlDEkL?=
 =?us-ascii?Q?G8uZNEunIY6dSMUOI7xes39HwruMtz4huTL0W6Slp2M8sVl0+Xj3D0qb7H7+?=
 =?us-ascii?Q?VyKXizYJHJazuN9SfVramDA3LrezHjS8vuo2vwtOgsU13s+oHt/xw5KD2r/y?=
 =?us-ascii?Q?VxpfgUGYAlIl0geYoggBZQY77gRcyJWAn92tU/i+a1TRmeii4sZOI6JX6Myt?=
 =?us-ascii?Q?1NAHyZABgiuXCGplMW4Fc+7uCcL1rgHMVHZXE5eglcCJK57L4lqmf2iF/yiI?=
 =?us-ascii?Q?9uKne7dSFSa0g3rRfRrSJY5ChfLzDSMP5r25wk9tjRgMy3Mpztld74j1YMYK?=
 =?us-ascii?Q?+MdDwyG6kfIsuIKpOPmtTeUGRB8I/oDNWdQLH3kVweW7wYgCW9xf//+N8XQ1?=
 =?us-ascii?Q?hmA8wHT7fu+lKMWUea9Ub0/hUUPGp+K+4VLLyrD1HCHQj0UDToToQG1SEjr+?=
 =?us-ascii?Q?OtzQgsRGDS4ouUqHkTn5+DVz/KVBRsUqmyMbgPOMU6Hd8JlFhqCt6g+CDxdy?=
 =?us-ascii?Q?te/xj4QD31btnkCWrDWm3wotTiC+Zye5ZtHVej/Fi0Vjkkh77+/tIHaKqAtm?=
 =?us-ascii?Q?OR8S7xwsGbh+YTjq7DO6vBByz8+4XrY7n9h9Rf1dPPJhJI39oUG07qFAFkpG?=
 =?us-ascii?Q?qHYriID7rOzebFh1m3WMOtrjyyA7qXOUjwcCDcMa6DrSui+Kt5T8RnxL5IMF?=
 =?us-ascii?Q?VIRv6mnvdeSGbXlMN8HFbvF2eqWpscSQj8bHlW3bUCptSgLFHLoZiaKyKl0N?=
 =?us-ascii?Q?GzjkR9wYAozfzLnqrbtkkcB1OIbqcSRiCCqqDbJOP0oGh44ft0IupWXGbgCo?=
 =?us-ascii?Q?z5n6eAfoeXE8pHd0WLkrcaLZPNPm0dv0SZzs6YTgorklz9gK6cx5vvoBFqGm?=
 =?us-ascii?Q?d9w1tsDgVkbzOTCpjFF8z0sCTUXF9IUKSArB/cAAsUUh+8uv2whmLjjs2U30?=
 =?us-ascii?Q?1NJpxV4Vg03xDdyzUDwvXFAkxff9Mr2OtoXhuUprFwf/0YzLBTTSqOYxBDYu?=
 =?us-ascii?Q?EMMvgDljGd1tiz+BQFAHHsi4dpTd2bDtnDjOz8r7NH512C0wAXN1lq4uNHcT?=
 =?us-ascii?Q?xB9HElgLkK30EbArovAcF6rrZk15Z6oMkJ710Fp33JlT2EQuPGDOMbKrOt47?=
 =?us-ascii?Q?wWrfnTJpsHsSzKbxK+cmmDXIrL+270WuGufd/sM7zVsbNw1vaNQ7SEG5df1+?=
 =?us-ascii?Q?Er+CV29iRzd2MJOAqQ7dQTiIaSQlquU0JfWXblVvmYrVTJ9bLUSjONxd1KQa?=
 =?us-ascii?Q?LD6CCbK/dVL16qCQKFMRlrn8eBG6jHnx/0BIPHGP1E0ytgqn5h/kCV+rk8Qj?=
 =?us-ascii?Q?/iJ38Nsmzqy8Cpa9nwhPRGZp3pqaDIRTuo0+VhHMuLp1Mlz6q+mY/P+Ump1a?=
 =?us-ascii?Q?NhGPCcT6uQXVIBqKwem0j4kFuuKK7XDbp8NEwd+3wKkGcL11a4fXVvNEkFJH?=
 =?us-ascii?Q?JXoGIn0YjfcRGY37rasx5zY1T++O0Gen8L2NmWKkEV97AEwkGzca7s0Q+gPV?=
 =?us-ascii?Q?yTfhQMJZuaGHFC0S5cjGEE1WS/l7cOFfIxpNZYPSiVXojq8L33zMAV4ibA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(82310400026)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 05:01:30.1373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79deb0c7-df16-4d97-65ad-08dd8ded653e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8970

Implement idbdev ops for device and port information.

Co-developed-by: Andrew Boyer <andrew.boyer@amd.com>
Signed-off-by: Andrew Boyer <andrew.boyer@amd.com>
Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 drivers/infiniband/hw/ionic/ionic_ibdev.c   | 224 ++++++++++++++++++++
 drivers/infiniband/hw/ionic/ionic_ibdev.h   |   5 +
 drivers/infiniband/hw/ionic/ionic_lif_cfg.c |  10 +
 drivers/infiniband/hw/ionic/ionic_lif_cfg.h |   2 +
 4 files changed, 241 insertions(+)

diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.c b/drivers/infiniband/hw/ionic/ionic_ibdev.c
index e7c5b15b27cf..1fe58ca2238f 100644
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
 
@@ -33,6 +37,219 @@ void ionic_port_event(struct ionic_ibdev *dev, enum ib_event_type event)
 	ib_dispatch_event(&ev);
 }
 
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
+	attr->kernel_cap_flags = IBK_LOCAL_DMA_LKEY;
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
+static const struct ib_device_ops ionic_dev_ops = {
+	.owner = THIS_MODULE,
+	.driver_id = RDMA_DRIVER_IONIC,
+	.uverbs_abi_ver = IONIC_ABI_VERSION,
+	.query_device = ionic_query_device,
+	.query_port = ionic_query_port,
+	.get_link_layer = ionic_get_link_layer,
+	.query_pkey = ionic_query_pkey,
+	.modify_device = ionic_modify_device,
+
+	.get_port_immutable = ionic_get_port_immutable,
+	.get_dev_fw_str = ionic_get_dev_fw_str,
+	.get_vector_affinity = ionic_get_vector_affinity,
+	.device_group = &ionic_rdma_attr_group,
+	.disassociate_ucontext = ionic_disassociate_ucontext,
+};
+
 static int ionic_init_resids(struct ionic_ibdev *dev)
 {
 	int rc;
@@ -174,6 +391,13 @@ static struct ionic_ibdev *ionic_create_ibdev(struct ionic_aux_dev *ionic_adev)
 	if (rc)
 		goto err_admin;
 
+	ibdev->uverbs_cmd_mask =
+		BIT_ULL(IB_USER_VERBS_CMD_GET_CONTEXT)		|
+		BIT_ULL(IB_USER_VERBS_CMD_QUERY_DEVICE)		|
+		BIT_ULL(IB_USER_VERBS_CMD_QUERY_PORT)		|
+		0;
+
+	ib_set_device_ops(&dev->ibdev, &ionic_dev_ops);
 	ionic_datapath_setops(dev);
 	ionic_controlpath_setops(dev);
 
diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.h b/drivers/infiniband/hw/ionic/ionic_ibdev.h
index c476f3781090..446cb8d5e334 100644
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
index a02eb2f5bd45..a4246de26b9b 100644
--- a/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
+++ b/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
@@ -119,3 +119,13 @@ int ionic_version_check(const struct device *dev, struct ionic_lif *lif)
 
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
2.34.1


