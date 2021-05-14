Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5DDD3804B5
	for <lists+linux-rdma@lfdr.de>; Fri, 14 May 2021 09:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbhENHzd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 May 2021 03:55:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:2979 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbhENHzc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 May 2021 03:55:32 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FhLMq2v9wzmWHl;
        Fri, 14 May 2021 15:52:07 +0800 (CST)
Received: from [10.174.179.215] (10.174.179.215) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Fri, 14 May 2021 15:54:18 +0800
Subject: Re: [PATCH] IB/srpt: Fix passing zero to 'PTR_ERR'
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <target-devel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20201112145443.17832-1-yuehaibing@huawei.com>
 <20201112172008.GA944848@nvidia.com>
 <c73d9be0-0bd8-634a-e3d1-c81fe4c30482@acm.org>
 <20201112183023.GB917484@nvidia.com>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <9afea945-8991-4c27-10d0-e02c732705fc@huawei.com>
Date:   Fri, 14 May 2021 15:54:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201112183023.GB917484@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.215]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2020/11/13 2:30, Jason Gunthorpe wrote:
> On Thu, Nov 12, 2020 at 10:25:48AM -0800, Bart Van Assche wrote:
>> On 11/12/20 9:20 AM, Jason Gunthorpe wrote:
>>> I think it should be like this, Bart?
>>>
>>> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
>>> index 6017d525084a0c..80f9673956ced2 100644
>>> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
>>> @@ -2311,7 +2311,7 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
>>>   	mutex_lock(&sport->port_guid_id.mutex);
>>>   	list_for_each_entry(stpg, &sport->port_guid_id.tpg_list, entry) {
>>> -		if (!IS_ERR_OR_NULL(ch->sess))
>>> +		if (ch->sess)
>>>   			break;
>>>   		ch->sess = target_setup_session(&stpg->tpg, tag_num,
>>>   						tag_size, TARGET_PROT_NORMAL,
>>> @@ -2321,12 +2321,12 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
>>>   	mutex_lock(&sport->port_gid_id.mutex);
>>>   	list_for_each_entry(stpg, &sport->port_gid_id.tpg_list, entry) {
>>> -		if (!IS_ERR_OR_NULL(ch->sess))
>>> +		if (ch->sess)
>>>   			break;
>>>   		ch->sess = target_setup_session(&stpg->tpg, tag_num,
>>>   					tag_size, TARGET_PROT_NORMAL, i_port_id,
>>>   					ch, NULL);
>>> -		if (!IS_ERR_OR_NULL(ch->sess))
>>> +		if (ch->sess)
>>>   			break;
>>>   		/* Retry without leading "0x" */
>>>   		ch->sess = target_setup_session(&stpg->tpg, tag_num,
>>> @@ -2335,7 +2335,9 @@ static int srpt_cm_req_recv(struct srpt_device *const sdev,
>>>   	}
>>>   	mutex_unlock(&sport->port_gid_id.mutex);
>>> -	if (IS_ERR_OR_NULL(ch->sess)) {
>>> +	if (!ch->sess)
>>> +		ch->sess = ERR_PTR(-ENOENT);
>>> +	if (IS_ERR(ch->sess)) {
>>>   		WARN_ON_ONCE(ch->sess == NULL);
>>>   		ret = PTR_ERR(ch->sess);
>>>   		ch->sess = NULL;
>>>
>>
>> Hi Jason,
>>
>> The ib_srpt driver accepts three different formats for the initiator ACL. Up
>> to two of the three target_setup_session() calls will fail if the fifth
>> argument of target_setup_session() does not use the format of the initiator
>> ID in configfs. If the first or the second target_setup_session() call fails
>> it is essential that later target_setup_session() calls happen. Hence the
>> IS_ERR_OR_NULL(ch->sess) checks in the above loops.
> 
> IS_ERR_OR_NULL is an abomination, it should not be used.
> 
> I see I didn't quite get it right, but that is still closer to sane,
> probably target_setup_session() should return NULL not err_ptr

Any fix plan?

> 
> Jason
> .
> 
