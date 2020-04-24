Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B371B7982
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2020 17:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgDXP0T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Apr 2020 11:26:19 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:34606 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbgDXP0T (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Apr 2020 11:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1587741978; x=1619277978;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=iYO/LJ4La79F/76gxXRPyaXqKc6JWGM33HL3SC6ywrk=;
  b=lHZYyowYk3E0yIihwwYUOnA8MIZbCIEL4DRKIiKDANy8diMNeMKt+X/D
   tHe3hLS7jK8D5B9x9rO0lU3mXRXbETjzNNe9M7jgbOZb57uyYus7vRos6
   I1FJ+xvP/YY6ouSIpxO+rUmZiH4vNa74gn4/k/IkgZIZ3A3um3s98hQf6
   Y=;
IronPort-SDR: FueZyyEWGKXDkytDi5hVHfUn6A/sUUAk8w3CnydiuThOloC2xodszTaL2KVKOKu1+cuxtvfTps
 ZFp/w7Kj31lA==
X-IronPort-AV: E=Sophos;i="5.73,311,1583193600"; 
   d="scan'208";a="27241078"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-821c648d.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 24 Apr 2020 15:26:05 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-821c648d.us-east-1.amazon.com (Postfix) with ESMTPS id B6A90A1FB6;
        Fri, 24 Apr 2020 15:26:04 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 24 Apr 2020 15:26:04 +0000
Received: from 8c85908914bf.ant.amazon.com (10.43.162.203) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 24 Apr 2020 15:26:00 +0000
Subject: Re: [PATCH for-next 2/3] RDMA/efa: Count mmap failures
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
References: <20200420062213.44577-1-galpress@amazon.com>
 <20200420062213.44577-3-galpress@amazon.com>
 <20200424145923.GH26002@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <e0ce4fa2-f802-a17c-2b13-666d086029c0@amazon.com>
Date:   Fri, 24 Apr 2020 18:25:54 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424145923.GH26002@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.203]
X-ClientProxiedBy: EX13D35UWC004.ant.amazon.com (10.43.162.180) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 24/04/2020 17:59, Jason Gunthorpe wrote:
> On Mon, Apr 20, 2020 at 09:22:12AM +0300, Gal Pressman wrote:
>> Add a new stat that counts mmap failures, which might help when
>> debugging different issues.
>>
>> Reviewed-by: Firas JahJah <firasj@amazon.com>
>> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
>> Signed-off-by: Gal Pressman <galpress@amazon.com>
>>  drivers/infiniband/hw/efa/efa.h       | 3 ++-
>>  drivers/infiniband/hw/efa/efa_verbs.c | 9 +++++++--
>>  2 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
>> index aa7396a1588a..77c9ff798117 100644
>> +++ b/drivers/infiniband/hw/efa/efa.h
>> @@ -1,6 +1,6 @@
>>  /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
>>  /*
>> - * Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
>> + * Copyright 2018-2020 Amazon.com, Inc. or its affiliates. All rights reserved.
>>   */
>>  
>>  #ifndef _EFA_H_
>> @@ -40,6 +40,7 @@ struct efa_sw_stats {
>>  	atomic64_t reg_mr_err;
>>  	atomic64_t alloc_ucontext_err;
>>  	atomic64_t create_ah_err;
>> +	atomic64_t mmap_err;
>>  };
>>  
>>  /* Don't use anything other than atomic64 */
>> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
>> index b555845d6c14..75eef1ec2474 100644
>> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
>> @@ -44,7 +44,8 @@ struct efa_user_mmap_entry {
>>  	op(EFA_CREATE_CQ_ERR, "create_cq_err") \
>>  	op(EFA_REG_MR_ERR, "reg_mr_err") \
>>  	op(EFA_ALLOC_UCONTEXT_ERR, "alloc_ucontext_err") \
>> -	op(EFA_CREATE_AH_ERR, "create_ah_err")
>> +	op(EFA_CREATE_AH_ERR, "create_ah_err") \
>> +	op(EFA_MMAP_ERR, "mmap_err")
>>  
>>  #define EFA_STATS_ENUM(ename, name) ename,
>>  #define EFA_STATS_STR(ename, name) [ename] = name,
>> @@ -1569,6 +1570,7 @@ static int __efa_mmap(struct efa_dev *dev, struct efa_ucontext *ucontext,
>>  		ibdev_dbg(&dev->ibdev,
>>  			  "pgoff[%#lx] does not have valid entry\n",
>>  			  vma->vm_pgoff);
>> +		atomic64_inc(&dev->stats.sw_stats.mmap_err);
>>  		return -EINVAL;
>>  	}
>>  	entry = to_emmap(rdma_entry);
>> @@ -1604,12 +1606,14 @@ static int __efa_mmap(struct efa_dev *dev, struct efa_ucontext *ucontext,
>>  		err = -EINVAL;
>>  	}
>>  
>> -	if (err)
>> +	if (err) {
>>  		ibdev_dbg(
>>  			&dev->ibdev,
>>  			"Couldn't mmap address[%#llx] length[%#zx] mmap_flag[%d] err[%d]\n",
>>  			entry->address, rdma_entry->npages * PAGE_SIZE,
>>  			entry->mmap_flag, err);
>> +		atomic64_inc(&dev->stats.sw_stats.mmap_err);
> 
> Really? Isn't this something that is only possible with a buggy
> rdma-core provider? Why count it?

Though unlikely, it could happen, otherwise this error flow wouldn't exist in
the first place.

If for some reason a customer app steps on a bug we're not aware of, this
counter could serve as a red flag.
