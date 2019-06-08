Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B99339A17
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jun 2019 04:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbfFHCMs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 22:12:48 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40170 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbfFHCMr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 22:12:47 -0400
Received: by mail-qk1-f193.google.com with SMTP id c70so2460107qkg.7
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 19:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wpShQkLbA04ODKXzG1qE5Ho3NFfEe7GrNzFNdw8N1fw=;
        b=KdtQ5fr+UogFRN2W3gb87flKQku8+8a2uZ9C8b+1HCumdi0y4HCUEWHcLy66b1nq4X
         4SF3bP3sHcLzah/aOrL8m3PeQIXdb3olf+OcEG8F0Zk0r1dByCU7dQ8gQWxZqd1j60eD
         H0U83e9gy23Ez5x9lmNcp/2PZehCzH6iXZwD864FqkleaoYKq7DKpUhTRd/PcAfMRBck
         iRixfqYtjrFpiHJCAu53qL/zRKhqJChLVgw/2BiGOLXoHCd7CuI4Ts0aPv/9PRdPQQMD
         /Xieh3rM2sehEaWUCQZ6m5stbB/HmTeC2fa3mc/tDRN0kLoaVFwSQ0Qo87NCLb/F4KIU
         D0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wpShQkLbA04ODKXzG1qE5Ho3NFfEe7GrNzFNdw8N1fw=;
        b=jvTtIxKl9ZrRLWBRsfQe2v+7kjIPgBzSjI4ueXm5NO+fTLZK+BuIwjMv6LrQ8/M89Q
         BuECQvNhEjmWmjU4nqi/RWDqEqdeNQHj3YH1KItu7s4C0wo5aKAcIwtRLTCo7+YbWfT9
         Iy2YigQ2eRcK8wfIXwSOAy36iaGeLuADXh6jyKh+DlgwDSkurUjyDnxk7pfCCxdoiF6f
         mT8vae9Asm3TF/j+s4knQo1uw3rI/O+3VS6Zn2W+RtJ164oc+NQ6v8UcSik3DTi4Y9mi
         4MzQucI87qGPgrAVCiR5nSvXkcMNqZ4uDeoRB2zUxIauigsHiA6gDmFrMoF0fT85WOsG
         rIZw==
X-Gm-Message-State: APjAAAW2u1myB1K0ZFlWYJuNYaFa2J9+CaUa5FniC4MKby1dOHh88qDr
        /jCymqvKgVGM+sEO6iIjKeLD3A==
X-Google-Smtp-Source: APXvYqyopt5iGds43Rcjcs2oGVXUS/CH/C4qYinnv741RxxtwZYKZ6rAvBmMWcCM3HDewJAkVTAcCw==
X-Received: by 2002:a37:a0e:: with SMTP id 14mr28116214qkk.203.1559959966493;
        Fri, 07 Jun 2019 19:12:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id e66sm2067066qtb.55.2019.06.07.19.12.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 19:12:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hZQqb-0002RD-KJ; Fri, 07 Jun 2019 23:12:45 -0300
Date:   Fri, 7 Jun 2019 23:12:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 hmm 11/11] mm/hmm: Remove confusing comment and logic
 from hmm_release
Message-ID: <20190608021245.GD7844@ziepe.ca>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-12-jgg@ziepe.ca>
 <61ea869d-43d2-d1e5-dc00-cf5e3e139169@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61ea869d-43d2-d1e5-dc00-cf5e3e139169@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 07, 2019 at 02:37:07PM -0700, Ralph Campbell wrote:
> 
> On 6/6/19 11:44 AM, Jason Gunthorpe wrote:
> > From: Jason Gunthorpe <jgg@mellanox.com>
> > 
> > hmm_release() is called exactly once per hmm. ops->release() cannot
> > accidentally trigger any action that would recurse back onto
> > hmm->mirrors_sem.
> > 
> > This fixes a use after-free race of the form:
> > 
> >         CPU0                                   CPU1
> >                                             hmm_release()
> >                                               up_write(&hmm->mirrors_sem);
> >   hmm_mirror_unregister(mirror)
> >    down_write(&hmm->mirrors_sem);
> >    up_write(&hmm->mirrors_sem);
> >    kfree(mirror)
> >                                               mirror->ops->release(mirror)
> > 
> > The only user we have today for ops->release is an empty function, so this
> > is unambiguously safe.
> > 
> > As a consequence of plugging this race drivers are not allowed to
> > register/unregister mirrors from within a release op.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> 
> I agree with the analysis above but I'm not sure that release() will
> always be an empty function. It might be more efficient to write back
> all data migrated to a device "in one pass" instead of relying
> on unmap_vmas() calling hmm_start_range_invalidate() per VMA.

Sure, but it should not be allowed to recurse back to
hmm_mirror_unregister.

> I think the bigger issue is potential deadlocks while calling
> sync_cpu_device_pagetables() and tasks calling hmm_mirror_unregister():
>
> Say you have three threads:
> - Thread A is in try_to_unmap(), either without holding mmap_sem or with
> mmap_sem held for read.
> - Thread B has some unrelated driver calling hmm_mirror_unregister().
> This doesn't require mmap_sem.
> - Thread C is about to call migrate_vma().
>
> Thread A                Thread B                 Thread C
> try_to_unmap            hmm_mirror_unregister    migrate_vma
> hmm_invalidate_range_start
> down_read(mirrors_sem)
>                         down_write(mirrors_sem)
>                         // Blocked on A
>                                                   device_lock
> device_lock
> // Blocked on C
>                                                   migrate_vma()
>                                                   hmm_invalidate_range_s
>                                                   down_read(mirrors_sem)
>                                                   // Blocked on B
>                                                   // Deadlock

Oh... you know I didn't know this about rwsems in linux that they have
a fairness policy for writes to block future reads..

Still, at least as things are designed, the driver cannot hold a lock
it obtains under sync_cpu_device_pagetables() and nest other things in
that lock. It certainly can't recurse back into any mmu notifiers
while holding that lock. (as you point out)

The lock in sync_cpu_device_pagetables() needs to be very narrowly
focused on updating device state only.

So, my first reaction is that the driver in thread C is wrong, and
needs a different locking scheme. I think you'd have to make a really
good case that there is no alternative for a driver..

> Perhaps we should consider using SRCU for walking the mirror->list?

It means the driver has to deal with races like in this patch
description. At that point there is almost no reason to insert hmm
here, just use mmu notifiers directly.

Drivers won't get this right, it is too hard.

Jason
