Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2004F2332A
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 14:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730585AbfETMFd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 08:05:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730557AbfETMFd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 May 2019 08:05:33 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B98A20815;
        Mon, 20 May 2019 12:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558353932;
        bh=g4wJ90SXpEGGkk853xPjajr+ELE8NqSlvuPV6eCcwsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JURoNozjLRz9pIfv3AxHsruTgx9bJlO5HtPGX/b35WHJXe5jFfSbnLCUpD3Y6/5Iy
         ffPoy/B+MmQ1i7ggy11Nhmic7/sgS70r2bPhr3LKpX+8mA7yZTJJ+xb/apBUMc4ftR
         ysvkIMCGN8zuewaY7YEh7EK4wRakDYRfPdYmUVUI=
Date:   Mon, 20 May 2019 15:05:29 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Cc:     dledford@redhat.com, jgg@mellanox.com, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: Re: [PATCH for-next v2 3/4] RDMA/nldev: ib_pd can be pointed by
 multiple ib_ucontext
Message-ID: <20190520120529.GH4573@mtr-leonro.mtl.com>
References: <20190520075333.6002-1-shamir.rabinovitch@oracle.com>
 <20190520075333.6002-4-shamir.rabinovitch@oracle.com>
 <20190520091840.GB4573@mtr-leonro.mtl.com>
 <20190520115009.GA7740@srabinov-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520115009.GA7740@srabinov-laptop>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 20, 2019 at 02:50:10PM +0300, Shamir Rabinovitch wrote:
> On Mon, May 20, 2019 at 12:18:40PM +0300, Leon Romanovsky wrote:
> > On Mon, May 20, 2019 at 10:53:20AM +0300, Shamir Rabinovitch wrote:
> > > In shared object model ib_pd can belong to 1 or more ib_ucontext.
> > > Fix the nldev code so it could report multiple context ids.
> > >
> > > Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> > > ---
> > >  drivers/infiniband/core/nldev.c | 93 +++++++++++++++++++++++++++++++--
> > >  1 file changed, 88 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> > > index cbd712f5f8b2..f4cc92b897ff 100644
> > > --- a/drivers/infiniband/core/nldev.c
> > > +++ b/drivers/infiniband/core/nldev.c
> > > @@ -41,6 +41,9 @@
> > >  #include "core_priv.h"
> > >  #include "cma_priv.h"
> > >  #include "restrack.h"
> > > +#include "uverbs.h"
> > > +
> > > +static bool is_visible_in_pid_ns(struct rdma_restrack_entry *res);
> >
> > Mark needed it too.
> > https://patchwork.kernel.org/patch/10921419/
> >
>
> I see. So follow Mark patch the above hunk is not needed.
> Should I apply Mark patch before this series?

No, you should continue with your series, just be aware that once Mark's
patches will be merged your series will need some small update.

>
> > > +	if (!rdma_is_kernel_res(res)) {
> > > +		pd_context(pd, &pd_context_ids);
> > > +		list_for_each_entry(ctx_id, &pd_context_ids, list) {
> > > +			if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_CTXN,
> > > +				ctx_id->id))
> >
> > Did it work? You are overwriting RDMA_NLDEV_ATTR_RES_CTXN entry in the
> > loop. You need to add RDMA_NLDEV_ATTR_RES_CTX and
> > RDMA_NLDEV_ATTR_RES_CTX_ENTRY to include/uapi/rdma_netlink.h and
> > open nested table here (inside of PD) with list of contexts.
>
> I tested with only 1 context per pd (what we have today). Thanks for
> comment. I'll try to follow what you wrote here.
>
