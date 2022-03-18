Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D724DD8C7
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Mar 2022 12:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbiCRLOw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Mar 2022 07:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235663AbiCRLOw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Mar 2022 07:14:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A813CDE6
        for <linux-rdma@vger.kernel.org>; Fri, 18 Mar 2022 04:13:33 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KKhDL4KlCzfYq9;
        Fri, 18 Mar 2022 19:12:02 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 19:13:31 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 18 Mar
 2022 19:13:31 +0800
Subject: Re: [PATCH for-next v4 05/12] RDMA/erdma: Add cmdq implementation
To:     Cheng Xu <chengyou@linux.alibaba.com>, <jgg@ziepe.ca>,
        <dledford@redhat.com>
References: <20220314064739.81647-1-chengyou@linux.alibaba.com>
 <20220314064739.81647-6-chengyou@linux.alibaba.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <KaiShen@linux.alibaba.com>, <tonylu@linux.alibaba.com>,
        <BMT@zurich.ibm.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <e1036da4-4175-3044-1e7f-e7b3710f9e61@huawei.com>
Date:   Fri, 18 Mar 2022 19:13:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20220314064739.81647-6-chengyou@linux.alibaba.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2022/3/14 14:47, Cheng Xu wrote:
<...>
> +static int erdma_cmdq_eq_init(struct erdma_dev *dev)
> +{
> +	struct erdma_cmdq *cmdq = &dev->cmdq;
> +	struct erdma_eq *eq = &cmdq->eq;
> +	u32 buf_size;
> +
> +	eq->depth = cmdq->max_outstandings;
> +	buf_size = eq->depth << EQE_SHIFT;
> +
> +	eq->qbuf = dma_alloc_coherent(&dev->pdev->dev,
> +				      WARPPED_BUFSIZE(buf_size),
> +				      &eq->qbuf_dma_addr,
> +				      GFP_KERNEL | __GFP_ZERO);
> +	if (!eq->qbuf)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&eq->lock);
> +	atomic64_set(&eq->event_num, 0);

This patchset sets and increases the reference count of event_num, but does not
call other interfaces such as atomic_dec_and_test to judge event_num. This
variable seems to be redundant in this patchset. Will subsequent patches
extend the function of event_num?

Similar to notify_num, armed_num.

<...>
> +
> +static void erdma_poll_single_cmd_completion(struct erdma_cmdq *cmdq,
> +					     __be32 *cqe)
> +{
> +	struct erdma_comp_wait *comp_wait;
> +	u16 sqe_idx, ctx_id;
> +	u64 *sqe;
> +	int i;
> +	u32 hdr0 = __be32_to_cpu(*cqe);
> +
> +	sqe_idx = __be32_to_cpu(*(cqe + 1));
> +	sqe = (u64 *)get_cmdq_sqe(cmdq, sqe_idx);

The pointer type returned by get_cmdq_sqe is "void *",
which does not need to be cast.

<...>
> +
> +static void erdma_polling_cmd_completions(struct erdma_cmdq *cmdq)
> +{
> +	u32 hdr;
> +	__be32 *cqe;
> +	unsigned long flags;
> +	u16 comp_num = 0;
> +	u8 owner, expect_owner;
> +	u16 cqe_idx;
> +
> +	spin_lock_irqsave(&cmdq->cq.lock, flags);
> +
> +	expect_owner = cmdq->cq.owner;
> +	cqe_idx = cmdq->cq.ci & (cmdq->cq.depth - 1);
> +
> +	while (1) {
> +		cqe = (__be32 *)get_cmdq_cqe(cmdq, cqe_idx);
> +		hdr = __be32_to_cpu(READ_ONCE(*cqe));
> +
> +		owner = FIELD_GET(ERDMA_CQE_HDR_OWNER_MASK, hdr);
> +		if (owner != expect_owner)
> +			break;
> +
> +		dma_rmb();
> +		erdma_poll_single_cmd_completion(cmdq, cqe);
> +		comp_num++;
> +		if (cqe_idx == cmdq->cq.depth - 1) {
> +			cqe_idx = 0;
> +			expect_owner = !expect_owner;
> +		} else {
> +			cqe_idx++;
> +		}
> +	}
> +
> +	if (comp_num) {
> +		cmdq->cq.ci += comp_num;
> +		cmdq->cq.owner = expect_owner;
> +
> +		if (cmdq->use_event)
> +			arm_cmdq_cq(cmdq);
> +	}
> +
> +	spin_unlock_irqrestore(&cmdq->cq.lock, flags);
> +}

The logic for judging whether cqe is valid is too complicated,
you can refer to the function get_sw_cqe_v2() of hns roce,
I hope it will help you.

Thanks,
Wenpeng
