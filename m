Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B943AE90B
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 14:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhFUMbO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 08:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhFUMbN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Jun 2021 08:31:13 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D35C06175F
        for <linux-rdma@vger.kernel.org>; Mon, 21 Jun 2021 05:28:59 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id v11-20020a9d340b0000b0290455f7b8b1dcso4589038otb.7
        for <linux-rdma@vger.kernel.org>; Mon, 21 Jun 2021 05:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HHQC6lOkJEn8B4ZK4mW/HBR6aX7M4uga90R1ZErZgKw=;
        b=Td38oUyS/9/MPrT4jo5WsEx4w0MWOF/8bM1XyUzvOBwwzScRQorv0t2fw+zHCf7ir0
         h8zpP6oNobDqmDV0rX43vwv23S4wvsx20o1++gTR06+eOXnxOdhaB+3kQbyaZz/2S0tV
         GQVwEXVWhC4IEfs607x4fPCPD20Mejq78fTdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HHQC6lOkJEn8B4ZK4mW/HBR6aX7M4uga90R1ZErZgKw=;
        b=Aw72adzT5SlkQfn5EATIBmMioDbhLIefKFbJ5kmr8p8+akwFFYWjx/7RI1BjEOg1Ca
         od1Zark6dx2lHYzS4kTv1mLV6kwXtg4p/ITVSs7JwAR2lEJTJOy6nE34N3hjsuWJTu1M
         pZakOmMjzBo0fqyR+ZOgwmGK5gzxyFDd5F0GeHbHWN+xhl+Yjf8kGiYuzMKEr96D9U2z
         8W0mUCtveYIJ4ghfTNsDshEc12JMEz8i53rTcj1+l/aMGkL0pRc4ttxzz47GRRZQOukb
         auSvBawzo68IvnVU0kSCwER0Pbm06Er7H77F1xPSpgmZqP4j3awMEdpUA/ve5+3BCSbf
         71+g==
X-Gm-Message-State: AOAM533ZN8KW31tL30jBngw249QUk0U7xdhaGiQtNUW0ShCbzS+nYM7D
        VpHZ1g5HPsKScjzLiVv6KfplyWUB96l0RE9/y+gs2Q==
X-Google-Smtp-Source: ABdhPJwD0i9Zn4q4SoQulAg+xyZR3j3c5+btpLl6Z1t9xWUhyH1ThXXNgyVXCPxYSRcrINNnl8lEcpNTDGpjBNUKKJE=
X-Received: by 2002:a9d:12eb:: with SMTP id g98mr20269296otg.303.1624278539116;
 Mon, 21 Jun 2021 05:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210618123615.11456-1-ogabbay@kernel.org>
In-Reply-To: <20210618123615.11456-1-ogabbay@kernel.org>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Mon, 21 Jun 2021 14:28:48 +0200
Message-ID: <CAKMK7uFOfoxbD2Z5mb-qHFnUe5rObGKQ6Ygh--HSH9M=9bziGg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] habanalabs: define uAPI to export FD for DMA-BUF
To:     Oded Gabbay <ogabbay@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>, Doug Ledford <dledford@redhat.com>,
        "airlied@gmail.com" <airlied@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
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

On Fri, Jun 18, 2021 at 2:36 PM Oded Gabbay <ogabbay@kernel.org> wrote:
> User process might want to share the device memory with another
> driver/device, and to allow it to access it over PCIe (P2P).
>
> To enable this, we utilize the dma-buf mechanism and add a dma-buf
> exporter support, so the other driver can import the device memory and
> access it.
>
> The device memory is allocated using our existing allocation uAPI,
> where the user will get a handle that represents the allocation.
>
> The user will then need to call the new
> uAPI (HL_MEM_OP_EXPORT_DMABUF_FD) and give the handle as a parameter.
>
> The driver will return a FD that represents the DMA-BUF object that
> was created to match that allocation.
>
> Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
> Reviewed-by: Tomer Tayar <ttayar@habana.ai>

Mission acomplished, we've gone full circle, and the totally-not-a-gpu
driver is now trying to use gpu infrastructure. And seems to have
gained vram meanwhile too. Next up is going to be synchronization
using dma_fence so you can pass buffers back&forth without stalls
among drivers.

Bonus points for this being at v3 before it shows up on dri-devel and
cc's dma-buf folks properly (not quite all, I added the missing
people).

I think we roughly have two options here

a) Greg continues to piss off dri-devel folks while trying to look
cute&cuddly and steadfastly claiming that this accelator doesn't work
like any of the other accelerator drivers we have in drivers/gpu/drm.
All while the driver ever more looks like one of these other accel
drivers.

b) We finally do what we should have done years back and treat this as
a proper driver submission and review it on dri-devel instead of
sneaking it in through other channels because the merge criteria
dri-devel has are too onerous and people who don't have experience
with accel stacks for the past 20 years or so don't like them.

"But this probably means a new driver and big disruption!"

Not my problem, I'm not the dude who has to come up with an excuse for
this because I didn't merge the driver in the first place. I do get to
throw a "we all told you so" in though, but that's not helping.

Also I'm wondering which is the other driver that we share buffers
with. The gaudi stuff doesn't have real struct pages as backing
storage, it only fills out the dma_addr_t. That tends to blow up with
other drivers, and the only place where this is guaranteed to work is
if you have a dynamic importer which sets the allow_peer2peer flag.
Adding maintainers from other subsystems who might want to chime in
here. So even aside of the big question as-is this is broken.

Currently only 2 drivers set allow_peer2peer, so those are the only
ones who can consume these buffers from device memory. Pinging those
folks specifically.

Doug/Jason from infiniband: Should we add linux-rdma to the dma-buf
wildcard match so that you can catch these next time around too? At
least when people use scripts/get_maintainers.pl correctly. All the
other subsystems using dma-buf are on there already (dri-devel,
linux-media and linaro-mm-sig for android/arm embedded stuff).

Cheers, Daniel



> ---
>  include/uapi/misc/habanalabs.h | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
> index a47a731e4527..aa3d8e0ba060 100644
> --- a/include/uapi/misc/habanalabs.h
> +++ b/include/uapi/misc/habanalabs.h
> @@ -808,6 +808,10 @@ union hl_wait_cs_args {
>  #define HL_MEM_OP_UNMAP                        3
>  /* Opcode to map a hw block */
>  #define HL_MEM_OP_MAP_BLOCK            4
> +/* Opcode to create DMA-BUF object for an existing device memory allocation
> + * and to export an FD of that DMA-BUF back to the caller
> + */
> +#define HL_MEM_OP_EXPORT_DMABUF_FD     5
>
>  /* Memory flags */
>  #define HL_MEM_CONTIGUOUS      0x1
> @@ -878,11 +882,26 @@ struct hl_mem_in {
>                         /* Virtual address returned from HL_MEM_OP_MAP */
>                         __u64 device_virt_addr;
>                 } unmap;
> +
> +               /* HL_MEM_OP_EXPORT_DMABUF_FD */
> +               struct {
> +                       /* Handle returned from HL_MEM_OP_ALLOC. In Gaudi,
> +                        * where we don't have MMU for the device memory, the
> +                        * driver expects a physical address (instead of
> +                        * a handle) in the device memory space.
> +                        */
> +                       __u64 handle;
> +                       /* Size of memory allocation. Relevant only for GAUDI */
> +                       __u64 mem_size;
> +               } export_dmabuf_fd;
>         };
>
>         /* HL_MEM_OP_* */
>         __u32 op;
> -       /* HL_MEM_* flags */
> +       /* HL_MEM_* flags.
> +        * For the HL_MEM_OP_EXPORT_DMABUF_FD opcode, this field holds the
> +        * DMA-BUF file/FD flags.
> +        */
>         __u32 flags;
>         /* Context ID - Currently not in use */
>         __u32 ctx_id;
> @@ -919,6 +938,13 @@ struct hl_mem_out {
>
>                         __u32 pad;
>                 };
> +
> +               /* Returned in HL_MEM_OP_EXPORT_DMABUF_FD. Represents the
> +                * DMA-BUF object that was created to describe a memory
> +                * allocation on the device's memory space. The FD should be
> +                * passed to the importer driver
> +                */
> +               __u64 fd;
>         };
>  };
>
> --
> 2.25.1
>


--
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
