Return-Path: <linux-rdma+bounces-3804-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6A892D4E5
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 17:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAD351F21827
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 15:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D4619413C;
	Wed, 10 Jul 2024 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6caoPvV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238DB190678
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jul 2024 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720625048; cv=none; b=ihW0uhxP6tx/5VE/RN561e9pV80z1RDsB01uYVqNu0/pSu6m1MFyFsFGOwD68iN10Q0rCqekzi8/7z6oQh+6oozZJIZSoNHDgDBEcFTmFHh3RNAHPMvHzrp80zHxAieyBqKX7McCtHN4GOwXEXmvxToMsFTOaZ3mFKmI1jkAf9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720625048; c=relaxed/simple;
	bh=9Vs/J4RSwspBl7TUJUSuRjlY+zu+cbvLnISpym/q1g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbemN7RnzIeVv8sIjnpI/efAfosOIE1jctrzOBoSfFzWYFS5Y0UxJMmeFGlgbzkC+k3ATdZiw2BdHSLE8zZehlFVFpfn0/FXPoAcj9/sky3PhmmNhLT8v+cyPqcScT1rApM3fEZeOebpCECsNtik6PcJKG7d4XE4laBY3o6eD3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6caoPvV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BD2C32781;
	Wed, 10 Jul 2024 15:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720625047;
	bh=9Vs/J4RSwspBl7TUJUSuRjlY+zu+cbvLnISpym/q1g4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F6caoPvV0BK6Bcl1oQRue6X/5gesmBopgy2i8mn6kz2qjF6+S+uDfUzqCfnycp5oM
	 GnF3E2PuvYKPinRXls1BqALkNk5t6PnNIGJ6aHeeK6WKFiMBYalIqBiJcOplSx7Wto
	 j6BO0VrC/DAKIUQJD8zYvvmnNDAkKPwOc/TXPCdia6ssjV8dcjm8yXo1oN1sFuzpsf
	 b3wTQcmIT5kivm1V7iChKfFqPAwxmn34m8rWntiBRRlIS02mCqEexnC44+SYs5zaX9
	 nq2mL18Q55dRp9T5FBXQny248g2rYfopO+OPBHU9YKxNLrpWy1u83AjWTqC8P5e4DU
	 +/5s9BzhEfN1Q==
Date: Wed, 10 Jul 2024 08:24:05 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Hao Peng <flyingpenghao@gmail.com>
Cc: Leon Romanovsky <leon@kernel.org>, jgg@ziepe.ca,
	linux-rdma@vger.kernel.org, Peng Hao <flyingpeng@tencent.com>
Subject: Re: [PATCH] infiniband/hw/ocrdma: increase frame warning limit in
 verifier when using KASAN or KCSAN
Message-ID: <20240710152405.GB1684801@thelio-3990X>
References: <20240709105242.63299-1-flyingpeng@tencent.com>
 <20240709122737.GD6668@unreal>
 <20240709212608.GA1649561@thelio-3990X>
 <20240710060221.GH6668@unreal>
 <CAPm50aLj5OsED5WeAnnv19d+JntNKC=WO8=FH7wy56dSccDb1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPm50aLj5OsED5WeAnnv19d+JntNKC=WO8=FH7wy56dSccDb1w@mail.gmail.com>

On Wed, Jul 10, 2024 at 09:46:27PM +0800, Hao Peng wrote:
> On Wed, Jul 10, 2024 at 2:02 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Tue, Jul 09, 2024 at 02:26:08PM -0700, Nathan Chancellor wrote:
> > > On Tue, Jul 09, 2024 at 03:27:37PM +0300, Leon Romanovsky wrote:
> > > > On Tue, Jul 09, 2024 at 06:52:42PM +0800, flyingpenghao@gmail.com wrote:
> > > > > From: Peng Hao <flyingpeng@tencent.com>
> > > > >
> > > > > When building kernel with clang, which will typically
> > > > > have sanitizers enabled, there is a warning about a large stack frame.
> > > > >
> > > > > drivers/infiniband/hw/ocrdma/ocrdma_stats.c:686:16: error: stack frame size (20664) exceeds limit (8192) in 'ocrdma_dbgfs_ops_read' [-Werror,-Wframe-larger-than]
> > > > > static ssize_t ocrdma_dbgfs_ops_read(struct file *filp, char __user *buffer,
> > > > >                ^
> > > >
> > > > Please fix it, not hide it.
> > >
> > > Agreed, this is far from an acceptable solution. No details were
> > > provided around compiler, architecture, or configuration, so I can only
> > > speculate what is happening here. From reading the code, I suspect that
> > > ocrdma_add_stat() is getting inlined into all of its callsites but the
> > > stack slot for buff[128] is not getting reused, which may be related to
> > > a missing lifetime marker like [1] or sanitizer instrumentation.  I am
> > > guessing that marking ocrdma_dbgfs_ops_read() as noinline_for_stack

This should have been ocrdma_add_stat()...

> > > would resolve this.
> > >
> KASAN is generally enabled for testing environments;
> noinline_for_stack is used to solve the problem of needing to
>  track deeper call chains. I also tried to use noinline_for_stack and
> issued a new patch, but I think the v1 method is better.

As far as I understand it, this stack usage would be a problem at runtime if
running without VMAP_STACK, so I am going to disagree. v2 gets more at the
heart of the problem (although I wonder if that just moves the high
stack usage to those other functions under the limit).

> My environment is:
> x86_64, clang version 15.0.7
> CONFIG_FRAME_WARN=8192

Is CONFIG_KASAN_STACK enabled? I realized that could be another reason
you see this warning, as that option is known to have high stack usage
with clang.

> > > static noinline_for_stack int ocrdma_add_stat(char *start, char *pcur,
> >
> > This is a good solution, but first let's see if the author can provide
> > more details.
> >
> > >
> > > If this is not tolerable for all configurations, it could be made more
> > > pointed with something like
> > >
> > > static
> > > #if defined(CONFIG_CC_IS_CLANG) && (defined(CONFIG_KASAN) || defined(CONFIG_KCSAN))
> > > noinline_for_stack
> > > #endif
> > > int ocrdma_add_stat(char *start, char *pcur,
> > >
> > > but I am aware that is quite ugly.
> > >
> > > [1]: https://github.com/llvm/llvm-project/issues/38157#issuecomment-1756321571
> > >
> > > Cheers,
> > > Nathan
> > >
> > > > > Increase the frame size by 20% to set.
> > > > >
> > > > > Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> > > > > ---
> > > > >  drivers/infiniband/hw/ocrdma/Makefile | 6 ++++++
> > > > >  1 file changed, 6 insertions(+)
> > > > >
> > > > > diff --git a/drivers/infiniband/hw/ocrdma/Makefile b/drivers/infiniband/hw/ocrdma/Makefile
> > > > > index 14fba95021d8..a1e9fcc04751 100644
> > > > > --- a/drivers/infiniband/hw/ocrdma/Makefile
> > > > > +++ b/drivers/infiniband/hw/ocrdma/Makefile
> > > > > @@ -3,4 +3,10 @@ ccflags-y := -I $(srctree)/drivers/net/ethernet/emulex/benet
> > > > >
> > > > >  obj-$(CONFIG_INFINIBAND_OCRDMA)  += ocrdma.o
> > > > >
> > > > > +ifneq ($(CONFIG_FRAME_WARN),0)
> > > > > +ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)),y)
> > > > > +CFLAGS_ocrdma_stats.o = -Wframe-larger-than=22664
> > > > > +endif
> > > > > +endif
> > > > > +
> > > > >  ocrdma-y :=      ocrdma_main.o ocrdma_verbs.o ocrdma_hw.o ocrdma_ah.o ocrdma_stats.o
> > > > > --
> > > > > 2.27.0
> > > > >
> > > > >

