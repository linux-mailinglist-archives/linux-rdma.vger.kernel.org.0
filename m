Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A18E3FF7C6
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Sep 2021 01:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbhIBXYP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Sep 2021 19:24:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232902AbhIBXYO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 Sep 2021 19:24:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 393FC60F21;
        Thu,  2 Sep 2021 23:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630624995;
        bh=ZZC4bsiJlmrxnQRzitRe1+pMj/zF1alN4i5xQjgy8HA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cnjX3s9/FN+t/6gH26V5bYue3E/1XpfXbN/Dashp6M+NwknD+FZ29cnnd8XiOvZu7
         m1e7LJAUx4war0RfeoZ5/ABoXFKGSw5jcdkPHMPHfLNwmPXP8wrxQQFZ2UNQ74A1HP
         ISTpPr/DZ1sivf0h0dM48HJ4n1bVkykSi8K1T38npH3F6Wm7sSQ1eahElgYxNE3JP2
         +ifUycTu1Rp2xhDKq3sV2rfDAYnU4jIrzZuYqFIXkkoTz7R+ysz1Rzkj5mq8po9vwj
         xCr8ReqXIBYsOy1mtAmxyJbrw+8C175xmYZdBkE7KmllsYPUJk24hIKXtP3ewqlYeU
         T3bgCFVGIt6rw==
Date:   Fri, 3 Sep 2021 02:23:12 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2 rdma-core] irdma: Add ice and irdma to kernel-boot
 rules
Message-ID: <YTFc4L0DPn9lNFmi@unreal>
References: <20210823154816.2027-1-tatyana.e.nikolova@intel.com>
 <20210823161116.GO1721383@nvidia.com>
 <DM6PR11MB46922D3AE92E34B4E1D3AC9FCBCE9@DM6PR11MB4692.namprd11.prod.outlook.com>
 <YTD1vWjFToPt7JLC@unreal>
 <DM6PR11MB4692524C197F055A727468F4CBCE9@DM6PR11MB4692.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4692524C197F055A727468F4CBCE9@DM6PR11MB4692.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 02, 2021 at 04:13:44PM +0000, Nikolova, Tatyana E wrote:
> 
> 
> > -----Original Message-----
> > From: Leon Romanovsky <leon@kernel.org>
> > Sent: Thursday, September 2, 2021 11:03 AM
> > To: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>
> > Cc: Jason Gunthorpe <jgg@nvidia.com>; dledford@redhat.com; linux-
> > rdma@vger.kernel.org
> > Subject: Re: [PATCH v2 rdma-core] irdma: Add ice and irdma to kernel-boot
> > rules
> > 
> > On Thu, Sep 02, 2021 at 03:29:43PM +0000, Nikolova, Tatyana E wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > Sent: Monday, August 23, 2021 11:11 AM
> > > > To: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>
> > > > Cc: dledford@redhat.com; leon@kernel.org; linux-rdma@vger.kernel.org
> > > > Subject: Re: [PATCH v2 rdma-core] irdma: Add ice and irdma to
> > > > kernel-boot rules
> > > >
> > > > On Mon, Aug 23, 2021 at 10:48:16AM -0500, Tatyana Nikolova wrote:
> > > > > Add ice and irdma to kernel-boot rules so that these devices are
> > > > > recognized as iWARP and RoCE capable.
> > > > >
> > > > > Otherwise the port mapper service which is only relevant for iWARP
> > > > > devices may not start automatically after boot.
> > > > >
> > > > > Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
> > > > > kernel-boot/rdma-description.rules | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > >
> > > > Given that ice is both iwarp and roce, is there some better way to
> > > > detect this? Doesn't the aux device encode it?
> > >
> > > Hi Jason,
> > >
> > > We tried a few experiments without success. The auxiliary devices alias
> > with our driver and not ice, so maybe this is the reason?
> > >
> > > Here is an example of what we tried.
> > >
> > > udevadm info
> > > /sys/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> > > P: /devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> > > E: DEVPATH=/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> > > E: DRIVER=irdma
> > > E: MODALIAS=auxiliary:ice.roce
> > > E: SUBSYSTEM=auxiliary
> > >
> > > udevadm info /sys/bus/auxiliary/devices/ice.roce.0
> > > P: /devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> > > E: DEVPATH=/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> > > E: DRIVER=irdma
> > > E: MODALIAS=auxiliary:ice.roce
> > > E: SUBSYSTEM=auxiliary
> > 
> > Everything will be much easier if you follow my initial review comment about
> > auxiliary bus naming when irdma driver was added.
> > 
> > The RoCE device should be:
> > P: /devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> > E: MODALIAS=auxiliary:ice.roce
> > 
> > and the iWARP device needs to be:
> > P: /devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.iwarp.0
> > E: MODALIAS=auxiliary:ice.iwarp
> 
> Hi Leon,
>  
> This is what we have now. We just provided an example with RoCE.

Great, so it seems like you almost there.

> 
> > 
> > Thanks
