Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276A650331C
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Apr 2022 07:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiDPCP5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Apr 2022 22:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiDPCOL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 Apr 2022 22:14:11 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219AADD95B
        for <linux-rdma@vger.kernel.org>; Fri, 15 Apr 2022 19:11:13 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KgGr81rrGz1HBy3;
        Sat, 16 Apr 2022 10:10:32 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 16 Apr 2022 10:11:11 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 16 Apr
 2022 10:11:11 +0800
Subject: Re: [PATCH for-next 2/2] RDMA/hns: Add NOP operation for sending WR
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220407131403.26040-1-liangwenpeng@huawei.com>
 <20220407131403.26040-3-liangwenpeng@huawei.com>
 <20220407132012.GL2120790@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <c71b711f-8c89-6ac5-850b-16624af14168@huawei.com>
Date:   Sat, 16 Apr 2022 10:11:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20220407132012.GL2120790@nvidia.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2022/4/7 21:20, Jason Gunthorpe wrote:
> On Thu, Apr 07, 2022 at 09:14:03PM +0800, Wenpeng Liang wrote:
>> From: Yangyang Li <liyangyang20@huawei.com>
>>
>> The NOP operation is a no-op, mainly used in scenarios where SQWQE requires
>> page alignment or WQE size alignment. Each NOP WR consumes one SQWQE, but
>> the hardware does not operate and directly generates a CQE. The IB
>> specification does not specify this type of WR.
>>
>> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
>> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
>> ---
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 9 +++++++++
>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 9 +++++++++
>>  2 files changed, 18 insertions(+)
> 
> Where is it used?
> 

This function has a precondition. The driver needs to provide two interfaces
to the user, one interface is used to fill the wqe, and the other is used to
ring the doorbell. If the content of the wqe is repeated, then the user does
not need to fill this wqe again but directly rings the doorbell.

If the user's wqe used to complete the specified work request does not fill
the send queue, then the user can fill the remaining wqe in the send queue
as a NOP operation.

This feature requires some cooperating code and does not meet the upstream
conditions. Therefore, I will revoke this patch.

Thanks,
Wenpeng

> Jason
> .
> 
