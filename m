Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADA974A7B0
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 18:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbfFRQxm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jun 2019 12:53:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729541AbfFRQxm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jun 2019 12:53:42 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 790AA206E0;
        Tue, 18 Jun 2019 16:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560876822;
        bh=IzC1R0C/uHUMoriLwu1XY7YY9/mH5bktMnbNOktWruM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rtQaWWNQrpSlQz0nonKsViMGw1GATdtmjnlNJHUaPdIWdZmpAHkgT8L5YEUscaXXG
         pCohcyNcVQ++7QToYqzVn1EVf4OmofXunZnrcX8u5eC++N3Rnb6mKnbsezwbCXhBY5
         k2RiMexxY96pvgd2Klys5ybzcw6/NENogPp3D32A=
Date:   Tue, 18 Jun 2019 19:53:38 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 2/3] RDMA: Add NLDEV_GET_CHARDEV to allow char dev
 discovery and autoload
Message-ID: <20190618165338.GO4690@mtr-leonro.mtl.com>
References: <20190614003819.19974-1-jgg@ziepe.ca>
 <20190614003819.19974-3-jgg@ziepe.ca>
 <20190618121709.GK4690@mtr-leonro.mtl.com>
 <20190618131019.GE6961@ziepe.ca>
 <97a95f7e5447b0ddf4dee15c536d72bd9fb65780.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97a95f7e5447b0ddf4dee15c536d72bd9fb65780.camel@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 18, 2019 at 11:55:08AM -0400, Doug Ledford wrote:
> On Tue, 2019-06-18 at 10:10 -0300, Jason Gunthorpe wrote:
> > On Tue, Jun 18, 2019 at 03:17:09PM +0300, Leon Romanovsky wrote:
> > > >  /**
> > > >   * ib_set_client_data - Set IB client context
> > > >   * @device:Device to set context for
> > > > diff --git a/drivers/infiniband/core/nldev.c
> > > > b/drivers/infiniband/core/nldev.c
> > > > index 69188cbbd99bd5..55eccea628e99f 100644
> > > > +++ b/drivers/infiniband/core/nldev.c
> > > > @@ -120,6 +120,9 @@ static const struct nla_policy
> > > > nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
> > > >  	[RDMA_NLDEV_ATTR_DEV_PROTOCOL]		= { .type =
> > > > NLA_NUL_STRING,
> > > >  				    .len = RDMA_NLDEV_ATTR_ENTRY_STRLEN
> > > > },
> > > >  	[RDMA_NLDEV_NET_NS_FD]			= { .type =
> > > > NLA_U32 },
> > > > +	[RDMA_NLDEV_ATTR_CHARDEV_TYPE]		= { .type =
> > > > NLA_NUL_STRING,
> > > > +				    .len = 128 },
> > > > +	[RDMA_NLDEV_ATTR_PORT_INDEX]		= { .type = NLA_U32 },
> > >
> > > It is wrong, we already have RDMA_NLDEV_ATTR_PORT_INDEX declared in
> > > nla_policy.
> > > But we don't have other RDMA_NLDEV_ATTR_CHARDEV_* declarations
> > > here.
> >
> > Doug can you fix it?
>
> I haven't pushed my wip to for-next yet, so yeah, I can fix it.  We
> just need to decide on what the full fix is ;-)
>
> Drop the duplicate ATTR_PORT_INDEX, but what about a final decision on
> including the outputs for possible future type checking?  You and Leon
> seem to be going back and forth, and I don't have strong feelings
> either way on this one.  It's just a definition statement, not like
> it's a dead subroutine.

I have a very strong opinion about it.

Thanks

>
> --
> Doug Ledford <dledford@redhat.com>
>     GPG KeyID: B826A3330E572FDD
>     Key fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57
> 2FDD


