Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77BD1280D67
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Oct 2020 08:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgJBGUQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Oct 2020 02:20:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgJBGUQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 2 Oct 2020 02:20:16 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9589206DD;
        Fri,  2 Oct 2020 06:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601619615;
        bh=LJgwOPywhe/GE+/YpTDrV1CWbLYmEMUmvHtzWpQaCwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WCDBetgaxhJB6AvydPCJHhh4c3L//MtbJUp1KbeEAMYq5z9VGL1Pc8YSxeN3otpX4
         76JKzG8P04j2DR36gsqQSEkXcL4nncDU9xiToovkSobZGM09kJShLVC/6iGtZNgCzh
         wl8kHYRacYiaqNg5ZNIv8v7wCe46CUVRRziiCo/I=
Date:   Fri, 2 Oct 2020 09:20:11 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Parav Pandit <parav@nvidia.com>
Cc:     "Ertman, David M" <david.m.ertman@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 1/6] Add ancillary bus support
Message-ID: <20201002062011.GY3094@unreal>
References: <20201001050534.890666-1-david.m.ertman@intel.com>
 <20201001050534.890666-2-david.m.ertman@intel.com>
 <20201001083229.GV3094@unreal>
 <DM6PR11MB2841DEF5C090BC8D830DEC52DD300@DM6PR11MB2841.namprd11.prod.outlook.com>
 <20201001174025.GW3094@unreal>
 <BY5PR12MB4322C7955974B4DCFC8078EFDC300@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20201001193211.GX3094@unreal>
 <BY5PR12MB4322EDDDF036BB58DE3A1F7BDC310@BY5PR12MB4322.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR12MB4322EDDDF036BB58DE3A1F7BDC310@BY5PR12MB4322.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 02, 2020 at 05:29:26AM +0000, Parav Pandit wrote:
>
>
> > From: Leon Romanovsky <leon@kernel.org>
> > Sent: Friday, October 2, 2020 1:02 AM
>
> > > > > > > +Registering an ancillary_device is a two-step process.  First
> > > > > > > +you must call ancillary_device_initialize(), which will check
> > > > > > > +several aspects of the ancillary_device struct and perform a
> > > > > > > +device_initialize().  After this step completes, any error
> > > > > > > +state must have a call to put_device() in its
> > > > > > resolution
> > > > > > > +path.  The second step in registering an ancillary_device is
> > > > > > > +to perform a
> > > > > > call
> > > > > > > +to ancillary_device_add(), which will set the name of the
> > > > > > > +device and add
> > > > > > the
> > > > > > > +device to the bus.
> > > > > > > +
> > > > > > > +To unregister an ancillary_device, just a call to
> > > > > > ancillary_device_unregister()
> > > > > > > +is used.  This will perform both a device_del() and a put_device().
> > > > > >
> > > > > > Why did you chose ancillary_device_initialize() and not
> > > > > > ancillary_device_register() to be paired with
> > > > ancillary_device_unregister()?
> > > > > >
> > > > > > Thanks
> > > > >
> > > > > We originally had a single call to ancillary_device_register()
> > > > > that paired with unregister, but there was an ask to separate the
> > > > > register into an initialize and add to make the error condition
> > > > > unwind more
> > > > compartimentalized.
> > > >
> > > > It is correct thing to separate, but I would expect:
> > > > ancillary_device_register()
> > > > ancillary_device_add()
> > > >
> > > device_initialize(), device_add() and device_unregister() is the pattern widely
> > followed in the core.
> >
> > It doesn't mean that I need to agree with that, right?
> >
> Right. May be I misunderstood your comment where you said "I expect device_register() and device_add()" in response to "device_initialize() and device_add".
> I interpreted your comment as to replace initialize() with register().
> Because that is odd naming and completely out of sync from the core APIs.
>
> A helper like below that wraps initialize() and add() is buggy, because when register() returns an error, it doesn't know if should do kfree() or put_device().

I wrote above (14 lines above this line) that I understand and support
the request to separate init and add parts. There is only one thing that
I didn't like that we have _unregister() but don't have _register().
It is not a big deal.

>
> ancillary_device_register(adev)
> {
>   ret = ancillary_device_initialize();
>   if (ret)
>     return ret;
>
>   ret = ancillary_device_add();
>   if (ret)
>     put_device(dev);
>   return ret;
> }
>
> > >
> > > > vs.
> > > > ancillary_device_unregister()
> > > >
> > > > It is not a big deal, just curious.
> > > >
> > > > The much more big deal is that I'm required to create 1-to-1 mapping
> > > > between device and driver, and I can't connect all my different
> > > > modules to one xxx_core.pf.y device in N-to-1 mapping. "N"
> > > > represents different protocols (IB, ETH, SCSI) and "1" is one PCI core.
> > >
> > > For one mlx5 (pf/vf/sf) device, there are three class erivers (ib, vdpa, en).
> > >
> > > So there should be one ida allocate per mlx5 device type.
> > >
> > > Static const mlx5_adev_names[MLX5_INTERFACE_PROTOCOL_MAX] = {
> > > 	"rdma",
> > > 	"eth",
> > > 	"vdpa"
> > > };
> > >
> > > Something like for current mlx5_register_device(),
> >
> > I know it and already implemented it, this is why I'm saying that it is not what I
> > would expect from the implementation.
> >
> > It is wrong create mlx5_core.rdma.1 device that is equal to mlx5_core.eth.1 just
> > to connect our mlx5_ib.ko to it, while documentation explains about creating
>
> Ancillary bus's documentation? If so, it should be corrected.
> Do you have specific text snippet to point to that should be fixed?

+One example could be a multi-port PCI network device that is rdma-capable and
+needs to export this functionality and attach to an rdma driver in another
+subsystem.  The PCI driver will allocate and register an ancillary_device for
+each physical function on the NIC.  The rdma driver will register an
+ancillary_driver that will be matched with and probed for each of these
+ancillary_devices.  This will give the rdma driver access to the shared data/ops
+in the PCI drivers shared object to establish a connection with the PCI driver.

>
> For purpose of matching service functionality, for each different class (ib, eth, vdpa) there is one ancillary device created.
> What exactly is wrong here? (and why is it wrong now and not in previous version of the RFC?)

Here the example of two real systems, see how many links we created to
same mlx5_core PCI logic. I imagine that Qlogic and Chelsio drivers will
look even worse, because they spread over more subsystems than mlx5.

This is first time when I see real implementation of real device.

System with 2 IB and 1 RoCE cards:
[leonro@vm ~]$ ls -l /sys/bus/ancillary/devices/
 mlx5_core.eth.0 -> ../../../devices/pci0000:00/0000:00:09.0/mlx5_core.eth.0
 mlx5_core.eth.1 -> ../../../devices/pci0000:00/0000:00:0a.0/mlx5_core.eth.1
 mlx5_core.eth.2 -> ../../../devices/pci0000:00/0000:00:0b.0/mlx5_core.eth.2
 mlx5_core.ib.0 -> ../../../devices/pci0000:00/0000:00:09.0/mlx5_core.ib.0
 mlx5_core.ib.1 -> ../../../devices/pci0000:00/0000:00:0a.0/mlx5_core.ib.1
 mlx5_core.ib.2 -> ../../../devices/pci0000:00/0000:00:0b.0/mlx5_core.ib.2
 mlx5_core.vdpa.0 -> ../../../devices/pci0000:00/0000:00:09.0/mlx5_core.ib.0
 mlx5_core.vdpa.1 -> ../../../devices/pci0000:00/0000:00:0a.0/mlx5_core.ib.1
 mlx5_core.vdpa.2 -> ../../../devices/pci0000:00/0000:00:0b.0/mlx5_core.ib.2
[leonro@vm ~]$ rdma dev
0: ibp0s9: node_type ca fw 4.6.9999 node_guid 5254:00c0:fe12:3455 sys_image_guid 5254:00c0:fe12:3455
1: ibp0s10: node_type ca fw 4.6.9999 node_guid 5254:00c0:fe12:3456 sys_image_guid 5254:00c0:fe12:3456
2: rdmap0s11: node_type ca fw 4.6.9999 node_guid 5254:00c0:fe12:3457 sys_image_guid 5254:00c0:fe12:3457

System with RoCE SR-IOV card with 4 VFs:
[leonro@vm ~]$ ls -l /sys/bus/ancillary/devices/
 mlx5_core.eth.0 -> ../../../devices/pci0000:00/0000:00:09.0/0000:01:00.0/mlx5_core.eth.0
 mlx5_core.eth.1 -> ../../../devices/pci0000:00/0000:00:09.0/0000:01:00.1/mlx5_core.eth.1
 mlx5_core.eth.2 -> ../../../devices/pci0000:00/0000:00:09.0/0000:01:00.2/mlx5_core.eth.2
 mlx5_core.eth.3 -> ../../../devices/pci0000:00/0000:00:09.0/0000:01:00.3/mlx5_core.eth.3
 mlx5_core.eth.4 -> ../../../devices/pci0000:00/0000:00:09.0/0000:01:00.4/mlx5_core.eth.4
 mlx5_core.ib.0 -> ../../../devices/pci0000:00/0000:00:09.0/0000:01:00.0/mlx5_core.ib.0
 mlx5_core.ib.1 -> ../../../devices/pci0000:00/0000:00:09.0/0000:01:00.1/mlx5_core.ib.1
 mlx5_core.ib.2 -> ../../../devices/pci0000:00/0000:00:09.0/0000:01:00.2/mlx5_core.ib.2
 mlx5_core.ib.3 -> ../../../devices/pci0000:00/0000:00:09.0/0000:01:00.3/mlx5_core.ib.3
 mlx5_core.ib.4 -> ../../../devices/pci0000:00/0000:00:09.0/0000:01:00.4/mlx5_core.ib.4
 mlx5_core.vdpa.0 -> ../../../devices/pci0000:00/0000:00:09.0/0000:01:00.0/mlx5_core.ib.0
 mlx5_core.vdpa.1 -> ../../../devices/pci0000:00/0000:00:09.0/0000:01:00.1/mlx5_core.ib.1
 mlx5_core.vdpa.2 -> ../../../devices/pci0000:00/0000:00:09.0/0000:01:00.2/mlx5_core.ib.2
 mlx5_core.vdpa.3 -> ../../../devices/pci0000:00/0000:00:09.0/0000:01:00.3/mlx5_core.ib.3
 mlx5_core.vdpa.4 -> ../../../devices/pci0000:00/0000:00:09.0/0000:01:00.4/mlx5_core.ib.4
[leonro@vm ~]$ rdma dev
0: rocep1s0f0: node_type ca fw 4.6.9999 node_guid 5254:00c0:fe12:3455 sys_image_guid 5254:00c0:fe12:3455
1: rocep1s0f0v0: node_type ca fw 4.6.9999 node_guid 0000:0000:0000:0000 sys_image_guid 5254:00c0:fe12:3456
2: rocep1s0f0v1: node_type ca fw 4.6.9999 node_guid 0000:0000:0000:0000 sys_image_guid 5254:00c0:fe12:3457
3: rocep1s0f0v2: node_type ca fw 4.6.9999 node_guid 0000:0000:0000:0000 sys_image_guid 5254:00c0:fe12:3458
4: rocep1s0f0v3: node_type ca fw 4.6.9999 node_guid 0000:0000:0000:0000 sys_image_guid 5254:00c0:fe12:3459

>
> Do you want to create one device and 3 drivers to bind to it? If you think that way, may be pci core should be extended to support that, ancillary bus may not be required.
> But that is different solution than what is being proposed here.

This is my expectation, I see this virtual bus as glue logic for the
drivers between different subsystems.

> Not sure I understand your comment about wrong create mlx5_core.rdma1 equal to core.eth.1", because they are not equal.
> To begin with, they have different id for matching service, and in future it should be extended to pass 'only' needed info.
> mlx5_core exposing the 'whole' mlx5_core_dev to other drivers doesn't look correct.

Maybe, what I would like to see is:
[leonro@vm ~]$ ls -l /sys/bus/ancillary/devices/
 mlx5_core.pf.0 -> ../../../devices/pci0000:00/0000:00:09.0/0000:01:00.0/mlx5_core.pf.0
 mlx5_core.vf.0 -> ../../../devices/pci0000:00/0000:00:09.0/0000:01:00.1/mlx5_core.vf.0
 mlx5_core.vf.1 -> ../../../devices/pci0000:00/0000:00:09.0/0000:01:00.2/mlx5_core.vf.1
 mlx5_core.vf.2 -> ../../../devices/pci0000:00/0000:00:09.0/0000:01:00.3/mlx5_core.vf.2
 mlx5_core.vf.3 -> ../../../devices/pci0000:00/0000:00:09.0/0000:01:00.4/mlx5_core.vf.3

The mlx5_ib, mlx5_vdpa and mlx5_en will connect to one of mlx5_core.XX.YY devices.

Thanks
