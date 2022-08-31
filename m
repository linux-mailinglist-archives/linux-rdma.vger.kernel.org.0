Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA295A78EF
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Aug 2022 10:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiHaIXE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Aug 2022 04:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbiHaIWq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Aug 2022 04:22:46 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FD13E764
        for <linux-rdma@vger.kernel.org>; Wed, 31 Aug 2022 01:21:50 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MHcWM4SDDzlWfg;
        Wed, 31 Aug 2022 16:18:23 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 31 Aug 2022 16:21:48 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 31 Aug
 2022 16:21:47 +0800
Subject: Re: [PATCH for-next] RDMA/hns: Disable local invalidate operation
To:     Leon Romanovsky <leon@kernel.org>
References: <20220829105203.1569481-1-liangwenpeng@huawei.com>
 <Yw28pZu4wuLzfYVT@unreal>
CC:     <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <05451121-77dd-95ad-f768-35150e8a0165@huawei.com>
Date:   Wed, 31 Aug 2022 16:21:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <Yw28pZu4wuLzfYVT@unreal>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2022/8/30 15:30, Leon Romanovsky wrote:
> On Mon, Aug 29, 2022 at 06:52:03PM +0800, Wenpeng Liang wrote:
>> From: Yangyang Li <liyangyang20@huawei.com>
>>
>> Currently, local invalidate operation doesn't work well. So the hns driver
>> does not support it temporarily and removes related code.
> Please add Fixes line, and provide some context, so we can take it to
> -rc and to all stable@ trees so this feature will be deleted from
> previous kernel versions too.
> 

I forgot to add the Fixes line. I will add it and resend this patch.

Thanks,
Wenpeng

> Thanks
> 
>> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
>> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 11 -----------
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  2 --
>>  2 files changed, 13 deletions(-)
