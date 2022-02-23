Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE694C07C0
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Feb 2022 03:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbiBWCYe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Feb 2022 21:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbiBWCYd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Feb 2022 21:24:33 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4C338798
        for <linux-rdma@vger.kernel.org>; Tue, 22 Feb 2022 18:24:05 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V5FyepN_1645583041;
Received: from 30.43.106.56(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V5FyepN_1645583041)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 23 Feb 2022 10:24:02 +0800
Message-ID: <1115891a-b69d-309e-e88f-7a8ca8070a80@linux.alibaba.com>
Date:   Wed, 23 Feb 2022 10:24:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH for-next v3 06/12] RDMA/erdma: Add event queue
 implementation
Content-Language: en-US
To:     Ma Ca <kealimaca@gmail.com>,
        Cheng Xu <chengyou.xc@alibaba-inc.com>, jgg@ziepe.ca,
        dledford@redhat.com
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com
References: <20220217030116.6324-1-chengyou.xc@alibaba-inc.com>
 <20220217030116.6324-7-chengyou.xc@alibaba-inc.com>
 <65ee7805-2785-5b02-671b-26868565226d@gmail.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <65ee7805-2785-5b02-671b-26868565226d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2/22/22 3:23 PM, Ma Ca wrote:
> 
> On 2022/2/17 11:01, Cheng Xu wrote:
>> From: Cheng Xu <chengyou@linux.alibaba.com>
>>

<...>

>> +    eq->qbuf = dma_alloc_coherent(&dev->pdev->dev,
>> +                      WARPPED_BUFSIZE(buf_size),
>> +                      &eq->qbuf_dma_addr, GFP_KERNEL);
>> +    if (!eq->qbuf)
>> +        return -ENOMEM;
>> +
>> +    memset(eq->qbuf, 0, WARPPED_BUFSIZE(buf_size));
> It's better replace the memset() by GFP_ZERO.

It is better, I will go through all the code and replace them.

Thanks.

>> +
>> +    spin_lock_init(&eq->lock);
>> +    atomic64_set(&eq->event_num, 0);
>> +    atomic64_set(&eq->notify_num, 0);
>> +
>> +    eq->depth = ERDMA_DEFAULT_EQ_DEPTH;
>> +    eq->db_addr = (u64 __iomem *)(dev->func_bar + 
>> ERDMA_REGS_AEQ_DB_REG);
>> +    eq->db_record = (u64 *)(eq->qbuf + buf_size);
>> +    eq->owner = 1;
>> +

<...>

>> +    erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_COMMON,
>> +                CMDQ_OPCODE_CREATE_EQ);
>> +    req.eqn = eqn;
>> +    req.depth = ilog2(eq->depth);
>> +    req.qbuf_addr = eq->qbuf_dma_addr;
>> +    req.qtype = 1; /* CEQ */
>> +    /* Vector index is the same sa EQN. */
> same sa -> same as

Will fix it.

>> +    req.vector_idx = eqn;
>> +    db_info_dma_addr = eq->qbuf_dma_addr + (eq->depth << EQE_SHIFT);
>> +    req.db_dma_addr_l = lower_32_bits(db_info_dma_addr);
>> +    req.db_dma_addr_h = upper_32_bits(db_info_dma_addr);
>> +
>> +    return erdma_post_cmd_wait(&dev->cmdq, (u64 *)&req,
>> +                   sizeof(struct erdma_cmdq_create_eq_req),
>> +                   NULL, NULL);
>> +}
>> +
>> +static int erdma_ceq_init_one(struct erdma_dev *dev, u16 ceqn)
>> +{
>> +    struct erdma_eq *eq = &dev->ceqs[ceqn].eq;
>> +    u32 buf_size = ERDMA_DEFAULT_EQ_DEPTH << EQE_SHIFT;
>> +    int ret;
>> +
>> +    eq->qbuf = dma_alloc_coherent(&dev->pdev->dev,
>> +                      WARPPED_BUFSIZE(buf_size),
>> +                      &eq->qbuf_dma_addr, GFP_KERNEL);
>> +    if (!eq->qbuf)
>> +        return -ENOMEM;
>> +
>> +    memset(eq->qbuf, 0, WARPPED_BUFSIZE(buf_size));
> ditto
<...>

>> +static void erdma_ceq_uninit_one(struct erdma_dev *dev, u16 ceqn)
>> +{
>> +    struct erdma_eq *eq = &dev->ceqs[ceqn].eq;
>> +    u32 buf_size = ERDMA_DEFAULT_EQ_DEPTH << EQE_SHIFT;
>> +    struct erdma_cmdq_destroy_eq_req req;
>> +    int err;
>> +
>> +    dev->ceqs[ceqn].ready = 0;
>> +
>> +    erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_COMMON,
>> +                CMDQ_OPCODE_DESTROY_EQ);
>> +    /* CEQ indexed from 1, 0 rsvd for CMDQ-EQ. */
>> +    req.eqn = ceqn + 1;
>> +    req.qtype = 1;
>> +    req.vector_idx = ceqn + 1;
>> +
>> +    err = erdma_post_cmd_wait(&dev->cmdq, (u64 *)&req, sizeof(req), 
>> NULL,
>> +                  NULL);
>> +    if (err)
>> +        return;
>> +
>> +    dma_free_coherent(&dev->pdev->dev, WARPPED_BUFSIZE(buf_size), 
>> eq->qbuf,
>> +              eq->qbuf_dma_addr);
> memleak maybe occurs at here when post failed.

If command failed, it means that the EQ is still owned by hardware, and
the queue buffer may be written by hardware after it is freed. I think
the current implementation is better than free it if command failed.

Thanks,
Cheng Xu


