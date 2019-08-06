Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B185F8305F
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2019 13:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730676AbfHFLNW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Aug 2019 07:13:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730381AbfHFLNV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Aug 2019 07:13:21 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4273720B1F;
        Tue,  6 Aug 2019 11:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565090000;
        bh=zZ9eLyccO8b6tvvvVNFaANxGTIj0zUiZNKzPkaNmXLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QiPFRAdBBfXHCExovcETbtF/WdksDpn2nvLPACfK4IVxTSrn9vpUZbya0Aakf1Lzd
         iVNUnXOlJS3h0Z5MReYL+iNr+2fVRFNMchb9cb1Iy86TQVGNVgDQ9pqN5iqNq1hLX7
         doQ6Od3JenkZlcNFojdsLzJ8+trHrdZjaA8sXOBw=
Date:   Tue, 6 Aug 2019 14:13:17 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Potnuri Bharat Teja <bharat@chelsio.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>
Subject: Re: [PATCH rdma-core 2/2] cxgb4: remove unused c4iw_match_device
Message-ID: <20190806111317.GV4832@mtr-leonro.mtl.com>
References: <20190725174928.26863-1-bharat@chelsio.com>
 <20190725181424.GB7467@ziepe.ca>
 <20190728083749.GH4674@mtr-leonro.mtl.com>
 <20190729074612.GA30030@chelsio.com>
 <20190805110652.GB23319@chelsio.com>
 <20190806080902.GS4832@mtr-leonro.mtl.com>
 <20190806094849.GT4832@mtr-leonro.mtl.com>
 <20190806110812.GA6109@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806110812.GA6109@chelsio.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 06, 2019 at 04:38:13PM +0530, Potnuri Bharat Teja wrote:
> On Tuesday, August 08/06/19, 2019 at 15:18:49 +0530, Leon Romanovsky wrote:
> > On Tue, Aug 06, 2019 at 11:09:02AM +0300, Leon Romanovsky wrote:
> > > On Mon, Aug 05, 2019 at 04:36:53PM +0530, Potnuri Bharat Teja wrote:
> > > > On Monday, July 07/29/19, 2019 at 13:16:20 +0530, Potnuri Bharat Teja wrote:
> > > > > On Sunday, July 07/28/19, 2019 at 14:07:49 +0530, Leon Romanovsky wrote:
> > > > > > On Thu, Jul 25, 2019 at 03:14:24PM -0300, Jason Gunthorpe wrote:
> > > > > > > On Thu, Jul 25, 2019 at 11:19:28PM +0530, Potnuri Bharat Teja wrote:
> > > > > > > > match_device handler is no longer needed after latest device binding changes.
> > > > > > > >
> > > > > > > > Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> > > > > > > > ---
> > > > > > > >  providers/cxgb4/dev.c | 41 -----------------------------------------
> > > > > > > >  1 file changed, 41 deletions(-)
> > > > > > >
> > > > > > > Do you know if we can also drop the same code in cxgb3?
> > > > > >
> > > > > > Can we simply remove cxgb3?
> > > > > >
> > > > >
> > > > > I am in talks with the people here. I'll confirm it soon.
> > > >
> > > > Hi Jason/Doug/Leon,
> > > > Chelsio is fine with removing cxgb3.
> > >
> > > Thanks a lot.
> >
> > Which parts of cxgb3 can we remove? RDMA, scsi, net or everything?
>
> I can only say RDMA. For net and scsi parts of cxgb3, the corresponding
> maintainers might request for their removal.
> Should I send a patch removing RDMA cxgb3?

It will be the best variant.

Thanks

>
> Thanks.
