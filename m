Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D78D7E122
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 19:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbfHARdd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 13:33:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfHARdd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Aug 2019 13:33:33 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ABB5205F4;
        Thu,  1 Aug 2019 17:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564680811;
        bh=bhu7d4P3PIHP8jAlid+ws+YuOmJFSxDJY4Z/2zbAGm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lMQjfjIR3tuy8kBq4UQR5BUJec1sGF89kJLOYBwELwNE5ClMDy9sIoTmawa2kzQks
         VHGv/z4it5WiIYNB0obk9T4vlRDmdLgS/qpJWi7Q+YmKXZaoa0t2R17B0xkVEljNRR
         VbmjERM/4o/hWjFjWmQ5g3OM+PcU1i5QOegEUBtU=
Date:   Thu, 1 Aug 2019 20:33:20 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Release locks during notifier
 unregister
Message-ID: <20190801173320.GZ4832@mtr-leonro.mtl.com>
References: <20190731180124.GE4832@mtr-leonro.mtl.com>
 <20190731195523.GK22677@mellanox.com>
 <20190801082749.GH4832@mtr-leonro.mtl.com>
 <20190801120007.GB23885@mellanox.com>
 <20190801120821.GK4832@mtr-leonro.mtl.com>
 <060b3e8fbe48312e9af33b88ba7ba62a6b64b493.camel@redhat.com>
 <20190801155912.GS4832@mtr-leonro.mtl.com>
 <a0dc81b63fdef1b7e877d5172be13792dda763d2.camel@redhat.com>
 <20190801162356.GV4832@mtr-leonro.mtl.com>
 <5ffad7827bc72b43948fa7c4707348999434009a.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ffad7827bc72b43948fa7c4707348999434009a.camel@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 01, 2019 at 12:42:43PM -0400, Doug Ledford wrote:
> On Thu, 2019-08-01 at 19:23 +0300, Leon Romanovsky wrote:
> > On Thu, Aug 01, 2019 at 12:11:20PM -0400, Doug Ledford wrote:
> > > On Thu, 2019-08-01 at 18:59 +0300, Leon Romanovsky wrote:
> > > > > There's no need for a lockdep.  The removal of the notifier
> > > > > callback
> > > > > entry is re-entrant safe.  The core removal routines have their
> > > > > own
> > > > > spinlock they use to protect the actual notifier list.  If you
> > > > > call
> > > > > it
> > > > > more than once, the second and subsequent calls merely scan the
> > > > > list,
> > > > > find no matching entry, and return ENOENT.  The only reason this
> > > > > might
> > > > > need a lock and a lockdep entry is if you are protecting against
> > > > > a
> > > > > race
> > > > > with the *add* notifier code in the mlx5 driver specifically
> > > > > (the
> > > > > core
> > > > > add code won't have an issue, but since you only have a single
> > > > > place
> > > > > to
> > > > > store the notifier callback pointer, if it would be possible for
> > > > > you
> > > > > to
> > > > > add two callbacks and write over the first callback pointer with
> > > > > the
> > > > > second without removing the first, then you would leak a
> > > > > callback
> > > > > notifier in the core notifier list).
> > > >
> > > > atomic_notifier_chain_unregister() unconditionally calls to
> > > > syncronize_rcu() and I'm not so sure that it is best thing to do
> > > > for every port unbind.
> > > >
> > > > Actually, I'm completely lost here, we are all agree that the
> > > > patch
> > > > fixes issue correctly, and it returns the code to be exactly as
> > > > it was before commit df097a278c75 ("IB/mlx5: Use the new mlx5 core
> > > > notifier
> > > > API"). Can we simply merge it and fix the kernel panic?
> > >
> > > As long as you are OK with me adding a comment to the patch so
> > > people
> > > coming back later won't scratch their head about how can it possible
> > > be
> > > right to do that sequence without a lock held, I'm fine merging the
> > > fix.
> > >
> > > Something like:
> > >
> > > /*
> > >  * The check/unregister/set-NULL sequence below does not need to be
> > >  * locked for correctness as it's only an optimization, and can't
> > >  * be under a lock or will throw a scheduling while atomic error.
> > >  */
> >
> > I think that the best place will be in commit message for this
> > explanation,
> > but I'm fine with the comment inside code as well.
> >
> > Thanks a lot, I appreciate it.
>
> Patch (unmodified) is applied to for-rc, thanks.

Thanks Doug, I'll prepare patch with lockdep for Jason and
will submit it to -next later on after passing verification.

Thanks

>
> --
> Doug Ledford <dledford@redhat.com>
>     GPG KeyID: B826A3330E572FDD
>     Fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD


