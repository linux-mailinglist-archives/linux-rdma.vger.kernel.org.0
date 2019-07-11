Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B235E652B4
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2019 09:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfGKH66 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Jul 2019 03:58:58 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44672 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfGKH66 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Jul 2019 03:58:58 -0400
Received: by mail-oi1-f193.google.com with SMTP id e189so3763013oib.11;
        Thu, 11 Jul 2019 00:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YfAMEG8L/owsmlbfRme+xFoHE9pScAhhFraw9xAGnXw=;
        b=HnQdzQnPbHoAadBXZ5W8Oosf2VALObPgnrRxEZYRNjTRT+FQnzp4tHGWASqFsf0SfZ
         GJ8DKhpgj1Gph0JfwuepjVmwnF4abKP5CAZ5YWfj4/iRmzZZ3ubpPDc3cEttpc8tl03B
         9UCemc7dozLq4SryJewR3yQP5tzu5GlZLxs2xv/+lCpHiUswJ//J6V6ojGVZ2tjn3Msa
         0e+05GWzddB+qw31lnsLGs2MAT/u6MM3K08SjmjcMNwIFVTi5/iGL5ONc116rPiRmkmG
         iduqbFi1hppnpFu7EFhGG7b602HwghUasxoaT6tOLUEbjsKSbBYPlkkruH2YYHq3J8T4
         /uHA==
X-Gm-Message-State: APjAAAUNAXzj3Z3ZCIYFH7UwdlCgZtPaFGShAIzT+yagJmriqMsFtl36
        5GsItXPOIHLLNBWXrPSH6zNdKpqX5hvQRbM3O8U=
X-Google-Smtp-Source: APXvYqy+qhB+skKoLFhPAEjb4GZrKBj+3TQMMBpCauOxz49hztroQJQAGrQPnhc/7czzr1iT/kmzGTHYyw3wfMVw7Vw=
X-Received: by 2002:aca:bd43:: with SMTP id n64mr1483995oif.148.1562831937398;
 Thu, 11 Jul 2019 00:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190710133930.26591-1-geert@linux-m68k.org> <20190710144636.GC4051@ziepe.ca>
In-Reply-To: <20190710144636.GC4051@ziepe.ca>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 Jul 2019 09:58:46 +0200
Message-ID: <CAMuHMdW4GP5FDhDuY1w3u0NypSCE84pPB-T7JoA+4odaPnhT5Q@mail.gmail.com>
Subject: Re: [PATCH -next] rdma/siw: Add missing dependencies on LIBCRC32C and DMA_VIRT_OPS
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Next <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason,

On Wed, Jul 10, 2019 at 4:46 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Wed, Jul 10, 2019 at 03:39:30PM +0200, Geert Uytterhoeven wrote:
> > If LIBCRC32C and DMA_VIRT_OPS are not enabled:
> >
> >     drivers/infiniband/sw/siw/siw_main.o: In function `siw_newlink':
> >     siw_main.c:(.text+0x35c): undefined reference to `dma_virt_ops'
> >     drivers/infiniband/sw/siw/siw_qp_rx.o: In function `siw_csum_update':
> >     siw_qp_rx.c:(.text+0x16): undefined reference to `crc32c'
> >
> > Fix the first issue by adding a select of DMA_VIRT_OPS.
> > Fix the second issue by replacing the unneeded dependency on
> > CRYPTO_CRC32 by a dependency on LIBCRC32C.
> >
> > Reported-by: noreply@ellerman.id.au (first issue)
> > Fixes: c0cf5bdde46c664d ("rdma/siw: addition to kernel build environment")
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >  drivers/infiniband/sw/siw/Kconfig | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/sw/siw/Kconfig b/drivers/infiniband/sw/siw/Kconfig
> > index 94f684174ce3556e..b622fc62f2cd6d46 100644
> > +++ b/drivers/infiniband/sw/siw/Kconfig
> > @@ -1,6 +1,7 @@
> >  config RDMA_SIW
> >       tristate "Software RDMA over TCP/IP (iWARP) driver"
> > -     depends on INET && INFINIBAND && CRYPTO_CRC32
> > +     depends on INET && INFINIBAND && LIBCRC32C
>
> Is this the best practice?
>
> siw is using both the libcrc32c API and the
> 'crypto_alloc_shash("crc32c", 0, 0);' version. Is it right to get that
> transitively through LIBCRC32C?

Yes, I think so.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
