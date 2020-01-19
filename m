Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92C1E141D21
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jan 2020 10:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgASJdE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Jan 2020 04:33:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:34748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgASJdD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 19 Jan 2020 04:33:03 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98A3720730;
        Sun, 19 Jan 2020 09:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579426382;
        bh=9xTcjvLeAOGktbppfiOiPsljLJJYy2hLFLvMcSasuCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uB9Jf299Oe/if6TxUaUzWgpITiiVMcBy81Fnl1fpsc/1k0V4s6fqxu4LVIQMi87gY
         mEF6migzcSgmJKhuIjv2IDabwRDaZje9oqH9NUfrLMGxeo6Hm51E0NglqFycqvrk/3
         pQyDX6KE8B+IZwbfl3ctY38QwgpItObYwwF/mAtQ=
Date:   Sun, 19 Jan 2020 11:32:59 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Lang Cheng <chenglang@huawei.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Weihang Li <liweihang@huawei.com>,
        aelior@marvell.com, mkalderon@marvell.com, linuxarm@huawei.com,
        aditr@vmware.com, linux-rdma@vger.kernel.org, dledford@redhat.com,
        shiraz.saleem@intel.com
Subject: Re: [PATCH RFC for-next 1/6] RDMA/core: support deliver net device
 event
Message-ID: <20200119093259.GD51881@unreal>
References: <1579147847-12158-1-git-send-email-liweihang@huawei.com>
 <1579147847-12158-2-git-send-email-liweihang@huawei.com>
 <20200117142318.GB29725@ziepe.ca>
 <19bd56ac-5df5-f5bb-e024-54ef3cd0d0ad@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19bd56ac-5df5-f5bb-e024-54ef3cd0d0ad@huawei.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jan 19, 2020 at 03:02:11PM +0800, Lang Cheng wrote:
>
> 在 2020/1/17 22:23, Jason Gunthorpe 写道:
> > On Thu, Jan 16, 2020 at 12:10:42PM +0800, Weihang Li wrote:
> > > From: Lang Cheng <chenglang@huawei.com>
> > >
> > > For the process of handling the link event of the net device, the driver
> > > of each provider is similar, so it can be integrated into the ib_core for
> > > unified processing.
> > >
> > > Signed-off-by: Lang Cheng <chenglang@huawei.com>
> > > Signed-off-by: Weihang Li <liweihang@huawei.com>
> > >   drivers/infiniband/core/cache.c  |  21 ++++++-
> > >   drivers/infiniband/core/device.c | 123 +++++++++++++++++++++++++++++++++++++++
> > >   include/rdma/ib_cache.h          |  13 +++++
> > >   include/rdma/ib_verbs.h          |   8 +++
> > >   4 files changed, 164 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
> > > index 17bfedd..791e965 100644
> > > +++ b/drivers/infiniband/core/cache.c
> > > @@ -1174,6 +1174,23 @@ int ib_get_cached_port_state(struct ib_device   *device,
> > >   }
> > >   EXPORT_SYMBOL(ib_get_cached_port_state);
> > > +int ib_get_cached_port_event_flags(struct ib_device   *device,
> > > +				   u8                  port_num,
> > > +				   enum ib_port_flags *event_flags)
> > > +{
> > > +	unsigned long flags;
> > > +
> > > +	if (!rdma_is_port_valid(device, port_num))
> > > +		return -EINVAL;
> > > +
> > > +	read_lock_irqsave(&device->cache_lock, flags);
> > > +	*event_flags = device->port_data[port_num].cache.port_event_flags;
> > > +	read_unlock_irqrestore(&device->cache_lock, flags);
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL(ib_get_cached_port_event_flags);
> > > +
> > >   /**
> > >    * rdma_get_gid_attr - Returns GID attributes for a port of a device
> > >    * at a requested gid_index, if a valid GID entry exists.
> > > @@ -1391,7 +1408,7 @@ ib_cache_update(struct ib_device *device, u8 port, bool enforce_security)
> > >   	if (!rdma_is_port_valid(device, port))
> > >   		return -EINVAL;
> > > -	tprops = kmalloc(sizeof *tprops, GFP_KERNEL);
> > > +	tprops = kzalloc(sizeof(*tprops), GFP_KERNEL);
> > >   	if (!tprops)
> > >   		return -ENOMEM;
> > > @@ -1435,6 +1452,8 @@ ib_cache_update(struct ib_device *device, u8 port, bool enforce_security)
> > >   	device->port_data[port].cache.pkey = pkey_cache;
> > >   	device->port_data[port].cache.lmc = tprops->lmc;
> > >   	device->port_data[port].cache.port_state = tprops->state;
> > > +	device->port_data[port].cache.port_event_flags =
> > > +						tprops->port_event_flags;
> > >   	device->port_data[port].cache.subnet_prefix = tprops->subnet_prefix;
> > >   	write_unlock_irq(&device->cache_lock);
> > > diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> > > index f6c2552..f03d6ce 100644
> > > +++ b/drivers/infiniband/core/device.c
> > > @@ -1325,6 +1325,77 @@ static int enable_device_and_get(struct ib_device *device)
> > >   	return ret;
> > >   }
> > > +unsigned int ib_query_ndev_port_num(struct ib_device *device,
> > > +				    struct net_device *netdev)
> > > +{
> > > +	unsigned int port_num;
> > > +
> > > +	rdma_for_each_port(device, port_num)
> > > +		if (netdev == device->port_data[port_num].netdev)
> > > +			break;
> > > +
> > > +	return port_num;
> > > +}
> > > +EXPORT_SYMBOL(ib_query_ndev_port_num);
> > This returns garbage if the netdev isn't found
>
> ib_get_cache_event_flags() will check port_num by calling
> rdma_is_port_valid() like ib_get_cache_port_state ().
>
> Now, following Leon's opinion, ib_get_cache_xxxx() should remove
> rdma_is_port_valid(),
>
> so it needs to be modified here, too.


rdma_is_port_valid() doesn't check for netdev existence, but only
ensures that port number is in valid range and it is supposed to
be guaranteed in this stage.

Thanks
