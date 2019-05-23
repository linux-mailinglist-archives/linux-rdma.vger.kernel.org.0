Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9011D285DF
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2019 20:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731329AbfEWSZB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 May 2019 14:25:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47350 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731237AbfEWSZB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 23 May 2019 14:25:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2B909300C035;
        Thu, 23 May 2019 18:25:01 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 43CCC5D9C6;
        Thu, 23 May 2019 18:25:00 +0000 (UTC)
Date:   Thu, 23 May 2019 14:24:58 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: Re: [PATCH v4 0/1] Use HMM for ODP v4
Message-ID: <20190523182458.GA3571@redhat.com>
References: <20190521205321.GC3331@redhat.com>
 <20190522005225.GA30819@ziepe.ca>
 <20190522174852.GA23038@redhat.com>
 <20190522235737.GD15389@ziepe.ca>
 <20190523150432.GA5104@redhat.com>
 <20190523154149.GB12159@ziepe.ca>
 <20190523155207.GC5104@redhat.com>
 <20190523163429.GC12159@ziepe.ca>
 <20190523173302.GD5104@redhat.com>
 <20190523175546.GE12159@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190523175546.GE12159@ziepe.ca>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 23 May 2019 18:25:01 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 23, 2019 at 02:55:46PM -0300, Jason Gunthorpe wrote:
> On Thu, May 23, 2019 at 01:33:03PM -0400, Jerome Glisse wrote:
> > On Thu, May 23, 2019 at 01:34:29PM -0300, Jason Gunthorpe wrote:
> > > On Thu, May 23, 2019 at 11:52:08AM -0400, Jerome Glisse wrote:
> > > > On Thu, May 23, 2019 at 12:41:49PM -0300, Jason Gunthorpe wrote:
> > > > > On Thu, May 23, 2019 at 11:04:32AM -0400, Jerome Glisse wrote:
> > > > > > On Wed, May 22, 2019 at 08:57:37PM -0300, Jason Gunthorpe wrote:
> > > > > > > On Wed, May 22, 2019 at 01:48:52PM -0400, Jerome Glisse wrote:
> > > > > > > 
> > > > > > > > > > So attached is a rebase on top of 5.2-rc1, i have tested with pingpong
> > > > > > > > > > (prefetch and not and different sizes). Seems to work ok.
> > > > > > > > > 
> > > > > > > > > Urk, it already doesn't apply to the rdma tree :(
> > > > > > > > > 
> > > > > > > > > The conflicts are a little more extensive than I'd prefer to handle..
> > > > > > > > > Can I ask you to rebase it on top of this branch please:
> > > > > > > > > 
> > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=wip/jgg-for-next
> > > > > > > > > 
> > > > > > > > > Specifically it conflicts with this patch:
> > > > > > > > > 
> > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=wip/jgg-for-next&id=d2183c6f1958e6b6dfdde279f4cee04280710e34
> > > > > > > 
> > > > > > > There is at least one more serious blocker here:
> > > > > > > 
> > > > > > > config ARCH_HAS_HMM_MIRROR
> > > > > > >         bool
> > > > > > >         default y
> > > > > > >         depends on (X86_64 || PPC64)
> > > > > > >         depends on MMU && 64BIT
> > > > > > > 
> > > > > > > I can't loose ARM64 support for ODP by merging this, that is too
> > > > > > > serious of a regression.
> > > > > > > 
> > > > > > > Can you fix it?
> > > > > > 
> > > > > > 5.2 already has patch to fix the Kconfig (ARCH_HAS_HMM_MIRROR and
> > > > > > ARCH_HAS_HMM_DEVICE replacing ARCH_HAS_HMM) I need to update nouveau
> > > > > 
> > > > > Newer than 5.2-rc1? Is this why ARCH_HAS_HMM_MIRROR is not used anywhere?
> > > > 
> > > > Yes this is multi-step update, first add the new Kconfig release n,
> > > > update driver in release n+1, update core Kconfig in release n+2
> > > > 
> > > > So we are in release n (5.2), in 5.3 i will update nouveau and amdgpu
> > > > so that in 5.4 in ca remove the old ARCH_HAS_HMM
> > > 
> > > Why don't you just send the patch for both parts to mm or to DRM?
> > > 
> > > This is very normal - as long as the resulting conflicts would be
> > > small during there is no reason not to do this. Can you share the
> > > combined patch?
> > 
> > This was tested in the past an resulted in failure. So for now i am
> > taking the simplest and easiest path with the least burden for every
> > maintainer. It only complexify my life.
> 
> I don't know what you tried to do in the past, but it happens all the
> time, every merge cycle with success. Not everything can be done, but
> changing the signature of one function with one call site should
> really not be a problem.
> 
> > Note that mm is not a git tree and thus i can not play any git trick
> > to help in this endeavor.
> 
> I am aware..
> 
> > > > > If mm takes the fixup patches so hmm mirror is as reliable as ODP's
> > > > > existing stuff, and patch from you to enable ARM64, then we can
> > > > > continue to merge into 5.3
> > > > > 
> > > > > So, let us try to get acks on those other threads..
> > > > 
> > > > I will be merging your patchset and Ralph and repost, they are only
> > > > minor change mostly that you can not update the driver API in just
> > > > one release.
> > > 
> > > Of course you can, we do it all the time. It requires some
> > > co-ordination, but as long as the merge conflicts are not big it is
> > > fine.
> > > 
> > > Merge the driver API change and the call site updates to -mm and
> > > refain from merging horrendously conflicting patches through DRM.
> > > 
> > > In the case of the changes in my HMM RFC it is something like 2
> > > lines in DRM that need touching, no problem at all.
> > > 
> > > If you want help I can volunteer make a hmm PR for Linus just for this
> > > during the merge window - but Andrew would need to agree and ack the
> > > patches.
> > 
> > This was tested in the past and i do not want to go over this issue
> > again (or re-iterate the long emails discussion associated with that).
> > It failed and it put the burden on every maintainers. So it is easier
> > to do the multi-step thing.
> > 
> > You can take a peak at Ralph patchset and yours into one with minor
> > changes here:
> > 
> > https://cgit.freedesktop.org/~glisse/linux/log/?h=hmm-5.3
> 
> Okay..
> 
> This patch needs to use down_read(&mm->mmap_sem) not READ_ONCE:
> 
>  mm/hmm: do not try to create hmm struct from within hmm_range_register()
>  Driver should never call hmm_range_register() without a valid and active
>  registered hmm_mirror and thus without a valid and active hmm struct. So
>  if that happens just return -EFAULT.
> 
> Otherwise it is inconsisent with the locking scheme and has a use
> after free race. 

I can not take mmap_sem in range_register, the READ_ONCE is fine and
they are no race as we do take a reference on the hmm struct thus
if we get are successful at taking that reference then hmm struct
will remain valid. Also this API has always been use with active
mirror and thus active hmm and thus mm->hmm will remain stable for
all call to hmm_range_register(), it would be a bug otherwise.

The READ_ONCE() is really just a safety net, it is not required and
once the convertion to hmm_mirror is done it will go away.

> 
> I was not sure if the lock could be obtained safely here so I
> preferred to use the no-lock alternative of passing in mirror. I still
> think you should just change the single call site and sent to -mm.

It is too painful with unmerge driver like amdgpu that are targeting
5.3, those do target API that is in 5.2

Cheers,
Jérôme
