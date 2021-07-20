Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7CD3CFA19
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 15:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbhGTM0b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jul 2021 08:26:31 -0400
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:43587 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238457AbhGTMZX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Jul 2021 08:25:23 -0400
Received: from [192.168.1.102] ([80.15.159.30])
        by mwinf5d34 with ME
        id XR5v2500f0feRjk03R5wRC; Tue, 20 Jul 2021 15:05:57 +0200
X-ME-Helo: [192.168.1.102]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 20 Jul 2021 15:05:57 +0200
X-ME-IP: 80.15.159.30
Subject: Re: [PATCH] RDMA/irdma: Improve the way 'cqp_request' structures are
 cleaned when they are recycled
To:     leon@kernel.org
Cc:     mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        christophe.jaillet@wanadoo.fr
References: <7f93f2a2c2fd18ddfeb99339d175b85ffd1c6398.1626713915.git.christophe.jaillet@wanadoo.fr>
 <YPbALA/P5+NsC7MO@unreal>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <629bc34e-ef41-9af6-9ed7-71865251a62c@wanadoo.fr>
Date:   Tue, 20 Jul 2021 15:05:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPbALA/P5+NsC7MO@unreal>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Le 20/07/2021 à 14:23, Leon Romanovsky a écrit :
> On Mon, Jul 19, 2021 at 07:02:15PM +0200, Christophe JAILLET wrote:
>> A set of IRDMA_CQP_SW_SQSIZE_2048 (i.e. 2048) 'cqp_request' are
>> pre-allocated and zeroed in 'irdma_create_cqp()' (hw.c).  These
>> structures are managed with the 'cqp->cqp_avail_reqs' list which keeps
>> track of available entries.
>>
>> In 'irdma_free_cqp_request()' (utils.c), when an entry is recycled and goes
>> back to the 'cqp_avail_reqs' list, some fields are reseted.
>>
>> However, one of these fields, 'compl_info', is initialized within
>> 'irdma_alloc_and_get_cqp_request()'.
>>
>> Move the corresponding memset to 'irdma_free_cqp_request()' so that the
>> clean-up is done in only one place. This makes the logic more easy to
>> understand.
> 
> I'm not so sure. The function irdma_alloc_and_get_cqp_request() returns
> prepared cqp_request and all users expect that it will returned cleaned
> one. The reliance on some other place to clear part of the structure is
> prone to errors.

Ok, so maybe, moving:
	cqp_request->request_done = false;
	cqp_request->callback_fcn = NULL;
	cqp_request->waiting = false;
from 'irdma_free_cqp_request()' to 'irdma_alloc_and_get_cqp_request()' 
to make explicit what is reseted makes more sense?

 From my point of view, it is same same: all (re)initialization are done 
at 1 place only.

This would also avoid setting 'waiting' twice (once to false in 
'irdma_free_cqp_request()' and one to 'wait' 
'irdma_alloc_and_get_cqp_request()')


CJ
> 
> Thanks
> 
>>
>> This also saves this memset in the case that the 'cqp_avail_reqs' list is
>> empty and a new 'cqp_request' structure must be allocated. This memset is
>> useless, because the structure is already kzalloc'ed.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>
>> ---
>>   drivers/infiniband/hw/irdma/utils.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
>> index 5bbe44e54f9a..66711024d38b 100644
>> --- a/drivers/infiniband/hw/irdma/utils.c
>> +++ b/drivers/infiniband/hw/irdma/utils.c
>> @@ -445,7 +445,6 @@ struct irdma_cqp_request *irdma_alloc_and_get_cqp_request(struct irdma_cqp *cqp,
>>   
>>   	cqp_request->waiting = wait;
>>   	refcount_set(&cqp_request->refcnt, 1);
>> -	memset(&cqp_request->compl_info, 0, sizeof(cqp_request->compl_info));
>>   
>>   	return cqp_request;
>>   }
>> @@ -475,6 +474,7 @@ void irdma_free_cqp_request(struct irdma_cqp *cqp,
>>   		cqp_request->request_done = false;
>>   		cqp_request->callback_fcn = NULL;
>>   		cqp_request->waiting = false;
>> +		memset(&cqp_request->compl_info, 0, sizeof(cqp_request->compl_info));
>>   
>>   		spin_lock_irqsave(&cqp->req_lock, flags);
>>   		list_add_tail(&cqp_request->list, &cqp->cqp_avail_reqs);
>> -- 
>> 2.30.2
>>
> 

