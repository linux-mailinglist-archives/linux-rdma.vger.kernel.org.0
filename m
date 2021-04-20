Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8293651C2
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Apr 2021 07:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhDTFQO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Apr 2021 01:16:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229588AbhDTFQO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Apr 2021 01:16:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99B5B613AE;
        Tue, 20 Apr 2021 05:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618895743;
        bh=dhlrIivZxquO2S27t8UwtNK40E82mVYLo2S9s3w+VQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MjFDFFy7pA2EJpP9o3/PWq6rJ+fd3Lq8uk8C3NuqPgQKf2Jz+gME+UYSMSMqPVXnw
         2t8U5clp3BiQnimEVW2aSV8uchZD4x8RhKHM/ZlWHQA0KuuThFt2nS0sQ8y4zUScqG
         A0FTHMRzLAbR+8wlHtqpoPN0SneIZto3383DoKMo5NDBSvK2LB8YTMY5by+L6g8aSt
         /1cRMK/XMARXXy9+DcwiQ1PRHnHYaihH5xS/o/4yJfOTh1DWfbMk+3IT4oo337rfRA
         MaELR+9OqluL0DR3Rc1W8zYl0wtuPTNM/qXfDwJbOnbdCI34gCne2M7vRbt8GnZJBQ
         UZOV4MQ6IXEdQ==
Date:   Tue, 20 Apr 2021 08:15:39 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Wan, Kaike" <kaike.wan@intel.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next 06/10] rdma: Set physical MTU for query_port
 function
Message-ID: <YH5je/mxDIUuIIs9@unreal>
References: <1617026056-50483-1-git-send-email-dennis.dalessandro@cornelisnetworks.com>
 <1617026056-50483-7-git-send-email-dennis.dalessandro@cornelisnetworks.com>
 <YGWHga9RMan2uioD@unreal>
 <44ca5d0e-7aa4-5a9a-8f3b-d30454a58fb4@cornelisnetworks.com>
 <YG7ztT81z8BZDkUj@unreal>
 <8d987675-09f3-542c-a921-072f19243e08@cornelisnetworks.com>
 <DM6PR11MB33061E82DC3C60F2779C87DFF4499@DM6PR11MB3306.namprd11.prod.outlook.com>
 <YH13p0zRz+M9Tmzz@unreal>
 <DM6PR11MB33060BC01328357BF1D9E562F4499@DM6PR11MB3306.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB33060BC01328357BF1D9E562F4499@DM6PR11MB3306.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 19, 2021 at 01:09:13PM +0000, Wan, Kaike wrote:
> 
> 
> > -----Original Message-----
> > From: Leon Romanovsky <leon@kernel.org>
> > Sent: Monday, April 19, 2021 8:29 AM
> > To: Wan, Kaike <kaike.wan@intel.com>
> > Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>;
> > dledford@redhat.com; jgg@ziepe.ca; linux-rdma@vger.kernel.org
> > Subject: Re: [PATCH for-next 06/10] rdma: Set physical MTU for query_port
> > function
> > 
> > On Mon, Apr 19, 2021 at 12:20:33PM +0000, Wan, Kaike wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> > > > Sent: Thursday, April 08, 2021 8:31 AM
> > > > To: Leon Romanovsky <leon@kernel.org>
> > > > Cc: dledford@redhat.com; jgg@ziepe.ca; linux-rdma@vger.kernel.org;
> > > > Wan, Kaike <kaike.wan@intel.com>
> > > > Subject: Re: [PATCH for-next 06/10] rdma: Set physical MTU for
> > > > query_port function
> > > >
> > > > On 4/8/2021 8:14 AM, Leon Romanovsky wrote:
> > > > > On Thu, Apr 08, 2021 at 08:06:46AM -0400, Dennis Dalessandro wrote:
> > > > >> On 4/1/2021 4:42 AM, Leon Romanovsky wrote:
> > > > >>> On Mon, Mar 29, 2021 at 09:54:12AM -0400,
> > > > dennis.dalessandro@cornelisnetworks.com wrote:
> > > > >>>> From: Kaike Wan <kaike.wan@intel.com>
> > > > >>>>
> > > > >>>> This is a follow on patch to add a phys_mtu field to the
> > > > >>>> ib_port_attr structure to indicate the maximum physical MTU the
> > > > >>>> underlying device supports.
> > > > >>>>
> > > > >>>> Extends the following:
> > > > >>>> commit 6d72344cf6c4 ("IB/ipoib: Increase ipoib Datagram mode
> > > > >>>> MTU's upper limit")
> > > > >>>>
> > > > >>>> Reviewed-by: Mike Marciniszyn
> > > > >>>> <mike.marciniszyn@cornelisnetworks.com>
> > > > >>>> Signed-off-by: Kaike Wan <kaike.wan@intel.com>
> > > > >>>> Signed-off-by: Dennis Dalessandro
> > > > >>>> <dennis.dalessandro@cornelisnetworks.com>
> > > > >>>> ---
> > > > >>>>    drivers/infiniband/hw/bnxt_re/ib_verbs.c        |  1 +
> > > > >>>>    drivers/infiniband/hw/cxgb4/provider.c          |  1 +
> > > > >>>>    drivers/infiniband/hw/efa/efa_verbs.c           |  1 +
> > > > >>>>    drivers/infiniband/hw/hns/hns_roce_main.c       |  1 +
> > > > >>>>    drivers/infiniband/hw/i40iw/i40iw_verbs.c       |  1 +
> > > > >>>>    drivers/infiniband/hw/mlx4/main.c               |  1 +
> > > > >>>>    drivers/infiniband/hw/mlx5/mad.c                |  1 +
> > > > >>>>    drivers/infiniband/hw/mlx5/main.c               |  2 ++
> > > > >>>>    drivers/infiniband/hw/mthca/mthca_provider.c    |  1 +
> > > > >>>>    drivers/infiniband/hw/ocrdma/ocrdma_verbs.c     |  1 +
> > > > >>>>    drivers/infiniband/hw/qib/qib_verbs.c           |  1 +
> > > > >>>>    drivers/infiniband/hw/usnic/usnic_ib_verbs.c    |  1 +
> > > > >>>>    drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c |  1 +
> > > > >>>>    drivers/infiniband/sw/siw/siw_verbs.c           |  1 +
> > > > >>>>    drivers/infiniband/ulp/ipoib/ipoib_main.c       |  2 +-
> > > > >>>>    include/rdma/ib_verbs.h                         | 17 -----------------
> > > > >>>>    16 files changed, 16 insertions(+), 18 deletions(-)
> > > > >>>
> > > > >>> But why? What will it give us that almost all drivers have same
> > > > >>> props->phys_mtu = ib_mtu_enum_to_int(props->max_mtu); line?
> > > > >>>
> > > > >>
> > > > >> Almost is not all. Alternative idea to convey this? Seemed like a
> > > > >> sensible thing to at least have support for but open to other
> > approaches.
> > > > >
> > > > > What about leave it as is?
> > > > >
> > > > > I'm struggling to get the rationale behind this patch., the code
> > > > > already works and set the phys_mtu correctly, isn't it?
> > > >
> > > > I see what you are saying now. Kaike, correct me if I'm wrong, but
> > > > the intent of this patch is just to make everything behave the same
> > > > in the sense that a device could have a different physical MTU. The
> > > > field got added to the ib_port_attr previously so this is giving it an initial
> > value vs leaving it unset.
> > > [Wan, Kaike]  Correct.
> > 
> > No one is using this "phys_mtu" field, except one place in ipoib.
> [Wan, Kaike]  Since phys_mtu was introduced into ib_port_attr and every query_port call will  return it in ib_port_attr. Rather than leaving it set to 0, setting it correctly in each hw driver seem more reasonable to me. 

Yes, if the drivers set this field differently, it is not the case here.
All of them (except one) set same value.

If you really want to have phys_mtu be correct all the time, change
query_port to set it.

Something like that:
query_port():
  if (!phys_mtu)
     phys_mtu = ib_mtu_enum_to_int(..)

Thanks

> 
> > 
> > Thanks
> > 
> > >
> > > >
> > > > -Denny
> > >
