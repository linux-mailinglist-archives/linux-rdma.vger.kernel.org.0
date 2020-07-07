Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423E4216DF6
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 15:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgGGNnF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 09:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgGGNnE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jul 2020 09:43:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D51C061755
        for <linux-rdma@vger.kernel.org>; Tue,  7 Jul 2020 06:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/X2uPTHs29vQRA39lL56UGAq6AeXykZeIyRMWg3flFE=; b=kkoyTwlulAXA8yV8J4WKwGO4ls
        QPnw1GfhYUEfQXmxaf6Z/jbVLHV/3ERP6RbBosgYr2XJiiAYWBN2utZ4M/1DICBbOfBaDXEDSV5sO
        8yG5eVQ65yMEHK7JqiQFY9Q58vuwL408oBGtEYKn503oPBMkLb4w3N7zk0VJSetG7Z/bsxU1nR5vR
        SNt9fbs5Ft4oYZ46eb+LOt2ji6Qp+rAOmYmk9j1m3GIjfobCkhnHrdCMGkAJ5mrHoGhqOnNcqYaW+
        hYUrp3b05SNKZwneSjlSYyzhLJPTHkd7uslMCTk4C/yOGwl3quxo5s3bU6SAWylZ9mle0n1c4GABm
        f8cpfwlg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsnsA-0007AW-6G; Tue, 07 Jul 2020 13:42:58 +0000
Date:   Tue, 7 Jul 2020 14:42:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc v1] RDMA/mlx5: Use xa_lock_irq when access to SRQ
 table
Message-ID: <20200707134258.GL25523@casper.infradead.org>
References: <20200707131551.1153207-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707131551.1153207-1-leon@kernel.org>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 07, 2020 at 04:15:51PM +0300, Leon Romanovsky wrote:
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

This one is correct.

> @@ -655,11 +655,11 @@ static int srq_event_notifier(struct notifier_block *nb,
>  	eqe = data;
>  	srqn = be32_to_cpu(eqe->data.qp_srq.qp_srq_n) & 0xffffff;
> 
> -	xa_lock(&table->array);
> +	xa_lock_irq(&table->array);
>  	srq = xa_load(&table->array, srqn);
>  	if (srq)
>  		refcount_inc(&srq->common.refcount);
> -	xa_unlock(&table->array);
> +	xa_unlock_irq(&table->array);

This one is not.  srq_event_notifier() is called in irq context, always,
so leave it as xa_lock() / xa_unlock().

You could switch to a less-locked model, which would look something like this:

	rcu_read_lock();
	srq = xa_load(&table->array, srqn);
	if (srq && !refcount_inc_not_zero(&srq->common.refcount))
		srq = NULL;
	rcu_read_unlock();

Then you wouldn't need to disable irqs while accessing the array.
But you would need to rcu-free the srqs.
