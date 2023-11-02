Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AC67DF274
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Nov 2023 13:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347360AbjKBMcY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Nov 2023 08:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345993AbjKBMcX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Nov 2023 08:32:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C56112
        for <linux-rdma@vger.kernel.org>; Thu,  2 Nov 2023 05:32:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BF9C433C7;
        Thu,  2 Nov 2023 12:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698928340;
        bh=DkUXd46otsJWfRY3oEiVnOzehyH5Ghvb1Jd4QF6lQEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iqwwr413V+akq7R3afJNaobAFRXuIhlHj6oR4b6iuooDovhIqlfTArarD26ff33uP
         VSe3qqP403J74iHnJIGWkALsyTfylqUCiIF1OhIHSp+xc/w/Mg/QQ/tCcR9XZqCpG4
         EKbjxpAF+bLZDro0hFkVLeuS0+3jistIO//l5vnek5fLeqB5yEsxp9Mk7kF86V6aKX
         tMEMxz/+usYhYVTWBG5jTaefQ4incED0C5uXvwYbKsyTJRtFxSLX3c226Kx3/SDkO7
         bvL+gTXD26/g/w8E28rNJMZ/gQ9guxTc/qhclJSSd0AnKxLAawMCxu/m+MtTt0gpuX
         9WzyE/2GgNh4A==
Date:   Thu, 2 Nov 2023 14:32:16 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Maxim Samoylov <max7255@meta.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian Benvenuti <benve@cisco.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH v2] IB: rework memlock limit handling code
Message-ID: <20231102123216.GF5885@unreal>
References: <20231012082921.546114-1-max7255@meta.com>
 <20231015091959.GC25776@unreal>
 <5fcf502d-71fb-123d-f6ff-f3ffb7c3ba1a@linux.dev>
 <20231023055229.GB10551@unreal>
 <bbefb351-92a2-409f-8bda-f6b5eef8cedc@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbefb351-92a2-409f-8bda-f6b5eef8cedc@meta.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 31, 2023 at 01:30:27PM +0000, Maxim Samoylov wrote:
> On 23/10/2023 07:52, Leon Romanovsky wrote:
> > On Mon, Oct 23, 2023 at 09:40:16AM +0800, Guoqing Jiang wrote:
> >>
> >>
> >> On 10/15/23 17:19, Leon Romanovsky wrote:
> >>> On Thu, Oct 12, 2023 at 01:29:21AM -0700, Maxim Samoylov wrote:
> >>>> This patch provides the uniform handling for RLIM_INFINITY value
> >>>> across the infiniband/rdma subsystem.
> >>>>
> >>>> Currently in some cases the infinity constant is treated
> >>>> as an actual limit value, which could be misleading.
> >>>>
> >>>> Let's also provide the single helper to check against process
> >>>> MEMLOCK limit while registering user memory region mappings.
> >>>>
> >>>> Signed-off-by: Maxim Samoylov<max7255@meta.com>
> >>>> ---
> >>>>
> >>>> v1 -> v2: rewritten commit message, rebased on recent upstream
> >>>>
> >>>>    drivers/infiniband/core/umem.c             |  7 ++-----
> >>>>    drivers/infiniband/hw/qib/qib_user_pages.c |  7 +++----
> >>>>    drivers/infiniband/hw/usnic/usnic_uiom.c   |  6 ++----
> >>>>    drivers/infiniband/sw/siw/siw_mem.c        |  6 +++---
> >>>>    drivers/infiniband/sw/siw/siw_verbs.c      | 23 ++++++++++------------
> >>>>    include/rdma/ib_umem.h                     | 11 +++++++++++
> >>>>    6 files changed, 31 insertions(+), 29 deletions(-)
> >>> <...>
> >>>
> >>>> @@ -1321,8 +1322,8 @@ struct ib_mr *siw_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
> >>>>    	struct siw_umem *umem = NULL;
> >>>>    	struct siw_ureq_reg_mr ureq;
> >>>>    	struct siw_device *sdev = to_siw_dev(pd->device);
> >>>> -
> >>>> -	unsigned long mem_limit = rlimit(RLIMIT_MEMLOCK);
> >>>> +	unsigned long num_pages =
> >>>> +		(PAGE_ALIGN(len + (start & ~PAGE_MASK))) >> PAGE_SHIFT;
> >>>>    	int rv;
> >>>>    	siw_dbg_pd(pd, "start: 0x%pK, va: 0x%pK, len: %llu\n",
> >>>> @@ -1338,19 +1339,15 @@ struct ib_mr *siw_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
> >>>>    		rv = -EINVAL;
> >>>>    		goto err_out;
> >>>>    	}
> >>>> -	if (mem_limit != RLIM_INFINITY) {
> >>>> -		unsigned long num_pages =
> >>>> -			(PAGE_ALIGN(len + (start & ~PAGE_MASK))) >> PAGE_SHIFT;
> >>>> -		mem_limit >>= PAGE_SHIFT;
> >>>> -		if (num_pages > mem_limit - current->mm->locked_vm) {
> >>>> -			siw_dbg_pd(pd, "pages req %lu, max %lu, lock %lu\n",
> >>>> -				   num_pages, mem_limit,
> >>>> -				   current->mm->locked_vm);
> >>>> -			rv = -ENOMEM;
> >>>> -			goto err_out;
> >>>> -		}
> >>>> +	if (!ib_umem_check_rlimit_memlock(num_pages + current->mm->locked_vm)) {
> >>>> +		siw_dbg_pd(pd, "pages req %lu, max %lu, lock %lu\n",
> >>>> +				num_pages, rlimit(RLIMIT_MEMLOCK),
> >>>> +				current->mm->locked_vm);
> >>>> +		rv = -ENOMEM;
> >>>> +		goto err_out;
> >>>>    	}
> >>> Sorry for late response, but why does this hunk exist in first place?
> >>>
> 
> Trailing newline, will definitely drop it.
> 
> >>>> +
> >>>>    	umem = siw_umem_get(start, len, ib_access_writable(rights));
> >>> This should be ib_umem_get().
> >>
> >> IMO, it deserves a separate patch, and replace siw_umem_get with ib_umem_get
> >> is not straightforward given siw_mem has two types of memory (pbl and umem).
> > 
> > The thing is that once you convince yourself that SIW should use ib_umem_get(),
> > the same question will arise for other parts of this patch where
> > ib_umem_check_rlimit_memlock() is used.
> > 
> > And if we eliminate them all, there won't be a need for this new API call at all.
> > 
> > Thanks
> >
> 
> Hi!
> 
> So, as for 31.10.2023 I still see siw_umem_get() call used in
> linux-rdma repo in "for-next" branch.

I hoped to hear some feedback from Bernard and Dennis.

> 
> AFAIU this helper call is used only in a single place and could
> potentially be replaced with ib_umem_get() as Leon suggests.
> 
> But should we perform it right inside this memlock helper patch?
> 
> I can submit later another patch with siw_umem_get() replaced
> if necessary.
> 
> 
> >>
> >> Thanks,
> >> Guoqing
> 
