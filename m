Return-Path: <linux-rdma+bounces-15243-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8227DCE9451
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Dec 2025 10:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CF5D3012DC9
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Dec 2025 09:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E602C235D;
	Tue, 30 Dec 2025 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daCBQnur"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E731EBFF7
	for <linux-rdma@vger.kernel.org>; Tue, 30 Dec 2025 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767088345; cv=none; b=amuq/3Gi3Cq6Asnt+cfBQvoVmKwJCpwjd/Gi7tDKmNCmvT7ghB2jqTuJC2N5Vm+j5XGr0BTaV/6BKVIzbpxjx3YjOK05T4G+wvbOVyCXAiJHy34ASQqqVZ/4iyQT0JPIuZrhIh8EfurbSSnxfcftj+uBky+vCQvSbCloP18bOhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767088345; c=relaxed/simple;
	bh=8IuA29C6VW6zLafRfutkm4KLV7ICUqqwqD/HOuN84tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEJ8eBprkqxrD9vQswcI5i0A5zv1314MW4nW7UlwGs5fW2rtoaWKzuBmmjTjZeAbYp0WX2j7iHBlREcNVNbNMDkShb6UhMTFj/xWbR4AMjmjUfttYYxuebMfX5Q/czAqrDubUgJ2XU+9bRkes3rhP59aHNbJ6zutGzSIXVmcUUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daCBQnur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673FCC4CEFB;
	Tue, 30 Dec 2025 09:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767088344;
	bh=8IuA29C6VW6zLafRfutkm4KLV7ICUqqwqD/HOuN84tQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=daCBQnur2UIUHvxYy4D4bXDrfQ/XYNI9lV0EoEF2uBNxL/ZnHqR09qQoipLz9r55N
	 dxc5lPtXS0e6x9pzurmJUkTKszZJpNqAREHYOtA7x7/JZq9UGB/qgrgWzeIv2huFhK
	 an6o53vgYnPfc+F6TDryc3CqonvWNeHEF36wFE/i3ZtBRRan8rzWc4IVhu56+Nx61Y
	 miwcM4HzLOL2Szrh4wmH970nhNwsLuQPstAf4IF5BaAyBGFW2jpRhXG4BNiqhXbu78
	 fEJxg/qFo9q+DY5WgCq/6mB6HcfsSSW44fDAX/YK2SWsiCJ6HwZLhgV02n0syEVPMp
	 fof8P1Dn3aQsw==
Date: Tue, 30 Dec 2025 11:52:20 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	tangchengchang@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Introduce limit_bank mode with better
 performance
Message-ID: <20251230095220.GB27868@unreal>
References: <20251227065358.3397802-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227065358.3397802-1-huangjunxian6@hisilicon.com>

On Sat, Dec 27, 2025 at 02:53:58PM +0800, Junxian Huang wrote:
> From: wenglianfa <wenglianfa@huawei.com>

<...>

> Signed-off-by: wenglianfa <wenglianfa@huawei.com>

Please use real name, Documentation/process/submitting-patches.rst

Thanks

> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_cq.c     | 13 +++++-
>  drivers/infiniband/hw/hns/hns_roce_device.h |  6 +++
>  drivers/infiniband/hw/hns/hns_roce_main.c   |  5 +++
>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 49 ++++++++++++++++-----
>  4 files changed, 61 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
> index 6aa82fe9dd3d..bc57806abd39 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_cq.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
> @@ -53,9 +53,10 @@ void hns_roce_put_cq_bankid_for_uctx(struct hns_roce_ucontext *uctx)
>  
>  void hns_roce_get_cq_bankid_for_uctx(struct hns_roce_ucontext *uctx)
>  {
> +#define INVALID_LOAD_CQNUM 0xFFFFFFFF
>  	struct hns_roce_dev *hr_dev = to_hr_dev(uctx->ibucontext.device);
>  	struct hns_roce_cq_table *cq_table = &hr_dev->cq_table;
> -	u32 least_load = cq_table->ctx_num[0];
> +	u32 least_load = INVALID_LOAD_CQNUM;
>  	u8 bankid = 0;
>  	u8 i;
>  
> @@ -63,7 +64,10 @@ void hns_roce_get_cq_bankid_for_uctx(struct hns_roce_ucontext *uctx)
>  		return;
>  
>  	mutex_lock(&cq_table->bank_mutex);
> -	for (i = 1; i < HNS_ROCE_CQ_BANK_NUM; i++) {
> +	for (i = 0; i < HNS_ROCE_CQ_BANK_NUM; i++) {
> +		if (!(cq_table->valid_cq_bank_mask & BIT(i)))
> +			continue;
> +
>  		if (cq_table->ctx_num[i] < least_load) {
>  			least_load = cq_table->ctx_num[i];
>  			bankid = i;
> @@ -581,6 +585,11 @@ void hns_roce_init_cq_table(struct hns_roce_dev *hr_dev)
>  		cq_table->bank[i].max = hr_dev->caps.num_cqs /
>  					HNS_ROCE_CQ_BANK_NUM - 1;
>  	}
> +
> +	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_LIMIT_BANK)
> +		cq_table->valid_cq_bank_mask = VALID_CQ_BANK_MASK_LIMIT;
> +	else
> +		cq_table->valid_cq_bank_mask = VALID_CQ_BANK_MASK_DEFAULT;
>  }
>  
>  void hns_roce_cleanup_cq_table(struct hns_roce_dev *hr_dev)
> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> index 318f18cf37aa..3f032b8038af 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> @@ -103,6 +103,10 @@
>  
>  #define CQ_BANKID_SHIFT 2
>  #define CQ_BANKID_MASK GENMASK(1, 0)
> +#define VALID_CQ_BANK_MASK_DEFAULT 0xF
> +#define VALID_CQ_BANK_MASK_LIMIT 0x9
> +
> +#define VALID_EXT_SGE_QP_BANK_MASK_LIMIT 0x42
>  
>  #define HNS_ROCE_MAX_CQ_COUNT 0xFFFF
>  #define HNS_ROCE_MAX_CQ_PERIOD 0xFFFF
> @@ -156,6 +160,7 @@ enum {
>  	HNS_ROCE_CAP_FLAG_CQE_INLINE		= BIT(19),
>  	HNS_ROCE_CAP_FLAG_BOND                  = BIT(21),
>  	HNS_ROCE_CAP_FLAG_SRQ_RECORD_DB         = BIT(22),
> +	HNS_ROCE_CAP_FLAG_LIMIT_BANK            = BIT(23),
>  };
>  
>  #define HNS_ROCE_DB_TYPE_COUNT			2
> @@ -500,6 +505,7 @@ struct hns_roce_cq_table {
>  	struct hns_roce_bank bank[HNS_ROCE_CQ_BANK_NUM];
>  	struct mutex			bank_mutex;
>  	u32 ctx_num[HNS_ROCE_CQ_BANK_NUM];
> +	u8 valid_cq_bank_mask;
>  };
>  
>  struct hns_roce_srq_table {
> diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
> index 2f4864ab7d4e..a3490bab297a 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_main.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_main.c
> @@ -259,6 +259,11 @@ static int hns_roce_query_device(struct ib_device *ib_dev,
>  		props->max_srq_sge = hr_dev->caps.max_srq_sges;
>  	}
>  
> +	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_LIMIT_BANK) {
> +		props->max_cq >>= 1;
> +		props->max_qp >>= 1;
> +	}
> +
>  	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_FRMR &&
>  	    hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09) {
>  		props->device_cap_flags |= IB_DEVICE_MEM_MGT_EXTENSIONS;
> diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
> index d1640c5fbaab..5f7ea6c16644 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_qp.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
> @@ -197,22 +197,16 @@ static u8 get_affinity_cq_bank(u8 qp_bank)
>  	return (qp_bank >> 1) & CQ_BANKID_MASK;
>  }
>  
> -static u8 get_least_load_bankid_for_qp(struct ib_qp_init_attr *init_attr,
> -					struct hns_roce_bank *bank)
> +static u8 get_least_load_bankid_for_qp(struct hns_roce_bank *bank, u8 valid_qp_bank_mask)
>  {
>  #define INVALID_LOAD_QPNUM 0xFFFFFFFF
> -	struct ib_cq *scq = init_attr->send_cq;
>  	u32 least_load = INVALID_LOAD_QPNUM;
> -	unsigned long cqn = 0;
>  	u8 bankid = 0;
>  	u32 bankcnt;
>  	u8 i;
>  
> -	if (scq)
> -		cqn = to_hr_cq(scq)->cqn;
> -
>  	for (i = 0; i < HNS_ROCE_QP_BANK_NUM; i++) {
> -		if (scq && (get_affinity_cq_bank(i) != (cqn & CQ_BANKID_MASK)))
> +		if (!(valid_qp_bank_mask & BIT(i)))
>  			continue;
>  
>  		bankcnt = bank[i].inuse;
> @@ -246,6 +240,42 @@ static int alloc_qpn_with_bankid(struct hns_roce_bank *bank, u8 bankid,
>  
>  	return 0;
>  }
> +
> +static bool use_ext_sge(struct ib_qp_init_attr *init_attr)
> +{
> +	return init_attr->cap.max_send_sge > HNS_ROCE_SGE_IN_WQE ||
> +		init_attr->qp_type == IB_QPT_UD ||
> +		init_attr->qp_type == IB_QPT_GSI;
> +}
> +
> +static u8 select_qp_bankid(struct hns_roce_dev *hr_dev,
> +			   struct ib_qp_init_attr *init_attr)
> +{
> +	struct hns_roce_qp_table *qp_table = &hr_dev->qp_table;
> +	struct hns_roce_bank *bank = qp_table->bank;
> +	struct ib_cq *scq = init_attr->send_cq;
> +	u8 valid_qp_bank_mask = 0;
> +	unsigned long cqn = 0;
> +	u8 i;
> +
> +	if (scq)
> +		cqn = to_hr_cq(scq)->cqn;
> +
> +	for (i = 0; i < HNS_ROCE_QP_BANK_NUM; i++) {
> +		if (scq && (get_affinity_cq_bank(i) != (cqn & CQ_BANKID_MASK)))
> +			continue;
> +
> +		if ((hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_LIMIT_BANK) &&
> +		    use_ext_sge(init_attr) &&
> +		    !(VALID_EXT_SGE_QP_BANK_MASK_LIMIT & BIT(i)))
> +			continue;
> +
> +		valid_qp_bank_mask |= BIT(i);
> +	}
> +
> +	return get_least_load_bankid_for_qp(bank, valid_qp_bank_mask);
> +}
> +
>  static int alloc_qpn(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
>  		     struct ib_qp_init_attr *init_attr)
>  {
> @@ -258,8 +288,7 @@ static int alloc_qpn(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
>  		num = 1;
>  	} else {
>  		mutex_lock(&qp_table->bank_mutex);
> -		bankid = get_least_load_bankid_for_qp(init_attr, qp_table->bank);
> -
> +		bankid = select_qp_bankid(hr_dev, init_attr);
>  		ret = alloc_qpn_with_bankid(&qp_table->bank[bankid], bankid,
>  					    &num);
>  		if (ret) {
> -- 
> 2.33.0
> 
> 

