Return-Path: <linux-rdma+bounces-5730-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 225D09BAE19
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Nov 2024 09:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 988A71F220D5
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Nov 2024 08:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3462B189F5F;
	Mon,  4 Nov 2024 08:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5ygXMoX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32F9189B97;
	Mon,  4 Nov 2024 08:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730709076; cv=none; b=GroPdKQgI7acq4pIA2hiOoMyCHGfmbRD6htHJClF5Kn40aB5mvlG/5sy6BOqIyEkv9gulB5//uSd2Ypnxh4tTluUPTEXHK0m0oQrrGLFYSG4iXyJFrVQ0OMoe8DMQeLNLiLKcQfmjvpwcB4Khxc/HhXY7XrHPohc3F8pA1yrsFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730709076; c=relaxed/simple;
	bh=3lXcI2gDCvD8Bf4i9kaGY28TLmCxro0UCE61VCrGrGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHGzAJ/rgmM7xc/YlKpuNBzlD6tJ82pQxWga2qyXqHx4MADV5zuMPWGuUmX8XLaKYNaxJSB5zPI1q/92BI/8Ck/01+lww0V0OrpvkDNgrM57cZ7QqHfYEMxRUs/uNH71KyU6CLN/LX9ZpjuNjCHg7eArWln+647xIzBJhZv6npQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5ygXMoX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A30C4CED2;
	Mon,  4 Nov 2024 08:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730709075;
	bh=3lXcI2gDCvD8Bf4i9kaGY28TLmCxro0UCE61VCrGrGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d5ygXMoXUAFfecUVU98LugXn+MulotJgeTT0oDQuAwdLiLCrh3Ezixh7szyA1Mps3
	 YZn4idSwMESzO10FY6462jcRHGaYjfFcCuyRuyNkvJOo3sQDQVrj9tViXqZrI00zZJ
	 jXBgqF/D9DLPyN+jAfY7m0vHhMqCV1wEa+4HxBA+j2r8DkCLhInGZjVVxwEDE3tcwR
	 Vd0pBI1esp1/he72I20MkmkGQv6z3UzXHNm4bAFDayC+DiAZeM+RDqjflZ4aZm5n75
	 3y/+06OQveRHajORXGbEpUW8/ZeqkhkeIZlyvDhBQD+CQUv+ogCQtt6TOY7eaQ9rjw
	 8zdwk3r3d2UsQ==
Date: Mon, 4 Nov 2024 10:31:09 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org, tangchengchang@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Support mmapping reset state to
 userspace
Message-ID: <20241104083109.GC99170@unreal>
References: <20241014130731.1650279-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014130731.1650279-1-huangjunxian6@hisilicon.com>

On Mon, Oct 14, 2024 at 09:07:31PM +0800, Junxian Huang wrote:
> From: Chengchang Tang <tangchengchang@huawei.com>
> 
> Mmap reset state to notify userspace about HW reset. The mmaped flag
> hw_ready will be initiated to a non-zero value. When HW is reset,
> the mmap page will be zapped and userspace will get a zero value of
> hw_ready.

I didn't forget that patch, but not applying now as it seems extremely
sketchy for me, so waiting for anyone to come and say their opinion too.

Thanks

> 
> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_device.h |  4 ++
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 47 ++++++++++++++++++++-
>  drivers/infiniband/hw/hns/hns_roce_main.c   | 36 ++++++++++++++++
>  include/uapi/rdma/hns-abi.h                 |  6 +++
>  4 files changed, 91 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> index 0b1e21cb6d2d..59bca8067a7f 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> @@ -202,6 +202,7 @@ struct hns_roce_uar {
>  enum hns_roce_mmap_type {
>  	HNS_ROCE_MMAP_TYPE_DB = 1,
>  	HNS_ROCE_MMAP_TYPE_DWQE,
> +	HNS_ROCE_MMAP_TYPE_RESET,
>  };
>  
>  struct hns_user_mmap_entry {
> @@ -216,6 +217,7 @@ struct hns_roce_ucontext {
>  	struct list_head	page_list;
>  	struct mutex		page_mutex;
>  	struct hns_user_mmap_entry *db_mmap_entry;
> +	struct hns_user_mmap_entry *reset_mmap_entry;
>  	u32			config;
>  };
>  
> @@ -1020,6 +1022,8 @@ struct hns_roce_dev {
>  	int			loop_idc;
>  	u32			sdb_offset;
>  	u32			odb_offset;
> +	struct page		*reset_page; /* store reset state */
> +	void			*reset_kaddr; /* addr of reset page */
>  	const struct hns_roce_hw *hw;
>  	void			*priv;
>  	struct workqueue_struct *irq_workq;
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index f1feaa79f78e..2f72074b7cf9 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -37,6 +37,7 @@
>  #include <linux/kernel.h>
>  #include <linux/types.h>
>  #include <linux/workqueue.h>
> +#include <linux/vmalloc.h>
>  #include <net/addrconf.h>
>  #include <rdma/ib_addr.h>
>  #include <rdma/ib_cache.h>
> @@ -2865,6 +2866,36 @@ static int free_mr_init(struct hns_roce_dev *hr_dev)
>  	return ret;
>  }
>  
> +static int hns_roce_v2_get_reset_page(struct hns_roce_dev *hr_dev)
> +{
> +	struct hns_roce_reset_state *state;
> +
> +	hr_dev->reset_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
> +	if (!hr_dev->reset_page)
> +		return -ENOMEM;
> +
> +	hr_dev->reset_kaddr = vmap(&hr_dev->reset_page, 1, VM_MAP, PAGE_KERNEL);
> +	if (!hr_dev->reset_kaddr)
> +		goto err_with_vmap;
> +
> +	state = hr_dev->reset_kaddr;
> +	state->hw_ready = 1;
> +
> +	return 0;
> +
> +err_with_vmap:
> +	put_page(hr_dev->reset_page);
> +	return -ENOMEM;
> +}
> +
> +static void hns_roce_v2_put_reset_page(struct hns_roce_dev *hr_dev)
> +{
> +	vunmap(hr_dev->reset_kaddr);
> +	hr_dev->reset_kaddr = NULL;
> +	put_page(hr_dev->reset_page);
> +	hr_dev->reset_page = NULL;
> +}
> +
>  static int get_hem_table(struct hns_roce_dev *hr_dev)
>  {
>  	unsigned int qpc_count;
> @@ -2944,14 +2975,21 @@ static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
>  {
>  	int ret;
>  
> +	ret = hns_roce_v2_get_reset_page(hr_dev);
> +	if (ret) {
> +		dev_err(hr_dev->dev,
> +			"reset state init failed, ret = %d.\n", ret);
> +		return ret;
> +	}
> +
>  	/* The hns ROCEE requires the extdb info to be cleared before using */
>  	ret = hns_roce_clear_extdb_list_info(hr_dev);
>  	if (ret)
> -		return ret;
> +		goto err_clear_extdb_failed;
>  
>  	ret = get_hem_table(hr_dev);
>  	if (ret)
> -		return ret;
> +		goto err_clear_extdb_failed;
>  
>  	if (hr_dev->is_vf)
>  		return 0;
> @@ -2967,6 +3005,9 @@ static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
>  err_llm_init_failed:
>  	put_hem_table(hr_dev);
>  
> +err_clear_extdb_failed:
> +	hns_roce_v2_put_reset_page(hr_dev);
> +
>  	return ret;
>  }
>  
> @@ -2980,6 +3021,8 @@ static void hns_roce_v2_exit(struct hns_roce_dev *hr_dev)
>  	if (!hr_dev->is_vf)
>  		hns_roce_free_link_table(hr_dev);
>  
> +	hns_roce_v2_put_reset_page(hr_dev);
> +
>  	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP09)
>  		free_dip_list(hr_dev);
>  }
> diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
> index 49315f39361d..1620d4318480 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_main.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_main.c
> @@ -324,6 +324,7 @@ hns_roce_user_mmap_entry_insert(struct ib_ucontext *ucontext, u64 address,
>  				ucontext, &entry->rdma_entry, length, 0);
>  		break;
>  	case HNS_ROCE_MMAP_TYPE_DWQE:
> +	case HNS_ROCE_MMAP_TYPE_RESET:
>  		ret = rdma_user_mmap_entry_insert_range(
>  				ucontext, &entry->rdma_entry, length, 1,
>  				U32_MAX);
> @@ -341,6 +342,20 @@ hns_roce_user_mmap_entry_insert(struct ib_ucontext *ucontext, u64 address,
>  	return entry;
>  }
>  
> +static int hns_roce_alloc_reset_entry(struct ib_ucontext *uctx)
> +{
> +	struct hns_roce_ucontext *context = to_hr_ucontext(uctx);
> +	struct hns_roce_dev *hr_dev = to_hr_dev(uctx->device);
> +
> +	context->reset_mmap_entry = hns_roce_user_mmap_entry_insert(
> +		uctx, (u64)page_to_phys(hr_dev->reset_page), PAGE_SIZE,
> +		HNS_ROCE_MMAP_TYPE_RESET);
> +	if (!context->reset_mmap_entry)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
>  static void hns_roce_dealloc_uar_entry(struct hns_roce_ucontext *context)
>  {
>  	if (context->db_mmap_entry)
> @@ -369,6 +384,7 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
>  	struct hns_roce_dev *hr_dev = to_hr_dev(uctx->device);
>  	struct hns_roce_ib_alloc_ucontext_resp resp = {};
>  	struct hns_roce_ib_alloc_ucontext ucmd = {};
> +	struct rdma_user_mmap_entry *rdma_entry;
>  	int ret = -EAGAIN;
>  
>  	if (!hr_dev->active)
> @@ -421,6 +437,13 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
>  
>  	resp.cqe_size = hr_dev->caps.cqe_sz;
>  
> +	ret = hns_roce_alloc_reset_entry(uctx);
> +	if (ret)
> +		goto error_fail_reset_entry;
> +
> +	rdma_entry = &context->reset_mmap_entry->rdma_entry;
> +	resp.reset_mmap_key = rdma_user_mmap_get_offset(rdma_entry);
> +
>  	ret = ib_copy_to_udata(udata, &resp,
>  			       min(udata->outlen, sizeof(resp)));
>  	if (ret)
> @@ -429,6 +452,9 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
>  	return 0;
>  
>  error_fail_copy_to_udata:
> +	rdma_user_mmap_entry_remove(&context->reset_mmap_entry->rdma_entry);
> +
> +error_fail_reset_entry:
>  	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_CQ_RECORD_DB ||
>  	    hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_RECORD_DB)
>  		mutex_destroy(&context->page_mutex);
> @@ -448,6 +474,8 @@ static void hns_roce_dealloc_ucontext(struct ib_ucontext *ibcontext)
>  	struct hns_roce_ucontext *context = to_hr_ucontext(ibcontext);
>  	struct hns_roce_dev *hr_dev = to_hr_dev(ibcontext->device);
>  
> +	rdma_user_mmap_entry_remove(&context->reset_mmap_entry->rdma_entry);
> +
>  	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_CQ_RECORD_DB ||
>  	    hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_QP_RECORD_DB)
>  		mutex_destroy(&context->page_mutex);
> @@ -485,6 +513,14 @@ static int hns_roce_mmap(struct ib_ucontext *uctx, struct vm_area_struct *vma)
>  	case HNS_ROCE_MMAP_TYPE_DWQE:
>  		prot = pgprot_device(vma->vm_page_prot);
>  		break;
> +	case HNS_ROCE_MMAP_TYPE_RESET:
> +		if (vma->vm_flags & (VM_WRITE | VM_EXEC)) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +		vm_flags_set(vma, VM_DONTEXPAND);
> +		prot = vma->vm_page_prot;
> +		break;
>  	default:
>  		ret = -EINVAL;
>  		goto out;
> diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
> index 94e861870e27..065eb2e0a690 100644
> --- a/include/uapi/rdma/hns-abi.h
> +++ b/include/uapi/rdma/hns-abi.h
> @@ -136,6 +136,7 @@ struct hns_roce_ib_alloc_ucontext_resp {
>  	__u32	max_inline_data;
>  	__u8	congest_type;
>  	__u8	reserved0[7];
> +	__aligned_u64 reset_mmap_key;
>  };
>  
>  struct hns_roce_ib_alloc_ucontext {
> @@ -153,4 +154,9 @@ struct hns_roce_ib_create_ah_resp {
>  	__u8 tc_mode;
>  };
>  
> +struct hns_roce_reset_state {
> +	__u32 hw_ready;
> +	__u32 reserved;
> +};
> +
>  #endif /* HNS_ABI_USER_H */
> -- 
> 2.33.0
> 

