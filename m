Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7D623CE1
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 18:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388592AbfETQIB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 12:08:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388121AbfETQIB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 May 2019 12:08:01 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52C33216B7;
        Mon, 20 May 2019 16:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558368481;
        bh=k4ZshHSb6fKK1903tm0sKfmy6u2wYoInHE2v/iMiOWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MwFNvurnWfFl+0zbLTEfOghlM2QiW+e3vppW4WJ1EI/u7c7/C0Scl1vJ5YcQerqW4
         sjuqMyvW6MJ0dt90of4vGIE61Je/DPspbSrNaceLgtuC3tRQDOEcu6fy2vqdc6jAhz
         dG4iC7PxRs0yZP/lV9dkYIA7IlKzOI9GFspUUYLY=
Date:   Mon, 20 May 2019 19:07:56 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Cc:     dledford@redhat.com, jgg@mellanox.com, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Parav Pandit <parav@mellanox.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: Re: [PATCH for-next v2 3/4] RDMA/nldev: ib_pd can be pointed by
 multiple ib_ucontext
Message-ID: <20190520160756.GR4573@mtr-leonro.mtl.com>
References: <20190520075333.6002-1-shamir.rabinovitch@oracle.com>
 <20190520075333.6002-4-shamir.rabinovitch@oracle.com>
 <20190520091840.GB4573@mtr-leonro.mtl.com>
 <20190520115009.GA7740@srabinov-laptop>
 <20190520120529.GH4573@mtr-leonro.mtl.com>
 <20190520153738.GA25279@srabinov-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520153738.GA25279@srabinov-laptop>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 20, 2019 at 06:37:39PM +0300, Shamir Rabinovitch wrote:
> On Mon, May 20, 2019 at 03:05:29PM +0300, Leon Romanovsky wrote:
> > On Mon, May 20, 2019 at 02:50:10PM +0300, Shamir Rabinovitch wrote:
> > > On Mon, May 20, 2019 at 12:18:40PM +0300, Leon Romanovsky wrote:
> > > > On Mon, May 20, 2019 at 10:53:20AM +0300, Shamir Rabinovitch wrote:
> >
> > >
> > > > > +	if (!rdma_is_kernel_res(res)) {
> > > > > +		pd_context(pd, &pd_context_ids);
> > > > > +		list_for_each_entry(ctx_id, &pd_context_ids, list) {
> > > > > +			if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_CTXN,
> > > > > +				ctx_id->id))
> > > >
> > > > Did it work? You are overwriting RDMA_NLDEV_ATTR_RES_CTXN entry in the
> > > > loop. You need to add RDMA_NLDEV_ATTR_RES_CTX and
> > > > RDMA_NLDEV_ATTR_RES_CTX_ENTRY to include/uapi/rdma_netlink.h and
> > > > open nested table here (inside of PD) with list of contexts.
> > >
> > > I tested with only 1 context per pd (what we have today). Thanks for
> > > comment. I'll try to follow what you wrote here.
> > >
>
> Leon, what is your expectation here? I see 2 options:
>
> 1. Code will build same NL message in case of single context id and
> nested table in case of multiple context ids
>
> 2. Code always build nested table with context id(s)
>
> If taking option (1) we can postpone the iproute2 matching commits to
> some extent but if we take option (2) I guess I have to add iproute2
> commits as well - right?

Yes, I imagined option 1 back then. The nested table inside of PD will
clearly mark that it is "shared PD" and rdmatool already handles
situation where no CTX is provided.

So you will have three options:
1. CTX is provided, no nested - user space PD - rdmatool supports it.
2. CTX is not provided, no nested - kernel space PD - rdmatool supports it by simply not printing cntx number.
3. CTX is not provided, nested table exists - shared PD - legacy rdmatool will think that we are in #2 and new
rdmatool will print list. This nested table should exist once PD in shared mode. I don't know if shared PD can
be with one context ID, but anyway it needs to be in nested table.

>
> Also, what's the best way to add the changes in both given what you
> choose above?

Patch plan?

>
> Thanks
