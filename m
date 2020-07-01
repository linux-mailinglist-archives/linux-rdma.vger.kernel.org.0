Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B294E210F90
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2020 17:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgGAPme (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Jul 2020 11:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgGAPmd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Jul 2020 11:42:33 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F525C08C5C1
        for <linux-rdma@vger.kernel.org>; Wed,  1 Jul 2020 08:42:33 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id x83so13417888oif.10
        for <linux-rdma@vger.kernel.org>; Wed, 01 Jul 2020 08:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HkYeES+the65jhF6rmWlj4yLK4y/80gAuVPob3gfotk=;
        b=f1woTfPpAit4dFDTgC1LxQAM46iypgOOZN9Qjs4MTCyikrkQdIJ2gPqijaKF+EmmK0
         tkoTXimHtXZZutNVm5fLD4OqJTcs4+aYsBpaT1mQCsQfNRYqPC5q3Il08McUG3nrihE6
         m+AqaTOiUTco0sL3ORObF71tLykyYIqPvmGjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HkYeES+the65jhF6rmWlj4yLK4y/80gAuVPob3gfotk=;
        b=NklPdLPiiMLV+YT3VJK0zHs0AMSKC/NsFSJyYZ2H6WYoUy8EzgyPMOZ5QAI4ZDuPGE
         13LZcORX3U2OJR/PxXqjYN+taMTapeeZVOt80D4MEuT2fD3mqfJ6wzOxUPNt0sZccbcK
         9BwWwOg1gnVPodGqteg8b6km7le+b0nPvCzv0qOsSnFQyFYWKGKwE3Lge0C3SI6EQ5e8
         diueYmL5DDowRu+ZUcRM6CuzeBTT+qlIeW5SknOiXZADn1vxSkOAn3I9FTn2VeEiHbp0
         dDX5H3G3DFQ33icO1eP5ocMcMJEKPfSuASJFFykGStU42PWxWkBLKMhnDgDJd2as+UdY
         818Q==
X-Gm-Message-State: AOAM532eH219zUsC5v3sdsrZEkvMHXcvIrtmBdYQqQAi/HCoN9B5nJJZ
        xQNtOyxH9ziXIsJnQZo6tj5NEwoUCyoysnxCig2+KQ==
X-Google-Smtp-Source: ABdhPJz5G6JVVjJt+T9seZsp2JFmqMLGTvG1yfc48XV0/7PKPi765ixKdOOGW3KewlSxlkCIRqgUJrxJsFcNVOh5T9U=
X-Received: by 2002:aca:dc82:: with SMTP id t124mr20958495oig.14.1593618152824;
 Wed, 01 Jul 2020 08:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <1593451903-30959-1-git-send-email-jianxin.xiong@intel.com>
 <20200629185152.GD25301@ziepe.ca> <MW3PR11MB4555A99038FA0CFC3ED80D3DE56F0@MW3PR11MB4555.namprd11.prod.outlook.com>
 <20200630173435.GK25301@ziepe.ca> <MW3PR11MB45553FA6D144BF1053571D98E56F0@MW3PR11MB4555.namprd11.prod.outlook.com>
 <9b4fa0c2-1661-6011-c552-e37b05f35938@amd.com> <20200701123904.GM25301@ziepe.ca>
 <34077a9f-7924-fbb3-04d9-cd20243f815c@amd.com>
In-Reply-To: <34077a9f-7924-fbb3-04d9-cd20243f815c@amd.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 1 Jul 2020 17:42:21 +0200
Message-ID: <CAKMK7uFf3_a+BN8CM7G8mNQPNtVBorouB+R5kxbbmFSB9XbeSg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] RDMA: add dma-buf support
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Doug Ledford <dledford@redhat.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>,
        "Xiong, Jianxin" <jianxin.xiong@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 1, 2020 at 2:56 PM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> Am 01.07.20 um 14:39 schrieb Jason Gunthorpe:
> > On Wed, Jul 01, 2020 at 11:03:06AM +0200, Christian K=C3=B6nig wrote:
> >> Am 30.06.20 um 20:46 schrieb Xiong, Jianxin:
> >>>> From: Jason Gunthorpe <jgg@ziepe.ca>
> >>>> Sent: Tuesday, June 30, 2020 10:35 AM
> >>>> To: Xiong, Jianxin <jianxin.xiong@intel.com>
> >>>> Cc: linux-rdma@vger.kernel.org; Doug Ledford <dledford@redhat.com>; =
Sumit Semwal <sumit.semwal@linaro.org>; Leon Romanovsky
> >>>> <leon@kernel.org>; Vetter, Daniel <daniel.vetter@intel.com>; Christi=
an Koenig <christian.koenig@amd.com>
> >>>> Subject: Re: [RFC PATCH v2 0/3] RDMA: add dma-buf support
> >>>>
> >>>> On Tue, Jun 30, 2020 at 05:21:33PM +0000, Xiong, Jianxin wrote:
> >>>>>>> Heterogeneous Memory Management (HMM) utilizes
> >>>>>>> mmu_interval_notifier and ZONE_DEVICE to support shared virtual
> >>>>>>> address space and page migration between system memory and device
> >>>>>>> memory. HMM doesn't support pinning device memory because pages
> >>>>>>> located on device must be able to migrate to system memory when
> >>>>>>> accessed by CPU. Peer-to-peer access is possible if the peer can
> >>>>>>> handle page fault. For RDMA, that means the NIC must support on-d=
emand paging.
> >>>>>> peer-peer access is currently not possible with hmm_range_fault().
> >>>>> Currently hmm_range_fault() always sets the cpu access flag and dev=
ice
> >>>>> private pages are migrated to the system RAM in the fault handler.
> >>>>> However, it's possible to have a modified code flow to keep the dev=
ice
> >>>>> private page info for use with peer to peer access.
> >>>> Sort of, but only within the same device, RDMA or anything else gene=
ric can't reach inside a DEVICE_PRIVATE and extract anything useful.
> >>> But pfn is supposed to be all that is needed.
> >>>
> >>>>>> So.. this patch doesn't really do anything new? We could just make=
 a MR against the DMA buf mmap and get to the same place?
> >>>>> That's right, the patch alone is just half of the story. The
> >>>>> functionality depends on availability of dma-buf exporter that can =
pin
> >>>>> the device memory.
> >>>> Well, what do you want to happen here? The RDMA parts are reasonable=
, but I don't want to add new functionality without a purpose - the
> >>>> other parts need to be settled out first.
> >>> At the RDMA side, we mainly want to check if the changes are acceptab=
le. For example,
> >>> the part about adding 'fd' to the device ops and the ioctl interface.=
 All the previous
> >>> comments are very helpful for us to refine the patch so that we can b=
e ready when
> >>> GPU side support becomes available.
> >>>
> >>>> The need for the dynamic mapping support for even the current DMA Bu=
f hacky P2P users is really too bad. Can you get any GPU driver to
> >>>> support non-dynamic mapping?
> >>> We are working on direct direction.
> >>>
> >>>>>>> migrate to system RAM. This is due to the lack of knowledge about
> >>>>>>> whether the importer can perform peer-to-peer access and the lack
> >>>>>>> of resource limit control measure for GPU. For the first part, th=
e
> >>>>>>> latest dma-buf driver has a peer-to-peer flag for the importer,
> >>>>>>> but the flag is currently tied to dynamic mapping support, which
> >>>>>>> requires on-demand paging support from the NIC to work.
> >>>>>> ODP for DMA buf?
> >>>>> Right.
> >>>> Hum. This is not actually so hard to do. The whole dma buf proposal =
would make a lot more sense if the 'dma buf MR' had to be the
> >>>> dynamic kind and the driver had to provide the faulting. It would no=
t be so hard to change mlx5 to be able to work like this, perhaps. (the
> >>>> locking might be a bit tricky though)
> >>> The main issue is that not all NICs support ODP.
> >> You don't need on-demand paging support from the NIC for dynamic mappi=
ng to
> >> work.
> >>
> >> All you need is the ability to stop wait for ongoing accesses to end a=
nd
> >> make sure that new ones grab a new mapping.
> > Swap and flush isn't a general HW ability either..
> >
> > I'm unclear how this could be useful, it is guarenteed to corrupt
> > in-progress writes?
> >
> > Did you mean pause, swap and resume? That's ODP.
>
> Yes, something like this. And good to know, never heard of ODP.

Hm I thought ODP was full hw page faults at an individual page level,
and this stop&resume is for the entire nic. Under the hood both apply
back-pressure on the network if a transmission can't be received, but
I thought the ODP one is a lore more fine-grained. For this dma_buf
stop-the-world approach we'd also need to guarantee _all_ buffers are
present again (without hw page faults on the nic side of things),
which has some additional locking implications.

> On the GPU side we can pipeline things, e.g. you can program the
> hardware that page tables are changed at a certain point in time.
>
> So what we do is when we get a notification that a buffer will move
> around is to mark this buffer in our structures as invalid and return a
> fence to so that the exporter is able to wait for ongoing stuff to finish=
.
>
> The actual move then happens only after the ongoing operations on the
> GPU are finished and on the next operation we grab the new location of
> the buffer and re-program the page tables to it.
>
> This way all the CPU does is really just planning asynchronous page
> table changes which are executed on the GPU later on.
>
> You can of course do it synchronized as well, but this would hurt our
> performance pretty badly.

So since Jason really doesn't like dma_fence much I think for rdma
synchronous it is. And it shouldn't really matter, since waiting for a
small transaction to complete at rdma wire speed isn't really that
long an operation. Should be much faster than waiting for the gpu to
complete quite sizeable amounts of rendering first. Plus with real hw
page faults it's really just pte write plus tlb flush, that should
definitely be possible from the ->move_notify hook.
But even the global stop-the-world approach I expect is going to be
much faster than a preempt request on a gpu.
-Daniel

>
> Regards,
> Christian.
>
> >
> > Jason
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
