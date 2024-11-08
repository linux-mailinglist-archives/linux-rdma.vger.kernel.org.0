Return-Path: <linux-rdma+bounces-5849-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC2D9C16E2
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 08:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D444B2111D
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 07:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF401D0E2F;
	Fri,  8 Nov 2024 07:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GmUOB7Xx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30E6DDA8
	for <linux-rdma@vger.kernel.org>; Fri,  8 Nov 2024 07:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731049896; cv=none; b=YgRcEflWoXeGI4daI71xZRDCC4RtAIJdCEVugAF78SDFNOihbkX2MUQzGJ3ZHQM0A6x/xMttAH5Y4mU1Or6YQp/90DxAFlwS5RaQxXqr0RZ1nFWmoIS0Wc+sVEAGCtU1fLU1Pa9uwMhuWW2FJ3S4uMeaPGjQbSwI83xorfl3zn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731049896; c=relaxed/simple;
	bh=PsWSEV93FfrtZ+Ycj4k3WhRDfZOcnH9xwFF4+uHVI7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q9xSmE+g3+emGA08cDSV/4JlwG2nwH26br4N+ffss7g+JS5Som8Bya6pcQrMXh+VWVCy+pFR6ytzcLPhF/cl0wqGOPJcIOFJaDjAy/3gj2ot36npEcK5b0j/wPlys2nZBMlOXXwxVRFB2PDZCN8XJMAEJiwRSt12i/D9/TdbSo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GmUOB7Xx; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c1837568-8895-49f2-b340-262824d2cb74@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731049889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wngUjgq9lM9z2ZmfydmF4GEze6LELUVsVUwN1Peg5Gk=;
	b=GmUOB7XxTEJ4mgiV/mNF6W/+5hne2fWfREwJEUbnoArT3FtehTbxqhvn92DLk4RzihPoNs
	oihim2uQNEc7A67FgvyrlTQqwx79zwwCnWxX5uDaNBJeMENj++Dvk+C3I2rys5+daLWnCd
	aAfzEqjmGq227quFqQDa3yUA/jH259k=
Date: Fri, 8 Nov 2024 08:11:26 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 for-next] RDMA/hns: Fix different dgids mapping to the
 same dip_idx
To: Junxian Huang <huangjunxian6@hisilicon.com>, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, tangchengchang@huawei.com
References: <20241107061148.2010241-1-huangjunxian6@hisilicon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20241107061148.2010241-1-huangjunxian6@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/11/7 7:11, Junxian Huang 写道:
> From: Feng Fang <fangfeng4@huawei.com>
> 
> DIP algorithm requires a one-to-one mapping between dgid and dip_idx.
> Currently a queue 'spare_idx' is used to store QPN of QPs that use
> DIP algorithm. For a new dgid, use a QPN from spare_idx as dip_idx.
> This method lacks a mechanism for deduplicating QPN, which may result
> in different dgids sharing the same dip_idx and break the one-to-one
> mapping requirement.
> 
> This patch replaces spare_idx with xarray and introduces a refcnt of
> a dip_idx to indicate the number of QPs that using this dip_idx.
> 
> The state machine for dip_idx management is implemented as:
> 
> * The entry at an index in xarray is empty -- This indicates that the
>    corresponding dip_idx hasn't been created.
> 
> * The entry at an index in xarray is not empty but with 0 refcnt --
>    This indicates that the corresponding dip_idx has been created but
>    not used as dip_idx yet.
> 
> * The entry at an index in xarray is not empty and with non-0 refcnt --
>    This indicates that the corresponding dip_idx is being used by refcnt
>    number of DIP QPs.
> 
> Fixes: eb653eda1e91 ("RDMA/hns: Bugfix for incorrect association between dip_idx and dgid")
> Fixes: f91696f2f053 ("RDMA/hns: Support congestion control type selection according to the FW")
> Signed-off-by: Feng Fang <fangfeng4@huawei.com>
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
> v1 -> v2:
> * Use xarray instead of bitmaps as Leon suggested.
> * v1: https://lore.kernel.org/all/20240906093444.3571619-10-huangjunxian6@hisilicon.com/
> ---
>   drivers/infiniband/hw/hns/hns_roce_device.h | 11 +--
>   drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 96 +++++++++++++++------
>   drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  2 +-
>   drivers/infiniband/hw/hns/hns_roce_main.c   |  2 -
>   drivers/infiniband/hw/hns/hns_roce_qp.c     |  7 +-
>   5 files changed, 74 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> index 9b51d5a1533f..560a1d9de408 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> @@ -489,12 +489,6 @@ struct hns_roce_bank {
>   	u32 next; /* Next ID to allocate. */
>   };
> 
> -struct hns_roce_idx_table {
> -	u32 *spare_idx;
> -	u32 head;
> -	u32 tail;
> -};
> -
>   struct hns_roce_qp_table {
>   	struct hns_roce_hem_table	qp_table;
>   	struct hns_roce_hem_table	irrl_table;
> @@ -503,7 +497,7 @@ struct hns_roce_qp_table {
>   	struct mutex			scc_mutex;
>   	struct hns_roce_bank bank[HNS_ROCE_QP_BANK_NUM];
>   	struct mutex bank_mutex;
> -	struct hns_roce_idx_table	idx_table;
> +	struct xarray			dip_xa;
>   };
> 
>   struct hns_roce_cq_table {
> @@ -658,6 +652,7 @@ struct hns_roce_qp {
>   	u8			tc_mode;
>   	u8			priority;
>   	spinlock_t flush_lock;
> +	struct hns_roce_dip *dip;
>   };
> 
>   struct hns_roce_ib_iboe {
> @@ -984,8 +979,6 @@ struct hns_roce_dev {
>   	enum hns_roce_device_state state;
>   	struct list_head	qp_list; /* list of all qps on this dev */
>   	spinlock_t		qp_list_lock; /* protect qp_list */
> -	struct list_head	dip_list; /* list of all dest ips on this dev */
> -	spinlock_t		dip_list_lock; /* protect dip_list */
> 
>   	struct list_head        pgdir_list;
>   	struct mutex            pgdir_mutex;
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index d1c075fb0ad8..36e7cedfd106 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -2553,20 +2553,19 @@ static void hns_roce_free_link_table(struct hns_roce_dev *hr_dev)
>   	free_link_table_buf(hr_dev, &priv->ext_llm);
>   }
> 
> -static void free_dip_list(struct hns_roce_dev *hr_dev)
> +static void free_dip_entry(struct hns_roce_dev *hr_dev)
>   {
>   	struct hns_roce_dip *hr_dip;
> -	struct hns_roce_dip *tmp;
> -	unsigned long flags;
> +	unsigned long idx;
> 
> -	spin_lock_irqsave(&hr_dev->dip_list_lock, flags);
> +	xa_lock(&hr_dev->qp_table.dip_xa);

In the original source code, spin_lock_irqsave is used, it means that 
irq is also taken into account. But in the new code, xa_lock is used. It 
means that irq is not taken into account. Not sure if this will 
introduce risks or not.

Perhaps xa_lock_irqsave/xa_unlock_irqrestore is better?

Zhu Yanjun

> 
> -	list_for_each_entry_safe(hr_dip, tmp, &hr_dev->dip_list, node) {
> -		list_del(&hr_dip->node);
> +	xa_for_each(&hr_dev->qp_table.dip_xa, idx, hr_dip) {
> +		__xa_erase(&hr_dev->qp_table.dip_xa, hr_dip->dip_idx);
>   		kfree(hr_dip);
>   	}
> 
> -	spin_unlock_irqrestore(&hr_dev->dip_list_lock, flags);
> +	xa_unlock(&hr_dev->qp_table.dip_xa);
>   }
> 
>   static struct ib_pd *free_mr_init_pd(struct hns_roce_dev *hr_dev)
> @@ -2974,7 +2973,7 @@ static void hns_roce_v2_exit(struct hns_roce_dev *hr_dev)
>   		hns_roce_free_link_table(hr_dev);
> 
>   	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP09)
> -		free_dip_list(hr_dev);
> +		free_dip_entry(hr_dev);
>   }
> 
>   static int hns_roce_mbox_post(struct hns_roce_dev *hr_dev,
> @@ -4694,26 +4693,49 @@ static int modify_qp_rtr_to_rts(struct ib_qp *ibqp, int attr_mask,
>   	return 0;
>   }
> 
> +static int alloc_dip_entry(struct xarray *dip_xa, u32 qpn)
> +{
> +	struct hns_roce_dip *hr_dip;
> +	int ret;
> +
> +	hr_dip = xa_load(dip_xa, qpn);
> +	if (hr_dip)
> +		return 0;
> +
> +	hr_dip = kzalloc(sizeof(*hr_dip), GFP_KERNEL);
> +	if (!hr_dip)
> +		return -ENOMEM;
> +
> +	ret = xa_err(xa_store(dip_xa, qpn, hr_dip, GFP_KERNEL));
> +	if (ret)
> +		kfree(hr_dip);
> +
> +	return ret;
> +}
> +
>   static int get_dip_ctx_idx(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
>   			   u32 *dip_idx)
>   {
>   	const struct ib_global_route *grh = rdma_ah_read_grh(&attr->ah_attr);
>   	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
> -	u32 *spare_idx = hr_dev->qp_table.idx_table.spare_idx;
> -	u32 *head =  &hr_dev->qp_table.idx_table.head;
> -	u32 *tail =  &hr_dev->qp_table.idx_table.tail;
> +	struct xarray *dip_xa = &hr_dev->qp_table.dip_xa;
> +	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
>   	struct hns_roce_dip *hr_dip;
> -	unsigned long flags;
> +	unsigned long idx;
>   	int ret = 0;
> 
> -	spin_lock_irqsave(&hr_dev->dip_list_lock, flags);
> +	ret = alloc_dip_entry(dip_xa, ibqp->qp_num);
> +	if (ret)
> +		return ret;
> 
> -	spare_idx[*tail] = ibqp->qp_num;
> -	*tail = (*tail == hr_dev->caps.num_qps - 1) ? 0 : (*tail + 1);
> +	xa_lock(dip_xa);
> 
> -	list_for_each_entry(hr_dip, &hr_dev->dip_list, node) {
> -		if (!memcmp(grh->dgid.raw, hr_dip->dgid, GID_LEN_V2)) {
> +	xa_for_each(dip_xa, idx, hr_dip) {
> +		if (hr_dip->qp_cnt &&
> +		    !memcmp(grh->dgid.raw, hr_dip->dgid, GID_LEN_V2)) {
>   			*dip_idx = hr_dip->dip_idx;
> +			hr_dip->qp_cnt++;
> +			hr_qp->dip = hr_dip;
>   			goto out;
>   		}
>   	}
> @@ -4721,19 +4743,24 @@ static int get_dip_ctx_idx(struct ib_qp *ibqp, const struct ib_qp_attr *attr,
>   	/* If no dgid is found, a new dip and a mapping between dgid and
>   	 * dip_idx will be created.
>   	 */
> -	hr_dip = kzalloc(sizeof(*hr_dip), GFP_ATOMIC);
> -	if (!hr_dip) {
> -		ret = -ENOMEM;
> -		goto out;
> +	xa_for_each(dip_xa, idx, hr_dip) {
> +		if (hr_dip->qp_cnt)
> +			continue;
> +
> +		*dip_idx = idx;
> +		memcpy(hr_dip->dgid, grh->dgid.raw, sizeof(grh->dgid.raw));
> +		hr_dip->dip_idx = idx;
> +		hr_dip->qp_cnt++;
> +		hr_qp->dip = hr_dip;
> +		break;
>   	}
> 
> -	memcpy(hr_dip->dgid, grh->dgid.raw, sizeof(grh->dgid.raw));
> -	hr_dip->dip_idx = *dip_idx = spare_idx[*head];
> -	*head = (*head == hr_dev->caps.num_qps - 1) ? 0 : (*head + 1);
> -	list_add_tail(&hr_dip->node, &hr_dev->dip_list);
> +	/* This should never happen. */
> +	if (WARN_ON_ONCE(!hr_qp->dip))
> +		ret = -ENOSPC;
> 
>   out:
> -	spin_unlock_irqrestore(&hr_dev->dip_list_lock, flags);
> +	xa_unlock(dip_xa);
>   	return ret;
>   }
> 
> @@ -5587,6 +5614,20 @@ static int hns_roce_v2_destroy_qp_common(struct hns_roce_dev *hr_dev,
>   	return ret;
>   }
> 
> +static void put_dip_ctx_idx(struct hns_roce_dev *hr_dev,
> +			    struct hns_roce_qp *hr_qp)
> +{
> +	struct hns_roce_dip *hr_dip = hr_qp->dip;
> +
> +	xa_lock(&hr_dev->qp_table.dip_xa);
> +
> +	hr_dip->qp_cnt--;
> +	if (!hr_dip->qp_cnt)
> +		memset(hr_dip->dgid, 0, GID_LEN_V2);
> +
> +	xa_unlock(&hr_dev->qp_table.dip_xa);
> +}
> +
>   int hns_roce_v2_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
>   {
>   	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
> @@ -5600,6 +5641,9 @@ int hns_roce_v2_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
>   	spin_unlock_irqrestore(&hr_qp->flush_lock, flags);
>   	flush_work(&hr_qp->flush_work.work);
> 
> +	if (hr_qp->cong_type == CONG_TYPE_DIP)
> +		put_dip_ctx_idx(hr_dev, hr_qp);
> +
>   	ret = hns_roce_v2_destroy_qp_common(hr_dev, hr_qp, udata);
>   	if (ret)
>   		ibdev_err_ratelimited(&hr_dev->ib_dev,
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> index 3b3c6259ace0..1c593fcf1143 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
> @@ -1347,7 +1347,7 @@ struct hns_roce_v2_priv {
>   struct hns_roce_dip {
>   	u8 dgid[GID_LEN_V2];
>   	u32 dip_idx;
> -	struct list_head node; /* all dips are on a list */
> +	u32 qp_cnt;
>   };
> 
>   struct fmea_ram_ecc {
> diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
> index 49315f39361d..ae24c81c9812 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_main.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_main.c
> @@ -1135,8 +1135,6 @@ int hns_roce_init(struct hns_roce_dev *hr_dev)
> 
>   	INIT_LIST_HEAD(&hr_dev->qp_list);
>   	spin_lock_init(&hr_dev->qp_list_lock);
> -	INIT_LIST_HEAD(&hr_dev->dip_list);
> -	spin_lock_init(&hr_dev->dip_list_lock);
> 
>   	ret = hns_roce_register_device(hr_dev);
>   	if (ret)
> diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
> index 2ad03ecdbf8e..7d67cefe549c 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_qp.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
> @@ -1573,14 +1573,10 @@ int hns_roce_init_qp_table(struct hns_roce_dev *hr_dev)
>   	unsigned int reserved_from_bot;
>   	unsigned int i;
> 
> -	qp_table->idx_table.spare_idx = kcalloc(hr_dev->caps.num_qps,
> -					sizeof(u32), GFP_KERNEL);
> -	if (!qp_table->idx_table.spare_idx)
> -		return -ENOMEM;
> -
>   	mutex_init(&qp_table->scc_mutex);
>   	mutex_init(&qp_table->bank_mutex);
>   	xa_init(&hr_dev->qp_table_xa);
> +	xa_init(&qp_table->dip_xa);
> 
>   	reserved_from_bot = hr_dev->caps.reserved_qps;
> 
> @@ -1607,5 +1603,4 @@ void hns_roce_cleanup_qp_table(struct hns_roce_dev *hr_dev)
>   		ida_destroy(&hr_dev->qp_table.bank[i].ida);
>   	mutex_destroy(&hr_dev->qp_table.bank_mutex);
>   	mutex_destroy(&hr_dev->qp_table.scc_mutex);
> -	kfree(hr_dev->qp_table.idx_table.spare_idx);
>   }
> --
> 2.33.0
> 


