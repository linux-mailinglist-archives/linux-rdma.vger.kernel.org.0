Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFACD36ABBD
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Apr 2021 07:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhDZFJj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Apr 2021 01:09:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230162AbhDZFJi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Apr 2021 01:09:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2AB861153;
        Mon, 26 Apr 2021 05:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619413734;
        bh=FB9IZe4W6KBfmEifqMgY62/Fy4ZapV8Jm17uzmJTlRo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LRLCkuPqBrdjUbLotyual5dcOE4bTL5Qnwjc0FjcoT8m1CtPfarbLtkC93348GL8y
         7dhrAZJxV12G0/BSiAGjS3LmcJdg3y5kinISGWqYwf/bqnS2EMs4DopAvmscpdpvgC
         J1X6s96BGpCu5eyek2BDAnufrZo0VgMW6zKwBhBqxkCB73DtY+iAPVWtHlSiJQngPi
         mfBH2EjO8hvz7xMRajg2tqblD6gi30SHnzxeVxMmGu3GFrOFFYwA3yuzTWusA6H+tp
         tFqRm6lr7zH/wghmBMs99tzxcZnrxibGKMMb6CDUy1xCnEYSsPW0pDGew7ZzjXY0Ut
         10j8TeIHtkx+g==
Date:   Mon, 26 Apr 2021 08:08:50 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Cc:     bmt@zurich.ibm.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rdma/siw: Fix a use after free in siw_alloc_mr
Message-ID: <YIZK4gb2qytVpMS0@unreal>
References: <20210426011647.3561-1-lyl2019@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426011647.3561-1-lyl2019@mail.ustc.edu.cn>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 25, 2021 at 06:16:47PM -0700, Lv Yunlong wrote:
> Our code analyzer reported a uaf.

Can you please share more details about this "code analyzer"?

Thanks

> 
> In siw_alloc_mr, it calls siw_mr_add_mem(mr,..). In the implementation
> of siw_mr_add_mem(), mem is assigned to mr->mem and then mem is freed
> via kfree(mem) if xa_alloc_cyclic() failed. Here, mr->mem still point
> to a freed object. After, the execution continue up to the err_out branch
> of siw_alloc_mr, and the freed mr->mem is used in siw_mr_drop_mem(mr).
> 
> My patch moves "mr->mem = mem" behind the if (xa_alloc_cyclic(..)<0) {}
> section, to avoid the uaf.
> 
> Fixes: 2251334dcac9e ("rdma/siw: application buffer management")
> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> ---
>  drivers/infiniband/sw/siw/siw_mem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
> index 34a910cf0edb..96b38cfbb513 100644
> --- a/drivers/infiniband/sw/siw/siw_mem.c
> +++ b/drivers/infiniband/sw/siw/siw_mem.c
> @@ -106,8 +106,6 @@ int siw_mr_add_mem(struct siw_mr *mr, struct ib_pd *pd, void *mem_obj,
>  	mem->perms = rights & IWARP_ACCESS_MASK;
>  	kref_init(&mem->ref);
>  
> -	mr->mem = mem;
> -
>  	get_random_bytes(&next, 4);
>  	next &= 0x00ffffff;
>  
> @@ -116,6 +114,8 @@ int siw_mr_add_mem(struct siw_mr *mr, struct ib_pd *pd, void *mem_obj,
>  		kfree(mem);
>  		return -ENOMEM;
>  	}
> +
> +	mr->mem = mem;
>  	/* Set the STag index part */
>  	mem->stag = id << 8;
>  	mr->base_mr.lkey = mr->base_mr.rkey = mem->stag;
> -- 
> 2.25.1
> 
> 
