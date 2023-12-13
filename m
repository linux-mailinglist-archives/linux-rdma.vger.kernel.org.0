Return-Path: <linux-rdma+bounces-405-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E65A810C42
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Dec 2023 09:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 251D2281988
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Dec 2023 08:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBECC1D68E;
	Wed, 13 Dec 2023 08:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJE0+mZH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86348FBEC
	for <linux-rdma@vger.kernel.org>; Wed, 13 Dec 2023 08:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA9AC433C7;
	Wed, 13 Dec 2023 08:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702455612;
	bh=QIQ/XTYDS89p6IebcbEBZqhnPpmreiXz0XEwj29pYQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VJE0+mZHfPOgjpccoMtC60eHQo58wPS+6FBD8pbzU5W1+bmTCtvdl9WKGonuD2a1v
	 oSuVkjyG7pKxQCAgXw5ZvU43hnGZEkQSMj6tmyOlsGVr3N65E5KmZOIMZ0FiDNgKp6
	 wkW2fgb/6YK1mGkucvelXR5wis6EHyWmaRNPIbsb/y9z778RtF08gPcYB1yGksGOJm
	 FSOKGt3tP8wP0ARUD2LpR6g/rZPztgVrqubeQDFz02tn0WeVuy9Z1Av4h72SQiRFeg
	 zrj+Or8D35sjLHpjQVoBMru0VMrtwsbsrh0IYwI6SM3LfF2MD4pJxqotOetdWQqoB9
	 LtkaGSGtyy6yw==
Date: Wed, 13 Dec 2023 10:20:07 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 2/2] RDMA/bnxt_re: Share a page to expose per CQ
 info with userspace
Message-ID: <20231213082007.GN4870@unreal>
References: <1702438411-23530-1-git-send-email-selvin.xavier@broadcom.com>
 <1702438411-23530-3-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1702438411-23530-3-git-send-email-selvin.xavier@broadcom.com>

On Tue, Dec 12, 2023 at 07:33:31PM -0800, Selvin Xavier wrote:
> Gen P7 adapters needs to share a toggle bits information received
> in kernel driver with the user space. User space needs this
> info during the request notify call back to arm the CQ.
> 
> User space application can get this page using the
> UAPI routines. Library will mmap this page and get the
> toggle bits to be used in the next ARM Doorbell.
> 
> Uses a hash list to map the CQ structure from the CQ ID.
> CQ structure is retrieved from the hash list while the
> library calls the UAPI routine to get the toggle page
> mapping. Currently the full page is mapped per CQ. This
> can be optimized to enable multiple CQs from the same
> application share the same page and different offsets
> in the page.
> 
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/bnxt_re.h   |  3 ++
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 59 +++++++++++++++++++++++++++----
>  drivers/infiniband/hw/bnxt_re/ib_verbs.h  |  2 ++
>  drivers/infiniband/hw/bnxt_re/main.c      | 10 +++++-
>  drivers/infiniband/hw/bnxt_re/qplib_res.h |  6 ++++
>  include/uapi/rdma/bnxt_re-abi.h           |  5 +++
>  6 files changed, 77 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> index 9fd9849..9dca451 100644
> --- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> +++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> @@ -41,6 +41,7 @@
>  #define __BNXT_RE_H__
>  #include <rdma/uverbs_ioctl.h>
>  #include "hw_counters.h"
> +#include <linux/hashtable.h>
>  #define ROCE_DRV_MODULE_NAME		"bnxt_re"
>  
>  #define BNXT_RE_DESC	"Broadcom NetXtreme-C/E RoCE Driver"
> @@ -135,6 +136,7 @@ struct bnxt_re_pacing {
>  #define BNXT_RE_DB_FIFO_ROOM_SHIFT 15
>  #define BNXT_RE_GRC_FIFO_REG_BASE 0x2000
>  
> +#define MAX_CQ_HASH_BITS		(16)
>  struct bnxt_re_dev {
>  	struct ib_device		ibdev;
>  	struct list_head		list;
> @@ -189,6 +191,7 @@ struct bnxt_re_dev {
>  	struct bnxt_re_pacing pacing;
>  	struct work_struct dbq_fifo_check_work;
>  	struct delayed_work dbq_pacing_work;
> +	DECLARE_HASHTABLE(cq_hash, MAX_CQ_HASH_BITS);
>  };
>  
>  #define to_bnxt_re_dev(ptr, member)	\
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> index 76cea30..de3d404 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -50,6 +50,7 @@
>  #include <rdma/ib_mad.h>
>  #include <rdma/ib_cache.h>
>  #include <rdma/uverbs_ioctl.h>
> +#include <linux/hashtable.h>
>  
>  #include "bnxt_ulp.h"
>  
> @@ -2910,14 +2911,20 @@ int bnxt_re_post_recv(struct ib_qp *ib_qp, const struct ib_recv_wr *wr,
>  /* Completion Queues */
>  int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
>  {
> -	struct bnxt_re_cq *cq;
> +	struct bnxt_qplib_chip_ctx *cctx;
>  	struct bnxt_qplib_nq *nq;
>  	struct bnxt_re_dev *rdev;
> +	struct bnxt_re_cq *cq;
>  
>  	cq = container_of(ib_cq, struct bnxt_re_cq, ib_cq);
>  	rdev = cq->rdev;
>  	nq = cq->qplib_cq.nq;
> +	cctx = rdev->chip_ctx;
>  
> +	if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT) {
> +		free_page((unsigned long)cq->uctx_cq_page);
> +		hash_del(&cq->hash_entry);
> +	}
>  	bnxt_qplib_destroy_cq(&rdev->qplib_res, &cq->qplib_cq);
>  	ib_umem_release(cq->umem);
>  
> @@ -2935,10 +2942,11 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>  	struct bnxt_re_ucontext *uctx =
>  		rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext, ib_uctx);
>  	struct bnxt_qplib_dev_attr *dev_attr = &rdev->dev_attr;
> -	int rc, entries;
> -	int cqe = attr->cqe;
> +	struct bnxt_qplib_chip_ctx *cctx;
>  	struct bnxt_qplib_nq *nq = NULL;
>  	unsigned int nq_alloc_cnt;
> +	int rc = -1, entries;

Why -1 and not some -EXXX value?

> +	int cqe = attr->cqe;
>  	u32 active_cqs;
>  
>  	if (attr->flags)
> @@ -2951,6 +2959,7 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>  	}
>  
>  	cq->rdev = rdev;
> +	cctx = rdev->chip_ctx;
>  	cq->qplib_cq.cq_handle = (u64)(unsigned long)(&cq->qplib_cq);
>  
>  	entries = bnxt_re_init_depth(cqe + 1, uctx);
> @@ -3012,8 +3021,16 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>  	spin_lock_init(&cq->cq_lock);
>  
>  	if (udata) {
> -		struct bnxt_re_cq_resp resp;
> -
> +		struct bnxt_re_cq_resp resp = {};
> +
> +		if (cctx->modes.toggle_bits & BNXT_QPLIB_CQ_TOGGLE_BIT) {

This bit is set for all gen_p7 cards, but bnxt_re_cq_resp doesn't have
comp_mask field in old rdma-core and it will cause to ib_copy_to_udata()
fail, isn't it?

> +			hash_add(rdev->cq_hash, &cq->hash_entry, cq->qplib_cq.id);
> +			/* Allocate a page */
> +			cq->uctx_cq_page = (void *)get_zeroed_page(GFP_KERNEL);
> +			if (!cq->uctx_cq_page)
> +				goto c2fail;
> +			resp.comp_mask |= BNXT_RE_CQ_TOGGLE_PAGE_SUPPORT;
> +		}

Thanks

