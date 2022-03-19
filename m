Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1314DE723
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Mar 2022 09:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbiCSIzo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Mar 2022 04:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiCSIzn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 19 Mar 2022 04:55:43 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7082D6388
        for <linux-rdma@vger.kernel.org>; Sat, 19 Mar 2022 01:54:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V7aAr2-_1647680059;
Received: from 30.236.17.167(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V7aAr2-_1647680059)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 19 Mar 2022 16:54:20 +0800
Message-ID: <62e047db-41e6-4f36-4747-1fcbb593a09a@linux.alibaba.com>
Date:   Sat, 19 Mar 2022 16:54:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH for-next v4 06/12] RDMA/erdma: Add event queue
 implementation
Content-Language: en-US
To:     Wenpeng Liang <liangwenpeng@huawei.com>, jgg@ziepe.ca,
        dledford@redhat.com
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com,
        BMT@zurich.ibm.com
References: <20220314064739.81647-1-chengyou@linux.alibaba.com>
 <20220314064739.81647-7-chengyou@linux.alibaba.com>
 <57cd0171-5964-228f-b004-06cec1e4daae@huawei.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <57cd0171-5964-228f-b004-06cec1e4daae@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 3/18/22 7:43 PM, Wenpeng Liang wrote:
> On 2022/3/14 14:47, Cheng Xu wrote:
>> Event queue (EQ) is the main notifcaition way from erdma hardware to its
>> driver. Each erdma device contains 2 kinds EQs: asynchronous EQ (AEQ) and
>> completion EQ (CEQ). Per device has 1 AEQ, which used for RDMA async event
>> report, and max to 32 CEQs (numbered for CEQ0 to CEQ31). CEQ0 is used for
>> cmdq completion event report, and the rest CEQs are used for RDMA
>> completion event report.
>>
> 
> notifcaition -> notification.
> 

Sorry for these typos, will fix them.

> <...>
>> +static void *get_eq_entry(struct erdma_eq *eq, u16 idx)
>> +{
>> +	idx &= (eq->depth - 1);
>> +
>> +	return eq->qbuf + (idx << EQE_SHIFT);
>> +}
>> +
>> +void *get_next_valid_eqe(struct erdma_eq *eq)
>> +{
>> +	u64 *eqe = (u64 *)get_eq_entry(eq, eq->ci);
> 
> The pointer type returned by get_eq_entry is "void *",
> which does not need to be cast.
> 

OK, will fix.

> <...>
>> +void erdma_aeq_event_handler(struct erdma_dev *dev)
>> +{
>> +	struct erdma_aeqe *aeqe;
>> +	u32 cqn, qpn;
>> +	struct erdma_qp *qp;
>> +	struct erdma_cq *cq;
>> +	struct ib_event event;
>> +	u32 poll_cnt = 0;
>> +
>> +	memset(&event, 0, sizeof(event));
>> +
>> +	while (poll_cnt < MAX_POLL_CHUNK_SIZE) {
>> +		aeqe = (struct erdma_aeqe *)get_next_valid_eqe(&dev->aeq);
> 
> Ditto.
> 
>> +		if (!aeqe)
>> +			break;
>> +
>> +		poll_cnt++;
>> +
>> +		if (FIELD_GET(ERDMA_AEQE_HDR_TYPE_MASK, aeqe->hdr) ==
>> +		    ERDMA_AE_TYPE_CQ_ERR) {
>> +			cqn = aeqe->event_data0;
>> +			cq = find_cq_by_cqn(dev, cqn);
>> +			if (!cq)
>> +				continue;
> 
> As with the else branch, also having a blank line makes the code clearer.
> 

Will fix.

>> +			event.device = cq->ibcq.device;
>> +			event.element.cq = &cq->ibcq;
>> +			event.event = IB_EVENT_CQ_ERR;
>> +			if (cq->ibcq.event_handler)
>> +				cq->ibcq.event_handler(&event,
>> +						       cq->ibcq.cq_context);
>> +		} else {
>> +			qpn = aeqe->event_data0;
>> +			qp = find_qp_by_qpn(dev, qpn);
>> +			if (!qp)
>> +				continue;
>> +
>> +			event.device = qp->ibqp.device;
>> +			event.element.qp = &qp->ibqp;
> <...>
>> +void erdma_ceq_completion_handler(struct erdma_eq_cb *ceq_cb)
>> +{
>> +	int cqn;
>> +	struct erdma_cq *cq;
>> +	struct erdma_dev *dev = ceq_cb->dev;
>> +	u32 poll_cnt = 0;
>> +	u64 *hdr;
>> +
>> +	if (!ceq_cb->ready)
>> +		return;
>> +
>> +	while (poll_cnt < MAX_POLL_CHUNK_SIZE) {
>> +		hdr = (u64 *)get_next_valid_eqe(&ceq_cb->eq);
> 
> The pointer type returned by get_next_valid_eqe is "void *",
> which does not need to be cast.
> 

Will fix.

> <...>
>> +static int erdma_set_ceq_irq(struct erdma_dev *dev, u16 ceqn)
>> +{
>> +	struct erdma_eq_cb *eqc = &dev->ceqs[ceqn];
>> +	cpumask_t affinity_hint_mask;
>> +	u32 cpu;
>> +	int err;
>> +
>> +	snprintf(eqc->irq_name, ERDMA_IRQNAME_SIZE, "erdma-ceq%u@pci:%s",
>> +		ceqn, pci_name(dev->pdev));
> 
> Parameters in parentheses are not vertically aligned, a space is missing before "ceqn".
> 

Will fix.

> <...>
>> +static int create_eq_cmd(struct erdma_dev *dev, u32 eqn, struct erdma_eq *eq)
>> +{
>> +	struct erdma_cmdq_create_eq_req req;
>> +	dma_addr_t db_info_dma_addr;
>> +
>> +	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_COMMON,
>> +				CMDQ_OPCODE_CREATE_EQ);
>> +	req.eqn = eqn;
>> +	req.depth = ilog2(eq->depth);
>> +	req.qbuf_addr = eq->qbuf_dma_addr;
>> +	req.qtype = 1; /* CEQ */
> 
> Use a macro to represent "1", so this comment is not needed.

Will fix.

> 
> <...>
>> +static int erdma_ceq_init_one(struct erdma_dev *dev, u16 ceqn)
>> +{
>> +	struct erdma_eq *eq = &dev->ceqs[ceqn].eq;
>> +	u32 buf_size = ERDMA_DEFAULT_EQ_DEPTH << EQE_SHIFT;
>> +	int ret;
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
>> +	atomic64_set(&eq->notify_num, 0);
>> +
>> +	eq->depth = ERDMA_DEFAULT_EQ_DEPTH;
>> +	eq->db_addr = (u64 __iomem *)(dev->func_bar +
>> +				      ERDMA_REGS_CEQ_DB_BASE_REG +
>> +				      (ceqn + 1) * 8);
> 
> Does this "8" represent the byte width of a "u64 __iomem*" type?
> 

Yes, each EQ's doorbell takes 8 Bytes, I will use a micro instead of
this magic number.

> <...>
>> +int erdma_ceqs_init(struct erdma_dev *dev)
>> +{
>> +	u32 i, j;
>> +	int err = 0;
> 
> The "err" does not need to be initialized to 0, it has been reassigned
> before the function returns.
> 

OK, will fix.

Thanks,
Cheng Xu

> Thanks,
> Wenpeng
>> +
>> +	for (i = 0; i < dev->attrs.irq_num - 1; i++) {
>> +		err = erdma_ceq_init_one(dev, i);
>> +		if (err)
>> +			goto out_err;
>> +
>> +		err = erdma_set_ceq_irq(dev, i);
>> +		if (err) {
>> +			erdma_ceq_uninit_one(dev, i);
>> +			goto out_err;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +
>> +out_err:
>> +	for (j = 0; j < i; j++) {
>> +		erdma_free_ceq_irq(dev, j);
>> +		erdma_ceq_uninit_one(dev, j);
>> +	}
>> +
>> +	return err;
>> +}
>> +
