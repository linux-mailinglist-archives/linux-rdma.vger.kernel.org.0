Return-Path: <linux-rdma+bounces-2274-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE25E8BC09F
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2024 15:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D47F11C20A7B
	for <lists+linux-rdma@lfdr.de>; Sun,  5 May 2024 13:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1311D540;
	Sun,  5 May 2024 13:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsVKBY5h"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7001BC5C
	for <linux-rdma@vger.kernel.org>; Sun,  5 May 2024 13:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714916771; cv=none; b=nEs+ZpaJK6L/uHQ7RHq4SmI2JLbBBxzzX/8uIq3KATphrHHIDTCORvuvoNbzIa4JCorfZpzBj+6ZZnvV5nyJW9dJrxSxzpHc8RBQVaDJHRQgXshugxlhqFFwTYr2EcVgc/XVHgMgLCqrD/zv/Fh+6etRfyj4nj+q1yKZctQQeV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714916771; c=relaxed/simple;
	bh=/KCXquXntFPjL9eMtDXljtelhz8E6pEjeNQXcFqm7hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEFQOHHaslu5ZWGZXuttsK4G84pPvTVset4cLh4UMo1UhGUYYYKM4gXfD7qNuI4gnvu1xZUc9S1uswes0veWLlRZ9tiHVeb6yE1C50gFqM9xIYdEcRnsm/Bh1Jv/ovG9RyYmUTYJ5n6GymGikLYV+gm1+ChgPDuEsborSu+enJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsVKBY5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B10C113CC;
	Sun,  5 May 2024 13:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714916770;
	bh=/KCXquXntFPjL9eMtDXljtelhz8E6pEjeNQXcFqm7hM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KsVKBY5hAuQuRfgeFUJ9s1IQ+TZyn0/8gXnV93Z2tYT+4AAdQS0DWTHVAQrJYwVaK
	 hHBmyqCqdYMbBB9X4+vaK5VBYxrm6Qwi8wQFC4PrFRYxkB+c6O/EEgDQhAR/365Osx
	 WJqzeJPms25D/CnH9v7U54mCVtfRfU8uNHmOVptUvG2jhfPhRFvxqL27BNRkgMf0gW
	 VC/G9d489RyvAihMyZUUk3TIni02uRrvvrj9N49Y19bfIQHPmtetpnpS9DKHw4XSih
	 n7IS/05HBpbFH/z/Do4sooiLf9M6hNTQisgwPRPhLmk6OoEmd+woCtZnAyL7tAotD5
	 HYNYGVpkuRUyg==
Date: Sun, 5 May 2024 16:46:06 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH for-next 1/2] RDMA/bnxt_re: Allow MSN table capability
 check
Message-ID: <20240505134606.GD68202@unreal>
References: <1714795819-12543-1-git-send-email-selvin.xavier@broadcom.com>
 <1714795819-12543-2-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1714795819-12543-2-git-send-email-selvin.xavier@broadcom.com>

On Fri, May 03, 2024 at 09:10:18PM -0700, Selvin Xavier wrote:
> FW reports the HW capability to use PSN table or MSN table and
> driver/library need to select it based on this capability.
> Use the new capability instead of the older capability check for HW
> retransmission while handling the MSN/PSN table.
> Also, Updated the FW interface structures to handle the new fields.
> 
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 12 ++++++------
>  drivers/infiniband/hw/bnxt_re/qplib_fp.h  |  2 +-
>  drivers/infiniband/hw/bnxt_re/qplib_res.h |  6 ++++++
>  drivers/infiniband/hw/bnxt_re/qplib_sp.c  |  1 +
>  drivers/infiniband/hw/bnxt_re/qplib_sp.h  |  1 +
>  drivers/infiniband/hw/bnxt_re/roce_hsi.h  | 30 +++++++++++++++++++++++++++++-
>  6 files changed, 44 insertions(+), 8 deletions(-)

I have same comment as I gave in rdma-core PR.
It seems like your change will cause to old devices to behave as they
don't have PSN table anymore.

Thanks

> 
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> index 439d0c7..3c961a8 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> @@ -984,7 +984,7 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
>  	u16 nsge;
>  
>  	if (res->dattr)
> -		qp->dev_cap_flags = res->dattr->dev_cap_flags;
> +		qp->is_host_msn_tbl = _is_host_msn_table(res->dattr->dev_cap_flags2);
>  
>  	sq->dbinfo.flags = 0;
>  	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
> @@ -1002,7 +1002,7 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
>  			 sizeof(struct sq_psn_search_ext) :
>  			 sizeof(struct sq_psn_search);
>  
> -		if (BNXT_RE_HW_RETX(qp->dev_cap_flags)) {
> +		if (qp->is_host_msn_tbl) {
>  			psn_sz = sizeof(struct sq_msn_search);
>  			qp->msn = 0;
>  		}
> @@ -1015,7 +1015,7 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
>  	hwq_attr.aux_stride = psn_sz;
>  	hwq_attr.aux_depth = bnxt_qplib_set_sq_size(sq, qp->wqe_mode);
>  	/* Update msn tbl size */
> -	if (BNXT_RE_HW_RETX(qp->dev_cap_flags) && psn_sz) {
> +	if (qp->is_host_msn_tbl && psn_sz) {
>  		hwq_attr.aux_depth = roundup_pow_of_two(bnxt_qplib_set_sq_size(sq, qp->wqe_mode));
>  		qp->msn_tbl_sz = hwq_attr.aux_depth;
>  		qp->msn = 0;
> @@ -1636,7 +1636,7 @@ static void bnxt_qplib_fill_psn_search(struct bnxt_qplib_qp *qp,
>  	if (!swq->psn_search)
>  		return;
>  	/* Handle MSN differently on cap flags  */
> -	if (BNXT_RE_HW_RETX(qp->dev_cap_flags)) {
> +	if (qp->is_host_msn_tbl) {
>  		bnxt_qplib_fill_msn_search(qp, wqe, swq);
>  		return;
>  	}
> @@ -1818,7 +1818,7 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
>  	}
>  
>  	swq = bnxt_qplib_get_swqe(sq, &wqe_idx);
> -	bnxt_qplib_pull_psn_buff(qp, sq, swq, BNXT_RE_HW_RETX(qp->dev_cap_flags));
> +	bnxt_qplib_pull_psn_buff(qp, sq, swq, qp->is_host_msn_tbl);
>  
>  	idx = 0;
>  	swq->slot_idx = hwq->prod;
> @@ -2008,7 +2008,7 @@ int bnxt_qplib_post_send(struct bnxt_qplib_qp *qp,
>  		rc = -EINVAL;
>  		goto done;
>  	}
> -	if (!BNXT_RE_HW_RETX(qp->dev_cap_flags) || msn_update) {
> +	if (!qp->is_host_msn_tbl || msn_update) {
>  		swq->next_psn = sq->psn & BTH_PSN_MASK;
>  		bnxt_qplib_fill_psn_search(qp, wqe, swq);
>  	}
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
> index 7fd4506..5b8d097 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
> @@ -340,7 +340,7 @@ struct bnxt_qplib_qp {
>  	struct list_head		rq_flush;
>  	u32				msn;
>  	u32				msn_tbl_sz;
> -	u16				dev_cap_flags;
> +	u16				is_host_msn_tbl;
>  };
>  
>  #define BNXT_QPLIB_MAX_CQE_ENTRY_SIZE	sizeof(struct cq_base)
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
> index 61628f7..a0f78cd 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
> @@ -554,6 +554,12 @@ static inline bool _is_hw_retx_supported(u16 dev_cap_flags)
>  
>  #define BNXT_RE_HW_RETX(a) _is_hw_retx_supported((a))
>  
> +static inline bool _is_host_msn_table(u16 dev_cap_ext_flags2)
> +{
> +	return (dev_cap_ext_flags2 & CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_MASK) ==
> +		CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_HOST_MSN_TABLE;
> +}
> +
>  static inline u8 bnxt_qplib_dbr_pacing_en(struct bnxt_qplib_chip_ctx *cctx)
>  {
>  	return cctx->modes.dbr_pacing;
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> index 8beeedd..9328db9 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
> @@ -156,6 +156,7 @@ int bnxt_qplib_get_dev_attr(struct bnxt_qplib_rcfw *rcfw,
>  				    (0x01 << RCFW_DBR_BASE_PAGE_SHIFT);
>  	attr->max_sgid = BNXT_QPLIB_NUM_GIDS_SUPPORTED;
>  	attr->dev_cap_flags = le16_to_cpu(sb->dev_cap_flags);
> +	attr->dev_cap_flags2 = le16_to_cpu(sb->dev_cap_ext_flags_2);
>  
>  	bnxt_qplib_query_version(rcfw, attr->fw_ver);
>  
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
> index d33c78b..16a67d7 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
> @@ -72,6 +72,7 @@ struct bnxt_qplib_dev_attr {
>  	u8				tqm_alloc_reqs[MAX_TQM_ALLOC_REQ];
>  	bool				is_atomic;
>  	u16                             dev_cap_flags;
> +	u16                             dev_cap_flags2;
>  	u32                             max_dpi;
>  };
>  
> diff --git a/drivers/infiniband/hw/bnxt_re/roce_hsi.h b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
> index 605c946..0425309 100644
> --- a/drivers/infiniband/hw/bnxt_re/roce_hsi.h
> +++ b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
> @@ -2157,8 +2157,36 @@ struct creq_query_func_resp_sb {
>  	__le32	tqm_alloc_reqs[12];
>  	__le32	max_dpi;
>  	u8	max_sge_var_wqe;
> -	u8	reserved_8;
> +	u8	dev_cap_ext_flags;
> +	#define CREQ_QUERY_FUNC_RESP_SB_ATOMIC_OPS_NOT_SUPPORTED         0x1UL
> +	#define CREQ_QUERY_FUNC_RESP_SB_DRV_VERSION_RGTR_SUPPORTED       0x2UL
> +	#define CREQ_QUERY_FUNC_RESP_SB_CREATE_QP_BATCH_SUPPORTED        0x4UL
> +	#define CREQ_QUERY_FUNC_RESP_SB_DESTROY_QP_BATCH_SUPPORTED       0x8UL
> +	#define CREQ_QUERY_FUNC_RESP_SB_ROCE_STATS_EXT_CTX_SUPPORTED     0x10UL
> +	#define CREQ_QUERY_FUNC_RESP_SB_CREATE_SRQ_SGE_SUPPORTED         0x20UL
> +	#define CREQ_QUERY_FUNC_RESP_SB_FIXED_SIZE_WQE_DISABLED          0x40UL
> +	#define CREQ_QUERY_FUNC_RESP_SB_DCN_SUPPORTED                    0x80UL
>  	__le16	max_inline_data_var_wqe;
> +	__le32	start_qid;
> +	u8	max_msn_table_size;
> +	u8	reserved8_1;
> +	__le16	dev_cap_ext_flags_2;
> +	#define CREQ_QUERY_FUNC_RESP_SB_OPTIMIZE_MODIFY_QP_SUPPORTED             0x1UL
> +	#define CREQ_QUERY_FUNC_RESP_SB_CHANGE_UDP_SRC_PORT_WQE_SUPPORTED        0x2UL
> +	#define CREQ_QUERY_FUNC_RESP_SB_CQ_COALESCING_SUPPORTED                  0x4UL
> +	#define CREQ_QUERY_FUNC_RESP_SB_MEMORY_REGION_RO_SUPPORTED               0x8UL
> +	#define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_MASK          0x30UL
> +	#define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_SFT           4
> +	#define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_HOST_PSN_TABLE  (0x0UL << 4)
> +	#define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_HOST_MSN_TABLE  (0x1UL << 4)
> +	#define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_IQM_MSN_TABLE   (0x2UL << 4)
> +	#define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_LAST	\
> +			CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_IQM_MSN_TABLE
> +	__le16	max_xp_qp_size;
> +	__le16	create_qp_batch_size;
> +	__le16	destroy_qp_batch_size;
> +	__le16	reserved16;
> +	__le64	reserved64;
>  };
>  
>  /* cmdq_set_func_resources (size:448b/56B) */
> -- 
> 2.5.5
> 



