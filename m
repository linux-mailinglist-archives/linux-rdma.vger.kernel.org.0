Return-Path: <linux-rdma+bounces-18405-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XSqJAatyvGlpywIAu9opvQ
	(envelope-from <linux-rdma+bounces-18405-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 23:03:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 388092D2DA3
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 23:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 891DE30097D5
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 22:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8334D30E827;
	Thu, 19 Mar 2026 22:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i1L3Z7cG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2729835949
	for <linux-rdma@vger.kernel.org>; Thu, 19 Mar 2026 22:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773957792; cv=none; b=kH+/So7yGO17+0IgES+4kjZqwr5/qYoQ0DwIZ4uTgLAAkphKZv3Y5i27WyoUxdeOVIA98hy+8ATQuHQyqmNc98zFjV5pCB4eI4XlCi6y34kofY24DyPYmP2ChtiCnkmveHrPmUvILddiReVrc/97IVaW+pNzAaLMAZsO4Mn8ufE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773957792; c=relaxed/simple;
	bh=bdaa+8PHrvIw/oE7WLnJD2eap6w43D8FtvtpPSZzP+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=CQ7EX8vzRa5llrFMSjzW5Up16yhgdu77nDeCbdzpHR/vdq1t0ykzrb+f5CeVmpDQRYpumh9WRe9VkiIcDEOeC3CXLNde0l3KvocL4X/Nt0kykMrJK7YHo7wkjjlu3yKWrKnBPL5A+pRcLYeDi+RmMJ6IkTxakdOAsDJojIJq7+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i1L3Z7cG; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <02ce0f8a-1ad7-4f18-a26f-99d38d38fec0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773957787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JnfMUBR1cfcGrZD0oe+c5P4lraQIXr9ou7ZpkUuKK7Q=;
	b=i1L3Z7cGdS8jdHzDtJis5VyJHRBPZx7Q8HNWhSDGp11Gh9+Raxrb13dorRYgFSuFBM3/2I
	DH3YRPcz1SWKnYafexC940ju4HRPBoyDdPc9zva60MFg5qYABWF0YL1by4WVrGRvWGs08a
	Ju4XXo0s8fsD094FB+LaQ/kAsTNWBp8=
Date: Thu, 19 Mar 2026 15:02:57 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next] RDMA: Properly propagate the number of CQEs as
 unsigned int
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Selvin Xavier <selvin.xavier@broadcom.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
 Yishai Hadas <yishaih@nvidia.com>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 Zhu Yanjun <zyjzyj2000@gmail.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
References: <20260319-resize_cq-cqe-v1-1-b78c6efc1def@nvidia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
Cc: linux-rdma <linux-rdma@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20260319-resize_cq-cqe-v1-1-b78c6efc1def@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,broadcom.com,intel.com,nvidia.com,cornelisnetworks.com,gmail.com,linux.dev];
	TAGGED_FROM(0.00)[bounces-18405-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 388092D2DA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/19/26 8:22 AM, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Instead of checking whether the number of CQEs is negative or zero, fix the
> .resize_user_cq() declaration to use unsigned int. This better reflects the
> expected value range. The sanity check is then handled correctly in ib_uvbers.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>   drivers/infiniband/core/uverbs_cmd.c         |  3 +++
>   drivers/infiniband/hw/bnxt_re/ib_verbs.c     |  8 +++----
>   drivers/infiniband/hw/bnxt_re/ib_verbs.h     |  3 ++-
>   drivers/infiniband/hw/irdma/verbs.c          |  2 +-
>   drivers/infiniband/hw/mlx4/cq.c              |  5 +++--
>   drivers/infiniband/hw/mlx4/mlx4_ib.h         |  3 ++-
>   drivers/infiniband/hw/mlx5/cq.c              | 10 +++------
>   drivers/infiniband/hw/mlx5/mlx5_ib.h         |  3 ++-
>   drivers/infiniband/hw/mthca/mthca_provider.c |  5 +++--
>   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c  | 12 +++++------
>   drivers/infiniband/hw/ocrdma/ocrdma_verbs.h  |  2 +-
>   drivers/infiniband/sw/rdmavt/cq.c            |  4 ++--
>   drivers/infiniband/sw/rdmavt/cq.h            |  2 +-
>   drivers/infiniband/sw/rxe/rxe_cq.c           | 31 ----------------------------
>   drivers/infiniband/sw/rxe/rxe_loc.h          |  3 ---
>   drivers/infiniband/sw/rxe/rxe_verbs.c        | 18 +++++++---------
>   include/rdma/ib_verbs.h                      |  2 +-
>   17 files changed, 39 insertions(+), 77 deletions(-)
> 
> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> index 25741db2c8f64..a768436ba4680 100644
> --- a/drivers/infiniband/core/uverbs_cmd.c
> +++ b/drivers/infiniband/core/uverbs_cmd.c
> @@ -1138,6 +1138,9 @@ static int ib_uverbs_resize_cq(struct uverbs_attr_bundle *attrs)
>   	if (ret)
>   		return ret;
>   
> +	if (!cmd.cqe)
> +		return -EINVAL;
> +
>   	cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ, cmd.cq_handle, attrs);
>   	if (IS_ERR(cq))
>   		return PTR_ERR(cq);
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> index 182128ee4f242..bc5b36c7cdc95 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -3551,7 +3551,8 @@ static void bnxt_re_resize_cq_complete(struct bnxt_re_cq *cq)
>   	}
>   }
>   
> -int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
> +int bnxt_re_resize_cq(struct ib_cq *ibcq, unsigned int cqe,
> +		      struct ib_udata *udata)
>   {
>   	struct bnxt_qplib_sg_info sg_info = {};
>   	struct bnxt_qplib_dpi *orig_dpi = NULL;
> @@ -3577,11 +3578,8 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
>   	}
>   
>   	/* Check the requested cq depth out of supported depth */
> -	if (cqe < 1 || cqe > dev_attr->max_cq_wqes) {
> -		ibdev_err(&rdev->ibdev, "Resize CQ %#x failed - out of range cqe %d",
> -			  cq->qplib_cq.id, cqe);
> +	if (cqe > dev_attr->max_cq_wqes)
>   		return -EINVAL;
> -	}
>   
>   	uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
>   	entries = bnxt_re_init_depth(cqe + 1, uctx);
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> index 3d02c16f54b61..14f4d9d66a1fe 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> @@ -255,7 +255,8 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>   		      struct uverbs_attr_bundle *attrs);
>   int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>   			   struct uverbs_attr_bundle *attrs);
> -int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata);
> +int bnxt_re_resize_cq(struct ib_cq *ibcq, unsigned int cqe,
> +		      struct ib_udata *udata);
>   int bnxt_re_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
>   int bnxt_re_poll_cq(struct ib_cq *cq, int num_entries, struct ib_wc *wc);
>   int bnxt_re_req_notify_cq(struct ib_cq *cq, enum ib_cq_notify_flags flags);
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
> index 740a770199f7f..531905aaa89fb 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -2012,7 +2012,7 @@ static int irdma_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
>    * @entries: desired cq size
>    * @udata: user data
>    */
> -static int irdma_resize_cq(struct ib_cq *ibcq, int entries,
> +static int irdma_resize_cq(struct ib_cq *ibcq, unsigned int entries,
>   			   struct ib_udata *udata)
>   {
>   #define IRDMA_RESIZE_CQ_MIN_REQ_LEN offsetofend(struct irdma_resize_cq_req, user_cq_buffer)
> diff --git a/drivers/infiniband/hw/mlx4/cq.c b/drivers/infiniband/hw/mlx4/cq.c
> index 8535fd561691d..b391883aa4004 100644
> --- a/drivers/infiniband/hw/mlx4/cq.c
> +++ b/drivers/infiniband/hw/mlx4/cq.c
> @@ -414,7 +414,8 @@ static void mlx4_ib_cq_resize_copy_cqes(struct mlx4_ib_cq *cq)
>   	++cq->mcq.cons_index;
>   }
>   
> -int mlx4_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata)
> +int mlx4_ib_resize_cq(struct ib_cq *ibcq, unsigned int entries,
> +		      struct ib_udata *udata)
>   {
>   	struct mlx4_ib_dev *dev = to_mdev(ibcq->device);
>   	struct mlx4_ib_cq *cq = to_mcq(ibcq);
> @@ -423,7 +424,7 @@ int mlx4_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata)
>   	int err;
>   
>   	mutex_lock(&cq->resize_mutex);
> -	if (entries < 1 || entries > dev->dev->caps.max_cqes) {
> +	if (entries > dev->dev->caps.max_cqes) {
>   		err = -EINVAL;
>   		goto out;
>   	}
> diff --git a/drivers/infiniband/hw/mlx4/mlx4_ib.h b/drivers/infiniband/hw/mlx4/mlx4_ib.h
> index 6a7ed5225c7db..5a799d6df93eb 100644
> --- a/drivers/infiniband/hw/mlx4/mlx4_ib.h
> +++ b/drivers/infiniband/hw/mlx4/mlx4_ib.h
> @@ -767,7 +767,8 @@ struct ib_mr *mlx4_ib_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
>   int mlx4_ib_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
>   		      unsigned int *sg_offset);
>   int mlx4_ib_modify_cq(struct ib_cq *cq, u16 cq_count, u16 cq_period);
> -int mlx4_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata);
> +int mlx4_ib_resize_cq(struct ib_cq *ibcq, unsigned int entries,
> +		      struct ib_udata *udata);
>   int mlx4_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>   		      struct uverbs_attr_bundle *attrs);
>   int mlx4_ib_create_user_cq(struct ib_cq *ibcq,
> diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
> index 43a7b5ca49dcc..806b4f25af709 100644
> --- a/drivers/infiniband/hw/mlx5/cq.c
> +++ b/drivers/infiniband/hw/mlx5/cq.c
> @@ -1335,7 +1335,8 @@ static int copy_resize_cqes(struct mlx5_ib_cq *cq)
>   	return 0;
>   }
>   
> -int mlx5_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata)
> +int mlx5_ib_resize_cq(struct ib_cq *ibcq, unsigned int entries,
> +		      struct ib_udata *udata)
>   {
>   	struct mlx5_ib_dev *dev = to_mdev(ibcq->device);
>   	struct mlx5_ib_cq *cq = to_mcq(ibcq);
> @@ -1355,13 +1356,8 @@ int mlx5_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata)
>   		return -ENOSYS;
>   	}
>   
> -	if (entries < 1 ||
> -	    entries > (1 << MLX5_CAP_GEN(dev->mdev, log_max_cq_sz))) {
> -		mlx5_ib_warn(dev, "wrong entries number %d, max %d\n",
> -			     entries,
> -			     1 << MLX5_CAP_GEN(dev->mdev, log_max_cq_sz));
> +	if (entries > (1 << MLX5_CAP_GEN(dev->mdev, log_max_cq_sz)))
>   		return -EINVAL;
> -	}
>   
>   	entries = roundup_pow_of_two(entries + 1);
>   	if (entries > (1 << MLX5_CAP_GEN(dev->mdev, log_max_cq_sz)) + 1)
> diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> index 1396bbe45826a..94d1e4f836796 100644
> --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
> +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> @@ -1309,7 +1309,8 @@ int mlx5_ib_pre_destroy_cq(struct ib_cq *cq);
>   void mlx5_ib_post_destroy_cq(struct ib_cq *cq);
>   int mlx5_ib_arm_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags);
>   int mlx5_ib_modify_cq(struct ib_cq *cq, u16 cq_count, u16 cq_period);
> -int mlx5_ib_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata);
> +int mlx5_ib_resize_cq(struct ib_cq *ibcq, unsigned int entries,
> +		      struct ib_udata *udata);
>   struct ib_mr *mlx5_ib_get_dma_mr(struct ib_pd *pd, int acc);
>   struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
>   				  u64 virt_addr, int access_flags,
> diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
> index d81806ef12e53..ca4cc7b9bf2ed 100644
> --- a/drivers/infiniband/hw/mthca/mthca_provider.c
> +++ b/drivers/infiniband/hw/mthca/mthca_provider.c
> @@ -695,7 +695,8 @@ static int mthca_alloc_resize_buf(struct mthca_dev *dev, struct mthca_cq *cq,
>   	return 0;
>   }
>   
> -static int mthca_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *udata)
> +static int mthca_resize_cq(struct ib_cq *ibcq, unsigned int entries,
> +			   struct ib_udata *udata)
>   {
>   	struct mthca_dev *dev = to_mdev(ibcq->device);
>   	struct mthca_cq *cq = to_mcq(ibcq);
> @@ -703,7 +704,7 @@ static int mthca_resize_cq(struct ib_cq *ibcq, int entries, struct ib_udata *uda
>   	u32 lkey;
>   	int ret;
>   
> -	if (entries < 1 || entries > dev->limits.max_cqes)
> +	if (entries > dev->limits.max_cqes)
>   		return -EINVAL;
>   
>   	mutex_lock(&cq->mutex);
> diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
> index eb922b9b00753..ec57807bc417a 100644
> --- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
> +++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
> @@ -1013,18 +1013,16 @@ int ocrdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>   	return status;
>   }
>   
> -int ocrdma_resize_cq(struct ib_cq *ibcq, int new_cnt,
> +int ocrdma_resize_cq(struct ib_cq *ibcq, unsigned int new_cnt,
>   		     struct ib_udata *udata)
>   {
> -	int status = 0;
>   	struct ocrdma_cq *cq = get_ocrdma_cq(ibcq);
>   
> -	if (new_cnt < 1 || new_cnt > cq->max_hw_cqe) {
> -		status = -EINVAL;
> -		return status;
> -	}
> +	if (new_cnt > cq->max_hw_cqe)
> +		return -EINVAL;
> +
>   	ibcq->cqe = new_cnt;
> -	return status;
> +	return 0;
>   }
>   
>   static void ocrdma_flush_cq(struct ocrdma_cq *cq)
> diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
> index 6c5c3755b8a9c..056562d9a01a8 100644
> --- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
> +++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.h
> @@ -71,7 +71,7 @@ int ocrdma_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata);
>   
>   int ocrdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>   		     struct uverbs_attr_bundle *attrs);
> -int ocrdma_resize_cq(struct ib_cq *, int cqe, struct ib_udata *);
> +int ocrdma_resize_cq(struct ib_cq *, unsigned int cqe, struct ib_udata *);
>   int ocrdma_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
>   
>   int ocrdma_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *attrs,
> diff --git a/drivers/infiniband/sw/rdmavt/cq.c b/drivers/infiniband/sw/rdmavt/cq.c
> index e7835ca70e2b2..30904c6ae852d 100644
> --- a/drivers/infiniband/sw/rdmavt/cq.c
> +++ b/drivers/infiniband/sw/rdmavt/cq.c
> @@ -337,7 +337,7 @@ int rvt_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags notify_flags)
>    *
>    * Return: 0 for success.
>    */
> -int rvt_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
> +int rvt_resize_cq(struct ib_cq *ibcq, unsigned int cqe, struct ib_udata *udata)
>   {
>   	struct rvt_cq *cq = ibcq_to_rvtcq(ibcq);
>   	u32 head, tail, n;
> @@ -349,7 +349,7 @@ int rvt_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
>   	struct rvt_k_cq_wc *k_wc = NULL;
>   	struct rvt_k_cq_wc *old_k_wc = NULL;
>   
> -	if (cqe < 1 || cqe > rdi->dparms.props.max_cqe)
> +	if (cqe > rdi->dparms.props.max_cqe)
>   		return -EINVAL;
>   
>   	/*
> diff --git a/drivers/infiniband/sw/rdmavt/cq.h b/drivers/infiniband/sw/rdmavt/cq.h
> index 4028702a7b2fd..82c902c98c8e0 100644
> --- a/drivers/infiniband/sw/rdmavt/cq.h
> +++ b/drivers/infiniband/sw/rdmavt/cq.h
> @@ -13,7 +13,7 @@ int rvt_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>   		  struct uverbs_attr_bundle *attrs);
>   int rvt_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata);
>   int rvt_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags notify_flags);
> -int rvt_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata);
> +int rvt_resize_cq(struct ib_cq *ibcq, unsigned int cqe, struct ib_udata *udata);
>   int rvt_poll_cq(struct ib_cq *ibcq, int num_entries, struct ib_wc *entry);
>   int rvt_driver_cq_init(void);
>   void rvt_cq_exit(void);
> diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
> index fffd144d509eb..eaf7802a5cbe5 100644
> --- a/drivers/infiniband/sw/rxe/rxe_cq.c
> +++ b/drivers/infiniband/sw/rxe/rxe_cq.c
> @@ -8,37 +8,6 @@
>   #include "rxe_loc.h"
>   #include "rxe_queue.h"
>   
> -int rxe_cq_chk_attr(struct rxe_dev *rxe, struct rxe_cq *cq,
> -		    int cqe, int comp_vector)
> -{
> -	int count;
> -
> -	if (cqe <= 0) {
> -		rxe_dbg_dev(rxe, "cqe(%d) <= 0\n", cqe);
> -		goto err1;
> -	}
> -
> -	if (cqe > rxe->attr.max_cqe) {
> -		rxe_dbg_dev(rxe, "cqe(%d) > max_cqe(%d)\n",
> -				cqe, rxe->attr.max_cqe);
> -		goto err1;
> -	}
> -
> -	if (cq) {
> -		count = queue_count(cq->queue, QUEUE_TYPE_TO_CLIENT);
> -		if (cqe < count) {
> -			rxe_dbg_cq(cq, "cqe(%d) < current # elements in queue (%d)\n",
> -					cqe, count);
> -			goto err1;
> -		}
> -	}
> -
> -	return 0;
> -
> -err1:
> -	return -EINVAL;
> -}
> -
>   int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
>   		     int comp_vector, struct ib_udata *udata,
>   		     struct rxe_create_cq_resp __user *uresp)
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index 7992290886e12..e095c12699cb0 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -18,9 +18,6 @@ void rxe_av_fill_ip_info(struct rxe_av *av, struct rdma_ah_attr *attr);
>   struct rxe_av *rxe_get_av(struct rxe_pkt_info *pkt, struct rxe_ah **ahp);
>   
>   /* rxe_cq.c */
> -int rxe_cq_chk_attr(struct rxe_dev *rxe, struct rxe_cq *cq,
> -		    int cqe, int comp_vector);
> -
>   int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
>   		     int comp_vector, struct ib_udata *udata,
>   		     struct rxe_create_cq_resp __user *uresp);
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 2be4fd68276dc..4e5c429aea37e 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -1097,11 +1097,8 @@ static int rxe_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>   		goto err_out;
>   	}
>   
> -	err = rxe_cq_chk_attr(rxe, NULL, attr->cqe, attr->comp_vector);
> -	if (err) {
> -		rxe_dbg_dev(rxe, "bad init attributes, err = %d\n", err);
> -		goto err_out;
> -	}
> +	if (attr->cqe > rxe->attr.max_cqe)
Thanks a lot. I’m fine with compressing the rxe_cq_chk_attr function 
into one or two lines.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Thanks,
Zhu Yanjun

> +		return -EINVAL;
>   
>   	err = rxe_add_to_pool(&rxe->cq_pool, cq);
>   	if (err) {
> @@ -1127,7 +1124,8 @@ static int rxe_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>   	return err;
>   }
>   
> -static int rxe_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
> +static int rxe_resize_cq(struct ib_cq *ibcq, unsigned int cqe,
> +			 struct ib_udata *udata)
>   {
>   	struct rxe_cq *cq = to_rcq(ibcq);
>   	struct rxe_dev *rxe = to_rdev(ibcq->device);
> @@ -1143,11 +1141,9 @@ static int rxe_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
>   		uresp = udata->outbuf;
>   	}
>   
> -	err = rxe_cq_chk_attr(rxe, cq, cqe, 0);
> -	if (err) {
> -		rxe_dbg_cq(cq, "bad attr, err = %d\n", err);
> -		goto err_out;
> -	}
> +	if (cqe > rxe->attr.max_cqe ||
> +	    cqe < queue_count(cq->queue, QUEUE_TYPE_TO_CLIENT))
> +		return -EINVAL;
>   
>   	err = rxe_cq_resize_queue(cq, cqe, uresp, udata);
>   	if (err) {
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index e53c6ed66f34a..9dd76f489a0ba 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -2634,7 +2634,7 @@ struct ib_device_ops {
>   			      struct uverbs_attr_bundle *attrs);
>   	int (*modify_cq)(struct ib_cq *cq, u16 cq_count, u16 cq_period);
>   	int (*destroy_cq)(struct ib_cq *cq, struct ib_udata *udata);
> -	int (*resize_user_cq)(struct ib_cq *cq, int cqe,
> +	int (*resize_user_cq)(struct ib_cq *cq, unsigned int cqe,
>   			      struct ib_udata *udata);
>   	/*
>   	 * pre_destroy_cq - Prevent a cq from generating any new work
> 
> ---
> base-commit: 90b7abe25ce9b8ea6b97c534cb0f037155013bb8
> change-id: 20260319-resize_cq-cqe-a3daa775ca57
> 
> Best regards,
> --
> Leon Romanovsky <leonro@nvidia.com>
> 


