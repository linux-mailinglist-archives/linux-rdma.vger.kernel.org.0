Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C08415736C
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2020 12:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgBJL1J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Feb 2020 06:27:09 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:34268 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726961AbgBJL1J (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Feb 2020 06:27:09 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6CE8BFAE38318DD8154F;
        Mon, 10 Feb 2020 19:27:07 +0800 (CST)
Received: from [127.0.0.1] (10.40.168.149) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Mon, 10 Feb 2020
 19:27:00 +0800
Subject: Re: [PATCH for-next] RDMA/hns: Optimize eqe buffer allocation flow
To:     Leon Romanovsky <leon@kernel.org>
CC:     <dledford@redhat.com>, <jgg@ziepe.ca>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <20200126145835.11368-1-liweihang@huawei.com>
 <20200127055205.GH3870@unreal>
 <10b7a08c-e069-0751-8bde-e5d19521c0b2@huawei.com>
 <20200210092508.GB495280@unreal>
 <512fa0f9-2bef-b3d8-fb3d-144984ee468c@huawei.com>
 <20200210102120.GC495280@unreal>
From:   Weihang Li <liweihang@huawei.com>
Message-ID: <d8ccdc94-917e-19be-dcd7-e15afd9c005a@huawei.com>
Date:   Mon, 10 Feb 2020 19:26:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200210102120.GC495280@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.168.149]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2020/2/10 18:21, Leon Romanovsky wrote:
> On Mon, Feb 10, 2020 at 05:48:05PM +0800, Weihang Li wrote:
>>
>>
>> On 2020/2/10 17:25, Leon Romanovsky wrote:
>>>>>> -		if (!eq->bt_l0)
>>>>>> -			return -ENOMEM;
>>>>>> -
>>>>>> -		eq->cur_eqe_ba = eq->l0_dma;
>>>>>> -		eq->nxt_eqe_ba = 0;
>>>>>> +	/* alloc a tmp list for storing eq buf address */
>>>>>> +	ret = hns_roce_alloc_buf_list(&region, &buf_list, 1);
>>>>>> +	if (ret) {
>>>>>> +		dev_err(hr_dev->dev, "alloc eq buf_list error\n");
>>>>> The same comment like we gave for bnxt driver, no dev_* prints inside
>>>>> driver, use ibdev_*.
>>>>>
>>>>> Thanks
>>>>>
>>>> Hi Leon,
>>>>
>>>> map_eq_buf() is called before ib_register_device(), so we can't use
>>>> ibdev_* here.
>>> As long as map_eq_buf() is called after ib_alloc_device(), you will be fine.
>>>
>>> Thanks
>>
>> Hi Leon,
>>
>> eq is used to queue hardware event, it should be ready before hardware is initialized.
>> So we can't call map_eq_buf() after ib_alloc_device().
> 
> How can it be that your newly added function has hns_roce_dev in the
> signature and you didn't call to ib_alloc_device()?
> 
>  +static int map_eq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq,
>  +                u32 page_shift)
> 
> Thanks
> 

Sorry, I confused ib_alloc_device() and ib_register_device(). What I was about to say is
ib_register_device().

Order of these functions in hns driver is:

1. ib_alloc_device()
2. map_eq_buf()
3. ib_register_device()

Refer to code in __ibdev_printk():

	else if (ibdev)
		printk("%s%s: %pV",
		       level, dev_name(&ibdev->dev), vaf);


If we called ibdev_*() before ib_register_device(), it will print "null" for the device
name. And I make a simple test, it will print like this:

[   41.400347] (null): -------------- This is a test!----------

Because map_eq_buf() should be finished before ib_register_device(), so I think we have
to use dev_*() in it.

>>
>> Thanks
>> Weihang
>>
>>>
>>>> Thanks for your reminder, another patch that replace other dev_* in
>>>> hns driver with ibdev_* is on preparing.
>>>>
>>>> Weihang
>>>>
>>>>> .
>>>>>
>>> .
>>>
>>
> 
> .
> 

