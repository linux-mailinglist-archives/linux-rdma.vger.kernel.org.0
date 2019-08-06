Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D16E482D89
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2019 10:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbfHFIJI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Aug 2019 04:09:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728918AbfHFIJI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Aug 2019 04:09:08 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A3F920651;
        Tue,  6 Aug 2019 08:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565078947;
        bh=JsMnJ0hB4gmyp5WzQRIAOmAOnqrA70wZBNxoZD5AzQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yZO8W4gpPJ+zIPWsgGIg7SkhD4bJn6s69REUdRK9xQfzF0bo035Y8+GTX6DeHhujn
         l8jFXxs1LseXBCrpDM6Yb2iGY//zKE7pzm2/xMakpkhbzrfyYrojBOBsPNSVeN8Q38
         XQ5AMOzq6AoGzhqh8EiT4eA3DrueYPlZh3StKHtU=
Date:   Tue, 6 Aug 2019 11:09:02 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Potnuri Bharat Teja <bharat@chelsio.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>
Subject: Re: [PATCH rdma-core 2/2] cxgb4: remove unused c4iw_match_device
Message-ID: <20190806080902.GS4832@mtr-leonro.mtl.com>
References: <20190725174928.26863-1-bharat@chelsio.com>
 <20190725181424.GB7467@ziepe.ca>
 <20190728083749.GH4674@mtr-leonro.mtl.com>
 <20190729074612.GA30030@chelsio.com>
 <20190805110652.GB23319@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805110652.GB23319@chelsio.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 05, 2019 at 04:36:53PM +0530, Potnuri Bharat Teja wrote:
> On Monday, July 07/29/19, 2019 at 13:16:20 +0530, Potnuri Bharat Teja wrote:
> > On Sunday, July 07/28/19, 2019 at 14:07:49 +0530, Leon Romanovsky wrote:
> > > On Thu, Jul 25, 2019 at 03:14:24PM -0300, Jason Gunthorpe wrote:
> > > > On Thu, Jul 25, 2019 at 11:19:28PM +0530, Potnuri Bharat Teja wrote:
> > > > > match_device handler is no longer needed after latest device binding changes.
> > > > >
> > > > > Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> > > > > ---
> > > > >  providers/cxgb4/dev.c | 41 -----------------------------------------
> > > > >  1 file changed, 41 deletions(-)
> > > >
> > > > Do you know if we can also drop the same code in cxgb3?
> > >
> > > Can we simply remove cxgb3?
> > >
> >
> > I am in talks with the people here. I'll confirm it soon.
>
> Hi Jason/Doug/Leon,
> Chelsio is fine with removing cxgb3.

Thanks a lot.

> Thanks,
> Bharat.
