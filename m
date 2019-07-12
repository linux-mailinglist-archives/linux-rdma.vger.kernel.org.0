Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 853EF672CA
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 17:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfGLPxH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Jul 2019 11:53:07 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:38771 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfGLPxH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Jul 2019 11:53:07 -0400
Received: from localhost (mehrangarh.blr.asicdesigners.com [10.193.185.169])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x6CFr0lU029840;
        Fri, 12 Jul 2019 08:53:01 -0700
Date:   Fri, 12 Jul 2019 21:22:59 +0530
From:   Potnuri Bharat Teja <bharat@chelsio.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "BMT@zurich.ibm.com" <BMT@zurich.ibm.com>,
        "monis@mellanox.com" <monis@mellanox.com>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>
Subject: Re: User SIW fails matching device
Message-ID: <20190712155258.GA1827@chelsio.com>
References: <20190712142718.GA26697@chelsio.com>
 <20190712143546.GD27512@ziepe.ca>
 <20190712152418.GA16331@chelsio.com>
 <20190712153032.GH27512@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712153032.GH27512@ziepe.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Friday, July 07/12/19, 2019 at 21:00:32 +0530, Jason Gunthorpe wrote:
> On Fri, Jul 12, 2019 at 08:54:20PM +0530, Potnuri Bharat Teja wrote:
> > On Friday, July 07/12/19, 2019 at 20:05:46 +0530, Jason Gunthorpe wrote:
> > > On Fri, Jul 12, 2019 at 07:57:19PM +0530, Potnuri Bharat Teja wrote:
> > > > Hi all,
> > > > I observe the following behavior on one of my machines configured for siw.
> > > > 
> > > > Issue:
> > > > SIW device gets wrong device ops (HW/real rdma driver device ops) instead of
> > > > siw device ops due to improper device matching.
> > > > 
> > > > Root-cause:
> > > > In libibverbs, during user cma initialisation, for each entry from the driver 
> > > > list, sysfs device is checked for matching name or device.
> > > > If the siw/rxe driver is at the head of the list, then sysfs device matches 
> > > > properly with the corresponding siw driver and gets the corresponding siw/rxe 
> > > > device ops. Now, If the siw/rxe driver is after the real HW driver cxgb4/mlx5 
> > > > respectively in the driver list, then siw sysfs device matches pci device and 
> > > > wrongly gets the device ops of HW driver (cxgb4/mlx5).
> > > > 
> > > > Below debug prints from verbs_register_driver() and driver_list entries, where 
> > > > siw is after cxgb4. I see verbs alloc context landing in cxgb4_alloc_context 
> > > > instead of siw_alloc_context, thus breaking user siw.
> > > > 
> > > > <debug> verbs_register_driver_22: 184: driver 0x176e370
> > > > <debug> verbs_register_driver_22: 185: name ipathverbs
> > > > <debug> verbs_register_driver_22: 184: driver 0x176f6a0
> > > > <debug> verbs_register_driver_22: 185: name cxgb4
> > > > <debug> verbs_register_driver_22: 184: driver 0x176fd50
> > > > <debug> verbs_register_driver_22: 185: name cxgb3
> > > > <debug> verbs_register_driver_22: 184: driver 0x1777020
> > > > <debug> verbs_register_driver_22: 185: name rxe
> > > > <debug> verbs_register_driver_22: 184: driver 0x1770a30
> > > > <debug> verbs_register_driver_22: 185: name siw
> > > > <debug> verbs_register_driver_22: 184: driver 0x1771120
> > > > <debug> verbs_register_driver_22: 185: name mlx4
> > > > <debug> verbs_register_driver_22: 184: driver 0x1771990
> > > > <debug> verbs_register_driver_22: 185: name mlx5
> > > > <debug> verbs_register_driver_22: 184: driver 0x1771ff0
> > > > <debug> verbs_register_driver_22: 185: name efa
> > > > 
> > > > <debug> try_drivers: 372: driver 0x176e370, sysfs_dev 0x1776b20, name: ipathverbs
> > > > <debug> try_drivers: 372: driver 0x176f6a0, sysfs_dev 0x1776b20, name: cxgb4
> > > > <debug> try_drivers: 372: driver 0x176fd50, sysfs_dev 0x1776b20, name: cxgb3
> > > > <debug> try_drivers: 372: driver 0x1777020, sysfs_dev 0x1776b20, name: rxe
> > > > <debug> try_drivers: 372: driver 0x1770a30, sysfs_dev 0x1776b20, name: siw
> > > > <debug> try_drivers: 372: driver 0x1771120, sysfs_dev 0x1776b20, name: mlx4
> > > > <debug> try_drivers: 372: driver 0x1771990, sysfs_dev 0x1776b20, name: mlx5
> > > > <debug> try_drivers: 372: driver 0x1771ff0, sysfs_dev 0x1776b20, name: efa
> > > > 
> > > > Proposed fix:
> > > > I have the below fix that works. It adds siw/rxe driver to the HEAD of the 
> > > > driver list and the rest to the tail. I am not sure if this fix is the ideal 
> > > > one, so I am attaching it to this mail.
> > > 
> > > Update your rdma-core to latest and this will be fixed fully by using
> > > netlink to match the siw device..
> > > 
> > I pulled the latest rdma-core, still see the issue.
> > 
> > commit 7ef6077ec3201f661458297fea776746ba752843 (HEAD, upstream/master)
> > Merge: 837954ff677c 95934b61a74e
> > Author: Jason Gunthorpe <jgg@mellanox.com>
> > Date:   Thu Jul 11 16:18:06 2019 -0300
> > 
> >     Merge pull request #539 from jgunthorpe/netlink
> > 
> >         Use netlink to learn about ibdevs and their related chardevs
> > 
> > 
> > Is there any corresponding kernel change or package dependency? I am currently 
> > on Doug's wip/dl-for-next branch.
> 
> That should be good enough for the kernel.. Hmm.. The siw stuff didn't
> get updated, you need this rdma-core patch too. Please confirm
> 
> diff --git a/providers/siw/siw.c b/providers/siw/siw.c
> index 23e4dd976caf84..41f33fa16123e9 100644
> --- a/providers/siw/siw.c
> +++ b/providers/siw/siw.c
> @@ -907,7 +907,7 @@ static void siw_device_free(struct verbs_device *vdev)
>  }
>  
>  static const struct verbs_match_ent rnic_table[] = {
> -	VERBS_NAME_MATCH("siw", NULL),
> +	VERBS_DRIVER_ID(RDMA_DRIVER_SIW),
>  	{},
>  };
>
It works with above change. Thanks!
