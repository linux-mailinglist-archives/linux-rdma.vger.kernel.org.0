Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D9536A793
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Apr 2021 15:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhDYNuU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 25 Apr 2021 09:50:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230214AbhDYNuU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 25 Apr 2021 09:50:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E5F761363;
        Sun, 25 Apr 2021 13:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619358580;
        bh=DGguM+dXVFEHhxP7ffgIr3ztEhgYe2f/QSBnkIvEibg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QcdMxScWzLppYu6Iki2rSJNfB9zAS7qdSTLw6JxFGaxv9tJQc7z5EYcxMqJZQ1ynd
         4BTi3TSmsEUfHXh6hTDVqYuAEsmKY8ZbDJfIUl7FhiHsy6EuxQa7VmIuXkewgIAeg6
         jMnX4UBU3TBE7frm0bLeSt+cou2Cyk041SgCsFS/gT2AvSyoVUbBNfBXkfiWiMG5mO
         zrgM7/V8Y6n+X/x2JHmdJkqeOep+kQXzxgRkKchJpsV8xyNuZwRUNcDDOEx9WVBuVs
         rcW0HTPPP/1430SRaa3sHHMSh1tq5x1Bt8QPF+X4Go3dtW7Yu4Ja4B5tebdvMQJddJ
         hatRqgoAuxOcA==
Date:   Sun, 25 Apr 2021 16:49:36 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Cc:     bmt@zurich.ibm.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rdma/siw: Fix a use after free in siw_alloc_mr
Message-ID: <YIVzcBMCtvlFov4W@unreal>
References: <20210425132001.3994-1-lyl2019@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210425132001.3994-1-lyl2019@mail.ustc.edu.cn>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 25, 2021 at 06:20:01AM -0700, Lv Yunlong wrote:
> Our code analyzer reported a uaf.
> 
> In siw_alloc_mr, it calls siw_mr_add_mem(mr,..). In the implementation
> of siw_mr_add_mem(), mem is assigned to mr->mem and then mem is freed
> via kfree(mem) if xa_alloc_cyclic() failed. Here, mr->mem still point
> to a freed object. After, the execution continue up to the err_out branch
> of siw_alloc_mr, and the freed mr->mem is used in siw_mr_drop_mem(mr).
> 
> Fixes: 2251334dcac9e ("rdma/siw: application buffer management")
> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> ---
>  drivers/infiniband/sw/siw/siw_mem.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
> index 34a910cf0edb..3bde3b6fca05 100644
> --- a/drivers/infiniband/sw/siw/siw_mem.c
> +++ b/drivers/infiniband/sw/siw/siw_mem.c
> @@ -114,6 +114,7 @@ int siw_mr_add_mem(struct siw_mr *mr, struct ib_pd *pd, void *mem_obj,
>  	if (xa_alloc_cyclic(&sdev->mem_xa, &id, mem, limit, &next,
>  	    GFP_KERNEL) < 0) {
>  		kfree(mem);
> +		mr->mem = NULL;
>  		return -ENOMEM;
>  	}

Please move "mr->mem = mem;" assignment to be here, after if (...) {} section.

Thanks

>  	/* Set the STag index part */
> -- 
> 2.25.1
> 
> 
