Return-Path: <linux-rdma+bounces-14388-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD0CC4D51F
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 12:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A33A24FC1FC
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 11:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EDD354AC7;
	Tue, 11 Nov 2025 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/ZrYwQT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46154354AC0
	for <linux-rdma@vger.kernel.org>; Tue, 11 Nov 2025 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858814; cv=none; b=gqBMuFxhxPSbr/NI354O2k4H+G4ixFBq+VESTkGnpbwzm9nI/WR3hwKdIt/vLd6++KSvtFFOafKYSWwQIKRkVj3GCdpA+6qC//pac/jVLCugglftNMoKYPFkyDLFj2PEY2tyihh/D7/DPBKVHHkvTM1vfQEJdJh6UyCH0mKmJSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858814; c=relaxed/simple;
	bh=+ZoS79ptAwCPUYgpl8+YMAn1XHaNgkP4WAOsjVI8vPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkTYIItv+mBxSk3Qv0wuvtRAyE/7mRvlXDmFb0kUZHxw8gm76By4ui1XAlWzj4qW9/0fTD12G/nizcV7p7J8PcLdcL4kJdROZ5ARSTA6z54yatSymSanuFGzk3K8SXGZEnL9t5Hvxycn232MwAYVXm7wKPGUpF5Jbvtqg+0uLd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/ZrYwQT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A32C116D0;
	Tue, 11 Nov 2025 11:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762858813;
	bh=+ZoS79ptAwCPUYgpl8+YMAn1XHaNgkP4WAOsjVI8vPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I/ZrYwQTj+SOzzvnAEVht35xsbIShhh9qvWlLdZ4JoyYwKA1WxHK3QXJptMTxREFu
	 f5XQEzCTa80BEcoAQ0jmCKQqkw8cZVvoCXKnPyoWV8xz51rECgJS1nX842/zPG332u
	 FkvGzHGZhbjjsP9F3RR28RH5XR/FXLJGK8aJYCuPBlpg9OaWOk26dt9Ew2dK86ZfHg
	 Sl+1QVr0tWt46ue8TE8qotlmIkrWF1DH/RgLhGZW3M8be/gajcuPm19ZsRQ06/Fow8
	 ku2fY99F/qnar8swEAM09ps32Tb018Dj8s+4+qpAcyCYxJZz1ewWkBaEjXdkRbsSu0
	 RwAQfbnVnY2QA==
Date: Tue, 11 Nov 2025 13:00:09 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v3 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
Message-ID: <20251111110009.GN15456@unreal>
References: <20251110145628.290296-1-sriharsha.basavapatna@broadcom.com>
 <20251110145628.290296-5-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110145628.290296-5-sriharsha.basavapatna@broadcom.com>

On Mon, Nov 10, 2025 at 08:26:28PM +0530, Sriharsha Basavapatna wrote:
> The following Direct Verb (DV) methods have been implemented in
> this patch.
> 
> CQ Direct Verbs:
> ----------------
> - BNXT_RE_METHOD_DV_CREATE_CQ:
>   Create a CQ of requested size (cqe). The application must have
>   already registered this memory with the driver using DV_UMEM_REG.
>   The CQ umem-handle and umem-offset are passed to the driver. The
>   driver now maps/pins the CQ user memory and registers it with the
>   hardware. The driver returns a CQ-handle to the application.
> 
> - BNXT_RE_METHOD_DV_DESTROY_CQ:
>   Destroy the DV_CQ specified by the CQ-handle; unmap the user memory.
> 
> QP Direct Verbs:
> ----------------
> - BNXT_RE_METHOD_DV_CREATE_QP:
>   Create a QP using specified params (struct bnxt_re_dv_create_qp_req).
>   The application must have already registered SQ/RQ memory with the
>   driver using DV_UMEM_REG. The SQ/RQ umem-handle and umem-offset are
>   passed to the driver. The driver now maps/pins the SQ/RQ user memory
>   and registers it with the hardware. The driver returns a QP-handle to
>   the application.
> 
> - BNXT_RE_METHOD_DV_DESTROY_QP:
>   Destroy the DV_QP specified by the QP-handle; unmap SQ/RQ user memory.
> 
> - BNXT_RE_METHOD_DV_MODIFY_QP:
>   Modify QP attributes for the DV_QP specified by the QP-handle;
>   wrapper functions have been implemented to resolve dmac/smac using
>   rdma_resolve_ip().
> 
> - BNXT_RE_METHOD_DV_QUERY_QP:
>   Return QP attributes for the DV_QP specified by the QP-handle.
> 
> Note:
> -----
> Some applications might want to allocate memory for all resources of a
> given type (CQ/QP) in one big chunk and then register that entire memory
> once using DV_UMEM_REG. At the time of creating each individual
> resource, the application would pass a specific offset/length in the
> umem registered memory.
> 
> - The DV_UMEM_REG handler (previous patch) only creates a dv_umem object
>   and saves user memory parameters, but doesn't really map/pin this
>   memory.
> - The mapping would be done at the time of creating individual objects.
> - This actual mapping of specific umem offsets is implemented by the
>   function bnxt_re_dv_umem_get(). This function validates the
>   umem-offset and size parameters passed during CQ/QP creation. If the
>   request is valid, it maps the specified offset/length within the umem
>   registered memory.
> - The CQ and QP creation DV handlers call bnxt_re_dv_umem_get() to map
>   offsets/sizes specific to each individual object. This means each
>   object gets its own mapped dv_umem object that is distinct from the
>   main dv_umem object created during DV_UMEM_REG.
> - The object specific dv_umem is unmapped when the object is destroyed.
> 
> Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
> Co-developed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Co-developed-by: Selvin Xavier <selvin.xavier@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/bnxt_re.h  |   12 +-
>  drivers/infiniband/hw/bnxt_re/dv.c       | 1071 ++++++++++++++++++++++
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c |   55 +-
>  drivers/infiniband/hw/bnxt_re/ib_verbs.h |   12 +
>  include/uapi/rdma/bnxt_re-abi.h          |   93 ++
>  5 files changed, 1227 insertions(+), 16 deletions(-)

<...>

> +enum {
> +	BNXT_RE_DV_RES_TYPE_QP = 0,

There is no need to set BNXT_RE_DV_RES_TYPE_QP to 0, all enums start
from 0 in C.

> +	BNXT_RE_DV_RES_TYPE_CQ,
> +	BNXT_RE_DV_RES_TYPE_MAX
> +};
> +
>  struct bnxt_re_dev {
>  	struct ib_device		ibdev;
>  	struct list_head		list;
> @@ -231,6 +237,8 @@ struct bnxt_re_dev {
>  	union ib_gid ugid;
>  	u32 ugid_index;
>  	u8 sniffer_flow_created : 1;
> +	atomic_t		dv_cq_count;
> +	atomic_t		dv_qp_count;
>  };
>  
>  #define to_bnxt_re_dev(ptr, member)	\
> @@ -274,6 +282,9 @@ static inline int bnxt_re_read_context_allowed(struct bnxt_re_dev *rdev)
>  	return 0;
>  }
>  
> +struct bnxt_qplib_nq *bnxt_re_get_nq(struct bnxt_re_dev *rdev);
> +void bnxt_re_put_nq(struct bnxt_re_dev *rdev, struct bnxt_qplib_nq *nq);
> +
>  #define BNXT_RE_CONTEXT_TYPE_QPC_SIZE_P5	1088
>  #define BNXT_RE_CONTEXT_TYPE_CQ_SIZE_P5		128
>  #define BNXT_RE_CONTEXT_TYPE_MRW_SIZE_P5	128
> @@ -286,5 +297,4 @@ static inline int bnxt_re_read_context_allowed(struct bnxt_re_dev *rdev)
>  
>  #define BNXT_RE_HWRM_CMD_TIMEOUT(rdev)		\
>  		((rdev)->chip_ctx->hwrm_cmd_max_timeout * 1000)
> -
>  #endif
> diff --git a/drivers/infiniband/hw/bnxt_re/dv.c b/drivers/infiniband/hw/bnxt_re/dv.c
> index 1485aa0a6818..100e18d07f51 100644
> --- a/drivers/infiniband/hw/bnxt_re/dv.c
> +++ b/drivers/infiniband/hw/bnxt_re/dv.c
> @@ -14,6 +14,7 @@
>  #include <rdma/uverbs_named_ioctl.h>
>  #include <rdma/ib_umem.h>
>  #include <rdma/bnxt_re-abi.h>
> +#include <rdma/ib_cache.h>
>  
>  #include "roce_hsi.h"
>  #include "qplib_res.h"
> @@ -379,6 +380,76 @@ static int bnxt_re_dv_validate_umem_attr(struct bnxt_re_dev *rdev,
>  	return 0;
>  }
>  
> +static bool bnxt_re_dv_is_valid_umem(struct bnxt_re_dv_umem *umem,
> +				     u64 offset, u32 size)
> +{
> +	return ((offset == ALIGN(offset, PAGE_SIZE)) &&
> +		(offset + size <= umem->size));
> +}
> +
> +static struct bnxt_re_dv_umem *bnxt_re_dv_umem_get(struct bnxt_re_dev *rdev,
> +						   struct ib_ucontext *ib_uctx,
> +						   struct bnxt_re_dv_umem *obj,
> +						   u64 umem_offset, u64 size,
> +						   struct bnxt_qplib_sg_info *sg)
> +{
> +	struct bnxt_re_dv_umem *dv_umem;
> +	struct ib_umem *umem;
> +	int umem_pgs, rc;
> +
> +	if (!bnxt_re_dv_is_valid_umem(obj, umem_offset, size))
> +		return ERR_PTR(-EINVAL);

I wonder why do you need this check. Will it be better to rely on
ib_umem_*_get() interfaces for these checks and slightly change code
to perform dv_umem = kzalloc(...) after that?

> +
> +	dv_umem = kzalloc(sizeof(*dv_umem), GFP_KERNEL);
> +	if (!dv_umem)
> +		return ERR_PTR(-ENOMEM);
> +
> +	dv_umem->addr = obj->addr + umem_offset;
> +	dv_umem->size = size;
> +	dv_umem->rdev = obj->rdev;
> +	dv_umem->dmabuf_fd = obj->dmabuf_fd;
> +	dv_umem->access = obj->access;
> +
> +	if (obj->dmabuf_fd) {
> +		struct ib_umem_dmabuf *umem_dmabuf;
> +
> +		umem_dmabuf = ib_umem_dmabuf_get_pinned(&rdev->ibdev, dv_umem->addr,
> +							dv_umem->size, dv_umem->dmabuf_fd,
> +							dv_umem->access);
> +		if (IS_ERR(umem_dmabuf)) {
> +			rc = PTR_ERR(umem_dmabuf);
> +			goto free_umem;
> +		}
> +		umem = &umem_dmabuf->umem;
> +	} else {
> +		umem = ib_umem_get(&rdev->ibdev, (unsigned long)dv_umem->addr,
> +				   dv_umem->size, dv_umem->access);
> +		if (IS_ERR(umem)) {
> +			rc = PTR_ERR(umem);
> +			goto free_umem;
> +		}
> +	}
> +
> +	dv_umem->umem = umem;
> +
> +	umem_pgs = ib_umem_num_dma_blocks(umem, PAGE_SIZE);
> +	if (!umem_pgs) {
> +		rc = -EINVAL;
> +		goto rel_umem;
> +	}
> +	sg->npages = ib_umem_num_dma_blocks(umem, PAGE_SIZE);

You already calculated it, exactly 4 lines above.

> +	sg->pgshft = PAGE_SHIFT;
> +	sg->pgsize = PAGE_SIZE;
> +	sg->umem = umem;
> +	return dv_umem;

<...>

> +	if (atomic_read(&rdev->stats.res.cq_count) >= dev_attr->max_cq) {
> +		ibdev_err(&rdev->ibdev, "Create CQ failed - max exceeded(CQs)");

User can trigger this error and fill dmesg. If you want to keep it, move
to be debug print.

> +		return NULL;
> +	}
> +
> +	/* Validate CQ fields */
> +	if (cqe < 1 || cqe > dev_attr->max_cq_wqes) {
> +		ibdev_err(&rdev->ibdev, "Create CQ failed - max exceeded(CQ_WQs)");

Same

> +		return NULL;
> +	}

<...>

> +	atomic_inc(&rdev->stats.res.cq_count);
> +	max_active_cqs = atomic_read(&rdev->stats.res.cq_count);

atomic_inc_return(&rdev->stats.res.cq_count);

> +	if (max_active_cqs > rdev->stats.res.cq_watermark)
> +		rdev->stats.res.cq_watermark = max_active_cqs;
> +	spin_lock_init(&cq->cq_lock);

<...>

> +static int bnxt_re_dv_uverbs_copy_to(struct bnxt_re_dev *rdev,
> +				     struct uverbs_attr_bundle *attrs,
> +				     int attr, void *from, size_t size)
> +{
> +	return uverbs_copy_to_struct_or_zero(attrs, attr, from, size);
> +}
> +

Please don't wrap basic functions.

> +static void bnxt_re_dv_finalize_uobj(struct ib_uobject *uobj, void *priv_obj,
> +				     struct uverbs_attr_bundle *attrs, int attr)
> +{
> +	uobj->object = priv_obj;
> +	uverbs_finalize_uobj_create(attrs, attr);
> +}

Same

> +

<...>

> +	dv_umem = bnxt_re_dv_umem_get(rdev, context, sq_umem,
> +				      init_attr->sq_umem_offset,
> +				      init_attr->sq_len, sginfo);
> +	if (IS_ERR(dv_umem)) {
> +		rc = PTR_ERR(dv_umem);
> +		ibdev_dbg(&rdev->ibdev, "%s: bnxt_re_dv_umem_get() failed, rc: %d\n",
> +			  __func__, rc);

Please remove __func__ prints.

> +		return rc;
> +	}
> +	qp->sq_umem = dv_umem;
> +	qp->sumem = dv_umem->umem;

<...>

> +static void
> +bnxt_re_dv_qp_init_msn(struct bnxt_re_qp *qp,
> +		       struct bnxt_re_dv_create_qp_req *req)
> +{
> +	struct bnxt_qplib_qp *qplib_qp = &qp->qplib_qp;
> +
> +	qplib_qp->is_host_msn_tbl = true;
> +	qplib_qp->msn = 0;
> +	qplib_qp->psn_sz = req->sq_psn_sz;
> +	qplib_qp->msn_tbl_sz = req->sq_psn_sz * req->sq_npsn;

Did you check that it can't overflow?

> +}

<...>

> +static int bnxt_re_dv_free_qp(struct ib_uobject *uobj,
> +			      enum rdma_remove_reason why,
> +			      struct uverbs_attr_bundle *attrs)
> +{
> +	struct bnxt_re_qp *qp = uobj->object;
> +	struct bnxt_re_dev *rdev = qp->rdev;
> +	struct bnxt_qplib_qp *qplib_qp = &qp->qplib_qp;
> +	struct bnxt_qplib_nq *scq_nq = NULL;
> +	struct bnxt_qplib_nq *rcq_nq = NULL;
> +	int rc;
> +
> +	mutex_lock(&rdev->qp_lock);
> +	list_del(&qp->list);
> +	atomic_dec_return(&rdev->stats.res.qp_count);

atomic_dec()

> +	if (qp->qplib_qp.type == CMDQ_CREATE_QP_TYPE_RC)
> +		atomic_dec(&rdev->stats.res.rc_qp_count);
> +	mutex_unlock(&rdev->qp_lock);

<...>

> +static void bnxt_re_copyout_ah_attr(struct ib_uverbs_ah_attr *dattr,
> +				    struct rdma_ah_attr *sattr)
> +{
> +	dattr->sl               = sattr->sl;

Please don't do vertical alignment.

> +	memcpy(dattr->grh.dgid, &sattr->grh.dgid, 16);
> +	dattr->grh.flow_label = sattr->grh.flow_label;
> +	dattr->grh.hop_limit = sattr->grh.hop_limit;
> +	dattr->grh.sgid_index = sattr->grh.sgid_index;
> +	dattr->grh.traffic_class = sattr->grh.traffic_class;
> +}
> +
> +static void bnxt_re_dv_copy_qp_attr_out(struct bnxt_re_dev *rdev,
> +					struct ib_uverbs_qp_attr *out,
> +					struct ib_qp_attr *qp_attr,
> +					struct ib_qp_init_attr *qp_init_attr)
> +{
> +	out->qp_state = qp_attr->qp_state;
> +	out->cur_qp_state = qp_attr->cur_qp_state;
> +	out->path_mtu = qp_attr->path_mtu;
> +	out->path_mig_state = qp_attr->path_mig_state;
> +	out->qkey = qp_attr->qkey;
> +	out->rq_psn = qp_attr->rq_psn;
> +	out->sq_psn = qp_attr->sq_psn;
> +	out->dest_qp_num = qp_attr->dest_qp_num;
> +	out->qp_access_flags = qp_attr->qp_access_flags;
> +	out->max_send_wr = qp_attr->cap.max_send_wr;
> +	out->max_recv_wr = qp_attr->cap.max_recv_wr;
> +	out->max_send_sge = qp_attr->cap.max_send_sge;
> +	out->max_recv_sge = qp_attr->cap.max_recv_sge;
> +	out->max_inline_data = qp_attr->cap.max_inline_data;
> +	out->pkey_index = qp_attr->pkey_index;
> +	out->alt_pkey_index = qp_attr->alt_pkey_index;
> +	out->en_sqd_async_notify = qp_attr->en_sqd_async_notify;
> +	out->sq_draining = qp_attr->sq_draining;
> +	out->max_rd_atomic = qp_attr->max_rd_atomic;
> +	out->max_dest_rd_atomic = qp_attr->max_dest_rd_atomic;
> +	out->min_rnr_timer = qp_attr->min_rnr_timer;
> +	out->port_num = qp_attr->port_num;
> +	out->timeout = qp_attr->timeout;
> +	out->retry_cnt = qp_attr->retry_cnt;
> +	out->rnr_retry = qp_attr->rnr_retry;
> +	out->alt_port_num = qp_attr->alt_port_num;
> +	out->alt_timeout = qp_attr->alt_timeout;
> +
> +	bnxt_re_copyout_ah_attr(&out->ah_attr, &qp_attr->ah_attr);
> +	bnxt_re_copyout_ah_attr(&out->alt_ah_attr, &qp_attr->alt_ah_attr);
> +}

Why do you need to open-code existing ib_uverbs_query_qp()? I afraid
that this in-driver prone to errors.

> +

<...>

> +	uobj = uverbs_attr_get_uobject(attrs, BNXT_RE_DV_QUERY_QP_HANDLE);

You should check that uobj is not an error.

> +	qp = uobj->object;

<...>

> +static int bnxt_re_dv_copy_qp_attr(struct bnxt_re_dev *rdev,
> +				   struct ib_qp_attr *dst,
> +				   struct ib_uverbs_qp_attr *src)
> +{
> +	int rc;
> +
> +	if (src->qp_attr_mask & IB_QP_ALT_PATH)
> +		return -EINVAL;
> +
> +	dst->qp_state           = src->qp_state;
> +	dst->cur_qp_state       = src->cur_qp_state;
> +	dst->path_mtu           = src->path_mtu;
> +	dst->path_mig_state     = src->path_mig_state;
> +	dst->qkey               = src->qkey;
> +	dst->rq_psn             = src->rq_psn;
> +	dst->sq_psn             = src->sq_psn;
> +	dst->dest_qp_num        = src->dest_qp_num;
> +	dst->qp_access_flags    = src->qp_access_flags;
> +
> +	dst->cap.max_send_wr        = src->max_send_wr;
> +	dst->cap.max_recv_wr        = src->max_recv_wr;
> +	dst->cap.max_send_sge       = src->max_send_sge;
> +	dst->cap.max_recv_sge       = src->max_recv_sge;
> +	dst->cap.max_inline_data    = src->max_inline_data;
> +
> +	if (src->qp_attr_mask & IB_QP_AV) {
> +		rc = bnxt_re_copyin_ah_attr(&rdev->ibdev, &dst->ah_attr,
> +					    &src->ah_attr);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	dst->pkey_index         = src->pkey_index;
> +	dst->alt_pkey_index     = src->alt_pkey_index;
> +	dst->en_sqd_async_notify = src->en_sqd_async_notify;
> +	dst->sq_draining        = src->sq_draining;
> +	dst->max_rd_atomic      = src->max_rd_atomic;
> +	dst->max_dest_rd_atomic = src->max_dest_rd_atomic;
> +	dst->min_rnr_timer      = src->min_rnr_timer;
> +	dst->port_num           = src->port_num;
> +	dst->timeout            = src->timeout;
> +	dst->retry_cnt          = src->retry_cnt;
> +	dst->rnr_retry          = src->rnr_retry;
> +	dst->alt_port_num       = src->alt_port_num;
> +	dst->alt_timeout        = src->alt_timeout;
> +
> +	return 0;
> +}

Again open-code variant of existing IB/core function.

> +
> +static int bnxt_re_dv_modify_qp(struct ib_uobject *uobj,
> +				struct uverbs_attr_bundle *attrs)
> +{

I'm starting to believe that this DV QP interface is not right thing to
do. I would expect DV to be for extra parameters on top of existing
basic QP infrastructure.

Thanks

