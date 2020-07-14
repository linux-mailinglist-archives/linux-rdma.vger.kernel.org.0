Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA37A21F610
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2020 17:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgGNPXO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jul 2020 11:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgGNPXO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jul 2020 11:23:14 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B07C061794
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 08:23:14 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 72so13309587otc.3
        for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2020 08:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cXIgj0iYr7P3K9BwnPZPhJf3MwNMTpVJeBZlv87Bh4I=;
        b=VLIaWTKC4PHL8JWLjq42ZsT9mY+u4qL1p7WxjpgKEl5De7mvV/iKccmYz4fTy5W0bX
         uwD6ShgNVxz/NJqIxDCK1jZ0AkTPAFmrweTkVH7sJq9pe+Uyk13OIivD+V7ejv2npjny
         COM+I7P0E87QnLBZ2ERPa5kKwcC4/ZCLIIjxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cXIgj0iYr7P3K9BwnPZPhJf3MwNMTpVJeBZlv87Bh4I=;
        b=IRPZvZ3OpgsekCU0tdEz1GR5y08LeBxAs62mQwkRl6xf4j0FwN22eGBLvq7WUVlyyb
         V4vUBkbV2/VOlL68JSh/piPeyhzjr7f6qMg3QhIo6tEEqFn5lv5s/+FZik3Kd50kNuc2
         pce7kp/Q7zFfXZ/w9u/eHbgulEnE4VMAwpzAYiqi3y4SL1hRNThjh8dTY4niIHJO7DnM
         eWU8iQPpQgY1FZ6ixQMmvGDjkjRttoBR1EGIXDKkWfQXAR81PYQV+KHumWG95psIMVeK
         uQgYq3wnqAgt8re0YQ2XKjG1/811CKOmGP6AnIBzFiPQZlPfEBns4meowTnLbI4IJfeT
         p3pA==
X-Gm-Message-State: AOAM533wId7kkTvAKa5uxrgBUIh/x8v8nawOr6JD/isz+IJzSYlDybQ1
        bq5JxiHAgWF+AU49/m9fr5p8fZEjfPks7Z2oJjiwbA==
X-Google-Smtp-Source: ABdhPJzMWKFMzStVCDzj6VA6xehwdIqELDcKSwQ56B351nM2OHgHnA5N7zQOfA0uHd0eJVAYd4Qstl3xeb/ssJHcYdM=
X-Received: by 2002:a9d:d55:: with SMTP id 79mr4759005oti.281.1594740193436;
 Tue, 14 Jul 2020 08:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
 <20200707201229.472834-5-daniel.vetter@ffwll.ch> <20200712222716.4rhvj7hryiecjthv@smtp.gmail.com>
 <20200714095717.njwk2u4tkgro54jn@smtp.gmail.com> <CAKMK7uGu4N2oe04N=haUodmVCLi6HnqFDORkObx8EPUQrEJ+MQ@mail.gmail.com>
 <20200714145553.zetjvbewixnf2rla@smtp.gmail.com>
In-Reply-To: <20200714145553.zetjvbewixnf2rla@smtp.gmail.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue, 14 Jul 2020 17:23:02 +0200
Message-ID: <CAKMK7uEyu8A3or00J+fBhf5sHhhq5Xz7X9Y=2AMajEPSaNB+-g@mail.gmail.com>
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

On Tue, Jul 14, 2020 at 4:56 PM Melissa Wen <melissa.srw@gmail.com> wrote:
>
> Hi,
>
> On 07/14, Daniel Vetter wrote:
> > On Tue, Jul 14, 2020 at 11:57 AM Melissa Wen <melissa.srw@gmail.com> wr=
ote:
> > >
> > > On 07/12, Rodrigo Siqueira wrote:
> > > > Hi,
> > > >
> > > > Everything looks fine to me, I just noticed that the amdgpu patches=
 did
> > > > not apply smoothly, however it was trivial to fix the issues.
> > > >
> > > > Reviewed-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > > >
> > > > Melissa,
> > > > Since you are using vkms regularly, could you test this patch and r=
eview
> > > > it? Remember to add your Tested-by when you finish.
> > > >
> > > Hi,
> > >
> > > I've applied the patch series, ran some tests on vkms, and found no
> > > issues. I mean, things have remained stable.
> > >
> > > Tested-by: Melissa Wen <melissa.srw@gmail.com>
> >
> > Did you test with CONFIG_PROVE_LOCKING enabled in the kernel .config?
> > Without that enabled, there's not really any change here, but with
> > that enabled there might be some lockdep splats in dmesg indicating a
> > problem.
> >
>
> Even with the lock debugging config enabled, no new issue arose in dmesg
> during my tests using vkms.

Excellent, thanks a lot for confirming this.
-Daniel

>
> Melissa
>
> > Thanks, Daniel
> > >
> > > > Thanks
> > > >
> > > > On 07/07, Daniel Vetter wrote:
> > > > > This is needed to signal the fences from page flips, annotate it
> > > > > accordingly. We need to annotate entire timer callback since if w=
e get
> > > > > stuck anywhere in there, then the timer stops, and hence fences s=
top.
> > > > > Just annotating the top part that does the vblank handling isn't
> > > > > enough.
> > > > >
> > > > > Cc: linux-media@vger.kernel.org
> > > > > Cc: linaro-mm-sig@lists.linaro.org
> > > > > Cc: linux-rdma@vger.kernel.org
> > > > > Cc: amd-gfx@lists.freedesktop.org
> > > > > Cc: intel-gfx@lists.freedesktop.org
> > > > > Cc: Chris Wilson <chris@chris-wilson.co.uk>
> > > > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > > > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > > > > Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > > > > Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
> > > > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > > > ---
> > > > >  drivers/gpu/drm/vkms/vkms_crtc.c | 8 +++++++-
> > > > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/v=
kms/vkms_crtc.c
> > > > > index ac85e17428f8..a53a40848a72 100644
> > > > > --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> > > > > +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> > > > > @@ -1,5 +1,7 @@
> > > > >  // SPDX-License-Identifier: GPL-2.0+
> > > > >
> > > > > +#include <linux/dma-fence.h>
> > > > > +
> > > > >  #include <drm/drm_atomic.h>
> > > > >  #include <drm/drm_atomic_helper.h>
> > > > >  #include <drm/drm_probe_helper.h>
> > > > > @@ -14,7 +16,9 @@ static enum hrtimer_restart vkms_vblank_simulat=
e(struct hrtimer *timer)
> > > > >     struct drm_crtc *crtc =3D &output->crtc;
> > > > >     struct vkms_crtc_state *state;
> > > > >     u64 ret_overrun;
> > > > > -   bool ret;
> > > > > +   bool ret, fence_cookie;
> > > > > +
> > > > > +   fence_cookie =3D dma_fence_begin_signalling();
> > > > >
> > > > >     ret_overrun =3D hrtimer_forward_now(&output->vblank_hrtimer,
> > > > >                                       output->period_ns);
> > > > > @@ -49,6 +53,8 @@ static enum hrtimer_restart vkms_vblank_simulat=
e(struct hrtimer *timer)
> > > > >                     DRM_DEBUG_DRIVER("Composer worker already que=
ued\n");
> > > > >     }
> > > > >
> > > > > +   dma_fence_end_signalling(fence_cookie);
> > > > > +
> > > > >     return HRTIMER_RESTART;
> > > > >  }
> > > > >
> > > > > --
> > > > > 2.27.0
> > > > >
> > > >
> > > > --
> > > > Rodrigo Siqueira
> > > > https://siqueira.tech
> > >
> > >
> >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
