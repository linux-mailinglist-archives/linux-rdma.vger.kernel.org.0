Return-Path: <linux-rdma+bounces-10136-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CD6AAF259
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 07:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32CE91C06BD1
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 05:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBD01F37C5;
	Thu,  8 May 2025 05:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X075Xl3c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A43019DF6A;
	Thu,  8 May 2025 05:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746680464; cv=fail; b=BLdQJj/1zVOhawdX0djVscDC8nRX7/jYkUw5Cz6Xn13a0rlWRyqQhxJBUp1DMwepbnBXCBJEiFiTjmVEgqC0sHQZWHskx+Yk0DBUp3lKBJU+Cpum31Sf4pNIfWQicFffzpRpVdulbeIAZA3JLVi6cAZ6dMJa+ltycgqlBxH+0t8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746680464; c=relaxed/simple;
	bh=ruFTXOuach/z3DXbblJmujzUdkbNkPBFW+YQDcAEhzM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q37JtJPL+AYCFbDJU0H1PO1NJcde/5bA8Bx/URZ44pcnouCgcPuHyJdgS3XUoLv+LCyf/XntstsjSv0ImOXXZAMcuuEr9KLDR9T+EsFsfWQwXeElQMSkxii19xHo6X1HBh2dTqsF5vJtZ4SaSazOCoQF9K7vGRb7ZfiWubfe8/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X075Xl3c; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ua5IrWIzvt3tMvXUcJQ6lMHe1I+v9bEUbeI3rVEgbGIXSIAH8Q56yJNw7gROUzmjP4vSjJxaYYL9pf7hlGK3lKmRM0stBu7t2iI59ieirsXlKLjtwY+8NjjF1xvyKje+RBoGoNHAa3xQ/naEsgJkc99ecSFeCFn3uIN+4y2LPn2G/2d234AFij+iZMekGPn0kLcAht5MMlJAkXFm/Idkn3xwD0fufncF/sl0ITUQ84SKz+l0IsWYIURpe6T7CVc/+4dZs7+AA9YTLLRIZZVFSEApp627OrgvSOI/GFxBhgc8kc8VtuDuiQPfvZcP1aeY390HuAcgoNU5vvHe5JdeyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bS29eiVl+FmoAoRpYJTh5dBcSrBsIvbzDImtulGCMsI=;
 b=Q17lLrLODJ49A97Lobo1oqFdTa+/6xG2tf/RXVO6elQTv+ji8fFgexTI++szU2Jpx1TBaJjrM99gCkWe7Z9/8vBgZR1bleiKxG5sGTZskgEm8e7nfQPPo87cSg3D8Jtik7VVyTEC1elUQSEdLaLyTJKkO1cV7GSDi5V1QuYb58Qn42Nvc+kcXGkpZR34lzUejaUTlq69uM2313rswHSFBYcNYxQ7c3cT4rAt33iyXrqf5QDWgebjCI/jnevBU6ycMRPt7lfleqsjPV2AdYNJuWIE9q+DwG5Eu4Dqpx3kMUGqfeB/yVdVyjXrKE+jFAF0IDQGYM1rHWQXP+tWhCiUgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bS29eiVl+FmoAoRpYJTh5dBcSrBsIvbzDImtulGCMsI=;
 b=X075Xl3cD5OCOxYa+wxOkOko7byOn+6q4KXBAexaHSnCfW1/uez4Tc1cP7wRY+N2novfe25JsAVbWoc6CuRz9gOQVI7RE8wzXtxcpL7fSC5cH8a0JhcATT1CibfhkPGOmRHhPDPU9TXV/6cMq0g+DeV6SUaHBqH8nNwyLxYSEkg=
Received: from PH7P220CA0158.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::34)
 by DS7PR12MB9551.namprd12.prod.outlook.com (2603:10b6:8:24f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Thu, 8 May
 2025 05:00:58 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:510:33b:cafe::35) by PH7P220CA0158.outlook.office365.com
 (2603:10b6:510:33b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Thu,
 8 May 2025 05:00:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 05:00:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 00:00:55 -0500
Received: from xhdipdslab61.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 8 May 2025 00:00:51 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH v2 05/14] net: ionic: Provide interrupt allocation support for the RDMA driver
Date: Thu, 8 May 2025 10:29:48 +0530
Message-ID: <20250508045957.2823318-6-abhijit.gangurde@amd.com>
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
Received-SPF: None (SATLEXMB04.amd.com: abhijit.gangurde@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|DS7PR12MB9551:EE_
X-MS-Office365-Filtering-Correlation-Id: 315e61e8-a86e-499b-39f9-08dd8ded5254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UY5FIwdtYW9dRuAa68HSlsHxosNpH9R2H7mLSiVRhjwJFf+YJaQ9mN402mLl?=
 =?us-ascii?Q?tx/mq8RJJQcVcpX1PKQBJ6/vQAZ3xPWCgPbOb2aQkvf35li8wBdbMI3/Sp4a?=
 =?us-ascii?Q?7GEmVlNmKbgf+mj1iMb6xZ5XU23em1JBI8J8TGbNFLsR96yw2QVkmknEYEqy?=
 =?us-ascii?Q?wW4xwIlLjPQSf4QmIRYPrZ5gsdRrauI6tkWzemUIUX8QbLNK+9MQEPiRzHfe?=
 =?us-ascii?Q?x2deSqDFQ65V/mC3HxnKLl1ANqk1pOkzUQahBVaLoqtTHGHmKleIeMSOgg8f?=
 =?us-ascii?Q?p7eLF0QmC3l+wO/BSzx/JsbphcX2UHo0HZadk/yT4L8XWQqS2i7vDTg5Tkrp?=
 =?us-ascii?Q?t2L04GcRFo3mHwfwhR9422vzPUgYpfYuauWElK6qZ0DqI1eFObxVJzxrNzOD?=
 =?us-ascii?Q?QfgBP5/eq9KIaSADS8NbVKKljLisFhSau7IsuYfb93RbC1rD/9lvujRAMkdO?=
 =?us-ascii?Q?jPJOSzPcJhWf9dfI8ONe/5rnZiZ8WO15ad5fentraWqw37bJSdGWI/+lWAOa?=
 =?us-ascii?Q?r+i4oZIxio5BJxUqLstF727qcpM5Km7ugZp6fpZzSXkvtTDQq4i5xxJeCOrf?=
 =?us-ascii?Q?bj+EDvmh9fB7J9mOJ8WWkJNdmgdsEqdk393qpUHxyzsH42PtY+3Ct/HatYvp?=
 =?us-ascii?Q?Mq7j0SUnc0CzNGt69OUkrPcyd6LRH/+bg0fUu4N6ELs8o7jYFDCmTotmxW95?=
 =?us-ascii?Q?qgSMukdOLQGVQ6zlOuXSl8IVOgKm9cv4e+QPLbdIpE5FRxChQdni8ZkGFEBm?=
 =?us-ascii?Q?4qxXCjgoTNsnIKJVXQD/blRIUw2Ldx0mOVt4PFKFUgSnwTK0kupYD4pep969?=
 =?us-ascii?Q?Lcg1As9GL5PXOqSw6JrbddF8bpu/fEvuMClxMkadwXoqiUK/JNdEU9pWS9Ob?=
 =?us-ascii?Q?gp/UU4TmnddPg08CcHz9rcEF71rk26ZZqlm+jF0XFMAIqgolOvIOGSFQK1h8?=
 =?us-ascii?Q?SAi1iBn+yhvCAeM2Oku9WiE2pfjWoUGXmUVcvi6OVI+3Wqn4n1htl9CccN+w?=
 =?us-ascii?Q?hlHAUtzPr5zxN6n4hunmDY6Aai0UJ5Dcxpr7l5xqeO5Fqxpzx/WGfrbtuMGm?=
 =?us-ascii?Q?AuHPUIBlk38e9x0rWTDxBzs+RagYzxf0TzgWLG14gb4SEr/NGbMZ8wsJ51iX?=
 =?us-ascii?Q?2nkwVvELSYgpUwTMCr8a5C2gCZVuMrjqyk80UPQZTXAwv6ub1ygQlso8fzfj?=
 =?us-ascii?Q?Op16V6bwcqolgKNz3zwyYiWFQAI2HQnAxOKkMBx2hsv7GsQ6xvLyZGK9GeeA?=
 =?us-ascii?Q?rMqQdLmMlThZsWZG79OuCoCOcZspGn5fCqeUxCwUls52n8GX67SEmb/XBllK?=
 =?us-ascii?Q?J3+nzC95iyu17x5SEcvlfPBy4QpUoL9eVsfu11BR8dvu/HX1V2HI22w9pq0c?=
 =?us-ascii?Q?nru0iB0Z6ygQi3K/zHCoKTwEgefhSFa7/ia/qV9jafurCC/vnwkxUsa7hQ8b?=
 =?us-ascii?Q?Q+wvH5+GgUOZIkZ/GDdTm/OEO+9KFwt3mJGAnf1Yk641YP0jkDGYrwW0QdNc?=
 =?us-ascii?Q?laPZRnlfWwr7+9z7NsEvMjP+YUMe0/JRXS825te2OhtmVEF0gPedxD6fMw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 05:00:58.3039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 315e61e8-a86e-499b-39f9-08dd8ded5254
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9551

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
2.34.1


