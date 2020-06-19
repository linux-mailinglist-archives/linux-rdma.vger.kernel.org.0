Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90761201C68
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2020 22:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389585AbgFSUc3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Jun 2020 16:32:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21635 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387641AbgFSUc2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 Jun 2020 16:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592598746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+MZZFlS2lzexZcWJLtzbL34zsSkKE8BItNhmdhhu4K0=;
        b=gV7Nhy09Pmbfd5qWST3UHxpP4jVqrJ4Jiw32p8hpYn42fnPhv9S1rv8Pbag3swg2RwZ/H/
        kfoeraaEntVyccXagXAX1qEe9MGkLWZn5QSLC61CulcJ2xGoN0F070HsXF6JnwFD1Fmiv5
        uH/5PaL2o+IpDAnZSi/Pm7T31PLO+XA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-1iFxF6w7NlWEkZxAuvaRDQ-1; Fri, 19 Jun 2020 16:32:21 -0400
X-MC-Unique: 1iFxF6w7NlWEkZxAuvaRDQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E422871254;
        Fri, 19 Jun 2020 20:31:52 +0000 (UTC)
Received: from redhat.com (ovpn-112-200.rdu2.redhat.com [10.10.112.200])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EE21810002B5;
        Fri, 19 Jun 2020 20:31:48 +0000 (UTC)
Date:   Fri, 19 Jun 2020 16:31:47 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Felix Kuehling <felix.kuehling@amd.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m_=28Intel=29?= 
        <thomas_os@shipmail.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
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
Message-ID: <20200619203147.GC13117@redhat.com>
References: <CAKMK7uEbqTu4q-amkLXyd1i8KNtLaoO2ZFoGqYiG6D0m0FKpOg@mail.gmail.com>
 <20200619113934.GN6578@ziepe.ca>
 <CAKMK7uE-kWA==Cko5uenMrcnopEjq42HxoDTDywzBAbHqsN13g@mail.gmail.com>
 <20200619151551.GP6578@ziepe.ca>
 <CAKMK7uEvkshAM6KUYZu8_OCpF4+1Y_SM7cQ9nJWpagfke8s8LA@mail.gmail.com>
 <20200619172308.GQ6578@ziepe.ca>
 <20200619180935.GA10009@redhat.com>
 <20200619181849.GR6578@ziepe.ca>
 <56008d64-772d-5757-6136-f20591ef71d2@amd.com>
 <20200619195538.GT6578@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200619195538.GT6578@ziepe.ca>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 19, 2020 at 04:55:38PM -0300, Jason Gunthorpe wrote:
> On Fri, Jun 19, 2020 at 03:48:49PM -0400, Felix Kuehling wrote:
> > Am 2020-06-19 um 2:18 p.m. schrieb Jason Gunthorpe:
> > > On Fri, Jun 19, 2020 at 02:09:35PM -0400, Jerome Glisse wrote:
> > >> On Fri, Jun 19, 2020 at 02:23:08PM -0300, Jason Gunthorpe wrote:
> > >>> On Fri, Jun 19, 2020 at 06:19:41PM +0200, Daniel Vetter wrote:
> > >>>
> > >>>> The madness is only that device B's mmu notifier might need to wait
> > >>>> for fence_B so that the dma operation finishes. Which in turn has to
> > >>>> wait for device A to finish first.
> > >>> So, it sound, fundamentally you've got this graph of operations across
> > >>> an unknown set of drivers and the kernel cannot insert itself in
> > >>> dma_fence hand offs to re-validate any of the buffers involved?
> > >>> Buffers which by definition cannot be touched by the hardware yet.
> > >>>
> > >>> That really is a pretty horrible place to end up..
> > >>>
> > >>> Pinning really is right answer for this kind of work flow. I think
> > >>> converting pinning to notifers should not be done unless notifier
> > >>> invalidation is relatively bounded. 
> > >>>
> > >>> I know people like notifiers because they give a bit nicer performance
> > >>> in some happy cases, but this cripples all the bad cases..
> > >>>
> > >>> If pinning doesn't work for some reason maybe we should address that?
> > >> Note that the dma fence is only true for user ptr buffer which predate
> > >> any HMM work and thus were using mmu notifier already. You need the
> > >> mmu notifier there because of fork and other corner cases.
> > > I wonder if we should try to fix the fork case more directly - RDMA
> > > has this same problem and added MADV_DONTFORK a long time ago as a
> > > hacky way to deal with it.
> > >
> > > Some crazy page pin that resolved COW in a way that always kept the
> > > physical memory with the mm that initiated the pin?
> > >
> > > (isn't this broken for O_DIRECT as well anyhow?)
> > >
> > > How does mmu_notifiers help the fork case anyhow? Block fork from
> > > progressing?
> > 
> > How much the mmu_notifier blocks fork progress depends, on quickly we
> > can preempt GPU jobs accessing affected memory. If we don't have
> > fine-grained preemption capability (graphics), the best we can do is
> > wait for the GPU jobs to complete. We can also delay submission of new
> > GPU jobs to the same memory until the MMU notifier is done. Future jobs
> > would use the new page addresses.
> > 
> > With fine-grained preemption (ROCm compute), we can preempt GPU work on
> > the affected adders space to minimize the delay seen by fork.
> > 
> > With recoverable device page faults, we can invalidate GPU page table
> > entries, so device access to the affected pages stops immediately.
> > 
> > In all cases, the end result is, that the device page table gets updated
> > with the address of the copied pages before the GPU accesses the COW
> > memory again.Without the MMU notifier, we'd end up with the GPU
> > corrupting memory of the other process.
> 
> The model here in fork has been wrong for a long time, and I do wonder
> how O_DIRECT manages to not be broken too.. I guess the time windows
> there are too small to get unlucky.

This was discuss extensively in the GUP works John have been doing.
Yes O_DIRECT can potentialy break but only if you are writting to
COW pages and you initiated the O_DIRECT right before the fork and
GUP happen before fork was able to write protect the pages.

If you O_DIRECT but use memory as input ie you are writting the
memory to the file not reading from the file. Then fork is harmless
as you are just reading memory. You can still face the COW uncertainty
(the process against which you did the O_DIRECT get "new" pages but your
O_DIRECT goes on with the "old" pages) but doing O_DIRECT and fork
concurently is asking for trouble.

> 
> If you have a write pin on a page then it should not be COW'd into the
> fork'd process but copied with the originating page remaining with the
> original mm.
> 
> I wonder if there is some easy way to achive that - if that is the
> main reason to use notifiers then it would be a better solution.

Not doable as page refcount can change for things unrelated to GUP, with
John changes we can identify GUP and we could potentialy copy GUPed page
instead of COW but this can potentialy slow down fork() and i am not sure
how acceptable this would be. Also this does not solve GUP against page
that are already in fork tree ie page P0 is in process A which forks,
we now have page P0 in process A and B. Now we have process A which forks
again and we have page P0 in A, B, and C. Here B and C are two branches
with root in A. B and/or C can keep forking and grow the fork tree.

Now if read only GUP on P0 happens in C (or B everything is symetrical in
respect to root A) then P0 might not be the page that is in C after the
GUP ie if something in C write to the virtual address corresponding to P0
then a new page might get allocated and the virtual address will no longer
point to P0 for C.

Semantic was change with 17839856fd588f4ab6b789f482ed3ffd7c403e1f to some
what "fix" that but GUP fast is still succeptible to this.

Note that above commit only address the GUP after/while forking. GUP
before fork() need mmu notifier (or forcing page copy instead of COW).

Cheers,
Jérôme

