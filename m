Return-Path: <linux-rdma+bounces-15070-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1B8CCC083
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 14:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26D6A30D9E75
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 13:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CD83376AA;
	Thu, 18 Dec 2025 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJGUqZnB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F209336EE9;
	Thu, 18 Dec 2025 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766064185; cv=none; b=EroixKcn4p957R5yHEZN5oAcwc4TRrPAv6BcEw4Pn7BXgChIv6UhR9tOLZyWLI3eKXO8N3M1fKjH/cF+EuDUMZ8il6HQx1OxZu3tLrcrfyG/aPeGf3GmeyD1NkuITy5eaPiXN9XpiglOD4ZbOVOdnk18bdJRfICG8OanV2tAEEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766064185; c=relaxed/simple;
	bh=cnp96vxWet6hk8u4hswpGDarA0U/OapE29sBMDoTdDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3h40RkPhfUmlt0ZaQgp55b+CRTmEC8WTXviFh6H6VdUpoI8GjWYRF5dUhpbbBMF9bnY+qyG0PjhJEtJvUumhNqwyYBzE/pWLa3fNeHOaE+Yp1JJ5CLGMEdG8x1AWN8Pu3ufVPtjs8rtFMiLwXT5R96W1C8GFfE1ul+ze9XmG7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJGUqZnB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B882C4CEFB;
	Thu, 18 Dec 2025 13:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766064184;
	bh=cnp96vxWet6hk8u4hswpGDarA0U/OapE29sBMDoTdDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kJGUqZnBh4ZimhKeb8KL3jFO69OtPGhLhVCiuWANCEQZFGD0ojxV3IYjVQZpM3rDg
	 Kj8upXXXbEldS6WfjZVTK+fe3Ao3DtXuVCYxaFBDBsWSehLzW9ov3vToUqqVW4YMgx
	 6xEiUOESG6CI/cophrStjJ6Y22NbShH3glNrdEsOefOQ698W/UfZilGxPLQxBOzRH3
	 bZ5WAnxip+Qf+eoxicODSOHkkU8kjG3PNcw68ATp9asZajWHEZ4GIbb955K4YC9t/0
	 NqD1VYG8l9zqjFLChR2+HKXSYyKv3fh1axKu9HwUXBG2EUFPU27pZ8yA31Qy7gMlhm
	 95u6MyofAlIPQ==
Date: Thu, 18 Dec 2025 15:22:59 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Honggang LI <honggangli@163.com>
Cc: haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
	danil.kipnis@cloud.ionos.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/rtrs: remove dead code
Message-ID: <20251218132259.GE39046@unreal>
References: <20251201032405.484231-1-honggangli@163.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201032405.484231-1-honggangli@163.com>

On Mon, Dec 01, 2025 at 11:24:05AM +0800, Honggang LI wrote:
> As rkey had been initialized to zero, the WARN_ON_ONCE should never been
> triggered. Remove it.
> 
> Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
> Signed-off-by: Honggang LI <honggangli@163.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index ef4abdea3c2d..a95640e848a5 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -240,11 +240,7 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
>  	wr->wr.num_sge	= 1;
>  	wr->remote_addr	= le64_to_cpu(id->rd_msg->desc[0].addr);
>  	wr->rkey	= le32_to_cpu(id->rd_msg->desc[0].key);
> -	if (rkey == 0)
> -		rkey = wr->rkey;
> -	else
> -		/* Only one key is actually used */
> -		WARN_ON_ONCE(rkey != wr->rkey);
> +	rkey = wr->rkey;

You can go one step further and remove rkey too.

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 9ecc6343455d..396dfc41e6da 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -208,7 +208,6 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
        size_t sg_cnt;
        int err, offset;
        bool need_inval;
-       u32 rkey = 0;
        struct ib_reg_wr rwr;
        struct ib_sge *plist;
        struct ib_sge list;
@@ -240,12 +239,6 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
        wr->wr.num_sge  = 1;
        wr->remote_addr = le64_to_cpu(id->rd_msg->desc[0].addr);
        wr->rkey        = le32_to_cpu(id->rd_msg->desc[0].key);
-       if (rkey == 0)
-               rkey = wr->rkey;
-       else
-               /* Only one key is actually used */
-               WARN_ON_ONCE(rkey != wr->rkey);
-
        wr->wr.opcode = IB_WR_RDMA_WRITE;
        wr->wr.wr_cqe   = &io_comp_cqe;
        wr->wr.ex.imm_data = 0;
@@ -277,7 +270,7 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
                inv_wr.opcode = IB_WR_SEND_WITH_INV;
                inv_wr.wr_cqe   = &io_comp_cqe;
                inv_wr.send_flags = 0;
-               inv_wr.ex.invalidate_rkey = rkey;
+               inv_wr.ex.invalidate_rkey = wr->rkey;
        }
 
        imm_wr.wr.next = NULL;
~

>  
>  	wr->wr.opcode = IB_WR_RDMA_WRITE;
>  	wr->wr.wr_cqe   = &io_comp_cqe;
> -- 
> 2.51.1
> 

