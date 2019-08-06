Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC7BA8356B
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2019 17:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732247AbfHFPga (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Aug 2019 11:36:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbfHFPga (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Aug 2019 11:36:30 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AEBA2064A;
        Tue,  6 Aug 2019 15:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565105788;
        bh=pJqh9PLGPYVggr9GNVtfjZ9JSXeDW72huetFAbFR4EE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hqAfyygDb3/+JyDkBFsX453zdpYUY2irSZ3uHxj1C3WNnHkna72sgGi7OOnFyc53W
         ieP7ZW0HDTMKLOqlKX59ZmSO9ev/w+1ydNKStgIMjbaQlvjfCU5WbuDzgr0l7957kN
         EfqIunX9Ehh+GJh7ovTEgVe70btJMmWY+mad4eDU=
Date:   Tue, 6 Aug 2019 18:36:13 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>
Subject: Re: [PATCH rdma-core 2/2] cxgb4: remove unused c4iw_match_device
Message-ID: <20190806153613.GX4832@mtr-leonro.mtl.com>
References: <20190725174928.26863-1-bharat@chelsio.com>
 <20190725181424.GB7467@ziepe.ca>
 <20190728083749.GH4674@mtr-leonro.mtl.com>
 <20190729074612.GA30030@chelsio.com>
 <20190805110652.GB23319@chelsio.com>
 <20190806080902.GS4832@mtr-leonro.mtl.com>
 <20190806094849.GT4832@mtr-leonro.mtl.com>
 <20190806110812.GA6109@chelsio.com>
 <20190806111317.GV4832@mtr-leonro.mtl.com>
 <e94a97412c260616c8bd27d9dd361e496f15c67a.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e94a97412c260616c8bd27d9dd361e496f15c67a.camel@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 06, 2019 at 11:16:13AM -0400, Doug Ledford wrote:
> On Tue, 2019-08-06 at 14:13 +0300, Leon Romanovsky wrote:
> > On Tue, Aug 06, 2019 at 04:38:13PM +0530, Potnuri Bharat Teja wrote:
> > > On Tuesday, August 08/06/19, 2019 at 15:18:49 +0530, Leon Romanovsky
> > > wrote:
> > > > On Tue, Aug 06, 2019 at 11:09:02AM +0300, Leon Romanovsky wrote:
> > > > > On Mon, Aug 05, 2019 at 04:36:53PM +0530, Potnuri Bharat Teja
> > > > > wrote:
> > > > > > On Monday, July 07/29/19, 2019 at 13:16:20 +0530, Potnuri
> > > > > > Bharat Teja wrote:
> > > > > > > On Sunday, July 07/28/19, 2019 at 14:07:49 +0530, Leon
> > > > > > > Romanovsky wrote:
> > > > > > > > On Thu, Jul 25, 2019 at 03:14:24PM -0300, Jason Gunthorpe
> > > > > > > > wrote:
> > > > > > > > > On Thu, Jul 25, 2019 at 11:19:28PM +0530, Potnuri Bharat
> > > > > > > > > Teja wrote:
> > > > > > > > > > match_device handler is no longer needed after latest
> > > > > > > > > > device binding changes.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com
> > > > > > > > > > >
> > > > > > > > > > ---
> > > > > > > > > >  providers/cxgb4/dev.c | 41 --------------------------
> > > > > > > > > > ---------------
> > > > > > > > > >  1 file changed, 41 deletions(-)
> > > > > > > > >
> > > > > > > > > Do you know if we can also drop the same code in cxgb3?
> > > > > > > >
> > > > > > > > Can we simply remove cxgb3?
> > > > > > > >
> > > > > > >
> > > > > > > I am in talks with the people here. I'll confirm it soon.
> > > > > >
> > > > > > Hi Jason/Doug/Leon,
> > > > > > Chelsio is fine with removing cxgb3.
> > > > >
> > > > > Thanks a lot.
> > > >
> > > > Which parts of cxgb3 can we remove? RDMA, scsi, net or everything?
> > >
> > > I can only say RDMA. For net and scsi parts of cxgb3, the
> > > corresponding
> > > maintainers might request for their removal.
> > > Should I send a patch removing RDMA cxgb3?
> >
> > It will be the best variant.
> >
> > Thanks
> >
> > > Thanks.
>
> I'm not entirely sure that I want it removed yet.  The cxgb3 isn't the
> most stellar device, but it will do 40GBit/s.  That's still a very
> respectable speed (unlike say mthca that was mostly 10GBit/s with only a
> short run of 20GBit/s devices before it switched over to mlx4).  So a
> cxgb3 based home system is still something very usable.  Are we sure we
> want to remove this?

I'm sceptical that such home users (who want RDMA part of cxgb3) exist.

My stake here is to remove as much as possible not-maintained driver
to simplify overall maintenance effort.

Thanks

>
> --
> Doug Ledford <dledford@redhat.com>
>     GPG KeyID: B826A3330E572FDD
>     Fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD


