Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CFC40C0C0
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Sep 2021 09:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236717AbhIOHrX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Sep 2021 03:47:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231364AbhIOHrW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Sep 2021 03:47:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7DFB61244;
        Wed, 15 Sep 2021 07:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631691963;
        bh=4Gj6JwM2F9z6+WV2U6hPIi4DFT6zybwQImEaoQLcouc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AIASKWCON1uBRCw4lAutBlPVeVE65cDnrLnCYFJ4bYNeSqoXUQggPgg4mg+gC6V/Y
         TflBPO0hKUGz9p2WxA8dSD1fgu0AIf+InGEhgq8eP3nmJ/fz4JxPSouhcsxb8loBAQ
         OmPg4ua8EDvhAZsigTuPNJa3td6pXkt2UKphCKj4B3g5FGlTxwszpw5w5WUxrHjztu
         yeLDXvPTeqE89v+A+Gd7x6/OkVHo0FrUiGsvLqWNSuWQ+aWuOpx5SB4G/ihr8FwUC6
         94HI38H82GHVZnLCMLyqxcbtnzOYDZKu8h1ChJhTGa8L9P6LUnl5mMcOCnFyE+CDJj
         4TNYDr1HCbL2w==
Received: by mail-oi1-f177.google.com with SMTP id y128so3069997oie.4;
        Wed, 15 Sep 2021 00:46:03 -0700 (PDT)
X-Gm-Message-State: AOAM532xNkwkXAt7sVx3JA82pXVogUcJLanpvm7gQNH8JfJz7QEVUHj3
        a+iGqgUPLnih/bry3d6sY0AFGjbRegQNEkyyECs=
X-Google-Smtp-Source: ABdhPJyHocVXnd3M7L44M5L0AEYg/MpqQyOEEu1IKwGTC02GHRHM6QQpVi8UIKUKfi6BBVVodwZ/vjYKKu1/Inl/D7Q=
X-Received: by 2002:aca:230f:: with SMTP id e15mr4339173oie.154.1631691962997;
 Wed, 15 Sep 2021 00:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210912165309.98695-1-ogabbay@kernel.org> <YUCvNzpyC091KeaJ@phenom.ffwll.local>
 <20210914161218.GF3544071@ziepe.ca>
In-Reply-To: <20210914161218.GF3544071@ziepe.ca>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Wed, 15 Sep 2021 10:45:36 +0300
X-Gmail-Original-Message-ID: <CAFCwf13322953Txr3Afa_MomuD148vnfpEog0xzW7FPWH9=6fg@mail.gmail.com>
Message-ID: <CAFCwf13322953Txr3Afa_MomuD148vnfpEog0xzW7FPWH9=6fg@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Add p2p via dmabuf to habanalabs
To:     Jason Gunthorpe <jgg@ziepe.ca>
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
        <linaro-mm-sig@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 14, 2021 at 7:12 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Tue, Sep 14, 2021 at 04:18:31PM +0200, Daniel Vetter wrote:
> > On Sun, Sep 12, 2021 at 07:53:07PM +0300, Oded Gabbay wrote:
> > > Hi,
> > > Re-sending this patch-set following the release of our user-space TPC
> > > compiler and runtime library.
> > >
> > > I would appreciate a review on this.
> >
> > I think the big open we have is the entire revoke discussions. Having the
> > option to let dma-buf hang around which map to random local memory ranges,
> > without clear ownership link and a way to kill it sounds bad to me.
> >
> > I think there's a few options:
> > - We require revoke support. But I've heard rdma really doesn't like that,
> >   I guess because taking out an MR while holding the dma_resv_lock would
> >   be an inversion, so can't be done. Jason, can you recap what exactly the
> >   hold-up was again that makes this a no-go?
>
> RDMA HW can't do revoke.
>
> So we have to exclude almost all the HW and several interesting use
> cases to enable a revoke operation.
>
> >   - For non-revokable things like these dma-buf we'd keep a drm_master
> >     reference around. This would prevent the next open to acquire
> >     ownership rights, which at least prevents all the nasty potential
> >     problems.
>
> This is what I generally would expect, the DMABUF FD and its DMA
> memory just floats about until the unrevokable user releases it, which
> happens when the FD that is driving the import eventually gets closed.
This is exactly what we are doing in the driver. We make sure
everything is valid until the unrevokable user releases it and that
happens only when the dmabuf fd gets closed.
And the user can't close it's fd of the device until he performs the
above, so there is no leakage between users.

>
> I still don't think any of the complexity is needed, pinnable memory
> is a thing in Linux, just account for it in mlocked and that is
> enough.
>
> Jason
