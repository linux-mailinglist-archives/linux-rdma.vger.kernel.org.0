Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB31F3AF116
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 18:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbhFUQ5u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 12:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbhFUQ4o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Jun 2021 12:56:44 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABB5C09B05B;
        Mon, 21 Jun 2021 09:26:38 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id g19-20020a9d12930000b0290457fde18ad0so4417845otg.1;
        Mon, 21 Jun 2021 09:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yoCwDUxZJP3Ut8z/hr4sZH2+48UBBB2zck9Vy5dLtgU=;
        b=pM+MoLSU0LSJh98DQrRsTPmTh+95pmfRHHbTmKcyhP9ovDKRhZcvBC02S/55ftG/og
         ruYrldynFgVUzXcJ5cpWd8IKQzedGdpH4I+1WfQpqdIufPWiWf72S0LDFysmflufYM4y
         4wEreRKEOPdT1VnnTfvE5bFAmShhQkzdbAuUs7Mj25c7MYRwZ3OzmCVuPeHzDrwJTziw
         rDSCsQLsvjXiYpI4vGyZmIa5HkJhW6dIjnKxwkKEFk6v9qnpGL7nodqGKszpOHNAzcK7
         CHo/Eex5i6JrEqmb0tCi7M7hZujczlekBuIR9iw4PZd+ucMGW5rl9ynK99eEaKLIYyZD
         Yulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yoCwDUxZJP3Ut8z/hr4sZH2+48UBBB2zck9Vy5dLtgU=;
        b=aZ3mam2bc6fZtI/oiZtfbZ08v2dsF0LIzdq/vTRGPbzu/RxfVvSwuiOsqpEPOCnWPu
         pgzEhKtbDGCX08hcrn/mfGKRvOfwhYZnzvcszOf9lWv+fjDAdLcw9PTx0+lyzvnCka6n
         8JuEDGQ7AeNYU3EisxnJrjgtfBMfNdLpVICCiliLr/q7gYYzR+GbG3LpwZ92+LiVWVER
         bqbZGLsg5YIdtKWfdcvNZtmcunNCR1KGxtsZ/sOEOSwffUt0iV8szH8+l9FP9mW5iyPL
         TBFN579YUbQuzJuQCRKsx60XjaKkbcoEwXlWKsQyWqFhi+NLQhIEEx4aSjpkzlnxnhSD
         PDPQ==
X-Gm-Message-State: AOAM533faXcsOwUwcsHz4H7u3JUbTbX/pEDDoZOC2sIqZdOOnY++cQQ5
        4vEtU8CtFwDxeJ5wUvcKBosPTGG6z6jVO9r7aZ8=
X-Google-Smtp-Source: ABdhPJyCAxXTkhs7AspbVL/ypAtCWxFLyf2+jHwkfD8UredO9wC4bcv1TQdaRkBRCIklexFbhcAJuyI6ee0+SeGt/NU=
X-Received: by 2002:a9d:4581:: with SMTP id x1mr22307079ote.145.1624292797889;
 Mon, 21 Jun 2021 09:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210618123615.11456-1-ogabbay@kernel.org> <CAKMK7uFOfoxbD2Z5mb-qHFnUe5rObGKQ6Ygh--HSH9M=9bziGg@mail.gmail.com>
 <YNCN0ulL6DQiRJaB@kroah.com> <20210621141217.GE1096940@ziepe.ca>
In-Reply-To: <20210621141217.GE1096940@ziepe.ca>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 21 Jun 2021 19:26:14 +0300
Message-ID: <CAFCwf10KvCh0zfHEHqYR-Na6KJh4j+9i-6+==QaMdHHpLH1yEA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] habanalabs: define uAPI to export FD for DMA-BUF
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Oded Gabbay <ogabbay@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>, Doug Ledford <dledford@redhat.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Gal Pressman <galpress@amazon.com>, sleybo@amazon.com,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomer Tayar <ttayar@habana.ai>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 21, 2021 at 5:12 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Jun 21, 2021 at 03:02:10PM +0200, Greg KH wrote:
> > On Mon, Jun 21, 2021 at 02:28:48PM +0200, Daniel Vetter wrote:
>
> > > Also I'm wondering which is the other driver that we share buffers
> > > with. The gaudi stuff doesn't have real struct pages as backing
> > > storage, it only fills out the dma_addr_t. That tends to blow up with
> > > other drivers, and the only place where this is guaranteed to work is
> > > if you have a dynamic importer which sets the allow_peer2peer flag.
> > > Adding maintainers from other subsystems who might want to chime in
> > > here. So even aside of the big question as-is this is broken.
> >
> > From what I can tell this driver is sending the buffers to other
> > instances of the same hardware,
>
> A dmabuf is consumed by something else in the kernel calling
> dma_buf_map_attachment() on the FD.
>
> What is the other side of this? I don't see any
> dma_buf_map_attachment() calls in drivers/misc, or added in this patch
> set.

This patch-set is only to enable the support for the exporter side.
The "other side" is any generic RDMA networking device that will want
to perform p2p communication over PCIe with our GAUDI accelerator.
An example is indeed the mlnx5 card which has already integrated
support for being an "importer".

This is *not* used for communication with another GAUDI device. If I
want to communicate with another GAUDI device, our userspace
communications library will use our internal network links, without
any need for dma-buf.

Oded

>
> AFAIK the only viable in-tree other side is in mlx5 (look in
> umem_dmabuf.c)
>
> Though as we already talked habana has their own networking (out of
> tree, presumably) so I suspect this is really to support some out of
> tree stuff??
>
> Jason
