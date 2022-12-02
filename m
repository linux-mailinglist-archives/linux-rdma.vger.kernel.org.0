Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DE264008F
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Dec 2022 07:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiLBGbX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Dec 2022 01:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiLBGbX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Dec 2022 01:31:23 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB1ACB22D
        for <linux-rdma@vger.kernel.org>; Thu,  1 Dec 2022 22:31:22 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NNjk56vxCzRpbB;
        Fri,  2 Dec 2022 14:30:37 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 2 Dec 2022 14:31:20 +0800
Subject: Re: [PATCH] infiniband:cma: change iboe packet life time from 18 to
 16
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>
References: <20221125010026.755-1-lengchao@huawei.com>
From:   Chao Leng <lengchao@huawei.com>
Message-ID: <227d7bf5-d8da-8a0f-0835-7bfb7d5672fb@huawei.com>
Date:   Fri, 2 Dec 2022 14:31:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20221125010026.755-1-lengchao@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi, jason
     Gently ping, thank you.

On 2022/11/25 9:00, Chao Leng wrote:
> The ack timeout retransmission time is affected by the following two
> factors: one is packet life time, another is the HCA processing time.
> Now the default packet lifetime(CMA_IBOE_PACKET_LIFETIME) is 18.
> That means the minimum ack timeout is 2 seconds(2^(18+1)*4us=2.097seconds).
> The packet lifetime means the maximum transmission time of packets
> on the network, 2 seconds is too long.
> Assume the network is a clos topology with three layers, every packet
> will pass through five hops of switches. Assume the buffer of every
> switch is 128MB and the port transmission rate is 25 Gbit/s,
> the maximum transmission time of the packet is 200ms(128MB*5/25Gbit/s).
> Add double redundancy, it is less than 500ms.
> So change the CMA_IBOE_PACKET_LIFETIME to 16,
> the maximum transmission time of the packet will be about 500+ms,
> it is long enough.
> 
> Signed-off-by: Chao Leng <lengchao@huawei.com>
> ---
>   drivers/infiniband/core/cma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index cc2222b85c88..2f5b5e6f3d11 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -47,7 +47,7 @@ MODULE_LICENSE("Dual BSD/GPL");
>   #define CMA_CM_RESPONSE_TIMEOUT 20
>   #define CMA_MAX_CM_RETRIES 15
>   #define CMA_CM_MRA_SETTING (IB_CM_MRA_FLAG_DELAY | 24)
> -#define CMA_IBOE_PACKET_LIFETIME 18
> +#define CMA_IBOE_PACKET_LIFETIME 16
>   #define CMA_PREFERRED_ROCE_GID_TYPE IB_GID_TYPE_ROCE_UDP_ENCAP
>   
>   static const char * const cma_events[] = {
> 
