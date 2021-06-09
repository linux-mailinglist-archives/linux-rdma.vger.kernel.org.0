Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDA53A115B
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jun 2021 12:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238469AbhFIKmQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Jun 2021 06:42:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236503AbhFIKmQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Jun 2021 06:42:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0AD9161375;
        Wed,  9 Jun 2021 10:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623235221;
        bh=w4o78bpNaj+TFbKDPBfoFUCyuOVleQStwLCO9/OVcZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dbsX89OaYlfzdMUlPDHA5AiQcuiL0r2e7A9mFhzxcGYfY9M7m8bph8/yvXOesX6WE
         SajUSPKk0BiAm1TSbwvTdM+Vn/+nrsOjZrCxk/zT/kCYUMiORVgqj0nZO4BLQZ/+AE
         /Jlez0Tl9soEcuMwqilVZ2D6z/fAUVygKUkNmNeOqY4cogsJRkv/FvaQpPnwFb4ji8
         7V93Ms7nnMB2ivNCpDJevfpg0Tk+5z5HNujm3WTDWRy87O99mcttYy55dCWatalqHC
         sl5I5J0z95Pi0LMRzjVWEMGyM5oAJbPromYMBYwgGJvwQPqJAFp9dDuED4HE8avezx
         GMQFP88KQY7sw==
Date:   Wed, 9 Jun 2021 13:40:17 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Anand Khoje <anand.a.khoje@oracle.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        Haakon Bugge <haakon.bugge@oracle.com>
Subject: Re: [PATCH v3 3/3] IB/core: Obtain subnet_prefix from cache in IB
 devices.
Message-ID: <YMCakSCQLqUbcQ1H@unreal>
References: <20210609055534.855-1-anand.a.khoje@oracle.com>
 <20210609055534.855-4-anand.a.khoje@oracle.com>
 <YMB9gxlKbDvdynUE@unreal>
 <MWHPR1001MB2096CA7F29DCF86DE921903EC5369@MWHPR1001MB2096.namprd10.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR1001MB2096CA7F29DCF86DE921903EC5369@MWHPR1001MB2096.namprd10.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 09, 2021 at 09:26:03AM +0000, Anand Khoje wrote:
> Hi Leon,

Please don't do top-posting.


> 
> The set_bit()/clear_bit() and enum ib_port_data_flags  has been added as a device that can be used for future enhancements. 
> Also, usage of set_bit()/clear_bit() ensures the operations on this bit is atomic.

The bitfield variables are better suit this use case.
Let's don't overcomplicate code without the reason.

Thanks

> 
> Thanks,
> Anand
> 
> -----Original Message-----
> From: Leon Romanovsky <leon@kernel.org> 
> Sent: Wednesday, June 9, 2021 2:06 PM
> To: Anand Khoje <anand.a.khoje@oracle.com>
> Cc: linux-rdma@vger.kernel.org; linux-kernel@vger.kernel.org; dledford@redhat.com; jgg@ziepe.ca; Haakon Bugge <haakon.bugge@oracle.com>
> Subject: Re: [PATCH v3 3/3] IB/core: Obtain subnet_prefix from cache in IB devices.
> 
> On Wed, Jun 09, 2021 at 11:25:34AM +0530, Anand Khoje wrote:
> > ib_query_port() calls device->ops.query_port() to get the port 
> > attributes. The method of querying is device driver specific.
> > The same function calls device->ops.query_gid() to get the GID and 
> > extract the subnet_prefix (gid_prefix).
> > 
> > The GID and subnet_prefix are stored in a cache. But they do not get 
> > read from the cache if the device is an Infiniband device. The 
> > following change takes advantage of the cached subnet_prefix.
> > Testing with RDBMS has shown a significant improvement in performance 
> > with this change.
> > 
> > The function ib_cache_is_initialised() is introduced because
> > ib_query_port() gets called early in the stage when the cache is not 
> > built while reading port immutable property.
> > 
> > In that case, the default GID still gets read from HCA for IB link- 
> > layer devices.
> > 
> > Fixes: fad61ad ("IB/core: Add subnet prefix to port info")
> > Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
> > Signed-off-by: Haakon Bugge <haakon.bugge@oracle.com>
> > 
> > ---
> > 
> > v1 -> v2:
> >     -	Split the v1 patch in 3 patches as per Leon's suggestion.
> > 
> > v2 -> v3:
> >     -	Added changes as per Mark Zhang's suggestion of clearing
> >     	flags in git_table_cleanup_one().
> > 
> > ---
> >  drivers/infiniband/core/cache.c  | 7 ++++++-  
> > drivers/infiniband/core/device.c | 9 +++++++++
> >  include/rdma/ib_cache.h          | 6 ++++++
> >  include/rdma/ib_verbs.h          | 6 ++++++
> >  4 files changed, 27 insertions(+), 1 deletion(-)
> 
> Why did you use clear_bit/test_bit API? I would expect it for the bitmap, but for such simple thing, the simple "u8 is_cached_init : 1;"
> will do the same trick.
> 
> Thanks
> 
> > 
> > diff --git a/drivers/infiniband/core/cache.c 
> > b/drivers/infiniband/core/cache.c index e957f0c915a3..94a8653a72c5 
> > 100644
> > --- a/drivers/infiniband/core/cache.c
> > +++ b/drivers/infiniband/core/cache.c
> > @@ -917,9 +917,12 @@ static void gid_table_cleanup_one(struct 
> > ib_device *ib_dev)  {
> >  	u32 p;
> >  
> > -	rdma_for_each_port (ib_dev, p)
> > +	rdma_for_each_port (ib_dev, p) {
> > +		clear_bit(IB_PORT_CACHE_INITIALIZED,
> > +			&ib_dev->port_data[p].flags);
> >  		cleanup_gid_table_port(ib_dev, p,
> >  				       ib_dev->port_data[p].cache.gid);
> > +	}
> >  }
> >  
> >  static int gid_table_setup_one(struct ib_device *ib_dev) @@ -1623,6 
> > +1626,8 @@ int ib_cache_setup_one(struct ib_device *device)
> >  		err = ib_cache_update(device, p, true);
> >  		if (err)
> >  			return err;
> > +		set_bit(IB_PORT_CACHE_INITIALIZED,
> > +			&device->port_data[p].flags);
> >  	}
> >  
> >  	return 0;
> > diff --git a/drivers/infiniband/core/device.c 
> > b/drivers/infiniband/core/device.c
> > index 595128b26c34..e8e7b0a61411 100644
> > --- a/drivers/infiniband/core/device.c
> > +++ b/drivers/infiniband/core/device.c
> > @@ -2059,6 +2059,15 @@ static int __ib_query_port(struct ib_device *device,
> >  	    IB_LINK_LAYER_INFINIBAND)
> >  		return 0;
> >  
> > +	if (!ib_cache_is_initialised(device, port_num))
> > +		goto query_gid_from_device;
> > +
> > +	ib_get_cached_subnet_prefix(device, port_num,
> > +				    &port_attr->subnet_prefix);
> > +
> > +	return 0;
> > +
> > +query_gid_from_device:
> >  	err = device->ops.query_gid(device, port_num, 0, &gid);
> >  	if (err)
> >  		return err;
> > diff --git a/include/rdma/ib_cache.h b/include/rdma/ib_cache.h index 
> > 226ae3702d8a..1526fc6637eb 100644
> > --- a/include/rdma/ib_cache.h
> > +++ b/include/rdma/ib_cache.h
> > @@ -114,4 +114,10 @@ ssize_t rdma_query_gid_table(struct ib_device *device,
> >  			     struct ib_uverbs_gid_entry *entries,
> >  			     size_t max_entries);
> >  
> > +static inline bool ib_cache_is_initialised(struct ib_device *device,
> > +					  u8 port_num)
> > +{
> > +	return test_bit(IB_PORT_CACHE_INITIALIZED,
> > +			&device->port_data[port_num].flags);
> > +}
> >  #endif /* _IB_CACHE_H */
> > diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h index 
> > 41cbec516424..ad2a55e3a2ee 100644
> > --- a/include/rdma/ib_verbs.h
> > +++ b/include/rdma/ib_verbs.h
> > @@ -2169,6 +2169,10 @@ struct ib_port_immutable {
> >  	u32                           max_mad_size;
> >  };
> >  
> > +enum ib_port_data_flags {
> > +	IB_PORT_CACHE_INITIALIZED = 1 << 0,
> > +};
> > +
> >  struct ib_port_data {
> >  	struct ib_device *ib_dev;
> >  
> > @@ -2178,6 +2182,8 @@ struct ib_port_data {
> >  
> >  	spinlock_t netdev_lock;
> >  
> > +	unsigned long flags;
> > +
> >  	struct list_head pkey_list;
> >  
> >  	struct ib_port_cache cache;
> > --
> > 2.27.0
> > 
