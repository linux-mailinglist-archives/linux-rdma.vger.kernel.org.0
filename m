Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727FB41A948
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Sep 2021 09:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238962AbhI1HGe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Sep 2021 03:06:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238806AbhI1HGe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 28 Sep 2021 03:06:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40BE06120D;
        Tue, 28 Sep 2021 07:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632812695;
        bh=uk0cBqp8mJmxC4hvpD+WS8Fqi0WFUUo+M5zqdDQbazY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZYDfy30/tBP5/iCcMrH4okxJH98hSVzSe0pHLCxrxNCdYHE0/mDev9XllrrCJRE9B
         7Mk4dWURNWeAaz33Mj6Cu5pQtxE2qHGKhgD2F8Wn0MoEsttBsBIgdUN9Ft3MC3m+bZ
         yNlUoWIAzhKfLvhvHziiUERFnyWi4HO+uXMuvB4Q3/8xhSLN7vMhdAeKHAsDC/GQTy
         xb1YIltPnbmNP53U4svjLs+CZZZfIGgQLl/5pV9boVk2p62lG3/RsawwZgD3/isy1f
         ESY0Bsi3N9m1humhlZjWtb9oy2khd+hy4HO2qiQX5/ciGOrK040W+3VpS1eAbyPFCp
         oN0WjKPKJrI1A==
Received: by mail-yb1-f178.google.com with SMTP id m132so9545361ybf.8;
        Tue, 28 Sep 2021 00:04:55 -0700 (PDT)
X-Gm-Message-State: AOAM531iVl5u4o6nc/ydr18bqVineNouOWwO5H1xEefd/xRMFUUhnyFX
        zO54x0126YyCsPu4H/z9HmHMhm2vF46scbco92E=
X-Google-Smtp-Source: ABdhPJzCFYplamGxooBWwJyp1KX8cm27ANY5LYxIJdr3J9BPyZ9mLw/SlxUYU2bbcrwj4fdC1tykp7PZzcufB4sjcI0=
X-Received: by 2002:a25:5b85:: with SMTP id p127mr744801ybb.444.1632812694370;
 Tue, 28 Sep 2021 00:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210912165309.98695-1-ogabbay@kernel.org> <YUCvNzpyC091KeaJ@phenom.ffwll.local>
 <20210914161218.GF3544071@ziepe.ca> <CAFCwf13322953Txr3Afa_MomuD148vnfpEog0xzW7FPWH9=6fg@mail.gmail.com>
 <YUM5JoMMK7gceuKZ@phenom.ffwll.local> <20210916131014.GK3544071@ziepe.ca>
 <YUSKSHBC9uI49wZZ@phenom.ffwll.local> <CAFCwf12o-+wtbk8J8k8hP4_k0a8Lco4m9f4s1vBobkQwNtn39w@mail.gmail.com>
 <CAFCwf11UFVh-88Z=d=EH07_nx=3tf9kQkHhJ4pF6hfgO=80u0g@mail.gmail.com>
In-Reply-To: <CAFCwf11UFVh-88Z=d=EH07_nx=3tf9kQkHhJ4pF6hfgO=80u0g@mail.gmail.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Tue, 28 Sep 2021 10:04:29 +0300
X-Gmail-Original-Message-ID: <CAFCwf121CuNOesSRECUY9y7KWSGOZ2dHPCVvBqu8C4PCYj5PTw@mail.gmail.com>
Message-ID: <CAFCwf121CuNOesSRECUY9y7KWSGOZ2dHPCVvBqu8C4PCYj5PTw@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Add p2p via dmabuf to habanalabs
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dave Airlie <airlied@gmail.com>
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

On Thu, Sep 23, 2021 at 12:22 PM Oded Gabbay <ogabbay@kernel.org> wrote:
>
> On Sat, Sep 18, 2021 at 11:38 AM Oded Gabbay <ogabbay@kernel.org> wrote:
> >
> > On Fri, Sep 17, 2021 at 3:30 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > >
> > > On Thu, Sep 16, 2021 at 10:10:14AM -0300, Jason Gunthorpe wrote:
> > > > On Thu, Sep 16, 2021 at 02:31:34PM +0200, Daniel Vetter wrote:
> > > > > On Wed, Sep 15, 2021 at 10:45:36AM +0300, Oded Gabbay wrote:
> > > > > > On Tue, Sep 14, 2021 at 7:12 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > > > > >
> > > > > > > On Tue, Sep 14, 2021 at 04:18:31PM +0200, Daniel Vetter wrote:
> > > > > > > > On Sun, Sep 12, 2021 at 07:53:07PM +0300, Oded Gabbay wrote:
> > > > > > > > > Hi,
> > > > > > > > > Re-sending this patch-set following the release of our user-space TPC
> > > > > > > > > compiler and runtime library.
> > > > > > > > >
> > > > > > > > > I would appreciate a review on this.
> > > > > > > >
> > > > > > > > I think the big open we have is the entire revoke discussions. Having the
> > > > > > > > option to let dma-buf hang around which map to random local memory ranges,
> > > > > > > > without clear ownership link and a way to kill it sounds bad to me.
> > > > > > > >
> > > > > > > > I think there's a few options:
> > > > > > > > - We require revoke support. But I've heard rdma really doesn't like that,
> > > > > > > >   I guess because taking out an MR while holding the dma_resv_lock would
> > > > > > > >   be an inversion, so can't be done. Jason, can you recap what exactly the
> > > > > > > >   hold-up was again that makes this a no-go?
> > > > > > >
> > > > > > > RDMA HW can't do revoke.
> > > > >
> > > > > Like why? I'm assuming when the final open handle or whatever for that MR
> > > > > is closed, you do clean up everything? Or does that MR still stick around
> > > > > forever too?
> > > >
> > > > It is a combination of uAPI and HW specification.
> > > >
> > > > revoke here means you take a MR object and tell it to stop doing DMA
> > > > without causing the MR object to be destructed.
> > > >
> > > > All the drivers can of course destruct the MR, but doing such a
> > > > destruction without explicit synchronization with user space opens
> > > > things up to a serious use-after potential that could be a security
> > > > issue.
> > > >
> > > > When the open handle closes the userspace is synchronized with the
> > > > kernel and we can destruct the HW objects safely.
> > > >
> > > > So, the special HW feature required is 'stop doing DMA but keep the
> > > > object in an error state' which isn't really implemented, and doesn't
> > > > extend very well to other object types beyond simple MRs.
> > >
> > > Yeah revoke without destroying the MR doesn't work, and it sounds like
> > > revoke by destroying the MR just moves the can of worms around to another
> > > place.
> > >
> > > > > 1. User A opens gaudi device, sets up dma-buf export
> > > > >
> > > > > 2. User A registers that with RDMA, or anything else that doesn't support
> > > > > revoke.
> > > > >
> > > > > 3. User A closes gaudi device
> > > > >
> > > > > 4. User B opens gaudi device, assumes that it has full control over the
> > > > > device and uploads some secrets, which happen to end up in the dma-buf
> > > > > region user A set up
> > > >
> > > > I would expect this is blocked so long as the DMABUF exists - eg the
> > > > DMABUF will hold a fget on the FD of #1 until the DMABUF is closed, so
> > > > that #3 can't actually happen.
> > > >
> > > > > It's not mlocked memory, it's mlocked memory and I can exfiltrate
> > > > > it.
> > > >
> > > > That's just bug, don't make buggy drivers :)
> > >
> > > Well yeah, but given that habanalabs hand rolled this I can't just check
> > > for the usual things we have to enforce this in drm. And generally you can
> > > just open chardevs arbitrarily, and multiple users fighting over each
> > > another. The troubles only start when you have private state or memory
> > > allocations of some kind attached to the struct file (instead of the
> > > underlying device), or something else that requires device exclusivity.
> > > There's no standard way to do that.
> > >
> > > Plus in many cases you really want revoke on top (can't get that here
> > > unfortunately it seems), and the attempts to get towards a generic
> > > revoke() just never went anywhere. So again it's all hand-rolled
> > > per-subsystem. *insert lament about us not having done this through a
> > > proper subsystem*
> > >
> > > Anyway it sounds like the code takes care of that.
> > > -Daniel
> >
> > Daniel, Jason,
> > Thanks for reviewing this code.
> >
> > Can I get an R-B / A-B from you for this patch-set ?
> >
> > Thanks,
> > Oded
>
> A kind reminder.
>
> Thanks,
> Oded

Hi,
I know last week was LPC and maybe this got lost in the inbox, so I'm
sending it again to make sure you got my request for R-B / A-B.

Thanks,
Oded
