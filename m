Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65BF3A365A
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2019 14:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfH3MIG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 30 Aug 2019 08:08:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12992 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727726AbfH3MIF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 30 Aug 2019 08:08:05 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7UC2sIY038174
        for <linux-rdma@vger.kernel.org>; Fri, 30 Aug 2019 08:08:02 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.119])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uq2s89vp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 30 Aug 2019 08:08:02 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 30 Aug 2019 12:08:01 -0000
Received: from us1b3-smtp08.a3dr.sjc01.isc4sb.com (10.122.203.190)
        by smtp.notes.na.collabserv.com (10.122.182.123) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 30 Aug 2019 12:07:52 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp08.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019083012075193-316989 ;
          Fri, 30 Aug 2019 12:07:51 +0000 
In-Reply-To: <20190827132846.9142-5-michal.kalderon@marvell.com>
Subject: Re: [PATCH v8 rdma-next 4/7] RDMA/siw: Use the common mmap_xa helpers
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Michal Kalderon" <michal.kalderon@marvell.com>
Cc:     <mkalderon@marvell.com>, <aelior@marvell.com>, <jgg@ziepe.ca>,
        <dledford@redhat.com>, <galpress@amazon.com>, <sleybo@amazon.com>,
        <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        "Ariel Elior" <ariel.elior@marvell.com>
Date:   Fri, 30 Aug 2019 12:07:51 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190827132846.9142-5-michal.kalderon@marvell.com>,<20190827132846.9142-1-michal.kalderon@marvell.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP57 August 05, 2019 at 12:42
X-KeepSent: ED447099:CC1C35E8-00258466:003FD3A8;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 27555
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19083012-3975-0000-0000-0000003D1849
X-IBM-SpamModules-Scores: BY=0.045472; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.035428
X-IBM-SpamModules-Versions: BY=3.00011684; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01254222; UDB=6.00662494; IPR=6.01035842;
 MB=3.00028390; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-30 12:07:58
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-08-30 10:49:47 - 6.00010348
x-cbparentid: 19083012-3976-0000-0000-000000621991
Message-Id: <OFED447099.CC1C35E8-ON00258466.003FD3A8-00258466.0042A33D@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-30_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Michal Kalderon" <michal.kalderon@marvell.com> wrote: -----

Hi Michael,

I tried this patch. It unfortunately panics immediately
when siw gets used. I'll investigate further. Some comments in line.

Thanks
Bernard.

>To: <mkalderon@marvell.com>, <aelior@marvell.com>, <jgg@ziepe.ca>,
><dledford@redhat.com>, <bmt@zurich.ibm.com>, <galpress@amazon.com>,
><sleybo@amazon.com>, <leon@kernel.org>
>From: "Michal Kalderon" <michal.kalderon@marvell.com>
>Date: 08/27/2019 03:31PM
>Cc: <linux-rdma@vger.kernel.org>, "Michal Kalderon"
><michal.kalderon@marvell.com>, "Ariel Elior"
><ariel.elior@marvell.com>
>Subject: [EXTERNAL] [PATCH v8 rdma-next 4/7] RDMA/siw: Use the common
>mmap_xa helpers
>
>Remove the functions related to managing the mmap_xa database.
>This code is now common in ib_core. Use the common API's instead.
>
>Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
>Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
>---
> drivers/infiniband/sw/siw/siw.h       |  20 ++-
> drivers/infiniband/sw/siw/siw_main.c  |   1 +
> drivers/infiniband/sw/siw/siw_verbs.c | 223
>+++++++++++++++++++---------------
> drivers/infiniband/sw/siw/siw_verbs.h |   1 +
> 4 files changed, 144 insertions(+), 101 deletions(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw.h
>b/drivers/infiniband/sw/siw/siw.h
>index 77b1aabf6ff3..d48cd42ae43e 100644
>--- a/drivers/infiniband/sw/siw/siw.h
>+++ b/drivers/infiniband/sw/siw/siw.h
>@@ -220,7 +220,7 @@ struct siw_cq {
> 	u32 cq_get;
> 	u32 num_cqe;
> 	bool kernel_verbs;
>-	u32 xa_cq_index; /* mmap information for CQE array */
>+	u64 cq_key; /* mmap information for CQE array */
> 	u32 id; /* For debugging only */
> };
> 
>@@ -263,7 +263,7 @@ struct siw_srq {
> 	u32 rq_put;
> 	u32 rq_get;
> 	u32 num_rqe; /* max # of wqe's allowed */
>-	u32 xa_srq_index; /* mmap information for SRQ array */
>+	u64 srq_key; /* mmap information for SRQ array */
> 	char armed; /* inform user if limit hit */
> 	char kernel_verbs; /* '1' if kernel client */
> };
>@@ -477,8 +477,8 @@ struct siw_qp {
> 		u8 layer : 4, etype : 4;
> 		u8 ecode;
> 	} term_info;
>-	u32 xa_sq_index; /* mmap information for SQE array */
>-	u32 xa_rq_index; /* mmap information for RQE array */
>+	u64 sq_key; /* mmap information for SQE array */
>+	u64 rq_key; /* mmap information for RQE array */
> 	struct rcu_head rcu;
> };
> 
>@@ -503,6 +503,12 @@ struct iwarp_msg_info {
> 	int (*rx_data)(struct siw_qp *qp);
> };
> 
>+struct siw_user_mmap_entry {
>+	struct rdma_user_mmap_entry rdma_entry;
>+	u64 address;
>+	u64 length;

This unsigned 64 range for an mmap length seems to be quite
ambitious. I do not expect we are mmapping objects of
that size. That range would be also not supported by 32bit
architectures  - a user cannot mmap more than size_t.
So size_t might be more appropriate? This throughout
all the proposed mmap_xa helpers.

>+};
>+
> /* Global siw parameters. Currently set in siw_main.c */
> extern const bool zcopy_tx;
> extern const bool try_gso;
>@@ -607,6 +613,12 @@ static inline struct siw_mr *to_siw_mr(struct
>ib_mr *base_mr)
> 	return container_of(base_mr, struct siw_mr, base_mr);
> }
> 
>+static inline struct siw_user_mmap_entry *
>+to_siw_mmap_entry(struct rdma_user_mmap_entry *rdma_mmap)
>+{
>+	return container_of(rdma_mmap, struct siw_user_mmap_entry,
>rdma_entry);
>+}
>+
> static inline struct siw_qp *siw_qp_id2obj(struct siw_device *sdev,
>int id)
> {
> 	struct siw_qp *qp;
>diff --git a/drivers/infiniband/sw/siw/siw_main.c
>b/drivers/infiniband/sw/siw/siw_main.c
>index 05a92f997f60..46c0bb59489d 100644
>--- a/drivers/infiniband/sw/siw/siw_main.c
>+++ b/drivers/infiniband/sw/siw/siw_main.c
>@@ -298,6 +298,7 @@ static const struct ib_device_ops siw_device_ops
>= {
> 	.iw_rem_ref = siw_qp_put_ref,
> 	.map_mr_sg = siw_map_mr_sg,
> 	.mmap = siw_mmap,
>+	.mmap_free = siw_mmap_free,
> 	.modify_qp = siw_verbs_modify_qp,
> 	.modify_srq = siw_modify_srq,
> 	.poll_cq = siw_poll_cq,
>diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
>b/drivers/infiniband/sw/siw/siw_verbs.c
>index 03176a3d1e18..9e049241051e 100644
>--- a/drivers/infiniband/sw/siw/siw_verbs.c
>+++ b/drivers/infiniband/sw/siw/siw_verbs.c
>@@ -34,44 +34,21 @@ static char ib_qp_state_to_string[IB_QPS_ERR +
>1][sizeof("RESET")] = {
> 	[IB_QPS_ERR] = "ERR"
> };
> 
>-static u32 siw_create_uobj(struct siw_ucontext *uctx, void *vaddr,
>u32 size)
>+void siw_mmap_free(struct rdma_user_mmap_entry *rdma_entry)
> {
>-	struct siw_uobj *uobj;
>-	struct xa_limit limit = XA_LIMIT(0, SIW_UOBJ_MAX_KEY);
>-	u32 key;
>+	struct siw_user_mmap_entry *entry = to_siw_mmap_entry(rdma_entry);
> 
>-	uobj = kzalloc(sizeof(*uobj), GFP_KERNEL);
>-	if (!uobj)
>-		return SIW_INVAL_UOBJ_KEY;
>-
>-	if (xa_alloc_cyclic(&uctx->xa, &key, uobj, limit,
>&uctx->uobj_nextkey,
>-			    GFP_KERNEL) < 0) {
>-		kfree(uobj);
>-		return SIW_INVAL_UOBJ_KEY;
>-	}
>-	uobj->size = PAGE_ALIGN(size);
>-	uobj->addr = vaddr;
>-
>-	return key;
>-}
>-
>-static struct siw_uobj *siw_get_uobj(struct siw_ucontext *uctx,
>-				     unsigned long off, u32 size)
>-{
>-	struct siw_uobj *uobj = xa_load(&uctx->xa, off);
>-
>-	if (uobj && uobj->size == size)
>-		return uobj;
>-
>-	return NULL;
>+	vfree((void *)entry->address);
>+	kfree(entry);
> }
> 
> int siw_mmap(struct ib_ucontext *ctx, struct vm_area_struct *vma)
> {
> 	struct siw_ucontext *uctx = to_siw_ctx(ctx);
>-	struct siw_uobj *uobj;
>-	unsigned long off = vma->vm_pgoff;
>+	unsigned long off = vma->vm_pgoff << PAGE_SHIFT;
>+	struct rdma_user_mmap_entry *rdma_entry;
> 	int size = vma->vm_end - vma->vm_start;
>+	struct siw_user_mmap_entry *entry;
> 	int rv = -EINVAL;
> 
> 	/*
>@@ -81,15 +58,26 @@ int siw_mmap(struct ib_ucontext *ctx, struct
>vm_area_struct *vma)
> 		pr_warn("siw: mmap not page aligned\n");
> 		goto out;
> 	}
>-	uobj = siw_get_uobj(uctx, off, size);
>-	if (!uobj) {
>+	rdma_entry = rdma_user_mmap_entry_get(&uctx->base_ucontext, off,
>+					      size, vma);
>+	if (!rdma_entry) {
> 		siw_dbg(&uctx->sdev->base_dev, "mmap lookup failed: %lu, %u\n",
> 			off, size);
> 		goto out;
> 	}
>-	rv = remap_vmalloc_range(vma, uobj->addr, 0);
>-	if (rv)
>+	entry = to_siw_mmap_entry(rdma_entry);
>+	if (entry->length != size) {
>+		siw_dbg(&uctx->sdev->base_dev,
>+			"key[%#lx] does not have valid length[%#x] expected[%#llx]\n",
>+			off, size, entry->length);
>+		return -EINVAL;
>+	}
>+
>+	rv = remap_vmalloc_range(vma, (void *)entry->address, 0);
>+	if (rv) {
> 		pr_warn("remap_vmalloc_range failed: %lu, %u\n", off, size);
>+		rdma_user_mmap_entry_put(&uctx->base_ucontext, rdma_entry);
>+	}
> out:
> 	return rv;
> }
>@@ -105,7 +93,7 @@ int siw_alloc_ucontext(struct ib_ucontext
>*base_ctx, struct ib_udata *udata)
> 		rv = -ENOMEM;
> 		goto err_out;
> 	}
>-	xa_init_flags(&ctx->xa, XA_FLAGS_ALLOC);
>+
> 	ctx->uobj_nextkey = 0;
> 	ctx->sdev = sdev;
> 
>@@ -135,19 +123,7 @@ int siw_alloc_ucontext(struct ib_ucontext
>*base_ctx, struct ib_udata *udata)
> void siw_dealloc_ucontext(struct ib_ucontext *base_ctx)
> {
> 	struct siw_ucontext *uctx = to_siw_ctx(base_ctx);
>-	void *entry;
>-	unsigned long index;
> 
>-	/*
>-	 * Make sure all user mmap objects are gone. Since QP, CQ
>-	 * and SRQ destroy routines destroy related objects, nothing
>-	 * should be found here.
>-	 */
>-	xa_for_each(&uctx->xa, index, entry) {
>-		kfree(xa_erase(&uctx->xa, index));
>-		pr_warn("siw: dropping orphaned uobj at %lu\n", index);
>-	}
>-	xa_destroy(&uctx->xa);
> 	atomic_dec(&uctx->sdev->num_ctx);
> }
> 
>@@ -293,6 +269,28 @@ void siw_qp_put_ref(struct ib_qp *base_qp)
> 	siw_qp_put(to_siw_qp(base_qp));
> }
> 
>+static int siw_user_mmap_entry_insert(struct ib_ucontext *ucontext,
>+				      u64 address, u64 length,
>+				      u64 *key)
>+{
>+	struct siw_user_mmap_entry *entry = kzalloc(sizeof(*entry),
>GFP_KERNEL);
>+
>+	if (!entry)
>+		return -ENOMEM;
>+
>+	entry->address = address;
>+	entry->length = length;
>+
>+	*key = rdma_user_mmap_entry_insert(ucontext, &entry->rdma_entry,
>+					   length);
>+	if (*key == RDMA_USER_MMAP_INVALID) {
>+		kfree(entry);
>+		return -ENOMEM;
>+	}
>+
>+	return 0;
>+}
>+
> /*
>  * siw_create_qp()
>  *
>@@ -317,6 +315,8 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
> 	struct siw_cq *scq = NULL, *rcq = NULL;
> 	unsigned long flags;
> 	int num_sqe, num_rqe, rv = 0;
>+	u64 length;
>+	u64 key;
> 
> 	siw_dbg(base_dev, "create new QP\n");
> 
>@@ -380,8 +380,8 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
> 	spin_lock_init(&qp->orq_lock);
> 
> 	qp->kernel_verbs = !udata;
>-	qp->xa_sq_index = SIW_INVAL_UOBJ_KEY;
>-	qp->xa_rq_index = SIW_INVAL_UOBJ_KEY;
>+	qp->sq_key = RDMA_USER_MMAP_INVALID;
>+	qp->rq_key = RDMA_USER_MMAP_INVALID;
> 
> 	rv = siw_qp_add(sdev, qp);
> 	if (rv)
>@@ -459,26 +459,41 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
> 		uresp.qp_id = qp_id(qp);
> 
> 		if (qp->sendq) {
>-			qp->xa_sq_index =
>-				siw_create_uobj(uctx, qp->sendq,
>-					num_sqe * sizeof(struct siw_sqe));
>+			length = num_sqe * sizeof(struct siw_sqe);
>+			rv = siw_user_mmap_entry_insert(&uctx->base_ucontext,
>+							(uintptr_t)qp->sendq,
>+							length, &key);
>+			if (!rv)

Shall be 'if (rv)'
The new 'siw_user_mmap_entry_insert()' seem to return zero
for success. Same issue afrer all other invocations of
siw_user_mmap_entry_insert() further down in that file.

>+				goto err_out_xa;
>+
>+			/* If entry was inserted successfully, qp->sendq
>+			 * will be freed by siw_mmap_free
>+			 */
>+			qp->sendq = NULL;

qp->sendq points to the SQ array. Zeroing this pointer will leave
siw with no idea where the WQE's are. It will panic de-referencing
[NULL + current position in ring buffer]. Same for RQ, SRQ and CQ.

 
>+			qp->sq_key = key;
> 		}
>+
> 		if (qp->recvq) {
>-			qp->xa_rq_index =
>-				 siw_create_uobj(uctx, qp->recvq,
>-					num_rqe * sizeof(struct siw_rqe));
>-		}
>-		if (qp->xa_sq_index == SIW_INVAL_UOBJ_KEY ||
>-		    qp->xa_rq_index == SIW_INVAL_UOBJ_KEY) {
>-			rv = -ENOMEM;
>-			goto err_out_xa;
>+			length = num_rqe * sizeof(struct siw_rqe);
>+			rv = siw_user_mmap_entry_insert(&uctx->base_ucontext,
>+							(uintptr_t)qp->recvq,
>+							length, &key);
>+			if (!rv)
>+				goto err_out_mmap_rem;
>+
>+			/* If entry was inserted successfully, qp->recvq will
>+			 * be freed by siw_mmap_free
>+			 */
>+			qp->recvq = NULL;

see above

>+			qp->rq_key = key;
> 		}
>-		uresp.sq_key = qp->xa_sq_index << PAGE_SHIFT;
>-		uresp.rq_key = qp->xa_rq_index << PAGE_SHIFT;

Changes here would require changes to the siw user lib

>+
>+		uresp.sq_key = qp->sq_key;
>+		uresp.rq_key = qp->rq_key;
> 
> 		if (udata->outlen < sizeof(uresp)) {
> 			rv = -EINVAL;
>-			goto err_out_xa;
>+			goto err_out_mmap_rem;
> 		}
> 		rv = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
> 		if (rv)
>@@ -496,21 +511,23 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
> 
> 	return qp->ib_qp;
> 
>+err_out_mmap_rem:
>+	if (udata) {
>+		rdma_user_mmap_entry_remove(&uctx->base_ucontext, qp->sq_key);
>+		rdma_user_mmap_entry_remove(&uctx->base_ucontext, qp->rq_key);
>+	}
>+
> err_out_xa:
> 	xa_erase(&sdev->qp_xa, qp_id(qp));
> err_out:
> 	kfree(siw_base_qp);
> 
> 	if (qp) {
>-		if (qp->xa_sq_index != SIW_INVAL_UOBJ_KEY)
>-			kfree(xa_erase(&uctx->xa, qp->xa_sq_index));
>-		if (qp->xa_rq_index != SIW_INVAL_UOBJ_KEY)
>-			kfree(xa_erase(&uctx->xa, qp->xa_rq_index));
>-
> 		vfree(qp->sendq);
> 		vfree(qp->recvq);
> 		kfree(qp);
> 	}
>+
> 	atomic_dec(&sdev->num_qp);
> 
> 	return ERR_PTR(rv);
>@@ -620,10 +637,10 @@ int siw_destroy_qp(struct ib_qp *base_qp,
>struct ib_udata *udata)
> 	qp->attrs.flags |= SIW_QP_IN_DESTROY;
> 	qp->rx_stream.rx_suspend = 1;
> 
>-	if (uctx && qp->xa_sq_index != SIW_INVAL_UOBJ_KEY)
>-		kfree(xa_erase(&uctx->xa, qp->xa_sq_index));
>-	if (uctx && qp->xa_rq_index != SIW_INVAL_UOBJ_KEY)
>-		kfree(xa_erase(&uctx->xa, qp->xa_rq_index));
>+	if (uctx) {
>+		rdma_user_mmap_entry_remove(&uctx->base_ucontext, qp->sq_key);
>+		rdma_user_mmap_entry_remove(&uctx->base_ucontext, qp->rq_key);
>+	}
> 
> 	down_write(&qp->state_lock);
> 
>@@ -993,8 +1010,8 @@ void siw_destroy_cq(struct ib_cq *base_cq,
>struct ib_udata *udata)
> 
> 	siw_cq_flush(cq);
> 
>-	if (ctx && cq->xa_cq_index != SIW_INVAL_UOBJ_KEY)
>-		kfree(xa_erase(&ctx->xa, cq->xa_cq_index));
>+	if (ctx)
>+		rdma_user_mmap_entry_remove(&ctx->base_ucontext, cq->cq_key);
> 
> 	atomic_dec(&sdev->num_cq);
> 
>@@ -1031,7 +1048,7 @@ int siw_create_cq(struct ib_cq *base_cq, const
>struct ib_cq_init_attr *attr,
> 	size = roundup_pow_of_two(size);
> 	cq->base_cq.cqe = size;
> 	cq->num_cqe = size;
>-	cq->xa_cq_index = SIW_INVAL_UOBJ_KEY;
>+	cq->cq_key = RDMA_USER_MMAP_INVALID;
> 
> 	if (!udata) {
> 		cq->kernel_verbs = 1;
>@@ -1057,16 +1074,21 @@ int siw_create_cq(struct ib_cq *base_cq,
>const struct ib_cq_init_attr *attr,
> 		struct siw_ucontext *ctx =
> 			rdma_udata_to_drv_context(udata, struct siw_ucontext,
> 						  base_ucontext);
>+		u64 length = size * sizeof(struct siw_cqe) +
>+			     sizeof(struct siw_cq_ctrl);
> 
>-		cq->xa_cq_index =
>-			siw_create_uobj(ctx, cq->queue,
>-					size * sizeof(struct siw_cqe) +
>-						sizeof(struct siw_cq_ctrl));
>-		if (cq->xa_cq_index == SIW_INVAL_UOBJ_KEY) {
>-			rv = -ENOMEM;
>+		rv = siw_user_mmap_entry_insert(&ctx->base_ucontext,
>+						(uintptr_t)cq->queue,
>+						length, &cq->cq_key);
>+		if (!rv)

if (rv)
> 			goto err_out;
>-		}
>-		uresp.cq_key = cq->xa_cq_index << PAGE_SHIFT;
>+
>+		/* If entry was inserted successfully, cq->queue will be freed
>+		 * by siw_mmap_free
>+		 */
>+		cq->queue = NULL;

causes panic
>+
>+		uresp.cq_key = cq->cq_key;
> 		uresp.cq_id = cq->id;
> 		uresp.num_cqe = size;
> 
>@@ -1087,8 +1109,9 @@ int siw_create_cq(struct ib_cq *base_cq, const
>struct ib_cq_init_attr *attr,
> 		struct siw_ucontext *ctx =
> 			rdma_udata_to_drv_context(udata, struct siw_ucontext,
> 						  base_ucontext);
>-		if (cq->xa_cq_index != SIW_INVAL_UOBJ_KEY)
>-			kfree(xa_erase(&ctx->xa, cq->xa_cq_index));
>+		if (udata)
>+			rdma_user_mmap_entry_remove(&ctx->base_ucontext,
>+						    cq->cq_key);
> 		vfree(cq->queue);
> 	}
> 	atomic_dec(&sdev->num_cq);
>@@ -1490,7 +1513,7 @@ int siw_create_srq(struct ib_srq *base_srq,
> 	}
> 	srq->max_sge = attrs->max_sge;
> 	srq->num_rqe = roundup_pow_of_two(attrs->max_wr);
>-	srq->xa_srq_index = SIW_INVAL_UOBJ_KEY;
>+	srq->srq_key = RDMA_USER_MMAP_INVALID;
> 	srq->limit = attrs->srq_limit;
> 	if (srq->limit)
> 		srq->armed = 1;
>@@ -1509,15 +1532,19 @@ int siw_create_srq(struct ib_srq *base_srq,
> 	}
> 	if (udata) {
> 		struct siw_uresp_create_srq uresp = {};
>+		u64 length = srq->num_rqe * sizeof(struct siw_rqe);
> 
>-		srq->xa_srq_index = siw_create_uobj(
>-			ctx, srq->recvq, srq->num_rqe * sizeof(struct siw_rqe));
>-
>-		if (srq->xa_srq_index == SIW_INVAL_UOBJ_KEY) {
>-			rv = -ENOMEM;
>+		rv = siw_user_mmap_entry_insert(&ctx->base_ucontext,
>+						(uintptr_t)srq->recvq,
>+						length, &srq->srq_key);
>+		if (!rv)

if (rv)

> 			goto err_out;
>-		}
>-		uresp.srq_key = srq->xa_srq_index;
>+
>+		/* If entry was inserted successfully, srq->recvq will be freed
>+		 * by siw_mmap_free
>+		 */
>+		srq->recvq = NULL;

causes panic

>+		uresp.srq_key = srq->srq_key;
> 		uresp.num_rqe = srq->num_rqe;
> 
> 		if (udata->outlen < sizeof(uresp)) {
>@@ -1536,8 +1563,9 @@ int siw_create_srq(struct ib_srq *base_srq,
> 
> err_out:
> 	if (srq->recvq) {
>-		if (ctx && srq->xa_srq_index != SIW_INVAL_UOBJ_KEY)
>-			kfree(xa_erase(&ctx->xa, srq->xa_srq_index));
>+		if (udata)
>+			rdma_user_mmap_entry_remove(&ctx->base_ucontext,
>+						    srq->srq_key);
> 		vfree(srq->recvq);
> 	}
> 	atomic_dec(&sdev->num_srq);
>@@ -1623,8 +1651,9 @@ void siw_destroy_srq(struct ib_srq *base_srq,
>struct ib_udata *udata)
> 		rdma_udata_to_drv_context(udata, struct siw_ucontext,
> 					  base_ucontext);
> 
>-	if (ctx && srq->xa_srq_index != SIW_INVAL_UOBJ_KEY)
>-		kfree(xa_erase(&ctx->xa, srq->xa_srq_index));
>+	if (ctx)
>+		rdma_user_mmap_entry_remove(&ctx->base_ucontext,
>+					    srq->srq_key);
> 
> 	vfree(srq->recvq);
> 	atomic_dec(&sdev->num_srq);
>diff --git a/drivers/infiniband/sw/siw/siw_verbs.h
>b/drivers/infiniband/sw/siw/siw_verbs.h
>index 1910869281cb..1a731989fad6 100644
>--- a/drivers/infiniband/sw/siw/siw_verbs.h
>+++ b/drivers/infiniband/sw/siw/siw_verbs.h
>@@ -83,6 +83,7 @@ void siw_destroy_srq(struct ib_srq *base_srq,
>struct ib_udata *udata);
> int siw_post_srq_recv(struct ib_srq *base_srq, const struct
>ib_recv_wr *wr,
> 		      const struct ib_recv_wr **bad_wr);
> int siw_mmap(struct ib_ucontext *ctx, struct vm_area_struct *vma);
>+void siw_mmap_free(struct rdma_user_mmap_entry *rdma_entry);
> void siw_qp_event(struct siw_qp *qp, enum ib_event_type type);
> void siw_cq_event(struct siw_cq *cq, enum ib_event_type type);
> void siw_srq_event(struct siw_srq *srq, enum ib_event_type type);
>-- 
>2.14.5
>
>

