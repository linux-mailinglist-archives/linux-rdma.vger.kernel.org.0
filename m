Return-Path: <linux-rdma+bounces-17466-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FHdMe8RqGmzngAAu9opvQ
	(envelope-from <linux-rdma+bounces-17466-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 12:05:19 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F111FEA59
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 12:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5F5B304520F
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2026 11:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BFC39183B;
	Wed,  4 Mar 2026 11:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnkpQ0XW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A702317169;
	Wed,  4 Mar 2026 11:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772622305; cv=none; b=jJTPZFyiz3d5hIVzbjscc2P8W9LPwsHpaMdkj5wmRu6zoRNBZ3vjLHSEP5ngIK2zG8P9GP4tDgBb12Cu+kU9WihHhBxdNjNxrzmtb2U+SKzy/QeTY3Yb0uUaCvAscTSp6ytQpj9sPoikjZ8bThsfv6L96Aw53j7jnFZKqwbWqoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772622305; c=relaxed/simple;
	bh=q3Lt0LWsHaTG1+TF09AJgCyp0woQf0eI+VAXMtvBkH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ce5Q4RRIReCzjDYDdDZ9NfdeTAe3Ikvw21rAFvT61mxVSEUi0NYbEroM4qEoiKRB47+pvYGJT2l51AuodLPl5Lb9y6twjRQxh45m9dhd/SD/i3d+wQn+ntvR6APMal3hPPSqJHgzJrK4V7XpNQ9+90wyR6/dMz0mbezBaHN5kCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnkpQ0XW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D41AC2BC87;
	Wed,  4 Mar 2026 11:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772622305;
	bh=q3Lt0LWsHaTG1+TF09AJgCyp0woQf0eI+VAXMtvBkH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XnkpQ0XWNC5J/LkxoPe5dyosllqFUz10mOkblv4Wic+FICNVPPc2wIAEJWKcTgblw
	 rb1vQlglLb4nNgRlJWvgfWUVINdge9QwQa6qgg5UCEwgOtLoK+F05YIxQ7CUc3yD1u
	 41UO7tyGcTWIp2zjCYMbv27ivCJE8js8bnZVW6x9hI7B00Uwg3raK8W5iskd/S7AX+
	 7ueZ7tsnfJ5Ksy0727z2MhGvJVUXZnyQgfKfCtxuUZ/9ckk+cILP152G2cdkng7bsY
	 7XQ8nu+fx7r36JyZnhnlkjzPEUV8luuv5+ddOCtb5avGSh0dpc8cd7ntdYevN249S5
	 ppliPh0Is3+WQ==
Date: Wed, 4 Mar 2026 13:05:00 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, shirazsaleem@microsoft.com,
	longli@microsoft.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next v2 1/1] RDMA/mana: Provide a modern CQ creation
 interface
Message-ID: <20260304110500.GZ12611@unreal>
References: <20260303124825.301452-1-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303124825.301452-1-kotaranov@linux.microsoft.com>
X-Rspamd-Queue-Id: 24F111FEA59
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17466-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 04:48:25AM -0800, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> The uverbs CQ creation UAPI allows users to supply their own umem for a CQ.
> Update mana to support this workflow while preserving support for creating
> umem through the legacy interface.
> 
> To support RDMA objects that own umem, extend mana_ib_create_queue() to return
> the umem to the caller and do not allocate umem if it was allocted
> by the caller.
> 
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
> v2: It is a rework of the patch proposed by Leon

I am curious to know what changes were introduced?

>  drivers/infiniband/hw/mana/cq.c      | 125 +++++++++++++++++----------
>  drivers/infiniband/hw/mana/device.c  |   1 +
>  drivers/infiniband/hw/mana/main.c    |  30 +++++--
>  drivers/infiniband/hw/mana/mana_ib.h |   5 +-
>  drivers/infiniband/hw/mana/qp.c      |   5 +-
>  drivers/infiniband/hw/mana/wq.c      |   3 +-
>  6 files changed, 111 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
> index b2749f971..fa951732a 100644
> --- a/drivers/infiniband/hw/mana/cq.c
> +++ b/drivers/infiniband/hw/mana/cq.c
> @@ -8,12 +8,8 @@
>  int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>  		      struct uverbs_attr_bundle *attrs)
>  {
> -	struct ib_udata *udata = &attrs->driver_udata;
>  	struct mana_ib_cq *cq = container_of(ibcq, struct mana_ib_cq, ibcq);
> -	struct mana_ib_create_cq_resp resp = {};
> -	struct mana_ib_ucontext *mana_ucontext;
>  	struct ib_device *ibdev = ibcq->device;
> -	struct mana_ib_create_cq ucmd = {};
>  	struct mana_ib_dev *mdev;
>  	bool is_rnic_cq;
>  	u32 doorbell;
> @@ -26,48 +22,91 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>  	cq->cq_handle = INVALID_MANA_HANDLE;
>  	is_rnic_cq = mana_ib_is_rnic(mdev);
>  
> -	if (udata) {
> -		if (udata->inlen < offsetof(struct mana_ib_create_cq, flags))
> -			return -EINVAL;
> -
> -		err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
> -		if (err) {
> -			ibdev_dbg(ibdev, "Failed to copy from udata for create cq, %d\n", err);
> -			return err;
> -		}
> +	if (attr->cqe > U32_MAX / COMP_ENTRY_SIZE / 2 + 1)
> +		return -EINVAL;

We are talking about kernel verbs. ULPs are not designed to provide
attributes and recover from random driver limitations. 

>  
> -		if ((!is_rnic_cq && attr->cqe > mdev->adapter_caps.max_qp_wr) ||
> -		    attr->cqe > U32_MAX / COMP_ENTRY_SIZE) {
> -			ibdev_dbg(ibdev, "CQE %d exceeding limit\n", attr->cqe);
> -			return -EINVAL;
> -		}
> +	buf_size = MANA_PAGE_ALIGN(roundup_pow_of_two(attr->cqe * COMP_ENTRY_SIZE));
> +	cq->cqe = buf_size / COMP_ENTRY_SIZE;
> +	err = mana_ib_create_kernel_queue(mdev, buf_size, GDMA_CQ, &cq->queue);
> +	if (err) {
> +		ibdev_dbg(ibdev, "Failed to create kernel queue for create cq, %d\n", err);
> +		return err;
> +	}
> +	doorbell = mdev->gdma_dev->doorbell;
>  
> -		cq->cqe = attr->cqe;
> -		err = mana_ib_create_queue(mdev, ucmd.buf_addr, cq->cqe * COMP_ENTRY_SIZE,
> -					   &cq->queue);
> +	if (is_rnic_cq) {
> +		err = mana_ib_gd_create_cq(mdev, cq, doorbell);
>  		if (err) {
> -			ibdev_dbg(ibdev, "Failed to create queue for create cq, %d\n", err);
> -			return err;
> +			ibdev_dbg(ibdev, "Failed to create RNIC cq, %d\n", err);
> +			goto err_destroy_queue;
>  		}
>  
> -		mana_ucontext = rdma_udata_to_drv_context(udata, struct mana_ib_ucontext,
> -							  ibucontext);
> -		doorbell = mana_ucontext->doorbell;
> -	} else {
> -		if (attr->cqe > U32_MAX / COMP_ENTRY_SIZE / 2 + 1) {
> -			ibdev_dbg(ibdev, "CQE %d exceeding limit\n", attr->cqe);
> -			return -EINVAL;
> -		}
> -		buf_size = MANA_PAGE_ALIGN(roundup_pow_of_two(attr->cqe * COMP_ENTRY_SIZE));
> -		cq->cqe = buf_size / COMP_ENTRY_SIZE;
> -		err = mana_ib_create_kernel_queue(mdev, buf_size, GDMA_CQ, &cq->queue);
> +		err = mana_ib_install_cq_cb(mdev, cq);
>  		if (err) {
> -			ibdev_dbg(ibdev, "Failed to create kernel queue for create cq, %d\n", err);
> -			return err;
> +			ibdev_dbg(ibdev, "Failed to install cq callback, %d\n", err);
> +			goto err_destroy_rnic_cq;
>  		}
> -		doorbell = mdev->gdma_dev->doorbell;
>  	}
>  
> +	spin_lock_init(&cq->cq_lock);
> +	INIT_LIST_HEAD(&cq->list_send_qp);
> +	INIT_LIST_HEAD(&cq->list_recv_qp);
> +
> +	return 0;
> +
> +err_destroy_rnic_cq:
> +	mana_ib_gd_destroy_cq(mdev, cq);
> +err_destroy_queue:
> +	mana_ib_destroy_queue(mdev, &cq->queue);
> +
> +	return err;
> +}
> +
> +int mana_ib_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
> +			   struct uverbs_attr_bundle *attrs)
> +{
> +	struct mana_ib_cq *cq = container_of(ibcq, struct mana_ib_cq, ibcq);
> +	struct ib_udata *udata = &attrs->driver_udata;
> +	struct mana_ib_create_cq_resp resp = {};
> +	struct mana_ib_ucontext *mana_ucontext;
> +	struct ib_device *ibdev = ibcq->device;
> +	struct mana_ib_create_cq ucmd = {};
> +	struct mana_ib_dev *mdev;
> +	bool is_rnic_cq;
> +	u32 doorbell;
> +	int err;
> +
> +	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
> +
> +	cq->comp_vector = attr->comp_vector % ibdev->num_comp_vectors;
> +	cq->cq_handle = INVALID_MANA_HANDLE;
> +	is_rnic_cq = mana_ib_is_rnic(mdev);
> +
> +	if (udata->inlen < offsetof(struct mana_ib_create_cq, flags))
> +		return -EINVAL;
> +
> +	err = ib_copy_from_udata(&ucmd, udata, min(sizeof(ucmd), udata->inlen));
> +	if (err) {
> +		ibdev_dbg(ibdev, "Failed to copy from udata for create cq, %d\n", err);
> +		return err;
> +	}
> +
> +	if ((!is_rnic_cq && attr->cqe > mdev->adapter_caps.max_qp_wr) ||
> +	    attr->cqe > U32_MAX / COMP_ENTRY_SIZE)
> +		return -EINVAL;
> +
> +	cq->cqe = attr->cqe;
> +	err = mana_ib_create_queue(mdev, ucmd.buf_addr, cq->cqe * COMP_ENTRY_SIZE,
> +				   &cq->queue, &ibcq->umem);
> +	if (err) {
> +		ibdev_dbg(ibdev, "Failed to create queue for create cq, %d\n", err);
> +		return err;
> +	}
> +
> +	mana_ucontext = rdma_udata_to_drv_context(udata, struct mana_ib_ucontext,
> +						  ibucontext);
> +	doorbell = mana_ucontext->doorbell;
> +
>  	if (is_rnic_cq) {
>  		err = mana_ib_gd_create_cq(mdev, cq, doorbell);
>  		if (err) {
> @@ -82,13 +121,11 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>  		}
>  	}
>  
> -	if (udata) {
> -		resp.cqid = cq->queue.id;
> -		err = ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));
> -		if (err) {
> -			ibdev_dbg(&mdev->ib_dev, "Failed to copy to udata, %d\n", err);
> -			goto err_remove_cq_cb;
> -		}
> +	resp.cqid = cq->queue.id;
> +	err = ib_copy_to_udata(udata, &resp, min(sizeof(resp), udata->outlen));
> +	if (err) {
> +		ibdev_dbg(&mdev->ib_dev, "Failed to copy to udata, %d\n", err);
> +		goto err_remove_cq_cb;
>  	}
>  
>  	spin_lock_init(&cq->cq_lock);
> diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
> index ccc2279ca..c5c5fe051 100644
> --- a/drivers/infiniband/hw/mana/device.c
> +++ b/drivers/infiniband/hw/mana/device.c
> @@ -21,6 +21,7 @@ static const struct ib_device_ops mana_ib_dev_ops = {
>  	.alloc_ucontext = mana_ib_alloc_ucontext,
>  	.create_ah = mana_ib_create_ah,
>  	.create_cq = mana_ib_create_cq,
> +	.create_user_cq = mana_ib_create_user_cq,
>  	.create_qp = mana_ib_create_qp,
>  	.create_rwq_ind_table = mana_ib_create_rwq_ind_table,
>  	.create_wq = mana_ib_create_wq,
> diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
> index 8d99cd00f..d1f1e217b 100644
> --- a/drivers/infiniband/hw/mana/main.c
> +++ b/drivers/infiniband/hw/mana/main.c
> @@ -262,33 +262,45 @@ int mana_ib_create_kernel_queue(struct mana_ib_dev *mdev, u32 size, enum gdma_qu
>  }
>  
>  int mana_ib_create_queue(struct mana_ib_dev *mdev, u64 addr, u32 size,
> -			 struct mana_ib_queue *queue)
> +			 struct mana_ib_queue *queue, struct ib_umem **umem)
>  {
> -	struct ib_umem *umem;
>  	int err;
>  
>  	queue->umem = NULL;
>  	queue->id = INVALID_QUEUE_ID;
>  	queue->gdma_region = GDMA_INVALID_DMA_REGION;
>  
> -	umem = ib_umem_get(&mdev->ib_dev, addr, size, IB_ACCESS_LOCAL_WRITE);
> -	if (IS_ERR(umem)) {
> -		ibdev_dbg(&mdev->ib_dev, "Failed to get umem, %pe\n", umem);
> -		return PTR_ERR(umem);
> +	if (umem)
> +		queue->umem = *umem;
> +
> +	if (!queue->umem) {
> +		/* if umem is not provided, allocate it */
> +		queue->umem = ib_umem_get(&mdev->ib_dev, addr, size, IB_ACCESS_LOCAL_WRITE);
> +		if (IS_ERR(queue->umem)) {
> +			ibdev_dbg(&mdev->ib_dev, "Failed to get umem, %pe\n", queue->umem);
> +			return PTR_ERR(queue->umem);
> +		}

I moved this hunk to the callers on purpose. The idea is to call to
ib_umem_get() as early as possible.

>  	}
>  
> -	err = mana_ib_create_zero_offset_dma_region(mdev, umem, &queue->gdma_region);
> +	err = mana_ib_create_zero_offset_dma_region(mdev, queue->umem, &queue->gdma_region);
>  	if (err) {
>  		ibdev_dbg(&mdev->ib_dev, "Failed to create dma region, %d\n", err);
>  		goto free_umem;
>  	}
> -	queue->umem = umem;
>  
>  	ibdev_dbg(&mdev->ib_dev, "created dma region 0x%llx\n", queue->gdma_region);
>  
> +	if (umem) {
> +		/* Give ownership of umem to the caller */
> +		*umem = queue->umem;
> +		queue->umem = NULL;
> +	}
> +
>  	return 0;
>  free_umem:
> -	ib_umem_release(umem);
> +	if (!umem || !(*umem))
> +		/* deallocate mana's umem */
> +		ib_umem_release(queue->umem);

This is another reason why ib_umem_get() shouldn't be buried in the
driver's internals. IB/core is responsible to release it.

Thanks

