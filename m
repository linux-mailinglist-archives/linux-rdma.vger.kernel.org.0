Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1AF7396FD
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2019 22:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbfFGUoa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 16:44:30 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45159 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729640AbfFGUoa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 16:44:30 -0400
Received: by mail-qk1-f193.google.com with SMTP id s22so2098806qkj.12
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jun 2019 13:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WewlwoMSKKpuUVFlw9dKTixdONarEXfImL/UTTPP7B8=;
        b=X0GGyDmYUIAZHt6qiBEP8KPAY6d75AVDJMz+L5eUnnWz9vTyYpreN8jlE7M6wtP1lF
         IDIcHQxP26GyfWw+o3noCioNyR5xkWWs1gKA+rdMJlD2sUOGdd0MrpRDRqNydQ9e7LcD
         8vcAXaxGgIGxeb1czpxE2GAaLGoDzu6No3mD6tMxqFJ2qHHOgRXfkUd9CrtNwOLuLCap
         Nn/nkrny4hyodmxLuC94m/gBMHcrLlsFK4MLipaiLGAjy6FjV+gCOnjwovaawgrcFS4J
         qwpJwBquFgb8t/8P6oJTqd4lG3V4ZQcEgxb1hEV9C51LFb7t5ZHp/uRuPMVrTa+QGz/o
         /lKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WewlwoMSKKpuUVFlw9dKTixdONarEXfImL/UTTPP7B8=;
        b=fSCFXhjWAY4f+8beSgGmPlI2cMrwFN95EgcD6WLL6XW2FwgkplY72OtASHiy4JV085
         dAN6khJu8ZdA0zwcRG07AU02c3k2xN433fHhhK5KMeCjyd/3PBbHqL9uan+R6I5h7+2W
         9ePQpn0EjFy7Im0Ecld/wvF4crUKxjH5/jPMLg6KUDeYeQCzGHlUI2CdpxsacpB+v73m
         fn94r/d/6qi92RnZiBthQOtreeFMSVzm5La8EmZJ1hEH5WsaMsrjf4ZgirBl2vqEjLAl
         mMWmSaTy3m0Y6Q0Wc050eJ0htU/wurpYSD49rHnQZ4qXkD/lXlzIIf1PuhSiOcTZmnvd
         dOew==
X-Gm-Message-State: APjAAAX73bwErtrh2TjYaoaXenQZbOMBYr/kGSpbutbURqOVs2/lyuE3
        hKu+2XGq0rtxaajWLNW/SMcZBw==
X-Google-Smtp-Source: APXvYqxD7hqThTbaMz7g+9dYXpp8HEemZOxyQw6X/LVcsbVXF36bw89VVAJrstOqneJu+6WWHcc1+Q==
X-Received: by 2002:a37:f50f:: with SMTP id l15mr27246401qkk.343.1559940268771;
        Fri, 07 Jun 2019 13:44:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id e4sm1836237qtc.3.2019.06.07.13.44.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 13:44:28 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hZLit-0001Nv-PI; Fri, 07 Jun 2019 17:44:27 -0300
Date:   Fri, 7 Jun 2019 17:44:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 hmm 05/11] mm/hmm: Remove duplicate condition test
 before wait_event_timeout
Message-ID: <20190607204427.GU14802@ziepe.ca>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-6-jgg@ziepe.ca>
 <6833be96-12a3-1a1c-1514-c148ba2dd87b@nvidia.com>
 <20190607191302.GR14802@ziepe.ca>
 <e17aa8c5-790c-d977-2eb8-c18cdaa4cbb3@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e17aa8c5-790c-d977-2eb8-c18cdaa4cbb3@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 07, 2019 at 01:21:12PM -0700, Ralph Campbell wrote:

> > What I want to get to is a pattern like this:
> > 
> > pagefault():
> > 
> >     hmm_range_register(&range);
> > again:
> >     /* On the slow path, if we appear to be live locked then we get
> >        the write side of mmap_sem which will break the live lock,
> >        otherwise this gets the read lock */
> >     if (hmm_range_start_and_lock(&range))
> >           goto err;
> > 
> >     lockdep_assert_held(range->mm->mmap_sem);
> > 
> >     // Optional: Avoid useless expensive work
> >     if (hmm_range_needs_retry(&range))
> >        goto again;
> >     hmm_range_(touch vmas)
> > 
> >     take_lock(driver->update);
> >     if (hmm_range_end(&range) {
> >         release_lock(driver->update);
> >         goto again;
> >     }
> >     // Finish driver updates
> >     release_lock(driver->update);
> > 
> >     // Releases mmap_sem
> >     hmm_range_unregister_and_unlock(&range);
> > 
> > What do you think?
> > 
> > Is it clear?
> > 
> > Jason
> > 
> 
> Are you talking about acquiring mmap_sem in hmm_range_start_and_lock()?
> Usually, the fault code has to lock mmap_sem for read in order to
> call find_vma() so it can set range.vma.

> If HMM drops mmap_sem - which I don't think it should, just return an
> error to tell the caller to drop mmap_sem and retry - the find_vma()
> will need to be repeated as well.

Overall I don't think it makes a lot of sense to sleep for retry in
hmm_range_start_and_lock() while holding mmap_sem. It would be better
to drop that lock, sleep, then re-acquire it as part of the hmm logic.

The find_vma should be done inside the critical section created by
hmm_range_start_and_lock(), not before it. If we are retrying then we
already slept and the additional CPU cost to repeat the find_vma is
immaterial, IMHO?

Do you see a reason why the find_vma() ever needs to be before the
'again' in my above example? range.vma does not need to be set for
range_register.

> I'm also not sure about acquiring the mmap_sem for write as way to
> mitigate thrashing. It seems to me that if a device and a CPU are
> both faulting on the same page,

One of the reasons to prefer this approach is that it means we don't
need to keep track of which ranges we are faulting, and if there is a
lot of *unrelated* fault activity (unlikely?) we can resolve it using
mmap sem instead of this elaborate ranges scheme and related
locking. 

This would reduce the overall work in the page fault and
invalidate_start/end paths for the common uncontended cases.

> some sort of backoff delay is needed to let one side or the other
> make some progress.

What the write side of the mmap_sem would do is force the CPU and
device to cleanly take turns. Once the device pages are registered
under the write side the CPU will have to wait in invalidate_start for
the driver to complete a shootdown, then the whole thing starts all
over again. 

It is certainly imaginable something could have a 'min life' timer for
a device mapping and hold mm invalidate_start, and device pagefault
for that min time to promote better sharing.

But, if we don't use the mmap_sem then we can livelock and the device
will see an unrecoverable error from the timeout which means we have
risk that under load the system will simply obscurely fail. This seems
unacceptable to me..

Particularly since for the ODP use case the issue is not trashing
migration as a GPU might have, but simple system stability under swap
load. We do not want the ODP pagefault to permanently fail due to
timeout if the VMA is still valid..

Jason
