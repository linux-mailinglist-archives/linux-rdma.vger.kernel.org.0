Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D9E3CF981
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 14:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237502AbhGTLmx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jul 2021 07:42:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236874AbhGTLmk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Jul 2021 07:42:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E85661165;
        Tue, 20 Jul 2021 12:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626783792;
        bh=k3u8kVux9MZ9aUC3HoK/CusB+Yi3Q/t7dbfUVU7znNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YAlToWw6aOZLePABIn2HAXF+uAnzv+QapStGGsYQegZtpptH1zLoy2hLFK+48tIlQ
         wjYkxMwBn37OVQkBauBGy+aF7eh3th9UeG4AbmGbJVldn3wIZOqZ2vtsOVcH8mKbVO
         cTQ3D1UbjtDGkyyiOwgU6o5TUDei8ZTEoXFrSUIRAkC87ebV8emtK0D4ZqxLL+US3h
         X2weJd6lg4ru7eASwjqMCYf90P0wiSfe3Z4jDTt6MFXCojK+fA8gVjSg1Frepl76V/
         6X8F4lhEoPMYhQA0/pG5J4kyZW7PEUjN/vXRjejSPSf2ojPFzZvT1gN0fIepm5fi0/
         pjIWx66FzHMng==
Date:   Tue, 20 Jul 2021 15:23:08 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/irdma: Improve the way 'cqp_request' structures are
 cleaned when they are recycled
Message-ID: <YPbALA/P5+NsC7MO@unreal>
References: <7f93f2a2c2fd18ddfeb99339d175b85ffd1c6398.1626713915.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f93f2a2c2fd18ddfeb99339d175b85ffd1c6398.1626713915.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 19, 2021 at 07:02:15PM +0200, Christophe JAILLET wrote:
> A set of IRDMA_CQP_SW_SQSIZE_2048 (i.e. 2048) 'cqp_request' are
> pre-allocated and zeroed in 'irdma_create_cqp()' (hw.c).  These
> structures are managed with the 'cqp->cqp_avail_reqs' list which keeps
> track of available entries.
> 
> In 'irdma_free_cqp_request()' (utils.c), when an entry is recycled and goes
> back to the 'cqp_avail_reqs' list, some fields are reseted.
> 
> However, one of these fields, 'compl_info', is initialized within
> 'irdma_alloc_and_get_cqp_request()'.
> 
> Move the corresponding memset to 'irdma_free_cqp_request()' so that the
> clean-up is done in only one place. This makes the logic more easy to
> understand.

I'm not so sure. The function irdma_alloc_and_get_cqp_request() returns
prepared cqp_request and all users expect that it will returned cleaned
one. The reliance on some other place to clear part of the structure is
prone to errors.

Thanks

> 
> This also saves this memset in the case that the 'cqp_avail_reqs' list is
> empty and a new 'cqp_request' structure must be allocated. This memset is
> useless, because the structure is already kzalloc'ed.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/infiniband/hw/irdma/utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
> index 5bbe44e54f9a..66711024d38b 100644
> --- a/drivers/infiniband/hw/irdma/utils.c
> +++ b/drivers/infiniband/hw/irdma/utils.c
> @@ -445,7 +445,6 @@ struct irdma_cqp_request *irdma_alloc_and_get_cqp_request(struct irdma_cqp *cqp,
>  
>  	cqp_request->waiting = wait;
>  	refcount_set(&cqp_request->refcnt, 1);
> -	memset(&cqp_request->compl_info, 0, sizeof(cqp_request->compl_info));
>  
>  	return cqp_request;
>  }
> @@ -475,6 +474,7 @@ void irdma_free_cqp_request(struct irdma_cqp *cqp,
>  		cqp_request->request_done = false;
>  		cqp_request->callback_fcn = NULL;
>  		cqp_request->waiting = false;
> +		memset(&cqp_request->compl_info, 0, sizeof(cqp_request->compl_info));
>  
>  		spin_lock_irqsave(&cqp->req_lock, flags);
>  		list_add_tail(&cqp_request->list, &cqp->cqp_avail_reqs);
> -- 
> 2.30.2
> 
