Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEFA63FF0AF
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Sep 2021 18:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbhIBQEa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Sep 2021 12:04:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235598AbhIBQEM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 Sep 2021 12:04:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4533E60FDA;
        Thu,  2 Sep 2021 16:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630598594;
        bh=a5+IHTkzh7Rr3gTiLJsC1eqzbfdzwmj1baSpGDshNTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UARzHeTN/aYGBL5KZawP60NkbMVxiW48ncUubOUh3bgSHcB7O9URZQbuQuVhZDg/V
         WRN5QsYyHtBKiPnTThL4RJLrRkQN27sxPcLHJhv3Fh7/K/klsl1OMJsjy8Jp+y23By
         uZUIJfmMkMPkeJXSvBvGmccuj4r6UjE0EtLj7IzF4gi9Km3uhxmMjCnUg1AeskSze4
         FB/lenLy0Y0+SziVJQPWGXy2fW+gUaHDIvL6yRHeHy5NNVeqBqbKBa8t1HYGlz8mLf
         svPpzZ1HTkThjz414q4gaSGymAUPm6zKXgZZiA8uem+XynUFEFf1+N3GYGK+l/JXxq
         1+KdEwzX/v1ZQ==
Date:   Thu, 2 Sep 2021 19:03:09 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2 rdma-core] irdma: Add ice and irdma to kernel-boot
 rules
Message-ID: <YTD1vWjFToPt7JLC@unreal>
References: <20210823154816.2027-1-tatyana.e.nikolova@intel.com>
 <20210823161116.GO1721383@nvidia.com>
 <DM6PR11MB46922D3AE92E34B4E1D3AC9FCBCE9@DM6PR11MB4692.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB46922D3AE92E34B4E1D3AC9FCBCE9@DM6PR11MB4692.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 02, 2021 at 03:29:43PM +0000, Nikolova, Tatyana E wrote:
> 
> 
> > -----Original Message-----
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Monday, August 23, 2021 11:11 AM
> > To: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>
> > Cc: dledford@redhat.com; leon@kernel.org; linux-rdma@vger.kernel.org
> > Subject: Re: [PATCH v2 rdma-core] irdma: Add ice and irdma to kernel-boot
> > rules
> > 
> > On Mon, Aug 23, 2021 at 10:48:16AM -0500, Tatyana Nikolova wrote:
> > > Add ice and irdma to kernel-boot rules so that these devices are
> > > recognized as iWARP and RoCE capable.
> > >
> > > Otherwise the port mapper service which is only relevant for iWARP
> > > devices may not start automatically after boot.
> > >
> > > Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
> > > kernel-boot/rdma-description.rules | 2 ++
> > >  1 file changed, 2 insertions(+)
> > 
> > Given that ice is both iwarp and roce, is there some better way to detect
> > this? Doesn't the aux device encode it?
> 
> Hi Jason,
> 
> We tried a few experiments without success. The auxiliary devices alias with our driver and not ice, so maybe this is the reason?
> 
> Here is an example of what we tried. 
> 
> udevadm info /sys/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> P: /devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> E: DEVPATH=/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> E: DRIVER=irdma
> E: MODALIAS=auxiliary:ice.roce
> E: SUBSYSTEM=auxiliary
> 
> udevadm info /sys/bus/auxiliary/devices/ice.roce.0
> P: /devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> E: DEVPATH=/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> E: DRIVER=irdma
> E: MODALIAS=auxiliary:ice.roce
> E: SUBSYSTEM=auxiliary

Everything will be much easier if you follow my initial review comment about auxiliary
bus naming when irdma driver was added.

The RoCE device should be:
P: /devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
E: MODALIAS=auxiliary:ice.roce

and the iWARP device needs to be:
P: /devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.iwarp.0
E: MODALIAS=auxiliary:ice.iwarp

Thanks
