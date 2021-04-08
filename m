Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24CD2358305
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 14:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbhDHMPB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 08:15:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231132AbhDHMPA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Apr 2021 08:15:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 86895610F9;
        Thu,  8 Apr 2021 12:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617884089;
        bh=9Xey6Tnu5GNmbzYOAUD308zjGzjr0UYTCxR5mxWyc6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i7TTCluuasqA6fisdGdHbsUmsB6mIG6v1HL5TJcFDWJRPcSW0KSWQXSZUiz26oahw
         JTP9VrTKQFT6aQXGRGM4XJjbItyvcH03ZxPfmLZcDx4mt2uXZYNUlAAJx6VJLqjtwm
         R2aswANrwqnT+dr05CBoMzV7nLd8DzG5m6XVSOK6Cnnv7H4U2taRQTmXrOvqtE+7W5
         yW3MESf7Sy/31ZhPfVXFOumSxo7uSZ+MOulAtDwtgKMrbJAreZEQyX87/6j69OPj1b
         VomkciZ7wb2qWXrnl7+4QFIQcIBC/bvzlC2om2/X2XKSMkykGCcAL/Cs7Ihh8e14GE
         s15S/HoS6JQeQ==
Date:   Thu, 8 Apr 2021 15:14:45 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        Kaike Wan <kaike.wan@intel.com>
Subject: Re: [PATCH for-next 06/10] rdma: Set physical MTU for query_port
 function
Message-ID: <YG7ztT81z8BZDkUj@unreal>
References: <1617026056-50483-1-git-send-email-dennis.dalessandro@cornelisnetworks.com>
 <1617026056-50483-7-git-send-email-dennis.dalessandro@cornelisnetworks.com>
 <YGWHga9RMan2uioD@unreal>
 <44ca5d0e-7aa4-5a9a-8f3b-d30454a58fb4@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44ca5d0e-7aa4-5a9a-8f3b-d30454a58fb4@cornelisnetworks.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 08, 2021 at 08:06:46AM -0400, Dennis Dalessandro wrote:
> On 4/1/2021 4:42 AM, Leon Romanovsky wrote:
> > On Mon, Mar 29, 2021 at 09:54:12AM -0400, dennis.dalessandro@cornelisnetworks.com wrote:
> > > From: Kaike Wan <kaike.wan@intel.com>
> > > 
> > > This is a follow on patch to add a phys_mtu field to the
> > > ib_port_attr structure to indicate the maximum physical MTU
> > > the underlying device supports.
> > > 
> > > Extends the following:
> > > commit 6d72344cf6c4 ("IB/ipoib: Increase ipoib Datagram mode MTU's upper limit")
> > > 
> > > Reviewed-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> > > Signed-off-by: Kaike Wan <kaike.wan@intel.com>
> > > Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> > > ---
> > >   drivers/infiniband/hw/bnxt_re/ib_verbs.c        |  1 +
> > >   drivers/infiniband/hw/cxgb4/provider.c          |  1 +
> > >   drivers/infiniband/hw/efa/efa_verbs.c           |  1 +
> > >   drivers/infiniband/hw/hns/hns_roce_main.c       |  1 +
> > >   drivers/infiniband/hw/i40iw/i40iw_verbs.c       |  1 +
> > >   drivers/infiniband/hw/mlx4/main.c               |  1 +
> > >   drivers/infiniband/hw/mlx5/mad.c                |  1 +
> > >   drivers/infiniband/hw/mlx5/main.c               |  2 ++
> > >   drivers/infiniband/hw/mthca/mthca_provider.c    |  1 +
> > >   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c     |  1 +
> > >   drivers/infiniband/hw/qib/qib_verbs.c           |  1 +
> > >   drivers/infiniband/hw/usnic/usnic_ib_verbs.c    |  1 +
> > >   drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c |  1 +
> > >   drivers/infiniband/sw/siw/siw_verbs.c           |  1 +
> > >   drivers/infiniband/ulp/ipoib/ipoib_main.c       |  2 +-
> > >   include/rdma/ib_verbs.h                         | 17 -----------------
> > >   16 files changed, 16 insertions(+), 18 deletions(-)
> > 
> > But why? What will it give us that almost all drivers have same
> > props->phys_mtu = ib_mtu_enum_to_int(props->max_mtu); line?
> > 
> 
> Almost is not all. Alternative idea to convey this? Seemed like a sensible
> thing to at least have support for but open to other approaches.

What about leave it as is? 

I'm struggling to get the rationale behind this patch., the code already works
and set the phys_mtu correctly, isn't it?

Thanks

> 
> -Denny
