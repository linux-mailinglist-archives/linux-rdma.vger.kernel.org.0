Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBA4675073
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jan 2023 10:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjATJPZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Jan 2023 04:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjATJPP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Jan 2023 04:15:15 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4758C934;
        Fri, 20 Jan 2023 01:14:57 -0800 (PST)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NytxL47qDzqVmh;
        Fri, 20 Jan 2023 17:09:58 +0800 (CST)
Received: from [10.67.103.121] (10.67.103.121) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 20 Jan 2023 17:14:54 +0800
Subject: Re: [PATCH for-next 0/3] Refactor rq inline and add cqe inline
To:     Leon Romanovsky <leon@kernel.org>
CC:     <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
References: <20221224102201.3114536-1-xuhaoyue1@hisilicon.com>
 <Y6w2aRPSXAv4s5Pp@unreal>
From:   "xuhaoyue (A)" <xuhaoyue1@hisilicon.com>
Message-ID: <6aa101b0-970e-9331-4819-7202b6c2bfcf@hisilicon.com>
Date:   Fri, 20 Jan 2023 17:14:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <Y6w2aRPSXAv4s5Pp@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.121]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2022/12/28 20:28:25, Leon Romanovsky wrote:
> On Sat, Dec 24, 2022 at 06:21:58PM +0800, Haoyue Xu wrote:
>> The patchset mainly removes the kernel space
>> rq inline features and supports cqe inline in user space.
>>
>> Luoyouming (3):
>>   RDMA/hns: Remove rq inline in kernel
>>   RDMA/hns: Add compatibility handling for only support userspace rq
>>     inline
>>   RDMA/hns: Support cqe inline in user space
>>
>>  drivers/infiniband/hw/hns/hns_roce_device.h |  19 +---
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 109 ++++++--------------
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   3 +-
>>  drivers/infiniband/hw/hns/hns_roce_main.c   |  12 +++
>>  drivers/infiniband/hw/hns/hns_roce_qp.c     |  66 +-----------
>>  include/uapi/rdma/hns-abi.h                 |   4 +
> 
> Your commit messages are too scarce for patches which touch UAPI.
> Please add more details about why you deleted, what users should do next
> and what are the features you are adding,
> 
> Thanks
> 
>>  6 files changed, 54 insertions(+), 159 deletions(-)
>>
>> -- 
>> 2.30.0
>>
> .
> 

Hi Leon,
Sorry for the late response.

The cqe inline feature works as follows: payloads less than or equal to 32 bytes will be placed in the cqe, and the hardware will no longer need to access the pbl table and move the payload data.
Instead, the driver will move the payload to the user data space, which is conducive to improving the latency performance of the send/receive operation.
If rq inline and cqe inline are enabled at the same time, the data packet whose payload length is less than or equal to 32 bytes uses the cqe inline feature,
and the data packet greater than 32 bytes and less than or equal to 1024 bytes uses the rq inline feature.

For the reason of deleting kernel space rq inline, Since no user currently uses kernel-mode rq inline, then only supports user-mode rq inline in further plans.
To reduce maintenance, remove unsupported kernel state rq inline-related code.
I will add this to the user-space patch if this explanation is ok?

Sincerely,
Haoyue
