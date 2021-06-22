Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC863AFF7A
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 10:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhFVIpM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 04:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhFVIpK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Jun 2021 04:45:10 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4365C061766;
        Tue, 22 Jun 2021 01:42:54 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id v5-20020a0568301bc5b029045c06b14f83so3948139ota.13;
        Tue, 22 Jun 2021 01:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Wk5uHooOe9m9o4Li9n5UAmr51NiBBmwNJ7AeW2XMF1s=;
        b=DpDeRnU/4unkLfeKoqfIKEFsfBMZFLBF8xKaZiqlTL9oc6P670t4XFLRq0TbDdE6nr
         Ztf3mV6Jahqo5RivMEWXCClTKbKDMDe6c7CL3y9QiJTZt8/r2DB9HhkBvxBCH8TrEfdm
         Rt/c8fK3pi38t+F5QDTk0+rxauu4yuqIqdSUlpvdAhK+1McLQSnLZ32JDHCpHLb58xJG
         9PLhewIvLG/dnvIOahxYSNKAxU8IZKlfkXFiSxdV5+C0PGXWM7yX0apmRtf4EIruhPsC
         ZdnMtoc3+SsuyvZ4RQOwY5D2Bxf48aWo0hzb8v20huhOrOF7qWZgFU7vlfk5rpemBNeB
         mw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Wk5uHooOe9m9o4Li9n5UAmr51NiBBmwNJ7AeW2XMF1s=;
        b=q4AKlySAvLP8hjry30pD4NVYpa5kqUhRKwuDzSDweh7Z6yw2frvxAZGYWVk+FUy6h+
         ebBEc+WwxHcI08xhUPGfKeUKi8sjmpZYCXQpxxPrf6itgUaD5vK6lYRwiWyIyANzIwok
         SDgXQ5cLopf+Txmdxfr6j2tpfM/lxkZ+jMCkujVw3UcHyRqS2Jl0AAG0Xzb9hUJfg0aK
         vEXWwVEXBPhyrrsMYfA5vo4vptWnXQEvMUBDPn6Dgj8MLnlQllKEULMAtO6om5LMSxqe
         /GF9WM6AObDWDfX4tM4Ogc/CftT9p/ef2PQcwUIldPEGG0r7dywRUMwUYsKecwF4oOWp
         lWqQ==
X-Gm-Message-State: AOAM530hVJagvdtC6BzNhDcTVLNzouPVjQwfDcALDenYp79+pc0TTv6t
        tj/l97qBKlbHTSRDekuJtmrqQUv9p2h2DOXK7LM=
X-Google-Smtp-Source: ABdhPJzeINwyGxytAS9kO9kcC4dX49tJx+ip+znA7WLEk4h03GgImJS/DeJ5KNQOD5tnXfEngTt8fSVxTPnkQjTwAv4=
X-Received: by 2002:a9d:509:: with SMTP id 9mr2169190otw.339.1624351373978;
 Tue, 22 Jun 2021 01:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210618123615.11456-1-ogabbay@kernel.org> <CAKMK7uFOfoxbD2Z5mb-qHFnUe5rObGKQ6Ygh--HSH9M=9bziGg@mail.gmail.com>
 <YNCN0ulL6DQiRJaB@kroah.com> <20210621141217.GE1096940@ziepe.ca>
 <CAFCwf10KvCh0zfHEHqYR-Na6KJh4j+9i-6+==QaMdHHpLH1yEA@mail.gmail.com>
 <20210621175511.GI1096940@ziepe.ca> <CAKMK7uEO1_B59DtM7N2g7kkH7pYtLM_WAkn+0f3FU3ps=XEjZQ@mail.gmail.com>
 <CAFCwf11jOnewkbLuxUESswCJpyo7C0ovZj80UrnwUOZkPv2JYQ@mail.gmail.com>
 <20210621232912.GK1096940@ziepe.ca> <d358c740-fd3a-9ecd-7001-676e2cb44ec9@gmail.com>
In-Reply-To: <d358c740-fd3a-9ecd-7001-676e2cb44ec9@gmail.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Tue, 22 Jun 2021 11:42:27 +0300
Message-ID: <CAFCwf11h_Nj_GEdCdeTzO5jgr-Y9em+W-v_pYUfz64i5Ac25yg@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH v3 1/2] habanalabs: define uAPI to export
 FD for DMA-BUF
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Gal Pressman <galpress@amazon.com>,
        sleybo@amazon.com, linux-rdma <linux-rdma@vger.kernel.org>,
        Oded Gabbay <ogabbay@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Doug Ledford <dledford@redhat.com>,
        Tomer Tayar <ttayar@habana.ai>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 22, 2021 at 9:37 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 22.06.21 um 01:29 schrieb Jason Gunthorpe:
> > On Mon, Jun 21, 2021 at 10:24:16PM +0300, Oded Gabbay wrote:
> >
> >> Another thing I want to emphasize is that we are doing p2p only
> >> through the export/import of the FD. We do *not* allow the user to
> >> mmap the dma-buf as we do not support direct IO. So there is no access
> >> to these pages through the userspace.
> > Arguably mmaping the memory is a better choice, and is the direction
> > that Logan's series goes in. Here the use of DMABUF was specifically
> > designed to allow hitless revokation of the memory, which this isn't
> > even using.
>
> The major problem with this approach is that DMA-buf is also used for
> memory which isn't CPU accessible.
>
> That was one of the reasons we didn't even considered using the mapping
> memory approach for GPUs.
>
> Regards,
> Christian.
>
> >
> > So you are taking the hit of very limited hardware support and reduced
> > performance just to squeeze into DMABUF..

Thanks Jason for the clarification, but I honestly prefer to use
DMA-BUF at the moment.
It gives us just what we need (even more than what we need as you
pointed out), it is *already* integrated and tested in the RDMA
subsystem, and I'm feeling comfortable using it as I'm somewhat
familiar with it from my AMD days.

I'll go and read Logan's patch-set to see if that will work for us in
the future. Please remember, as Daniel said, we don't have struct page
backing our device memory, so if that is a requirement to connect to
Logan's work, then I don't think we will want to do it at this point.

Thanks,
Oded

> >
> > Jason
> > _______________________________________________
> > Linaro-mm-sig mailing list
> > Linaro-mm-sig@lists.linaro.org
> > https://lists.linaro.org/mailman/listinfo/linaro-mm-sig
>
