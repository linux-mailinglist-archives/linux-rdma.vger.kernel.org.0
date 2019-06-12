Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2137242530
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 14:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfFLMMb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 08:12:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbfFLMMb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Jun 2019 08:12:31 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC2282080A;
        Wed, 12 Jun 2019 12:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560341550;
        bh=iByvDKhQTiJKXXAd4jGURPMCj9qKNi8B8zxpDg1ZOa4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xkzPYNlFCJJ+Ply6XEt1iEaMp0qBTFtJpd2/WD1tBhFIX7Db6RSjYi4BwRWKSoFy8
         P0LVEKv1HCLNohIa6XWLyHC6nMGYI0xaSUGWqBBNc1KDVa7aXpHLOSmDJmyywYFu1F
         VxPToK37prbArtTTVUnN3v30k5Lol5fGbp4HJFj4=
Date:   Wed, 12 Jun 2019 15:12:27 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Mark Zhang <markz@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH rdma-next v3 09/17] IB/mlx5: Support statistic q counter
 configuration
Message-ID: <20190612121227.GQ6369@mtr-leonro.mtl.com>
References: <20190606105345.8546-1-leon@kernel.org>
 <20190606105345.8546-10-leon@kernel.org>
 <20190611175419.GA19838@ziepe.ca>
 <285c454e-2a20-d9e0-56a4-7738dd375d17@mellanox.com>
 <20190612120802.GE3876@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612120802.GE3876@ziepe.ca>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 12, 2019 at 09:08:02AM -0300, Jason Gunthorpe wrote:
> On Wed, Jun 12, 2019 at 12:01:23PM +0000, Mark Zhang wrote:
> > On 6/12/2019 1:54 AM, Jason Gunthorpe wrote:
> > > On Thu, Jun 06, 2019 at 01:53:37PM +0300, Leon Romanovsky wrote:
> > >> From: Mark Zhang <markz@mellanox.com>
> > >>
> > >> Add support for ib callbacks counter_bind_qp() and counter_unbind_qp().
> > >>
> > >> Signed-off-by: Mark Zhang <markz@mellanox.com>
> > >> Reviewed-by: Majd Dibbiny <majd@mellanox.com>
> > >> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > >>   drivers/infiniband/hw/mlx5/main.c | 53 +++++++++++++++++++++++++++++++
> > >>   1 file changed, 53 insertions(+)
> > >>
> > >> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> > >> index 8b7bcf8f68fb..66c94a060718 100644
> > >> +++ b/drivers/infiniband/hw/mlx5/main.c
> > >> @@ -5533,6 +5533,57 @@ static int mlx5_ib_get_hw_stats(struct ib_device *ibdev,
> > >>   	return num_counters;
> > >>   }
> > >>
> > >> +static int mlx5_ib_counter_bind_qp(struct rdma_counter *counter,
> > >> +				   struct ib_qp *qp)
> > >> +{
> > >> +	struct mlx5_ib_dev *dev = to_mdev(qp->device);
> > >> +	u16 cnt_set_id = 0;
> > >> +	int err;
> > >> +
> > >> +	if (!counter->id) {
> > >> +		err = mlx5_cmd_alloc_q_counter(dev->mdev,
> > >> +					       &cnt_set_id,
> > >> +					       MLX5_SHARED_RESOURCE_UID);
> > >> +		if (err)
> > >> +			return err;
> > >> +		counter->id = cnt_set_id;
> > >> +	}
> > >> +
> > >> +	err = mlx5_ib_qp_set_counter(qp, counter);
> > >> +	if (err)
> > >> +		goto fail_set_counter;
> > >> +
> > >> +	return 0;
> > >> +
> > >> +fail_set_counter:
> > >> +	mlx5_core_dealloc_q_counter(dev->mdev, cnt_set_id);
> > >> +	counter->id = 0;
> > >> +
> > >> +	return err;
> > >> +}
> > >> +
> > >> +static int mlx5_ib_counter_unbind_qp(struct ib_qp *qp, bool force)
> > >> +{
> > >> +	struct mlx5_ib_dev *dev = to_mdev(qp->device);
> > >> +	struct rdma_counter *counter = qp->counter;
> > >> +	int err;
> > >> +
> > >> +	err = mlx5_ib_qp_set_counter(qp, NULL);
> > >> +	if (err && !force)
> > >> +		return err;
> > >> +
> > >> +	/*
> > >> +	 * Deallocate the counter if this is the last QP bound on it;
> > >> +	 * If @force is set then we still deallocate the q counter
> > >> +	 * no matter if there's any error in previous. used for cases
> > >> +	 * like qp destroy.
> > >> +	 */
> > >> +	if (atomic_read(&counter->usecnt) == 1)
> > >> +		return mlx5_core_dealloc_q_counter(dev->mdev, counter->id);
> > >
> > > This looks like a nonsense thing to write, what it is trying to do
> > > with that atomic?
> > >
> > > I still can't see why this isn't a normal kref.
> > >
> >
> > Hi Jason,
> >
> > Have discussed with Leon, unlike other resources, counter alloc/dealloc
> > isn't called explicitly. So we need a refcount to record how many QPs
> > are bound on this counter, when it comes to 0 then the counter can be
> > deallocated. Whether to use atomic or kref the code is similar, it is
> > not able to take advantage of kref/completion.
>
> That doesn't explain the nonsense "atomic_read(&counter->usecnt) == 1"
> test

It means that all QPs "returned" this counter.

>
> Jason
