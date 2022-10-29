Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280DD6121FE
	for <lists+linux-rdma@lfdr.de>; Sat, 29 Oct 2022 11:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiJ2Jrk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 29 Oct 2022 05:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiJ2Jrk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 29 Oct 2022 05:47:40 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05218DB562
        for <linux-rdma@vger.kernel.org>; Sat, 29 Oct 2022 02:47:38 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Mzvdq40NdzFq7m;
        Sat, 29 Oct 2022 17:44:47 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 29 Oct 2022 17:47:37 +0800
Received: from [10.67.103.121] (10.67.103.121) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 29 Oct 2022 17:47:36 +0800
Subject: Re: [PATCH v2 for-rc 2/5] RDMA/hns: Fix the problem of sge nums
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <20221026095054.2384620-1-xuhaoyue1@hisilicon.com>
 <20221026095054.2384620-3-xuhaoyue1@hisilicon.com>
 <Y1wGWydgMduaZTOE@nvidia.com>
From:   "xuhaoyue (A)" <xuhaoyue1@hisilicon.com>
Message-ID: <221cd187-d947-265a-3559-62477c5f1b34@hisilicon.com>
Date:   Sat, 29 Oct 2022 17:47:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <Y1wGWydgMduaZTOE@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.121]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I will change it in V3.

On 2022/10/29 0:42:03, Jason Gunthorpe wrote:
> On Wed, Oct 26, 2022 at 05:50:51PM +0800, Haoyue Xu wrote:
>> From: Luoyouming <luoyouming@huawei.com>
>>
>> Currently, the driver only uses max_send_sge to initialize sge num
>> when creating_qp. So, in the sq inline scenario, the driver may not
>> has enough sge to send data. For example, if max_send_sge is 16 and
>> max_inline_data is 1024, the driver needs 1024/16=64 sge to send data.
>> Therefore, the calculation method of sge num is modified to take the
>> maximum value of max_send_sge and max_inline_data/16 to solve this
>> problem.
>>
>> Fixes: 05201e01be93 ("RDMA/hns: Refactor process of setting extended sge")
>> Fixes: 30b707886aeb ("RDMA/hns: Support inline data in extented sge space for RC")
>>
>> Signed-off-by: Luoyouming <luoyouming@huawei.com>
>> Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_device.h |   3 +
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  12 +--
>>  drivers/infiniband/hw/hns/hns_roce_main.c   |  18 +++-
>>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 108 +++++++++++++++++---
>>  include/uapi/rdma/hns-abi.h                 |  17 +++
>>  5 files changed, 128 insertions(+), 30 deletions(-)
>  
> There should be no space after the fixes line, please check all
> patches
> 
> Also this entire series seems unsuitable to go into for-rc
> 
> You need to justify the impact of each rc patch in the commit message,
> and nearly evey rc patch should have a fixes tag. 
> 
> Make the first two patches are OK for -rc, but they should have better
> commit messages.
> 
> Jason
> .
> 
