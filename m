Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9AD3201BB2
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2020 21:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390858AbgFSTzm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Jun 2020 15:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387750AbgFSTzk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Jun 2020 15:55:40 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5775C0613EE
        for <linux-rdma@vger.kernel.org>; Fri, 19 Jun 2020 12:55:39 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e3so1715043qts.12
        for <linux-rdma@vger.kernel.org>; Fri, 19 Jun 2020 12:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iG/5poalED/7VvSow3wimfYmMiRP/QtWwEKtwUawqmQ=;
        b=amN9JafWL7REIgsG4g8OIqFlIlTlu1gJ4PcPJxw/L2LrqG+b/m+K9h46XOj035Kkef
         TsRqrMbDxejbLCKISjpgVIvIvH7KHxmqfLRppOe1JNXqfsUFcxa8bn0PHmGiIQh/MjLu
         UuMd6uihuWcp1/Cjglk/qvCxbaToMFKCgnOjW98TkQq1CnFA7XBucfvRktJqaYLyZbJL
         Qy2zeXt+RF9aZKE2Fh7cJ+gITSFerrfdPNhqoA8Ybh6njFwj+0WTTmZp0R2d3r4yQcc7
         0W0chyQB7bKAO0rPcYlw7T6gZe3V/Kuht69pjetjB2C5veX71/wW5Hb5ATTmGDza23KL
         22Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iG/5poalED/7VvSow3wimfYmMiRP/QtWwEKtwUawqmQ=;
        b=hLFaKSGXv9ugYPw/MDkDfIhV9RD7e7tSWRHVnA07JvQC+9EnhmYh7zBXpdiy/A5GU0
         WiukmPzS3tI0UI/X/1SDvr89TH04hjNJuY4cAGEl6fEwAq3egKzaVnx0JqQ7d/iKkAAW
         5dpe/tb8gS2MbJQtJ4FBIwBEdyAPz/YC0z+38F4XuGv5VRFtnS/9terG9Fp2ZVw/gnb5
         kqb4CiUVkSZg8vFv4W6XJYuuD4W09QQ6hpuLfzbIR97Uc/j1AKdr6mdKN0RRkLJb6Jpe
         IZ51ryA6KKF0ftzGJRbTmhovLc42CkP1X//xGIeNQO2z+YgbPJwr3rgLSA+KucQab6o7
         3ADA==
X-Gm-Message-State: AOAM532CpkKE80U9IhSSHweg/9c1Q/xyG+JYB7+zWF5TL1Snn7UzTqNP
        L7guvv++bcpTZxmXUG9Obk7nUA==
X-Google-Smtp-Source: ABdhPJyHrX1Mu0x40IEM5APsAGFiOIM0Ueh1NwUrby9aTJ1iJ4sadbDDvULedBTEjFxxXMxRl6BLIg==
X-Received: by 2002:ac8:4143:: with SMTP id e3mr5021341qtm.28.1592596538972;
        Fri, 19 Jun 2020 12:55:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id l127sm620014qkc.117.2020.06.19.12.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 12:55:38 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jmN6w-00B0jt-2Q; Fri, 19 Jun 2020 16:55:38 -0300
Date:   Fri, 19 Jun 2020 16:55:38 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Thomas =?utf-8?B?SGVsbHN0csO2bSAoSW50ZWwp?= 
        <thomas_os@shipmail.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Subject: Re: [Linaro-mm-sig] [PATCH 04/18] dma-fence: prime lockdep
 annotations
Message-ID: <20200619195538.GT6578@ziepe.ca>
References: <20200618172338.GM6578@ziepe.ca>
 <CAKMK7uEbqTu4q-amkLXyd1i8KNtLaoO2ZFoGqYiG6D0m0FKpOg@mail.gmail.com>
 <20200619113934.GN6578@ziepe.ca>
 <CAKMK7uE-kWA==Cko5uenMrcnopEjq42HxoDTDywzBAbHqsN13g@mail.gmail.com>
 <20200619151551.GP6578@ziepe.ca>
 <CAKMK7uEvkshAM6KUYZu8_OCpF4+1Y_SM7cQ9nJWpagfke8s8LA@mail.gmail.com>
 <20200619172308.GQ6578@ziepe.ca>
 <20200619180935.GA10009@redhat.com>
 <20200619181849.GR6578@ziepe.ca>
 <56008d64-772d-5757-6136-f20591ef71d2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56008d64-772d-5757-6136-f20591ef71d2@amd.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 19, 2020 at 03:48:49PM -0400, Felix Kuehling wrote:
> Am 2020-06-19 um 2:18 p.m. schrieb Jason Gunthorpe:
> > On Fri, Jun 19, 2020 at 02:09:35PM -0400, Jerome Glisse wrote:
> >> On Fri, Jun 19, 2020 at 02:23:08PM -0300, Jason Gunthorpe wrote:
> >>> On Fri, Jun 19, 2020 at 06:19:41PM +0200, Daniel Vetter wrote:
> >>>
> >>>> The madness is only that device B's mmu notifier might need to wait
> >>>> for fence_B so that the dma operation finishes. Which in turn has to
> >>>> wait for device A to finish first.
> >>> So, it sound, fundamentally you've got this graph of operations across
> >>> an unknown set of drivers and the kernel cannot insert itself in
> >>> dma_fence hand offs to re-validate any of the buffers involved?
> >>> Buffers which by definition cannot be touched by the hardware yet.
> >>>
> >>> That really is a pretty horrible place to end up..
> >>>
> >>> Pinning really is right answer for this kind of work flow. I think
> >>> converting pinning to notifers should not be done unless notifier
> >>> invalidation is relatively bounded. 
> >>>
> >>> I know people like notifiers because they give a bit nicer performance
> >>> in some happy cases, but this cripples all the bad cases..
> >>>
> >>> If pinning doesn't work for some reason maybe we should address that?
> >> Note that the dma fence is only true for user ptr buffer which predate
> >> any HMM work and thus were using mmu notifier already. You need the
> >> mmu notifier there because of fork and other corner cases.
> > I wonder if we should try to fix the fork case more directly - RDMA
> > has this same problem and added MADV_DONTFORK a long time ago as a
> > hacky way to deal with it.
> >
> > Some crazy page pin that resolved COW in a way that always kept the
> > physical memory with the mm that initiated the pin?
> >
> > (isn't this broken for O_DIRECT as well anyhow?)
> >
> > How does mmu_notifiers help the fork case anyhow? Block fork from
> > progressing?
> 
> How much the mmu_notifier blocks fork progress depends, on quickly we
> can preempt GPU jobs accessing affected memory. If we don't have
> fine-grained preemption capability (graphics), the best we can do is
> wait for the GPU jobs to complete. We can also delay submission of new
> GPU jobs to the same memory until the MMU notifier is done. Future jobs
> would use the new page addresses.
> 
> With fine-grained preemption (ROCm compute), we can preempt GPU work on
> the affected adders space to minimize the delay seen by fork.
> 
> With recoverable device page faults, we can invalidate GPU page table
> entries, so device access to the affected pages stops immediately.
> 
> In all cases, the end result is, that the device page table gets updated
> with the address of the copied pages before the GPU accesses the COW
> memory again.Without the MMU notifier, we'd end up with the GPU
> corrupting memory of the other process.

The model here in fork has been wrong for a long time, and I do wonder
how O_DIRECT manages to not be broken too.. I guess the time windows
there are too small to get unlucky.

If you have a write pin on a page then it should not be COW'd into the
fork'd process but copied with the originating page remaining with the
original mm. 

I wonder if there is some easy way to achive that - if that is the
main reason to use notifiers then it would be a better solution.

Jason
