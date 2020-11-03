Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295A12A3D11
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Nov 2020 07:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgKCG4q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Nov 2020 01:56:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:40522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbgKCG4q (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Nov 2020 01:56:46 -0500
Received: from localhost (host-213-179-129-39.customer.m-online.net [213.179.129.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21BD1206D5;
        Tue,  3 Nov 2020 06:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604386605;
        bh=1pw8epSlEOfcVzyP1Ig5GYBOSOWGgdzgKI5eIb922vA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IUdaAjfLRZ+KpuFUXU6agwKn7DfhL/3SVeraBUmSe6Sywh3jglyR1ULMsvgCM29FI
         FTWCqkna1vlzrW4tOCwKrfZjUaY84lEH5miVy/QCHIbhwPBEakc0z0KEHTxO0OzAsG
         bTRA5ZgCb/9Yzx25ngg79PSq9Lo6p8G7USjUvMmw=
Date:   Tue, 3 Nov 2020 08:56:41 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Adit Ranadive <aditr@vmware.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, pv-drivers@vmware.com
Subject: Re: [Suspected Spam] Re: [PATCH for-rc] RDMA/vmw_pvrdma: Fix the
 active_speed and phys_state value
Message-ID: <20201103065641.GI5429@unreal>
References: <20201028231945.6533-1-aditr@vmware.com>
 <20201029115733.GA2620339@nvidia.com>
 <e0a834a1-e5ee-4838-4718-d6ded1e954be@vmware.com>
 <38f4a89a-c443-2cb2-a3de-89481a86e192@vmware.com>
 <20201102180256.GG2620339@nvidia.com>
 <f8b16c37-14ef-5663-048c-75def55968b1@vmware.com>
 <20201102182714.GI2620339@nvidia.com>
 <14c28229-3a5e-88f4-f57a-eddbe7145231@vmware.com>
 <20201102184640.GJ2620339@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102184640.GJ2620339@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 02, 2020 at 02:46:40PM -0400, Jason Gunthorpe wrote:
> On Mon, Nov 02, 2020 at 10:38:19AM -0800, Adit Ranadive wrote:
> > On 11/2/20 10:27 AM, Jason Gunthorpe wrote:
> > > On Mon, Nov 02, 2020 at 10:21:21AM -0800, Adit Ranadive wrote:
> > >> On 11/2/20 10:02 AM, Jason Gunthorpe wrote:
> > >>> On Mon, Nov 02, 2020 at 09:55:25AM -0800, Adit Ranadive wrote:
> > >>>> On 10/29/20 9:16 AM, Adit Ranadive wrote:
> > >>>>> On 10/29/20 4:57 AM, Jason Gunthorpe wrote:
> > >>>>>> On Wed, Oct 28, 2020 at 11:19:45PM +0000, Adit Ranadive wrote:
> > >>>>>>> The PVRDMA device still reports the active_speed in u8.
> > >>>>>>> Lets use the ib_eth_get_speed to report the speed and
> > >>>>>>> width. Unfortunately, phys_state gets stored as msb of
> > >>>>>>> the new u16 active_speed.
> > >>>>>>
> > >>>>>> This explanation is not clear, I have no idea what this is fixing
> > >>>>>
> > >>>>> It seemed more clear to me in my head, I guess :).
> > >>>>>
> > >>>>> After commit 376ceb31ff87 changed the active_speed attribute to
> > >>>>> u16, both the active_speed and phys_state attributes in the
> > >>>>> pvrdma_port_attr struct are getting stored in this u16. As a
> > >>>>> result, these show up as invalid values in ibv_devinfo.
> > >>>>>
> > >>>>> Our device still gives us back a u8 active_speed so both these
> > >>>>> are getting stored in the u16. This fix I proposed simply gets
> > >>>>> the active_speed from the netdev while the phys_state still
> > >>>>> needs to come from the pvrdma device, i.e. the msb the of the
> > >>>>> u16. I also removed some unused functions as a result.
> > >>>>>
> > >>>>> Alternatively, I could change the u8 active_width and u16
> > >>>>> active_speed to reserved now that we're getting the active_speed
> > >>>>> and active_width from the ib_get_eth_speed function.
> > >>>>
> > >>>> Jason, did you have any comments on this or did you want me
> > >>>> to just send v1 with an updated description?
> > >>>
> > >>> I still haven't figured out what this is fixing.
> > >>>
> > >>> Is 'struct pvrdma_port_attr' some kind of ABI? If so why isn't the fix
> > >>> to revert the type?
> > >>
> > >> I can revert it but I thought that it had to a u16 based on the IBTA, no?
> > >> Or does that not apply to device-level stuff?
> > >
> > > You didn't answer the question, it it ABI to some kind of FW interface
> > > or something?
> > >
> > > *HOW* did two fields get overlapped onto a single u16?? The compiler
> > > won't do this..
> > >
> >
> > It is an ABI to the device for port attributes. The device gives us back
> > this structure for query port verb. The response from the device is
> > memcopied into this pvrdma_port_attr structure. So both the bytes
> > representing active_speed and phys_state from the device are copied
> > into the single u16 in this structure.
>
> So it is ABI and it shouldn't have been changed, point at the stuff
> that made it ABI and revert the structure layout change..

How will it work for the new IBTA speed?

Thanks

>
> Jason
