Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAF3A703C3
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2019 17:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbfGVP2z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 11:28:55 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:59090 "EHLO
        os.inf.tu-dresden.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbfGVP2y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jul 2019 11:28:54 -0400
X-Greylist: delayed 859 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Jul 2019 11:28:53 EDT
Received: from [195.176.96.199] (helo=[10.3.5.139])
        by os.inf.tu-dresden.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92)
        id 1hpaFA-0008NN-TJ; Mon, 22 Jul 2019 17:28:52 +0200
Subject: Re: [PATCH 04/10] Protect kref_put with the lock
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190722151426.5266-1-mplaneta@os.inf.tu-dresden.de>
 <20190722151426.5266-5-mplaneta@os.inf.tu-dresden.de>
 <20190722152559.GD7607@ziepe.ca>
From:   Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
Message-ID: <c2fdbf86-acea-aebb-48c4-8c2f85a68978@os.inf.tu-dresden.de>
Date:   Mon, 22 Jul 2019 17:28:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190722152559.GD7607@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 22/07/2019 17:25, Jason Gunthorpe wrote:
> On Mon, Jul 22, 2019 at 05:14:20PM +0200, Maksym Planeta wrote:
>> Need to ensure that kref_put does not run concurrently with the loop
>> inside rxe_pool_get_key.
>>
>> Signed-off-by: Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
>>   drivers/infiniband/sw/rxe/rxe_pool.c | 18 ++++++++++++++++++
>>   drivers/infiniband/sw/rxe/rxe_pool.h |  4 +---
>>   2 files changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
>> index efa9bab01e02..30a887cf9200 100644
>> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
>> @@ -536,3 +536,21 @@ void *rxe_pool_get_key(struct rxe_pool *pool, void *key)
>>   	read_unlock_irqrestore(&pool->pool_lock, flags);
>>   	return node ? elem : NULL;
>>   }
>> +
>> +static void rxe_dummy_release(struct kref *kref)
>> +{
>> +}
>> +
>> +void rxe_drop_ref(struct rxe_pool_entry *pelem)
>> +{
>> +	int res;
>> +	struct rxe_pool *pool = pelem->pool;
>> +	unsigned long flags;
>> +
>> +	write_lock_irqsave(&pool->pool_lock, flags);
>> +	res = kref_put(&pelem->ref_cnt, rxe_dummy_release);
>> +	write_unlock_irqrestore(&pool->pool_lock, flags);
> 
> This doesn't make sense..
> 
> If something is making the kref go to 0 while the node is still in the
> RB tree then that is a bug.
> 
> You should never need to add locking around a kref_put.
> 

 From https://www.kernel.org/doc/Documentation/kref.txt

| The last rule (rule 3) is the nastiest one to handle.  Say, for
| instance, you have a list of items that are each kref-ed, and you wish
| to get the first one.  You can't just pull the first item off the list
| and kref_get() it.  That violates rule 3 because you are not already
| holding a valid pointer.  You must add a mutex (or some other lock).


> Jason
> 

-- 
Regards,
Maksym Planeta
