Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1A06259A3
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Nov 2022 12:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiKKLlu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Nov 2022 06:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiKKLls (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Nov 2022 06:41:48 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97ABDF46;
        Fri, 11 Nov 2022 03:41:47 -0800 (PST)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N7xcX5qNjzRpCx;
        Fri, 11 Nov 2022 19:41:32 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 19:41:45 +0800
Received: from [10.67.103.121] (10.67.103.121) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 19:41:44 +0800
Subject: Re: [PATCH v3 for-rc 0/2] Fix sge_num bug
To:     Leon Romanovsky <leon@kernel.org>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>
References: <20221108133847.2304539-1-xuhaoyue1@hisilicon.com>
 <Y2vsZ+qPWJI/R94M@unreal>
From:   "xuhaoyue (A)" <xuhaoyue1@hisilicon.com>
Message-ID: <48d3efa2-60f8-c0dd-8206-8ca0466f3b77@hisilicon.com>
Date:   Fri, 11 Nov 2022 19:41:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <Y2vsZ+qPWJI/R94M@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.121]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Hi Jason and Leon,

Actually, I have another bugfix patch set needed to send, and I am waiting for this patch to apply. That one is not related to this patch set.
Could I send it out, since it is a little late for Linux 6.1?
Also, I wonder is that ok to send more than one patch set in the review list.

Sincerely,
haoyue(Aaron)

On 2022/11/10 2:07:35, Leon Romanovsky wrote:
> On Tue, Nov 08, 2022 at 09:38:45PM +0800, Haoyue Xu wrote:
>> The patchset mainly fixes the sge_num bug relates to sq_inline.
>>
>> Changes since v2:
>> 1. Move the refactor rq_inline and new CQE inline patches to go 
>> into for-next after this bugfix apply.
>> 2. Change the commit message to better explain the bug.
>> V2 Link: https://patchwork.kernel.org/project/linux-rdma/cover/20221026095054.2384620-1-xuhaoyue1@hisilicon.com/
>>
>> Luoyouming (2):
>>   RDMA/hns: Fix ext_sge num error when post send
>>   RDMA/hns: Fix the problem of sge nums
>>
>>  drivers/infiniband/hw/hns/hns_roce_device.h |   3 +
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |   3 +-
>>  drivers/infiniband/hw/hns/hns_roce_main.c   |  18 +++-
>>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 107 ++++++++++++++++----
>>  include/uapi/rdma/hns-abi.h                 |  15 +++
> 
> Jason,
> 
> I think that it was you who asked to send it to -rc. Given the amount of
> changes together with UAPI in second patch, are you sure that it is -rc4
> material?
> 
> Thanks
> 
>>  5 files changed, 125 insertions(+), 21 deletions(-)
>>
>> -- 
>> 2.30.0
>>
> .
> 
