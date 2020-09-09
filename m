Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F4126254B
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Sep 2020 04:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgIICjw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Sep 2020 22:39:52 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33238 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726605AbgIICjv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Sep 2020 22:39:51 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A8D46B1F914BA973C5F3;
        Wed,  9 Sep 2020 10:39:48 +0800 (CST)
Received: from [10.40.203.251] (10.40.203.251) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Wed, 9 Sep 2020 10:39:39 +0800
Subject: Re: [PATCH for-next 1/9] RDMA/hns: Refactor process about opcode in
 post_send()
To:     Weihang Li <liweihang@huawei.com>, <dledford@redhat.com>,
        <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <leon@kernel.org>
References: <1599485808-29940-1-git-send-email-liweihang@huawei.com>
 <1599485808-29940-2-git-send-email-liweihang@huawei.com>
From:   Lang Cheng <chenglang@huawei.com>
Message-ID: <b29f111d-7c46-c7e2-66fa-1085f20e3220@huawei.com>
Date:   Wed, 9 Sep 2020 10:39:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1599485808-29940-2-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.203.251]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2020/9/7 21:36, Weihang Li wrote:
> According to the IB specifications, the verbs should return an immediate
> error when the users set an unsupported opcode. Furthermore, refactor codes
> about opcode in process of post_send to make the difference between opcodes
> clearer.
> 
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>   drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 135 ++++++++++++++++++-----------
>   1 file changed, 83 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index 96e08b4..9a9639b 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -292,6 +292,33 @@ static unsigned int calc_wr_sge_num(const struct ib_send_wr *wr,
>   	return valid_num;
>   }
>   
> +static __le32 get_immtdata(const struct ib_send_wr *wr)
> +{
> +	switch (wr->opcode) {
> +	case IB_WR_SEND_WITH_IMM:
> +	case IB_WR_RDMA_WRITE_WITH_IMM:
> +		return cpu_to_le32(be32_to_cpu(wr->ex.imm_data));
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int set_ud_opcode(struct hns_roce_v2_ud_send_wqe *ud_sq_wqe,
> +			 const struct ib_send_wr *wr)
> +{
> +	u32 ib_op = wr->opcode;
> +
> +	if (ib_op != IB_WR_SEND && ib_op != IB_WR_SEND_WITH_IMM)
> +		return -EINVAL;
> +
> +	ud_sq_wqe->immtdata = get_immtdata(wr);
> +
> +	roce_set_field(ud_sq_wqe->byte_4, V2_UD_SEND_WQE_BYTE_4_OPCODE_M,
> +		       V2_UD_SEND_WQE_BYTE_4_OPCODE_S, to_hr_opcode(ib_op));
> +
> +	return 0;
> +}
> +
>   static inline int set_ud_wqe(struct hns_roce_qp *qp,
>   			     const struct ib_send_wr *wr,
>   			     void *wqe, unsigned int *sge_idx,
> @@ -300,15 +327,24 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
>   	struct hns_roce_dev *hr_dev = to_hr_dev(qp->ibqp.device);
>   	struct hns_roce_ah *ah = to_hr_ah(ud_wr(wr)->ah);
>   	struct hns_roce_v2_ud_send_wqe *ud_sq_wqe = wqe;
> +	struct ib_device *ibdev = &hr_dev->ib_dev;
>   	unsigned int curr_idx = *sge_idx;
>   	int valid_num_sge;
>   	u32 msg_len = 0;
>   	bool loopback;
>   	u8 *smac;
> +	int ret;
>   
>   	valid_num_sge = calc_wr_sge_num(wr, &msg_len);
>   	memset(ud_sq_wqe, 0, sizeof(*ud_sq_wqe));
>   
> +	ret = set_ud_opcode(ud_sq_wqe, wr);
> +	if (unlikely(ret)) {
> +		ibdev_err(ibdev, "unsupported opcode, opcode = %d.\n",
> +			  wr->opcode);
> +		return ret;
> +	}
> +
>   	roce_set_field(ud_sq_wqe->dmac, V2_UD_SEND_WQE_DMAC_0_M,
>   		       V2_UD_SEND_WQE_DMAC_0_S, ah->av.mac[0]);
>   	roce_set_field(ud_sq_wqe->dmac, V2_UD_SEND_WQE_DMAC_1_M,
> @@ -336,16 +372,6 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
>   
>   	ud_sq_wqe->msg_len = cpu_to_le32(msg_len);
>   
> -	switch (wr->opcode) {
> -	case IB_WR_SEND_WITH_IMM:
> -	case IB_WR_RDMA_WRITE_WITH_IMM:
> -		ud_sq_wqe->immtdata = cpu_to_le32(be32_to_cpu(wr->ex.imm_data));
> -		break;
> -	default:
> -		ud_sq_wqe->immtdata = 0;
> -		break;
> -	}
> -
>   	/* Set sig attr */
>   	roce_set_bit(ud_sq_wqe->byte_4, V2_UD_SEND_WQE_BYTE_4_CQE_S,
>   		     (wr->send_flags & IB_SEND_SIGNALED) ? 1 : 0);
> @@ -402,33 +428,68 @@ static inline int set_ud_wqe(struct hns_roce_qp *qp,
>   	return 0;
>   }
>   
> +static int set_rc_opcode(struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
> +			 const struct ib_send_wr *wr)
> +{
> +	u32 ib_op = wr->opcode;
> +
> +	rc_sq_wqe->immtdata = get_immtdata(wr);
> +
> +	switch (ib_op) {
> +	case IB_WR_RDMA_READ:
> +	case IB_WR_RDMA_WRITE:
> +	case IB_WR_RDMA_WRITE_WITH_IMM:
> +		rc_sq_wqe->rkey = cpu_to_le32(rdma_wr(wr)->rkey);
> +		rc_sq_wqe->va = cpu_to_le64(rdma_wr(wr)->remote_addr);
> +		break;
> +	case IB_WR_SEND:
> +	case IB_WR_SEND_WITH_IMM:
> +		break;
> +	case IB_WR_ATOMIC_CMP_AND_SWP:
> +	case IB_WR_ATOMIC_FETCH_AND_ADD:
> +		rc_sq_wqe->rkey = cpu_to_le32(atomic_wr(wr)->rkey);
> +		rc_sq_wqe->va = cpu_to_le64(atomic_wr(wr)->remote_addr);
> +		break;
> +	case IB_WR_REG_MR:
> +		set_frmr_seg(rc_sq_wqe, reg_wr(wr));
> +		break;
> +	case IB_WR_LOCAL_INV:
> +		roce_set_bit(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_SO_S, 1);
> +		fallthrough;
> +	case IB_WR_SEND_WITH_INV:
> +		rc_sq_wqe->inv_key = cpu_to_le32(wr->ex.invalidate_rkey);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	roce_set_field(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_OPCODE_M,
> +		       V2_RC_SEND_WQE_BYTE_4_OPCODE_S, to_hr_opcode(ib_op));
> +
> +	return 0;
> +}
>   static inline int set_rc_wqe(struct hns_roce_qp *qp,
>   			     const struct ib_send_wr *wr,
>   			     void *wqe, unsigned int *sge_idx,
>   			     unsigned int owner_bit)
>   {
> +	struct ib_device *ibdev = &to_hr_dev(qp->ibqp.device)->ib_dev;
>   	struct hns_roce_v2_rc_send_wqe *rc_sq_wqe = wqe;
>   	unsigned int curr_idx = *sge_idx;
>   	unsigned int valid_num_sge;
>   	u32 msg_len = 0;
> -	int ret = 0;
> +	int ret;
>   
>   	valid_num_sge = calc_wr_sge_num(wr, &msg_len);
>   	memset(rc_sq_wqe, 0, sizeof(*rc_sq_wqe));
>   
>   	rc_sq_wqe->msg_len = cpu_to_le32(msg_len);
>   
> -	switch (wr->opcode) {
> -	case IB_WR_SEND_WITH_IMM:
> -	case IB_WR_RDMA_WRITE_WITH_IMM:
> -		rc_sq_wqe->immtdata = cpu_to_le32(be32_to_cpu(wr->ex.imm_data));
> -		break;
> -	case IB_WR_SEND_WITH_INV:
> -		rc_sq_wqe->inv_key = cpu_to_le32(wr->ex.invalidate_rkey);
> -		break;
> -	default:
> -		rc_sq_wqe->immtdata = 0;
> -		break;
> +	ret = set_rc_opcode(rc_sq_wqe, wr);
> +	if (unlikely(ret)) {
> +		ibdev_err(ibdev, "unsupported opcode, opcode = %d.\n",
> +			  wr->opcode);
> +		return ret;
>   	}
>   
>   	roce_set_bit(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_FENCE_S,
> @@ -440,36 +501,6 @@ static inline int set_rc_wqe(struct hns_roce_qp *qp,
>   	roce_set_bit(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_CQE_S,
>   		     (wr->send_flags & IB_SEND_SIGNALED) ? 1 : 0);
>   
> -	roce_set_bit(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_OWNER_S,
> -		     owner_bit);

Seems we lost this field.

> -
> -	switch (wr->opcode) {
> -	case IB_WR_RDMA_READ:
> -	case IB_WR_RDMA_WRITE:
> -	case IB_WR_RDMA_WRITE_WITH_IMM:
> -		rc_sq_wqe->rkey = cpu_to_le32(rdma_wr(wr)->rkey);
> -		rc_sq_wqe->va = cpu_to_le64(rdma_wr(wr)->remote_addr);
> -		break;
> -	case IB_WR_LOCAL_INV:
> -		roce_set_bit(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_SO_S, 1);
> -		rc_sq_wqe->inv_key = cpu_to_le32(wr->ex.invalidate_rkey);
> -		break;
> -	case IB_WR_REG_MR:
> -		set_frmr_seg(rc_sq_wqe, reg_wr(wr));
> -		break;
> -	case IB_WR_ATOMIC_CMP_AND_SWP:
> -	case IB_WR_ATOMIC_FETCH_AND_ADD:
> -		rc_sq_wqe->rkey = cpu_to_le32(atomic_wr(wr)->rkey);
> -		rc_sq_wqe->va = cpu_to_le64(atomic_wr(wr)->remote_addr);
> -		break;
> -	default:
> -		break;
> -	}
> -
> -	roce_set_field(rc_sq_wqe->byte_4, V2_RC_SEND_WQE_BYTE_4_OPCODE_M,
> -		       V2_RC_SEND_WQE_BYTE_4_OPCODE_S,
> -		       to_hr_opcode(wr->opcode));
> -
>   	if (wr->opcode == IB_WR_ATOMIC_CMP_AND_SWP ||
>   	    wr->opcode == IB_WR_ATOMIC_FETCH_AND_ADD)
>   		set_atomic_seg(wr, rc_sq_wqe, valid_num_sge);
> 
