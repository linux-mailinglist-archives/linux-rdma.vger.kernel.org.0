Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627633AF613
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 21:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFUT07 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 15:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhFUT06 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Jun 2021 15:26:58 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7913BC061756;
        Mon, 21 Jun 2021 12:24:44 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so18803522oth.9;
        Mon, 21 Jun 2021 12:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dBJ5d1VMITTeIiGdzPkAixCEDqtOI+Of2asfGh+UAZ4=;
        b=poWdRMlEM2ZoLHlzus9H+sJm2Gyv4Ad5UYLCdoksxIn2aeAMLa+dKaekWP8LifxgyJ
         n2jVVjTuonYLSxe3ETtsIuLK6gvACWCDRPmuF5tYeQjeJRX7OY/u7vWBpL0kZJzHl5sj
         Ny/XMZJGPL6fogHwoJFWsiHZjsbH13H9+wxt/q/eKq5DtLZntN4WMvAkk8EZkafocBEK
         6xqocdwV6n4EqRoI+ZBfp3axIcf4mR5Wn6oTb26BEs3yq9YTXbI3ZeEuQkoD5A+xRhEy
         Pckce+Y9OeKX2dihb865SJYvyNOs4TOMg3c3iU7fvPH++FHzFI5BYoTOBQOjmtC3BaTY
         AZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dBJ5d1VMITTeIiGdzPkAixCEDqtOI+Of2asfGh+UAZ4=;
        b=Z6TcuANUJds16hTi8hffR8eVoxSYOIdorTOVAbVhPCLkRydNfApPbN9mHaU7J5vqaK
         HfI67UOliHEvqeaglP6/4ndtXqAz/c4/pgu+/UVaJMnM+mC4gk8YMcrOiCpXe2uZMNbs
         zLswkXMm135/eCoC1WHCquIaUa9C8zGO5Nqydds8QaZR1HB5EYJ8z8GY/S2c5L1XtlXM
         CDrVfHxB3uItyyBfg8SS5IgD9iIpi1ronHwg5AI1EjjQFVMLkr0NAEvszmLkaRXrx3mg
         bcfeW0gkbJllQQQzCoVfMljcvtnJA51O1bHJOXG2jPbcbZe/falexQnPp2vbu53yz9W0
         LNUg==
X-Gm-Message-State: AOAM533krmmjlEmIcP4Xtps9U6+5mR4rAaO4zjtzTGRO/qp2UEZNfFu4
        JGSGXM7dcJhENC7/cmNmzwX9rxvS8vJV1tWMDEU=
X-Google-Smtp-Source: ABdhPJxgnG68naVmqaj9VbYQpqtCzzRUWIKZ1A7mHfJtyBXgRWCjJn597bAS85CrpNuYd9PVyrIs804CEiOHGbIXZSQ=
X-Received: by 2002:a9d:542:: with SMTP id 60mr12808otw.143.1624303483767;
 Mon, 21 Jun 2021 12:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210618123615.11456-1-ogabbay@kernel.org> <CAKMK7uFOfoxbD2Z5mb-qHFnUe5rObGKQ6Ygh--HSH9M=9bziGg@mail.gmail.com>
 <YNCN0ulL6DQiRJaB@kroah.com> <20210621141217.GE1096940@ziepe.ca>
 <CAFCwf10KvCh0zfHEHqYR-Na6KJh4j+9i-6+==QaMdHHpLH1yEA@mail.gmail.com>
 <20210621175511.GI1096940@ziepe.ca> <CAKMK7uEO1_B59DtM7N2g7kkH7pYtLM_WAkn+0f3FU3ps=XEjZQ@mail.gmail.com>
In-Reply-To: <CAKMK7uEO1_B59DtM7N2g7kkH7pYtLM_WAkn+0f3FU3ps=XEjZQ@mail.gmail.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 21 Jun 2021 22:24:16 +0300
Message-ID: <CAFCwf11jOnewkbLuxUESswCJpyo7C0ovZj80UrnwUOZkPv2JYQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] habanalabs: define uAPI to export FD for DMA-BUF
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Greg KH <gregkh@linuxfoundation.org>,
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

On Mon, Jun 21, 2021 at 9:27 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> On Mon, Jun 21, 2021 at 7:55 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > On Mon, Jun 21, 2021 at 07:26:14PM +0300, Oded Gabbay wrote:
> > > On Mon, Jun 21, 2021 at 5:12 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > >
> > > > On Mon, Jun 21, 2021 at 03:02:10PM +0200, Greg KH wrote:
> > > > > On Mon, Jun 21, 2021 at 02:28:48PM +0200, Daniel Vetter wrote:
> > > >
> > > > > > Also I'm wondering which is the other driver that we share buffers
> > > > > > with. The gaudi stuff doesn't have real struct pages as backing
> > > > > > storage, it only fills out the dma_addr_t. That tends to blow up with
> > > > > > other drivers, and the only place where this is guaranteed to work is
> > > > > > if you have a dynamic importer which sets the allow_peer2peer flag.
> > > > > > Adding maintainers from other subsystems who might want to chime in
> > > > > > here. So even aside of the big question as-is this is broken.
> > > > >
> > > > > From what I can tell this driver is sending the buffers to other
> > > > > instances of the same hardware,
> > > >
> > > > A dmabuf is consumed by something else in the kernel calling
> > > > dma_buf_map_attachment() on the FD.
> > > >
> > > > What is the other side of this? I don't see any
> > > > dma_buf_map_attachment() calls in drivers/misc, or added in this patch
> > > > set.
> > >
> > > This patch-set is only to enable the support for the exporter side.
> > > The "other side" is any generic RDMA networking device that will want
> > > to perform p2p communication over PCIe with our GAUDI accelerator.
> > > An example is indeed the mlnx5 card which has already integrated
> > > support for being an "importer".
> >
> > It raises the question of how you are testing this if you aren't using
> > it with the only intree driver: mlx5.
>
> For p2p dma-buf there's also amdgpu as a possible in-tree candiate
> driver, that's why I added amdgpu folks. Otoh I'm not aware of AI+GPU
> combos being much in use, at least with upstream gpu drivers (nvidia
> blob is a different story ofc, but I don't care what they do in their
> own world).
> -Daniel
> --
We have/are doing three things:
1. I wrote a simple "importer" driver that emulates an RDMA driver. It
calls all the IB_UMEM_DMABUF functions, same as the mlnx5 driver does.
And instead of using h/w, it accesses the bar directly. We wrote
several tests that emulated the real application. i.e. asking the
habanalabs driver to create dma-buf object and export its FD back to
userspace. Then the userspace sends the FD to the "importer" driver,
which attaches to it, get the SG list and accesses the memory on the
GAUDI device. This gave me the confidence that how we integrated the
exporter is basically correct/working.

2. We are trying to do a POC with a MLNX card we have, WIP.

3. We are working with another 3rd party RDMA device that its driver
is now adding support for being an "importer". also WIP

In both points 2&3 We haven't yet reached the actual stage of checking
this feature.

Another thing I want to emphasize is that we are doing p2p only
through the export/import of the FD. We do *not* allow the user to
mmap the dma-buf as we do not support direct IO. So there is no access
to these pages through the userspace.

Thanks,
Oded
