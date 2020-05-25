Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1D81E11C4
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 17:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404174AbgEYPbM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 11:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404147AbgEYPbM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 May 2020 11:31:12 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C399FC08C5C0
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 08:31:10 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id d7so14053411ote.6
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 08:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bAUJzoc7IqUjSn+yo0peq2R8rxLuXszL8v1+SHoHNg4=;
        b=Tr5Is/tFfhBcNvoJFDbRu5Ln8A76+CnG+YDW2gJrWDvyNGkCXJ7tLlLksMoNneiC/G
         JQcpPGhoKYZL1sU8qtPMsxurg5u2WpN3lkX8GcIcMGy67IE5X9Z/KXbl7mWg/wzgEVa5
         0YNI55NOQ1RqN/Ren3NRDgb8W+ScMuN+eyqoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bAUJzoc7IqUjSn+yo0peq2R8rxLuXszL8v1+SHoHNg4=;
        b=MR1wCv/3jSit1ZExVFGlHyYqlMcNUnvSfSMpoO6PVreuzc8GbuPuMCh1I1NvDFzN73
         ayJEKxTDip80yTtXRKp2kCD8orCR34WdqRpnZFNPWPGbyYNuAkRgV9J/2GGwc7STKu7N
         rgAe8RMsO0UJGf+wtUvLmNK/cU9OZWc6WDtnesjAmDizg4F5hpspIyRUyiRIu7/xUyvY
         skX62jeU90x8WQW9nMNPWGmNBrlFLFdcZjGP2xPKALBgqYvAQM2V4JmRF3ChNlXudbgX
         XWkV+xGKSVy4pSUT0q0GKUsju8lqRJnhK9EvNd8jk1mhgasynOrdRp1P6sexRPmiOyZM
         TNhw==
X-Gm-Message-State: AOAM531NPdycjGzU2m5itrRQvtZjld4zyKbCbfiR8et74Ehe9rserQ5B
        D2ZN8mA8Hj9CNVCkSCAJVgLg40/JAhtQLFCSIha60Q==
X-Google-Smtp-Source: ABdhPJzkcrR3yAMwEAELXE9cys4iQedV/n7q7FwrzlUwqN0x19DN2aghlSLeBpaRXuxxoHbrXZYQHIFlGr+0T8f9mVM=
X-Received: by 2002:a9d:768a:: with SMTP id j10mr5068453otl.188.1590420670094;
 Mon, 25 May 2020 08:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200512085944.222637-1-daniel.vetter@ffwll.ch> <20200512085944.222637-9-daniel.vetter@ffwll.ch>
In-Reply-To: <20200512085944.222637-9-daniel.vetter@ffwll.ch>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Mon, 25 May 2020 17:30:59 +0200
Message-ID: <CAKMK7uHXjFcVZuV-gF-mGYZVG8CbosoxWKN5MKV+rBXwEr3JZw@mail.gmail.com>
Subject: Re: [RFC 08/17] drm/scheduler: use dma-fence annotations in main thread
To:     DRI Development <dri-devel@lists.freedesktop.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Qiang Yu <yuq825@gmail.com>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <Steven.Price@arm.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        "Anholt, Eric" <eric@anholt.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 12, 2020 at 11:00 AM Daniel Vetter <daniel.vetter@ffwll.ch> wro=
te:
>
> If the scheduler rt thread gets stuck on a mutex that we're holding
> while waiting for gpu workloads to complete, we have a problem.
>
> Add dma-fence annotations so that lockdep can check this for us.
>
> I've tried to quite carefully review this, and I think it's at the
> right spot. But obviosly no expert on drm scheduler.
>
> Cc: linux-media@vger.kernel.org
> Cc: linaro-mm-sig@lists.linaro.org
> Cc: linux-rdma@vger.kernel.org
> Cc: amd-gfx@lists.freedesktop.org
> Cc: intel-gfx@lists.freedesktop.org
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Adding a bunch more people from drivers using the drm/scheduler (so
that's maintainers for etnaviv, lima, panfrost, and v3d on top of
amdgpu folks arlready on cc). Any takes or testing on this and well
the entire series very much appreciated, there's also another patch to
anotate the tdr work in this series. Plus ofc the prep work.

Thanks, Daniel

> ---
>  drivers/gpu/drm/scheduler/sched_main.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sch=
eduler/sched_main.c
> index 2f319102ae9f..06a736e506ad 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -763,9 +763,12 @@ static int drm_sched_main(void *param)
>         struct sched_param sparam =3D {.sched_priority =3D 1};
>         struct drm_gpu_scheduler *sched =3D (struct drm_gpu_scheduler *)p=
aram;
>         int r;
> +       bool fence_cookie;
>
>         sched_setscheduler(current, SCHED_FIFO, &sparam);
>
> +       fence_cookie =3D dma_fence_begin_signalling();
> +
>         while (!kthread_should_stop()) {
>                 struct drm_sched_entity *entity =3D NULL;
>                 struct drm_sched_fence *s_fence;
> @@ -823,6 +826,9 @@ static int drm_sched_main(void *param)
>
>                 wake_up(&sched->job_scheduled);
>         }
> +
> +       dma_fence_end_signalling(fence_cookie);
> +
>         return 0;
>  }
>
> --
> 2.26.2
>


--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
