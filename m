Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4486A61FB3F
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Nov 2022 18:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiKGR0K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Nov 2022 12:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbiKGR0H (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Nov 2022 12:26:07 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EF921240
        for <linux-rdma@vger.kernel.org>; Mon,  7 Nov 2022 09:26:02 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id x16so6202927ilm.5
        for <linux-rdma@vger.kernel.org>; Mon, 07 Nov 2022 09:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k05Y4e+PrHzSfY5WD7UasfT68aLf+beRaOmVJAx50IE=;
        b=aigTDkQoIrZ5du6qge/d6nU8XEtnOQxQGbL3jhraCwqwWSZTnNbLNTpEqxU68U6tqz
         dT7IR3PAOIU4mgnAoPDn37z3q9yYgeFFX+uYApeVR69MSmpm3kFyqRjh7+MlJpUiBvhf
         qt3+8nXCBsc8ZVaoQNdO/n7ydEFoq3KzLvkRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k05Y4e+PrHzSfY5WD7UasfT68aLf+beRaOmVJAx50IE=;
        b=TNkb+fo4uTirxkHbnPYpC4AmUsaZGhg/SyWROOhZnwcw18NrVeWU/IamUu6fqCS/YL
         kEcyugKRZkO+UHRrt1hSJUgOpAEKi4KDVqKEWctFs9ECgWwoXV9Giyu+XGZxx6YEE3aU
         chvzXeYE9gGwk9NuQea6jwnLNBSMlO5WMq6XaUGfKJ9eI+hGQ8Kfk39cZLJwFGnMuF7Q
         y28tw2hDRPenH7pY4R6xxmjC5ylV4u2TuH3JsUTEEgSHSfiop4zZpiFslbWGWMsTyM8j
         mGYn/GCuW8x1wAs57ROfQzjQlLOcWEhAXY+pvZ6YsRyiJT9lfZl86hz0lpj234JQ608V
         umEA==
X-Gm-Message-State: ACrzQf3AmZS7YQF0nm96DLsjO6VAyd8yTiAcdLN0GQRAzK/ESeuOtrDh
        Ap83ZvSBRKlXy41E/AmpwvpHhvqiAPLkmEWyCZggWQ==
X-Google-Smtp-Source: AMsMyM7TUXJXcis8PmcF9tz+mPP8pp0mnUv/KZmZclnSef+BAXAmZIP+VqDuAGl+a0+0RYzgd/QOqiORrMVMDd6y2JE=
X-Received: by 2002:a92:d681:0:b0:2ff:573c:8d44 with SMTP id
 p1-20020a92d681000000b002ff573c8d44mr29932067iln.203.1667841961903; Mon, 07
 Nov 2022 09:26:01 -0800 (PST)
MIME-Version: 1.0
References: <20221017172229.42269-1-dmitry.osipenko@collabora.com> <20221017172229.42269-19-dmitry.osipenko@collabora.com>
In-Reply-To: <20221017172229.42269-19-dmitry.osipenko@collabora.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 7 Nov 2022 18:25:50 +0100
Message-ID: <CAKMK7uFFwTfNYT2BrubYvUMrH4fEmtF=yJshUck3-gKYLGqxCg@mail.gmail.com>
Subject: Re: [PATCH v7 18/21] dma-buf: Move dma_buf_mmap() to dynamic locking specification
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Clark <robdclark@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
        Qiang Yu <yuq825@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Tomi Valkeinen <tomba@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Ruhl Michael J <michael.j.ruhl@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org,
        linux-rdma@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, 17 Oct 2022 at 19:25, Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Move dma_buf_mmap() function to the dynamic locking specification by
> taking the reservation lock. Neither of the today's drivers take the
> reservation lock within the mmap() callback, hence it's safe to enforce
> the locking.
>
> Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Just noticed this while reading code ... this patch seems to have
missed dma_buf_mmap_internal()?

Might be good if at least some drivers gain a dma_resv_assert_held in
that path to make sure we're not quite this bad, together with fixing
this issue.
-Daniel

> ---
>  drivers/dma-buf/dma-buf.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index f54c649f922a..f149b384f4dd 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -1390,6 +1390,8 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_end_cpu_access, DMA_BU=
F);
>  int dma_buf_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma,
>                  unsigned long pgoff)
>  {
> +       int ret;
> +
>         if (WARN_ON(!dmabuf || !vma))
>                 return -EINVAL;
>
> @@ -1410,7 +1412,11 @@ int dma_buf_mmap(struct dma_buf *dmabuf, struct vm=
_area_struct *vma,
>         vma_set_file(vma, dmabuf->file);
>         vma->vm_pgoff =3D pgoff;
>
> -       return dmabuf->ops->mmap(dmabuf, vma);
> +       dma_resv_lock(dmabuf->resv, NULL);
> +       ret =3D dmabuf->ops->mmap(dmabuf, vma);
> +       dma_resv_unlock(dmabuf->resv);
> +
> +       return ret;
>  }
>  EXPORT_SYMBOL_NS_GPL(dma_buf_mmap, DMA_BUF);
>
> --
> 2.37.3
>


--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
