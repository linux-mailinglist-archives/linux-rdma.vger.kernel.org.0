Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4BD43F0097
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Aug 2021 11:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbhHRJfu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Aug 2021 05:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234104AbhHRJfo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Aug 2021 05:35:44 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A68C0617A8
        for <linux-rdma@vger.kernel.org>; Wed, 18 Aug 2021 02:35:03 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id r38-20020a05683044a600b0051a2c6dd421so2447490otv.3
        for <linux-rdma@vger.kernel.org>; Wed, 18 Aug 2021 02:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Xyn/PM5YP2/IFB7tHgsnFcmbLe6blpVJ1aozmlu1ow=;
        b=gykCm02M32GyZzKN1jfPZSs6ksGKG8l2HXfkmk5eKcJSlW5ZG7T0cBaM6blIbOzxSm
         mE6oC/HNp/hdxXahUd3yM8+s//fCqPmr2cM/b4lDVrkeFWGFD5OhwWzexvIvVZrYSA/o
         5RvVMnMJ/nxikIQRWfFHgxPgKIrsz/pQyKHKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Xyn/PM5YP2/IFB7tHgsnFcmbLe6blpVJ1aozmlu1ow=;
        b=dPwtbVQq1Qzu8Fp4QKDl+jNZ6oytilfmPQNM32yyno7jw33QL/kuY4dTcSksNSJyVa
         1WhwKdwN3ns6Hm56kaxiH3CAENrrdhj+uww9K3V+MRZ16tBUJR/B5urHMXG1lK1uw+q3
         NjfsAhAcL9xj8b05npx/NmmNSMjArH7Ezoddf4gq4fCdCDnAjDfJfgxHROTbrLL6tOYi
         vepA97S0LehYDudSFrHgi6ivmHX163scUp0+xCs+wqrJh+2egI81qDb+Rq3OQpAHfBf1
         djHaTdKH5Bbu+WKWOnzZxYAKoTzuL/9tX1ImIyU+AX5cCklzPLv5iGLt5FxDPt27m/od
         7vbg==
X-Gm-Message-State: AOAM532MwG4VnUPdD15ZwCoSjL4aPdfcnYAVqV+5y0i1N2J0ooXOkHRm
        x6IsXCwWW6pq/Lxb3k+mfBnMy5VDh2m3GIdnT9riRg==
X-Google-Smtp-Source: ABdhPJzzKnNN6vTQEqveeY3cTCAGgV7gRJVSFEJ7nlgeJN7LO2mJNz++CF+lAxXxgRgj3f7Ugw8Xdn5CgD7rk7Hez/s=
X-Received: by 2002:a9d:65da:: with SMTP id z26mr6101976oth.303.1629279302395;
 Wed, 18 Aug 2021 02:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210818074352.29950-1-galpress@amazon.com>
In-Reply-To: <20210818074352.29950-1-galpress@amazon.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 18 Aug 2021 11:34:51 +0200
Message-ID: <CAKMK7uGZ_eX+XfYJU6EkKEOVrHz3q6QMxaEbyyD3_1iqj9YSjw@mail.gmail.com>
Subject: Re: [RFC] Make use of non-dynamic dmabuf in RDMA
To:     Gal Pressman <galpress@amazon.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Oded Gabbay <ogabbay@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>,
        Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jianxin Xiong <jianxin.xiong@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 18, 2021 at 9:45 AM Gal Pressman <galpress@amazon.com> wrote:
>
> Hey all,
>
> Currently, the RDMA subsystem can only work with dynamic dmabuf
> attachments, which requires the RDMA device to support on-demand-paging
> (ODP) which is not common on most devices (only supported by mlx5).
>
> While the dynamic requirement makes sense for certain GPUs, some devices
> (such as habanalabs) have device memory that is always "pinned" and do
> not need/use the move_notify operation.
>
> The motivation of this RFC is to use habanalabs as the dmabuf exporter,
> and EFA as the importer to allow for peer2peer access through libibverbs.
>
> This draft patch changes the dmabuf driver to differentiate between
> static/dynamic attachments by looking at the move_notify op instead of
> the importer_ops struct, and allowing the peer2peer flag to be enabled
> in case of a static exporter.
>
> Thanks
>
> Signed-off-by: Gal Pressman <galpress@amazon.com>

Given that habanalabs dma-buf support is very firmly in limbo (at
least it's not yet in linux-next or anywhere else) I think you want to
solve that problem first before we tackle the additional issue of
making p2p work without dynamic dma-buf. Without that it just doesn't
make a lot of sense really to talk about solutions here.
-Daniel

> ---
>  drivers/dma-buf/dma-buf.c             | 5 +++--
>  drivers/infiniband/core/umem_dmabuf.c | 2 +-
>  include/linux/dma-buf.h               | 2 +-
>  3 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 511fe0d217a0..e3faad8f492c 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -727,7 +727,8 @@ dma_buf_dynamic_attach(struct dma_buf *dmabuf, struct device *dev,
>         if (WARN_ON(!dmabuf || !dev))
>                 return ERR_PTR(-EINVAL);
>
> -       if (WARN_ON(importer_ops && !importer_ops->move_notify))
> +       if (WARN_ON(importer_ops && !importer_ops->move_notify &&
> +                   dma_buf_is_dynamic(attach->dmabuf)))
>                 return ERR_PTR(-EINVAL);
>
>         attach = kzalloc(sizeof(*attach), GFP_KERNEL);
> @@ -1048,7 +1049,7 @@ void dma_buf_move_notify(struct dma_buf *dmabuf)
>         dma_resv_assert_held(dmabuf->resv);
>
>         list_for_each_entry(attach, &dmabuf->attachments, node)
> -               if (attach->importer_ops)
> +               if (attach->importer_ops && attach->importer_ops->move_notify)
>                         attach->importer_ops->move_notify(attach);
>  }
>  EXPORT_SYMBOL_GPL(dma_buf_move_notify);
> diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
> index c6e875619fac..c502ae828bd3 100644
> --- a/drivers/infiniband/core/umem_dmabuf.c
> +++ b/drivers/infiniband/core/umem_dmabuf.c
> @@ -118,7 +118,7 @@ struct ib_umem_dmabuf *ib_umem_dmabuf_get(struct ib_device *device,
>         if (check_add_overflow(offset, (unsigned long)size, &end))
>                 return ret;
>
> -       if (unlikely(!ops || !ops->move_notify))
> +       if (unlikely(!ops))
>                 return ret;
>
>         dmabuf = dma_buf_get(fd);
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index efdc56b9d95f..4b2e99012cb1 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -473,7 +473,7 @@ static inline bool dma_buf_is_dynamic(struct dma_buf *dmabuf)
>  static inline bool
>  dma_buf_attachment_is_dynamic(struct dma_buf_attachment *attach)
>  {
> -       return !!attach->importer_ops;
> +       return !!attach->importer_ops->move_notify;
>  }
>
>  struct dma_buf_attachment *dma_buf_attach(struct dma_buf *dmabuf,
> --
> 2.32.0
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
