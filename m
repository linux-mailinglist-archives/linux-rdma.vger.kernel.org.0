Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5066ADFECD
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 09:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387614AbfJVH5m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 03:57:42 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50190 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387999AbfJVH5l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Oct 2019 03:57:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id q13so5964623wmj.0
        for <linux-rdma@vger.kernel.org>; Tue, 22 Oct 2019 00:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ROh4rdNDqXOhRRdO284KPkGzZyY++utv+oGYDMQe5MU=;
        b=CBb48fDUyTRQMv9HvwoxGfLenOC40zL3DrVPS/y/X0lpnxGaEbBd6CvNglLC88n0nm
         H2S3nHw5RAiDUKsFcOCAo16yGxKfcB3KblwNeRUSbQpswczeghaDIjPJmbnOPri9UZGo
         0xkMKv5HA2iYR4s8pU8+gACjEJj2rhE47sB+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ROh4rdNDqXOhRRdO284KPkGzZyY++utv+oGYDMQe5MU=;
        b=uYaxGrdklnYeUiNTJYNm/vWni+BcXf0MBgUvpspeRCozu0I2g2nVIoOUgnqh3KtXNp
         kPys/oTzuTDGvGcSIw/ce3vAZ09ptIlbbunheuf4XxLCZ6BIlmHmThQOoJfn2RutC3ET
         W5rzwzbrJQsdQPuApTaMSEmot+DxNtVUQ7O6EXWlQtGSq5DStnZvsHGeENULnoh2aOTT
         FMIcHSu8VkLrrcBmbk9tr+CXT4WJDyrwAO6jdFx2AdaX+2KPMjUOsGenbGt0KfCffCxd
         EWpUGbbP0TWrnbGImOZi66eB0O4g3LZnD8VhNkMiaPyPU32284AAegnDKnuJ4khqj+DV
         sTlw==
X-Gm-Message-State: APjAAAXtEFop7Pgm5FRYeHXbKNC97KHS1OY+wyio98Qjnoxr2T4JuVF1
        N3X8hW5xEvQw+h/xNulcI/tq1w==
X-Google-Smtp-Source: APXvYqzKrxZLRkZGIn/j/6GXzN01h0XlQ1NZaDTvcyCGyqNp2p/Kw3f/rv9PyApcC7hMNit/dkHghw==
X-Received: by 2002:a7b:c3c8:: with SMTP id t8mr1558153wmj.87.1571731058043;
        Tue, 22 Oct 2019 00:57:38 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id p7sm16093245wma.34.2019.10.22.00.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 00:57:37 -0700 (PDT)
Date:   Tue, 22 Oct 2019 09:57:35 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Yang, Philip" <Philip.Yang@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH hmm 00/15] Consolidate the mmu notifier interval_tree and
 locking
Message-ID: <20191022075735.GV11828@phenom.ffwll.local>
Mail-Followup-To: Jason Gunthorpe <jgg@mellanox.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Yang, Philip" <Philip.Yang@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
References: <bc954d29-388b-9e29-f960-115ccc6b9fea@gmail.com>
 <20191016160444.GB3430@mellanox.com>
 <2df298e2-ee91-ef40-5da9-2bc1af3a17be@gmail.com>
 <2046e0b4-ba05-0683-5804-e9bbf903658d@amd.com>
 <d6bcbd2a-2519-8945-eaf5-4f4e738c7fa9@amd.com>
 <20191018203608.GA5670@mellanox.com>
 <f7e34d8f-f3b0-b86d-7388-1f791674a4a9@amd.com>
 <20191021135744.GA25164@mellanox.com>
 <e07092c3-8ccd-9814-835c-6c462017aff8@amd.com>
 <20191021151221.GC25164@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191021151221.GC25164@mellanox.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 21, 2019 at 03:12:26PM +0000, Jason Gunthorpe wrote:
> On Mon, Oct 21, 2019 at 02:28:46PM +0000, Koenig, Christian wrote:
> > Am 21.10.19 um 15:57 schrieb Jason Gunthorpe:
> > > On Sun, Oct 20, 2019 at 02:21:42PM +0000, Koenig, Christian wrote:
> > >> Am 18.10.19 um 22:36 schrieb Jason Gunthorpe:
> > >>> On Thu, Oct 17, 2019 at 04:47:20PM +0000, Koenig, Christian wrote:
> > >>> [SNIP]
> > >>>    
> > >>>> So again how are they serialized?
> > >>> The 'driver lock' thing does it, read the hmm documentation, the hmm
> > >>> approach is basically the only approach that was correct of all the
> > >>> drivers..
> > >> Well that's what I've did, but what HMM does still doesn't looks correct
> > >> to me.
> > > It has a bug, but the basic flow seems to work.
> > >
> > > https://patchwork.kernel.org/patch/11191
> > 
> > Maybe wrong link? That link looks like an unrelated discussion on kernel 
> > image relocation.
> 
> Sorry, it got corrupted:
> 
> https://patchwork.kernel.org/patch/11191397/
> 
> > >>> So long as the 'driver lock' is held the range cannot become
> > >>> invalidated as the 'driver lock' prevents progress of invalidation.
> > >> Correct, but the problem is it doesn't wait for ongoing operations to
> > >> complete.
> > >>
> > >> See I'm talking about the following case:
> > >>
> > >> Thread A    Thread B
> > >> invalidate_range_start()
> > >>                       mmu_range_read_begin()
> > >>                       get_user_pages()/hmm_range_fault()
> > >>                       grab_driver_lock()
> > >> Updating the ptes
> > >> invalidate_range_end()
> > >>
> > >> As far as I can see in invalidate_range_start() the driver lock is taken
> > >> to make sure that we can't start any invalidation while the driver is
> > >> using the pages for a command submission.
> > > Again, this uses the seqlock like scheme *and* the driver lock.
> > >
> > > In this case after grab_driver_lock() mmu_range_read_retry() will
> > > return false if Thread A has progressed to 'updating the ptes.
> > >
> > > For instance here is how the concurrency resolves for retry:
> > >
> > >         CPU1                                CPU2
> > >                                    seq = mmu_range_read_begin()
> > > invalidate_range_start()
> > >    invalidate_seq++
> > 
> > How that was order was what confusing me. But I've read up on the code 
> > in mmu_range_read_begin() and found the lines I was looking for:
> > 
> > +    if (is_invalidating)
> > +        wait_event(mmn_mm->wq,
> > +               READ_ONCE(mmn_mm->invalidate_seq) != seq);
> > 
> > [SNIP]
> 
> Right, the basic design is that the 'seq' returned by
> mmu_range_read_begin() is never currently under invalidation.
> 
> Thus if the starting seq is not invalidating, then if it doesn't
> change we are guaranteed the ptes haven't changed either.
> 
> > > For the above I've simplified the mechanics of the invalidate_seq, you
> > > need to look through the patch to see how it actually works.
> > 
> > Yea, that you also allow multiple write sides is pretty neat.
> 
> Complicated, but necessary to make the non-blocking OOM stuff able to
> read the interval tree under all conditions :\
> 
> > > One of the motivations for this work is to squash that bug by adding a
> > > seqlock like pattern. But the basic hmm flow and collision-retry
> > > approach seems sound.
> > >
> > > Do you see a problem with this patch?
> > 
> > No, not any more.
> 
> Okay, great, thanks
>  
> > Essentially you are doing the same thing I've tried to do with the 
> > original amdgpu implementation. The difference is that you don't try to 
> > use a per range sequence (which is a good idea, we never got that fully 
> > working) and you allow multiple writers at the same time.
> 
> Yes, ODP had the per-range sequence and it never worked right
> either. Keeping track of things during the invalidate_end was too complex
>  
> > Feel free to stitch an Acked-by: Christian König 
> > <christian.koenig@amd.com> on patch #2,
> 
> Thanks! Can you also take some review and test for the AMD related
> patches? These were quite hard to make, it is very likely I've made an
> error..
> 
> > but you still doing a bunch of things in there which are way beyond
> > my understanding (e.g. where are all the SMP barriers?).
> 
> The only non-locked data is 'struct mmu_range_notifier->invalidate_seq'
> 
> On the write side it uses a WRITE_ONCE. The 'seq' it writes is
> generated under the mmn_mm->lock spinlock (held before and after the
> WRITE_ONCE) such that all concurrent WRITE_ONCE's are storing the same
> value. 
> 
> Essentially the spinlock is providing the barrier to order write:
> 
> invalidate_range_start():
>  spin_lock(&mmn_mm->lock);
>  mmn_mm->active_invalidate_ranges++;
>  mmn_mm->invalidate_seq |= 1;
>  *seq = mmn_mm->invalidate_seq;
>  spin_unlock(&mmn_mm->lock);
> 
>  WRITE_ONCE(mrn->invalidate_seq, cur_seq);
> 
> invalidate_range_end()
>  spin_lock(&mmn_mm->lock);
>  if (--mmn_mm->active_invalidate_ranges)
>     mmn_mm->invalidate_seq++
>  spin_unlock(&mmn_mm->lock);
> 
> ie when we do invalidate_seq++, due to the active_invalidate_ranges
> counter and the spinlock, we know all other WRITE_ONCE's have passed
> their spin_unlock and no concurrent ones are starting. The spinlock is
> providing the barrier here.
> 
> On the read side.. It is a similar argument, except with the
> driver_lock:
> 
> mmu_range_read_begin()
>   seq = READ_ONCE(mrn->invalidate_seq);
> 
> Here 'seq' may be the current value, or it may be an older
> value. Ordering is eventually provided by the driver_lock:
> 
> mn_tree_invalidate_start()
>  [..]
>  WRITE_ONCE(mrn->invalidate_seq, cur_seq);
>  driver_lock()
>  driver_unlock()
> 
> vs
>  driver_lock()
>    mmu_range_read_begin()
>      return seq != READ_ONCE(mrn->invalidate_seq);
>  driver_unlock()
> 
> Here if mn_tree_invalidate_start() has passed driver_unlock() then
> because we do driver_lock() before mmu_range_read_begin() we must
> observe the WRITE_ONCE. ie the driver_unlock()/driver_lock() provide
> the pair'd barrier.
> 
> If mn_tree_invalidate_start() has not passed driver_lock() then the
> mmu_range_read_begin() side prevents it from passing driver_lock()
> while it holds the lock. In this case it is OK if we don't observe the
> WRITE_ONCE() that was done just before as the invalidate_start()
> thread can't proceed to invalidation.
> 
> It is very unusual locking, it would be great if others could help
> look at it!
> 
> The unusual bit in all of this is using a lock's critical region to
> 'protect' data for read, but updating that same data before the lock's
> critical secion. ie relying on the unlock barrier to 'release' program
> ordered stores done before the lock's own critical region, and the
> lock side barrier to 'acquire' those stores.

I think this unusual use of locks as barriers for other unlocked accesses
deserves comments even more than just normal barriers. Can you pls add
them? I think the design seeems sound ...

Also the comment on the driver's lock hopefully prevents driver
maintainers from moving the driver_lock around in a way that would very
subtle break the scheme, so I think having the acquire barrier commented
in each place would be really good.

Cheers, Daniel

> 
> This approach is borrowed from the hmm mirror implementation..
> 
> If for some reason the scheme doesn't work, then the fallback is to
> expand the mmn_mm->lock spinlock to protect the mrn->invalidate_seq at
> some cost in performance.
> 
> Jason
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
