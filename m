Return-Path: <linux-rdma+bounces-402-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EEE810C07
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Dec 2023 09:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25A928184A
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Dec 2023 08:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A950A1CA9F;
	Wed, 13 Dec 2023 08:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ex26g4PH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A76A1CA96
	for <linux-rdma@vger.kernel.org>; Wed, 13 Dec 2023 08:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58515C433C7;
	Wed, 13 Dec 2023 08:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702455002;
	bh=ec4SlFoQJFFYJn71TzxQtUfao+0n1L45UTzjqaZI9+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ex26g4PHx9E2a9+WY6f1pO26SGZNogYEa0zO/gbBfdqoJyw04mep5YqX8b+m2Bj84
	 eLtXdr1yX75eAqNiWXgK4Iaw5JXMiHy2mggb+RuJH1Ryzh/msofHrbmHrwO0MxJUv+
	 M6tt/m1tb/xBVJEnbQL96fsszzEBnCbIIHMpp1f7aJdLABXbIk/khwh2xmb9qUDHVO
	 mj5j2+xhIORY4eI2PLfqtlz+giS0znJZaILwhJskVNlHFd9Bz/9Bz6bkzsZGpN/BvJ
	 9Q7csqTVpyAeLPO0T8Ol3Ypm8aMht29f88IeVOQWZ9iagKAa2eaYp4JYBKDO0S8zXg
	 u1fF4a6mxOrdA==
Date: Wed, 13 Dec 2023 10:09:58 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 1/2] RDMA/bnxt_re: Add UAPI to share a page with
 user space
Message-ID: <20231213080958.GM4870@unreal>
References: <1702438411-23530-1-git-send-email-selvin.xavier@broadcom.com>
 <1702438411-23530-2-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1702438411-23530-2-git-send-email-selvin.xavier@broadcom.com>

On Tue, Dec 12, 2023 at 07:33:30PM -0800, Selvin Xavier wrote:
> Gen P7 adapters require to share a toggle value for CQ
> and SRQ. This is received by the driver as part of
> interrupt notifications and needs to be shared with the
> user space. Add a new UAPI infrastructure to get the
> shared page for CQ and SRQ.
> 
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 106 +++++++++++++++++++++++++++++++
>  drivers/infiniband/hw/bnxt_re/ib_verbs.h |   1 +
>  include/uapi/rdma/bnxt_re-abi.h          |  26 ++++++++
>  3 files changed, 133 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> index e7ef099..76cea30 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -567,6 +567,7 @@ bnxt_re_mmap_entry_insert(struct bnxt_re_ucontext *uctx, u64 mem_offset,
>  	case BNXT_RE_MMAP_WC_DB:
>  	case BNXT_RE_MMAP_DBR_BAR:
>  	case BNXT_RE_MMAP_DBR_PAGE:
> +	case BNXT_RE_MMAP_TOGGLE_PAGE:
>  		ret = rdma_user_mmap_entry_insert(&uctx->ib_uctx,
>  						  &entry->rdma_entry, PAGE_SIZE);
>  		break;
> @@ -4254,6 +4255,7 @@ int bnxt_re_mmap(struct ib_ucontext *ib_uctx, struct vm_area_struct *vma)
>  					rdma_entry);
>  		break;
>  	case BNXT_RE_MMAP_DBR_PAGE:
> +	case BNXT_RE_MMAP_TOGGLE_PAGE:
>  		/* Driver doesn't expect write access for user space */
>  		if (vma->vm_flags & VM_WRITE)
>  			return -EFAULT;
> @@ -4430,8 +4432,112 @@ DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_NOTIFY_DRV);
>  DECLARE_UVERBS_GLOBAL_METHODS(BNXT_RE_OBJECT_NOTIFY_DRV,
>  			      &UVERBS_METHOD(BNXT_RE_METHOD_NOTIFY_DRV));
>  
> +/* Toggle MEM */
> +static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bundle *attrs)
> +{
> +	struct ib_uobject *uobj = uverbs_attr_get_uobject(attrs, BNXT_RE_TOGGLE_MEM_HANDLE);
> +	enum bnxt_re_get_toggle_mem_type res_type;
> +	struct bnxt_re_user_mmap_entry *entry;
> +	enum bnxt_re_mmap_flag mmap_flag;
> +	struct bnxt_qplib_chip_ctx *cctx;
> +	struct bnxt_re_ucontext *uctx;
> +	struct bnxt_re_dev *rdev;
> +	u64 mem_offset;
> +	u32 length;
> +	u32 offset;
> +	u64 addr;
> +	int err;
> +
> +	uctx = container_of(ib_uverbs_get_ucontext(attrs), struct bnxt_re_ucontext, ib_uctx);
> +	if (IS_ERR(uctx))

How is it possible? You should check return value from ib_uverbs_get_ucontext() and not container_of.

> +		return PTR_ERR(uctx);
> +
> +	err = uverbs_get_const(&res_type, attrs, BNXT_RE_TOGGLE_MEM_TYPE);
> +	if (err)
> +		return err;
> +
> +	rdev = uctx->rdev;
> +	cctx = rdev->chip_ctx;
> +
> +	switch (res_type) {
> +	case BNXT_RE_CQ_TOGGLE_MEM:
> +		break;

No need in this break here.

> +	case BNXT_RE_SRQ_TOGGLE_MEM:
> +		break;
> +
> +	default:
> +		return -EOPNOTSUPP;
> +	}

Thanks

