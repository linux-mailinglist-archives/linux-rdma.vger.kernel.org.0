Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F84C4AB06
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jun 2019 21:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbfFRTeA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jun 2019 15:34:00 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:21775 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730189AbfFRTeA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jun 2019 15:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1560886439; x=1592422439;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=1ah8PzZwauZoEAAkvI/YZVD8gFRsAZj4Hiku1y/xEfA=;
  b=QqOeBipD6HKzgkkSuDAhHeIN2tStnLdBxIRIi6dp/bzmggTNg+Fs9H6M
   j/6vukXS3OJDrnd9eu9E6eekMC5yycuPAthUkielOF4qWMjwzLdP3BOFp
   HaEyoB5bKLcNQBzrW7ApBXKW7ws1oAfcc3f2moKcV7Ve+taeab3/txJK1
   s=;
X-IronPort-AV: E=Sophos;i="5.62,390,1554768000"; 
   d="scan'208";a="680645129"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 18 Jun 2019 19:33:57 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id 9EC58A24F1;
        Tue, 18 Jun 2019 19:33:56 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 18 Jun 2019 19:33:56 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.128) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 18 Jun 2019 19:33:53 +0000
Subject: Re: [PATCH for-rc v2] RDMA/efa: Handle mmap insertions overflow
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>
References: <20190618130732.20895-1-galpress@amazon.com>
 <20190618184808.GN6961@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <82786c0b-510e-9aa7-cb18-28a84cec9420@amazon.com>
Date:   Tue, 18 Jun 2019 22:33:48 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190618184808.GN6961@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.128]
X-ClientProxiedBy: EX13D10UWA001.ant.amazon.com (10.43.160.216) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 18/06/2019 21:48, Jason Gunthorpe wrote:
> On Tue, Jun 18, 2019 at 04:07:32PM +0300, Gal Pressman wrote:
>> When inserting a new mmap entry to the xarray we should check for
>> 'mmap_page' overflow as it is limited to 32 bits.
>>
>> Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")
>> Signed-off-by: Gal Pressman <galpress@amazon.com>
>> Changelog:
>> v1->v2
>> * Bring back the ucontext->mmap_xa_page assignment before __xa_insert
>>  drivers/infiniband/hw/efa/efa_verbs.c | 21 ++++++++++++++++-----
>>  1 file changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
>> index 0fea5d63fdbe..fb6115244d4c 100644
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
> 
> Why did DIV_ROUND_UP become >> ?

Since length is guaranteed to be a multiple of PAGE_SIZE.
