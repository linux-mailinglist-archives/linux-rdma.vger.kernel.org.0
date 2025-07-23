Return-Path: <linux-rdma+bounces-12440-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49906B0F940
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 19:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B19A5848CC
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 17:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E86C23D291;
	Wed, 23 Jul 2025 17:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WNleRev6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362A123B636;
	Wed, 23 Jul 2025 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291982; cv=fail; b=X9khp+WsUSc89NtvI32u/hI7MMR4QH8ZjyBziZb/xv/UMlBrftGwowgeskbtZ11V+aIP3ux/xK25Ets6elGKUOhjUDkB2ZWkIKYI3Z+eJxJoXb/RVsowKo72RJjSDR5VgeG2DNwxVGC8YWo77t8P2yKuTgwvvgfcxp80o+FvVIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291982; c=relaxed/simple;
	bh=ZBlcUtpR6D07RjAX9txMRoXGLB+7fqMd2uqbmoBX6FA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a394yxPikRsKszlZrWT78wlnA/lr37mWrzb3cX7aSIND8j6fX1qMiXNya46UPT0onXPDToxr8CeP4CGKDOtw/icnDOUdX2tDIqKZyaBlS8zndhdFmJ6C35ll5FlPzx4k0YWsbI3oCIkkM3vRekG8QdtYVBRqUqS0uZRPgFSkEMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WNleRev6; arc=fail smtp.client-ip=40.107.102.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mr/NY7enBmLVUUgzEZfAzIB9v3wVWNVs5G4n/PPT4GeMUO3QdwMpUkN4VwPi1OuIV0OBYKcGHV7/SNmbiCV6c6zEyghrlAVBS5MjlgVpG6J3nuUM9yozoh2t7bnuxKmXSqYrb7dbV5blAS5+JtJuW5kJTsY7DYjsM2Ri025mhQWdSPUdQ89K87udGgO5kfsbjNRIl6PQ2hRTxBre7XY2eTe5iEVDj5oPaLGWJQH1PPxAReXuK5YZwGS73IExyA8phrknxiKuZ5d1Mj8bdG9AE4F0kfL+r//D0Up53p0W6DvOdJbEtjgoBM2hZEc6puQf3Ks4UC8OztMUxLvsEw2mjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HugzHnngS7QUUkVIZnV+vVgBVUNR77XJ+O5fwLTuq4=;
 b=x5f27SEWcniPTrw97VTzPyLlTqMdo4pXmr+OT0iHucxXsXFTs7Uc3N3gDHaFBQEbJmsjARAq+l7hmxF/20BAM+qs2CwXsMXDZgjzTpSYYpr5CVSgdfxW5lwmZxk0ACm8c+WhllcKgl7Lnr52JynMwiM36lAqH7ULEAwF/oSFwcDeMBl54YMbFr/nFSPuFZ1Cx74CRG5QNe/dOC16OB8qapLy1k6Uw15ZL8AHC1OhGtJlXOTFVa+HWE/QolR97nrTfp6iI/84/cr2bE0ifRPLsGLdnDlIeErU1nqg8fWMO2PsT3DWlp78uACV8hVAs6GQBer0LVi8+xF7isA8AX7iuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HugzHnngS7QUUkVIZnV+vVgBVUNR77XJ+O5fwLTuq4=;
 b=WNleRev6qglfjNcDzdG8vA8eRsz/2c2DzmADWoKhAlG1yovXPboWuVpUOVXUBTZ0xtWiVRShzAJeC9z7faQG7ayBXKuh78mW8nZSJkEf/f6YBAANGYd5BIpQd53ymuyIq46KYCTWdllohpzXxG9qPl4xsiY+hSZZqXQaMiz029U=
Received: from CH2PR19CA0015.namprd19.prod.outlook.com (2603:10b6:610:4d::25)
 by LV8PR12MB9083.namprd12.prod.outlook.com (2603:10b6:408:18c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 17:32:56 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::24) by CH2PR19CA0015.outlook.office365.com
 (2603:10b6:610:4d::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Wed,
 23 Jul 2025 17:32:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 17:32:56 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 12:32:56 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 12:32:55 -0500
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 23 Jul 2025 12:32:51 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, Andrew Boyer <andrew.boyer@amd.com>
Subject: [PATCH v4 12/14] RDMA/ionic: Register device ops for miscellaneous functionality
Date: Wed, 23 Jul 2025 23:01:47 +0530
Message-ID: <20250723173149.2568776-13-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723173149.2568776-1-abhijit.gangurde@amd.com>
References: <20250723173149.2568776-1-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|LV8PR12MB9083:EE_
X-MS-Office365-Filtering-Correlation-Id: 428cc9de-1aea-48b8-7644-08ddca0ef62e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lrpqy8s7nxNhJq5iqnIdUxUzWF7srXxDPmxUFBfvhEk3qvHa8Jxk8LownCFN?=
 =?us-ascii?Q?hE8Qlt2Mc1VUFG3IxJX1+2AtRzz8s32e6AZWlR55atqW0H4j01lwffNL7S1z?=
 =?us-ascii?Q?5WY1Eb7YYPQTyPngXBg4vn2cjQVsdyW/smtb1a4yXKwWLFbS6jy+CjQpt9TN?=
 =?us-ascii?Q?2by7jZcS5T8wprgC+9De8SbmIBUMzFYAexsffenXALBg3GWcR08qxigtMyRX?=
 =?us-ascii?Q?3K9SgkV6KL2OxkMt0T6plGpWPb/Fu5qBUgVIgUY3TzUboCioP5LuJuhFcKcW?=
 =?us-ascii?Q?pQFqIqFdxdzbosiKYpkuM/CJeaAGR5kNj66BrG93QhiqLzlIq0QK8qKNPAUL?=
 =?us-ascii?Q?nQ65RmB7xa2XnPstPVdWisMCFzkHe72SV/G1OXoneMEyd8eNIhqpG4+kKyJA?=
 =?us-ascii?Q?A+Z/E8MWkrUE/vS5Ewg26qmTPFe/DwDHm4iOH5//qh/iFnkhfB2xsvvLEt6t?=
 =?us-ascii?Q?UwdC42XgCtLri4vbkAWTfBj3GM4D3fymbmbjblQK4RNYemnBdq/UPxJTdtWQ?=
 =?us-ascii?Q?of/PmVQoEP/E1GCep/wko5qvENJI3gooRHKs8mGTls/FDE/136fwjCj+e/D5?=
 =?us-ascii?Q?y1C/+QNnzgc+6lC/inNB0tiNKxS9Po3eIAhnCqdqZi0KYOHkoenO1GFNg9pj?=
 =?us-ascii?Q?3dI+ZIZROBo2Hwu01+TNMXp1a0JhXrvnh1cULz+z47lgkW7f8v19jmRV2ynd?=
 =?us-ascii?Q?KnSWkT1mJD/SrxxPkf/kVfAQghiWQNANkfeJJvqPe2BvzrPlxQ62oyPdt2cj?=
 =?us-ascii?Q?c4MdSr10YCixqx4OTLkE2BgZR8uxgWeK26lUlrZHewh0Bmsb5CrxUXIAGhS7?=
 =?us-ascii?Q?oSQF8LTPWR7GMoSD4vIT9zyyfBJRgbJwiV+7dFjSVBm0zCHlPxD/F3maPVCM?=
 =?us-ascii?Q?KRKTxDN6I9zQX87/Atnc3Gy0imhiu2tNbt84c1zlSrwicewGY6GSK+8Ip985?=
 =?us-ascii?Q?aGHj9RFCsjaxc2oTL64AQTzU0U+ZpplMVs0HwT/eChaFR7MnddAeTfprAhwZ?=
 =?us-ascii?Q?ZvSsDFgCU2RNwDOmxbQP7GGoBPLAplO9EU+TDeupJt7ymyFRF5nS7YtRXTHA?=
 =?us-ascii?Q?a8UC0ywk49ZVxbi5shebR5piCa4xtbOYH2yDkDtCJP7HHn1dfslZeCqkhPk4?=
 =?us-ascii?Q?g51ctJZUWf4T1/gQDmFTRcUHj8Iu+FNVXxC3UkpQ0ETw9ABXVK2w3aML3H3B?=
 =?us-ascii?Q?vMfyP+zBPqpoa3IKjNtxK+Sl1xmFXgg1KYUUHu52XTVw8138NwMG3xG/1sWY?=
 =?us-ascii?Q?YSlyq7MGQ+BV1B/wji5dn1i6UFLt4D5s5squTcI01vfhF/P/0jYtBKcUbXe3?=
 =?us-ascii?Q?HBVfMqmZNyMWmAKpmhSe/nxAVfS1D06zEv3avMDLvNV2d2h2VEZA4vYHAC9e?=
 =?us-ascii?Q?KEN/0Cx+kzEU9LZ0vcwj9N0ycvvH3qt2Ph0iuab1cryYoGY7AGXJlVnG8eKV?=
 =?us-ascii?Q?b3K+41Xd/zoXWhLPRa9Wn/1b5GFHsmeQ2flbtSpZ0A9Ny8XwtQ2wqL3gzgtX?=
 =?us-ascii?Q?RwWffNXcE/6mgy1148BCWoRa86VECS/SJTDlJXzaTA85D1KtKGbbE8pbbw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 17:32:56.4545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 428cc9de-1aea-48b8-7644-08ddca0ef62e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9083

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
index dc30fecd9646..1a2c81490c5c 100644
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


