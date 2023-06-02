Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3313C71FB67
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Jun 2023 09:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbjFBHzL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Jun 2023 03:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjFBHzK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Jun 2023 03:55:10 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9D2123;
        Fri,  2 Jun 2023 00:55:09 -0700 (PDT)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QXZtB2fvDz18LQp;
        Fri,  2 Jun 2023 15:50:26 +0800 (CST)
Received: from [10.67.102.17] (10.67.102.17) by kwepemi500006.china.huawei.com
 (7.221.188.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 2 Jun
 2023 15:55:06 +0800
Message-ID: <b5d8a033-171a-f269-a686-ddd5d15eb27c@hisilicon.com>
Date:   Fri, 2 Jun 2023 15:55:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH for-rc 0/3] RDMA/hns: Bugfix and improvements
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
References: <20230523121641.3132102-1-huangjunxian6@hisilicon.com>
 <ZHkjHl1H02sr8pnq@nvidia.com>
Content-Language: en-US
From:   Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <ZHkjHl1H02sr8pnq@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.17]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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



On 2023/6/2 7:00, Jason Gunthorpe wrote:
> On Tue, May 23, 2023 at 08:16:38PM +0800, Junxian Huang wrote:
>> 1. #1-#2: The first two patches improves diagnostic information to
>>    the driver.
>>
>> 2. #3: The third patch removes unnecessary QP type checks.
>>
>>
>> Chengchang Tang (2):
>>   RDMA/hns: Fix hns_roce_table_get return value
>>   RDMA/hns: Add clear_hem return value to log
>>
>> Junxian Huang (1):
>>   RDMA/hns: Remove unnecessary QP type checks
> 
> These are not -rc patches, they don't fix user facing things, so I put
> them in for-next
> 
> Also there was a compile warning I fixed
> 
> ../drivers/infiniband/hw/hns/hns_roce_hw_v2.c:767:20: warning: unused variable 'ibdev' [-Wunused-variable]
>         struct ib_device *ibdev = &hr_dev->ib_dev;
> 
> Although it could probably use more fixing.
> 
> Jason

Oops,that's our miss. Thanks!
