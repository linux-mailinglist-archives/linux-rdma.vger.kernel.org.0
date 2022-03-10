Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE524D4597
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Mar 2022 12:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239648AbiCJLXC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Mar 2022 06:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbiCJLXB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Mar 2022 06:23:01 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68071137584
        for <linux-rdma@vger.kernel.org>; Thu, 10 Mar 2022 03:22:00 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0V6oiS81_1646911316;
Received: from 30.43.105.100(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V6oiS81_1646911316)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 10 Mar 2022 19:21:57 +0800
Message-ID: <12c06f78-64f1-8a93-b468-0f79415bb4d1@linux.alibaba.com>
Date:   Thu, 10 Mar 2022 19:21:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH for-next v3 07/12] RDMA/erdma: Add verbs header file
Content-Language: en-US
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        "dust.li@linux.alibaba.com" <dust.li@linux.alibaba.com>,
        Cheng Xu <chengyou.xc@alibaba-inc.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>
Cc:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "KaiShen@linux.alibaba.com" <KaiShen@linux.alibaba.com>,
        "tonylu@linux.alibaba.com" <tonylu@linux.alibaba.com>
References: <BYAPR15MB26319EE484A7565AE8DAC3DC990A9@BYAPR15MB2631.namprd15.prod.outlook.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <BYAPR15MB26319EE484A7565AE8DAC3DC990A9@BYAPR15MB2631.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 3/10/22 12:33 AM, Bernard Metzler wrote:
> 
> 
>> -----Original Message-----
>> From: dust.li <dust.li@linux.alibaba.com>
>> Sent: Tuesday, 22 February 2022 11:41
>> To: Cheng Xu <chengyou.xc@alibaba-inc.com>; jgg@ziepe.ca;
>> dledford@redhat.com
>> Cc: leon@kernel.org; linux-rdma@vger.kernel.org;
>> KaiShen@linux.alibaba.com; chengyou@linux.alibaba.com;
>> tonylu@linux.alibaba.com
>> Subject: [EXTERNAL] Re: [PATCH for-next v3 07/12] RDMA/erdma: Add verbs
>> header file
>>
>> On Thu, Feb 17, 2022 at 11:01:11AM +0800, Cheng Xu wrote:
>>> From: Cheng Xu <chengyou@linux.alibaba.com>
>>>
>>> This header file defines the main structrues and functions used for RDMA
>>> Verbs, including qp, cq, mr ucontext, etc,.
>>>
>>> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
>>> ---
>>> drivers/infiniband/hw/erdma/erdma_verbs.h | 345 ++++++++++++++++++++++
>>> 1 file changed, 345 insertions(+)
>>> create mode 100644 drivers/infiniband/hw/erdma/erdma_verbs.h
>>>
>>> diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h
>> b/drivers/infiniband/hw/erdma/erdma_verbs.h
>>> new file mode 100644
>>> index 000000000000..261f8c0bdff3
>>> --- /dev/null
>>> +++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
>>> @@ -0,0 +1,345 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
>>> +
>>> +/* Authors: Cheng Xu <chengyou@linux.alibaba.com> */
>>> +/*          Kai Shen <kaishen@linux.alibaba.com> */
>>> +/* Copyright (c) 2020-2022, Alibaba Group. */
>>
>> Maybe it's better to use a single '/**/' for multilines in the comment.
>>
>>> +
>>> +#ifndef __ERDMA_VERBS_H__
>>> +#define __ERDMA_VERBS_H__
>>> +
>>> +#include <linux/errno.h>
>>> +
>>> +#include <rdma/iw_cm.h>
>>> +#include <rdma/ib_verbs.h>
>>> +#include <rdma/ib_user_verbs.h>
>>> +
>>> +#include "erdma.h"
>>> +#include "erdma_cm.h"
>>> +#include "erdma_hw.h"
>>> +
>>> +/* RDMA Capbility. */
> 
> Capability

Will fix.

> 
>>> +#define ERDMA_MAX_PD (128 * 1024)
>>> +#define ERDMA_MAX_SEND_WR 4096
>>> +#define ERDMA_MAX_ORD 128
>>> +#define ERDMA_MAX_IRD 128
>>> +#define ERDMA_MAX_SGE_RD 1
>>> +#define ERDMA_MAX_FMR 0
>>> +#define ERDMA_MAX_SRQ 0 /* not support srq now. */
>>> +#define ERDMA_MAX_SRQ_WR 0 /* not support srq now. */
>>> +#define ERDMA_MAX_SRQ_SGE 0 /* not support srq now. */
>>> +#define ERDMA_MAX_CONTEXT (128 * 1024)
>>> +#define ERDMA_MAX_SEND_SGE 6
>>> +#define ERDMA_MAX_RECV_SGE 1
>>> +#define ERDMA_MAX_INLINE (sizeof(struct erdma_sge) *
>> (ERDMA_MAX_SEND_SGE))
> 
> Wouldn't it make sense to define MAX_INLINE in
> the abi header file? The user level application
> also wants to know about it.
> 

It has another way to expose this capability in core code, e,g,
userspace providers can get MAX_INLINE from struct ib_qp_attr in
ibv_cmd_create_qp response.


> And, is the value correct? I did not check how the
> user data are carried over, but (from siw) I assume
> data are kept in sge[1] .. sge[n-1], and sge[0]
> would carry len information and point to sge[1] for
> data? With that it would be (ERDMA_MAX_SEND_SGE - 1)
> here.
> 

Yes. ERDMA's SQE generally has 3 parts: Header (8Byte), Task
Section (vary with different opcode) and SGE Section. SGE Section
contains sges or inline data, and the length information is always put
in Header Section.


Thanks,
Cheng Xu

<...>
