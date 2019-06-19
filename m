Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5334B782
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2019 13:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfFSL4f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jun 2019 07:56:35 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41116 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfFSL4e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jun 2019 07:56:34 -0400
Received: by mail-qt1-f195.google.com with SMTP id d17so14489213qtj.8
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jun 2019 04:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aIyKDOmF25sa+ptAgfuszqALqlc+ol795zmgMWT7ReM=;
        b=F0D/nOEkUs6Sluf5qwUaaXatuIYH0Kewqi3at+sT1omrKjsK7hh+55S+3yOdioLu1y
         kLGplu7LdHjOqetDdcDArMO8rhcNYAfEC/4iDVbECenXZ5rzvImGFgzIxrQjlhLK48Dk
         Vwdy+2avjCBUG0WPpNFolYWtgh+/PrpsKjDYVMgY2c77acE7Xu5xm12glEcYkQccFa1c
         hr+8jfUyWiTURljXzSjxKWQ1CLPDzxvW2Mom/x30FY9VzZ4ngqplYyBIbo9oWyebHM97
         63QODAfcqMfegCTl8X2RAUhqEqzx3k46c6At4QLG8O2Fselsf1BVT4/rkjea8tqv0zhT
         O0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aIyKDOmF25sa+ptAgfuszqALqlc+ol795zmgMWT7ReM=;
        b=Yxm+btH13N3qQJ3CGoDWrKkdmjk2acxS3gZUfKvLbTj6a7eSOtpKyEKfbzYVNL6JLN
         LzxJuIEFh3yLhM8M6yNd2zeQFrpwb+N6QAIogI7wvi3ye4cCCC2bi4w7Tx3Qhf37Lx/3
         XTIvPV9xR+jPHuPo75oik8ojw+/HRcg/9t6uA2LxXG2Qdtcrofqr/HgOvD6+viGloY3N
         20uCRXoV6w5m1kVGfX5xzkMtI50uh2vITfQwJWQd9B+pBtdP0zbN+rzriy4CX2TKgIL5
         s8mlXZUqQJk85EiqeCf1Qrf+yMCtpjf4JqxmgXWmps3/Y3GRvNd+QXvSL9gnQz0jq4EQ
         c3EA==
X-Gm-Message-State: APjAAAVIp8OGjWEk3EgryjPLFJBrEAc90uCODVsHMUyxsLw4fsUOShyv
        KgVYchroAmXIkxNkh+RL5v4mow==
X-Google-Smtp-Source: APXvYqx83INLY1tOphLQBSuL2n2XC0sWDzdU9zK76pUp/d8/new7r9oZpKe73QludbDlywxZpabUmQ==
X-Received: by 2002:a0c:b148:: with SMTP id r8mr32123100qvc.240.1560945393639;
        Wed, 19 Jun 2019 04:56:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id c184sm9739470qkf.82.2019.06.19.04.56.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 04:56:33 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hdZCa-000393-Fg; Wed, 19 Jun 2019 08:56:32 -0300
Date:   Wed, 19 Jun 2019 08:56:32 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        "Yang, Philip" <Philip.Yang@amd.com>
Subject: Re: [PATCH v3 hmm 11/12] mm/hmm: Remove confusing comment and logic
 from hmm_release
Message-ID: <20190619115632.GC9360@ziepe.ca>
References: <20190614004450.20252-1-jgg@ziepe.ca>
 <20190614004450.20252-12-jgg@ziepe.ca>
 <20190615142106.GK17724@infradead.org>
 <20190618004509.GE30762@ziepe.ca>
 <20190618053733.GA25048@infradead.org>
 <be4f8573-6284-04a6-7862-23bb357bfe3c@amd.com>
 <20190619080705.GA5164@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619080705.GA5164@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 19, 2019 at 01:07:05AM -0700, Christoph Hellwig wrote:
> On Wed, Jun 19, 2019 at 12:53:55AM +0000, Kuehling, Felix wrote:
> > This code is derived from our old MMU notifier code. Before HMM we used 
> > to register a single MMU notifier per mm_struct and look up virtual 
> > address ranges that had been registered for mirroring via driver API 
> > calls. The idea was to reuse a single MMU notifier for the life time of 
> > the process. It would remain registered until we got a notifier_release.
> > 
> > hmm_mirror took the place of that when we converted the code to HMM.
> > 
> > I suppose we could destroy the mirror earlier, when we have no more 
> > registered virtual address ranges, and create a new one if needed later.
> 
> I didn't write the code, but if you look at hmm_mirror it already is
> a multiplexer over the mmu notifier, and the intent clearly seems that
> you register one per range that you want to mirror, and not multiplex
> it once again.  In other words - I think each amdgpu_mn_node should
> probably have its own hmm_mirror.  And while the amdgpu_mn_node objects
> are currently stored in an interval tree it seems like they are only
> linearly iterated anyway, so a list actually seems pretty suitable.  If
> not we need to improve the core data structures instead of working
> around them.

This looks a lot like the ODP code (amdgpu_mn_node == ib_umem_odp)

The interval tree is to quickly find the driver object(s) that have
the virtual pages during invalidation:

static int amdgpu_mn_sync_pagetables_gfx(struct hmm_mirror *mirror,
                        const struct hmm_update *update)
{
        it = interval_tree_iter_first(&amn->objects, start, end);
        while (it) {
                [..]
                amdgpu_mn_invalidate_node(node, start, end);

And following the ODP model there should be a single hmm_mirror per-mm
(user can fork and stuff, this is something I want to have core code
help with). 

The hmm_mirror can either exist so long as objects exist, or it can
exist until the chardev is closed - but never longer than the
chardev's lifetime.

Maybe we should be considering providing a mmu notifier & interval
tree & lock abstraction since ODP & AMD are very similar here..

Jason
