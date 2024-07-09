Return-Path: <linux-rdma+bounces-3778-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4479A92C54B
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 23:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2B9F1F232C8
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 21:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1479A182A58;
	Tue,  9 Jul 2024 21:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOurk9AO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1F8153505
	for <linux-rdma@vger.kernel.org>; Tue,  9 Jul 2024 21:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720560370; cv=none; b=Ge7UOtZBdhQKZp0Xrf/94iOuZOXSAeepvSuKt7rW0B/KACiWk6uTBeoxoJFU5HTqflR83x6Nic13Anzxf9CYiOwvD1aFMXJzcJT2Zb4QujSt6wDlAsAcUMKUy/fPDnDDi+AFMUf9Ngaui01Mg1RjxRDuovpidHiR+vQja2O3Rh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720560370; c=relaxed/simple;
	bh=AWEu4sU0j19F9mfAfoRzNLeMS3uivt27s77ecTWIIGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BlZaGGwlc0F/sDXZNSGaxsBDb9NzEF5GCBDvqseZpHZt+/Qme99lF67LPYt9tm+W2DvK8G8ZWH/t8ParBmDHIsn5+9nuUtpFeqaLLwE54/eULG3HX5V2Gg+y/8k2mw6Ch7oEI6+2zxP97ul6fIvSvOpofqmYhcQQGuMhLcuRnuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOurk9AO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1CB9C3277B;
	Tue,  9 Jul 2024 21:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720560370;
	bh=AWEu4sU0j19F9mfAfoRzNLeMS3uivt27s77ecTWIIGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UOurk9AO4NQ4X9es6oxqH1ay9c8wa5GRV1tXIbrhCPFW42rEl3Zq3IOUg5I+xXvEJ
	 Aqoapx3oBPRdVqpqY/U54iNR+Irna+th6qSfutVso4Tw5Rdua6kgFZ/UueqsFLLMnj
	 /d0qF75DDxlmKo6n0defLkNCrOqCcnSxSuW1kh+xDI4D2SEZ8SsFUBYYOsdDrmwZOd
	 KUsnsilJEhbyv6OSiQHqu+dCk1X4nVdtdkWLFsHbhuZ1EBwKFQE5H1Yv6hs2/Yhlt/
	 ocDAPnUyi3EKLTdNME3lTu5HMwJCDI7LAq6xzAk/P3N1Fdquf+p+YerWawqXa9v5Ly
	 Ief5mi5HTGmHQ==
Date: Tue, 9 Jul 2024 14:26:08 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: flyingpenghao@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	Peng Hao <flyingpeng@tencent.com>
Subject: Re: [PATCH]   infiniband/hw/ocrdma: increase frame warning limit in
 verifier when using KASAN or KCSAN
Message-ID: <20240709212608.GA1649561@thelio-3990X>
References: <20240709105242.63299-1-flyingpeng@tencent.com>
 <20240709122737.GD6668@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709122737.GD6668@unreal>

On Tue, Jul 09, 2024 at 03:27:37PM +0300, Leon Romanovsky wrote:
> On Tue, Jul 09, 2024 at 06:52:42PM +0800, flyingpenghao@gmail.com wrote:
> > From: Peng Hao <flyingpeng@tencent.com>
> > 
> > When building kernel with clang, which will typically
> > have sanitizers enabled, there is a warning about a large stack frame.
> > 
> > drivers/infiniband/hw/ocrdma/ocrdma_stats.c:686:16: error: stack frame size (20664) exceeds limit (8192) in 'ocrdma_dbgfs_ops_read' [-Werror,-Wframe-larger-than]
> > static ssize_t ocrdma_dbgfs_ops_read(struct file *filp, char __user *buffer,
> >                ^
> 
> Please fix it, not hide it.

Agreed, this is far from an acceptable solution. No details were
provided around compiler, architecture, or configuration, so I can only
speculate what is happening here. From reading the code, I suspect that
ocrdma_add_stat() is getting inlined into all of its callsites but the
stack slot for buff[128] is not getting reused, which may be related to
a missing lifetime marker like [1] or sanitizer instrumentation.  I am
guessing that marking ocrdma_dbgfs_ops_read() as noinline_for_stack
would resolve this.

static noinline_for_stack int ocrdma_add_stat(char *start, char *pcur,

If this is not tolerable for all configurations, it could be made more
pointed with something like

static
#if defined(CONFIG_CC_IS_CLANG) && (defined(CONFIG_KASAN) || defined(CONFIG_KCSAN))
noinline_for_stack
#endif
int ocrdma_add_stat(char *start, char *pcur,

but I am aware that is quite ugly.

[1]: https://github.com/llvm/llvm-project/issues/38157#issuecomment-1756321571

Cheers,
Nathan

> > Increase the frame size by 20% to set.
> > 
> > Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> > ---
> >  drivers/infiniband/hw/ocrdma/Makefile | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/infiniband/hw/ocrdma/Makefile b/drivers/infiniband/hw/ocrdma/Makefile
> > index 14fba95021d8..a1e9fcc04751 100644
> > --- a/drivers/infiniband/hw/ocrdma/Makefile
> > +++ b/drivers/infiniband/hw/ocrdma/Makefile
> > @@ -3,4 +3,10 @@ ccflags-y := -I $(srctree)/drivers/net/ethernet/emulex/benet
> >  
> >  obj-$(CONFIG_INFINIBAND_OCRDMA)	+= ocrdma.o
> >  
> > +ifneq ($(CONFIG_FRAME_WARN),0)
> > +ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)),y)
> > +CFLAGS_ocrdma_stats.o = -Wframe-larger-than=22664
> > +endif
> > +endif
> > +
> >  ocrdma-y :=	ocrdma_main.o ocrdma_verbs.o ocrdma_hw.o ocrdma_ah.o ocrdma_stats.o
> > -- 
> > 2.27.0
> > 
> > 

