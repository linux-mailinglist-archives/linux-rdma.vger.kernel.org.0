Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEA631642A3
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 11:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgBSKxZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 05:53:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:55374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbgBSKxZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Feb 2020 05:53:25 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52A2F2464E;
        Wed, 19 Feb 2020 10:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582109605;
        bh=3zUKsMm/5ta+w+TeCavTeiyhcfwN52m0ijdtxeJmuE8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y/86LSQgxz+hd1l7/Ttm7I+YXDsG/fqb3Mm7N7FlL2oCQVyBQv1N8VZz5OKpRQvV/
         rNpkAk/1KGA6ESGN5NYnkQW9xd0kG1Ghzdz9hBDH9wSaA/2zH8JoUGwqAx8q+IVlii
         O3aYFeB7euw0Rf72EzhuiX5aDtk2GjghqpanFitY=
Date:   Wed, 19 Feb 2020 12:53:20 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: Re: [PATCH for-next v2] RDMA/siw: Fix setting active_{speed, width}
 attributes
Message-ID: <20200219105320.GJ15239@unreal>
References: <20200218095911.26614-1-kamalheib1@gmail.com>
 <20200218165847.GA15239@unreal>
 <20200219084359.GA12296@kheib-workstation>
 <20200219093321.GI15239@unreal>
 <20200219102110.GA13582@kheib-workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219102110.GA13582@kheib-workstation>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 19, 2020 at 12:21:10PM +0200, Kamal Heib wrote:
> On Wed, Feb 19, 2020 at 11:33:21AM +0200, Leon Romanovsky wrote:
> > On Wed, Feb 19, 2020 at 10:43:59AM +0200, Kamal Heib wrote:
> > > On Tue, Feb 18, 2020 at 06:58:47PM +0200, Leon Romanovsky wrote:
> > > > On Tue, Feb 18, 2020 at 11:59:11AM +0200, Kamal Heib wrote:
> > > > > Make sure to set the active_{speed, width} attributes to avoid reporting
> > > > > the same values regardless of the underlying device.
> > > > >
> > > > > Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
> > > > > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > > > > ---
> > > > > V2: Change rc to rv.
> > > > > ---
> > > > >  drivers/infiniband/sw/siw/siw_verbs.c | 7 ++++---
> > > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
> > > > > index 73485d0da907..d5390d498c61 100644
> > > > > --- a/drivers/infiniband/sw/siw/siw_verbs.c
> > > > > +++ b/drivers/infiniband/sw/siw/siw_verbs.c
> > > > > @@ -165,11 +165,12 @@ int siw_query_port(struct ib_device *base_dev, u8 port,
> > > > >  		   struct ib_port_attr *attr)
> > > > >  {
> > > > >  	struct siw_device *sdev = to_siw_dev(base_dev);
> > > > > +	int rv;
> > > > >
> > > > >  	memset(attr, 0, sizeof(*attr));
> > > >
> > > > This line should go too. IB/core clears attr prior to call driver.
> > > >
> > > > Thanks
> > > >
> > >
> > > This can be done in a separate patch as this patch fixes a specific issue.
> >
> > Whatever works for you, if you don't value your own time, go for it,
> > do separate patch for every line you are changing. It just looks crazy
> > to see changes like this:
> >  * changed line
> >  * line to be changed, but not changed
> >  * another changed line
> >
> > Thanks
> >
>
> Leon, With all my respect, This isn't your decision what I do and when.

Please carefully reread my answer, I didn't say what and when you should
do, simply gave to you an explanation why request remove useless memeset
makes sense in the context of proposed patch.

Thanks
