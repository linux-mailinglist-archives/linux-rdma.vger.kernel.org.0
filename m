Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA22C98114
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 19:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbfHURPE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 13:15:04 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34604 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfHURPE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Aug 2019 13:15:04 -0400
Received: by mail-qk1-f195.google.com with SMTP id m10so2513973qkk.1
        for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2019 10:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HLep7YwJTYmynxq0tyS2wjXjpj05GXr2FH8L7z2ItUU=;
        b=I5m0SnUlyCWxMxxP1kCr50mdUAAYc3OpnEOBjGG7IbUgXWGnN1WmDzRAAQCp7j9MCO
         NROmRTASjVshu+xe7Msx+8JkNnYztCFsu4GAJ9AEH5wrrhcl70oxr74olEZ4gnmscImE
         9gOs0xc12V2t6AjdJ0/pWU2k84mcAx5/ciIQeJaRMZ6RKkDJp5tJ83EeSq9TghxYN5Hm
         AdYdcmvFskh2NJzBSPrYZ+2jIueU3pwBw7oHKfo6JoM1GqZ35MIUlDceAZoPGcKNJuWJ
         YnoMaff1RxvYJA5HpNBq/k4xHg+eIDIk5oHEJFZArqAbIFmrkUVIMv7Cq4IJdVG55EIF
         0Udg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HLep7YwJTYmynxq0tyS2wjXjpj05GXr2FH8L7z2ItUU=;
        b=Prd71k9Y4Zgeda+fDhwI+TfOIHtgHFlziQSoh8VMykQTa9WADDNiL9gHW8w/xPtuuE
         nh4k8owYP9r+GokVJL+vn296sku8szxFIH+iWsHeNNWbH5WMtvc3FPyHI2hVfYpItrNv
         XYLoV0cK4vf4uAadF5mcJ5QeEJH75bEgA3Sg0Awi9hdf+SNenZCeJqft8VAz+FyKt3vZ
         WWtvuZDj9qVV0c5HdrNqV2hcY+hZ0ws/G+l/jelxc9LpEYIgWrH4Ex6LvLU4deRw4uVx
         Jbo1w5ZcteRekyZKCbT240Ft9TDBo/G1/4jJn/yScV7/etaEbgIygT99ggQb5KQC2Mni
         /PQQ==
X-Gm-Message-State: APjAAAV8XI6ackeFm3PHJdMTtX1sfyv+zAxCnpioRD2Znh6jXt2zc5yg
        JWfNYVieG0SLEhBQ2rh4LaoQRg==
X-Google-Smtp-Source: APXvYqwg3r4yYIS6SHUHAWabTJvZmuLx8NKf8ithcCWdm0GSmFsSMTy379ij3Xfx/Nb+0pISjtmNlw==
X-Received: by 2002:a37:5347:: with SMTP id h68mr19462742qkb.236.1566407703249;
        Wed, 21 Aug 2019 10:15:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id b1sm9647032qkk.8.2019.08.21.10.15.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Aug 2019 10:15:02 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i0UCM-0005zw-GF; Wed, 21 Aug 2019 14:15:02 -0300
Date:   Wed, 21 Aug 2019 14:15:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Guy Levi <guyle@mellanox.com>, Moni Shoua <monis@mellanox.com>
Subject: Re: [PATCH rdma-next 02/12] RDMA/odp: Iterate over the whole rbtree
 directly
Message-ID: <20190821171502.GA23022@ziepe.ca>
References: <20190819111710.18440-1-leon@kernel.org>
 <20190819111710.18440-3-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819111710.18440-3-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 19, 2019 at 02:17:00PM +0300, Leon Romanovsky wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> Instead of intersecting a full interval, just iterate over every element
> directly. This is faster and clearer.
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
>  drivers/infiniband/core/umem_odp.c | 51 ++++++++++++++++--------------
>  drivers/infiniband/hw/mlx5/odp.c   | 41 +++++++++++-------------
>  2 files changed, 47 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
> index 8358eb8e3a26..b9bebef00a33 100644
> +++ b/drivers/infiniband/core/umem_odp.c
> @@ -72,35 +72,41 @@ static void ib_umem_notifier_end_account(struct ib_umem_odp *umem_odp)
>  	mutex_unlock(&umem_odp->umem_mutex);
>  }
>  
> -static int ib_umem_notifier_release_trampoline(struct ib_umem_odp *umem_odp,
> -					       u64 start, u64 end, void *cookie)
> -{
> -	/*
> -	 * Increase the number of notifiers running, to
> -	 * prevent any further fault handling on this MR.
> -	 */
> -	ib_umem_notifier_start_account(umem_odp);
> -	umem_odp->dying = 1;

This patch was not applied on top of the commit noted in the cover
letter

> -	/* Make sure that the fact the umem is dying is out before we release
> -	 * all pending page faults. */
> -	smp_wmb();
> -	complete_all(&umem_odp->notifier_completion);
> -	umem_odp->umem.context->invalidate_range(
> -		umem_odp, ib_umem_start(umem_odp), ib_umem_end(umem_odp));
> -	return 0;
> -}
> -
>  static void ib_umem_notifier_release(struct mmu_notifier *mn,
>  				     struct mm_struct *mm)
>  {
>  	struct ib_ucontext_per_mm *per_mm =
>  		container_of(mn, struct ib_ucontext_per_mm, mn);
> +	struct rb_node *node;
>  
>  	down_read(&per_mm->umem_rwsem);
> -	if (per_mm->active)
> -		rbt_ib_umem_for_each_in_range(
> -			&per_mm->umem_tree, 0, ULLONG_MAX,
> -			ib_umem_notifier_release_trampoline, true, NULL);
> +	if (!per_mm->active)
> +		goto out;
> +
> +	for (node = rb_first_cached(&per_mm->umem_tree); node;
> +	     node = rb_next(node)) {
> +		struct ib_umem_odp *umem_odp =
> +			rb_entry(node, struct ib_umem_odp, interval_tree.rb);
> +
> +		/*
> +		 * Increase the number of notifiers running, to prevent any
> +		 * further fault handling on this MR.
> +		 */
> +		ib_umem_notifier_start_account(umem_odp);
> +
> +		umem_odp->dying = 1;

So this ends up as a 'rebasing error'

I fixed it

Jason
