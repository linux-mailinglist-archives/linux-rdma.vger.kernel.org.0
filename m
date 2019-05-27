Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80A792B47D
	for <lists+linux-rdma@lfdr.de>; Mon, 27 May 2019 14:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfE0MLg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 May 2019 08:11:36 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43171 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfE0MLg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 May 2019 08:11:36 -0400
Received: by mail-qk1-f194.google.com with SMTP id z6so17462142qkl.10
        for <linux-rdma@vger.kernel.org>; Mon, 27 May 2019 05:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jpepDAiOfooZ2W/aqljI7e5sq65GV2b3V3Fu4V24Ddw=;
        b=Zbf33k01eqbdwby+TshXg/L+FwiTGPUhYISq5z9bZFYZatCZqyvEilg3SUFhoJENcE
         geyUvfo6cW473LULUTtvNeXzKb+xC5CTZgLKuUkujhZ+TQNz3Hwfbsiom7TOYoUVmAkZ
         780EY8LwZCNBaJ0CNyc21zLXGLKE656q4NSnYGObf1EwnkoVJ0+lDhB7d5CAf82qH1lG
         dbP9BtmGu/eAavDt6uIDvD8RP/wK709d25aBflgiTp24G/wHZAGpK2S9s985TNPhRxsu
         hBoCKTFOqEUN1YmisgIwDgeI9JSOPEdD0ovMM6mbENgO4AMO4kFmh9cE+vM8qqNniBFF
         pBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jpepDAiOfooZ2W/aqljI7e5sq65GV2b3V3Fu4V24Ddw=;
        b=jRMTjkYS/3k7cy7dZRvmhA9nqF1rcBLngm+uhpHLpMWtqmRlCF7UVT3PC1OY6H5dRk
         Bq2EdjScvfvt4vg22NTff3CkzIRwkhoHEX/gtBkDjyVn2OeCuLgqqLAniIN7dnylGXuY
         gslrlIspeHg9IHGZemI2UAjBuQe+rVRDZCI92UkchNX/jZhcJtQ9RsMD7hJmVuTNDvVb
         uf2nSLQddVilkZUZ8GZrDsH3iJxodhf9/o63GP+d0FjlWuY1hXzoleQt2Nao/gr54rWJ
         gVmOCV5cyajIZkotDOwHRAOt2x3SvkTUak9WMKpvsCH58nun0RVMyxWffaMkbbp8lypZ
         iFPQ==
X-Gm-Message-State: APjAAAWAH6SnRghVMd48VhhD4W/E1MBocjIyAKwrkMzCZnTGFOGS9sn1
        9mIEK9pJjCh9Kl8Tz7udHFL+7Q==
X-Google-Smtp-Source: APXvYqzNruqVgn0KqfX5swUHSoak+kDt+/oBzLQgF7qANcxrj08dD0+QGmmJcxsN5T9WZe1H6SASdg==
X-Received: by 2002:ac8:24f5:: with SMTP id t50mr5600620qtt.285.1558959095587;
        Mon, 27 May 2019 05:11:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id p64sm224812qkf.60.2019.05.27.05.11.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 05:11:35 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hVETW-0003bl-Jt; Mon, 27 May 2019 09:11:34 -0300
Date:   Mon, 27 May 2019 09:11:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yuval Shaia <yuval.shaia@oracle.com>
Cc:     yishaih@mellanox.com, dledford@redhat.com, leon@kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [RFC] verbs: Introduce a new reg_mr API for virtual address space
Message-ID: <20190527121134.GC8519@ziepe.ca>
References: <20190526080224.2778-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526080224.2778-1-yuval.shaia@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 26, 2019 at 11:02:24AM +0300, Yuval Shaia wrote:
> The virtual address that is registered is used as a base for any address
> used later in post_recv and post_send operations.
> 
> On a virtualised environment this is not correct.
> 
> A guest cannot register its memory so hypervisor maps the guest physical
> address to a host virtual address and register it with the HW. Later on,
> at datapath phase, the guest fills the SGEs with addresses from its
> address space.
> Since HW cannot access guest virtual address space an extra translation
> is needed map those addresses to be based on the host virtual address
> that was registered with the HW.
> 
> To avoid this, a logical separation between the address that is
> registered and the address that is used as a offset at datapath phase is
> needed.
> This separation is already implemented in the lower layer part
> (ibv_cmd_reg_mr) but blocked at the API level.
> 
> Fix it by introducing a new API function that accepts a address from
> guest virtual address space as well.
> 
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
>  libibverbs/driver.h    |  3 +++
>  libibverbs/dummy_ops.c | 10 ++++++++++
>  libibverbs/verbs.h     | 26 ++++++++++++++++++++++++++
>  providers/rxe/rxe.c    | 16 ++++++++++++----
>  4 files changed, 51 insertions(+), 4 deletions(-)
> 
> diff --git a/libibverbs/driver.h b/libibverbs/driver.h
> index e4d624b2..73bc10e6 100644
> +++ b/libibverbs/driver.h
> @@ -339,6 +339,9 @@ struct verbs_context_ops {
>  				    unsigned int access);
>  	struct ibv_mr *(*reg_mr)(struct ibv_pd *pd, void *addr, size_t length,
>  				 int access);
> +	struct ibv_mr *(*reg_mr_virt_as)(struct ibv_pd *pd, void *addr,
> +					 size_t length, uint64_t hca_va,
> +					 int access);

I don't want to see a new entry point, all HW already supports it, so
we should just add the hca_va to the main one and remove the
assumption that the void *addr should be used as the hca_va from the
drivers.


>  	int (*req_notify_cq)(struct ibv_cq *cq, int solicited_only);
>  	int (*rereg_mr)(struct verbs_mr *vmr, int flags, struct ibv_pd *pd,
>  			void *addr, size_t length, int access);
> diff --git a/libibverbs/dummy_ops.c b/libibverbs/dummy_ops.c
> index c861c3a0..aab61a17 100644
> +++ b/libibverbs/dummy_ops.c
> @@ -416,6 +416,14 @@ static struct ibv_mr *reg_mr(struct ibv_pd *pd, void *addr, size_t length,
>  	return NULL;
>  }
>  
> +static struct ibv_mr *reg_mr_virt_as(struct ibv_pd *pd, void *addr,
> +				     size_t length, uint64_t hca_va,
> +				     int access)
> +{
> +	errno = ENOSYS;

> +	return NULL;
> +}
> +
>  static int req_notify_cq(struct ibv_cq *cq, int solicited_only)
>  {
>  	return ENOSYS;
> @@ -508,6 +516,7 @@ const struct verbs_context_ops verbs_dummy_ops = {
>  	read_counters,
>  	reg_dm_mr,
>  	reg_mr,
> +	reg_mr_virt_as,
>  	req_notify_cq,
>  	rereg_mr,
>  	resize_cq,
> @@ -623,6 +632,7 @@ void verbs_set_ops(struct verbs_context *vctx,
>  	SET_PRIV_OP(ctx, query_srq);
>  	SET_OP(vctx, reg_dm_mr);
>  	SET_PRIV_OP(ctx, reg_mr);
> +	SET_OP(vctx, reg_mr_virt_as);
>  	SET_OP(ctx, req_notify_cq);
>  	SET_PRIV_OP(ctx, rereg_mr);
>  	SET_PRIV_OP(ctx, resize_cq);
> diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
> index cb2d8439..8bcc8388 100644
> +++ b/libibverbs/verbs.h
> @@ -2037,6 +2037,9 @@ struct verbs_context {
>  	struct ibv_mr *(*reg_dm_mr)(struct ibv_pd *pd, struct ibv_dm *dm,
>  				    uint64_t dm_offset, size_t length,
>  				    unsigned int access);
> +	struct ibv_mr *(*reg_mr_virt_as)(struct ibv_pd *pd, void *addr,
> +					 size_t length, uint64_t hca_va,
> +					 int access);

Can't add new functions here, breaks the ABI

Jason
