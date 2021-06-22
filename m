Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773BD3AFCF4
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 08:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhFVGSn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 02:18:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhFVGSn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 02:18:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 292B060FDC;
        Tue, 22 Jun 2021 06:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624342587;
        bh=z15Kwl8oV1sBDp03uYbCoqoT/uw5Ys7M76aR3X1yf+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eswEkGgwPDBT5jTXngsC9JVGDoKB4HSkeJ+4BeAaUX01vdQp3Q0/bNQh5fScUJbmX
         sPdEfQkIB/kWLWUp9KPV82I016Z+V2ddeUMo73mAzu5L9NRlhRwwPjRVDlVIt0lsok
         C5oWvSqU59H9zIst/XukCJ6NXvomqHRXiYc01v0AM92A89OzPb8hQSpaqHNo5UZRLF
         0eG1q4B+3hwaV3aYoPe+PFfhPpOQ4FXBS5D4AXk2OFKVtUIDSGkVRHGw+R5EUEvzeG
         kbwTgwXmZ+DxeitY8OJhEOFT03V2S3U5KDLF5KC3gdijiuuNhRYrmG7qwIJo7gLs2s
         FazhQnvpFXqjg==
Date:   Tue, 22 Jun 2021 09:16:23 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Hans Ry <hans.westgaard.ry@oracle.com>
Subject: Re: [PATCH for-next v2] RDMA/cma: Replace RMW with atomic bit-ops
Message-ID: <YNGAN4eGYXkrFMCg@unreal>
References: <1623934765-31435-1-git-send-email-haakon.bugge@oracle.com>
 <YNA7ZnKIKC217pCw@unreal>
 <C8E39F1F-14D5-4DBE-ABE0-2EFC20353D83@oracle.com>
 <YNBhuZNjGvUsJHUy@unreal>
 <FB3E1A32-A1BA-48B8-A20D-99662CDAC921@oracle.com>
 <20210621143758.GP1002214@nvidia.com>
 <36906AC6-B2DB-40D4-972C-8058FF0B462C@oracle.com>
 <20210621151240.GQ1002214@nvidia.com>
 <AFF46FA1-4679-4625-89CD-B608FCBE14C1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AFF46FA1-4679-4625-89CD-B608FCBE14C1@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 21, 2021 at 03:55:40PM +0000, Haakon Bugge wrote:
> 
> 
> > On 21 Jun 2021, at 17:12, Jason Gunthorpe <jgg@nvidia.com> wrote:
> > 
> > On Mon, Jun 21, 2021 at 02:58:46PM +0000, Haakon Bugge wrote:
> >> 
> >> 
> >>> On 21 Jun 2021, at 16:37, Jason Gunthorpe <jgg@nvidia.com> wrote:
> >>> 
> >>> On Mon, Jun 21, 2021 at 10:46:26AM +0000, Haakon Bugge wrote:
> >>> 
> >>>>>> You're running an old checkpatch. Since commit bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column warning"), the default line-length is 100. As Linus states in:
> >>>>>> 
> >>>>>> https://lkml.org/lkml/2009/12/17/229
> >>>>>> 
> >>>>>> "... But 80 characters is causing too many idiotic changes."
> >>>>> 
> >>>>> I'm aware of that thread, but RDMA subsystem continues to use 80 symbols limit.
> >>>> 
> >>>> I wasn't aware. Where is that documented? Further, it must be a
> >>>> limit that is not enforced. Of the last 100 commits in
> >>>> drivers/infiniband, there are 630 lines longer than 80.
> >>> 
> >>> Linus said stick to 80 but use your best judgement if going past
> >>> 
> >>> It was not a blanket allowance to needless long lines all over the
> >>> place.
> >> 
> >> That is not how I interpreted him:
> > 
> > There was a much newer thread on this from Linus, 2009 is really old
> 
> Yes, from last year, lkml.org/lkml/2020/5/29/1038
> 
> <quote>
> Excessive line breaks are BAD. They cause real and every-day problems.
> 
> They cause problems for things like "grep" both in the patterns and in
> the output, since grep (and a lot of other very basic unix utilities)
> is fundamentally line-based.
> 
> So the fact is, many of us have long long since skipped the whole
> "80-column terminal" model, for the same reason that we have many more
> lines than 25 lines visible at a time.
> 
> And honestly, I don't want to see patches that make the kernel reading
> experience worse for me and likely for the vast majority of people,
> based on the argument that some odd people have small terminal
> windows.
> </quote>
> 
> Occasionally enforcing 80-chars line lengths in the RDMA subsystem seems like a strange policy to me :-)

I prefer to be strict here. We are submitting patches to different
subsystems with different reviewers.

"This adds a few pointles > 80 char lines."
https://lore.kernel.org/linux-rdma/20200907072921.GC19875@lst.de/

> 
> 
> Thxs, Håkon
> 
> 
> > 
> > Jason
> 
