Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45B263D729
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jun 2019 21:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405413AbfFKTtB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jun 2019 15:49:01 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44221 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405039AbfFKTtA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jun 2019 15:49:00 -0400
Received: by mail-qk1-f195.google.com with SMTP id w187so8438723qkb.11
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jun 2019 12:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dheT/EMDb4T+RApc8v8N2FtLE3hQvNF1jI6K4SKLtO8=;
        b=KARLerpzOvvIj3IeSArTupBFJwtO+dDGhTWToR4GRIOdhp5jyNWQH6gKAGwNJyiQ4U
         xCkP33zNk7FBLZe+Voo8dCCfx7wIB4dz2w5in+9dfr+0SUDLq0d7orxxPsoyNk3DtpJ4
         L9S3duKjQxW0McdT7XRm9Omr0K64Cpj09xwwLEanRjVh6IWFPsosaX+imndD2tPbPeQB
         FjnnbXv4dHkcKwvFZ+PCT06b9Jyb25/mybmzSoosPbMLQFcH82UhcYYjvkwHCRFFKaie
         nVhD3xpMNRX40iAA/yFNxeGBPVUFRysXuFmpx3gzh30qnakSYukbUtU4rsjR07o6ntSb
         +aSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dheT/EMDb4T+RApc8v8N2FtLE3hQvNF1jI6K4SKLtO8=;
        b=dh0Ab1pGCZ7kgSwlYkgl9m7nnSLojhQE9EnMu289oHCNlX6vK9kh/Dc8SS4aRjRhQG
         gkk6gBKiyYtwNlNy6XyBklNIbkPsRHl3fGBwygkhSFGCDNCxxS04DmYLOvCED079K4f/
         EWQiWeVb7nQgp9EQ2EIwwc2euqoa53QgZtqCXh2o9Ns01g1yn2w1IibXUaybstmzIQPj
         Oy+WSiefw3RphgGX0R7bgN3r1E1rh94Lfa811VQqMosecFBILvSiPZj5CmCzh5s5t4wD
         SpKO8WWVM22l4KJDtY19S6CmpTFwrLsVOt6rrOKo1wDHthl1CXGT6rKFMguTMqV6ljJ4
         pezw==
X-Gm-Message-State: APjAAAXbfqyeaHvi0eyldx3FKT3Ny531jOwNiGLQNSum4UHfScExcoJf
        rtdkx9MjLz16k1ObPKOjg3KrdQ==
X-Google-Smtp-Source: APXvYqzWz4wQqQxqhco5IULXJcXk646whmpSr99hd3VvEKfBiD/jhjxF/rS3VyznrgwL7ykbqH0Z2w==
X-Received: by 2002:a37:de18:: with SMTP id h24mr7448842qkj.147.1560282539428;
        Tue, 11 Jun 2019 12:48:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id g185sm3415686qkf.54.2019.06.11.12.48.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Jun 2019 12:48:59 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hamlO-0007GH-Lg; Tue, 11 Jun 2019 16:48:58 -0300
Date:   Tue, 11 Jun 2019 16:48:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Felix.Kuehling@amd.com,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 hmm 00/11] Various revisions from a locking/code review
Message-ID: <20190611194858.GA27792@ziepe.ca>
References: <20190606184438.31646-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606184438.31646-1-jgg@ziepe.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 06, 2019 at 03:44:27PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> For hmm.git:
> 
> This patch series arised out of discussions with Jerome when looking at the
> ODP changes, particularly informed by use after free races we have already
> found and fixed in the ODP code (thanks to syzkaller) working with mmu
> notifiers, and the discussion with Ralph on how to resolve the lifetime model.
> 
> Overall this brings in a simplified locking scheme and easy to explain
> lifetime model:
> 
>  If a hmm_range is valid, then the hmm is valid, if a hmm is valid then the mm
>  is allocated memory.
> 
>  If the mm needs to still be alive (ie to lock the mmap_sem, find a vma, etc)
>  then the mmget must be obtained via mmget_not_zero().
> 
> Locking of mm->hmm is shifted to use the mmap_sem consistently for all
> read/write and unlocked accesses are removed.
> 
> The use unlocked reads on 'hmm->dead' are also eliminated in favour of using
> standard mmget() locking to prevent the mm from being released. Many of the
> debugging checks of !range->hmm and !hmm->mm are dropped in favour of poison -
> which is much clearer as to the lifetime intent.
> 
> The trailing patches are just some random cleanups I noticed when reviewing
> this code.
> 
> This v2 incorporates alot of the good off list changes & feedback Jerome had,
> and all the on-list comments too. However, now that we have the shared git I
> have kept the one line change to nouveau_svm.c rather than the compat
> funtions.
> 
> I believe we can resolve this merge in the DRM tree now and keep the core
> mm/hmm.c clean. DRM maintainers, please correct me if I'm wrong.
> 
> It is on top of hmm.git, and I have a git tree of this series to ease testing
> here:
> 
> https://github.com/jgunthorpe/linux/tree/hmm
> 
> There are still some open locking issues, as I think this remains unaddressed:
> 
> https://lore.kernel.org/linux-mm/20190527195829.GB18019@mellanox.com/
> 
> I'm looking for some more acks, reviews and tests so this can move ahead to
> hmm.git.

AMD Folks, this is looking pretty good now, can you please give at
least a Tested-by for the new driver code using this that I see in
linux-next?

Thanks,
Jason
