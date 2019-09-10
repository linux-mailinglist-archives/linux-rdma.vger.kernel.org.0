Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98C63AF1D1
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2019 21:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfIJTWX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Sep 2019 15:22:23 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:21589 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbfIJTWX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Sep 2019 15:22:23 -0400
Received: from localhost (budha.blr.asicdesigners.com [10.193.185.4])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x8AJLxj8004459;
        Tue, 10 Sep 2019 12:22:01 -0700
Date:   Wed, 11 Sep 2019 00:51:59 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        Steve Wise <larrystevenwise@gmail.com>,
        Bernard Metzler <BMT@zurich.ibm.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v3] iwcm: don't hold the irq disabled lock on iw_rem_ref
Message-ID: <20190910192157.GA5954@chelsio.com>
References: <20190904212531.6488-1-sagi@grimberg.me>
 <20190910111759.GA5472@chelsio.com>
 <5cc42f23-bf60-ca8d-f40c-cbd8875f5756@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cc42f23-bf60-ca8d-f40c-cbd8875f5756@grimberg.me>
User-Agent: Mutt/1.9.3 (20180206.02d571c2)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Please review the below patch, I will resubmit this in patch-series
after review.
- As kput_ref handler(siw_free_qp) uses vfree, iwcm can't call
  iw_rem_ref() with spinlocks held. Doing so can cause vfree() to sleep
  with irq disabled.
  Two possible solutions:
  1)With spinlock acquired, take a copy of "cm_id_priv->qp" and update
    it to NULL. And after releasing lock use the copied qp pointer for
    rem_ref().
  2)Replacing issue causing vmalloc()/vfree to kmalloc()/kfree in SIW
    driver, may not be a ideal solution.
  
  Solution 2 may not be ideal as allocating huge contigous memory for
   SQ & RQ doesn't look appropriate.
  
- The structure "siw_base_qp" is getting freed in siw_destroy_qp(), but
  if cm_close_handler() holds the last reference, then siw_free_qp(),
  via cm_close_handler(), tries to get already freed "siw_base_qp" from
  "ib_qp". 
   Hence, "siw_base_qp" should be freed at the end of siw_free_qp().


diff --git a/drivers/infiniband/core/iwcm.c
b/drivers/infiniband/core/iwcm.c
index 72141c5b7c95..d5ab69fa598a 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -373,6 +373,7 @@ static void destroy_cm_id(struct iw_cm_id *cm_id)
 {
        struct iwcm_id_private *cm_id_priv;
        unsigned long flags;
+       struct ib_qp *qp;

        cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
        /*
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
@@ -880,6 +882,7 @@ static int cm_conn_rep_handler(struct
iwcm_id_private *cm_id_priv,
 {
        unsigned long flags;
        int ret;
+       struct ib_qp *qp = NULL;

        spin_lock_irqsave(&cm_id_priv->lock, flags);
        /*
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
@@ -944,12 +949,12 @@ static int cm_close_handler(struct iwcm_id_private
*cm_id_priv,
 {
        unsigned long flags;
        int ret = 0;
+       struct ib_qp *qp;
+
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
@@ -965,6 +970,8 @@ static int cm_close_handler(struct iwcm_id_private
*cm_id_priv,
        }
        spin_unlock_irqrestore(&cm_id_priv->lock, flags);

+       if (qp)
+               cm_id_priv->id.device->ops.iw_rem_ref(qp);
        return ret;
 }

diff --git a/drivers/infiniband/sw/siw/siw_qp.c
b/drivers/infiniband/sw/siw/siw_qp.c
index 430314c8abd9..cb177688a49f 100644
--- a/drivers/infiniband/sw/siw/siw_qp.c
+++ b/drivers/infiniband/sw/siw/siw_qp.c
@@ -1307,6 +1307,7 @@ void siw_free_qp(struct kref *ref)
        struct siw_qp *found, *qp = container_of(ref, struct siw_qp,
ref);
        struct siw_device *sdev = qp->sdev;
        unsigned long flags;
+       struct siw_base_qp *siw_base_qp = to_siw_base_qp(qp->ib_qp);

        if (qp->cep)
                siw_cep_put(qp->cep);
@@ -1327,4 +1328,5 @@ void siw_free_qp(struct kref *ref)
        atomic_dec(&sdev->num_qp);
        siw_dbg_qp(qp, "free QP\n");
        kfree_rcu(qp, rcu);
+       kfree(siw_base_qp);
 }
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
b/drivers/infiniband/sw/siw/siw_verbs.c
index da52c90e06d4..ac08d84d84cb 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -603,7 +603,6 @@ int siw_verbs_modify_qp(struct ib_qp *base_qp,
struct ib_qp_attr *attr,
 int siw_destroy_qp(struct ib_qp *base_qp, struct ib_udata *udata)
 {
        struct siw_qp *qp = to_siw_qp(base_qp);
-       struct siw_base_qp *siw_base_qp = to_siw_base_qp(base_qp);
        struct siw_ucontext *uctx =
                rdma_udata_to_drv_context(udata, struct siw_ucontext,
                                          base_ucontext);
@@ -640,7 +639,6 @@ int siw_destroy_qp(struct ib_qp *base_qp, struct
ib_udata *udata)
        qp->scq = qp->rcq = NULL;

        siw_qp_put(qp);
-       kfree(siw_base_qp);

        return 0;
 }


On Tuesday, September 09/10/19, 2019 at 22:23:13 +0530, Sagi Grimberg wrote:
> 
> >> This may be the final put on a qp and result in freeing
> >> resourcesand should not be done with interrupts disabled.
> > 
> > Hi Sagi,
> > 
> > Few things to consider in fixing this completely:
> >    - there are some other places where iw_rem_ref() should be called
> >      after spinlock critical section. eg: in cm_close_handler(),
> > iw_cm_connect(),...
> >    - Any modifications to "cm_id_priv" should be done with in spinlock
> >      critical section, modifying cm_id_priv->qp outside spinlocks, even
> > with atomic xchg(), might be error prone.
> >    - the structure "siw_base_qp" is getting freed in siw_destroy_qp(),
> >      but it should be done at the end of siw_free_qp().
> 
> Not sure why you say that, at the end of this function ->qp will be null
> anyways...
 Hope the above description and patch answers this.
> 
> >    
> > I am about to finish writing a patch that cover all the above issues.
> > Will test it and submit here by EOD.
> 
> Sure, you take it. Just stumbled on it so thought I'd go ahead and send
> a patch...
