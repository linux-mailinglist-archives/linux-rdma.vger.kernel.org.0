Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAE5AAF91B
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2019 11:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfIKJi7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 11 Sep 2019 05:38:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42422 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726657AbfIKJi7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 11 Sep 2019 05:38:59 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8B9b1Yu001059
        for <linux-rdma@vger.kernel.org>; Wed, 11 Sep 2019 05:38:57 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.113])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uxvapcbjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Wed, 11 Sep 2019 05:38:57 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Wed, 11 Sep 2019 09:38:56 -0000
Received: from us1b3-smtp06.a3dr.sjc01.isc4sb.com (10.122.203.184)
        by smtp.notes.na.collabserv.com (10.122.47.56) with smtp.notes.na.collabserv.com ESMTP;
        Wed, 11 Sep 2019 09:38:51 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp06.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019091109385056-251839 ;
          Wed, 11 Sep 2019 09:38:50 +0000 
In-Reply-To: <20190910192157.GA5954@chelsio.com>
Subject: Re: Re: [PATCH v3] iwcm: don't hold the irq disabled lock on iw_rem_ref
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Krishnamraju Eraparaju" <krishna2@chelsio.com>
Cc:     "Sagi Grimberg" <sagi@grimberg.me>,
        "Steve Wise" <larrystevenwise@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
Date:   Wed, 11 Sep 2019 09:38:50 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190910192157.GA5954@chelsio.com>,<20190904212531.6488-1-sagi@grimberg.me>
 <20190910111759.GA5472@chelsio.com>
 <5cc42f23-bf60-ca8d-f40c-cbd8875f5756@grimberg.me>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP57 August 05, 2019 at 12:42
X-KeepSent: 00E4DFD9:0EEF58A6-00258472:0032F9AC;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 19767
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19091109-7691-0000-0000-000000654F71
X-IBM-SpamModules-Scores: BY=0.123745; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.198460
X-IBM-SpamModules-Versions: BY=3.00011754; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000288; SDB=6.01259780; UDB=6.00665919; IPR=6.01041549;
 MB=3.00028578; MTD=3.00000008; XFM=3.00000015; UTC=2019-09-11 09:38:55
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-09-11 05:30:23 - 6.00010393
x-cbparentid: 19091109-7692-0000-0000-0000009E5335
Message-Id: <OF00E4DFD9.0EEF58A6-ON00258472.0032F9AC-00258472.0034FEAA@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-11_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----

>To: "Sagi Grimberg" <sagi@grimberg.me>, "Steve Wise"
><larrystevenwise@gmail.com>, "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>Date: 09/10/2019 09:22PM
>Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "Jason
>Gunthorpe" <jgg@ziepe.ca>
>Subject: [EXTERNAL] Re: [PATCH v3] iwcm: don't hold the irq disabled
>lock on iw_rem_ref
>
>Please review the below patch, I will resubmit this in patch-series
>after review.
>- As kput_ref handler(siw_free_qp) uses vfree, iwcm can't call
>  iw_rem_ref() with spinlocks held. Doing so can cause vfree() to
>sleep
>  with irq disabled.
>  Two possible solutions:
>  1)With spinlock acquired, take a copy of "cm_id_priv->qp" and
>update
>    it to NULL. And after releasing lock use the copied qp pointer
>for
>    rem_ref().
>  2)Replacing issue causing vmalloc()/vfree to kmalloc()/kfree in SIW
>    driver, may not be a ideal solution.
>  
>  Solution 2 may not be ideal as allocating huge contigous memory for
>   SQ & RQ doesn't look appropriate.
>  
>- The structure "siw_base_qp" is getting freed in siw_destroy_qp(),
>but
>  if cm_close_handler() holds the last reference, then siw_free_qp(),
>  via cm_close_handler(), tries to get already freed "siw_base_qp"
>from
>  "ib_qp". 
>   Hence, "siw_base_qp" should be freed at the end of siw_free_qp().
>

Regarding the siw driver, I am fine with that proposed
change. Delaying freeing the base_qp is OK. In fact,
I'd expect the drivers soon are passing that responsibility
to the rdma core anyway -- like for CQ/SRQ/PD/CTX objects,
which are already allocated and freed up there.

The iwcm changes look OK to me as well.

(some comments on re-formatting the changes
inlined below)

Thanks!
Bernard.
>
>diff --git a/drivers/infiniband/core/iwcm.c
>b/drivers/infiniband/core/iwcm.c
>index 72141c5b7c95..d5ab69fa598a 100644
>--- a/drivers/infiniband/core/iwcm.c
>+++ b/drivers/infiniband/core/iwcm.c
>@@ -373,6 +373,7 @@ static void destroy_cm_id(struct iw_cm_id *cm_id)
> {
>        struct iwcm_id_private *cm_id_priv;
>        unsigned long flags;
>+       struct ib_qp *qp;

move *qp declaration up one line - see comment in
siw driver change below.
>
>        cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
>        /*
>@@ -389,6 +390,9 @@ static void destroy_cm_id(struct iw_cm_id *cm_id)
>        set_bit(IWCM_F_DROP_EVENTS, &cm_id_priv->flags);
>
>        spin_lock_irqsave(&cm_id_priv->lock, flags);
>+       qp = cm_id_priv->qp;
>+       cm_id_priv->qp = NULL;
>+
>        switch (cm_id_priv->state) {
>        case IW_CM_STATE_LISTEN:
>                cm_id_priv->state = IW_CM_STATE_DESTROYING;
>@@ -401,7 +405,7 @@ static void destroy_cm_id(struct iw_cm_id *cm_id)
>                cm_id_priv->state = IW_CM_STATE_DESTROYING;
>                spin_unlock_irqrestore(&cm_id_priv->lock, flags);
>                /* Abrupt close of the connection */
>-               (void)iwcm_modify_qp_err(cm_id_priv->qp);
>+               (void)iwcm_modify_qp_err(qp);
>                spin_lock_irqsave(&cm_id_priv->lock, flags);
>                break;
>        case IW_CM_STATE_IDLE:
>@@ -426,11 +430,9 @@ static void destroy_cm_id(struct iw_cm_id
>*cm_id)
>                BUG();
>                break;
>        }
>-       if (cm_id_priv->qp) {
>-
>cm_id_priv->id.device->ops.iw_rem_ref(cm_id_priv->qp);
>-               cm_id_priv->qp = NULL;
>-       }
>        spin_unlock_irqrestore(&cm_id_priv->lock, flags);
>+       if (qp)
>+               cm_id_priv->id.device->ops.iw_rem_ref(qp);
>
>        if (cm_id->mapped) {
>                iwpm_remove_mapinfo(&cm_id->local_addr,
>&cm_id->m_local_addr);
>@@ -671,11 +673,11 @@ int iw_cm_accept(struct iw_cm_id *cm_id,
>                BUG_ON(cm_id_priv->state != IW_CM_STATE_CONN_RECV);
>                cm_id_priv->state = IW_CM_STATE_IDLE;
>                spin_lock_irqsave(&cm_id_priv->lock, flags);
>-               if (cm_id_priv->qp) {
>-                       cm_id->device->ops.iw_rem_ref(qp);
>-                       cm_id_priv->qp = NULL;
>-               }
>+               qp = cm_id_priv->qp;
>+               cm_id_priv->qp = NULL;
>                spin_unlock_irqrestore(&cm_id_priv->lock, flags);
>+               if (qp)
>+                       cm_id->device->ops.iw_rem_ref(qp);
>                clear_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags);
>                wake_up_all(&cm_id_priv->connect_wait);
>        }
>@@ -730,13 +732,13 @@ int iw_cm_connect(struct iw_cm_id *cm_id,
>struct
>iw_cm_conn_param *iw_param)
>                return 0;       /* success */
>
>        spin_lock_irqsave(&cm_id_priv->lock, flags);
>-       if (cm_id_priv->qp) {
>-               cm_id->device->ops.iw_rem_ref(qp);
>-               cm_id_priv->qp = NULL;
>-       }
>+       qp = cm_id_priv->qp;
>+       cm_id_priv->qp = NULL;
>        cm_id_priv->state = IW_CM_STATE_IDLE;
> err:
>        spin_unlock_irqrestore(&cm_id_priv->lock, flags);
>+       if (qp)
>+               cm_id->device->ops.iw_rem_ref(qp);
>        clear_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags);
>        wake_up_all(&cm_id_priv->connect_wait);
>        return ret;
>@@ -880,6 +882,7 @@ static int cm_conn_rep_handler(struct
>iwcm_id_private *cm_id_priv,
> {
>        unsigned long flags;
>        int ret;
>+       struct ib_qp *qp = NULL;
>
>        spin_lock_irqsave(&cm_id_priv->lock, flags);
>        /*
>@@ -896,11 +899,13 @@ static int cm_conn_rep_handler(struct
>iwcm_id_private *cm_id_priv,
>                cm_id_priv->state = IW_CM_STATE_ESTABLISHED;
>        } else {
>                /* REJECTED or RESET */
>-
>cm_id_priv->id.device->ops.iw_rem_ref(cm_id_priv->qp);
>+               qp = cm_id_priv->qp;
>                cm_id_priv->qp = NULL;
>                cm_id_priv->state = IW_CM_STATE_IDLE;
>        }
>        spin_unlock_irqrestore(&cm_id_priv->lock, flags);
>+       if (qp)
>+               cm_id_priv->id.device->ops.iw_rem_ref(qp);
>        ret = cm_id_priv->id.cm_handler(&cm_id_priv->id, iw_event);
>
>        if (iw_event->private_data_len)
>@@ -944,12 +949,12 @@ static int cm_close_handler(struct
>iwcm_id_private
>*cm_id_priv,
> {
>        unsigned long flags;
>        int ret = 0;
>+       struct ib_qp *qp;

move *qp declaration up two lines - see comment on siw
driver change below.
>+
>        spin_lock_irqsave(&cm_id_priv->lock, flags);
>+       qp = cm_id_priv->qp;
>+       cm_id_priv->qp = NULL;
>
>-       if (cm_id_priv->qp) {
>-
>cm_id_priv->id.device->ops.iw_rem_ref(cm_id_priv->qp);
>-               cm_id_priv->qp = NULL;
>-       }
>        switch (cm_id_priv->state) {
>        case IW_CM_STATE_ESTABLISHED:
>        case IW_CM_STATE_CLOSING:
>@@ -965,6 +970,8 @@ static int cm_close_handler(struct
>iwcm_id_private
>*cm_id_priv,
>        }
>        spin_unlock_irqrestore(&cm_id_priv->lock, flags);
>
>+       if (qp)
>+               cm_id_priv->id.device->ops.iw_rem_ref(qp);
>        return ret;
> }
>
>diff --git a/drivers/infiniband/sw/siw/siw_qp.c
>b/drivers/infiniband/sw/siw/siw_qp.c
>index 430314c8abd9..cb177688a49f 100644
>--- a/drivers/infiniband/sw/siw/siw_qp.c
>+++ b/drivers/infiniband/sw/siw/siw_qp.c
>@@ -1307,6 +1307,7 @@ void siw_free_qp(struct kref *ref)
>        struct siw_qp *found, *qp = container_of(ref, struct siw_qp,
>ref);
>        struct siw_device *sdev = qp->sdev;
>        unsigned long flags;
>+       struct siw_base_qp *siw_base_qp = to_siw_base_qp(qp->ib_qp);

Please move that two lines up if OK with you.
I always prefer to have structs and its pointers
declared before introducing simple helper variables
like int and long etc. Thanks!


>
>        if (qp->cep)
>                siw_cep_put(qp->cep);
>@@ -1327,4 +1328,5 @@ void siw_free_qp(struct kref *ref)
>        atomic_dec(&sdev->num_qp);
>        siw_dbg_qp(qp, "free QP\n");
>        kfree_rcu(qp, rcu);
>+       kfree(siw_base_qp);
> }
>diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
>b/drivers/infiniband/sw/siw/siw_verbs.c
>index da52c90e06d4..ac08d84d84cb 100644
>--- a/drivers/infiniband/sw/siw/siw_verbs.c
>+++ b/drivers/infiniband/sw/siw/siw_verbs.c
>@@ -603,7 +603,6 @@ int siw_verbs_modify_qp(struct ib_qp *base_qp,
>struct ib_qp_attr *attr,
> int siw_destroy_qp(struct ib_qp *base_qp, struct ib_udata *udata)
> {
>        struct siw_qp *qp = to_siw_qp(base_qp);
>-       struct siw_base_qp *siw_base_qp = to_siw_base_qp(base_qp);
>        struct siw_ucontext *uctx =
>                rdma_udata_to_drv_context(udata, struct siw_ucontext,
>                                          base_ucontext);
>@@ -640,7 +639,6 @@ int siw_destroy_qp(struct ib_qp *base_qp, struct
>ib_udata *udata)
>        qp->scq = qp->rcq = NULL;
>
>        siw_qp_put(qp);
>-       kfree(siw_base_qp);
>
>        return 0;
> }
>
>
>On Tuesday, September 09/10/19, 2019 at 22:23:13 +0530, Sagi Grimberg
>wrote:
>> 
>> >> This may be the final put on a qp and result in freeing
>> >> resourcesand should not be done with interrupts disabled.
>> > 
>> > Hi Sagi,
>> > 
>> > Few things to consider in fixing this completely:
>> >    - there are some other places where iw_rem_ref() should be
>called
>> >      after spinlock critical section. eg: in cm_close_handler(),
>> > iw_cm_connect(),...
>> >    - Any modifications to "cm_id_priv" should be done with in
>spinlock
>> >      critical section, modifying cm_id_priv->qp outside
>spinlocks, even
>> > with atomic xchg(), might be error prone.
>> >    - the structure "siw_base_qp" is getting freed in
>siw_destroy_qp(),
>> >      but it should be done at the end of siw_free_qp().
>> 
>> Not sure why you say that, at the end of this function ->qp will be
>null
>> anyways...
> Hope the above description and patch answers this.
>> 
>> >    
>> > I am about to finish writing a patch that cover all the above
>issues.
>> > Will test it and submit here by EOD.
>> 
>> Sure, you take it. Just stumbled on it so thought I'd go ahead and
>send
>> a patch...
>
>

