Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88B3C66BA6
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 13:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfGLLd4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 12 Jul 2019 07:33:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48892 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726254AbfGLLd4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 12 Jul 2019 07:33:56 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6CBX0KK087320
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jul 2019 07:33:54 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.112])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tps488up5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jul 2019 07:33:54 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 12 Jul 2019 11:33:54 -0000
Received: from us1b3-smtp06.a3dr.sjc01.isc4sb.com (10.122.203.184)
        by smtp.notes.na.collabserv.com (10.122.47.54) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 12 Jul 2019 11:33:47 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp06.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019071211334723-334113 ;
          Fri, 12 Jul 2019 11:33:47 +0000 
In-Reply-To: <20190712085212.3901785-1-arnd@arndb.de>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Doug Ledford" <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Jason Gunthorpe" <jgg@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 12 Jul 2019 11:33:46 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190712085212.3901785-1-arnd@arndb.de>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-KeepSent: 05C1A780:433E36D1-00258435:003381DA;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 50775
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19071211-4615-0000-0000-000000060386
X-IBM-SpamModules-Scores: BY=0.030803; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.000012
X-IBM-SpamModules-Versions: BY=3.00011414; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01231072; UDB=6.00648485; IPR=6.01012357;
 MB=3.00027690; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-12 11:33:52
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-07-12 09:42:48 - 6.00010155
x-cbparentid: 19071211-4616-0000-0000-0000000A0372
Message-Id: <OF05C1A780.433E36D1-ON00258435.003381DA-00258435.003F847E@notes.na.collabserv.com>
Subject: Re:  [PATCH] rdma/siw: avoid smp_store_mb() on a u64
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-12_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Arnd Bergmann" <arnd@arndb.de> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>, "Doug Ledford"
><dledford@redhat.com>, "Jason Gunthorpe" <jgg@ziepe.ca>
>From: "Arnd Bergmann" <arnd@arndb.de>
>Date: 07/12/2019 10:52AM
>Cc: "Arnd Bergmann" <arnd@arndb.de>, "Peter Zijlstra"
><peterz@infradead.org>, "Jason Gunthorpe" <jgg@mellanox.com>,
>linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
>Subject: [EXTERNAL] [PATCH] rdma/siw: avoid smp_store_mb() on a u64
>
>The new siw driver fails to build on i386 with
>
>drivers/infiniband/sw/siw/siw_qp.c:1025:3: error: invalid output size
>for constraint '+q'
>                smp_store_mb(*cq->notify, SIW_NOTIFY_NOT);
>                ^
>include/asm-generic/barrier.h:141:35: note: expanded from macro
>'smp_store_mb'
> #define smp_store_mb(var, value)  __smp_store_mb(var, value)
>                                  ^
>arch/x86/include/asm/barrier.h:65:47: note: expanded from macro
>'__smp_store_mb'
> #define __smp_store_mb(var, value) do { (void)xchg(&var, value); }
>while (0)
>                                              ^
>include/asm-generic/atomic-instrumented.h:1648:2: note: expanded from
>macro 'xchg'
>        arch_xchg(__ai_ptr, __VA_ARGS__);
>  \
>        ^
>arch/x86/include/asm/cmpxchg.h:78:27: note: expanded from macro
>'arch_xchg'
> #define arch_xchg(ptr, v)       __xchg_op((ptr), (v), xchg, "")
>                                ^
>arch/x86/include/asm/cmpxchg.h:48:19: note: expanded from macro
>'__xchg_op'
>                                      : "+q" (__ret), "+m" (*(ptr))
>  \
>                                              ^
>drivers/infiniband/sw/siw/siw_qp.o: In function `siw_sqe_complete':
>siw_qp.c:(.text+0x1450): undefined reference to `__xchg_wrong_size'
>drivers/infiniband/sw/siw/siw_qp.o: In function `siw_rqe_complete':
>siw_qp.c:(.text+0x15b0): undefined reference to `__xchg_wrong_size'
>drivers/infiniband/sw/siw/siw_verbs.o: In function
>`siw_req_notify_cq':
>siw_verbs.c:(.text+0x18ff): undefined reference to
>`__xchg_wrong_size'
>
>Since smp_store_mb() has to be an atomic store, but the architecture
>can only do this on 32-bit quantities or smaller, but 'cq->notify'
>is a 64-bit word.
>
>Apparently the smp_store_mb() is paired with a READ_ONCE() here,
>which
>seems like an odd choice because there is only a barrier on the
>writer
>side and not the reader, and READ_ONCE() is already not atomic on
>quantities larger than a CPU register.
>
>I suspect it is sufficient to use the (possibly nonatomic)
>WRITE_ONCE()
>and an SMP memory barrier here. If it does need to be atomic as well
>as 64-bit quantities, using an
>atomic64_set_release()/atomic64_read_acquire()
>may be a better choice.
>
>Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
>Fixes: f29dd55b0236 ("rdma/siw: queue pair methods")
>Cc: Peter Zijlstra <peterz@infradead.org>
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>---
> drivers/infiniband/sw/siw/siw_qp.c    | 4 +++-
> drivers/infiniband/sw/siw/siw_verbs.c | 5 +++--
> 2 files changed, 6 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw_qp.c
>b/drivers/infiniband/sw/siw/siw_qp.c
>index 11383d9f95ef..a2c08f17f13d 100644
>--- a/drivers/infiniband/sw/siw/siw_qp.c
>+++ b/drivers/infiniband/sw/siw/siw_qp.c
>@@ -1016,13 +1016,15 @@ static bool siw_cq_notify_now(struct siw_cq
>*cq, u32 flags)
> 	if (!cq->base_cq.comp_handler)
> 		return false;
> 
>+	smp_rmb();
> 	cq_notify = READ_ONCE(*cq->notify);
> 
> 	if ((cq_notify & SIW_NOTIFY_NEXT_COMPLETION) ||
> 	    ((cq_notify & SIW_NOTIFY_SOLICITED) &&
> 	     (flags & SIW_WQE_SOLICITED))) {
> 		/* dis-arm CQ */
>-		smp_store_mb(*cq->notify, SIW_NOTIFY_NOT);
>+		WRITE_ONCE(*cq->notify, SIW_NOTIFY_NOT);
>+		smp_wmb();
> 
> 		return true;
> 	}
>diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
>b/drivers/infiniband/sw/siw/siw_verbs.c
>index 32dc79d0e898..41c5ab293fe1 100644
>--- a/drivers/infiniband/sw/siw/siw_verbs.c
>+++ b/drivers/infiniband/sw/siw/siw_verbs.c
>@@ -1142,10 +1142,11 @@ int siw_req_notify_cq(struct ib_cq *base_cq,
>enum ib_cq_notify_flags flags)
> 
> 	if ((flags & IB_CQ_SOLICITED_MASK) == IB_CQ_SOLICITED)
> 		/* CQ event for next solicited completion */
>-		smp_store_mb(*cq->notify, SIW_NOTIFY_SOLICITED);
>+		WRITE_ONCE(*cq->notify, SIW_NOTIFY_SOLICITED);
> 	else
> 		/* CQ event for any signalled completion */
>-		smp_store_mb(*cq->notify, SIW_NOTIFY_ALL);
>+		WRITE_ONCE(*cq->notify, SIW_NOTIFY_ALL);
>+	smp_wmb();
> 
> 	if (flags & IB_CQ_REPORT_MISSED_EVENTS)
> 		return cq->cq_put - cq->cq_get;
>-- 
>2.20.0
>
>


Hi Arnd,
Many thanks for pointing that out! Indeed, this CQ notification
mechanism does not take 32 bit architectures into account.
Since we have only three flags to hold here, it's probably better
to make it a 32bit value. That would remove the issue w/o
introducing extra smp_wmb(). I'd prefer smp_store_mb(),
since on some architectures it shall be more efficient.
That would also make it sufficient to use READ_ONCE. 

That would be the proposed fix:

From c7c3e2dbc3555581be52cb5d76c15726dced0331 Mon Sep 17 00:00:00 2001
From: Bernard Metzler <bmt@zurich.ibm.com>
Date: Fri, 12 Jul 2019 13:19:27 +0200
Subject: [PATCH] Make shared CQ notification flags 32bit to respect 32bit
 architectures

Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/siw.h       | 2 +-
 drivers/infiniband/sw/siw/siw_qp.c    | 6 +++---
 drivers/infiniband/sw/siw/siw_verbs.c | 6 +++---
 include/uapi/rdma/siw-abi.h           | 3 ++-
 4 files changed, 9 insertions(+), 8 deletions(-)

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
index 83e50fe8e48b..0fcc5002d2da 100644
--- a/drivers/infiniband/sw/siw/siw_qp.c
+++ b/drivers/infiniband/sw/siw/siw_qp.c
@@ -1011,18 +1011,18 @@ int siw_activate_tx(struct siw_qp *qp)
  */
 static bool siw_cq_notify_now(struct siw_cq *cq, u32 flags)
 {
-	u64 cq_notify;
+	u32 cq_notify;
 
 	if (!cq->base_cq.comp_handler)
 		return false;
 
-	cq_notify = READ_ONCE(*cq->notify);
+	cq_notify = READ_ONCE(cq->notify->flags);
 
 	if ((cq_notify & SIW_NOTIFY_NEXT_COMPLETION) ||
 	    ((cq_notify & SIW_NOTIFY_SOLICITED) &&
 	     (flags & SIW_WQE_SOLICITED))) {
 		/* dis-arm CQ */
-		smp_store_mb(*cq->notify, SIW_NOTIFY_NOT);
+		smp_store_mb(cq->notify->flags, SIW_NOTIFY_NOT);
 
 		return true;
 	}
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index d4fb78780765..bc6892229af0 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -1049,7 +1049,7 @@ int siw_create_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
 
 	spin_lock_init(&cq->lock);
 
-	cq->notify = &((struct siw_cq_ctrl *)&cq->queue[size])->notify;
+	cq->notify = (struct siw_cq_ctrl *)&cq->queue[size];
 
 	if (udata) {
 		struct siw_uresp_create_cq uresp = {};
@@ -1142,10 +1142,10 @@ int siw_req_notify_cq(struct ib_cq *base_cq, enum ib_cq_notify_flags flags)
 
 	if ((flags & IB_CQ_SOLICITED_MASK) == IB_CQ_SOLICITED)
 		/* CQ event for next solicited completion */
-		smp_store_mb(*cq->notify, SIW_NOTIFY_SOLICITED);
+		smp_store_mb(cq->notify->flags, SIW_NOTIFY_SOLICITED);
 	else
 		/* CQ event for any signalled completion */
-		smp_store_mb(*cq->notify, SIW_NOTIFY_ALL);
+	smp_store_mb(cq->notify->flags, SIW_NOTIFY_ALL);
 
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


