Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B524E3A70
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 19:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394078AbfJXRzb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 13:55:31 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:56242 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391414AbfJXRzb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Oct 2019 13:55:31 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9OHoEvE028330;
        Thu, 24 Oct 2019 10:55:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=ldrdxchpXTqvITcQKjHUcBB5wrqB9uMT63eNHxDs0sg=;
 b=pwZCNdaaDk0DTujBSuIK9sOXSXnMv6MMCeElHT9JHQRcumqhmO0G3NQESuz+VEm4178W
 H+++DKla9FW3o2rTxHe5uTHo65xDMcs4l6NpDfLXX8y/pUVRRx250aLNGNtg7DJfbN5/
 W8wwOacfmndMpNTFfbP3EYJOdUGSMPrWs9gRWiSkdyE+XKM2JGhpKLh8+zEf0EKPgBBN
 Atyx2Rw3hkNfKubkWYU42DGD5CjsjfUMvsnQhnhTJTbby2+BikJdtCd5LmGuXHYpll1d
 xWkF/S6sVyG/N0ycwkjYbLPUcohc2fV9hLfAvNdDVnalhGhDelhCm4VOq65QhjN24JyA NQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2vt9ujrhhk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 24 Oct 2019 10:55:28 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 24 Oct
 2019 10:55:26 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Thu, 24 Oct 2019 10:55:26 -0700
Received: from lb-tlvb-michal.il.qlogic.org (unknown [10.5.220.215])
        by maili.marvell.com (Postfix) with ESMTP id CF28A3F7040;
        Thu, 24 Oct 2019 10:55:24 -0700 (PDT)
From:   Michal Kalderon <michal.kalderon@marvell.com>
To:     <michal.kalderon@marvell.com>, <aelior@marvell.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, Ariel Elior <ariel.elior@marvell.com>
Subject: [PATCH v3 rdma-next 1/3] RDMA/qedr: Fix qpids xarray api used
Date:   Thu, 24 Oct 2019 20:52:51 +0300
Message-ID: <20191024175253.26816-2-michal.kalderon@marvell.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20191024175253.26816-1-michal.kalderon@marvell.com>
References: <20191024175253.26816-1-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-24_10:2019-10-23,2019-10-24 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The qpids xarray isn't accessed from irq context and therefore there
is no need to use the xa_XXX_irq version of the apis.
Remove the _irq.

Fixes: b6014f9e5f39 ("qedr: Convert qpidr to XArray")
Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
---
 drivers/infiniband/hw/qedr/main.c       | 1 -
 drivers/infiniband/hw/qedr/qedr_iw_cm.c | 2 +-
 drivers/infiniband/hw/qedr/verbs.c      | 4 ++--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/main.c b/drivers/infiniband/hw/qedr/main.c
index 5136b835e1ba..432dff95a7aa 100644
--- a/drivers/infiniband/hw/qedr/main.c
+++ b/drivers/infiniband/hw/qedr/main.c
@@ -359,7 +359,6 @@ static int qedr_alloc_resources(struct qedr_dev *dev)
 	spin_lock_init(&dev->sgid_lock);
 
 	if (IS_IWARP(dev)) {
-		xa_init_flags(&dev->qps, XA_FLAGS_LOCK_IRQ);
 		dev->iwarp_wq = create_singlethread_workqueue("qedr_iwarpq");
 	}
 
diff --git a/drivers/infiniband/hw/qedr/qedr_iw_cm.c b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
index 22881d4442b9..7fea74739c1f 100644
--- a/drivers/infiniband/hw/qedr/qedr_iw_cm.c
+++ b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
@@ -739,7 +739,7 @@ void qedr_iw_qp_rem_ref(struct ib_qp *ibqp)
 	struct qedr_qp *qp = get_qedr_qp(ibqp);
 
 	if (atomic_dec_and_test(&qp->refcnt)) {
-		xa_erase_irq(&qp->dev->qps, qp->qp_id);
+		xa_erase(&qp->dev->qps, qp->qp_id);
 		kfree(qp);
 	}
 }
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 6f3ce86019b7..84b666c67cff 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -1918,7 +1918,7 @@ struct ib_qp *qedr_create_qp(struct ib_pd *ibpd,
 	qp->ibqp.qp_num = qp->qp_id;
 
 	if (rdma_protocol_iwarp(&dev->ibdev, 1)) {
-		rc = xa_insert_irq(&dev->qps, qp->qp_id, qp, GFP_KERNEL);
+		rc = xa_insert(&dev->qps, qp->qp_id, qp, GFP_KERNEL);
 		if (rc)
 			goto err;
 	}
@@ -2492,7 +2492,7 @@ int qedr_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 
 	if (atomic_dec_and_test(&qp->refcnt) &&
 	    rdma_protocol_iwarp(&dev->ibdev, 1)) {
-		xa_erase_irq(&dev->qps, qp->qp_id);
+		xa_erase(&dev->qps, qp->qp_id);
 		kfree(qp);
 	}
 	return 0;
-- 
2.14.5

