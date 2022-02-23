Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A75D4C07C8
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Feb 2022 03:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbiBWC0y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Feb 2022 21:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbiBWC0x (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Feb 2022 21:26:53 -0500
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904FB3B3DB
        for <linux-rdma@vger.kernel.org>; Tue, 22 Feb 2022 18:26:26 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V5FxXMy_1645583182;
Received: from 30.43.106.56(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V5FxXMy_1645583182)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 23 Feb 2022 10:26:24 +0800
Message-ID: <4996986d-97e3-3a81-94b8-688362883f18@linux.alibaba.com>
Date:   Wed, 23 Feb 2022 10:26:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH for-next v3 06/12] RDMA/erdma: Add event queue
 implementation
Content-Language: en-US
To:     dust.li@linux.alibaba.com, Cheng Xu <chengyou.xc@alibaba-inc.com>,
        jgg@ziepe.ca, dledford@redhat.com
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com
References: <20220217030116.6324-1-chengyou.xc@alibaba-inc.com>
 <20220217030116.6324-7-chengyou.xc@alibaba-inc.com>
 <20220222075331.GD5443@linux.alibaba.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20220222075331.GD5443@linux.alibaba.com>
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



On 2/22/22 3:53 PM, dust.li wrote:
> On Thu, Feb 17, 2022 at 11:01:10AM +0800, Cheng Xu wrote:
>> From: Cheng Xu <chengyou@linux.alibaba.com>
>>
>> Event queue (EQ) is the main notifcaition way from erdma hardware to its
>> driver. Each erdma device contains 2 kinds EQs: asynchronous EQ (AEQ) and
>> completion EQ (CEQ). Per device has 1 AEQ, which used for RDMA async event
>> report, and max to 32 CEQs (numbered for CEQ0 to CEQ31). CEQ0 is used for
>> cmdq completion event report, and the reset CEQs are used for RDMA
> 
> reset --> rest ?
> 

Yes, will fix it.

>> completion event report.
>>
>> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
>> ---
>> drivers/infiniband/hw/erdma/erdma_eq.c | 366 +++++++++++++++++++++++++
>> 1 file changed, 366 insertions(+)
>> create mode 100644 drivers/infiniband/hw/erdma/erdma_eq.c
>>
>> diff --git a/drivers/infiniband/hw/erdma/erdma_eq.c b/drivers/infiniband/hw/erdma/erdma_eq.c
>> new file mode 100644
>> index 000000000000..2a2215710e94
>> --- /dev/null
>> +++ b/drivers/infiniband/hw/erdma/erdma_eq.c
>> @@ -0,0 +1,366 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>> +
>> +/* Authors: Cheng Xu <chengyou@linux.alibaba.com> */
>> +/*          Kai Shen <kaishen@linux.alibaba.com> */
>> +/* Copyright (c) 2020-2022, Alibaba Group. */
>> +
>> +#include <linux/errno.h>
>> +#include <linux/types.h>
>> +#include <linux/pci.h>
>> +
>> +#include <rdma/iw_cm.h>
>> +#include <rdma/ib_verbs.h>
>> +#include <rdma/ib_user_verbs.h>
>> +
>> +#include "erdma.h"
>> +#include "erdma_cm.h"
>> +#include "erdma_hw.h"
>> +#include "erdma_verbs.h"
>> +
>> +void notify_eq(struct erdma_eq *eq)
>> +{
>> +	u64 db_data = FIELD_PREP(ERDMA_EQDB_CI_MASK, eq->ci) |
>> +		      FIELD_PREP(ERDMA_EQDB_ARM_MASK, 1);
>> +
>> +	*eq->db_record = db_data;
>> +	writeq(db_data, eq->db_addr);
>> +
>> +	atomic64_inc(&eq->notify_num);
>> +}
>> +
>> +static void *get_eq_entry(struct erdma_eq *eq, u16 idx)
>> +{
>> +	idx &= (eq->depth - 1);
>> +
>> +	return eq->qbuf + (idx << EQE_SHIFT);
>> +}
>> +
>> +static void *get_valid_eqe(struct erdma_eq *eq)
>> +{
>> +	u64 *eqe = (u64 *)get_eq_entry(eq, eq->ci);
>> +	u64 val = READ_ONCE(*eqe);
>> +
>> +	if (FIELD_GET(ERDMA_CEQE_HDR_O_MASK, val) == eq->owner) {
>> +		dma_rmb();
>> +		eq->ci++;
>> +		if ((eq->ci & (eq->depth - 1)) == 0)
>> +			eq->owner = !eq->owner;
>> +
>> +		atomic64_inc(&eq->event_num);
>> +		return eqe;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static int erdma_poll_aeq_event(struct erdma_eq *aeq, void *out)
>> +{
>> +	struct erdma_aeqe *aeqe;
>> +
>> +	aeqe = (struct erdma_aeqe *)get_valid_eqe(aeq);
>> +	if (aeqe && out) {
>> +		memcpy(out, aeqe, EQE_SIZE);
>> +		return 1;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +int erdma_poll_ceq_event(struct erdma_eq *ceq)
>> +{
>> +	u64 *ceqe;
>> +	u64 val;
>> +
>> +	ceqe = (u64 *)get_valid_eqe(ceq);
>> +	if (ceqe) {
>> +		val = READ_ONCE(*ceqe);
>> +		return FIELD_GET(ERDMA_CEQE_HDR_CQN_MASK, val);
>> +	}
>> +
>> +	return -1;
>> +}
> 
> Probably not a real issue. Just wonder why not use the same function
> format (i.e. return value, argument) for the above 2 erdma_poll_xxx_event()s ?
> 

Will consider this.

Thanks,
Cheng Xu
