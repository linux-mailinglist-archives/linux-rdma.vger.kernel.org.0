Return-Path: <linux-rdma+bounces-9727-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB1FA9878A
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 12:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFC4018997A3
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 10:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A492277013;
	Wed, 23 Apr 2025 10:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aZ3AB0Z5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C46276025;
	Wed, 23 Apr 2025 10:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745404336; cv=fail; b=V9cploFZdwX7lQwcOV4eLkCuuBgmt+jYdjowLgq4eeZXSGq5xsXvmrf3+JOa3wd8SHWk8XBYtQ5qWvNXG6UhqKlvuP4RAQ6PaOZLvSjVFRNp89k0KyuW/KAdqfVax3AYUOE9b3Dkd0Th3btWzquvnnsbKgdy5me96nHwt0sbL6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745404336; c=relaxed/simple;
	bh=V7JCa/0s5LyJ8dIlQx2sCYIBKv2JsFF2OkxMvVxoS64=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jFNCfDznPIX3IqnJ94oXYi3bZqCh25QqxfqWuV7p8sEbat1me/kZBH05gBYXlhgRSQgmPdlk4W+ZeMJ1nSRa5ZGHEz2IG51CVWpaRDpS8QfHBFztjHeIL2YGva/K3lUgBPfV624QyO7NVTnhjBS12H03CCKwZtmmVXzsh+TucnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aZ3AB0Z5; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICIBKpj9NdcVw4vvUn038X3I/bdH7Mp5byg4JkYMZWyiyBOixsD3LdKT1+Sdlp3joYF7PAqqkJkoEmhvDUkVomHyFLVmcZxWzhlU3kIS2T5D5dQ3kajve1luNGRyx5++TcoL3iQmKejwhCDK/C4hjHnvD2emXKZaVaqvWykKOCuwFygA4AYJC46iRonSBUKfljIUGRkhdiQIxMeZ2ntDURtzlEdSpMHBZWC0bM56XYm4E0CZS/dXJTqWQgMkFKWk36EmEBrAoeEp6Y3LBCnIO2MkjzvVGbmyKihrgrS1hSs+DNSRYQUlM9jyobAPmQaJhM4tPGq3rv27inKE5vleRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fe4Jq3iaji6kTXJB2wuGCH3DPAJCNHlyyR7/dp8M+1Q=;
 b=eMPBxXaiZugSIxEvQpwejJNIVXIQGiyFwRevxBr78WDNYhWpb6ts0YtszAtvHkPB7bYPD6SeBMNVqHKCyTB3o/aeb5giReYEHKjJAJg2dhuq1HHMy+OlL+kRYKm/r3yYsMEotwrkuRSSL9jkXhsJJG3QEnMKNvj/0a9F8or++l9XqFC7bGlFeyN3SYnLnhg6FQSydh/9dTy5MrE9f/N84HlH2MfYuy6uBWiV49aHdba71rTAZEUkPUsIxqL8CZdmaCMgOYjsUquDf6URnLmtW0nV2EgESPf7HZx2IDZX+xKQJBRH+rLJm6XGJ2cuL8CLkwCPlkhlCimuxzH/6ii3hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fe4Jq3iaji6kTXJB2wuGCH3DPAJCNHlyyR7/dp8M+1Q=;
 b=aZ3AB0Z54I45YigdCx9X45zfS1itwp8j/UXJeWq7b48VCfH3roAsV5T/OEQWNjnPcxrcJxYYcXgLHV932VGKglU1wcqn0UoXwl+puvuL4Rbifk8yzBwWZFPCIRLG4oM+eE/WvPrrEzwGeD0rCWDXGNaCr/VDmBhmJsk2oOcvUCQ=
Received: from CH5P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::15)
 by CY8PR12MB8067.namprd12.prod.outlook.com (2603:10b6:930:74::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 10:32:07 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::d7) by CH5P220CA0014.outlook.office365.com
 (2603:10b6:610:1ef::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Wed,
 23 Apr 2025 10:32:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 10:32:06 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Apr
 2025 05:32:04 -0500
Received: from xhdipdslab48.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 23 Apr 2025 05:31:57 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, Andrew Boyer <andrew.boyer@amd.com>
Subject: [PATCH 12/14] RDMA/ionic: Register device ops for miscellaneous functionality
Date: Wed, 23 Apr 2025 15:59:11 +0530
Message-ID: <20250423102913.438027-13-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423102913.438027-1-abhijit.gangurde@amd.com>
References: <20250423102913.438027-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: abhijit.gangurde@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|CY8PR12MB8067:EE_
X-MS-Office365-Filtering-Correlation-Id: 006e6d15-e835-4738-0cd8-08dd82521879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ydky82MnA/r5PpV65dZThlJhndj5zpambUfwF1H65hlG5t1zwPAXjKduw+SW?=
 =?us-ascii?Q?NXow2uzlz2UK/HKIRI4kbPYdYs7mojk0y1R9wu97WreX84tZwxII9xrcDgqx?=
 =?us-ascii?Q?GwmM89BUJWB43K3AKc+Ir2xGL1dv4sbx45upcT8Za7fnqd5wNB5PWWivaOpC?=
 =?us-ascii?Q?0ndl5fFE6u7BdHEQWZOqyNhSXX8jzs0HyBFCX6n91dsPSnrA+F6yYwsWfG8C?=
 =?us-ascii?Q?7m94msEa9XSD0Dda70ZlwKGb4ThMjQxv8Tp+ogDo3alN8nBbvIYTcV8f1zGH?=
 =?us-ascii?Q?boyQhbuwWS1jRuxv7aAzfXccl2ZO1J7wT5u04PVKj+hhvlHITskso6bNjwwk?=
 =?us-ascii?Q?I+FB55YR5d4f2yDFYeeIj7XM7HvojP4YdahhvYI/5KHZgfjDE7BQm2hMSvq/?=
 =?us-ascii?Q?lr9Uz82qYNa7mPGaGDikkVcunuEVnrna94ICnDSm6lrTvmpgqqTtDYRML9bf?=
 =?us-ascii?Q?TNuT1IOKRT+/vurknM9+Jv5JcG2nz/5swiBY10bQ1QsfK2yyel5XFzHBjBMb?=
 =?us-ascii?Q?6sT9npai/7ae/HguH4NkFAxB3jGX0hqG84MlO5NnnraXO/YLztQOUuQL8L82?=
 =?us-ascii?Q?Qsj/F5PaxKWTqb5Puv5lw18ohoPAH0ghdYmKxtnJmOolCmitRmFcZ6ZZ/8d7?=
 =?us-ascii?Q?n8DvAE+/8axyvlcX5jtWMZ3kgwMiM1dvp+5rZChm/A34N6F3FpkFcxAUklHM?=
 =?us-ascii?Q?BqUTcvCts6gh/1Z4uQ0WelFyJSyjo3nCz6Qu+7gs49CGjpKrFvY8wKgE0JSo?=
 =?us-ascii?Q?5GsKuiZf9O0xPWRFBS3KSj3pHmKl2MctfSgecEFDbabwIVEmCkOo77Z5x7NK?=
 =?us-ascii?Q?HPcYZ6oNomRxrKq2EdMYJcROyZe8wp6aWcYuAIka2/734J85dch0WOBkCG77?=
 =?us-ascii?Q?gH3qFPdJ4gDnyGmxHqPFZNNUI6XHH+3NzEPH9LWawMja8FbOuLlZzRF1wKy5?=
 =?us-ascii?Q?F7gi901lZRKmcXemrekTo5T7aBwvKH1S4Vf1UC8IgZ4yUR/PvnUARK2s3qRk?=
 =?us-ascii?Q?WEMDHYDBay4geyuyoOrVg1Asc/2m0dF4bOqIb4N5oNbhsgb4gakvE6qiUF90?=
 =?us-ascii?Q?0O0NoQYGauKAMewWdulTzOXvFb8cW0XkWsOJVACIRopujo8iPXHS5NCjkU92?=
 =?us-ascii?Q?bBGpYLSjZ1rvWL5BLfG+//heX5+geic7zXA+w9pGZs0JtEV8pTDdgGsKRW1u?=
 =?us-ascii?Q?KZuBJeF3pNz94FFabvhYfoW3H+PvDxH/tLYR+O+ReUmerovEfGdicTYa9P/6?=
 =?us-ascii?Q?Ek4nCtEq4wbNgroj6ppmVPZaj+Idv5hMWbZW0QzbzyHXc+mo29dSkFaaLi93?=
 =?us-ascii?Q?2kFZmONX317/cJPDnYVg6gFWSZHZhLht32o+FZtxc3LPXJxZ/JrkkcxKzjB/?=
 =?us-ascii?Q?pyIdT8X4VkPVnEcmvEzVqcWVICiSwt8x2nrrXt7TfHVVO0xoGM7i4b5A3rW7?=
 =?us-ascii?Q?C+b6YfKKntvKXHNH2N5sxLg6L9CAUWOpPVv91dEodZK9YSH68VwVFLsPwKU/?=
 =?us-ascii?Q?kfVEu70LD7wyKwt2rAFiv63KWOOEqQ4rWmnZLrp0G70os2e+8EUAxEgL1g?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 10:32:06.5368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 006e6d15-e835-4738-0cd8-08dd82521879
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8067

Implement idbdev ops for device and port information.

Co-developed-by: Andrew Boyer <andrew.boyer@amd.com>
Signed-off-by: Andrew Boyer <andrew.boyer@amd.com>
Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 drivers/infiniband/hw/ionic/ionic_ibdev.c | 236 ++++++++++++++++++++++
 drivers/infiniband/hw/ionic/ionic_ibdev.h |   5 +
 2 files changed, 241 insertions(+)

diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.c b/drivers/infiniband/hw/ionic/ionic_ibdev.c
index e6e3eee6760b..731d280a301b 100644
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
 
@@ -35,6 +39,230 @@ void ionic_port_event(struct ionic_ibdev *dev, enum ib_event_type event)
 	ib_dispatch_event(&ev);
 }
 
+static int ionic_query_device(struct ib_device *ibdev,
+			      struct ib_device_attr *attr,
+			      struct ib_udata *udata)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibdev);
+
+	addrconf_ifid_eui48((u8 *)&attr->sys_image_guid, dev->ndev);
+	attr->max_mr_size =
+		le32_to_cpu(dev->ident->rdma.npts_per_lif) * PAGE_SIZE / 2;
+	attr->page_size_cap = dev->page_size_supported;
+
+	attr->vendor_id = to_pci_dev(dev->hwdev)->vendor;
+	attr->vendor_part_id = to_pci_dev(dev->hwdev)->device;
+
+	attr->hw_ver = dev->info->asic_rev;
+	attr->fw_ver = 0;
+	attr->max_qp = dev->size_qpid;
+	attr->max_qp_wr = IONIC_MAX_DEPTH;
+	attr->device_cap_flags =
+		IB_DEVICE_MEM_WINDOW |
+		IB_DEVICE_MEM_MGT_EXTENSIONS |
+		IB_DEVICE_MEM_WINDOW_TYPE_2B |
+		0;
+	attr->kernel_cap_flags = IBK_LOCAL_DMA_LKEY;
+	attr->max_send_sge =
+		min(ionic_v1_send_wqe_max_sge(dev->max_stride, 0, false),
+		    IONIC_SPEC_HIGH);
+	attr->max_recv_sge =
+		min(ionic_v1_recv_wqe_max_sge(dev->max_stride, 0, false),
+		    IONIC_SPEC_HIGH);
+	attr->max_sge_rd = attr->max_send_sge;
+	attr->max_cq = dev->inuse_cqid.inuse_size / dev->udma_count;
+	attr->max_cqe = IONIC_MAX_CQ_DEPTH - IONIC_CQ_GRACE;
+	attr->max_mr = dev->inuse_mrid.inuse_size;
+	attr->max_pd = IONIC_MAX_PD;
+	attr->max_qp_rd_atom = IONIC_MAX_RD_ATOM;
+	attr->max_ee_rd_atom = 0;
+	attr->max_res_rd_atom = IONIC_MAX_RD_ATOM;
+	attr->max_qp_init_rd_atom = IONIC_MAX_RD_ATOM;
+	attr->max_ee_init_rd_atom = 0;
+	attr->atomic_cap = IB_ATOMIC_GLOB;
+	attr->masked_atomic_cap = IB_ATOMIC_GLOB;
+	attr->max_mw = dev->inuse_mrid.inuse_size;
+	attr->max_mcast_grp = 0;
+	attr->max_mcast_qp_attach = 0;
+	attr->max_ah = dev->inuse_ahid.inuse_size;
+	attr->max_fast_reg_page_list_len =
+		le32_to_cpu(dev->ident->rdma.npts_per_lif) / 2;
+	attr->max_pkeys = IONIC_PKEY_TBL_LEN;
+
+	return 0;
+}
+
+static int ionic_query_port(struct ib_device *ibdev, u32 port,
+			    struct ib_port_attr *attr)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibdev);
+	struct net_device *ndev = dev->ndev;
+
+	if (port != 1)
+		return -EINVAL;
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
+static struct net_device *ionic_get_netdev(struct ib_device *ibdev, u32 port)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibdev);
+
+	if (port != 1)
+		return ERR_PTR(-EINVAL);
+
+	dev_hold(dev->ndev);
+
+	return dev->ndev;
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
+	strscpy(str, dev->info->fw_version, IB_FW_VERSION_NAME_MAX);
+}
+
+static const struct cpumask *ionic_get_vector_affinity(struct ib_device *ibdev,
+						       int comp_vector)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibdev);
+
+	if (comp_vector < 0 || comp_vector >= dev->eq_count)
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
+	return sysfs_emit(buf, "0x%x\n", dev->info->asic_rev);
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
+	.get_netdev = ionic_get_netdev,
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
 static void ionic_destroy_ibdev(struct ionic_ibdev *dev)
 {
 	ionic_kill_rdma_admin(dev, false);
@@ -84,6 +312,7 @@ static struct ionic_ibdev *ionic_create_ibdev(void *handle,
 	dev->handle = handle;
 	dev->lif_index = lif_index;
 	dev->ident = ident;
+	dev->info = ionic_api_get_devinfo(handle);
 	ionic_api_kernel_dbpage(handle, &dev->intr_ctrl, &dev->dbid,
 				&dev->dbpage);
 
@@ -203,6 +432,13 @@ static struct ionic_ibdev *ionic_create_ibdev(void *handle,
 
 	addrconf_ifid_eui48((u8 *)&ibdev->node_guid, ndev);
 
+	ibdev->uverbs_cmd_mask =
+		BIT_ULL(IB_USER_VERBS_CMD_GET_CONTEXT)		|
+		BIT_ULL(IB_USER_VERBS_CMD_QUERY_DEVICE)		|
+		BIT_ULL(IB_USER_VERBS_CMD_QUERY_PORT)		|
+		0;
+
+	ib_set_device_ops(&dev->ibdev, &ionic_dev_ops);
 	ionic_datapath_setops(dev);
 	ionic_controlpath_setops(dev);
 	rc = ib_register_device(ibdev, "ionic_%d", ibdev->dev.parent);
diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.h b/drivers/infiniband/hw/ionic/ionic_ibdev.h
index bb2cb1bc41ba..00ad562b4713 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.h
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.h
@@ -31,6 +31,11 @@
 #define IONIC_EQ_ISR_BUDGET 10
 #define IONIC_EQ_WORK_BUDGET 1000
 #define IONIC_PAGE_SIZE_SUPPORTED	0x40201000 /* 4kb, 2Mb, 1Gb */
+#define IONIC_MAX_RD_ATOM 16
+#define IONIC_PKEY_TBL_LEN 1
+#define IONIC_GID_TBL_LEN 256
+#define IONIC_MAX_PD 1024
+
 #define IONIC_SPEC_HIGH 8
 #define IONIC_MAX_PD 1024
 #define IONIC_SQCMB_ORDER 5
-- 
2.34.1


