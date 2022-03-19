Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E554DE719
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Mar 2022 09:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242513AbiCSIkJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Mar 2022 04:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242533AbiCSIkH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 19 Mar 2022 04:40:07 -0400
Received: from out199-15.us.a.mail.aliyun.com (out199-15.us.a.mail.aliyun.com [47.90.199.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02D62BE2DD
        for <linux-rdma@vger.kernel.org>; Sat, 19 Mar 2022 01:38:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V7aJnPD_1647679121;
Received: from 30.236.17.167(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V7aJnPD_1647679121)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 19 Mar 2022 16:38:42 +0800
Message-ID: <32e91657-4ca5-3012-cede-ac83e7b13d22@linux.alibaba.com>
Date:   Sat, 19 Mar 2022 16:38:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH for-next v4 05/12] RDMA/erdma: Add cmdq implementation
Content-Language: en-US
To:     Wenpeng Liang <liangwenpeng@huawei.com>, jgg@ziepe.ca,
        dledford@redhat.com
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com,
        BMT@zurich.ibm.com
References: <20220314064739.81647-1-chengyou@linux.alibaba.com>
 <20220314064739.81647-6-chengyou@linux.alibaba.com>
 <e1036da4-4175-3044-1e7f-e7b3710f9e61@huawei.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <e1036da4-4175-3044-1e7f-e7b3710f9e61@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 3/18/22 7:13 PM, Wenpeng Liang wrote:
> On 2022/3/14 14:47, Cheng Xu wrote:
> <...>
>> +static int erdma_cmdq_eq_init(struct erdma_dev *dev)
>> +{
>> +	struct erdma_cmdq *cmdq = &dev->cmdq;
>> +	struct erdma_eq *eq = &cmdq->eq;
>> +	u32 buf_size;
>> +
>> +	eq->depth = cmdq->max_outstandings;
>> +	buf_size = eq->depth << EQE_SHIFT;
>> +
>> +	eq->qbuf = dma_alloc_coherent(&dev->pdev->dev,
>> +				      WARPPED_BUFSIZE(buf_size),
>> +				      &eq->qbuf_dma_addr,
>> +				      GFP_KERNEL | __GFP_ZERO);
>> +	if (!eq->qbuf)
>> +		return -ENOMEM;
>> +
>> +	spin_lock_init(&eq->lock);
>> +	atomic64_set(&eq->event_num, 0);
> 
> This patchset sets and increases the reference count of event_num, but does not
> call other interfaces such as atomic_dec_and_test to judge event_num. This
> variable seems to be redundant in this patchset. Will subsequent patches
> extend the function of event_num?
> 
> Similar to notify_num, armed_num.
> 

Yes, We plan to expose these counters to ib_device_ops.get_hw_stats 
interface in later patches.

Thanks

> <...>
>> +
>> +static void erdma_poll_single_cmd_completion(struct erdma_cmdq *cmdq,
>> +					     __be32 *cqe)
>> +{
>> +	struct erdma_comp_wait *comp_wait;
>> +	u16 sqe_idx, ctx_id;
>> +	u64 *sqe;
>> +	int i;
>> +	u32 hdr0 = __be32_to_cpu(*cqe);
>> +
>> +	sqe_idx = __be32_to_cpu(*(cqe + 1));
>> +	sqe = (u64 *)get_cmdq_sqe(cmdq, sqe_idx);
> 
> The pointer type returned by get_cmdq_sqe is "void *",
> which does not need to be cast.
> 

Will fix.

> <...>
>> +
>> +static void erdma_polling_cmd_completions(struct erdma_cmdq *cmdq)
>> +{
>> +	u32 hdr;
>> +	__be32 *cqe;
>> +	unsigned long flags;
>> +	u16 comp_num = 0;
>> +	u8 owner, expect_owner;
>> +	u16 cqe_idx;
>> +
>> +	spin_lock_irqsave(&cmdq->cq.lock, flags);
>> +
>> +	expect_owner = cmdq->cq.owner;
>> +	cqe_idx = cmdq->cq.ci & (cmdq->cq.depth - 1);
>> +
>> +	while (1) {
>> +		cqe = (__be32 *)get_cmdq_cqe(cmdq, cqe_idx);
>> +		hdr = __be32_to_cpu(READ_ONCE(*cqe));
>> +
>> +		owner = FIELD_GET(ERDMA_CQE_HDR_OWNER_MASK, hdr);
>> +		if (owner != expect_owner)
>> +			break;
>> +
>> +		dma_rmb();
>> +		erdma_poll_single_cmd_completion(cmdq, cqe);
>> +		comp_num++;
>> +		if (cqe_idx == cmdq->cq.depth - 1) {
>> +			cqe_idx = 0;
>> +			expect_owner = !expect_owner;
>> +		} else {
>> +			cqe_idx++;
>> +		}
>> +	}
>> +
>> +	if (comp_num) {
>> +		cmdq->cq.ci += comp_num;
>> +		cmdq->cq.owner = expect_owner;
>> +
>> +		if (cmdq->use_event)
>> +			arm_cmdq_cq(cmdq);
>> +	}
>> +
>> +	spin_unlock_irqrestore(&cmdq->cq.lock, flags);
>> +}
> 
> The logic for judging whether cqe is valid is too complicated,
> you can refer to the function get_sw_cqe_v2() of hns roce,
> I hope it will help you.
> 

I will check this.

Thanks,
Cheng Xu

> Thanks,
> Wenpeng
