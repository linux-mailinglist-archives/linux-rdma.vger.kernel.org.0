Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564C171F8E9
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Jun 2023 05:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjFBDZy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Jun 2023 23:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjFBDZx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Jun 2023 23:25:53 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1030C136;
        Thu,  1 Jun 2023 20:25:51 -0700 (PDT)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QXT0c5KGzzSrJk;
        Fri,  2 Jun 2023 11:25:36 +0800 (CST)
Received: from [10.67.102.17] (10.67.102.17) by kwepemi500006.china.huawei.com
 (7.221.188.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 2 Jun
 2023 11:25:49 +0800
Message-ID: <b99bf9a3-e2e9-2e5e-bdab-5c58a3ee421b@hisilicon.com>
Date:   Fri, 2 Jun 2023 11:25:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH for-next] RDMA/core: Get IB width and speed from netdev
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
References: <20230522012502.1529035-1-huangjunxian6@hisilicon.com>
 <ZHi/9SjEiHy8fBf0@nvidia.com>
Content-Language: en-US
From:   Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <ZHi/9SjEiHy8fBf0@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.17]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2023/6/1 23:57, Jason Gunthorpe wrote:
> On Mon, May 22, 2023 at 09:25:02AM +0800, Junxian Huang wrote:
>> From: Haoyue Xu <xuhaoyue1@hisilicon.com>
>>
>> Logic of retrieving netdev lanes and speed from net_device and
>> translating it to IB width and speed. Also, add a generic function
>> to translating netdev speed to IB speed.
>>
>> Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
>> Signed-off-by: Luoyouming <luoyouming@huawei.com>
>> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
>> ---
>>  drivers/infiniband/core/verbs.c | 19 +++++++++++++++++--
>>  include/rdma/ib_verbs.h         | 26 ++++++++++++++++++++++++++
>>  2 files changed, 43 insertions(+), 2 deletions(-)
> 
> Can you explain in the commit message why we'd want to do this?
> 
> Jason

Sure. I'll add the explanation in v2.

Junxian
