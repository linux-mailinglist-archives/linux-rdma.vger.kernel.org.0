Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 193B4427E3
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 15:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfFLNon (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 09:44:43 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39633 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfFLNom (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jun 2019 09:44:42 -0400
Received: by mail-qt1-f193.google.com with SMTP id i34so18532644qta.6
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jun 2019 06:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6ToCLfp+GJ2SoCyIUmTjSZUsEtVlTwakkuPkowLYTtU=;
        b=oPoqIUAdpxkpX7NkxsWgRA/Nn/51gabG1ZYypkPG65reDNFgjGFp3+IDO7aFuu05bd
         StyrDCgKK7OH1Mo6X/Bkyg3T2URUjbHjNsktZfjwL4dVE2arOE/drX2ZBVwmxJqksvSz
         G+sDikltyT9Atvg1BcB70J2hyGEDCpKVj7e2HwA7wlFQp0kLF0+gXxQ9x9yyh/RQVO6q
         /7Y7WWckDtgrNgsZ5HFxtq5FuUN9gyby2YKH+MnVMtLvBCFojEP0IImKO4Jtjvc4x06q
         5FKOhUxkDO+UPhJ6pAy9amddCZ1mpdWAdM+V1ik+ojXUvRn6d5EmBJotgyLLDbCqa7Gp
         Uebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6ToCLfp+GJ2SoCyIUmTjSZUsEtVlTwakkuPkowLYTtU=;
        b=nScgBqxqX+fiB+gie8JhsRwCRZ9QMhGWmFGkBGivV1QhLr6wUR8HQUUj2JMcciNECU
         7Bq19LGi7xtwujH2ShIrkNxodsif9tBQsjy+yvdugHXYkcLm7ZQmDlWy3ojLXXeJpd/7
         GjmNJyHURQy7+3yjq9Be12JiItqjRtWaG1MH31g0k19VjrnzL46AAp9+U2D+ObQ5EOa0
         5OpJhwUNkZ33YQK6E67RB2LuUjS0y3V1uAjw9DK2qLlAZOSSTdjdCuWjxxZIy+sgRHeB
         P17G3wy5DpI6pCMu4racKJWKNghzGzmg4ZjpTE3RXLqJkJcUeTOMTTMXhAKWkRAygAPG
         OmpA==
X-Gm-Message-State: APjAAAWlBlQGLw+ocw6EMm5nGr0aSVbPKHOzCjn/urYUlfKOXqYFvYlk
        yNDlPYfmaa4BbkH1u2gA6nLucA==
X-Google-Smtp-Source: APXvYqyBGq+LzQOg9u3Wy0L+tCV4KN75sjF8qLqyXKYqSCNa+nugdxs8j6kPZm+GnOWy8eOZ2biLxA==
X-Received: by 2002:ac8:3fa1:: with SMTP id d30mr63680174qtk.54.1560347081380;
        Wed, 12 Jun 2019 06:44:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id f25sm5436861qta.81.2019.06.12.06.44.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 06:44:40 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hb3YO-0003Bk-BA; Wed, 12 Jun 2019 10:44:40 -0300
Date:   Wed, 12 Jun 2019 10:44:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Mark Zhang <markz@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH rdma-next v3 09/17] IB/mlx5: Support statistic q counter
 configuration
Message-ID: <20190612134440.GF3876@ziepe.ca>
References: <20190606105345.8546-1-leon@kernel.org>
 <20190606105345.8546-10-leon@kernel.org>
 <20190611175419.GA19838@ziepe.ca>
 <285c454e-2a20-d9e0-56a4-7738dd375d17@mellanox.com>
 <20190612120802.GE3876@ziepe.ca>
 <20190612121227.GQ6369@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612121227.GQ6369@mtr-leonro.mtl.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 12, 2019 at 03:12:27PM +0300, Leon Romanovsky wrote:
> On Wed, Jun 12, 2019 at 09:08:02AM -0300, Jason Gunthorpe wrote:
> > On Wed, Jun 12, 2019 at 12:01:23PM +0000, Mark Zhang wrote:
> > > On 6/12/2019 1:54 AM, Jason Gunthorpe wrote:
> > > > On Thu, Jun 06, 2019 at 01:53:37PM +0300, Leon Romanovsky wrote:
> > > >> From: Mark Zhang <markz@mellanox.com>
> > > >>
> > > >> Add support for ib callbacks counter_bind_qp() and counter_unbind_qp().
> > > >>
> > > >> Signed-off-by: Mark Zhang <markz@mellanox.com>
> > > >> Reviewed-by: Majd Dibbiny <majd@mellanox.com>
> > > >> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > > >>   drivers/infiniband/hw/mlx5/main.c | 53 +++++++++++++++++++++++++++++++
> > > >>   1 file changed, 53 insertions(+)
> > > >>
> > > >> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> > > >> index 8b7bcf8f68fb..66c94a060718 100644
> > > >> +++ b/drivers/infiniband/hw/mlx5/main.c
> > > >> @@ -5533,6 +5533,57 @@ static int mlx5_ib_get_hw_stats(struct ib_device *ibdev,
> > > >>   	return num_counters;
> > > >>   }
> > > >>
> > > >> +static int mlx5_ib_counter_bind_qp(struct rdma_counter *counter,
> > > >> +				   struct ib_qp *qp)
> > > >> +{
> > > >> +	struct mlx5_ib_dev *dev = to_mdev(qp->device);
> > > >> +	u16 cnt_set_id = 0;
> > > >> +	int err;
> > > >> +
> > > >> +	if (!counter->id) {
> > > >> +		err = mlx5_cmd_alloc_q_counter(dev->mdev,
> > > >> +					       &cnt_set_id,
> > > >> +					       MLX5_SHARED_RESOURCE_UID);
> > > >> +		if (err)
> > > >> +			return err;
> > > >> +		counter->id = cnt_set_id;
> > > >> +	}
> > > >> +
> > > >> +	err = mlx5_ib_qp_set_counter(qp, counter);
> > > >> +	if (err)
> > > >> +		goto fail_set_counter;
> > > >> +
> > > >> +	return 0;
> > > >> +
> > > >> +fail_set_counter:
> > > >> +	mlx5_core_dealloc_q_counter(dev->mdev, cnt_set_id);
> > > >> +	counter->id = 0;
> > > >> +
> > > >> +	return err;
> > > >> +}
> > > >> +
> > > >> +static int mlx5_ib_counter_unbind_qp(struct ib_qp *qp, bool force)
> > > >> +{
> > > >> +	struct mlx5_ib_dev *dev = to_mdev(qp->device);
> > > >> +	struct rdma_counter *counter = qp->counter;
> > > >> +	int err;
> > > >> +
> > > >> +	err = mlx5_ib_qp_set_counter(qp, NULL);
> > > >> +	if (err && !force)
> > > >> +		return err;
> > > >> +
> > > >> +	/*
> > > >> +	 * Deallocate the counter if this is the last QP bound on it;
> > > >> +	 * If @force is set then we still deallocate the q counter
> > > >> +	 * no matter if there's any error in previous. used for cases
> > > >> +	 * like qp destroy.
> > > >> +	 */
> > > >> +	if (atomic_read(&counter->usecnt) == 1)
> > > >> +		return mlx5_core_dealloc_q_counter(dev->mdev, counter->id);
> > > >
> > > > This looks like a nonsense thing to write, what it is trying to do
> > > > with that atomic?
> > > >
> > > > I still can't see why this isn't a normal kref.
> > > >
> > >
> > > Hi Jason,
> > >
> > > Have discussed with Leon, unlike other resources, counter alloc/dealloc
> > > isn't called explicitly. So we need a refcount to record how many QPs
> > > are bound on this counter, when it comes to 0 then the counter can be
> > > deallocated. Whether to use atomic or kref the code is similar, it is
> > > not able to take advantage of kref/completion.
> >
> > That doesn't explain the nonsense "atomic_read(&counter->usecnt) == 1"
> > test
> 
> It means that all QPs "returned" this counter.

It doesn't make sense to do something like that with an atomic, either
you know there is no possible atomic_inc/dec at this point (which begs the
question why test it), or it is racy

Jason
