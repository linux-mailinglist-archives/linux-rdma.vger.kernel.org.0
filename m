Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9DAD87DD5
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2019 17:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfHIPRN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Aug 2019 11:17:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36160 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726358AbfHIPRN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Aug 2019 11:17:13 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x79FDuXu039259
        for <linux-rdma@vger.kernel.org>; Fri, 9 Aug 2019 11:17:13 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u98v374dt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 09 Aug 2019 11:17:12 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rdma@vger.kernel.org> from <bmt@zurich.ibm.com>;
        Fri, 9 Aug 2019 16:17:10 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 9 Aug 2019 16:17:07 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x79FGmOw40042792
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Aug 2019 15:16:48 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2103F11C052;
        Fri,  9 Aug 2019 15:17:06 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB09B11C050;
        Fri,  9 Aug 2019 15:17:05 +0000 (GMT)
Received: from spoke.zurich.ibm.com (unknown [9.4.69.152])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  9 Aug 2019 15:17:05 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@ziepe.ca, Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH] Make user mmapped CQ arming flags field 32-bit size to remove 64-bit architecture dependency of siw.
Date:   Fri,  9 Aug 2019 17:16:59 +0200
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 19080915-4275-0000-0000-00000357220D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080915-4276-0000-0000-000038692AA7
Message-Id: <20190809151700.12960-1-bmt@zurich.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-09_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=877 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908090153
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch changes the driver/user shared (mmapped) CQ notification
flags field from unsigned 64-bits size to unsigned 32-bits size. This
enables building siw on 32-bit architectures.

This patch changes the siw-abi. On previously supported 64-bits
little-endian architectures, the old siw user library remains
usable, since the used 2 lowest bits of the new 32-bits field reside
at the same memory location as those of the old 64-bits field.
On 64-bits big-endian systems, the changes would break compatibility.
Given the very short time of availability of siw with the current ABI,
we do not expect current usage of siw on 64-bit big-endian systems.

An according patch to change the siw user library fitting the new ABI
will be provided to rdma-core.

Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/Kconfig     |  2 +-
 drivers/infiniband/sw/siw/siw.h       |  2 +-
 drivers/infiniband/sw/siw/siw_qp.c    | 14 ++++++++++----
 drivers/infiniband/sw/siw/siw_verbs.c | 16 +++++++++++-----
 include/uapi/rdma/siw-abi.h           |  3 ++-
 5 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/sw/siw/Kconfig b/drivers/infiniband/sw/siw/Kconfig
index dace276aea14..b622fc62f2cd 100644
--- a/drivers/infiniband/sw/siw/Kconfig
+++ b/drivers/infiniband/sw/siw/Kconfig
@@ -1,6 +1,6 @@
 config RDMA_SIW
 	tristate "Software RDMA over TCP/IP (iWARP) driver"
-	depends on INET && INFINIBAND && LIBCRC32C && 64BIT
+	depends on INET && INFINIBAND && LIBCRC32C
 	select DMA_VIRT_OPS
 	help
 	This driver implements the iWARP RDMA transport over
diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index 03fd7b2f595f..77b1aabf6ff3 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -214,7 +214,7 @@ struct siw_wqe {
 struct siw_cq {
 	struct ib_cq base_cq;
 	spinlock_t lock;
-	u64 *notify;
+	struct siw_cq_ctrl *notify;
 	struct siw_cqe *queue;
 	u32 cq_put;
 	u32 cq_get;
diff --git a/drivers/infiniband/sw/siw/siw_qp.c b/drivers/infiniband/sw/siw/siw_qp.c
index e27bd5b35b96..0990307c5d2c 100644
--- a/drivers/infiniband/sw/siw/siw_qp.c
+++ b/drivers/infiniband/sw/siw/siw_qp.c
@@ -1013,18 +1013,24 @@ int siw_activate_tx(struct siw_qp *qp)
  */
 static bool siw_cq_notify_now(struct siw_cq *cq, u32 flags)
 {
-	u64 cq_notify;
+	u32 cq_notify;
 
 	if (!cq->base_cq.comp_handler)
 		return false;
 
-	cq_notify = READ_ONCE(*cq->notify);
+	/* Read application shared notification state */
+	cq_notify = READ_ONCE(cq->notify->flags);
 
 	if ((cq_notify & SIW_NOTIFY_NEXT_COMPLETION) ||
 	    ((cq_notify & SIW_NOTIFY_SOLICITED) &&
 	     (flags & SIW_WQE_SOLICITED))) {
-		/* dis-arm CQ */
-		smp_store_mb(*cq->notify, SIW_NOTIFY_NOT);
+		/*
+		 * CQ notification is one-shot: Since the
+		 * current CQE causes user notification,
+		 * the CQ gets dis-aremd and must be re-aremd
+		 * by the user for a new notification.
+		 */
+		WRITE_ONCE(cq->notify->flags, SIW_NOTIFY_NOT);
 
 		return true;
 	}
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 32dc79d0e898..e7f3a2379d9d 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -1049,7 +1049,7 @@ int siw_create_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
 
 	spin_lock_init(&cq->lock);
 
-	cq->notify = &((struct siw_cq_ctrl *)&cq->queue[size])->notify;
+	cq->notify = (struct siw_cq_ctrl *)&cq->queue[size];
 
 	if (udata) {
 		struct siw_uresp_create_cq uresp = {};
@@ -1141,11 +1141,17 @@ int siw_req_notify_cq(struct ib_cq *base_cq, enum ib_cq_notify_flags flags)
 	siw_dbg_cq(cq, "flags: 0x%02x\n", flags);
 
 	if ((flags & IB_CQ_SOLICITED_MASK) == IB_CQ_SOLICITED)
-		/* CQ event for next solicited completion */
-		smp_store_mb(*cq->notify, SIW_NOTIFY_SOLICITED);
+		/*
+		 * Enable CQ event for next solicited completion.
+		 * and make it visible to all associated producers.
+		 */
+		smp_store_mb(cq->notify->flags, SIW_NOTIFY_SOLICITED);
 	else
-		/* CQ event for any signalled completion */
-		smp_store_mb(*cq->notify, SIW_NOTIFY_ALL);
+		/*
+		 * Enable CQ event for any signalled completion.
+		 * and make it visible to all associated producers.
+		 */
+		smp_store_mb(cq->notify->flags, SIW_NOTIFY_ALL);
 
 	if (flags & IB_CQ_REPORT_MISSED_EVENTS)
 		return cq->cq_put - cq->cq_get;
diff --git a/include/uapi/rdma/siw-abi.h b/include/uapi/rdma/siw-abi.h
index 7de68f1dc707..af735f55b291 100644
--- a/include/uapi/rdma/siw-abi.h
+++ b/include/uapi/rdma/siw-abi.h
@@ -180,6 +180,7 @@ struct siw_cqe {
  * to control CQ arming.
  */
 struct siw_cq_ctrl {
-	__aligned_u64 notify;
+	__u32 flags;
+	__u32 pad;
 };
 #endif
-- 
2.17.2

