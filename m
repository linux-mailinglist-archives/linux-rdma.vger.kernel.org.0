Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5877E11E1CE
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Dec 2019 11:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbfLMKTX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Dec 2019 05:19:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33689 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMKTX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Dec 2019 05:19:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id b6so6077918wrq.0
        for <linux-rdma@vger.kernel.org>; Fri, 13 Dec 2019 02:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rl6ZcpYNx9OU5/nEbfBo5yylHG5ar169zdHs7M50F4Q=;
        b=Ap0FGuiBLoc7CtJsj51ddw+Fe6G5hC9uLNn75596J5Cu1boRP8Hx4/X+SsUFptCl/Q
         4QdXTyu9jjysyr2JBOZZkONFripkTFG1nJ6Je9FXEKJyJV3CS23bW7QqwatOtTVrW34S
         /3MuLnSkpFz69g6E4iETKNuOb9eg/WRwlc/rI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=rl6ZcpYNx9OU5/nEbfBo5yylHG5ar169zdHs7M50F4Q=;
        b=kirN2K/vvp96I3mmqqhM478Q5AGn/ASjfwQHASFiIMKLKw+DIFJtOqLKC9UDwBVWbH
         uDXPDKa/qShIgV+sj6Sw1xS6T4EzjcPHpDpfh6se29MOzjrLJMbefChSl65ffj8zlBME
         26tWdH5mDexW+0iZ/Dje4uQz2x2EeZ1DBJuYQcjeIOw/Bh6TLPqBUNAsh3VM/rMwOMv2
         6IBKZIvj20zY8MkDEWAb6wOfx2tl654zO/DeFbQ+JMpxXeV1ASLeAAeMswXyBo63eRhe
         zUnZ1Dg+nmntTHQnLtKZIRUJylJEV1ENei1wt9r91CUYwzqZiECdapm9wQQezgKOx1SQ
         Fg2g==
X-Gm-Message-State: APjAAAVffeFe+F6wWiM8DzlbYQulAAfEHnIbinWaotp3/vfLxhMzJrtF
        LQMhhLifDrQQpoBSeVenDd8k6Q==
X-Google-Smtp-Source: APXvYqyhmTb9L+Ty2qqWHWby6TsBUoPJB8m/X3BYq7Z4RTM7jDbTx/v8gsKAoFlcC2n53nTyeYCmrQ==
X-Received: by 2002:adf:fe12:: with SMTP id n18mr11521520wrr.158.1576232359891;
        Fri, 13 Dec 2019 02:19:19 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:564b:0:7567:bb67:3d7f:f863])
        by smtp.gmail.com with ESMTPSA id x1sm9393930wru.50.2019.12.13.02.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 02:19:18 -0800 (PST)
Date:   Fri, 13 Dec 2019 11:19:16 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Airlie <airlied@linux.ie>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [GIT PULL] Please pull hmm changes
Message-ID: <20191213101916.GD624164@phenom.ffwll.local>
Mail-Followup-To: Jason Gunthorpe <jgg@mellanox.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        David Airlie <airlied@linux.ie>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20191125204248.GA2485@ziepe.ca>
 <CAHk-=wiqguF5NakpL4L9XCmmYr4wY0wk__+6+wHVReF2sVVZhA@mail.gmail.com>
 <CAHk-=wiQtTsZfgTwLYgfV8Gr_0JJiboZOzVUTAgJ2xTdf5bMiw@mail.gmail.com>
 <20191203024206.GC5795@mellanox.com>
 <20191205160324.GB5819@redhat.com>
 <20191211225703.GE3434@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211225703.GE3434@mellanox.com>
X-Operating-System: Linux phenom 5.3.0-2-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 11, 2019 at 10:57:13PM +0000, Jason Gunthorpe wrote:
> On Thu, Dec 05, 2019 at 11:03:24AM -0500, Jerome Glisse wrote:
> 
> > > struct mmu_notifier_mm (ie the mm->mmu_notifier_mm)
> > >    -> mmn_mm
> > > struct mm_struct 
> > >    -> mm
> > > struct mmu_notifier (ie the user subscription to the mm_struct)
> > >    -> mn
> > > struct mmu_interval_notifier (the other kind of user subscription)
> > >    -> mni
> > 
> > What about "interval" the context should already tell people
> > it is related to mmu notifier and thus a notifier. I would
> > just remove the notifier suffix, this would match the below
> > range.
> 
> Interval could be a good replacement for mni in the mm/mmu_notififer
> file if we don't do the wholesale rename
> 
> > > I think it would be overall nicer with better names for the original
> > > structs. Perhaps:
> > > 
> > >  mmn_* - MMU notifier prefix
> > >  mmn_state <- struct mmu_notifier_mm
> > >  mmn_subscription (mmn_sub) <- struct mmu_notifier
> > >  mmn_range_subscription (mmn_range_sub) <- struct mmu_interval_notifier
> > >  mmn_invalidate_desc <- struct mmu_notifier_range
> > 
> > This looks good.
> 
> Well, lets just bite the bullet then and switch it. Do you like
> 'state'? I thought that was the weakest one

Since you're asking, here's my bikeshed. I kinda agree _state looks a bit
strange for this, what about a _link suffix in the spirit of

	struct list_head link;

The other common name is "node", but I think that's confusing in the
context of mm code. The purpose of this struct is to link everything
together (and yes it carries also some state, but the main job is to link
a mm_struct to a mmu_notifier). At least for me a _state is configuration
state for a specific object, not something that links a bunch of things
together. But I'm biased on this, since we use that pattern in drm for all
the display state tracking.

Also feel free to ignore my bikeshed :-)

Aside from this I think the proposed names are a solid improvement.
-Daniel

> 
> We could use mmnotif as the prefix, this makes the longest:
> 
>   struct mmnotif_range_subscription
> 
> Which is reasonable enough
> 
> > Maybe we can do a semantic patch to do convertion and then Linus
> > can easily apply the patch by just re-running the coccinelle.
> 
> I tried this last time I renamed everything, it was OK, but it missed
> updating the comments. So it still needs some by-hand helping.
> 
> I'll make some patches next week when I get back.
> 
> Jason
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
