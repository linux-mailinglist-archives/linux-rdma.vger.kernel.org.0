Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06421D1DBD
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 20:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387492AbgEMSny (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 14:43:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732817AbgEMSny (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 May 2020 14:43:54 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D068205CB;
        Wed, 13 May 2020 18:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589395434;
        bh=dnVyDkHOQiYhrjgAjq0NPR8MnfG+3kRGSUh+VJEBeqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UKcKVxLJHaulK8ujBDmz9edzR5O0OPbY75uZQOzhxGtrt3WHrSjZPqOGVJQ9/dUrL
         +kL5g5kUIGlkBTRAVfMX2kVOfNMPNNQDBGYhkU9PNXAmxLBf9NAF73EKZaJ+s1TMvH
         UkfDSXcM/J0yKQTcZi3zdS5pnpheMRhbm5fBnV5s=
Date:   Wed, 13 May 2020 21:43:49 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Israel Rukshin <israelr@mellanox.com>,
        linux-rdma@vger.kernel.org, dledford@redhat.com, maxg@mellanox.com,
        sergeygo@mellanox.com, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH] IB/iser: Remove support for FMR memory registration
Message-ID: <20200513184349.GA4814@unreal>
References: <1589299739-16570-1-git-send-email-israelr@mellanox.com>
 <20200512171633.GO4814@unreal>
 <5b8b0b51-83e3-06c2-9b99-dec0862c0e5b@acm.org>
 <20200512201303.GA19158@mellanox.com>
 <98a0d1aa-6364-a2f1-37f6-9c69e1efaa0b@acm.org>
 <20200512230625.GB19158@mellanox.com>
 <b9dab6bf-d1b8-40c0-63ba-09eb3f4882f5@grimberg.me>
 <20200513071855.GQ4814@unreal>
 <be388f26-9b86-b826-5d4b-8dec201ea5ef@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be388f26-9b86-b826-5d4b-8dec201ea5ef@intel.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 13, 2020 at 12:44:16PM -0400, Dennis Dalessandro wrote:
> On 5/13/2020 3:18 AM, Leon Romanovsky wrote:
> > On Tue, May 12, 2020 at 05:53:34PM -0700, Sagi Grimberg wrote:
> > >
> > > > > > > > > FMR is not supported on most recent RDMA devices (that use fast memory
> > > > > > > > > registration mechanism). Also, FMR was recently removed from NFS/RDMA
> > > > > > > > > ULP.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Israel Rukshin <israelr@mellanox.com>
> > > > > > > > > Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> > > > > > > > >    drivers/infiniband/ulp/iser/iscsi_iser.h     |  79 +----------
> > > > > > > > >    drivers/infiniband/ulp/iser/iser_initiator.c |  19 ++-
> > > > > > > > >    drivers/infiniband/ulp/iser/iser_memory.c    | 188 ++-------------------------
> > > > > > > > >    drivers/infiniband/ulp/iser/iser_verbs.c     | 126 +++---------------
> > > > > > > > >    4 files changed, 40 insertions(+), 372 deletions(-)
> > > > > > > >
> > > > > > > > Can we do an extra step and remove FMR from srp too?
> > > > > > >
> > > > > > > Which HCA's will be affected by removing FMR support? Or in other words,
> > > > > > > when did (Mellanox) HCA's start supporting fast memory registration? I'm
> > > > > > > asking this because there is a tradition in the Linux kernel not to
> > > > > > > remove support for old hardware unless it is pretty sure that nobody is
> > > > > > > using that hardware anymore.
> > > > > >
> > > > > > We haven't entirely been following that in RDMA.. More like when
> > > > > > people can't test any more it can go.
> > > > > >
> > > > > > For FMR the support was dropped in newer HW so AFAIK, nobody tests
> > > > > > this and it just stands in the way of making FRWR work properly.
> > > > > >
> > > > > > Do the ULPs stop working or do they just run slower with some regular
> > > > > > MR flow?
> > > > >
> > > > > I'm not sure. I do not have access to RDMA adapters that do not support
> > > > > FRWR.
> > > > >
> > > > > A possible test is to check on websites for used products whether old
> > > > > RDMA adapters are still available. Is the InfiniHost adapter one of the
> > > > > adapters that supports FMR? It seems like that adapter is still easy to
> > > > > find.
> > > >
> > > > I don't know - AFAIK nobody does any testing on those cards any
> > > > more, and doesn't test the ULPs either.
> > > >
> > > > I know Leon has pushed to remove the mthca driver in the past.  At one
> > > > point there was a suggestion that drivers that do not support FRWR
> > > > should be dropped, but I don't remember if mthca is the last one or
> > > > not.
> > > >
> > > > There has been a big push to purge useless old stuff, look at the
> > > > entire arch removals for instance. The large RDMA drivers fall under
> > > > the same logic, IMHO.
> > >
> > > I think we should remove this support, if there is a user of this
> > > somewhere he can safely use iscsi. Let alone that iser uses the fmr
> > > pools which leaves rkeys exposed for caching purposes. So I'd much
> > > rather remove it than trying to fix it.
> >
> > Agree, given the fact that no one is even going to try to fix.
> >
> > We don't see new contributors in this community who are not affiliated
> > with RDMA companies and they are not testing and have no plans to test FMR.
> >
> > I feel that we can't even say if FMR and old cards work :).
>
> qib still works.

mlx4 works too :), I had in mind more older cards than qib, which was
added to the kernel only ten years ago. For example mlx4 was added 13
years ago an mthca before git era (>15 years).

Thanks

>
> -Denny
>
