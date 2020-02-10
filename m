Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94ABC15720B
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2020 10:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgBJJsR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Feb 2020 04:48:17 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10608 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727029AbgBJJsQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Feb 2020 04:48:16 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8AFBE55DE8448840C893;
        Mon, 10 Feb 2020 17:48:13 +0800 (CST)
Received: from [127.0.0.1] (10.40.168.149) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Mon, 10 Feb 2020
 17:48:05 +0800
Subject: Re: [PATCH for-next] RDMA/hns: Optimize eqe buffer allocation flow
To:     Leon Romanovsky <leon@kernel.org>
CC:     <dledford@redhat.com>, <jgg@ziepe.ca>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <20200126145835.11368-1-liweihang@huawei.com>
 <20200127055205.GH3870@unreal>
 <10b7a08c-e069-0751-8bde-e5d19521c0b2@huawei.com>
 <20200210092508.GB495280@unreal>
From:   Weihang Li <liweihang@huawei.com>
Message-ID: <512fa0f9-2bef-b3d8-fb3d-144984ee468c@huawei.com>
Date:   Mon, 10 Feb 2020 17:48:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200210092508.GB495280@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.168.149]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2020/2/10 17:25, Leon Romanovsky wrote:
>>>> -		if (!eq->bt_l0)
>>>> -			return -ENOMEM;
>>>> -
>>>> -		eq->cur_eqe_ba = eq->l0_dma;
>>>> -		eq->nxt_eqe_ba = 0;
>>>> +	/* alloc a tmp list for storing eq buf address */
>>>> +	ret = hns_roce_alloc_buf_list(&region, &buf_list, 1);
>>>> +	if (ret) {
>>>> +		dev_err(hr_dev->dev, "alloc eq buf_list error\n");
>>> The same comment like we gave for bnxt driver, no dev_* prints inside
>>> driver, use ibdev_*.
>>>
>>> Thanks
>>>
>> Hi Leon,
>>
>> map_eq_buf() is called before ib_register_device(), so we can't use
>> ibdev_* here.
> As long as map_eq_buf() is called after ib_alloc_device(), you will be fine.
> 
> Thanks

Hi Leon,

eq is used to queue hardware event, it should be ready before hardware is initialized.
So we can't call map_eq_buf() after ib_alloc_device().

Thanks
Weihang

> 
>> Thanks for your reminder, another patch that replace other dev_* in
>> hns driver with ibdev_* is on preparing.
>>
>> Weihang
>>
>>> .
>>>
> .
> 

