Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7CB1D098A
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 09:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbgEMHIC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 03:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbgEMHIB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 13 May 2020 03:08:01 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8629C061A0C
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2020 00:07:59 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id z17so12634183oto.4
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2020 00:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U5dnCZ5YNvHzHQjGscrcpq9MiALGgU67N8Jq5EBQuzw=;
        b=OZiU+kRVCLk5/6W0St2OK5Xb+p5aH38bGDJXr1TsF9faLdtdBKQuGuJ7Zp5SiMdew7
         euECR2vCo6+/20wE4jAyKXi43lO8iX735T4hub/MDAh5jbFqtfScDmRenqpoSLVd8NNf
         g8jnREjHPAvO3tUS/62IwHmPFGNzojTApT+lE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U5dnCZ5YNvHzHQjGscrcpq9MiALGgU67N8Jq5EBQuzw=;
        b=V9mfcvFETfXJ4iihvUYhbr8twgD5n7FsuWT+dABbRibBTgZZcNh8YV2g4lLbnKQqu7
         s+BlHge8lVOzdW00BoxleeSqOXdIU3+Ywfld8tSXtXpHAIhDHdgleaMfPkiMn88z6sf/
         lwIRpTe9Crzq17urQRBn5l+2xWPHOfnDqvfvjpAyBYc1LPQPpdzxNzDOXq0CcErgl7pT
         vJIORYavjiAaDBMkLYk8h+kewHriyZgiWhEkQnqwwrjVeauf6HYsGcybMesUV7TgMU5l
         SPBhNDfPXPvBQszBO5CQ2Q8tDwT/gjwjcws3AmatyatGXo2bKuu1/Vlb64etKQD77wWR
         QpIg==
X-Gm-Message-State: AGi0PuYEuXcPtH6xEEBFH7GXQzke7AKngwsp4tTmw3+MGO21PBjTiwM8
        +VsMP3Y1bpSAOmaTJYRQn2TVY4BGJos0MkhQZChGCA==
X-Google-Smtp-Source: APiQypLDDUNEGNzAQQ9b8u81ZQsefjAzdi6bm0eh+UnIE80cVeBpyFUq2uSk3Y7c5QYPc5UTCXnFi072V/n20RqH3kg=
X-Received: by 2002:a9d:7c92:: with SMTP id q18mr20636927otn.281.1589353679188;
 Wed, 13 May 2020 00:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200512085944.222637-1-daniel.vetter@ffwll.ch>
 <20200512085944.222637-10-daniel.vetter@ffwll.ch> <6cfd324e-0443-3a12-6a2c-25a546c68643@gmail.com>
In-Reply-To: <6cfd324e-0443-3a12-6a2c-25a546c68643@gmail.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 13 May 2020 09:07:48 +0200
Message-ID: <CAKMK7uEwrf=CqswANbKzF1veFER5mHPHcQxR1avLXJROOGpUvg@mail.gmail.com>
Subject: Re: [RFC 09/17] drm/amdgpu: use dma-fence annotations in cs_submit()
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 13, 2020 at 9:02 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 12.05.20 um 10:59 schrieb Daniel Vetter:
> > This is a bit tricky, since ->notifier_lock is held while calling
> > dma_fence_wait we must ensure that also the read side (i.e.
> > dma_fence_begin_signalling) is on the same side. If we mix this up
> > lockdep complaints, and that's again why we want to have these
> > annotations.
> >
> > A nice side effect of this is that because of the fs_reclaim priming
> > for dma_fence_enable lockdep now automatically checks for us that
> > nothing in here allocates memory, without even running any userptr
> > workloads.
> >
> > Cc: linux-media@vger.kernel.org
> > Cc: linaro-mm-sig@lists.linaro.org
> > Cc: linux-rdma@vger.kernel.org
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: intel-gfx@lists.freedesktop.org
> > Cc: Chris Wilson <chris@chris-wilson.co.uk>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cs.c
> > index 7653f62b1b2d..6db3f3c629b0 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > @@ -1213,6 +1213,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_pars=
er *p,
> >       struct amdgpu_job *job;
> >       uint64_t seq;
> >       int r;
> > +     bool fence_cookie;
> >
> >       job =3D p->job;
> >       p->job =3D NULL;
> > @@ -1227,6 +1228,8 @@ static int amdgpu_cs_submit(struct amdgpu_cs_pars=
er *p,
> >        */
> >       mutex_lock(&p->adev->notifier_lock);
> >
> > +     fence_cookie =3D dma_fence_begin_signalling();
> > +
> >       /* If userptr are invalidated after amdgpu_cs_parser_bos(), retur=
n
> >        * -EAGAIN, drmIoctl in libdrm will restart the amdgpu_cs_ioctl.
> >        */
> > @@ -1264,12 +1267,14 @@ static int amdgpu_cs_submit(struct amdgpu_cs_pa=
rser *p,
> >       amdgpu_vm_move_to_lru_tail(p->adev, &fpriv->vm);
> >
> >       ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
> > +     dma_fence_end_signalling(fence_cookie);
>
> Mhm, this could come earlier in theory. E.g. after pushing the job to
> the scheduler.

Yeah, I have not much clue about how amdgpu works :-) In practice it
doesn't matter much, since the enclosing adev->notifier_lock is a lot
more strict about what it allows than the dma_fence signalling fake
lock.
-Daniel

>
> Christian.
>
> >       mutex_unlock(&p->adev->notifier_lock);
> >
> >       return 0;
> >
> >   error_abort:
> >       drm_sched_job_cleanup(&job->base);
> > +     dma_fence_end_signalling(fence_cookie);
> >       mutex_unlock(&p->adev->notifier_lock);
> >
> >   error_unlock:
>


--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
