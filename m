Return-Path: <linux-rdma+bounces-12439-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD0AB0F93A
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 19:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE6AAC3FAE
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 17:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDDC23BD05;
	Wed, 23 Jul 2025 17:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YCWPjaLm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267FA23B605;
	Wed, 23 Jul 2025 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291975; cv=fail; b=B5VOido96/kid2Veh3WjW5i9OUvppuE/xB1iJb/fV9eiEV6wdtPPeaci2QwkVxLAKHNm5vsfXp9wQixZFBSkg4idANSSV3NekEJjjmktwmgMY4q2Fder+HzYhcTQQQ9LO4/SlMQ1lW4F/j0wO7QScElG+FFLhxeEGlZDR0IN9aY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291975; c=relaxed/simple;
	bh=sLeQMZaiwYFvkU+VeESVobXFPbAsm1F0Rv3gKDLHOAQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PGPc/pSXT1rtEUjcPPTso9SkkbYla3SWaNIkfKuUx5+wgpQNwK2+SZuMnr9qHgxlYzT1XKPeBnprOMWD43t2+xzyNFQkvR+M6kXRcpjncUx/B0DmD3GezHp7y1MmxKeS3c7PLVpvoHaBgvTE9yT5ad6AALGIUABRoyBCvGFK0KQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YCWPjaLm; arc=fail smtp.client-ip=40.107.212.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIgxset/ns5tT6g9rdQ+Ci/a5ZIiuenGA2OcoUbJhD1R9+RYlzDhcFLfV+nXDog+hCQN9JNCZ4ADmhEubUPHYCa4l/lqJKicslUq6533mDCu6CDNmprNqq3vpBtxwuFEJ4ONJ+Rq6Rx6qg6t2toIWKUqd/jvP2AFWfpxt4pzR1/OtXqTbGOGJV2qzWCSmFql+LmifN4YDRtkYx9ABsYK0Ur+Obh/Eir2MT+P312oW/1mut90xLUKgVDnyPkYnV0iDuULrMChC1UkDWBUOkrCxuLRTrMHx7PZ5o0F6w09RfNhXoR+PBtgl+J1SThjdju8TIpda+BLrdG8MgLFukY9ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4r3GJLMRZDzkrK+4DIep/UJFAcV7xCs+QBF7DFBOkE0=;
 b=AlrRHj6LWM2ggeMfLHFlyPsNluTze4cwwws2ACrcAYLC92Z8lbIUPfLNc+/bQ1/CcYdLPJ/915T/syZiWO5yoenAISy99N4TItsP+6KtkTJn4QN7CKPcH3m9SgTE4hqreaVhA0oQIuBjnyCJUMIpu76GwDCi3XdyVrmGlVtonKr4i5B8r3IH8eH3Zfz+kwQh/iqfcHEsnhgdRqbin0z6nPNwXa1tKy0tuDb2BIb35qXAqdg9Ok/ANpoOC0HZZ+2KCpjRwvzHFzPu/Y1jDjQUPN+2uq6Bfjz3eBQQLld4uEQ4873LF7fpN1txP9DQj8kvj7S0vGGW5a6WifT7XLN/fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4r3GJLMRZDzkrK+4DIep/UJFAcV7xCs+QBF7DFBOkE0=;
 b=YCWPjaLm3J+GCQy8S4xkEJca3wYN/MwMnXHoaY/4l9Qz82tL7GC+dFq4fHEkr8mxN3nwxRbGnWBqw/mc8GBeKINEUvXwsiWVZt+pUtw5Mg9JPhLr86El5LhO6RUJ81MLzFrSFgkQCEMEBwx08m/wNB7xejCd4OUkILpYP+QvU1o=
Received: from CH2PR15CA0012.namprd15.prod.outlook.com (2603:10b6:610:51::22)
 by CYXPR12MB9388.namprd12.prod.outlook.com (2603:10b6:930:e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 17:32:46 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::9a) by CH2PR15CA0012.outlook.office365.com
 (2603:10b6:610:51::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Wed,
 23 Jul 2025 17:32:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 17:32:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 12:32:45 -0500
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 23 Jul 2025 12:32:41 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, Andrew Boyer <andrew.boyer@amd.com>
Subject: [PATCH v4 10/14] RDMA/ionic: Register device ops for control path
Date: Wed, 23 Jul 2025 23:01:45 +0530
Message-ID: <20250723173149.2568776-11-abhijit.gangurde@amd.com>
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
Received-SPF: None (SATLEXMB04.amd.com: abhijit.gangurde@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|CYXPR12MB9388:EE_
X-MS-Office365-Filtering-Correlation-Id: 6370da2f-c7d0-4b43-b7a0-08ddca0ef076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kj+Cukd9VhCXxPgrFjJZm5bT6sJvIhE+aiW8Kl4mI/tcO3jOKDbTu1y5l6mV?=
 =?us-ascii?Q?Mkd8hUCNy08RCyamkuntwxsNSpaI1j/Q4uwneZ+dGfZLMdEi5vmT3w/qmHlU?=
 =?us-ascii?Q?sPZxR795zLvHwi+OvhSQJMduWMQSXPIw9jef8QmfTzcScoFLr2jvvGBVJt3O?=
 =?us-ascii?Q?lFgO9IxNvJ32AOsAvPly7aijLAil6RITQNIlEVrgUS9SE36P0sj0DAcJO3Nm?=
 =?us-ascii?Q?efJg1+8pb+e/At9hXt/4C8I5P433qCxEVIxMG09TBosHwUilr+EyJjuT3KVG?=
 =?us-ascii?Q?2UPbLOMGQSU4YqpVi0scV+PlBrotkJu7B5FkKnSVcoYGg3DHDK7ctq3wlJVR?=
 =?us-ascii?Q?U2k6fMwUL3DbuQ52/LbaTgj/nIX1plPJ7dAbqumtRPAJzKW3DeJUsB5tcJ49?=
 =?us-ascii?Q?exZ9i3WnrLMSltvXbhoncwQ3zmJ+Zua2ilDMUFsFlSY1tK4v/d+IwewGdT4F?=
 =?us-ascii?Q?KaGaJT097Rfp6/97dHs+l9rVDoKEslxwUHX6dR24fEGE1L5iwef9SrstCvKB?=
 =?us-ascii?Q?aW+By/8a8Z7PgjAB9cca2ec06++n+ED2m/poO/Ew0LvwdJbXU1oMA0D/jv4U?=
 =?us-ascii?Q?2lbb3cdOPPgZnBnBa+cShohAeOD3QElXLJy4sFuODpueY+mKW+Bjh105+spz?=
 =?us-ascii?Q?JPLc7B0RJDWneJsOZ04Q+BWs6n+Go+p/QTsFDg6VRNva/JEYB0Tw9npn3G6y?=
 =?us-ascii?Q?xdvgRG1Mjk9P1MQnBEqOmJQqXa9Hd3A7j9AcLO+lNCn3CKxkjZL5eIR73fvp?=
 =?us-ascii?Q?dkyrOlCDDc/ccu1h1pvt2jdqZMkfL793Y3t4c5NzZYNCQobI5PFF1Ypy7qMr?=
 =?us-ascii?Q?Cy6I/I13w43L3jb0g2RyLJbL1D02GleeaaB+7g+AARUhGrCHU7jaefrzwVrV?=
 =?us-ascii?Q?RtL4xRzipN+ex64HYGV1hQ5FH7xTvcUf7by+GE0Ek13BREjTJu1SOQLZdGRn?=
 =?us-ascii?Q?vcI6eBcdTS+nSQZQWA/RYdCzl0DhhCccjd6DLCNuUF1A66PFAe/DUZlVQ/JG?=
 =?us-ascii?Q?5aJTzswiEWTS6D/IM7/pjbI2d/3TEeVh7Zc4ZBLUt6HUoFp+Bm5uXot+EFW1?=
 =?us-ascii?Q?ARd7hXrd62NzgHdU0Ot9VvxyS9d4D1SZ3F1HQ8QX6bkY0oU7yrZ4HDAp5th5?=
 =?us-ascii?Q?syfCzLwE/WMEq2j1USsFGurz+37hWUYVD3o+ghfTl7aPmLvBB8RDjrlqNPst?=
 =?us-ascii?Q?VferndRGugUovt65S2G7s/oKw/HN4xsvonLXItiCu2PpMBbEgD330NosrTP5?=
 =?us-ascii?Q?RAi7t4vQqhGA2A5dvC38jd5Y+H/DDzsLrcf6LoyElptWdd3b9XXHw2IiMJdW?=
 =?us-ascii?Q?9rKdgn7FSck5PLAcPydYBZUvsnGz2YvO5ZV0Oscb3SRsKGVpk2/z1Mor16H2?=
 =?us-ascii?Q?zuHY0mtVIYwnw1uME3l6oChu0JGdli4YalL8jkBkWyUtA55CqmnY60Fopq+0?=
 =?us-ascii?Q?VzJ9V2PmSGuPdPmZAAgxaiq/DMRAbuDfgL2uVQkYb0Gcmx0DRoc5PtBI+esc?=
 =?us-ascii?Q?ihIWgeLhxl9KLrHWQPLyRy37837x7IHMd97MeQRKPchj6+zL6bpqUi2hvA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 17:32:46.8581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6370da2f-c7d0-4b43-b7a0-08ddca0ef076
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9388

Implement device supported verb APIs for control path.

Co-developed-by: Andrew Boyer <andrew.boyer@amd.com>
Signed-off-by: Andrew Boyer <andrew.boyer@amd.com>
Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
v3->v4
  - Removed empty labels
  - Used xa lock instead of rcu lock for qp and cq access
    and removed sync_rcu
v2->v3
  - Registered main ib ops at once
  - Removed uverbs_cmd_mask
  - Removed uverbs_cmd_mask
  - Used rdma_user_mmap_* APIs for mappings
  - Removed rw locks around xarrays
  - Fixed sparse checks

 drivers/infiniband/hw/ionic/ionic_admin.c     |  104 +
 .../infiniband/hw/ionic/ionic_controlpath.c   | 2490 +++++++++++++++++
 drivers/infiniband/hw/ionic/ionic_fw.h        |  717 +++++
 drivers/infiniband/hw/ionic/ionic_ibdev.c     |   46 +-
 drivers/infiniband/hw/ionic/ionic_ibdev.h     |  249 +-
 drivers/infiniband/hw/ionic/ionic_pgtbl.c     |   19 +
 include/uapi/rdma/ionic-abi.h                 |  115 +
 7 files changed, 3731 insertions(+), 9 deletions(-)
 create mode 100644 include/uapi/rdma/ionic-abi.h

diff --git a/drivers/infiniband/hw/ionic/ionic_admin.c b/drivers/infiniband/hw/ionic/ionic_admin.c
index 845c03f6d9fb..1ba7a8ecc073 100644
--- a/drivers/infiniband/hw/ionic/ionic_admin.c
+++ b/drivers/infiniband/hw/ionic/ionic_admin.c
@@ -627,6 +627,44 @@ static struct ionic_aq *ionic_create_rdma_adminq(struct ionic_ibdev *dev,
 	return ERR_PTR(rc);
 }
 
+static void ionic_flush_qs(struct ionic_ibdev *dev)
+{
+	struct ionic_qp *qp, *qp_tmp;
+	struct ionic_cq *cq, *cq_tmp;
+	LIST_HEAD(flush_list);
+	unsigned long index;
+
+	WARN_ON(!irqs_disabled());
+
+	/* Flush qp send and recv */
+	xa_lock(&dev->qp_tbl);
+	xa_for_each(&dev->qp_tbl, index, qp) {
+		kref_get(&qp->qp_kref);
+		list_add_tail(&qp->ibkill_flush_ent, &flush_list);
+	}
+	xa_unlock(&dev->qp_tbl);
+
+	list_for_each_entry_safe(qp, qp_tmp, &flush_list, ibkill_flush_ent) {
+		ionic_flush_qp(dev, qp);
+		kref_put(&qp->qp_kref, ionic_qp_complete);
+		list_del(&qp->ibkill_flush_ent);
+	}
+
+	/* Notify completions */
+	xa_lock(&dev->cq_tbl);
+	xa_for_each(&dev->cq_tbl, index, cq) {
+		kref_get(&cq->cq_kref);
+		list_add_tail(&cq->ibkill_flush_ent, &flush_list);
+	}
+	xa_unlock(&dev->cq_tbl);
+
+	list_for_each_entry_safe(cq, cq_tmp, &flush_list, ibkill_flush_ent) {
+		ionic_notify_flush_cq(cq);
+		kref_put(&cq->cq_kref, ionic_cq_complete);
+		list_del(&cq->ibkill_flush_ent);
+	}
+}
+
 static void ionic_kill_ibdev(struct ionic_ibdev *dev, bool fatal_path)
 {
 	unsigned long irqflags;
@@ -650,6 +688,9 @@ static void ionic_kill_ibdev(struct ionic_ibdev *dev, bool fatal_path)
 		spin_unlock(&aq->lock);
 	}
 
+	if (do_flush)
+		ionic_flush_qs(dev);
+
 	local_irq_restore(irqflags);
 
 	/* Post a fatal event if requested */
@@ -789,6 +830,65 @@ static void ionic_cq_event(struct ionic_ibdev *dev, u32 cqid, u8 code)
 	kref_put(&cq->cq_kref, ionic_cq_complete);
 }
 
+static void ionic_qp_event(struct ionic_ibdev *dev, u32 qpid, u8 code)
+{
+	unsigned long irqflags;
+	struct ib_event ibev;
+	struct ionic_qp *qp;
+
+	xa_lock_irqsave(&dev->qp_tbl, irqflags);
+	qp = xa_load(&dev->qp_tbl, qpid);
+	if (qp)
+		kref_get(&qp->qp_kref);
+	xa_unlock_irqrestore(&dev->qp_tbl, irqflags);
+
+	if (!qp) {
+		ibdev_dbg(&dev->ibdev,
+			  "missing qpid %#x code %u\n", qpid, code);
+		return;
+	}
+
+	ibev.device = &dev->ibdev;
+	ibev.element.qp = &qp->ibqp;
+
+	switch (code) {
+	case IONIC_V1_EQE_SQ_DRAIN:
+		ibev.event = IB_EVENT_SQ_DRAINED;
+		break;
+
+	case IONIC_V1_EQE_QP_COMM_EST:
+		ibev.event = IB_EVENT_COMM_EST;
+		break;
+
+	case IONIC_V1_EQE_QP_LAST_WQE:
+		ibev.event = IB_EVENT_QP_LAST_WQE_REACHED;
+		break;
+
+	case IONIC_V1_EQE_QP_ERR:
+		ibev.event = IB_EVENT_QP_FATAL;
+		break;
+
+	case IONIC_V1_EQE_QP_ERR_REQUEST:
+		ibev.event = IB_EVENT_QP_REQ_ERR;
+		break;
+
+	case IONIC_V1_EQE_QP_ERR_ACCESS:
+		ibev.event = IB_EVENT_QP_ACCESS_ERR;
+		break;
+
+	default:
+		ibdev_dbg(&dev->ibdev,
+			  "unrecognized qpid %#x code %u\n", qpid, code);
+		goto out;
+	}
+
+	if (qp->ibqp.event_handler)
+		qp->ibqp.event_handler(&ibev, qp->ibqp.qp_context);
+
+out:
+	kref_put(&qp->qp_kref, ionic_qp_complete);
+}
+
 static u16 ionic_poll_eq(struct ionic_eq *eq, u16 budget)
 {
 	struct ionic_ibdev *dev = eq->dev;
@@ -818,6 +918,10 @@ static u16 ionic_poll_eq(struct ionic_eq *eq, u16 budget)
 			ionic_cq_event(dev, qid, code);
 			break;
 
+		case IONIC_V1_EQE_TYPE_QP:
+			ionic_qp_event(dev, qid, code);
+			break;
+
 		default:
 			ibdev_dbg(&dev->ibdev,
 				  "unknown event %#x type %u\n", evt, type);
diff --git a/drivers/infiniband/hw/ionic/ionic_controlpath.c b/drivers/infiniband/hw/ionic/ionic_controlpath.c
index e1130573bd39..52aeb5cf8279 100644
--- a/drivers/infiniband/hw/ionic/ionic_controlpath.c
+++ b/drivers/infiniband/hw/ionic/ionic_controlpath.c
@@ -1,8 +1,19 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
 
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <rdma/ib_addr.h>
+#include <rdma/ib_cache.h>
+#include <rdma/ib_user_verbs.h>
+#include <ionic_api.h>
+
+#include "ionic_fw.h"
 #include "ionic_ibdev.h"
 
+#define ionic_set_ecn(tos)   (((tos) | 2u) & ~1u)
+#define ionic_clear_ecn(tos)  ((tos) & ~3u)
+
 static int ionic_validate_qdesc(struct ionic_qdesc *q)
 {
 	if (!q->addr || !q->size || !q->mask ||
@@ -179,3 +190,2482 @@ void ionic_destroy_cq_common(struct ionic_ibdev *dev, struct ionic_cq *cq)
 
 	cq->vcq = NULL;
 }
+
+static int ionic_validate_qdesc_zero(struct ionic_qdesc *q)
+{
+	if (q->addr || q->size || q->mask || q->depth_log2 || q->stride_log2)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int ionic_get_pdid(struct ionic_ibdev *dev, u32 *pdid)
+{
+	int rc;
+
+	rc = ionic_resid_get(&dev->inuse_pdid);
+	if (rc < 0)
+		return rc;
+
+	*pdid = rc;
+	return 0;
+}
+
+static int ionic_get_ahid(struct ionic_ibdev *dev, u32 *ahid)
+{
+	int rc;
+
+	rc = ionic_resid_get(&dev->inuse_ahid);
+	if (rc < 0)
+		return rc;
+
+	*ahid = rc;
+	return 0;
+}
+
+static int ionic_get_mrid(struct ionic_ibdev *dev, u32 *mrid)
+{
+	int rc;
+
+	/* wrap to 1, skip reserved lkey */
+	rc = ionic_resid_get_shared(&dev->inuse_mrid, 1,
+				    dev->inuse_mrid.inuse_size);
+	if (rc < 0)
+		return rc;
+
+	*mrid = ionic_mrid(rc, dev->next_mrkey++);
+	return 0;
+}
+
+static int ionic_get_gsi_qpid(struct ionic_ibdev *dev, u32 *qpid)
+{
+	int rc = 0;
+
+	rc = ionic_resid_get_shared(&dev->inuse_qpid, IB_QPT_GSI, IB_QPT_GSI + 1);
+	if (rc < 0)
+		return rc;
+
+	*qpid = IB_QPT_GSI;
+	return 0;
+}
+
+static int ionic_get_qpid(struct ionic_ibdev *dev, u32 *qpid,
+			  u8 *udma_idx, u8 udma_mask)
+{
+	unsigned int size, base, bound;
+	int udma_i, udma_x, udma_ix;
+	int rc = -EINVAL;
+
+	udma_x = dev->next_qpid_udma_idx;
+
+	dev->next_qpid_udma_idx ^= dev->lif_cfg.udma_count - 1;
+
+	for (udma_i = 0; udma_i < dev->lif_cfg.udma_count; ++udma_i) {
+		udma_ix = udma_i ^ udma_x;
+
+		if (!(udma_mask & BIT(udma_ix)))
+			continue;
+
+		size = dev->lif_cfg.qp_count / dev->lif_cfg.udma_count;
+		base = size * udma_ix;
+		bound = base + size;
+
+		/* skip reserved SMI and GSI qpids in group zero */
+		if (!base)
+			base = 2;
+
+		rc = ionic_resid_get_shared(&dev->inuse_qpid, base, bound);
+		if (rc >= 0) {
+			*qpid = ionic_bitid_to_qid(rc,
+						   dev->lif_cfg.udma_qgrp_shift,
+						   dev->half_qpid_udma_shift);
+			*udma_idx = udma_ix;
+
+			rc = 0;
+			break;
+		}
+	}
+
+	return rc;
+}
+
+static int ionic_get_dbid(struct ionic_ibdev *dev, u32 *dbid, phys_addr_t *addr)
+{
+	int rc, dbpage_num;
+
+	/* wrap to 1, skip kernel reserved */
+	rc = ionic_resid_get_shared(&dev->inuse_dbid, 1,
+				    dev->inuse_dbid.inuse_size);
+	if (rc < 0)
+		return rc;
+
+	dbpage_num = (dev->lif_cfg.lif_hw_index * dev->lif_cfg.dbid_count) + rc;
+	*addr = dev->lif_cfg.db_phys + ((phys_addr_t)dbpage_num << PAGE_SHIFT);
+
+	*dbid = rc;
+
+	return 0;
+}
+
+static void ionic_put_pdid(struct ionic_ibdev *dev, u32 pdid)
+{
+	ionic_resid_put(&dev->inuse_pdid, pdid);
+}
+
+static void ionic_put_ahid(struct ionic_ibdev *dev, u32 ahid)
+{
+	ionic_resid_put(&dev->inuse_ahid, ahid);
+}
+
+static void ionic_put_mrid(struct ionic_ibdev *dev, u32 mrid)
+{
+	ionic_resid_put(&dev->inuse_mrid, ionic_mrid_index(mrid));
+}
+
+static void ionic_put_qpid(struct ionic_ibdev *dev, u32 qpid)
+{
+	u32 bitid = ionic_qid_to_bitid(qpid,
+				       dev->lif_cfg.udma_qgrp_shift,
+				       dev->half_qpid_udma_shift);
+
+	ionic_resid_put(&dev->inuse_qpid, bitid);
+}
+
+static void ionic_put_dbid(struct ionic_ibdev *dev, u32 dbid)
+{
+	ionic_resid_put(&dev->inuse_dbid, dbid);
+}
+
+static struct rdma_user_mmap_entry*
+ionic_mmap_entry_insert(struct ionic_ctx *ctx, unsigned long size,
+			unsigned long pfn, u8 mmap_flags, u64 *offset)
+{
+	struct ionic_mmap_entry *entry;
+	int rc;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return NULL;
+
+	entry->size = size;
+	entry->pfn = pfn;
+	entry->mmap_flags = mmap_flags;
+
+	rc = rdma_user_mmap_entry_insert(&ctx->ibctx, &entry->rdma_entry,
+					 entry->size);
+	if (rc) {
+		kfree(entry);
+		return NULL;
+	}
+
+	if (offset)
+		*offset = rdma_user_mmap_get_offset(&entry->rdma_entry);
+
+	return &entry->rdma_entry;
+}
+
+int ionic_alloc_ucontext(struct ib_ucontext *ibctx, struct ib_udata *udata)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibctx->device);
+	struct ionic_ctx *ctx = to_ionic_ctx(ibctx);
+	struct ionic_ctx_resp resp = {};
+	struct ionic_ctx_req req;
+	phys_addr_t db_phys = 0;
+	int rc;
+
+	rc = ib_copy_from_udata(&req, udata, sizeof(req));
+	if (rc)
+		return rc;
+
+	/* try to allocate dbid for user ctx */
+	rc = ionic_get_dbid(dev, &ctx->dbid, &db_phys);
+	if (rc < 0)
+		return rc;
+
+	ibdev_dbg(&dev->ibdev, "user space dbid %u\n", ctx->dbid);
+
+	ctx->mmap_dbell = ionic_mmap_entry_insert(ctx, PAGE_SIZE,
+						  PHYS_PFN(db_phys), 0, NULL);
+	if (!ctx->mmap_dbell) {
+		rc = -ENOMEM;
+		goto err_mmap_dbell;
+	}
+
+	resp.page_shift = PAGE_SHIFT;
+
+	resp.dbell_offset = db_phys & ~PAGE_MASK;
+
+	resp.version = dev->lif_cfg.rdma_version;
+	resp.qp_opcodes = dev->lif_cfg.qp_opcodes;
+	resp.admin_opcodes = dev->lif_cfg.admin_opcodes;
+
+	resp.sq_qtype = dev->lif_cfg.sq_qtype;
+	resp.rq_qtype = dev->lif_cfg.rq_qtype;
+	resp.cq_qtype = dev->lif_cfg.cq_qtype;
+	resp.admin_qtype = dev->lif_cfg.aq_qtype;
+	resp.max_stride = dev->lif_cfg.max_stride;
+	resp.max_spec = IONIC_SPEC_HIGH;
+
+	resp.udma_count = dev->lif_cfg.udma_count;
+	resp.expdb_mask = dev->lif_cfg.expdb_mask;
+
+	if (dev->lif_cfg.sq_expdb)
+		resp.expdb_qtypes |= IONIC_EXPDB_SQ;
+	if (dev->lif_cfg.rq_expdb)
+		resp.expdb_qtypes |= IONIC_EXPDB_RQ;
+
+	rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
+	if (rc)
+		goto err_resp;
+
+	return 0;
+
+err_resp:
+	rdma_user_mmap_entry_remove(ctx->mmap_dbell);
+err_mmap_dbell:
+	ionic_put_dbid(dev, ctx->dbid);
+
+	return rc;
+}
+
+void ionic_dealloc_ucontext(struct ib_ucontext *ibctx)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibctx->device);
+	struct ionic_ctx *ctx = to_ionic_ctx(ibctx);
+
+	rdma_user_mmap_entry_remove(ctx->mmap_dbell);
+	ionic_put_dbid(dev, ctx->dbid);
+}
+
+int ionic_mmap(struct ib_ucontext *ibctx, struct vm_area_struct *vma)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibctx->device);
+	struct ionic_ctx *ctx = to_ionic_ctx(ibctx);
+	struct rdma_user_mmap_entry *rdma_entry;
+	struct ionic_mmap_entry *ionic_entry;
+	int rc = 0;
+
+	rdma_entry = rdma_user_mmap_entry_get(&ctx->ibctx, vma);
+	if (!rdma_entry) {
+		ibdev_dbg(&dev->ibdev, "not found %#lx\n",
+			  vma->vm_pgoff << PAGE_SHIFT);
+		return -EINVAL;
+	}
+
+	ionic_entry = container_of(rdma_entry, struct ionic_mmap_entry,
+				   rdma_entry);
+
+	ibdev_dbg(&dev->ibdev, "writecombine? %d\n",
+		  ionic_entry->mmap_flags & IONIC_MMAP_WC);
+	if (ionic_entry->mmap_flags & IONIC_MMAP_WC)
+		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+	else
+		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	ibdev_dbg(&dev->ibdev, "remap st %#lx pf %#lx sz %#lx\n",
+		  vma->vm_start, ionic_entry->pfn, ionic_entry->size);
+	rc = rdma_user_mmap_io(&ctx->ibctx, vma, ionic_entry->pfn,
+			       ionic_entry->size, vma->vm_page_prot,
+			       rdma_entry);
+	if (rc)
+		ibdev_dbg(&dev->ibdev, "remap failed %d\n", rc);
+
+	rdma_user_mmap_entry_put(rdma_entry);
+	return rc;
+}
+
+void ionic_mmap_free(struct rdma_user_mmap_entry *rdma_entry)
+{
+	struct ionic_mmap_entry *ionic_entry;
+
+	ionic_entry = container_of(rdma_entry, struct ionic_mmap_entry,
+				   rdma_entry);
+	kfree(ionic_entry);
+}
+
+int ionic_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibpd->device);
+	struct ionic_pd *pd = to_ionic_pd(ibpd);
+
+	return ionic_get_pdid(dev, &pd->pdid);
+}
+
+int ionic_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibpd->device);
+	struct ionic_pd *pd = to_ionic_pd(ibpd);
+
+	ionic_put_pdid(dev, pd->pdid);
+
+	return 0;
+}
+
+static int ionic_build_hdr(struct ionic_ibdev *dev,
+			   struct ib_ud_header *hdr,
+			   const struct rdma_ah_attr *attr,
+			   u16 sport, bool want_ecn)
+{
+	const struct ib_global_route *grh;
+	enum rdma_network_type net;
+	u16 vlan;
+	int rc;
+
+	if (attr->ah_flags != IB_AH_GRH)
+		return -EINVAL;
+	if (attr->type != RDMA_AH_ATTR_TYPE_ROCE)
+		return -EINVAL;
+
+	grh = rdma_ah_read_grh(attr);
+
+	rc = rdma_read_gid_l2_fields(grh->sgid_attr, &vlan, &hdr->eth.smac_h[0]);
+	if (rc)
+		return rc;
+
+	net = rdma_gid_attr_network_type(grh->sgid_attr);
+
+	rc = ib_ud_header_init(0,	/* no payload */
+			       0,	/* no lrh */
+			       1,	/* yes eth */
+			       vlan != 0xffff,
+			       0,	/* no grh */
+			       net == RDMA_NETWORK_IPV4 ? 4 : 6,
+			       1,	/* yes udp */
+			       0,	/* no imm */
+			       hdr);
+	if (rc)
+		return rc;
+
+	ether_addr_copy(hdr->eth.dmac_h, attr->roce.dmac);
+
+	if (net == RDMA_NETWORK_IPV4) {
+		hdr->eth.type = cpu_to_be16(ETH_P_IP);
+		hdr->ip4.frag_off = cpu_to_be16(0x4000); /* don't fragment */
+		hdr->ip4.ttl = grh->hop_limit;
+		hdr->ip4.tot_len = cpu_to_be16(0xffff);
+		hdr->ip4.saddr =
+			*(const __be32 *)(grh->sgid_attr->gid.raw + 12);
+		hdr->ip4.daddr = *(const __be32 *)(grh->dgid.raw + 12);
+
+		if (want_ecn)
+			hdr->ip4.tos = ionic_set_ecn(grh->traffic_class);
+		else
+			hdr->ip4.tos = ionic_clear_ecn(grh->traffic_class);
+	} else {
+		hdr->eth.type = cpu_to_be16(ETH_P_IPV6);
+		hdr->grh.flow_label = cpu_to_be32(grh->flow_label);
+		hdr->grh.hop_limit = grh->hop_limit;
+		hdr->grh.source_gid = grh->sgid_attr->gid;
+		hdr->grh.destination_gid = grh->dgid;
+
+		if (want_ecn)
+			hdr->grh.traffic_class =
+				ionic_set_ecn(grh->traffic_class);
+		else
+			hdr->grh.traffic_class =
+				ionic_clear_ecn(grh->traffic_class);
+	}
+
+	if (vlan != 0xffff) {
+		vlan |= rdma_ah_get_sl(attr) << VLAN_PRIO_SHIFT;
+		hdr->vlan.tag = cpu_to_be16(vlan);
+		hdr->vlan.type = hdr->eth.type;
+		hdr->eth.type = cpu_to_be16(ETH_P_8021Q);
+	}
+
+	hdr->udp.sport = cpu_to_be16(sport);
+	hdr->udp.dport = cpu_to_be16(ROCE_V2_UDP_DPORT);
+
+	return 0;
+}
+
+static void ionic_set_ah_attr(struct ionic_ibdev *dev,
+			      struct rdma_ah_attr *ah_attr,
+			      struct ib_ud_header *hdr,
+			      int sgid_index)
+{
+	u32 flow_label;
+	u16 vlan = 0;
+	u8  tos, ttl;
+
+	if (hdr->vlan_present)
+		vlan = be16_to_cpu(hdr->vlan.tag);
+
+	if (hdr->ipv4_present) {
+		flow_label = 0;
+		ttl = hdr->ip4.ttl;
+		tos = hdr->ip4.tos;
+		*(__be16 *)(hdr->grh.destination_gid.raw + 10) = cpu_to_be16(0xffff);
+		*(__be32 *)(hdr->grh.destination_gid.raw + 12) = hdr->ip4.daddr;
+	} else {
+		flow_label = be32_to_cpu(hdr->grh.flow_label);
+		ttl = hdr->grh.hop_limit;
+		tos = hdr->grh.traffic_class;
+	}
+
+	memset(ah_attr, 0, sizeof(*ah_attr));
+	ah_attr->type = RDMA_AH_ATTR_TYPE_ROCE;
+	if (hdr->eth_present)
+		memcpy(&ah_attr->roce.dmac, &hdr->eth.dmac_h, ETH_ALEN);
+	rdma_ah_set_sl(ah_attr, vlan >> VLAN_PRIO_SHIFT);
+	rdma_ah_set_port_num(ah_attr, 1);
+	rdma_ah_set_grh(ah_attr, NULL, flow_label, sgid_index, ttl, tos);
+	rdma_ah_set_dgid_raw(ah_attr, &hdr->grh.destination_gid);
+}
+
+static int ionic_create_ah_cmd(struct ionic_ibdev *dev,
+			       struct ionic_ah *ah,
+			       struct ionic_pd *pd,
+			       struct rdma_ah_attr *attr,
+			       u32 flags)
+{
+	struct ionic_admin_wr wr = {
+		.work = COMPLETION_INITIALIZER_ONSTACK(wr.work),
+		.wqe = {
+			.op = IONIC_V1_ADMIN_CREATE_AH,
+			.len = cpu_to_le16(IONIC_ADMIN_CREATE_AH_IN_V1_LEN),
+			.cmd.create_ah = {
+				.pd_id = cpu_to_le32(pd->pdid),
+				.dbid_flags = cpu_to_le16(dev->lif_cfg.dbid),
+				.id_ver = cpu_to_le32(ah->ahid),
+			}
+		}
+	};
+	enum ionic_admin_flags admin_flags = 0;
+	dma_addr_t hdr_dma = 0;
+	void *hdr_buf;
+	gfp_t gfp = GFP_ATOMIC;
+	int rc, hdr_len = 0;
+
+	if (dev->lif_cfg.admin_opcodes <= IONIC_V1_ADMIN_CREATE_AH)
+		return -EBADRQC;
+
+	if (flags & RDMA_CREATE_AH_SLEEPABLE)
+		gfp = GFP_KERNEL;
+	else
+		admin_flags |= IONIC_ADMIN_F_BUSYWAIT;
+
+	rc = ionic_build_hdr(dev, &ah->hdr, attr, IONIC_ROCE_UDP_SPORT, false);
+	if (rc)
+		return rc;
+
+	if (ah->hdr.eth.type == cpu_to_be16(ETH_P_8021Q)) {
+		if (ah->hdr.vlan.type == cpu_to_be16(ETH_P_IP))
+			wr.wqe.cmd.create_ah.csum_profile =
+				IONIC_TFP_CSUM_PROF_ETH_QTAG_IPV4_UDP;
+		else
+			wr.wqe.cmd.create_ah.csum_profile =
+				IONIC_TFP_CSUM_PROF_ETH_QTAG_IPV6_UDP;
+	} else {
+		if (ah->hdr.eth.type == cpu_to_be16(ETH_P_IP))
+			wr.wqe.cmd.create_ah.csum_profile =
+				IONIC_TFP_CSUM_PROF_ETH_IPV4_UDP;
+		else
+			wr.wqe.cmd.create_ah.csum_profile =
+				IONIC_TFP_CSUM_PROF_ETH_IPV6_UDP;
+	}
+
+	ah->sgid_index = rdma_ah_read_grh(attr)->sgid_index;
+
+	hdr_buf = kmalloc(PAGE_SIZE, gfp);
+	if (!hdr_buf)
+		return -ENOMEM;
+
+	hdr_len = ib_ud_header_pack(&ah->hdr, hdr_buf);
+	hdr_len -= IB_BTH_BYTES;
+	hdr_len -= IB_DETH_BYTES;
+	ibdev_dbg(&dev->ibdev, "roce packet header template\n");
+	print_hex_dump_debug("hdr ", DUMP_PREFIX_OFFSET, 16, 1,
+			     hdr_buf, hdr_len, true);
+
+	hdr_dma = dma_map_single(dev->lif_cfg.hwdev, hdr_buf, hdr_len,
+				 DMA_TO_DEVICE);
+
+	rc = dma_mapping_error(dev->lif_cfg.hwdev, hdr_dma);
+	if (rc)
+		goto err_dma;
+
+	wr.wqe.cmd.create_ah.dma_addr = cpu_to_le64(hdr_dma);
+	wr.wqe.cmd.create_ah.length = cpu_to_le32(hdr_len);
+
+	ionic_admin_post(dev, &wr);
+	rc = ionic_admin_wait(dev, &wr, admin_flags);
+
+	dma_unmap_single(dev->lif_cfg.hwdev, hdr_dma, hdr_len,
+			 DMA_TO_DEVICE);
+err_dma:
+	kfree(hdr_buf);
+
+	return rc;
+}
+
+static int ionic_destroy_ah_cmd(struct ionic_ibdev *dev, u32 ahid, u32 flags)
+{
+	struct ionic_admin_wr wr = {
+		.work = COMPLETION_INITIALIZER_ONSTACK(wr.work),
+		.wqe = {
+			.op = IONIC_V1_ADMIN_DESTROY_AH,
+			.len = cpu_to_le16(IONIC_ADMIN_DESTROY_AH_IN_V1_LEN),
+			.cmd.destroy_ah = {
+				.ah_id = cpu_to_le32(ahid),
+			},
+		}
+	};
+	enum ionic_admin_flags admin_flags = IONIC_ADMIN_F_TEARDOWN;
+
+	if (dev->lif_cfg.admin_opcodes <= IONIC_V1_ADMIN_DESTROY_AH)
+		return -EBADRQC;
+
+	if (!(flags & RDMA_CREATE_AH_SLEEPABLE))
+		admin_flags |= IONIC_ADMIN_F_BUSYWAIT;
+
+	ionic_admin_post(dev, &wr);
+	ionic_admin_wait(dev, &wr, admin_flags);
+
+	/* No host-memory resource is associated with ah, so it is ok
+	 * to "succeed" and complete this destroy ah on the host.
+	 */
+	return 0;
+}
+
+int ionic_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
+		    struct ib_udata *udata)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibah->device);
+	struct rdma_ah_attr *attr = init_attr->ah_attr;
+	struct ionic_pd *pd = to_ionic_pd(ibah->pd);
+	struct ionic_ah *ah = to_ionic_ah(ibah);
+	struct ionic_ah_resp resp = {};
+	u32 flags = init_attr->flags;
+	int rc;
+
+	rc = ionic_get_ahid(dev, &ah->ahid);
+	if (rc)
+		return rc;
+
+	rc = ionic_create_ah_cmd(dev, ah, pd, attr, flags);
+	if (rc)
+		goto err_cmd;
+
+	if (udata) {
+		resp.ahid = ah->ahid;
+
+		rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
+		if (rc)
+			goto err_resp;
+	}
+
+	return 0;
+
+err_resp:
+	ionic_destroy_ah_cmd(dev, ah->ahid, flags);
+err_cmd:
+	ionic_put_ahid(dev, ah->ahid);
+	return rc;
+}
+
+int ionic_query_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibah->device);
+	struct ionic_ah *ah = to_ionic_ah(ibah);
+
+	ionic_set_ah_attr(dev, ah_attr, &ah->hdr, ah->sgid_index);
+
+	return 0;
+}
+
+int ionic_destroy_ah(struct ib_ah *ibah, u32 flags)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibah->device);
+	struct ionic_ah *ah = to_ionic_ah(ibah);
+	int rc;
+
+	rc = ionic_destroy_ah_cmd(dev, ah->ahid, flags);
+	if (rc)
+		return rc;
+
+	ionic_put_ahid(dev, ah->ahid);
+
+	return 0;
+}
+
+static int ionic_create_mr_cmd(struct ionic_ibdev *dev,
+			       struct ionic_pd *pd,
+			       struct ionic_mr *mr,
+			       u64 addr,
+			       u64 length)
+{
+	struct ionic_admin_wr wr = {
+		.work = COMPLETION_INITIALIZER_ONSTACK(wr.work),
+		.wqe = {
+			.op = IONIC_V1_ADMIN_CREATE_MR,
+			.len = cpu_to_le16(IONIC_ADMIN_CREATE_MR_IN_V1_LEN),
+			.cmd.create_mr = {
+				.va = cpu_to_le64(addr),
+				.length = cpu_to_le64(length),
+				.pd_id = cpu_to_le32(pd->pdid),
+				.page_size_log2 = mr->buf.page_size_log2,
+				.tbl_index = cpu_to_le32(~0),
+				.map_count = cpu_to_le32(mr->buf.tbl_pages),
+				.dma_addr = ionic_pgtbl_dma(&mr->buf, addr),
+				.dbid_flags = cpu_to_le16(mr->flags),
+				.id_ver = cpu_to_le32(mr->mrid),
+			}
+		}
+	};
+	int rc;
+
+	if (dev->lif_cfg.admin_opcodes <= IONIC_V1_ADMIN_CREATE_MR)
+		return -EBADRQC;
+
+	ionic_admin_post(dev, &wr);
+	rc = ionic_admin_wait(dev, &wr, 0);
+	if (!rc)
+		mr->created = true;
+
+	return rc;
+}
+
+static int ionic_destroy_mr_cmd(struct ionic_ibdev *dev, u32 mrid)
+{
+	struct ionic_admin_wr wr = {
+		.work = COMPLETION_INITIALIZER_ONSTACK(wr.work),
+		.wqe = {
+			.op = IONIC_V1_ADMIN_DESTROY_MR,
+			.len = cpu_to_le16(IONIC_ADMIN_DESTROY_MR_IN_V1_LEN),
+			.cmd.destroy_mr = {
+				.mr_id = cpu_to_le32(mrid),
+			},
+		}
+	};
+
+	if (dev->lif_cfg.admin_opcodes <= IONIC_V1_ADMIN_DESTROY_MR)
+		return -EBADRQC;
+
+	ionic_admin_post(dev, &wr);
+
+	return ionic_admin_wait(dev, &wr, IONIC_ADMIN_F_TEARDOWN);
+}
+
+struct ib_mr *ionic_get_dma_mr(struct ib_pd *ibpd, int access)
+{
+	struct ionic_pd *pd = to_ionic_pd(ibpd);
+	struct ionic_mr *mr;
+
+	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
+
+	mr->ibmr.lkey = IONIC_DMA_LKEY;
+	mr->ibmr.rkey = IONIC_DMA_RKEY;
+
+	if (pd)
+		pd->flags |= IONIC_QPF_PRIVILEGED;
+
+	return &mr->ibmr;
+}
+
+struct ib_mr *ionic_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
+				u64 addr, int access, struct ib_udata *udata)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibpd->device);
+	struct ionic_pd *pd = to_ionic_pd(ibpd);
+	struct ionic_mr *mr;
+	unsigned long pg_sz;
+	int rc;
+
+	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
+
+	rc = ionic_get_mrid(dev, &mr->mrid);
+	if (rc)
+		goto err_mrid;
+
+	mr->ibmr.lkey = mr->mrid;
+	mr->ibmr.rkey = mr->mrid;
+	mr->ibmr.iova = addr;
+	mr->ibmr.length = length;
+
+	mr->flags = IONIC_MRF_USER_MR | to_ionic_mr_flags(access);
+
+	mr->umem = ib_umem_get(&dev->ibdev, start, length, access);
+	if (IS_ERR(mr->umem)) {
+		rc = PTR_ERR(mr->umem);
+		goto err_umem;
+	}
+
+	pg_sz = ib_umem_find_best_pgsz(mr->umem,
+				       dev->lif_cfg.page_size_supported,
+				       addr);
+	if (!pg_sz) {
+		rc = -EINVAL;
+		goto err_pgtbl;
+	}
+
+	rc = ionic_pgtbl_init(dev, &mr->buf, mr->umem, 0, 1, pg_sz);
+	if (rc)
+		goto err_pgtbl;
+
+	rc = ionic_create_mr_cmd(dev, pd, mr, addr, length);
+	if (rc)
+		goto err_cmd;
+
+	ionic_pgtbl_unbuf(dev, &mr->buf);
+
+	return &mr->ibmr;
+
+err_cmd:
+	ionic_pgtbl_unbuf(dev, &mr->buf);
+err_pgtbl:
+	ib_umem_release(mr->umem);
+err_umem:
+	ionic_put_mrid(dev, mr->mrid);
+err_mrid:
+	kfree(mr);
+	return ERR_PTR(rc);
+}
+
+struct ib_mr *ionic_reg_user_mr_dmabuf(struct ib_pd *ibpd, u64 offset,
+				       u64 length, u64 addr, int fd, int access,
+				       struct uverbs_attr_bundle *attrs)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibpd->device);
+	struct ionic_pd *pd = to_ionic_pd(ibpd);
+	struct ib_umem_dmabuf *umem_dmabuf;
+	struct ionic_mr *mr;
+	u64 pg_sz;
+	int rc;
+
+	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
+
+	rc = ionic_get_mrid(dev, &mr->mrid);
+	if (rc)
+		goto err_mrid;
+
+	mr->ibmr.lkey = mr->mrid;
+	mr->ibmr.rkey = mr->mrid;
+	mr->ibmr.iova = addr;
+	mr->ibmr.length = length;
+
+	mr->flags = IONIC_MRF_USER_MR | to_ionic_mr_flags(access);
+
+	umem_dmabuf = ib_umem_dmabuf_get_pinned(&dev->ibdev, offset, length,
+						fd, access);
+	if (IS_ERR(umem_dmabuf)) {
+		rc = PTR_ERR(umem_dmabuf);
+		goto err_umem;
+	}
+
+	mr->umem = &umem_dmabuf->umem;
+
+	pg_sz = ib_umem_find_best_pgsz(mr->umem,
+				       dev->lif_cfg.page_size_supported,
+				       addr);
+	if (!pg_sz) {
+		rc = -EINVAL;
+		goto err_pgtbl;
+	}
+
+	rc = ionic_pgtbl_init(dev, &mr->buf, mr->umem, 0, 1, pg_sz);
+	if (rc)
+		goto err_pgtbl;
+
+	rc = ionic_create_mr_cmd(dev, pd, mr, addr, length);
+	if (rc)
+		goto err_cmd;
+
+	ionic_pgtbl_unbuf(dev, &mr->buf);
+
+	return &mr->ibmr;
+
+err_cmd:
+	ionic_pgtbl_unbuf(dev, &mr->buf);
+err_pgtbl:
+	ib_umem_release(mr->umem);
+err_umem:
+	ionic_put_mrid(dev, mr->mrid);
+err_mrid:
+	kfree(mr);
+	return ERR_PTR(rc);
+}
+
+int ionic_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibmr->device);
+	struct ionic_mr *mr = to_ionic_mr(ibmr);
+	int rc;
+
+	if (!mr->ibmr.lkey)
+		goto out;
+
+	if (mr->created) {
+		rc = ionic_destroy_mr_cmd(dev, mr->mrid);
+		if (rc)
+			return rc;
+	}
+
+	ionic_pgtbl_unbuf(dev, &mr->buf);
+
+	if (mr->umem)
+		ib_umem_release(mr->umem);
+
+	ionic_put_mrid(dev, mr->mrid);
+
+out:
+	kfree(mr);
+
+	return 0;
+}
+
+struct ib_mr *ionic_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type type,
+			     u32 max_sg)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibpd->device);
+	struct ionic_pd *pd = to_ionic_pd(ibpd);
+	struct ionic_mr *mr;
+	int rc;
+
+	if (type != IB_MR_TYPE_MEM_REG)
+		return ERR_PTR(-EINVAL);
+
+	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
+
+	rc = ionic_get_mrid(dev, &mr->mrid);
+	if (rc)
+		goto err_mrid;
+
+	mr->ibmr.lkey = mr->mrid;
+	mr->ibmr.rkey = mr->mrid;
+
+	mr->flags = IONIC_MRF_PHYS_MR;
+
+	rc = ionic_pgtbl_init(dev, &mr->buf, mr->umem, 0, max_sg, PAGE_SIZE);
+	if (rc)
+		goto err_pgtbl;
+
+	mr->buf.tbl_pages = 0;
+
+	rc = ionic_create_mr_cmd(dev, pd, mr, 0, 0);
+	if (rc)
+		goto err_cmd;
+
+	return &mr->ibmr;
+
+err_cmd:
+	ionic_pgtbl_unbuf(dev, &mr->buf);
+err_pgtbl:
+	ionic_put_mrid(dev, mr->mrid);
+err_mrid:
+	kfree(mr);
+	return ERR_PTR(rc);
+}
+
+static int ionic_map_mr_page(struct ib_mr *ibmr, u64 dma)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibmr->device);
+	struct ionic_mr *mr = to_ionic_mr(ibmr);
+
+	ibdev_dbg(&dev->ibdev, "dma %p\n", (void *)dma);
+	return ionic_pgtbl_page(&mr->buf, dma);
+}
+
+int ionic_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
+		    unsigned int *sg_offset)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibmr->device);
+	struct ionic_mr *mr = to_ionic_mr(ibmr);
+	int rc;
+
+	/* mr must be allocated using ib_alloc_mr() */
+	if (unlikely(!mr->buf.tbl_limit))
+		return -EINVAL;
+
+	mr->buf.tbl_pages = 0;
+
+	if (mr->buf.tbl_buf)
+		dma_sync_single_for_cpu(dev->lif_cfg.hwdev, mr->buf.tbl_dma,
+					mr->buf.tbl_size, DMA_TO_DEVICE);
+
+	ibdev_dbg(&dev->ibdev, "sg %p nent %d\n", sg, sg_nents);
+	rc = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, ionic_map_mr_page);
+
+	mr->buf.page_size_log2 = order_base_2(ibmr->page_size);
+
+	if (mr->buf.tbl_buf)
+		dma_sync_single_for_device(dev->lif_cfg.hwdev, mr->buf.tbl_dma,
+					   mr->buf.tbl_size, DMA_TO_DEVICE);
+
+	return rc;
+}
+
+int ionic_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibmw->device);
+	struct ionic_pd *pd = to_ionic_pd(ibmw->pd);
+	struct ionic_mr *mr = to_ionic_mw(ibmw);
+	int rc;
+
+	rc = ionic_get_mrid(dev, &mr->mrid);
+	if (rc)
+		return rc;
+
+	mr->ibmw.rkey = mr->mrid;
+
+	if (mr->ibmw.type == IB_MW_TYPE_1)
+		mr->flags = IONIC_MRF_MW_1;
+	else
+		mr->flags = IONIC_MRF_MW_2;
+
+	rc = ionic_create_mr_cmd(dev, pd, mr, 0, 0);
+	if (rc)
+		goto err_cmd;
+
+	return 0;
+
+err_cmd:
+	ionic_put_mrid(dev, mr->mrid);
+	return rc;
+}
+
+int ionic_dealloc_mw(struct ib_mw *ibmw)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibmw->device);
+	struct ionic_mr *mr = to_ionic_mw(ibmw);
+	int rc;
+
+	rc = ionic_destroy_mr_cmd(dev, mr->mrid);
+	if (rc)
+		return rc;
+
+	ionic_put_mrid(dev, mr->mrid);
+
+	return 0;
+}
+
+static int ionic_create_cq_cmd(struct ionic_ibdev *dev,
+			       struct ionic_ctx *ctx,
+			       struct ionic_cq *cq,
+			       struct ionic_tbl_buf *buf)
+{
+	const u16 dbid = ionic_ctx_dbid(dev, ctx);
+	struct ionic_admin_wr wr = {
+		.work = COMPLETION_INITIALIZER_ONSTACK(wr.work),
+		.wqe = {
+			.op = IONIC_V1_ADMIN_CREATE_CQ,
+			.len = cpu_to_le16(IONIC_ADMIN_CREATE_CQ_IN_V1_LEN),
+			.cmd.create_cq = {
+				.eq_id = cpu_to_le32(cq->eqid),
+				.depth_log2 = cq->q.depth_log2,
+				.stride_log2 = cq->q.stride_log2,
+				.page_size_log2 = buf->page_size_log2,
+				.tbl_index = cpu_to_le32(~0),
+				.map_count = cpu_to_le32(buf->tbl_pages),
+				.dma_addr = ionic_pgtbl_dma(buf, 0),
+				.dbid_flags = cpu_to_le16(dbid),
+				.id_ver = cpu_to_le32(cq->cqid),
+			}
+		}
+	};
+
+	if (dev->lif_cfg.admin_opcodes <= IONIC_V1_ADMIN_CREATE_CQ)
+		return -EBADRQC;
+
+	ionic_admin_post(dev, &wr);
+
+	return ionic_admin_wait(dev, &wr, 0);
+}
+
+static int ionic_destroy_cq_cmd(struct ionic_ibdev *dev, u32 cqid)
+{
+	struct ionic_admin_wr wr = {
+		.work = COMPLETION_INITIALIZER_ONSTACK(wr.work),
+		.wqe = {
+			.op = IONIC_V1_ADMIN_DESTROY_CQ,
+			.len = cpu_to_le16(IONIC_ADMIN_DESTROY_CQ_IN_V1_LEN),
+			.cmd.destroy_cq = {
+				.cq_id = cpu_to_le32(cqid),
+			},
+		}
+	};
+
+	if (dev->lif_cfg.admin_opcodes <= IONIC_V1_ADMIN_DESTROY_CQ)
+		return -EBADRQC;
+
+	ionic_admin_post(dev, &wr);
+
+	return ionic_admin_wait(dev, &wr, IONIC_ADMIN_F_TEARDOWN);
+}
+
+int ionic_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		    struct uverbs_attr_bundle *attrs)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibcq->device);
+	struct ib_udata *udata = &attrs->driver_udata;
+	struct ionic_ctx *ctx =
+		rdma_udata_to_drv_context(udata, struct ionic_ctx, ibctx);
+	struct ionic_vcq *vcq = to_ionic_vcq(ibcq);
+	struct ionic_tbl_buf buf = {};
+	struct ionic_cq_resp resp;
+	struct ionic_cq_req req;
+	int udma_idx = 0, rc;
+
+	if (udata) {
+		rc = ib_copy_from_udata(&req, udata, sizeof(req));
+		if (rc)
+			return rc;
+	}
+
+	vcq->udma_mask = BIT(dev->lif_cfg.udma_count) - 1;
+
+	if (udata)
+		vcq->udma_mask &= req.udma_mask;
+
+	if (!vcq->udma_mask) {
+		rc = -EINVAL;
+		goto err_init;
+	}
+
+	for (; udma_idx < dev->lif_cfg.udma_count; ++udma_idx) {
+		if (!(vcq->udma_mask & BIT(udma_idx)))
+			continue;
+
+		rc = ionic_create_cq_common(vcq, &buf, attr, ctx, udata,
+					    &req.cq[udma_idx],
+					    &resp.cqid[udma_idx],
+					    udma_idx);
+		if (rc)
+			goto err_init;
+
+		rc = ionic_create_cq_cmd(dev, ctx, &vcq->cq[udma_idx], &buf);
+		if (rc)
+			goto err_cmd;
+
+		ionic_pgtbl_unbuf(dev, &buf);
+	}
+
+	vcq->ibcq.cqe = attr->cqe;
+
+	if (udata) {
+		resp.udma_mask = vcq->udma_mask;
+
+		rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
+		if (rc)
+			goto err_resp;
+	}
+
+	return 0;
+
+err_resp:
+	while (udma_idx) {
+		--udma_idx;
+		if (!(vcq->udma_mask & BIT(udma_idx)))
+			continue;
+		ionic_destroy_cq_cmd(dev, vcq->cq[udma_idx].cqid);
+err_cmd:
+		ionic_pgtbl_unbuf(dev, &buf);
+		ionic_destroy_cq_common(dev, &vcq->cq[udma_idx]);
+err_init:
+		;
+	}
+
+	return rc;
+}
+
+int ionic_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibcq->device);
+	struct ionic_vcq *vcq = to_ionic_vcq(ibcq);
+	int udma_idx, rc_tmp, rc = 0;
+
+	for (udma_idx = dev->lif_cfg.udma_count; udma_idx; ) {
+		--udma_idx;
+
+		if (!(vcq->udma_mask & BIT(udma_idx)))
+			continue;
+
+		rc_tmp = ionic_destroy_cq_cmd(dev, vcq->cq[udma_idx].cqid);
+		if (rc_tmp) {
+			if (!rc)
+				rc = rc_tmp;
+
+			continue;
+		}
+
+		ionic_destroy_cq_common(dev, &vcq->cq[udma_idx]);
+	}
+
+	return rc;
+}
+
+static bool pd_remote_privileged(struct ib_pd *pd)
+{
+	return pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY;
+}
+
+static int ionic_create_qp_cmd(struct ionic_ibdev *dev,
+			       struct ionic_pd *pd,
+			       struct ionic_cq *send_cq,
+			       struct ionic_cq *recv_cq,
+			       struct ionic_qp *qp,
+			       struct ionic_tbl_buf *sq_buf,
+			       struct ionic_tbl_buf *rq_buf,
+			       struct ib_qp_init_attr *attr)
+{
+	const u16 dbid = ionic_obj_dbid(dev, pd->ibpd.uobject);
+	const u32 flags = to_ionic_qp_flags(0, 0,
+					    qp->sq_cmb & IONIC_CMB_ENABLE,
+					    qp->rq_cmb & IONIC_CMB_ENABLE,
+					    qp->sq_spec, qp->rq_spec,
+					    pd->flags & IONIC_QPF_PRIVILEGED,
+					    pd_remote_privileged(&pd->ibpd));
+	struct ionic_admin_wr wr = {
+		.work = COMPLETION_INITIALIZER_ONSTACK(wr.work),
+		.wqe = {
+			.op = IONIC_V1_ADMIN_CREATE_QP,
+			.len = cpu_to_le16(IONIC_ADMIN_CREATE_QP_IN_V1_LEN),
+			.cmd.create_qp = {
+				.pd_id = cpu_to_le32(pd->pdid),
+				.priv_flags = cpu_to_be32(flags),
+				.type_state = to_ionic_qp_type(attr->qp_type),
+				.dbid_flags = cpu_to_le16(dbid),
+				.id_ver = cpu_to_le32(qp->qpid),
+			}
+		}
+	};
+
+	if (dev->lif_cfg.admin_opcodes <= IONIC_V1_ADMIN_CREATE_QP)
+		return -EBADRQC;
+
+	if (qp->has_sq) {
+		wr.wqe.cmd.create_qp.sq_cq_id = cpu_to_le32(send_cq->cqid);
+		wr.wqe.cmd.create_qp.sq_depth_log2 = qp->sq.depth_log2;
+		wr.wqe.cmd.create_qp.sq_stride_log2 = qp->sq.stride_log2;
+		wr.wqe.cmd.create_qp.sq_page_size_log2 = sq_buf->page_size_log2;
+		wr.wqe.cmd.create_qp.sq_tbl_index_xrcd_id = cpu_to_le32(~0);
+		wr.wqe.cmd.create_qp.sq_map_count =
+			cpu_to_le32(sq_buf->tbl_pages);
+		wr.wqe.cmd.create_qp.sq_dma_addr = ionic_pgtbl_dma(sq_buf, 0);
+	}
+
+	if (qp->has_rq) {
+		wr.wqe.cmd.create_qp.rq_cq_id = cpu_to_le32(recv_cq->cqid);
+		wr.wqe.cmd.create_qp.rq_depth_log2 = qp->rq.depth_log2;
+		wr.wqe.cmd.create_qp.rq_stride_log2 = qp->rq.stride_log2;
+		wr.wqe.cmd.create_qp.rq_page_size_log2 = rq_buf->page_size_log2;
+		wr.wqe.cmd.create_qp.rq_tbl_index_srq_id = cpu_to_le32(~0);
+		wr.wqe.cmd.create_qp.rq_map_count =
+			cpu_to_le32(rq_buf->tbl_pages);
+		wr.wqe.cmd.create_qp.rq_dma_addr = ionic_pgtbl_dma(rq_buf, 0);
+	}
+
+	ionic_admin_post(dev, &wr);
+
+	return ionic_admin_wait(dev, &wr, 0);
+}
+
+static int ionic_modify_qp_cmd(struct ionic_ibdev *dev,
+			       struct ionic_pd *pd,
+			       struct ionic_qp *qp,
+			       struct ib_qp_attr *attr,
+			       int mask)
+{
+	const u32 flags = to_ionic_qp_flags(attr->qp_access_flags,
+					    attr->en_sqd_async_notify,
+					    qp->sq_cmb & IONIC_CMB_ENABLE,
+					    qp->rq_cmb & IONIC_CMB_ENABLE,
+					    qp->sq_spec, qp->rq_spec,
+					    pd->flags & IONIC_QPF_PRIVILEGED,
+					    pd_remote_privileged(qp->ibqp.pd));
+	const u8 state = to_ionic_qp_modify_state(attr->qp_state,
+						  attr->cur_qp_state);
+	struct ionic_admin_wr wr = {
+		.work = COMPLETION_INITIALIZER_ONSTACK(wr.work),
+		.wqe = {
+			.op = IONIC_V1_ADMIN_MODIFY_QP,
+			.len = cpu_to_le16(IONIC_ADMIN_MODIFY_QP_IN_V1_LEN),
+			.cmd.mod_qp = {
+				.attr_mask = cpu_to_be32(mask),
+				.access_flags = cpu_to_be16(flags),
+				.rq_psn = cpu_to_le32(attr->rq_psn),
+				.sq_psn = cpu_to_le32(attr->sq_psn),
+				.rate_limit_kbps =
+					cpu_to_le32(attr->rate_limit),
+				.pmtu = (attr->path_mtu + 7),
+				.retry = (attr->retry_cnt |
+					  (attr->rnr_retry << 4)),
+				.rnr_timer = attr->min_rnr_timer,
+				.retry_timeout = attr->timeout,
+				.type_state = state,
+				.id_ver = cpu_to_le32(qp->qpid),
+			}
+		}
+	};
+	const struct ib_global_route *grh = rdma_ah_read_grh(&attr->ah_attr);
+	void *hdr_buf = NULL;
+	dma_addr_t hdr_dma = 0;
+	int rc, hdr_len = 0;
+	u16 sport;
+
+	if (dev->lif_cfg.admin_opcodes <= IONIC_V1_ADMIN_MODIFY_QP)
+		return -EBADRQC;
+
+	if ((mask & IB_QP_MAX_DEST_RD_ATOMIC) && attr->max_dest_rd_atomic) {
+		/* Note, round up/down was already done for allocating
+		 * resources on the device. The allocation order is in cache
+		 * line size.  We can't use the order of the resource
+		 * allocation to determine the order wqes here, because for
+		 * queue length <= one cache line it is not distinct.
+		 *
+		 * Therefore, order wqes is computed again here.
+		 *
+		 * Account for hole and round up to the next order.
+		 */
+		wr.wqe.cmd.mod_qp.rsq_depth =
+			order_base_2(attr->max_dest_rd_atomic + 1);
+		wr.wqe.cmd.mod_qp.rsq_index = cpu_to_le32(~0);
+	}
+
+	if ((mask & IB_QP_MAX_QP_RD_ATOMIC) && attr->max_rd_atomic) {
+		/* Account for hole and round down to the next order */
+		wr.wqe.cmd.mod_qp.rrq_depth =
+			order_base_2(attr->max_rd_atomic + 2) - 1;
+		wr.wqe.cmd.mod_qp.rrq_index = cpu_to_le32(~0);
+	}
+
+	if (qp->ibqp.qp_type == IB_QPT_RC || qp->ibqp.qp_type == IB_QPT_UC)
+		wr.wqe.cmd.mod_qp.qkey_dest_qpn =
+			cpu_to_le32(attr->dest_qp_num);
+	else
+		wr.wqe.cmd.mod_qp.qkey_dest_qpn = cpu_to_le32(attr->qkey);
+
+	if (mask & IB_QP_AV) {
+		if (!qp->hdr)
+			return -ENOMEM;
+
+		sport = rdma_get_udp_sport(grh->flow_label,
+					   qp->qpid,
+					   attr->dest_qp_num);
+
+		rc = ionic_build_hdr(dev, qp->hdr, &attr->ah_attr, sport, true);
+		if (rc)
+			return rc;
+
+		qp->sgid_index = grh->sgid_index;
+
+		hdr_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+		if (!hdr_buf)
+			return -ENOMEM;
+
+		hdr_len = ib_ud_header_pack(qp->hdr, hdr_buf);
+		hdr_len -= IB_BTH_BYTES;
+		hdr_len -= IB_DETH_BYTES;
+		ibdev_dbg(&dev->ibdev, "roce packet header template\n");
+		print_hex_dump_debug("hdr ", DUMP_PREFIX_OFFSET, 16, 1,
+				     hdr_buf, hdr_len, true);
+
+		hdr_dma = dma_map_single(dev->lif_cfg.hwdev, hdr_buf, hdr_len,
+					 DMA_TO_DEVICE);
+
+		rc = dma_mapping_error(dev->lif_cfg.hwdev, hdr_dma);
+		if (rc)
+			goto err_dma;
+
+		if (qp->hdr->ipv4_present) {
+			wr.wqe.cmd.mod_qp.tfp_csum_profile =
+				qp->hdr->vlan_present ?
+					IONIC_TFP_CSUM_PROF_ETH_QTAG_IPV4_UDP :
+					IONIC_TFP_CSUM_PROF_ETH_IPV4_UDP;
+		} else {
+			wr.wqe.cmd.mod_qp.tfp_csum_profile =
+				qp->hdr->vlan_present ?
+					IONIC_TFP_CSUM_PROF_ETH_QTAG_IPV6_UDP :
+					IONIC_TFP_CSUM_PROF_ETH_IPV6_UDP;
+		}
+
+		wr.wqe.cmd.mod_qp.ah_id_len =
+			cpu_to_le32(qp->ahid | (hdr_len << 24));
+		wr.wqe.cmd.mod_qp.dma_addr = cpu_to_le64(hdr_dma);
+
+		wr.wqe.cmd.mod_qp.en_pcp = attr->ah_attr.sl;
+		wr.wqe.cmd.mod_qp.ip_dscp = grh->traffic_class >> 2;
+	}
+
+	ionic_admin_post(dev, &wr);
+
+	rc = ionic_admin_wait(dev, &wr, 0);
+
+	if (mask & IB_QP_AV)
+		dma_unmap_single(dev->lif_cfg.hwdev, hdr_dma, hdr_len,
+				 DMA_TO_DEVICE);
+err_dma:
+	if (mask & IB_QP_AV)
+		kfree(hdr_buf);
+
+	return rc;
+}
+
+static int ionic_query_qp_cmd(struct ionic_ibdev *dev,
+			      struct ionic_qp *qp,
+			      struct ib_qp_attr *attr,
+			      int mask)
+{
+	struct ionic_admin_wr wr = {
+		.work = COMPLETION_INITIALIZER_ONSTACK(wr.work),
+		.wqe = {
+			.op = IONIC_V1_ADMIN_QUERY_QP,
+			.len = cpu_to_le16(IONIC_ADMIN_QUERY_QP_IN_V1_LEN),
+			.cmd.query_qp = {
+				.id_ver = cpu_to_le32(qp->qpid),
+			},
+		}
+	};
+	struct ionic_v1_admin_query_qp_sq *query_sqbuf;
+	struct ionic_v1_admin_query_qp_rq *query_rqbuf;
+	dma_addr_t query_sqdma;
+	dma_addr_t query_rqdma;
+	dma_addr_t hdr_dma = 0;
+	void *hdr_buf = NULL;
+	int flags, rc;
+
+	if (dev->lif_cfg.admin_opcodes <= IONIC_V1_ADMIN_QUERY_QP)
+		return -EBADRQC;
+
+	if (qp->has_sq) {
+		bool expdb = !!(qp->sq_cmb & IONIC_CMB_EXPDB);
+
+		attr->cap.max_send_sge =
+			ionic_v1_send_wqe_max_sge(qp->sq.stride_log2,
+						  qp->sq_spec,
+						  expdb);
+		attr->cap.max_inline_data =
+			ionic_v1_send_wqe_max_data(qp->sq.stride_log2, expdb);
+	}
+
+	if (qp->has_rq) {
+		attr->cap.max_recv_sge =
+			ionic_v1_recv_wqe_max_sge(qp->rq.stride_log2,
+						  qp->rq_spec,
+						  qp->rq_cmb & IONIC_CMB_EXPDB);
+	}
+
+	query_sqbuf = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!query_sqbuf)
+		return -ENOMEM;
+
+	query_rqbuf = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!query_rqbuf) {
+		rc = -ENOMEM;
+		goto err_rqbuf;
+	}
+
+	query_sqdma = dma_map_single(dev->lif_cfg.hwdev, query_sqbuf, PAGE_SIZE,
+				     DMA_FROM_DEVICE);
+	rc = dma_mapping_error(dev->lif_cfg.hwdev, query_sqdma);
+	if (rc)
+		goto err_sqdma;
+
+	query_rqdma = dma_map_single(dev->lif_cfg.hwdev, query_rqbuf, PAGE_SIZE,
+				     DMA_FROM_DEVICE);
+	rc = dma_mapping_error(dev->lif_cfg.hwdev, query_rqdma);
+	if (rc)
+		goto err_rqdma;
+
+	if (mask & IB_QP_AV) {
+		hdr_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+		if (!hdr_buf) {
+			rc = -ENOMEM;
+			goto err_hdrbuf;
+		}
+
+		hdr_dma = dma_map_single(dev->lif_cfg.hwdev, hdr_buf,
+					 PAGE_SIZE, DMA_FROM_DEVICE);
+		rc = dma_mapping_error(dev->lif_cfg.hwdev, hdr_dma);
+		if (rc)
+			goto err_hdrdma;
+	}
+
+	wr.wqe.cmd.query_qp.sq_dma_addr = cpu_to_le64(query_sqdma);
+	wr.wqe.cmd.query_qp.rq_dma_addr = cpu_to_le64(query_rqdma);
+	wr.wqe.cmd.query_qp.hdr_dma_addr = cpu_to_le64(hdr_dma);
+	wr.wqe.cmd.query_qp.ah_id = cpu_to_le32(qp->ahid);
+
+	ionic_admin_post(dev, &wr);
+
+	rc = ionic_admin_wait(dev, &wr, 0);
+
+	if (rc)
+		goto err_hdrdma;
+
+	flags = be16_to_cpu(query_sqbuf->access_perms_flags |
+			    query_rqbuf->access_perms_flags);
+
+	print_hex_dump_debug("sqbuf ", DUMP_PREFIX_OFFSET, 16, 1,
+			     query_sqbuf, sizeof(*query_sqbuf), true);
+	print_hex_dump_debug("rqbuf ", DUMP_PREFIX_OFFSET, 16, 1,
+			     query_rqbuf, sizeof(*query_rqbuf), true);
+	ibdev_dbg(&dev->ibdev, "query qp %u state_pmtu %#x flags %#x",
+		  qp->qpid, query_rqbuf->state_pmtu, flags);
+
+	attr->qp_state = from_ionic_qp_state(query_rqbuf->state_pmtu >> 4);
+	attr->cur_qp_state = attr->qp_state;
+	attr->path_mtu = (query_rqbuf->state_pmtu & 0xf) - 7;
+	attr->path_mig_state = IB_MIG_MIGRATED;
+	attr->qkey = be32_to_cpu(query_sqbuf->qkey_dest_qpn);
+	attr->rq_psn = be32_to_cpu(query_sqbuf->rq_psn);
+	attr->sq_psn = be32_to_cpu(query_rqbuf->sq_psn);
+	attr->dest_qp_num = attr->qkey;
+	attr->qp_access_flags = from_ionic_qp_flags(flags);
+	attr->pkey_index = 0;
+	attr->alt_pkey_index = 0;
+	attr->en_sqd_async_notify = !!(flags & IONIC_QPF_SQD_NOTIFY);
+	attr->sq_draining = !!(flags & IONIC_QPF_SQ_DRAINING);
+	attr->max_rd_atomic = BIT(query_rqbuf->rrq_depth) - 1;
+	attr->max_dest_rd_atomic = BIT(query_rqbuf->rsq_depth) - 1;
+	attr->min_rnr_timer = query_sqbuf->rnr_timer;
+	attr->port_num = 0;
+	attr->timeout = query_sqbuf->retry_timeout;
+	attr->retry_cnt = query_rqbuf->retry_rnrtry & 0xf;
+	attr->rnr_retry = query_rqbuf->retry_rnrtry >> 4;
+	attr->alt_port_num = 0;
+	attr->alt_timeout = 0;
+	attr->rate_limit = be32_to_cpu(query_sqbuf->rate_limit_kbps);
+
+	if (mask & IB_QP_AV)
+		ionic_set_ah_attr(dev, &attr->ah_attr,
+				  qp->hdr, qp->sgid_index);
+
+err_hdrdma:
+	if (mask & IB_QP_AV) {
+		dma_unmap_single(dev->lif_cfg.hwdev, hdr_dma,
+				 PAGE_SIZE, DMA_FROM_DEVICE);
+		kfree(hdr_buf);
+	}
+err_hdrbuf:
+	dma_unmap_single(dev->lif_cfg.hwdev, query_rqdma, sizeof(*query_rqbuf),
+			 DMA_FROM_DEVICE);
+err_rqdma:
+	dma_unmap_single(dev->lif_cfg.hwdev, query_sqdma, sizeof(*query_sqbuf),
+			 DMA_FROM_DEVICE);
+err_sqdma:
+	kfree(query_rqbuf);
+err_rqbuf:
+	kfree(query_sqbuf);
+
+	return rc;
+}
+
+static int ionic_destroy_qp_cmd(struct ionic_ibdev *dev, u32 qpid)
+{
+	struct ionic_admin_wr wr = {
+		.work = COMPLETION_INITIALIZER_ONSTACK(wr.work),
+		.wqe = {
+			.op = IONIC_V1_ADMIN_DESTROY_QP,
+			.len = cpu_to_le16(IONIC_ADMIN_DESTROY_QP_IN_V1_LEN),
+			.cmd.destroy_qp = {
+				.qp_id = cpu_to_le32(qpid),
+			},
+		}
+	};
+
+	if (dev->lif_cfg.admin_opcodes <= IONIC_V1_ADMIN_DESTROY_QP)
+		return -EBADRQC;
+
+	ionic_admin_post(dev, &wr);
+
+	return ionic_admin_wait(dev, &wr, IONIC_ADMIN_F_TEARDOWN);
+}
+
+static bool ionic_expdb_wqe_size_supported(struct ionic_ibdev *dev,
+					   uint32_t wqe_size)
+{
+	switch (wqe_size) {
+	case 64: return dev->lif_cfg.expdb_mask & IONIC_EXPDB_64;
+	case 128: return dev->lif_cfg.expdb_mask & IONIC_EXPDB_128;
+	case 256: return dev->lif_cfg.expdb_mask & IONIC_EXPDB_256;
+	case 512: return dev->lif_cfg.expdb_mask & IONIC_EXPDB_512;
+	}
+
+	return false;
+}
+
+static void ionic_qp_sq_init_cmb(struct ionic_ibdev *dev,
+				 struct ionic_qp *qp,
+				 struct ib_udata *udata,
+				 int max_data)
+{
+	u8 expdb_stride_log2 = 0;
+	bool expdb;
+	int rc;
+
+	if (!(qp->sq_cmb & IONIC_CMB_ENABLE))
+		goto not_in_cmb;
+
+	if (qp->sq_cmb & ~IONIC_CMB_SUPPORTED) {
+		if (qp->sq_cmb & IONIC_CMB_REQUIRE)
+			goto not_in_cmb;
+
+		qp->sq_cmb &= IONIC_CMB_SUPPORTED;
+	}
+
+	if ((qp->sq_cmb & IONIC_CMB_EXPDB) && !dev->lif_cfg.sq_expdb) {
+		if (qp->sq_cmb & IONIC_CMB_REQUIRE)
+			goto not_in_cmb;
+
+		qp->sq_cmb &= ~IONIC_CMB_EXPDB;
+	}
+
+	qp->sq_cmb_order = order_base_2(qp->sq.size / PAGE_SIZE);
+
+	if (qp->sq_cmb_order >= IONIC_SQCMB_ORDER)
+		goto not_in_cmb;
+
+	if (qp->sq_cmb & IONIC_CMB_EXPDB)
+		expdb_stride_log2 = qp->sq.stride_log2;
+
+	rc = ionic_get_cmb(dev->lif_cfg.lif, &qp->sq_cmb_pgid,
+			   &qp->sq_cmb_addr, qp->sq_cmb_order,
+			   expdb_stride_log2, &expdb);
+	if (rc)
+		goto not_in_cmb;
+
+	if ((qp->sq_cmb & IONIC_CMB_EXPDB) && !expdb) {
+		if (qp->sq_cmb & IONIC_CMB_REQUIRE)
+			goto err_map;
+
+		qp->sq_cmb &= ~IONIC_CMB_EXPDB;
+	}
+
+	return;
+
+err_map:
+	ionic_put_cmb(dev->lif_cfg.lif, qp->sq_cmb_pgid, qp->sq_cmb_order);
+not_in_cmb:
+	if (qp->sq_cmb & IONIC_CMB_REQUIRE)
+		ibdev_dbg(&dev->ibdev, "could not place sq in cmb as required\n");
+
+	qp->sq_cmb = 0;
+	qp->sq_cmb_order = IONIC_RES_INVALID;
+	qp->sq_cmb_pgid = 0;
+	qp->sq_cmb_addr = 0;
+}
+
+static void ionic_qp_sq_destroy_cmb(struct ionic_ibdev *dev,
+				    struct ionic_ctx *ctx,
+				    struct ionic_qp *qp)
+{
+	if (!(qp->sq_cmb & IONIC_CMB_ENABLE))
+		return;
+
+	if (ctx)
+		rdma_user_mmap_entry_remove(qp->mmap_sq_cmb);
+
+	ionic_put_cmb(dev->lif_cfg.lif, qp->sq_cmb_pgid, qp->sq_cmb_order);
+}
+
+static int ionic_qp_sq_init(struct ionic_ibdev *dev, struct ionic_ctx *ctx,
+			    struct ionic_qp *qp, struct ionic_qdesc *sq,
+			    struct ionic_tbl_buf *buf, int max_wr, int max_sge,
+			    int max_data, int sq_spec, struct ib_udata *udata)
+{
+	u32 wqe_size;
+	int rc = 0;
+
+	qp->sq_msn_prod = 0;
+	qp->sq_msn_cons = 0;
+
+	if (!qp->has_sq) {
+		if (buf) {
+			buf->tbl_buf = NULL;
+			buf->tbl_limit = 0;
+			buf->tbl_pages = 0;
+		}
+		if (udata)
+			rc = ionic_validate_qdesc_zero(sq);
+
+		return rc;
+	}
+
+	rc = -EINVAL;
+
+	if (max_wr < 0 || max_wr > 0xffff)
+		return rc;
+
+	if (max_sge < 1)
+		return rc;
+
+	if (max_sge > min(ionic_v1_send_wqe_max_sge(dev->lif_cfg.max_stride, 0,
+						    qp->sq_cmb &
+						    IONIC_CMB_EXPDB),
+			  IONIC_SPEC_HIGH))
+		return rc;
+
+	if (max_data < 0)
+		return rc;
+
+	if (max_data > ionic_v1_send_wqe_max_data(dev->lif_cfg.max_stride,
+						  qp->sq_cmb & IONIC_CMB_EXPDB))
+		return rc;
+
+	if (udata) {
+		rc = ionic_validate_qdesc(sq);
+		if (rc)
+			return rc;
+
+		qp->sq_spec = sq_spec;
+
+		qp->sq.ptr = NULL;
+		qp->sq.size = sq->size;
+		qp->sq.mask = sq->mask;
+		qp->sq.depth_log2 = sq->depth_log2;
+		qp->sq.stride_log2 = sq->stride_log2;
+
+		qp->sq_meta = NULL;
+		qp->sq_msn_idx = NULL;
+
+		qp->sq_umem = ib_umem_get(&dev->ibdev, sq->addr, sq->size, 0);
+		if (IS_ERR(qp->sq_umem))
+			return PTR_ERR(qp->sq_umem);
+	} else {
+		qp->sq_umem = NULL;
+
+		qp->sq_spec = ionic_v1_use_spec_sge(max_sge, sq_spec);
+		if (sq_spec && !qp->sq_spec)
+			ibdev_dbg(&dev->ibdev,
+				  "init sq: max_sge %u disables spec\n",
+				  max_sge);
+
+		if (qp->sq_cmb & IONIC_CMB_EXPDB) {
+			wqe_size = ionic_v1_send_wqe_min_size(max_sge, max_data,
+							      qp->sq_spec,
+							      true);
+
+			if (!ionic_expdb_wqe_size_supported(dev, wqe_size))
+				qp->sq_cmb &= ~IONIC_CMB_EXPDB;
+		}
+
+		if (!(qp->sq_cmb & IONIC_CMB_EXPDB))
+			wqe_size = ionic_v1_send_wqe_min_size(max_sge, max_data,
+							      qp->sq_spec,
+							      false);
+
+		rc = ionic_queue_init(&qp->sq, dev->lif_cfg.hwdev,
+				      max_wr, wqe_size);
+		if (rc)
+			return rc;
+
+		ionic_queue_dbell_init(&qp->sq, qp->qpid);
+
+		qp->sq_meta = kmalloc_array((u32)qp->sq.mask + 1,
+					    sizeof(*qp->sq_meta),
+					    GFP_KERNEL);
+		if (!qp->sq_meta) {
+			rc = -ENOMEM;
+			goto err_sq_meta;
+		}
+
+		qp->sq_msn_idx = kmalloc_array((u32)qp->sq.mask + 1,
+					       sizeof(*qp->sq_msn_idx),
+					       GFP_KERNEL);
+		if (!qp->sq_msn_idx) {
+			rc = -ENOMEM;
+			goto err_sq_msn;
+		}
+	}
+
+	ionic_qp_sq_init_cmb(dev, qp, udata, max_data);
+
+	if (qp->sq_cmb & IONIC_CMB_ENABLE)
+		rc = ionic_pgtbl_init(dev, buf, NULL,
+				      (u64)qp->sq_cmb_pgid << PAGE_SHIFT,
+				      1, PAGE_SIZE);
+	else
+		rc = ionic_pgtbl_init(dev, buf,
+				      qp->sq_umem, qp->sq.dma, 1, PAGE_SIZE);
+	if (rc)
+		goto err_sq_tbl;
+
+	return 0;
+
+err_sq_tbl:
+	ionic_qp_sq_destroy_cmb(dev, ctx, qp);
+	kfree(qp->sq_msn_idx);
+err_sq_msn:
+	kfree(qp->sq_meta);
+err_sq_meta:
+	if (qp->sq_umem)
+		ib_umem_release(qp->sq_umem);
+	else
+		ionic_queue_destroy(&qp->sq, dev->lif_cfg.hwdev);
+	return rc;
+}
+
+static void ionic_qp_sq_destroy(struct ionic_ibdev *dev,
+				struct ionic_ctx *ctx,
+				struct ionic_qp *qp)
+{
+	if (!qp->has_sq)
+		return;
+
+	ionic_qp_sq_destroy_cmb(dev, ctx, qp);
+
+	kfree(qp->sq_msn_idx);
+	kfree(qp->sq_meta);
+
+	if (qp->sq_umem)
+		ib_umem_release(qp->sq_umem);
+	else
+		ionic_queue_destroy(&qp->sq, dev->lif_cfg.hwdev);
+}
+
+static void ionic_qp_rq_init_cmb(struct ionic_ibdev *dev,
+				 struct ionic_qp *qp,
+				 struct ib_udata *udata)
+{
+	u8 expdb_stride_log2 = 0;
+	bool expdb;
+	int rc;
+
+	if (!(qp->rq_cmb & IONIC_CMB_ENABLE))
+		goto not_in_cmb;
+
+	if (qp->rq_cmb & ~IONIC_CMB_SUPPORTED) {
+		if (qp->rq_cmb & IONIC_CMB_REQUIRE)
+			goto not_in_cmb;
+
+		qp->rq_cmb &= IONIC_CMB_SUPPORTED;
+	}
+
+	if ((qp->rq_cmb & IONIC_CMB_EXPDB) && !dev->lif_cfg.rq_expdb) {
+		if (qp->rq_cmb & IONIC_CMB_REQUIRE)
+			goto not_in_cmb;
+
+		qp->rq_cmb &= ~IONIC_CMB_EXPDB;
+	}
+
+	qp->rq_cmb_order = order_base_2(qp->rq.size / PAGE_SIZE);
+
+	if (qp->rq_cmb_order >= IONIC_RQCMB_ORDER)
+		goto not_in_cmb;
+
+	if (qp->rq_cmb & IONIC_CMB_EXPDB)
+		expdb_stride_log2 = qp->rq.stride_log2;
+
+	rc = ionic_get_cmb(dev->lif_cfg.lif, &qp->rq_cmb_pgid,
+			   &qp->rq_cmb_addr, qp->rq_cmb_order,
+			   expdb_stride_log2, &expdb);
+	if (rc)
+		goto not_in_cmb;
+
+	if ((qp->rq_cmb & IONIC_CMB_EXPDB) && !expdb) {
+		if (qp->rq_cmb & IONIC_CMB_REQUIRE)
+			goto err_map;
+
+		qp->rq_cmb &= ~IONIC_CMB_EXPDB;
+	}
+
+	return;
+
+err_map:
+	ionic_put_cmb(dev->lif_cfg.lif, qp->rq_cmb_pgid, qp->rq_cmb_order);
+not_in_cmb:
+	if (qp->rq_cmb & IONIC_CMB_REQUIRE)
+		ibdev_dbg(&dev->ibdev, "could not place rq in cmb as required\n");
+
+	qp->rq_cmb = 0;
+	qp->rq_cmb_order = IONIC_RES_INVALID;
+	qp->rq_cmb_pgid = 0;
+	qp->rq_cmb_addr = 0;
+}
+
+static void ionic_qp_rq_destroy_cmb(struct ionic_ibdev *dev,
+				    struct ionic_ctx *ctx,
+				    struct ionic_qp *qp)
+{
+	if (!(qp->rq_cmb & IONIC_CMB_ENABLE))
+		return;
+
+	if (ctx)
+		rdma_user_mmap_entry_remove(qp->mmap_rq_cmb);
+
+	ionic_put_cmb(dev->lif_cfg.lif, qp->rq_cmb_pgid, qp->rq_cmb_order);
+}
+
+static int ionic_qp_rq_init(struct ionic_ibdev *dev, struct ionic_ctx *ctx,
+			    struct ionic_qp *qp, struct ionic_qdesc *rq,
+			    struct ionic_tbl_buf *buf, int max_wr, int max_sge,
+			    int rq_spec, struct ib_udata *udata)
+{
+	int rc = 0, i;
+	u32 wqe_size;
+
+	if (!qp->has_rq) {
+		if (buf) {
+			buf->tbl_buf = NULL;
+			buf->tbl_limit = 0;
+			buf->tbl_pages = 0;
+		}
+		if (udata)
+			rc = ionic_validate_qdesc_zero(rq);
+
+		return rc;
+	}
+
+	rc = -EINVAL;
+
+	if (max_wr < 0 || max_wr > 0xffff)
+		return rc;
+
+	if (max_sge < 1)
+		return rc;
+
+	if (max_sge > min(ionic_v1_recv_wqe_max_sge(dev->lif_cfg.max_stride, 0, false),
+			  IONIC_SPEC_HIGH))
+		return rc;
+
+	if (udata) {
+		rc = ionic_validate_qdesc(rq);
+		if (rc)
+			return rc;
+
+		qp->rq_spec = rq_spec;
+
+		qp->rq.ptr = NULL;
+		qp->rq.size = rq->size;
+		qp->rq.mask = rq->mask;
+		qp->rq.depth_log2 = rq->depth_log2;
+		qp->rq.stride_log2 = rq->stride_log2;
+
+		qp->rq_meta = NULL;
+
+		qp->rq_umem = ib_umem_get(&dev->ibdev, rq->addr, rq->size, 0);
+		if (IS_ERR(qp->rq_umem))
+			return PTR_ERR(qp->rq_umem);
+	} else {
+		qp->rq_umem = NULL;
+
+		qp->rq_spec = ionic_v1_use_spec_sge(max_sge, rq_spec);
+		if (rq_spec && !qp->rq_spec)
+			ibdev_dbg(&dev->ibdev,
+				  "init rq: max_sge %u disables spec\n",
+				  max_sge);
+
+		if (qp->rq_cmb & IONIC_CMB_EXPDB) {
+			wqe_size = ionic_v1_recv_wqe_min_size(max_sge,
+							      qp->rq_spec,
+							      true);
+
+			if (!ionic_expdb_wqe_size_supported(dev, wqe_size))
+				qp->rq_cmb &= ~IONIC_CMB_EXPDB;
+		}
+
+		if (!(qp->rq_cmb & IONIC_CMB_EXPDB))
+			wqe_size = ionic_v1_recv_wqe_min_size(max_sge,
+							      qp->rq_spec,
+							      false);
+
+		rc = ionic_queue_init(&qp->rq, dev->lif_cfg.hwdev,
+				      max_wr, wqe_size);
+		if (rc)
+			return rc;
+
+		ionic_queue_dbell_init(&qp->rq, qp->qpid);
+
+		qp->rq_meta = kmalloc_array((u32)qp->rq.mask + 1,
+					    sizeof(*qp->rq_meta),
+					    GFP_KERNEL);
+		if (!qp->rq_meta) {
+			rc = -ENOMEM;
+			goto err_rq_meta;
+		}
+
+		for (i = 0; i < qp->rq.mask; ++i)
+			qp->rq_meta[i].next = &qp->rq_meta[i + 1];
+		qp->rq_meta[i].next = IONIC_META_LAST;
+		qp->rq_meta_head = &qp->rq_meta[0];
+	}
+
+	ionic_qp_rq_init_cmb(dev, qp, udata);
+
+	if (qp->rq_cmb & IONIC_CMB_ENABLE)
+		rc = ionic_pgtbl_init(dev, buf, NULL,
+				      (u64)qp->rq_cmb_pgid << PAGE_SHIFT,
+				      1, PAGE_SIZE);
+	else
+		rc = ionic_pgtbl_init(dev, buf,
+				      qp->rq_umem, qp->rq.dma, 1, PAGE_SIZE);
+	if (rc)
+		goto err_rq_tbl;
+
+	return 0;
+
+err_rq_tbl:
+	ionic_qp_rq_destroy_cmb(dev, ctx, qp);
+	kfree(qp->rq_meta);
+err_rq_meta:
+	if (qp->rq_umem)
+		ib_umem_release(qp->rq_umem);
+	else
+		ionic_queue_destroy(&qp->rq, dev->lif_cfg.hwdev);
+	return rc;
+}
+
+static void ionic_qp_rq_destroy(struct ionic_ibdev *dev,
+				struct ionic_ctx *ctx,
+				struct ionic_qp *qp)
+{
+	if (!qp->has_rq)
+		return;
+
+	ionic_qp_rq_destroy_cmb(dev, ctx, qp);
+
+	kfree(qp->rq_meta);
+
+	if (qp->rq_umem)
+		ib_umem_release(qp->rq_umem);
+	else
+		ionic_queue_destroy(&qp->rq, dev->lif_cfg.hwdev);
+}
+
+int ionic_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
+		    struct ib_udata *udata)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibqp->device);
+	struct ionic_tbl_buf sq_buf = {}, rq_buf = {};
+	struct ionic_pd *pd = to_ionic_pd(ibqp->pd);
+	struct ionic_qp *qp = to_ionic_qp(ibqp);
+	struct ionic_ctx *ctx =
+		rdma_udata_to_drv_context(udata, struct ionic_ctx, ibctx);
+	struct ionic_qp_resp resp = {};
+	struct ionic_qp_req req = {};
+	struct ionic_cq *cq;
+	u8 udma_mask;
+	void *entry;
+	int rc;
+
+	if (udata) {
+		rc = ib_copy_from_udata(&req, udata, sizeof(req));
+		if (rc)
+			return rc;
+	} else {
+		req.sq_spec = IONIC_SPEC_HIGH;
+		req.rq_spec = IONIC_SPEC_HIGH;
+	}
+
+	if (attr->qp_type == IB_QPT_SMI || attr->qp_type > IB_QPT_UD)
+		return -EOPNOTSUPP;
+
+	qp->state = IB_QPS_RESET;
+
+	INIT_LIST_HEAD(&qp->cq_poll_sq);
+	INIT_LIST_HEAD(&qp->cq_flush_sq);
+	INIT_LIST_HEAD(&qp->cq_flush_rq);
+
+	spin_lock_init(&qp->sq_lock);
+	spin_lock_init(&qp->rq_lock);
+
+	qp->has_sq = 1;
+	qp->has_rq = 1;
+
+	if (attr->qp_type == IB_QPT_GSI) {
+		rc = ionic_get_gsi_qpid(dev, &qp->qpid);
+	} else {
+		udma_mask = BIT(dev->lif_cfg.udma_count) - 1;
+
+		if (qp->has_sq)
+			udma_mask &= to_ionic_vcq(attr->send_cq)->udma_mask;
+
+		if (qp->has_rq)
+			udma_mask &= to_ionic_vcq(attr->recv_cq)->udma_mask;
+
+		if (udata && req.udma_mask)
+			udma_mask &= req.udma_mask;
+
+		if (!udma_mask)
+			return -EINVAL;
+
+		rc = ionic_get_qpid(dev, &qp->qpid, &qp->udma_idx, udma_mask);
+	}
+	if (rc)
+		return rc;
+
+	qp->sig_all = attr->sq_sig_type == IB_SIGNAL_ALL_WR;
+	qp->has_ah = attr->qp_type == IB_QPT_RC;
+
+	if (qp->has_ah) {
+		qp->hdr = kzalloc(sizeof(*qp->hdr), GFP_KERNEL);
+		if (!qp->hdr) {
+			rc = -ENOMEM;
+			goto err_ah_alloc;
+		}
+
+		rc = ionic_get_ahid(dev, &qp->ahid);
+		if (rc)
+			goto err_ahid;
+	}
+
+	if (udata) {
+		if (req.rq_cmb & IONIC_CMB_ENABLE)
+			qp->rq_cmb = req.rq_cmb;
+
+		if (req.sq_cmb & IONIC_CMB_ENABLE)
+			qp->sq_cmb = req.sq_cmb;
+	}
+
+	rc = ionic_qp_sq_init(dev, ctx, qp, &req.sq, &sq_buf,
+			      attr->cap.max_send_wr, attr->cap.max_send_sge,
+			      attr->cap.max_inline_data, req.sq_spec, udata);
+	if (rc)
+		goto err_sq;
+
+	rc = ionic_qp_rq_init(dev, ctx, qp, &req.rq, &rq_buf,
+			      attr->cap.max_recv_wr, attr->cap.max_recv_sge,
+			      req.rq_spec, udata);
+	if (rc)
+		goto err_rq;
+
+	rc = ionic_create_qp_cmd(dev, pd,
+				 to_ionic_vcq_cq(attr->send_cq, qp->udma_idx),
+				 to_ionic_vcq_cq(attr->recv_cq, qp->udma_idx),
+				 qp, &sq_buf, &rq_buf, attr);
+	if (rc)
+		goto err_cmd;
+
+	if (udata) {
+		resp.qpid = qp->qpid;
+		resp.udma_idx = qp->udma_idx;
+
+		if (qp->sq_cmb & IONIC_CMB_ENABLE) {
+			bool wc;
+
+			if ((qp->sq_cmb & (IONIC_CMB_WC | IONIC_CMB_UC)) ==
+				(IONIC_CMB_WC | IONIC_CMB_UC)) {
+				ibdev_dbg(&dev->ibdev,
+					  "Both sq_cmb flags IONIC_CMB_WC and IONIC_CMB_UC are set, using default driver mapping\n");
+				qp->sq_cmb &= ~(IONIC_CMB_WC | IONIC_CMB_UC);
+			}
+
+			wc = (qp->sq_cmb & (IONIC_CMB_WC | IONIC_CMB_UC))
+					!= IONIC_CMB_UC;
+
+			/* let userspace know the mapping */
+			if (wc)
+				qp->sq_cmb |= IONIC_CMB_WC;
+			else
+				qp->sq_cmb |= IONIC_CMB_UC;
+
+			qp->mmap_sq_cmb =
+			    ionic_mmap_entry_insert(ctx,
+						    qp->sq.size,
+						    PHYS_PFN(qp->sq_cmb_addr),
+						    wc ? IONIC_MMAP_WC : 0,
+						    &resp.sq_cmb_offset);
+			if (!qp->mmap_sq_cmb) {
+				rc = -ENOMEM;
+				goto err_mmap_sq;
+			}
+
+			resp.sq_cmb = qp->sq_cmb;
+		}
+
+		if (qp->rq_cmb & IONIC_CMB_ENABLE) {
+			bool wc;
+
+			if ((qp->rq_cmb & (IONIC_CMB_WC | IONIC_CMB_UC)) ==
+				(IONIC_CMB_WC | IONIC_CMB_UC)) {
+				ibdev_dbg(&dev->ibdev,
+					  "Both rq_cmb flags IONIC_CMB_WC and IONIC_CMB_UC are set, using default driver mapping\n");
+				qp->rq_cmb &= ~(IONIC_CMB_WC | IONIC_CMB_UC);
+			}
+
+			if (qp->rq_cmb & IONIC_CMB_EXPDB)
+				wc = (qp->rq_cmb & (IONIC_CMB_WC | IONIC_CMB_UC))
+					== IONIC_CMB_WC;
+			else
+				wc = (qp->rq_cmb & (IONIC_CMB_WC | IONIC_CMB_UC))
+					!= IONIC_CMB_UC;
+
+			/* let userspace know the mapping */
+			if (wc)
+				qp->rq_cmb |= IONIC_CMB_WC;
+			else
+				qp->rq_cmb |= IONIC_CMB_UC;
+
+			qp->mmap_rq_cmb =
+			    ionic_mmap_entry_insert(ctx,
+						    qp->rq.size,
+						    PHYS_PFN(qp->rq_cmb_addr),
+						    wc ? IONIC_MMAP_WC : 0,
+						    &resp.rq_cmb_offset);
+			if (!qp->mmap_rq_cmb) {
+				rc = -ENOMEM;
+				goto err_mmap_rq;
+			}
+
+			resp.rq_cmb = qp->rq_cmb;
+		}
+
+		rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
+		if (rc)
+			goto err_resp;
+	}
+
+	ionic_pgtbl_unbuf(dev, &rq_buf);
+	ionic_pgtbl_unbuf(dev, &sq_buf);
+
+	qp->ibqp.qp_num = qp->qpid;
+
+	init_completion(&qp->qp_rel_comp);
+	kref_init(&qp->qp_kref);
+
+	entry = xa_store_irq(&dev->qp_tbl, qp->qpid, qp, GFP_KERNEL);
+	if (entry) {
+		if (!xa_is_err(entry))
+			rc = -EINVAL;
+		else
+			rc = xa_err(entry);
+
+		goto err_resp;
+	}
+
+	if (qp->has_sq) {
+		cq = to_ionic_vcq_cq(attr->send_cq, qp->udma_idx);
+
+		attr->cap.max_send_wr = qp->sq.mask;
+		attr->cap.max_send_sge =
+			ionic_v1_send_wqe_max_sge(qp->sq.stride_log2,
+						  qp->sq_spec,
+						  qp->sq_cmb & IONIC_CMB_EXPDB);
+		attr->cap.max_inline_data =
+			ionic_v1_send_wqe_max_data(qp->sq.stride_log2,
+						   qp->sq_cmb &
+						   IONIC_CMB_EXPDB);
+		qp->sq_cqid = cq->cqid;
+	}
+
+	if (qp->has_rq) {
+		cq = to_ionic_vcq_cq(attr->recv_cq, qp->udma_idx);
+
+		attr->cap.max_recv_wr = qp->rq.mask;
+		attr->cap.max_recv_sge =
+			ionic_v1_recv_wqe_max_sge(qp->rq.stride_log2,
+						  qp->rq_spec,
+						  qp->rq_cmb & IONIC_CMB_EXPDB);
+		qp->rq_cqid = cq->cqid;
+	}
+
+	return 0;
+
+err_resp:
+	if (udata && (qp->rq_cmb & IONIC_CMB_ENABLE))
+		rdma_user_mmap_entry_remove(qp->mmap_rq_cmb);
+err_mmap_rq:
+	if (udata && (qp->sq_cmb & IONIC_CMB_ENABLE))
+		rdma_user_mmap_entry_remove(qp->mmap_sq_cmb);
+err_mmap_sq:
+	ionic_destroy_qp_cmd(dev, qp->qpid);
+err_cmd:
+	ionic_pgtbl_unbuf(dev, &rq_buf);
+	ionic_qp_rq_destroy(dev, ctx, qp);
+err_rq:
+	ionic_pgtbl_unbuf(dev, &sq_buf);
+	ionic_qp_sq_destroy(dev, ctx, qp);
+err_sq:
+	if (qp->has_ah)
+		ionic_put_ahid(dev, qp->ahid);
+err_ahid:
+	kfree(qp->hdr);
+err_ah_alloc:
+	ionic_put_qpid(dev, qp->qpid);
+	return rc;
+}
+
+void ionic_notify_flush_cq(struct ionic_cq *cq)
+{
+	if (cq->flush && cq->vcq->ibcq.comp_handler)
+		cq->vcq->ibcq.comp_handler(&cq->vcq->ibcq,
+					   cq->vcq->ibcq.cq_context);
+}
+
+static void ionic_notify_qp_cqs(struct ionic_ibdev *dev, struct ionic_qp *qp)
+{
+	if (qp->ibqp.send_cq)
+		ionic_notify_flush_cq(to_ionic_vcq_cq(qp->ibqp.send_cq,
+						      qp->udma_idx));
+	if (qp->ibqp.recv_cq && qp->ibqp.recv_cq != qp->ibqp.send_cq)
+		ionic_notify_flush_cq(to_ionic_vcq_cq(qp->ibqp.recv_cq,
+						      qp->udma_idx));
+}
+
+void ionic_flush_qp(struct ionic_ibdev *dev, struct ionic_qp *qp)
+{
+	unsigned long irqflags;
+	struct ionic_cq *cq;
+
+	if (qp->ibqp.send_cq) {
+		cq = to_ionic_vcq_cq(qp->ibqp.send_cq, qp->udma_idx);
+
+		/* Hold the CQ lock and QP sq_lock to set up flush */
+		spin_lock_irqsave(&cq->lock, irqflags);
+		spin_lock(&qp->sq_lock);
+		qp->sq_flush = true;
+		if (!ionic_queue_empty(&qp->sq)) {
+			cq->flush = true;
+			list_move_tail(&qp->cq_flush_sq, &cq->flush_sq);
+		}
+		spin_unlock(&qp->sq_lock);
+		spin_unlock_irqrestore(&cq->lock, irqflags);
+	}
+
+	if (qp->ibqp.recv_cq) {
+		cq = to_ionic_vcq_cq(qp->ibqp.recv_cq, qp->udma_idx);
+
+		/* Hold the CQ lock and QP rq_lock to set up flush */
+		spin_lock_irqsave(&cq->lock, irqflags);
+		spin_lock(&qp->rq_lock);
+		qp->rq_flush = true;
+		if (!ionic_queue_empty(&qp->rq)) {
+			cq->flush = true;
+			list_move_tail(&qp->cq_flush_rq, &cq->flush_rq);
+		}
+		spin_unlock(&qp->rq_lock);
+		spin_unlock_irqrestore(&cq->lock, irqflags);
+	}
+}
+
+static void ionic_clean_cq(struct ionic_cq *cq, u32 qpid)
+{
+	struct ionic_v1_cqe *qcqe;
+	int prod, qtf, qid, type;
+	bool color;
+
+	if (!cq->q.ptr)
+		return;
+
+	color = cq->color;
+	prod = cq->q.prod;
+	qcqe = ionic_queue_at(&cq->q, prod);
+
+	while (color == ionic_v1_cqe_color(qcqe)) {
+		qtf = ionic_v1_cqe_qtf(qcqe);
+		qid = ionic_v1_cqe_qtf_qid(qtf);
+		type = ionic_v1_cqe_qtf_type(qtf);
+
+		if (qid == qpid && type != IONIC_V1_CQE_TYPE_ADMIN)
+			ionic_v1_cqe_clean(qcqe);
+
+		prod = ionic_queue_next(&cq->q, prod);
+		qcqe = ionic_queue_at(&cq->q, prod);
+		color = ionic_color_wrap(prod, color);
+	}
+}
+
+static void ionic_reset_qp(struct ionic_ibdev *dev, struct ionic_qp *qp)
+{
+	unsigned long irqflags;
+	struct ionic_cq *cq;
+	int i;
+
+	local_irq_save(irqflags);
+
+	if (qp->ibqp.send_cq) {
+		cq = to_ionic_vcq_cq(qp->ibqp.send_cq, qp->udma_idx);
+		spin_lock(&cq->lock);
+		ionic_clean_cq(cq, qp->qpid);
+		spin_unlock(&cq->lock);
+	}
+
+	if (qp->ibqp.recv_cq) {
+		cq = to_ionic_vcq_cq(qp->ibqp.recv_cq, qp->udma_idx);
+		spin_lock(&cq->lock);
+		ionic_clean_cq(cq, qp->qpid);
+		spin_unlock(&cq->lock);
+	}
+
+	if (qp->has_sq) {
+		spin_lock(&qp->sq_lock);
+		qp->sq_flush = false;
+		qp->sq_flush_rcvd = false;
+		qp->sq_msn_prod = 0;
+		qp->sq_msn_cons = 0;
+		qp->sq.prod = 0;
+		qp->sq.cons = 0;
+		spin_unlock(&qp->sq_lock);
+	}
+
+	if (qp->has_rq) {
+		spin_lock(&qp->rq_lock);
+		qp->rq_flush = false;
+		qp->rq.prod = 0;
+		qp->rq.cons = 0;
+		if (qp->rq_meta) {
+			for (i = 0; i < qp->rq.mask; ++i)
+				qp->rq_meta[i].next = &qp->rq_meta[i + 1];
+			qp->rq_meta[i].next = IONIC_META_LAST;
+		}
+		qp->rq_meta_head = &qp->rq_meta[0];
+		spin_unlock(&qp->rq_lock);
+	}
+
+	local_irq_restore(irqflags);
+}
+
+static bool ionic_qp_cur_state_is_ok(enum ib_qp_state q_state,
+				     enum ib_qp_state attr_state)
+{
+	if (q_state == attr_state)
+		return true;
+
+	if (attr_state == IB_QPS_ERR)
+		return true;
+
+	if (attr_state == IB_QPS_SQE)
+		return q_state == IB_QPS_RTS || q_state == IB_QPS_SQD;
+
+	return false;
+}
+
+static int ionic_check_modify_qp(struct ionic_qp *qp, struct ib_qp_attr *attr,
+				 int mask)
+{
+	enum ib_qp_state cur_state = (mask & IB_QP_CUR_STATE) ?
+		attr->cur_qp_state : qp->state;
+	enum ib_qp_state next_state = (mask & IB_QP_STATE) ?
+		attr->qp_state : cur_state;
+
+	if ((mask & IB_QP_CUR_STATE) &&
+	    !ionic_qp_cur_state_is_ok(qp->state, attr->cur_qp_state))
+		return -EINVAL;
+
+	if (!ib_modify_qp_is_ok(cur_state, next_state, qp->ibqp.qp_type, mask))
+		return -EINVAL;
+
+	/* unprivileged qp not allowed privileged qkey */
+	if ((mask & IB_QP_QKEY) && (attr->qkey & 0x80000000) &&
+	    qp->ibqp.uobject)
+		return -EPERM;
+
+	return 0;
+}
+
+int ionic_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int mask,
+		    struct ib_udata *udata)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibqp->device);
+	struct ionic_pd *pd = to_ionic_pd(ibqp->pd);
+	struct ionic_qp *qp = to_ionic_qp(ibqp);
+	int rc;
+
+	rc = ionic_check_modify_qp(qp, attr, mask);
+	if (rc)
+		return rc;
+
+	if (mask & IB_QP_CAP)
+		return -EINVAL;
+
+	rc = ionic_modify_qp_cmd(dev, pd, qp, attr, mask);
+	if (rc)
+		return rc;
+
+	if (mask & IB_QP_STATE) {
+		qp->state = attr->qp_state;
+
+		if (attr->qp_state == IB_QPS_ERR) {
+			ionic_flush_qp(dev, qp);
+			ionic_notify_qp_cqs(dev, qp);
+		} else if (attr->qp_state == IB_QPS_RESET) {
+			ionic_reset_qp(dev, qp);
+		}
+	}
+
+	return 0;
+}
+
+int ionic_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
+		   int mask, struct ib_qp_init_attr *init_attr)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibqp->device);
+	struct ionic_qp *qp = to_ionic_qp(ibqp);
+	int rc;
+
+	memset(attr, 0, sizeof(*attr));
+	memset(init_attr, 0, sizeof(*init_attr));
+
+	rc = ionic_query_qp_cmd(dev, qp, attr, mask);
+	if (rc)
+		return rc;
+
+	if (qp->has_sq)
+		attr->cap.max_send_wr = qp->sq.mask;
+
+	if (qp->has_rq)
+		attr->cap.max_recv_wr = qp->rq.mask;
+
+	init_attr->event_handler = ibqp->event_handler;
+	init_attr->qp_context = ibqp->qp_context;
+	init_attr->send_cq = ibqp->send_cq;
+	init_attr->recv_cq = ibqp->recv_cq;
+	init_attr->srq = ibqp->srq;
+	init_attr->xrcd = ibqp->xrcd;
+	init_attr->cap = attr->cap;
+	init_attr->sq_sig_type = qp->sig_all ?
+		IB_SIGNAL_ALL_WR : IB_SIGNAL_REQ_WR;
+	init_attr->qp_type = ibqp->qp_type;
+	init_attr->create_flags = 0;
+	init_attr->port_num = 0;
+	init_attr->rwq_ind_tbl = ibqp->rwq_ind_tbl;
+	init_attr->source_qpn = 0;
+
+	return rc;
+}
+
+int ionic_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
+{
+	struct ionic_ctx *ctx =
+		rdma_udata_to_drv_context(udata, struct ionic_ctx, ibctx);
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibqp->device);
+	struct ionic_qp *qp = to_ionic_qp(ibqp);
+	unsigned long irqflags;
+	struct ionic_cq *cq;
+	int rc;
+
+	rc = ionic_destroy_qp_cmd(dev, qp->qpid);
+	if (rc)
+		return rc;
+
+	xa_erase_irq(&dev->qp_tbl, qp->qpid);
+
+	kref_put(&qp->qp_kref, ionic_qp_complete);
+	wait_for_completion(&qp->qp_rel_comp);
+
+	if (qp->ibqp.send_cq) {
+		cq = to_ionic_vcq_cq(qp->ibqp.send_cq, qp->udma_idx);
+		spin_lock_irqsave(&cq->lock, irqflags);
+		ionic_clean_cq(cq, qp->qpid);
+		list_del(&qp->cq_poll_sq);
+		list_del(&qp->cq_flush_sq);
+		spin_unlock_irqrestore(&cq->lock, irqflags);
+	}
+
+	if (qp->ibqp.recv_cq) {
+		cq = to_ionic_vcq_cq(qp->ibqp.recv_cq, qp->udma_idx);
+		spin_lock_irqsave(&cq->lock, irqflags);
+		ionic_clean_cq(cq, qp->qpid);
+		list_del(&qp->cq_flush_rq);
+		spin_unlock_irqrestore(&cq->lock, irqflags);
+	}
+
+	ionic_qp_rq_destroy(dev, ctx, qp);
+	ionic_qp_sq_destroy(dev, ctx, qp);
+	if (qp->has_ah) {
+		ionic_put_ahid(dev, qp->ahid);
+		kfree(qp->hdr);
+	}
+	ionic_put_qpid(dev, qp->qpid);
+
+	return 0;
+}
diff --git a/drivers/infiniband/hw/ionic/ionic_fw.h b/drivers/infiniband/hw/ionic/ionic_fw.h
index 44ec69487519..8c1c0a07c527 100644
--- a/drivers/infiniband/hw/ionic/ionic_fw.h
+++ b/drivers/infiniband/hw/ionic/ionic_fw.h
@@ -5,6 +5,266 @@
 #define _IONIC_FW_H_
 
 #include <linux/kernel.h>
+#include <rdma/ib_verbs.h>
+
+/* common for ib spec */
+
+#define IONIC_EXP_DBELL_SZ		8
+
+enum ionic_mrid_bits {
+	IONIC_MRID_INDEX_SHIFT		= 8,
+};
+
+static inline u32 ionic_mrid(u32 index, u8 key)
+{
+	return (index << IONIC_MRID_INDEX_SHIFT) | key;
+}
+
+static inline u32 ionic_mrid_index(u32 lrkey)
+{
+	return lrkey >> IONIC_MRID_INDEX_SHIFT;
+}
+
+/* common to all versions */
+
+/* wqe scatter gather element */
+struct ionic_sge {
+	__be64				va;
+	__be32				len;
+	__be32				lkey;
+};
+
+/* admin queue mr type */
+enum ionic_mr_flags {
+	/* bits that determine mr access */
+	IONIC_MRF_LOCAL_WRITE		= BIT(0),
+	IONIC_MRF_REMOTE_WRITE		= BIT(1),
+	IONIC_MRF_REMOTE_READ		= BIT(2),
+	IONIC_MRF_REMOTE_ATOMIC		= BIT(3),
+	IONIC_MRF_MW_BIND		= BIT(4),
+	IONIC_MRF_ZERO_BASED		= BIT(5),
+	IONIC_MRF_ON_DEMAND		= BIT(6),
+	IONIC_MRF_PB			= BIT(7),
+	IONIC_MRF_ACCESS_MASK		= BIT(12) - 1,
+
+	/* bits that determine mr type */
+	IONIC_MRF_UKEY_EN		= BIT(13),
+	IONIC_MRF_IS_MW			= BIT(14),
+	IONIC_MRF_INV_EN		= BIT(15),
+
+	/* base flags combinations for mr types */
+	IONIC_MRF_USER_MR		= 0,
+	IONIC_MRF_PHYS_MR		= (IONIC_MRF_UKEY_EN |
+					   IONIC_MRF_INV_EN),
+	IONIC_MRF_MW_1			= (IONIC_MRF_UKEY_EN |
+					   IONIC_MRF_IS_MW),
+	IONIC_MRF_MW_2			= (IONIC_MRF_UKEY_EN |
+					   IONIC_MRF_IS_MW |
+					   IONIC_MRF_INV_EN),
+};
+
+static inline int to_ionic_mr_flags(int access)
+{
+	int flags = 0;
+
+	if (access & IB_ACCESS_LOCAL_WRITE)
+		flags |= IONIC_MRF_LOCAL_WRITE;
+
+	if (access & IB_ACCESS_REMOTE_READ)
+		flags |= IONIC_MRF_REMOTE_READ;
+
+	if (access & IB_ACCESS_REMOTE_WRITE)
+		flags |= IONIC_MRF_REMOTE_WRITE;
+
+	if (access & IB_ACCESS_REMOTE_ATOMIC)
+		flags |= IONIC_MRF_REMOTE_ATOMIC;
+
+	if (access & IB_ACCESS_MW_BIND)
+		flags |= IONIC_MRF_MW_BIND;
+
+	if (access & IB_ZERO_BASED)
+		flags |= IONIC_MRF_ZERO_BASED;
+
+	return flags;
+}
+
+enum ionic_qp_flags {
+	/* bits that determine qp access */
+	IONIC_QPF_REMOTE_WRITE		= BIT(0),
+	IONIC_QPF_REMOTE_READ		= BIT(1),
+	IONIC_QPF_REMOTE_ATOMIC		= BIT(2),
+
+	/* bits that determine other qp behavior */
+	IONIC_QPF_SQ_PB			= BIT(6),
+	IONIC_QPF_RQ_PB			= BIT(7),
+	IONIC_QPF_SQ_SPEC		= BIT(8),
+	IONIC_QPF_RQ_SPEC		= BIT(9),
+	IONIC_QPF_REMOTE_PRIVILEGED	= BIT(10),
+	IONIC_QPF_SQ_DRAINING		= BIT(11),
+	IONIC_QPF_SQD_NOTIFY		= BIT(12),
+	IONIC_QPF_SQ_CMB		= BIT(13),
+	IONIC_QPF_RQ_CMB		= BIT(14),
+	IONIC_QPF_PRIVILEGED		= BIT(15),
+};
+
+static inline int from_ionic_qp_flags(int flags)
+{
+	int access_flags = 0;
+
+	if (flags & IONIC_QPF_REMOTE_WRITE)
+		access_flags |= IB_ACCESS_REMOTE_WRITE;
+
+	if (flags & IONIC_QPF_REMOTE_READ)
+		access_flags |= IB_ACCESS_REMOTE_READ;
+
+	if (flags & IONIC_QPF_REMOTE_ATOMIC)
+		access_flags |= IB_ACCESS_REMOTE_ATOMIC;
+
+	return access_flags;
+}
+
+static inline int to_ionic_qp_flags(int access, bool sqd_notify,
+				    bool sq_is_cmb, bool rq_is_cmb,
+				    bool sq_spec, bool rq_spec,
+				    bool privileged, bool remote_privileged)
+{
+	int flags = 0;
+
+	if (access & IB_ACCESS_REMOTE_WRITE)
+		flags |= IONIC_QPF_REMOTE_WRITE;
+
+	if (access & IB_ACCESS_REMOTE_READ)
+		flags |= IONIC_QPF_REMOTE_READ;
+
+	if (access & IB_ACCESS_REMOTE_ATOMIC)
+		flags |= IONIC_QPF_REMOTE_ATOMIC;
+
+	if (sqd_notify)
+		flags |= IONIC_QPF_SQD_NOTIFY;
+
+	if (sq_is_cmb)
+		flags |= IONIC_QPF_SQ_CMB;
+
+	if (rq_is_cmb)
+		flags |= IONIC_QPF_RQ_CMB;
+
+	if (sq_spec)
+		flags |= IONIC_QPF_SQ_SPEC;
+
+	if (rq_spec)
+		flags |= IONIC_QPF_RQ_SPEC;
+
+	if (privileged)
+		flags |= IONIC_QPF_PRIVILEGED;
+
+	if (remote_privileged)
+		flags |= IONIC_QPF_REMOTE_PRIVILEGED;
+
+	return flags;
+}
+
+/* admin queue qp type */
+enum ionic_qp_type {
+	IONIC_QPT_RC,
+	IONIC_QPT_UC,
+	IONIC_QPT_RD,
+	IONIC_QPT_UD,
+	IONIC_QPT_SRQ,
+	IONIC_QPT_XRC_INI,
+	IONIC_QPT_XRC_TGT,
+	IONIC_QPT_XRC_SRQ,
+};
+
+static inline int to_ionic_qp_type(enum ib_qp_type type)
+{
+	switch (type) {
+	case IB_QPT_GSI:
+	case IB_QPT_UD:
+		return IONIC_QPT_UD;
+	case IB_QPT_RC:
+		return IONIC_QPT_RC;
+	case IB_QPT_UC:
+		return IONIC_QPT_UC;
+	case IB_QPT_XRC_INI:
+		return IONIC_QPT_XRC_INI;
+	case IB_QPT_XRC_TGT:
+		return IONIC_QPT_XRC_TGT;
+	default:
+		return -EINVAL;
+	}
+}
+
+/* admin queue qp state */
+enum ionic_qp_state {
+	IONIC_QPS_RESET,
+	IONIC_QPS_INIT,
+	IONIC_QPS_RTR,
+	IONIC_QPS_RTS,
+	IONIC_QPS_SQD,
+	IONIC_QPS_SQE,
+	IONIC_QPS_ERR,
+};
+
+static inline int from_ionic_qp_state(enum ionic_qp_state state)
+{
+	switch (state) {
+	case IONIC_QPS_RESET:
+		return IB_QPS_RESET;
+	case IONIC_QPS_INIT:
+		return IB_QPS_INIT;
+	case IONIC_QPS_RTR:
+		return IB_QPS_RTR;
+	case IONIC_QPS_RTS:
+		return IB_QPS_RTS;
+	case IONIC_QPS_SQD:
+		return IB_QPS_SQD;
+	case IONIC_QPS_SQE:
+		return IB_QPS_SQE;
+	case IONIC_QPS_ERR:
+		return IB_QPS_ERR;
+	default:
+		return -EINVAL;
+	}
+}
+
+static inline int to_ionic_qp_state(enum ib_qp_state state)
+{
+	switch (state) {
+	case IB_QPS_RESET:
+		return IONIC_QPS_RESET;
+	case IB_QPS_INIT:
+		return IONIC_QPS_INIT;
+	case IB_QPS_RTR:
+		return IONIC_QPS_RTR;
+	case IB_QPS_RTS:
+		return IONIC_QPS_RTS;
+	case IB_QPS_SQD:
+		return IONIC_QPS_SQD;
+	case IB_QPS_SQE:
+		return IONIC_QPS_SQE;
+	case IB_QPS_ERR:
+		return IONIC_QPS_ERR;
+	default:
+		return 0;
+	}
+}
+
+static inline int to_ionic_qp_modify_state(enum ib_qp_state to_state,
+					   enum ib_qp_state from_state)
+{
+	return to_ionic_qp_state(to_state) |
+		(to_ionic_qp_state(from_state) << 4);
+}
+
+/* fw abi v1 */
+
+/* data payload part of v1 wqe */
+union ionic_v1_pld {
+	struct ionic_sge	sgl[2];
+	__be32			spec32[8];
+	__be16			spec16[16];
+	__u8			data[32];
+};
 
 /* completion queue v1 cqe */
 struct ionic_v1_cqe {
@@ -78,6 +338,390 @@ static inline u32 ionic_v1_cqe_qtf_qid(u32 qtf)
 	return qtf >> IONIC_V1_CQE_QID_SHIFT;
 }
 
+/* v1 base wqe header */
+struct ionic_v1_base_hdr {
+	__u64				wqe_id;
+	__u8				op;
+	__u8				num_sge_key;
+	__be16				flags;
+	__be32				imm_data_key;
+};
+
+/* v1 receive wqe body */
+struct ionic_v1_recv_bdy {
+	__u8				rsvd[16];
+	union ionic_v1_pld		pld;
+};
+
+/* v1 send/rdma wqe body (common, has sgl) */
+struct ionic_v1_common_bdy {
+	union {
+		struct {
+			__be32		ah_id;
+			__be32		dest_qpn;
+			__be32		dest_qkey;
+		} send;
+		struct {
+			__be32		remote_va_high;
+			__be32		remote_va_low;
+			__be32		remote_rkey;
+		} rdma;
+	};
+	__be32				length;
+	union ionic_v1_pld		pld;
+};
+
+/* v1 atomic wqe body */
+struct ionic_v1_atomic_bdy {
+	__be32				remote_va_high;
+	__be32				remote_va_low;
+	__be32				remote_rkey;
+	__be32				swap_add_high;
+	__be32				swap_add_low;
+	__be32				compare_high;
+	__be32				compare_low;
+	__u8				rsvd[4];
+	struct ionic_sge		sge;
+};
+
+/* v1 reg mr wqe body */
+struct ionic_v1_reg_mr_bdy {
+	__be64				va;
+	__be64				length;
+	__be64				offset;
+	__be64				dma_addr;
+	__be32				map_count;
+	__be16				flags;
+	__u8				dir_size_log2;
+	__u8				page_size_log2;
+	__u8				rsvd[8];
+};
+
+/* v1 bind mw wqe body */
+struct ionic_v1_bind_mw_bdy {
+	__be64				va;
+	__be64				length;
+	__be32				lkey;
+	__be16				flags;
+	__u8				rsvd[26];
+};
+
+/* v1 send/recv wqe */
+struct ionic_v1_wqe {
+	struct ionic_v1_base_hdr	base;
+	union {
+		struct ionic_v1_recv_bdy	recv;
+		struct ionic_v1_common_bdy	common;
+		struct ionic_v1_atomic_bdy	atomic;
+		struct ionic_v1_reg_mr_bdy	reg_mr;
+		struct ionic_v1_bind_mw_bdy	bind_mw;
+	};
+};
+
+/* queue pair v1 send opcodes */
+enum ionic_v1_op {
+	IONIC_V1_OP_SEND,
+	IONIC_V1_OP_SEND_INV,
+	IONIC_V1_OP_SEND_IMM,
+	IONIC_V1_OP_RDMA_READ,
+	IONIC_V1_OP_RDMA_WRITE,
+	IONIC_V1_OP_RDMA_WRITE_IMM,
+	IONIC_V1_OP_ATOMIC_CS,
+	IONIC_V1_OP_ATOMIC_FA,
+	IONIC_V1_OP_REG_MR,
+	IONIC_V1_OP_LOCAL_INV,
+	IONIC_V1_OP_BIND_MW,
+
+	/* flags */
+	IONIC_V1_FLAG_FENCE		= BIT(0),
+	IONIC_V1_FLAG_SOL		= BIT(1),
+	IONIC_V1_FLAG_INL		= BIT(2),
+	IONIC_V1_FLAG_SIG		= BIT(3),
+
+	/* flags last four bits for sgl spec format */
+	IONIC_V1_FLAG_SPEC32		= (1u << 12),
+	IONIC_V1_FLAG_SPEC16		= (2u << 12),
+	IONIC_V1_SPEC_FIRST_SGE		= 2,
+};
+
+static inline size_t ionic_v1_send_wqe_min_size(int min_sge, int min_data,
+						int spec, bool expdb)
+{
+	size_t sz_wqe, sz_sgl, sz_data;
+
+	if (spec > IONIC_V1_SPEC_FIRST_SGE)
+		min_sge += IONIC_V1_SPEC_FIRST_SGE;
+
+	if (expdb) {
+		min_sge += 1;
+		min_data += IONIC_EXP_DBELL_SZ;
+	}
+
+	sz_wqe = sizeof(struct ionic_v1_wqe);
+	sz_sgl = offsetof(struct ionic_v1_wqe, common.pld.sgl[min_sge]);
+	sz_data = offsetof(struct ionic_v1_wqe, common.pld.data[min_data]);
+
+	if (sz_sgl > sz_wqe)
+		sz_wqe = sz_sgl;
+
+	if (sz_data > sz_wqe)
+		sz_wqe = sz_data;
+
+	return sz_wqe;
+}
+
+static inline int ionic_v1_send_wqe_max_sge(u8 stride_log2, int spec,
+					    bool expdb)
+{
+	struct ionic_sge *sge = (void *)(1ull << stride_log2);
+	struct ionic_v1_wqe *wqe = (void *)0;
+	int num_sge = 0;
+
+	if (expdb)
+		sge -= 1;
+
+	if (spec > IONIC_V1_SPEC_FIRST_SGE)
+		num_sge = IONIC_V1_SPEC_FIRST_SGE;
+
+	num_sge = sge - &wqe->common.pld.sgl[num_sge];
+
+	if (spec && num_sge > spec)
+		num_sge = spec;
+
+	return num_sge;
+}
+
+static inline int ionic_v1_send_wqe_max_data(u8 stride_log2, bool expdb)
+{
+	struct ionic_v1_wqe *wqe = (void *)0;
+	__u8 *data = (void *)(1ull << stride_log2);
+
+	if (expdb)
+		data -= IONIC_EXP_DBELL_SZ;
+
+	return data - wqe->common.pld.data;
+}
+
+static inline size_t ionic_v1_recv_wqe_min_size(int min_sge, int spec,
+						bool expdb)
+{
+	size_t sz_wqe, sz_sgl;
+
+	if (spec > IONIC_V1_SPEC_FIRST_SGE)
+		min_sge += IONIC_V1_SPEC_FIRST_SGE;
+
+	if (expdb)
+		min_sge += 1;
+
+	sz_wqe = sizeof(struct ionic_v1_wqe);
+	sz_sgl = offsetof(struct ionic_v1_wqe, recv.pld.sgl[min_sge]);
+
+	if (sz_sgl > sz_wqe)
+		sz_wqe = sz_sgl;
+
+	return sz_wqe;
+}
+
+static inline int ionic_v1_recv_wqe_max_sge(u8 stride_log2, int spec,
+					    bool expdb)
+{
+	struct ionic_sge *sge = (void *)(1ull << stride_log2);
+	struct ionic_v1_wqe *wqe = (void *)0;
+	int num_sge = 0;
+
+	if (expdb)
+		sge -= 1;
+
+	if (spec > IONIC_V1_SPEC_FIRST_SGE)
+		num_sge = IONIC_V1_SPEC_FIRST_SGE;
+
+	num_sge = sge - &wqe->recv.pld.sgl[num_sge];
+
+	if (spec && num_sge > spec)
+		num_sge = spec;
+
+	return num_sge;
+}
+
+static inline int ionic_v1_use_spec_sge(int min_sge, int spec)
+{
+	if (!spec || min_sge > spec)
+		return 0;
+
+	if (min_sge <= IONIC_V1_SPEC_FIRST_SGE)
+		return IONIC_V1_SPEC_FIRST_SGE;
+
+	return spec;
+}
+
+struct ionic_admin_create_ah {
+	__le64		dma_addr;
+	__le32		length;
+	__le32		pd_id;
+	__le32		id_ver;
+	__le16		dbid_flags;
+	__u8		csum_profile;
+	__u8		crypto;
+} __packed;
+
+#define IONIC_ADMIN_CREATE_AH_IN_V1_LEN 24
+static_assert(sizeof(struct ionic_admin_create_ah) ==
+	       IONIC_ADMIN_CREATE_AH_IN_V1_LEN);
+
+struct ionic_admin_destroy_ah {
+	__le32		ah_id;
+} __packed;
+
+#define IONIC_ADMIN_DESTROY_AH_IN_V1_LEN 4
+static_assert(sizeof(struct ionic_admin_destroy_ah) ==
+	       IONIC_ADMIN_DESTROY_AH_IN_V1_LEN);
+
+struct ionic_admin_query_ah {
+	__le64		dma_addr;
+} __packed;
+
+#define IONIC_ADMIN_QUERY_AH_IN_V1_LEN 8
+static_assert(sizeof(struct ionic_admin_query_ah) ==
+	       IONIC_ADMIN_QUERY_AH_IN_V1_LEN);
+
+struct ionic_admin_create_mr {
+	__le64		va;
+	__le64		length;
+	__le32		pd_id;
+	__le32		id_ver;
+	__le32		tbl_index;
+	__le32		map_count;
+	__le64		dma_addr;
+	__le16		dbid_flags;
+	__u8		pt_type;
+	__u8		dir_size_log2;
+	__u8		page_size_log2;
+} __packed;
+
+#define IONIC_ADMIN_CREATE_MR_IN_V1_LEN 45
+static_assert(sizeof(struct ionic_admin_create_mr) ==
+	       IONIC_ADMIN_CREATE_MR_IN_V1_LEN);
+
+struct ionic_admin_destroy_mr {
+	__le32		mr_id;
+} __packed;
+
+#define IONIC_ADMIN_DESTROY_MR_IN_V1_LEN 4
+static_assert(sizeof(struct ionic_admin_destroy_mr) ==
+	       IONIC_ADMIN_DESTROY_MR_IN_V1_LEN);
+
+struct ionic_admin_create_cq {
+	__le32		eq_id;
+	__u8		depth_log2;
+	__u8		stride_log2;
+	__u8		dir_size_log2_rsvd;
+	__u8		page_size_log2;
+	__le32		cq_flags;
+	__le32		id_ver;
+	__le32		tbl_index;
+	__le32		map_count;
+	__le64		dma_addr;
+	__le16		dbid_flags;
+} __packed;
+
+#define IONIC_ADMIN_CREATE_CQ_IN_V1_LEN 34
+static_assert(sizeof(struct ionic_admin_create_cq) ==
+	       IONIC_ADMIN_CREATE_CQ_IN_V1_LEN);
+
+struct ionic_admin_destroy_cq {
+	__le32		cq_id;
+} __packed;
+
+#define IONIC_ADMIN_DESTROY_CQ_IN_V1_LEN 4
+static_assert(sizeof(struct ionic_admin_destroy_cq) ==
+	       IONIC_ADMIN_DESTROY_CQ_IN_V1_LEN);
+
+struct ionic_admin_create_qp {
+	__le32		pd_id;
+	__be32		priv_flags;
+	__le32		sq_cq_id;
+	__u8		sq_depth_log2;
+	__u8		sq_stride_log2;
+	__u8		sq_dir_size_log2_rsvd;
+	__u8		sq_page_size_log2;
+	__le32		sq_tbl_index_xrcd_id;
+	__le32		sq_map_count;
+	__le64		sq_dma_addr;
+	__le32		rq_cq_id;
+	__u8		rq_depth_log2;
+	__u8		rq_stride_log2;
+	__u8		rq_dir_size_log2_rsvd;
+	__u8		rq_page_size_log2;
+	__le32		rq_tbl_index_srq_id;
+	__le32		rq_map_count;
+	__le64		rq_dma_addr;
+	__le32		id_ver;
+	__le16		dbid_flags;
+	__u8		type_state;
+	__u8		rsvd;
+} __packed;
+
+#define IONIC_ADMIN_CREATE_QP_IN_V1_LEN 64
+static_assert(sizeof(struct ionic_admin_create_qp) ==
+	       IONIC_ADMIN_CREATE_QP_IN_V1_LEN);
+
+struct ionic_admin_destroy_qp {
+	__le32		qp_id;
+} __packed;
+
+#define IONIC_ADMIN_DESTROY_QP_IN_V1_LEN 4
+static_assert(sizeof(struct ionic_admin_destroy_qp) ==
+	       IONIC_ADMIN_DESTROY_QP_IN_V1_LEN);
+
+struct ionic_admin_mod_qp {
+	__be32		attr_mask;
+	__u8		dcqcn_profile;
+	__u8		tfp_csum_profile;
+	__be16		access_flags;
+	__le32		rq_psn;
+	__le32		sq_psn;
+	__le32		qkey_dest_qpn;
+	__le32		rate_limit_kbps;
+	__u8		pmtu;
+	__u8		retry;
+	__u8		rnr_timer;
+	__u8		retry_timeout;
+	__u8		rsq_depth;
+	__u8		rrq_depth;
+	__le16		pkey_id;
+	__le32		ah_id_len;
+	__u8		en_pcp;
+	__u8		ip_dscp;
+	__u8		rsvd2;
+	__u8		type_state;
+	union {
+		struct {
+			__le16		rsvd1;
+		};
+		__le32		rrq_index;
+	};
+	__le32		rsq_index;
+	__le64		dma_addr;
+	__le32		id_ver;
+} __packed;
+
+#define IONIC_ADMIN_MODIFY_QP_IN_V1_LEN 60
+static_assert(sizeof(struct ionic_admin_mod_qp) ==
+	       IONIC_ADMIN_MODIFY_QP_IN_V1_LEN);
+
+struct ionic_admin_query_qp {
+	__le64		hdr_dma_addr;
+	__le64		sq_dma_addr;
+	__le64		rq_dma_addr;
+	__le32		ah_id;
+	__le32		id_ver;
+	__le16		dbid_flags;
+} __packed;
+
+#define IONIC_ADMIN_QUERY_QP_IN_V1_LEN 34
+static_assert(sizeof(struct ionic_admin_query_qp) ==
+	       IONIC_ADMIN_QUERY_QP_IN_V1_LEN);
+
 #define ADMIN_WQE_STRIDE	64
 #define ADMIN_WQE_HDR_LEN	4
 
@@ -88,9 +732,66 @@ struct ionic_v1_admin_wqe {
 	__le16				len;
 
 	union {
+		struct ionic_admin_create_ah create_ah;
+		struct ionic_admin_destroy_ah destroy_ah;
+		struct ionic_admin_query_ah query_ah;
+		struct ionic_admin_create_mr create_mr;
+		struct ionic_admin_destroy_mr destroy_mr;
+		struct ionic_admin_create_cq create_cq;
+		struct ionic_admin_destroy_cq destroy_cq;
+		struct ionic_admin_create_qp create_qp;
+		struct ionic_admin_destroy_qp destroy_qp;
+		struct ionic_admin_mod_qp mod_qp;
+		struct ionic_admin_query_qp query_qp;
 	} cmd;
 };
 
+/* side data for query qp */
+struct ionic_v1_admin_query_qp_sq {
+	__u8				rnr_timer;
+	__u8				retry_timeout;
+	__be16				access_perms_flags;
+	__be16				rsvd;
+	__be16				pkey_id;
+	__be32				qkey_dest_qpn;
+	__be32				rate_limit_kbps;
+	__be32				rq_psn;
+};
+
+struct ionic_v1_admin_query_qp_rq {
+	__u8				state_pmtu;
+	__u8				retry_rnrtry;
+	__u8				rrq_depth;
+	__u8				rsq_depth;
+	__be32				sq_psn;
+	__be16				access_perms_flags;
+	__be16				rsvd;
+};
+
+/* admin queue v1 opcodes */
+enum ionic_v1_admin_op {
+	IONIC_V1_ADMIN_NOOP,
+	IONIC_V1_ADMIN_CREATE_CQ,
+	IONIC_V1_ADMIN_CREATE_QP,
+	IONIC_V1_ADMIN_CREATE_MR,
+	IONIC_V1_ADMIN_STATS_HDRS,
+	IONIC_V1_ADMIN_STATS_VALS,
+	IONIC_V1_ADMIN_DESTROY_MR,
+	IONIC_v1_ADMIN_RSVD_7,		/* RESIZE_CQ */
+	IONIC_V1_ADMIN_DESTROY_CQ,
+	IONIC_V1_ADMIN_MODIFY_QP,
+	IONIC_V1_ADMIN_QUERY_QP,
+	IONIC_V1_ADMIN_DESTROY_QP,
+	IONIC_V1_ADMIN_DEBUG,
+	IONIC_V1_ADMIN_CREATE_AH,
+	IONIC_V1_ADMIN_QUERY_AH,
+	IONIC_V1_ADMIN_MODIFY_DCQCN,
+	IONIC_V1_ADMIN_DESTROY_AH,
+	IONIC_V1_ADMIN_QP_STATS_HDRS,
+	IONIC_V1_ADMIN_QP_STATS_VALS,
+	IONIC_V1_ADMIN_OPCODES_MAX,
+};
+
 /* admin queue v1 cqe status */
 enum ionic_v1_admin_status {
 	IONIC_V1_ASTS_OK,
@@ -136,6 +837,22 @@ enum ionic_v1_eqe_evt_bits {
 	IONIC_V1_EQE_QP_ERR_ACCESS	= 10,
 };
 
+enum ionic_tfp_csum_profiles {
+	IONIC_TFP_CSUM_PROF_ETH_IPV4_UDP				= 0,
+	IONIC_TFP_CSUM_PROF_ETH_QTAG_IPV4_UDP				= 1,
+	IONIC_TFP_CSUM_PROF_ETH_IPV6_UDP				= 2,
+	IONIC_TFP_CSUM_PROF_ETH_QTAG_IPV6_UDP				= 3,
+	IONIC_TFP_CSUM_PROF_IPV4_UDP_VXLAN_ETH_QTAG_IPV4_UDP		= 4,
+	IONIC_TFP_CSUM_PROF_IPV4_UDP_VXLAN_ETH_QTAG_IPV6_UDP		= 5,
+	IONIC_TFP_CSUM_PROF_QTAG_IPV4_UDP_VXLAN_ETH_QTAG_IPV4_UDP	= 6,
+	IONIC_TFP_CSUM_PROF_QTAG_IPV4_UDP_VXLAN_ETH_QTAG_IPV6_UDP	= 7,
+	IONIC_TFP_CSUM_PROF_ETH_QTAG_IPV4_UDP_ESP_IPV4_UDP		= 8,
+	IONIC_TFP_CSUM_PROF_ETH_QTAG_IPV4_ESP_UDP			= 9,
+	IONIC_TFP_CSUM_PROF_ETH_QTAG_IPV4_UDP_ESP_UDP			= 10,
+	IONIC_TFP_CSUM_PROF_ETH_QTAG_IPV6_ESP_UDP			= 11,
+	IONIC_TFP_CSUM_PROF_ETH_QTAG_IPV4_UDP_CSUM			= 12,
+};
+
 static inline bool ionic_v1_eqe_color(struct ionic_v1_eqe *eqe)
 {
 	return eqe->evt & cpu_to_be32(IONIC_V1_EQE_COLOR);
diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.c b/drivers/infiniband/hw/ionic/ionic_ibdev.c
index 7710190ff65f..6833abbfb1dc 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.c
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.c
@@ -15,6 +15,44 @@ MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS("NET_IONIC");
 
+static const struct ib_device_ops ionic_dev_ops = {
+	.owner = THIS_MODULE,
+	.driver_id = RDMA_DRIVER_IONIC,
+	.uverbs_abi_ver = IONIC_ABI_VERSION,
+
+	.alloc_ucontext = ionic_alloc_ucontext,
+	.dealloc_ucontext = ionic_dealloc_ucontext,
+	.mmap = ionic_mmap,
+	.mmap_free = ionic_mmap_free,
+	.alloc_pd = ionic_alloc_pd,
+	.dealloc_pd = ionic_dealloc_pd,
+	.create_ah = ionic_create_ah,
+	.query_ah = ionic_query_ah,
+	.destroy_ah = ionic_destroy_ah,
+	.create_user_ah = ionic_create_ah,
+	.get_dma_mr = ionic_get_dma_mr,
+	.reg_user_mr = ionic_reg_user_mr,
+	.reg_user_mr_dmabuf = ionic_reg_user_mr_dmabuf,
+	.dereg_mr = ionic_dereg_mr,
+	.alloc_mr = ionic_alloc_mr,
+	.map_mr_sg = ionic_map_mr_sg,
+	.alloc_mw = ionic_alloc_mw,
+	.dealloc_mw = ionic_dealloc_mw,
+	.create_cq = ionic_create_cq,
+	.destroy_cq = ionic_destroy_cq,
+	.create_qp = ionic_create_qp,
+	.modify_qp = ionic_modify_qp,
+	.query_qp = ionic_query_qp,
+	.destroy_qp = ionic_destroy_qp,
+
+	INIT_RDMA_OBJ_SIZE(ib_ucontext, ionic_ctx, ibctx),
+	INIT_RDMA_OBJ_SIZE(ib_pd, ionic_pd, ibpd),
+	INIT_RDMA_OBJ_SIZE(ib_ah, ionic_ah, ibah),
+	INIT_RDMA_OBJ_SIZE(ib_cq, ionic_vcq, ibcq),
+	INIT_RDMA_OBJ_SIZE(ib_qp, ionic_qp, ibqp),
+	INIT_RDMA_OBJ_SIZE(ib_mw, ionic_mr, ibmw),
+};
+
 static void ionic_init_resids(struct ionic_ibdev *dev)
 {
 	ionic_resid_init(&dev->inuse_cqid, dev->lif_cfg.cq_count);
@@ -48,6 +86,8 @@ static void ionic_destroy_ibdev(struct ionic_ibdev *dev)
 	ib_unregister_device(&dev->ibdev);
 	ionic_destroy_rdma_admin(dev);
 	ionic_destroy_resids(dev);
+	WARN_ON(!xa_empty(&dev->qp_tbl));
+	xa_destroy(&dev->qp_tbl);
 	WARN_ON(!xa_empty(&dev->cq_tbl));
 	xa_destroy(&dev->cq_tbl);
 	ib_dealloc_device(&dev->ibdev);
@@ -66,6 +106,7 @@ static struct ionic_ibdev *ionic_create_ibdev(struct ionic_aux_dev *ionic_adev)
 
 	ionic_fill_lif_cfg(ionic_adev->lif, &dev->lif_cfg);
 
+	xa_init_flags(&dev->qp_tbl, GFP_ATOMIC);
 	xa_init_flags(&dev->cq_tbl, GFP_ATOMIC);
 
 	ionic_init_resids(dev);
@@ -98,6 +139,8 @@ static struct ionic_ibdev *ionic_create_ibdev(struct ionic_aux_dev *ionic_adev)
 	if (rc)
 		goto err_admin;
 
+	ib_set_device_ops(&dev->ibdev, &ionic_dev_ops);
+
 	rc = ib_register_device(ibdev, "ionic_%d", ibdev->dev.parent);
 	if (rc)
 		goto err_register;
@@ -110,6 +153,7 @@ static struct ionic_ibdev *ionic_create_ibdev(struct ionic_aux_dev *ionic_adev)
 	ionic_destroy_rdma_admin(dev);
 err_reset:
 	ionic_destroy_resids(dev);
+	xa_destroy(&dev->qp_tbl);
 	xa_destroy(&dev->cq_tbl);
 	ib_dealloc_device(&dev->ibdev);
 
@@ -161,7 +205,7 @@ static int __init ionic_mod_init(void)
 {
 	int rc;
 
-	ionic_evt_workq = create_workqueue(DRIVER_NAME "-evt");
+	ionic_evt_workq = create_workqueue(KBUILD_MODNAME "-evt");
 	if (!ionic_evt_workq)
 		return -ENOMEM;
 
diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.h b/drivers/infiniband/hw/ionic/ionic_ibdev.h
index 490897628f41..cb1ac8aca358 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.h
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.h
@@ -6,7 +6,10 @@
 
 #include <rdma/ib_umem.h>
 #include <rdma/ib_verbs.h>
+#include <rdma/ib_pack.h>
+#include <rdma/uverbs_ioctl.h>
 
+#include <rdma/ionic-abi.h>
 #include <ionic_api.h>
 #include <ionic_regs.h>
 
@@ -24,9 +27,26 @@
 #define IONIC_EQ_ISR_BUDGET 10
 #define IONIC_EQ_WORK_BUDGET 1000
 #define IONIC_MAX_PD 1024
+#define IONIC_SPEC_HIGH 8
+#define IONIC_SQCMB_ORDER 5
+#define IONIC_RQCMB_ORDER 0
+
+#define IONIC_META_LAST		((void *)1ul)
+#define IONIC_META_POSTED	((void *)2ul)
 
 #define IONIC_CQ_GRACE 100
 
+#define IONIC_ROCE_UDP_SPORT	28272
+#define IONIC_DMA_LKEY		0
+#define IONIC_DMA_RKEY		IONIC_DMA_LKEY
+
+#define IONIC_CMB_SUPPORTED \
+	(IONIC_CMB_ENABLE | IONIC_CMB_REQUIRE | IONIC_CMB_EXPDB | \
+	 IONIC_CMB_WC | IONIC_CMB_UC)
+
+/* resource is not reserved on the device, indicated in tbl_order */
+#define IONIC_RES_INVALID	-1
+
 struct ionic_aq;
 struct ionic_cq;
 struct ionic_eq;
@@ -44,14 +64,6 @@ enum ionic_admin_flags {
 	IONIC_ADMIN_F_INTERRUPT = BIT(2),	/* Interruptible w/timeout */
 };
 
-struct ionic_qdesc {
-	__aligned_u64 addr;
-	__u32 size;
-	__u16 mask;
-	__u8 depth_log2;
-	__u8 stride_log2;
-};
-
 enum ionic_mmap_flag {
 	IONIC_MMAP_WC = BIT(0),
 };
@@ -160,6 +172,13 @@ struct ionic_tbl_buf {
 	u8		page_size_log2;
 };
 
+struct ionic_pd {
+	struct ib_pd		ibpd;
+
+	u32			pdid;
+	u32			flags;
+};
+
 struct ionic_cq {
 	struct ionic_vcq	*vcq;
 
@@ -193,11 +212,188 @@ struct ionic_vcq {
 	u8			poll_idx;
 };
 
+struct ionic_sq_meta {
+	u64			wrid;
+	u32			len;
+	u16			seq;
+	u8			ibop;
+	u8			ibsts;
+	u8			remote:1;
+	u8			signal:1;
+	u8			local_comp:1;
+};
+
+struct ionic_rq_meta {
+	struct ionic_rq_meta	*next;
+	u64			wrid;
+};
+
+struct ionic_qp {
+	struct ib_qp		ibqp;
+	enum ib_qp_state	state;
+
+	u32			qpid;
+	u32			ahid;
+	u32			sq_cqid;
+	u32			rq_cqid;
+	u8			udma_idx;
+	u8			has_ah:1;
+	u8			has_sq:1;
+	u8			has_rq:1;
+	u8			sig_all:1;
+
+	struct list_head	qp_list_counter;
+
+	struct list_head	cq_poll_sq;
+	struct list_head	cq_flush_sq;
+	struct list_head	cq_flush_rq;
+	struct list_head	ibkill_flush_ent;
+
+	spinlock_t		sq_lock; /* for posting and polling */
+	struct ionic_queue	sq;
+	struct ionic_sq_meta	*sq_meta;
+	u16			*sq_msn_idx;
+	int			sq_spec;
+	u16			sq_old_prod;
+	u16			sq_msn_prod;
+	u16			sq_msn_cons;
+	u8			sq_cmb;
+	bool			sq_flush;
+	bool			sq_flush_rcvd;
+
+	spinlock_t		rq_lock; /* for posting and polling */
+	struct ionic_queue	rq;
+	struct ionic_rq_meta	*rq_meta;
+	struct ionic_rq_meta	*rq_meta_head;
+	int			rq_spec;
+	u16			rq_old_prod;
+	u8			rq_cmb;
+	bool			rq_flush;
+
+	struct kref		qp_kref;
+	struct completion	qp_rel_comp;
+
+	/* infrequently accessed, keep at end */
+	int			sgid_index;
+	int			sq_cmb_order;
+	u32			sq_cmb_pgid;
+	phys_addr_t		sq_cmb_addr;
+	struct rdma_user_mmap_entry *mmap_sq_cmb;
+
+	struct ib_umem		*sq_umem;
+
+	int			rq_cmb_order;
+	u32			rq_cmb_pgid;
+	phys_addr_t		rq_cmb_addr;
+	struct rdma_user_mmap_entry *mmap_rq_cmb;
+
+	struct ib_umem		*rq_umem;
+
+	int			dcqcn_profile;
+
+	struct ib_ud_header	*hdr;
+};
+
+struct ionic_ah {
+	struct ib_ah		ibah;
+	u32			ahid;
+	int			sgid_index;
+	struct ib_ud_header	hdr;
+};
+
+struct ionic_mr {
+	union {
+		struct ib_mr	ibmr;
+		struct ib_mw	ibmw;
+	};
+
+	u32			mrid;
+	int			flags;
+
+	struct ib_umem		*umem;
+	struct ionic_tbl_buf	buf;
+	bool			created;
+};
+
 static inline struct ionic_ibdev *to_ionic_ibdev(struct ib_device *ibdev)
 {
 	return container_of(ibdev, struct ionic_ibdev, ibdev);
 }
 
+static inline struct ionic_ctx *to_ionic_ctx(struct ib_ucontext *ibctx)
+{
+	return container_of(ibctx, struct ionic_ctx, ibctx);
+}
+
+static inline struct ionic_ctx *to_ionic_ctx_uobj(struct ib_uobject *uobj)
+{
+	if (!uobj)
+		return NULL;
+
+	if (!uobj->context)
+		return NULL;
+
+	return to_ionic_ctx(uobj->context);
+}
+
+static inline struct ionic_pd *to_ionic_pd(struct ib_pd *ibpd)
+{
+	return container_of(ibpd, struct ionic_pd, ibpd);
+}
+
+static inline struct ionic_mr *to_ionic_mr(struct ib_mr *ibmr)
+{
+	return container_of(ibmr, struct ionic_mr, ibmr);
+}
+
+static inline struct ionic_mr *to_ionic_mw(struct ib_mw *ibmw)
+{
+	return container_of(ibmw, struct ionic_mr, ibmw);
+}
+
+static inline struct ionic_vcq *to_ionic_vcq(struct ib_cq *ibcq)
+{
+	return container_of(ibcq, struct ionic_vcq, ibcq);
+}
+
+static inline struct ionic_cq *to_ionic_vcq_cq(struct ib_cq *ibcq,
+					       uint8_t udma_idx)
+{
+	return &to_ionic_vcq(ibcq)->cq[udma_idx];
+}
+
+static inline struct ionic_qp *to_ionic_qp(struct ib_qp *ibqp)
+{
+	return container_of(ibqp, struct ionic_qp, ibqp);
+}
+
+static inline struct ionic_ah *to_ionic_ah(struct ib_ah *ibah)
+{
+	return container_of(ibah, struct ionic_ah, ibah);
+}
+
+static inline u32 ionic_ctx_dbid(struct ionic_ibdev *dev,
+				 struct ionic_ctx *ctx)
+{
+	if (!ctx)
+		return dev->lif_cfg.dbid;
+
+	return ctx->dbid;
+}
+
+static inline u32 ionic_obj_dbid(struct ionic_ibdev *dev,
+				 struct ib_uobject *uobj)
+{
+	return ionic_ctx_dbid(dev, to_ionic_ctx_uobj(uobj));
+}
+
+static inline void ionic_qp_complete(struct kref *kref)
+{
+	struct ionic_qp *qp = container_of(kref, struct ionic_qp, qp_kref);
+
+	complete(&qp->qp_rel_comp);
+}
+
 static inline void ionic_cq_complete(struct kref *kref)
 {
 	struct ionic_cq *cq = container_of(kref, struct ionic_cq, cq_kref);
@@ -227,8 +423,45 @@ int ionic_create_cq_common(struct ionic_vcq *vcq,
 			   __u32 *resp_cqid,
 			   int udma_idx);
 void ionic_destroy_cq_common(struct ionic_ibdev *dev, struct ionic_cq *cq);
+void ionic_flush_qp(struct ionic_ibdev *dev, struct ionic_qp *qp);
+void ionic_notify_flush_cq(struct ionic_cq *cq);
+
+int ionic_alloc_ucontext(struct ib_ucontext *ibctx, struct ib_udata *udata);
+void ionic_dealloc_ucontext(struct ib_ucontext *ibctx);
+int ionic_mmap(struct ib_ucontext *ibctx, struct vm_area_struct *vma);
+void ionic_mmap_free(struct rdma_user_mmap_entry *rdma_entry);
+int ionic_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
+int ionic_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
+int ionic_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
+		    struct ib_udata *udata);
+int ionic_query_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr);
+int ionic_destroy_ah(struct ib_ah *ibah, u32 flags);
+struct ib_mr *ionic_get_dma_mr(struct ib_pd *ibpd, int access);
+struct ib_mr *ionic_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 length,
+				u64 addr, int access, struct ib_udata *udata);
+struct ib_mr *ionic_reg_user_mr_dmabuf(struct ib_pd *ibpd, u64 offset,
+				       u64 length, u64 addr, int fd, int access,
+				       struct uverbs_attr_bundle *attrs);
+int ionic_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
+struct ib_mr *ionic_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type type,
+			     u32 max_sg);
+int ionic_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
+		    unsigned int *sg_offset);
+int ionic_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata);
+int ionic_dealloc_mw(struct ib_mw *ibmw);
+int ionic_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
+		    struct uverbs_attr_bundle *attrs);
+int ionic_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
+int ionic_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
+		    struct ib_udata *udata);
+int ionic_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int mask,
+		    struct ib_udata *udata);
+int ionic_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int mask,
+		   struct ib_qp_init_attr *init_attr);
+int ionic_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata);
 
 /* ionic_pgtbl.c */
+__le64 ionic_pgtbl_dma(struct ionic_tbl_buf *buf, u64 va);
 int ionic_pgtbl_page(struct ionic_tbl_buf *buf, u64 dma);
 int ionic_pgtbl_init(struct ionic_ibdev *dev,
 		     struct ionic_tbl_buf *buf,
diff --git a/drivers/infiniband/hw/ionic/ionic_pgtbl.c b/drivers/infiniband/hw/ionic/ionic_pgtbl.c
index 11461f7642bc..a8eb73be6f86 100644
--- a/drivers/infiniband/hw/ionic/ionic_pgtbl.c
+++ b/drivers/infiniband/hw/ionic/ionic_pgtbl.c
@@ -7,6 +7,25 @@
 #include "ionic_fw.h"
 #include "ionic_ibdev.h"
 
+__le64 ionic_pgtbl_dma(struct ionic_tbl_buf *buf, u64 va)
+{
+	u64 pg_mask = BIT_ULL(buf->page_size_log2) - 1;
+	u64 dma;
+
+	if (!buf->tbl_pages)
+		return cpu_to_le64(0);
+
+	if (buf->tbl_pages > 1)
+		return cpu_to_le64(buf->tbl_dma);
+
+	if (buf->tbl_buf)
+		dma = le64_to_cpu(buf->tbl_buf[0]);
+	else
+		dma = buf->tbl_dma;
+
+	return cpu_to_le64(dma + (va & pg_mask));
+}
+
 int ionic_pgtbl_page(struct ionic_tbl_buf *buf, u64 dma)
 {
 	if (unlikely(buf->tbl_pages == buf->tbl_limit))
diff --git a/include/uapi/rdma/ionic-abi.h b/include/uapi/rdma/ionic-abi.h
new file mode 100644
index 000000000000..7b589d3e9728
--- /dev/null
+++ b/include/uapi/rdma/ionic-abi.h
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc */
+
+#ifndef IONIC_ABI_H
+#define IONIC_ABI_H
+
+#include <linux/types.h>
+
+#define IONIC_ABI_VERSION	1
+
+#define IONIC_EXPDB_64		1
+#define IONIC_EXPDB_128		2
+#define IONIC_EXPDB_256		4
+#define IONIC_EXPDB_512		8
+
+#define IONIC_EXPDB_SQ		1
+#define IONIC_EXPDB_RQ		2
+
+#define IONIC_CMB_ENABLE	1
+#define IONIC_CMB_REQUIRE	2
+#define IONIC_CMB_EXPDB		4
+#define IONIC_CMB_WC		8
+#define IONIC_CMB_UC		16
+
+struct ionic_ctx_req {
+	__u32 rsvd[2];
+};
+
+struct ionic_ctx_resp {
+	__u32 rsvd;
+	__u32 page_shift;
+
+	__aligned_u64 dbell_offset;
+
+	__u16 version;
+	__u8 qp_opcodes;
+	__u8 admin_opcodes;
+
+	__u8 sq_qtype;
+	__u8 rq_qtype;
+	__u8 cq_qtype;
+	__u8 admin_qtype;
+
+	__u8 max_stride;
+	__u8 max_spec;
+	__u8 udma_count;
+	__u8 expdb_mask;
+	__u8 expdb_qtypes;
+
+	__u8 rsvd2[3];
+};
+
+struct ionic_qdesc {
+	__aligned_u64 addr;
+	__u32 size;
+	__u16 mask;
+	__u8 depth_log2;
+	__u8 stride_log2;
+};
+
+struct ionic_ah_resp {
+	__u32 ahid;
+	__u32 pad;
+};
+
+struct ionic_cq_req {
+	struct ionic_qdesc cq[2];
+	__u8 udma_mask;
+	__u8 rsvd[7];
+};
+
+struct ionic_cq_resp {
+	__u32 cqid[2];
+	__u8 udma_mask;
+	__u8 rsvd[7];
+};
+
+struct ionic_qp_req {
+	struct ionic_qdesc sq;
+	struct ionic_qdesc rq;
+	__u8 sq_spec;
+	__u8 rq_spec;
+	__u8 sq_cmb;
+	__u8 rq_cmb;
+	__u8 udma_mask;
+	__u8 rsvd[3];
+};
+
+struct ionic_qp_resp {
+	__u32 qpid;
+	__u8 sq_cmb;
+	__u8 rq_cmb;
+	__u8 udma_idx;
+	__u8 rsvd[1];
+	__aligned_u64 sq_cmb_offset;
+	__aligned_u64 rq_cmb_offset;
+};
+
+struct ionic_srq_req {
+	struct ionic_qdesc rq;
+	__u8 rq_spec;
+	__u8 rq_cmb;
+	__u8 udma_mask;
+	__u8 rsvd[5];
+};
+
+struct ionic_srq_resp {
+	__u32 qpid;
+	__u8 rq_cmb;
+	__u8 udma_idx;
+	__u8 rsvd[2];
+	__aligned_u64 rq_cmb_offset;
+};
+
+#endif /* IONIC_ABI_H */
-- 
2.43.0


