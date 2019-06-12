Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4A304277C
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 15:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732380AbfFLN2m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 09:28:42 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:10212 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfFLN2l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jun 2019 09:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1560346121; x=1591882121;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Vb8f5ijLcWV1N5C8MvaLaQiKnyo7t4VZa9IbRm5YjAk=;
  b=BVrLnT+iX4ehz5ax8F9tgAnqcHdIsdMsU5OLKcLp85XxfeK4IRYxscbC
   xZPHC8IOqc0/uJ2rmtRP0f9fvE9dMBG15760lqNs2GoSIDMo+ImdMXcZq
   CfNGxB/AJcj14WaUCMteEv9AJSQVSgDjwrg9Lppeu9JS0GKYeRjdOAWBf
   4=;
X-IronPort-AV: E=Sophos;i="5.62,366,1554768000"; 
   d="scan'208";a="679507109"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 12 Jun 2019 13:28:37 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (Postfix) with ESMTPS id 7C314C5E0F;
        Wed, 12 Jun 2019 13:28:37 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 12 Jun 2019 13:28:37 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.57) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 12 Jun 2019 13:28:34 +0000
Subject: Re: [PATCH for-rc 2/2] RDMA/efa: Handle mmap insertions overflow
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>
References: <20190612072842.99285-1-galpress@amazon.com>
 <20190612072842.99285-3-galpress@amazon.com> <20190612120114.GD3876@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <eb0bbd15-cf37-eacc-a4ce-62becf045c38@amazon.com>
Date:   Wed, 12 Jun 2019 16:28:29 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612120114.GD3876@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.57]
X-ClientProxiedBy: EX13D13UWB003.ant.amazon.com (10.43.161.233) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/06/2019 15:01, Jason Gunthorpe wrote:
> On Wed, Jun 12, 2019 at 10:28:42AM +0300, Gal Pressman wrote:
>> When inserting a new mmap entry to the xarray we should check for
>> 'mmap_page' overflow as it is limited to 32 bits.
>>
>> While at it, make sure to advance the mmap_page stored on the ucontext
>> only after a successful insertion.
>>
>> Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")
>> Signed-off-by: Gal Pressman <galpress@amazon.com>
>>  drivers/infiniband/hw/efa/efa_verbs.c | 21 ++++++++++++++++-----
>>  1 file changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
>> index 0fea5d63fdbe..c463c683ae84 100644
>> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
>> @@ -204,6 +204,7 @@ static u64 mmap_entry_insert(struct efa_dev *dev, struct efa_ucontext *ucontext,
>>  			     void *obj, u64 address, u64 length, u8 mmap_flag)
>>  {
>>  	struct efa_mmap_entry *entry;
>> +	u32 next_mmap_page;
>>  	int err;
>>  
>>  	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
>> @@ -216,15 +217,19 @@ static u64 mmap_entry_insert(struct efa_dev *dev, struct efa_ucontext *ucontext,
>>  	entry->mmap_flag = mmap_flag;
>>  
>>  	xa_lock(&ucontext->mmap_xa);
>> +	if (check_add_overflow(ucontext->mmap_xa_page,
>> +			       (u32)(length >> PAGE_SHIFT),
>> +			       &next_mmap_page))
>> +		goto err_unlock;
>> +
>>  	entry->mmap_page = ucontext->mmap_xa_page;
>> -	ucontext->mmap_xa_page += DIV_ROUND_UP(length, PAGE_SIZE);
>>  	err = __xa_insert(&ucontext->mmap_xa, entry->mmap_page, entry,
>>  			  GFP_KERNEL);
>> +	if (err)
>> +		goto err_unlock;
>> +
>> +	ucontext->mmap_xa_page = next_mmap_page;
> 
> This is not ordered right anymore, the xa_lock can be released inside
> __xa_insert, so to be atomic you must do everything before calling
> __xa_insert.

Ah, missed the fact that __xa_insert could release the lock :\..
Thanks Jason, will bring back the mmap_xa_page assignment before the __xa_insert
call and unwind it in case of __xa_insert failure.
