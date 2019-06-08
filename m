Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06D7E399FE
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jun 2019 03:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbfFHBNs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jun 2019 21:13:48 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11337 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728536AbfFHBNs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jun 2019 21:13:48 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cfb0bc90000>; Fri, 07 Jun 2019 18:13:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 07 Jun 2019 18:13:47 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 07 Jun 2019 18:13:47 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 8 Jun
 2019 01:13:46 +0000
Subject: Re: [PATCH v2 hmm 01/11] mm/hmm: fix use after free with struct hmm
 in the mmu notifiers
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        <Felix.Kuehling@amd.com>, <linux-rdma@vger.kernel.org>,
        <linux-mm@kvack.org>, Andrea Arcangeli <aarcange@redhat.com>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
References: <20190606184438.31646-1-jgg@ziepe.ca>
 <20190606184438.31646-2-jgg@ziepe.ca>
 <9c72d18d-2924-cb90-ea44-7cd4b10b5bc2@nvidia.com>
 <20190607123432.GB14802@ziepe.ca>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <1b3916b8-fcf0-3a11-1cd8-223fc8e60ac1@nvidia.com>
Date:   Fri, 7 Jun 2019 18:13:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190607123432.GB14802@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559956425; bh=uiPsFTVMNBBi8QlzP+NhgiuB1J/ANB5gJR02GD6ywIc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=SzYmAOHzQcQHZcZQepC2C4sEoMsTl8f1jPKE1PnsyZJ/ap9CeBbaoX8p4Uqwe7fjw
         iL8f8FtsIZMdEtfURvHBm68zj3tCm+12mMLKimRtnuE4YhAitzFOU5MKDwXRyjCeYO
         5deRY3zjyiX3Ix5CKxv9aSy7KMe+7ccCCysTafCkZ4U1HBhk4PPIWSgCSrdZB6YXq1
         IDqqkAglq+MdtTdF0Ow6aPH2DHxVbL8zqacY9v6JH+nR8KPh5yDkgmGKO2SHsst6Cz
         aVmO18nZ4ypXY18hqKo0R9gDDhJ/FscYVwyWlur4hC5L38VcU2aI3sq/un5/chhvEL
         vIvvlsKGNdDuQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/7/19 5:34 AM, Jason Gunthorpe wrote:
> On Thu, Jun 06, 2019 at 07:29:08PM -0700, John Hubbard wrote:
>> On 6/6/19 11:44 AM, Jason Gunthorpe wrote:
>>> From: Jason Gunthorpe <jgg@mellanox.com>
>> ...
>>> diff --git a/mm/hmm.c b/mm/hmm.c
>>> index 8e7403f081f44a..547002f56a163d 100644
>>> +++ b/mm/hmm.c
>> ...
>>> @@ -125,7 +130,7 @@ static void hmm_free(struct kref *kref)
>>>  		mm->hmm = NULL;
>>>  	spin_unlock(&mm->page_table_lock);
>>>  
>>> -	kfree(hmm);
>>> +	mmu_notifier_call_srcu(&hmm->rcu, hmm_free_rcu);
>>
>>
>> It occurred to me to wonder if it is best to use the MMU notifier's
>> instance of srcu, instead of creating a separate instance for HMM.
> 
> It *has* to be the MMU notifier SRCU because we are synchornizing
> against the read side of that SRU inside the mmu notifier code, ie:
> 
> int __mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
>         id = srcu_read_lock(&srcu);
>         hlist_for_each_entry_rcu(mn, &range->mm->mmu_notifier_mm->list, hlist) {
>                 if (mn->ops->invalidate_range_start) {
>                    ^^^^^
> 
> Here 'mn' is really hmm (hmm = container_of(mn, struct hmm,
> mmu_notifier)), so we must protect the memory against free for the mmu
> notifier core.
> 
> Thus we have no choice but to use its SRCU.

Ah right. It's embarassingly obvious when you say it out loud. :) 
Thanks for explaining.

> 
> CH also pointed out a more elegant solution, which is to get the write
> side of the mmap_sem during hmm_mirror_unregister - no notifier
> callback can be running in this case. Then we delete the kref, srcu
> and so forth.
> 
> This is much clearer/saner/better, but.. requries the callers of
> hmm_mirror_unregister to be safe to get the mmap_sem write side.
> 
> I think this is true, so maybe this patch should be switched, what do
> you think?

OK, your follow-up notes that we'll leave it as is, got it.


thanks,
-- 
John Hubbard
NVIDIA
