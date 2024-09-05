Return-Path: <linux-rdma+bounces-4772-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E01F96D6B5
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Sep 2024 13:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C084B1C25416
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Sep 2024 11:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB4A1991D9;
	Thu,  5 Sep 2024 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2mq/qRN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0A9189913;
	Thu,  5 Sep 2024 11:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725534379; cv=none; b=RPaTO40evzKt1UxHOgKyc6fOv+YlojY/YVY6+n2ty8V41ldtVF0SgDW5uOZHeqWQxn81SBiImj0HfmmkrFvFxaS0ci5qag5Zj6jDBLU849toaTxxU3XHh97otTdijz7K3JfdOzV64Ck06FjP5ZY6vahj4XiQMmJAXuJ37WwXlgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725534379; c=relaxed/simple;
	bh=mXm3vLF7Xuh4dzhKD4FomDaVEt4SbJF7YWiZC5GCATQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oR4j7ze3Jq8U/NizYtqeUUe7DyaGHZMau6cuMJqZjhBD+KhfqX9gv2Rvv3KALSPDOgGFgHydMiCOmVKtf5RVG5GSDxUIiPaxfEb+DVpTaFwExuaeyJ8ZhphRVmW6Oc3gZG1nG/CusBGKUM8QW3A/ncylamFkBeMfx2vazDnhQDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2mq/qRN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC8FC4CEC3;
	Thu,  5 Sep 2024 11:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725534379;
	bh=mXm3vLF7Xuh4dzhKD4FomDaVEt4SbJF7YWiZC5GCATQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B2mq/qRN/Z70OYMD2rx1NZbnBWRU9YUSBkGrmw5L+9WzF8P5jVXuBZPoi9fGb27jW
	 4sisdrwtT9a+7J9dD+vMDQ4x6saVdjxHeLQKfE9VGGJGz067D5SgB64nTAPTnVYsO+
	 GOOgZOO0Ot0Vcgj04y0rNPxFfd9n61CcozjrWAO6zG6w27HPOHYNULV82jl04e5A2C
	 HTawa+Egcti/ins5/wtzxvdYlu6oa8SKBpxuIQSbOh5aS+kg64pmtQPKDY4aoWgLBi
	 IIvZcuq6DsNNmgtfDn6+bvFvRUUCGAJ7L9Y30o1jL/kJprJyBVatUqRt7r/G3eYbO0
	 C7AvbliWnugvA==
Date: Thu, 5 Sep 2024 14:06:15 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Yu Jiaoliang <yujiaoliang@vivo.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Erick Archer <erick.archer@gmx.com>,
	Akiva Goldberger <agoldberger@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Mark Zhang <markzhang@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Rohit Chavan <roheetchavan@gmail.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Shigeru Yoshida <syoshida@redhat.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1 rdma-next] RDMA/core: Use ERR_CAST to return an
 error-valued pointer
Message-ID: <20240905110615.GU4026@unreal>
References: <20240905093445.1186581-1-yujiaoliang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905093445.1186581-1-yujiaoliang@vivo.com>

On Thu, Sep 05, 2024 at 05:34:40PM +0800, Yu Jiaoliang wrote:
> Instead of directly casting and returning (void *) pointer, use ERR_CAST
> to explicitly return an error-valued pointer. This makes the error handling
> more explicit and improves code clarity.
> 
> Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
> ---
>  drivers/infiniband/core/mad_rmpp.c   | 2 +-
>  drivers/infiniband/core/uverbs_cmd.c | 2 +-
>  drivers/infiniband/core/verbs.c      | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

I see other places in the code that could benefit from this change.
Please do it for whole drivers/infiniband and group the patches.

Thanks

> 
> diff --git a/drivers/infiniband/core/mad_rmpp.c b/drivers/infiniband/core/mad_rmpp.c
> index 8af0619a39cd..b4b10e8a6495 100644
> --- a/drivers/infiniband/core/mad_rmpp.c
> +++ b/drivers/infiniband/core/mad_rmpp.c
> @@ -158,7 +158,7 @@ static struct ib_mad_send_buf *alloc_response_msg(struct ib_mad_agent *agent,
>  	ah = ib_create_ah_from_wc(agent->qp->pd, recv_wc->wc,
>  				  recv_wc->recv_buf.grh, agent->port_num);
>  	if (IS_ERR(ah))
> -		return (void *) ah;
> +		return ERR_CAST(ah);
>  
>  	hdr_len = ib_get_mad_data_offset(recv_wc->recv_buf.mad->mad_hdr.mgmt_class);
>  	msg = ib_create_send_mad(agent, recv_wc->wc->src_qp,
> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> index 1b3ea71f2c33..35a83825f6ba 100644
> --- a/drivers/infiniband/core/uverbs_cmd.c
> +++ b/drivers/infiniband/core/uverbs_cmd.c
> @@ -192,7 +192,7 @@ _ib_uverbs_lookup_comp_file(s32 fd, struct uverbs_attr_bundle *attrs)
>  					       fd, attrs);
>  
>  	if (IS_ERR(uobj))
> -		return (void *)uobj;
> +		return ERR_CAST(uobj);
>  
>  	uverbs_uobject_get(uobj);
>  	uobj_put_read(uobj);
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> index 473ee0831307..77268cce4d31 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -572,7 +572,7 @@ struct ib_ah *rdma_create_ah(struct ib_pd *pd, struct rdma_ah_attr *ah_attr,
>  					   GFP_KERNEL : GFP_ATOMIC);
>  	if (IS_ERR(slave)) {
>  		rdma_unfill_sgid_attr(ah_attr, old_sgid_attr);
> -		return (void *)slave;
> +		return ERR_CAST(slave);
>  	}
>  	ah = _rdma_create_ah(pd, ah_attr, flags, NULL, slave);
>  	rdma_lag_put_ah_roce_slave(slave);
> -- 
> 2.34.1
> 

