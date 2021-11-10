Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41AF44C367
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Nov 2021 15:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbhKJOzg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Nov 2021 09:55:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:43188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232186AbhKJOzg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 10 Nov 2021 09:55:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 22A83611ED;
        Wed, 10 Nov 2021 14:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636555968;
        bh=y6erYN1h2x+BqWPWwFUttEPWi8tX+k7oMBONlweQHfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SBCk0ohjlSo+p3nC74Zl4cJK4kMv1EkqeU5WDxFEcgBYaaJ41HiqQNJjAkvFPt15u
         RfW5dlUSRncVrOS/rFspTS9BUsDxGvPMpwZjVqEbPEtii7WU2CRXNBUWvd+9Kihcp0
         AtSILL50AoYbyUX4nF3/6v86A6GZDn6x+7B+7iR7lQmyRwRPlfIhP065BNixSbIxeh
         rWzd1FzZ3eXRaYWBkN7j+gCCRHB5hmG1lGzhi/ZLzUoFcMQnSQnZHEhRMKnICFwXS2
         a6o9AO6KbRc5LCoyBHk7Ey3weau0URKrWCmxP2s28v40LoTTYMeeFZqUWMzv51UsJX
         ray3XseLCqn4w==
Date:   Wed, 10 Nov 2021 16:52:45 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] RDMA/netlink: Annotate unused function that is
 needed for compilation check
Message-ID: <YYvcvUZpGfQerupd@unreal>
References: <4a8101919b765e01d7fde6f27fd572c958deeb4a.1636267207.git.leonro@nvidia.com>
 <20211108123639.GT2744544@nvidia.com>
 <YYkcV9g8E3KhE92h@unreal>
 <20211108124839.GW2744544@nvidia.com>
 <YYvVL8myawsp49RB@unreal>
 <20211110144244.GU1740502@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110144244.GU1740502@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 10, 2021 at 10:42:44AM -0400, Jason Gunthorpe wrote:
> On Wed, Nov 10, 2021 at 04:20:31PM +0200, Leon Romanovsky wrote:
> > On Mon, Nov 08, 2021 at 08:48:39AM -0400, Jason Gunthorpe wrote:
> > > On Mon, Nov 08, 2021 at 02:47:19PM +0200, Leon Romanovsky wrote:
> > > > On Mon, Nov 08, 2021 at 08:36:39AM -0400, Jason Gunthorpe wrote:
> > > > > On Sun, Nov 07, 2021 at 08:40:47AM +0200, Leon Romanovsky wrote:
> > > > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > > > > 
> > > > > > >> drivers/infiniband/core/nldev.c:2543:1: warning: unused function '__chk_RDMA_NL_NLDEV'
> > > > > >    MODULE_ALIAS_RDMA_NETLINK(RDMA_NL_NLDEV, 5);
> > > > > >    ^
> > > > > > 
> > > > > > Fixes: e3bf14bdc17a ("rdma: Autoload netlink client modules")
> > > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > > > >  include/rdma/rdma_netlink.h | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/include/rdma/rdma_netlink.h b/include/rdma/rdma_netlink.h
> > > > > > index 2758d9df71ee..c2a79aeee113 100644
> > > > > > +++ b/include/rdma/rdma_netlink.h
> > > > > > @@ -30,7 +30,7 @@ enum rdma_nl_flags {
> > > > > >   * constant as well and the compiler checks they are the same.
> > > > > >   */
> > > > > >  #define MODULE_ALIAS_RDMA_NETLINK(_index, _val)                                \
> > > > > > -	static inline void __chk_##_index(void)                                \
> > > > > > +	static inline void __maybe_unused __chk_##_index(void)                 \
> > > > > >  	{                                                                      \
> > > > > >  		BUILD_BUG_ON(_index != _val);                                  \
> > > > > >  	}                                                                      \
> > > > > 
> > > > > This is a compiler bug, static inline should never need maybe_unsed
> > > > 
> > > > I saw many examples like this in arch code.
> > > > For example, commit 4ac214574d2d ("KVM: MMU: mark role_regs and role accessors as maybe unused")
> > > > 
> > > > It is better to fix and forget instead of trying to fix clang.
> > > 
> > > "Because clang reports warnings for unused inlines declared in a .c file,
> > > mark both sets of accessors as __maybe_unused."
> > > 
> > > Yikes, what a thing to do.
> > 
> > Jason,
> > 
> > I don't see this patch in the tree and patchworks status says that it is "new".
> > https://patchwork.kernel.org/project/linux-rdma/patch/4a8101919b765e01d7fde6f27fd572c958deeb4a.1636267207.git.leonro@nvidia.com/
> > 
> > Should I do anything extra to progress with this patch?
> 
> It is merge window, I'm not doing anything with patches until rc1
> unless it is an emergency and a random clang failure on mips isn't
> an emergency.

ok, I didn't know that build failure is not important.

Thanks

> 
> Jason
