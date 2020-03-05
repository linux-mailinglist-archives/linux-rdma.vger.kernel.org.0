Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78FAA179FDE
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2020 07:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgCEGSn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Mar 2020 01:18:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:39050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgCEGSn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Mar 2020 01:18:43 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01E9F2073D;
        Thu,  5 Mar 2020 06:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583389122;
        bh=boikPsEMDMgdAKPUtpzKvOcz/0xjBMDBSKofxumABKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NAiK6u8IMZTzo0MVVZPRzLliZwr9ZgcdiUvMuSdEBucGaiErdkpXK/yBByIZVx/wH
         B253LvsL/thWqxEd2yNp70062HsHrzNbPDEt1b7TNJfC6zAeXeuGWQ/07juaVuAVF4
         h5zJ3y9YLZcBnSn3S40Po4DZGhlHbyaUf5gxsdgM=
Date:   Thu, 5 Mar 2020 08:18:39 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 3/5] RDMA/hns: Optimize the wr opcode conversion
 from ib to hns
Message-ID: <20200305061839.GQ121803@unreal>
References: <1583151093-30402-1-git-send-email-liweihang@huawei.com>
 <1583151093-30402-4-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583151093-30402-4-git-send-email-liweihang@huawei.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 02, 2020 at 08:11:31PM +0800, Weihang Li wrote:
> From: Xi Wang <wangxi11@huawei.com>
>
> Simplify the wr opcode conversion from ib to hns by using a map table
> instead of the switch-case statement.
>
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 70 ++++++++++++++++++------------
>  1 file changed, 43 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index c8c345f..ea61ccb 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -56,6 +56,47 @@ static void set_data_seg_v2(struct hns_roce_v2_wqe_data_seg *dseg,
>  	dseg->len  = cpu_to_le32(sg->length);
>  }
>
> +/*
> + * mapped-value = 1 + real-value
> + * The hns wr opcode real value is start from 0, In order to distinguish between
> + * initialized and uninitialized map values, we plus 1 to the actual value when
> + * defining the mapping, so that the validity can be identified by checking the
> + * mapped value is greater than 0.
> + */
> +#define HR_OPC_MAP(ib_key, hr_key) \
> +		[IB_WR_ ## ib_key] = 1 + HNS_ROCE_V2_WQE_OP_ ## hr_key
> +
> +static const u32 hns_roce_op_code[] = {
> +	HR_OPC_MAP(RDMA_WRITE,			RDMA_WRITE),
> +	HR_OPC_MAP(RDMA_WRITE_WITH_IMM,		RDMA_WRITE_WITH_IMM),
> +	HR_OPC_MAP(SEND,			SEND),
> +	HR_OPC_MAP(SEND_WITH_IMM,		SEND_WITH_IMM),
> +	HR_OPC_MAP(RDMA_READ,			RDMA_READ),
> +	HR_OPC_MAP(ATOMIC_CMP_AND_SWP,		ATOM_CMP_AND_SWAP),
> +	HR_OPC_MAP(ATOMIC_FETCH_AND_ADD,	ATOM_FETCH_AND_ADD),
> +	HR_OPC_MAP(SEND_WITH_INV,		SEND_WITH_INV),
> +	HR_OPC_MAP(LOCAL_INV,			LOCAL_INV),
> +	HR_OPC_MAP(MASKED_ATOMIC_CMP_AND_SWP,	ATOM_MSK_CMP_AND_SWAP),
> +	HR_OPC_MAP(MASKED_ATOMIC_FETCH_AND_ADD,	ATOM_MSK_FETCH_AND_ADD),
> +	HR_OPC_MAP(REG_MR,			FAST_REG_PMR),
> +	[IB_WR_RESERVED1] = 0,

hns_roce_op_code[] is declared as static, everything is initialized to
0, there is no need to set 0 again.

> +};
> +
> +static inline u32 to_hr_opcode(u32 ib_opcode)

No inline functions in *.c, please.

> +{
> +	u32 hr_opcode = 0;
> +
> +	if (ib_opcode < IB_WR_RESERVED1)

if (ib_opcode > ARRAY_SIZE(hns_roce_op_code) - 1)
	return HNS_ROCE_V2_WQE_OP_MASK;

return hns_roce_op_code[ib_opcode];


> +		hr_opcode = hns_roce_op_code[ib_opcode];
> +
> +	/* exist a valid mapping definition for ib code */
> +	if (hr_opcode > 0)
> +		return hr_opcode - 1;
> +
> +	/* default hns roce wr opcode */
> +	return HNS_ROCE_V2_WQE_OP_MASK;
> +}
> +
>  static void set_frmr_seg(struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
>  			 void *wqe, const struct ib_reg_wr *wr)
>  {
> @@ -303,7 +344,6 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
>  	void *wqe = NULL;
>  	bool loopback;
>  	u32 tmp_len;
> -	u32 hr_op;
>  	u8 *smac;
>  	int nreq;
>  	int ret;
> @@ -517,76 +557,52 @@ static int hns_roce_v2_post_send(struct ib_qp *ibqp,
>  			wqe += sizeof(struct hns_roce_v2_rc_send_wqe);
>  			switch (wr->opcode) {
>  			case IB_WR_RDMA_READ:
> -				hr_op = HNS_ROCE_V2_WQE_OP_RDMA_READ;
>  				rc_sq_wqe->rkey =
>  					cpu_to_le32(rdma_wr(wr)->rkey);
>  				rc_sq_wqe->va =
>  					cpu_to_le64(rdma_wr(wr)->remote_addr);
>  				break;
>  			case IB_WR_RDMA_WRITE:
> -				hr_op = HNS_ROCE_V2_WQE_OP_RDMA_WRITE;
>  				rc_sq_wqe->rkey =
>  					cpu_to_le32(rdma_wr(wr)->rkey);
>  				rc_sq_wqe->va =
>  					cpu_to_le64(rdma_wr(wr)->remote_addr);
>  				break;
>  			case IB_WR_RDMA_WRITE_WITH_IMM:
> -				hr_op = HNS_ROCE_V2_WQE_OP_RDMA_WRITE_WITH_IMM;
>  				rc_sq_wqe->rkey =
>  					cpu_to_le32(rdma_wr(wr)->rkey);
>  				rc_sq_wqe->va =
>  					cpu_to_le64(rdma_wr(wr)->remote_addr);
>  				break;
> -			case IB_WR_SEND:
> -				hr_op = HNS_ROCE_V2_WQE_OP_SEND;
> -				break;
> -			case IB_WR_SEND_WITH_INV:
> -				hr_op = HNS_ROCE_V2_WQE_OP_SEND_WITH_INV;
> -				break;
> -			case IB_WR_SEND_WITH_IMM:
> -				hr_op = HNS_ROCE_V2_WQE_OP_SEND_WITH_IMM;
> -				break;
>  			case IB_WR_LOCAL_INV:
> -				hr_op = HNS_ROCE_V2_WQE_OP_LOCAL_INV;
>  				roce_set_bit(rc_sq_wqe->byte_4,
>  					       V2_RC_SEND_WQE_BYTE_4_SO_S, 1);
>  				rc_sq_wqe->inv_key =
>  					    cpu_to_le32(wr->ex.invalidate_rkey);
>  				break;
>  			case IB_WR_REG_MR:
> -				hr_op = HNS_ROCE_V2_WQE_OP_FAST_REG_PMR;
>  				set_frmr_seg(rc_sq_wqe, wqe, reg_wr(wr));
>  				break;
>  			case IB_WR_ATOMIC_CMP_AND_SWP:
> -				hr_op = HNS_ROCE_V2_WQE_OP_ATOM_CMP_AND_SWAP;
>  				rc_sq_wqe->rkey =
>  					cpu_to_le32(atomic_wr(wr)->rkey);
>  				rc_sq_wqe->va =
>  					cpu_to_le64(atomic_wr(wr)->remote_addr);
>  				break;
>  			case IB_WR_ATOMIC_FETCH_AND_ADD:
> -				hr_op = HNS_ROCE_V2_WQE_OP_ATOM_FETCH_AND_ADD;
>  				rc_sq_wqe->rkey =
>  					cpu_to_le32(atomic_wr(wr)->rkey);
>  				rc_sq_wqe->va =
>  					cpu_to_le64(atomic_wr(wr)->remote_addr);
>  				break;
> -			case IB_WR_MASKED_ATOMIC_CMP_AND_SWP:
> -				hr_op =
> -				       HNS_ROCE_V2_WQE_OP_ATOM_MSK_CMP_AND_SWAP;
> -				break;
> -			case IB_WR_MASKED_ATOMIC_FETCH_AND_ADD:
> -				hr_op =
> -				      HNS_ROCE_V2_WQE_OP_ATOM_MSK_FETCH_AND_ADD;
> -				break;
>  			default:
> -				hr_op = HNS_ROCE_V2_WQE_OP_MASK;
>  				break;
>  			}
>
>  			roce_set_field(rc_sq_wqe->byte_4,
>  				       V2_RC_SEND_WQE_BYTE_4_OPCODE_M,
> -				       V2_RC_SEND_WQE_BYTE_4_OPCODE_S, hr_op);
> +				       V2_RC_SEND_WQE_BYTE_4_OPCODE_S,
> +				       to_hr_opcode(wr->opcode));
>
>  			if (wr->opcode == IB_WR_ATOMIC_CMP_AND_SWP ||
>  			    wr->opcode == IB_WR_ATOMIC_FETCH_AND_ADD)
> --
> 2.8.1
>
