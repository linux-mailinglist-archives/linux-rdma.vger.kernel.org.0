Return-Path: <linux-rdma+bounces-3802-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E1892D352
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 15:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284021C22F56
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2024 13:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7B613D501;
	Wed, 10 Jul 2024 13:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFc7gW68"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D94192B8E
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jul 2024 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720619202; cv=none; b=gOGjg6GsFTxjUUrHvPs0lArSTEu+zlK7vzTL5ygU9zODtp4Mp3kNz7yFxC9yroFQ0+byENvpYn4eXFimWgok1hVa0Zm5UmttjuuchXq5cwXtn0RFGgDI58QhRpWGk+giDTQLKZZjFswaJL8f/FdzIJFVOeDUCUAH6fWERgl6O7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720619202; c=relaxed/simple;
	bh=feDBvWRIRzTgN6QbXVbs0peoFiWE7fusIOptgeHkXXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eW8TjpzemHe7sepGKLWpyfoAWiifSx7+klaW6Inah2I+kwOSCyRDpEUGM3z/FmS8JnFqN8qNi0MO+wgpHh4RLH7Gx0cXIh1q2TITWgWJCmX0XAyxUO5FTn9eVV57Uf3x3LOupPdsOtHGeNrVxGNVTsEAcMoCk9OiWChwPfZ9rAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFc7gW68; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42726d6eca5so9362175e9.1
        for <linux-rdma@vger.kernel.org>; Wed, 10 Jul 2024 06:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720619199; x=1721223999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmlJniPvKFxGn0zgmpG06wXTyn8rYz2lfmU/WFt8q84=;
        b=WFc7gW68nSfvlvNGNEhayErXgU3wlKEpLCh5a8tYpa4bnTCql+pPWLvUUEgbMBM1YQ
         7sEklQCrNIX+3C5cZFX0b+t0ePVeNMbxBEua4jf2q9zgVcL0MfIixAgAMG2ToAXEmemG
         5fRHINaFR9UPSXgPhZOMSmB5C944I8nje/m7PiBemhJy5afe2TB0Bjiqpr5/v1GnmlcZ
         u26GwXhozmei5hZzU0WDi4D9u/l06qvh9xbX442r0YiUeBvLQiWvnOfGceonkwqeC55C
         WCjzz1+pNfzWtpIZsgNihT86UepzbJPEbJ6zDypzcRdJCOwFdS8OXgpu1MfeREvosThk
         TusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720619199; x=1721223999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmlJniPvKFxGn0zgmpG06wXTyn8rYz2lfmU/WFt8q84=;
        b=jt0bwqinJBFWkIoXxG/Lb29bXqVFyXJJqjIWAtfwLf4AjuYeRYwGI7FGfBSDdmTW9R
         13l07EIt1mPKzmCAs+bs1pswNyH1pCJJJtW1wRF+s6blS8yVU+xgF5tBgu0Tef7C0R4a
         V9VQWomEnR1LoUNl2r6Ep/g6m3XpZpZr/ndUNfjbX+g3nD3hq52UCxONOcjF/6VBN0Hm
         Ohdn9dgbelXkaQ1EFK6OLldlYsVUnhSc7N0NksuLuc4E8PzJ3sWyRXT1V8BIu7PazQN7
         NR/6uiPHS4bt2dfb1weF3frC6eR5AlYMLbVGxAVj8PX42rBv33CE4thtmrdk0E1sFTiy
         GXhg==
X-Forwarded-Encrypted: i=1; AJvYcCVbZei5emfNwT4cIYAgp5tmd9JlFR63Ywmo3x9lORvpJnlMZjZByG8+y1jNnmETurMIyG0y7K4MeWbp7JbYBqwW7Wp3DhSBxHgDwA==
X-Gm-Message-State: AOJu0YwLf5PxztTbofAVwlkLKAQex7E4Mzh6AoVl5X+bB15jBf9DoXH6
	YBjV5XeaJ+XO6IXkQIUgtDmnUrztuglxDb93mR/s6LcWSok1zg4bl12W8NkmG5Q9kDfb/RMSELT
	3JrIddqVuaViqOM+gcB36wS/M3qA=
X-Google-Smtp-Source: AGHT+IFMNTNdPjePnXuCygilavrG9iD38x63egLaJP0teZCdkCmShd5zZHKCHM/nrHLF4Pgfxh6dkE4V4RVBQlcyXEo=
X-Received: by 2002:a5d:4b01:0:b0:35f:2067:2072 with SMTP id
 ffacd0b85a97d-367cead1e55mr3657924f8f.52.1720619199153; Wed, 10 Jul 2024
 06:46:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709105242.63299-1-flyingpeng@tencent.com>
 <20240709122737.GD6668@unreal> <20240709212608.GA1649561@thelio-3990X> <20240710060221.GH6668@unreal>
In-Reply-To: <20240710060221.GH6668@unreal>
From: Hao Peng <flyingpenghao@gmail.com>
Date: Wed, 10 Jul 2024 21:46:27 +0800
Message-ID: <CAPm50aLj5OsED5WeAnnv19d+JntNKC=WO8=FH7wy56dSccDb1w@mail.gmail.com>
Subject: Re: [PATCH] infiniband/hw/ocrdma: increase frame warning limit in
 verifier when using KASAN or KCSAN
To: Leon Romanovsky <leon@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, 
	Peng Hao <flyingpeng@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 2:02=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Tue, Jul 09, 2024 at 02:26:08PM -0700, Nathan Chancellor wrote:
> > On Tue, Jul 09, 2024 at 03:27:37PM +0300, Leon Romanovsky wrote:
> > > On Tue, Jul 09, 2024 at 06:52:42PM +0800, flyingpenghao@gmail.com wro=
te:
> > > > From: Peng Hao <flyingpeng@tencent.com>
> > > >
> > > > When building kernel with clang, which will typically
> > > > have sanitizers enabled, there is a warning about a large stack fra=
me.
> > > >
> > > > drivers/infiniband/hw/ocrdma/ocrdma_stats.c:686:16: error: stack fr=
ame size (20664) exceeds limit (8192) in 'ocrdma_dbgfs_ops_read' [-Werror,-=
Wframe-larger-than]
> > > > static ssize_t ocrdma_dbgfs_ops_read(struct file *filp, char __user=
 *buffer,
> > > >                ^
> > >
> > > Please fix it, not hide it.
> >
> > Agreed, this is far from an acceptable solution. No details were
> > provided around compiler, architecture, or configuration, so I can only
> > speculate what is happening here. From reading the code, I suspect that
> > ocrdma_add_stat() is getting inlined into all of its callsites but the
> > stack slot for buff[128] is not getting reused, which may be related to
> > a missing lifetime marker like [1] or sanitizer instrumentation.  I am
> > guessing that marking ocrdma_dbgfs_ops_read() as noinline_for_stack
> > would resolve this.
> >
KASAN is generally enabled for testing environments;
noinline_for_stack is used to solve the problem of needing to
 track deeper call chains. I also tried to use noinline_for_stack and
issued a new patch, but I think the v1 method is better.
My environment is:
x86_64, clang version 15.0.7
CONFIG_FRAME_WARN=3D8192
> > static noinline_for_stack int ocrdma_add_stat(char *start, char *pcur,
>
> This is a good solution, but first let's see if the author can provide
> more details.
>
> >
> > If this is not tolerable for all configurations, it could be made more
> > pointed with something like
> >
> > static
> > #if defined(CONFIG_CC_IS_CLANG) && (defined(CONFIG_KASAN) || defined(CO=
NFIG_KCSAN))
> > noinline_for_stack
> > #endif
> > int ocrdma_add_stat(char *start, char *pcur,
> >
> > but I am aware that is quite ugly.
> >
> > [1]: https://github.com/llvm/llvm-project/issues/38157#issuecomment-175=
6321571
> >
> > Cheers,
> > Nathan
> >
> > > > Increase the frame size by 20% to set.
> > > >
> > > > Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> > > > ---
> > > >  drivers/infiniband/hw/ocrdma/Makefile | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/drivers/infiniband/hw/ocrdma/Makefile b/drivers/infini=
band/hw/ocrdma/Makefile
> > > > index 14fba95021d8..a1e9fcc04751 100644
> > > > --- a/drivers/infiniband/hw/ocrdma/Makefile
> > > > +++ b/drivers/infiniband/hw/ocrdma/Makefile
> > > > @@ -3,4 +3,10 @@ ccflags-y :=3D -I $(srctree)/drivers/net/ethernet/=
emulex/benet
> > > >
> > > >  obj-$(CONFIG_INFINIBAND_OCRDMA)  +=3D ocrdma.o
> > > >
> > > > +ifneq ($(CONFIG_FRAME_WARN),0)
> > > > +ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)),y)
> > > > +CFLAGS_ocrdma_stats.o =3D -Wframe-larger-than=3D22664
> > > > +endif
> > > > +endif
> > > > +
> > > >  ocrdma-y :=3D      ocrdma_main.o ocrdma_verbs.o ocrdma_hw.o ocrdma=
_ah.o ocrdma_stats.o
> > > > --
> > > > 2.27.0
> > > >
> > > >

