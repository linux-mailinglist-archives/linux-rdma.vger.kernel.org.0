Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEE366F87
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 15:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfGLNF0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 12 Jul 2019 09:05:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727336AbfGLNFZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 12 Jul 2019 09:05:25 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6CD2lLx067152
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jul 2019 09:05:24 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tpswbtbcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jul 2019 09:05:24 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 12 Jul 2019 13:05:23 -0000
Received: from us1a3-smtp03.a3.dal06.isc4sb.com (10.106.154.98)
        by smtp.notes.na.collabserv.com (10.106.227.158) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 12 Jul 2019 13:05:15 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp03.a3.dal06.isc4sb.com
          with ESMTP id 2019071213051539-475857 ;
          Fri, 12 Jul 2019 13:05:15 +0000 
In-Reply-To: <20190712120328.GB27512@ziepe.ca>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@ziepe.ca>
Cc:     "Arnd Bergmann" <arnd@arndb.de>,
        "Doug Ledford" <dledford@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 12 Jul 2019 13:05:14 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190712120328.GB27512@ziepe.ca>,<20190712085212.3901785-1-arnd@arndb.de>
 <OF05C1A780.433E36D1-ON00258435.003381DA-00258435.003F847E@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-LLNOutbound: False
X-Disclaimed: 22835
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19071213-1335-0000-0000-00000099771C
X-IBM-SpamModules-Scores: BY=0.030638; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.002329
X-IBM-SpamModules-Versions: BY=3.00011415; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01231103; UDB=6.00648504; IPR=6.01012387;
 MB=3.00027691; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-12 13:05:21
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-07-12 09:20:14 - 6.00010155
x-cbparentid: 19071213-1336-0000-0000-000001597D84
Message-Id: <OF36428621.B839DE8B-ON00258435.00461748-00258435.0047E413@notes.na.collabserv.com>
Subject: Re:  Re: [PATCH] rdma/siw: avoid smp_store_mb() on a u64
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-12_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Jason Gunthorpe" <jgg@ziepe.ca>
>Date: 07/12/2019 02:03PM
>Cc: "Arnd Bergmann" <arnd@arndb.de>, "Doug Ledford"
><dledford@redhat.com>, "Peter Zijlstra" <peterz@infradead.org>,
>linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
>Subject: [EXTERNAL] Re: [PATCH] rdma/siw: avoid smp_store_mb() on a
>u64
>
>On Fri, Jul 12, 2019 at 11:33:46AM +0000, Bernard Metzler wrote:
>> >diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
>> >b/drivers/infiniband/sw/siw/siw_verbs.c
>> >index 32dc79d0e898..41c5ab293fe1 100644
>> >+++ b/drivers/infiniband/sw/siw/siw_verbs.c
>> >@@ -1142,10 +1142,11 @@ int siw_req_notify_cq(struct ib_cq
>*base_cq,
>> >enum ib_cq_notify_flags flags)
>> > 
>> > 	if ((flags & IB_CQ_SOLICITED_MASK) == IB_CQ_SOLICITED)
>> > 		/* CQ event for next solicited completion */
>> >-		smp_store_mb(*cq->notify, SIW_NOTIFY_SOLICITED);
>> >+		WRITE_ONCE(*cq->notify, SIW_NOTIFY_SOLICITED);
>> > 	else
>> > 		/* CQ event for any signalled completion */
>> >-		smp_store_mb(*cq->notify, SIW_NOTIFY_ALL);
>> >+		WRITE_ONCE(*cq->notify, SIW_NOTIFY_ALL);
>> >+	smp_wmb();
>> > 
>> > 	if (flags & IB_CQ_REPORT_MISSED_EVENTS)
>> > 		return cq->cq_put - cq->cq_get;
>> 
>> 
>> Hi Arnd,
>> Many thanks for pointing that out! Indeed, this CQ notification
>> mechanism does not take 32 bit architectures into account.
>> Since we have only three flags to hold here, it's probably better
>> to make it a 32bit value. That would remove the issue w/o
>> introducing extra smp_wmb(). 
>
>I also prefer not to see smp_wmb() in drivers..
>
>> I'd prefer smp_store_mb(), since on some architectures it shall be
>> more efficient.  That would also make it sufficient to use
>> READ_ONCE.
>
>The READ_ONCE is confusing to me too, if you need store_release
>semantics then the reader also needs to pair with load_acquite -
>otherwise it doesn't work.
>
>Still, we need to do something rapidly to fix the i386 build, please
>revise right away..
>
>Jason
>
>

We share CQ (completion queue) notification flags between application
(which may be user land) and producer (kernel QP's (queue pairs)).
Those flags can be written by both application and QP's. The application
writes those flags to let the driver know if it shall inform about new
work completions. It can write those flags at any time.
Only a kernel producer reads those flags to decide if
the CQ notification handler shall be kicked, if a new CQ element gets
added to the CQ. When kicking the completion handler, the driver resets the
notification flag, which must get re-armed by the application.

We use READ_ONCE() and WRITE_ONCE(), since the flags are potentially
shared (mmap'd) between user and kernel land.

siw_req_notify_cq() is being called only by kernel consumers to change
(write) the CQ notification state. We use smp_store_mb() to make sure
the new value becomes visible to all kernel producers (QP's) asap.


From cfb861a09dcfb24a98ba0f1e26bdaa1529d1b006 Mon Sep 17 00:00:00 2001
From: Bernard Metzler <bmt@zurich.ibm.com>
Date: Fri, 12 Jul 2019 13:19:27 +0200
Subject: [PATCH] Make shared CQ notification flags 32bit to respect 32bit
 architectures

Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/siw.h       |  2 +-
 drivers/infiniband/sw/siw/siw_qp.c    | 12 ++++++++----
 drivers/infiniband/sw/siw/siw_verbs.c | 20 +++++++++++++++-----
 include/uapi/rdma/siw-abi.h           |  3 ++-
 4 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index 409e2987cd45..d59d81f4d86b 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -216,7 +216,7 @@ struct siw_wqe {
 struct siw_cq {
 struct ib_cq base_cq;
 	spinlock_t lock;
-	u64 *notify;
+	struct siw_cq_ctrl *notify;
 	struct siw_cqe *queue;
 	u32 cq_put;
 	u32 cq_get;
diff --git a/drivers/infiniband/sw/siw/siw_qp.c b/drivers/infiniband/sw/siw/siw_qp.c
index 83e50fe8e48b..f4b8d55839a7 100644
--- a/drivers/infiniband/sw/siw/siw_qp.c
+++ b/drivers/infiniband/sw/siw/siw_qp.c
@@ -1011,18 +1011,22 @@ int siw_activate_tx(struct siw_qp *qp)
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
+		 * dis-arm CQ: write (potentially user land)
+		 * application shared notification state.
+		 */
+		WRITE_ONCE(cq->notify->flags, SIW_NOTIFY_NOT);
 
 		return true;
 	}
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index d4fb78780765..cda92e4c7cc9 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -1049,7 +1049,7 @@ int siw_create_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,

 	spin_lock_init(&cq->lock);
 
-	cq->notify = &((struct siw_cq_ctrl *)&cq->queue[size])->notify;
+	cq->notify = (struct siw_cq_ctrl *)&cq->queue[size];

 	if (udata) {
 		struct siw_uresp_create_cq uresp = {};
@@ -1131,6 +1131,10 @@ int siw_poll_cq(struct ib_cq *base_cq, int num_cqe, struct ib_wc *wc)
  *   number of not reaped CQE's regardless of its notification
  *   type and current or new CQ notification settings.
  *
+ * This function gets called only by kernel consumers.
+ * Notification state must immediately become visible to all
+ * associated kernel producers (QP's).
+ *
  * @base_cq:   Base CQ contained in siw CQ.
  * @flags:     Requested notification flags.
  */
@@ -1141,11 +1145,17 @@ int siw_req_notify_cq(struct ib_cq *base_cq, enum ib_cq_notify_flags flags)
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
index ba4d5315cb76..93298980d3a7 100644
--- a/include/uapi/rdma/siw-abi.h
+++ b/include/uapi/rdma/siw-abi.h
@@ -178,6 +178,7 @@ struct siw_cqe {
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



