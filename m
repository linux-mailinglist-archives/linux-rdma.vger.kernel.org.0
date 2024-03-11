Return-Path: <linux-rdma+bounces-1389-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF378783CE
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Mar 2024 16:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9287D1C21B1F
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Mar 2024 15:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457554206B;
	Mon, 11 Mar 2024 15:32:10 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1B941C87;
	Mon, 11 Mar 2024 15:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710171130; cv=none; b=ZuhgOH5K9VbmsBAMaHsfjCC9ehE2huXyuf/hZXDuf18zB5eZyztCub7bj9q7RuXjPbe+1bK9P5s4T2klCaoekg749TElgv2mGpUoStsD27WogNlii76tWEBv0ONksb/OwPlNLJIEfSmwDUwRie6DPR1YSCANDqSstfth7BRVxPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710171130; c=relaxed/simple;
	bh=IBtQ1Bt2rZNvPqsEPdeWv4N25hlh7/CRi2fmavDsr6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGBu/1CVfkXCLSEhU1iv4KKxVymrRQ5Ct+gJbtr0VC6JHdOr9+pwgaqMhuGYTgU8kgVexY5iZ4uZivaorqj5/10eRy7JkEJ2CUe2x7dc+Rfxi6fLU+brbjDzyMyEjxf8nqjd8EJl5Cr8xt1LTJWleUR+3BOEmzkyfNcSr3uFpcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d40fe2181dso39209661fa.1;
        Mon, 11 Mar 2024 08:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710171126; x=1710775926;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TwSH2RmUX8+hBp5SFqXt5yoPzgd9y6S3euZId5zxtYI=;
        b=InvBsmYbFL8HjflziBaLiKMzl6JUSQ5d3x3aY8xj7I43xj4gAmoBmQ0pZeQa1ijT34
         Rw2d/87hvuOWFXrltN34cxj6xaTa67ZQAU1CP0meko/vN7ITyXx71+KMMawSP/4WIW+W
         8zT12nSEoRv4iyW3DbelLSr7DJNkfvhPbJTkN0E5XoMFfgNCfvObFVqjNElM+n4qR8F0
         BVyMRcoj9M/qVTvU/zbySEsICroxmzA3DDZ7/ORY3n1jOo1rEi2Mw2fGS6j0Sg2cVC7a
         C/Unr6qPmuOdcyGhdj/sunrmajH/jpdznPWKz1JNN6kl+EWLo2WR4JTSp1HkRma2kkXE
         zbYw==
X-Forwarded-Encrypted: i=1; AJvYcCUgd/hdhe5YQvb3CJ9uuepu4DhFHrMRo5k7osdQRtFMa2Nz/mdYwbbbvWwIukJZ8C4pXeExuA5/bRvt+7sUrxwPrA1z7lS8PZ851DkThYthP3So77FgAuxF2ocu4QFMmfTq9Unx68R0fA==
X-Gm-Message-State: AOJu0Yzk0AyjmX2VblmZylLNuWDE7HJCBYJuZJ2fltJPvHZvkB5Hnp/8
	GNiraZpubXQBBD9mM/FTqPQGfmBGTsfngSQcT8DgG9W+DOAvdTek
X-Google-Smtp-Source: AGHT+IGjC79UEv92JL8lH5kWDuZcXIA99I1f/Mi2XRqgx6xZVlXPojUpy84fIrpXsqHctggSSHPkRQ==
X-Received: by 2002:a2e:918f:0:b0:2d4:22b6:eee6 with SMTP id f15-20020a2e918f000000b002d422b6eee6mr4482635ljg.8.1710171125950;
        Mon, 11 Mar 2024 08:32:05 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id d15-20020aa7d5cf000000b00567f39a8b55sm3019153eds.39.2024.03.11.08.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 08:32:05 -0700 (PDT)
Date: Mon, 11 Mar 2024 08:32:03 -0700
From: Breno Leitao <leitao@debian.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	kuba@kernel.org, keescook@chromium.org,
	"open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] IB/hfi1: allocate dummy net_device dynamically
Message-ID: <Ze8j8yWyXCQtwcOJ@gmail.com>
References: <20240308182951.2137779-1-leitao@debian.org>
 <6460dd4b-9b65-49df-beaf-05412e42f706@cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6460dd4b-9b65-49df-beaf-05412e42f706@cornelisnetworks.com>

Hello Dennis,

On Mon, Mar 11, 2024 at 08:05:45AM -0400, Dennis Dalessandro wrote:
> On 3/8/24 1:29 PM, Breno Leitao wrote:
> > struct net_device shouldn't be embedded into any structure, instead,
> > the owner should use the priv space to embed their state into net_device.
> > 
> > Embedding net_device into structures prohibits the usage of flexible
> > arrays in the net_device structure. For more details, see the discussion
> > at [1].
> > 
> > Un-embed the net_device from struct iwl_trans_pcie by converting it
> > into a pointer. Then use the leverage alloc_netdev() to allocate the
> > net_device object at iwl_trans_pcie_alloc.
> 
> What does an Omni-Path Architecture driver from Cornelis Networks have to do
> with an Intel wireless driver?

That is an oversight. I will fix it in v2. Sorry about it.

> > The private data of net_device becomes a pointer for the struct
> > iwl_trans_pcie, so, it is easy to get back to the iwl_trans_pcie parent
> > given the net_device object.
> > 
> > [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  drivers/infiniband/hw/hfi1/netdev.h    | 2 +-
> >  drivers/infiniband/hw/hfi1/netdev_rx.c | 9 +++++++--
> >  2 files changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/infiniband/hw/hfi1/netdev.h b/drivers/infiniband/hw/hfi1/netdev.h
> > index 8aa074670a9c..07c8f77c9181 100644
> > --- a/drivers/infiniband/hw/hfi1/netdev.h
> > +++ b/drivers/infiniband/hw/hfi1/netdev.h
> > @@ -49,7 +49,7 @@ struct hfi1_netdev_rxq {
> >   *		When 0 receive queues will be freed.
> >   */
> >  struct hfi1_netdev_rx {
> > -	struct net_device rx_napi;
> > +	struct net_device *rx_napi;
> >  	struct hfi1_devdata *dd;
> >  	struct hfi1_netdev_rxq *rxq;
> >  	int num_rx_q;
> > diff --git a/drivers/infiniband/hw/hfi1/netdev_rx.c b/drivers/infiniband/hw/hfi1/netdev_rx.c
> > index 720d4c85c9c9..5c26a69fa2bb 100644
> > --- a/drivers/infiniband/hw/hfi1/netdev_rx.c
> > +++ b/drivers/infiniband/hw/hfi1/netdev_rx.c
> > @@ -188,7 +188,7 @@ static int hfi1_netdev_rxq_init(struct hfi1_netdev_rx *rx)
> >  	int i;
> >  	int rc;
> >  	struct hfi1_devdata *dd = rx->dd;
> > -	struct net_device *dev = &rx->rx_napi;
> > +	struct net_device *dev = rx->rx_napi;
> >  
> >  	rx->num_rx_q = dd->num_netdev_contexts;
> >  	rx->rxq = kcalloc_node(rx->num_rx_q, sizeof(*rx->rxq),
> > @@ -360,7 +360,11 @@ int hfi1_alloc_rx(struct hfi1_devdata *dd)
> >  	if (!rx)
> >  		return -ENOMEM;
> >  	rx->dd = dd;
> > -	init_dummy_netdev(&rx->rx_napi);
> > +	rx->rx_napi = alloc_netdev(sizeof(struct iwl_trans_pcie *),
> > +				   "dummy", NET_NAME_UNKNOWN,
> > +				   init_dummy_netdev);
> 
> Again with the iwl stuff? Please do not stuff to the mailing list that doesn't
> even compile....
> 
>  CC [M]  drivers/infiniband/hw/hfi1/verbs.o
>   CC [M]  drivers/infiniband/hw/hfi1/verbs_txreq.o
>   CC [M]  drivers/infiniband/hw/hfi1/vnic_main.o
> In file included from ./include/net/sock.h:46,
>                  from ./include/linux/tcp.h:19,
>                  from ./include/linux/ipv6.h:95,
>                  from ./include/net/ipv6.h:12,
>                  from ./include/rdma/ib_verbs.h:25,
>                  from ./include/rdma/ib_hdrs.h:11,
>                  from drivers/infiniband/hw/hfi1/hfi.h:29,
>                  from drivers/infiniband/hw/hfi1/sdma.h:15,
>                  from drivers/infiniband/hw/hfi1/netdev_rx.c:11:
> drivers/infiniband/hw/hfi1/netdev_rx.c: In function ‘hfi1_alloc_rx’:
> drivers/infiniband/hw/hfi1/netdev_rx.c:365:36: error: passing argument 4 of
> ‘alloc_netdev_mqs’ from incompatible pointer type
> [-Werror=incompatible-pointer-types]
>   365 |                                    init_dummy_netdev);
>       |                                    ^~~~~~~~~~~~~~~~~
>       |                                    |
>       |                                    int (*)(struct net_device *)
> ./include/linux/netdevice.h:4632:63: note: in definition of macro ‘alloc_netdev’
>  4632 |         alloc_netdev_mqs(sizeof_priv, name, name_assign_type, setup, 1, 1)
>       |                                                               ^~~~~
> ./include/linux/netdevice.h:4629:44: note: expected ‘void (*)(struct net_device
> *)’ but argument is of type ‘int (*)(struct net_device *)’
>  4629 |                                     void (*setup)(struct net_device *),
>       |                                     ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
>   CC [M]  drivers/infiniband/hw/hfi1/vnic_sdma.o

Sorry, this patch is against net-next and you probably tested in Linus'
upstream.

You need to have d160c66cda0ac8614 ("net: Do not return value from
init_dummy_netdev()"), which is in net-next, and has this important
change that is necessary for this patch:

    -int init_dummy_netdev(struct net_device *dev);
    +void init_dummy_netdev(struct net_device *dev);

If you are OK with a v2, I will fix the topics reported in this thread.

Thank you
Breno

