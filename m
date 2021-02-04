Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17DBC30FC08
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Feb 2021 19:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239236AbhBDSzk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Feb 2021 13:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238978AbhBDSpe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Feb 2021 13:45:34 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF2BC061788
        for <linux-rdma@vger.kernel.org>; Thu,  4 Feb 2021 10:44:53 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id x23so1007409oop.1
        for <linux-rdma@vger.kernel.org>; Thu, 04 Feb 2021 10:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4gooucf1A/MMHrPZZxu5UrlGZXNuNVaVVN03MAVxOqo=;
        b=nrF6qdlRrTGg6bI04z7g6l6waKFUp10JPZfWBBovOVUWSVVGkEyE4fSknfKR0M6ygk
         1ml9g4QKtEzZxV9Lvc083qz4lSJVFXme2QkjVXmxsi3nmiGCryLH4Yz5PpMfCDWx8g0s
         1lJbRyJMmAuDf2KR9lZ9fpowwT+pc6MpzAe+S9MeCWwOTt5e6EXjKJPWF2T6dTxn80bW
         jN3dRGT8BWiDDLD0Onhj2YlpIqlwVMLhZPZjztclfv6Zy+9U6YDgjEOrng9phgTDA8wl
         PanCqP/A7/M/9owttkc7k0TE9fa3YMbGvAwk07PCwT8ueKbPdQQ1rgbWDb69Sk6AB/do
         +YVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4gooucf1A/MMHrPZZxu5UrlGZXNuNVaVVN03MAVxOqo=;
        b=JMfs8/HLjkVtrIZCoSjCraH0tKOpFWnYcLnUlS5pAE8zl2RJbm+ZanuKEuXo0DBUg3
         vSZoeDwHl2y26ZJQd6LlAX6OEKcNMVXcHvk7DoruZ88R4wWxXiQ9dBSSOa0vlrmjtg30
         2zC3sgB9R37H2haFSV6W5hHyDBGriVTuhi29AUcf6p++ayIDEhUJGXK2x3WTxf5m1hBw
         XaVHrFXFcTii/G4pAA0Eb7ab1dbXzvFcLpsG5qE8F/78YiHloWyfmrNzop4ttkIQYPad
         ijLUHIbiTfQSMH3xzZmRKLpG+1UpvD2JmZ1N3PrC95VbjdAQJFb9+/HhU0jfbE2tArEb
         LHhg==
X-Gm-Message-State: AOAM5313EkF1UAzYfiYKoe7ryKE5gWs2KOnvqpaF4VTrJgHSdvBxkvz0
        4ytjbq8sC/T19rZxeY+7Gj0pHOInGtON2MnCMVUyzTkT
X-Google-Smtp-Source: ABdhPJyeoMN3IRVyXp+gfdgnnLu/hcm6gS6KPMHhpb0K/ivi5apGLX3HLtZJBx6m1veE0Uz6mRStkwLzxJ1ESXXZph8=
X-Received: by 2002:a4a:de94:: with SMTP id v20mr694655oou.90.1612464293198;
 Thu, 04 Feb 2021 10:44:53 -0800 (PST)
MIME-Version: 1.0
References: <1608067636-98073-1-git-send-email-jianxin.xiong@intel.com>
 <5e4ac17d-1654-9abc-9a14-bda223d62866@nvidia.com> <CADnq5_M2YuOv16E2DG6sCPtL=z5SDDrN+y7iwD_pHVc7Omyrmw@mail.gmail.com>
 <20210204182923.GL4247@nvidia.com>
In-Reply-To: <20210204182923.GL4247@nvidia.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 4 Feb 2021 13:44:41 -0500
Message-ID: <CADnq5_N9QvgAKQMLeutA7oBo5W5XyttvNOMK_siOc6QL+H07jQ@mail.gmail.com>
Subject: Re: [PATCH v16 0/4] RDMA: Add dma-buf support
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Jianxin Xiong <jianxin.xiong@intel.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Leon Romanovsky <leon@kernel.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Doug Ledford <dledford@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 4, 2021 at 1:29 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Thu, Feb 04, 2021 at 08:50:38AM -0500, Alex Deucher wrote:
> > On Thu, Feb 4, 2021 at 2:48 AM John Hubbard <jhubbard@nvidia.com> wrote:
> > >
> > > On 12/15/20 1:27 PM, Jianxin Xiong wrote:
> > > > This patch series adds dma-buf importer role to the RDMA driver in
> > > > attempt to support RDMA using device memory such as GPU VRAM. Dma-buf is
> > > > chosen for a few reasons: first, the API is relatively simple and allows
> > > > a lot of flexibility in implementing the buffer manipulation ops.
> > > > Second, it doesn't require page structure. Third, dma-buf is already
> > > > supported in many GPU drivers. However, we are aware that existing GPU
> > > > drivers don't allow pinning device memory via the dma-buf interface.
> > > > Pinning would simply cause the backing storage to migrate to system RAM.
> > > > True peer-to-peer access is only possible using dynamic attach, which
> > > > requires on-demand paging support from the NIC to work. For this reason,
> > > > this series only works with ODP capable NICs.
> > >
> > > Hi,
> > >
> > > Looking ahead to after this patchset is merged...
> > >
> > > Are there design thoughts out there, about the future of pinning to vidmem,
> > > for this? It would allow a huge group of older GPUs and NICs and such to
> > > do p2p with this approach, and it seems like a natural next step, right?
> >
> > The argument is that vram is a scarce resource, but I don't know if
> > that is really the case these days.  At this point, we often have as
> > much vram as system ram if not more.
>
> I thought the main argument was that GPU memory could move at any time
> between the GPU and CPU and the DMA buf would always track its current
> location?

I think the reason for that is that VRAM is scarce so we have to be
able to move it around.  We don't enforce the same limitations for
buffers in system memory.  We could just support pinning dma-bufs in
vram like we do with system ram.  Maybe with some conditions, e.g.,
p2p is possible, and the device has a large BAR so you aren't tying up
the BAR window.

Alex


>
> IMHO there is no reason not to have a special API to create small
> amounts of GPU dedicated locked memory that cannot be moved off the
> GPU.
>
> For instance this paper:
>
> http://www.ziti.uni-heidelberg.de/ziti/uploads/ce_group/2014-ASHESIPDPS.pdf
>
> Considers using the GPU to directly drive the RDMA work
> queues. Putting the queues themselves in GPU VRAM would make alot of
> sense.
>
> But that is impossible without fixed non-invalidating dma bufs.
>
> Jason
