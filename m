Return-Path: <linux-rdma+bounces-13053-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25665B414EF
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 08:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 634E07AD51B
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 06:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558022DBF48;
	Wed,  3 Sep 2025 06:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jq9thBIQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600582D7DFA;
	Wed,  3 Sep 2025 06:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756880275; cv=fail; b=TNzSRaqPRkF1ESyykDzMOkvk1thCOaMMo/xqX8Iqw69sLlz1800xmQTIX3ASAqbbAVmXiU9HoXoUiEOZ60x7Hm8XBHogbEa1kIf1IV7w8+F1MZPDwOqcKqluslOVXNcRqpcosefJKF8N1NKIJmi6Wu0Z5qRfd8mRmdj8jPBdrsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756880275; c=relaxed/simple;
	bh=fX3Z5SU+ffWK2r2Gdff9s1fM0ULMEjyDGIZPJ6N6974=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CEl/lY83hxODIamEtl7NgivT6YLhkD0AhBKrdXAN+VtCyBFCHzdbtGCvWzeNMkU8LLRG+Bj1XAJDgpzjlhooQnaOHmp8BzWpMtwvFHuluTUnOfgdM/Gk+2xjA3p7fHmx6Lj44a/UyhCwjVKbMREXi3kQAG9xl7+sd+F/ZvA6C6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jq9thBIQ; arc=fail smtp.client-ip=40.107.244.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FlAI99l9KuCOdmOqV6UhhJL18mNojbclOoPhfhsVy09wVtrwFrZuIpHOq9+L+cyInK+yGWJnUvp4Teb0lY2W4o8ygpq1nfyaUn+3wbY1908lzyiUG90cJcHs8bOIee0O7IUlSqZV/Xh6FTPVx39Zk35k5ZRuBMwQXmKe2SiLhYwZJgBDFJQcQivP2nW78VnamqQ3H0cGmT8vWmiWLq8ClKCwPcbC+xB+r+hpAU1wH7rb++V5fnAujd2oWeuqms8/OGGi4x6MHkfJu2ujUXMTTTWtG4ukijs7MUmBAB5Fs/aZ6jjr5JNG+jmaa/JwxvgIWZQx5fpxsCJEUX7LkEFumg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xflnG8/TfydJ8Y6B1S9sEjhxICv8C0Om/JD7epWP4ZU=;
 b=eOaX+oHbhQRyXYtvTzVmTqboCqxxGAuXW/kkPhzaaddn3DQyaXZfxQJ79KjjNHWvSG5YZu92n5eiLK4XPEO5pBhJ+sx6cu9jy8BbAOd/dHIXTa6d4y1yJLUhi3TkyGuhJnqI3VBe+FYceKP3vUt8m+8HYWkquY4RlV5JLiuL7LUUx3UV6SrTEPlje1ua1MfERB/C2DYMj77Pf1/RV9TWfx4WhH65VkyG2ZnE10jtOKrHDwieBMMJKaW8maChk1qiPljRHyampgHzX/7HUx0crVczkLg2D+KeFIO+7Bnt1p2XOgTGZOUVvT40O88X6T6bwWFa2LJxS079ogwlHUdpSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xflnG8/TfydJ8Y6B1S9sEjhxICv8C0Om/JD7epWP4ZU=;
 b=Jq9thBIQz8Xcds73pPcsnfWeNxxjUs5aAcQqU/73Ukhn3ZV07Gxw9IV01sJ2ly8uS9dH1A0mwd6GYqdFwsz1Ef6PUwgYB6OCUUdAd19T5S2/gBpeZVprr4bhNTjFEQF+U3hdpVp4vOwyNmVIF1cZpMx7fHvYpBgj/99i/ufEi6U=
Received: from MN0PR05CA0025.namprd05.prod.outlook.com (2603:10b6:208:52c::13)
 by DS5PPF266051432.namprd12.prod.outlook.com (2603:10b6:f:fc00::648) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Wed, 3 Sep
 2025 06:17:46 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:52c:cafe::73) by MN0PR05CA0025.outlook.office365.com
 (2603:10b6:208:52c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Wed,
 3 Sep 2025 06:17:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Wed, 3 Sep 2025 06:17:45 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 01:17:40 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 01:17:40 -0500
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 3 Sep 2025 01:17:35 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <brett.creeley@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <corbet@lwn.net>, <jgg@ziepe.ca>,
	<leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <sln@onemain.com>, <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v6 05/14] net: ionic: Provide interrupt allocation support for the RDMA driver
Date: Wed, 3 Sep 2025 11:45:57 +0530
Message-ID: <20250903061606.4139957-6-abhijit.gangurde@amd.com>
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
Received-SPF: None (SATLEXMB05.amd.com: abhijit.gangurde@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|DS5PPF266051432:EE_
X-MS-Office365-Filtering-Correlation-Id: 6abe8b48-1659-4f7f-7114-08ddeab19950
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iQiM/jrxLjvPU8Mkk1Uam1DQWt1dKHVgiO2Kb5Mty8YzBfUUl8hIuPPYHrsb?=
 =?us-ascii?Q?cpiEIvCWQ6RxELUIN5QgEcZF7LhKSE8Ym1ktRlHP+0Z/zVpT5+7CqYIWFjr0?=
 =?us-ascii?Q?6POA1FjiYPq11+dkZJZbTP+ZdJjPt1WNMtNaKcrjfGXxi5hZ8045VKM/iJZZ?=
 =?us-ascii?Q?nWvhxYq2RCLoh30cvFwD6Tgdm0sNRrGJCMSm7BheeRXGBiCkV/JfRf3PTRLS?=
 =?us-ascii?Q?pXMY2RWaFGvZqnL6Y5p/fhmQlBcJ+JPy64/oo/o1zNq1f/+BqDgMn8Ld0/Rt?=
 =?us-ascii?Q?4AI2QWQPZv2pyRydnyDoXDcS5WSd4TK5Xp3qWgap9+UaRagSarMWLxQOktVH?=
 =?us-ascii?Q?zXlG+V3GMYFU+LDFNOlc6+iWjEx0Ldyw6SRp3f7ifNqIFUDzaf24YeIDIFnC?=
 =?us-ascii?Q?q14OkZ90R3Odyo6IZgMQHFwgwkXLzXQAZOTTy3YjREjQuyG3/C/3SzC9O7ir?=
 =?us-ascii?Q?OAT5eCjHZbDiXy812ugVsxKAKGftrpiV+ezFPAngYpA1JfNMD50xra8++K/n?=
 =?us-ascii?Q?gIPzMSgKchGPAUP5PsftJYiZQaZpCXT4WdCRn3YlqN8RwS8mLF5gZptHdT9c?=
 =?us-ascii?Q?pRS7/QWaEl6H08T1zWF+yIZNvcUmH64ftT63j12G1niugQ+MGAFBhYU0xdsH?=
 =?us-ascii?Q?5c9bRZszRlw/7H2KJfBG8YmQigi36zX1B92wB7odfM8GgyBhP81MxwvMHhKD?=
 =?us-ascii?Q?mB8SA5kdPDt/THmSgHVi6hbsHTxzn8tCugD6HeOcbRcqh2Z1MMWJwEvQNsJu?=
 =?us-ascii?Q?TtGAc7i/K0xkBAJ6pp44845Rsk1wqH1bdXVCsNcL5KlnWxl0Fb+xhGCxHlQB?=
 =?us-ascii?Q?coHjX7Z9pwRdEu6Qw9REIdm0hCaE1iBWLUiv+ZWFBSKvdFt3YI+CRPiGcztx?=
 =?us-ascii?Q?9Y9e8LPmBE/FnuEbLHqcE6YRi6EvxN0YF1efbFJaZ1DgXm/89zBO6NzQUYM5?=
 =?us-ascii?Q?ukLGkGtzJlZIBgQpNQQzynZDxZFmweyJ8npFetyGeFzuWfMrm53yNa+hh59J?=
 =?us-ascii?Q?/pXv/XEzXr9Sp7AQhSMAOiWn6LqHT2wXiPUpoYeA5AoTHXBY1Ty0uXGDxVQX?=
 =?us-ascii?Q?BSOvQBrAHv17HgR3i0O4dqiOWXfIQ1mCuXzrUb9tYEzR+f3zLq79qzkAkpP6?=
 =?us-ascii?Q?NLgEwfcMRcHDNALArJM+7iUk8qB6YX3erI3Jhq8ktJUZQmdFDjQIZc/ejfIA?=
 =?us-ascii?Q?EJ+cMLshenTcYhqchEQdWooiG5OKe9pPb0bVWohU1q+rBlY10yWmjgX0121R?=
 =?us-ascii?Q?7muO6bPpBNEsq+C8xAINd17uy5wcXbiCvAYvcPHOISzgUM4Rlciec0lXv8bG?=
 =?us-ascii?Q?VTovqxFgNnU1HIhUWfxaE/BeQgkGLOeziIFRa8PkVZQqeKPtci15eTK3yiqG?=
 =?us-ascii?Q?swD7v/D633pXADpFCRH6ed7tX/yayESNyq9/gDHq0g1FIx1UOeUGfpEntSui?=
 =?us-ascii?Q?l8C7Lr6j8quAe5DpcwpFXseyaLgoAxhiyHdD1f6nKccYXyzfLKZbnE21M/Rx?=
 =?us-ascii?Q?P8X91hyQQvc+SCzrLngcMr6sVHDbNY2q5gtk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 06:17:45.8333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6abe8b48-1659-4f7f-7114-08ddeab19950
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF266051432

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


