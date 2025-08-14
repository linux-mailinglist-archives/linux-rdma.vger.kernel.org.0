Return-Path: <linux-rdma+bounces-12743-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AA9B25B0F
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 07:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AFF617A7AA
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 05:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F1324BBFD;
	Thu, 14 Aug 2025 05:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fKcVoD6L"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C866022A7F2;
	Thu, 14 Aug 2025 05:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755150026; cv=fail; b=G8Z8iyaDJZO1JUBqokluRjM1EDKsOnNDVy2XO14rnCeienkRePNwiZPO2RGSSuJvXUXzuce7Fs+79VcPrQcIIJJdeVLYGG9SOjiBTsmmLi+AJQf0FyKdgGNcfMvg7WDhqg/3yWByzAbcouW33R1zb7dmaz58t1UgNDBlAj8rVA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755150026; c=relaxed/simple;
	bh=ndxxTUPEeYsF7NPbYQemEFqbn6mCssCMtA4w9R2N8VM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ET56n6mC6DB1q5HM9I7txw7UQ5l8X0ze9bng14VsrG2Do2quVoC2gGhGjSySonh7vueA1VgwBPYNTn+BhyJXvrqusk8Uhpy6YPwJKhN7bfm/SCaCO+w3mGujfzltotM6z0YqFF0cMLQOpygcFQVxCBX+dLrEptBNjzn1lSFVflE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fKcVoD6L; arc=fail smtp.client-ip=40.107.102.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eohyxqG+GaW7X1IbmBdkWnBFtovjR92UpH2atSVScx3yANDo0zrkKpMW/BRloOYPkyXBecUTxe0sjfflutZXXbPmdhlTDMnsS/C9mGhX+yl849obYVdNSAuv1M43IHJGQkERrRW+9+t5JNFzYfgj5TFj+z03SHKcqy1bGIC43ACnHn48uhyhT3oY/Nf8YooT2O0orSc1ndADWIW5YnksUNkYDbncaDjmsiOQu9P/dmeuBoKNpkU4eMeMmNIz35QFw9rRgoG+7o7nbJSLMYxCoUrHmGPxqqE3Fxiow3zB7o7cT0PqSuwGbLr5EfmhQ8kl3x1uv+oTgqW6NAiT2JMILQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAhqHgwhnrhQN3uUHEskfGf017XJKGUDxArdEeiDvdI=;
 b=wWodmAyvYlaqQM4Jk2ANiQ9V1hvZMqLWX/FY8JOcMZIHv37DtmHQgIuAoqPpXlVtT3vlruUik8liR7X2dqhh4T3xIX3aBEZYY6B9wTxYufuJ5nT5AiuZvGXGA6tVUzGGX6ZEtVVrSbX7PRB+R56QG/D+y006cVJaUi9EK1enJR9ZqetzAtu0KP9BuFLvHcerENJkEBbieYwSk3op4ZOyKSSWkq1o56IwRsIr6xqa613MpL6hlxhkWsUdBZqxz8ppa00KF1ffPMyr6d/lPUDN8kRWPEDghOupF8Wzqp/jCH/Du/nG+6oCtrTUGncf+g0dx29HPNIF2/+ILql2B7CaLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAhqHgwhnrhQN3uUHEskfGf017XJKGUDxArdEeiDvdI=;
 b=fKcVoD6LZon/M31WLsmGEH+pN4eH0CmzScaHELt5z+aaGqqsLXvKk14+u8bSI9uNBUFublQK83NOznDHOWw1uLVFCHPJKU9PPhYcUa74DQA86ZY5mPNIDiIKdnuNM+jGwuveCIjc+G4SvAMohWnmUUZmRu3p3uQNYNyPpifBb64=
Received: from SJ0PR03CA0187.namprd03.prod.outlook.com (2603:10b6:a03:2ef::12)
 by PH7PR12MB9254.namprd12.prod.outlook.com (2603:10b6:510:308::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Thu, 14 Aug
 2025 05:40:16 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::e9) by SJ0PR03CA0187.outlook.office365.com
 (2603:10b6:a03:2ef::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.16 via Frontend Transport; Thu,
 14 Aug 2025 05:40:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 05:40:16 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 00:40:12 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 00:40:12 -0500
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 14 Aug 2025 00:40:08 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <brett.creeley@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <corbet@lwn.net>, <jgg@ziepe.ca>,
	<leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <sln@onemain.com>, <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, Andrew Boyer <andrew.boyer@amd.com>
Subject: [PATCH v5 12/14] RDMA/ionic: Register device ops for miscellaneous functionality
Date: Thu, 14 Aug 2025 11:08:58 +0530
Message-ID: <20250814053900.1452408-13-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250814053900.1452408-1-abhijit.gangurde@amd.com>
References: <20250814053900.1452408-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: abhijit.gangurde@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|PH7PR12MB9254:EE_
X-MS-Office365-Filtering-Correlation-Id: b87db750-e44a-4c71-51f1-08dddaf50c23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0PD8SUZu/mNom+Uod1zSaEO2UTLrjI1+YFPBnPw25Cj81Z2AO9pq0eRFM3tb?=
 =?us-ascii?Q?x0s1xHrUFh7pKToEG+FwYhHwzwZJIJpph7NIKgvY/iJT8jCdYiXgTsP4ZMlQ?=
 =?us-ascii?Q?pYTbcla8Nw4Mq1M9Sq8qURkI8Wj1NJfCfZ0B7xyCn76DF4zHiN5ljcXjvHjO?=
 =?us-ascii?Q?rSuS7Ah3xBvd6FgGNf7uVvznAFuFcrlUFx1BhBJLwlA1/NH683EqQjPhpVni?=
 =?us-ascii?Q?9ULo0rETj4m9MLfc7ls4IDqU0JvFm3fAO0x7uogT/+KuljUFvL0KEfUADTJg?=
 =?us-ascii?Q?ZLcHG4XjhwsbMUaDMWnWY01NjJdil03oPXTH8c/jI5gmoRWGqkcnXMAG5ePh?=
 =?us-ascii?Q?sAndmKfBgGV//6Z7PJys9DDpnxzg1C/NpNdD6FK93IESkp+Gm+3omYkfQIqs?=
 =?us-ascii?Q?mi/DtITAa9soxFhpegN7rCcxemxDxwMJUHlJEx0DCUZpK9YW30oRti6UkkZm?=
 =?us-ascii?Q?QTPZk/cgmLiQYherX1EJ84vpjlNVEdz7dlZVGyq6LiZeH2AqtkZY/EUVWcoo?=
 =?us-ascii?Q?85EM3THCXg7d60hpNc5Pkdg5FWJ964Mqq4WFhw0O41eVl9wYiOzafipFMgvl?=
 =?us-ascii?Q?+ubrjnDK77fhMbP2pKkp7Uab1JE4wdMkisUvYiT6c1JnDEQAeuz/9cNZhS68?=
 =?us-ascii?Q?Y49q45bp3i87sN+TfWSq1DOZYzFmyXN3FjUiYM1D//NU9gQCAx+gab2JO9hE?=
 =?us-ascii?Q?d34ffTs/hz7n1UKM8AqzMP/GlRDeWpznjrHqLaOqDiYgy3D5zRLFUtML2QRt?=
 =?us-ascii?Q?uYbZU3oDupOy6r18xwJ6Q6NHeCfFEmGSq0bY+CTJ/DFWTpvDDkaaTMjG1y9R?=
 =?us-ascii?Q?VkRhFbMnf77sEcS4cdZKhrMPR9gct5LFCGFuZaEGflQEcPCWAvb43xRsIbGa?=
 =?us-ascii?Q?1hsDISA/ii+XPjW5YGygcYqlFF76o5VBfasHab395OFcLkts6os8Ki39A36J?=
 =?us-ascii?Q?bU6oRcancvNfO7O3RZzholzmfOE+J5ITz3vrNRxwtlWHhW72VxwbVaQVLdq5?=
 =?us-ascii?Q?128fEz0o2CEy4BUaGDjzG7nt3j/UqlLYbVhwdrkvYtK4TX2B37ZqJ/8BlNSY?=
 =?us-ascii?Q?Yp1uTyT3VDzc60+SZ9MeyELZ8Zge4yekjtLc04C2fU9XAi9IaZIjx4xtowlM?=
 =?us-ascii?Q?HKqQbr97FP5Sj/dBIlSiHPhwqJYxUqwfXrbrXaqVH8rk0Rpbuvr7X2Jz+Kpv?=
 =?us-ascii?Q?yeFQdKecOjSQ8XYyruSfNkIWnHvr/FNlUkyFujV6LjUGZu0JZEmn1zIKcsPH?=
 =?us-ascii?Q?lcJCC6KaHsP8SuxMrvfEDMsQELQr8PfTxSwV8RW390gASPc6UDp+BXbGaxP7?=
 =?us-ascii?Q?RQXVshyDBjCIUf93by/jOlpm+NkIndZmnzIhQvim5CiMih9lINKTD6G9GWH0?=
 =?us-ascii?Q?aFTw036TLbSfvW4rjKRKPjTLuRDME9uwI7j3o4/Rms0GpfGmZhp2wcJCOdOC?=
 =?us-ascii?Q?oHy/iMKcf+qS/LE067eKDFktP1DNPopDxbjCGGyBLmgtGOKknWFUp789TMlA?=
 =?us-ascii?Q?oYPRzAt0ylFjwdtRyRD1yu6V14xECOrTpSLz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 05:40:16.0696
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b87db750-e44a-4c71-51f1-08dddaf50c23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9254

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

 drivers/infiniband/hw/ionic/ionic_ibdev.c   | 212 ++++++++++++++++++++
 drivers/infiniband/hw/ionic/ionic_ibdev.h   |   5 +
 drivers/infiniband/hw/ionic/ionic_lif_cfg.c |  10 +
 drivers/infiniband/hw/ionic/ionic_lif_cfg.h |   2 +
 4 files changed, 229 insertions(+)

diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.c b/drivers/infiniband/hw/ionic/ionic_ibdev.c
index ab080d945a13..84db48ba357f 100644
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
 
@@ -15,6 +19,203 @@ MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS("NET_IONIC");
 
+static int ionic_query_device(struct ib_device *ibdev,
+			      struct ib_device_attr *attr,
+			      struct ib_udata *udata)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibdev);
+	struct net_device *ndev;
+
+	ndev = ib_device_get_netdev(ibdev, 1);
+	addrconf_ifid_eui48((u8 *)&attr->sys_image_guid, ndev);
+	dev_put(ndev);
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
@@ -50,6 +251,17 @@ static const struct ib_device_ops ionic_dev_ops = {
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
index bbec041b378b..c750e049fecc 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.h
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.h
@@ -26,6 +26,11 @@
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
index 8d0d209227e9..f3cd281c3a2f 100644
--- a/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
+++ b/drivers/infiniband/hw/ionic/ionic_lif_cfg.c
@@ -99,3 +99,13 @@ struct net_device *ionic_lif_netdev(struct ionic_lif *lif)
 	dev_hold(netdev);
 	return netdev;
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
index 5b04b8a9937e..20853429f623 100644
--- a/drivers/infiniband/hw/ionic/ionic_lif_cfg.h
+++ b/drivers/infiniband/hw/ionic/ionic_lif_cfg.h
@@ -60,5 +60,7 @@ struct ionic_lif_cfg {
 
 void ionic_fill_lif_cfg(struct ionic_lif *lif, struct ionic_lif_cfg *cfg);
 struct net_device *ionic_lif_netdev(struct ionic_lif *lif);
+void ionic_lif_fw_version(struct ionic_lif *lif, char *str, size_t len);
+u8 ionic_lif_asic_rev(struct ionic_lif *lif);
 
 #endif /* _IONIC_LIF_CFG_H_ */
-- 
2.43.0


