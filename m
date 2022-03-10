Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1654D4046
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Mar 2022 05:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbiCJE3V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Mar 2022 23:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbiCJE3V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Mar 2022 23:29:21 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC50BC1CBA
        for <linux-rdma@vger.kernel.org>; Wed,  9 Mar 2022 20:28:18 -0800 (PST)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KDbXZ5sZ9zcb08;
        Thu, 10 Mar 2022 12:23:26 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Mar 2022 12:28:16 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 10 Mar
 2022 12:28:16 +0800
Subject: Re: [PATCH v2 for-next] RDMA/hns: Use the reserved loopback QPs to
 free MR before destroying MPT
To:     Leon Romanovsky <leon@kernel.org>
References: <20220308130127.31398-1-liangwenpeng@huawei.com>
 <YiiwVALEM1urucId@unreal>
CC:     <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <66e1489d-2e3b-e1a5-dec0-d01c9c3c8102@huawei.com>
Date:   Thu, 10 Mar 2022 12:28:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YiiwVALEM1urucId@unreal>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2022/3/9 21:49, Leon Romanovsky wrote:
> On Tue, Mar 08, 2022 at 09:01:27PM +0800, Wenpeng Liang wrote:
>> From: Yixing Liu <liuyixing1@huawei.com>
>>
>> Before destroying MPT, the reserved loopback QPs send loopback IOs (one
>> write operation per SL). Completing these loopback IOs represents that
>> there isn't any outstanding request in MPT, then it's safe to destroy MPT.
>>
>> Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
>> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
>>
>> Changes since v1:
> The changes should be placed under "---" markup.
> 

Thanks, I will resend this patch.

Thanks,
Wenpeng

> Thanks
> 
>> * Allocate all reserved resources in one function.
>> * Clean up encoding issues.
>> * v1 Link: https://patchwork.kernel.org/project/linux-rdma/patch/20220225095654.24684-1-liangwenpeng@huawei.com/
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_device.h |   2 +
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 311 +++++++++++++++++++-
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  20 ++
>>  drivers/infiniband/hw/hns/hns_roce_mr.c     |   6 +-
>>  4 files changed, 335 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
>> index 21182ec56f18..3083d6db1d68 100644
