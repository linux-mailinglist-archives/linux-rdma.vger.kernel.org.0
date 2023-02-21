Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7A569D86F
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Feb 2023 03:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjBUCXW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Feb 2023 21:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjBUCXW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Feb 2023 21:23:22 -0500
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69019C654
        for <linux-rdma@vger.kernel.org>; Mon, 20 Feb 2023 18:23:20 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VcA6X8T_1676946196;
Received: from 30.221.100.179(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VcA6X8T_1676946196)
          by smtp.aliyun-inc.com;
          Tue, 21 Feb 2023 10:23:17 +0800
Message-ID: <242e0d17-fcf7-61dd-3903-e64e286d3843@linux.alibaba.com>
Date:   Tue, 21 Feb 2023 10:23:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH for-next 1/2] RDMA/erdma: Use fixed hardware page size
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com
References: <20230220102015.43047-1-chengyou@linux.alibaba.com>
 <20230220102015.43047-2-chengyou@linux.alibaba.com>
 <Y/QayUBR0P7tzde+@ziepe.ca>
Content-Language: en-US
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <Y/QayUBR0P7tzde+@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2/21/23 9:13 AM, Jason Gunthorpe wrote:
> On Mon, Feb 20, 2023 at 06:20:14PM +0800, Cheng Xu wrote:
>> Hardware page size is 4096, but the kernel's page size may vary. driver
>> should use hardware page size to set the parameters to hardware.
>>
>> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
>> ---
>>  drivers/infiniband/hw/erdma/erdma_hw.h    |  4 ++++
>>  drivers/infiniband/hw/erdma/erdma_verbs.c | 17 +++++++++--------
>>  2 files changed, 13 insertions(+), 8 deletions(-)
> 
> This should have a fixes line
> 

OK, I will send v2 after merge window.

Thanks,
Cheng Xu
