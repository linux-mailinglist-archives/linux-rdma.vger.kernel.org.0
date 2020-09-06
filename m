Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F270B25ED1C
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Sep 2020 09:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbgIFHVJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 6 Sep 2020 03:21:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgIFHVJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 6 Sep 2020 03:21:09 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7008520759;
        Sun,  6 Sep 2020 07:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599376869;
        bh=ySXR2GxJ/ZKO7tVu7fwcKOIo699yPLm174Jc6PdQY8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jhkb8erQ26eYuu1saIgOnn25vI+X9AVu66oFhZeFMSR+/g4TFfLUqnyTOzP8PnjgW
         mVlaCvsvn6DS5LKZHs2FE1hocrTukMP0K8qpUDuvLOMkzxCZSLnIZ4qmr0FX0MDB3D
         WqjAd2JhJXMeJ3VWG/9M9teiGFAv7L5cgViiINP4=
Date:   Sun, 6 Sep 2020 10:21:04 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: Re: [PATCH v2 17/17] RDMA/ocrdma: Remove fbo from MR
Message-ID: <20200906072104.GB55261@unreal>
References: <0-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
 <17-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 04, 2020 at 07:41:58PM -0300, Jason Gunthorpe wrote:
> This is always the same value as IOVA masked by the page size, just use
> that clearer calculation directly.
>
> It is unclear of ocrdma hardware can actually support a true fbo, if so it
> could use a different algorithm to compute the best page size.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/hw/ocrdma/ocrdma.h       | 1 -
>  drivers/infiniband/hw/ocrdma/ocrdma_hw.c    | 5 +++--
>  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 1 -
>  3 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/infiniband/hw/ocrdma/ocrdma.h b/drivers/infiniband/hw/ocrdma/ocrdma.h
> index fcfe0e82197a24..5eb61c1100900d 100644
> --- a/drivers/infiniband/hw/ocrdma/ocrdma.h
> +++ b/drivers/infiniband/hw/ocrdma/ocrdma.h
> @@ -185,7 +185,6 @@ struct ocrdma_hw_mr {
>  	u32 num_pbes;
>  	u32 pbl_size;
>  	u32 pbe_size;
> -	u64 fbo;
>  	u64 va;
>  };
>
> diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_hw.c b/drivers/infiniband/hw/ocrdma/ocrdma_hw.c
> index e07bf0b2209a4c..18ed658f8dba10 100644
> --- a/drivers/infiniband/hw/ocrdma/ocrdma_hw.c
> +++ b/drivers/infiniband/hw/ocrdma/ocrdma_hw.c
> @@ -1962,6 +1962,7 @@ static int ocrdma_mbx_reg_mr(struct ocrdma_dev *dev, struct ocrdma_hw_mr *hwmr,
>  	int i;
>  	struct ocrdma_reg_nsmr *cmd;
>  	struct ocrdma_reg_nsmr_rsp *rsp;
> +	u64 fbo = hwmr->va & (hwmr->pbe_size - 1);
>
>  	cmd = ocrdma_init_emb_mqe(OCRDMA_CMD_REGISTER_NSMR, sizeof(*cmd));
>  	if (!cmd)
> @@ -1987,8 +1988,8 @@ static int ocrdma_mbx_reg_mr(struct ocrdma_dev *dev, struct ocrdma_hw_mr *hwmr,
>  					OCRDMA_REG_NSMR_HPAGE_SIZE_SHIFT;
>  	cmd->totlen_low = hwmr->len;
>  	cmd->totlen_high = upper_32_bits(hwmr->len);
> -	cmd->fbo_low = (u32) (hwmr->fbo & 0xffffffff);
> -	cmd->fbo_high = (u32) upper_32_bits(hwmr->fbo);
> +	cmd->fbo_low = (u32) (fbo & 0xffffffff);

lower_32_bits(fbo)

> +	cmd->fbo_high = (u32) upper_32_bits(fbo);

u32 casting is not necessary.

>  	cmd->va_loaddr = (u32) hwmr->va;
>  	cmd->va_hiaddr = (u32) upper_32_bits(hwmr->va);
>
> diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
> index 1fb8da6d613674..3b98a3b3e2272d 100644
> --- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
> +++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
> @@ -870,7 +870,6 @@ struct ib_mr *ocrdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
>  		goto umem_err;
>
>  	mr->hwmr.pbe_size = PAGE_SIZE;
> -	mr->hwmr.fbo = ib_umem_offset(mr->umem);
>  	mr->hwmr.va = usr_addr;
>  	mr->hwmr.len = len;
>  	mr->hwmr.remote_wr = (acc & IB_ACCESS_REMOTE_WRITE) ? 1 : 0;
> --
> 2.28.0
>
