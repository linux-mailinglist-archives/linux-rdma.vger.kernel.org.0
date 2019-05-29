Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 581BF2E572
	for <lists+linux-rdma@lfdr.de>; Wed, 29 May 2019 21:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfE2TgL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 May 2019 15:36:11 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:8841 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfE2TgL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 May 2019 15:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559158570; x=1590694570;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=YKajrDtX0rNQjdWEoEEvUwwG2BX/2Oe62zvzqEJ3UNw=;
  b=kz2GrTjaxb1fVzF0vI01uCUu3KpRaq+R1+x2+2QQxsmnMR1EDglp37f3
   uv5KZUfCEJlFFDf6QTiu8EKXm9pRvSNkb1rlPuV6vKrTaZlGP0lph7vzB
   lBngoqtUbEHcAdY3JHHbPbORT9DVVlZ9lpjCgG9aPmV+BjDjBqT0hRhrQ
   I=;
X-IronPort-AV: E=Sophos;i="5.60,527,1549929600"; 
   d="scan'208";a="768167853"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-69849ee2.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 29 May 2019 19:36:08 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-69849ee2.us-west-2.amazon.com (Postfix) with ESMTPS id 3E6D1A2055;
        Wed, 29 May 2019 19:36:08 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 29 May 2019 19:36:07 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.161.145) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 29 May 2019 19:36:03 +0000
Subject: Re: [PATCH for-rc 4/6] RDMA/efa: Use API to get contiguous memory
 blocks aligned to device supported page size
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Firas JahJah <firasj@amazon.com>
References: <20190528124618.77918-1-galpress@amazon.com>
 <20190528124618.77918-5-galpress@amazon.com>
 <20190529161938.GA14765@ziepe.ca>
 <9DD61F30A802C4429A01CA4200E302A7A5B07AB2@fmsmsx124.amr.corp.intel.com>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <0bb01352-1300-b624-d8f6-055e8df8dbd3@amazon.com>
Date:   Wed, 29 May 2019 22:35:58 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <9DD61F30A802C4429A01CA4200E302A7A5B07AB2@fmsmsx124.amr.corp.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.145]
X-ClientProxiedBy: EX13D02UWB002.ant.amazon.com (10.43.161.160) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 29/05/2019 20:20, Saleem, Shiraz wrote:
>> Subject: Re: [PATCH for-rc 4/6] RDMA/efa: Use API to get contiguous memory
>> blocks aligned to device supported page size
>>
>> On Tue, May 28, 2019 at 03:46:16PM +0300, Gal Pressman wrote:
>>> @@ -1500,13 +1443,17 @@ struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64
>> start, u64 length,
>>>  	params.iova = virt_addr;
>>>  	params.mr_length_in_bytes = length;
>>>  	params.permissions = access_flags & 0x1;
>>> -	max_page_shift = fls64(dev->dev_attr.page_size_cap);
>>>
>>> -	efa_cont_pages(mr->umem, start, max_page_shift, &npages,
>>> -		       &params.page_shift, &params.page_num);
>>> +	pg_sz = ib_umem_find_best_pgsz(mr->umem,
>>> +				       dev->dev_attr.page_size_cap,
>>> +				       virt_addr);
>>
>> I think this needs to check pg_sz is not zero..
>>
> 
> What is the smallest page size this driver supports?

The page size capability is queried from the device, the smallest page size is
currently 4k.

Isn't PAGE_SIZE always supported? What did drivers do before
ib_umem_find_best_pgsz() existed in case they didn't support PAGE_SIZE?

I doubt there is/will be a real use-case where it matters for EFA, but I can add
the check to be on the safe side.
