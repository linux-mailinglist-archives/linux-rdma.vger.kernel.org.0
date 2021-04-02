Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B63C35251D
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Apr 2021 03:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbhDBB0t (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Apr 2021 21:26:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15901 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhDBB0t (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Apr 2021 21:26:49 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FBMmd1C8WzkghD;
        Fri,  2 Apr 2021 09:25:05 +0800 (CST)
Received: from [10.40.203.251] (10.40.203.251) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Fri, 2 Apr 2021 09:26:38 +0800
Subject: Re: [PATCH for-next 1/3] RDMA/hns: Enable all CMDQ context
To:     Leon Romanovsky <leon@kernel.org>,
        Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <jgg@nvidia.com>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <1617262341-37571-1-git-send-email-liweihang@huawei.com>
 <1617262341-37571-2-git-send-email-liweihang@huawei.com>
 <YGXFtqbcVGLiKfXD@unreal>
From:   Lang Cheng <chenglang@huawei.com>
Message-ID: <3782ed3b-f630-8174-5d65-6a458fcdcd8f@huawei.com>
Date:   Fri, 2 Apr 2021 09:26:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <YGXFtqbcVGLiKfXD@unreal>
Content-Type: multipart/mixed;
        boundary="------------C8801381A6655FC6581D42BC"
Content-Language: en-US
X-Originating-IP: [10.40.203.251]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--------------C8801381A6655FC6581D42BC
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 2021/4/1 21:08, Leon Romanovsky wrote:
> On Thu, Apr 01, 2021 at 03:32:19PM +0800, Weihang Li wrote:
>> From: Lang Cheng <chenglang@huawei.com>
>>
>> Fix error of cmd's context number calculation algorithm to enable all of
>> 32 cmd entries and support 32 concurrent accesses.
>>
>> Signed-off-by: Lang Cheng <chenglang@huawei.com>
>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>> ---
>>   drivers/infiniband/hw/hns/hns_roce_cmd.c    | 62 ++++++++++++-----------------
>>   drivers/infiniband/hw/hns/hns_roce_device.h |  6 +--
>>   2 files changed, 27 insertions(+), 41 deletions(-)
> 
> <...>
> 
>> -	WARN_ON(cmd->free_head < 0);
>> -	context = &cmd->context[cmd->free_head];
>> -	context->token += cmd->token_mask + 1;
>> -	cmd->free_head = context->next;
>> +
>> +	do {
>> +		context = &cmd->context[cmd->free_head];
>> +		cmd->free_head = context->next;
>> +	} while (context->busy);
>> +
>> +	context->busy = 1;
> 
> This "busy" flag after do-while together with release in __hns_roce_cmd_mbox_wait()
> is interesting thing. Are you sure that it won't loop forever here?
> 

When initializing resources in hns_roce_cmd_use_events(), ensure that 
the number of semaphores is consistent with the depth of context[].

int hns_roce_cmd_use_events( )
{
	hr_cmd->context = kcalloc(hr_cmd->max_cmds, ...);
	sema_init(&hr_cmd->event_sem, hr_cmd->max_cmds);
}

Then, when someone gets the event_sem in hns_roce_cmd_mbox_wait(), it 
means that there must be a not busy context.

Thanks.

> Thanks
> .
> 

--------------C8801381A6655FC6581D42BC
Content-Type: text/x-vcard; name="chenglang.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="chenglang.vcf"

bnVsbA==
--------------C8801381A6655FC6581D42BC--
