Return-Path: <linux-rdma+bounces-14330-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCCBC43A8F
	for <lists+linux-rdma@lfdr.de>; Sun, 09 Nov 2025 10:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4C614E1ADB
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Nov 2025 09:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D6D22157B;
	Sun,  9 Nov 2025 09:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USx4PKkL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DDD1A23AC
	for <linux-rdma@vger.kernel.org>; Sun,  9 Nov 2025 09:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762680109; cv=none; b=jAfdmC8yTziPqa2O6DRYEiWQJ9+y12/jYMHmRlO/AR4mu3GTR0ao32Nq0CCGOtLYCk+TzNW6wsuvw1+y+2rSJHg70MYnSsHTw5xbXGAdRJWbuF/k4Xoh3TPMKBEPKlNO0B22hROWxgnWPfb3zfut2zj1gPZhWcX4YgMMwKt4x2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762680109; c=relaxed/simple;
	bh=ROPeb/ZWivbuvRsmHHq/crnADAmT9hqBgIad5D/rDqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWApTV+txid68RIda69bi9D4PRyZYA6K5dKjJIFjSnktVEjDuJeJWO8io3IVNEtUmUrxOpHF/zmpbWd5JwHE2ABttzs8SOtfR/poLQWKAm0embWtL8XzsYrZWQj7JyQ21w5wc5RIOoP8aSmpOaTIKdNZQ7nRXLWjThb3pgGocPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USx4PKkL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C3EC4CEFB;
	Sun,  9 Nov 2025 09:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762680108;
	bh=ROPeb/ZWivbuvRsmHHq/crnADAmT9hqBgIad5D/rDqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=USx4PKkLuA9BZUjT3kLst266bkfHZturLJ2FcovHcwy68reOLTCX6gVt7dmBq2JTP
	 hfgDisVCN+hhroYCy9EHGb5BDD2wRK69L7ts5LvjLaFZ30Uu8FvwfxDRkOFRY4l6OP
	 P+YKABQeLjD29NFF+vZ/265LkD9flYgrM+8Cm+r/f37AgEG+CFeEUTz5XomzBOJ6O/
	 zDq4ESkNNf/vn/Czg0vHC2WGSn0aH5EX38XX4opJCNX7FXhNdVGPGAQ0r1ur0Z9Rt7
	 1y7UhtXpKk0NM+n7BOllokhdiQ1P0oMtH+FdTxABdcSnrtUoLCPC6ARJGzp5GS2JLP
	 2Tjjz0vtHMYuQ==
Date: Sun, 9 Nov 2025 11:21:43 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v2 2/4] RDMA/bnxt_re: Refactor
 bnxt_qplib_create_qp() function
Message-ID: <20251109092143.GG15456@unreal>
References: <20251104072320.210596-1-sriharsha.basavapatna@broadcom.com>
 <20251104072320.210596-3-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104072320.210596-3-sriharsha.basavapatna@broadcom.com>

On Tue, Nov 04, 2025 at 12:53:18PM +0530, Sriharsha Basavapatna wrote:
> From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> 
> Inside bnxt_qplib_create_qp(), driver currently is doing
> a lot of things like allocating HWQ memory for SQ/RQ/ORRQ/IRRQ,
> initializing few of qplib_qp fields etc.
> 
> Refactored the code such that all memory allocation for HWQs
> have been moved to bnxt_re_init_qp_attr() function and inside
> bnxt_qplib_create_qp() function just initialize the request
> structure and issue the HWRM command to firmware.
> 
> Introduced couple of new functions bnxt_re_setup_qp_hwqs() and
> bnxt_re_setup_qp_swqs() moved the hwq and swq memory allocation
> logic there.
> 
> This patch also introduces a change to store the PD id in
> bnxt_qplib_qp. Instead of keeping a pointer to "struct
> bnxt_qplib_pd", store PD id directly in "struct bnxt_qplib_qp".
> This change is needed for a subsequent change in this patch
> series. This PD ID value will be used in new DV implementation
> for create_qp(). There is no functional change.
> 
> Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Reviewed-by: Selvin Thyparampil Xavier <selvin.xavier@broadcom.com>
> Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 207 ++++++++++++--
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 311 +++++++---------------
>  drivers/infiniband/hw/bnxt_re/qplib_fp.h  |  10 +-
>  drivers/infiniband/hw/bnxt_re/qplib_res.h |   6 +
>  4 files changed, 304 insertions(+), 230 deletions(-)

<...>

> +free_umem:
> +	if (uctx)
> +		bnxt_re_qp_free_umem(qp);

<...>

> +	if (udata)
> +		bnxt_re_qp_free_umem(qp);

<...>

Do you need to have if (..) here?
ib_umem_release() does nothing if pointer is NULL.


> +	kfree(sq->swq);
> +	sq->swq = NULL;

Is this SQ reused?

> +	return rc;
> +}

<...>

>  struct bnxt_qplib_qp {
> -	struct bnxt_qplib_pd		*pd;
> +	u32				pd_id;
>  	struct bnxt_qplib_dpi		*dpi;
>  	struct bnxt_qplib_chip_ctx	*cctx;
>  	u64				qp_handle;
> @@ -279,6 +279,7 @@ struct bnxt_qplib_qp {
>  	u8				wqe_mode;
>  	u8				state;
>  	u8				cur_qp_state;
> +	u8				is_user;

This is already known to IB/core, use rdma_is_kernel_res().

Thanks

