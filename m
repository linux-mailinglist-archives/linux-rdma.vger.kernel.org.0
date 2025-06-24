Return-Path: <linux-rdma+bounces-11574-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 247A1AE6465
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 14:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FCF2405BE2
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 12:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0C9298CC4;
	Tue, 24 Jun 2025 12:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bf6Ehnkq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E707A291C0D;
	Tue, 24 Jun 2025 12:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750767240; cv=fail; b=pTDZKtmR/Kfy3MDSnuxxR0SmUHro3Fe6Rzd6l7JzGlD9JIPhEFzHgLND70Yxxkh8i5zZvu/K5GHN5OsUAVmfmUgloP7uEW5SEUBmHd0AUkErNvTAhtitpsv6XIk5Pf69AJGkT8wxicIjITV9T2wlmzYkOjLWK0K+2KcX8xLE2AU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750767240; c=relaxed/simple;
	bh=aqGv8x8xiCRuVokmXHPFXh0YmUkYQcz84Ac/ouQdmOY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IXeSgbb8YoyByWw2qD6blmgkHJRX9sm2NIhej3bcSY/W2FdRX1gYrP3UZUvl0LztRRB75Ig4ipLVI0j3Q7EZGXm1hkKnhSmwzBtXFWTTYcNFxeG4p8ovsgrUMYLsREOM8nwhB/BaZ8dFI8Rk1QTx7Yx3n6DHUFPyZkns52XmiPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bf6Ehnkq; arc=fail smtp.client-ip=40.107.237.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kY2OQLo+7LF4JSGSpiI9ud5s4jQVe03wUg8vqpzSfBgwz6lckzUD5QZRC9DYetM8vKqYi5ZZr0ZQgmvcymfW+PG6iPxQUfGC0Uwd2GjDKMB3cKgVDvrPJHsn7kbMyoLsyOQCKwAxcyze5rjo/bH1uGUdn5zAIrhkXBxCnqJZk/MzYCb0C5ijKIS7S+E4B48OhSBmfgySziN81PwkFa2vP8LdfilLCI/8SV2qyDYWhjgNvcuJp4YTfPWOKiujDFxWfxSLKBlGI87bQIbJtimQizDLdp1sTiNbC0/o/EK2mfLwhskoKP1zmJBnlaJRHO0gMeOGi5OszxNvI1vfhTgL5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFx/dmppJWhrBmtc7FTHrJmb3RhB//ITRFbLXMcp5W0=;
 b=ZhWI4ft4HHJIDZo+r/yoqQOFRGL7atmwLWzADo4+jLONFq9HIdzvu4b8NNAUEON7gQU6OQf04Iz3s3tyX/82olUyIC35DzYHgQZVzsbUar3VcxjX/wzHtQtZk3xmKtpnY/is45GqpZTkOD1F505nVh3VXHkbWalzAbJ8Mb3s5cay/oieC2oXEaK7THbxA6T2TVG09hXSMkdfjKNM2dnkjXNJDX4hWLiqkAFMjrsxRee0hDyLRkaYXZx1KsdTHttNdi1ODWyBBcQkG1+nW+KKxuRY5Bi4jSzSrs/0zQdCZ+2qKhZpMbELHytI5Xfqn17Q4A15est9M8ofQFZaE/RyZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFx/dmppJWhrBmtc7FTHrJmb3RhB//ITRFbLXMcp5W0=;
 b=Bf6EhnkqTzAaI3yChQS1UgsPMOAwe7bzCASdO8emkzRIqUJwUoKrGlvDfEq2nICHOMl8BhHmXPFWSb0xx9JruEAg9qiOjujiCPHSgU93S9h9IM8Zv6YzgDVXkkpET4Q2mnp222s2RUptJy3N4JrLK3dqm2H8UXosoIBGFB3Efms=
Received: from BN9PR03CA0722.namprd03.prod.outlook.com (2603:10b6:408:110::7)
 by CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Tue, 24 Jun
 2025 12:13:51 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::a9) by BN9PR03CA0722.outlook.office365.com
 (2603:10b6:408:110::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.27 via Frontend Transport; Tue,
 24 Jun 2025 12:13:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 12:13:50 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 07:13:49 -0500
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 24 Jun 2025 07:13:45 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH v3 05/14] net: ionic: Provide interrupt allocation support for the RDMA driver
Date: Tue, 24 Jun 2025 17:43:06 +0530
Message-ID: <20250624121315.739049-6-abhijit.gangurde@amd.com>
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
Received-SPF: None (SATLEXMB03.amd.com: abhijit.gangurde@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|CH3PR12MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: 783a5a8e-9a9b-4b60-ce1a-08ddb3189477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J1X6qAb8p4JST/+EhVSu8BV+VSkzh2HcPNpJ0ruUBYbvJYbPU1oHF/PhhCzc?=
 =?us-ascii?Q?z86sfB635+9I/JcMF3j7f266mPBNBe0fc25kQxR6Mw6M7+QqmFKkL2p9QNhV?=
 =?us-ascii?Q?o3vNKLwxp8pSKV9OVqzdVkw1Isc0KQIxApI0XuqP0WUgwlTiJATY17qbZfw/?=
 =?us-ascii?Q?nWz13aTuuszn4U5zJFm7+APc00iTWgXrMhNp0Gw36rMEG7VC5tqUNzYnqa/5?=
 =?us-ascii?Q?APW4Tddu6y8EVKmNKdgLU1bdhLPZoQpJ60S0pYcHT10j5iG09Cc/emQKUQOP?=
 =?us-ascii?Q?9NtOPqQu8FBVTokorQ8gvvzxZ4XxslVrBeO4wv0ebn3i394feCQJSSRSd80I?=
 =?us-ascii?Q?If+P17uaVU8m3OmMqxCYGCoMG74PfxXBaMTAEQOPfFOuObEXlVpwAF7n+h+s?=
 =?us-ascii?Q?VxSoFEIcYND4Q9BDL4+fXRPjAXeH/M/8+6Af90J5zRdASL2Aaq4AeQQzSS3V?=
 =?us-ascii?Q?TmkcTZ1HPP/eNaA9zTiNnPPhueLRnvyRNZe1u3JP82m/mXn7RqcKIStJqrRq?=
 =?us-ascii?Q?iLrKRYu6B+VrXMeuLfYuOH4XdWHcTIVn5nIUgqTKNjMR49wmALrKjdFWKAax?=
 =?us-ascii?Q?bqzP2AmRbW1Nr2CcLn2V/PWx/M4TUnt/GDFWNVR6MJY5JS0rR57w8RdEJ20F?=
 =?us-ascii?Q?/byhQtLCpOx/DCwL0p76s3CknGsIyPK7DYxrgMoca/kun3Kno/Ckkiticx4B?=
 =?us-ascii?Q?79XtJUCLCx/bRmgTQ/WC7IqGcGFXPqbHnwfKft6UrX8uRX3ktBR13LMOiNJW?=
 =?us-ascii?Q?NxE9jg2UXY8l1ZHb10KOufO3zQUBwjTjKPwN7qLnEBprG6X7/VfEbay7lNHK?=
 =?us-ascii?Q?aeWucLR9iUmlkA/51n52He61IDHWUX9ubrgq8LpQrhF6Q7zGRcaOzSIOtWen?=
 =?us-ascii?Q?oF53ELet1x//lu88K6/T2TjujG+wHpwNkIkoFNUmuxQNPG3+kGzpwjqCJPs4?=
 =?us-ascii?Q?ofZC5kGECwM2gTDNtScrGczM6qrX7mNqKNyrju70k+UEx0rdvOd5iw5nvV/L?=
 =?us-ascii?Q?NfR+9YpfcIZ1JinGfpVh62IC0ezpgUuTKYIPmq6BzPpmXJhLQ0O618AQTTyW?=
 =?us-ascii?Q?frfBCBAMR7q+LEffb2VWl+8n66Sy3pQnCG9MzgIQEFNLCPPCD/8GnUAHjxBv?=
 =?us-ascii?Q?t3wGoYoS0YIaGORYpXU3A7GjRvoSo/KWr8kf53AxZcDkfOryVFSIybSMsKsD?=
 =?us-ascii?Q?ORVhQ6+OByigiCuKqsIAknnohrjAzC55OsT1TIi5JOX7s+MKvX7cE+sODpVP?=
 =?us-ascii?Q?PZr/IS80C64j3jKNFQ6INbtoOc04VdrgPVj/YURZX9HG5bs2+EIA5NOML4AE?=
 =?us-ascii?Q?fSrs8lCrkKKwUFTzJqjk4dSHAmJM24GQ0Aw+rXX9rwzlbsLt4BtHoSgSDyu6?=
 =?us-ascii?Q?p6hb63IK7CiLowB1RwveDvN9UNebR7mkAQiGVkF1iQXGVv8bJPBo5dhf/wy5?=
 =?us-ascii?Q?uklsVMHj02ZY4WIHu/QnkWNiKkGEdvD7FmMo9m4KtoYeyYLBOJZ7ApX4i554?=
 =?us-ascii?Q?EVH3j1nMAPGUMMu78Oyjjjqtcwl9lkGp2J5TDjRd2SWDQHHw0iPJCmIP+A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 12:13:50.7521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 783a5a8e-9a9b-4b60-ce1a-08ddb3189477
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8658

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


