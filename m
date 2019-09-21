Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0CFB9F67
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Sep 2019 20:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387658AbfIUSfl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 21 Sep 2019 14:35:41 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:13045 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387606AbfIUSfl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 21 Sep 2019 14:35:41 -0400
Received: from localhost (budha.blr.asicdesigners.com [10.193.185.4])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x8LIZ99E028056;
        Sat, 21 Sep 2019 11:35:10 -0700
Date:   Sun, 22 Sep 2019 00:05:08 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Steve Wise <larrystevenwise@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>,
        "'Potnuri Bharat Teja'" <bharat@chelsio.com>
Subject: Re: [PATCH v3] iwcm: don't hold the irq disabled lock on iw_rem_ref
Message-ID: <20190921183507.GA1622@chelsio.com>
References: <20190904212531.6488-1-sagi@grimberg.me>
 <20190910111759.GA5472@chelsio.com>
 <5cc42f23-bf60-ca8d-f40c-cbd8875f5756@grimberg.me>
 <20190910192157.GA5954@chelsio.com>
 <OF00E4DFD9.0EEF58A6-ON00258472.0032F9AC-00258472.0034FEAA@notes.na.collabserv.com>
 <CADmRdJcCENJx==LaaJQYU_kMv5rSgD69Z6s+ubCKWjprZmPQpA@mail.gmail.com>
 <20190911155814.GA12639@chelsio.com>
 <OFAEAC1AA7.9611AF4F-ON00258478.002E162F-00258478.0031D798@notes.na.collabserv.com>
 <55ece255-b4e2-9bc4-e1ec-039d92a36273@grimberg.me>
 <20190918134324.GA5734@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918134324.GA5734@chelsio.com>
User-Agent: Mutt/1.9.3 (20180206.02d571c2)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wednesday, September 09/18/19, 2019 at 19:13:25 +0530, Krishnamraju Eraparaju wrote:
Hi,

I have restructured iw_cxgb4 driver to support the proposed iwcm
changes. Issues addressed by this patch:
-all iw_rem_ref calls from iwcm are outside the spinlock critical
section.
-fixes siw early freeing of siw_base_qp issue.
-the ib_destroy_qp for iw_cxgb4 does not block, even before CM getting
destroyed.
Currently we are testing these changes, will submit the patch next week.

PATCH:
-----
diff --git a/drivers/infiniband/core/iwcm.c
b/drivers/infiniband/core/iwcm.c
index 72141c5..7e1d834 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -372,6 +372,7 @@ int iw_cm_disconnect(struct iw_cm_id *cm_id, int
abrupt)
 static void destroy_cm_id(struct iw_cm_id *cm_id)
 {
        struct iwcm_id_private *cm_id_priv;
+       struct ib_qp *qp;
        unsigned long flags;

        cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
@@ -389,6 +390,9 @@ static void destroy_cm_id(struct iw_cm_id *cm_id)
        set_bit(IWCM_F_DROP_EVENTS, &cm_id_priv->flags);

        spin_lock_irqsave(&cm_id_priv->lock, flags);
+       qp = cm_id_priv->qp;
+       cm_id_priv->qp = NULL;
+
        switch (cm_id_priv->state) {
        case IW_CM_STATE_LISTEN:
                cm_id_priv->state = IW_CM_STATE_DESTROYING;
@@ -401,7 +405,7 @@ static void destroy_cm_id(struct iw_cm_id *cm_id)
                cm_id_priv->state = IW_CM_STATE_DESTROYING;
                spin_unlock_irqrestore(&cm_id_priv->lock, flags);
                /* Abrupt close of the connection */
-               (void)iwcm_modify_qp_err(cm_id_priv->qp);
+               (void)iwcm_modify_qp_err(qp);
                spin_lock_irqsave(&cm_id_priv->lock, flags);
                break;
        case IW_CM_STATE_IDLE:
@@ -426,11 +430,9 @@ static void destroy_cm_id(struct iw_cm_id *cm_id)
                BUG();
                break;
        }
-       if (cm_id_priv->qp) {
-               cm_id_priv->id.device->ops.iw_rem_ref(cm_id_priv->qp);
-               cm_id_priv->qp = NULL;
-       }
        spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+       if (qp)
+               cm_id_priv->id.device->ops.iw_rem_ref(qp);

        if (cm_id->mapped) {
                iwpm_remove_mapinfo(&cm_id->local_addr,
&cm_id->m_local_addr);
@@ -671,11 +673,11 @@ int iw_cm_accept(struct iw_cm_id *cm_id,
                BUG_ON(cm_id_priv->state != IW_CM_STATE_CONN_RECV);
                cm_id_priv->state = IW_CM_STATE_IDLE;
                spin_lock_irqsave(&cm_id_priv->lock, flags);
-               if (cm_id_priv->qp) {
-                       cm_id->device->ops.iw_rem_ref(qp);
-                       cm_id_priv->qp = NULL;
-               }
+               qp = cm_id_priv->qp;
+               cm_id_priv->qp = NULL;
                spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+               if (qp)
+                       cm_id->device->ops.iw_rem_ref(qp);
                clear_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags);
                wake_up_all(&cm_id_priv->connect_wait);
        }
@@ -696,7 +698,7 @@ int iw_cm_connect(struct iw_cm_id *cm_id, struct
iw_cm_conn_param *iw_param)
        struct iwcm_id_private *cm_id_priv;
        int ret;
        unsigned long flags;
-       struct ib_qp *qp;
+       struct ib_qp *qp = NULL;

        cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);

@@ -730,13 +732,13 @@ int iw_cm_connect(struct iw_cm_id *cm_id, struct
iw_cm_conn_param *iw_param)
                return 0;       /* success */

        spin_lock_irqsave(&cm_id_priv->lock, flags);
-       if (cm_id_priv->qp) {
-               cm_id->device->ops.iw_rem_ref(qp);
-               cm_id_priv->qp = NULL;
-       }
+       qp = cm_id_priv->qp;
+       cm_id_priv->qp = NULL;
        cm_id_priv->state = IW_CM_STATE_IDLE;
 err:
        spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+       if (qp)
+               cm_id->device->ops.iw_rem_ref(qp);
        clear_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags);
        wake_up_all(&cm_id_priv->connect_wait);
        return ret;
@@ -878,6 +880,7 @@ static int cm_conn_est_handler(struct
iwcm_id_private *cm_id_priv,
 static int cm_conn_rep_handler(struct iwcm_id_private *cm_id_priv,
                               struct iw_cm_event *iw_event)
 {
+       struct ib_qp *qp = NULL;
        unsigned long flags;
        int ret;

@@ -896,11 +899,13 @@ static int cm_conn_rep_handler(struct
iwcm_id_private *cm_id_priv,
                cm_id_priv->state = IW_CM_STATE_ESTABLISHED;
        } else {
                /* REJECTED or RESET */
-               cm_id_priv->id.device->ops.iw_rem_ref(cm_id_priv->qp);
+               qp = cm_id_priv->qp;
                cm_id_priv->qp = NULL;
                cm_id_priv->state = IW_CM_STATE_IDLE;
        }
        spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+       if (qp)
+               cm_id_priv->id.device->ops.iw_rem_ref(qp);
        ret = cm_id_priv->id.cm_handler(&cm_id_priv->id, iw_event);

        if (iw_event->private_data_len)
@@ -942,14 +947,13 @@ static void cm_disconnect_handler(struct
iwcm_id_private *cm_id_priv,
 static int cm_close_handler(struct iwcm_id_private *cm_id_priv,
                                  struct iw_cm_event *iw_event)
 {
+       struct ib_qp *qp;
        unsigned long flags;
        int ret = 0;
        spin_lock_irqsave(&cm_id_priv->lock, flags);
+       qp = cm_id_priv->qp;
+       cm_id_priv->qp = NULL;

-       if (cm_id_priv->qp) {
-               cm_id_priv->id.device->ops.iw_rem_ref(cm_id_priv->qp);
-               cm_id_priv->qp = NULL;
-       }
        switch (cm_id_priv->state) {
        case IW_CM_STATE_ESTABLISHED:
        case IW_CM_STATE_CLOSING:
@@ -965,6 +969,8 @@ static int cm_close_handler(struct iwcm_id_private
*cm_id_priv,
        }
        spin_unlock_irqrestore(&cm_id_priv->lock, flags);

+       if (qp)
+               cm_id_priv->id.device->ops.iw_rem_ref(qp);
        return ret;
 }

diff --git a/drivers/infiniband/hw/cxgb4/device.c
b/drivers/infiniband/hw/cxgb4/device.c
index a8b9548..330483d 100644
--- a/drivers/infiniband/hw/cxgb4/device.c
+++ b/drivers/infiniband/hw/cxgb4/device.c
@@ -747,6 +747,7 @@ void c4iw_release_dev_ucontext(struct c4iw_rdev
*rdev,
        struct list_head *pos, *nxt;
        struct c4iw_qid_list *entry;

+       wait_event(uctx->wait, refcount_read(&uctx->refcnt) == 1);
        mutex_lock(&uctx->lock);
        list_for_each_safe(pos, nxt, &uctx->qpids) {
                entry = list_entry(pos, struct c4iw_qid_list, entry);
@@ -775,6 +776,8 @@ void c4iw_init_dev_ucontext(struct c4iw_rdev *rdev,
        INIT_LIST_HEAD(&uctx->qpids);
        INIT_LIST_HEAD(&uctx->cqids);
        mutex_init(&uctx->lock);
+       init_waitqueue_head(&uctx->wait);
+       refcount_set(&uctx->refcnt, 1);
 }

 /* Caller takes care of locking if needed */
diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
index 7d06b0f..441adc6 100644
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -110,6 +110,8 @@ struct c4iw_dev_ucontext {
        struct list_head cqids;
        struct mutex lock;
        struct kref kref;
+       wait_queue_head_t wait;
+       refcount_t refcnt;
 };

 enum c4iw_rdev_flags {
@@ -490,13 +492,13 @@ struct c4iw_qp {
        struct t4_wq wq;
        spinlock_t lock;
        struct mutex mutex;
+       struct kref kref;
        wait_queue_head_t wait;
        int sq_sig_all;
        struct c4iw_srq *srq;
+       struct work_struct free_work;
        struct c4iw_ucontext *ucontext;
        struct c4iw_wr_wait *wr_waitp;
-       struct completion qp_rel_comp;
-       refcount_t qp_refcnt;
 };

 static inline struct c4iw_qp *to_c4iw_qp(struct ib_qp *ibqp)
@@ -531,6 +533,7 @@ struct c4iw_ucontext {
        spinlock_t mmap_lock;
        struct list_head mmaps;
        bool is_32b_cqe;
+       struct completion qp_comp;
 };

 static inline struct c4iw_ucontext *to_c4iw_ucontext(struct ib_ucontext
*c)
diff --git a/drivers/infiniband/hw/cxgb4/qp.c
b/drivers/infiniband/hw/cxgb4/qp.c
index eb9368b..ca61193 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -889,17 +889,44 @@ static int build_inv_stag(union t4_wr *wqe, const
struct ib_send_wr *wr,
        return 0;
 }

+static void free_qp_work(struct work_struct *work)
+{
+       struct c4iw_dev_ucontext *uctx;
+       struct c4iw_qp *qhp;
+       struct c4iw_dev *rhp;
+
+       qhp = container_of(work, struct c4iw_qp, free_work);
+       rhp = qhp->rhp;
+       uctx = qhp->ucontext ? &qhp->ucontext->uctx : &rhp->rdev.uctx;
+
+       pr_debug("qhp %p ucontext %p\n", qhp, qhp->ucontext);
+       destroy_qp(&rhp->rdev, &qhp->wq, uctx, !qhp->srq);
+
+       c4iw_put_wr_wait(qhp->wr_waitp);
+       kfree(qhp);
+       refcount_dec(&uctx->refcnt);
+       wake_up(&uctx->wait);
+}
+
+static void queue_qp_free(struct kref *kref)
+{
+       struct c4iw_qp *qhp;
+
+       qhp = container_of(kref, struct c4iw_qp, kref);
+       pr_debug("qhp %p\n", qhp);
+       queue_work(qhp->rhp->rdev.free_workq, &qhp->free_work);
+}
+
 void c4iw_qp_add_ref(struct ib_qp *qp)
 {
        pr_debug("ib_qp %p\n", qp);
-       refcount_inc(&to_c4iw_qp(qp)->qp_refcnt);
+       kref_get(&to_c4iw_qp(qp)->kref);
 }

 void c4iw_qp_rem_ref(struct ib_qp *qp)
 {
        pr_debug("ib_qp %p\n", qp);
-       if (refcount_dec_and_test(&to_c4iw_qp(qp)->qp_refcnt))
-               complete(&to_c4iw_qp(qp)->qp_rel_comp);
+       kref_put(&to_c4iw_qp(qp)->kref, queue_qp_free);
 }

 static void add_to_fc_list(struct list_head *head, struct list_head
*entry)
@@ -2071,12 +2098,10 @@ int c4iw_destroy_qp(struct ib_qp *ib_qp, struct
ib_udata *udata)
 {
        struct c4iw_dev *rhp;
        struct c4iw_qp *qhp;
-       struct c4iw_ucontext *ucontext;
        struct c4iw_qp_attributes attrs;

        qhp = to_c4iw_qp(ib_qp);
        rhp = qhp->rhp;
-       ucontext = qhp->ucontext;

        attrs.next_state = C4IW_QP_STATE_ERROR;
        if (qhp->attr.state == C4IW_QP_STATE_TERMINATE)
@@ -2094,17 +2119,7 @@ int c4iw_destroy_qp(struct ib_qp *ib_qp, struct
ib_udata *udata)

        c4iw_qp_rem_ref(ib_qp);

-       wait_for_completion(&qhp->qp_rel_comp);
-
        pr_debug("ib_qp %p qpid 0x%0x\n", ib_qp, qhp->wq.sq.qid);
-       pr_debug("qhp %p ucontext %p\n", qhp, ucontext);
-
-       destroy_qp(&rhp->rdev, &qhp->wq,
-                  ucontext ? &ucontext->uctx : &rhp->rdev.uctx,
                   !qhp->srq);
-
-       c4iw_put_wr_wait(qhp->wr_waitp);
-
-       kfree(qhp);
        return 0;
 }

@@ -2214,8 +2229,8 @@ struct ib_qp *c4iw_create_qp(struct ib_pd *pd,
struct ib_qp_init_attr *attrs,
        spin_lock_init(&qhp->lock);
        mutex_init(&qhp->mutex);
        init_waitqueue_head(&qhp->wait);
-       init_completion(&qhp->qp_rel_comp);
-       refcount_set(&qhp->qp_refcnt, 1);
+       kref_init(&qhp->kref);
+       INIT_WORK(&qhp->free_work, free_qp_work);

        ret = xa_insert_irq(&rhp->qps, qhp->wq.sq.qid, qhp, GFP_KERNEL);
        if (ret)
@@ -2335,6 +2350,8 @@ struct ib_qp *c4iw_create_qp(struct ib_pd *pd,
struct ib_qp_init_attr *attrs,
        if (attrs->srq)
                qhp->srq = to_c4iw_srq(attrs->srq);
        INIT_LIST_HEAD(&qhp->db_fc_entry);
+       refcount_inc(ucontext ? &ucontext->uctx.refcnt :
+                               &rhp->rdev.uctx.refcnt);
        pr_debug("sq id %u size %u memsize %zu num_entries %u rq id %u
size %u memsize %zu num_entries %u\n",
                 qhp->wq.sq.qid, qhp->wq.sq.size, qhp->wq.sq.memsize,
                 attrs->cap.max_send_wr, qhp->wq.rq.qid,
qhp->wq.rq.size,
diff --git a/drivers/infiniband/sw/siw/siw_qp.c
b/drivers/infiniband/sw/siw/siw_qp.c
index 0990307..743d3d2 100644
--- a/drivers/infiniband/sw/siw/siw_qp.c
+++ b/drivers/infiniband/sw/siw/siw_qp.c
@@ -1305,6 +1305,7 @@ int siw_qp_add(struct siw_device *sdev, struct
siw_qp *qp)
 void siw_free_qp(struct kref *ref)
 {
        struct siw_qp *found, *qp = container_of(ref, struct siw_qp,
ref);
+       struct siw_base_qp *siw_base_qp = to_siw_base_qp(qp->ib_qp);
        struct siw_device *sdev = qp->sdev;
        unsigned long flags;

@@ -1327,4 +1328,5 @@ void siw_free_qp(struct kref *ref)
        atomic_dec(&sdev->num_qp);
        siw_dbg_qp(qp, "free QP\n");
        kfree_rcu(qp, rcu);
+       kfree(siw_base_qp);
 }
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
b/drivers/infiniband/sw/siw/siw_verbs.c
index 03176a3..35eee3f 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -605,7 +605,6 @@ int siw_verbs_modify_qp(struct ib_qp *base_qp,
struct ib_qp_attr *attr,
 int siw_destroy_qp(struct ib_qp *base_qp, struct ib_udata *udata)
 {
        struct siw_qp *qp = to_siw_qp(base_qp);
-       struct siw_base_qp *siw_base_qp = to_siw_base_qp(base_qp);
        struct siw_ucontext *uctx =
                rdma_udata_to_drv_context(udata, struct siw_ucontext,
                                          base_ucontext);
@@ -642,7 +641,6 @@ int siw_destroy_qp(struct ib_qp *base_qp, struct
ib_udata *udata)
        qp->scq = qp->rcq = NULL;

        siw_qp_put(qp);
-       kfree(siw_base_qp);

        return 0;
 }

> On Tuesday, September 09/17/19, 2019 at 22:50:27 +0530, Sagi Grimberg wrote:
> > 
> > >> To: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
> > >> From: "Jason Gunthorpe" <jgg@ziepe.ca>
> > >> Date: 09/16/2019 06:28PM
> > >> Cc: "Steve Wise" <larrystevenwise@gmail.com>, "Bernard Metzler"
> > >> <BMT@zurich.ibm.com>, "Sagi Grimberg" <sagi@grimberg.me>,
> > >> "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
> > >> Subject: [EXTERNAL] Re: Re: [PATCH v3] iwcm: don't hold the irq
> > >> disabled lock on iw_rem_ref
> > >>
> > >> On Wed, Sep 11, 2019 at 09:28:16PM +0530, Krishnamraju Eraparaju
> > >> wrote:
> > >>> Hi Steve & Bernard,
> > >>>
> > >>> Thanks for the review comments.
> > >>> I will do those formating changes.
> > >>
> > >> I don't see anything in patchworks, but the consensus is to drop
> > >> Sagi's patch pending this future patch?
> > >>
> > >> Jason
> > >>
> > > This is my impression as well. But consensus should be
> > > explicit...Sagi, what do you think?
> > 
> > I don't really care, but given the changes from Krishnamraju cause other
> > problems I'd ask if my version is also offending his test.
> Hi Sagi,
> Your version holds good for rdma_destroy_id() path only, but there are
> other places where iw_rem_ref() is being called within spinlocks, here is
> the call trace when iw_rem_ref() is called in cm_close_handler() path:
> [  627.716339] Call Trace:
> [  627.716339]  ? load_new_mm_cr3+0xc0/0xc0
> [  627.716339]  on_each_cpu+0x23/0x40
> [  627.716339]  flush_tlb_kernel_range+0x74/0x80
> [  627.716340]  free_unmap_vmap_area+0x2a/0x40
> [  627.716340]  remove_vm_area+0x59/0x60
> [  627.716340]  __vunmap+0x46/0x210
> [  627.716340]  siw_free_qp+0x88/0x120 [siw]
> [  627.716340]  cm_work_handler+0x5b8/0xd00  <=====
> [  627.716340]  process_one_work+0x155/0x380
> [  627.716341]  worker_thread+0x41/0x3b0
> [  627.716341]  kthread+0xf3/0x130
> [  627.716341]  ? process_one_work+0x380/0x380
> [  627.716341]  ? kthread_bind+0x10/0x10
> [  627.716341]  ret_from_fork+0x35/0x40
> 
> Hence, I moved all the occurances of iw_rem_ref() outside of spinlocks
> critical section.
> > 
> > In general, I do not think that making resources free routines (both
> > explict or implicit via ref dec) under a spinlock is not a robust
> > design.
> > 
> > I would first make it clear and documented what cm_id_priv->lock is
> > protecting. In my mind, it should protect *its own* mutations of
> > cm_id_priv and by design leave all the ops calls outside the lock.
> > 
> > I don't understand what is causing the Chelsio issue observed, but
> > it looks like c4iw_destroy_qp blocks on a completion that depends on a
> > refcount that is taken also by iwcm, which means that I cannot call
> > ib_destroy_qp if the cm is not destroyed as well?
> > 
> > If that is madatory, I'd say that instead of blocking on this
> > completion, we can simply convert c4iw_qp_rem_ref if use a kref
> > which is not order dependent.
> 
> I agree,
> I'm exploring best possible ways to address this issue, will update my
> final resolution by this Friday.
