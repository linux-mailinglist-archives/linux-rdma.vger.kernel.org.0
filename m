Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BFA542E0C
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jun 2022 12:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbiFHKlW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jun 2022 06:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236591AbiFHKlV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Jun 2022 06:41:21 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642481D8809;
        Wed,  8 Jun 2022 03:41:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VFlnOFv_1654684873;
Received: from 30.43.105.165(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VFlnOFv_1654684873)
          by smtp.aliyun-inc.com;
          Wed, 08 Jun 2022 18:41:14 +0800
Message-ID: <47f97387-5587-3f81-1407-3e1d943025cb@linux.alibaba.com>
Date:   Wed, 8 Jun 2022 18:41:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH -next] RDMA/erdma: remove unneeded semicolon
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Yang Li <yang.lee@linux.alibaba.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, kaishen@linux.alibaba.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20220608005534.76789-1-yang.lee@linux.alibaba.com>
 <ef94d5de-da12-a894-8ff3-af7ecf9d568a@linux.alibaba.com>
 <YqBWrU27/wNsLU/u@unreal>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <YqBWrU27/wNsLU/u@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 6/8/22 3:58 PM, Leon Romanovsky wrote:
> On Wed, Jun 08, 2022 at 11:36:07AM +0800, Cheng Xu wrote:
>>
>>
>> On 6/8/22 8:55 AM, Yang Li wrote:
>>> Eliminate the following coccicheck warning:
>>> ./drivers/infiniband/hw/erdma/erdma_qp.c:254:3-4: Unneeded semicolon
>>>
>>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>>> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>>
>> Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
>>
>> Thanks.
>>
>>
>> Jason,
>>
>> BTW, are this and other two patches for erdma posted today parts of
>> the static checker reports which you mentioned in [1] ? If so, I think I
>> should re-post the v10 patches including the fixes ?
> 
> Yes, the fixes need to be squashed into the relevant patches.
> 
> Thanks
> 

Get it, thanks.
Cheng Xu

>>
>> Thanks,
>> Cheng Xu
>>
>> [1] https://lore.kernel.org/linux-rdma/20220606154754.GA645238@nvidia.com/
