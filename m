Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24011C7740
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 18:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbgEFQ4N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 12:56:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729774AbgEFQ4N (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 May 2020 12:56:13 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 077EA208E4;
        Wed,  6 May 2020 16:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588784172;
        bh=/kCm+r/X+xBMfvi5mOSUTHhaaUOSgwbAga3v2NOw5ko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u0ZxtRlMopfOs2PbJluJz0ROhMqgJrvvNbMaNPrPOE3iOVcgzrfXlxrGw6RtIRD0J
         DfxtFS+ODWaE6Ld5QxcUANzuT1WJXTGpy/GpHvkPONkyhJz275e9uvl/1uZZojBMio
         JHfcPo1Mv/b1hCdzmR6d6W21jH47sTkpUZz5AFPU=
Date:   Wed, 6 May 2020 19:56:08 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc v1] IB/core: Fix potential NULL pointer
 dereference in pkey cache
Message-ID: <20200506165608.GA4600@unreal>
References: <20200506053213.566264-1-leon@kernel.org>
 <20200506144344.GA8875@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506144344.GA8875@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 06, 2020 at 11:43:44AM -0300, Jason Gunthorpe wrote:
> On Wed, May 06, 2020 at 08:32:13AM +0300, Leon Romanovsky wrote:
> > From: Jack Morgenstein <jackm@dev.mellanox.co.il>
> >
> > The IB core pkey cache is populated by procedure ib_cache_update().
> > Initially, the pkey cache pointer is NULL. ib_cache_update allocates
> > a buffer and populates it with the device's pkeys, via repeated calls
> > to procedure ib_query_pkey().
> >
> > If there is a failure in populating the pkey buffer via ib_query_pkey(),
> > ib_cache_update does not replace the old pkey buffer cache with the
> > updated one -- it leaves the old cache as is.
> >
> > Since initially the pkey buffer cache is NULL, when calling
> > ib_cache_update the first time, a failure in ib_query_pkey() will cause
> > the pkey buffer cache pointer to remain NULL.
> >
> > In this situation, any calls subsequent to ib_get_cached_pkey(),
> > ib_find_cached_pkey(), or ib_find_cached_pkey_exact() will try to
> > dereference the NULL pkey cache pointer, causing a kernel panic.
> >
> > Fix this by checking the ib_cache_update() return value.
> >
> > Fixes: 8faea9fd4a39 ("RDMA/cache: Move the cache per-port data into the main ib_port_data")
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > ---
> > Changelog:
> > v1: I rewrote the patch to take care of ib_cache_update() return value.
> > v0: https://lore.kernel.org/linux-rdma/20200426075811.129814-1-leon@kernel.org
> > ---
> >  drivers/infiniband/core/cache.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > --
> > 2.26.2
> >
> > diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
> > index 717b798cddad..1cbebfa374a5 100644
> > --- a/drivers/infiniband/core/cache.c
> > +++ b/drivers/infiniband/core/cache.c
> > @@ -1553,10 +1553,17 @@ int ib_cache_setup_one(struct ib_device *device)
> >  	if (err)
> >  		return err;
> >
> > -	rdma_for_each_port (device, p)
> > -		ib_cache_update(device, p, true);
> > +	rdma_for_each_port (device, p) {
> > +		err = ib_cache_update(device, p, true);
> > +		if (err)
> > +			goto out;
> > +	}
> >
> >  	return 0;
> > +
> > +out:
> > +	ib_cache_release_one(device);
> > +	return err;
>
> ib_cache_release_once can be called only once, and it is always called
> by ib_device_release(), it should not be called here

It doesn't sound right if we rely on ib_device_release() to unwind error
in ib_cache_setup_one(). I don't think that we need to return from
ib_cache_setup_one() without cleaning it.

Thanks

>
> Jason
