Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A63584B5B
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Jul 2022 08:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbiG2GFC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Jul 2022 02:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiG2GFC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 Jul 2022 02:05:02 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EFF19006
        for <linux-rdma@vger.kernel.org>; Thu, 28 Jul 2022 23:05:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VKk1nlk_1659074694;
Received: from 30.43.106.167(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VKk1nlk_1659074694)
          by smtp.aliyun-inc.com;
          Fri, 29 Jul 2022 14:04:55 +0800
Message-ID: <c2448883-b87b-b0a8-a1ed-70b1c6b34c18@linux.alibaba.com>
Date:   Fri, 29 Jul 2022 14:04:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v14 10/11] RDMA/erdma: Add the ABI definitions
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com
References: <20220727014927.76564-1-chengyou@linux.alibaba.com>
 <20220727014927.76564-11-chengyou@linux.alibaba.com>
 <YuHgRkOkuU5itoIe@nvidia.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <YuHgRkOkuU5itoIe@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 7/28/22 9:03 AM, Jason Gunthorpe wrote:
> On Wed, Jul 27, 2022 at 09:49:26AM +0800, Cheng Xu wrote:
>> Add erdma ABI definitions which will be shared between kernel and
>> userspace. This commit also fix compile issues reported by lkp.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
>> ---
>>  include/uapi/rdma/erdma-abi.h | 49 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 49 insertions(+)
>>  create mode 100644 include/uapi/rdma/erdma-abi.h
>>
>> diff --git a/include/uapi/rdma/erdma-abi.h b/include/uapi/rdma/erdma-abi.h
>> new file mode 100644
>> index 000000000000..fcbaff1d84c3
>> --- /dev/null
>> +++ b/include/uapi/rdma/erdma-abi.h
>> @@ -0,0 +1,49 @@
>> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
>> +/*
>> + * Copyright (c) 2020-2022, Alibaba Group.
>> + */
>> +
>> +#ifndef __ERDMA_USER_H__
>> +#define __ERDMA_USER_H__
>> +
>> +#include <linux/types.h>
>> +
>> +#define ERDMA_ABI_VERSION       1
>> +
>> +struct erdma_ureq_create_cq {
>> +	__u64 db_record_va;
>> +	__u64 qbuf_va;
> 
> These should all be __aligned_u64, I fixed it

Thanks, It's fine.

Cheng Xu

