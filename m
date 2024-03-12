Return-Path: <linux-rdma+bounces-1397-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE17878F4E
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Mar 2024 08:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D9091C21069
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Mar 2024 07:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2779D69970;
	Tue, 12 Mar 2024 07:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3407EwR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BE842A9D;
	Tue, 12 Mar 2024 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710230164; cv=none; b=Wnk8DnWPrWVWrg2jMklFzb9C6NDItNCOHnVbC3HZ1ogtjtUYT+JKkXPHWLtXT5XEbfFtdGDBDrOqwbEBOvG97AR/epqNDaexr8ycLzXJYi/EOYRkta7Movbosb4DljrMENTz58X/6ouCO+y6V9HBmTJsIb1VEcY0ZKX4TwFZijg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710230164; c=relaxed/simple;
	bh=hTScA3wJ52eR+H4wIfPG0dmibfZ8eytlX7lUfo1C7zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WeUBKHgTt2AqG3U9gCQ9xXXruff7F200M3UAnL7nilTaWmsLEkWpODFiDrVQ1RG5ker6DAd3IVeGTgASlmH9LQlfDSCKzElXuQe+vY4HL56Xgl5Es3zcjls8Gdpwc8VfS8mDKQ9MyZpOB2SwdHlEIibhJf2rs9zyDV++x2HMZP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3407EwR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F888C43394;
	Tue, 12 Mar 2024 07:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710230164;
	bh=hTScA3wJ52eR+H4wIfPG0dmibfZ8eytlX7lUfo1C7zE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E3407EwROPmNA/PkmT2xH9YCS4+7Km9sZj4Mxbk615K1FkxNM3e1noCQYujzkzBDN
	 oM9Ds77qgec8Vn/NseFrjDW2vMzuQfwsRTXRm3c7QKI8NjQup0B7m43vd79wrczKeq
	 oNp2zVoryU2Yivd6WiDchA22YL4k4jSYfjjvt5dxHnHg7Ww/vkF4HBctiavOjNgbwy
	 EvejYAmquItE1zv8SuNy7XqhP1KmVuEMhFJoLCnvEqeWzLLlWAHL83VOrJQuiMztGn
	 3IOH7zimx4YNv5eOGJWHbBqr6iy6HLQh6nIhyEKiQf8EqYOAUHPJaDzDuGS8VtEmQr
	 HJOKq3FrvB5XA==
Date: Tue, 12 Mar 2024 09:55:59 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, kuba@kernel.org,
	keescook@chromium.org,
	"open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] IB/hfi1: allocate dummy net_device dynamically
Message-ID: <20240312075559.GM12921@unreal>
References: <20240308182951.2137779-1-leitao@debian.org>
 <6460dd4b-9b65-49df-beaf-05412e42f706@cornelisnetworks.com>
 <Ze8j8yWyXCQtwcOJ@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ze8j8yWyXCQtwcOJ@gmail.com>

On Mon, Mar 11, 2024 at 08:32:03AM -0700, Breno Leitao wrote:
> Hello Dennis,
> 
> On Mon, Mar 11, 2024 at 08:05:45AM -0400, Dennis Dalessandro wrote:
> > On 3/8/24 1:29 PM, Breno Leitao wrote:
> > > struct net_device shouldn't be embedded into any structure, instead,
> > > the owner should use the priv space to embed their state into net_device.
> > > 
> > > Embedding net_device into structures prohibits the usage of flexible
> > > arrays in the net_device structure. For more details, see the discussion
> > > at [1].
> > > 
> > > Un-embed the net_device from struct iwl_trans_pcie by converting it
> > > into a pointer. Then use the leverage alloc_netdev() to allocate the
> > > net_device object at iwl_trans_pcie_alloc.
> > 
> > What does an Omni-Path Architecture driver from Cornelis Networks have to do
> > with an Intel wireless driver?
> 
> That is an oversight. I will fix it in v2. Sorry about it.
> 
> > > The private data of net_device becomes a pointer for the struct
> > > iwl_trans_pcie, so, it is easy to get back to the iwl_trans_pcie parent
> > > given the net_device object.
> > > 
> > > [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
> > > 
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > ---
> > >  drivers/infiniband/hw/hfi1/netdev.h    | 2 +-
> > >  drivers/infiniband/hw/hfi1/netdev_rx.c | 9 +++++++--
> > >  2 files changed, 8 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/infiniband/hw/hfi1/netdev.h b/drivers/infiniband/hw/hfi1/netdev.h
> > > index 8aa074670a9c..07c8f77c9181 100644
> > > --- a/drivers/infiniband/hw/hfi1/netdev.h
> > > +++ b/drivers/infiniband/hw/hfi1/netdev.h
> > > @@ -49,7 +49,7 @@ struct hfi1_netdev_rxq {
> > >   *		When 0 receive queues will be freed.
> > >   */
> > >  struct hfi1_netdev_rx {
> > > -	struct net_device rx_napi;
> > > +	struct net_device *rx_napi;
> > >  	struct hfi1_devdata *dd;
> > >  	struct hfi1_netdev_rxq *rxq;
> > >  	int num_rx_q;
> > > diff --git a/drivers/infiniband/hw/hfi1/netdev_rx.c b/drivers/infiniband/hw/hfi1/netdev_rx.c
> > > index 720d4c85c9c9..5c26a69fa2bb 100644
> > > --- a/drivers/infiniband/hw/hfi1/netdev_rx.c
> > > +++ b/drivers/infiniband/hw/hfi1/netdev_rx.c
> > > @@ -188,7 +188,7 @@ static int hfi1_netdev_rxq_init(struct hfi1_netdev_rx *rx)
> > >  	int i;
> > >  	int rc;
> > >  	struct hfi1_devdata *dd = rx->dd;
> > > -	struct net_device *dev = &rx->rx_napi;
> > > +	struct net_device *dev = rx->rx_napi;
> > >  
> > >  	rx->num_rx_q = dd->num_netdev_contexts;
> > >  	rx->rxq = kcalloc_node(rx->num_rx_q, sizeof(*rx->rxq),
> > > @@ -360,7 +360,11 @@ int hfi1_alloc_rx(struct hfi1_devdata *dd)
> > >  	if (!rx)
> > >  		return -ENOMEM;
> > >  	rx->dd = dd;
> > > -	init_dummy_netdev(&rx->rx_napi);
> > > +	rx->rx_napi = alloc_netdev(sizeof(struct iwl_trans_pcie *),
> > > +				   "dummy", NET_NAME_UNKNOWN,
> > > +				   init_dummy_netdev);
> > 
> > Again with the iwl stuff? Please do not stuff to the mailing list that doesn't
> > even compile....
> > 
> >  CC [M]  drivers/infiniband/hw/hfi1/verbs.o
> >   CC [M]  drivers/infiniband/hw/hfi1/verbs_txreq.o
> >   CC [M]  drivers/infiniband/hw/hfi1/vnic_main.o
> > In file included from ./include/net/sock.h:46,
> >                  from ./include/linux/tcp.h:19,
> >                  from ./include/linux/ipv6.h:95,
> >                  from ./include/net/ipv6.h:12,
> >                  from ./include/rdma/ib_verbs.h:25,
> >                  from ./include/rdma/ib_hdrs.h:11,
> >                  from drivers/infiniband/hw/hfi1/hfi.h:29,
> >                  from drivers/infiniband/hw/hfi1/sdma.h:15,
> >                  from drivers/infiniband/hw/hfi1/netdev_rx.c:11:
> > drivers/infiniband/hw/hfi1/netdev_rx.c: In function ‘hfi1_alloc_rx’:
> > drivers/infiniband/hw/hfi1/netdev_rx.c:365:36: error: passing argument 4 of
> > ‘alloc_netdev_mqs’ from incompatible pointer type
> > [-Werror=incompatible-pointer-types]
> >   365 |                                    init_dummy_netdev);
> >       |                                    ^~~~~~~~~~~~~~~~~
> >       |                                    |
> >       |                                    int (*)(struct net_device *)
> > ./include/linux/netdevice.h:4632:63: note: in definition of macro ‘alloc_netdev’
> >  4632 |         alloc_netdev_mqs(sizeof_priv, name, name_assign_type, setup, 1, 1)
> >       |                                                               ^~~~~
> > ./include/linux/netdevice.h:4629:44: note: expected ‘void (*)(struct net_device
> > *)’ but argument is of type ‘int (*)(struct net_device *)’
> >  4629 |                                     void (*setup)(struct net_device *),
> >       |                                     ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   CC [M]  drivers/infiniband/hw/hfi1/vnic_sdma.o
> 
> Sorry, this patch is against net-next and you probably tested in Linus'
> upstream.

Dennis tested against rdma-next git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git

Thanks

> 
> You need to have d160c66cda0ac8614 ("net: Do not return value from
> init_dummy_netdev()"), which is in net-next, and has this important
> change that is necessary for this patch:
> 
>     -int init_dummy_netdev(struct net_device *dev);
>     +void init_dummy_netdev(struct net_device *dev);
> 
> If you are OK with a v2, I will fix the topics reported in this thread.
> 
> Thank you
> Breno

