Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC744DE72B
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Mar 2022 10:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbiCSJIR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Mar 2022 05:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiCSJIQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 19 Mar 2022 05:08:16 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F202E8CE4
        for <linux-rdma@vger.kernel.org>; Sat, 19 Mar 2022 02:06:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V7aAYyR_1647680811;
Received: from 30.236.17.167(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V7aAYyR_1647680811)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 19 Mar 2022 17:06:51 +0800
Message-ID: <2dff3586-78e3-97e3-5343-2a826c96dc1c@linux.alibaba.com>
Date:   Sat, 19 Mar 2022 17:06:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH for-next v4 08/12] RDMA/erdma: Add verbs implementation
Content-Language: en-US
To:     Wenpeng Liang <liangwenpeng@huawei.com>, jgg@ziepe.ca,
        dledford@redhat.com
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        KaiShen@linux.alibaba.com, tonylu@linux.alibaba.com,
        BMT@zurich.ibm.com
References: <20220314064739.81647-1-chengyou@linux.alibaba.com>
 <20220314064739.81647-9-chengyou@linux.alibaba.com>
 <d61a22b5-249e-557e-cb23-c7035a97c767@huawei.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <d61a22b5-249e-557e-cb23-c7035a97c767@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 3/18/22 8:24 PM, Wenpeng Liang wrote:
> On 2022/3/14 14:47, Cheng Xu wrote:
>> The RDMA verbs implementation of erdma is divided into three files:
>> erdma_qp.c, erdma_cq.c, and erdma_verbs.c. Internal used functions and
>> datapath functions of QP/CQ are put in erdma_qp.c and erdma_cq.c, the reset
>> is in erdma_verbs.c.
> 
> reset -> rest.

Will fix.

> 
> <...>
>> +static int erdma_poll_one_cqe(struct erdma_cq *cq, struct erdma_cqe *cqe,
>> +			      struct ib_wc *wc)
>> +{
>> +	struct erdma_dev *dev = to_edev(cq->ibcq.device);
>> +	struct erdma_qp *qp;
>> +	struct erdma_kqp *kern_qp;
>> +	u64 *wqe_hdr;
>> +	u64 *id_table;
>> +	u32 qpn = be32_to_cpu(cqe->qpn);
>> +	u16 wqe_idx = be32_to_cpu(cqe->qe_idx);
>> +	u32 hdr = be32_to_cpu(cqe->hdr);
>> +	u16 depth;
>> +	u8 opcode, syndrome, qtype;
>> +
>> +	qp = find_qp_by_qpn(dev, qpn);
>> +	kern_qp = &qp->kern_qp;
> 
> The qp returned by find_qp_by_qpn may be null.
> 

Thanks, this is a bug, will fix.

>> +
>> +	qtype = FIELD_GET(ERDMA_CQE_HDR_QTYPE_MASK, hdr);
>> +	syndrome = FIELD_GET(ERDMA_CQE_HDR_SYNDROME_MASK, hdr);
>> +	opcode = FIELD_GET(ERDMA_CQE_HDR_OPCODE_MASK, hdr);
>> +
>> +	if (qtype == ERDMA_CQE_QTYPE_SQ) {
>> +		id_table = kern_qp->swr_tbl;
>> +		depth = qp->attrs.sq_size;
>> +		wqe_hdr = (u64 *)get_sq_entry(qp, wqe_idx);
> 
> The pointer type returned by get_sq_entry is "void *",
> which does not need to be cast.
> 

Also will fix.

> <...>
>> +int erdma_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *wc)
>> +{
>> +	struct erdma_cq *cq = to_ecq(ibcq);
>> +	struct erdma_cqe *cqe;
>> +	unsigned long flags;
>> +	u32 owner;
>> +	u32 ci;
>> +	int i, ret;
>> +	int new = 0;
>> +	u32 hdr;
>> +
>> +	spin_lock_irqsave(&cq->kern_cq.lock, flags);
>> +
>> +	owner = cq->kern_cq.owner;
>> +	ci = cq->kern_cq.ci;
>> +
>> +	for (i = 0; i < num_entries; i++) {
>> +		cqe = &cq->kern_cq.qbuf[ci & (cq->depth - 1)];
>> +
>> +		hdr = be32_to_cpu(READ_ONCE(cqe->hdr));
>> +		if (FIELD_GET(ERDMA_CQE_HDR_OWNER_MASK, hdr) != owner)
>> +			break;
>> +
>> +		/* cqbuf should be ready when we poll*/
> 
> "poll*/" -> "poll */".

Will fix.

> 
>> +		dma_rmb();
>> +		ret = erdma_poll_one_cqe(cq, cqe, wc);
>> +		ci++;
>> +		if ((ci & (cq->depth - 1)) == 0)
>> +			owner = !owner;
>> +		if (ret)
> 
> The return value of erdma_poll_one_cqe is always 0.

As you mentioned above, find_qp_by_qpn may return NULL, and then
erdma_poll_one_cqe should return a non-zero value. The code here is all
right, and I will fix the bug in erdma_poll_one_cqe.

> 
>> +			continue;
>> +		wc++;
>> +		new++;
>> +	}
>> +	cq->kern_cq.owner = owner;
>> +	cq->kern_cq.ci = ci;
>> +
>> +	spin_unlock_irqrestore(&cq->kern_cq.lock, flags);
>> +	return new;
>> +}
> <...>
>> +struct ib_qp *erdma_get_ibqp(struct ib_device *ibdev, int id)
>> +{
>> +	struct erdma_qp *qp = find_qp_by_qpn(to_edev(ibdev), id);
>> +
>> +	if (qp)
>> +		return &qp->ibqp;
>> +
>> +	return (struct ib_qp *)NULL;
> 
> Redundant cast?

Will fix.

> <...>
>> +int erdma_modify_qp_internal(struct erdma_qp *qp, struct erdma_qp_attrs *attrs,
>> +			     enum erdma_qp_attr_mask mask)
>> +{
>> +	int drop_conn = 0, ret = 0;
>> +
>> +	if (!mask)
>> +		return 0;
>> +
>> +	if (!(mask & ERDMA_QP_ATTR_STATE))
>> +		return 0;
>> +
>> +	switch (qp->attrs.state) {
>> +	case ERDMA_QP_STATE_IDLE:
>> +	case ERDMA_QP_STATE_RTR:
>> +		if (attrs->state == ERDMA_QP_STATE_RTS) {
>> +			ret = erdma_modify_qp_state_to_rts(qp, attrs, mask);
>> +		} else if (attrs->state == ERDMA_QP_STATE_ERROR) {
>> +			qp->attrs.state = ERDMA_QP_STATE_ERROR;
>> +			if (qp->cep) {
>> +				erdma_cep_put(qp->cep);
>> +				qp->cep = NULL;
>> +			}
>> +			ret = erdma_modify_qp_state_to_stop(qp, attrs, mask);
>> +		}
>> +		break;
>> +	case ERDMA_QP_STATE_RTS:
>> +		if (attrs->state == ERDMA_QP_STATE_CLOSING) {
>> +			ret = erdma_modify_qp_state_to_stop(qp, attrs, mask);
>> +			drop_conn = 1;
>> +		} else if (attrs->state == ERDMA_QP_STATE_TERMINATE) {
>> +			qp->attrs.state = ERDMA_QP_STATE_TERMINATE;
>> +			ret = erdma_modify_qp_state_to_stop(qp, attrs, mask);
>> +			drop_conn = 1;
>> +		} else if (attrs->state == ERDMA_QP_STATE_ERROR) {
>> +			ret = erdma_modify_qp_state_to_stop(qp, attrs, mask);
>> +			qp->attrs.state = ERDMA_QP_STATE_ERROR;
>> +			drop_conn = 1;
>> +		}
>> +		break;
>> +	case ERDMA_QP_STATE_TERMINATE:
>> +		if (attrs->state == ERDMA_QP_STATE_ERROR)
>> +			qp->attrs.state = ERDMA_QP_STATE_ERROR;
>> +		break;
>> +	case ERDMA_QP_STATE_CLOSING:
>> +		if (attrs->state == ERDMA_QP_STATE_IDLE)
>> +			qp->attrs.state = ERDMA_QP_STATE_IDLE;
>> +		else if (attrs->state == ERDMA_QP_STATE_ERROR) {
>> +			ret = erdma_modify_qp_state_to_stop(qp, attrs, mask);
>> +			qp->attrs.state = ERDMA_QP_STATE_ERROR;
>> +		} else if (attrs->state != ERDMA_QP_STATE_CLOSING) {
>> +			return -ECONNABORTED;
>> +		}
> 
> If the conditional statement has a branch with curly braces,
> then all branches use curly braces.
> 

Yes, will fix.

>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	if (drop_conn)
>> +		erdma_qp_cm_drop(qp);
> 
> Can this conditional statement be placed in the ERDMA_QP_STATE_RTS branch
> of the switch-case alternative branch?
> 
> The logic related to drop_conn is concentrated into one piece to improve
> code aggregation.
> 

Fine, it's better, and I will fix it.

>> +
>> +	return ret;
>> +}
> <...>
>> +static int erdma_push_one_sqe(struct erdma_qp *qp, u16 *pi,
>> +			      const struct ib_send_wr *send_wr)
>> +{
>> +	struct erdma_write_sqe *write_sqe;
>> +	struct erdma_send_sqe *send_sqe;
>> +	struct erdma_readreq_sqe *read_sqe;
>> +	struct erdma_reg_mr_sqe *regmr_sge;
>> +	struct erdma_mr *mr;
>> +	struct ib_rdma_wr *rdma_wr;
>> +	struct ib_sge *sge;
>> +	u32 wqe_size, wqebb_cnt, hw_op;
>> +	int ret;
>> +	u32 flags = send_wr->send_flags;
>> +	u32 idx = *pi & (qp->attrs.sq_size - 1);
>> +	u64 *entry = (u64 *)get_sq_entry(qp, idx);
> 
> <...>
> 
>> +		sge = (struct ib_sge *)get_sq_entry(qp, idx + 1);
> 
> <...>
> 
>> +			inline_data = (u64 *)get_sq_entry(qp, idx + 1);
> 
> The pointer type returned by get_sq_entry is "void *",
> which does not need to be cast.
> 

Will fix.

> <...>
>> +static int erdma_post_recv_one(struct ib_qp *ibqp,
>> +			       const struct ib_recv_wr *recv_wr,
>> +			       const struct ib_recv_wr **bad_recv_wr)
> 
> bad_recv_wr is a redundant input parameter.
> 

Will fix.

>> +{
>> +	struct erdma_qp *qp = to_eqp(ibqp);
>> +	struct erdma_rqe *rqe;
>> +	unsigned int rq_pi;
>> +	u16 idx;
>> +
>> +	rq_pi = qp->kern_qp.rq_pi;
>> +	idx = rq_pi & (qp->attrs.rq_size - 1);
>> +	rqe = (struct erdma_rqe *)qp->kern_qp.rq_buf + idx;
>> +
>> +	rqe->qe_idx = rq_pi + 1;
>> +	rqe->qpn = QP_ID(qp);
>> +
>> +	if (recv_wr->num_sge == 0) {
>> +		rqe->length = 0;
>> +	} else if (recv_wr->num_sge == 1) {
>> +		rqe->stag = recv_wr->sg_list[0].lkey;
>> +		rqe->to = recv_wr->sg_list[0].addr;
>> +		rqe->length = recv_wr->sg_list[0].length;
>> +	} else {
>> +		return -EINVAL;
>> +	}
>> +
>> +	*(u64 *)qp->kern_qp.rq_db_info = *(u64 *)rqe;
>> +	writeq(*(u64 *)rqe, qp->kern_qp.hw_rq_db);
>> +
>> +	qp->kern_qp.rwr_tbl[idx] = recv_wr->wr_id;
>> +	qp->kern_qp.rq_pi = rq_pi + 1;
>> +
>> +	return 0;
>> +}
>> +
>> +int erdma_post_recv(struct ib_qp *qp, const struct ib_recv_wr *recv_wr,
>> +		    const struct ib_recv_wr **bad_recv_wr)
>> +{
>> +	struct erdma_qp *eqp = to_eqp(qp);
>> +	int ret = 0;
>> +	const struct ib_recv_wr *wr = recv_wr;
>> +	unsigned long flags;
>> +
>> +	if (!qp || !recv_wr)
>> +		return -EINVAL;
>> +
>> +	spin_lock_irqsave(&eqp->lock, flags);
>> +	while (wr) {
>> +		ret = erdma_post_recv_one(qp, wr, bad_recv_wr);
>> +		if (ret) {
>> +			*bad_recv_wr = wr;
>> +			break;
>> +		}
>> +		wr = wr->next;
>> +	}
>> +	spin_unlock_irqrestore(&eqp->lock, flags);
>> +	return ret;
>> +}
> 
> The "ret" does not need to be initialized to 0, it has been reassigned
> before the function returns.
> 

Will fix.

> <...>
>> +static int erdma_create_stag(struct erdma_dev *dev, u32 *stag)
>> +{
>> +	int stag_idx;
>> +	u32 key = 0;
>> +
>> +	stag_idx = erdma_alloc_idx(&dev->res_cb[ERDMA_RES_TYPE_STAG_IDX]);
>> +	if (stag_idx < 0)
>> +		return stag_idx;
>> +
>> +	*stag = (stag_idx << 8) | (key & 0xFF);
> 
> The "key" is initialized to 0 and never assigned again.
> 

Will fix it.

> <...>
>> +int erdma_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
>> +		   int qp_attr_mask, struct ib_qp_init_attr *qp_init_attr)
>> +{
>> +	struct erdma_qp *qp;
>> +	struct erdma_dev *dev;
>> +
>> +	if (ibqp && qp_attr && qp_init_attr) {
>> +		qp = to_eqp(ibqp);
>> +		dev = to_edev(ibqp->device);
>> +	} else
>> +		return -EINVAL;
> 
> If the conditional statement has a branch with curly braces,
> then all branches use curly braces.
> 

Will fix it.

Thanks,
Cheng Xu

> Thanks,
> Wenpeng
