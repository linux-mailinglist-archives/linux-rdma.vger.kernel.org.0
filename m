Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE5962855F
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2019 19:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbfEWRzt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 May 2019 13:55:49 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43122 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731073AbfEWRzt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 May 2019 13:55:49 -0400
Received: by mail-qt1-f193.google.com with SMTP id g17so1724331qtq.10
        for <linux-rdma@vger.kernel.org>; Thu, 23 May 2019 10:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CgT8oRWFS1J54ASxbVHmBz5Tyd/B834Vmb8dQsBzisk=;
        b=F01S9opKEjPWv1Ji/EPg5pd8NgABY3rLeWMBPEdUABGVrhUNUf5eWyX9uP4mooc9z7
         08jsjlnmLzzEGZa2iFIooRKYnwUGmWomH4RW9fOz5RgdIghbJHbngpnj3zQAptdfz5Xn
         ozn0pvEdcMupMWs0/GT5euLr6qmTjpe5C4rkgyWcIcJQhOmO6JX9pNBvqsTNW3L5DrVo
         hprfbGpQqesljgeHKGYrVsjgILLrqDcWnb2qGhkNr5O8vilHZmJVaDaUfrbY+RHRDcIS
         +kdh3CoXyBFc8Ao/3ZL0a4rOoMaQyCwbYk30JpKF1t65UfZNPAu1RebA5i0dYH0QvfuY
         +Omg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CgT8oRWFS1J54ASxbVHmBz5Tyd/B834Vmb8dQsBzisk=;
        b=Gaei6LWceFOb52QKhOzYP1IIhxGytCkX3YjLoTTz4YVRMWi1WAQ9oV5h4ccPOxiBmA
         +xr/JzJ9yOxAjn1fDZDgV3tRdjnXofhdzNsbdLY+Zjp0t5Z2pdU54igeetvkDZQ5uEhy
         7ho+soqQ8218xKr1VuvbMpCvnAZqdwf9pLuBTeNfcHUzhiOtuc/G1633BpeKD7vZETNF
         7odS2N8mUs+bwBC7N2ThuoAak6jGnCMAfzZIfuFsrCJb1sN4jnZpX+D72qSoHm9repDx
         0e8HX+CApFSrVFg63XaK40Qm57OkfQPFSdPzFuuSnyCGdfJmsPFqqbTPWJmZAc1wdTX6
         BIYQ==
X-Gm-Message-State: APjAAAU3XEu1BSuABXeJBSNm8RYSlhzLgMhfHNJiyb/lB2JXMyyEnqiL
        kcEVNNy6Nr5+G3DV1ixyboxi6g==
X-Google-Smtp-Source: APXvYqx3zTS7lcJS9edhgyAQdVswoEICefM3VTQ/rsN0qW9V3gpHj7jUQQJoTPHGPMbQYnaMuP+Zkg==
X-Received: by 2002:aed:22e2:: with SMTP id q31mr80397038qtc.238.1558634148140;
        Thu, 23 May 2019 10:55:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id o64sm21105qke.61.2019.05.23.10.55.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 10:55:47 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTrwQ-0008Ar-MY; Thu, 23 May 2019 14:55:46 -0300
Date:   Thu, 23 May 2019 14:55:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: Re: [PATCH v4 0/1] Use HMM for ODP v4
Message-ID: <20190523175546.GE12159@ziepe.ca>
References: <20190506195657.GA30261@ziepe.ca>
 <20190521205321.GC3331@redhat.com>
 <20190522005225.GA30819@ziepe.ca>
 <20190522174852.GA23038@redhat.com>
 <20190522235737.GD15389@ziepe.ca>
 <20190523150432.GA5104@redhat.com>
 <20190523154149.GB12159@ziepe.ca>
 <20190523155207.GC5104@redhat.com>
 <20190523163429.GC12159@ziepe.ca>
 <20190523173302.GD5104@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523173302.GD5104@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 23, 2019 at 01:33:03PM -0400, Jerome Glisse wrote:
> On Thu, May 23, 2019 at 01:34:29PM -0300, Jason Gunthorpe wrote:
> > On Thu, May 23, 2019 at 11:52:08AM -0400, Jerome Glisse wrote:
> > > On Thu, May 23, 2019 at 12:41:49PM -0300, Jason Gunthorpe wrote:
> > > > On Thu, May 23, 2019 at 11:04:32AM -0400, Jerome Glisse wrote:
> > > > > On Wed, May 22, 2019 at 08:57:37PM -0300, Jason Gunthorpe wrote:
> > > > > > On Wed, May 22, 2019 at 01:48:52PM -0400, Jerome Glisse wrote:
> > > > > > 
> > > > > > > > > So attached is a rebase on top of 5.2-rc1, i have tested with pingpong
> > > > > > > > > (prefetch and not and different sizes). Seems to work ok.
> > > > > > > > 
> > > > > > > > Urk, it already doesn't apply to the rdma tree :(
> > > > > > > > 
> > > > > > > > The conflicts are a little more extensive than I'd prefer to handle..
> > > > > > > > Can I ask you to rebase it on top of this branch please:
> > > > > > > > 
> > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=wip/jgg-for-next
> > > > > > > > 
> > > > > > > > Specifically it conflicts with this patch:
> > > > > > > > 
> > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=wip/jgg-for-next&id=d2183c6f1958e6b6dfdde279f4cee04280710e34
> > > > > > 
> > > > > > There is at least one more serious blocker here:
> > > > > > 
> > > > > > config ARCH_HAS_HMM_MIRROR
> > > > > >         bool
> > > > > >         default y
> > > > > >         depends on (X86_64 || PPC64)
> > > > > >         depends on MMU && 64BIT
> > > > > > 
> > > > > > I can't loose ARM64 support for ODP by merging this, that is too
> > > > > > serious of a regression.
> > > > > > 
> > > > > > Can you fix it?
> > > > > 
> > > > > 5.2 already has patch to fix the Kconfig (ARCH_HAS_HMM_MIRROR and
> > > > > ARCH_HAS_HMM_DEVICE replacing ARCH_HAS_HMM) I need to update nouveau
> > > > 
> > > > Newer than 5.2-rc1? Is this why ARCH_HAS_HMM_MIRROR is not used anywhere?
> > > 
> > > Yes this is multi-step update, first add the new Kconfig release n,
> > > update driver in release n+1, update core Kconfig in release n+2
> > > 
> > > So we are in release n (5.2), in 5.3 i will update nouveau and amdgpu
> > > so that in 5.4 in ca remove the old ARCH_HAS_HMM
> > 
> > Why don't you just send the patch for both parts to mm or to DRM?
> > 
> > This is very normal - as long as the resulting conflicts would be
> > small during there is no reason not to do this. Can you share the
> > combined patch?
> 
> This was tested in the past an resulted in failure. So for now i am
> taking the simplest and easiest path with the least burden for every
> maintainer. It only complexify my life.

I don't know what you tried to do in the past, but it happens all the
time, every merge cycle with success. Not everything can be done, but
changing the signature of one function with one call site should
really not be a problem.

> Note that mm is not a git tree and thus i can not play any git trick
> to help in this endeavor.

I am aware..

> > > > If mm takes the fixup patches so hmm mirror is as reliable as ODP's
> > > > existing stuff, and patch from you to enable ARM64, then we can
> > > > continue to merge into 5.3
> > > > 
> > > > So, let us try to get acks on those other threads..
> > > 
> > > I will be merging your patchset and Ralph and repost, they are only
> > > minor change mostly that you can not update the driver API in just
> > > one release.
> > 
> > Of course you can, we do it all the time. It requires some
> > co-ordination, but as long as the merge conflicts are not big it is
> > fine.
> > 
> > Merge the driver API change and the call site updates to -mm and
> > refain from merging horrendously conflicting patches through DRM.
> > 
> > In the case of the changes in my HMM RFC it is something like 2
> > lines in DRM that need touching, no problem at all.
> > 
> > If you want help I can volunteer make a hmm PR for Linus just for this
> > during the merge window - but Andrew would need to agree and ack the
> > patches.
> 
> This was tested in the past and i do not want to go over this issue
> again (or re-iterate the long emails discussion associated with that).
> It failed and it put the burden on every maintainers. So it is easier
> to do the multi-step thing.
> 
> You can take a peak at Ralph patchset and yours into one with minor
> changes here:
> 
> https://cgit.freedesktop.org/~glisse/linux/log/?h=hmm-5.3

Okay..

This patch needs to use down_read(&mm->mmap_sem) not READ_ONCE:

 mm/hmm: do not try to create hmm struct from within hmm_range_register()
 Driver should never call hmm_range_register() without a valid and active
 registered hmm_mirror and thus without a valid and active hmm struct. So
 if that happens just return -EFAULT.

Otherwise it is inconsisent with the locking scheme and has a use
after free race. 

I was not sure if the lock could be obtained safely here so I
preferred to use the no-lock alternative of passing in mirror. I still
think you should just change the single call site and sent to -mm.

Thank you for all the other fixes, they look great.

Regards,
Jason
