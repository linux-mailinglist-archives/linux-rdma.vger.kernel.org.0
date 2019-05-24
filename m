Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB39029C99
	for <lists+linux-rdma@lfdr.de>; Fri, 24 May 2019 18:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390804AbfEXQ7d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 May 2019 12:59:33 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:41480 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390210AbfEXQ7d (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 May 2019 12:59:33 -0400
Received: by mail-ua1-f65.google.com with SMTP id l14so3841742uah.8
        for <linux-rdma@vger.kernel.org>; Fri, 24 May 2019 09:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O9bMjKCyr7eNelVQt8Zjl1TFCNvm0TrsCVv9SV5F2LA=;
        b=HrCziIIgnkfF6lnXZ9I93PRqTjpRSMycNPK6S9UnR++m//3vRAc2gt5C6JjLlu7y91
         EChv41pTNRKeh3Lfe2OVbQw3LV/q1HRxCZ18sTGXDYQrAXNfPEuZYbDD+3wPqpNLJlMe
         zvwBDd4SfbF5JZClyBUra+5k2sbDB/c3Bs3MpNhnp25dqW3dqi2Ts8wyvsKX8w1bUcBn
         LlOkyGzBIz4QCHZf7hkoLlRp7hZ7flsPqVMqx8GZE3mvBzaUQnd0qJ2KDgk1J6LHLwhr
         thF4EEDyFxbeYWxe96Jr5GRyEUnhExvyJjfZXSUtoSj5thcJFZc1QFlT7anNaqWFByPj
         0qkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O9bMjKCyr7eNelVQt8Zjl1TFCNvm0TrsCVv9SV5F2LA=;
        b=MWX36X+v3HwDdP+urg4yRkGN2SIK6I07XmTd7ecrYNF/ILDLMgrETxImNxiTs3PrF2
         7nkaS3pR5CQakw5LyPjngdO92cMInojdE/HcU+oHdZIcLvAM8GUvI+29PoXmIxRcUy/K
         R+0MBGfoxadiDqygk55hjQ687kO5EaFTKcCS3hnHXJ/C0+dm1qgz2D4tC+WcaIoKwbVG
         G0/VYNyVD3zudFHbGsntiySNose4q2e+RngmtKRejRF4G8ZA4/6t/xB5e2g98qc4R8E/
         VIoN6JkELAYlcNn7NVvLnfx7VRofQ7YDPh60iwf5/WfLtTIaDvOKuO1h51tABVtHzxwh
         Y16A==
X-Gm-Message-State: APjAAAVfMWcxpM1TZujok9FMxsqan0ub7a1QQ0bbaZDgDwce8gXRIEJf
        VuYWFB65HiBkZggCpbBBwdzyOA==
X-Google-Smtp-Source: APXvYqzCugFsX5gP7tzOEzB1injnMH4R7g32RSkMVvqSHiKmxtd7YAkP43CL3FRq24fYgKSISuo1ag==
X-Received: by 2002:ab0:688b:: with SMTP id t11mr16535128uar.70.1558717172439;
        Fri, 24 May 2019 09:59:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id n23sm1918465vsj.27.2019.05.24.09.59.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 09:59:31 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hUDXX-0008IP-GX; Fri, 24 May 2019 13:59:31 -0300
Date:   Fri, 24 May 2019 13:59:31 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-mm@kvack.org,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 00/11] mm/hmm: Various revisions from a locking/code
 review
Message-ID: <20190524165931.GF16845@ziepe.ca>
References: <20190523153436.19102-1-jgg@ziepe.ca>
 <20190524143649.GA14258@ziepe.ca>
 <20190524164902.GA3346@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524164902.GA3346@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 24, 2019 at 12:49:02PM -0400, Jerome Glisse wrote:
> On Fri, May 24, 2019 at 11:36:49AM -0300, Jason Gunthorpe wrote:
> > On Thu, May 23, 2019 at 12:34:25PM -0300, Jason Gunthorpe wrote:
> > > From: Jason Gunthorpe <jgg@mellanox.com>
> > > 
> > > This patch series arised out of discussions with Jerome when looking at the
> > > ODP changes, particularly informed by use after free races we have already
> > > found and fixed in the ODP code (thanks to syzkaller) working with mmu
> > > notifiers, and the discussion with Ralph on how to resolve the lifetime model.
> > 
> > So the last big difference with ODP's flow is how 'range->valid'
> > works.
> > 
> > In ODP this was done using the rwsem umem->umem_rwsem which is
> > obtained for read in invalidate_start and released in invalidate_end.
> > 
> > Then any other threads that wish to only work on a umem which is not
> > undergoing invalidation will obtain the write side of the lock, and
> > within that lock's critical section the virtual address range is known
> > to not be invalidating.
> > 
> > I cannot understand how hmm gets to the same approach. It has
> > range->valid, but it is not locked by anything that I can see, so when
> > we test it in places like hmm_range_fault it seems useless..
> > 
> > Jerome, how does this work?
> > 
> > I have a feeling we should copy the approach from ODP and use an
> > actual lock here.
> 
> range->valid is use as bail early if invalidation is happening in
> hmm_range_fault() to avoid doing useless work. The synchronization
> is explained in the documentation:

That just says the hmm APIs handle locking. I asked how the apis
implement that locking internally.

Are you trying to say that if I do this, hmm will still work completely
correctly?

diff --git a/mm/hmm.c b/mm/hmm.c
index 8396a65710e304..42977744855d26 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -981,8 +981,8 @@ long hmm_range_snapshot(struct hmm_range *range)
 
 	do {
 		/* If range is no longer valid force retry. */
-		if (!range->valid)
-			return -EAGAIN;
+/*		if (!range->valid)
+			return -EAGAIN;*/
 
 		vma = find_vma(hmm->mm, start);
 		if (vma == NULL || (vma->vm_flags & device_vma))
@@ -1080,10 +1080,10 @@ long hmm_range_fault(struct hmm_range *range, bool block)
 
 	do {
 		/* If range is no longer valid force retry. */
-		if (!range->valid) {
+/*		if (!range->valid) {
 			up_read(&hmm->mm->mmap_sem);
 			return -EAGAIN;
-		}
+		}*/
 
 		vma = find_vma(hmm->mm, start);
 		if (vma == NULL || (vma->vm_flags & device_vma))
@@ -1134,7 +1134,7 @@ long hmm_range_fault(struct hmm_range *range, bool block)
 			start = hmm_vma_walk.last;
 
 			/* Keep trying while the range is valid. */
-		} while (ret == -EBUSY && range->valid);
+		} while (ret == -EBUSY /*&& range->valid*/);
 
 		if (ret) {
 			unsigned long i;
