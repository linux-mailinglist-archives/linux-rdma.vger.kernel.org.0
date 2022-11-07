Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7333761E87C
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Nov 2022 03:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiKGCC5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 6 Nov 2022 21:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiKGCCv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 6 Nov 2022 21:02:51 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F31DF4A
        for <linux-rdma@vger.kernel.org>; Sun,  6 Nov 2022 18:02:50 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VU5C.27_1667786565;
Received: from 30.221.98.186(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VU5C.27_1667786565)
          by smtp.aliyun-inc.com;
          Mon, 07 Nov 2022 10:02:48 +0800
Message-ID: <cf92c599-5078-1464-eed0-8ba72afb4824@linux.alibaba.com>
Date:   Mon, 7 Nov 2022 10:02:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH for-next 0/3] RDMA/erdma: Add atomic operations support
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
References: <20221027095741.48044-1-chengyou@linux.alibaba.com>
 <Y2e1pr36v3tm0l5A@unreal>
Content-Language: en-US
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <Y2e1pr36v3tm0l5A@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 11/6/22 9:24 PM, Leon Romanovsky wrote:
> On Thu, Oct 27, 2022 at 05:57:38PM +0800, Cheng Xu wrote:
>> Hi,
>>
>> This series introcuces atomic operations support for erdma driver:
>> - #1 extends access rights field in FRMR and REG MR commands to support
>>   IB_ACCESS_REMOTE_ATOMIC.
>> - #2 gets atomic capacity from hardware, and reports the cap to core.
>> - #3 implements the IO-path of atomic WR processing.
>>
>> Thanks,
>> Cheng Xu
>>
>> Cheng Xu (3):
>>   RDMA/erdma: Extend access right field of FRMR and REG MR to support
>>     atomic
>>   RDMA/erdma: Report atomic capacity when hardware supports atomic
>>     feature
>>   RDMA/erdma: Implement atomic operations support
> 
> It doesn't pass my static analyzer checks.
> 
> ➜  kernel git:(wip/leon-for-next) mkt ci
> 3f69c46621e3 (HEAD -> build) RDMA/erdma: Implement atomic operations support
> drivers/infiniband/hw/erdma/erdma_qp.c:365:26: warning: incorrect type in assignment (different base types)
> drivers/infiniband/hw/erdma/erdma_qp.c:365:26:    expected restricted __le32 [usertype] key
> drivers/infiniband/hw/erdma/erdma_qp.c:365:26:    got unsigned int [usertype] rkey
> 

I'm sorry for forgetting to run sparse for the code. 
I will send v2.

Thanks,
Cheng Xu

