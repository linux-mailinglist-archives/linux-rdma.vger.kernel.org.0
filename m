Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B4C4330F9
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Oct 2021 10:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbhJSIYj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Oct 2021 04:24:39 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:57584 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234658AbhJSIYj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 Oct 2021 04:24:39 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19J2rTJw009227;
        Tue, 19 Oct 2021 01:22:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pfpt0220;
 bh=o9oc2+A3xTVy8mMP32u7nQOtUNaoEPYjyMs11gbPFJk=;
 b=OMBp/QZKJoipDX5dSIfDQ/95I184Ma9N+CI+MRHegMrV/NMPT9n1WwPfN9GCdC4ud8bq
 zFNoLgoOM09VKFkDc8zi15xLbFXuG9aSnX0WiGr3+ix+PzrkFk89/fvUNjgB/9PUZBst
 +poviHobj5rRn2ARgWOtf1hDkDFTKJczemt8CJmAwk+PiNo8Jn3mdYQ9td15rFv+tQk5
 Rt9jIyvDeCVfW2AyBu25QPDgNN6mb9AqCN9Wc0DF4GfA8/383KanH9tEbmzr9MIppJ7s
 sTKQtFcx+TAu31Uo6tFdKnIxxNX7XuUsx44LDHpOJ3ucyQaRAdLx7pBajiVVmTfnwgON DQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 3bsnmq1dgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 19 Oct 2021 01:22:18 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 19 Oct
 2021 01:22:16 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server id
 15.0.1497.18 via Frontend Transport; Tue, 19 Oct 2021 01:22:14 -0700
From:   Prabhakar Kushwaha <pkushwaha@marvell.com>
To:     <linux-rdma@vger.kernel.org>, <dledford@redhat.com>,
        <jgg@nvidia.com>, <mkalderon@marvell.com>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <smalin@marvell.com>,
        <aelior@marvell.com>, <palok@marvell.com>, <pkushwaha@marvell.com>,
        <prabhakar.pkin@gmail.com>, <malin1024@gmail.com>
Subject: [PATCH for-rc] rdma/qedr: Fix crash due to redundant release of device's qp memory
Date:   Tue, 19 Oct 2021 11:22:12 +0300
Message-ID: <20211019082212.7052-1-pkushwaha@marvell.com>
X-Mailer: git-send-email 2.16.6
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Xj6jtfw9SpDzsH2okC6jkL-PjHdzd63Z
X-Proofpoint-ORIG-GUID: Xj6jtfw9SpDzsH2okC6jkL-PjHdzd63Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-18_07,2021-10-18_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Device's QP memory should only be allocated and released by IB layer.
This patch removes the redundant release of the device's qp memory
and uses completion APIs to make sure that .destroy_qp() only return,
when qp reference becomes 0.

Fixes: 514aee660df4 ("RDMA: Globally allocate and release QP memory")
Acked-by: Michal Kalderon <michal.kalderon@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
Signed-off-by: Alok Prasad <palok@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
---
 drivers/infiniband/hw/qedr/qedr.h       | 1 +
 drivers/infiniband/hw/qedr/qedr_iw_cm.c | 2 +-
 drivers/infiniband/hw/qedr/verbs.c      | 5 ++++-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/qedr.h b/drivers/infiniband/hw/qedr/qedr.h
index 3cb4febaad0f..8def88cfa300 100644
--- a/drivers/infiniband/hw/qedr/qedr.h
+++ b/drivers/infiniband/hw/qedr/qedr.h
@@ -455,6 +455,7 @@ struct qedr_qp {
 	/* synchronization objects used with iwarp ep */
 	struct kref refcnt;
 	struct completion iwarp_cm_comp;
+	struct completion qp_rel_comp;
 	unsigned long iwarp_cm_flags; /* enum iwarp_cm_flags */
 };
 
diff --git a/drivers/infiniband/hw/qedr/qedr_iw_cm.c b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
index 1715fbe0719d..a51fc6854984 100644
--- a/drivers/infiniband/hw/qedr/qedr_iw_cm.c
+++ b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
@@ -83,7 +83,7 @@ static void qedr_iw_free_qp(struct kref *ref)
 {
 	struct qedr_qp *qp = container_of(ref, struct qedr_qp, refcnt);
 
-	kfree(qp);
+	complete(&qp->qp_rel_comp);
 }
 
 static void
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 3fbf172dbbef..dcb3653db72d 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -1357,6 +1357,7 @@ static void qedr_set_common_qp_params(struct qedr_dev *dev,
 	if (rdma_protocol_iwarp(&dev->ibdev, 1)) {
 		kref_init(&qp->refcnt);
 		init_completion(&qp->iwarp_cm_comp);
+		init_completion(&qp->qp_rel_comp);
 	}
 
 	qp->pd = pd;
@@ -2857,8 +2858,10 @@ int qedr_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 
 	qedr_free_qp_resources(dev, qp, udata);
 
-	if (rdma_protocol_iwarp(&dev->ibdev, 1))
+	if (rdma_protocol_iwarp(&dev->ibdev, 1)) {
 		qedr_iw_qp_rem_ref(&qp->ibqp);
+		wait_for_completion(&qp->qp_rel_comp);
+	}
 
 	return 0;
 }
-- 
2.24.1

