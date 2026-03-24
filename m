Return-Path: <linux-rdma+bounces-18546-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MIWBvDdwWnxXQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18546-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 01:42:24 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5902FFDE6
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 01:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D64FC3087EAF
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 00:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3584630B51D;
	Tue, 24 Mar 2026 00:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvbZtirt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E912524BBF0;
	Tue, 24 Mar 2026 00:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774312797; cv=none; b=Asl7rq1gcebyae15zha1ZJi0Mm5bqPToKyE0SfnCtKUUeDA9o3dFXtoTJo82co+1mVH9LgL2PIWj8MHxSdcxGF5zrRRQLgm2hXh/bRqIB2EdZXZaPI41+CPqOfbOs/4YkMglyh4gf5nxtZlwu2WZDGIGC4MS+zhqrcYNC676CvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774312797; c=relaxed/simple;
	bh=QjDO1u3tuu+DLUdsm+IoGRajW5P/NFNjR0ZmLm0KHdM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jt/ltbFg4qLA6qaF0wYNtGYCwq/LwX2TkumY/xeRLotg6gM8sR2YtZWdeMTAJZYtMc8hCP11+XiQWGgSSXhSOiW5m4VBJPE4sRu7SPJRScKCT2iHGALpfSHjn20tMZuLmmaWzG3RZH36MtbQD5pUx11pBKMhBkUFerQVXoRSvkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvbZtirt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2CEC4CEF7;
	Tue, 24 Mar 2026 00:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774312796;
	bh=QjDO1u3tuu+DLUdsm+IoGRajW5P/NFNjR0ZmLm0KHdM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rvbZtirtWQcmgmdy0Gi61uqKYp5ygwRGU5IhMcYHSjn9Z/BMtIM9Fw6tNWFdb7un8
	 r1uCd/E637Y8y2gDEoJCf2FpcIT7xnLg13kjNZZIYTeSd0Z7TzEqrKok7z6bIDAETn
	 k3c687wTm/zZ7gZ5szV5krgXG5e1NovrkA45bBpkyRw60rmP5w0Y0Mq6lkMfUgRNdW
	 9abpHVuRuknCPwXs1tpBEMkKAVHeNYdnuxpefASgPht+OaFFymn3Y23ZIqWKAL6hGc
	 ouRP62NxrLGanHvAuWYKrRLNycqCmLOFqS492ZBjYi7vlmyKFHof2m10q33EfUQSq/
	 BJXWmKG6vKEBA==
Date: Mon, 23 Mar 2026 17:39:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe
 Shemesh <moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next 3/3] net/mlx5e: Speed up channel creation by
 initializing MKEY entries via UMR WQE
Message-ID: <20260323173955.39c8c902@kernel.org>
In-Reply-To: <20260319074338.24265-4-tariqt@nvidia.com>
References: <20260319074338.24265-1-tariqt@nvidia.com>
	<20260319074338.24265-4-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-18546-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC5902FFDE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 19 Mar 2026 09:43:38 +0200 Tariq Toukan wrote:
> Initializing all UMR MKEY entries as part of the CREATE_MKEY firmware
> command is relatively slow. Since this operation is performed per RQ,
> the cumulative latency becomes significant with a large number of
> queues.
> 
> Move the entries initialization out of the CREATE_MKEY command and
> perform it in the fast path by posting an appropriate UMR WQE on the
> ICOSQ.
> 
> The UMR WQE is prepared and written to the ICOSQ before activation,
> making it safe without additional locking, as it does not race with NOP
> postings or early NAPI refills.
> 
> Performance results:
> Setup: 248 channels, MTU 9000, RX/TX ring size 8K.

AI says:

> @@ -397,57 +396,61 @@ static u8 mlx5e_mpwrq_access_mode(enum mlx5e_mpwrq_umr_mode umr_mode)
> +static int mlx5e_rq_umr_mkey_data_alloc(struct mlx5e_rq *rq, u32 npages,
> +					struct mlx5_wqe_data_seg *dseg)
> +{
> +	dma_addr_t data_addr;
> +	int data_sz;
> +	void *data;
>  
> -	octwords = mlx5e_mpwrq_umr_octowords(npages, umr_mode);
> +	data_sz = mlx5e_mpwrq_umr_octowords(npages, rq->mpwqe.umr_mode) *
> +		MLX5_OCTWORD;
> +	rq->mpwqe_sp.init_data.p_unaligned =
> +		kzalloc(data_sz + MLX5_UMR_ALIGN - 1, GFP_KERNEL);
Is this allocation safe for large setups?
For setups with large ring sizes like 8K WQEs in OVERSIZED mode, the data size
can reach 256KB to 1MB. Requesting physically contiguous high-order allocations
across many channels during interface bring-up might fail on memory-fragmented
systems.
Should this continue to fall back to vmalloc like the previous kvzalloc code
did?

> @@ -455,48 +458,152 @@ static int mlx5e_create_umr_mkey(struct mlx5_core_dev *mdev,
> +static int mlx5e_rq_umr_mkey_data_init(struct mlx5e_rq *rq, u32 npages)
> +{
> +	struct mlx5_wqe_ctrl_seg      *cseg;
> +	struct mlx5_wqe_umr_ctrl_seg *ucseg;
> +	struct mlx5e_icosq *sq = rq->icosq;
> +	struct mlx5e_umr_wqe *umr_wqe;
> +	u16 pi, num_wqebbs, octowords;
> +	u8 ds_cnt;
> +	int err;
> +
> +	/* + 1 for the data segment */
> +	ds_cnt = 1 + DIV_ROUND_UP(offsetof(struct mlx5e_umr_wqe, dseg),
> +				  MLX5_SEND_WQE_DS);
> +	num_wqebbs = DIV_ROUND_UP(ds_cnt, MLX5_SEND_WQEBB_NUM_DS);
> +	pi = mlx5e_icosq_get_next_pi(sq, num_wqebbs);
> +	umr_wqe = mlx5_wq_cyc_get_wqe(&sq->wq, pi);
> +	memset(umr_wqe, 0, num_wqebbs * MLX5_SEND_WQE_BB);
> +
> +	cseg = &umr_wqe->hdr.ctrl;
> +	ucseg = &umr_wqe->hdr.uctrl;
> +
> +	cseg->opmod_idx_opcode =
> +		cpu_to_be32((sq->pc << MLX5_WQE_CTRL_WQE_INDEX_SHIFT) |
> +			    MLX5_OPCODE_UMR);
> +	cseg->qpn_ds = cpu_to_be32((sq->sqn << MLX5_WQE_CTRL_QPN_SHIFT) |
> +				   ds_cnt);
> +	cseg->umr_mkey = rq->mpwqe_sp.umr_mkey_be;
> +
> +	octowords = mlx5e_mpwrq_umr_octowords(npages, rq->mpwqe.umr_mode);
> +	ucseg->xlt_octowords = cpu_to_be16(octowords);
> +	ucseg->mkey_mask = cpu_to_be64(MLX5_MKEY_MASK_FREE);
> +
> +	err = mlx5e_rq_umr_mkey_data_alloc(rq, npages, umr_wqe->dseg);
> +	if (err)
> +		return err;
> +
> +	mlx5e_rq_umr_mkey_data_fill(rq, npages);

Could this sequence violate DMA coherency rules?
The buffer is mapped to the device with dma_map_single inside
mlx5e_rq_umr_mkey_data_alloc, but then mlx5e_rq_umr_mkey_data_fill writes the
MKEY translation data into the buffer.
On architectures without hardware cache coherency, the CPU writes might
remain in the cache, causing the NIC to read stale memory instead of the
actual MKEY data.

> +
> +	sq->db.wqe_info[pi] = (struct mlx5e_icosq_wqe_info) {
> +		.wqe_type   = MLX5E_ICOSQ_WQE_UMR_RX_INIT,
> +		.num_wqebbs = num_wqebbs,
> +		.umr.rq     = rq,
> +	};
> +
> +	sq->pc += num_wqebbs;
> +
> +	sq->doorbell_cseg = cseg;

Can this leave a stale pointer in sq->doorbell_cseg?
If a NOP WQE is later pushed to the ICOSQ but fails to clear this pointer, and
a subsequent allocation error occurs during the first iteration of
mlx5e_post_rx_mpwqes, the error path might use this stale doorbell_cseg.
Modifying an already-executed WQE could desynchronize the queue and stall the
ICOSQ.

> @@ -505,7 +612,6 @@ static int mlx5e_create_umr_mkey(struct mlx5_core_dev *mdev,
>  
>  static int mlx5e_create_rq_umr_mkey(struct mlx5_core_dev *mdev, struct mlx5e_rq *rq)
>  {
> -	u32 xsk_chunk_size = rq->xsk_pool ? rq->xsk_pool->chunk_size : 0;
>  	u32 wq_size = mlx5_wq_ll_get_size(&rq->mpwqe.wq);
>  	u32 num_entries, max_num_entries;
>  	u32 umr_mkey;
> @@ -522,9 +628,16 @@ static int mlx5e_create_rq_umr_mkey(struct mlx5_core_dev *mdev, struct mlx5e_rq
>  			      max_num_entries);
>  
>  	err = mlx5e_create_umr_mkey(mdev, num_entries, rq->mpwqe.page_shift,
> -				    &umr_mkey, rq->wqe_overflow.addr,
> -				    rq->mpwqe.umr_mode, xsk_chunk_size);
> +				    &umr_mkey, rq->mpwqe.umr_mode);
> +	if (err)
> +		return err;
> +
>  	rq->mpwqe_sp.umr_mkey_be = cpu_to_be32(umr_mkey);
> +
> +	err = mlx5e_rq_umr_mkey_data_init(rq, num_entries);
> +	if (err)
> +		mlx5_core_destroy_mkey(mdev, umr_mkey);
> +
>  	return err;
>  }

Does this code leak the initialization data and DMA mapping if a failure
happens later during queue creation?
If mlx5e_create_rq_umr_mkey completes successfully, but the broader
mlx5e_alloc_rq fails on a subsequent step like page pool creation, the teardown
seems to miss calling mlx5e_rq_umr_mkey_data_free for the newly allocated
buffer.

> @@ -1275,8 +1389,11 @@ int mlx5e_wait_for_min_rx_wqes(struct mlx5e_rq *rq, int wait_time)
>  	u16 min_wqes = mlx5_min_rx_wqes(rq->wq_type, mlx5e_rqwq_get_size(rq));
>  
>  	do {
> -		if (mlx5e_rqwq_get_cur_sz(rq) >= min_wqes)
> +		if (mlx5e_rqwq_get_cur_sz(rq) >= min_wqes) {
> +			/* memory usage completed, can be freed already */
> +			mlx5e_rq_umr_mkey_data_free(rq);
>  			return 0;
> +		}
>  
>  		msleep(20);
>  	} while (time_before(jiffies, exp_time));

Does this prematurely free the initialization buffer?
The condition checking that cur_sz is greater than min_wqes tracks the CPU's
NAPI thread pushing RX WQEs to the RQ, but it does not appear to guarantee that
the hardware has actually finished executing the asynchronous
MLX5E_ICOSQ_WQE_UMR_RX_INIT WQE on the ICOSQ.
If unmapped and freed while the NIC DMA engine is still fetching the data,
could this result in a DMA use-after-free and potential IOMMU faults?

