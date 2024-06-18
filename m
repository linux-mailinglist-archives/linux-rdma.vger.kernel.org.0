Return-Path: <linux-rdma+bounces-3246-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 319E790C027
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 02:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38B281C21828
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2024 00:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F623EC0;
	Tue, 18 Jun 2024 00:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Td/DSTDt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544F71367
	for <linux-rdma@vger.kernel.org>; Tue, 18 Jun 2024 00:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718669463; cv=fail; b=gluyBrGzeymSuwxQvQ/pV29K1GBfP1REJtnR42whqLwuBiE4lgaTU5xWnZ7Fa0+krmtER5ivd0GNpTrJhQ5QULpd8le9NUuSXhsOipEgjb6znMDkh5FX8/0qe+cktVtlqaPHx+wY9z85fo2whOX9hJ9P4Pz158ku+1bwlmU8uEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718669463; c=relaxed/simple;
	bh=en+Xbof2ele3+6M7NQ435F1OuwxyVZGlvyKJ5ZiB058=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P+W3ImHZ1Ek/pxTkgp5gv7nu6zIQ2ZR8EHe/NfHAbiSt1DyrE8U0BUdxYOmFcDt8IRhn65NjUyOD0mwpJhkvSLlooOPfXT9gO+a8a08SQQcQ5N2GP32nYO6g9N15Romzw2vgXmSM4kqkRmu6GOODTP6H/yv3wKLNQ+UPeOR0Op8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Td/DSTDt; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrXlvE3J+5ETlxgYiJu18FSg/CMhe430+EA2PqlVzlnlfnySF1pFyHe/H90j/Dgk5lQsC+fSHkKChTmGbpYHZKm97NB+Nu9ghNWBYuavT1Sm6Yru3BXQshK90c6ithUg0nuB9/oc/xpoasyTTjookjioZ2FydzTkzyLlCU0Yk7mYjYMzN8HlfOryuX/kEzuA2ImFqkdWjM8N6bEUc7CjpAmaPiRwch0sLmuRwFx9HLeFIe357S6zLNWiQ2lu8QKDUjALBTLjiSQ1w3v7Td9iWtIg8DnOJAhJrgag22GXJMzBqMwH2RQJWZ4kN4E3Ba+TkBJlXIk1jno9/a/CvGx8MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/D57k+qje9srjgeYV7+LAq3vzfnZkskwDhTuSBbfNlY=;
 b=MY7usu3VnMjT6ARZL9MXXxHOsZ4tYwaJRiXHz8MD+BPiKYfz3Bp/1GY56LXtylFYGoKz4TZ8up53ObFgJ1f90TVcW47nPsOancQ/hE8JGwOVEjE/t4ogq8mGPFOIQ8jcOqVV4QtXPpa/lMjOQPUIeO2U371VfBqGaiCad5lYzpthqbG5bVEMD5AQnxt3S/HpJNUy9SNDr03vp17eBuy4p9gWspqF2RqUg5NkCs0RxuJcvUR3QkgkO/Qn2wavoU1JPV9mbtps7/jTOiBU4oAlXDhaB5kSz0LCbQtfON2BnoD9hkF7rHqlLCGUiCZrAAZGI1BJoob9CAXrmBMSa3mYaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/D57k+qje9srjgeYV7+LAq3vzfnZkskwDhTuSBbfNlY=;
 b=Td/DSTDtjyw3xwgQNkDIaD0UkchANqbL+EPdC002D4QAgGje/qBFIeuV4WmNKrvG3OCGEjRQ/nIPj++7H1LfQMfRTD0JIVnlsugoLfg3B7EMh1z7yhkeC3EJ2R+Kb1l3R/0cb3I/8CB3TnqFzvpkdhIbRgLA/TlvQZTareDz4pj07niTN/F8C3Qhs9Vi01ng7PmZZmqYkQBITEkptIGWxNoSTeWGclt3q4n1YfEBUobsq7CxZtJz/3A/xFY2x1u9bbLhEDS0OWsrEDW2a5WsTaGb+kcADvmk0DP9wTeypykl53sGAjM4Blm+thXJyuAqOCmTVGZn4CEmgnmXmk27WQ==
Received: from CH2PR16CA0009.namprd16.prod.outlook.com (2603:10b6:610:50::19)
 by CH3PR12MB7572.namprd12.prod.outlook.com (2603:10b6:610:144::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 00:10:58 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::1c) by CH2PR16CA0009.outlook.office365.com
 (2603:10b6:610:50::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30 via Frontend
 Transport; Tue, 18 Jun 2024 00:10:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 00:10:56 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 17:10:43 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 17:10:42 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 17 Jun 2024 17:10:39 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <leonro@nvidia.com>, <jgg@nvidia.com>, <linux-nvme@lists.infradead.org>,
	<linux-rdma@vger.kernel.org>, <chuck.lever@oracle.com>
CC: <oren@nvidia.com>, <israelr@nvidia.com>, <maorg@nvidia.com>,
	<yishaih@nvidia.com>, <hch@lst.de>, <bvanassche@acm.org>,
	<shiraz.saleem@intel.com>, <edumazet@google.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 1/6] IB/core: add support for draining Shared receive queues
Date: Tue, 18 Jun 2024 03:10:29 +0300
Message-ID: <20240618001034.22681-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20240618001034.22681-1-mgurtovoy@nvidia.com>
References: <20240618001034.22681-1-mgurtovoy@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|CH3PR12MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: fac4ebb3-bb6c-4580-fef8-08dc8f2b205e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|1800799021|82310400023|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?toPmIOlbiB1zIvr6Hs6brcqa8dO+oZtLrAh2japrbJzDMavelV4dsRg81Vmk?=
 =?us-ascii?Q?VdatHdB56Py5B/SU0Fk+NNhrdoQEIx+wLLsg9o8gsNxDqDv6ZR5wbIwPjYvb?=
 =?us-ascii?Q?NncHHpz48wWRBIUUbZhvNZ+5H9glU0Nz5E15rnBEkSjfJpyz0JneSwbLApYT?=
 =?us-ascii?Q?pDEfqcVVPGU/u55kSSVO3pDCi7gL2LYFU9mFkLIuRrYYtbb4eqNzdKjBigt3?=
 =?us-ascii?Q?JE05EAencRB0adAt6fmIi9/shQwMvcNvd+4DSLk+q6FTXqk7mGn086L7PN5V?=
 =?us-ascii?Q?oWVDZ/4MaO7ZMcJKR/NTQdzovaf5ITf1Qs7B12xx9areVgWU/Y2kHLOmol9q?=
 =?us-ascii?Q?7igVCfHmsPoSeewXdM9XsV5/jRqr5FS2PxStP+wrBXW6aVEqQbMzb24oiS7Z?=
 =?us-ascii?Q?N92wA4n3Ow5rq9bdBQkziClBnfvcpB5wLQwpCcZmY/vqIbODEIMXK2/zs+0A?=
 =?us-ascii?Q?pqRdwDf7+MuJ/5ybkGl9nNshFEFHVrt2Ii8OjHdo2H6XVQZeEQncAjQUlFot?=
 =?us-ascii?Q?Gb01zigwUURHdBWbuV4rVZlleWfd3RB9gOvmcEiyhV3P3/yJXyywvY7g8NTs?=
 =?us-ascii?Q?CmgQXwc/w01SWT8EqZnBNGaR9SMLROKVDnSRFSeaKfF3Hf4j23VcEAopiJri?=
 =?us-ascii?Q?wFjxFqj6yFyC9/ALYR8b5ZAfre0p1XNxgRwjk79f4Epirdt6INhKo/ATVLe0?=
 =?us-ascii?Q?IHJINnEU+zIgZz3EJb40bWkexrH0/k2/AhvYPtEYeCf7WYSwrzyjzLJ5Fi2W?=
 =?us-ascii?Q?MJD7FQWU9DcGenLEv2t0esEOxrp0DNMWIXFJZnk37LMBVzrE6RTEKGSjO6hN?=
 =?us-ascii?Q?gYkob8vYesz2mJvanxgkpJ7RNdZqhOxChZKDRTBIh51HUcjw64v+roNyEsXp?=
 =?us-ascii?Q?hOx4W0d/7L2R2GZs850sFAB3LbqNzv/sLoNsXp+2NPuK8IDCQfasQe/Rq74c?=
 =?us-ascii?Q?IIe+mVcThCxCn5pwtxucTkOdwVP8lXS8/11uxaTXBpmVtJ7OZNB7h7I/8tZU?=
 =?us-ascii?Q?BHyY506T/faD/EYSzZNNyyvubnESPZuLRl6DKX18nH3EN6xSTEvYPQhf+tUb?=
 =?us-ascii?Q?AZ2mH9Pc3YtRgK0LhkhCwljy9GUmqrFTN6PlsKFocHS1QHDpBKn6Bh1xY06f?=
 =?us-ascii?Q?eTjk0inaFvbMFs7HX8PInA/5Lo0Ar7ytWoUyZkFuaSGWHnyFv1IUJDU1TY7o?=
 =?us-ascii?Q?RVb79V9hNwUXfJD0KZrJO0NxEjS6xmUhxK13HDqIkbgYCESW33zuPVnnCwH0?=
 =?us-ascii?Q?psIb8FnZAdRiZUGkisNhM+dQ0+7ih5mvdHpmEC8SEEtDChHvNF+ydKOsfbvC?=
 =?us-ascii?Q?LmkpS7UfF5GYr/VJxUPSiMaY4Asj2fcvF6ceSnjv9cJyr0R2X94j78dB68Nb?=
 =?us-ascii?Q?tWVGFOYbx5oUYowd6juhstylOlIf9aCoE4BqzxORejnIIN3aIQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(376011)(1800799021)(82310400023)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 00:10:56.7823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fac4ebb3-bb6c-4580-fef8-08dc8f2b205e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7572

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

Catch the Last WQE Reached Event in the core layer without involving the
ULP drivers with extra logic during drain and destroy QP flows.

The "Last WQE Reached" event will only be send on the errant QP, for
signaling that the SRQ flushed all the WQEs that have been dequeued from
the SRQ for processing by the associated QP.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/infiniband/core/verbs.c | 83 ++++++++++++++++++++++++++++++++-
 include/rdma/ib_verbs.h         |  2 +
 2 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 94a7f3b0c71c..9e4df7d40e0c 100644
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
+	else if (qp->registered_event_handler)
+		qp->registered_event_handler(event, qp->qp_context);
+}
+
 static void __ib_shared_qp_event_handler(struct ib_event *event, void *context)
 {
 	struct ib_qp *qp = context;
@@ -1221,7 +1231,10 @@ static struct ib_qp *create_qp(struct ib_device *dev, struct ib_pd *pd,
 	qp->qp_type = attr->qp_type;
 	qp->rwq_ind_tbl = attr->rwq_ind_tbl;
 	qp->srq = attr->srq;
-	qp->event_handler = attr->event_handler;
+	if (qp->srq)
+		init_completion(&qp->srq_completion);
+	qp->event_handler = __ib_qp_event_handler;
+	qp->registered_event_handler = attr->event_handler;
 	qp->port = attr->port_num;
 	qp->qp_context = attr->qp_context;
 
@@ -2884,6 +2897,72 @@ static void __ib_drain_rq(struct ib_qp *qp)
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
+	if (wait_for_completion_timeout(&qp->srq_completion, 10 * HZ) > 0) {
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
@@ -2962,6 +3041,8 @@ void ib_drain_qp(struct ib_qp *qp)
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


