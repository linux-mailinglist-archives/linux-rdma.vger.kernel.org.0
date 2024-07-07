Return-Path: <linux-rdma+bounces-3684-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C481B929711
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jul 2024 10:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 767431F2163F
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jul 2024 08:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83692101CA;
	Sun,  7 Jul 2024 08:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qe3W+aH9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405A71078B;
	Sun,  7 Jul 2024 08:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720340678; cv=none; b=NfOmVLALNK6l6fsR4JL5PNzdvh3DuvlDlXRPwEqUwRHxgsJuhmEyWwyW8EXqii7iLeGqvFK7CCphSnsbrMS2xYonW/p7KfTleaIISpvGVor/M8jF9/Dj1CLhA73ewb9yRA+5lo382kpb9nFChYfj9eirtGUgJ7ROMd+u2tJAyE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720340678; c=relaxed/simple;
	bh=ppO6FBi3iKDQ0JeXaUGFkZ4NSMxgumSYofQkBenoBCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrA12KgZu6vWJUbC2vSGWZ12eQSe3N3w+x/F7u8Ywno0zqeTfKizK1yVrrZk1CzfQ6hGjldAIz+EYwPhlNx3AFNFqh7SGEjWE2cCy9+StYirR+TaU3NqvbwHom0U+hb68YjhhIzyelPE3dv5icYQ/qCtSAjQ3eSPhetclclWxG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qe3W+aH9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD07C3277B;
	Sun,  7 Jul 2024 08:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720340677;
	bh=ppO6FBi3iKDQ0JeXaUGFkZ4NSMxgumSYofQkBenoBCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qe3W+aH96XZ9mVxsGLaxMVq9SeHE9lIBFtNIrnq++NZkddPcn4T6VjQdIVHvpjvdt
	 6KaER9eeghdu2/1+CHLq+tmVN3ksyt6H0JrFxOyBIGT4e8xEo+o13LnM9pQCpSVqBT
	 p/8M9p9Ktkruu3y/aADJ4fYXK7+Fh/iKGGXwiIoDE4gHgpZknIYTLOZTlzztRX7n8M
	 Jk+cku2A+B9w36AFGHbcvGU3Lee5D+28BR2hDBMshcb7TnUvojpGAIGvF4RI2nTg/l
	 lmt3xGicTVq/7pT+AViKWyYx5y//ZUNLg8PFPiriAHgbJBxbsF+aizOfBznhd+Qdv9
	 MoXf8P66UHWhw==
Date: Sun, 7 Jul 2024 11:24:33 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-rc 1/9] RDMA/hns: Check atomic wr length
Message-ID: <20240707082433.GD6695@unreal>
References: <20240705085937.1644229-1-huangjunxian6@hisilicon.com>
 <20240705085937.1644229-2-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705085937.1644229-2-huangjunxian6@hisilicon.com>

On Fri, Jul 05, 2024 at 04:59:29PM +0800, Junxian Huang wrote:
> 8 bytes is the only supported length of atomic. Return an error if
> it is not.
> 
> Fixes: 384f88185112 ("RDMA/hns: Add atomic support")
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_device.h |  2 ++
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 19 +++++++++++++++----
>  2 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> index ff0b3f68ee3a..05005079258c 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> @@ -91,6 +91,8 @@
>  /* Configure to HW for PAGE_SIZE larger than 4KB */
>  #define PG_SHIFT_OFFSET				(PAGE_SHIFT - 12)
>  
> +#define ATOMIC_WR_LEN				8
> +
>  #define HNS_ROCE_IDX_QUE_ENTRY_SZ		4
>  #define SRQ_DB_REG				0x230
>  
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index 4287818a737f..a5d746a5cc68 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -164,15 +164,23 @@ static void set_frmr_seg(struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
>  	hr_reg_clear(fseg, FRMR_BLK_MODE);
>  }
>  
> -static void set_atomic_seg(const struct ib_send_wr *wr,
> -			   struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
> -			   unsigned int valid_num_sge)
> +static int set_atomic_seg(struct hns_roce_dev *hr_dev,
> +			  const struct ib_send_wr *wr,
> +			  struct hns_roce_v2_rc_send_wqe *rc_sq_wqe,
> +			  unsigned int valid_num_sge, u32 msg_len)
>  {
>  	struct hns_roce_v2_wqe_data_seg *dseg =
>  		(void *)rc_sq_wqe + sizeof(struct hns_roce_v2_rc_send_wqe);
>  	struct hns_roce_wqe_atomic_seg *aseg =
>  		(void *)dseg + sizeof(struct hns_roce_v2_wqe_data_seg);
>  
> +	if (msg_len != ATOMIC_WR_LEN) {
> +		ibdev_err_ratelimited(&hr_dev->ib_dev,
> +				      "invalid atomic wr len, len = %u.\n",
> +				      msg_len);
> +		return -EINVAL;

1. Please don't add prints in data-path.
2. You most likely need to add this check before calling to set_atomic_seg().
3. You shouldn't continue to process the WQE if the length is invalid.
Need to return from set_rc_wqe() and not continue.
4. I wonder if it is right place to put this limitation and can't be
enforced much earlier.

Thanks

