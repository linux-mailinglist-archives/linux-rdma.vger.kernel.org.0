Return-Path: <linux-rdma+bounces-3781-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F6892CA55
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 08:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C2D1C21B25
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 06:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE512446CF;
	Wed, 10 Jul 2024 06:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p86Zdlhg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3BBA47
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jul 2024 06:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720591347; cv=none; b=HHIbDcUzdHK689bcFzaiMudlAUpGeHFpO/xnbT1AgqfcaKL8ZYuHV6VRvJkfQCtGFMwF4rSdInFa9dJN6k5i1+ugE6W1aL/yYmiFx0F2JvYVyF4vTllOKIm/739J4ihVeKRpuBHO1pZ5QBE9LFbPeqoPnyWZkrVKp8W1Pjr7FFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720591347; c=relaxed/simple;
	bh=lKgFiFW3zZjr3HXXPIFCHCg6bR5gw6CRBf9QHGQhNEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdu6usaxai4//kO7bXn6qoF7CkVWjTl2pBGGwNZi2n5bnLmELaaNMEkfAzsH1x1he68nfGsOXwrNWmjA3FpYinwyn8yDyDA0q3LfIpnbzHQDCp/xFvhIyCmO3FPHUE/49eesaz0gMFu00B+3ykkQlJqce8zGQ2QqdxyyZvAOKds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p86Zdlhg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BB5C32781;
	Wed, 10 Jul 2024 06:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720591347;
	bh=lKgFiFW3zZjr3HXXPIFCHCg6bR5gw6CRBf9QHGQhNEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p86ZdlhgMSBfyhS/9SPBSuKpMB09oJX1c3kju9iL9UcQyLy1OnfXba9FZTSKb09Kb
	 qZFdN5Y9fZbngrsvD09BaY+T5AZRi4fp745UmKGtRMQkL1iSEcbR82z3TIauLZuiWe
	 G4gk7IuB2BMkgOOLZssJ9gXsnGCG0mYONRUyk+IsdCQ0IaNEv7M24OEn3//jNJO9Ce
	 bf1eyoQL4bQIMTQfK/fm5SJVwIxX5kVr32vNVTszn12yJ05tkeTmC5okuhJxrmpy+K
	 cZa4A3O1FY4HoOhPdjLRkeOnsea0/rS1vpkpib1zFIIeVvz2AXnP4qSuqt/wLCZlqA
	 BYKkvu0ioQ6gQ==
Date: Wed, 10 Jul 2024 09:02:21 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: flyingpenghao@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	Peng Hao <flyingpeng@tencent.com>
Subject: Re: [PATCH]   infiniband/hw/ocrdma: increase frame warning limit in
 verifier when using KASAN or KCSAN
Message-ID: <20240710060221.GH6668@unreal>
References: <20240709105242.63299-1-flyingpeng@tencent.com>
 <20240709122737.GD6668@unreal>
 <20240709212608.GA1649561@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709212608.GA1649561@thelio-3990X>

On Tue, Jul 09, 2024 at 02:26:08PM -0700, Nathan Chancellor wrote:
> On Tue, Jul 09, 2024 at 03:27:37PM +0300, Leon Romanovsky wrote:
> > On Tue, Jul 09, 2024 at 06:52:42PM +0800, flyingpenghao@gmail.com wrote:
> > > From: Peng Hao <flyingpeng@tencent.com>
> > > 
> > > When building kernel with clang, which will typically
> > > have sanitizers enabled, there is a warning about a large stack frame.
> > > 
> > > drivers/infiniband/hw/ocrdma/ocrdma_stats.c:686:16: error: stack frame size (20664) exceeds limit (8192) in 'ocrdma_dbgfs_ops_read' [-Werror,-Wframe-larger-than]
> > > static ssize_t ocrdma_dbgfs_ops_read(struct file *filp, char __user *buffer,
> > >                ^
> > 
> > Please fix it, not hide it.
> 
> Agreed, this is far from an acceptable solution. No details were
> provided around compiler, architecture, or configuration, so I can only
> speculate what is happening here. From reading the code, I suspect that
> ocrdma_add_stat() is getting inlined into all of its callsites but the
> stack slot for buff[128] is not getting reused, which may be related to
> a missing lifetime marker like [1] or sanitizer instrumentation.  I am
> guessing that marking ocrdma_dbgfs_ops_read() as noinline_for_stack
> would resolve this.
> 
> static noinline_for_stack int ocrdma_add_stat(char *start, char *pcur,

This is a good solution, but first let's see if the author can provide
more details. 

> 
> If this is not tolerable for all configurations, it could be made more
> pointed with something like
> 
> static
> #if defined(CONFIG_CC_IS_CLANG) && (defined(CONFIG_KASAN) || defined(CONFIG_KCSAN))
> noinline_for_stack
> #endif
> int ocrdma_add_stat(char *start, char *pcur,
> 
> but I am aware that is quite ugly.
> 
> [1]: https://github.com/llvm/llvm-project/issues/38157#issuecomment-1756321571
> 
> Cheers,
> Nathan
> 
> > > Increase the frame size by 20% to set.
> > > 
> > > Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> > > ---
> > >  drivers/infiniband/hw/ocrdma/Makefile | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/infiniband/hw/ocrdma/Makefile b/drivers/infiniband/hw/ocrdma/Makefile
> > > index 14fba95021d8..a1e9fcc04751 100644
> > > --- a/drivers/infiniband/hw/ocrdma/Makefile
> > > +++ b/drivers/infiniband/hw/ocrdma/Makefile
> > > @@ -3,4 +3,10 @@ ccflags-y := -I $(srctree)/drivers/net/ethernet/emulex/benet
> > >  
> > >  obj-$(CONFIG_INFINIBAND_OCRDMA)	+= ocrdma.o
> > >  
> > > +ifneq ($(CONFIG_FRAME_WARN),0)
> > > +ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)),y)
> > > +CFLAGS_ocrdma_stats.o = -Wframe-larger-than=22664
> > > +endif
> > > +endif
> > > +
> > >  ocrdma-y :=	ocrdma_main.o ocrdma_verbs.o ocrdma_hw.o ocrdma_ah.o ocrdma_stats.o
> > > -- 
> > > 2.27.0
> > > 
> > > 

