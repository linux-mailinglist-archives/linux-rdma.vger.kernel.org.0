Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8779A63D138
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Nov 2022 09:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbiK3I7U (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Nov 2022 03:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233400AbiK3I7T (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Nov 2022 03:59:19 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AB13F045;
        Wed, 30 Nov 2022 00:59:16 -0800 (PST)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NMY5h2g0tzHwJZ;
        Wed, 30 Nov 2022 16:58:32 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 16:59:14 +0800
Received: from [10.67.103.121] (10.67.103.121) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 16:59:14 +0800
Subject: Re: [PATCH v3 for-rc 0/2] Fix sge_num bug
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
References: <20221108133847.2304539-1-xuhaoyue1@hisilicon.com>
 <Y3gh+am3+KRMzbMk@nvidia.com>
From:   "xuhaoyue (A)" <xuhaoyue1@hisilicon.com>
Message-ID: <a6c8867d-6c33-3baf-f672-bd235e839119@hisilicon.com>
Date:   Wed, 30 Nov 2022 16:59:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <Y3gh+am3+KRMzbMk@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.121]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Sorry about that. I will pay more attention to the commit messages in the future.
Could you give me some advice about it? Which patch makes it confusing?

Thanks,
haoyue

On 2022/11/19 8:23:21, Jason Gunthorpe wrote:
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
> 
> It is still not clear what the bugs are from the commit messages, and
> the second is a bit big, so I put this in for-next
> 
> Thanks,
> Jason
> .
> 
