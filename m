Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2904220E77
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2020 15:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731942AbgGONwA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jul 2020 09:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729086AbgGONwA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jul 2020 09:52:00 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2139EC061755
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2020 06:52:00 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id p26so472254oos.7
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2020 06:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MqsOl2rYB/7u7Gut1iGuVJHU6JubtHB+/cs3tCH619k=;
        b=IKgfCkkoCpyGSci4cTPs6WgN6drUjM+E3fQd+RPREwzfcvyoI/L2/DSylDaZWzbbuB
         ZgDTW9XW77MQfdfYrmTKY8Ba+zSSqU0LXVTiQfGjJQ1YBrXbynYX7OwZI6lTTmBPBmKW
         2LvOJErq6bacSh3G/oxiPt9fWxpefW9zWQzeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MqsOl2rYB/7u7Gut1iGuVJHU6JubtHB+/cs3tCH619k=;
        b=lUXlxif07/kQN3HUeIgqj1765uoLALV8ALu6ejPNqLZH8AU9rD9X79XglM645P1omY
         ffvNkrfWJn8SRfh17tAFJf4ds5Lgg3Jx1fFc3kOGEN7f+0Qau1+i221lc0cPpy0pCpcI
         ObmIc8Pd+2a4sQLedZEYAJowKa81JNJa5i2W4zdid+JpghHExYO22a5COk16pXUs+diG
         eU8oq+oxOcrNVRO9cmYAAvVND4JaSAlmW3GiTFcFW4nx8dGpQM3IHf3F+Z/C5AzDstMp
         3jyvBQoeitTCC+N/O9CmH76yIi+mYP759veT2wWPX70IBZP4I2OhWCw5jFXJd0pJlj5y
         MOBQ==
X-Gm-Message-State: AOAM530jlQK/JY4vsR2/dIKEPPSqiGzw5XLKeXiJBkckS4KIDPIPsLiZ
        ufW00ubXi30k192neam5FX3sdPGRoVl1g5FDjsaokg==
X-Google-Smtp-Source: ABdhPJwb4NJPJ8t5WoT1YhrXoIhXNQ8S5ZrdL1024UrQe8WZqMBqKIOTr7Bpj9gabyh7CPZGKTyh2I4hoATPLTHtUTk=
X-Received: by 2002:a4a:bb8a:: with SMTP id h10mr9338522oop.28.1594821119474;
 Wed, 15 Jul 2020 06:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
 <20200707201229.472834-9-daniel.vetter@ffwll.ch> <20200715125347.GT159988@e110455-lin.cambridge.arm.com>
In-Reply-To: <20200715125347.GT159988@e110455-lin.cambridge.arm.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 15 Jul 2020 15:51:48 +0200
Message-ID: <CAKMK7uHt=eUP+FQpET8j8bVsmL3FqEBVcWPQSk6R27SMqpuV+w@mail.gmail.com>
Subject: Re: [PATCH 08/25] drm/malidp: Annotate dma-fence critical section in
 commit path
To:     Liviu Dudau <liviu.dudau@arm.com>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        "James (Qian) Wang" <james.qian.wang@arm.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 15, 2020 at 2:53 PM Liviu Dudau <liviu.dudau@arm.com> wrote:
>
> On Tue, Jul 07, 2020 at 10:12:12PM +0200, Daniel Vetter wrote:
> > Again needs to be put right after the call to
> > drm_atomic_helper_commit_hw_done(), since that's the last thing which
> > can hold up a subsequent atomic commit.
> >
> > No surprises here.
>
> I was (still am) hoping to do a testing for this patch but when I dug out=
 the series
> from the ML it looked like it has extra dependencies, so I was waiting fo=
r the dust
> to settle.
>
> Otherwise, LGTM.

I should all just apply I think, it's based on drm-tip. Branch with
bunch of other random stuff is here:

https://cgit.freedesktop.org/~danvet/drm/log/

If that doesn't cherry-pick cleanly I'm confused about something.
-Daniel

>
> Best regards,
> Liviu
>
> >
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: "James (Qian) Wang" <james.qian.wang@arm.com>
> > Cc: Liviu Dudau <liviu.dudau@arm.com>
> > Cc: Mihail Atanassov <mihail.atanassov@arm.com>
> > ---
> >  drivers/gpu/drm/arm/malidp_drv.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/mal=
idp_drv.c
> > index 69fee05c256c..26e60401a8e1 100644
> > --- a/drivers/gpu/drm/arm/malidp_drv.c
> > +++ b/drivers/gpu/drm/arm/malidp_drv.c
> > @@ -234,6 +234,7 @@ static void malidp_atomic_commit_tail(struct drm_at=
omic_state *state)
> >       struct drm_crtc *crtc;
> >       struct drm_crtc_state *old_crtc_state;
> >       int i;
> > +     bool fence_cookie =3D dma_fence_begin_signalling();
> >
> >       pm_runtime_get_sync(drm->dev);
> >
> > @@ -260,6 +261,8 @@ static void malidp_atomic_commit_tail(struct drm_at=
omic_state *state)
> >
> >       malidp_atomic_commit_hw_done(state);
> >
> > +     dma_fence_end_signalling(fence_cookie);
> > +
> >       pm_runtime_put(drm->dev);
> >
> >       drm_atomic_helper_cleanup_planes(drm, state);
> > --
> > 2.27.0
> >
>
> --
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     =C2=AF\_(=E3=83=84)_/=C2=AF



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
