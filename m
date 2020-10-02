Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128EF28117B
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Oct 2020 13:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgJBLpu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Oct 2020 07:45:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgJBLpu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 2 Oct 2020 07:45:50 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB03E206E3;
        Fri,  2 Oct 2020 11:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601639149;
        bh=Pz95HEQOu00LREcKTfrLQ1OFE1RN0p/e2FOjSN+3YCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ekKbSGUw21UaYEvRUV8yiPQcmwJGbCvnn3sA7Jtpmf6oQGlslma7PUp3G5OrzYMtu
         5ZmOe++epRlOk5iKUX39fNShoZ9ZE3C/63XLMkorII6aI/Hvb2aQt6VTA9BA7eRfDD
         zRBE+/etpWIfm7KbA3+nAb56EacOoK6zOtM12r68=
Date:   Fri, 2 Oct 2020 14:45:45 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Parav Pandit <parav@nvidia.com>
Cc:     "Ertman, David M" <david.m.ertman@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 1/6] Add ancillary bus support
Message-ID: <20201002114545.GB3094@unreal>
References: <20201001083229.GV3094@unreal>
 <DM6PR11MB2841DEF5C090BC8D830DEC52DD300@DM6PR11MB2841.namprd11.prod.outlook.com>
 <20201001174025.GW3094@unreal>
 <BY5PR12MB4322C7955974B4DCFC8078EFDC300@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20201001193211.GX3094@unreal>
 <BY5PR12MB4322EDDDF036BB58DE3A1F7BDC310@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20201002062011.GY3094@unreal>
 <BY5PR12MB4322C2E2E726DCF700802104DC310@BY5PR12MB4322.namprd12.prod.outlook.com>
 <20201002111354.GZ3094@unreal>
 <BY5PR12MB432201FCEA970DA28AB06166DC310@BY5PR12MB4322.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR12MB432201FCEA970DA28AB06166DC310@BY5PR12MB4322.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 02, 2020 at 11:27:43AM +0000, Parav Pandit wrote:
>
>
> > From: Leon Romanovsky <leon@kernel.org>
> > Sent: Friday, October 2, 2020 4:44 PM
>
> [..]
> > > > ../../../devices/pci0000:00/0000:00:0b.0/mlx5_core.eth.2
> > > This gives you the ability to not load the netdevice and rdma device of a VF
> > and only load the vdpa device.
> > > These are real use case that users have asked for.
> > > In use case one, they are only interested in rdma device.
> > > In second use case only vdpa device.
> > > How shall one achieve that without spinning of the device for each class?
> >
> > Why will it be different if ancillary device is small PCI core?
> > If you want RDMA, you will use specific ancillary driver that connects to that
> > small PCI logic.
>
> I didn't follow, wwhat is PCI core and PCI logic in this context?

mlx5_core is PCI core/logic - ancillary device
mlx5_ib/mlx5_en/mlx5_vdpa - ancillary drivers

>
> Not sure if you understood the use case.
> Let me try again.
> Let say there are 4 VFs enabled.
> User would not like to create netdev for 3 VFs (0 to 2) ; user only wants rdma device for these VFs 0 to 2.
> User wants only vdpa device for 4th VF.
> User doesn't want to create rdma device and netdevice for the 4th VF.
> How one shall achieve this?

It depends on how N-to-1 bus will be implemented. For example, devlink
already allows to disable RoCE on specific function, nothing prohibits
to extend it to support other classes.

> It is easily achievable with current ancillary device instantiation per class proposal.

It is byproduct of 1-to-1 connection and not specific design decision.

>
> > Being nice to the users and provide clean abstraction are important goals too.
> Which part of this makes not_nice_to_users and what is not abstracted.
> I lost you.

Your use case perfectly presented not_nice_to_users thing. Users are
interested to work on functions (VF/PF/SF) and configure them without
need to dig into the sysfs directories to connect ancillary classes
and their indexes to the real functions.

Thanks
