Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A689423A8F
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Oct 2021 11:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhJFJcr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Oct 2021 05:32:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237852AbhJFJcn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 Oct 2021 05:32:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 013FF60FC0;
        Wed,  6 Oct 2021 09:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633512645;
        bh=4tjNezoaeMvFYX6HtvLOnUgP5bviSoGlZfZLRSEk4lc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jQ73KeaLTEKDP6gHWsUUhi0qmci/nlVoVkjb5Zdx6dOhUIOJZLr/Zzvwd1mBalNSO
         yweHuF4CgaOUXGbXOO2AzYm8JRNY1+zhgWvIbEh++s2YJNE6KEgoVAOGbzjJQuOz3T
         Ps21mUYFOiHcBNJ841A2j6cAz0CFIzsBTAMNBoJeOOm3aQjHT5RWZwXF7VPEkFy/ME
         oDGs8OBWyupAHjYxN5RvdfQ6ZjesnesGswaaMPE185Le99b6b9SQ7nhagQM6Xof7xA
         353xNFLtxVURLps1Ob90qm26b/CwYs0opjnzdu3RQvRqyXzH/C+HNJfwPpgDqAqzqx
         obAd3959ITzKQ==
Date:   Wed, 6 Oct 2021 12:30:41 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Aharon Landau <aharonl@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Avoid taking MRs from larger MR
 cache pools when a pool is empty
Message-ID: <YV1swbl1VMQqoR1x@unreal>
References: <71af2770c737b936f7b10f457f0ef303ffcf7ad7.1632644527.git.leonro@nvidia.com>
 <20211004230003.GA2602856@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004230003.GA2602856@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 04, 2021 at 08:00:03PM -0300, Jason Gunthorpe wrote:
> On Sun, Sep 26, 2021 at 11:31:43AM +0300, Leon Romanovsky wrote:
> > From: Aharon Landau <aharonl@nvidia.com>
> > 
> > Currently, if a cache entry is empty, the driver will try to take MRs
> > from larger cache entries. This behavior consumes a lot of memory.
> > In addition, when searching for an mkey in an entry, the entry is locked.
> > When using a multithreaded application with the old behavior, the threads
> > will block each other more often, which can hurt performance as can be
> > seen in the table below.
> > 
> > Therefore, avoid it by creating a new mkey when the requested cache entry
> > is empty.
> > 
> > The test was performed on a machine with
> > Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz 44 cores.
> > 
> > Here are the time measures for allocating MRs of 2^6 pages. The search in
> > the cache started from entry 6.
> > 
> > +------------+---------------------+---------------------+
> > |            |     Old behavior    |     New behavior    |
> > |            +----------+----------+----------+----------+
> > |            | 1 thread | 5 thread | 1 thread | 5 thread |
> > +============+==========+==========+==========+==========+
> > |  1,000 MRs |   14 ms  |   30 ms  |   14 ms  |   80 ms  |
> > +------------+----------+----------+----------+----------+
> > | 10,000 MRs |  135 ms  |   6 sec  |  173 ms  |  880 ms  |
> > +------------+----------+----------+----------+----------+
> > |100,000 MRs | 11.2 sec |  57 sec  | 1.74 sec |  8.8 sec |
> > +------------+----------+----------+----------+----------+
> > 
> > Signed-off-by: Aharon Landau <aharonl@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/infiniband/hw/mlx5/mr.c | 26 +++++++++-----------------
> >  1 file changed, 9 insertions(+), 17 deletions(-)
> 
> I'm surprised the cost is so high, I assume this has alot to do with
> repeated calls to queue_adjust_cache_locked()? Maybe this should be
> further investigated?

I don't think so, most of the overhead comes from entry lock, which
effectively stops any change to that shared entry.

> 
> Anyhow, applied to for-next, thanks

Thanks

> 
> Jason
