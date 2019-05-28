Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8110F2C7A1
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 15:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfE1NRr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 May 2019 09:17:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:46074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726870AbfE1NRr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 May 2019 09:17:47 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C7882133F;
        Tue, 28 May 2019 13:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559049466;
        bh=efTy9wXhtz2oSMmnb1Ethn5TPa+TYNl0s51N7YfVNlk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=haAJ7Zmp244EeDLta4++0fqlOVnYEq6Si8qbImJD4FglpTtXjr1LMiCdtxgXxRYPH
         p2jOLNV+3ckSyyBzxa0FArxdk6nYfYO+l5xg7j5sQAACpgtEAISZpl4p1SWHZh84Jn
         wu52fnqvxKJ6ees2WGhZvIlt+o99Fmtr84k5+V8A=
Date:   Tue, 28 May 2019 16:17:43 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Cc:     dledford@redhat.com, jgg@mellanox.com, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: Re: [PATCH for-next v2 3/4] RDMA/nldev: ib_pd can be pointed by
 multiple ib_ucontext
Message-ID: <20190528131743.GM4633@mtr-leonro.mtl.com>
References: <20190520075333.6002-1-shamir.rabinovitch@oracle.com>
 <20190520075333.6002-4-shamir.rabinovitch@oracle.com>
 <20190520091840.GB4573@mtr-leonro.mtl.com>
 <20190522122531.GA6173@srabinov-laptop>
 <20190528123322.GA11474@srabinov-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528123322.GA11474@srabinov-laptop>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 28, 2019 at 03:33:26PM +0300, Shamir Rabinovitch wrote:
> On Wed, May 22, 2019 at 03:25:32PM +0300, Shamir Rabinovitch wrote:
> > On Mon, May 20, 2019 at 12:18:40PM +0300, Leon Romanovsky wrote:
> > > On Mon, May 20, 2019 at 10:53:20AM +0300, Shamir Rabinovitch wrote:
> > > > In shared object model ib_pd can belong to 1 or more ib_ucontext.
> > > > Fix the nldev code so it could report multiple context ids.
> > > >
> > > > Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> > > > ---
> >
> > [...]
> >
> > > > +	if (!rdma_is_kernel_res(res)) {
> > > > +		pd_context(pd, &pd_context_ids);
> > > > +		list_for_each_entry(ctx_id, &pd_context_ids, list) {
> > > > +			if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_CTXN,
> > > > +				ctx_id->id))
> > >
> > > Did it work? You are overwriting RDMA_NLDEV_ATTR_RES_CTXN entry in the
> > > loop. You need to add RDMA_NLDEV_ATTR_RES_CTX and
> > > RDMA_NLDEV_ATTR_RES_CTX_ENTRY to include/uapi/rdma_netlink.h and
> > > open nested table here (inside of PD) with list of contexts.
> > >
> > > > +				goto err;
> > > > +		}
> >
> > Hi Leon,
> >
> > Just to clarify the above nesting...
> >
> > Do you expect the below NL attribute nesting in case of shared pd dump?
> >
> > RDMA_NLDEV_ATTR_RES_CTX
> > 	RDMA_NLDEV_ATTR_RES_CTX_ENTRY
> > 		RDMA_NLDEV_ATTR_RES_CTXN #1
> > 		RDMA_NLDEV_ATTR_RES_CTXN #2
> > 		...
> > 		RDMA_NLDEV_ATTR_RES_CTXN #N
> >
> >
> > I tried this and rdmatool reported:
> >
> > [root@qemu-fc29 iproute2]# rdma/rdma res show pd dev mlx4_0
> > dev mlx4_0 pdn 0 local_dma_lkey 0x8000 users 4 comm [ib_core]
> > dev mlx4_0 pdn 1 local_dma_lkey 0x8000 users 4 comm [ib_core]
> > error: Operation not supported
> >
> > Is this the expected behaviour from unmodified latest rdmatool?
> >
> > Thanks
>
> Leon,
>
> I tried this nesting (which make more sense to me) and results are the
> same as above.
>
> RDMA_NLDEV_ATTR_RES_CTX
> 	RDMA_NLDEV_ATTR_RES_CTX_ENTRY
> 		RDMA_NLDEV_ATTR_RES_CTXN
> 	RDMA_NLDEV_ATTR_RES_CTX_ENTRY
> 		RDMA_NLDEV_ATTR_RES_CTXN
> ...
>
> Which is the nesting you expect ?

Sorry, I was OOO and slightly try to catch all emails.

This latest variant looks right to me.

>
> Is it OK that we get the rdma tool "error: Operation not supported" ?

Definitely not. I don't see the origin of that error, it didn't come from rdmatool.

Thanks

>
> Thanks
