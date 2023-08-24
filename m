Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE681786920
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Aug 2023 09:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjHXH6h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Aug 2023 03:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238424AbjHXH6V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Aug 2023 03:58:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D8D170B;
        Thu, 24 Aug 2023 00:58:19 -0700 (PDT)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RWb591sXvzrSMp;
        Thu, 24 Aug 2023 15:56:45 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 24 Aug 2023 15:58:16 +0800
Message-ID: <7c94dd6a-4fab-10dc-b0bb-2d9caa16a148@hisilicon.com>
Date:   Thu, 24 Aug 2023 15:58:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH for-next 0/3] RDMA/hns: Add more debugging information for
 rdma-tool
To:     Leon Romanovsky <leon@kernel.org>
CC:     <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
References: <20230816091812.2899366-1-huangjunxian6@hisilicon.com>
 <20230819113212.GN22185@unreal>
Content-Language: en-US
From:   Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20230819113212.GN22185@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.120.168]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2023/8/19 19:32, Leon Romanovsky wrote:
> On Wed, Aug 16, 2023 at 05:18:09PM +0800, Junxian Huang wrote:
>> 1. #1: The first patch supports dumping QP/CQ/MR context entirely in raw
>>        data with rdma-tool.
>>
>> 2. #2: The second patch supports query of HW stats with rdma-tool.
>>
>> 3. #3: The last patch supports query of SW stats with rdma-tool.
>>
>> Chengchang Tang (3):
>>   RDMA/hns: Dump whole QP/CQ/MR resource in raw
>>   RDMA/hns: Support hns HW stats
> 
> These two patches generate static analyzer warnings.
> ➜  kernel git:(wip/leon-for-next) mkt ci --rev 0a68261bbbe5
> 0a68261bbbe5 (HEAD -> build) RDMA/hns: Dump whole QP/CQ/MR resource in raw
> WARNING: 'informations' may be misspelled - perhaps 'information'?
> #7:
> rdma-tool, but these informations are not enough. It is very
>                      ^^^^^^^^^^^^
> ➜  kernel git:(wip/leon-for-next) mkt ci
> 5a87279591a1 (HEAD -> build) RDMA/hns: Support hns HW stats
> drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1651:35: warning: restricted __le16 degrades to integer
> 

OK，I'll fix them in V2.

>>   RDMA/hns: Support hns SW stats
> 
> This is not support SW stats, but actually implementation of SW
> statistics which you exposed through rdmatool. That tool is

Yes,

> not right place for such information and debugfs will be better
> fit.
> 
> Thanks
> 

but from what I have seen, efa and bnxt_re drivers also use rdmatool
to expose SW statisics.

And could you please explain why rdmatool is not suitable for this?

Junxian

>>
>>  drivers/infiniband/hw/hns/hns_roce_ah.c       |   6 +-
>>  drivers/infiniband/hw/hns/hns_roce_cmd.c      |  19 ++-
>>  drivers/infiniband/hw/hns/hns_roce_cq.c       |  15 +-
>>  drivers/infiniband/hw/hns/hns_roce_device.h   |  50 ++++++
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c    |  59 +++++++
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h    |   1 +
>>  drivers/infiniband/hw/hns/hns_roce_main.c     | 152 +++++++++++++++++-
>>  drivers/infiniband/hw/hns/hns_roce_mr.c       |  26 ++-
>>  drivers/infiniband/hw/hns/hns_roce_pd.c       |  10 +-
>>  drivers/infiniband/hw/hns/hns_roce_qp.c       |   8 +-
>>  drivers/infiniband/hw/hns/hns_roce_restrack.c |  75 +--------
>>  drivers/infiniband/hw/hns/hns_roce_srq.c      |   6 +-
>>  12 files changed, 325 insertions(+), 102 deletions(-)
>>
>> --
>> 2.30.0
>>
