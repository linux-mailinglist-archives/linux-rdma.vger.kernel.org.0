Return-Path: <linux-rdma+bounces-13058-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4904DB41504
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 08:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1E86189385C
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 06:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3048A2E06E4;
	Wed,  3 Sep 2025 06:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RfgZD7R6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37442D8773;
	Wed,  3 Sep 2025 06:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756880302; cv=fail; b=X2BIbw+/fwBUNfxyOssvO3ocpTZlhRAI1ArY9e+xW64R6BHJ5zB52bhxLiYleYOnL5rLrMaWhFEIC5nrl6HtPv/oN9KuWeAD3dce5f6qFhS8a3ZkC1jyNXUtdHY7dcPsBy8qwl/DLFrppB/XePVqswBNSyItXhjIkzlHIbnbR8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756880302; c=relaxed/simple;
	bh=HzDxcdTcU0Ax7Ty5+WDsFNblI+WPs31N66Awk/RJAwM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r4cR3aYOwGuihNtInQwEH3/sYfFdeBRTdc/xNCz590/xp4ueg1gjsdYDu9DeFnFwfjCJ6ixFO6rpjoom95hAxMVau5ZpRSfAIDgHRiLw6GzdDg2dpfjrQ8+BGgrgl43ssLvsMSCX1+q1kakY5wvH44XCDmwrXz/OD9U0KSe33zQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RfgZD7R6; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGMm7Li1852Cmlnav51Re5FZaeSsOs3db7iYTOJ6F45ANgN45NTP6vBmcuLfcscyGq5NhPyxV83JUTp7IKDS4XayQ9vLXN6TB7FQTNrlZAzWGt0PfoEiliReu4M13sAxe8DOBPDquShMF2HcvB5eeddvq95DqlmHR85+2TUudcSL1X7NAg70DFgLiIoBj6x3H9saIQUM4Eg3LbLeMTaY9OpWQSHQWqcG/Ux+U86xzgGbxgPG24BnP4y3yiR6WMKBG83MbH/vD1VCJEiZA81W2mdE5zrsyyJQLjRJSqLu/U4PE0eIbLOFawDSR3riwa1oihZnJfoGFUNK/plGtzcQMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxKETJtG4WQBRv4ybZ11/Qg6YhMaRXd0Xecej/i8EVs=;
 b=kDvc4oQteicr5TqATiUfNqo5twmhcPB0G8N/buBlv4hd/agnG3yxwDlRQEb7HTqQa1MpCcv5td0jQdkaPvyU+9ZxC6zUL6XqUSPhefb9IUyHk9BqnsmiTYt0sWdIxqr60/XfKd1UICbwod713s/Y5BovlOtS1GUH16bhARHnGhPwCkohKIBDLBa4Q12+5RGnnO02ULY//E4wlCsU7jfEuAE+EJ87WHmmRhbUPzXh7aciXHqaqnkXH0Vo0pVc14OtxN7WnfC7tMZX9WkDflAlSqfu2NmvmQzsHNRcvczcCZugxyb9XgPswwkaE9m1Me9nUzO4s8iBCvlB/iaIWxVF8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxKETJtG4WQBRv4ybZ11/Qg6YhMaRXd0Xecej/i8EVs=;
 b=RfgZD7R6rwSntR73eNjeLY8TeJZOU75pNUy+xn1FFTGXHd/puPlnqsu2dzpEJsO0Jj80VdMYhWV/a6vuj4qElSWe1BuHIoRMaohu/nVjN0A/DQmk5UkeEjKcJnLsXZZiGfMgzKQTSCw4/7LwKSDO7+K6SdOEWjMK5rt4GBOmIds=
Received: from DM6PR10CA0007.namprd10.prod.outlook.com (2603:10b6:5:60::20) by
 PH8PR12MB6868.namprd12.prod.outlook.com (2603:10b6:510:1cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Wed, 3 Sep
 2025 06:18:16 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:5:60:cafe::76) by DM6PR10CA0007.outlook.office365.com
 (2603:10b6:5:60::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Wed,
 3 Sep 2025 06:18:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Wed, 3 Sep 2025 06:18:15 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 01:18:14 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 2 Sep
 2025 23:18:14 -0700
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 3 Sep 2025 01:18:10 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <brett.creeley@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <corbet@lwn.net>, <jgg@ziepe.ca>,
	<leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <sln@onemain.com>, <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, Andrew Boyer <andrew.boyer@amd.com>
Subject: [PATCH v6 12/14] RDMA/ionic: Register device ops for miscellaneous functionality
Date: Wed, 3 Sep 2025 11:46:04 +0530
Message-ID: <20250903061606.4139957-13-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903061606.4139957-1-abhijit.gangurde@amd.com>
References: <20250903061606.4139957-1-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|PH8PR12MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: 76ce20e8-1d02-44dc-9df4-08ddeab1ab33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WVrBrW1hXAYAjx0Tc7r4f4B2GQkHjeKYO/7yTef2lv+LgQnmKUetpGhTMmyn?=
 =?us-ascii?Q?I7BHILjaW8gzXB/crxSOFwzFXuAoIcNAeRP0rNHkyXgj5K1ENCbtwvgW1NXn?=
 =?us-ascii?Q?gD/FIz6sD1/3zLrbTjvef/5/6Zz2csXOhoiZeXN9XqwhJfXU515m9Uky1TA0?=
 =?us-ascii?Q?DeIBoGzucMQ8nRWP//7ddxwpfISmjzkWgXys90XWqQFu2ZBkd/wu6XdykmZC?=
 =?us-ascii?Q?K4smpVWwXWcN4bqWgr6+kkgf7IZnrQ/5StGzGGHvv5h/SkDKrwIyeW+xPjrp?=
 =?us-ascii?Q?pCCwB2KMUik9PRAtkjDwTgxspvNOshOWeIq2FFLjjTGhssweCbVq6vT4F0cH?=
 =?us-ascii?Q?Zw2aN0PoDxgeJXSgRK0mlTfqZM0QbnhxX8IU9UgRrqSwE9+F+WVX4pGOAw6e?=
 =?us-ascii?Q?d9Uw9acELOkqv+dxvRj/IsRoQ0dK/bqCYQQliMH0Jp0/gmRRzjalhzczyG1b?=
 =?us-ascii?Q?bv8AYLxNTCga6HCgU4t6hhRCaqpaEW6upfK2gvdhqUP9EMavxOvKeJybkrLG?=
 =?us-ascii?Q?zDrp/wkFOYL0ClLaulgZKEgP4gwdqC7vBC3zwOaUftKP1dU9myk75jb6cADN?=
 =?us-ascii?Q?AOhoDig9QPeai/UO2ovygnwAIlWy72J1Gytu1hqFAvoD6LG/0MkuljUFjcvt?=
 =?us-ascii?Q?Cw0rYL7k0tlFilogSSofIRTZzHe8aEDakBZFnObAhrM9DpRPrkjeeFQ7wxMF?=
 =?us-ascii?Q?fOCi5eE/Tu7QeVclP9p678njaDFwkIblTQ7L6sQqYnQEGI/Be55LPFw8hVmc?=
 =?us-ascii?Q?Oh/3ash/Lf581TbEoTDN78WmXhp+x1aizGI66aYI5juMIT3UzCZcXa+B3Zxc?=
 =?us-ascii?Q?ocVoP1EvRuH1JIKNvUmCRZcmRRrfKsBlofQ3wb6ISzhsf/sqWx3UKmnv00b9?=
 =?us-ascii?Q?B6rPgiL6L0QGPaJ2QVaTmOl3iKml2nmn6gAssLJjpee029T7OZUpZwVyqdHk?=
 =?us-ascii?Q?ACtjPd45KHgeYCX4xHaS2xF2DN4Qm3DQWGAY+u/WZN+tebX/1gbcXaY5vAOA?=
 =?us-ascii?Q?LUwgEBxuCBYaO1IMa1qt4tPuw3gHmfCe9N24dGywZYpKpIiiFHy32FfjpTLq?=
 =?us-ascii?Q?3tx02ie+Fem6ANH4aMNNZgszfeUC141We2ihSLL63bRHcAqQfmg9yH46+hR+?=
 =?us-ascii?Q?ixreImsD65rX1KE+veuAL3CRMgslvzKW0znG3dLoaNGwAOkPa5o/wgdK7lI0?=
 =?us-ascii?Q?nQBWoN0DKENcqkEScjNqFFagTogCHFq7PRwIKSc79i/HV/i4HJpnPCMN3QhF?=
 =?us-ascii?Q?RvYNiMAdbo8S+HgV7GLYkVDRepF1YOeb/fjMDldpJxYkipxlgizq0mDtyM7U?=
 =?us-ascii?Q?auj8z2OV0ctOLWklBod5imNwlD/NvulS4rf2DzQNOw4+AOKuUSP9tzVj/cF6?=
 =?us-ascii?Q?ObEOSv7q79nN/RErLOsxSdYbMyyoqDPN2uvyF44x2D2VymV7nnC7dRjfWnel?=
 =?us-ascii?Q?3/9MqxQgBuBbfn3pVrhM3ntEuFVBbZn4EpFqcTX2iaYDu7mR66vFrYmAj9Yc?=
 =?us-ascii?Q?45PpmDm95IXqDnJ/YO8ZRF/psmzSvK94a0PL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 06:18:15.8072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ce20e8-1d02-44dc-9df4-08ddeab1ab33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6868

Implement idbdev ops for device and port information.

Co-developed-by: Andrew Boyer <andrew.boyer@amd.com>
Signed-off-by: Andrew Boyer <andrew.boyer@amd.com>
Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
v5->v6
  - Removed ib callback for get_vector_affinity
v2->v3
  - Registered main ib ops at once
  - Removed uverbs_cmd_mask

 drivers/infiniband/hw/ionic/ionic_ibdev.c   | 200 ++++++++++++++++++++
 drivers/infiniband/hw/ionic/ionic_ibdev.h   |   5 +
 drivers/infiniband/hw/ionic/ionic_lif_cfg.c |  10 +
 drivers/infiniband/hw/ionic/ionic_lif_cfg.h |   2 +
 4 files changed, 217 insertions(+)

diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.c b/drivers/infiniband/hw/ionic/ionic_ibdev.c
index ab080d945a13..5f51873af350 100644
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
 
@@ -15,6 +19,192 @@ MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
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
@@ -50,6 +240,16 @@ static const struct ib_device_ops ionic_dev_ops = {
 	.poll_cq = ionic_poll_cq,
 	.req_notify_cq = ionic_req_notify_cq,
 
+	.query_device = ionic_query_device,
+	.query_port = ionic_query_port,
+	.get_link_layer = ionic_get_link_layer,
+	.query_pkey = ionic_query_pkey,
+	.modify_device = ionic_modify_device,
+	.get_port_immutable = ionic_get_port_immutable,
+	.get_dev_fw_str = ionic_get_dev_fw_str,
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


