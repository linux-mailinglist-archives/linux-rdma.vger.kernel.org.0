Return-Path: <linux-rdma+bounces-13057-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7C5B41501
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 08:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFAD716B225
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 06:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA822DFA28;
	Wed,  3 Sep 2025 06:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3kGUpR5j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB2F2D8375;
	Wed,  3 Sep 2025 06:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756880301; cv=fail; b=r7bHtdez0Dmgk34Qs8A0ZZyrs5BX7yXA/3qkuX7U9kT9gNnpC2dDaraMk/LkhAGnPQ+1G9YzgcjH6A8XYDKWMUpJnq8e0yruC725bqGIp7UoFbPmUVuNsBVpu+8kGQM6bV0Fykrv5a/439c/64ycHK3bju1VJSyLaTe7BqT5G0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756880301; c=relaxed/simple;
	bh=sqJRhSMM9MtkoU8TmMd3EtXEJ41BgHPqdtxZ5W60lfM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E3B2O0LUi1ty4o5eOFnOZAta4oKWokZ07Iii2UqHKVzmBbxfepKfuCnI5dMf4z0i+J/A0G0552JHze1HvCAUzAjZlFGxQc3Rg4drm6q4+MhREUUIHwvvlsFoROScq7smK8JY6Itn0ce/l82gOI/RFRGMvY2PAjfYIbIdnUF9MpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3kGUpR5j; arc=fail smtp.client-ip=40.107.236.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXrDLCLENSLNQgt28wDnDBKDaDTCbVDUX1Mkqr1qIds132hhnkw8W4+FHWJWR2QuiwOGMsoZwekcVVFRdJabRo667WUln0kGw2WqvuVaZwMqrmqKKfqmgk2ljc5q87vMW7WOwXPYy7jG08TUDSb2K4/oCnPKRO9BvJEHQF7zTQDV+dF6RU6Dk71CmSBrxu2NvRlXlJZlVHGw7zM0WA6I1yj9HyZ+nOIsHEGe/wHAAmN/AbtPfudaZ9CZPb0lkDi6Xily6zwKklDc5/IZ5HqZ8Ws2sQW1izU30NzS6qA2RNJRTZe18UjIvs+m6DqR14DT0IRcHJzebhsvatiMbE5Rtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBk1reaVebmzy7ubp1afYXNzQdBFpJRMcZW4AKGma4o=;
 b=yyjUdjEztUODUkBXPEV+kAzpmUEMSMRzZ0zwbIVTwksrDHQscoajnU5DHchL6ye+f9N2r/67prOxm9cCd1l2NN34EM/1uat0/Erc1UisKnXU4wwGy5dr1Ls/k+RlTE0O7mtPeNzKQt23CuKgBcGhJacBZmYtALG5UzGmlydt6vbqrCWYsevlCB4hFSBSFBcU+dE/wfIEhrzgiI16J16MR/MQnCChjFAoYoZq73HRlLerm6v4YZrvIfAaetRG+nSxyVPiNxIhgRLqbREyoUY+cMfZ/2cjpOXhGVc5EHvJfjjfZli/VnPA15qtw3FMI52DddqDbidsuCHD/d4NKuI3Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBk1reaVebmzy7ubp1afYXNzQdBFpJRMcZW4AKGma4o=;
 b=3kGUpR5jNcEVhC91aHsooM6hLwZHgK9d4VWe+d2T6Fy4QtL0oSzZy7Dg3410J7SB46qKDC6VUzhgExxsd3ZRwaYCsz/3PM0rqcShdVcBlL4+G0u5aQz7Ow38z3jsvkv+hWezmOYfoyWmiefOUO2YEMjF5ReY2hZT6+vtGt416II=
Received: from DS7PR05CA0010.namprd05.prod.outlook.com (2603:10b6:5:3b9::15)
 by DS0PR12MB8525.namprd12.prod.outlook.com (2603:10b6:8:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 06:18:11 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:3b9:cafe::87) by DS7PR05CA0010.outlook.office365.com
 (2603:10b6:5:3b9::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.6 via Frontend Transport; Wed, 3
 Sep 2025 06:18:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Wed, 3 Sep 2025 06:18:10 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 01:18:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 2 Sep
 2025 23:18:09 -0700
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 3 Sep 2025 01:18:05 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <brett.creeley@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <corbet@lwn.net>, <jgg@ziepe.ca>,
	<leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <sln@onemain.com>, <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, Andrew Boyer <andrew.boyer@amd.com>
Subject: [PATCH v6 11/14] RDMA/ionic: Register device ops for datapath
Date: Wed, 3 Sep 2025 11:46:03 +0530
Message-ID: <20250903061606.4139957-12-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|DS0PR12MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: d3191de0-8f3c-4201-eac5-08ddeab1a800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k7cg33/Xw+7MQAPOQ5O+v0gehDJAcx9Y1nyePFxml9jHMlUAr4AhPdhlj79T?=
 =?us-ascii?Q?eIWdd3v5RQz55t78WZTiqScVqtYC6E1s9cfk5ms9jr2CV3f5UV1mMzB/gudb?=
 =?us-ascii?Q?TxENM23JhDTWJ0w28EOwZwmGJtPUffpGkPiC6P9wIWAOY/2aKoFUaG6NPEGR?=
 =?us-ascii?Q?LGDxr8LvWlIua/u5D8R3vWJV70mf/wkmuy85iNYWn6BYD+eRTzKuAXmyk7mt?=
 =?us-ascii?Q?emnBOq6OXdaMnFXq8FCTC6VeThxYi7/J/AehkQIP/uDtlGKpsdxS9y7veJJ5?=
 =?us-ascii?Q?LP9chSniUlrAgBSglqOpy3egQTIhJgyc82IwwYLIufgy2rwv38exz345y0Aq?=
 =?us-ascii?Q?rQnLlr2krqqxaGR6QfecUKKG7BkdmBqHycEmrzgYcImhXjX7M8wkNXR34L6y?=
 =?us-ascii?Q?9mMYF7SO7zFQfhVD6dLLfkTLkk7cnbdf8mX2t5m8eF1xSa20O1cPqvNDDepI?=
 =?us-ascii?Q?5PpX/pWKovdmJBQFxjcrWfYY6ASl78g1bpjhLu+32bTrG48WkAlwJ3RZoEuB?=
 =?us-ascii?Q?DNRWAI8ArGSCGoUx8Z9vOIXCuQCkhOW/gDZgCO7zLGw9w0854wgI95MGabID?=
 =?us-ascii?Q?C+W0jLI+N7Bqxg0h3bOgvM2EKWEwZry9POMP1MRS2kXjt6DJV4mesj+DtyIb?=
 =?us-ascii?Q?WXG4QVjtc5G4E3lw6AqifN8dGqopzUjlijxLZsHNUFQUCYSzh8zUYvhE5UWv?=
 =?us-ascii?Q?kNFJpJm2ug4oQGrr2mVEabiYONC0eO6yVK16CAX5GP9MK/uFEMAnzQmsxiiX?=
 =?us-ascii?Q?74b4ZOVHmk9PtS07D23BKuI1f/lcD5nR8Gqis7tREqw5YTUUbqeVnFDZ3UrG?=
 =?us-ascii?Q?tp3A3ba83MNKzTPZeh56jAdWCU0+RAuJs5tlx6mpLJsrH+cE0uPjlaKg6uSZ?=
 =?us-ascii?Q?xyR62ix2c64O3ji+i9OnELeM4Us/lqQBQGiLLQlZ8MQpEB7AtQ7mW7QLz7e6?=
 =?us-ascii?Q?Cc8MQ/RQ1tIMc1RJlQatUoGku3e4qpbnhRcg3N/h9CJ2az3Cx//lW8d2iuir?=
 =?us-ascii?Q?a4UglJqhpD6keotCgpyh0dXkpdV2q0X4yuDsxkKUsQFnbw6Nwh22tXMmgnOv?=
 =?us-ascii?Q?nKoD90Oh1+HKDUprsUTgPbUviwHWdyK1bwWJ6nS3C8X6x/OaapzS6JoK9okk?=
 =?us-ascii?Q?KtKw6QkUDwM87NEZPWH72Tc7AbRJ4eznPi2E7oqDqorCEfUSRZxthqOZcNP0?=
 =?us-ascii?Q?uHBWYVgxV19H7YQpYCP+xt5i0j7cowAIAhZrpfUPDCruVEGATY4pSsrI2KMF?=
 =?us-ascii?Q?pdZz9CqEbMn9kZk8yib3X8Xf+3GGyqJQjaPesaIhW1HOT3pUJK1RFEwbRsOc?=
 =?us-ascii?Q?YbTh48G7+RLATUIL2hXY/hPeRTZF/YVCaT9PJbLu0bscI2eR6TLkrTlpeTRf?=
 =?us-ascii?Q?n4iI/w1sELHIrjmhyxBzri35K8RdyAezeG8R4Szwdl8cvMOxAb9KBnFDNCKR?=
 =?us-ascii?Q?vz4w4s9PFfZvYYpUaBWv/dn4+2m8NPd/w66Kn3uVFaKuPq7aOs1iVw9creA9?=
 =?us-ascii?Q?noS/FeexMNDMuj9zHAdelLwMHuBfVrppE1Fb?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 06:18:10.4385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3191de0-8f3c-4201-eac5-08ddeab1a800
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8525

Implement device supported verb APIs for datapath.

Co-developed-by: Andrew Boyer <andrew.boyer@amd.com>
Signed-off-by: Andrew Boyer <andrew.boyer@amd.com>
Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
v5->v6
  - Added misc comment
v2->v3
  - Registered main ib ops at once
  - Removed uverbs_cmd_mask

 drivers/infiniband/hw/ionic/ionic_datapath.c | 1399 ++++++++++++++++++
 drivers/infiniband/hw/ionic/ionic_fw.h       |  105 ++
 drivers/infiniband/hw/ionic/ionic_ibdev.c    |    5 +
 drivers/infiniband/hw/ionic/ionic_ibdev.h    |   14 +
 drivers/infiniband/hw/ionic/ionic_pgtbl.c    |   11 +
 5 files changed, 1534 insertions(+)
 create mode 100644 drivers/infiniband/hw/ionic/ionic_datapath.c

diff --git a/drivers/infiniband/hw/ionic/ionic_datapath.c b/drivers/infiniband/hw/ionic/ionic_datapath.c
new file mode 100644
index 000000000000..aa2944887f23
--- /dev/null
+++ b/drivers/infiniband/hw/ionic/ionic_datapath.c
@@ -0,0 +1,1399 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
+
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <rdma/ib_addr.h>
+#include <rdma/ib_user_verbs.h>
+
+#include "ionic_fw.h"
+#include "ionic_ibdev.h"
+
+#define IONIC_OP(version, opname) \
+	((version) < 2 ? IONIC_V1_OP_##opname : IONIC_V2_OP_##opname)
+
+static bool ionic_next_cqe(struct ionic_ibdev *dev, struct ionic_cq *cq,
+			   struct ionic_v1_cqe **cqe)
+{
+	struct ionic_v1_cqe *qcqe = ionic_queue_at_prod(&cq->q);
+
+	if (unlikely(cq->color != ionic_v1_cqe_color(qcqe)))
+		return false;
+
+	/* Prevent out-of-order reads of the CQE */
+	dma_rmb();
+
+	*cqe = qcqe;
+
+	return true;
+}
+
+static int ionic_flush_recv(struct ionic_qp *qp, struct ib_wc *wc)
+{
+	struct ionic_rq_meta *meta;
+	struct ionic_v1_wqe *wqe;
+
+	if (!qp->rq_flush)
+		return 0;
+
+	if (ionic_queue_empty(&qp->rq))
+		return 0;
+
+	wqe = ionic_queue_at_cons(&qp->rq);
+
+	/* wqe_id must be a valid queue index */
+	if (unlikely(wqe->base.wqe_id >> qp->rq.depth_log2)) {
+		ibdev_warn(qp->ibqp.device,
+			   "flush qp %u recv index %llu invalid\n",
+			   qp->qpid, (unsigned long long)wqe->base.wqe_id);
+		return -EIO;
+	}
+
+	/* wqe_id must indicate a request that is outstanding */
+	meta = &qp->rq_meta[wqe->base.wqe_id];
+	if (unlikely(meta->next != IONIC_META_POSTED)) {
+		ibdev_warn(qp->ibqp.device,
+			   "flush qp %u recv index %llu not posted\n",
+			   qp->qpid, (unsigned long long)wqe->base.wqe_id);
+		return -EIO;
+	}
+
+	ionic_queue_consume(&qp->rq);
+
+	memset(wc, 0, sizeof(*wc));
+
+	wc->status = IB_WC_WR_FLUSH_ERR;
+	wc->wr_id = meta->wrid;
+	wc->qp = &qp->ibqp;
+
+	meta->next = qp->rq_meta_head;
+	qp->rq_meta_head = meta;
+
+	return 1;
+}
+
+static int ionic_flush_recv_many(struct ionic_qp *qp,
+				 struct ib_wc *wc, int nwc)
+{
+	int rc = 0, npolled = 0;
+
+	while (npolled < nwc) {
+		rc = ionic_flush_recv(qp, wc + npolled);
+		if (rc <= 0)
+			break;
+
+		npolled += rc;
+	}
+
+	return npolled ?: rc;
+}
+
+static int ionic_flush_send(struct ionic_qp *qp, struct ib_wc *wc)
+{
+	struct ionic_sq_meta *meta;
+
+	if (!qp->sq_flush)
+		return 0;
+
+	if (ionic_queue_empty(&qp->sq))
+		return 0;
+
+	meta = &qp->sq_meta[qp->sq.cons];
+
+	ionic_queue_consume(&qp->sq);
+
+	memset(wc, 0, sizeof(*wc));
+
+	wc->status = IB_WC_WR_FLUSH_ERR;
+	wc->wr_id = meta->wrid;
+	wc->qp = &qp->ibqp;
+
+	return 1;
+}
+
+static int ionic_flush_send_many(struct ionic_qp *qp,
+				 struct ib_wc *wc, int nwc)
+{
+	int rc = 0, npolled = 0;
+
+	while (npolled < nwc) {
+		rc = ionic_flush_send(qp, wc + npolled);
+		if (rc <= 0)
+			break;
+
+		npolled += rc;
+	}
+
+	return npolled ?: rc;
+}
+
+static int ionic_poll_recv(struct ionic_ibdev *dev, struct ionic_cq *cq,
+			   struct ionic_qp *cqe_qp, struct ionic_v1_cqe *cqe,
+			   struct ib_wc *wc)
+{
+	struct ionic_qp *qp = NULL;
+	struct ionic_rq_meta *meta;
+	u32 src_qpn, st_len;
+	u16 vlan_tag;
+	u8 op;
+
+	if (cqe_qp->rq_flush)
+		return 0;
+
+	qp = cqe_qp;
+
+	st_len = be32_to_cpu(cqe->status_length);
+
+	/* ignore wqe_id in case of flush error */
+	if (ionic_v1_cqe_error(cqe) && st_len == IONIC_STS_WQE_FLUSHED_ERR) {
+		cqe_qp->rq_flush = true;
+		cq->flush = true;
+		list_move_tail(&qp->cq_flush_rq, &cq->flush_rq);
+
+		/* posted recvs (if any) flushed by ionic_flush_recv */
+		return 0;
+	}
+
+	/* there had better be something in the recv queue to complete */
+	if (ionic_queue_empty(&qp->rq)) {
+		ibdev_warn(&dev->ibdev, "qp %u is empty\n", qp->qpid);
+		return -EIO;
+	}
+
+	/* wqe_id must be a valid queue index */
+	if (unlikely(cqe->recv.wqe_id >> qp->rq.depth_log2)) {
+		ibdev_warn(&dev->ibdev,
+			   "qp %u recv index %llu invalid\n",
+			   qp->qpid, (unsigned long long)cqe->recv.wqe_id);
+		return -EIO;
+	}
+
+	/* wqe_id must indicate a request that is outstanding */
+	meta = &qp->rq_meta[cqe->recv.wqe_id];
+	if (unlikely(meta->next != IONIC_META_POSTED)) {
+		ibdev_warn(&dev->ibdev,
+			   "qp %u recv index %llu not posted\n",
+			   qp->qpid, (unsigned long long)cqe->recv.wqe_id);
+		return -EIO;
+	}
+
+	meta->next = qp->rq_meta_head;
+	qp->rq_meta_head = meta;
+
+	memset(wc, 0, sizeof(*wc));
+
+	wc->wr_id = meta->wrid;
+
+	wc->qp = &cqe_qp->ibqp;
+
+	if (ionic_v1_cqe_error(cqe)) {
+		wc->vendor_err = st_len;
+		wc->status = ionic_to_ib_status(st_len);
+
+		cqe_qp->rq_flush = true;
+		cq->flush = true;
+		list_move_tail(&qp->cq_flush_rq, &cq->flush_rq);
+
+		ibdev_warn(&dev->ibdev,
+			   "qp %d recv cqe with error\n", qp->qpid);
+		print_hex_dump(KERN_WARNING, "cqe ", DUMP_PREFIX_OFFSET, 16, 1,
+			       cqe, BIT(cq->q.stride_log2), true);
+		goto out;
+	}
+
+	wc->vendor_err = 0;
+	wc->status = IB_WC_SUCCESS;
+
+	src_qpn = be32_to_cpu(cqe->recv.src_qpn_op);
+	op = src_qpn >> IONIC_V1_CQE_RECV_OP_SHIFT;
+
+	src_qpn &= IONIC_V1_CQE_RECV_QPN_MASK;
+	op &= IONIC_V1_CQE_RECV_OP_MASK;
+
+	wc->opcode = IB_WC_RECV;
+	switch (op) {
+	case IONIC_V1_CQE_RECV_OP_RDMA_IMM:
+		wc->opcode = IB_WC_RECV_RDMA_WITH_IMM;
+		wc->wc_flags |= IB_WC_WITH_IMM;
+		wc->ex.imm_data = cqe->recv.imm_data_rkey; /* be32 in wc */
+		break;
+	case IONIC_V1_CQE_RECV_OP_SEND_IMM:
+		wc->wc_flags |= IB_WC_WITH_IMM;
+		wc->ex.imm_data = cqe->recv.imm_data_rkey; /* be32 in wc */
+		break;
+	case IONIC_V1_CQE_RECV_OP_SEND_INV:
+		wc->wc_flags |= IB_WC_WITH_INVALIDATE;
+		wc->ex.invalidate_rkey = be32_to_cpu(cqe->recv.imm_data_rkey);
+		break;
+	}
+
+	wc->byte_len = st_len;
+	wc->src_qp = src_qpn;
+
+	if (qp->ibqp.qp_type == IB_QPT_UD ||
+	    qp->ibqp.qp_type == IB_QPT_GSI) {
+		wc->wc_flags |= IB_WC_GRH | IB_WC_WITH_SMAC;
+		ether_addr_copy(wc->smac, cqe->recv.src_mac);
+
+		wc->wc_flags |= IB_WC_WITH_NETWORK_HDR_TYPE;
+		if (ionic_v1_cqe_recv_is_ipv4(cqe))
+			wc->network_hdr_type = RDMA_NETWORK_IPV4;
+		else
+			wc->network_hdr_type = RDMA_NETWORK_IPV6;
+
+		if (ionic_v1_cqe_recv_is_vlan(cqe))
+			wc->wc_flags |= IB_WC_WITH_VLAN;
+
+		/* vlan_tag in cqe will be valid from dpath even if no vlan */
+		vlan_tag = be16_to_cpu(cqe->recv.vlan_tag);
+		wc->vlan_id = vlan_tag & 0xfff; /* 802.1q VID */
+		wc->sl = vlan_tag >> VLAN_PRIO_SHIFT; /* 802.1q PCP */
+	}
+
+	wc->pkey_index = 0;
+	wc->port_num = 1;
+
+out:
+	ionic_queue_consume(&qp->rq);
+
+	return 1;
+}
+
+static bool ionic_peek_send(struct ionic_qp *qp)
+{
+	struct ionic_sq_meta *meta;
+
+	if (qp->sq_flush)
+		return false;
+
+	/* completed all send queue requests */
+	if (ionic_queue_empty(&qp->sq))
+		return false;
+
+	meta = &qp->sq_meta[qp->sq.cons];
+
+	/* waiting for remote completion */
+	if (meta->remote && meta->seq == qp->sq_msn_cons)
+		return false;
+
+	/* waiting for local completion */
+	if (!meta->remote && !meta->local_comp)
+		return false;
+
+	return true;
+}
+
+static int ionic_poll_send(struct ionic_ibdev *dev, struct ionic_cq *cq,
+			   struct ionic_qp *qp, struct ib_wc *wc)
+{
+	struct ionic_sq_meta *meta;
+
+	if (qp->sq_flush)
+		return 0;
+
+	do {
+		/* completed all send queue requests */
+		if (ionic_queue_empty(&qp->sq))
+			goto out_empty;
+
+		meta = &qp->sq_meta[qp->sq.cons];
+
+		/* waiting for remote completion */
+		if (meta->remote && meta->seq == qp->sq_msn_cons)
+			goto out_empty;
+
+		/* waiting for local completion */
+		if (!meta->remote && !meta->local_comp)
+			goto out_empty;
+
+		ionic_queue_consume(&qp->sq);
+
+		/* produce wc only if signaled or error status */
+	} while (!meta->signal && meta->ibsts == IB_WC_SUCCESS);
+
+	memset(wc, 0, sizeof(*wc));
+
+	wc->status = meta->ibsts;
+	wc->wr_id = meta->wrid;
+	wc->qp = &qp->ibqp;
+
+	if (meta->ibsts == IB_WC_SUCCESS) {
+		wc->byte_len = meta->len;
+		wc->opcode = meta->ibop;
+	} else {
+		wc->vendor_err = meta->len;
+
+		qp->sq_flush = true;
+		cq->flush = true;
+		list_move_tail(&qp->cq_flush_sq, &cq->flush_sq);
+	}
+
+	return 1;
+
+out_empty:
+	if (qp->sq_flush_rcvd) {
+		qp->sq_flush = true;
+		cq->flush = true;
+		list_move_tail(&qp->cq_flush_sq, &cq->flush_sq);
+	}
+	return 0;
+}
+
+static int ionic_poll_send_many(struct ionic_ibdev *dev, struct ionic_cq *cq,
+				struct ionic_qp *qp, struct ib_wc *wc, int nwc)
+{
+	int rc = 0, npolled = 0;
+
+	while (npolled < nwc) {
+		rc = ionic_poll_send(dev, cq, qp, wc + npolled);
+		if (rc <= 0)
+			break;
+
+		npolled += rc;
+	}
+
+	return npolled ?: rc;
+}
+
+static int ionic_validate_cons(u16 prod, u16 cons,
+			       u16 comp, u16 mask)
+{
+	if (((prod - cons) & mask) <= ((comp - cons) & mask))
+		return -EIO;
+
+	return 0;
+}
+
+static int ionic_comp_msn(struct ionic_qp *qp, struct ionic_v1_cqe *cqe)
+{
+	struct ionic_sq_meta *meta;
+	u16 cqe_seq, cqe_idx;
+	int rc;
+
+	if (qp->sq_flush)
+		return 0;
+
+	cqe_seq = be32_to_cpu(cqe->send.msg_msn) & qp->sq.mask;
+
+	rc = ionic_validate_cons(qp->sq_msn_prod,
+				 qp->sq_msn_cons,
+				 cqe_seq - 1,
+				 qp->sq.mask);
+	if (rc) {
+		ibdev_warn(qp->ibqp.device,
+			   "qp %u bad msn %#x seq %u for prod %u cons %u\n",
+			   qp->qpid, be32_to_cpu(cqe->send.msg_msn),
+			   cqe_seq, qp->sq_msn_prod, qp->sq_msn_cons);
+		return rc;
+	}
+
+	qp->sq_msn_cons = cqe_seq;
+
+	if (ionic_v1_cqe_error(cqe)) {
+		cqe_idx = qp->sq_msn_idx[(cqe_seq - 1) & qp->sq.mask];
+
+		meta = &qp->sq_meta[cqe_idx];
+		meta->len = be32_to_cpu(cqe->status_length);
+		meta->ibsts = ionic_to_ib_status(meta->len);
+
+		ibdev_warn(qp->ibqp.device,
+			   "qp %d msn cqe with error\n", qp->qpid);
+		print_hex_dump(KERN_WARNING, "cqe ", DUMP_PREFIX_OFFSET, 16, 1,
+			       cqe, sizeof(*cqe), true);
+	}
+
+	return 0;
+}
+
+static int ionic_comp_npg(struct ionic_qp *qp, struct ionic_v1_cqe *cqe)
+{
+	struct ionic_sq_meta *meta;
+	u16 cqe_idx;
+	u32 st_len;
+
+	if (qp->sq_flush)
+		return 0;
+
+	st_len = be32_to_cpu(cqe->status_length);
+
+	if (ionic_v1_cqe_error(cqe) && st_len == IONIC_STS_WQE_FLUSHED_ERR) {
+		/*
+		 * Flush cqe does not consume a wqe on the device, and maybe
+		 * no such work request is posted.
+		 *
+		 * The driver should begin flushing after the last indicated
+		 * normal or error completion.	Here, only set a hint that the
+		 * flush request was indicated.	 In poll_send, if nothing more
+		 * can be polled normally, then begin flushing.
+		 */
+		qp->sq_flush_rcvd = true;
+		return 0;
+	}
+
+	cqe_idx = cqe->send.npg_wqe_id & qp->sq.mask;
+	meta = &qp->sq_meta[cqe_idx];
+	meta->local_comp = true;
+
+	if (ionic_v1_cqe_error(cqe)) {
+		meta->len = st_len;
+		meta->ibsts = ionic_to_ib_status(st_len);
+		meta->remote = false;
+		ibdev_warn(qp->ibqp.device,
+			   "qp %d npg cqe with error\n", qp->qpid);
+		print_hex_dump(KERN_WARNING, "cqe ", DUMP_PREFIX_OFFSET, 16, 1,
+			       cqe, sizeof(*cqe), true);
+	}
+
+	return 0;
+}
+
+static void ionic_reserve_sync_cq(struct ionic_ibdev *dev, struct ionic_cq *cq)
+{
+	if (!ionic_queue_empty(&cq->q)) {
+		cq->credit += ionic_queue_length(&cq->q);
+		cq->q.cons = cq->q.prod;
+
+		ionic_dbell_ring(dev->lif_cfg.dbpage, dev->lif_cfg.cq_qtype,
+				 ionic_queue_dbell_val(&cq->q));
+	}
+}
+
+static void ionic_reserve_cq(struct ionic_ibdev *dev, struct ionic_cq *cq,
+			     int spend)
+{
+	cq->credit -= spend;
+
+	if (cq->credit <= 0)
+		ionic_reserve_sync_cq(dev, cq);
+}
+
+static int ionic_poll_vcq_cq(struct ionic_ibdev *dev,
+			     struct ionic_cq *cq,
+			     int nwc, struct ib_wc *wc)
+{
+	struct ionic_qp *qp, *qp_next;
+	struct ionic_v1_cqe *cqe;
+	int rc = 0, npolled = 0;
+	unsigned long irqflags;
+	u32 qtf, qid;
+	bool peek;
+	u8 type;
+
+	if (nwc < 1)
+		return 0;
+
+	spin_lock_irqsave(&cq->lock, irqflags);
+
+	/* poll already indicated work completions for send queue */
+	list_for_each_entry_safe(qp, qp_next, &cq->poll_sq, cq_poll_sq) {
+		if (npolled == nwc)
+			goto out;
+
+		spin_lock(&qp->sq_lock);
+		rc = ionic_poll_send_many(dev, cq, qp, wc + npolled,
+					  nwc - npolled);
+		spin_unlock(&qp->sq_lock);
+
+		if (rc > 0)
+			npolled += rc;
+
+		if (npolled < nwc)
+			list_del_init(&qp->cq_poll_sq);
+	}
+
+	/* poll for more work completions */
+	while (likely(ionic_next_cqe(dev, cq, &cqe))) {
+		if (npolled == nwc)
+			goto out;
+
+		qtf = ionic_v1_cqe_qtf(cqe);
+		qid = ionic_v1_cqe_qtf_qid(qtf);
+		type = ionic_v1_cqe_qtf_type(qtf);
+
+		/*
+		 * Safe to access QP without additional reference here as,
+		 * 1. We hold cq->lock throughout
+		 * 2. ionic_destroy_qp() acquires the same cq->lock before cleanup
+		 * 3. QP is removed from qp_tbl before any cleanup begins
+		 * This ensures no concurrent access between polling and destruction.
+		 */
+		qp = xa_load(&dev->qp_tbl, qid);
+		if (unlikely(!qp)) {
+			ibdev_dbg(&dev->ibdev, "missing qp for qid %u\n", qid);
+			goto cq_next;
+		}
+
+		switch (type) {
+		case IONIC_V1_CQE_TYPE_RECV:
+			spin_lock(&qp->rq_lock);
+			rc = ionic_poll_recv(dev, cq, qp, cqe, wc + npolled);
+			spin_unlock(&qp->rq_lock);
+
+			if (rc < 0)
+				goto out;
+
+			npolled += rc;
+
+			break;
+
+		case IONIC_V1_CQE_TYPE_SEND_MSN:
+			spin_lock(&qp->sq_lock);
+			rc = ionic_comp_msn(qp, cqe);
+			if (!rc) {
+				rc = ionic_poll_send_many(dev, cq, qp,
+							  wc + npolled,
+							  nwc - npolled);
+				peek = ionic_peek_send(qp);
+			}
+			spin_unlock(&qp->sq_lock);
+
+			if (rc < 0)
+				goto out;
+
+			npolled += rc;
+
+			if (peek)
+				list_move_tail(&qp->cq_poll_sq, &cq->poll_sq);
+			break;
+
+		case IONIC_V1_CQE_TYPE_SEND_NPG:
+			spin_lock(&qp->sq_lock);
+			rc = ionic_comp_npg(qp, cqe);
+			if (!rc) {
+				rc = ionic_poll_send_many(dev, cq, qp,
+							  wc + npolled,
+							  nwc - npolled);
+				peek = ionic_peek_send(qp);
+			}
+			spin_unlock(&qp->sq_lock);
+
+			if (rc < 0)
+				goto out;
+
+			npolled += rc;
+
+			if (peek)
+				list_move_tail(&qp->cq_poll_sq, &cq->poll_sq);
+			break;
+
+		default:
+			ibdev_warn(&dev->ibdev,
+				   "unexpected cqe type %u\n", type);
+			rc = -EIO;
+			goto out;
+		}
+
+cq_next:
+		ionic_queue_produce(&cq->q);
+		cq->color = ionic_color_wrap(cq->q.prod, cq->color);
+	}
+
+	/* lastly, flush send and recv queues */
+	if (likely(!cq->flush))
+		goto out;
+
+	cq->flush = false;
+
+	list_for_each_entry_safe(qp, qp_next, &cq->flush_sq, cq_flush_sq) {
+		if (npolled == nwc)
+			goto out;
+
+		spin_lock(&qp->sq_lock);
+		rc = ionic_flush_send_many(qp, wc + npolled, nwc - npolled);
+		spin_unlock(&qp->sq_lock);
+
+		if (rc > 0)
+			npolled += rc;
+
+		if (npolled < nwc)
+			list_del_init(&qp->cq_flush_sq);
+		else
+			cq->flush = true;
+	}
+
+	list_for_each_entry_safe(qp, qp_next, &cq->flush_rq, cq_flush_rq) {
+		if (npolled == nwc)
+			goto out;
+
+		spin_lock(&qp->rq_lock);
+		rc = ionic_flush_recv_many(qp, wc + npolled, nwc - npolled);
+		spin_unlock(&qp->rq_lock);
+
+		if (rc > 0)
+			npolled += rc;
+
+		if (npolled < nwc)
+			list_del_init(&qp->cq_flush_rq);
+		else
+			cq->flush = true;
+	}
+
+out:
+	/* in case credit was depleted (more work posted than cq depth) */
+	if (cq->credit <= 0)
+		ionic_reserve_sync_cq(dev, cq);
+
+	spin_unlock_irqrestore(&cq->lock, irqflags);
+
+	return npolled ?: rc;
+}
+
+int ionic_poll_cq(struct ib_cq *ibcq, int nwc, struct ib_wc *wc)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibcq->device);
+	struct ionic_vcq *vcq = to_ionic_vcq(ibcq);
+	int rc_tmp, rc = 0, npolled = 0;
+	int cq_i, cq_x, cq_ix;
+
+	cq_x = vcq->poll_idx;
+	vcq->poll_idx ^= dev->lif_cfg.udma_count - 1;
+
+	for (cq_i = 0; npolled < nwc && cq_i < dev->lif_cfg.udma_count; ++cq_i) {
+		cq_ix = cq_i ^ cq_x;
+
+		if (!(vcq->udma_mask & BIT(cq_ix)))
+			continue;
+
+		rc_tmp = ionic_poll_vcq_cq(dev, &vcq->cq[cq_ix],
+					   nwc - npolled,
+					   wc + npolled);
+
+		if (rc_tmp >= 0)
+			npolled += rc_tmp;
+		else if (!rc)
+			rc = rc_tmp;
+	}
+
+	return npolled ?: rc;
+}
+
+static int ionic_req_notify_vcq_cq(struct ionic_ibdev *dev, struct ionic_cq *cq,
+				   enum ib_cq_notify_flags flags)
+{
+	u64 dbell_val = cq->q.dbell;
+
+	if (flags & IB_CQ_SOLICITED) {
+		cq->arm_sol_prod = ionic_queue_next(&cq->q, cq->arm_sol_prod);
+		dbell_val |= cq->arm_sol_prod | IONIC_CQ_RING_SOL;
+	} else {
+		cq->arm_any_prod = ionic_queue_next(&cq->q, cq->arm_any_prod);
+		dbell_val |= cq->arm_any_prod | IONIC_CQ_RING_ARM;
+	}
+
+	ionic_reserve_sync_cq(dev, cq);
+
+	ionic_dbell_ring(dev->lif_cfg.dbpage, dev->lif_cfg.cq_qtype, dbell_val);
+
+	/*
+	 * IB_CQ_REPORT_MISSED_EVENTS:
+	 *
+	 * The queue index in ring zero guarantees no missed events.
+	 *
+	 * Here, we check if the color bit in the next cqe is flipped.	If it
+	 * is flipped, then progress can be made by immediately polling the cq.
+	 * Still, the cq will be armed, and an event will be generated.	 The cq
+	 * may be empty when polled after the event, because the next poll
+	 * after arming the cq can empty it.
+	 */
+	return (flags & IB_CQ_REPORT_MISSED_EVENTS) &&
+		cq->color == ionic_v1_cqe_color(ionic_queue_at_prod(&cq->q));
+}
+
+int ionic_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibcq->device);
+	struct ionic_vcq *vcq = to_ionic_vcq(ibcq);
+	int rc = 0, cq_i;
+
+	for (cq_i = 0; cq_i < dev->lif_cfg.udma_count; ++cq_i) {
+		if (!(vcq->udma_mask & BIT(cq_i)))
+			continue;
+
+		if (ionic_req_notify_vcq_cq(dev, &vcq->cq[cq_i], flags))
+			rc = 1;
+	}
+
+	return rc;
+}
+
+static s64 ionic_prep_inline(void *data, u32 max_data,
+			     const struct ib_sge *ib_sgl, int num_sge)
+{
+	static const s64 bit_31 = 1u << 31;
+	s64 len = 0, sg_len;
+	int sg_i;
+
+	for (sg_i = 0; sg_i < num_sge; ++sg_i) {
+		sg_len = ib_sgl[sg_i].length;
+
+		/* sge length zero means 2GB */
+		if (unlikely(sg_len == 0))
+			sg_len = bit_31;
+
+		/* greater than max inline data is invalid */
+		if (unlikely(len + sg_len > max_data))
+			return -EINVAL;
+
+		memcpy(data + len, (void *)ib_sgl[sg_i].addr, sg_len);
+
+		len += sg_len;
+	}
+
+	return len;
+}
+
+static s64 ionic_prep_pld(struct ionic_v1_wqe *wqe,
+			  union ionic_v1_pld *pld,
+			  int spec, u32 max_sge,
+			  const struct ib_sge *ib_sgl,
+			  int num_sge)
+{
+	static const s64 bit_31 = 1l << 31;
+	struct ionic_sge *sgl;
+	__be32 *spec32 = NULL;
+	__be16 *spec16 = NULL;
+	s64 len = 0, sg_len;
+	int sg_i = 0;
+
+	if (unlikely(num_sge < 0 || (u32)num_sge > max_sge))
+		return -EINVAL;
+
+	if (spec && num_sge > IONIC_V1_SPEC_FIRST_SGE) {
+		sg_i = IONIC_V1_SPEC_FIRST_SGE;
+
+		if (num_sge > 8) {
+			wqe->base.flags |= cpu_to_be16(IONIC_V1_FLAG_SPEC16);
+			spec16 = pld->spec16;
+		} else {
+			wqe->base.flags |= cpu_to_be16(IONIC_V1_FLAG_SPEC32);
+			spec32 = pld->spec32;
+		}
+	}
+
+	sgl = &pld->sgl[sg_i];
+
+	for (sg_i = 0; sg_i < num_sge; ++sg_i) {
+		sg_len = ib_sgl[sg_i].length;
+
+		/* sge length zero means 2GB */
+		if (unlikely(sg_len == 0))
+			sg_len = bit_31;
+
+		/* greater than 2GB data is invalid */
+		if (unlikely(len + sg_len > bit_31))
+			return -EINVAL;
+
+		sgl[sg_i].va = cpu_to_be64(ib_sgl[sg_i].addr);
+		sgl[sg_i].len = cpu_to_be32(sg_len);
+		sgl[sg_i].lkey = cpu_to_be32(ib_sgl[sg_i].lkey);
+
+		if (spec32) {
+			spec32[sg_i] = sgl[sg_i].len;
+		} else if (spec16) {
+			if (unlikely(sg_len > U16_MAX))
+				return -EINVAL;
+			spec16[sg_i] = cpu_to_be16(sg_len);
+		}
+
+		len += sg_len;
+	}
+
+	return len;
+}
+
+static void ionic_prep_base(struct ionic_qp *qp,
+			    const struct ib_send_wr *wr,
+			    struct ionic_sq_meta *meta,
+			    struct ionic_v1_wqe *wqe)
+{
+	meta->wrid = wr->wr_id;
+	meta->ibsts = IB_WC_SUCCESS;
+	meta->signal = false;
+	meta->local_comp = false;
+
+	wqe->base.wqe_id = qp->sq.prod;
+
+	if (wr->send_flags & IB_SEND_FENCE)
+		wqe->base.flags |= cpu_to_be16(IONIC_V1_FLAG_FENCE);
+
+	if (wr->send_flags & IB_SEND_SOLICITED)
+		wqe->base.flags |= cpu_to_be16(IONIC_V1_FLAG_SOL);
+
+	if (qp->sig_all || wr->send_flags & IB_SEND_SIGNALED) {
+		wqe->base.flags |= cpu_to_be16(IONIC_V1_FLAG_SIG);
+		meta->signal = true;
+	}
+
+	meta->seq = qp->sq_msn_prod;
+	meta->remote =
+		qp->ibqp.qp_type != IB_QPT_UD &&
+		qp->ibqp.qp_type != IB_QPT_GSI &&
+		!ionic_ibop_is_local(wr->opcode);
+
+	if (meta->remote) {
+		qp->sq_msn_idx[meta->seq] = qp->sq.prod;
+		qp->sq_msn_prod = ionic_queue_next(&qp->sq, qp->sq_msn_prod);
+	}
+
+	ionic_queue_produce(&qp->sq);
+}
+
+static int ionic_prep_common(struct ionic_qp *qp,
+			     const struct ib_send_wr *wr,
+			     struct ionic_sq_meta *meta,
+			     struct ionic_v1_wqe *wqe)
+{
+	s64 signed_len;
+	u32 mval;
+
+	if (wr->send_flags & IB_SEND_INLINE) {
+		wqe->base.num_sge_key = 0;
+		wqe->base.flags |= cpu_to_be16(IONIC_V1_FLAG_INL);
+		mval = ionic_v1_send_wqe_max_data(qp->sq.stride_log2, false);
+		signed_len = ionic_prep_inline(wqe->common.pld.data, mval,
+					       wr->sg_list, wr->num_sge);
+	} else {
+		wqe->base.num_sge_key = wr->num_sge;
+		mval = ionic_v1_send_wqe_max_sge(qp->sq.stride_log2,
+						 qp->sq_spec,
+						 false);
+		signed_len = ionic_prep_pld(wqe, &wqe->common.pld,
+					    qp->sq_spec, mval,
+					    wr->sg_list, wr->num_sge);
+	}
+
+	if (unlikely(signed_len < 0))
+		return signed_len;
+
+	meta->len = signed_len;
+	wqe->common.length = cpu_to_be32(signed_len);
+
+	ionic_prep_base(qp, wr, meta, wqe);
+
+	return 0;
+}
+
+static void ionic_prep_sq_wqe(struct ionic_qp *qp, void *wqe)
+{
+	memset(wqe, 0, 1u << qp->sq.stride_log2);
+}
+
+static void ionic_prep_rq_wqe(struct ionic_qp *qp, void *wqe)
+{
+	memset(wqe, 0, 1u << qp->rq.stride_log2);
+}
+
+static int ionic_prep_send(struct ionic_qp *qp,
+			   const struct ib_send_wr *wr)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(qp->ibqp.device);
+	struct ionic_sq_meta *meta;
+	struct ionic_v1_wqe *wqe;
+
+	meta = &qp->sq_meta[qp->sq.prod];
+	wqe = ionic_queue_at_prod(&qp->sq);
+
+	ionic_prep_sq_wqe(qp, wqe);
+
+	meta->ibop = IB_WC_SEND;
+
+	switch (wr->opcode) {
+	case IB_WR_SEND:
+		wqe->base.op = IONIC_OP(dev->lif_cfg.rdma_version, SEND);
+		break;
+	case IB_WR_SEND_WITH_IMM:
+		wqe->base.op = IONIC_OP(dev->lif_cfg.rdma_version, SEND_IMM);
+		wqe->base.imm_data_key = wr->ex.imm_data;
+		break;
+	case IB_WR_SEND_WITH_INV:
+		wqe->base.op = IONIC_OP(dev->lif_cfg.rdma_version, SEND_INV);
+		wqe->base.imm_data_key =
+			cpu_to_be32(wr->ex.invalidate_rkey);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ionic_prep_common(qp, wr, meta, wqe);
+}
+
+static int ionic_prep_send_ud(struct ionic_qp *qp,
+			      const struct ib_ud_wr *wr)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(qp->ibqp.device);
+	struct ionic_sq_meta *meta;
+	struct ionic_v1_wqe *wqe;
+	struct ionic_ah *ah;
+
+	if (unlikely(!wr->ah))
+		return -EINVAL;
+
+	ah = to_ionic_ah(wr->ah);
+
+	meta = &qp->sq_meta[qp->sq.prod];
+	wqe = ionic_queue_at_prod(&qp->sq);
+
+	ionic_prep_sq_wqe(qp, wqe);
+
+	wqe->common.send.ah_id = cpu_to_be32(ah->ahid);
+	wqe->common.send.dest_qpn = cpu_to_be32(wr->remote_qpn);
+	wqe->common.send.dest_qkey = cpu_to_be32(wr->remote_qkey);
+
+	meta->ibop = IB_WC_SEND;
+
+	switch (wr->wr.opcode) {
+	case IB_WR_SEND:
+		wqe->base.op = IONIC_OP(dev->lif_cfg.rdma_version, SEND);
+		break;
+	case IB_WR_SEND_WITH_IMM:
+		wqe->base.op = IONIC_OP(dev->lif_cfg.rdma_version, SEND_IMM);
+		wqe->base.imm_data_key = wr->wr.ex.imm_data;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ionic_prep_common(qp, &wr->wr, meta, wqe);
+}
+
+static int ionic_prep_rdma(struct ionic_qp *qp,
+			   const struct ib_rdma_wr *wr)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(qp->ibqp.device);
+	struct ionic_sq_meta *meta;
+	struct ionic_v1_wqe *wqe;
+
+	meta = &qp->sq_meta[qp->sq.prod];
+	wqe = ionic_queue_at_prod(&qp->sq);
+
+	ionic_prep_sq_wqe(qp, wqe);
+
+	meta->ibop = IB_WC_RDMA_WRITE;
+
+	switch (wr->wr.opcode) {
+	case IB_WR_RDMA_READ:
+		if (wr->wr.send_flags & (IB_SEND_SOLICITED | IB_SEND_INLINE))
+			return -EINVAL;
+		meta->ibop = IB_WC_RDMA_READ;
+		wqe->base.op = IONIC_OP(dev->lif_cfg.rdma_version, RDMA_READ);
+		break;
+	case IB_WR_RDMA_WRITE:
+		if (wr->wr.send_flags & IB_SEND_SOLICITED)
+			return -EINVAL;
+		wqe->base.op = IONIC_OP(dev->lif_cfg.rdma_version, RDMA_WRITE);
+		break;
+	case IB_WR_RDMA_WRITE_WITH_IMM:
+		wqe->base.op = IONIC_OP(dev->lif_cfg.rdma_version, RDMA_WRITE_IMM);
+		wqe->base.imm_data_key = wr->wr.ex.imm_data;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	wqe->common.rdma.remote_va_high = cpu_to_be32(wr->remote_addr >> 32);
+	wqe->common.rdma.remote_va_low = cpu_to_be32(wr->remote_addr);
+	wqe->common.rdma.remote_rkey = cpu_to_be32(wr->rkey);
+
+	return ionic_prep_common(qp, &wr->wr, meta, wqe);
+}
+
+static int ionic_prep_atomic(struct ionic_qp *qp,
+			     const struct ib_atomic_wr *wr)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(qp->ibqp.device);
+	struct ionic_sq_meta *meta;
+	struct ionic_v1_wqe *wqe;
+
+	if (wr->wr.num_sge != 1 || wr->wr.sg_list[0].length != 8)
+		return -EINVAL;
+
+	if (wr->wr.send_flags & (IB_SEND_SOLICITED | IB_SEND_INLINE))
+		return -EINVAL;
+
+	meta = &qp->sq_meta[qp->sq.prod];
+	wqe = ionic_queue_at_prod(&qp->sq);
+
+	ionic_prep_sq_wqe(qp, wqe);
+
+	meta->ibop = IB_WC_RDMA_WRITE;
+
+	switch (wr->wr.opcode) {
+	case IB_WR_ATOMIC_CMP_AND_SWP:
+		meta->ibop = IB_WC_COMP_SWAP;
+		wqe->base.op = IONIC_OP(dev->lif_cfg.rdma_version, ATOMIC_CS);
+		wqe->atomic.swap_add_high = cpu_to_be32(wr->swap >> 32);
+		wqe->atomic.swap_add_low = cpu_to_be32(wr->swap);
+		wqe->atomic.compare_high = cpu_to_be32(wr->compare_add >> 32);
+		wqe->atomic.compare_low = cpu_to_be32(wr->compare_add);
+		break;
+	case IB_WR_ATOMIC_FETCH_AND_ADD:
+		meta->ibop = IB_WC_FETCH_ADD;
+		wqe->base.op = IONIC_OP(dev->lif_cfg.rdma_version, ATOMIC_FA);
+		wqe->atomic.swap_add_high = cpu_to_be32(wr->compare_add >> 32);
+		wqe->atomic.swap_add_low = cpu_to_be32(wr->compare_add);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	wqe->atomic.remote_va_high = cpu_to_be32(wr->remote_addr >> 32);
+	wqe->atomic.remote_va_low = cpu_to_be32(wr->remote_addr);
+	wqe->atomic.remote_rkey = cpu_to_be32(wr->rkey);
+
+	wqe->base.num_sge_key = 1;
+	wqe->atomic.sge.va = cpu_to_be64(wr->wr.sg_list[0].addr);
+	wqe->atomic.sge.len = cpu_to_be32(8);
+	wqe->atomic.sge.lkey = cpu_to_be32(wr->wr.sg_list[0].lkey);
+
+	return ionic_prep_common(qp, &wr->wr, meta, wqe);
+}
+
+static int ionic_prep_inv(struct ionic_qp *qp,
+			  const struct ib_send_wr *wr)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(qp->ibqp.device);
+	struct ionic_sq_meta *meta;
+	struct ionic_v1_wqe *wqe;
+
+	if (wr->send_flags & (IB_SEND_SOLICITED | IB_SEND_INLINE))
+		return -EINVAL;
+
+	meta = &qp->sq_meta[qp->sq.prod];
+	wqe = ionic_queue_at_prod(&qp->sq);
+
+	ionic_prep_sq_wqe(qp, wqe);
+
+	wqe->base.op = IONIC_OP(dev->lif_cfg.rdma_version, LOCAL_INV);
+	wqe->base.imm_data_key = cpu_to_be32(wr->ex.invalidate_rkey);
+
+	meta->len = 0;
+	meta->ibop = IB_WC_LOCAL_INV;
+
+	ionic_prep_base(qp, wr, meta, wqe);
+
+	return 0;
+}
+
+static int ionic_prep_reg(struct ionic_qp *qp,
+			  const struct ib_reg_wr *wr)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(qp->ibqp.device);
+	struct ionic_mr *mr = to_ionic_mr(wr->mr);
+	struct ionic_sq_meta *meta;
+	struct ionic_v1_wqe *wqe;
+	__le64 dma_addr;
+	int flags;
+
+	if (wr->wr.send_flags & (IB_SEND_SOLICITED | IB_SEND_INLINE))
+		return -EINVAL;
+
+	/* must call ib_map_mr_sg before posting reg wr */
+	if (!mr->buf.tbl_pages)
+		return -EINVAL;
+
+	meta = &qp->sq_meta[qp->sq.prod];
+	wqe = ionic_queue_at_prod(&qp->sq);
+
+	ionic_prep_sq_wqe(qp, wqe);
+
+	flags = to_ionic_mr_flags(wr->access);
+
+	wqe->base.op = IONIC_OP(dev->lif_cfg.rdma_version, REG_MR);
+	wqe->base.num_sge_key = wr->key;
+	wqe->base.imm_data_key = cpu_to_be32(mr->ibmr.lkey);
+	wqe->reg_mr.va = cpu_to_be64(mr->ibmr.iova);
+	wqe->reg_mr.length = cpu_to_be64(mr->ibmr.length);
+	wqe->reg_mr.offset = ionic_pgtbl_off(&mr->buf, mr->ibmr.iova);
+	dma_addr = ionic_pgtbl_dma(&mr->buf, mr->ibmr.iova);
+	wqe->reg_mr.dma_addr = cpu_to_be64(le64_to_cpu(dma_addr));
+
+	wqe->reg_mr.map_count = cpu_to_be32(mr->buf.tbl_pages);
+	wqe->reg_mr.flags = cpu_to_be16(flags);
+	wqe->reg_mr.dir_size_log2 = 0;
+	wqe->reg_mr.page_size_log2 = order_base_2(mr->ibmr.page_size);
+
+	meta->len = 0;
+	meta->ibop = IB_WC_REG_MR;
+
+	ionic_prep_base(qp, &wr->wr, meta, wqe);
+
+	return 0;
+}
+
+static int ionic_prep_one_rc(struct ionic_qp *qp,
+			     const struct ib_send_wr *wr)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(qp->ibqp.device);
+	int rc = 0;
+
+	switch (wr->opcode) {
+	case IB_WR_SEND:
+	case IB_WR_SEND_WITH_IMM:
+	case IB_WR_SEND_WITH_INV:
+		rc = ionic_prep_send(qp, wr);
+		break;
+	case IB_WR_RDMA_READ:
+	case IB_WR_RDMA_WRITE:
+	case IB_WR_RDMA_WRITE_WITH_IMM:
+		rc = ionic_prep_rdma(qp, rdma_wr(wr));
+		break;
+	case IB_WR_ATOMIC_CMP_AND_SWP:
+	case IB_WR_ATOMIC_FETCH_AND_ADD:
+		rc = ionic_prep_atomic(qp, atomic_wr(wr));
+		break;
+	case IB_WR_LOCAL_INV:
+		rc = ionic_prep_inv(qp, wr);
+		break;
+	case IB_WR_REG_MR:
+		rc = ionic_prep_reg(qp, reg_wr(wr));
+		break;
+	default:
+		ibdev_dbg(&dev->ibdev, "invalid opcode %d\n", wr->opcode);
+		rc = -EINVAL;
+	}
+
+	return rc;
+}
+
+static int ionic_prep_one_ud(struct ionic_qp *qp,
+			     const struct ib_send_wr *wr)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(qp->ibqp.device);
+	int rc = 0;
+
+	switch (wr->opcode) {
+	case IB_WR_SEND:
+	case IB_WR_SEND_WITH_IMM:
+		rc = ionic_prep_send_ud(qp, ud_wr(wr));
+		break;
+	default:
+		ibdev_dbg(&dev->ibdev, "invalid opcode %d\n", wr->opcode);
+		rc = -EINVAL;
+	}
+
+	return rc;
+}
+
+static int ionic_prep_recv(struct ionic_qp *qp,
+			   const struct ib_recv_wr *wr)
+{
+	struct ionic_rq_meta *meta;
+	struct ionic_v1_wqe *wqe;
+	s64 signed_len;
+	u32 mval;
+
+	wqe = ionic_queue_at_prod(&qp->rq);
+
+	/* if wqe is owned by device, caller can try posting again soon */
+	if (wqe->base.flags & cpu_to_be16(IONIC_V1_FLAG_FENCE))
+		return -EAGAIN;
+
+	meta = qp->rq_meta_head;
+	if (unlikely(meta == IONIC_META_LAST) ||
+	    unlikely(meta == IONIC_META_POSTED))
+		return -EIO;
+
+	ionic_prep_rq_wqe(qp, wqe);
+
+	mval = ionic_v1_recv_wqe_max_sge(qp->rq.stride_log2, qp->rq_spec,
+					 false);
+	signed_len = ionic_prep_pld(wqe, &wqe->recv.pld,
+				    qp->rq_spec, mval,
+				    wr->sg_list, wr->num_sge);
+	if (signed_len < 0)
+		return signed_len;
+
+	meta->wrid = wr->wr_id;
+
+	wqe->base.wqe_id = meta - qp->rq_meta;
+	wqe->base.num_sge_key = wr->num_sge;
+
+	/* total length for recv goes in base imm_data_key */
+	wqe->base.imm_data_key = cpu_to_be32(signed_len);
+
+	ionic_queue_produce(&qp->rq);
+
+	qp->rq_meta_head = meta->next;
+	meta->next = IONIC_META_POSTED;
+
+	return 0;
+}
+
+static int ionic_post_send_common(struct ionic_ibdev *dev,
+				  struct ionic_vcq *vcq,
+				  struct ionic_cq *cq,
+				  struct ionic_qp *qp,
+				  const struct ib_send_wr *wr,
+				  const struct ib_send_wr **bad)
+{
+	unsigned long irqflags;
+	bool notify = false;
+	int spend, rc = 0;
+
+	if (!bad)
+		return -EINVAL;
+
+	if (!qp->has_sq) {
+		*bad = wr;
+		return -EINVAL;
+	}
+
+	if (qp->state < IB_QPS_RTS) {
+		*bad = wr;
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&qp->sq_lock, irqflags);
+
+	while (wr) {
+		if (ionic_queue_full(&qp->sq)) {
+			ibdev_dbg(&dev->ibdev, "queue full");
+			rc = -ENOMEM;
+			goto out;
+		}
+
+		if (qp->ibqp.qp_type == IB_QPT_UD ||
+		    qp->ibqp.qp_type == IB_QPT_GSI)
+			rc = ionic_prep_one_ud(qp, wr);
+		else
+			rc = ionic_prep_one_rc(qp, wr);
+		if (rc)
+			goto out;
+
+		wr = wr->next;
+	}
+
+out:
+	spin_unlock_irqrestore(&qp->sq_lock, irqflags);
+
+	spin_lock_irqsave(&cq->lock, irqflags);
+	spin_lock(&qp->sq_lock);
+
+	if (likely(qp->sq.prod != qp->sq_old_prod)) {
+		/* ring cq doorbell just in time */
+		spend = (qp->sq.prod - qp->sq_old_prod) & qp->sq.mask;
+		ionic_reserve_cq(dev, cq, spend);
+
+		qp->sq_old_prod = qp->sq.prod;
+
+		ionic_dbell_ring(dev->lif_cfg.dbpage, dev->lif_cfg.sq_qtype,
+				 ionic_queue_dbell_val(&qp->sq));
+	}
+
+	if (qp->sq_flush) {
+		notify = true;
+		cq->flush = true;
+		list_move_tail(&qp->cq_flush_sq, &cq->flush_sq);
+	}
+
+	spin_unlock(&qp->sq_lock);
+	spin_unlock_irqrestore(&cq->lock, irqflags);
+
+	if (notify && vcq->ibcq.comp_handler)
+		vcq->ibcq.comp_handler(&vcq->ibcq, vcq->ibcq.cq_context);
+
+	*bad = wr;
+	return rc;
+}
+
+static int ionic_post_recv_common(struct ionic_ibdev *dev,
+				  struct ionic_vcq *vcq,
+				  struct ionic_cq *cq,
+				  struct ionic_qp *qp,
+				  const struct ib_recv_wr *wr,
+				  const struct ib_recv_wr **bad)
+{
+	unsigned long irqflags;
+	bool notify = false;
+	int spend, rc = 0;
+
+	if (!bad)
+		return -EINVAL;
+
+	if (!qp->has_rq) {
+		*bad = wr;
+		return -EINVAL;
+	}
+
+	if (qp->state < IB_QPS_INIT) {
+		*bad = wr;
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&qp->rq_lock, irqflags);
+
+	while (wr) {
+		if (ionic_queue_full(&qp->rq)) {
+			ibdev_dbg(&dev->ibdev, "queue full");
+			rc = -ENOMEM;
+			goto out;
+		}
+
+		rc = ionic_prep_recv(qp, wr);
+		if (rc)
+			goto out;
+
+		wr = wr->next;
+	}
+
+out:
+	if (!cq) {
+		spin_unlock_irqrestore(&qp->rq_lock, irqflags);
+		goto out_unlocked;
+	}
+	spin_unlock_irqrestore(&qp->rq_lock, irqflags);
+
+	spin_lock_irqsave(&cq->lock, irqflags);
+	spin_lock(&qp->rq_lock);
+
+	if (likely(qp->rq.prod != qp->rq_old_prod)) {
+		/* ring cq doorbell just in time */
+		spend = (qp->rq.prod - qp->rq_old_prod) & qp->rq.mask;
+		ionic_reserve_cq(dev, cq, spend);
+
+		qp->rq_old_prod = qp->rq.prod;
+
+		ionic_dbell_ring(dev->lif_cfg.dbpage, dev->lif_cfg.rq_qtype,
+				 ionic_queue_dbell_val(&qp->rq));
+	}
+
+	if (qp->rq_flush) {
+		notify = true;
+		cq->flush = true;
+		list_move_tail(&qp->cq_flush_rq, &cq->flush_rq);
+	}
+
+	spin_unlock(&qp->rq_lock);
+	spin_unlock_irqrestore(&cq->lock, irqflags);
+
+	if (notify && vcq->ibcq.comp_handler)
+		vcq->ibcq.comp_handler(&vcq->ibcq, vcq->ibcq.cq_context);
+
+out_unlocked:
+	*bad = wr;
+	return rc;
+}
+
+int ionic_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
+		    const struct ib_send_wr **bad)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibqp->device);
+	struct ionic_vcq *vcq = to_ionic_vcq(ibqp->send_cq);
+	struct ionic_qp *qp = to_ionic_qp(ibqp);
+	struct ionic_cq *cq =
+		to_ionic_vcq_cq(ibqp->send_cq, qp->udma_idx);
+
+	return ionic_post_send_common(dev, vcq, cq, qp, wr, bad);
+}
+
+int ionic_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
+		    const struct ib_recv_wr **bad)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibqp->device);
+	struct ionic_vcq *vcq = to_ionic_vcq(ibqp->recv_cq);
+	struct ionic_qp *qp = to_ionic_qp(ibqp);
+	struct ionic_cq *cq =
+		to_ionic_vcq_cq(ibqp->recv_cq, qp->udma_idx);
+
+	return ionic_post_recv_common(dev, vcq, cq, qp, wr, bad);
+}
diff --git a/drivers/infiniband/hw/ionic/ionic_fw.h b/drivers/infiniband/hw/ionic/ionic_fw.h
index 8c1c0a07c527..d48ee000f334 100644
--- a/drivers/infiniband/hw/ionic/ionic_fw.h
+++ b/drivers/infiniband/hw/ionic/ionic_fw.h
@@ -163,6 +163,61 @@ static inline int to_ionic_qp_flags(int access, bool sqd_notify,
 	return flags;
 }
 
+/* cqe non-admin status indicated in status_length field when err bit is set */
+enum ionic_status {
+	IONIC_STS_OK,
+	IONIC_STS_LOCAL_LEN_ERR,
+	IONIC_STS_LOCAL_QP_OPER_ERR,
+	IONIC_STS_LOCAL_PROT_ERR,
+	IONIC_STS_WQE_FLUSHED_ERR,
+	IONIC_STS_MEM_MGMT_OPER_ERR,
+	IONIC_STS_BAD_RESP_ERR,
+	IONIC_STS_LOCAL_ACC_ERR,
+	IONIC_STS_REMOTE_INV_REQ_ERR,
+	IONIC_STS_REMOTE_ACC_ERR,
+	IONIC_STS_REMOTE_OPER_ERR,
+	IONIC_STS_RETRY_EXCEEDED,
+	IONIC_STS_RNR_RETRY_EXCEEDED,
+	IONIC_STS_XRC_VIO_ERR,
+	IONIC_STS_LOCAL_SGL_INV_ERR,
+};
+
+static inline int ionic_to_ib_status(int sts)
+{
+	switch (sts) {
+	case IONIC_STS_OK:
+		return IB_WC_SUCCESS;
+	case IONIC_STS_LOCAL_LEN_ERR:
+		return IB_WC_LOC_LEN_ERR;
+	case IONIC_STS_LOCAL_QP_OPER_ERR:
+	case IONIC_STS_LOCAL_SGL_INV_ERR:
+		return IB_WC_LOC_QP_OP_ERR;
+	case IONIC_STS_LOCAL_PROT_ERR:
+		return IB_WC_LOC_PROT_ERR;
+	case IONIC_STS_WQE_FLUSHED_ERR:
+		return IB_WC_WR_FLUSH_ERR;
+	case IONIC_STS_MEM_MGMT_OPER_ERR:
+		return IB_WC_MW_BIND_ERR;
+	case IONIC_STS_BAD_RESP_ERR:
+		return IB_WC_BAD_RESP_ERR;
+	case IONIC_STS_LOCAL_ACC_ERR:
+		return IB_WC_LOC_ACCESS_ERR;
+	case IONIC_STS_REMOTE_INV_REQ_ERR:
+		return IB_WC_REM_INV_REQ_ERR;
+	case IONIC_STS_REMOTE_ACC_ERR:
+		return IB_WC_REM_ACCESS_ERR;
+	case IONIC_STS_REMOTE_OPER_ERR:
+		return IB_WC_REM_OP_ERR;
+	case IONIC_STS_RETRY_EXCEEDED:
+		return IB_WC_RETRY_EXC_ERR;
+	case IONIC_STS_RNR_RETRY_EXCEEDED:
+		return IB_WC_RNR_RETRY_EXC_ERR;
+	case IONIC_STS_XRC_VIO_ERR:
+	default:
+		return IB_WC_GENERAL_ERR;
+	}
+}
+
 /* admin queue qp type */
 enum ionic_qp_type {
 	IONIC_QPT_RC,
@@ -294,6 +349,24 @@ struct ionic_v1_cqe {
 	__be32				qid_type_flags;
 };
 
+/* bits for cqe recv */
+enum ionic_v1_cqe_src_qpn_bits {
+	IONIC_V1_CQE_RECV_QPN_MASK	= 0xffffff,
+	IONIC_V1_CQE_RECV_OP_SHIFT	= 24,
+
+	/* MASK could be 0x3, but need 0x1f for makeshift values:
+	 * OP_TYPE_RDMA_OPER_WITH_IMM, OP_TYPE_SEND_RCVD
+	 */
+	IONIC_V1_CQE_RECV_OP_MASK	= 0x1f,
+	IONIC_V1_CQE_RECV_OP_SEND	= 0,
+	IONIC_V1_CQE_RECV_OP_SEND_INV	= 1,
+	IONIC_V1_CQE_RECV_OP_SEND_IMM	= 2,
+	IONIC_V1_CQE_RECV_OP_RDMA_IMM	= 3,
+
+	IONIC_V1_CQE_RECV_IS_IPV4	= BIT(7 + IONIC_V1_CQE_RECV_OP_SHIFT),
+	IONIC_V1_CQE_RECV_IS_VLAN	= BIT(6 + IONIC_V1_CQE_RECV_OP_SHIFT),
+};
+
 /* bits for cqe qid_type_flags */
 enum ionic_v1_cqe_qtf_bits {
 	IONIC_V1_CQE_COLOR		= BIT(0),
@@ -318,6 +391,16 @@ static inline bool ionic_v1_cqe_error(struct ionic_v1_cqe *cqe)
 	return cqe->qid_type_flags & cpu_to_be32(IONIC_V1_CQE_ERROR);
 }
 
+static inline bool ionic_v1_cqe_recv_is_ipv4(struct ionic_v1_cqe *cqe)
+{
+	return cqe->recv.src_qpn_op & cpu_to_be32(IONIC_V1_CQE_RECV_IS_IPV4);
+}
+
+static inline bool ionic_v1_cqe_recv_is_vlan(struct ionic_v1_cqe *cqe)
+{
+	return cqe->recv.src_qpn_op & cpu_to_be32(IONIC_V1_CQE_RECV_IS_VLAN);
+}
+
 static inline void ionic_v1_cqe_clean(struct ionic_v1_cqe *cqe)
 {
 	cqe->qid_type_flags |= cpu_to_be32(~0u << IONIC_V1_CQE_QID_SHIFT);
@@ -444,6 +527,28 @@ enum ionic_v1_op {
 	IONIC_V1_SPEC_FIRST_SGE		= 2,
 };
 
+/* queue pair v2 send opcodes */
+enum ionic_v2_op {
+	IONIC_V2_OPSL_OUT          = 0x20,
+	IONIC_V2_OPSL_IMM          = 0x40,
+	IONIC_V2_OPSL_INV          = 0x80,
+
+	IONIC_V2_OP_SEND           = 0x0 | IONIC_V2_OPSL_OUT,
+	IONIC_V2_OP_SEND_IMM       = IONIC_V2_OP_SEND | IONIC_V2_OPSL_IMM,
+	IONIC_V2_OP_SEND_INV       = IONIC_V2_OP_SEND | IONIC_V2_OPSL_INV,
+
+	IONIC_V2_OP_RDMA_WRITE     = 0x1 | IONIC_V2_OPSL_OUT,
+	IONIC_V2_OP_RDMA_WRITE_IMM = IONIC_V2_OP_RDMA_WRITE | IONIC_V2_OPSL_IMM,
+
+	IONIC_V2_OP_RDMA_READ      = 0x2,
+
+	IONIC_V2_OP_ATOMIC_CS      = 0x4,
+	IONIC_V2_OP_ATOMIC_FA      = 0x5,
+	IONIC_V2_OP_REG_MR         = 0x6,
+	IONIC_V2_OP_LOCAL_INV      = 0x7,
+	IONIC_V2_OP_BIND_MW        = 0x8,
+};
+
 static inline size_t ionic_v1_send_wqe_min_size(int min_sge, int min_data,
 						int spec, bool expdb)
 {
diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.c b/drivers/infiniband/hw/ionic/ionic_ibdev.c
index 6833abbfb1dc..ab080d945a13 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.c
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.c
@@ -45,6 +45,11 @@ static const struct ib_device_ops ionic_dev_ops = {
 	.query_qp = ionic_query_qp,
 	.destroy_qp = ionic_destroy_qp,
 
+	.post_send = ionic_post_send,
+	.post_recv = ionic_post_recv,
+	.poll_cq = ionic_poll_cq,
+	.req_notify_cq = ionic_req_notify_cq,
+
 	INIT_RDMA_OBJ_SIZE(ib_ucontext, ionic_ctx, ibctx),
 	INIT_RDMA_OBJ_SIZE(ib_pd, ionic_pd, ibpd),
 	INIT_RDMA_OBJ_SIZE(ib_ah, ionic_ah, ibah),
diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.h b/drivers/infiniband/hw/ionic/ionic_ibdev.h
index 94ef76aaca43..bbec041b378b 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.h
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.h
@@ -387,6 +387,11 @@ static inline u32 ionic_obj_dbid(struct ionic_ibdev *dev,
 	return ionic_ctx_dbid(dev, to_ionic_ctx_uobj(uobj));
 }
 
+static inline bool ionic_ibop_is_local(enum ib_wr_opcode op)
+{
+	return op == IB_WR_LOCAL_INV || op == IB_WR_REG_MR;
+}
+
 static inline void ionic_qp_complete(struct kref *kref)
 {
 	struct ionic_qp *qp = container_of(kref, struct ionic_qp, qp_kref);
@@ -462,8 +467,17 @@ int ionic_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr, int mask,
 		   struct ib_qp_init_attr *init_attr);
 int ionic_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata);
 
+/* ionic_datapath.c */
+int ionic_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
+		    const struct ib_send_wr **bad);
+int ionic_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
+		    const struct ib_recv_wr **bad);
+int ionic_poll_cq(struct ib_cq *ibcq, int nwc, struct ib_wc *wc);
+int ionic_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags);
+
 /* ionic_pgtbl.c */
 __le64 ionic_pgtbl_dma(struct ionic_tbl_buf *buf, u64 va);
+__be64 ionic_pgtbl_off(struct ionic_tbl_buf *buf, u64 va);
 int ionic_pgtbl_page(struct ionic_tbl_buf *buf, u64 dma);
 int ionic_pgtbl_init(struct ionic_ibdev *dev,
 		     struct ionic_tbl_buf *buf,
diff --git a/drivers/infiniband/hw/ionic/ionic_pgtbl.c b/drivers/infiniband/hw/ionic/ionic_pgtbl.c
index a8eb73be6f86..e74db73c9246 100644
--- a/drivers/infiniband/hw/ionic/ionic_pgtbl.c
+++ b/drivers/infiniband/hw/ionic/ionic_pgtbl.c
@@ -26,6 +26,17 @@ __le64 ionic_pgtbl_dma(struct ionic_tbl_buf *buf, u64 va)
 	return cpu_to_le64(dma + (va & pg_mask));
 }
 
+__be64 ionic_pgtbl_off(struct ionic_tbl_buf *buf, u64 va)
+{
+	if (buf->tbl_pages > 1) {
+		u64 pg_mask = BIT_ULL(buf->page_size_log2) - 1;
+
+		return cpu_to_be64(va & pg_mask);
+	}
+
+	return 0;
+}
+
 int ionic_pgtbl_page(struct ionic_tbl_buf *buf, u64 dma)
 {
 	if (unlikely(buf->tbl_pages == buf->tbl_limit))
-- 
2.43.0


