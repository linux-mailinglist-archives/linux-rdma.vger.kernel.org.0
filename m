Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D18921ED7D
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2020 11:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgGNJ7d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jul 2020 05:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgGNJ7c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jul 2020 05:59:32 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1752DC061755
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 02:59:32 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id e4so13490157oib.1
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 02:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P8l6FryZA/keVvXZxlVWCIThf2OhcjulZofupovGm64=;
        b=JjXl30BetKudJTECMqXFHImpbHoIMJwSlaxINv3XDnK+9+Tr9N4ASZCG80YQJhQQYs
         T3mQ1QXsNczwOdwVusg9i/jHB3mHw1vkbHHqnTVRescmoWMv79nbDTyGZqLouvo7PVY5
         Ny7CdSKe4B5cGITJ2pqyXTuhrBe67YunCv/+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P8l6FryZA/keVvXZxlVWCIThf2OhcjulZofupovGm64=;
        b=MMvEZyBqfHckdK/iqt5TxfjYRYK28jcZIbYhylIm9z6q0v4q0eS4HYLrwA27wmAPj8
         3GKB61hNBneGldvZKV+0IUy+UKxDQXXsIJlYKMqLcmXZOD8wFcKkDPOK5HwdK98CUCGU
         4GbGxcKEk3yuAn7vhQHgOnDeuNchNtozWUMpcK/MRhfga0t8CYIQ3lR/E+X3X23IS1DJ
         OUcV75Z8nctlc9OccdaRwaXmwbZl6+YPuZK4Pfbm5tbsxphcMVSq6quvnqKvyOQQqVo5
         QwSvu0HexBg2Rop124w7C/txnF41s69tlKn9hqYEnwD2gNs1HK3DaZLfC5IERcjZ/CQE
         j2nQ==
X-Gm-Message-State: AOAM530+7V78lJAcXnpFcu+Jn/q/HkBxnSGCg6R+zfDEd2zV/5DgpHAd
        RPchu/J7S5A+k5XGRpWdU9Pk5sl2Ixp1I0ufs2lysA==
X-Google-Smtp-Source: ABdhPJxzz/S8lATGQ/0IMYNwtQjDlAlFcSobX9FbPzm4XdALVWpg/Y5C8vwjamXN8Z0EGUWFlRHk8Cbz+tDX12mNXeA=
X-Received: by 2002:aca:cc8e:: with SMTP id c136mr2959277oig.128.1594720771402;
 Tue, 14 Jul 2020 02:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
 <20200707201229.472834-5-daniel.vetter@ffwll.ch> <20200712222716.4rhvj7hryiecjthv@smtp.gmail.com>
 <20200714095717.njwk2u4tkgro54jn@smtp.gmail.com>
In-Reply-To: <20200714095717.njwk2u4tkgro54jn@smtp.gmail.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue, 14 Jul 2020 11:59:20 +0200
Message-ID: <CAKMK7uGu4N2oe04N=haUodmVCLi6HnqFDORkObx8EPUQrEJ+MQ@mail.gmail.com>
Subject: Re: [PATCH 04/25] drm/vkms: Annotate vblank timer
To:     Melissa Wen <melissa.srw@gmail.com>
Cc:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Trevor Woerner <twoerner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 14, 2020 at 11:57 AM Melissa Wen <melissa.srw@gmail.com> wrote:
>
> On 07/12, Rodrigo Siqueira wrote:
> > Hi,
> >
> > Everything looks fine to me, I just noticed that the amdgpu patches did
> > not apply smoothly, however it was trivial to fix the issues.
> >
> > Reviewed-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> >
> > Melissa,
> > Since you are using vkms regularly, could you test this patch and revie=
w
> > it? Remember to add your Tested-by when you finish.
> >
> Hi,
>
> I've applied the patch series, ran some tests on vkms, and found no
> issues. I mean, things have remained stable.
>
> Tested-by: Melissa Wen <melissa.srw@gmail.com>

Did you test with CONFIG_PROVE_LOCKING enabled in the kernel .config?
Without that enabled, there's not really any change here, but with
that enabled there might be some lockdep splats in dmesg indicating a
problem.

Thanks, Daniel
>
> > Thanks
> >
> > On 07/07, Daniel Vetter wrote:
> > > This is needed to signal the fences from page flips, annotate it
> > > accordingly. We need to annotate entire timer callback since if we ge=
t
> > > stuck anywhere in there, then the timer stops, and hence fences stop.
> > > Just annotating the top part that does the vblank handling isn't
> > > enough.
> > >
> > > Cc: linux-media@vger.kernel.org
> > > Cc: linaro-mm-sig@lists.linaro.org
> > > Cc: linux-rdma@vger.kernel.org
> > > Cc: amd-gfx@lists.freedesktop.org
> > > Cc: intel-gfx@lists.freedesktop.org
> > > Cc: Chris Wilson <chris@chris-wilson.co.uk>
> > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > > Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > > Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
> > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > ---
> > >  drivers/gpu/drm/vkms/vkms_crtc.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/=
vkms_crtc.c
> > > index ac85e17428f8..a53a40848a72 100644
> > > --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> > > +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> > > @@ -1,5 +1,7 @@
> > >  // SPDX-License-Identifier: GPL-2.0+
> > >
> > > +#include <linux/dma-fence.h>
> > > +
> > >  #include <drm/drm_atomic.h>
> > >  #include <drm/drm_atomic_helper.h>
> > >  #include <drm/drm_probe_helper.h>
> > > @@ -14,7 +16,9 @@ static enum hrtimer_restart vkms_vblank_simulate(st=
ruct hrtimer *timer)
> > >     struct drm_crtc *crtc =3D &output->crtc;
> > >     struct vkms_crtc_state *state;
> > >     u64 ret_overrun;
> > > -   bool ret;
> > > +   bool ret, fence_cookie;
> > > +
> > > +   fence_cookie =3D dma_fence_begin_signalling();
> > >
> > >     ret_overrun =3D hrtimer_forward_now(&output->vblank_hrtimer,
> > >                                       output->period_ns);
> > > @@ -49,6 +53,8 @@ static enum hrtimer_restart vkms_vblank_simulate(st=
ruct hrtimer *timer)
> > >                     DRM_DEBUG_DRIVER("Composer worker already queued\=
n");
> > >     }
> > >
> > > +   dma_fence_end_signalling(fence_cookie);
> > > +
> > >     return HRTIMER_RESTART;
> > >  }
> > >
> > > --
> > > 2.27.0
> > >
> >
> > --
> > Rodrigo Siqueira
> > https://siqueira.tech
>
>


--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
