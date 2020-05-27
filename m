Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1331E4B3E
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2020 18:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgE0Q7x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 May 2020 12:59:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726978AbgE0Q7x (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 27 May 2020 12:59:53 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EA7D20787;
        Wed, 27 May 2020 16:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590598792;
        bh=8q3jzRDqvsoIvtRypUgXiAuysDm2k8ZTq2KJ7ICZPRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z77S30Je4HHzBgmSeOMM5AkkIP9p2ZWVnR1YCItAVSijnC3ewxIAhnj4y6a7BFShF
         oVmmFix+NS1cuwy3CS3KaXU+1NDVM9WU/LpvdyBu+0MVkGUW22ehQhyost2GOK3xwX
         ecWkKtocFqtDNsj74hCZQKktsfHUG2Dxm/fsqNk0=
Date:   Wed, 27 May 2020 12:04:47 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] IB/core: Use sizeof_field() helper
Message-ID: <20200527170447.GA18738@embeddedor>
References: <20200527144152.GA22605@embeddedor>
 <20200527164452.GQ744@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527164452.GQ744@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 27, 2020 at 01:44:52PM -0300, Jason Gunthorpe wrote:
> On Wed, May 27, 2020 at 09:41:52AM -0500, Gustavo A. R. Silva wrote:
> > Make use of the sizeof_field() helper instead of an open-coded version.
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  drivers/infiniband/core/sa_query.c     | 8 ++++----
> >  drivers/infiniband/core/uverbs_cmd.c   | 2 +-
> >  drivers/infiniband/core/uverbs_ioctl.c | 2 +-
> >  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> What kind of tool are you using for this? It seems to miss a lot, I
> added in a few others to this patch and applied it, thanks:
> 

Hi Jason,

I was just doing a "terrain recognition" with grep. I certainly
wasn't expecting spaces between the sizeof operator and the opening
parenthesis: "sizeof ((struct ib_sa_mcmember_rec *) 0)->field".

Also, I was just running grep in drivers/infiniband/

I'll run a cocci script next time...

Thanks for your feedback. :)
--
Gustavo

> diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
> index 8f70c5c38ab7c3..a2ed09a3c714a9 100644
> --- a/drivers/infiniband/core/sa_query.c
> +++ b/drivers/infiniband/core/sa_query.c
> @@ -420,7 +420,7 @@ static const struct ib_field opa_path_rec_table[] = {
>  
>  #define MCMEMBER_REC_FIELD(field) \
>  	.struct_offset_bytes = offsetof(struct ib_sa_mcmember_rec, field),	\
> -	.struct_size_bytes   = sizeof ((struct ib_sa_mcmember_rec *) 0)->field,	\
> +	.struct_size_bytes   = sizeof_field(struct ib_sa_mcmember_rec, field),	\
>  	.field_name          = "sa_mcmember_rec:" #field
>  
>  static const struct ib_field mcmember_rec_table[] = {
> @@ -504,7 +504,7 @@ static const struct ib_field mcmember_rec_table[] = {
>  
>  #define SERVICE_REC_FIELD(field) \
>  	.struct_offset_bytes = offsetof(struct ib_sa_service_rec, field),	\
> -	.struct_size_bytes   = sizeof ((struct ib_sa_service_rec *) 0)->field,	\
> +	.struct_size_bytes   = sizeof_field(struct ib_sa_service_rec, field),	\
>  	.field_name          = "sa_service_rec:" #field
>  
>  static const struct ib_field service_rec_table[] = {
> @@ -710,7 +710,7 @@ static const struct ib_field opa_classport_info_rec_table[] = {
>  
>  #define GUIDINFO_REC_FIELD(field) \
>  	.struct_offset_bytes = offsetof(struct ib_sa_guidinfo_rec, field),	\
> -	.struct_size_bytes   = sizeof((struct ib_sa_guidinfo_rec *) 0)->field,	\
> +	.struct_size_bytes   = sizeof_field(struct ib_sa_guidinfo_rec, field),	\
>  	.field_name          = "sa_guidinfo_rec:" #field
>  
>  static const struct ib_field guidinfo_rec_table[] = {
> diff --git a/drivers/infiniband/core/ud_header.c b/drivers/infiniband/core/ud_header.c
> index 29a45d2f8898e1..d65d541b9a2587 100644
> --- a/drivers/infiniband/core/ud_header.c
> +++ b/drivers/infiniband/core/ud_header.c
> @@ -41,7 +41,7 @@
>  
>  #define STRUCT_FIELD(header, field) \
>  	.struct_offset_bytes = offsetof(struct ib_unpacked_ ## header, field),      \
> -	.struct_size_bytes   = sizeof ((struct ib_unpacked_ ## header *) 0)->field, \
> +	.struct_size_bytes   = sizeof_field(struct ib_unpacked_ ## header, field), \
>  	.field_name          = #header ":" #field
>  
>  static const struct ib_field lrh_table[]  = {
> diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
> index 5bd2b037e9147c..0418d7bddf3e0c 100644
> --- a/include/rdma/uverbs_ioctl.h
> +++ b/include/rdma/uverbs_ioctl.h
> @@ -420,9 +420,9 @@ struct uapi_definition {
>  		.scope = UAPI_SCOPE_OBJECT,                                    \
>  		.needs_fn_offset =                                             \
>  			offsetof(struct ib_device_ops, ibdev_fn) +             \
> -			BUILD_BUG_ON_ZERO(                                     \
> -			    sizeof(((struct ib_device_ops *)0)->ibdev_fn) !=   \
> -			    sizeof(void *)),				       \
> +			BUILD_BUG_ON_ZERO(sizeof_field(struct ib_device_ops,   \
> +						       ibdev_fn) !=            \
> +					  sizeof(void *)),                     \
>  	}
>  
>  /*
> @@ -435,9 +435,9 @@ struct uapi_definition {
>  		.scope = UAPI_SCOPE_METHOD,                                    \
>  		.needs_fn_offset =                                             \
>  			offsetof(struct ib_device_ops, ibdev_fn) +             \
> -			BUILD_BUG_ON_ZERO(                                     \
> -			    sizeof(((struct ib_device_ops *)0)->ibdev_fn) !=   \
> -			    sizeof(void *)),                                   \
> +			BUILD_BUG_ON_ZERO(sizeof_field(struct ib_device_ops,   \
> +						       ibdev_fn) !=            \
> +					  sizeof(void *)),                     \
>  	}
>  
>  /* Call a function to determine if the entire object is supported or not */
