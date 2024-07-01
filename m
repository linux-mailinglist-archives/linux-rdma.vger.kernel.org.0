Return-Path: <linux-rdma+bounces-3583-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FCA91DE57
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 13:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D15111F24D2B
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2024 11:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7C5145354;
	Mon,  1 Jul 2024 11:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/RR9kBX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC42E82D94;
	Mon,  1 Jul 2024 11:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719834592; cv=none; b=rWG5RcitWNgsPkY2T9nS7utU+pYW1IkXOyZoNN9W3IRRCIvuizy6Op0W5PMSq3oxMegbfTQCNCR44xGfVAmUOI3RCOiv0LobD05WyFoPfJCToA81b/W47zPWemT2JFbxhtSdOVeGQ1OLRY70L2vef+/y9GBiY2hnQ4b2UCXwK7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719834592; c=relaxed/simple;
	bh=BOlAuoN67TSbbX0DL1uynkxemPurWVZf+HBdbsql2Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdO19eB/YT93DxGsGF690JANfATCJ0YHGUhoMd3jDIO1gVjGruBgrZYXMbibu9yPk1DSbUy8mP3bM2S7UPf6gs8AdIWSCfohaWFzBsu24jsBTKy0JNNWy9yueF3K0Fnd02r3irN8/XHrYUKwbhUNCQ7qKhc9TUhC6i01xz2eNkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/RR9kBX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3924BC116B1;
	Mon,  1 Jul 2024 11:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719834592;
	bh=BOlAuoN67TSbbX0DL1uynkxemPurWVZf+HBdbsql2Ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q/RR9kBXT7ABSlvbENp+mFK5VuygGQIl8yfqrBkWZlZWEgm+5KiQ3NGB8YmdF4k7p
	 yehZiiXDnPvMQ1y3rtG2IGpepKNb0I6fpLUZ2DGmtIB6pFRhZ3UqzCqOlVqz4axo/o
	 qoQCtQFOnyTJp94aDT2tICVKixEUjF2kmrZJLKqn4cz1klgOCV7FerhyIusvmdAF9x
	 TvH2aYebnDDJ5WnEafg+cJTb4T5E2mD5acym6nVnDH7pVxpacfYF7Q+J2hOf4qoeK9
	 Gs5bwxQ9T3FQaGwykE/7Cg0XXRqe1aghSiSyWrD8mjqj11aEhQqUDQMXqIVy73gHuV
	 dGNEZU1n62aPA==
Date: Mon, 1 Jul 2024 14:49:49 +0300
From: Leon Romanovsky <leon@kernel.org>
To: David Laight <David.Laight@aculab.com>
Cc: Anand Khoje <anand.a.khoje@oracle.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"saeedm@mellanox.com" <saeedm@mellanox.com>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH v4] net/mlx5: Reclaim max 50K pages at once
Message-ID: <20240701114949.GB13195@unreal>
References: <20240619132827.51306-1-anand.a.khoje@oracle.com>
 <20240624095757.GD29266@unreal>
 <3d5b16d332914d4f810bc0ce48fd8772@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d5b16d332914d4f810bc0ce48fd8772@AcuMS.aculab.com>

On Fri, Jun 28, 2024 at 03:13:45PM +0000, David Laight wrote:
> From: Leon Romanovsky
> > Sent: 24 June 2024 10:58
> > 
> > On Wed, Jun 19, 2024 at 06:58:27PM +0530, Anand Khoje wrote:
> > > In non FLR context, at times CX-5 requests release of ~8 million FW pages.
> > > This needs humongous number of cmd mailboxes, which to be released once
> > > the pages are reclaimed. Release of humongous number of cmd mailboxes is
> > > consuming cpu time running into many seconds. Which with non preemptible
> > > kernels is leading to critical process starving on that cpu’s RQ.
> > > To alleviate this, this change restricts the total number of pages
> > > a worker will try to reclaim maximum 50K pages in one go.
> > > The limit 50K is aligned with the current firmware capacity/limit of
> > > releasing 50K pages at once per MLX5_CMD_OP_MANAGE_PAGES + MLX5_PAGES_TAKE
> > > device command.
> > >
> > > Our tests have shown significant benefit of this change in terms of
> > > time consumed by dma_pool_free().
> > > During a test where an event was raised by HCA
> > > to release 1.3 Million pages, following observations were made:
> > >
> > > - Without this change:
> > > Number of mailbox messages allocated was around 20K, to accommodate
> > > the DMA addresses of 1.3 million pages.
> > > The average time spent by dma_pool_free() to free the DMA pool is between
> > > 16 usec to 32 usec.
> > >            value  ------------- Distribution ------------- count
> > >              256 |                                         0
> > >              512 |@                                        287
> > >             1024 |@@@                                      1332
> > >             2048 |@                                        656
> > >             4096 |@@@@@                                    2599
> > >             8192 |@@@@@@@@@@                               4755
> > >            16384 |@@@@@@@@@@@@@@@                          7545
> > >            32768 |@@@@@                                    2501
> > >            65536 |                                         0
> > >
> > > - With this change:
> > > Number of mailbox messages allocated was around 800; this was to
> > > accommodate DMA addresses of only 50K pages.
> > > The average time spent by dma_pool_free() to free the DMA pool in this case
> > > lies between 1 usec to 2 usec.
> > >            value  ------------- Distribution ------------- count
> > >              256 |                                         0
> > >              512 |@@@@@@@@@@@@@@@@@@                       346
> > >             1024 |@@@@@@@@@@@@@@@@@@@@@@                   435
> > >             2048 |                                         0
> > >             4096 |                                         0
> > >             8192 |                                         1
> > >            16384 |                                         0
> > >
> > > Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
> > > Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> > > ---
> > > Changes in v4:
> > >   - Fixed a nit in patch subject.
> > > ---
> > >  drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
> > b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
> > > index dcf58ef..06eee3a 100644
> > > --- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
> > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
> > > @@ -608,6 +608,7 @@ enum {
> > >  	RELEASE_ALL_PAGES_MASK = 0x4000,
> > >  };
> > >
> > > +#define MAX_RECLAIM_NPAGES -50000
> 
> It would be traditional to enclose a negative value in ().
> (Although only 30+ year old compilers would generate unexpected code for
> 	foo-MAX_RECLAIM_NPAGES
> and you have to go back into the 1970s for
> 	foo=MAX_RECLAIM_NPAGES
> to be a problem.)
> 
> > >  static int req_pages_handler(struct notifier_block *nb,
> > >  			     unsigned long type, void *data)
> > >  {
> > > @@ -639,9 +640,13 @@ static int req_pages_handler(struct notifier_block *nb,
> > >
> > >  	req->dev = dev;
> > >  	req->func_id = func_id;
> > > -	req->npages = npages;
> > >  	req->ec_function = ec_function;
> > >  	req->release_all = release_all;
> > > +	if (npages < MAX_RECLAIM_NPAGES)
> > > +		req->npages = MAX_RECLAIM_NPAGES;
> > > +	else
> > > +		req->npages = npages;
> > > +
> > 
> > BTW, this can be written as:
> > 	req->npages = max_t(s32, npages, MAX_RECLAIM_NPAGES);
> 
> That shouldn't need all the (s32) casts.

#define doesn't have a type, so it is better to be explicit here.

> (I don't think it even needed them before I relaxed the type check.)
> 
> 	David
> 
> > 
> > Thanks
> > 
> > >  	INIT_WORK(&req->work, pages_work_handler);
> > >  	queue_work(dev->priv.pg_wq, &req->work);
> > >  	return NOTIFY_OK;
> > > --
> > > 1.8.3.1
> > >
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

