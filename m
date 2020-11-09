Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72662AB070
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Nov 2020 06:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgKIFJI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Nov 2020 00:09:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:41534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729389AbgKIFJH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 9 Nov 2020 00:09:07 -0500
Received: from localhost (searspoint.nvidia.com [216.228.112.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EE95221FB;
        Mon,  9 Nov 2020 05:09:06 +0000 (UTC)
Date:   Mon, 9 Nov 2020 07:09:02 +0200
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/nldev: Add parent bdf to device
 information dump
Message-ID: <20201109050902.GA4527@unreal>
References: <20201103132627.67642-1-galpress@amazon.com>
 <20201103134522.GL36674@ziepe.ca>
 <20201103135719.GK5429@unreal>
 <0825e1bf-f913-d2c1-ad3f-35ba3d6b75ef@amazon.com>
 <20201103142243.GM36674@ziepe.ca>
 <5e2208ab-9e87-56ae-bc38-5827637eb5be@amazon.com>
 <20201105200005.GJ36674@ziepe.ca>
 <cd3f2926-0491-8540-d6b1-534014190bae@amazon.com>
 <20201108234935.GC244516@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201108234935.GC244516@ziepe.ca>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Nov 08, 2020 at 07:49:35PM -0400, Jason Gunthorpe wrote:
> On Sun, Nov 08, 2020 at 03:03:45PM +0200, Gal Pressman wrote:
> > On 05/11/2020 22:00, Jason Gunthorpe wrote:
> > > On Tue, Nov 03, 2020 at 05:45:26PM +0200, Gal Pressman wrote:
> > >> On 03/11/2020 16:22, Jason Gunthorpe wrote:
> > >>> On Tue, Nov 03, 2020 at 04:11:19PM +0200, Gal Pressman wrote:
> > >>>> On 03/11/2020 15:57, Leon Romanovsky wrote:
> > >>>>> On Tue, Nov 03, 2020 at 09:45:22AM -0400, Jason Gunthorpe wrote:
> > >>>>>> On Tue, Nov 03, 2020 at 03:26:27PM +0200, Gal Pressman wrote:
> > >>>>>>> Add the ability to query the device's bdf through rdma tool netlink
> > >>>>>>> command (in addition to the sysfs infra).
> > >>>>>>>
> > >>>>>>> In case of virtual devices (rxe/siw), the netdev bdf will be shown.
> > >>>>>>
> > >>>>>> Why? What is the use case?
> > >>>>>
> > >>>>> Right, and why isn't netdev (RDMA_NLDEV_ATTR_NDEV_NAME) enough?
> > >>>>
> > >>>> When taking system topology into consideration you need some way to pair the
> > >>>> ibdev and bdf, especially when working with multiple devices.
> > >>>> The netdev name doesn't exist on devices with no netdevs (IB, EFA).
> > >>>
> > >>> You are supposed to use sysfs
> > >>>
> > >>> /sys/class/infiniband/ibp0s9/device
> > >>>
> > >>> Should always be the physical device
> > >>>
> > >>>> Why rdma tool? Because it's more intuitive than sysfs.
> > >>>
> > >>> But we generally don't put this information into netlink BDF is just
> > >>> the start, you need all the other topology information to make sense
> > >>> of it, and all that is in sysfs only already
> > >>
> > >> As the commit message says, it's in addition to the device sysfs.
> > >>
> > >> Many (if not most) of the existing rdma netlink commands are duplicates of some
> > >> sysfs entries, but show it in a more "modern" way.
> > >> I'm not convinced that bdf should be treated differently.
> > >
> > > Why did you call it BDF anyhow? it has nothing to do with PCI BDF
> > > other than it happens to be the PDF for PCI devices. Netdev called
> > > this bus_info
> >
> > Are there non pci devices in the subsystem?
>
> Yes, HNS uses non-pci devices
>
> > I can rename to a more fitting name, will change to bus_info unless
> > someone has a better idea.
>
> The thing is, is is still useless. You have to consult sysfs to
> understand what bus it is scoped on to do anything further with
> it. Can't just assume it is PCI.

Can anyone please remind me why are we doing it?
What problem do you solve here by adding new nldev attributes?

Thanks

>
> Jason
