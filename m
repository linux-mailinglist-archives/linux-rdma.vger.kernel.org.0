Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04B9B823AC
	for <lists+linux-rdma@lfdr.de>; Mon,  5 Aug 2019 19:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfHERJJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 5 Aug 2019 13:09:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbfHERJI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 5 Aug 2019 13:09:08 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D14DC20880;
        Mon,  5 Aug 2019 17:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565024947;
        bh=Xzy6CThtxFXjheigB0/1/goZUGYWnD6DXLmlSxQwCzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nX/1ws2UexESzhXsb/JLFxi9f0LlbvUmm9Jo1ASzjiZaRtBLowWS9I0L2QJHmFWUr
         oomaTxXRZO0oia4MwWRY/HAIZmVA1vVpk6Inxu9zGbuiB0SOSZU7uYJYXvA+GYnGVX
         fVuoR195HRrDie6eaz4gWLk1eiQqLZapPYxNeAmo=
Date:   Mon, 5 Aug 2019 20:09:03 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, jgg@ziepe.ca
Subject: Re: [PATCH 1/1] Make user mmapped CQ arming flags field 32 bit size
 to remove 64 bit architecture dependency of siw.
Message-ID: <20190805170903.GO4832@mtr-leonro.mtl.com>
References: <20190805141708.9004-1-bmt@zurich.ibm.com>
 <20190805141708.9004-2-bmt@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805141708.9004-2-bmt@zurich.ibm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 05, 2019 at 04:17:08PM +0200, Bernard Metzler wrote:
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/Kconfig     |  2 +-
>  drivers/infiniband/sw/siw/siw.h       |  2 +-
>  drivers/infiniband/sw/siw/siw_qp.c    | 14 ++++++++++----
>  drivers/infiniband/sw/siw/siw_verbs.c | 16 +++++++++++-----
>  include/uapi/rdma/siw-abi.h           |  3 ++-
>  5 files changed, 25 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/infiniband/sw/siw/Kconfig b/drivers/infiniband/sw/siw/Kconfig
> index dace276aea14..b622fc62f2cd 100644
> --- a/drivers/infiniband/sw/siw/Kconfig
> +++ b/drivers/infiniband/sw/siw/Kconfig
> @@ -1,6 +1,6 @@
>  config RDMA_SIW
>  	tristate "Software RDMA over TCP/IP (iWARP) driver"
> -	depends on INET && INFINIBAND && LIBCRC32C && 64BIT
> +	depends on INET && INFINIBAND && LIBCRC32C
>  	select DMA_VIRT_OPS
>  	help
>  	This driver implements the iWARP RDMA transport over
> diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
> index 03fd7b2f595f..77b1aabf6ff3 100644
> --- a/drivers/infiniband/sw/siw/siw.h
> +++ b/drivers/infiniband/sw/siw/siw.h
> @@ -214,7 +214,7 @@ struct siw_wqe {
>  struct siw_cq {
>  	struct ib_cq base_cq;
>  	spinlock_t lock;
> -	u64 *notify;
> +	struct siw_cq_ctrl *notify;
>  	struct siw_cqe *queue;
>  	u32 cq_put;
>  	u32 cq_get;
> diff --git a/drivers/infiniband/sw/siw/siw_qp.c b/drivers/infiniband/sw/siw/siw_qp.c
> index e27bd5b35b96..0990307c5d2c 100644
> --- a/drivers/infiniband/sw/siw/siw_qp.c
> +++ b/drivers/infiniband/sw/siw/siw_qp.c
> @@ -1013,18 +1013,24 @@ int siw_activate_tx(struct siw_qp *qp)
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
> +	/* Read application shared notification state */
> +	cq_notify = READ_ONCE(cq->notify->flags);
>
>  	if ((cq_notify & SIW_NOTIFY_NEXT_COMPLETION) ||
>  	    ((cq_notify & SIW_NOTIFY_SOLICITED) &&
>  	     (flags & SIW_WQE_SOLICITED))) {
> -		/* dis-arm CQ */
> -		smp_store_mb(*cq->notify, SIW_NOTIFY_NOT);
> +		/*
> +		 * CQ notification is one-shot: Since the
> +		 * current CQE causes user notification,
> +		 * the CQ gets dis-aremd and must be re-aremd
> +		 * by the user for a new notification.
> +		 */
> +		WRITE_ONCE(cq->notify->flags, SIW_NOTIFY_NOT);
>
>  		return true;
>  	}
> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
> index 32dc79d0e898..e7f3a2379d9d 100644
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
> @@ -1141,11 +1141,17 @@ int siw_req_notify_cq(struct ib_cq *base_cq, enum ib_cq_notify_flags flags)
>  	siw_dbg_cq(cq, "flags: 0x%02x\n", flags);
>
>  	if ((flags & IB_CQ_SOLICITED_MASK) == IB_CQ_SOLICITED)
> -		/* CQ event for next solicited completion */
> -		smp_store_mb(*cq->notify, SIW_NOTIFY_SOLICITED);
> +		/*
> +		 * Enable CQ event for next solicited completion.
> +		 * and make it visible to all associated producers.
> +		 */
> +		smp_store_mb(cq->notify->flags, SIW_NOTIFY_SOLICITED);
>  	else
> -		/* CQ event for any signalled completion */
> -		smp_store_mb(*cq->notify, SIW_NOTIFY_ALL);
> +		/*
> +		 * Enable CQ event for any signalled completion.
> +		 * and make it visible to all associated producers.
> +		 */
> +		smp_store_mb(cq->notify->flags, SIW_NOTIFY_ALL);
>
>  	if (flags & IB_CQ_REPORT_MISSED_EVENTS)
>  		return cq->cq_put - cq->cq_get;
> diff --git a/include/uapi/rdma/siw-abi.h b/include/uapi/rdma/siw-abi.h
> index 7de68f1dc707..af735f55b291 100644
> --- a/include/uapi/rdma/siw-abi.h
> +++ b/include/uapi/rdma/siw-abi.h
> @@ -180,6 +180,7 @@ struct siw_cqe {
>   * to control CQ arming.
>   */
>  struct siw_cq_ctrl {
> -	__aligned_u64 notify;
> +	__u32 flags;
> +	__u32 pad;

You can't do it, it will break backward compatibility with rdma-core.
https://github.com/linux-rdma/rdma-core/blob/2066065574554229f5e4ef1a37abf637938b71e3/providers/siw/siw.c#L175

Thanks

>  };
>  #endif
> --
> 2.17.2
>
