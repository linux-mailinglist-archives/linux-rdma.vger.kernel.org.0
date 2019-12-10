Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6D56118955
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2019 14:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfLJNKw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Dec 2019 08:10:52 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7208 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727334AbfLJNKw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Dec 2019 08:10:52 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C2D7D4C4E46191AE2554;
        Tue, 10 Dec 2019 21:10:33 +0800 (CST)
Received: from [127.0.0.1] (10.40.168.149) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Tue, 10 Dec 2019
 21:10:25 +0800
Subject: Re: [PATCH for-next] RDMA/hns: Add support for extended atomic
From:   Weihang Li <liweihang@hisilicon.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <1573781966-45800-1-git-send-email-liweihang@hisilicon.com>
Message-ID: <d48e1f2c-4a2e-42ee-08d6-69eab4aacde0@hisilicon.com>
Date:   Tue, 10 Dec 2019 21:10:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1573781966-45800-1-git-send-email-liweihang@hisilicon.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.168.149]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason and Doug,

Do you have some comments on this patch?

Thanks,
Weihang

On 2019/11/15 9:39, Weihang Li wrote:
> From: Jiaran Zhang <zhangjiaran@huawei.com>
> 
> Support extended atomic operations including cmp & swap and fetch & add
> of 8 bytes, 16 bytes, 32 bytes, 64 bytes on hip08.
> 
> Signed-off-by: Jiaran Zhang <zhangjiaran@huawei.com>
> Signed-off-by: Weihang Li <liweihang@hisilicon.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 100 ++++++++++++++++++++++++-----
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h |   8 +++
>  2 files changed, 93 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index 907c951..74ccb08 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -97,18 +97,68 @@ static void set_frmr_seg(struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
>  		     V2_RC_FRMR_WQE_BYTE_40_BLK_MODE_S, 0);
>  }
>  
> -static void set_atomic_seg(struct hns_roce_wqe_atomic_seg *aseg,
> -			   const struct ib_atomic_wr *wr)
> +static void set_extend_atomic_seg(struct hns_roce_qp *qp,
> +				  u32 ex_sge_num, unsigned int *sge_idx,
> +				  u64 *data_addr)
>  {
> -	if (wr->wr.opcode == IB_WR_ATOMIC_CMP_AND_SWP) {
> -		aseg->fetchadd_swap_data = cpu_to_le64(wr->swap);
> -		aseg->cmp_data  = cpu_to_le64(wr->compare_add);
> -	} else {
> -		aseg->fetchadd_swap_data = cpu_to_le64(wr->compare_add);
> -		aseg->cmp_data  = 0;
> +	__le64 *ext_seg;
> +	int i;
> +
> +	for (i = 0; i < ex_sge_num; i += EXT_SGE_BYTE_8_NUM, (*sge_idx)++) {
> +		ext_seg = get_send_extend_sge(qp, ((*sge_idx) &
> +					      (qp->sge.sge_cnt - 1)));
> +		/* In the extended atomic scenario, the data_add parameter
> +		 * passes the address where the extended atomic data is stored.
> +		 */
> +		*ext_seg = data_addr ? cpu_to_le64(*(data_addr + i)) : 0;
> +		*(ext_seg + 1) = data_addr ?
> +				 cpu_to_le64(*(data_addr + (i + 1))) : 0;
>  	}
>  }
>  
> +static int set_atomic_seg(struct hns_roce_qp *qp,
> +			  const struct ib_send_wr *wr, unsigned int msg_len,
> +			  void *dseg, unsigned int *sge_idx)
> +{
> +	struct hns_roce_wqe_atomic_seg *aseg;
> +	u32 ex_sge_num;
> +
> +	dseg += sizeof(struct hns_roce_v2_wqe_data_seg);
> +	aseg = dseg;
> +
> +	if (msg_len == STANDARD_ATOMIC_BYTE_8) {
> +		if (wr->opcode == IB_WR_ATOMIC_CMP_AND_SWP) {
> +			aseg->fetchadd_swap_data =
> +				cpu_to_le64(atomic_wr(wr)->swap);
> +			aseg->cmp_data =
> +				cpu_to_le64(atomic_wr(wr)->compare_add);
> +		} else {
> +			aseg->fetchadd_swap_data =
> +				cpu_to_le64(atomic_wr(wr)->compare_add);
> +			aseg->cmp_data = 0;
> +		}
> +	} else if (msg_len == EXTEND_ATOMIC_BYTE_16 ||
> +		   msg_len == EXTEND_ATOMIC_BYTE_32 ||
> +		   msg_len == EXTEND_ATOMIC_BYTE_64) {
> +		ex_sge_num = msg_len >> 3;
> +		aseg->fetchadd_swap_data = 0;
> +		aseg->cmp_data = 0;
> +		if (wr->opcode == IB_WR_ATOMIC_CMP_AND_SWP) {
> +			set_extend_atomic_seg(qp, ex_sge_num, sge_idx,
> +					(u64 *)atomic_wr(wr)->swap);
> +			set_extend_atomic_seg(qp, ex_sge_num, sge_idx,
> +					(u64 *)atomic_wr(wr)->compare_add);
> +		} else {
> +			set_extend_atomic_seg(qp, ex_sge_num, sge_idx,
> +					(u64 *)atomic_wr(wr)->compare_add);
> +			set_extend_atomic_seg(qp, ex_sge_num, sge_idx, 0);
> +		}
> +	} else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  static void set_extend_sge(struct hns_roce_qp *qp, const struct ib_send_wr *wr,
>  			   unsigned int *sge_ind)
>  {
> @@ -545,8 +595,12 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
>  
>  				dseg = wqe;
>  				set_data_seg_v2(dseg, wr->sg_list);
> -				wqe += sizeof(struct hns_roce_v2_wqe_data_seg);
> -				set_atomic_seg(wqe, atomic_wr(wr));
> +				ret = set_atomic_seg(qp, wr, rc_sq_wqe->msg_len,
> +						     dseg, &sge_idx);
> +				if (ret) {
> +					*bad_wr = wr;
> +					goto out;
> +				}
>  				roce_set_field(rc_sq_wqe->byte_16,
>  					       V2_RC_SEND_WQE_BYTE_16_SGE_NUM_M,
>  					       V2_RC_SEND_WQE_BYTE_16_SGE_NUM_S,
> @@ -1668,7 +1722,7 @@ static int hns_roce_v2_profile(struct hns_roce_dev *hr_dev)
>  	caps->max_srq_desc_sz	= HNS_ROCE_V2_MAX_SRQ_DESC_SZ;
>  	caps->qpc_entry_sz	= HNS_ROCE_V2_QPC_ENTRY_SZ;
>  	caps->irrl_entry_sz	= HNS_ROCE_V2_IRRL_ENTRY_SZ;
> -	caps->trrl_entry_sz	= HNS_ROCE_V2_TRRL_ENTRY_SZ;
> +	caps->trrl_entry_sz	= HNS_ROCE_V2_EXT_ATOMIC_TRRL_ENTRY_SZ;
>  	caps->cqc_entry_sz	= HNS_ROCE_V2_CQC_ENTRY_SZ;
>  	caps->srqc_entry_sz	= HNS_ROCE_V2_SRQC_ENTRY_SZ;
>  	caps->mtpt_entry_sz	= HNS_ROCE_V2_MTPT_ENTRY_SZ;
> @@ -2860,19 +2914,19 @@ static int hns_roce_v2_poll_one(struct hns_roce_cq *hr_cq,
>  			break;
>  		case HNS_ROCE_SQ_OPCODE_ATOMIC_COMP_AND_SWAP:
>  			wc->opcode = IB_WC_COMP_SWAP;
> -			wc->byte_len  = 8;
> +			wc->byte_len  = le32_to_cpu(cqe->byte_cnt);
>  			break;
>  		case HNS_ROCE_SQ_OPCODE_ATOMIC_FETCH_AND_ADD:
>  			wc->opcode = IB_WC_FETCH_ADD;
> -			wc->byte_len  = 8;
> +			wc->byte_len  = le32_to_cpu(cqe->byte_cnt);
>  			break;
>  		case HNS_ROCE_SQ_OPCODE_ATOMIC_MASK_COMP_AND_SWAP:
>  			wc->opcode = IB_WC_MASKED_COMP_SWAP;
> -			wc->byte_len  = 8;
> +			wc->byte_len  = le32_to_cpu(cqe->byte_cnt);
>  			break;
>  		case HNS_ROCE_SQ_OPCODE_ATOMIC_MASK_FETCH_AND_ADD:
>  			wc->opcode = IB_WC_MASKED_FETCH_ADD;
> -			wc->byte_len  = 8;
> +			wc->byte_len  = le32_to_cpu(cqe->byte_cnt);
>  			break;
>  		case HNS_ROCE_SQ_OPCODE_FAST_REG_WR:
>  			wc->opcode = IB_WC_REG_MR;
> @@ -3211,6 +3265,9 @@ static void set_access_flags(struct hns_roce_qp *hr_qp,
>  	roce_set_bit(context->byte_76_srqn_op_en, V2_QPC_BYTE_76_ATE_S,
>  		     !!(access_flags & IB_ACCESS_REMOTE_ATOMIC));
>  	roce_set_bit(qpc_mask->byte_76_srqn_op_en, V2_QPC_BYTE_76_ATE_S, 0);
> +	roce_set_bit(context->byte_76_srqn_op_en, V2_QPC_BYTE_76_EXT_ATE_S,
> +		     !!(access_flags & IB_ACCESS_REMOTE_ATOMIC));
> +	roce_set_bit(qpc_mask->byte_76_srqn_op_en, V2_QPC_BYTE_76_EXT_ATE_S, 0);
>  }
>  
>  static void set_qpc_wqe_cnt(struct hns_roce_qp *hr_qp,
> @@ -3578,6 +3635,12 @@ static void modify_qp_init_to_init(struct ib_qp *ibqp,
>  			     IB_ACCESS_REMOTE_ATOMIC));
>  		roce_set_bit(qpc_mask->byte_76_srqn_op_en, V2_QPC_BYTE_76_ATE_S,
>  			     0);
> +		roce_set_bit(context->byte_76_srqn_op_en,
> +			     V2_QPC_BYTE_76_EXT_ATE_S,
> +			     !!(attr->qp_access_flags &
> +				IB_ACCESS_REMOTE_ATOMIC));
> +		roce_set_bit(qpc_mask->byte_76_srqn_op_en,
> +			     V2_QPC_BYTE_76_EXT_ATE_S, 0);
>  	} else {
>  		roce_set_bit(context->byte_76_srqn_op_en, V2_QPC_BYTE_76_RRE_S,
>  			     !!(hr_qp->access_flags & IB_ACCESS_REMOTE_READ));
> @@ -3593,6 +3656,13 @@ static void modify_qp_init_to_init(struct ib_qp *ibqp,
>  			     !!(hr_qp->access_flags & IB_ACCESS_REMOTE_ATOMIC));
>  		roce_set_bit(qpc_mask->byte_76_srqn_op_en, V2_QPC_BYTE_76_ATE_S,
>  			     0);
> +
> +		roce_set_bit(context->byte_76_srqn_op_en,
> +			     V2_QPC_BYTE_76_EXT_ATE_S,
> +			     !!(hr_qp->access_flags &
> +				IB_ACCESS_REMOTE_ATOMIC));
> +		roce_set_bit(qpc_mask->byte_76_srqn_op_en,
> +			     V2_QPC_BYTE_76_EXT_ATE_S, 0);
>  	}
>  
>  	roce_set_field(context->byte_16_buf_ba_pg_sz, V2_QPC_BYTE_16_PD_M,
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> index 76a14db..0a9d1e5 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> @@ -81,6 +81,7 @@
>  #define HNS_ROCE_V2_QPC_ENTRY_SZ		256
>  #define HNS_ROCE_V2_IRRL_ENTRY_SZ		64
>  #define HNS_ROCE_V2_TRRL_ENTRY_SZ		48
> +#define HNS_ROCE_V2_EXT_ATOMIC_TRRL_ENTRY_SZ	100
>  #define HNS_ROCE_V2_CQC_ENTRY_SZ		64
>  #define HNS_ROCE_V2_SRQC_ENTRY_SZ		64
>  #define HNS_ROCE_V2_MTPT_ENTRY_SZ		64
> @@ -158,6 +159,12 @@ enum {
>  
>  #define HNS_ROCE_V2_CQE_QPN_MASK		0x3ffff
>  
> +#define EXT_SGE_BYTE_8_NUM	2
> +#define STANDARD_ATOMIC_BYTE_8	0x8
> +#define EXTEND_ATOMIC_BYTE_16	0x10
> +#define EXTEND_ATOMIC_BYTE_32	0x20
> +#define EXTEND_ATOMIC_BYTE_64	0x40
> +
>  enum {
>  	HNS_ROCE_V2_WQE_OP_SEND				= 0x0,
>  	HNS_ROCE_V2_WQE_OP_SEND_WITH_INV		= 0x1,
> @@ -644,6 +651,7 @@ struct hns_roce_v2_qp_context {
>  
>  #define	V2_QPC_BYTE_76_RQIE_S 28
>  
> +#define	V2_QPC_BYTE_76_EXT_ATE_S 29
>  #define	V2_QPC_BYTE_76_RQ_VLAN_EN_S 30
>  #define	V2_QPC_BYTE_80_RX_CQN_S 0
>  #define V2_QPC_BYTE_80_RX_CQN_M GENMASK(23, 0)
> 

