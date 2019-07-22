Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F498703CC
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2019 17:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbfGVPbW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 11:31:22 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:59226 "EHLO
        os.inf.tu-dresden.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbfGVPbW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jul 2019 11:31:22 -0400
Received: from [195.176.96.199] (helo=[10.3.5.139])
        by os.inf.tu-dresden.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92)
        id 1hpaHZ-0008Pe-5b; Mon, 22 Jul 2019 17:31:21 +0200
Subject: Re: [PATCH 07/10] Pass the return value of kref_put further
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190722151426.5266-1-mplaneta@os.inf.tu-dresden.de>
 <20190722151426.5266-8-mplaneta@os.inf.tu-dresden.de>
 <20190722152947.GF7607@ziepe.ca>
From:   Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
Message-ID: <8956ccbb-f45e-692c-5208-ec52a3062680@os.inf.tu-dresden.de>
Date:   Mon, 22 Jul 2019 17:31:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190722152947.GF7607@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In a later patch I need to know if the dependency to QP object still 
exists or not.

On 22/07/2019 17:29, Jason Gunthorpe wrote:
> On Mon, Jul 22, 2019 at 05:14:23PM +0200, Maksym Planeta wrote:
>> Used in a later patch.
>>
>> Signed-off-by: Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
>>   drivers/infiniband/sw/rxe/rxe_pool.c | 3 ++-
>>   drivers/infiniband/sw/rxe/rxe_pool.h | 2 +-
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
>> index 30a887cf9200..711d7d7f3692 100644
>> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
>> @@ -541,7 +541,7 @@ static void rxe_dummy_release(struct kref *kref)
>>   {
>>   }
>>   
>> -void rxe_drop_ref(struct rxe_pool_entry *pelem)
>> +int rxe_drop_ref(struct rxe_pool_entry *pelem)
>>   {
>>   	int res;
>>   	struct rxe_pool *pool = pelem->pool;
>> @@ -553,4 +553,5 @@ void rxe_drop_ref(struct rxe_pool_entry *pelem)
>>   	if (res) {
>>   		rxe_elem_release(&pelem->ref_cnt);
>>   	}
>> +	return res;
>>   }
> 
> Using the return value of kref_put at all is super sketchy. Are you
> sure this is actually a kref usage pattern?
> 
> Why would this be needed?
> 
> Jason
> 

-- 
Regards,
Maksym Planeta
