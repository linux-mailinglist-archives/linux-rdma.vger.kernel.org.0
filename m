Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4DB49339B
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jan 2022 04:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351305AbiASD04 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jan 2022 22:26:56 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:40986 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351287AbiASD0u (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Jan 2022 22:26:50 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V2F8jKu_1642562808;
Received: from 30.43.72.229(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0V2F8jKu_1642562808)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 19 Jan 2022 11:26:48 +0800
Message-ID: <74bd1d56-a067-fb6f-132c-5b14c9137970@linux.alibaba.com>
Date:   Wed, 19 Jan 2022 11:26:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH rdma-next v2 07/11] RDMA/erdma: Add verbs implementation
Content-Language: en-US
To:     Bernard Metzler <BMT@zurich.ibm.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>
Cc:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "KaiShen@linux.alibaba.com" <KaiShen@linux.alibaba.com>,
        "tonylu@linux.alibaba.com" <tonylu@linux.alibaba.com>
References: <BYAPR15MB2631E68F8FB3AFF7113B4E5A99589@BYAPR15MB2631.namprd15.prod.outlook.com>
From:   Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <BYAPR15MB2631E68F8FB3AFF7113B4E5A99589@BYAPR15MB2631.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 1/18/22 10:06 PM, Bernard Metzler wrote:

<...>

>> +
>> +static const struct {
>> +	enum erdma_opcode erdma;
>> +	enum ib_wc_opcode base;
>> +} map_cqe_opcode[ERDMA_NUM_OPCODES] = {
>> +	{ ERDMA_OP_WRITE, IB_WC_RDMA_WRITE },
>> +	{ ERDMA_OP_READ, IB_WC_RDMA_READ },
>> +	{ ERDMA_OP_SEND, IB_WC_SEND },
>> +	{ ERDMA_OP_SEND_WITH_IMM, IB_WC_SEND },
>> +	{ ERDMA_OP_RECEIVE, IB_WC_RECV },
>> +	{ ERDMA_OP_RECV_IMM, IB_WC_RECV_RDMA_WITH_IMM },
>> +	{ ERDMA_OP_RECV_INV, IB_WC_LOCAL_INV }, /* confirm afterwards */
>> +	{ ERDMA_OP_REQ_ERR, IB_WC_RECV }, /* remove afterwards */
>> +	{ ERDNA_OP_READ_RESPONSE, IB_WC_RECV }, /* can not appear */
>> +	{ ERDMA_OP_WRITE_WITH_IMM, IB_WC_RDMA_WRITE },
>> +	{ ERDMA_OP_RECV_ERR, IB_WC_RECV_RDMA_WITH_IMM }, /* can not appear
> 
> I do not understand the four above /* comments */.
> What does it say?

The definition comes from ERDMA hardware, and is used both in driver and
device. Some opcodes are defined but not used now (ERDMA_OP_RECV_INV,
ERDMA_OP_REQ_ERR, ERDMA_OP_RECV_ERR), and some are not reported to CQE
never (ERDNA_OP_READ_RESPONSE). I will find a better way to keep the
mapping table without the useless mapping entries.

>> */
>> +	{ ERDMA_OP_INVALIDATE, IB_WC_LOCAL_INV },
>> +	{ ERDMA_OP_RSP_SEND_IMM, IB_WC_RECV },
>> +	{ ERDMA_OP_SEND_WITH_INV, IB_WC_SEND },
>> +	{ ERDMA_OP_REG_MR, IB_WC_REG_MR },
>> +	{ ERDMA_OP_LOCAL_INV, IB_WC_LOCAL_INV },
>> +	{ ERDMA_OP_READ_WITH_INV, IB_WC_RDMA_READ },
>> +};
>> +

<...>

>> +static int create_qp_cmd(struct erdma_dev *dev, struct erdma_qp *qp)
>> +{
>> +	struct erdma_cmdq_create_qp_req req;
>> +	struct erdma_pd *pd = to_epd(qp->ibqp.pd);
>> +	struct erdma_uqp *user_qp;
>> +	int err;
>> +
>> +	ERDMA_CMDQ_BUILD_REQ_HDR(&req, CMDQ_SUBMOD_RDMA,
>> CMDQ_OPCODE_CREATE_QP);
>> +
>> +	req.cfg0 = FIELD_PREP(ERDMA_CMD_CREATE_QP_SQ_DEPTH_MASK, ilog2(qp-
>>> attrs.sq_size)) |
>> +		   FIELD_PREP(ERDMA_CMD_CREATE_QP_QPN_MASK, QP_ID(qp));
>> +	req.cfg1 = FIELD_PREP(ERDMA_CMD_CREATE_QP_RQ_DEPTH_MASK, ilog2(qp-
>>> attrs.rq_size)) |
>> +		   FIELD_PREP(ERDMA_CMD_CREATE_QP_PD_MASK, pd->pdn);
>> +
>> +	if (qp->is_kernel_qp) {
> 
> use rdma_is_kernel_res(&qp->ibqp.res)
> 

Will fix.

>> +		u32 pgsz_range = ilog2(SZ_1M) - PAGE_SHIFT;
>> +
>> +		req.sq_cqn_mtt_cfg =
>> FIELD_PREP(ERDMA_CMD_CREATE_QP_PAGE_SIZE_MASK, pgsz_range) |
>> +				     FIELD_PREP(ERDMA_CMD_CREATE_QP_CQN_MASK, qp-
>>> scq->cqn);
>> +		req.rq_cqn_mtt_cfg =
>> FIELD_PREP(ERDMA_CMD_CREATE_QP_PAGE_SIZE_MASK, pgsz_range) |
>> +				     FIELD_PREP(ERDMA_CMD_CREATE_QP_CQN_MASK, qp-
>>> rcq->cqn);

<...>

>> +	if (cq->is_kernel_cq) {
> 
> use rdma_is_kernel_res(&cq->ibcq.res)
> 

Will fix.

> 
>> +		page_size = SZ_32M;
>> +		req.cfg0 |= FIELD_PREP(ERDMA_CMD_CREATE_CQ_PAGESIZE_MASK,
>> +				       ilog2(page_size) - PAGE_SHIFT);
>> +		req.qbuf_addr_l = lower_32_bits(cq->kern_cq.qbuf_dma_addr);
>> +		req.qbuf_addr_h = upper_32_bits(cq->kern_cq.qbuf_dma_addr);
>> +
>> +		req.cfg1 |= FIELD_PREP(ERDMA_CMD_CREATE_CQ_MTT_CNT_MASK, 1) |
>> +			    FIELD_PREP(ERDMA_CMD_CREATE_CQ_MTT_TYPE_MASK,
>> ERDMA_MR_INLINE_MTT);
>> +
>> +		req.first_page_offset = 0;
>> +		req.cq_db_info_addr = cq->kern_cq.qbuf_dma_addr + (cq->depth
>> << CQE_SHIFT);
>> +	} else {
>> +		req.cfg0 |= FIELD_PREP(ERDMA_CMD_CREATE_CQ_PAGESIZE_MASK,
>> +				       ilog2(cq->user_cq.qbuf_mtt.page_size) -
>> PAGE_SHIFT);

<...>

>> +	attr->state = dev->state;
>> +	attr->max_mtu = ib_mtu_int_to_enum(dev->netdev->mtu);
>> +	attr->active_mtu = ib_mtu_int_to_enum(dev->netdev->mtu);
>> +	attr->gid_tbl_len = 1;
>> +	attr->port_cap_flags = IB_PORT_CM_SUP;
>> +	attr->port_cap_flags |= IB_PORT_DEVICE_MGMT_SUP;
> 
> you may better write above two lines in one line
> 

Will fix.

>> +	attr->max_msg_sz = -1;
>> +	attr->phys_state = dev->state == IB_PORT_ACTIVE ?
>> +		IB_PORT_PHYS_STATE_LINK_UP : IB_PORT_PHYS_STATE_DISABLED;
>> +
>> +	return ret;
>> +}
>> +

<...>

>> +	if (max_num_sg > ERDMA_MR_MAX_MTT_CNT) {
> 
> Does erdma really accept 524288 list entries, or is
> that a typo?
> 

Yes, for 4K page size, 512K enties can achieve 2GByte Mmemory Region,
and this is our capacity. This is also been tested.

>> +		ibdev_err(&dev->ibdev, "max_num_sg too large:%u", max_num_sg);
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +

<...>

>> +	atomic_inc(&dev->num_mr);
> 
> This dev->num_mr thing gets initialized, incremented and decremented here
> and there, but is never checked. So it has no meaning. It seems max MR is
> enforced via max possible STags.

Yes, you get it, QP, CQ, and PD are in the same way also.

> Same is true for devices num_qp, num_cq, num_pd counters. The intent probably
> was to enforce resource limits. How is that done today?
> In any case, they are never checked. So just remove that, and check if
> resource limits are enforced correctly otherwise.
>   

We will remove them.

>> +
>> +	return &mr->ibmr;
>> +
>> +err_out_mr:
>> +	erdma_free_idx(&dev->res_cb[ERDMA_RES_TYPE_STAG_IDX], mr->ibmr.lkey
>>>> 8);
>> +
>> +err_out_put_mtt:
>> +	put_mtt_entries(dev, &mr->mem);
>> +
>> +err_out_free:
>> +	kfree(mr);
>> +

<...>

>> +	if (depth > dev->attrs.max_cqe) {
>> +		dev_warn(dev->dmadev, "WARN: exceed cqe(%d) >
>> capbility(%d)\n", depth,
>> +			 dev->attrs.max_cqe);
> 
> That is not worth a warning. The application just exceeded some
> Resource limit. Remove it.
> 

Yes, will remove it. At first, it often happened that create cq failed
due to max cq depth exceed, so we add this warning. Now it should be
removed.


>> +		return -EINVAL;
>> +	}
>> +

<...>

>> +		cq->is_kernel_cq = 1;
> 
> 
> Can be removed.
> 

Sure, will fix.

Besides, thanks for your carefully review.
Cheng Xu
