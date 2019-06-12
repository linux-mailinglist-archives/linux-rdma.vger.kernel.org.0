Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5D042436
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 13:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406547AbfFLLl2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 07:41:28 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46328 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405753AbfFLLl2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jun 2019 07:41:28 -0400
Received: by mail-qt1-f196.google.com with SMTP id h21so18096850qtn.13
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jun 2019 04:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lSxjAlC+uZbBWLnsce9oyecap+o1G1ClcqcyZBLt6wI=;
        b=c/H5ji3nSCh+gOvUZDZ+S49kTWjjHMkqM5K2HXt6kiI18mXJOv9nYMDgzX8sXa8uuc
         IcCdYbXGtrpY3GhKtGwh+RIXGC+PFMakdA+wusR+N3jiLNgrx4wjM95NSf+r/FPBRTNN
         yd4RlBPaK5CMMzhC7YE89oQF4gmN6FRcGMETb6SbdNYDGHpJjmCsIvQszvUQHLGeEEcf
         QKiBZ/BRdaKFgmw9CAqhzwIQ6vijVznk6tB3bDaJa089FcAOedvmz990jdY7jBdkCUSa
         1Pra7M2WAjRYPtoJQ+g7F+1qbiV5Kg4vguRuA6sY7Djm4wQOECC02VyEL2dpeO3v2WOZ
         am+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lSxjAlC+uZbBWLnsce9oyecap+o1G1ClcqcyZBLt6wI=;
        b=cv5RH1o8fvMFXAffRgtaM1boETvmZwccMqyFfhx8buDWbkk378Dm/nMPs9OE5XJ+Dv
         S6klRKBkcRTVzdacECnPDlcoluQyVDb2FQYBMjXaIH54VZSxu/t4ctJ5EJDZTtuyGjVc
         hCZM+fvMtzYBug6mXQY28gIi84Mseyuv5Rf3lT6dQ1JiwGRXAdiwe2kIOT0zq/1Lmq9h
         z2vEcc6cQVBzO7LzV8qHJNlAMUXlRd5Q84uoWV+b0PeaGWSu5lZtrnFEhsDCkd2HkrT3
         WbCkVUmMACDqOAAbfHWz0ZCzPw1xRu7Mla3Tf3i+R/ufYUBaePQcBj3xTQvhL3VpUrrc
         DiOA==
X-Gm-Message-State: APjAAAUEZr2aH7eHQt221FZyq7A5+8TXZhZto3/mDMk2NHyGA77doadp
        tk73VgMazdFXr7RiWAtN4/ZWPQ==
X-Google-Smtp-Source: APXvYqyV/onR2nJG+SUqo2rImG4GNtftgkItRoz2K7ZKcS8ciTodUxxiDupnb/jFspB22/5anKiaMA==
X-Received: by 2002:ac8:2b01:: with SMTP id 1mr63205463qtu.177.1560339686428;
        Wed, 12 Jun 2019 04:41:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id s66sm7743817qkh.17.2019.06.12.04.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 04:41:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hb1d7-0002GY-4q; Wed, 12 Jun 2019 08:41:25 -0300
Date:   Wed, 12 Jun 2019 08:41:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
        linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 hmm 02/11] mm/hmm: Use hmm_mirror not mm as an
 argument for hmm_range_register
Message-ID: <20190612114125.GA3876@ziepe.ca>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-3-jgg@ziepe.ca>
 <20190608085425.GB32185@infradead.org>
 <20190611194431.GC29375@ziepe.ca>
 <20190612071234.GA20306@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612071234.GA20306@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 12, 2019 at 12:12:34AM -0700, Christoph Hellwig wrote:
> On Tue, Jun 11, 2019 at 04:44:31PM -0300, Jason Gunthorpe wrote:
> > On Sat, Jun 08, 2019 at 01:54:25AM -0700, Christoph Hellwig wrote:
> > > FYI, I very much disagree with the direction this is moving.
> > > 
> > > struct hmm_mirror literally is a trivial duplication of the
> > > mmu_notifiers.  All these drivers should just use the mmu_notifiers
> > > directly for the mirroring part instead of building a thing wrapper
> > > that adds nothing but helping to manage the lifetime of struct hmm,
> > > which shouldn't exist to start with.
> > 
> > Christoph: What do you think about this sketch below?
> > 
> > It would replace the hmm_range/mirror/etc with a different way to
> > build the same locking scheme using some optional helpers linked to
> > the mmu notifier?
> > 
> > (just a sketch, still needs a lot more thinking)
> 
> I like the idea.  A few nitpicks: Can we avoid having to store the
> mm in struct mmu_notifier? I think we could just easily pass it as a
> parameter to the helpers.

Yes, but I think any driver that needs to use this API will have to
hold the 'struct mm_struct' and the 'struct mmu_notifier' together (ie
ODP does this in ib_ucontext_per_mm), so if we put it in the notifier
then it is trivially available everwhere it is needed, and the
mmu_notifier code takes care of the lifetime for the driver.

> The write lock case of mm_invlock_start_write_and_lock is probably
> worth factoring into separate helper? I can see cases where drivers
> want to just use it directly if they need to force getting the lock
> without the chance of a long wait.

The entire purpose of the invlock is to avoid getting the write lock
on mmap_sem as a fast path - if the driver wishes to use mmap_sem
locking only then it should just do so directly and forget about the
invlock.

Note that this patch is just an API sketch, I haven't fully checked
that the range_start/end are actually always called under mmap_sem,
and I already found that release is not. So there will need to be some
preperatory adjustments before we can use down_write(mmap_sem) as a
locking strategy here.

Thanks,
Jason
