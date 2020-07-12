Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB49421C9DB
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2020 16:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgGLOdM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 Jul 2020 10:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbgGLOdM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 12 Jul 2020 10:33:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1574C061794
        for <linux-rdma@vger.kernel.org>; Sun, 12 Jul 2020 07:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XfAGWHscjqU5UdFyf7uI9KuxXHXIqASbBjUC15OhGbc=; b=dz1pk1nWolyuO22wjGeed+gGyN
        YM0H5BdZaNe2K/kJRz1tJQ/hs/m7wGzEjl2+4rXeFe9OM4bWfl7LyEGV3AVSFH1qy4gsbkYXqIGzH
        NAkCRuRxjJ+VDW+2WHh74izW+5QKF9h+uoCNcZCsr7ESLcQi9Fu409WicfEfsJcgGKtokjANZpZLD
        j/s5OcCvB2EYBqXOV0NF/szO/ppyTPazTs7hmzP5vo1FQ83aImAoF12cbZTVPCgU6ZFojUx+1T9+0
        9KYhHPLy2J9WiUdFGt5z3YyxWCBTndl4PGb3tbPYiwYtuBg6kdeQ8gAivhc33+vPUAkSrphKaDyNZ
        s6hHM+oQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jud2Q-0003wa-6F; Sun, 12 Jul 2020 14:33:06 +0000
Date:   Sun, 12 Jul 2020 15:33:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc v2] RDMA/mlx5: Use xa_lock_irq when access to SRQ
 table
Message-ID: <20200712143306.GT12769@casper.infradead.org>
References: <20200712102641.15210-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200712102641.15210-1-leon@kernel.org>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 12, 2020 at 01:26:41PM +0300, Leon Romanovsky wrote:
> Fixes: b02a29eb8841 ("mlx5: Convert mlx5_srq_table to XArray")
> Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
> v2:
>  * Dropped wrong hunk
> v1:
> https://lore.kernel.org/linux-rdma/20200707131551.1153207-1-leon@kernel.org
>  * I left Fixes as before to make sure that it is taken properly to stable@.
>  * xa_lock_irqsave -> xa_lock_irq

But it won't be taken properly to stable.  It's true that that's the
earliest version that this applies to, but as far as I can tell the
underlying bug is there a lot earlier.  It doesn't appear to be there
in e126ba97dba9edeb6fafa3665b5f8497fc9cdf8c as the cq->lock is taken
irqsafe in mlx5_ib_poll_cq() before calling mlx5_poll_one() which calls
handle_responder() which calls mlx5_core_get_srq(), but it was there
before b02a29eb8841.  I think it's up to you to figure out which version
this bug was introduced in, because stable still cares about trees before
5.2 (which is when b02a29eb8841 was introduced).  You'll also have to
produce a patch for those earlier kernels.

> v0:
> https://lore.kernel.org/linux-rdma/20200707110612.882962-2-leon@kernel.org
> ---
>  drivers/infiniband/hw/mlx5/srq_cmd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/srq_cmd.c b/drivers/infiniband/hw/mlx5/srq_cmd.c
> index 6f5eadc4d183..37aaacebd3f2 100644
> --- a/drivers/infiniband/hw/mlx5/srq_cmd.c
> +++ b/drivers/infiniband/hw/mlx5/srq_cmd.c
> @@ -83,11 +83,11 @@ struct mlx5_core_srq *mlx5_cmd_get_srq(struct mlx5_ib_dev *dev, u32 srqn)
>  	struct mlx5_srq_table *table = &dev->srq_table;
>  	struct mlx5_core_srq *srq;
> 
> -	xa_lock(&table->array);
> +	xa_lock_irq(&table->array);
>  	srq = xa_load(&table->array, srqn);
>  	if (srq)
>  		refcount_inc(&srq->common.refcount);
> -	xa_unlock(&table->array);
> +	xa_unlock_irq(&table->array);
> 
>  	return srq;
>  }
> --
> 2.26.2
> 
