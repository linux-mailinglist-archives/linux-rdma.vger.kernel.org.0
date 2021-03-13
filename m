Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8880E339B07
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Mar 2021 03:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhCMCFR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 12 Mar 2021 21:05:17 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:3477 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhCMCFK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Mar 2021 21:05:10 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Dy5Z8155RzRGlb;
        Sat, 13 Mar 2021 10:03:28 +0800 (CST)
Received: from dggema752-chm.china.huawei.com (10.1.198.194) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Sat, 13 Mar 2021 10:05:08 +0800
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggema752-chm.china.huawei.com (10.1.198.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Sat, 13 Mar 2021 10:05:07 +0800
Received: from dggema753-chm.china.huawei.com ([10.9.48.84]) by
 dggema753-chm.china.huawei.com ([10.9.48.84]) with mapi id 15.01.2106.013;
 Sat, 13 Mar 2021 10:05:07 +0800
From:   liweihang <liweihang@huawei.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: [PATCH for-rc] RDMA/hns: Fix bug during CMDQ initialization
Thread-Topic: [PATCH for-rc] RDMA/hns: Fix bug during CMDQ initialization
Thread-Index: AQHXFyP/evFyWB/sBEKRuknO7iJHUA==
Date:   Sat, 13 Mar 2021 02:05:07 +0000
Message-ID: <15b5241a7e604aad9245497efe969af5@huawei.com>
References: <1615541933-35798-1-git-send-email-liweihang@huawei.com>
 <20210312132036.GC2710221@ziepe.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.100.165]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021/3/12 21:20, Jason Gunthorpe wrote:
> On Fri, Mar 12, 2021 at 05:38:53PM +0800, Weihang Li wrote:
>> From: Lang Cheng <chenglang@huawei.com>
>>
>> When reloading driver, the head/tail pointer of CMDQ may be not at position
>> 0. Then during initialization of CMDQ, if head is reset first, the firmware
>> will start to handle CMDQ because the head is not equal to the tail. The
>> driver can reset tail first since the firmware will be triggerred only by
>> head. This bug is introduced by changing macros of head/tail register
>> without changing the order of initialization.
>>
>> Besides, the same name represents opposite meanings in new/old driver, it
>> is hard to maintain, so rename them to PI/CI.
> 
> Please split this to two patches for the -rc flow
> 
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> index c3934ab..c359f09 100644
>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>> @@ -1194,8 +1194,10 @@ static void hns_roce_cmq_init_regs(struct hns_roce_dev *hr_dev, bool ring_type)
>>  			   upper_32_bits(dma));
>>  		roce_write(hr_dev, ROCEE_TX_CMQ_DEPTH_REG,
>>  			   (u32)ring->desc_num >> HNS_ROCE_CMQ_DESC_NUM_S);
>> -		roce_write(hr_dev, ROCEE_TX_CMQ_HEAD_REG, 0);
>> -		roce_write(hr_dev, ROCEE_TX_CMQ_TAIL_REG, 0);
>> +
>> +		/* Make sure to write CI first and then PI */
>> +		roce_write(hr_dev, ROCEE_TX_CMQ_CI_REG, 0);
>> +		roce_write(hr_dev, ROCEE_TX_CMQ_PI_REG, 0);
> 
> Only this hunk should be in -rc
> 
> Thanks,
> Jason
> 

I see, thank you.

Weihang
