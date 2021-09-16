Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4340140DAE3
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Sep 2021 15:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239959AbhIPNRy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Sep 2021 09:17:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239805AbhIPNRv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Sep 2021 09:17:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F5CC61209;
        Thu, 16 Sep 2021 13:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631798191;
        bh=2SG+H3kPevlJgkQQvQK9AWnLbdaQxjj73VmdBEz2Wec=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uBB97KZcafpcr9Fvmgxvt3cex2msqbDU833CT4y17phe93ZFrk+tasiQfh9bRUXTV
         lAFpyotnHfPKhe53lFUNoer4RLfO4P3T2/eB24OS8LSoXCX3v7tk8A22RQucMqvGda
         ENYrGzxn4SrST1ZwMk+qy8ehrg3OgY7CYdchkXE5AjKe62/PJiQA94XUjs2wVDxotm
         FxmadI38cxNwaCIfbUwTIs6IObCc4xT1XLghPGTosfQ6/qNOFsj1qgjf3/oJ0qV3p4
         oFGW7umR+E5aZbSItLQT6GKyp+gYWISx/voRSUzEitrSAozO5Oywx3EOJB7glEBdO8
         MllPzht7VdI4w==
Received: by mail-oi1-f179.google.com with SMTP id v2so8976495oie.6;
        Thu, 16 Sep 2021 06:16:31 -0700 (PDT)
X-Gm-Message-State: AOAM531qcvlLyCPEd0he8iYOfP0YSGJpSDQCKPX7709//7omKCl9YniU
        +TAA7gTFm87AvmPyTzPb02iwWgI4rEbXoExudhE=
X-Google-Smtp-Source: ABdhPJyWoWAIpzSgckjrkOLA2KkBsw0T+bKIQh+jiBBw5MwfbN0tvv8J0mgdDyzVFL2WGjrHToyOcCbn0yXbXM7VGbo=
X-Received: by 2002:a05:6808:2193:: with SMTP id be19mr8915077oib.102.1631798190674;
 Thu, 16 Sep 2021 06:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210912165309.98695-1-ogabbay@kernel.org> <YUCvNzpyC091KeaJ@phenom.ffwll.local>
 <20210914161218.GF3544071@ziepe.ca> <CAFCwf13322953Txr3Afa_MomuD148vnfpEog0xzW7FPWH9=6fg@mail.gmail.com>
 <YUM5JoMMK7gceuKZ@phenom.ffwll.local> <CAFCwf10MnK5KPBaeWar4tALGz9n8+-B8toXnqurcebZ8Y_Jjpw@mail.gmail.com>
In-Reply-To: <CAFCwf10MnK5KPBaeWar4tALGz9n8+-B8toXnqurcebZ8Y_Jjpw@mail.gmail.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Thu, 16 Sep 2021 16:16:03 +0300
X-Gmail-Original-Message-ID: <CAFCwf12H=Pu2R6695LagUGoQwf+tUon1PKcv5=XZCVc42++pDg@mail.gmail.com>
Message-ID: <CAFCwf12H=Pu2R6695LagUGoQwf+tUon1PKcv5=XZCVc42++pDg@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Add p2p via dmabuf to habanalabs
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Gal Pressman <galpress@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Dave Airlie <airlied@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>, dsinger@habana.ai
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 16, 2021 at 3:44 PM Oded Gabbay <ogabbay@kernel.org> wrote:
>
> On Thu, Sep 16, 2021 at 3:31 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > Maybe I got the device security model all wrong, but I thought Guadi is
> > single user, and the only thing it protects is the system against the
> > Gaudi device trhough iommu/device gart. So roughly the following can
> > happen:
> >
> > 1. User A opens gaudi device, sets up dma-buf export
> >
> > 2. User A registers that with RDMA, or anything else that doesn't support
> > revoke.
> >
> > 3. User A closes gaudi device
> This can not happen without User A closing the FD of the dma-buf it exported.
> We prevent User A from closing the device because when it exported the
> dma-buf, the driver's code took a refcnt of the user's private
> structure. You can see that in export_dmabuf_common() in the 2nd
> patch. There is a call there to hl_ctx_get.
> So even if User A calls close(device_fd), the driver won't let any
> other user open the device until User A closes the fd of the dma-buf
> object.
>
> Moreover, once User A will close the dma-buf fd and the device is
> released, the driver will scrub the device memory (this is optional
> for systems who care about security).
>
> And AFAIK, User A can't close the dma-buf fd once it registered it
> with RDMA, without doing unregister.
> This can be seen in ib_umem_dmabuf_get() which calls dma_buf_get()
> which does fget(fd)

Adding Daniel, I don't know how his email got dropped when I replied to him...
