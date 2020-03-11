Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73FA8180D6D
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2020 02:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbgCKBWB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 21:22:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50386 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727506AbgCKBWB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Mar 2020 21:22:01 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 167EEFA8812DEEE1569B;
        Wed, 11 Mar 2020 09:21:59 +0800 (CST)
Received: from [127.0.0.1] (10.40.203.251) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Wed, 11 Mar 2020
 09:21:50 +0800
Subject: Re: [PATCH for-next] RDMA/hns: Support to set mininum depth of qp to
 0
To:     Leon Romanovsky <leon@kernel.org>
CC:     Weihang Li <liweihang@huawei.com>, <dledford@redhat.com>,
        <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <1583140937-2223-1-git-send-email-liweihang@huawei.com>
 <20200309151813.GE172334@unreal>
 <13c7ec71-f79f-8599-b368-fae6893da0e6@huawei.com>
 <20200310123948.GJ242734@unreal>
From:   Lang Cheng <chenglang@huawei.com>
Message-ID: <d32f1dcd-863f-966e-0ee9-9524d4dca13e@huawei.com>
Date:   Wed, 11 Mar 2020 09:21:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200310123948.GJ242734@unreal>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.203.251]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2020/3/10 20:39, Leon Romanovsky wrote:
> On Tue, Mar 10, 2020 at 06:34:47PM +0800, Lang Cheng wrote:
>>
>>
>> On 2020/3/9 23:18, Leon Romanovsky wrote:
>>> On Mon, Mar 02, 2020 at 05:22:17PM +0800, Weihang Li wrote:
>>>> From: Lang Cheng <chenglang@huawei.com>
>>>>
>>>> Minimum depth of qp should be allowed to be set to 0 according to the
>>>> firmware configuration. And when qp is changed from reset to reset, the
>>>> capability of minimum qp depth was used to identify hardware of hip06,
>>>> it should be changed into a more readable form.
>>>
>>>
>>> And what does it mean "qp depth == 0"?
>>
>>
>> Here are 2 related test cases can be executed successfully:
>> 1,Just create qp with 0-depth sq and 0-depth rq, but do not perform sending
>> and receiving.
>> 2. Create a qp with 0-depth rq, the send operation can be completed.
>>
>> Perhaps supporting 0-depth qp would provide some flexibility for some
>> features.
>>
>> Or should we return error when ULP try to create a 0-depth queue?
> 
> "0" looks like not valid value and you can't explain what will be expected
> behavior if user sets such value, so returning an error sounds like a
> good solution.
> 

Check depth 0 in next.

Thanks.

>>
>>
>>>
>>>>
>>>> Signed-off-by: Lang Cheng <chenglang@huawei.com>
>>>> Signed-off-by: Weihang Li <liweihang@huawei.com>
>>>> ---
>>>>    drivers/infiniband/hw/hns/hns_roce_qp.c | 13 ++++++-------
>>>>    1 file changed, 6 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
>>>> index 2a75355..10c4354 100644
>>>> --- a/drivers/infiniband/hw/hns/hns_roce_qp.c
>>>> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
>>>> @@ -382,10 +382,10 @@ static int set_rq_size(struct hns_roce_dev *hr_dev,
>>>>    			return -EINVAL;
>>>>    		}
>>>>
>>>> -		if (hr_dev->caps.min_wqes)
>>>> +		if (cap->max_recv_wr)
>>>>    			max_cnt = max(cap->max_recv_wr, hr_dev->caps.min_wqes);
>>>>    		else
>>>> -			max_cnt = cap->max_recv_wr;
>>>> +			max_cnt = 0;
>>>
>>> It is basically the same thing: cap->max_recv_wr == 0.
>>
>> The current firmware has not specified the minimum depth of qp, resulting in
>> hr_dev-> caps.min_wqes always being 0, the process will always go into the
>> else branch, so there is no minimum depth check for qp.
>>
>> The firmware will support configuring the minimum depth of qp, so this patch
>> checks all the use of this caps.
> 
> if (cap->max_recv_wr)
>    cap->max_recv_wr != 0
> else
>   cap->max_recv_wr == 0
>   => max_cnt = 0 and max_cnt = cap->max_recv_wr are the same
> 
> Thanks
> 
>>
>>>
>>>>
>>>>    		hr_qp->rq.wqe_cnt = roundup_pow_of_two(max_cnt);
>>>>
>>>> @@ -652,10 +652,10 @@ static int set_kernel_sq_size(struct hns_roce_dev *hr_dev,
>>>>
>>>>    	hr_qp->sq.wqe_shift = ilog2(hr_dev->caps.max_sq_desc_sz);
>>>>
>>>> -	if (hr_dev->caps.min_wqes)
>>>> +	if (cap->max_send_wr)
>>>>    		max_cnt = max(cap->max_send_wr, hr_dev->caps.min_wqes);
>>>>    	else
>>>> -		max_cnt = cap->max_send_wr;
>>>> +		max_cnt = 0;
>>>
>>> Ditto
>>>
>>>>
>>>>    	hr_qp->sq.wqe_cnt = roundup_pow_of_two(max_cnt);
>>>>    	if ((u32)hr_qp->sq.wqe_cnt > hr_dev->caps.max_wqes) {
>>>> @@ -1394,11 +1394,10 @@ int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
>>>>    		goto out;
>>>>
>>>>    	if (cur_state == new_state && cur_state == IB_QPS_RESET) {
>>>> -		if (hr_dev->caps.min_wqes) {
>>>> +		if (hr_dev->hw_rev == HNS_ROCE_HW_VER1) {
>>>>    			ret = -EPERM;
>>>>    			ibdev_err(&hr_dev->ib_dev,
>>>> -				"cur_state=%d new_state=%d\n", cur_state,
>>>> -				new_state);
>>>> +				  "Unsupport to modify qp from reset to reset\n");
>>>
>>> "RST2RST state is not supported\n"
>>
>> Will be modified in next, thanks.
>>
>>
>>>
>>>>    		} else {
>>>>    			ret = 0;
>>>>    		}
>>>> --
>>>> 2.8.1
>>>>
>>>
>>> .
>>>
>>
> 
> .
> 

