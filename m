Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC35210AD8
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2020 14:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbgGAMO5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Jul 2020 08:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730271AbgGAMO4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Jul 2020 08:14:56 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D44AC061755
        for <linux-rdma@vger.kernel.org>; Wed,  1 Jul 2020 05:14:56 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j18so22160055wmi.3
        for <linux-rdma@vger.kernel.org>; Wed, 01 Jul 2020 05:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tN5TAaADg2yYm9GDU7vTWYQgIa/EOt26hR6tLv2V8Cg=;
        b=k5X9vRuzogl5baYKW2Pi68HeB+yFk1j01ipuMlJiNw/m7YFQLBLxQnGlBEnWtOC7Oj
         MsjJLKIhenJ/mYMVh564Gh4LtTsY5hinuPVLqW9SQF9GHqKaEuNLq133T3WVFYPMuObQ
         hO92vEHi4g0tP4TnOmiqjt8y20QsKg5z7bkEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tN5TAaADg2yYm9GDU7vTWYQgIa/EOt26hR6tLv2V8Cg=;
        b=JBVQa2U6Yjq+YXNuJ/X/T85nuBaiFbNEi8Clh3jxGrCP0TZQK52Kihluonjtks7DpN
         PQ1icKB4hbMd4Tvrt7xDUZWG6Pfa6GSbvHI9Z/aoRL+HgvhhVQvz71SBuDH4hgQCO0ea
         H4N8SKICB7VEh7Bwjw9QeJ7XTp07r+swmH6a2Ft6Sj2XoRuPxIrcey01k5FnPpQXPDkD
         RRzRBAdFhlGb4ZxTljTiy9yWHxBrresQGoCdl0x/RlkfYfCUtoZcYBsJ/f9QLjOOe7FJ
         yYgyI/h6jQ2KKW+WYOrmD+gVJtzVh7kMFlFU65EI1KqCUlBDk6k4UQ6V9Mi/tggGre6J
         XOyg==
X-Gm-Message-State: AOAM532xhy5Trh1MnAsjxJm38Y7qSWSxd2wZhttRwqjRPB7wIyKEquab
        Q8Pay+UEN2Fo2oNMuwNPc0HgNJpFbkQ=
X-Google-Smtp-Source: ABdhPJyER+mBzmfllU3VjbRSwZcvMAbuQVqaGxOLBTyems8OILpNjZf7dANso/dkWhpv+iuMe5crYQ==
X-Received: by 2002:a7b:c3c7:: with SMTP id t7mr24537988wmj.97.1593605695134;
        Wed, 01 Jul 2020 05:14:55 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id x124sm1985095wmx.16.2020.07.01.05.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 05:14:54 -0700 (PDT)
Date:   Wed, 1 Jul 2020 14:14:52 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     "Xiong, Jianxin" <jianxin.xiong@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Doug Ledford <dledford@redhat.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>
Subject: Re: [RFC PATCH v2 0/3] RDMA: add dma-buf support
Message-ID: <20200701121452.GV3278063@phenom.ffwll.local>
References: <1593451903-30959-1-git-send-email-jianxin.xiong@intel.com>
 <20200629185152.GD25301@ziepe.ca>
 <MW3PR11MB4555A99038FA0CFC3ED80D3DE56F0@MW3PR11MB4555.namprd11.prod.outlook.com>
 <20200630173435.GK25301@ziepe.ca>
 <MW3PR11MB45553FA6D144BF1053571D98E56F0@MW3PR11MB4555.namprd11.prod.outlook.com>
 <9b4fa0c2-1661-6011-c552-e37b05f35938@amd.com>
 <20200701120744.GU3278063@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200701120744.GU3278063@phenom.ffwll.local>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 01, 2020 at 02:07:44PM +0200, Daniel Vetter wrote:
> Either my mailer ate half the thread or it's still stuck somewhere, so
> jumping in the middle a bit.
> 
> On Wed, Jul 01, 2020 at 11:03:06AM +0200, Christian König wrote:
> > Am 30.06.20 um 20:46 schrieb Xiong, Jianxin:
> > > > -----Original Message-----
> > > > From: Jason Gunthorpe <jgg@ziepe.ca>
> > > > Sent: Tuesday, June 30, 2020 10:35 AM
> > > > To: Xiong, Jianxin <jianxin.xiong@intel.com>
> > > > Cc: linux-rdma@vger.kernel.org; Doug Ledford <dledford@redhat.com>; Sumit Semwal <sumit.semwal@linaro.org>; Leon Romanovsky
> > > > <leon@kernel.org>; Vetter, Daniel <daniel.vetter@intel.com>; Christian Koenig <christian.koenig@amd.com>
> > > > Subject: Re: [RFC PATCH v2 0/3] RDMA: add dma-buf support
> > > > 
> > > > On Tue, Jun 30, 2020 at 05:21:33PM +0000, Xiong, Jianxin wrote:
> > > > > > > Heterogeneous Memory Management (HMM) utilizes
> > > > > > > mmu_interval_notifier and ZONE_DEVICE to support shared virtual
> > > > > > > address space and page migration between system memory and device
> > > > > > > memory. HMM doesn't support pinning device memory because pages
> > > > > > > located on device must be able to migrate to system memory when
> > > > > > > accessed by CPU. Peer-to-peer access is possible if the peer can
> > > > > > > handle page fault. For RDMA, that means the NIC must support on-demand paging.
> > > > > > peer-peer access is currently not possible with hmm_range_fault().
> > > > > Currently hmm_range_fault() always sets the cpu access flag and device
> > > > > private pages are migrated to the system RAM in the fault handler.
> > > > > However, it's possible to have a modified code flow to keep the device
> > > > > private page info for use with peer to peer access.
> > > > Sort of, but only within the same device, RDMA or anything else generic can't reach inside a DEVICE_PRIVATE and extract anything useful.
> > > But pfn is supposed to be all that is needed.
> > > 
> > > > > > So.. this patch doesn't really do anything new? We could just make a MR against the DMA buf mmap and get to the same place?
> > > > > That's right, the patch alone is just half of the story. The
> > > > > functionality depends on availability of dma-buf exporter that can pin
> > > > > the device memory.
> > > > Well, what do you want to happen here? The RDMA parts are reasonable, but I don't want to add new functionality without a purpose - the
> > > > other parts need to be settled out first.
> > > At the RDMA side, we mainly want to check if the changes are acceptable. For example,
> > > the part about adding 'fd' to the device ops and the ioctl interface. All the previous
> > > comments are very helpful for us to refine the patch so that we can be ready when
> > > GPU side support becomes available.
> > > 
> > > > The need for the dynamic mapping support for even the current DMA Buf hacky P2P users is really too bad. Can you get any GPU driver to
> > > > support non-dynamic mapping?
> > > We are working on direct direction.
> > > 
> > > > > > > migrate to system RAM. This is due to the lack of knowledge about
> > > > > > > whether the importer can perform peer-to-peer access and the lack
> > > > > > > of resource limit control measure for GPU. For the first part, the
> > > > > > > latest dma-buf driver has a peer-to-peer flag for the importer,
> > > > > > > but the flag is currently tied to dynamic mapping support, which
> > > > > > > requires on-demand paging support from the NIC to work.
> > > > > > ODP for DMA buf?
> > > > > Right.
> > > > Hum. This is not actually so hard to do. The whole dma buf proposal would make a lot more sense if the 'dma buf MR' had to be the
> > > > dynamic kind and the driver had to provide the faulting. It would not be so hard to change mlx5 to be able to work like this, perhaps. (the
> > > > locking might be a bit tricky though)
> > > The main issue is that not all NICs support ODP.
> > 
> > You don't need on-demand paging support from the NIC for dynamic mapping to
> > work.
> > 
> > All you need is the ability to stop wait for ongoing accesses to end and
> > make sure that new ones grab a new mapping.
> 
> So having no clue about rdma myself much, this sounds rather interesting.
> Sure it would result in immediately re-acquiring the pages, but that's
> also really all we need to be able to move buffers around on the gpu side.
> And with dma_resv_lock there's no livelock risk if the NIC immediately
> starts a kthread/work_struct which reacquires all the dma-buf and
> everything else it needs. Plus also with the full ww_mutex deadlock
> backoff dance there's no locking issues with having to acquire an entire
> pile of dma_resv_lock, that's natively supported (gpus very much need to
> be able to lock arbitrary set of buffers).
> 
> And I think if that would allow us to avoid the entire "avoid random
> drivers pinning dma-buf into vram" discussions, much better and quicker to
> land something like that.
> 
> I guess the big question is going to be how to fit this into rdma, since
> the ww_mutex deadlock backoff dance needs to be done at a fairly high
> level. For gpu drivers it's always done at the top level ioctl entry
> point.

Also, just to alleviate fears: I think all that dynamic dma-buf stuff for
rdma should be doable this way _without_ having to interact with
dma_fence. Avoiding that I think is the biggest request Jason has in this
area :-)

Furthermore, it is officially ok to allocate memory while holding a
dma_resv_lock. What is not ok (and might cause issues if you somehow mix
up things in strange ways) is taking a userspace fault, because gpu
drivers must be able to take the dma_resv_lock in their fault handlers.
That might pose a problem.

Also, all these rules are now enforced by lockdep, might_fault() and
similar checks.
-Daniel

> 
> > Apart from that this is a rather interesting work.
> > 
> > Regards,
> > Christian.
> > 
> > > 
> > > > > > > There are a few possible ways to address these issues, such as
> > > > > > > decoupling peer-to-peer flag from dynamic mapping, allowing more
> > > > > > > leeway for individual drivers to make the pinning decision and
> > > > > > > adding GPU resource limit control via cgroup. We would like to get
> > > > > > > comments on this patch series with the assumption that device
> > > > > > > memory pinning via dma-buf is supported by some GPU drivers, and
> > > > > > > at the same time welcome open discussions on how to address the
> > > > > > > aforementioned issues as well as GPU-NIC peer-to-peer access solutions in general.
> > > > > > These seem like DMA buf problems, not RDMA problems, why are you
> > > > > > asking these questions with a RDMA patch set? The usual DMA buf people are not even Cc'd here.
> > > > > The intention is to have people from both RDMA and DMA buffer side to
> > > > > comment. Sumit Semwal is the DMA buffer maintainer according to the
> > > > > MAINTAINERS file. I agree more people could be invited to the discussion.
> > > > > Just added Christian Koenig to the cc-list.
> 
> 
> MAINTAINERS also says to cc and entire pile of mailing lists, where the
> usual suspects (including Christian and me) hang around. Is that the
> reason I got only like half the thread here?
> 
> For next time around, really include everyone relevant here please.
> -Daniel
> 
> > > > Would be good to have added the drm lists too
> > > Thanks, cc'd dri-devel here, and will also do the same for the previous part of the thread.
> > > 
> > > > > If the umem_description you mentioned is for information used to
> > > > > create the umem (e.g. a structure for all the parameters), then this would work better.
> > > > It would make some more sense, and avoid all these weird EOPNOTSUPPS.
> > > Good, thanks for the suggestion.
> > > 
> > > > Jason
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
