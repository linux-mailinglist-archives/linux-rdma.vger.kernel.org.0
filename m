Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A7D4DD92C
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Mar 2022 12:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiCRLoo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Mar 2022 07:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235959AbiCRLon (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Mar 2022 07:44:43 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37796114FC5
        for <linux-rdma@vger.kernel.org>; Fri, 18 Mar 2022 04:43:24 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KKhwS3vgyz1GCd1;
        Fri, 18 Mar 2022 19:43:20 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 19:43:22 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 18 Mar
 2022 19:43:22 +0800
Subject: Re: [PATCH for-next v4 06/12] RDMA/erdma: Add event queue
 implementation
To:     Cheng Xu <chengyou@linux.alibaba.com>, <jgg@ziepe.ca>,
        <dledford@redhat.com>
References: <20220314064739.81647-1-chengyou@linux.alibaba.com>
 <20220314064739.81647-7-chengyou@linux.alibaba.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <KaiShen@linux.alibaba.com>, <tonylu@linux.alibaba.com>,
        <BMT@zurich.ibm.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <57cd0171-5964-228f-b004-06cec1e4daae@huawei.com>
Date:   Fri, 18 Mar 2022 19:43:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20220314064739.81647-7-chengyou@linux.alibaba.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
> Event queue (EQ) is the main notifcaition way from erdma hardware to its
> driver. Each erdma device contains 2 kinds EQs: asynchronous EQ (AEQ) and
> completion EQ (CEQ). Per device has 1 AEQ, which used for RDMA async event
> report, and max to 32 CEQs (numbered for CEQ0 to CEQ31). CEQ0 is used for
> cmdq completion event report, and the rest CEQs are used for RDMA
> completion event report.
> 

notifcaition -> notification.

<...>
> +static void *get_eq_entry(struct erdma_eq *eq, u16 idx)
> +{
> +	idx &= (eq->depth - 1);
> +
> +	return eq->qbuf + (idx << EQE_SHIFT);
> +}
> +
> +void *get_next_valid_eqe(struct erdma_eq *eq)
> +{
> +	u64 *eqe = (u64 *)get_eq_entry(eq, eq->ci);

The pointer type returned by get_eq_entry is "void *",
which does not need to be cast.

<...>
> +void erdma_aeq_event_handler(struct erdma_dev *dev)
> +{
> +	struct erdma_aeqe *aeqe;
> +	u32 cqn, qpn;
> +	struct erdma_qp *qp;
> +	struct erdma_cq *cq;
> +	struct ib_event event;
> +	u32 poll_cnt = 0;
> +
> +	memset(&event, 0, sizeof(event));
> +
> +	while (poll_cnt < MAX_POLL_CHUNK_SIZE) {
> +		aeqe = (struct erdma_aeqe *)get_next_valid_eqe(&dev->aeq);

Ditto.

> +		if (!aeqe)
> +			break;
> +
> +		poll_cnt++;
> +
> +		if (FIELD_GET(ERDMA_AEQE_HDR_TYPE_MASK, aeqe->hdr) ==
> +		    ERDMA_AE_TYPE_CQ_ERR) {
> +			cqn = aeqe->event_data0;
> +			cq = find_cq_by_cqn(dev, cqn);
> +			if (!cq)
> +				continue;

As with the else branch, also having a blank line makes the code clearer.

> +			event.device = cq->ibcq.device;
> +			event.element.cq = &cq->ibcq;
> +			event.event = IB_EVENT_CQ_ERR;
> +			if (cq->ibcq.event_handler)
> +				cq->ibcq.event_handler(&event,
> +						       cq->ibcq.cq_context);
> +		} else {
> +			qpn = aeqe->event_data0;
> +			qp = find_qp_by_qpn(dev, qpn);
> +			if (!qp)
> +				continue;
> +
> +			event.device = qp->ibqp.device;
> +			event.element.qp = &qp->ibqp;
<...>
> +void erdma_ceq_completion_handler(struct erdma_eq_cb *ceq_cb)
> +{
> +	int cqn;
> +	struct erdma_cq *cq;
> +	struct erdma_dev *dev = ceq_cb->dev;
> +	u32 poll_cnt = 0;
> +	u64 *hdr;
> +
> +	if (!ceq_cb->ready)
> +		return;
> +
> +	while (poll_cnt < MAX_POLL_CHUNK_SIZE) {
> +		hdr = (u64 *)get_next_valid_eqe(&ceq_cb->eq);

The pointer type returned by get_next_valid_eqe is "void *",
which does not need to be cast.

<...>
> +static int erdma_set_ceq_irq(struct erdma_dev *dev, u16 ceqn)
> +{
> +	struct erdma_eq_cb *eqc = &dev->ceqs[ceqn];
> +	cpumask_t affinity_hint_mask;
> +	u32 cpu;
> +	int err;
> +
> +	snprintf(eqc->irq_name, ERDMA_IRQNAME_SIZE, "erdma-ceq%u@pci:%s",
> +		ceqn, pci_name(dev->pdev));

Parameters in parentheses are not vertically aligned, a space is missing before "ceqn".

<...>
> +static int create_eq_cmd(struct erdma_dev *dev, u32 eqn, struct erdma_eq *eq)
> +{
> +	struct erdma_cmdq_create_eq_req req;
> +	dma_addr_t db_info_dma_addr;
> +
> +	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_COMMON,
> +				CMDQ_OPCODE_CREATE_EQ);
> +	req.eqn = eqn;
> +	req.depth = ilog2(eq->depth);
> +	req.qbuf_addr = eq->qbuf_dma_addr;
> +	req.qtype = 1; /* CEQ */

Use a macro to represent "1", so this comment is not needed.

<...>
> +static int erdma_ceq_init_one(struct erdma_dev *dev, u16 ceqn)
> +{
> +	struct erdma_eq *eq = &dev->ceqs[ceqn].eq;
> +	u32 buf_size = ERDMA_DEFAULT_EQ_DEPTH << EQE_SHIFT;
> +	int ret;
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
> +	atomic64_set(&eq->notify_num, 0);
> +
> +	eq->depth = ERDMA_DEFAULT_EQ_DEPTH;
> +	eq->db_addr = (u64 __iomem *)(dev->func_bar +
> +				      ERDMA_REGS_CEQ_DB_BASE_REG +
> +				      (ceqn + 1) * 8);

Does this "8" represent the byte width of a "u64 __iomem*" type?

<...>
> +int erdma_ceqs_init(struct erdma_dev *dev)
> +{
> +	u32 i, j;
> +	int err = 0;

The "err" does not need to be initialized to 0, it has been reassigned
before the function returns.

Thanks,
Wenpeng
> +
> +	for (i = 0; i < dev->attrs.irq_num - 1; i++) {
> +		err = erdma_ceq_init_one(dev, i);
> +		if (err)
> +			goto out_err;
> +
> +		err = erdma_set_ceq_irq(dev, i);
> +		if (err) {
> +			erdma_ceq_uninit_one(dev, i);
> +			goto out_err;
> +		}
> +	}
> +
> +	return 0;
> +
> +out_err:
> +	for (j = 0; j < i; j++) {
> +		erdma_free_ceq_irq(dev, j);
> +		erdma_ceq_uninit_one(dev, j);
> +	}
> +
> +	return err;
> +}
> +
