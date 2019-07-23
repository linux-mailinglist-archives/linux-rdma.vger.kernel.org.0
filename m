Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3085070EA7
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 03:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbfGWBaO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 21:30:14 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49726 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728108AbfGWBaO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Jul 2019 21:30:14 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D71B5FE4D2F11A6C9979;
        Tue, 23 Jul 2019 09:30:10 +0800 (CST)
Received: from [127.0.0.1] (10.61.25.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Tue, 23 Jul 2019
 09:30:10 +0800
Subject: =?UTF-8?Q?Re:_=e3=80=90Question_for_srpt_in_kernel-4.14=e3=80=91?=
To:     Bart Van Assche <bvanassche@acm.org>, <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
CC:     linux-rdma <linux-rdma@vger.kernel.org>
References: <16008407-2ffd-0bbb-717e-7e874a3a5ee0@huawei.com>
 <d4b60eb6-9e61-987e-d7ba-e3806faceedd@acm.org>
From:   oulijun <oulijun@huawei.com>
Message-ID: <d2531a84-b0c2-3c39-141a-166a4a8dd8be@huawei.com>
Date:   Tue, 23 Jul 2019 09:30:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <d4b60eb6-9e61-987e-d7ba-e3806faceedd@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.61.25.96]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2019/7/23 2:07, Bart Van Assche 写道:
> On 7/19/19 11:54 PM, oulijun wrote:
>> I am targeting a problem about RoCE and SCSI over RDMA from srpt in kernel-4.14. When insmod srpt.ko and insmod hns-roce-hw-v2.ko, it will
>> report a warning in srpt_add_one:
>>    ib_srpt srpt_add_one(hns_0) failed.
>
> How about the following patch?
>
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index 1a039f16d315..e2a4a14763b8 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -3109,7 +3109,8 @@ static void srpt_add_one(struct ib_device *device)
>      srpt_use_srq(sdev, sdev->port[0].port_attrib.use_srq);
>
>      if (!srpt_service_guid)
> -        srpt_service_guid = be64_to_cpu(device->node_guid);
> +        srpt_service_guid = be64_to_cpu(device->node_guid) &
> +            ~IB_SERVICE_ID_AGN_MASK;
>
>      if (rdma_port_get_link_layer(device, 1) == IB_LINK_LAYER_INFINIBAND)
>          sdev->cm_id = ib_create_cm_id(device, srpt_cm_handler, sdev);
>
No, I did not find this patch in the latest kernel-5.3 or others.
>> In addition, I analyzed a patch in kernel-4.17(IB/srpt: Add RDMA/CM support). As a result, I can understand that the previous srpt is not supported by RDMA/CM?
>> So, all RoCE will failed when use kernel-4.14 version to run srpt.ko?
>
> That's correct. The upstream SRP drivers only support RoCE in kernel versions
> v4.17 and later.
>
> Thanks,
>
> Bart.
>
> .
>


