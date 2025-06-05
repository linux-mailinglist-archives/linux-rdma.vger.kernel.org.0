Return-Path: <linux-rdma+bounces-11030-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B01FBACEE51
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Jun 2025 13:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B37717658A
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Jun 2025 11:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D1E213236;
	Thu,  5 Jun 2025 11:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GLJeXhjo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865ED1C4A20
	for <linux-rdma@vger.kernel.org>; Thu,  5 Jun 2025 11:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749121851; cv=none; b=W8cySqqFcVGZ+GNj85IvkNgaG0jvwDQmTJwpDASGQaNarqJV/CHqNVpY3htNeP7VqJlQDi94ryJ2yYsp2P764LzOfyc7rWybMEG2J4Eh+oJIP7P9cspus2nRuj3Arn2ietrE3luPNcnVObg/jtIeceuMrGc/Xky7G+KLVmFe/bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749121851; c=relaxed/simple;
	bh=Apc4iGIRKCWdZ8ESz37ZbtrFVtbs1l+NvMUCUeWtWAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nponIbT3PX0ammoRQP1rrGeuv8M0bH9xaq8sEkFBqG3vicZWxjU8LLNWEq9ZdxEqrM3aWgglGTec3V9ld0gE2TRRKxv69nul0rPWvRGCWlAXUP9PjluIz5+VyAKF6LlJ7NaWCBPjOG2htQTmehw/EhV9u4t3w1seMRsfATzZPq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GLJeXhjo; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f0397a5c-aacf-4261-8eb7-f32dab43d3a0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749121846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WdTulqa4KSEeJM5gou5BwZ1r/HeRCeEPaYSZh4LiBfM=;
	b=GLJeXhjoWFLLjp6RCkXrvcg51iPr3Lu4+9mxeJ/0a1MT0X1L7x8noQISeDqfXAQtXgP9yh
	coIxG86hLe4OhjktfHPTDHrz75FWADY7H/7wr3RftWpDMAJCvnNSdevY/3Lr5/FpVcyYKK
	SkDCg60wMgY/0atyFQ2t97fJEvnMKr0=
Date: Thu, 5 Jun 2025 13:10:27 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next] RDMA/hns: Remove MW support
To: Junxian Huang <huangjunxian6@hisilicon.com>, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com, tangchengchang@huawei.com
References: <20250605024917.1132393-1-huangjunxian6@hisilicon.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250605024917.1132393-1-huangjunxian6@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 05.06.25 04:49, Junxian Huang wrote:
> MW is no longer supported in hns. Delete relevant codes.

Is MW referring to "Memory Window"? A sub-concept of memory range in RDMA?
If so, why is MW no longer supported in HNS?
I'm just curious about this—I don’t mean to question the commit.

Zhu Yanjun

> 
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
> 
> The corresponding rdma-core PR is:
> https://github.com/linux-rdma/rdma-core/pull/1613
> 
> ---
>   drivers/infiniband/hw/hns/hns_roce_device.h |  19 ----
>   drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  41 +------
>   drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   8 --
>   drivers/infiniband/hw/hns/hns_roce_main.c   |  10 --
>   drivers/infiniband/hw/hns/hns_roce_mr.c     | 114 --------------------
>   5 files changed, 1 insertion(+), 191 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> index 1dcc9cbb4678..40dcf77e2d92 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> @@ -316,16 +316,6 @@ struct hns_roce_mtr {
>   	struct hns_roce_hem_cfg  hem_cfg; /* config for hardware addressing */
>   };
> 
> -struct hns_roce_mw {
> -	struct ib_mw		ibmw;
> -	u32			pdn;
> -	u32			rkey;
> -	int			enabled; /* MW's active status */
> -	u32			pbl_hop_num;
> -	u32			pbl_ba_pg_sz;
> -	u32			pbl_buf_pg_sz;
> -};
> -
>   struct hns_roce_mr {
>   	struct ib_mr		ibmr;
>   	u64			iova; /* MR's virtual original addr */
> @@ -933,7 +923,6 @@ struct hns_roce_hw {
>   				struct hns_roce_mr *mr, int flags,
>   				void *mb_buf);
>   	int (*frmr_write_mtpt)(void *mb_buf, struct hns_roce_mr *mr);
> -	int (*mw_write_mtpt)(void *mb_buf, struct hns_roce_mw *mw);
>   	void (*write_cqc)(struct hns_roce_dev *hr_dev,
>   			  struct hns_roce_cq *hr_cq, void *mb_buf, u64 *mtts,
>   			  dma_addr_t dma_handle);
> @@ -1078,11 +1067,6 @@ static inline struct hns_roce_mr *to_hr_mr(struct ib_mr *ibmr)
>   	return container_of(ibmr, struct hns_roce_mr, ibmr);
>   }
> 
> -static inline struct hns_roce_mw *to_hr_mw(struct ib_mw *ibmw)
> -{
> -	return container_of(ibmw, struct hns_roce_mw, ibmw);
> -}
> -
>   static inline struct hns_roce_qp *to_hr_qp(struct ib_qp *ibqp)
>   {
>   	return container_of(ibqp, struct hns_roce_qp, ibqp);
> @@ -1246,9 +1230,6 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
>   int hns_roce_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
>   unsigned long key_to_hw_index(u32 key);
> 
> -int hns_roce_alloc_mw(struct ib_mw *mw, struct ib_udata *udata);
> -int hns_roce_dealloc_mw(struct ib_mw *ibmw);
> -
>   void hns_roce_buf_free(struct hns_roce_dev *hr_dev, struct hns_roce_buf *buf);
>   struct hns_roce_buf *hns_roce_buf_alloc(struct hns_roce_dev *hr_dev, u32 size,
>   					u32 page_shift, u32 flags);
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index fa8747656f25..761c184727a2 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -144,7 +144,7 @@ static void set_frmr_seg(struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
>   	u64 pbl_ba;
> 
>   	/* use ib_access_flags */
> -	hr_reg_write_bool(fseg, FRMR_BIND_EN, wr->access & IB_ACCESS_MW_BIND);
> +	hr_reg_write_bool(fseg, FRMR_BIND_EN, 0);
>   	hr_reg_write_bool(fseg, FRMR_ATOMIC,
>   			  wr->access & IB_ACCESS_REMOTE_ATOMIC);
>   	hr_reg_write_bool(fseg, FRMR_RR, wr->access & IB_ACCESS_REMOTE_READ);
> @@ -3313,8 +3313,6 @@ static int hns_roce_v2_write_mtpt(struct hns_roce_dev *hr_dev,
>   	hr_reg_write(mpt_entry, MPT_ST, V2_MPT_ST_VALID);
>   	hr_reg_write(mpt_entry, MPT_PD, mr->pd);
> 
> -	hr_reg_write_bool(mpt_entry, MPT_BIND_EN,
> -			  mr->access & IB_ACCESS_MW_BIND);
>   	hr_reg_write_bool(mpt_entry, MPT_ATOMIC_EN,
>   			  mr->access & IB_ACCESS_REMOTE_ATOMIC);
>   	hr_reg_write_bool(mpt_entry, MPT_RR_EN,
> @@ -3358,8 +3356,6 @@ static int hns_roce_v2_rereg_write_mtpt(struct hns_roce_dev *hr_dev,
>   	hr_reg_write(mpt_entry, MPT_PD, mr->pd);
> 
>   	if (flags & IB_MR_REREG_ACCESS) {
> -		hr_reg_write(mpt_entry, MPT_BIND_EN,
> -			     (mr_access_flags & IB_ACCESS_MW_BIND ? 1 : 0));
>   		hr_reg_write(mpt_entry, MPT_ATOMIC_EN,
>   			     mr_access_flags & IB_ACCESS_REMOTE_ATOMIC ? 1 : 0);
>   		hr_reg_write(mpt_entry, MPT_RR_EN,
> @@ -3397,7 +3393,6 @@ static int hns_roce_v2_frmr_write_mtpt(void *mb_buf, struct hns_roce_mr *mr)
>   	hr_reg_enable(mpt_entry, MPT_R_INV_EN);
> 
>   	hr_reg_enable(mpt_entry, MPT_FRE);
> -	hr_reg_clear(mpt_entry, MPT_MR_MW);
>   	hr_reg_enable(mpt_entry, MPT_BPD);
>   	hr_reg_clear(mpt_entry, MPT_PA);
> 
> @@ -3417,38 +3412,6 @@ static int hns_roce_v2_frmr_write_mtpt(void *mb_buf, struct hns_roce_mr *mr)
>   	return 0;
>   }
> 
> -static int hns_roce_v2_mw_write_mtpt(void *mb_buf, struct hns_roce_mw *mw)
> -{
> -	struct hns_roce_v2_mpt_entry *mpt_entry;
> -
> -	mpt_entry = mb_buf;
> -	memset(mpt_entry, 0, sizeof(*mpt_entry));
> -
> -	hr_reg_write(mpt_entry, MPT_ST, V2_MPT_ST_FREE);
> -	hr_reg_write(mpt_entry, MPT_PD, mw->pdn);
> -
> -	hr_reg_enable(mpt_entry, MPT_R_INV_EN);
> -	hr_reg_enable(mpt_entry, MPT_LW_EN);
> -
> -	hr_reg_enable(mpt_entry, MPT_MR_MW);
> -	hr_reg_enable(mpt_entry, MPT_BPD);
> -	hr_reg_clear(mpt_entry, MPT_PA);
> -	hr_reg_write(mpt_entry, MPT_BQP,
> -		     mw->ibmw.type == IB_MW_TYPE_1 ? 0 : 1);
> -
> -	mpt_entry->lkey = cpu_to_le32(mw->rkey);
> -
> -	hr_reg_write(mpt_entry, MPT_PBL_HOP_NUM,
> -		     mw->pbl_hop_num == HNS_ROCE_HOP_NUM_0 ? 0 :
> -							     mw->pbl_hop_num);
> -	hr_reg_write(mpt_entry, MPT_PBL_BA_PG_SZ,
> -		     mw->pbl_ba_pg_sz + PG_SHIFT_OFFSET);
> -	hr_reg_write(mpt_entry, MPT_PBL_BUF_PG_SZ,
> -		     mw->pbl_buf_pg_sz + PG_SHIFT_OFFSET);
> -
> -	return 0;
> -}
> -
>   static int free_mr_post_send_lp_wqe(struct hns_roce_qp *hr_qp)
>   {
>   	struct hns_roce_dev *hr_dev = to_hr_dev(hr_qp->ibqp.device);
> @@ -3849,7 +3812,6 @@ static const u32 wc_send_op_map[] = {
>   	HR_WC_OP_MAP(ATOM_MSK_CMP_AND_SWAP,	MASKED_COMP_SWAP),
>   	HR_WC_OP_MAP(ATOM_MSK_FETCH_AND_ADD,	MASKED_FETCH_ADD),
>   	HR_WC_OP_MAP(FAST_REG_PMR,		REG_MR),
> -	HR_WC_OP_MAP(BIND_MW,			REG_MR),
>   };
> 
>   static int to_ib_wc_send_op(u32 hr_opcode)
> @@ -6948,7 +6910,6 @@ static const struct hns_roce_hw hns_roce_hw_v2 = {
>   	.write_mtpt = hns_roce_v2_write_mtpt,
>   	.rereg_write_mtpt = hns_roce_v2_rereg_write_mtpt,
>   	.frmr_write_mtpt = hns_roce_v2_frmr_write_mtpt,
> -	.mw_write_mtpt = hns_roce_v2_mw_write_mtpt,
>   	.write_cqc = hns_roce_v2_write_cqc,
>   	.set_hem = hns_roce_v2_set_hem,
>   	.clear_hem = hns_roce_v2_clear_hem,
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> index bc7466830eaf..be8ef8ddd422 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> @@ -814,24 +814,16 @@ struct hns_roce_v2_mpt_entry {
> 
>   #define V2_MPT_BYTE_8_LW_EN_S 7
> 
> -#define V2_MPT_BYTE_8_MW_CNT_S 8
> -#define V2_MPT_BYTE_8_MW_CNT_M GENMASK(31, 8)
> -
>   #define V2_MPT_BYTE_12_FRE_S 0
> 
>   #define V2_MPT_BYTE_12_PA_S 1
> 
> -#define V2_MPT_BYTE_12_MR_MW_S 4
> -
>   #define V2_MPT_BYTE_12_BPD_S 5
> 
>   #define V2_MPT_BYTE_12_BQP_S 6
> 
>   #define V2_MPT_BYTE_12_INNER_PA_VLD_S 7
> 
> -#define V2_MPT_BYTE_12_MW_BIND_QPN_S 8
> -#define V2_MPT_BYTE_12_MW_BIND_QPN_M GENMASK(31, 8)
> -
>   #define V2_MPT_BYTE_48_PBL_BA_H_S 0
>   #define V2_MPT_BYTE_48_PBL_BA_H_M GENMASK(28, 0)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
> index e7a497cc125c..55962653f214 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_main.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_main.c
> @@ -672,13 +672,6 @@ static const struct ib_device_ops hns_roce_dev_mr_ops = {
>   	.rereg_user_mr = hns_roce_rereg_user_mr,
>   };
> 
> -static const struct ib_device_ops hns_roce_dev_mw_ops = {
> -	.alloc_mw = hns_roce_alloc_mw,
> -	.dealloc_mw = hns_roce_dealloc_mw,
> -
> -	INIT_RDMA_OBJ_SIZE(ib_mw, hns_roce_mw, ibmw),
> -};
> -
>   static const struct ib_device_ops hns_roce_dev_frmr_ops = {
>   	.alloc_mr = hns_roce_alloc_mr,
>   	.map_mr_sg = hns_roce_map_mr_sg,
> @@ -732,9 +725,6 @@ static int hns_roce_register_device(struct hns_roce_dev *hr_dev)
>   	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_REREG_MR)
>   		ib_set_device_ops(ib_dev, &hns_roce_dev_mr_ops);
> 
> -	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_MW)
> -		ib_set_device_ops(ib_dev, &hns_roce_dev_mw_ops);
> -
>   	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_FRMR)
>   		ib_set_device_ops(ib_dev, &hns_roce_dev_frmr_ops);
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
> index 93a48b41955b..ebef93559225 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_mr.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
> @@ -483,120 +483,6 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
>   	return sg_num;
>   }
> 
> -static void hns_roce_mw_free(struct hns_roce_dev *hr_dev,
> -			     struct hns_roce_mw *mw)
> -{
> -	struct device *dev = hr_dev->dev;
> -	int ret;
> -
> -	if (mw->enabled) {
> -		ret = hns_roce_destroy_hw_ctx(hr_dev, HNS_ROCE_CMD_DESTROY_MPT,
> -					      key_to_hw_index(mw->rkey) &
> -					      (hr_dev->caps.num_mtpts - 1));
> -		if (ret)
> -			dev_warn(dev, "MW DESTROY_MPT failed (%d)\n", ret);
> -
> -		hns_roce_table_put(hr_dev, &hr_dev->mr_table.mtpt_table,
> -				   key_to_hw_index(mw->rkey));
> -	}
> -
> -	ida_free(&hr_dev->mr_table.mtpt_ida.ida,
> -		 (int)key_to_hw_index(mw->rkey));
> -}
> -
> -static int hns_roce_mw_enable(struct hns_roce_dev *hr_dev,
> -			      struct hns_roce_mw *mw)
> -{
> -	struct hns_roce_mr_table *mr_table = &hr_dev->mr_table;
> -	struct hns_roce_cmd_mailbox *mailbox;
> -	struct device *dev = hr_dev->dev;
> -	unsigned long mtpt_idx = key_to_hw_index(mw->rkey);
> -	int ret;
> -
> -	/* prepare HEM entry memory */
> -	ret = hns_roce_table_get(hr_dev, &mr_table->mtpt_table, mtpt_idx);
> -	if (ret)
> -		return ret;
> -
> -	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
> -	if (IS_ERR(mailbox)) {
> -		ret = PTR_ERR(mailbox);
> -		goto err_table;
> -	}
> -
> -	ret = hr_dev->hw->mw_write_mtpt(mailbox->buf, mw);
> -	if (ret) {
> -		dev_err(dev, "MW write mtpt fail!\n");
> -		goto err_page;
> -	}
> -
> -	ret = hns_roce_create_hw_ctx(hr_dev, mailbox, HNS_ROCE_CMD_CREATE_MPT,
> -				     mtpt_idx & (hr_dev->caps.num_mtpts - 1));
> -	if (ret) {
> -		dev_err(dev, "MW CREATE_MPT failed (%d)\n", ret);
> -		goto err_page;
> -	}
> -
> -	mw->enabled = 1;
> -
> -	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
> -
> -	return 0;
> -
> -err_page:
> -	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
> -
> -err_table:
> -	hns_roce_table_put(hr_dev, &mr_table->mtpt_table, mtpt_idx);
> -
> -	return ret;
> -}
> -
> -int hns_roce_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
> -{
> -	struct hns_roce_dev *hr_dev = to_hr_dev(ibmw->device);
> -	struct hns_roce_ida *mtpt_ida = &hr_dev->mr_table.mtpt_ida;
> -	struct ib_device *ibdev = &hr_dev->ib_dev;
> -	struct hns_roce_mw *mw = to_hr_mw(ibmw);
> -	int ret;
> -	int id;
> -
> -	/* Allocate a key for mw from mr_table */
> -	id = ida_alloc_range(&mtpt_ida->ida, mtpt_ida->min, mtpt_ida->max,
> -			     GFP_KERNEL);
> -	if (id < 0) {
> -		ibdev_err(ibdev, "failed to alloc id for MW key, id(%d)\n", id);
> -		return -ENOMEM;
> -	}
> -
> -	mw->rkey = hw_index_to_key(id);
> -
> -	ibmw->rkey = mw->rkey;
> -	mw->pdn = to_hr_pd(ibmw->pd)->pdn;
> -	mw->pbl_hop_num = hr_dev->caps.pbl_hop_num;
> -	mw->pbl_ba_pg_sz = hr_dev->caps.pbl_ba_pg_sz;
> -	mw->pbl_buf_pg_sz = hr_dev->caps.pbl_buf_pg_sz;
> -
> -	ret = hns_roce_mw_enable(hr_dev, mw);
> -	if (ret)
> -		goto err_mw;
> -
> -	return 0;
> -
> -err_mw:
> -	hns_roce_mw_free(hr_dev, mw);
> -	return ret;
> -}
> -
> -int hns_roce_dealloc_mw(struct ib_mw *ibmw)
> -{
> -	struct hns_roce_dev *hr_dev = to_hr_dev(ibmw->device);
> -	struct hns_roce_mw *mw = to_hr_mw(ibmw);
> -
> -	hns_roce_mw_free(hr_dev, mw);
> -	return 0;
> -}
> -
>   static int mtr_map_region(struct hns_roce_dev *hr_dev, struct hns_roce_mtr *mtr,
>   			  struct hns_roce_buf_region *region, dma_addr_t *pages,
>   			  int max_count)
> --
> 2.33.0
> 


