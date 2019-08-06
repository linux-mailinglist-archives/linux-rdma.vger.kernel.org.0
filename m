Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3024083130
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2019 14:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfHFMKJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Aug 2019 08:10:09 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35333 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfHFMKJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Aug 2019 08:10:09 -0400
Received: by mail-qk1-f195.google.com with SMTP id r21so62704904qke.2
        for <linux-rdma@vger.kernel.org>; Tue, 06 Aug 2019 05:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rtwnfShAcCURI6hDQktzCuipc0LG6n25xta1tFHGTpw=;
        b=ndMXZCuhwUjFBc00b6tp98v+mlQQ6BdML4iGiRycHfDV1ClWfNbZZKttQBhGtS/7mX
         5DekRfcM7XDL5pSMjJzvQ6Wu0oU9BLF5BVr2xuYDF8ZQFTbh6U2w+srdc/bpN5UTfbvo
         4iDFM7hYxDJg81KVO6uYHC/A0cDUUwwF4wxa9nuDDXVFkVeQ1TrDD+ye6wQD5A7gCEnJ
         rE6vE9+TKxJ78Y9O0cxXyQUk2YIsl+1p+9ehv73NDzGfGQEhkGj1+8ufYN7hkpoRsH23
         BVD5l6yUXtw8M6jGJHV0ZbCmlRMXiZVnsTFAstYGLpIQJjyYVDrUrvlBlJ01enioD8sB
         az7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rtwnfShAcCURI6hDQktzCuipc0LG6n25xta1tFHGTpw=;
        b=NqV2H2svJc8OfzlByWqW4yU14/dr63heTlOcHLH58elqLngbpCnpXqsLYsrUIkFG+P
         k9Jb+aN6laBB8NbbTQ82/96zPr5UE9Ldv1d54sg7DljJbRMM7ICtn9A4C2NHI5Jf09Vo
         m9s9KZzZeljpCPBpu+7PqrvKUAWhCQCCdmznmLqjBgzKVEP1QhT9hHILohZhKvNx8Ppc
         8RXIJHXYogzvIo5Tp5QyDGdfFJWuTHzExImGCBbsKAfj9O6TH1BWcILR3+but3EVdDcJ
         Kw6XXVpIVhRvXie0jG4KNW33OZwjKgKoqa+k6RNhran2Vp+ibUsWWNCdQiYcMiyjkfOu
         dI0w==
X-Gm-Message-State: APjAAAUne8jwbf7odKirAjhozTTY6OyZAvJhkPvxc8gPqQiVMhmCaf7F
        Gmh6vOOfkHE2/QKM99p7BoWyLg==
X-Google-Smtp-Source: APXvYqxJllsfxz4XwY9VgHLi8/FCQHsJllcrMBvmWxY8ca1AZtgOKNUcuum11FaqPFQ9heFGIcaasg==
X-Received: by 2002:ae9:e306:: with SMTP id v6mr2803377qkf.145.1565093407766;
        Tue, 06 Aug 2019 05:10:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id r205sm42701122qke.115.2019.08.06.05.10.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Aug 2019 05:10:07 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1huyI2-0003n5-PV; Tue, 06 Aug 2019 09:10:06 -0300
Date:   Tue, 6 Aug 2019 09:10:06 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/1] Make user mmapped CQ arming flags field 32 bit size
 to remove 64 bit architecture dependency of siw.
Message-ID: <20190806121006.GC11627@ziepe.ca>
References: <20190805141708.9004-1-bmt@zurich.ibm.com>
 <20190805141708.9004-2-bmt@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805141708.9004-2-bmt@zurich.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 05, 2019 at 04:17:08PM +0200, Bernard Metzler wrote:
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---

Don't send patches with empty commit messages. Every patch must have a
comprehensive commit message from now on.

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

this isn't what we talked about, is it?

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

The commit message needs to explain why this is compatible with
existing user space, if it is even is safe..

Jason
