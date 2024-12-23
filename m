Return-Path: <linux-rdma+bounces-6697-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1999FA8BC
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Dec 2024 01:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E576188550A
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Dec 2024 00:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD752107;
	Mon, 23 Dec 2024 00:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="ODDBOqKp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8681FA4;
	Mon, 23 Dec 2024 00:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734913307; cv=none; b=jqouVXFde0dFGKI5LtGRazoxy6d6Df3zuDgVBqOY7zfFOegMwNH4Vjhuby2gjUSfEOc6knWZKO0+iV6BHJ/5hBT2XMbKIXO+AKG6WMxIzSz9ApHpw/ZrcUC3W7iT/gltlOrFsiecdP2dXiAKxvqdExphSqlqM/KtGwEkF5kJKm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734913307; c=relaxed/simple;
	bh=d8uaJnnShTLNHGMfBAnAG38nksw/X4ydX1MnwXVcZdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lehb0Aj8/+3fH+XLJpy4mMFIDg/e7KDZsa4YkBcMGSGEiL4XESNWA/sB0GThZsHEprXFzNLlZBfmXTZ+3GpYD4n1hSTc4k6yx+STVeT/UWiA1DcHDPdfj7zh5kq85Jo8qVHFUgpInvcaqayfHTL1nOU4vR33vZnSQhV4ycNC8ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=ODDBOqKp; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=nkMMA/IzUV5pMiPbf7b9mp9ltt1QPwhSNOzhTMzDKOM=; b=ODDBOqKpLVoHttVi
	jTP6QtaeeoP3E+eIXOm9nH/362qYhv2b26m2r/OAbOELJ+1GeIM6vexBKnyZC+HShOQfcTq3rIuX3
	gmbgxMvJgutSioD77jtqv0bYXj2U2aKGTyx29ZwswKqTXuh85cq444G4IIbusYD00bMYNRQYD1fGK
	BfxVJ4lD+B7wwk6EXwSVDCtlp9rU9BOCeKmL94aG4wG7DGUuGakWnME4Ax9V4coWyfBh7yucZz9c3
	JDhFisVm7MxRNTgUaNLoECSUM7+4jlqUEZ6w8xuCPnQE1vcd9h8Xs1Fh5tV8qYT7qoYLOpnwpF9Ge
	yJDsFylI2pso7vLE2g==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tPWCb-006nxZ-0I;
	Mon, 23 Dec 2024 00:21:41 +0000
Date: Mon, 23 Dec 2024 00:21:41 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: tatyana.e.nikolova@intel.com, jgg@ziepe.ca, leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/irdma: Remove unused irdma_cqp_*_fpm_val_cmd
 functions
Message-ID: <Z2itFZKLLTdEh0fE@gallifrey>
References: <20241223001613.307138-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241223001613.307138-1-linux@treblig.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 00:20:54 up 228 days, 11:34,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)


Note Mustafa's email address bounces:
  mustafa.ismail@intel.com
    host mgamail.eglb.intel.com [192.198.163.19]
    SMTP error from remote mail server after RCPT TO:<mustafa.ismail@intel.com>:
    550 #5.1.0 Address rejected.

Dave

* linux@treblig.org (linux@treblig.org) wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> irdma_cqp_commit_fpm_val_cmd() and irdma_cqp_query_fpm_val_cmd()
> were added in 2021 by
> commit 915cc7ac0f8e ("RDMA/irdma: Add miscellaneous utility definitions")
> but haven't been used.
> 
> Remove them.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/infiniband/hw/irdma/osdep.h  |  4 --
>  drivers/infiniband/hw/irdma/protos.h |  4 --
>  drivers/infiniband/hw/irdma/utils.c  | 68 ----------------------------
>  3 files changed, 76 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/irdma/osdep.h b/drivers/infiniband/hw/irdma/osdep.h
> index e1e3d3ae72b7..ddf02a462efa 100644
> --- a/drivers/infiniband/hw/irdma/osdep.h
> +++ b/drivers/infiniband/hw/irdma/osdep.h
> @@ -59,10 +59,6 @@ int irdma_cqp_sds_cmd(struct irdma_sc_dev *dev,
>  int irdma_cqp_manage_hmc_fcn_cmd(struct irdma_sc_dev *dev,
>  				 struct irdma_hmc_fcn_info *hmcfcninfo,
>  				 u16 *pmf_idx);
> -int irdma_cqp_query_fpm_val_cmd(struct irdma_sc_dev *dev,
> -				struct irdma_dma_mem *val_mem, u8 hmc_fn_id);
> -int irdma_cqp_commit_fpm_val_cmd(struct irdma_sc_dev *dev,
> -				 struct irdma_dma_mem *val_mem, u8 hmc_fn_id);
>  int irdma_alloc_query_fpm_buf(struct irdma_sc_dev *dev,
>  			      struct irdma_dma_mem *mem);
>  void *irdma_remove_cqp_head(struct irdma_sc_dev *dev);
> diff --git a/drivers/infiniband/hw/irdma/protos.h b/drivers/infiniband/hw/irdma/protos.h
> index d7c8ea948bcd..c0c9441885d3 100644
> --- a/drivers/infiniband/hw/irdma/protos.h
> +++ b/drivers/infiniband/hw/irdma/protos.h
> @@ -85,10 +85,6 @@ int irdma_process_cqp_cmd(struct irdma_sc_dev *dev,
>  int irdma_process_bh(struct irdma_sc_dev *dev);
>  int irdma_cqp_sds_cmd(struct irdma_sc_dev *dev,
>  		      struct irdma_update_sds_info *info);
> -int irdma_cqp_query_fpm_val_cmd(struct irdma_sc_dev *dev,
> -				struct irdma_dma_mem *val_mem, u8 hmc_fn_id);
> -int irdma_cqp_commit_fpm_val_cmd(struct irdma_sc_dev *dev,
> -				 struct irdma_dma_mem *val_mem, u8 hmc_fn_id);
>  int irdma_alloc_query_fpm_buf(struct irdma_sc_dev *dev,
>  			      struct irdma_dma_mem *mem);
>  int irdma_cqp_manage_hmc_fcn_cmd(struct irdma_sc_dev *dev,
> diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
> index 0422787592d8..1ea29994ace3 100644
> --- a/drivers/infiniband/hw/irdma/utils.c
> +++ b/drivers/infiniband/hw/irdma/utils.c
> @@ -971,74 +971,6 @@ void irdma_terminate_del_timer(struct irdma_sc_qp *qp)
>  		irdma_qp_rem_ref(&iwqp->ibqp);
>  }
>  
> -/**
> - * irdma_cqp_query_fpm_val_cmd - send cqp command for fpm
> - * @dev: function device struct
> - * @val_mem: buffer for fpm
> - * @hmc_fn_id: function id for fpm
> - */
> -int irdma_cqp_query_fpm_val_cmd(struct irdma_sc_dev *dev,
> -				struct irdma_dma_mem *val_mem, u8 hmc_fn_id)
> -{
> -	struct irdma_cqp_request *cqp_request;
> -	struct cqp_cmds_info *cqp_info;
> -	struct irdma_pci_f *rf = dev_to_rf(dev);
> -	int status;
> -
> -	cqp_request = irdma_alloc_and_get_cqp_request(&rf->cqp, true);
> -	if (!cqp_request)
> -		return -ENOMEM;
> -
> -	cqp_info = &cqp_request->info;
> -	cqp_request->param = NULL;
> -	cqp_info->in.u.query_fpm_val.cqp = dev->cqp;
> -	cqp_info->in.u.query_fpm_val.fpm_val_pa = val_mem->pa;
> -	cqp_info->in.u.query_fpm_val.fpm_val_va = val_mem->va;
> -	cqp_info->in.u.query_fpm_val.hmc_fn_id = hmc_fn_id;
> -	cqp_info->cqp_cmd = IRDMA_OP_QUERY_FPM_VAL;
> -	cqp_info->post_sq = 1;
> -	cqp_info->in.u.query_fpm_val.scratch = (uintptr_t)cqp_request;
> -
> -	status = irdma_handle_cqp_op(rf, cqp_request);
> -	irdma_put_cqp_request(&rf->cqp, cqp_request);
> -
> -	return status;
> -}
> -
> -/**
> - * irdma_cqp_commit_fpm_val_cmd - commit fpm values in hw
> - * @dev: hardware control device structure
> - * @val_mem: buffer with fpm values
> - * @hmc_fn_id: function id for fpm
> - */
> -int irdma_cqp_commit_fpm_val_cmd(struct irdma_sc_dev *dev,
> -				 struct irdma_dma_mem *val_mem, u8 hmc_fn_id)
> -{
> -	struct irdma_cqp_request *cqp_request;
> -	struct cqp_cmds_info *cqp_info;
> -	struct irdma_pci_f *rf = dev_to_rf(dev);
> -	int status;
> -
> -	cqp_request = irdma_alloc_and_get_cqp_request(&rf->cqp, true);
> -	if (!cqp_request)
> -		return -ENOMEM;
> -
> -	cqp_info = &cqp_request->info;
> -	cqp_request->param = NULL;
> -	cqp_info->in.u.commit_fpm_val.cqp = dev->cqp;
> -	cqp_info->in.u.commit_fpm_val.fpm_val_pa = val_mem->pa;
> -	cqp_info->in.u.commit_fpm_val.fpm_val_va = val_mem->va;
> -	cqp_info->in.u.commit_fpm_val.hmc_fn_id = hmc_fn_id;
> -	cqp_info->cqp_cmd = IRDMA_OP_COMMIT_FPM_VAL;
> -	cqp_info->post_sq = 1;
> -	cqp_info->in.u.commit_fpm_val.scratch = (uintptr_t)cqp_request;
> -
> -	status = irdma_handle_cqp_op(rf, cqp_request);
> -	irdma_put_cqp_request(&rf->cqp, cqp_request);
> -
> -	return status;
> -}
> -
>  /**
>   * irdma_cqp_cq_create_cmd - create a cq for the cqp
>   * @dev: device pointer
> -- 
> 2.47.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

