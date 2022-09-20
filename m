Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3389C5BE864
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Sep 2022 16:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbiITOQi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Sep 2022 10:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiITOQT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Sep 2022 10:16:19 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB9230F44
        for <linux-rdma@vger.kernel.org>; Tue, 20 Sep 2022 07:14:02 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id e81so3515500ybb.13
        for <linux-rdma@vger.kernel.org>; Tue, 20 Sep 2022 07:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=A5SHHtL7QW2l54muzkKKvK4LNnKVv9lnQOHGxIBuRuE=;
        b=I0YUoX79VzdB1su5c8YsyhJqRmH5BNT4YqtIql7uMHjv4tNfOgHifd92qluReG4d/X
         i+jYW3HyitXzOX4IonS8R0ZONlFkR1k7gzgwSfoZiyoaclz0ttvaXwLoZb7ZtxANBu5Y
         3z526ei+ptSUlr9B43I+BPqd8EpQylJ4cBJQM2NB3es8UnHI+rMDDmASlishpV745ZiR
         FmF+Tn/kij0Q3tHjPuP7PPUW7rGa0WojF+SdtI5DCR6jLM2zwity5aoAXKaUhJv2tGwk
         A1NAE6VKh7Q2gKgry+vltVNnOPdcodRj2m1ez7wQy3SuDN63Pt0F5Dl77GROsIrV6LU3
         c7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=A5SHHtL7QW2l54muzkKKvK4LNnKVv9lnQOHGxIBuRuE=;
        b=S7x5P1WN4XwR8jpe+QPwNK2t8tJtTVZEBFcvyz9/h0H8trfCd6KtWvD23auLX64Dht
         7o4UscAFIZVED6pqYWg5ulF/cx1PAj/s0WN7So3AUsADzsCYrStw3q94JwXsTKOWyAGw
         SNxvziluZ95pXyHBxVmDxuXp+moT6pQ9w4WauXDX0F85hE8O+/r7JRw8YN8lz+gKNbRk
         86AQqotbJFlPN3km/1FGuVazMDbw4Sfs4NJzkOBbU177i4zIcR9akoqcboso+wJ1H9iR
         Tvk3jWCnEA8Ba5fonhe9ZBknV1XoyrcFroRz4rETx14KdeZkbUhiQf9U+tMg6hjyYdip
         6H+w==
X-Gm-Message-State: ACrzQf3+kDiP9/LOIge5z26jpPp1xivZm/ZHiewIxPeXJMVr/9JesKn+
        H03FXgQjfiekUYqo5VBgtdt5yeQPftYQhgSm4/5IYw==
X-Google-Smtp-Source: AMsMyM5ptp/xJcYbBs/zLcmhTWf9yaT5sYYL81f6HBIkVW4YVsWA9kHYXFc60Kp909nkSHb5MmXRrVuHNeF6LJJFSRY=
X-Received: by 2002:a25:af52:0:b0:6b3:de78:452a with SMTP id
 c18-20020a25af52000000b006b3de78452amr10092889ybj.157.1663683242012; Tue, 20
 Sep 2022 07:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220913192757.37727-1-dmitry.osipenko@collabora.com> <20220913192757.37727-16-dmitry.osipenko@collabora.com>
In-Reply-To: <20220913192757.37727-16-dmitry.osipenko@collabora.com>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Tue, 20 Sep 2022 19:43:49 +0530
Message-ID: <CAO_48GFtLjR657nO+yh9KwsrWbNmGVsf7srHj19biO+NauYt4w@mail.gmail.com>
Subject: Re: [PATCH v5 15/21] dma-buf: Move dma_buf_vmap() to dynamic locking specification
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Gert Wollny <gert.wollny@collabora.com>,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Clark <robdclark@gmail.com>,
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Dmitry,

Thanks very much for the series.

On Wed, 14 Sept 2022 at 00:59, Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Move dma_buf_vmap/vunmap_unlocked() functions to the dynamic locking
> specification by asserting that the reservation lock is held.
Thanks for the patch; just a minor nit - I think you mean dma_buf_vmap
/ vunmap() here, and not _unlocked?

Best,
Sumit.


>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/dma-buf/dma-buf.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 50db7571dc4b..80fd6ccc88c6 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -1450,6 +1450,8 @@ int dma_buf_vmap(struct dma_buf *dmabuf, struct ios=
ys_map *map)
>         if (WARN_ON(!dmabuf))
>                 return -EINVAL;
>
> +       dma_resv_assert_held(dmabuf->resv);
> +
>         if (!dmabuf->ops->vmap)
>                 return -EINVAL;
>
> @@ -1510,6 +1512,8 @@ void dma_buf_vunmap(struct dma_buf *dmabuf, struct =
iosys_map *map)
>         if (WARN_ON(!dmabuf))
>                 return;
>
> +       dma_resv_assert_held(dmabuf->resv);
> +
>         BUG_ON(iosys_map_is_null(&dmabuf->vmap_ptr));
>         BUG_ON(dmabuf->vmapping_counter =3D=3D 0);
>         BUG_ON(!iosys_map_is_equal(&dmabuf->vmap_ptr, map));
> --
> 2.37.3
>


--
Thanks and regards,

Sumit Semwal (he / him)
Tech Lead - LCG, Vertical Technologies
Linaro.org =E2=94=82 Open source software for ARM SoCs
