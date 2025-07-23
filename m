Return-Path: <linux-rdma+bounces-12433-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFAEB0F922
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 19:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40AB61759BF
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 17:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07376231827;
	Wed, 23 Jul 2025 17:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V0OMQLWl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C14A223DC0;
	Wed, 23 Jul 2025 17:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291952; cv=fail; b=mesZdWs6NzknupeV87QS8JqujaUVnbzBrQTus9fKg0W2mma3RjuNwu/bFp1MpDUMYvo3yu5uLIstB2hp/u3ho/aSdq/BPohWiE1FgblFdlF43Nt/9wRWdzXXVpgaVvGa/08YpdlxR5Q3PLNhzpBSJUqhNiIkrqOa2gUsKsS3piE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291952; c=relaxed/simple;
	bh=aqGv8x8xiCRuVokmXHPFXh0YmUkYQcz84Ac/ouQdmOY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=REnT88FHrEDiAOTIfQmz7cdeS4173i+9r3v0DX7EofpYVT49A0oXHclsP3U6CgPsDAGvjaLCqXHKbzaptLH+Mot11krsBnh25Dh182LE4nSWT+kuB3dPlypr6+DXkPPCrnyBUJPIJ4BpMiiXM5mWtVv04cXU5cF1tYsU2pysBgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V0OMQLWl; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDVG9KVXzX0MlgXWf2hkl6ywHIDAV8Fdk/0htzJapNBy5YhUbe7EFrWtpPGY3xRaUOUbXnL05Lx6wOly5zNbgGPVY4uZsVa0ruqChcepdj1bF+35fl2NbVHd+ApzZ2X04FWPqLvxvZxWwj7Ri6T1M4+Z5UJHyGqRJBdZnCcL31FxZeUIDkGaozJ1gYJ5OFTFREJgLw4x8F4uKH3mNqojEimNMZi6AtFBxUrZa5LHef0e/lZLX6+RpVyh1ACl9v8sOSL1nN87sN9qpSc1CC1toB8xMBd77FdXBBdYTQ9MCSZJadQo8zmQ8cgWYxXbKd5PBr7Bp7vs7RBr+J1dKQSJBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFx/dmppJWhrBmtc7FTHrJmb3RhB//ITRFbLXMcp5W0=;
 b=CeYUDl8dPBSa3iAEzm7V+XD1zIhEVdblRdcuLizkqhodNPA+LO/RntQBBCeXGiuaOUMVBCY8axhNHC/dzB7SsGB52tsY629kEGUKz6GrpjWA8dCbNbwoPZJezsXoo8dyH8neQ630kDEyXiZtDGyWP282X2+Jl0lyNweBklNFuVXxZ+6hHT4a111HAG4/IYrDsBXAL+D7q9k7upR5dil8b4DZB4/EhZOx8nuweiMWWUpciTf8zljoMXgZMGySwbhmbhT7HV6cEo//ca5D10bB1gx9XsXz+Iq9uCcH/c/VSfpfq45srV9DBvxTAbmzMmGR1NBKKobIu135C0L+JJPbXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFx/dmppJWhrBmtc7FTHrJmb3RhB//ITRFbLXMcp5W0=;
 b=V0OMQLWlrRc5niNZHn14KM2XLGu6StttzSyK9EA2/5l94iaZ8gZNMvv4jzZ/fAasoDZz7YbX6Be4hBNxQBjvZgWUaXH03G3TuwBAN4lbsOVBRUvh3PKplHQ4QOZmSiOEBHswWca+xsbVKEKALu22euoaL1yZTtoWkm1jH702pnA=
Received: from CH2PR15CA0012.namprd15.prod.outlook.com (2603:10b6:610:51::22)
 by CYXPR12MB9425.namprd12.prod.outlook.com (2603:10b6:930:dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 17:32:26 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::ce) by CH2PR15CA0012.outlook.office365.com
 (2603:10b6:610:51::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Wed,
 23 Jul 2025 17:32:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 17:32:26 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 12:32:22 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 12:32:21 -0500
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 23 Jul 2025 12:32:17 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH v4 05/14] net: ionic: Provide interrupt allocation support for the RDMA driver
Date: Wed, 23 Jul 2025 23:01:40 +0530
Message-ID: <20250723173149.2568776-6-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|CYXPR12MB9425:EE_
X-MS-Office365-Filtering-Correlation-Id: 574ad7d4-7bd7-407c-8f3e-08ddca0ee446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FeMiLBmIaU43juAr4atqs8p52DzpJJ4SoUT9rrOGvu3lwPkiDTf+xbEG6P9k?=
 =?us-ascii?Q?z03RGkX91pO+TMdGvAbvkFa25+YkvE/OMFm5BybyGwYYQaw0qaPHBIH5Yfxd?=
 =?us-ascii?Q?7rf7rSYuK4J1FMzdfeBJw7+BK7NQ9DVwOpsWBdNw0oy6CoZjhVfu0138kgCc?=
 =?us-ascii?Q?pv6osYJ9J0BlGuufZe62XZASem9CvWD+umZ9/Kdh8p7SHAfD/LYpX4gYDZKo?=
 =?us-ascii?Q?KaQmMvPIFoO2m3S5s/QqS5uMzeVpJkLYMsKwsCua1Op74pyv8WDnsHWCc+tR?=
 =?us-ascii?Q?RBd4S7PBAAkpbaesfAvJoH8mT7ll/qO85r7fl9NkoVZ9KpVUGg6CxG0PsIoT?=
 =?us-ascii?Q?7n3GNH4YfMpdGhr8Xw7CxhAkax23+fsFvqrA2yL9Ybe6nQ17V/ldb3Z6uWk2?=
 =?us-ascii?Q?lpmD4sfEZDtlYCJVkk5qCrwwGFj1yTmrx+jMC1twN8jsb/hgAaKTqWTrUEqC?=
 =?us-ascii?Q?ESfXUEH2FFo0iHpss7Qoko6PTwOpKnspU0iMHRD/1aMJT+IF+lwGQyRS2nHT?=
 =?us-ascii?Q?MAG31sYbh/lFHgsEIwW9IyrTfiOt+mlAMtaHgir++w29M5/TISW3dOGO0cO0?=
 =?us-ascii?Q?03We9HT0rltoXXmM3mOz4r0jywN6JSD+WYU4oWu370mBCyP/DfRK7nzpEDsn?=
 =?us-ascii?Q?abMq2tOW9Aum1bNhpUhxpO+AIASUHVMFmDCR8mwKYpefzR/f4IMKsS7JyfgG?=
 =?us-ascii?Q?/MwElapMbi5KSigq2GeaZcJHgLfBlvOYRgM/ajVvcSnb1j5Ok6BWFSoeMWx7?=
 =?us-ascii?Q?4D1l4tQJE1Sn9Qbq8v6yOgod30Eu4tmkth+fs8bRr/tKU8Bec77snYoibSbd?=
 =?us-ascii?Q?M0mW6xzQ0SCdGHCaRWYSN8bMZXAZCO19qGzg3f0g7vPxRhEvg4Ilq3BpryxM?=
 =?us-ascii?Q?/hPQ14Ivc24ouiaMchh9RV6VngwUg1YKDPxzxN5bQzoGrpi/k0j9YY6EtKRg?=
 =?us-ascii?Q?IZ4FL/b4v+z3vg66hlhnbt5jCPM2q8WV80t28ccl2GUFanBdrPQrD+uxrQ+C?=
 =?us-ascii?Q?jACfMjoIJydpbysh+esukZQdeluFQXEcFmDQa+uFrXLEuYmjm0kR6g/8PQdj?=
 =?us-ascii?Q?QJ18R46T9NuqJqWtYwTPQLZN09+5fT9r+DIQbpAwIcwl19DtZOhMU5MUmHdW?=
 =?us-ascii?Q?RWOfJVWggOIyvg09SHgI5Vbff+BkZIXYjHHfxXCJvyDNwYna9tsngr458S7C?=
 =?us-ascii?Q?a09/DRBq/W2tREPeIe7x5O8VvmTd7TdnyA6fbSKhf5FcFaLsQjw2bU82ea5x?=
 =?us-ascii?Q?/+skGP+BpsJxjUaA9ZgFs8er1nDrqJoB38zDQorQ/W265nYXWMGnQQnwti1g?=
 =?us-ascii?Q?vXd48IYqslR+iOPN+agxrvxaYX1Pt4AWe/XqppTyudrDGSSm7+sXmSiwta/q?=
 =?us-ascii?Q?dO0H6Othapq+wMZlYndgOR63P1gx523oTruKA1P8Vw0EdKaC9VzRDEY2xfFQ?=
 =?us-ascii?Q?wg/nC2rWWPYDykEbG1c5k9D97sjz4qCzP6XWWl8BsYJ+6ig325f+2tu15sUe?=
 =?us-ascii?Q?vFQZbCjlhUndPSTCLHrOr4Wz3kq/ez3TmzbvA8ZXvddT72P5uUqCXh/L0w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 17:32:26.4116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 574ad7d4-7bd7-407c-8f3e-08ddca0ee446
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9425

RDMA driver needs an interrupt for an event queue. Export
function from net driver to allocate an interrupt.

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_api.h   | 43 +++++++++++++++++++
 .../net/ethernet/pensando/ionic/ionic_dev.h   | 13 ------
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 38 ++++++++--------
 3 files changed, 62 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_api.h b/drivers/net/ethernet/pensando/ionic/ionic_api.h
index e0b766d1769f..5fd23aa8c5a1 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_api.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_api.h
@@ -32,6 +32,29 @@ struct ionic_admin_ctx {
 	union ionic_adminq_comp comp;
 };
 
+#define IONIC_INTR_INDEX_NOT_ASSIGNED	-1
+#define IONIC_INTR_NAME_MAX_SZ		32
+
+/**
+ * struct ionic_intr_info - Interrupt information
+ * @name:          Name identifier
+ * @rearm_count:   Interrupt rearm count
+ * @index:         Interrupt index position
+ * @vector:        Interrupt number
+ * @dim_coal_hw:   Interrupt coalesce value in hardware units
+ * @affinity_mask: CPU affinity mask
+ * @aff_notify:    context for notification of IRQ affinity changes
+ */
+struct ionic_intr_info {
+	char name[IONIC_INTR_NAME_MAX_SZ];
+	u64 rearm_count;
+	unsigned int index;
+	unsigned int vector;
+	u32 dim_coal_hw;
+	cpumask_var_t *affinity_mask;
+	struct irq_affinity_notify aff_notify;
+};
+
 /**
  * ionic_adminq_post_wait - Post an admin command and wait for response
  * @lif:        Logical interface
@@ -63,4 +86,24 @@ int ionic_error_to_errno(enum ionic_status_code code);
  */
 void ionic_request_rdma_reset(struct ionic_lif *lif);
 
+/**
+ * ionic_intr_alloc - Reserve a device interrupt
+ * @lif:        Logical interface
+ * @intr:       Reserved ionic interrupt structure
+ *
+ * Reserve an interrupt index and get irq number for that index.
+ *
+ * Return: zero or negative error status
+ */
+int ionic_intr_alloc(struct ionic_lif *lif, struct ionic_intr_info *intr);
+
+/**
+ * ionic_intr_free - Release a device interrupt index
+ * @lif:        Logical interface
+ * @intr:       Interrupt index
+ *
+ * Mark the interrupt index unused so that it can be reserved again.
+ */
+void ionic_intr_free(struct ionic_lif *lif, int intr);
+
 #endif /* _IONIC_API_H_ */
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index bc26eb8f5779..68cf4da3c6b3 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -274,19 +274,6 @@ struct ionic_queue {
 	char name[IONIC_QUEUE_NAME_MAX_SZ];
 } ____cacheline_aligned_in_smp;
 
-#define IONIC_INTR_INDEX_NOT_ASSIGNED	-1
-#define IONIC_INTR_NAME_MAX_SZ		32
-
-struct ionic_intr_info {
-	char name[IONIC_INTR_NAME_MAX_SZ];
-	u64 rearm_count;
-	unsigned int index;
-	unsigned int vector;
-	u32 dim_coal_hw;
-	cpumask_var_t *affinity_mask;
-	struct irq_affinity_notify aff_notify;
-};
-
 struct ionic_cq {
 	struct ionic_lif *lif;
 	struct ionic_queue *bound_q;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 146659f6862a..f89b458bd20a 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -244,29 +244,36 @@ static int ionic_request_irq(struct ionic_lif *lif, struct ionic_qcq *qcq)
 				0, intr->name, &qcq->napi);
 }
 
-static int ionic_intr_alloc(struct ionic_lif *lif, struct ionic_intr_info *intr)
+int ionic_intr_alloc(struct ionic_lif *lif, struct ionic_intr_info *intr)
 {
 	struct ionic *ionic = lif->ionic;
-	int index;
+	int index, err;
 
 	index = find_first_zero_bit(ionic->intrs, ionic->nintrs);
-	if (index == ionic->nintrs) {
-		netdev_warn(lif->netdev, "%s: no intr, index=%d nintrs=%d\n",
-			    __func__, index, ionic->nintrs);
+	if (index == ionic->nintrs)
 		return -ENOSPC;
-	}
 
 	set_bit(index, ionic->intrs);
 	ionic_intr_init(&ionic->idev, intr, index);
 
+	err = ionic_bus_get_irq(ionic, intr->index);
+	if (err < 0) {
+		clear_bit(index, ionic->intrs);
+		return err;
+	}
+
+	intr->vector = err;
+
 	return 0;
 }
+EXPORT_SYMBOL_NS(ionic_intr_alloc, "NET_IONIC");
 
-static void ionic_intr_free(struct ionic *ionic, int index)
+void ionic_intr_free(struct ionic_lif *lif, int index)
 {
-	if (index != IONIC_INTR_INDEX_NOT_ASSIGNED && index < ionic->nintrs)
-		clear_bit(index, ionic->intrs);
+	if (index != IONIC_INTR_INDEX_NOT_ASSIGNED && index < lif->ionic->nintrs)
+		clear_bit(index, lif->ionic->intrs);
 }
+EXPORT_SYMBOL_NS(ionic_intr_free, "NET_IONIC");
 
 static void ionic_irq_aff_notify(struct irq_affinity_notify *notify,
 				 const cpumask_t *mask)
@@ -401,7 +408,7 @@ static void ionic_qcq_intr_free(struct ionic_lif *lif, struct ionic_qcq *qcq)
 	irq_set_affinity_hint(qcq->intr.vector, NULL);
 	devm_free_irq(lif->ionic->dev, qcq->intr.vector, &qcq->napi);
 	qcq->intr.vector = 0;
-	ionic_intr_free(lif->ionic, qcq->intr.index);
+	ionic_intr_free(lif, qcq->intr.index);
 	qcq->intr.index = IONIC_INTR_INDEX_NOT_ASSIGNED;
 }
 
@@ -511,13 +518,6 @@ static int ionic_alloc_qcq_interrupt(struct ionic_lif *lif, struct ionic_qcq *qc
 		goto err_out;
 	}
 
-	err = ionic_bus_get_irq(lif->ionic, qcq->intr.index);
-	if (err < 0) {
-		netdev_warn(lif->netdev, "no vector for %s: %d\n",
-			    qcq->q.name, err);
-		goto err_out_free_intr;
-	}
-	qcq->intr.vector = err;
 	ionic_intr_mask_assert(lif->ionic->idev.intr_ctrl, qcq->intr.index,
 			       IONIC_INTR_MASK_SET);
 
@@ -546,7 +546,7 @@ static int ionic_alloc_qcq_interrupt(struct ionic_lif *lif, struct ionic_qcq *qc
 	return 0;
 
 err_out_free_intr:
-	ionic_intr_free(lif->ionic, qcq->intr.index);
+	ionic_intr_free(lif, qcq->intr.index);
 err_out:
 	return err;
 }
@@ -741,7 +741,7 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
 err_out_free_irq:
 	if (flags & IONIC_QCQ_F_INTR) {
 		devm_free_irq(dev, new->intr.vector, &new->napi);
-		ionic_intr_free(lif->ionic, new->intr.index);
+		ionic_intr_free(lif, new->intr.index);
 	}
 err_out_free_page_pool:
 	page_pool_destroy(new->q.page_pool);
-- 
2.43.0


