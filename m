Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D488DC84D
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Oct 2019 17:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfJRPUJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 18 Oct 2019 11:20:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5864 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633014AbfJRPUI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Oct 2019 11:20:08 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9IF8fVa061251
        for <linux-rdma@vger.kernel.org>; Fri, 18 Oct 2019 11:20:07 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.112])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vqetxu0d0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 18 Oct 2019 11:20:06 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 18 Oct 2019 15:20:05 -0000
Received: from us1b3-smtp06.a3dr.sjc01.isc4sb.com (10.122.203.184)
        by smtp.notes.na.collabserv.com (10.122.47.54) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 18 Oct 2019 15:19:59 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp06.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019101815195850-545016 ;
          Fri, 18 Oct 2019 15:19:58 +0000 
In-Reply-To: <20191007102627.12568-1-krishna2@chelsio.com>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Krishnamraju Eraparaju" <krishna2@chelsio.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com, sagi@grimberg.me, larrystevenwise@gmail.com
Date:   Fri, 18 Oct 2019 15:19:58 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20191007102627.12568-1-krishna2@chelsio.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP59 September 23, 2019 at 18:08
X-KeepSent: 37CC94FF:9041EFF5-00258497:0054187F;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 52375
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19101815-4615-0000-0000-000000BC5B58
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.411265; ST=0; TS=0; UL=0; ISC=; MB=0.000000
X-IBM-SpamModules-Versions: BY=3.00011959; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000292; SDB=6.01277250; UDB=6.00676583; IPR=6.01059368;
 MB=3.00029143; MTD=3.00000008; XFM=3.00000015; UTC=2019-10-18 15:20:04
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-10-18 14:25:09 - 6.00010541
x-cbparentid: 19101815-4616-0000-0000-000069236A2C
Message-Id: <OF37CC94FF.9041EFF5-ON00258497.0054187F-00258497.005439FD@notes.na.collabserv.com>
Subject: Re:  [PATCH v1,for-rc] RDMA/iwcm: move iw_rem_ref() calls out of spinlock
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-18_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----

>To: jgg@ziepe.ca, bmt@zurich.ibm.com
>From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>Date: 10/07/2019 12:28PM
>Cc: linux-rdma@vger.kernel.org, bharat@chelsio.com,
>nirranjan@chelsio.com, sagi@grimberg.me, larrystevenwise@gmail.com,
>"Krishnamraju Eraparaju" <krishna2@chelsio.com>
>Subject: [EXTERNAL] [PATCH v1,for-rc] RDMA/iwcm: move iw_rem_ref()
>calls out of spinlock
>
>kref release routines usually perform memory release operations,
>hence, they should not be called with spinlocks held.
>one such case is: SIW kref release routine siw_free_qp(), which
>can sleep via vfree() while freeing queue memory.
>
>Hence, all iw_rem_ref() calls in IWCM are moved out of spinlocks.
>
>Fixes: 922a8e9fb2e0 ("RDMA: iWARP Connection Manager.")
>Signed-off-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
>---
>v0 -> v1:
>-changed component name in subject line: siw->iwcm
>-added "Fixes" line.
>---
> drivers/infiniband/core/iwcm.c | 52
>+++++++++++++++++++---------------
> 1 file changed, 29 insertions(+), 23 deletions(-)
>
>diff --git a/drivers/infiniband/core/iwcm.c
>b/drivers/infiniband/core/iwcm.c
>index 72141c5b7c95..ade71823370f 100644
>--- a/drivers/infiniband/core/iwcm.c
>+++ b/drivers/infiniband/core/iwcm.c
>@@ -372,6 +372,7 @@ EXPORT_SYMBOL(iw_cm_disconnect);
> static void destroy_cm_id(struct iw_cm_id *cm_id)
> {
> 	struct iwcm_id_private *cm_id_priv;
>+	struct ib_qp *qp;
> 	unsigned long flags;
> 
> 	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
>@@ -389,6 +390,9 @@ static void destroy_cm_id(struct iw_cm_id *cm_id)
> 	set_bit(IWCM_F_DROP_EVENTS, &cm_id_priv->flags);
> 
> 	spin_lock_irqsave(&cm_id_priv->lock, flags);
>+	qp = cm_id_priv->qp;
>+	cm_id_priv->qp = NULL;
>+
> 	switch (cm_id_priv->state) {
> 	case IW_CM_STATE_LISTEN:
> 		cm_id_priv->state = IW_CM_STATE_DESTROYING;
>@@ -401,7 +405,7 @@ static void destroy_cm_id(struct iw_cm_id *cm_id)
> 		cm_id_priv->state = IW_CM_STATE_DESTROYING;
> 		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
> 		/* Abrupt close of the connection */
>-		(void)iwcm_modify_qp_err(cm_id_priv->qp);
>+		(void)iwcm_modify_qp_err(qp);
> 		spin_lock_irqsave(&cm_id_priv->lock, flags);
> 		break;
> 	case IW_CM_STATE_IDLE:
>@@ -426,11 +430,9 @@ static void destroy_cm_id(struct iw_cm_id
>*cm_id)
> 		BUG();
> 		break;
> 	}
>-	if (cm_id_priv->qp) {
>-		cm_id_priv->id.device->ops.iw_rem_ref(cm_id_priv->qp);
>-		cm_id_priv->qp = NULL;
>-	}
> 	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
>+	if (qp)
>+		cm_id_priv->id.device->ops.iw_rem_ref(qp);
> 
> 	if (cm_id->mapped) {
> 		iwpm_remove_mapinfo(&cm_id->local_addr, &cm_id->m_local_addr);
>@@ -671,11 +673,11 @@ int iw_cm_accept(struct iw_cm_id *cm_id,
> 		BUG_ON(cm_id_priv->state != IW_CM_STATE_CONN_RECV);
> 		cm_id_priv->state = IW_CM_STATE_IDLE;
> 		spin_lock_irqsave(&cm_id_priv->lock, flags);
>-		if (cm_id_priv->qp) {
>-			cm_id->device->ops.iw_rem_ref(qp);
>-			cm_id_priv->qp = NULL;
>-		}
>+		qp = cm_id_priv->qp;
>+		cm_id_priv->qp = NULL;
> 		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
>+		if (qp)
>+			cm_id->device->ops.iw_rem_ref(qp);
> 		clear_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags);
> 		wake_up_all(&cm_id_priv->connect_wait);
> 	}
>@@ -696,7 +698,7 @@ int iw_cm_connect(struct iw_cm_id *cm_id, struct
>iw_cm_conn_param *iw_param)
> 	struct iwcm_id_private *cm_id_priv;
> 	int ret;
> 	unsigned long flags;
>-	struct ib_qp *qp;
>+	struct ib_qp *qp = NULL;
> 
> 	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
> 
>@@ -730,13 +732,13 @@ int iw_cm_connect(struct iw_cm_id *cm_id,
>struct iw_cm_conn_param *iw_param)
> 		return 0;	/* success */
> 
> 	spin_lock_irqsave(&cm_id_priv->lock, flags);
>-	if (cm_id_priv->qp) {
>-		cm_id->device->ops.iw_rem_ref(qp);
>-		cm_id_priv->qp = NULL;
>-	}
>+	qp = cm_id_priv->qp;
>+	cm_id_priv->qp = NULL;
> 	cm_id_priv->state = IW_CM_STATE_IDLE;
> err:
> 	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
>+	if (qp)
>+		cm_id->device->ops.iw_rem_ref(qp);
> 	clear_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags);
> 	wake_up_all(&cm_id_priv->connect_wait);
> 	return ret;
>@@ -878,6 +880,7 @@ static int cm_conn_est_handler(struct
>iwcm_id_private *cm_id_priv,
> static int cm_conn_rep_handler(struct iwcm_id_private *cm_id_priv,
> 			       struct iw_cm_event *iw_event)
> {
>+	struct ib_qp *qp = NULL;
> 	unsigned long flags;
> 	int ret;
> 
>@@ -896,11 +899,13 @@ static int cm_conn_rep_handler(struct
>iwcm_id_private *cm_id_priv,
> 		cm_id_priv->state = IW_CM_STATE_ESTABLISHED;
> 	} else {
> 		/* REJECTED or RESET */
>-		cm_id_priv->id.device->ops.iw_rem_ref(cm_id_priv->qp);
>+		qp = cm_id_priv->qp;
> 		cm_id_priv->qp = NULL;
> 		cm_id_priv->state = IW_CM_STATE_IDLE;
> 	}
> 	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
>+	if (qp)
>+		cm_id_priv->id.device->ops.iw_rem_ref(qp);
> 	ret = cm_id_priv->id.cm_handler(&cm_id_priv->id, iw_event);
> 
> 	if (iw_event->private_data_len)
>@@ -942,21 +947,18 @@ static void cm_disconnect_handler(struct
>iwcm_id_private *cm_id_priv,
> static int cm_close_handler(struct iwcm_id_private *cm_id_priv,
> 				  struct iw_cm_event *iw_event)
> {
>+	struct ib_qp *qp;
> 	unsigned long flags;
>-	int ret = 0;
>+	int ret = 0, notify_event = 0;
> 	spin_lock_irqsave(&cm_id_priv->lock, flags);
>+	qp = cm_id_priv->qp;
>+	cm_id_priv->qp = NULL;
> 
>-	if (cm_id_priv->qp) {
>-		cm_id_priv->id.device->ops.iw_rem_ref(cm_id_priv->qp);
>-		cm_id_priv->qp = NULL;
>-	}
> 	switch (cm_id_priv->state) {
> 	case IW_CM_STATE_ESTABLISHED:
> 	case IW_CM_STATE_CLOSING:
> 		cm_id_priv->state = IW_CM_STATE_IDLE;
>-		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
>-		ret = cm_id_priv->id.cm_handler(&cm_id_priv->id, iw_event);
>-		spin_lock_irqsave(&cm_id_priv->lock, flags);
>+		notify_event = 1;
> 		break;
> 	case IW_CM_STATE_DESTROYING:
> 		break;
>@@ -965,6 +967,10 @@ static int cm_close_handler(struct
>iwcm_id_private *cm_id_priv,
> 	}
> 	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
> 
>+	if (qp)
>+		cm_id_priv->id.device->ops.iw_rem_ref(qp);
>+	if (notify_event)
>+		ret = cm_id_priv->id.cm_handler(&cm_id_priv->id, iw_event);
> 	return ret;
> }
> 
>-- 
>2.23.0.rc0
>
>

That looks good to me.

Thanks,
Bernard.

Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>

