Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8198364BA
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2019 21:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfFETbQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 15:31:16 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40864 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFETbP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 15:31:15 -0400
Received: by mail-oi1-f194.google.com with SMTP id w196so9559093oie.7
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 12:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=et4APYx0tqmu3u6XwFXNQ//fsLyYlmbO57d3weHj4Y8=;
        b=mKq7fMA/gOkykYEuNRtYvexuawgseROnR85bF/+DHbZX0OZcdDgfUqgTckdloAdXDi
         5f/8UhvCgA1JfsLDPU1oq269MXA0eYW/SFTlLTacNc+heozjB83EDfvcSlbMTme4Q+m7
         irXc6iCvbqoOjJrQjMthApbO6V5q3t26MNTS5gd9ahY9EMi0qazDf+VsxXImWvsbg0uZ
         2m1l0SdWSlvdA0yfKK2uDR82bYhLF1zj2168Vegg+Aw1cJ3O+WdKrK3nQQCkdUI8XJCc
         HG9PdEwZjhASKlUsYq12DMJJgUrX+Fvvfwkll7O8xAcJC6XrMSNb4YFLt/EUSX3c0DZN
         2L7w==
X-Gm-Message-State: APjAAAX7udJEWlbctBzAmxMoCGt+GQ7dSukcHX1OLZoYb3znVLnIQXA2
        nrHKGaAdyKyOlWQlr39QLrw=
X-Google-Smtp-Source: APXvYqzwkweCKY5glSzqaWPRjvLKzDYtCT8+M+QdgoEmIJi1Qq+6wLwMutlH2xz0fU9ZJLwLtmLFJQ==
X-Received: by 2002:aca:39c6:: with SMTP id g189mr4532491oia.65.1559763074896;
        Wed, 05 Jun 2019 12:31:14 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id a31sm8051571otc.60.2019.06.05.12.31.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 12:31:13 -0700 (PDT)
Subject: Re: [PATCH 10/20] RDMA/mlx5: Introduce and implement new
 IB_WR_REG_MR_INTEGRITY work request
To:     Max Gurtovoy <maxg@mellanox.com>, leonro@mellanox.com,
        linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com,
        hch@lst.de, bvanassche@acm.org
Cc:     israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com,
        vladimirk@mellanox.com, shlomin@mellanox.com
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-11-git-send-email-maxg@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e058cb80-7000-781d-8455-581ee5dee1b5@grimberg.me>
Date:   Wed, 5 Jun 2019 12:31:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1559222731-16715-11-git-send-email-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 5/30/19 6:25 AM, Max Gurtovoy wrote:
> This new WR will be used to perform PI (protection information) handover
> using the new API. Using the new API, the user will post a single WR that
> will internally perform all the needed actions to complete PI operation.
> This new WR will use a memory region that was allocated as
> IB_MR_TYPE_INTEGRITY and was mapped using ib_map_mr_sg_pi to perform the
> registration. In the old API, in order to perform a signature handover
> operation, each ULP should perform the following:
> 1. Map and register the data buffers.
> 2. Map and register the protection buffers.
> 3. Post a special reg WR to configure the signature handover operation
>     layout.
> 4. Invalidate the signature memory key.
> 5. Invalidate protection buffers memory key.
> 6. Invalidate data buffers memory key.
> 
> In the new API, the mapping of both data and protection buffers is
> performed using a single call to ib_map_mr_sg_pi function. Also the
> registration of the buffers and the configuration of the signature
> operation layout is done by a single new work request called
> IB_WR_REG_MR_INTEGRITY.
> This patch implements this operation for mlx5 devices that are capable to
> offload data integrity generation/validation while performing the actual
> buffer transfer.
> This patch will not remove the old signature API that is used by the iSER
> initiator and target drivers. This will be done in the future.
> 
> In the internal implementation, for each IB_WR_REG_MR_INTEGRITY work
> request, we are using a single UMR operation to register both data and
> protection buffers using KLM's.
> Afterwards, another UMR operation will describe the strided block format.
> These will be followed by 2 SET_PSV operations to set the memory/wire
> domains initial signature parameters passed by the user.
> In the end of the whole transaction, only the signature memory key
> (the one that exposed for the RDMA operation) will be invalidated.
> 
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/infiniband/hw/mlx5/qp.c | 218 ++++++++++++++++++++++++++++++++++++----
>   include/linux/mlx5/qp.h         |   3 +-
>   include/rdma/ib_verbs.h         |   1 +
>   3 files changed, 201 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
> index 65d82e40871c..7c9fd335d43d 100644
> --- a/drivers/infiniband/hw/mlx5/qp.c
> +++ b/drivers/infiniband/hw/mlx5/qp.c
> @@ -4172,7 +4172,7 @@ static __be64 sig_mkey_mask(void)
>   static void set_reg_umr_seg(struct mlx5_wqe_umr_ctrl_seg *umr,
>   			    struct mlx5_ib_mr *mr, u8 flags)
>   {
> -	int size = mr->ndescs * mr->desc_size;
> +	int size = (mr->ndescs + mr->meta_ndescs) * mr->desc_size;
>   
>   	memset(umr, 0, sizeof(*umr));
>   
> @@ -4303,7 +4303,7 @@ static void set_reg_mkey_seg(struct mlx5_mkey_seg *seg,
>   			     struct mlx5_ib_mr *mr,
>   			     u32 key, int access)
>   {
> -	int ndescs = ALIGN(mr->ndescs, 8) >> 1;
> +	int ndescs = ALIGN(mr->ndescs + mr->meta_ndescs, 8) >> 1;
>   
>   	memset(seg, 0, sizeof(*seg));
>   
> @@ -4354,7 +4354,7 @@ static void set_reg_data_seg(struct mlx5_wqe_data_seg *dseg,
>   			     struct mlx5_ib_mr *mr,
>   			     struct mlx5_ib_pd *pd)
>   {
> -	int bcount = mr->desc_size * mr->ndescs;
> +	int bcount = mr->desc_size * (mr->ndescs + mr->meta_ndescs);
>   
>   	dseg->addr = cpu_to_be64(mr->desc_map);
>   	dseg->byte_count = cpu_to_be32(ALIGN(bcount, 64));
> @@ -4547,23 +4547,52 @@ static int mlx5_set_bsf(struct ib_mr *sig_mr,
>   	return 0;
>   }
>   
> -static int set_sig_data_segment(const struct ib_sig_handover_wr *wr,
> -				struct mlx5_ib_qp *qp, void **seg,
> -				int *size, void **cur_edge)
> +static int set_sig_data_segment(const struct ib_send_wr *send_wr,
> +				struct ib_mr *sig_mr,
> +				struct ib_sig_attrs *sig_attrs,
> +				struct mlx5_ib_qp *qp, void **seg, int *size,
> +				void **cur_edge)
>   {
> -	struct ib_sig_attrs *sig_attrs = wr->sig_attrs;
> -	struct ib_mr *sig_mr = wr->sig_mr;
>   	struct mlx5_bsf *bsf;
> -	u32 data_len = wr->wr.sg_list->length;
> -	u32 data_key = wr->wr.sg_list->lkey;
> -	u64 data_va = wr->wr.sg_list->addr;
> +	u32 data_len;
> +	u32 data_key;
> +	u64 data_va;
> +	u32 prot_len = 0;
> +	u32 prot_key = 0;
> +	u64 prot_va = 0;
> +	bool prot = false;
>   	int ret;
>   	int wqe_size;
>   
> -	if (!wr->prot ||
> -	    (data_key == wr->prot->lkey &&
> -	     data_va == wr->prot->addr &&
> -	     data_len == wr->prot->length)) {
> +	if (send_wr->opcode == IB_WR_REG_SIG_MR) {
> +		const struct ib_sig_handover_wr *wr = sig_handover_wr(send_wr);
> +
> +		data_len = wr->wr.sg_list->length;
> +		data_key = wr->wr.sg_list->lkey;
> +		data_va = wr->wr.sg_list->addr;
> +		if (wr->prot) {
> +			prot_len = wr->prot->length;
> +			prot_key = wr->prot->lkey;
> +			prot_va = wr->prot->addr;
> +			prot = true;
> +		}
> +	} else {
> +		struct mlx5_ib_mr *mr = to_mmr(sig_mr);
> +		struct mlx5_ib_mr *pi_mr = mr->pi_mr;
> +
> +		data_len = pi_mr->data_length;
> +		data_key = pi_mr->ibmr.lkey;
> +		data_va = pi_mr->ibmr.iova;
> +		if (pi_mr->meta_ndescs) {
> +			prot_len = pi_mr->meta_length;
> +			prot_key = pi_mr->ibmr.lkey;
> +			prot_va = pi_mr->ibmr.iova + data_len;
> +			prot = true;
> +		}
> +	}
> +
> +	if (!prot || (data_key == prot_key && data_va == prot_va &&
> +		      data_len == prot_len)) {

Worth explaining in a comment that this is either insert/strip or
interleaved case..

Other than that,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
(again)
