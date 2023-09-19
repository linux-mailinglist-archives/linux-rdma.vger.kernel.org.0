Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4FC7A6052
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Sep 2023 12:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjISK5N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Sep 2023 06:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjISK4n (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Sep 2023 06:56:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7270C1BD2;
        Tue, 19 Sep 2023 03:53:44 -0700 (PDT)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rqdjx5pW0zVl5x;
        Tue, 19 Sep 2023 18:50:45 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 19 Sep 2023 18:53:42 +0800
Message-ID: <1fdda70d-54bb-1a7c-08cc-80462afd6576@hisilicon.com>
Date:   Tue, 19 Sep 2023 18:53:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH RFC] rdma: Add support to dump SRQ resource in raw format
Content-Language: en-US
To:     Mark Zhang <markzhang@nvidia.com>, <jgg@ziepe.ca>,
        <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>
References: <20230918131140.4037213-1-huangjunxian6@hisilicon.com>
 <a80d2e67-11f2-5b13-f966-b9150df1e568@nvidia.com>
From:   Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <a80d2e67-11f2-5b13-f966-b9150df1e568@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.120.168]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2023/9/19 13:34, Mark Zhang wrote:
> On 9/18/2023 9:11 PM, Junxian Huang wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> From: wenglianfa <wenglianfa@huawei.com>
>>
>> Add support to dump SRQ resource in raw format.
>>
>> This patch relies on the corresponding kernel patch:
>> RDMA/core: Add support to dump SRQ resource in RAW format
>>
>> Example:
>> $ rdma res show srq -r
>> dev hns3 149000...
>>
>> $ rdma res show srq -j -r
>> [{"ifindex":0,"ifname":"hns3","data":[149,0,0,...]}]
>>
>> Signed-off-by: wenglianfa <wenglianfa@huawei.com>
>> ---
>>   rdma/include/uapi/rdma/rdma_netlink.h |  2 ++
>>   rdma/res-srq.c                        | 17 ++++++++++++++++-
>>   rdma/res.h                            |  2 ++
>>   3 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/rdma/include/uapi/rdma/rdma_netlink.h b/rdma/include/uapi/rdma/rdma_netlink.h
>> index 92c528a0..84f775be 100644
>> --- a/rdma/include/uapi/rdma/rdma_netlink.h
>> +++ b/rdma/include/uapi/rdma/rdma_netlink.h
>> @@ -299,6 +299,8 @@ enum rdma_nldev_command {
>>
>>          RDMA_NLDEV_CMD_STAT_GET_STATUS,
>>
>> +       RDMA_NLDEV_CMD_RES_SRQ_GET_RAW,
>> +
>>          RDMA_NLDEV_NUM_OPS
>>   };
>>
> 
> Usually this file is submitted as a separate patch.
> 
Thanks. Will fix it in the formal patch.

Junxian
