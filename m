Return-Path: <linux-rdma+bounces-1036-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7E8858333
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Feb 2024 18:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C74FB23906
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Feb 2024 17:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8AB130E25;
	Fri, 16 Feb 2024 16:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9++NuFD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FC27E784;
	Fri, 16 Feb 2024 16:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708102796; cv=none; b=SJMASZeYbnSSnwZ5vhHmnv+koN84RvBF3E59cgPh9Xf3XLl+tkrWGYaLHjD/usYty51uX72AUtx2QTpkeroxk5+lHacgEpB4oJLmWApCrUWtrMI+gM5uv1L9ccCs5X2oMpiIJsvht9doTVrvCZKjjxJlGNQydE+sVasU71+/iJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708102796; c=relaxed/simple;
	bh=KOEhEuIqAZHLvjmDU556V+igmwDiKmcNj2F0X2Zgdqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZKIT7LIqxfpKANzOqLmd2XQQbNUKjfOinPvzxxJNfT4WZ0gX2ucueL35oivWrghy1OziQU6XUR+9DLaRA2fnXF5eQ6tS6g6FeOOUXOLuhCPPb6nOIhs8evISpF4/WSqvuDGDXz/4g+PtQIkgDHGdGV/LaWrO8K9jerUzMwxtzfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9++NuFD; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so965095a12.0;
        Fri, 16 Feb 2024 08:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708102794; x=1708707594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/x+pl6pSSD4011o2sxhi3tmE0ghNOP6YOH/ewDjwkTI=;
        b=D9++NuFDtfMqYh4CEU/fuANiuBz32fzjqZeV8ph2v7dtglwY1Irf4y406MbjkzWVGy
         CbIzERvUraIHYQWDwv73sndXOlMts+aBN72aksy1hTgkr3nG9GJ/WVf8neynUvpM+gx2
         XeZykbzhsc/1PgbH9fjahffYnur+il0bMLzAC7jnQKJb4DfZP/6QVSBzrjgSm4GjpeMe
         GADaVmHgoitPZ8qVwbpf0IwQjWG7abkT+RLaboBsgHK1VxiNuzoyWFY4gMNzP+i58MdC
         FPaeOZS7RcZQ1foRVaqvwafd1W+idUQwzai+ExiPjCc8HeccyGcfttVkjTWPU2iY5+mz
         9AYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708102794; x=1708707594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/x+pl6pSSD4011o2sxhi3tmE0ghNOP6YOH/ewDjwkTI=;
        b=Lq8XnWZITVq1f0m3fmZYfmavlvgTmb/+A1ybyUzEc4Xb/nMYrHW4y3sc1aoG1DHrKl
         FKCDHPDuvLUl/rOz7FgyztdpZqWU3m3UyrOipChSY7pa7ZOaX61OsOkuSsxOppSqiT5Y
         xa7PK+QrhPsSy1L+3ap1U0y8pBKxp4uxZiouj3bV0IuAGVI41K1L2e5sTmtcCU3mMHtl
         eVozLraj/3bKMqiM/o4hS/UD06bR9vqWkem4g3TX1SXNhgj1Fsoa3EzIHcfHo/N57arX
         dOXEkw/o9pLD9EmYZobfDP5W2mMH9t8g3e3muh1tzr0t/JGMqx6Tm/eNhOt/6ZcWh+lG
         /+4g==
X-Forwarded-Encrypted: i=1; AJvYcCWSuxDovrbgMt+bJA1MFmc6DEcWAA75YrwnbXF6my0sX8RkYdYS0ZvZdMVYXmOlypDdsFNSUN2/Broc1AF0iz4mnYqIiIzWCCslE2C2TQ9PjElwmJPEzA0Z+pVcrdBsU+D/QPE4PB3flg==
X-Gm-Message-State: AOJu0YwpgBXKKJ5Qs4qCS4XJ9Vp+/iieZnTX9izOSweSGDudbI/FYFad
	Lq93LL/WomnFbau3zr2RQqwps8JKt2ziLcvvJiX3FIPaPbIRHe3z9+bHQEd1/UaXOjJYiW3BML5
	8HhhYGpmlyRDoiqnDnGs4r7eRSLifcPLM
X-Google-Smtp-Source: AGHT+IFCDrkANKvivOACqcEya2zGfx4wIMBdPgjxD/0svYgSjKn3pI/eIrsX+aXebJhmfR73YSorrnNo7W7edSVRpl8=
X-Received: by 2002:a17:90b:1009:b0:297:1196:3716 with SMTP id
 gm9-20020a17090b100900b0029711963716mr5572994pjb.18.1708102794502; Fri, 16
 Feb 2024 08:59:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215133155.9198-1-ilpo.jarvinen@linux.intel.com>
 <20240215133155.9198-2-ilpo.jarvinen@linux.intel.com> <BL1PR12MB51440761895B3DF935840BF0F74D2@BL1PR12MB5144.namprd12.prod.outlook.com>
 <dd2da980-d114-e30e-fa91-79ff9ec353e7@linux.intel.com>
In-Reply-To: <dd2da980-d114-e30e-fa91-79ff9ec353e7@linux.intel.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 16 Feb 2024 11:59:42 -0500
Message-ID: <CADnq5_MCQX+vP9aGsYdKejQtPF=rgKqNauDwqCLa39Ug8Nd-zg@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/radeon: Use RMW accessors for changing LNKCTL2
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, 
	"Koenig, Christian" <Christian.Koenig@amd.com>, Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks.

Alex

On Fri, Feb 16, 2024 at 5:38=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Thu, 15 Feb 2024, Deucher, Alexander wrote:
>
> > [Public]
> >
> > > -----Original Message-----
> > > From: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > > Sent: Thursday, February 15, 2024 8:32 AM
> > > To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> > > gfx@lists.freedesktop.org; Daniel Vetter <daniel@ffwll.ch>; David Air=
lie
> > > <airlied@gmail.com>; Dennis Dalessandro
> > > <dennis.dalessandro@cornelisnetworks.com>; dri-
> > > devel@lists.freedesktop.org; Jason Gunthorpe <jgg@ziepe.ca>; Leon
> > > Romanovsky <leon@kernel.org>; linux-kernel@vger.kernel.org; linux-
> > > rdma@vger.kernel.org; Pan, Xinhui <Xinhui.Pan@amd.com>; Koenig, Chris=
tian
> > > <Christian.Koenig@amd.com>
> > > Cc: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>; Lukas Wunner
> > > <lukas@wunner.de>
> > > Subject: [PATCH 1/3] drm/radeon: Use RMW accessors for changing LNKCT=
L2
> > >
> > > Convert open coded RMW accesses for LNKCTL2 to use
> > > pcie_capability_clear_and_set_word() which makes its easier to unders=
tand
> > > what the code tries to do.
> > >
> > > LNKCTL2 is not really owned by any driver because it is a collection =
of control
> > > bits that PCI core might need to touch. RMW accessors already have su=
pport
> > > for proper locking for a selected set of registers
> > > (LNKCTL2 is not yet among them but likely will be in the future) to a=
void losing
> > > concurrent updates.
> > >
> > > Suggested-by: Lukas Wunner <lukas@wunner.de>
> > > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> >
> > The radeon and amdgpu patches are:
> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > Are you looking for me to pick them up or do you want to land them as
> > part of some larger change?  Either way is fine with me.
>
> Hi,
>
> You please take them, I intentionally took them apart from the BW
> controller series so they can go through the usual trees, not along with
> the BW controller. (I don't expect the BW controller to be accepted durin=
g
> this cycle).
>
> --
>  i.

