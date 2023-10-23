Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C707D29D0
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Oct 2023 07:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjJWFwg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Oct 2023 01:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJWFwf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Oct 2023 01:52:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135FEFC
        for <linux-rdma@vger.kernel.org>; Sun, 22 Oct 2023 22:52:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33717C433C8;
        Mon, 23 Oct 2023 05:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698040353;
        bh=c5e/xj++UlvFH63sLD+CL1Bh5xshEaNjBymMUOkp9mM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f2DoiuLwo7NGf5IeCzrDxOeExaNpR8NbjkpJs4rf2zwN67g2Q+/R9tMOlJw+MxPS+
         ibZ4toyXnVSlp5tq4jrjMTXlFYUbc4NSHEXjX3QeNxn/ZWf4pXeLkJaeIX/HenAVZO
         hUg9UUVHpRJ/kA0U+a6uZzhC2KuMCXySx6+vNOg0a+PYyO8+AW35yiZOmlr+J5YARO
         PAvorqVe/KsYTgSjr38U9zAjjy208bJ4eWbDYbPjkVNzY9kPHapQQ9E1CHSwSnJ6fi
         5jryWh4KX9jztveEIH3LmQIVR8BB1DRojFLc5Go5CWUgCLfsCoVQ67oz2lG2dfZr0o
         0O90RWnH0xDyg==
Date:   Mon, 23 Oct 2023 08:52:29 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     Maxim Samoylov <max7255@meta.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Christian Benvenuti <benve@cisco.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH v2] IB: rework memlock limit handling code
Message-ID: <20231023055229.GB10551@unreal>
References: <20231012082921.546114-1-max7255@meta.com>
 <20231015091959.GC25776@unreal>
 <5fcf502d-71fb-123d-f6ff-f3ffb7c3ba1a@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fcf502d-71fb-123d-f6ff-f3ffb7c3ba1a@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 23, 2023 at 09:40:16AM +0800, Guoqing Jiang wrote:
> 
> 
> On 10/15/23 17:19, Leon Romanovsky wrote:
> > On Thu, Oct 12, 2023 at 01:29:21AM -0700, Maxim Samoylov wrote:
> > > This patch provides the uniform handling for RLIM_INFINITY value
> > > across the infiniband/rdma subsystem.
> > > 
> > > Currently in some cases the infinity constant is treated
> > > as an actual limit value, which could be misleading.
> > > 
> > > Let's also provide the single helper to check against process
> > > MEMLOCK limit while registering user memory region mappings.
> > > 
> > > Signed-off-by: Maxim Samoylov<max7255@meta.com>
> > > ---
> > > 
> > > v1 -> v2: rewritten commit message, rebased on recent upstream
> > > 
> > >   drivers/infiniband/core/umem.c             |  7 ++-----
> > >   drivers/infiniband/hw/qib/qib_user_pages.c |  7 +++----
> > >   drivers/infiniband/hw/usnic/usnic_uiom.c   |  6 ++----
> > >   drivers/infiniband/sw/siw/siw_mem.c        |  6 +++---
> > >   drivers/infiniband/sw/siw/siw_verbs.c      | 23 ++++++++++------------
> > >   include/rdma/ib_umem.h                     | 11 +++++++++++
> > >   6 files changed, 31 insertions(+), 29 deletions(-)
> > <...>
> > 
> > > @@ -1321,8 +1322,8 @@ struct ib_mr *siw_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
> > >   	struct siw_umem *umem = NULL;
> > >   	struct siw_ureq_reg_mr ureq;
> > >   	struct siw_device *sdev = to_siw_dev(pd->device);
> > > -
> > > -	unsigned long mem_limit = rlimit(RLIMIT_MEMLOCK);
> > > +	unsigned long num_pages =
> > > +		(PAGE_ALIGN(len + (start & ~PAGE_MASK))) >> PAGE_SHIFT;
> > >   	int rv;
> > >   	siw_dbg_pd(pd, "start: 0x%pK, va: 0x%pK, len: %llu\n",
> > > @@ -1338,19 +1339,15 @@ struct ib_mr *siw_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
> > >   		rv = -EINVAL;
> > >   		goto err_out;
> > >   	}
> > > -	if (mem_limit != RLIM_INFINITY) {
> > > -		unsigned long num_pages =
> > > -			(PAGE_ALIGN(len + (start & ~PAGE_MASK))) >> PAGE_SHIFT;
> > > -		mem_limit >>= PAGE_SHIFT;
> > > -		if (num_pages > mem_limit - current->mm->locked_vm) {
> > > -			siw_dbg_pd(pd, "pages req %lu, max %lu, lock %lu\n",
> > > -				   num_pages, mem_limit,
> > > -				   current->mm->locked_vm);
> > > -			rv = -ENOMEM;
> > > -			goto err_out;
> > > -		}
> > > +	if (!ib_umem_check_rlimit_memlock(num_pages + current->mm->locked_vm)) {
> > > +		siw_dbg_pd(pd, "pages req %lu, max %lu, lock %lu\n",
> > > +				num_pages, rlimit(RLIMIT_MEMLOCK),
> > > +				current->mm->locked_vm);
> > > +		rv = -ENOMEM;
> > > +		goto err_out;
> > >   	}
> > Sorry for late response, but why does this hunk exist in first place?
> > 
> > > +
> > >   	umem = siw_umem_get(start, len, ib_access_writable(rights));
> > This should be ib_umem_get().
> 
> IMO, it deserves a separate patch, and replace siw_umem_get with ib_umem_get
> is not straightforward given siw_mem has two types of memory (pbl and umem).

The thing is that once you convince yourself that SIW should use ib_umem_get(),
the same question will arise for other parts of this patch where
ib_umem_check_rlimit_memlock() is used.

And if we eliminate them all, there won't be a need for this new API call at all.

Thanks

> 
> Thanks,
> Guoqing
