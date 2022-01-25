Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0011049ADB6
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jan 2022 08:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377074AbiAYHhe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jan 2022 02:37:34 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46582 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351469AbiAYHev (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jan 2022 02:34:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F1956130E
        for <linux-rdma@vger.kernel.org>; Tue, 25 Jan 2022 07:34:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AAA3C340E0;
        Tue, 25 Jan 2022 07:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643096089;
        bh=Bcyk4r2K3BJd/kzY1EhnDrguesa5CbZAQJadl/G9hFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=te2L72Jn4Kjotyb6v6Kj+GkEWHOGXQV2kk9MZ2dmKiz/R+pLBN3URDn9Hze6ltxJw
         cQhZSRnWZyaerUeQkhMRJtxfQeoFKxewgA3HM5CXItFqdeWAWFabkB8/WpapyPqZlN
         SXhsZXryXSNv0+lTY684DQ+goFhhyM/Iy3FMoEoKRuNJpi0w2PwUbdazNBa6PUJeLQ
         TwM9ZBxuDjzYiuH6CgNjARsq0LdismyCFKht102ScyAGXoOzCJg6XVxNZ/qi0VmH1B
         vE7HFY7Py10VZzKVBzRQqQPzD7dr4EnEBOvaruPc9rLQafvYXK/c4SxrTQm+MoqTwU
         N70E5UVl78JDQ==
Date:   Tue, 25 Jan 2022 09:34:44 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
Cc:     Haakon Bugge <haakon.bugge@oracle.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-rc] IB/rdmavt: Validate remote_addr during loopback
 atomic tests
Message-ID: <Ye+oFAX/GzOD3MzU@unreal>
References: <1642584489-141005-1-git-send-email-mike.marciniszyn@cornelisnetworks.com>
 <Ye0vPMAF6NdF0pMu@unreal>
 <E3A123CC-3C34-4EE9-BF6E-3F9FEF04A939@oracle.com>
 <Ye6cry944qSVHi6z@unreal>
 <4579CC13-F537-4F54-887B-B9CFB570DE43@oracle.com>
 <CH0PR01MB7153A251BF2D1F2C4A8ACFDAF25E9@CH0PR01MB7153.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH0PR01MB7153A251BF2D1F2C4A8ACFDAF25E9@CH0PR01MB7153.prod.exchangelabs.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 24, 2022 at 01:20:56PM +0000, Marciniszyn, Mike wrote:
> > From: Haakon Bugge <haakon.bugge@oracle.com>
> > Sent: Monday, January 24, 2022 7:44 AM
> > To: Leon Romanovsky <leon@kernel.org>
> > Cc: Marciniszyn, Mike <mike.marciniszyn@cornelisnetworks.com>;
> > jgg@ziepe.ca; OFED mailing list <linux-rdma@vger.kernel.org>
> > Subject: Re: [PATCH for-rc] IB/rdmavt: Validate remote_addr during
> > loopback atomic tests
> > > And is IBTA restriction applicable to hfi1?
> > 
> > For hfi1, I do not know. But this fix was in drivers/infiniband/sw/rdmavt, for
> > which the first commit message states:
> > 
> >  This patch introduces the basics for a new module called rdma_vt. This new
> >     driver is a software implementation of the InfiniBand verbs...
> > 
> > 
> > More importantly, the check we discuss is not about being page-aligned, but
> > about being naturally aligned, right?
> > 
> 
> Hardware supported by rdamvt strives to be 100% compatible with the verbs API.
> 
> And yes, the natural alignment is the objective for the test.
> 
> According to the IB Spec (V1-Rel1.2.1 section 9.4.5 ATOMIC OPERATIONS):
>         "The virtual address in the ATOMIC Command Request packet shall
>         be naturally aligned to an 8 byte boundary. The responding CA
>         checks this and returns an Invalid Request NAK if it is not naturally
>         aligned."
> 
> The recent additions to the rdma-core test suite caught this issue.
> 
> The test is consistent with input packet parsing:
> 
>         case OP(COMPARE_SWAP):
>         case OP(FETCH_ADD): {
> <snip>
>                 if (unlikely(vaddr & (sizeof(u64) - 1)))
>                         goto nack_inv_unlck;

I see, thanks Mike and Haakon.

