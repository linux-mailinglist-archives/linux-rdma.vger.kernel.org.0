Return-Path: <linux-rdma+bounces-3348-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DE590F4E3
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 19:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D553C1F23471
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 17:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6503F155758;
	Wed, 19 Jun 2024 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rnL+8ARn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66575155756
	for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2024 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718817149; cv=fail; b=Qm4cmox3/FCy+yUuNiYTaETL/iH54j5YDDiI7Hu/aC07hGOHaH0rIzx3NJQH0KpSfBFhBX/1CcBp/SKNOZoqe5H7MlZN00CxSWtE/q/n3v4EGyihtgJ71dZmFpZB0TLl3fIdkBa5uVcoVusF8aTG0SwuKwCwirpcNszn79z3Tro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718817149; c=relaxed/simple;
	bh=pLraDnFOHy7cSbDEobqjliEnWMSvRgSvtxE+SHzoglU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qhCke3znllqyTfoW0XU16xtCZyL1NEUqRiNHrmF/3dSv43bgEukang7BxIqBMHKb7k5UxUBoLRnP8DQFH5guP8QeYm1QLm4EOs9df3mJguTu2QEPCYcMRKkfLUBwIcSzokd/YNfRHa0CGgsyUCQCCrf25yyQQDPUCD9Dvhf6MmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rnL+8ARn; arc=fail smtp.client-ip=40.107.236.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=musG07v0dY4YT9flHCEyfgFoikF5W6P7pILxekj93ECCrgxGtGFVCSzqawhc6jWN/WvPEpBPojcHH3nZrccACCSda6FFtngKCnWrZafKynsSlFkM/fGAXYH7+aN7MP5xMYhhe99trrhYs27LMPpaf8e7rNjwPnzJoDRyylmLa/Fxu+zpOKA6BiB/L0imD7INzobChpQKCVFQGl0MTvEfd/hwytTO+dxuFAwugINziAtLUoA4u+zNHL9irfiBawA2CEqfFaz17bGjP5s+0b8KiVrdTXqJqkifIBmHLmoxz/X+RDgPyoCVi8tKTpSQtgj5I63qtnhYXy0SaRG04hujjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHhW5tqlKCQve6ZST5IZ3UzNuG6hOXqaMbdinh80n4Y=;
 b=a3npO09jVCpLIuUiIb9xUwi5RNdxJVG9iTinSmiBuoOd4uIRzyxVhWdtbseD57dq6sz+0lXQFyPS636q6QDJjQ0pQnvYlDsSAGAiMz9fmcGRydPoVxXns5gfbTB2yKGOyCG/g6429EZ2wM3ZFZ0qkcbxxJF+Y/nILHxsgN3CFdu4KNAR+iXvhBjqGegdTJAny+wQuB1y2haA5GRfodPhQFHdnJxi4YPGftSqh9Y95h+TgMN8acDnMFMfF35kmgiaS2cUR2FSwoMvfO5RQmiYvmEOtxfiY3/SddVqP3CxMkSYf8YoRXuEeRoMkF4PuKkMS/sT1L2F6yGXZIg5HLBMBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHhW5tqlKCQve6ZST5IZ3UzNuG6hOXqaMbdinh80n4Y=;
 b=rnL+8ARnz+nhzb1k+nNi7tMUGlkCPS1U6dzeOLOhg43pBfNsO6R8AnQDtIbgEwxb7jmz7O0NiIVc0HFtrCNJFFq2aaY+5WIyy8yuVxO6gDQWLHuJ5Tl/nHs9yc44GOI6mM88xeB2QWXXtI47cV/qnEH/xaQkErdNXxPMkC0pxpR+9l+PaAKgjwlAiX9HByhN6fQcfmKE2E88PqwU8A9ZI/ONcJvSs6Kq3dJg/KSlqeaTV+MvA6sy8aKtloLqsZMIKLnwFQlEGpX1s7rqAmOumuJ/5pGY3Sk/Yq4qZni30pfIBluzXX/3P79TgAnWIsLaJZ0oM4OD7bBv4r6ufCWYHg==
Received: from MN2PR19CA0048.namprd19.prod.outlook.com (2603:10b6:208:19b::25)
 by SJ2PR12MB9163.namprd12.prod.outlook.com (2603:10b6:a03:559::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.23; Wed, 19 Jun
 2024 17:12:23 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:19b:cafe::fe) by MN2PR19CA0048.outlook.office365.com
 (2603:10b6:208:19b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Wed, 19 Jun 2024 17:12:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 17:12:23 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Jun
 2024 10:12:03 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Jun
 2024 10:12:03 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 19 Jun 2024 10:11:59 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <leonro@nvidia.com>, <jgg@nvidia.com>, <linux-nvme@lists.infradead.org>,
	<linux-rdma@vger.kernel.org>, <chuck.lever@oracle.com>, <sagi@grimberg.me>
CC: <oren@nvidia.com>, <israelr@nvidia.com>, <maorg@nvidia.com>,
	<yishaih@nvidia.com>, <hch@lst.de>, <bvanassche@acm.org>,
	<shiraz.saleem@intel.com>, <edumazet@google.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 1/2] IB/core: add support for draining Shared receive queues
Date: Wed, 19 Jun 2024 20:11:52 +0300
Message-ID: <20240619171153.34631-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20240619171153.34631-1-mgurtovoy@nvidia.com>
References: <20240619171153.34631-1-mgurtovoy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|SJ2PR12MB9163:EE_
X-MS-Office365-Filtering-Correlation-Id: 2340fa8b-e046-4db3-d5a0-08dc9082fc41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|36860700010|376011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z7AqE7O0GoJwbMl9/CV7xT3LXfFeN8Q17ivgXbHabNxzgO+pHiDshBHpM0bv?=
 =?us-ascii?Q?QkCqESxsqy3vhJ6Ew/RBgSgRh8JpJMKTWs71a9mWvTKAOrx/vL1kGpxxjiZ8?=
 =?us-ascii?Q?I12DMVws8g+sb8YGPYQjX7FuvKmuhajDEsvsyYHK26gJOeQDqlm7EWzpzmcW?=
 =?us-ascii?Q?jqSeBp+f/ZIsBfGV/up8Z9dPeeMnYeouaVi2m1w+rPP62W2mr2uKWA4LqKEf?=
 =?us-ascii?Q?bd3IDNFPQvz1XSacjMah50Bq23vPRTvinpC1A6JKrGy1L8KuWoKWZ/2n7UqO?=
 =?us-ascii?Q?/v6FEVtiVWKSgzm/2TdBlwsDVTj1wCcfZDvY8wSzEr6AWvNHbQwQHF677ctH?=
 =?us-ascii?Q?PY3MF8/QjIH5m1E3XgBvx4riZ3a7a0iY3LYe/I4z5CwuwI8RwqAxC3PMINmk?=
 =?us-ascii?Q?SeP0abx1QwNsbKr1fYWWT/QRTGjiOeKDZ49UkAZlN1+trPJ61xiQdzL9w28b?=
 =?us-ascii?Q?noid9hm/QZj6X5YrFVSWbKF6OCec+j25TXlMnZFzKGGK0PavCksgkkvxVcYP?=
 =?us-ascii?Q?sl5QdJi2mNUE2cLNsQtxK6C2/UkYZ2+yinCJF5aud3JFuC1mbcr7DdtTA8D/?=
 =?us-ascii?Q?9MP8EXzSG83g+KviBbXhLQyL/Uy/sSwbiXLW2SFIVKi2O6vnazV5BRxrEbfn?=
 =?us-ascii?Q?QyhycBdRvH2tUr5mtXiOtn2RwoRs71fu/rpYQNBc1l8W15+RfI8xZjXBGQU9?=
 =?us-ascii?Q?xbhhxkNOecKisAV2A47p8hyAND5I+yawC1AKTg7soEf+TXTX/jlFyCpQ+12f?=
 =?us-ascii?Q?aAx47o0MaG6DbpZJrhIRBQiSlpucun35UKHnpkvpAKD39wdtwsF9aCzw1JPl?=
 =?us-ascii?Q?c/AlhTJha2qDV0K0FDhqpWGLa41Zp8YLqA9EFUiIQZu+/JK8pzTdOYCbZEqA?=
 =?us-ascii?Q?KJRybQtoaOBl4KeK2eKrV3LfFsxqZIIVxKM4fYv7B5CDcEoKYjGxfCrUJCmc?=
 =?us-ascii?Q?Br2kYbhjOYSZw2JSBNJZYsdLTQkaq4Todo9/XMY0hp8IceuA9G28mJeDT/ts?=
 =?us-ascii?Q?CdtLjJ/L8fAGy301WSKxgbzFsTMc3Rd9fYhAOup0mahN+e07LMTe4JgeJ901?=
 =?us-ascii?Q?8nGI8teVYQcIlkFj1DoEZ+01CpxuptOXwwsJr3AUc4JSH02b+Vn1/TWw2Lgv?=
 =?us-ascii?Q?FsDMC//4wV9QJ7gpqCZWb+W76BJKdqskGxstd2Ot731+9wEXcSmNdDqTHMS6?=
 =?us-ascii?Q?Eon+bK/bzttbPAv/72g3dfgS48HAxxwwBHzzkWEngNYVShK9GooAIlgD7bXu?=
 =?us-ascii?Q?yMt369+ryNisefZUmNH4h5yVTBfmaqyndGaddTt3Qa0iqRMbLsr+dnKNx3EX?=
 =?us-ascii?Q?LyzF37+7l3VxCgdjSV7tXGRyhPJtbkd1ShQBurNyHMAElRDHoogtNdDSyamb?=
 =?us-ascii?Q?siWrPmzN9iY51s6hyVPE/OjClyoGf+31LOpFuc6ZlZJlMC9bzw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(36860700010)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 17:12:23.0213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2340fa8b-e046-4db3-d5a0-08dc9082fc41
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9163

To avoid leakage for QPs assocoated with SRQ, according to IB spec
(section 10.3.1):

"Note, for QPs that are associated with an SRQ, the Consumer should take
the QP through the Error State before invoking a Destroy QP or a Modify
QP to the Reset State. The Consumer may invoke the Destroy QP without
first performing a Modify QP to the Error State and waiting for the Affiliated
Asynchronous Last WQE Reached Event. However, if the Consumer
does not wait for the Affiliated Asynchronous Last WQE Reached Event,
then WQE and Data Segment leakage may occur. Therefore, it is good
programming practice to teardown a QP that is associated with an SRQ
by using the following process:
 - Put the QP in the Error State;
 - wait for the Affiliated Asynchronous Last WQE Reached Event;
 - either:
   - drain the CQ by invoking the Poll CQ verb and either wait for CQ
     to be empty or the number of Poll CQ operations has exceeded
     CQ capacity size; or
   - post another WR that completes on the same CQ and wait for this
     WR to return as a WC;
 - and then invoke a Destroy QP or Reset QP."

Catch the Last WQE Reached Event in the core layer during drain QP flow.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/infiniband/core/verbs.c | 82 ++++++++++++++++++++++++++++++++-
 include/rdma/ib_verbs.h         |  2 +
 2 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 94a7f3b0c71c..473ee0831307 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1101,6 +1101,16 @@ EXPORT_SYMBOL(ib_destroy_srq_user);
 
 /* Queue pairs */
 
+static void __ib_qp_event_handler(struct ib_event *event, void *context)
+{
+	struct ib_qp *qp = event->element.qp;
+
+	if (event->event == IB_EVENT_QP_LAST_WQE_REACHED)
+		complete(&qp->srq_completion);
+	if (qp->registered_event_handler)
+		qp->registered_event_handler(event, qp->qp_context);
+}
+
 static void __ib_shared_qp_event_handler(struct ib_event *event, void *context)
 {
 	struct ib_qp *qp = context;
@@ -1221,13 +1231,15 @@ static struct ib_qp *create_qp(struct ib_device *dev, struct ib_pd *pd,
 	qp->qp_type = attr->qp_type;
 	qp->rwq_ind_tbl = attr->rwq_ind_tbl;
 	qp->srq = attr->srq;
-	qp->event_handler = attr->event_handler;
+	qp->event_handler = __ib_qp_event_handler;
+	qp->registered_event_handler = attr->event_handler;
 	qp->port = attr->port_num;
 	qp->qp_context = attr->qp_context;
 
 	spin_lock_init(&qp->mr_lock);
 	INIT_LIST_HEAD(&qp->rdma_mrs);
 	INIT_LIST_HEAD(&qp->sig_mrs);
+	init_completion(&qp->srq_completion);
 
 	qp->send_cq = attr->send_cq;
 	qp->recv_cq = attr->recv_cq;
@@ -2884,6 +2896,72 @@ static void __ib_drain_rq(struct ib_qp *qp)
 		wait_for_completion(&rdrain.done);
 }
 
+/*
+ * __ib_drain_srq() - Block until Last WQE Reached event arrives, or timeout
+ *                    expires.
+ * @qp:               queue pair associated with SRQ to drain
+ *
+ * Quoting 10.3.1 Queue Pair and EE Context States:
+ *
+ * Note, for QPs that are associated with an SRQ, the Consumer should take the
+ * QP through the Error State before invoking a Destroy QP or a Modify QP to the
+ * Reset State.  The Consumer may invoke the Destroy QP without first performing
+ * a Modify QP to the Error State and waiting for the Affiliated Asynchronous
+ * Last WQE Reached Event. However, if the Consumer does not wait for the
+ * Affiliated Asynchronous Last WQE Reached Event, then WQE and Data Segment
+ * leakage may occur. Therefore, it is good programming practice to tear down a
+ * QP that is associated with an SRQ by using the following process:
+ *
+ * - Put the QP in the Error State
+ * - Wait for the Affiliated Asynchronous Last WQE Reached Event;
+ * - either:
+ *       drain the CQ by invoking the Poll CQ verb and either wait for CQ
+ *       to be empty or the number of Poll CQ operations has exceeded
+ *       CQ capacity size;
+ * - or
+ *       post another WR that completes on the same CQ and wait for this
+ *       WR to return as a WC;
+ * - and then invoke a Destroy QP or Reset QP.
+ *
+ * We use the first option.
+ */
+static void __ib_drain_srq(struct ib_qp *qp)
+{
+	struct ib_qp_attr attr = { .qp_state = IB_QPS_ERR };
+	struct ib_cq *cq;
+	int n, polled = 0;
+	int ret;
+
+	if (!qp->srq) {
+		WARN_ONCE(1, "QP 0x%p is not associated with SRQ\n", qp);
+		return;
+	}
+
+	ret = ib_modify_qp(qp, &attr, IB_QP_STATE);
+	if (ret) {
+		WARN_ONCE(ret, "failed to drain shared recv queue: %d\n", ret);
+		return;
+	}
+
+	if (ib_srq_has_cq(qp->srq->srq_type)) {
+		cq = qp->srq->ext.cq;
+	} else if (qp->recv_cq) {
+		cq = qp->recv_cq;
+	} else {
+		WARN_ONCE(1, "QP 0x%p has no CQ associated with SRQ\n", qp);
+		return;
+	}
+
+	if (wait_for_completion_timeout(&qp->srq_completion, 60 * HZ) > 0) {
+		while (polled != cq->cqe) {
+			n = ib_process_cq_direct(cq, cq->cqe - polled);
+			if (!n)
+				return;
+			polled += n;
+		}
+	}
+}
+
 /**
  * ib_drain_sq() - Block until all SQ CQEs have been consumed by the
  *		   application.
@@ -2962,6 +3040,8 @@ void ib_drain_qp(struct ib_qp *qp)
 	ib_drain_sq(qp);
 	if (!qp->srq)
 		ib_drain_rq(qp);
+	else
+		__ib_drain_srq(qp);
 }
 EXPORT_SYMBOL(ib_drain_qp);
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 477bf9dd5e71..5a193008f99c 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1788,6 +1788,7 @@ struct ib_qp {
 	struct list_head	rdma_mrs;
 	struct list_head	sig_mrs;
 	struct ib_srq	       *srq;
+	struct completion	srq_completion;
 	struct ib_xrcd	       *xrcd; /* XRC TGT QPs only */
 	struct list_head	xrcd_list;
 
@@ -1797,6 +1798,7 @@ struct ib_qp {
 	struct ib_qp           *real_qp;
 	struct ib_uqp_object   *uobject;
 	void                  (*event_handler)(struct ib_event *, void *);
+	void                  (*registered_event_handler)(struct ib_event *, void *);
 	void		       *qp_context;
 	/* sgid_attrs associated with the AV's */
 	const struct ib_gid_attr *av_sgid_attr;
-- 
2.18.1


