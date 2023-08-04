Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B6B76F6E9
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Aug 2023 03:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjHDBZq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Aug 2023 21:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjHDBZp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Aug 2023 21:25:45 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA7C423E;
        Thu,  3 Aug 2023 18:25:41 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RH7Kv0nW8z1KCCn;
        Fri,  4 Aug 2023 09:24:35 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 09:25:38 +0800
Message-ID: <cd9cef17-7d59-6779-80d5-8322055163fd@huawei.com>
Date:   Fri, 4 Aug 2023 09:25:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH net-next] net/mlx5: remove many unnecessary NULL values
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
CC:     <borisp@nvidia.com>, <saeedm@nvidia.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20230801123854.375155-1-ruanjinjie@huawei.com>
 <20230803181730.GG53714@unreal>
From:   Ruan Jinjie <ruanjinjie@huawei.com>
In-Reply-To: <20230803181730.GG53714@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2023/8/4 2:17, Leon Romanovsky wrote:
> On Tue, Aug 01, 2023 at 08:38:54PM +0800, Ruan Jinjie wrote:
>> Ther are many pointers assigned first, which need not to be initialized, so
> 
> Ther -> There
> 
>> remove the NULL assignment.
> 
> assignment -> assignments.

Thank you! I'll fix the issues sooner.

> 
>>
>> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
>> ---
>>  drivers/net/ethernet/mellanox/mlx5/core/fpga/core.c   | 4 ++--
>>  drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.c | 2 +-
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>
> 
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
