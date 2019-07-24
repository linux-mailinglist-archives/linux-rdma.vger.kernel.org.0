Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6F6E723C3
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2019 03:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbfGXBfr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 21:35:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46510 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728132AbfGXBfr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jul 2019 21:35:47 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 31A3FA0E6E2DA1674ADF;
        Wed, 24 Jul 2019 09:35:46 +0800 (CST)
Received: from [127.0.0.1] (10.61.25.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Wed, 24 Jul 2019
 09:35:40 +0800
Subject: =?UTF-8?Q?Re:_=e3=80=90Question_for_srpt_in_kernel-4.14=e3=80=91?=
From:   oulijun <oulijun@huawei.com>
To:     Bart Van Assche <bvanassche@acm.org>, <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
CC:     linux-rdma <linux-rdma@vger.kernel.org>
References: <16008407-2ffd-0bbb-717e-7e874a3a5ee0@huawei.com>
 <d4b60eb6-9e61-987e-d7ba-e3806faceedd@acm.org>
 <d2531a84-b0c2-3c39-141a-166a4a8dd8be@huawei.com>
 <c15e7a21-0e8b-b760-97dc-4bbd9a08b604@acm.org>
 <b99eb729-2a1d-5c2e-970c-e3a9baf5d6bd@huawei.com>
Message-ID: <e39e78fb-cf7a-b27f-89e3-b753131673d8@huawei.com>
Date:   Wed, 24 Jul 2019 09:35:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <b99eb729-2a1d-5c2e-970c-e3a9baf5d6bd@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.61.25.96]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2019/7/23 11:25, oulijun 写道:
> 在 2019/7/23 11:13, Bart Van Assche 写道:
>> On 7/22/19 6:30 PM, oulijun wrote:
>>> 在 2019/7/23 2:07, Bart Van Assche 写道:
>>>> On 7/19/19 11:54 PM, oulijun wrote:
>>>>> I am targeting a problem about RoCE and SCSI over RDMA from srpt in kernel-4.14. When insmod srpt.ko and insmod hns-roce-hw-v2.ko, it will
>>>>> report a warning in srpt_add_one:
>>>>>     ib_srpt srpt_add_one(hns_0) failed.
>>>> How about the following patch?
>>>>
>>>> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
>>>> index 1a039f16d315..e2a4a14763b8 100644
>>>> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
>>>> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
>>>> @@ -3109,7 +3109,8 @@ static void srpt_add_one(struct ib_device *device)
>>>>       srpt_use_srq(sdev, sdev->port[0].port_attrib.use_srq);
>>>>
>>>>       if (!srpt_service_guid)
>>>> -        srpt_service_guid = be64_to_cpu(device->node_guid);
>>>> +        srpt_service_guid = be64_to_cpu(device->node_guid) &
>>>> +            ~IB_SERVICE_ID_AGN_MASK;
>>>>
>>>>       if (rdma_port_get_link_layer(device, 1) == IB_LINK_LAYER_INFINIBAND)
>>>>           sdev->cm_id = ib_create_cm_id(device, srpt_cm_handler, sdev);
>>>>
>>> No, I did not find this patch in the latest kernel-5.3 or others.
>> What I meant is: can you try that patch?
>>
>> Thanks,
>>
>> Bart.
>>
>> .
>>
> Yes, I will do.
>
>
>
> .
>
Hi, Bart vlan Assche

   if we don't add the patch (IB/srpt: Add RDMA/CM support) and only merge your patch, it will not resolve our question.

if we add the patch(IB/srpt: Add RDMA/CM support) and merge your patch, it will success.


thanks.

Lijun Ou


