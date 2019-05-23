Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC42A2896C
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2019 21:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389695AbfEWThH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 May 2019 15:37:07 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44399 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390202AbfEWThG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 May 2019 15:37:06 -0400
Received: by mail-qt1-f194.google.com with SMTP id f24so8148720qtk.11
        for <linux-rdma@vger.kernel.org>; Thu, 23 May 2019 12:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EvB2oEdix8izGKCkl98CmLnxVEgkJ+2l0HrrW4Cnk4Y=;
        b=UfpXqxnkWDaeaaMCa66rkawZsy7d3VU8+Y4fiL6RCiHgxXiOAlS3lxadX42iz4hl+M
         BIkIHbLj+ye2OmlcBBji/RjpTpPAk1hYv6g6D1K/w1oZN0xrtKLWtx95M6bwxcHoudgZ
         LTE3fOtWAmcT5VE45VMIhIvFoG+07u1HBIcDuZZQNpfYs/WJC8yMoLOU/o6yns6gbHyh
         da23t12u1Zi2CytLjFaaqChQILykLUvixJtBowukob56QB9gAZRPMHkq3K4suDSvzCK3
         zp2oNMk2ARP7Ha6oXysTJv/ctxhnMVCiaedJEQ9BWmPCe4RT0uqCdknX2mfBR3uygiYX
         Di9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EvB2oEdix8izGKCkl98CmLnxVEgkJ+2l0HrrW4Cnk4Y=;
        b=gqcM8FsGX6aS/VB+PaJkgdYvbFbDKP3yZDWLsi/phu9GWIR1kgiooGMGk2Vsqh9hMJ
         2uy/Tr3jFnMO5yY7xm2EbqwWnYd2jSZo4yxAUmyOEjvCs4GR2m6ghwBADYc3KeZyQve3
         cnJRE/2t1iqLKQRNhtJqfq2m6f+GJcZZ5FRZsAd4lMBkd4D6Hhdhod3ECU4V8a7J/ipl
         DiR6/Zd2rz67Xbz0nXEqP6gQEPL7Ey07coeVqAH/4b2ZHAPfHj/9DoJ8BBwJFUc/oJ8s
         EdCwNIFNQ2y8LuXos5rWbhsxHbOiAQv05lk9QKnF9vkKvvastx/ELMINHWO1PoMsiJ+A
         qukQ==
X-Gm-Message-State: APjAAAUvh4lI6f6PuoO35t0tmhC9vw5QuRrDjR1N7m70jCrMPF0siiZg
        u40ARcAEQagXDYAKkv2gA4kzdw==
X-Google-Smtp-Source: APXvYqxJkBFJ4HgvZM38oeTFaXtBNor24nYI7KEJ+EprkXwXo4IbuqdcjGctpDTQXlmC7qxbJGyYAg==
X-Received: by 2002:ac8:6750:: with SMTP id n16mr58786519qtp.142.1558640225374;
        Thu, 23 May 2019 12:37:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id d58sm194218qtb.11.2019.05.23.12.37.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 12:37:04 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTtWR-0000xZ-Fj; Thu, 23 May 2019 16:37:03 -0300
Date:   Thu, 23 May 2019 16:37:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [RFC PATCH 00/11] mm/hmm: Various revisions from a locking/code
 review
Message-ID: <20190523193703.GI12159@ziepe.ca>
References: <20190523153436.19102-1-jgg@ziepe.ca>
 <6ee88cde-5365-9bbc-6c4d-7459d5c3ebe2@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ee88cde-5365-9bbc-6c4d-7459d5c3ebe2@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 23, 2019 at 12:04:16PM -0700, John Hubbard wrote:
> On 5/23/19 8:34 AM, Jason Gunthorpe wrote:
> > From: Jason Gunthorpe <jgg@mellanox.com>
> > 
> > This patch series arised out of discussions with Jerome when looking at the
> > ODP changes, particularly informed by use after free races we have already
> > found and fixed in the ODP code (thanks to syzkaller) working with mmu
> > notifiers, and the discussion with Ralph on how to resolve the lifetime model.
> > 
> > Overall this brings in a simplified locking scheme and easy to explain
> > lifetime model:
> > 
> >   If a hmm_range is valid, then the hmm is valid, if a hmm is valid then the mm
> >   is allocated memory.
> > 
> >   If the mm needs to still be alive (ie to lock the mmap_sem, find a vma, etc)
> >   then the mmget must be obtained via mmget_not_zero().
> > 
> > Locking of mm->hmm is shifted to use the mmap_sem consistently for all
> > read/write and unlocked accesses are removed.
> > 
> > The use unlocked reads on 'hmm->dead' are also eliminated in favour of using
> > standard mmget() locking to prevent the mm from being released. Many of the
> > debugging checks of !range->hmm and !hmm->mm are dropped in favour of poison -
> > which is much clearer as to the lifetime intent.
> > 
> > The trailing patches are just some random cleanups I noticed when reviewing
> > this code.
> > 
> > I expect Jerome & Ralph will have some design notes so this is just RFC, and
> > it still needs a matching edit to nouveau. It is only compile tested.
> > 
> 
> Thanks so much for doing this. Jerome has already absorbed these into his
> hmm-5.3 branch, along with Ralph's other fixes, so we can start testing,
> as well as reviewing, the whole set. We'll have feedback soon.

Yes, I looked at Jerome's v2's and he found a few great fixups.

My only dislike is re-introducing a READ_ONCE(mm->hmm) when a major
point of this seris was to remove that use-after-free stuff. 

But Jerome says it is a temporary defect while he works out some cross
tree API stuff.

Jason
