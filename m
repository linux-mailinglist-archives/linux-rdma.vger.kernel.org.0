Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14DF6217290
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 17:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgGGPhX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 11:37:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728246AbgGGPhX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 Jul 2020 11:37:23 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2417A206F6;
        Tue,  7 Jul 2020 15:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594136242;
        bh=GOErlGGphj9PiHoO31Lwnox/KyRMld47W8W4+191Y1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L7ZjzdbiUmIadeFFj9LLQ/0dl23ayW2MMHpsTmTXS4JiNuS3yMM53F8X/6AnGJjKi
         BSKDP3eetCl24bYdxBHgbNIATIOzS2VBg0VOlqWAAcoKIdNM0GvwCGPgd2rQ1xQ7U0
         j6IzhUmzBzYAO2iixcW2uKA9LnZ0i6Ld0093xBeI=
Date:   Tue, 7 Jul 2020 18:37:18 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc v1] RDMA/mlx5: Use xa_lock_irq when access to SRQ
 table
Message-ID: <20200707153718.GO207186@unreal>
References: <20200707131551.1153207-1-leon@kernel.org>
 <20200707134258.GL25523@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707134258.GL25523@casper.infradead.org>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 07, 2020 at 02:42:58PM +0100, Matthew Wilcox wrote:
> On Tue, Jul 07, 2020 at 04:15:51PM +0300, Leon Romanovsky wrote:
> > +++ b/drivers/infiniband/hw/mlx5/srq_cmd.c
> > @@ -83,11 +83,11 @@ struct mlx5_core_srq *mlx5_cmd_get_srq(struct mlx5_ib_dev *dev, u32 srqn)
> >  	struct mlx5_srq_table *table = &dev->srq_table;
> >  	struct mlx5_core_srq *srq;
> >
> > -	xa_lock(&table->array);
> > +	xa_lock_irq(&table->array);
> >  	srq = xa_load(&table->array, srqn);
> >  	if (srq)
> >  		refcount_inc(&srq->common.refcount);
> > -	xa_unlock(&table->array);
> > +	xa_unlock_irq(&table->array);
>
> This one is correct.
>
> > @@ -655,11 +655,11 @@ static int srq_event_notifier(struct notifier_block *nb,
> >  	eqe = data;
> >  	srqn = be32_to_cpu(eqe->data.qp_srq.qp_srq_n) & 0xffffff;
> >
> > -	xa_lock(&table->array);
> > +	xa_lock_irq(&table->array);
> >  	srq = xa_load(&table->array, srqn);
> >  	if (srq)
> >  		refcount_inc(&srq->common.refcount);
> > -	xa_unlock(&table->array);
> > +	xa_unlock_irq(&table->array);
>
> This one is not.  srq_event_notifier() is called in irq context, always,
> so leave it as xa_lock() / xa_unlock().
>
> You could switch to a less-locked model, which would look something like this:
>
> 	rcu_read_lock();
> 	srq = xa_load(&table->array, srqn);
> 	if (srq && !refcount_inc_not_zero(&srq->common.refcount))
> 		srq = NULL;
> 	rcu_read_unlock();
>
> Then you wouldn't need to disable irqs while accessing the array.
> But you would need to rcu-free the srqs.

Thanks for your feedback,
At this point of time, we don't need rcu_* optimization, it is not
bottleneck yet :).

Thanks

