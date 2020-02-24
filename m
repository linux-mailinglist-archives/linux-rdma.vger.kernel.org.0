Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 294FC16A459
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2020 11:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbgBXKwL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Feb 2020 05:52:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:41140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbgBXKwK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Feb 2020 05:52:10 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72BB02080D;
        Mon, 24 Feb 2020 10:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582541530;
        bh=Rt7UHy3i9v5mvfkCcsGkAePPgjdS22gMDW83JXuT2Ww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DlTpgzyteWAEWEHUgBwD1LMxNDUh/Lcievi4WFnYE0JDiQOwi0GjNvQFTeVnaXSQh
         DrQkCQxtmiZ1cb44YKTS06EBZJGF0qDXNQgZ09OyIX1k4zB+FYmdYLCYYFkdBcJ9I6
         cTN0Iicw3dAm4jSfkegTq2uyLWxdkjXe4+oshQfI=
Date:   Mon, 24 Feb 2020 12:52:06 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Parav Pandit <parav@mellanox.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Weihang Li <liweihang@huawei.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: Is anyone working on implementing LAG in ib core?
Message-ID: <20200224105206.GA468372@unreal>
References: <280d87d0-fbc0-0566-794b-f66cb4fadb63@huawei.com>
 <20200222234026.GO31668@ziepe.ca>
 <98482e8a-f2eb-5406-b679-0ceb946ac618@mellanox.com>
 <20200223094928.GB422704@unreal>
 <5db0d4f8-1893-33c2-fb25-e6012e0fc6d6@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5db0d4f8-1893-33c2-fb25-e6012e0fc6d6@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 24, 2020 at 07:10:13AM +0000, Parav Pandit wrote:
> Hi Leon,
>
> On 2/23/2020 3:49 AM, Leon Romanovsky wrote:
> > On Sun, Feb 23, 2020 at 12:44:12AM +0000, Parav Pandit wrote:
> >> Hi Jason, Weihang,
> >>
> >> On 2/22/2020 5:40 PM, Jason Gunthorpe wrote:
> >>> On Sat, Feb 22, 2020 at 11:48:04AM +0800, Weihang Li wrote:
> >>>> Hi all,
> >>>>
> >>>> We plan to implement LAG in hns drivers recently, and as we know, there is
> >>>> already a mature and stable solution in the mlx5 driver. Considering that
> >>>> the net subsystem in kernel adopt the strategy that the framework implement
> >>>> bonding, we think it's reasonable to add LAG feature to the ib core based
> >>>> on mlx5's implementation. So that all drivers including hns and mlx5 can
> >>>> benefit from it.
> >>>>
> >>>> In previous discussions with Leon about achieving reporting of ib port link
> >>>> event in ib core, Leon mentioned that there might be someone trying to do
> >>>> this.
> >>>>
> >>>> So may I ask if there is anyone working on LAG in ib core or planning to
> >>>> implement it in near future? I will appreciate it if you can share your
> >>>> progress with me and maybe we can finish it together.
> >>>>
> >>>> If nobody is working on this, our team may take a try to implement LAG in
> >>>> the core. Any comments and suggestion are welcome.
> >>>
> >>> This is something that needs to be done, I understand several of the
> >>> other drivers are going to want to use LAG and we certainly can't have
> >>> everything copied into each driver.
> >>>
> >>> Jason
> >>>
> >> I am not sure mlx5 is right model for new rdma bond device support which
> >> I tried to highlight in Q&A-1 below.
> >>
> >> I have below not-so-refined proposal for rdma bond device.
> >>
> >> - Create a rdma bond device named rbond0 using two slave rdma devices
> >> mlx5_0 mlx5_1 which is connected to netdevice bond1 and underlying dma
> >> device of mlx5_0 rdma device.
> >>
> >> $ rdma dev add type bond name rbond0 netdev bond1 slave mlx5_0 slave
> >> mlx5_1 dmadevice mlx5_0
> >>
> >> $ rdma dev show
> >> 0: mlx5_0: node_type ca fw 12.25.1020 node_guid 248a:0703:0055:4660
> >> sys_image_guid 248a:0703:0055:4660
> >> 1: mlx5_1: node_type ca fw 12.25.1020 node_guid 248a:0703:0055:4661
> >> sys_image_guid 248a:0703:0055:4660
> >> 2: rbond0: node_type ca node_guid 248a:0703:0055:4660 sys_image_guid
> >> 248a:0703:0055:4660
> >>
> >> - This should be done via rdma bond driver in
> >> drivers/infiniband/ulp/rdma_bond
> >
> > Extra question, why do we need RDMA bond ULP which combines ib devices
> > and not create netdev bond device and create one ib device on top of that?
> >
>
> I read your question few times, but I likely don't understand your question.
>
> Are you asking why bonding should be implemented as dedicated
> ulp/driver, and not as an extension by the vendor driver?

No, I meant something different. You are proposing to combine IB
devices, while keeping netdev devices separated. I'm asking if it is
possible to combine netdev devices with already existing bond driver
and simply create new ib device with bond netdev as an underlying
provider.

I'm not suggesting to implement anything in vendor drivers.

>
> In an alternative approach a given hw driver implements a newlink()
> instead of dedicated bond driver.
> However this will duplicate the code in few drivers. Hence, to do in
> common driver and implement only necessary hooks in hw driver.

I'm not sure about it.

>
> > Thanks
> >
>
