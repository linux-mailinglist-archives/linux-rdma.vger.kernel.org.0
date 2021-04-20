Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D606A3651BF
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Apr 2021 07:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbhDTFMX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Apr 2021 01:12:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229617AbhDTFMX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Apr 2021 01:12:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87B7F60FEE;
        Tue, 20 Apr 2021 05:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618895512;
        bh=hxBxREUC/wMk0mkHPk23ZtOzrsYTwXOQLc4xfzwRDJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tFFqzf3Ybq4i9gNI9+9d6qdB2+VkeAw7kvArqL07Wr/GSps+vz3jWS3Of9KBml+Y2
         p5vVdNqhu+j0hRDfsosZdoYHK7KR2WOd3ZTQE9oKpGH+goskAsGeeXKLKqaekMBq7t
         8LWz7FZabzq/c0f2DtD9JAbNCubaBv+SD90G/LZoDOBsVGQAZqJ8eKHn/+weVeHT5d
         lINA1dLCtKjnHAsvGQ43igv2vLgl9rKVKYDc6slAVaf9ENNazzOlTAojWfQcz1IWVp
         FKCOo2jwvUFUHJldGUko2TycuRgNOyotnVsjYSO1x9zirMnNmDoKoIyZE0RMHBfWy3
         gR8Y5hRUTA9aw==
Date:   Tue, 20 Apr 2021 08:11:48 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     "Wan, Kaike" <kaike.wan@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next 06/10] rdma: Set physical MTU for query_port
 function
Message-ID: <YH5ilM02U4cuYK3x@unreal>
References: <1617026056-50483-1-git-send-email-dennis.dalessandro@cornelisnetworks.com>
 <1617026056-50483-7-git-send-email-dennis.dalessandro@cornelisnetworks.com>
 <YGWHga9RMan2uioD@unreal>
 <44ca5d0e-7aa4-5a9a-8f3b-d30454a58fb4@cornelisnetworks.com>
 <YG7ztT81z8BZDkUj@unreal>
 <8d987675-09f3-542c-a921-072f19243e08@cornelisnetworks.com>
 <DM6PR11MB33061E82DC3C60F2779C87DFF4499@DM6PR11MB3306.namprd11.prod.outlook.com>
 <YH13p0zRz+M9Tmzz@unreal>
 <49397542-7015-5e8f-b473-49a124dd4341@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49397542-7015-5e8f-b473-49a124dd4341@cornelisnetworks.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 19, 2021 at 09:08:55AM -0400, Dennis Dalessandro wrote:
> On 4/19/2021 8:29 AM, Leon Romanovsky wrote:
> > On Mon, Apr 19, 2021 at 12:20:33PM +0000, Wan, Kaike wrote:
> > > 
> > > 
> > > > -----Original Message-----
> > > > From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> > > > Sent: Thursday, April 08, 2021 8:31 AM
> > > > To: Leon Romanovsky <leon@kernel.org>
> > > > Cc: dledford@redhat.com; jgg@ziepe.ca; linux-rdma@vger.kernel.org; Wan,
> > > > Kaike <kaike.wan@intel.com>
> > > > Subject: Re: [PATCH for-next 06/10] rdma: Set physical MTU for query_port
> > > > function
> > > > 
> > > > On 4/8/2021 8:14 AM, Leon Romanovsky wrote:
> > > > > On Thu, Apr 08, 2021 at 08:06:46AM -0400, Dennis Dalessandro wrote:
> > > > > > On 4/1/2021 4:42 AM, Leon Romanovsky wrote:
> > > > > > > On Mon, Mar 29, 2021 at 09:54:12AM -0400,
> > > > dennis.dalessandro@cornelisnetworks.com wrote:
> > > > > > > > From: Kaike Wan <kaike.wan@intel.com>
> > > > > > > > 
> > > > > > > > This is a follow on patch to add a phys_mtu field to the
> > > > > > > > ib_port_attr structure to indicate the maximum physical MTU the
> > > > > > > > underlying device supports.
> > > > > > > > 
> > > > > > > > Extends the following:
> > > > > > > > commit 6d72344cf6c4 ("IB/ipoib: Increase ipoib Datagram mode MTU's
> > > > > > > > upper limit")
> > > > > > > > 
> > > > > > > > Reviewed-by: Mike Marciniszyn
> > > > > > > > <mike.marciniszyn@cornelisnetworks.com>
> > > > > > > > Signed-off-by: Kaike Wan <kaike.wan@intel.com>
> > > > > > > > Signed-off-by: Dennis Dalessandro
> > > > > > > > <dennis.dalessandro@cornelisnetworks.com>
> > > > > > > > ---
> > > > > > > >     drivers/infiniband/hw/bnxt_re/ib_verbs.c        |  1 +
> > > > > > > >     drivers/infiniband/hw/cxgb4/provider.c          |  1 +
> > > > > > > >     drivers/infiniband/hw/efa/efa_verbs.c           |  1 +
> > > > > > > >     drivers/infiniband/hw/hns/hns_roce_main.c       |  1 +
> > > > > > > >     drivers/infiniband/hw/i40iw/i40iw_verbs.c       |  1 +
> > > > > > > >     drivers/infiniband/hw/mlx4/main.c               |  1 +
> > > > > > > >     drivers/infiniband/hw/mlx5/mad.c                |  1 +
> > > > > > > >     drivers/infiniband/hw/mlx5/main.c               |  2 ++
> > > > > > > >     drivers/infiniband/hw/mthca/mthca_provider.c    |  1 +
> > > > > > > >     drivers/infiniband/hw/ocrdma/ocrdma_verbs.c     |  1 +
> > > > > > > >     drivers/infiniband/hw/qib/qib_verbs.c           |  1 +
> > > > > > > >     drivers/infiniband/hw/usnic/usnic_ib_verbs.c    |  1 +
> > > > > > > >     drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c |  1 +
> > > > > > > >     drivers/infiniband/sw/siw/siw_verbs.c           |  1 +
> > > > > > > >     drivers/infiniband/ulp/ipoib/ipoib_main.c       |  2 +-
> > > > > > > >     include/rdma/ib_verbs.h                         | 17 -----------------
> > > > > > > >     16 files changed, 16 insertions(+), 18 deletions(-)
> > > > > > > 
> > > > > > > But why? What will it give us that almost all drivers have same
> > > > > > > props->phys_mtu = ib_mtu_enum_to_int(props->max_mtu); line?
> > > > > > > 
> > > > > > 
> > > > > > Almost is not all. Alternative idea to convey this? Seemed like a
> > > > > > sensible thing to at least have support for but open to other approaches.
> > > > > 
> > > > > What about leave it as is?
> > > > > 
> > > > > I'm struggling to get the rationale behind this patch., the code
> > > > > already works and set the phys_mtu correctly, isn't it?
> > > > 
> > > > I see what you are saying now. Kaike, correct me if I'm wrong, but the intent
> > > > of this patch is just to make everything behave the same in the sense that a
> > > > device could have a different physical MTU. The field got added to the
> > > > ib_port_attr previously so this is giving it an initial value vs leaving it unset.
> > > [Wan, Kaike]  Correct.
> > 
> > No one is using this "phys_mtu" field, except one place in ipoib.
> 
> Today. I think it would be better to formalize the idea though and have a
> cleaner interface. Does this cause some problem?

Not directly, but yes.

Before your change, drivers don't need to care about this field because
it is not in use at all, after your change all drivers need to carry same
line. This is prone to errors.

Thanks

> 
> -Denny
