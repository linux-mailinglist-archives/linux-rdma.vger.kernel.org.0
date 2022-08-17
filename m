Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9F85966F9
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Aug 2022 03:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238083AbiHQBqm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Aug 2022 21:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbiHQBql (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Aug 2022 21:46:41 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA9A979C4
        for <linux-rdma@vger.kernel.org>; Tue, 16 Aug 2022 18:46:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VMTMNEB_1660700796;
Received: from 30.43.105.7(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VMTMNEB_1660700796)
          by smtp.aliyun-inc.com;
          Wed, 17 Aug 2022 09:46:38 +0800
Message-ID: <47178d1a-489d-d258-3722-34add81425c5@linux.alibaba.com>
Date:   Wed, 17 Aug 2022 09:46:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH for-rc] RDMA/erdma: Correct the max_qp and max_cq
 capacities of the device
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
References: <20220810014320.88026-1-chengyou@linux.alibaba.com>
 <YvucWrCLUYjljcTj@unreal>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <YvucWrCLUYjljcTj@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 8/16/22 9:32 PM, Leon Romanovsky wrote:
> On Wed, Aug 10, 2022 at 09:43:19AM +0800, Cheng Xu wrote:
>> QP0 in HW is used for CMDQ, and the rest is for RDMA QPs. So the actual
>> max_qp capacity reported to core should be max_qp (reported by HW) - 1.
>> So does max_cq.
>>
>> Fixes: 155055771704 ("RDMA/erdma: Add verbs implementation")
>> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
>> ---
>>  drivers/infiniband/hw/erdma/erdma_verbs.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
> 
> Thanks, applied both patches to -rc.
> 
> As a note, please group the patches properly and not as a reply.
> Or send them separately, or use cover letter.

It's my fault. I shouldn't send the two patches together in one git send-email
command.

Thanks,
Cheng Xu
