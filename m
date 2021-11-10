Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBB344C3F2
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Nov 2021 16:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbhKJPFx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Nov 2021 10:05:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:46952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232617AbhKJPFd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 10 Nov 2021 10:05:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4C3560F90;
        Wed, 10 Nov 2021 15:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636556566;
        bh=5m/zRffgKv16PZlxNb3w4yArR959Ngwu79vxZSMlMVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fXT8ePPs1hd0pBDwqMuWtVmwRtsw3LO6XpqrMg4QKLDe0QwuizjV3vaZbM48nI/QA
         VBZsAgTRtCrwtkyLeS6Jx9FLF7lXuZxEEZivN62hE8rn7af+7ifLQREQ5oq/bZc1UZ
         DoQz3XVxkjJSgit2ylgZMtaF4DyAelsew03Oyj1236Oj7CwocZJy6nVkE4yv14RF40
         dxUjxnlJo7SJK98dDjO/tOkgky/2ZD2vhRvwDMQaCWKYwBAYCed0+SMSSfvAulVX0N
         9v58HtpmMb8RGbs7getQ0/o4U3kwk7o2XX6rJBRtaqSRvqkc0K2Zfto44wOMAA2t17
         5RBSlu2TPRO9A==
Date:   Wed, 10 Nov 2021 17:02:42 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH rdma-rc] RDMA/netlink: Annotate unused function that is
 needed for compilation check
Message-ID: <YYvfEm0fSBxRjCk4@unreal>
References: <4a8101919b765e01d7fde6f27fd572c958deeb4a.1636267207.git.leonro@nvidia.com>
 <20211108123639.GT2744544@nvidia.com>
 <YYkcV9g8E3KhE92h@unreal>
 <20211108124839.GW2744544@nvidia.com>
 <YYvVL8myawsp49RB@unreal>
 <20211110144244.GU1740502@nvidia.com>
 <YYvcvUZpGfQerupd@unreal>
 <20211110145442.GV1740502@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110145442.GV1740502@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 10, 2021 at 10:54:42AM -0400, Jason Gunthorpe wrote:
> On Wed, Nov 10, 2021 at 04:52:45PM +0200, Leon Romanovsky wrote:
> > On Wed, Nov 10, 2021 at 10:42:44AM -0400, Jason Gunthorpe wrote:
> > > On Wed, Nov 10, 2021 at 04:20:31PM +0200, Leon Romanovsky wrote:
> > > > On Mon, Nov 08, 2021 at 08:48:39AM -0400, Jason Gunthorpe wrote:
> > > > > On Mon, Nov 08, 2021 at 02:47:19PM +0200, Leon Romanovsky wrote:
> > > > > > On Mon, Nov 08, 2021 at 08:36:39AM -0400, Jason Gunthorpe wrote:
> > > > > > > On Sun, Nov 07, 2021 at 08:40:47AM +0200, Leon Romanovsky wrote:
> > > > > > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > > > > > > 
> > > > > > > > >> drivers/infiniband/core/nldev.c:2543:1: warning: unused function '__chk_RDMA_NL_NLDEV'
> > > > > > > >    MODULE_ALIAS_RDMA_NETLINK(RDMA_NL_NLDEV, 5);
> > > > > > > >    ^
> > > > > > > > 
> > > > > > > > Fixes: e3bf14bdc17a ("rdma: Autoload netlink client modules")
> > > > > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > > > > > >  include/rdma/rdma_netlink.h | 2 +-
> > > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > > 
> > > > > > > > diff --git a/include/rdma/rdma_netlink.h b/include/rdma/rdma_netlink.h
> > > > > > > > index 2758d9df71ee..c2a79aeee113 100644
> > > > > > > > +++ b/include/rdma/rdma_netlink.h
> > > > > > > > @@ -30,7 +30,7 @@ enum rdma_nl_flags {
> > > > > > > >   * constant as well and the compiler checks they are the same.
> > > > > > > >   */
> > > > > > > >  #define MODULE_ALIAS_RDMA_NETLINK(_index, _val)                                \
> > > > > > > > -	static inline void __chk_##_index(void)                                \
> > > > > > > > +	static inline void __maybe_unused __chk_##_index(void)                 \
> > > > > > > >  	{                                                                      \
> > > > > > > >  		BUILD_BUG_ON(_index != _val);                                  \
> > > > > > > >  	}                                                                      \
> > > > > > > 
> > > > > > > This is a compiler bug, static inline should never need maybe_unsed
> > > > > > 
> > > > > > I saw many examples like this in arch code.
> > > > > > For example, commit 4ac214574d2d ("KVM: MMU: mark role_regs and role accessors as maybe unused")
> > > > > > 
> > > > > > It is better to fix and forget instead of trying to fix clang.
> > > > > 
> > > > > "Because clang reports warnings for unused inlines declared in a .c file,
> > > > > mark both sets of accessors as __maybe_unused."
> > > > > 
> > > > > Yikes, what a thing to do.
> > > > 
> > > > Jason,
> > > > 
> > > > I don't see this patch in the tree and patchworks status says that it is "new".
> > > > https://patchwork.kernel.org/project/linux-rdma/patch/4a8101919b765e01d7fde6f27fd572c958deeb4a.1636267207.git.leonro@nvidia.com/
> > > > 
> > > > Should I do anything extra to progress with this patch?
> > > 
> > > It is merge window, I'm not doing anything with patches until rc1
> > > unless it is an emergency and a random clang failure on mips isn't
> > > an emergency.
> > 
> > ok, I didn't know that build failure is not important.
> 
> It is a warning then the clang mips compiler crashes, so <shrug>
> 
> None of this is new code, frankly I'm confused why we are only seeing
> it now since I'm running clang 12 builds standard.. Is it W=1 or something?

Yes, it is W=1, the failure was reported 5 months ago, but to wrong person :)
https://lore.kernel.org/lkml/202105122353.5x1Ez6Dh-lkp@intel.com/

> 
> Jason
