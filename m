Return-Path: <linux-rdma+bounces-8338-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFD2A4ED9F
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 20:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76BF0172BED
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 19:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B280225D522;
	Tue,  4 Mar 2025 19:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Dp0ostl+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8C2209F59
	for <linux-rdma@vger.kernel.org>; Tue,  4 Mar 2025 19:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741117305; cv=none; b=MajHdDbZJz/x+AFFtM+rZRd1sWwjDX+glxwU77G4sMxzPaBdf0D+Eks2D/AXCIQqPn2NT5jUG5My3uAat1cFgn2VRWcHF9pfT97lViNOcNt4Yu0Tjrp53gw8ozbBXqS04GP58TskZElgcMRLKrALkhgO2uFaUlLj2OEyhh11hac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741117305; c=relaxed/simple;
	bh=Z1Dr2H1wZQma+yJxOpXVs8NcHO1DKsOkb0OPlMDP+XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJDWA9qHHsms+UCn1LMCDIX5lGIq3qZ1U9gNX6dmoaX35Lcpi3kviVCAWhQIoF/O2ZNkMfnZ75kHSOtB/NV+x41mn8B/PSi2PwKHb1YpCDG3M3xeLmisluC7judzJ5QseSaWAfYuVvke32NoDCSKSkjgsehesgiIxGGbdT5j29k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Dp0ostl+; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e895fd83d3so46642026d6.3
        for <linux-rdma@vger.kernel.org>; Tue, 04 Mar 2025 11:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741117302; x=1741722102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hniMK4SB1u1F2OOA4rSYd4xqdAr8kGaAFH0sJ2S5DiI=;
        b=Dp0ostl+XTTjDEM3m1SzD6qZL0bKvFcGaXEQHgrUtJ+Mr5RonLJYQ3jcyInnuALtSd
         UEQn/OvkSo7/odNgS8TUNQrB+7GyZTVNKZjqzVBHfy9OzsDd1h9s0XyMdiKLLsZT+uck
         7VtQLP+Xh6czvHWQ4t6pKXbWPVr72SisFtfcZ/UuXrO5S1Y+4JJE6M3tcrGPWGftPD66
         nWx6U7SZAhx/oZ40QYh47Dd8tHzuVDhY+RHrYlBAvVhnY96hm8+rFAtjUVBzm0zokP3j
         SImSxPHMkasmx0/sPaU0h96q9GXQza8442rT7xUw8HKjvYKQBwf8pZpq1DnC1gLbBPjh
         OifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741117302; x=1741722102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hniMK4SB1u1F2OOA4rSYd4xqdAr8kGaAFH0sJ2S5DiI=;
        b=Ix2I/sNqLf+BZzCajLAfSgokTkC4c0ITARCwUZ/9+8vTICWiONSiWNeqo4mLH6axmp
         2Pd06WXhlMdF3f3HKHZ4jbTiUsfuyFwBgR/rLlbwTrrxHgI5/MenyV5gB8VFOD85mcnE
         +4cTRptHxgU3UUrAuuqJ7KBNcGT8VkXdaA9al89iZupeUwXnFRztUU/5cEY1SpBic8Cn
         CG+GYy1fQwyHy1GxckAHdLXhwnRycXHgri3W6gdYT1AI24ODefh6mtENd/evzNMHouY4
         nEJnatixZBagjtMzILL23IzjwHj8E7xG++AZtfdPSJPbf8nstDN2aIKY5xHwhWdBIIHj
         Stjw==
X-Forwarded-Encrypted: i=1; AJvYcCUgClxaqJA9+3CD9VWAQFe1JgdjwP49TFF9vh6h9AuwK3srcqH2nV6MKTMD4ouF/jC6CQYL9XLvUbAu@vger.kernel.org
X-Gm-Message-State: AOJu0YyI/4BEdgcwRbpUdFfYzSuAPBiNdoOJ+vYz5alIC2rwSffwCpXm
	DSpu6uRbJe30q2XcM2MovwYWHNyoyqz9blOpi9Ja+/RFW2wMdHhFTtdTL0dzh0NOq1JfuBrv8Cc
	D
X-Gm-Gg: ASbGncvHI+rY17/5UePQOGNY2EU4+4gDnsN+ibCrSwx6xgL4MqD4Yjwr88ABibxh9/G
	XOeH6Odl05qI+pBE5cTcbCKDjHvEVTmif2e7Q3WuKuRN89RRXK1zN4zGf32/cRtJJ5PF56MsBHy
	Qeo7nNp56qC+RLpcIMgNfnm0uDLkci54Nt8TGRst34YKKDXSBhiL7bms32Gx+iD7HhVKGxN+NT6
	jSkyHbbuU4rYbgnmi+fb5n4wXG6eeyqcS5CBWkZKYzhZTbq+eec/5thgdhGVt+ZYi/T5ctVbzGh
	/O+UWtcJOY5jY8yT711Ags89TQhbDb3QHiw5THTKLfjtko7PaDNp6Mnnm1NEfhP3mdZ8kQ4vEcF
	pt/sw/ET8WCeXPhhNbQ==
X-Google-Smtp-Source: AGHT+IEVAKGzcENzw+iAKzItxzizgLoOPdiHsjgb9KK/h/j44uEdoziCKUzFRD74zSh7p4AQOUAf1A==
X-Received: by 2002:a05:6214:e67:b0:6e8:89bd:2b50 with SMTP id 6a1803df08f44-6e8e6cc6b6emr9042306d6.7.1741117300888;
        Tue, 04 Mar 2025 11:41:40 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976ec1f8sm70616526d6.121.2025.03.04.11.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 11:41:40 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tpY95-00000001J4e-2w8n;
	Tue, 04 Mar 2025 15:41:39 -0400
Date: Tue, 4 Mar 2025 15:41:39 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Long Li <longli@microsoft.com>
Cc: Ratheesh Kannoth <rkannoth@marvell.com>,
	"longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
	Leon Romanovsky <leon@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [Patch rdma-next] RDMA/mana_ib: handle net event
 for pointing to the current netdev
Message-ID: <20250304194139.GE5011@ziepe.ca>
References: <1740782519-13485-1-git-send-email-longli@linuxonhyperv.com>
 <20250304063940.GA2702870@maili.marvell.com>
 <SA6PR21MB423174BA15D8A909CB2A6950CEC82@SA6PR21MB4231.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA6PR21MB423174BA15D8A909CB2A6950CEC82@SA6PR21MB4231.namprd21.prod.outlook.com>

On Tue, Mar 04, 2025 at 06:26:03PM +0000, Long Li wrote:
> > On 2025-03-01 at 04:11:59, longli@linuxonhyperv.com
> > (longli@linuxonhyperv.com) wrote:
> > > From: Long Li <longli@microsoft.com>
> > >
> > > When running under Hyper-V, the master device to the RDMA device is
> > > always bonded to this RDMA device if it's present in the kernel. This
> > > is not user-configurable.
> > >
> > > The master device can be unbind/bind from the kernel. During those
> > > events, the RDMA device should set to the current netdev to relect the
> > > change of master device from those events.
> > >
> > > Signed-off-by: Long Li <longli@microsoft.com>
> > > ---
> > >  drivers/infiniband/hw/mana/device.c  | 35
> > > ++++++++++++++++++++++++++++  drivers/infiniband/hw/mana/mana_ib.h |
> > > 1 +
> > >  2 files changed, 36 insertions(+)
> > >
> > > diff --git a/drivers/infiniband/hw/mana/device.c
> > > b/drivers/infiniband/hw/mana/device.c
> > > index 3416a85f8738..3e4f069c2258 100644
> > > --- a/drivers/infiniband/hw/mana/device.c
> > > +++ b/drivers/infiniband/hw/mana/device.c
> > > @@ -51,6 +51,37 @@ static const struct ib_device_ops mana_ib_dev_ops = {
> > >                          ib_ind_table),  };
> > >
> > > +static int mana_ib_netdev_event(struct notifier_block *this,
> > > +                             unsigned long event, void *ptr) {
> > > +     struct mana_ib_dev *dev = container_of(this, struct mana_ib_dev, nb);
> > > +     struct net_device *event_dev = netdev_notifier_info_to_dev(ptr);
> > > +     struct gdma_context *gc = dev->gdma_dev->gdma_context;
> > > +     struct mana_context *mc = gc->mana.driver_data;
> > > +     struct net_device *ndev;
> > > +
> > > +     if (event_dev != mc->ports[0])
> > > +             return NOTIFY_DONE;
> > > +
> > > +     switch (event) {
> > > +     case NETDEV_CHANGEUPPER:
> > > +             rcu_read_lock();
> > > +             ndev = mana_get_primary_netdev_rcu(mc, 0);
> > > +             rcu_read_unlock();
> > ...
> > > +
> > > +             /*
> > > +              * RDMA core will setup GID based on updated netdev.
> > > +              * It's not possible to race with the core as rtnl lock is being
> > > +              * held.
> > > +              */
> > > +             ib_device_set_netdev(&dev->ib_dev, ndev, 1);
> > rcu_read_unlock() should be here, right ?
> 
> It can't.  ib_device_set_netdev() is calling alloc_port_data() and may sleep.
> 
> I think this locking is okay. This event only comes in when:
> 1. the master device has changed to netvsc. In this case ndev is guaranteed to be valid as this notification is triggered by netvsc.
> 2. the master device has changed to itself (the ethernet device parent for the IB device).  In this case, ndev is valid because mana_ib is an auxiliary device to ndev and it can't unload itself at this time.


Why not return with the netdev refcount held so you don't need this
weirdo rcu thing?

Jason

