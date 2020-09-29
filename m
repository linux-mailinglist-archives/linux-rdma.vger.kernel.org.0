Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB4827DA2B
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Sep 2020 23:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgI2VfS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Sep 2020 17:35:18 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11743 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgI2VfR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Sep 2020 17:35:17 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f73a8300000>; Tue, 29 Sep 2020 14:33:36 -0700
Received: from [172.27.0.26] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 29 Sep
 2020 21:35:14 +0000
Subject: Re: [PATCH rdma-next v2 1/4] IB/core: Improve ODP to use
 hmm_range_fault()
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>
References: <20200922082104.2148873-1-leon@kernel.org>
 <20200922082104.2148873-2-leon@kernel.org>
 <20200929192730.GB767138@nvidia.com>
 <089ce58a-a439-79b5-72ac-128d56002878@nvidia.com>
 <20200929201303.GG9475@nvidia.com>
From:   Yishai Hadas <yishaih@nvidia.com>
Message-ID: <c3b37733-f48b-bc97-9077-60dab5954702@nvidia.com>
Date:   Wed, 30 Sep 2020 00:34:55 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200929201303.GG9475@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601415216; bh=F7oPqqTsPj9yAVxmoDqQy16n+9FVlZna0tOv75D4LVI=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=AX67s85Pyo5WO6PToOgLfARxrE6CbWnMvlShwdB5XL5Bgn8jKGqUTfgfGgHlF+DiM
         u2W45Xgeu2RhLTBIn78WD0hUVd3q2t8N9jo+/6/aWdacZ3Xbt5hjmMe2KPZmW2f+Ft
         SrrTtluzP5Nd5qeWNRyWfNoO3CCT2CaXfQVrBcJsKB6ZV9MzU7WK8fyjS8IioKc3Ta
         PJzkTZOmpAMZySoi8xk8rFJipZdoctCNmTxMe8eLPJ2HkWqanwh0nk8BwfC2N27pOy
         +bPp6kjwSWEzvSEqPuxE9aNOVumRG1+gjmNJv13drHQv05KwR+wonE0gyN00xjzS8C
         5vm/31CKEmg8g==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/29/2020 11:13 PM, Jason Gunthorpe wrote:
>>>> +		WARN_ON(!(range.hmm_pfns[pfn_index] & HMM_PFN_VALID));
>>>> +		hmm_order = hmm_pfn_to_map_order(range.hmm_pfns[pfn_index]);
>>>> +		/* If a hugepage was detected and ODP wasn't set for, the umem
>>>> +		 * page_shift will be used, the opposite case is an error.
>>>> +		 */
>>>> +		if (hmm_order + PAGE_SHIFT < page_shift) {
>>>> +			ret = -EINVAL;
>>>> +			pr_debug("%s: un-expected hmm_order %d, page_shift %d\n",
>>>> +				 __func__, hmm_order, page_shift);
>>>>    			break;
>>>>    		}
>>> I think this break should be a continue here. There is no reason not
>>> to go to the next aligned PFN and try to sync as much as possible.
>> This might happen if the application didn't honor the contract to use
>> hugepages for the full range despite that it sets IB_ACCESS_HUGETLB, right ?
> Yes
>
>> Do we still need to sync as much as possible in that case ? I
>> believe that we may consider return an error in this case to let
>> application be aware of as was before this series.
> We might be prefetching or something weird where it could make sense.
>
>
In addition to my previous note here as of below [1], ignoring the clear 
error case might break some testing that expects to get an error in this 
case when the contract was not honored.

Also not sure how the HW will behave, won't that cause an extra / 
infinite call to the driver to page fault for the missing data as the 
result will be success but no dma will be provided ?
As of that I believe that better leave the code as is, what do you think ?


[1] "Not sure about the exact scenario rather than an application issue, 
this follows the original code in this area, maybe better sets an error 
in the clear application error."

Yishai

