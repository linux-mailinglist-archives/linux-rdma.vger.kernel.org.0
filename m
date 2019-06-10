Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAEF63B5D0
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2019 15:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390043AbfFJNMq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jun 2019 09:12:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389762AbfFJNMq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Jun 2019 09:12:46 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EFE820679;
        Mon, 10 Jun 2019 13:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560172365;
        bh=NdwOInWatgcJZuyjHQlFg9AujwOVXsRbRzzzCFPErhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R9LNgZZ36GrBbaet58folJRyVUsgNHCCxMrtpHa192t6ihYY+ccpMoSzRSAH8hVUC
         GWs2fl9Hn8jqch/EAj0h0ZMSTgsfJkaGqgnThRVgBmPrN7l2nWs2S6BiOeQFnSK6zD
         lYZU2NVlwtqMFPKFQU5/YcismtySHXIBFNXYV0kQ=
Date:   Mon, 10 Jun 2019 16:12:42 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH for-next] RDMA/ipoib: Remove check for ETH_SS_TEST
Message-ID: <20190610131242.GX6369@mtr-leonro.mtl.com>
References: <20190530131817.6147-1-kamalheib1@gmail.com>
 <20190607120952.GJ5261@mtr-leonro.mtl.com>
 <338cf9cde79ee9d734d8d854a342731e0da7e962.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <338cf9cde79ee9d734d8d854a342731e0da7e962.camel@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 10, 2019 at 01:59:31PM +0300, Kamal Heib wrote:
> On Fri, 2019-06-07 at 15:09 +0300, Leon Romanovsky wrote:
> > On Thu, May 30, 2019 at 04:18:17PM +0300, Kamal Heib wrote:
> > > Self-test isn't supported by the ipoib driver, so remove the check
> > > for
> > > ETH_SS_TEST.
> > >
> > > Fixes: e3614bc9dc44 ("IB/ipoib: Add readout of statistics using
> > > ethtool")
> > > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > > ---
> > >  drivers/infiniband/ulp/ipoib/ipoib_ethtool.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
> > > b/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
> > > index 83429925dfc6..b0bd0ff0b45c 100644
> > > --- a/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
> > > +++ b/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c
> > > @@ -138,7 +138,6 @@ static void ipoib_get_strings(struct net_device
> > > __always_unused *dev,
> > >  			p += ETH_GSTRING_LEN;
> > >  		}
> > >  		break;
> > > -	case ETH_SS_TEST:
> >
> > The commit message and code doesn't match each other.
> > Removing this specific case will leave exactly the same behaviour as
> > before, so why should we change it?
> >
>
> The idea is very simple, no point of checking ETH_SS_TEST if the ipoib
> doesn't support it.

Please write in commit message, that "default" option means "unsupported" and
there is no need in explicit declaration of unsupported ETH_SS_TEST.

Thanks
