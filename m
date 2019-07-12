Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD2866BC2
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 13:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfGLLrV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Jul 2019 07:47:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55510 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfGLLrU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Jul 2019 07:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=09b07o5vnG2lxWsLi8/Igd/MSdi8rFkcLyCH46v0de0=; b=FomguHRTFjIm6ueie4WhaWAYT
        gpspeiYWEJ7x62J6XowEWQfsziVlMRKp5WromlGZmsl6TZ6AJCvuOrpVrxC3F20pb6XCnUXEysx46
        zxM4oW/r+OF5ZMbYdu7k3EPNpIdy1VZOf7pxz7rCfKjVEU7whff9SvpbXxnTiAYH63q1rdSQZAvIn
        g1GXbJh4damYXenB6Q10yUdvFOA8YzdAVwze0T3E+3Pam6oDlfVLvZw0lZNKefgL+gjAXfAI7I5pi
        bEnC8eWRXC7sqeyB9hvWSuydpACRGPdvS+lt7lmMttjknoae686Cu/Xgfduf58JzpowKpJUElTX0l
        vPahW2Bxw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlu1F-0006th-3H; Fri, 12 Jul 2019 11:47:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 81CB3209772E6; Fri, 12 Jul 2019 13:47:15 +0200 (CEST)
Date:   Fri, 12 Jul 2019 13:47:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rdma/siw: avoid smp_store_mb() on a u64
Message-ID: <20190712114715.GV3402@hirez.programming.kicks-ass.net>
References: <20190712085212.3901785-1-arnd@arndb.de>
 <OF05C1A780.433E36D1-ON00258435.003381DA-00258435.003F847E@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF05C1A780.433E36D1-ON00258435.003381DA-00258435.003F847E@notes.na.collabserv.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 12, 2019 at 11:33:46AM +0000, Bernard Metzler wrote:
> Many thanks for pointing that out! Indeed, this CQ notification
> mechanism does not take 32 bit architectures into account.
> Since we have only three flags to hold here, it's probably better
> to make it a 32bit value. That would remove the issue w/o
> introducing extra smp_wmb(). I'd prefer smp_store_mb(),
> since on some architectures it shall be more efficient.
> That would also make it sufficient to use READ_ONCE. 
> 

The below fails review due to a distinct lack of comments describing the
memory ordering.

Describe which variables (at least two) are ordered how and what
guarantees that provides and how that helps.

> From c7c3e2dbc3555581be52cb5d76c15726dced0331 Mon Sep 17 00:00:00 2001
> From: Bernard Metzler <bmt@zurich.ibm.com>
> Date: Fri, 12 Jul 2019 13:19:27 +0200
> Subject: [PATCH] Make shared CQ notification flags 32bit to respect 32bit
>  architectures
> 
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw.h       | 2 +-
>  drivers/infiniband/sw/siw/siw_qp.c    | 6 +++---
>  drivers/infiniband/sw/siw/siw_verbs.c | 6 +++---
>  include/uapi/rdma/siw-abi.h           | 3 ++-
>  4 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
> index 409e2987cd45..d59d81f4d86b 100644
> --- a/drivers/infiniband/sw/siw/siw.h
> +++ b/drivers/infiniband/sw/siw/siw.h
> @@ -216,7 +216,7 @@ struct siw_wqe {
>  struct siw_cq {
>  	struct ib_cq base_cq;
>  	spinlock_t lock;
> -	u64 *notify;
> +	struct siw_cq_ctrl *notify;
>  	struct siw_cqe *queue;
>  	u32 cq_put;
>  	u32 cq_get;
> diff --git a/drivers/infiniband/sw/siw/siw_qp.c b/drivers/infiniband/sw/siw/siw_qp.c
> index 83e50fe8e48b..0fcc5002d2da 100644
> --- a/drivers/infiniband/sw/siw/siw_qp.c
> +++ b/drivers/infiniband/sw/siw/siw_qp.c
> @@ -1011,18 +1011,18 @@ int siw_activate_tx(struct siw_qp *qp)
>   */
>  static bool siw_cq_notify_now(struct siw_cq *cq, u32 flags)
>  {
> -	u64 cq_notify;
> +	u32 cq_notify;
>  
>  	if (!cq->base_cq.comp_handler)
>  		return false;
>  
> -	cq_notify = READ_ONCE(*cq->notify);
> +	cq_notify = READ_ONCE(cq->notify->flags);
>  
>  	if ((cq_notify & SIW_NOTIFY_NEXT_COMPLETION) ||
>  	    ((cq_notify & SIW_NOTIFY_SOLICITED) &&
>  	     (flags & SIW_WQE_SOLICITED))) {
>  		/* dis-arm CQ */
> -		smp_store_mb(*cq->notify, SIW_NOTIFY_NOT);
> +		smp_store_mb(cq->notify->flags, SIW_NOTIFY_NOT);
>  
>  		return true;
>  	}
> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
> index d4fb78780765..bc6892229af0 100644
> --- a/drivers/infiniband/sw/siw/siw_verbs.c
> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
> @@ -1049,7 +1049,7 @@ int siw_create_cq(struct ib_cq *base_cq, const struct ib_cq_init_attr *attr,
>  
>  	spin_lock_init(&cq->lock);
>  
> -	cq->notify = &((struct siw_cq_ctrl *)&cq->queue[size])->notify;
> +	cq->notify = (struct siw_cq_ctrl *)&cq->queue[size];
>  
>  	if (udata) {
>  		struct siw_uresp_create_cq uresp = {};
> @@ -1142,10 +1142,10 @@ int siw_req_notify_cq(struct ib_cq *base_cq, enum ib_cq_notify_flags flags)
>  
>  	if ((flags & IB_CQ_SOLICITED_MASK) == IB_CQ_SOLICITED)
>  		/* CQ event for next solicited completion */
> -		smp_store_mb(*cq->notify, SIW_NOTIFY_SOLICITED);
> +		smp_store_mb(cq->notify->flags, SIW_NOTIFY_SOLICITED);
>  	else
>  		/* CQ event for any signalled completion */
> -		smp_store_mb(*cq->notify, SIW_NOTIFY_ALL);
> +	smp_store_mb(cq->notify->flags, SIW_NOTIFY_ALL);
>  
>  	if (flags & IB_CQ_REPORT_MISSED_EVENTS)
>  		return cq->cq_put - cq->cq_get;
> diff --git a/include/uapi/rdma/siw-abi.h b/include/uapi/rdma/siw-abi.h
> index ba4d5315cb76..93298980d3a7 100644
> --- a/include/uapi/rdma/siw-abi.h
> +++ b/include/uapi/rdma/siw-abi.h
> @@ -178,6 +178,7 @@ struct siw_cqe {
>   * to control CQ arming.
>   */
>  struct siw_cq_ctrl {
> -	__aligned_u64 notify;
> +	__u32 flags;
> +	__u32 pad;
>  };
>  #endif
> -- 
> 2.17.2
> 
> 
