Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2017203317
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2020 11:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgFVJQ3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jun 2020 05:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgFVJQ1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jun 2020 05:16:27 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980C9C061796
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jun 2020 02:16:26 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id k15so12485289otp.8
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jun 2020 02:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZSeaMlE7GUutcCnGTBRyHmDL2wVD0AT7mD7yKh2KGMo=;
        b=H5vK5ouIPrJPZWDsfQ3DH3OjxhnJ+FDUdSyhVh2Ejj8/rsBPNCpbVe+HVV8SfXGtCc
         yGooR5PrZ7Q7Reu6OHaJ21Xk6My7JHgbvY164c4so/v+VzDkrKaFhB3a9X27YGWVZ+HD
         9f0TVFR7O4aFInSAo4+hO4Lk5fOamlWZm0rZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZSeaMlE7GUutcCnGTBRyHmDL2wVD0AT7mD7yKh2KGMo=;
        b=AUcz861X2kRO6kBYEcE4mXOZ/5lF0vpScqiPcqQnM/twCpXYK2VIrUX9ykwqo6T5em
         Lw/KA3vU1RVwCsOHaC0+ezw9gIgZ6Pc5+z3rR1WH5LRY9GYjGE5VS5uz0Q83McpyLOBX
         UJrPDZ5o+Bfd8fju5YxZ02wuUSn+Rv5VNAz0f6flWk7a24wDfMo3CQK8FSbrNpFqMw+w
         SOvNr4SXaTlvUU51Ou9k3k5w6BXg55oAa0XJkEc5gm77xJg3RSKRgqE4U+NbfLKZEuCx
         q0eATmHRU7FAvKTMfKkFP9GOoWYc8/yl3DjFMH07P8iC+AeB/aoawLeoA9X55UK0otzN
         EoCg==
X-Gm-Message-State: AOAM532naK53fsuvrM09kGLPnwwg4E9aXiGxUmfj8fQKgWMpaa724QX6
        gjqBpi/zg2CoY0dEsg7HQt5LDTzSPC5R89xB78KhAg==
X-Google-Smtp-Source: ABdhPJzIZC4iHlgUR+Yu5PeT4ypjAmYK05V91KLSkvEtVAiftAA5v9bvKYgkF5yc4xBoBP7cOtRYbpIjiRIH9kD4kJM=
X-Received: by 2002:a9d:4cd:: with SMTP id 71mr14110772otm.188.1592817385783;
 Mon, 22 Jun 2020 02:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
 <20200604081224.863494-4-daniel.vetter@ffwll.ch> <159186243606.1506.4437341616828968890@build.alporthouse.com>
 <CAPM=9ty6r1LuXAH_rf98GH0R9yN3x8xzKPjZG3QyvokpQBR-Hg@mail.gmail.com>
 <CAPj87rM0S2OPssf+WA+pjanT-0Om3yuUM1zUJCv4qTx5VYE=Fw@mail.gmail.com>
 <159255511144.7737.12635440776531222029@build.alporthouse.com>
 <CAKMK7uHEwj6jiZkRZ5PaCUNWcuU9oE4KYm4XHZwHnFzEuChZ7w@mail.gmail.com>
 <159255801588.7737.4425728073225310839@build.alporthouse.com>
 <20200619094309.GT20149@phenom.ffwll.local> <159257233754.7737.17318605310513355800@build.alporthouse.com>
In-Reply-To: <159257233754.7737.17318605310513355800@build.alporthouse.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 22 Jun 2020 11:16:14 +0200
Message-ID: <CAKMK7uG4KzUa5yJMXQ0ffUwC_fR+pPTEnag7=qfJNtobFH3+pQ@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH 03/18] dma-fence: basic lockdep annotations
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 19, 2020 at 3:12 PM Chris Wilson <chris@chris-wilson.co.uk> wrote:
>
> Quoting Daniel Vetter (2020-06-19 10:43:09)
> > On Fri, Jun 19, 2020 at 10:13:35AM +0100, Chris Wilson wrote:
> > > Quoting Daniel Vetter (2020-06-19 09:51:59)
> > > > On Fri, Jun 19, 2020 at 10:25 AM Chris Wilson <chris@chris-wilson.co.uk> wrote:
> > > > > Forcing a generic primitive to always be part of the same global map is
> > > > > horrible.
> > > >
> > > > And  no concrete example or reason for why that's not possible.
> > > > Because frankly it's not horrible, this is what upstream is all about:
> > > > Shared concepts, shared contracts, shared code.
> > > >
> > > > The proposed patches might very well encode the wrong contract, that's
> > > > all up for discussion. But fundamentally questioning that we need one
> > > > is missing what upstream is all about.
> > >
> > > Then I have not clearly communicated, as my opinion is not that
> > > validation is worthless, but that the implementation is enshrining a
> > > global property on a low level primitive that prevents it from being
> > > used elsewhere. And I want to replace completion [chains] with fences, and
> > > bio with fences, and closures with fences, and what other equivalencies
> > > there are in the kernel. The fence is as central a locking construct as
> > > struct completion and deserves to be a foundational primitive provided
> > > by kernel/ used throughout all drivers for discrete problem domains.
> > >
> > > This is narrowing dma_fence whereby adding
> > >       struct lockdep_map *dma_fence::wait_map
> > > and annotating linkage, allows you to continue to specify that all
> > > dma_fence used for a particular purpose must follow common rules,
> > > without restricting the primitive for uses outside of this scope.
> >
> > Somewhere else in this thread I had discussions with Jason Gunthorpe about
> > this topic. It might maybe change somewhat depending upon exact rules, but
> > his take is very much "I don't want dma_fence in rdma". Or pretty close to
> > that at least.
> >
> > Similar discussions with habanalabs, they're using dma_fence internally
> > without any of the uapi. Discussion there has also now concluded that it's
> > best if they remove them, and simply switch over to a wait_queue or
> > completion like every other driver does.
> >
> > The next round of the patches already have a paragraph to at least
> > somewhat limit how non-gpu drivers use dma_fence. And I guess actual
> > consensus might be pointing even more strongly at dma_fence being solely
> > something for gpus and closely related subsystem (maybe media) for syncing
> > dma-buf access.
> >
> > So dma_fence as general replacement for completion chains I think just
> > wont happen.
>
> That is sad. I cannot comprehend going back to pure completions after a
> taste of fence scheduling. And we are not even close to fully utilising
> them, as not all the async cpu [allocation!] tasks are fully tracked by
> fences yet and are still stuck in a FIFO workqueue.
>
> > What might make sense is if e.g. the lockdep annotations could be reused,
> > at least in design, for wait_queue or completion or anything else
> > really. I do think that has a fair chance compared to the automagic
> > cross-release annotations approach, which relied way too heavily on
> > guessing where barriers are. My experience from just a bit of playing
> > around with these patches here and discussing them with other driver
> > maintainers is that accurately deciding where critical sections start and
> > end is a job for humans only. And if you get it wrong, you will have a
> > false positive.
> >
> > And you're indeed correct that if we'd do annotations for completions and
> > wait queues, then that would need to have a class per semantically
> > equivalent user, like we have lockdep classes for mutexes, not just one
> > overall.
> >
> > But dma_fence otoh is something very specific, which comes with very
> > specific rules attached - it's not a generic wait_queue at all. Originally
> > it did start out as one even, but it is a very specialized wait_queue.
> >
> > So there's imo two cases:
> >
> > - Your completion is entirely orthogonal of dma_fences, and can never ever
> >   block a dma_fence. Don't use dma_fence for this, and no problem. It's
> >   just another wait_queue somewhere.
> >
> > - Your completion can eventually, maybe through lots of convolutions and
> >   depdencies, block a dma_fence. In that case full dma_fence rules apply,
> >   and the only thing you can do with a custom annotation is make the rules
> >   even stricter. E.g. if a sub-timeline in the scheduler isn't allowed to
> >   take certain scheduler locks. But the userspace visible/published fence
> >   do take them, maybe as part of command submission or retirement.
> >   Entirely hypotethical, no idea any driver actually needs this.
>
> I think we are faced with this very real problem.
>
> The papering we have today over userptr is so very thin, and if you
> squint you can already see it is coupled into the completion signal. Just
> it happens to be on the other side of the fence.
>
> The next batch of priority inversions involve integrating the async cpu
> tasks into the scheduler, and have full dependency tracking over every
> internal fence. I do not see any way to avoid coupling the completion
> signal from the GPU to the earliest resource allocation, as it's an
> unbroken chain of work, at least from the user's perspective. [Next up
> for annotations is that we need to always assume that userspace has an
> implicit lock on GPU resources; having to break that lock with a GPU
> reset should be a breach of our data integrity, and best avoided, for
> compute does not care one iota about system integrity and insist
> userspace knows best.] Such allocations have to be allowed to fail and
> for that failure to propagate cancelling the queued work, such that I'm
> considering what rules we need for gfp_t. That might allow enough
> leverage to break any fs_reclaim loops, but userptr is likely forever
> doomed [aside from its fs_reclaim loop is as preventable as the normal
> shrinker paths], but we still need to suggest to pin_user_pages that
> failure is better than oom and that is not clear atm. Plus the usual
> failure can happen at any time after updating the user facing
> bookkeeping, but that is just extra layers in the execution monitor
> ready to step in and replacing failing work with the error propagation.
> Or where the system grinds to a halt, requiring the monitor to patch in
> a new page / resource.

Zooming out a bunch, since this is a lot about the details of making
this happen, and I want to make sure I'm understanding your aim
correctly. I think we have 2 big things here interacting:

On one side the "everything async" push, for some value of everything.
Once everything is async we let either the linux scheduler (for
dma_fence_work) or the gpu scheduler (for i915_request) figure out how
to order everything, with all the dependencies. For memory allocations
there's likely quite a bit of retrying (on the allocation side) and
skipping (on the shrinker/mmu notifier side) involved to make this all
pan out. Maybe something like a GFP_NOGPU flag.

On the other side we have opinionated userspace with both very
long-running batches (they might as well be infinite, best we can do
is check that they still preempt within a reasonable amount of time,
lack of hw support for preemption in all cases notwithstanding). And
batches which synchronize across engines and whatever entirely under
userspace controls, with stuff like gpu semaphore waits entirely in
the cmd stream, without any kernel or gpu scheduler involvement. Well
maybe a slightly smarter gpu scheduler which converts the semaphore
wait from a pure busy loop into a "repoll on each scheduler
timeslice". But not actual dependency tracking awareness in the kernel
(or guc/hw fwiw) of what userspace is really trying to do.

Later is a big motivator for the former, since with arbitrary long
batches and arbitrary fences any wait for a batch to complete can take
forever, hence anything that might end up doing that needs to be done
async and without locks. That way we don't have to shoot anything if a
batch takes too long.

Finally if anything goes wrong (on the kernel side at least) we just
propagete fence error state through the entire ladder of in-flight
things (only if it goes wrong terminally ofc).

Roughly correct or did I miss a big (or small but really important) thing?

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
