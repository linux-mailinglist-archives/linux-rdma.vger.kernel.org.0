Return-Path: <linux-rdma+bounces-4632-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA43964287
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2024 13:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 931C1286913
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2024 11:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4705C190471;
	Thu, 29 Aug 2024 11:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGwMtLYs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A7518A6D1
	for <linux-rdma@vger.kernel.org>; Thu, 29 Aug 2024 11:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724929387; cv=none; b=Y5OpTbpEh3k8neTJoffcFZLdTohn8QYnZuE4/NCWu+Tnr9QhqioLdex0Z0iN6Jgyx4vHz9g+vrkSYBK1Kx76SPcynOOgishx7dldh6uQICZ7d3sj0OJ9hQpvWoz6jfS1ZnJUPxvTJ6JO6m6WGcpmzJZzb2W+z6sIOr8Ko0S/Brc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724929387; c=relaxed/simple;
	bh=uXNXJo0wJ3E0YXqFPdJAZk6WInNjykAhL1/XdE0f/Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TScKdBtNQpFFc4lkLuhKj6TY5YMWs2OsonzRpLnkP4jxX7RGEiKzS7fYYjcvK7EGFY4F/IH9ODZ7TsQJ4AoV12RK6fDJFWqJVd2Ho/TUFjUPK64vfZJoWloizIfQ/poYq8ag/cMUcWwyf/9a1TmtLMiMHrXium89CzVv9DGFEQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGwMtLYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEF4C4CEC1;
	Thu, 29 Aug 2024 11:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724929386;
	bh=uXNXJo0wJ3E0YXqFPdJAZk6WInNjykAhL1/XdE0f/Mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IGwMtLYsBcBrtsr07HZVYT8EsvGGB+ekX9k6EsNalH7G/EDp7NClS2W5iYtxBwqsv
	 Mj1LiR1QsjMriiFlbJvc/wdF6/Xniwd6FxdcLw9leJCFl2rGGCNvnA1U8h+8oITDeo
	 f1KeD0NIrmSOojMGs7HGK2xIYGe2GXpLFq0QZkrJeQZm5gizhqX04QTPEoDjN6H/g/
	 gZKgk5BFt2aHr0Tz4wNL2ctzvfgoqDcbesDBo+9pPoyio8BFUi2Ql9lUCSQCi4c12O
	 8S+h8F0Vzh17X67PWqGnw23hRCLqipQ/s3qfPjxaMr9Gi/ZA3BrtxQ7QPPh+R4Kz67
	 sY69EHy5z9olQ==
Date: Thu, 29 Aug 2024 14:03:03 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, chandramohan.akula@broadcom.com
Subject: Re: [PATCH for-next 3/3] RDMA/bnxt_re: Share a page to expose per
 SRQ info with userspace
Message-ID: <20240829110303.GF26654@unreal>
References: <1724834832-10600-1-git-send-email-selvin.xavier@broadcom.com>
 <1724834832-10600-4-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1724834832-10600-4-git-send-email-selvin.xavier@broadcom.com>

On Wed, Aug 28, 2024 at 01:47:12AM -0700, Selvin Xavier wrote:
> From: Chandramohan Akula <chandramohan.akula@broadcom.com>
> 
> Gen P7 adapters needs to share a toggle bits information received
> in kernel driver with the user space. User space needs this
> info to arm the SRQ.
> 
> User space application can get this page using the
> UAPI routines. Library will mmap this page and get the
> toggle bits to be used in the next ARM Doorbell.
> 
> Uses a hash list to map the SRQ structure from the SRQ ID.
> SRQ structure is retrieved from the hash list while the
> library calls the UAPI routine to get the toggle page
> mapping. Currently the full page is mapped per SRQ. This
> can be optimized to enable multiple SRQs from the same
> application share the same page and different offsets
> in the page
> 
> Signed-off-by: Chandramohan Akula <chandramohan.akula@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/bnxt_re.h  |  2 ++
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 34 +++++++++++++++++++++++++++++++-
>  drivers/infiniband/hw/bnxt_re/ib_verbs.h |  1 +
>  drivers/infiniband/hw/bnxt_re/main.c     |  6 +++++-
>  include/uapi/rdma/bnxt_re-abi.h          |  5 +++++
>  5 files changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> index 0912d2f..2be9a62 100644
> --- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> +++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> @@ -141,6 +141,7 @@ struct bnxt_re_pacing {
>  #define BNXT_RE_GRC_FIFO_REG_BASE 0x2000
>  
>  #define MAX_CQ_HASH_BITS		(16)
> +#define MAX_SRQ_HASH_BITS		(16)
>  struct bnxt_re_dev {
>  	struct ib_device		ibdev;
>  	struct list_head		list;
> @@ -196,6 +197,7 @@ struct bnxt_re_dev {
>  	struct work_struct dbq_fifo_check_work;
>  	struct delayed_work dbq_pacing_work;
>  	DECLARE_HASHTABLE(cq_hash, MAX_CQ_HASH_BITS);
> +	DECLARE_HASHTABLE(srq_hash, MAX_SRQ_HASH_BITS);
>  };
>  
>  #define to_bnxt_re_dev(ptr, member)	\
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> index 1e76093..0219c8a 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -1685,6 +1685,10 @@ int bnxt_re_destroy_srq(struct ib_srq *ib_srq, struct ib_udata *udata)
>  
>  	if (qplib_srq->cq)
>  		nq = qplib_srq->cq->nq;
> +	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT) {
> +		free_page((unsigned long)srq->uctx_srq_page);
> +		hash_del(&srq->hash_entry);
> +	}
>  	bnxt_qplib_destroy_srq(&rdev->qplib_res, qplib_srq);
>  	ib_umem_release(srq->umem);
>  	atomic_dec(&rdev->stats.res.srq_count);
> @@ -1789,9 +1793,18 @@ int bnxt_re_create_srq(struct ib_srq *ib_srq,
>  	}
>  
>  	if (udata) {
> -		struct bnxt_re_srq_resp resp;
> +		struct bnxt_re_srq_resp resp = {};
>  
>  		resp.srqid = srq->qplib_srq.id;
> +		if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT) {
> +			hash_add(rdev->srq_hash, &srq->hash_entry, srq->qplib_srq.id);
> +			srq->uctx_srq_page = (void *)get_zeroed_page(GFP_KERNEL);
> +			if (!srq->uctx_srq_page) {
> +				rc = -ENOMEM;
> +				goto fail;
> +			}
> +			resp.comp_mask |= BNXT_RE_SRQ_TOGGLE_PAGE_SUPPORT;
> +		}
>  		rc = ib_copy_to_udata(udata, &resp, sizeof(resp));
>  		if (rc) {
>  			ibdev_err(&rdev->ibdev, "SRQ copy to udata failed!");
> @@ -4266,6 +4279,19 @@ static struct bnxt_re_cq *bnxt_re_search_for_cq(struct bnxt_re_dev *rdev, u32 cq
>  	return cq;
>  }
>  
> +static struct bnxt_re_srq *bnxt_re_search_for_srq(struct bnxt_re_dev *rdev, u32 srq_id)
> +{
> +	struct bnxt_re_srq *srq = NULL, *tmp_srq;
> +
> +	hash_for_each_possible(rdev->srq_hash, tmp_srq, hash_entry, srq_id) {
> +		if (tmp_srq->qplib_srq.id == srq_id) {
> +			srq = tmp_srq;
> +			break;
> +		}
> +	}
> +	return srq;
> +}
> +
>  /* Helper function to mmap the virtual memory from user app */
>  int bnxt_re_mmap(struct ib_ucontext *ib_uctx, struct vm_area_struct *vma)
>  {
> @@ -4494,6 +4520,7 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
>  	struct bnxt_re_ucontext *uctx;
>  	struct ib_ucontext *ib_uctx;
>  	struct bnxt_re_dev *rdev;
> +	struct bnxt_re_srq *srq;
>  	u32 length = PAGE_SIZE;
>  	struct bnxt_re_cq *cq;
>  	u64 mem_offset;
> @@ -4525,6 +4552,11 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_GET_TOGGLE_MEM)(struct uverbs_attr_bund
>  		addr = (u64)cq->uctx_cq_page;
>  		break;
>  	case BNXT_RE_SRQ_TOGGLE_MEM:
> +		srq = bnxt_re_search_for_srq(rdev, res_id);
> +		if (!srq)
> +			return -EINVAL;
> +
> +		addr = (u64)srq->uctx_srq_page;
>  		break;
>  
>  	default:
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> index 4e113b9..9c74dfe 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> @@ -78,6 +78,7 @@ struct bnxt_re_srq {
>  	struct ib_umem		*umem;
>  	spinlock_t		lock;		/* protect srq */
>  	void			*uctx_srq_page;
> +	struct hlist_node       hash_entry;
>  };
>  
>  struct bnxt_re_qp {
> diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> index 9714b9a..1211fe5 100644
> --- a/drivers/infiniband/hw/bnxt_re/main.c
> +++ b/drivers/infiniband/hw/bnxt_re/main.c
> @@ -139,8 +139,10 @@ static void bnxt_re_set_drv_mode(struct bnxt_re_dev *rdev, u8 mode)
>  	if (bnxt_re_hwrm_qcaps(rdev))
>  		dev_err(rdev_to_dev(rdev),
>  			"Failed to query hwrm qcaps\n");
> -	if (bnxt_qplib_is_chip_gen_p7(rdev->chip_ctx))
> +	if (bnxt_qplib_is_chip_gen_p7(rdev->chip_ctx)) {
>  		cctx->modes.toggle_bits |= BNXT_QPLIB_CQ_TOGGLE_BIT;
> +		cctx->modes.toggle_bits |= BNXT_QPLIB_SRQ_TOGGLE_BIT;
> +	}
>  }
>  
>  static void bnxt_re_destroy_chip_ctx(struct bnxt_re_dev *rdev)
> @@ -1771,6 +1773,8 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 wqe_mode)
>  		bnxt_re_vf_res_config(rdev);
>  	}
>  	hash_init(rdev->cq_hash);
> +	if (rdev->chip_ctx->modes.toggle_bits & BNXT_QPLIB_SRQ_TOGGLE_BIT)
> +		hash_init(rdev->srq_hash);
>  
>  	return 0;
>  free_sctx:
> diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
> index e61104f..84917a9 100644
> --- a/include/uapi/rdma/bnxt_re-abi.h
> +++ b/include/uapi/rdma/bnxt_re-abi.h
> @@ -134,8 +134,13 @@ struct bnxt_re_srq_req {
>  	__aligned_u64 srq_handle;
>  };
>  
> +enum bnxt_re_srq_mask {
> +	BNXT_RE_SRQ_TOGGLE_PAGE_SUPPORT = 0x1,
> +};
> +
>  struct bnxt_re_srq_resp {
>  	__u32 srqid;

I think that you should add __u32 reserved field here to align the
struct.

> +	__aligned_u64 comp_mask;
>  };
>  
>  enum bnxt_re_shpg_offt {
> -- 
> 2.5.5
> 

