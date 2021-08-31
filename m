Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7817C3FC6E7
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Aug 2021 14:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbhHaMBG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 31 Aug 2021 08:01:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231628AbhHaMBG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 31 Aug 2021 08:01:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DC9B60698;
        Tue, 31 Aug 2021 12:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630411211;
        bh=ZFNfZfl6mxHUw1BbBnsrpBxFD/PkIeH8i0iIstK7Ax0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qwa98a0S/WoF27sbrqu6L5GbtO7FRvnn67IpsP9e51mw5236R/LddXVcCxB6Mr8/1
         AvnTXGJQPIG2gxlXoJZJ7Wn8LScNgQVmK5mZbgkEpW6bU5so7HtaNOob0Vtx+pLbxl
         kjegD7XFZT7p4WtiexRLVBlKDvGf6JFpvmswSet+ppf0uxLEtF+T2nQC20T6dhdZOj
         U7Ro1riXh95Ku5NOJcRAySwVnYXg7fIminTBWfVw0o1s46WKllEdPTuFUsoNo8sTyD
         88S1kGKTQ1+qyxq1LtG47JRmMmJ+NNeL8wtpTiUNbXxvR78Gn5rReSkzMZGvMc4mW4
         Wvd5fr6LrQXxQ==
Date:   Tue, 31 Aug 2021 15:00:07 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     =?utf-8?B?5bq35a6B?= <kangning18z@ict.ac.cn>
Cc:     haakon.bugge@oracle.com, linux-rdma@vger.kernel.org
Subject: Re: Re: [PATCH v3] Fix one error in mthca_alloc
Message-ID: <YS4Zx30hAa9FuL5E@unreal>
References: <20210827005228.15671-1-kangning18z@ict.ac.cn>
 <YS371Qgef1FTTrHZ@unreal>
 <30f8792b.1e35e.17b9bcbf058.Coremail.kangning18z@ict.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <30f8792b.1e35e.17b9bcbf058.Coremail.kangning18z@ict.ac.cn>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 31, 2021 at 06:40:38PM +0800, 康宁 wrote:
> &gt; 
> &gt; On Fri, Aug 27, 2021 at 08:52:28AM +0800, kangning wrote:
> &gt; &gt; drivers/infiniband/hw/mthca/mthca_allocator.c: alloc-&gt;last left unchanged in mthca_alloc, which
> &gt; &gt; has impact on performance of function find_next_zero_bit in mthca_alloc.
> &gt; 
> &gt; I don't know what the sentence above means, but the change is unlikely
> &gt; to be correct.
> &gt; 
> &gt; When alloc-&gt;last starts to be equal to alloc-&gt;max, the
> &gt; find_next_zero_bit() will always return alloc-&gt;max. which will ensure
> &gt; that the following code is executed.
> &gt; 
> &gt;    48         if (obj &gt;= alloc-&gt;max) {
> &gt;    49                 alloc-&gt;top = (alloc-&gt;top + alloc-&gt;max) &amp; alloc-&gt;mask;
> &gt;    50                 obj = find_first_zero_bit(alloc-&gt;table, alloc-&gt;max);
> &gt;    51         }
> &gt; 
> 
> Thanks for your review.
> Yes, your analysis is right. However, this is a bitmap allocator for resource id allocation (like QP, and CQ). 
> We first look at the situation where no resource id is released.
> When the value of alloc-&gt;last starts to reaches alloc-&gt;max, the bitmap will 
> be full. In this case, it's normal to return an invalid value.
> 
> Now, let's add resource releasing into consideration. 
> The following code is part of mthca_free：
> 
> 70	spin_lock_irqsave(&amp;alloc-&gt;lock, flags);
> 71
> 72	clear_bit(obj, alloc-&gt;table);
> 73	alloc-&gt;last = min(alloc-&gt;last, obj);
> 74	alloc-&gt;top = (alloc-&gt;top + alloc-&gt;max) &amp; alloc-&gt;mask;
> 
> mthca_free() is used to release the allocated resource id. It will update alloc-&gt;last when obj is freed. 
> So, if the bitmap has space for allocation, my modification can continuously work.

After alloc->last starts to be equal to alloc->max, the bitmap is
searches with find_first_zero_bit() call. That will ensure that we look
for any bit between 0 and alloc->max.

So no, your change can't be right.

Thanks

> 
> &gt; 
> &gt; However the mthca_alloc() function has other error, it returns -1 while
> &gt; based on its declaration it needs to be unsigned,
> 
> I think you are right about this. But obj is the return value of u32 type, which is the requirement of resource id 
> (though it may not fully use 32 bits). I have no idea of how to fix it.
> 
> Thanks.
> 
> &gt; 
> &gt; Thanks
> &gt; 
> &gt; &gt; 
> &gt; &gt; Signed-off-by: kangning <kangning18z@ict.ac.cn>
> &gt; &gt; ---
> &gt; &gt;  
> &gt; &gt;  I squashed two commits into one in this version.
> &gt; &gt;  
> &gt; &gt;  drivers/infiniband/hw/mthca/mthca_allocator.c | 3 +++
> &gt; &gt;  1 file changed, 3 insertions(+)
> &gt; &gt; 
> &gt; &gt; diff --git a/drivers/infiniband/hw/mthca/mthca_allocator.c b/drivers/infiniband/hw/mthca/mthca_allocator.c
> &gt; &gt; index aef1d274a14e..1141695093e7 100644
> &gt; &gt; --- a/drivers/infiniband/hw/mthca/mthca_allocator.c
> &gt; &gt; +++ b/drivers/infiniband/hw/mthca/mthca_allocator.c
> &gt; &gt; @@ -51,6 +51,9 @@ u32 mthca_alloc(struct mthca_alloc *alloc)
> &gt; &gt;  	}
> &gt; &gt;  
> &gt; &gt;  	if (obj &lt; alloc-&gt;max) {
> &gt; &gt; +		alloc-&gt;last = obj + 1;
> &gt; &gt; +		if (alloc-&gt;last == alloc-&gt;max)
> &gt; &gt; +			alloc-&gt;last = 0;
> &gt; &gt;  		set_bit(obj, alloc-&gt;table);
> &gt; &gt;  		obj |= alloc-&gt;top;
> &gt; &gt;  	} else
> &gt; &gt; -- 
> &gt; &gt; 2.17.1
> &gt; &gt; 
> </kangning18z@ict.ac.cn>
