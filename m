Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2221A8CAB
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2020 22:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633271AbgDNUk1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Apr 2020 16:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730053AbgDNUkR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Apr 2020 16:40:17 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F4DC061A0C
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2020 13:40:17 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id q73so635665qvq.2
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2020 13:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zfpb6F/oiwk03cDnS37uytJ2Xqcpf5MQ0GElxnA0880=;
        b=WQ5HePKylYtoqpmkMlScFtRgVckFgLKQgYqEzx3nJpI6aDntvuZYuagQXZK4ME1/7D
         Fv36LmcHpRhQ8SYp3cVkhT9O8Qid7MuPMkTzZFF2hZ7qRm/UmVSvh/tpHEuSNcHfN/vS
         sFiekJ8B4F6IUSM1AqjV2u9oMY84XGshboHcseenTiunKFykwFzQ50QlnBJ58omsPL3R
         FPpbk550osI4Bi3J0nH4DJGHESXsoB9HyoqxO4CAP4OoqdxF6VYyAgxweBW1LlX3PgLB
         l6GrypA8dSixcYP9XNUU4YHgEDQYdXcbrdQtTFy+LOGHuDioXhP+nw36p0aOmKEnRYUY
         oRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zfpb6F/oiwk03cDnS37uytJ2Xqcpf5MQ0GElxnA0880=;
        b=gvEqwo1F3BjdCqLl2vRH/T+zAWu9WT/qi7kAHCKDIbmZs/13XDxTXJPICtsCVrajOj
         D8p8NgLni/rTTv70Bp019PAr1v888O4ePrjvelLFI8f08QQtrjuJaR5ydVeQv9SR9W6P
         D9ngCpfwFdI2+nsRctw3G0BHlErpIjEdTpl6oKT1NYs4LjY0Gq3OEOieoUcJp4LIorxU
         l6K3LOYKk48IhIt87xIp615jCc2PiLNzHIfEnY9RFFFU+APfPtCZNye0r3soxRSFLdrx
         TNXII60A3UVfBd7/2oZ+ta7bA12tRGxDXwE42L/lGPWV+z5S3fMmTf/EGIqwj8sAP74C
         q+yw==
X-Gm-Message-State: AGi0PuYsLo+UvMSaNSQ7jzvSEuTrSWFtpqO1q15sYmkfZM9mFO1R298R
        BYa/CEvN/YcS8+rZZMmdLMyWwQ==
X-Google-Smtp-Source: APiQypKGJeDp+W/DhhCVuZGhIZ2G7Rlgatv4xobd5tZG4bOX6FG6/E2FdltMWJTfk0LopWj3nnczDQ==
X-Received: by 2002:a0c:ba9b:: with SMTP id x27mr1969414qvf.194.1586896816484;
        Tue, 14 Apr 2020 13:40:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id z26sm437938qkg.39.2020.04.14.13.40.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Apr 2020 13:40:15 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jOSLv-00040V-FW; Tue, 14 Apr 2020 17:40:15 -0300
Date:   Tue, 14 Apr 2020 17:40:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        ted.h.kim@oracle.com, william.taylor@oracle.com
Subject: Re: [PATCH for-rc] RDMA/cm: Do not send REJ when remote_id is unknown
Message-ID: <20200414204015.GA28572@ziepe.ca>
References: <20200414111720.1789168-1-haakon.bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200414111720.1789168-1-haakon.bugge@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 14, 2020 at 01:17:20PM +0200, Håkon Bugge wrote:
> In cm_destroy_id(), when the cm_id state is IB_CM_REQ_SENT or
> IB_CM_MRA_REQ_RCVD, an attempt is made to send a REJ with
> IB_CM_REJ_TIMEOUT as the reject reason.

Yes, this causes the remote to destroy the half completed connection,
for instance if the path is unidirectional.

> However, in said states, we have no remote_id. For the REQ_SENT case,
> we simply haven't received anything from our peer,

Which is correct, the spec covers this in Table 108 which describes
the remote communication ID as '0 if REJecting due to REP timeout and
no MRA was received'

This is implemented in cm_acquire_rejected_id(), assuming it isn't
buggy.

> for the MRA_REQ_RCVD case, the cm_rma_handler() doesn't pick up the
> remote_id.

This seems like a bug. It would be appropriate to store the remote id
when getting a MRA and set it in cm_format_rej() if a MRA has been rx'd

It also seems like a bug that cm_acquire_rejected_id() does not check
the remote_comm_id if it is not zero.

And for this reason it also seems unwise that cm_alloc_id_priv() will
allocate 0 cm_id's, as that value appears to have special meaning, oh
and it is unwise to use 0 with cm_acquire_id(). Tsk.

The CM_MSG_RESPONSE_REQ path looks kind of wrong too..

> Therefore, it is no reason to send this REJ, since it simply will be
> tossed at the peer's CM layer (if it reaches it). If running in CX-3
> virtualized and having the pr_debug enabled in the mlx4_ib driver, we
> will see:
> 
> mlx4_ib_demux_cm_handler: Couldn't find an entry for pv_cm_id 0x0

This seems to be a bug in mlx4. The pv layer should be duplicating how
cm_acquire_rejected_id() works

Something like this for the cm parts - what do you think?

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 4794113ecd596c..fb384bf60b6f02 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -592,20 +592,35 @@ static void cm_free_id(__be32 local_id)
 	xa_erase_irq(&cm.local_id_table, cm_local_id(local_id));
 }
 
-static struct cm_id_private *cm_acquire_id(__be32 local_id, __be32 remote_id)
+/*
+ * If we know the message is related to a REQ then there is no remote_id set, so
+ * it should not be checked. The state should be in IB_CM_REQ_SENT,
+ * IB_CM_SIDR_REQ_SENT or IB_CM_MRA_REQ_RCVD and the caller should check this.
+ */
+static struct cm_id_private *cm_acquire_req(__be32 local_id)
 {
 	struct cm_id_private *cm_id_priv;
 
 	rcu_read_lock();
 	cm_id_priv = xa_load(&cm.local_id_table, cm_local_id(local_id));
-	if (!cm_id_priv || cm_id_priv->id.remote_id != remote_id ||
-	    !refcount_inc_not_zero(&cm_id_priv->refcount))
+	if (!cm_id_priv || !refcount_inc_not_zero(&cm_id_priv->refcount))
 		cm_id_priv = NULL;
 	rcu_read_unlock();
 
 	return cm_id_priv;
 }
 
+static struct cm_id_private *cm_acquire_id(__be32 local_id, __be32 remote_id)
+{
+	struct cm_id_private *cm_id_priv = cm_acquire_req(local_id);
+
+	if (READ_ONCE(cm_id_priv->id.remote_id) != remote_id) {
+		cm_deref_id(cm_id_priv);
+		return NULL;
+	}
+	return cm_id_priv;
+}
+
 /*
  * Trivial helpers to strip endian annotation and compare; the
  * endianness doesn't actually matter since we just need a stable
@@ -1856,6 +1871,10 @@ static void cm_format_rej(struct cm_rej_msg *rej_msg,
 			be32_to_cpu(cm_id_priv->id.local_id));
 		IBA_SET(CM_REJ_MESSAGE_REJECTED, rej_msg, CM_MSG_RESPONSE_REP);
 		break;
+	case IB_CM_MRA_REQ_RCVD:
+		IBA_SET(CM_REJ_REMOTE_COMM_ID, rej_msg,
+			be32_to_cpu(cm_id_priv->id.remote_id));
+		fallthrough;
 	default:
 		IBA_SET(CM_REJ_LOCAL_COMM_ID, rej_msg,
 			be32_to_cpu(cm_id_priv->id.local_id));
@@ -2409,8 +2428,8 @@ static int cm_rep_handler(struct cm_work *work)
 	struct cm_timewait_info *timewait_info;
 
 	rep_msg = (struct cm_rep_msg *)work->mad_recv_wc->recv_buf.mad;
-	cm_id_priv = cm_acquire_id(
-		cpu_to_be32(IBA_GET(CM_REP_REMOTE_COMM_ID, rep_msg)), 0);
+	cm_id_priv = cm_acquire_req(
+		cpu_to_be32(IBA_GET(CM_REP_REMOTE_COMM_ID, rep_msg)));
 	if (!cm_id_priv) {
 		cm_dup_rep_handler(work);
 		pr_debug("%s: remote_comm_id %d, no cm_id_priv\n", __func__,
@@ -2991,7 +3010,8 @@ static struct cm_id_private * cm_acquire_rejected_id(struct cm_rej_msg *rej_msg)
 
 	remote_id = cpu_to_be32(IBA_GET(CM_REJ_LOCAL_COMM_ID, rej_msg));
 
-	if (IBA_GET(CM_REJ_REASON, rej_msg) == IB_CM_REJ_TIMEOUT) {
+	if (IBA_GET(CM_REJ_REASON, rej_msg) == IB_CM_REJ_TIMEOUT &&
+	    IBA_GET(CM_REJ_REMOTE_COMM_ID, rej_msg) == 0) {
 		spin_lock_irq(&cm.lock);
 		timewait_info = cm_find_remote_id(
 			*((__be64 *)IBA_GET_MEM_PTR(CM_REJ_ARI, rej_msg)),
@@ -3005,9 +3025,8 @@ static struct cm_id_private * cm_acquire_rejected_id(struct cm_rej_msg *rej_msg)
 		spin_unlock_irq(&cm.lock);
 	} else if (IBA_GET(CM_REJ_MESSAGE_REJECTED, rej_msg) ==
 		   CM_MSG_RESPONSE_REQ)
-		cm_id_priv = cm_acquire_id(
-			cpu_to_be32(IBA_GET(CM_REJ_REMOTE_COMM_ID, rej_msg)),
-			0);
+		cm_id_priv = cm_acquire_req(
+			cpu_to_be32(IBA_GET(CM_REJ_REMOTE_COMM_ID, rej_msg)));
 	else
 		cm_id_priv = cm_acquire_id(
 			cpu_to_be32(IBA_GET(CM_REJ_REMOTE_COMM_ID, rej_msg)),
@@ -3171,9 +3190,8 @@ static struct cm_id_private * cm_acquire_mraed_id(struct cm_mra_msg *mra_msg)
 {
 	switch (IBA_GET(CM_MRA_MESSAGE_MRAED, mra_msg)) {
 	case CM_MSG_RESPONSE_REQ:
-		return cm_acquire_id(
-			cpu_to_be32(IBA_GET(CM_MRA_REMOTE_COMM_ID, mra_msg)),
-			0);
+		return cm_acquire_req(
+			cpu_to_be32(IBA_GET(CM_MRA_REMOTE_COMM_ID, mra_msg)));
 	case CM_MSG_RESPONSE_REP:
 	case CM_MSG_RESPONSE_OTHER:
 		return cm_acquire_id(
@@ -3211,6 +3229,8 @@ static int cm_mra_handler(struct cm_work *work)
 				  cm_id_priv->msg, timeout))
 			goto out;
 		cm_id_priv->id.state = IB_CM_MRA_REQ_RCVD;
+		cm_id_priv->id.remote_id =
+			IBA_GET(CM_MRA_LOCAL_COMM_ID, mra_msg);
 		break;
 	case IB_CM_REP_SENT:
 		if (IBA_GET(CM_MRA_MESSAGE_MRAED, mra_msg) !=
@@ -3769,8 +3789,8 @@ static int cm_sidr_rep_handler(struct cm_work *work)
 
 	sidr_rep_msg = (struct cm_sidr_rep_msg *)
 				work->mad_recv_wc->recv_buf.mad;
-	cm_id_priv = cm_acquire_id(
-		cpu_to_be32(IBA_GET(CM_SIDR_REP_REQUESTID, sidr_rep_msg)), 0);
+	cm_id_priv = cm_acquire_req(
+		cpu_to_be32(IBA_GET(CM_SIDR_REP_REQUESTID, sidr_rep_msg)));
 	if (!cm_id_priv)
 		return -EINVAL; /* Unmatched reply. */
 
