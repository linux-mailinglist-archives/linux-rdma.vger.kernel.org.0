Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8328A7BC478
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Oct 2023 05:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbjJGDny (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Oct 2023 23:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjJGDnx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Oct 2023 23:43:53 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8153DCA;
        Fri,  6 Oct 2023 20:43:51 -0700 (PDT)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4S2WL93dfkz1P7t8;
        Sat,  7 Oct 2023 11:41:21 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 7 Oct 2023 11:43:48 +0800
Message-ID: <2d7a7131-a42f-3213-a337-05ef8a53b743@hisilicon.com>
Date:   Sat, 7 Oct 2023 11:43:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH 0/2] rdma: Support dumping SRQ resource in raw format
To:     Leon Romanovsky <leon@kernel.org>
CC:     <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        <netdev@vger.kernel.org>
References: <20230928063202.1435527-1-huangjunxian6@hisilicon.com>
 <20231002111631.GD7059@unreal>
Content-Language: en-US
From:   Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20231002111631.GD7059@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.120.168]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2023/10/2 19:16, Leon Romanovsky wrote:
> On Thu, Sep 28, 2023 at 02:32:00PM +0800, Junxian Huang wrote:
>> This patchset adds support to dump SRQ resource in raw format with
>> rdmatool. The corresponding kernel commit is aebf8145e11a
>> ("RDMA/core: Add support to dump SRQ resource in RAW format")
>>
>> Junxian Huang (1):
>>   rdma: Update uapi headers
>>
>> wenglianfa (1):
>>   rdma: Add support to dump SRQ resource in raw format
>>
>>  rdma/include/uapi/rdma/rdma_netlink.h |  2 ++
>>  rdma/res-srq.c                        | 17 ++++++++++++++++-
>>  rdma/res.h                            |  2 ++
>>  3 files changed, 20 insertions(+), 1 deletion(-)
> 
> rdmatool is part of iproute2 suite and as such To, Cc and Subject should
> follow that suite rules. You need to add David to "TO", add Stephen and
> netdev and add target (iproute2-next) for this patches.
> 
> See this randomly chosen series as an example.
> https://lore.kernel.org/netdev/20211014075358.239708-1-markzhang@nvidia.com/
> 
> or latest one
> https://lore.kernel.org/netdev/20231002104349.971927-1-tariqt@nvidia.com/T/#m7ef8e4ce275052d428b4f13ad9f3b41a4bf5d46b
> 
> Thanks
> 
>>
>> --
>> 2.30.0
>>

Thanks. I'll send it again.

Junxian
