Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3B1FF41A5
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2019 09:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbfKHIL1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Nov 2019 03:11:27 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6170 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726672AbfKHIL0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 8 Nov 2019 03:11:26 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 910825F89C9AE8C44856;
        Fri,  8 Nov 2019 16:11:19 +0800 (CST)
Received: from [127.0.0.1] (10.40.168.149) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Fri, 8 Nov 2019
 16:11:13 +0800
Subject: Re: [PATCH v2 for-next 8/9] RDMA/hns: Fix non-standard error codes
To:     Leon Romanovsky <leon@kernel.org>
CC:     <dledford@redhat.com>, <jgg@ziepe.ca>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <1572952082-6681-1-git-send-email-liweihang@hisilicon.com>
 <1572952082-6681-9-git-send-email-liweihang@hisilicon.com>
 <20191105170058.GJ6763@unreal>
 <3b2b6654-135c-a268-8933-7ca2ee5a0105@hisilicon.com>
 <20191106154339.GL6763@unreal>
From:   Weihang Li <liweihang@hisilicon.com>
Message-ID: <2833edc5-27a4-8117-537e-b2b9a26ac757@hisilicon.com>
Date:   Fri, 8 Nov 2019 16:11:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191106154339.GL6763@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.168.149]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2019/11/6 23:43, Leon Romanovsky wrote:
> On Wed, Nov 06, 2019 at 06:44:06PM +0800, Weihang Li wrote:
>>
>>
>> On 2019/11/6 1:00, Leon Romanovsky wrote:
>>> On Tue, Nov 05, 2019 at 07:08:01PM +0800, Weihang Li wrote:
>>>> From: Yixian Liu <liuyixian@huawei.com>
>>>>
>>>> It is better to return a linux error code than define a private constant.
>>>>
>>>> Signed-off-by: Yixian Liu <liuyixian@huawei.com>
>>>> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
>>>> Signed-off-by: Weihang Li <liweihang@hisilicon.com>
>>>> ---
>>>>  drivers/infiniband/hw/hns/hns_roce_alloc.c |  4 ++--
>>>>  drivers/infiniband/hw/hns/hns_roce_cq.c    |  4 ++--
>>>>  drivers/infiniband/hw/hns/hns_roce_mr.c    | 15 ++++++++-------
>>>>  drivers/infiniband/hw/hns/hns_roce_pd.c    |  2 +-
>>>>  drivers/infiniband/hw/hns/hns_roce_srq.c   |  2 +-
>>>>  5 files changed, 14 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
>>>> index 8c063c5..da574c2 100644
>>>> --- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
>>>> +++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
>>>> @@ -55,7 +55,7 @@ int hns_roce_bitmap_alloc(struct hns_roce_bitmap *bitmap, unsigned long *obj)
>>>
>>> Why do HNS driver have custom bitmap functions instead of include/linux/bitmap.h?
>>>
>>> Thanks
>>>
>>> .
>>>
>>
>> Hi Leon,
>>
>> These custom functions achieved the bitmap working in round-robin fashion.
>> When using CM to establish connections, if we allocate a new QP after destroying
>> one, we will get the same QP number which will be rejected by IB core.
> 
> QP number is controlled by HW (or at least should) and not by this bitmap.

Hi Leon,

Sorry for the late reply. QP number is allocated by SW in hip08, so we have to use this round-robin bitmap.

> 
>>
>> I found related patches about this issue:
>> https://git.congatec.com/android/qmx6_kernel/commit/f4ec9e9531ac79ee2521faf7ad3d98978f747e42
>> https://patchwork.kernel.org/patch/3306941/
>> https://patchwork.kernel.org/patch/9444173/
> 
> Irrelevant, those patches try to create and manage object numbers in SW.
> 
> Thanks
> 
>>
>> Thanks,
>> Weihang
>>
> 
> .
> 

