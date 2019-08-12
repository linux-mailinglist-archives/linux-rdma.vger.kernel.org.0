Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A29B989FC1
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2019 15:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbfHLNc4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Aug 2019 09:32:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728826AbfHLNcz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Aug 2019 09:32:55 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE444206C2;
        Mon, 12 Aug 2019 13:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565616774;
        bh=POD3ptsADRQbSPUAAdShRLWE6WFbHmXdxzxQu7o7hkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eoFq1pTaGs2TdBqc388ZIp+2REiSujjJ8j8xYZ0cpP/99Gn63VXLnJF/u0eRgjo5q
         pfdFpBWZUgZcmCKF9WtdL9s0cKlcFMcgx7o8DNr+EGcfuSWeVBk1/UDCcgIDO5kpyg
         lSE2Q8yA36h/qz5sBUQSZueOpYVja0FqOdRqxBqc=
Date:   Mon, 12 Aug 2019 16:32:48 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: Re: [PATCH rdma-next 2/6] RDMA/umem: Add ODP type indicator within
 ib_umem_odp
Message-ID: <20190812133248.GB29138@mtr-leonro.mtl.com>
References: <20190807103403.8102-1-leon@kernel.org>
 <20190807103403.8102-3-leon@kernel.org>
 <20190807114406.GC1571@mellanox.com>
 <20190807121335.GC32366@mtr-leonro.mtl.com>
 <20190807123510.GF1557@ziepe.ca>
 <20190807131239.GF32366@mtr-leonro.mtl.com>
 <20190812105324.GA29138@mtr-leonro.mtl.com>
 <20190812121124.GA24457@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812121124.GA24457@ziepe.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 12, 2019 at 09:11:24AM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 12, 2019 at 01:53:24PM +0300, Leon Romanovsky wrote:
> > On Wed, Aug 07, 2019 at 04:12:39PM +0300, Leon Romanovsky wrote:
> > > On Wed, Aug 07, 2019 at 09:35:10AM -0300, Jason Gunthorpe wrote:
> > > > On Wed, Aug 07, 2019 at 03:13:35PM +0300, Leon Romanovsky wrote:
> > > > > On Wed, Aug 07, 2019 at 11:44:16AM +0000, Jason Gunthorpe wrote:
> > > > > > On Wed, Aug 07, 2019 at 01:33:59PM +0300, Leon Romanovsky wrote:
> > > > > > > From: Erez Alfasi <ereza@mellanox.com>
> > > > > > >
> > > > > > > ODP type can be divided into 2 subclasses:
> > > > > > > Explicit and Implicit ODP.
> > > > > > >
> > > > > > > Adding a type enums and an odp type flag within
> > > > > > > ib_umem_odp will give us an indication whether a
> > > > > > > given MR is ODP implicit/explicit registered.
> > > > > > >
> > > > > > > Signed-off-by: Erez Alfasi <ereza@mellanox.com>
> > > > > > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > > > > > >  drivers/infiniband/core/umem.c    |  1 +
> > > > > > >  include/rdma/ib_umem_odp.h        | 14 ++++++++++++++
> > > > > > >  include/uapi/rdma/ib_user_verbs.h |  5 +++++
> > > > > > >  3 files changed, 20 insertions(+)
> > > > > >
> > > > > > No for this patch, I've got a series cleaning up this
> > > > > > implicit/explicit nonsense, and the result is much cleaner than this.
> > > > >
> > > > > It doesn't really clean anything, just stores implicit/explicit information.
> > > > >
> > > > > >
> > > > > > This series will have to wait.
> > > > >
> > > > > The information exposed in this series is already available in uverbs,
> > > > > so whatever cleanup will come, we still need to expose ODP MR type.
> > > > >
> > > > > This patch is tiny part of whole series, why should we block whole
> > > > > series and iproute2?
> > > >
> > > > This whole approach is really ugly, I even object to the very idea of
> > > > patch #1
> > >
> > > How did patch #1 relate? It simply removed same code from drivers and
> > > put it in one place.
> > >
> > > >
> > > > The umem is an internal detail and should not be exposed out of the
> > > > driver for nldev to use.
> > >
> > > We are exporting ODP MR property, users are not aware of umem thing
> > > underneath at all.
> >
> > Jason ???
> >
> > I don't want to send iproute2 and make noise if the kernel part is
> > put on hold.
>
> Like I said, this is layered wrong and does not support the direction
> I want to go in with the ODP code, needs respin.

Base on what should I respin? We are in -rc4.

Thanks

>
> Jason
