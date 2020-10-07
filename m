Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7EB285A43
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Oct 2020 10:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgJGIPp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Oct 2020 04:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgJGIPo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Oct 2020 04:15:44 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1612BC061755
        for <linux-rdma@vger.kernel.org>; Wed,  7 Oct 2020 01:15:43 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id d28so1468641ote.1
        for <linux-rdma@vger.kernel.org>; Wed, 07 Oct 2020 01:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pzPWUp2kZLxPkBgPS5CFIuIDZhRYDXybDPGOe+gkyjk=;
        b=Sk5u8ZJACW67ugyj/T0pqGfKZwFhZ6QzSMPb8GHncNSoFSXz5ceYEjUiMY2g1VWlur
         akMu3IMZ04idCFQMJIH1qTYbGm9PtJrZDJY7cTSUMyHD2kqt0HmBgZwTu+2zWdQFbvWW
         DnFXUIWNgYS5d6BaKP/BYCJ/koUmUcIdl08hI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pzPWUp2kZLxPkBgPS5CFIuIDZhRYDXybDPGOe+gkyjk=;
        b=uBgeLc3OqWRxXOdWkAYCrv3+i+XWYXTLHoKNXpNkLb9owA0jHWtM/q2Zxgq3nYK4H6
         NLQu0bgjNgUyhtxawbzNEUAWXcXssUNUAhek+d1eEV5L1kC8MrmxVFAhTMYfUCsznJ+9
         bcZCKXjOAmT6S11YuTrdMM8igb7vXtUs/+227N0OZjQsi6OVatNpQrsUyG3hn9gVGHwJ
         IoLc5CDmU0x08QRJWP9vo8b7ccceL/cslRYzD5ZQ6fbjSQ7DFOIcmisOdhY6BhsAgjZf
         SjIR/Tk7iAYN/Q10/ZctCnBTvfwKguIrnsAlLYPqpRCc0cGcCvLjUNNxsWytqd6cvs+D
         H+cw==
X-Gm-Message-State: AOAM533Ja4JyctULPF4nm2wP53TxibrdouA0juS5mq9YibX1MkgiLi9B
        4lxa3d3flYrUTjiRx/3kJFDlWWucjoRfD7TTlN4iFA==
X-Google-Smtp-Source: ABdhPJy+YbYFDPa0+x1zr9PWGe0p0SDWhe7AMwlm685FYFp9ntA32GbX8DL6dp85EDg+Q3d+DRjums1alXx8QoNeihU=
X-Received: by 2002:a05:6830:1e56:: with SMTP id e22mr1110002otj.303.1602058542439;
 Wed, 07 Oct 2020 01:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <20201004154340.1080481-1-leon@kernel.org> <20201005235650.GA89159@nvidia.com>
 <20201006104122.GA438822@phenom.ffwll.local> <20201006114627.GE5177@ziepe.ca>
In-Reply-To: <20201006114627.GE5177@ziepe.ca>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 7 Oct 2020 10:15:31 +0200
Message-ID: <CAKMK7uG5UOS5360_HjJyroLE8b+6wrhT291PaqjFbii+BT7+Hg@mail.gmail.com>
Subject: Re: [PATCH rdma-next v5 0/4] Dynamicaly allocate SG table from the pages
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Maor Gottlieb <maorg@nvidia.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 7, 2020 at 9:22 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Tue, Oct 06, 2020 at 12:41:22PM +0200, Daniel Vetter wrote:
> > On Mon, Oct 05, 2020 at 08:56:50PM -0300, Jason Gunthorpe wrote:
> > > On Sun, Oct 04, 2020 at 06:43:36PM +0300, Leon Romanovsky wrote:
> > > > This series extends __sg_alloc_table_from_pages to allow chaining of
> > > > new pages to already initialized SG table.
> > > >
> > > > This allows for the drivers to utilize the optimization of merging contiguous
> > > > pages without a need to pre allocate all the pages and hold them in
> > > > a very large temporary buffer prior to the call to SG table initialization.
> > > >
> > > > The second patch changes the Infiniband driver to use the new API. It
> > > > removes duplicate functionality from the code and benefits the
> > > > optimization of allocating dynamic SG table from pages.
> > > >
> > > > In huge pages system of 2MB page size, without this change, the SG table
> > > > would contain x512 SG entries.
> > > > E.g. for 100GB memory registration:
> > > >
> > > >              Number of entries      Size
> > > >     Before        26214400          600.0MB
> > > >     After            51200            1.2MB
> > > >
> > > > Thanks
> > > >
> > > > Maor Gottlieb (2):
> > > >   lib/scatterlist: Add support in dynamic allocation of SG table from
> > > >     pages
> > > >   RDMA/umem: Move to allocate SG table from pages
> > > >
> > > > Tvrtko Ursulin (2):
> > > >   tools/testing/scatterlist: Rejuvenate bit-rotten test
> > > >   tools/testing/scatterlist: Show errors in human readable form
> > >
> > > This looks OK, I'm going to send it into linux-next on the hmm tree
> > > for awhile to see if anything gets broken. If there is more
> > > remarks/tags/etc please continue
> >
> > An idea that just crossed my mind: A pin_user_pages_sgt might be useful
> > for both rdma and drm, since this would avoid the possible huge interim
> > struct pages array for thp pages. Or anything else that could be coalesced
> > down into a single sg entry.
> >
> > Not sure it's worth it, but would at least give a slightly neater
> > interface I think.
>
> We've talked about it. Christoph wants to see this area move to a biovec
> interface instead of sgl, but it might still be worthwhile to have an
> interm step at least as an API consolidation.

Hm but then we'd need a new struct for the mapped side of things
(which would still be what you get from dma-buf). That would be quite
a bit of work to roll out everywhere, and sgt isn't such a huge misfit
for passing buffer object mappings and system memory backing storage
around, and hence what we (very slowly) converging drivers/gpu towards
over the past 10 years or so.

And moving the dma_map step out of dma-buf doesn't work, because some
of the use-cases we have is for very special iommus which are managed
by the gpu driver directly. Stuff that e.g. rotates/retiles/compresses
on the fly, and is accessible by other (gfx related like video code,
camera, ..) devices. Not something I expect to ever be relevant for
rdma since this exist mostly on some small soc, but it's a thing.
Without that dma-buf could hand out biovec for struct_page backed
stuff, or some pfn_vec for the p2p stuff.

Anyway was just an idea, I guess we'll have to live with some
impedance mismatch since rolling out the one an only iovec structure
which suits everyone is I think impossible :-)

> Avoiding the page list would be complicated as we'd somehow have to
> code share the page table iterator scheme.

We're (slowly) getting towards thp for vram mappings and everything so
I guess for drivers/gpu we might make that happen. But yeah it'd be
not so pretty I think.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
