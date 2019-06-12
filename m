Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 111E1427DB
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 15:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408450AbfFLNmk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 09:42:40 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:42362 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407111AbfFLNmk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jun 2019 09:42:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1560346959; x=1591882959;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=aSFd1lAJ3cIobNIu06L3vAMkryi9cHYdPSvIN+6gI2I=;
  b=D3hGx1XrpIUZo6Nyv31SPV7KyUks3/+YtSdqAQzpjoQa4Ic2GlV7Uihi
   78ld0lBQOjwW+vteR6HBPhBhnJHmkT61n/NNmqoM17EsAWPeWVPMdVu7w
   TnPsEZObrRPHvCcJy6en5p4xk2SYUnwqtUeOO4KJGvrlzdsj19UN6PjM5
   k=;
X-IronPort-AV: E=Sophos;i="5.62,366,1554768000"; 
   d="scan'208";a="406102820"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 12 Jun 2019 13:42:38 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id B278FA203E;
        Wed, 12 Jun 2019 13:42:37 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 12 Jun 2019 13:42:36 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.160.177) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 12 Jun 2019 13:42:34 +0000
Subject: Re: [PATCH for-rc 2/2] RDMA/efa: Handle mmap insertions overflow
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>
References: <20190612072842.99285-1-galpress@amazon.com>
 <20190612072842.99285-3-galpress@amazon.com> <20190612120114.GD3876@ziepe.ca>
 <eb0bbd15-cf37-eacc-a4ce-62becf045c38@amazon.com>
Message-ID: <57150f7f-fcca-5f59-6971-9afdd1cc2f72@amazon.com>
Date:   Wed, 12 Jun 2019 16:42:29 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <eb0bbd15-cf37-eacc-a4ce-62becf045c38@amazon.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.177]
X-ClientProxiedBy: EX13P01UWA002.ant.amazon.com (10.43.160.46) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/06/2019 16:28, Gal Pressman wrote:
> On 12/06/2019 15:01, Jason Gunthorpe wrote:
>> On Wed, Jun 12, 2019 at 10:28:42AM +0300, Gal Pressman wrote:
>>> When inserting a new mmap entry to the xarray we should check for
>>> 'mmap_page' overflow as it is limited to 32 bits.
>>>
>>> While at it, make sure to advance the mmap_page stored on the ucontext
>>> only after a successful insertion.
>>>
>>> Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")
>>> Signed-off-by: Gal Pressman <galpress@amazon.com>
>>>  drivers/infiniband/hw/efa/efa_verbs.c | 21 ++++++++++++++++-----
>>>  1 file changed, 16 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
>>> index 0fea5d63fdbe..c463c683ae84 100644
>>> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
>>> @@ -204,6 +204,7 @@ static u64 mmap_entry_insert(struct efa_dev *dev, struct efa_ucontext *ucontext,
>>>  			     void *obj, u64 address, u64 length, u8 mmap_flag)
>>>  {
>>>  	struct efa_mmap_entry *entry;
>>> +	u32 next_mmap_page;
>>>  	int err;
>>>  
>>>  	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
>>> @@ -216,15 +217,19 @@ static u64 mmap_entry_insert(struct efa_dev *dev, struct efa_ucontext *ucontext,
>>>  	entry->mmap_flag = mmap_flag;
>>>  
>>>  	xa_lock(&ucontext->mmap_xa);
>>> +	if (check_add_overflow(ucontext->mmap_xa_page,
>>> +			       (u32)(length >> PAGE_SHIFT),
>>> +			       &next_mmap_page))
>>> +		goto err_unlock;
>>> +
>>>  	entry->mmap_page = ucontext->mmap_xa_page;
>>> -	ucontext->mmap_xa_page += DIV_ROUND_UP(length, PAGE_SIZE);
>>>  	err = __xa_insert(&ucontext->mmap_xa, entry->mmap_page, entry,
>>>  			  GFP_KERNEL);
>>> +	if (err)
>>> +		goto err_unlock;
>>> +
>>> +	ucontext->mmap_xa_page = next_mmap_page;
>>
>> This is not ordered right anymore, the xa_lock can be released inside
>> __xa_insert, so to be atomic you must do everything before calling
>> __xa_insert.
> 
> Ah, missed the fact that __xa_insert could release the lock :\..
> Thanks Jason, will bring back the mmap_xa_page assignment before the __xa_insert
> call and unwind it in case of __xa_insert failure.

On second thought, unwinding the mmap_xa_page will cause other issues.. Will
drop this part.
