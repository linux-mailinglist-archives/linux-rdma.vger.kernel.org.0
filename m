Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113C9447FBD
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Nov 2021 13:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236141AbhKHMuI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Nov 2021 07:50:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:42342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236758AbhKHMuH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 8 Nov 2021 07:50:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C935A61056;
        Mon,  8 Nov 2021 12:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636375643;
        bh=2lL6p2FkwKwZDMfQvkjmVX/8/DZ8UBYP9z5uxeu2gYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B4G2JkX/I6SmOre2krLcxpCZZQnCzYpjlx4Wp9FS1kJZdYO0Uif3jSnJykvAckjae
         AkGneqdtjmwK4CROWKJL2FONWxcE8t4dd64NkuQXQDxhLq7k4Wt91TLkn98ApMW/QI
         Ys2fIdKhi0P12HZF3/sl7ei0S0ukjCetmqT07VSxoPNvpfXXTxFVVsFiP9jtH1mXsJ
         R88rc6TtJNa8QZlawsko87txlzJT3kgMOCfAS0NYXSloX8t6HPdMIvG8ryguv9kLT7
         e7rAKCkhBw+1oHk8gKvDhTDZf+Cd6KvNHPBR5ksGuNvPjP4nGI0Gh+EJtT7JaV97FJ
         +8upPKlXmrbiA==
Date:   Mon, 8 Nov 2021 14:47:19 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] RDMA/netlink: Annotate unused function that is
 needed for compilation check
Message-ID: <YYkcV9g8E3KhE92h@unreal>
References: <4a8101919b765e01d7fde6f27fd572c958deeb4a.1636267207.git.leonro@nvidia.com>
 <20211108123639.GT2744544@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108123639.GT2744544@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 08, 2021 at 08:36:39AM -0400, Jason Gunthorpe wrote:
> On Sun, Nov 07, 2021 at 08:40:47AM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > >> drivers/infiniband/core/nldev.c:2543:1: warning: unused function '__chk_RDMA_NL_NLDEV'
> >    MODULE_ALIAS_RDMA_NETLINK(RDMA_NL_NLDEV, 5);
> >    ^
> > 
> > Fixes: e3bf14bdc17a ("rdma: Autoload netlink client modules")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  include/rdma/rdma_netlink.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/rdma/rdma_netlink.h b/include/rdma/rdma_netlink.h
> > index 2758d9df71ee..c2a79aeee113 100644
> > --- a/include/rdma/rdma_netlink.h
> > +++ b/include/rdma/rdma_netlink.h
> > @@ -30,7 +30,7 @@ enum rdma_nl_flags {
> >   * constant as well and the compiler checks they are the same.
> >   */
> >  #define MODULE_ALIAS_RDMA_NETLINK(_index, _val)                                \
> > -	static inline void __chk_##_index(void)                                \
> > +	static inline void __maybe_unused __chk_##_index(void)                 \
> >  	{                                                                      \
> >  		BUILD_BUG_ON(_index != _val);                                  \
> >  	}                                                                      \
> 
> This is a compiler bug, static inline should never need maybe_unsed

I saw many examples like this in arch code.
For example, commit 4ac214574d2d ("KVM: MMU: mark role_regs and role accessors as maybe unused")

It is better to fix and forget instead of trying to fix clang.

Thanks

> 
> Jason
