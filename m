Return-Path: <linux-rdma+bounces-12737-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A76B25AF8
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 07:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B0716502D
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 05:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7DB23A9BB;
	Thu, 14 Aug 2025 05:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wi3/xkoP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30961EE7B9;
	Thu, 14 Aug 2025 05:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755149987; cv=fail; b=u5EVkcr/vNVv9NNEr4mXEVafU5Rs3S0Gcidhkab7zcIyWXotfo9TqFs0UL1bD2H5UeAAi6Czqruh8dql/tu00sJgYEUxSPHjLe+nWqs27UZ17MYSKnZEAdLAhINwcOPzb+BFrzFd36aLcKDhIUBkaaFR/uOvdnukqTqAgcztVQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755149987; c=relaxed/simple;
	bh=fX3Z5SU+ffWK2r2Gdff9s1fM0ULMEjyDGIZPJ6N6974=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FchPtAfws3YPhqWI5+jfd3DIFowH9u3uRAo2T+ceO2Jmi3G/jD+jbOVY4Bl+QcUplH6CeDH7jyn+EduKD/VHyZo3vxhMIlJisM4owrx+j+rzUEWfWr687wOSPxgjNs9RywitDRQDq9Gogvh4Cdl2tm+6G9igDcG47CZL4hKlldw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wi3/xkoP; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GaPEheL0FFochRdD6Jth5STL8+uzhHs7A9a9w4KI7dsBoFgnLrc8R8eo33OwyDR4jRM+OOdtJUuRLdgUzA/dkMqflSSrlsKdXFcVbEqiX0S/nCSW11z9TpDquOrSuwfdgEl9HF8JmWe11K2Ih13kvUxb9oKdSwqFmthSWF6Q2tS9uhJzefbxzppWmr/u6zssj33f00BVFaOulrRQ7l5YqPb8cvfrnJNq9KO0SmbaXbQ8m1k9yskW3aboNXGmJiMD9WFhZjN41P8mjw3QxzyueRXYmSns8zXnOtMYeagErUJ9jOqpoHlpdZ+9uzgdAVZm/N/GNvIL3FIWz1Hs2dMAlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xflnG8/TfydJ8Y6B1S9sEjhxICv8C0Om/JD7epWP4ZU=;
 b=fgqeqQflNu1scBPPo7d36QFAFkQ+KD+IckP3FDJ/9IFwVcOgyn2Sz8cmigiPG4CdZblOPlvTb9L0VzB0qrL2cC9q/3XDuun2U78O6EobbfqTlsLq5iUU69oFHS6v+F/SlFpoH3nj9sqREeb/sMn2szhm4bXHeToWehIvLNIPGIwop4umABh3slyRUX2pPC80c7at0qNUqrGjO39qsYlufIMwYFSKm3hO5z0nDKELo3FTmkFf0eeziBWS2JT+tTmXrA7c4sZjFk/OViQ5wDpyoB60T7mbSDc4aPfbp8XqSVZOsDVifcT51yoAX7oEWlg4wIKbUC7zIqgJof23E8RKzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xflnG8/TfydJ8Y6B1S9sEjhxICv8C0Om/JD7epWP4ZU=;
 b=wi3/xkoPY7L6HJKxxPJQ6smubNhM/pJv/xR8lV9kTxvk2S7YKlFBjWsAjqDw/5Ai4vOB4yHisfqss7q6UA63ZnfKtelGcQQdx4YgZMgEq5EGUwrC0abXYRbjlni57xcBC4pLyvbzJGi9/Bzon0wqm9WYTSzKMggZim4LFvzy5GM=
Received: from SA0PR11CA0105.namprd11.prod.outlook.com (2603:10b6:806:d1::20)
 by SA5PPF06C91DA0C.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 14 Aug
 2025 05:39:40 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:d1:cafe::15) by SA0PR11CA0105.outlook.office365.com
 (2603:10b6:806:d1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Thu,
 14 Aug 2025 05:39:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 05:39:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 00:39:39 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 13 Aug
 2025 22:39:38 -0700
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 14 Aug 2025 00:39:34 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <brett.creeley@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <corbet@lwn.net>, <jgg@ziepe.ca>,
	<leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <sln@onemain.com>, <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v5 05/14] net: ionic: Provide interrupt allocation support for the RDMA driver
Date: Thu, 14 Aug 2025 11:08:51 +0530
Message-ID: <20250814053900.1452408-6-abhijit.gangurde@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|SA5PPF06C91DA0C:EE_
X-MS-Office365-Filtering-Correlation-Id: ac48c6f8-fae0-4cc9-5692-08dddaf4f667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cn0ByaBzuSiQ3la/zlZiXAeIRoGDyNYZEeZSKayK3oVN9MTo8Y6gVznZiLI2?=
 =?us-ascii?Q?AyuTfyFpjsgV7M7ZOdvfHoJHSjwCvJ0uvTUQJr2tuyRu+EdIvtWJ6AExiVzN?=
 =?us-ascii?Q?9aTP1xNan42ACch4RNKsb/6ioWpZPkC4fHC4/JY2GWMZuteODyEBORPv6LtL?=
 =?us-ascii?Q?nJVuyhhN1HKaYy4sb+YapLFbHzS6tNnmIdHpGF+EyTPSOBbL1ZCT60Na9ejK?=
 =?us-ascii?Q?IpyW1aCsLMWtKlA6CYjO5P9NVny48KhzRE16wsRqxPnR+LAGlWSHSfQUGTWk?=
 =?us-ascii?Q?wXM9S7E8I3kzfMIr/+3fsZ1zGLo1kEjmAVXUfH7Wx1pNUXBzzt+tRVC65MU7?=
 =?us-ascii?Q?n9/ith1Zx96XCFewefh2Z0Dthp49fTuM92BOas62Rz9/TSYURoV2jL/w5ViT?=
 =?us-ascii?Q?dytI27Mw9EhVNmB5v6ipzkTj3tcwhnt9A2ju2SSWdhE0+WVbQzMdx1s5EdnG?=
 =?us-ascii?Q?jIazcDUfF+HbB5/s3z2uFw+D5DN+KDHk2G/XUXURlcQlzlR71H2jeknf1Bjf?=
 =?us-ascii?Q?ucouen+aIXCDpLCZzJL1aDWhsJMXEQ/kAYKewFX6zrrQvPW6VYKYO00CjRSY?=
 =?us-ascii?Q?/C+eP/H8Jc3QOaJVsDMLlJ82PnHduL778rD/YD04nFWV+4X6UAPaB/Iiqwkn?=
 =?us-ascii?Q?T2iZi4NS6g6KyhAPxy9Gxtl5wtfJ2oLvZkOJPhh0uhUJoNI+5srZT3arGezS?=
 =?us-ascii?Q?JusHrdZNlECMjqt9nQeFtBCCCrSg8G161YgTt4GdPtOKry0ZsEx1cc0wop4U?=
 =?us-ascii?Q?29lAM6+f68o3fn8+YFdqitVUj2PGfV4R1XYlwAzNvrFIhCkw+1syIrXxnAdn?=
 =?us-ascii?Q?72GNsEF0vchEE9mem6gJfyvpq2j+ZOb46/Sor9FARWyPUHC0M87xPh0/cHJK?=
 =?us-ascii?Q?pwf6WvIYtIXiRpJfYKg1dWk3dI6X/u1MySS9HUwJXEreFemNx6ZWM9dx2uvp?=
 =?us-ascii?Q?VEDm1wNCewcmUjH8KQ2Ki6b41138y527wE+gU7iCHFfI4QqP6lRVB5zeAWEF?=
 =?us-ascii?Q?msxEXxuYW4U4FBusbz3M8KJfc6hzb/nDieyGIolh5Vk/bIMYDBbbBbU29Mik?=
 =?us-ascii?Q?OaL++oXQnOR+ZBZP64icipWr/seUenZ1/elDwXUDhNFYK64QukzndsWDsvgu?=
 =?us-ascii?Q?EWnO7M8vPadaXl2uMNWTOlc/KRyNO3doQ46OYNhDh2j4GrUMyJv7G6k5ZMqi?=
 =?us-ascii?Q?DqKBElIn4Jv6gQo+9dMdbMoXiH+GBQbsL3MjfAw1DLIwlzqbwNjz1MQzwl4p?=
 =?us-ascii?Q?kEwsW0/ffLRYlQVdQriy/6gMspXpMkiHrZ3ynhLuPQTnezHUMstz5YIlqJoC?=
 =?us-ascii?Q?YNJK1L/IUmzB6YSgEF2UCvLPnGkWfY0K04zDrkE2RydlQmTHFx0Q8hA4urrs?=
 =?us-ascii?Q?raX37ZNtaxLWfi8FlpemZSsFLPsUCwj8arjmUdMG85VHwxJ3b/xCsNaMkYTE?=
 =?us-ascii?Q?OGNZDOWmS9XkurrDje55amcPJhMfMC0WCDqAzrgNhFkGMM074jb1ha/viVYn?=
 =?us-ascii?Q?6rICsZ2BSQpfgz4qXEFaI5JiOYCkVeKtKniU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 05:39:39.6652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac48c6f8-fae0-4cc9-5692-08dddaf4f667
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF06C91DA0C

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
index 8ed5d2e5fde4..276024002484 100644
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


