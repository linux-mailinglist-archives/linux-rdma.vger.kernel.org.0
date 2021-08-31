Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35193FC537
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Aug 2021 11:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240743AbhHaJxU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Aug 2021 05:53:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240724AbhHaJxU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 31 Aug 2021 05:53:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8304B60295;
        Tue, 31 Aug 2021 09:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630403545;
        bh=vE7HLXrEAlCbXwAGOXyMOu7xe8UoqsW9N4CCYvjwDVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DTOhk1RC/dExqc09TaejeWq0UWBrhZHpxp35z80JtUq6c7ql9xmNGgCmRR1yvl27w
         MPRlLiQbfkyJ70+FLxjL7b6FNtvWbuO8AMpIjqKZsf1LqMX+Zk5v/MYic8ruyOfxy9
         wU9zSf/42jBLd7FFQakI8bW49CQNs0cjech+deyiFdZ+Sp6yZ6ZmUuDdlp2aLmyuld
         10Mb5qG6LuuW6yjv1Ncd9Gt1NrPTe72jBD2ZLqg3//2BpGcJ9mIMHEhyYa73GLARk1
         JwTa0Yn2dCZ1soZ6lIkFFk05qD2ytgPdNXzMwfVHYHGbVWF5m9C9ui1A3Z66H5oSSe
         LYKOUYXVVm8uw==
Date:   Tue, 31 Aug 2021 12:52:21 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     kangning <kangning18z@ict.ac.cn>
Cc:     haakon.bugge@oracle.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v3] Fix one error in mthca_alloc
Message-ID: <YS371Qgef1FTTrHZ@unreal>
References: <20210827005228.15671-1-kangning18z@ict.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827005228.15671-1-kangning18z@ict.ac.cn>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 27, 2021 at 08:52:28AM +0800, kangning wrote:
> drivers/infiniband/hw/mthca/mthca_allocator.c: alloc->last left unchanged in mthca_alloc, which
> has impact on performance of function find_next_zero_bit in mthca_alloc.

I don't know what the sentence above means, but the change is unlikely
to be correct.

When alloc->last starts to be equal to alloc->max, the
find_next_zero_bit() will always return alloc->max. which will ensure
that the following code is executed.

   48         if (obj >= alloc->max) {
   49                 alloc->top = (alloc->top + alloc->max) & alloc->mask;
   50                 obj = find_first_zero_bit(alloc->table, alloc->max);
   51         }


However the mthca_alloc() function has other error, it returns -1 while
based on its declaration it needs to be unsigned,

Thanks

> 
> Signed-off-by: kangning <kangning18z@ict.ac.cn>
> ---
>  
>  I squashed two commits into one in this version.
>  
>  drivers/infiniband/hw/mthca/mthca_allocator.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/mthca/mthca_allocator.c b/drivers/infiniband/hw/mthca/mthca_allocator.c
> index aef1d274a14e..1141695093e7 100644
> --- a/drivers/infiniband/hw/mthca/mthca_allocator.c
> +++ b/drivers/infiniband/hw/mthca/mthca_allocator.c
> @@ -51,6 +51,9 @@ u32 mthca_alloc(struct mthca_alloc *alloc)
>  	}
>  
>  	if (obj < alloc->max) {
> +		alloc->last = obj + 1;
> +		if (alloc->last == alloc->max)
> +			alloc->last = 0;
>  		set_bit(obj, alloc->table);
>  		obj |= alloc->top;
>  	} else
> -- 
> 2.17.1
> 
