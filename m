Return-Path: <linux-rdma+bounces-14337-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BE5C43B52
	for <lists+linux-rdma@lfdr.de>; Sun, 09 Nov 2025 10:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3F7323476A4
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Nov 2025 09:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022312D3739;
	Sun,  9 Nov 2025 09:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIAolLve"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E37267729
	for <linux-rdma@vger.kernel.org>; Sun,  9 Nov 2025 09:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762681750; cv=none; b=gJiz7tuPPEA1bKKcFo7JUMLl0o2wXPEyR64JAHwbcWf/8SJzP8z6D/IG+VTFz9ykRl/sXOymlz9X8/s/91fwYkkjFOOd6Oj6FdbGS2JYRdHItcCY2MX1FZRfk0ULqrPoaby2ZOdPUlnB/Jv+RNNoILf475hgI+VGbH7gCoR83+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762681750; c=relaxed/simple;
	bh=fJtvNbRLDB2XoFK+VAEuAInonjEFFEY6AUfDB2+wH3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqBfjR3sf16uDaVzLEZhiltrif983QYbTxV7C3Yyi1CkVWyDMD0LC419Ocntopis58Xf1FmeHyZBjTrxvMK4a9Ja8hnn3g2ZZyhZIbi4Kz4PA2WqEeGhZO1/kIW7R3PZAHpdIcr9Alz6kMaM3MNUiWI8UVKnrVAAfqe1Z054iMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIAolLve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01BFC4CEF7;
	Sun,  9 Nov 2025 09:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762681750;
	bh=fJtvNbRLDB2XoFK+VAEuAInonjEFFEY6AUfDB2+wH3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VIAolLvebx8+4SIToWNIoTEMhPegkb9X7rFwje0h8v/M06fNClC+8Uc9fTLzaLOkP
	 kS0ZqdUpG3HDB3/k8XhBHVcM9BtBkGqlzxhF3tIzBwC4NLwguCMv9HgtZ2eMmftT8R
	 xw/ev4vAluatHOO4pBpWEXQF7aiEJlTNcufLjUOiNLRSxP5La7ws7ucKLDDa95et7R
	 rNJKe/zsfQggudUkwIOfkPOL7CPZ4FLkFtrZsJ1P6IODirF92nYpq96XkyD8CVaem7
	 AqX1gcJqT9XEP51kmoYl84pePFHUvkH1nRFyzWPz8+JTyWHK5lxJSmBekERwQ/81++
	 Mj9G3m8NyTc7g==
Date: Sun, 9 Nov 2025 11:49:05 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v2 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
Message-ID: <20251109094905.GH15456@unreal>
References: <20251104072320.210596-1-sriharsha.basavapatna@broadcom.com>
 <20251104072320.210596-5-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104072320.210596-5-sriharsha.basavapatna@broadcom.com>

On Tue, Nov 04, 2025 at 12:53:20PM +0530, Sriharsha Basavapatna wrote:
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
>  drivers/infiniband/hw/bnxt_re/dv.c       | 1208 ++++++++++++++++++++++
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c |   55 +-
>  drivers/infiniband/hw/bnxt_re/ib_verbs.h |   12 +
>  include/uapi/rdma/bnxt_re-abi.h          |   93 ++
>  5 files changed, 1364 insertions(+), 16 deletions(-)

<...>

> +		if (IS_ERR(umem_dmabuf)) {
> +			rc = PTR_ERR(umem_dmabuf);
> +			dev_err(rdev_to_dev(rdev),
> +				"%s: failed to get umem dmabuf : %d\n",
> +				__func__, rc);

All these dev_XXX() lines should go. They can be used before IB device
is created, after that you are invited to use ibdev_XXX() helpers.

> +			goto free_umem;

<...>

> +static void
> +bnxt_re_print_dv_qp_attr(struct bnxt_re_dev *rdev,
> +			 struct bnxt_re_cq *send_cq,
> +			 struct bnxt_re_cq *recv_cq,
> +			 struct  bnxt_re_dv_create_qp_req *req)
> +{
> +	dev_dbg(rdev_to_dev(rdev), "DV_QP_ATTR:\n");
> +	dev_dbg(rdev_to_dev(rdev),
> +		"\t qp_type: 0x%x pdid: 0x%x qp_handle: 0x%llx\n",
> +		req->qp_type, req->pd_id, req->qp_handle);
> +
> +	dev_dbg(rdev_to_dev(rdev), "\t SQ ATTR:\n");
> +	dev_dbg(rdev_to_dev(rdev),
> +		"\t\t max_send_wr: 0x%x max_send_sge: 0x%x\n",
> +		req->max_send_wr, req->max_send_sge);
> +	dev_dbg(rdev_to_dev(rdev),
> +		"\t\t va: 0x%llx len: 0x%x slots: 0x%x wqe_sz: 0x%x\n",
> +		req->sq_va, req->sq_len, req->sq_slots, req->sq_wqe_sz);
> +	dev_dbg(rdev_to_dev(rdev), "\t\t psn_sz: 0x%x npsn: 0x%x\n",
> +		req->sq_psn_sz, req->sq_npsn);
> +	dev_dbg(rdev_to_dev(rdev),
> +		"\t\t send_cq_id: 0x%x\n", send_cq->qplib_cq.id);
> +
> +	dev_dbg(rdev_to_dev(rdev), "\t RQ ATTR:\n");
> +	dev_dbg(rdev_to_dev(rdev),
> +		"\t\t max_recv_wr: 0x%x max_recv_sge: 0x%x\n",
> +		req->max_recv_wr, req->max_recv_sge);
> +	dev_dbg(rdev_to_dev(rdev),
> +		"\t\t va: 0x%llx len: 0x%x slots: 0x%x wqe_sz: 0x%x\n",
> +		req->rq_va, req->rq_len, req->rq_slots, req->rq_wqe_sz);
> +	dev_dbg(rdev_to_dev(rdev),
> +		"\t\t recv_cq_id: 0x%x\n", recv_cq->qplib_cq.id);
> +}

And I afraid that you went too far with debug prints in this patch.
Please remove ALL of them and leave only minimal number of error prints.

Thanks

