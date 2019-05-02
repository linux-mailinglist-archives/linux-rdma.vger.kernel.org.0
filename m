Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D650711294
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2019 07:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfEBF0j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 May 2019 01:26:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfEBF0j (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 May 2019 01:26:39 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16B442085A;
        Thu,  2 May 2019 05:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556774798;
        bh=WwXxMD/Z8IZGVNSYbPauYW3sigFOUV3wwZt343vv3Xk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NZAjWYH5vUtLpnQ7wJNs+/1YY0w7CrWDB2X5UYx+sti5x9aiOR4kp+A6q+uQBZtck
         6kWQVTkuiN3SIt39iMZRB/lpyGYEp5SObxnPfuRh/X7sz5KmwtimXFXsF+w8bwX7Zk
         qZw4Upzigh3HRGQvmG7zmE+mDQtqLKPyBFxnRJx0=
Date:   Thu, 2 May 2019 08:26:32 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Parav Pandit <parav@mellanox.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/device: Don't fire uevent before device
 is fully initialized
Message-ID: <20190502052632.GG7676@mtr-leonro.mtl.com>
References: <20190501054619.14838-1-leon@kernel.org>
 <20190501115049.GA10407@mellanox.com>
 <20190501173126.GD7676@mtr-leonro.mtl.com>
 <VI1PR0501MB227160596CFF8DF1C72AAAF3D1340@VI1PR0501MB2271.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0501MB227160596CFF8DF1C72AAAF3D1340@VI1PR0501MB2271.eurprd05.prod.outlook.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 02, 2019 at 01:50:22AM +0000, Parav Pandit wrote:
> Hi Leon,
>
> > -----Original Message-----
> > From: linux-rdma-owner@vger.kernel.org <linux-rdma-
> > owner@vger.kernel.org> On Behalf Of Leon Romanovsky
> > Sent: Wednesday, May 1, 2019 12:31 PM
> > To: Jason Gunthorpe <jgg@mellanox.com>
> > Cc: Doug Ledford <dledford@redhat.com>; RDMA mailing list <linux-
> > rdma@vger.kernel.org>
> > Subject: Re: [PATCH rdma-next] RDMA/device: Don't fire uevent before
> > device is fully initialized
> >
> > On Wed, May 01, 2019 at 01:28:55PM +0000, Jason Gunthorpe wrote:
> > > On Wed, May 01, 2019 at 08:46:19AM +0300, Leon Romanovsky wrote:
> > > > From: Leon Romanovsky <leonro@mellanox.com>
> > > >
> > > > When the refcount is 0 the device is invisible to netlink. However
> > > > in the patch below the refcount = 1 was moved to after the device_add().
> > > > This creates a race where userspace can issue a netlink query after
> > > > the
> > > > device_add() event and not see the device as visible.
> > > >
> > > > Ensure that no uevent is fired before device is fully registered.
> > > >
> > > > Fixes: d79af7242bb2 ("RDMA/device: Expose ib_device_try_get(()")
> > > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > > > drivers/infiniband/core/device.c | 12 ++++++++++++
> > > >  1 file changed, 12 insertions(+)
> > > >
> > > > diff --git a/drivers/infiniband/core/device.c
> > > > b/drivers/infiniband/core/device.c
> > > > index 8ae4906a60e7..4cdc8588df7f 100644
> > > > +++ b/drivers/infiniband/core/device.c
> > > > @@ -808,6 +808,7 @@ static int add_one_compat_dev(struct ib_device
> > *device,
> > > >  	cdev->dev.release = compatdev_release;
> > > >  	dev_set_name(&cdev->dev, "%s", dev_name(&device->dev));
> > > >
> > > > +	dev_set_uevent_suppress(&device->dev, true);
> > > >  	ret = device_add(&cdev->dev);
> > > >  	if (ret)
> > > >  		goto add_err;
> > >
> > > compat devices definitely should not be doing this..
> >
> > Why? They have the same problematic pattern:
> >  device_add -> ..... -> enable_device.
> >
> compat devices are added in enable_device_and_get() after refcount is set.
> ib_register_device()
>    enable_device_and_get()
>        refcount=2
>        [...]
>        add_compat_devs()



ok, I will return to my original patch before I changed its as a
response for review comments.

Thanks
