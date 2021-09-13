Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACB9408962
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Sep 2021 12:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238710AbhIMKwq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Sep 2021 06:52:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238690AbhIMKwq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Sep 2021 06:52:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C819D60F6F;
        Mon, 13 Sep 2021 10:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631530290;
        bh=4Z6WdakBB792YFw9YwbMrXPGjmS18hZ90lAozXnfSZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=grYxuo1EKPgj+1TS/h34LgOtM8zt4HugbzhvwQ2XK8nwG96KpO8WzgMhJ3IWuRqeI
         g2Nc285VCJI1s2Hihut3Cgp2+A5UNabLLaojmOJTTAGs+jkdXVC55eYiAnmlvYrP/L
         bzUrVCs8u/mcnJvAYEOCZ9deqC3Ffsou5V9hQ8cSxPTmWrTuFoH1M3JH+ap0gRdG8Q
         SZvtpyF3t1+St8R8VLSKXEakLfY78oMrDteU9ci6JuYMv/A9cgIJ1aGmb74Fh2Fq0n
         Hp84CuPeOgcEPO9uz838E/sVlLRO2XIZ1TNL3JaSusWfrV0uIUdhclGS1XSd1Zy09x
         xXwAFwm/F3UZg==
Date:   Mon, 13 Sep 2021 13:51:26 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 05/12] RDMA/bnxt_re: Support multiple page sizes
Message-ID: <YT8tLoTUplYAjR9w@unreal>
References: <1631470526-22228-1-git-send-email-selvin.xavier@broadcom.com>
 <1631470526-22228-6-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631470526-22228-6-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 12, 2021 at 11:15:19AM -0700, Selvin Xavier wrote:
> HW can support multiple page sizes. Enable bits
> for enabling sizes from 4k to 1G by reporting
> page_size_cap.
> 
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/bnxt_re.h  | 2 ++
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> index 5b85620..39a5677 100644
> --- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> +++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
> @@ -57,6 +57,8 @@
>  #define BNXT_RE_PAGE_SIZE_8M		BIT(BNXT_RE_PAGE_SHIFT_8M)
>  #define BNXT_RE_PAGE_SIZE_1G		BIT(BNXT_RE_PAGE_SHIFT_1G)

All the defines above can be deleted, they are not used.

>  
> +#define BNXT_RE_PAGE_SIZE_SUPPORTED	0x7FFFF000 /* 4kb - 1G */
> +
>  #define BNXT_RE_MAX_MR_SIZE_LOW		BIT_ULL(BNXT_RE_PAGE_SHIFT_1G)
>  #define BNXT_RE_MAX_MR_SIZE_HIGH	BIT_ULL(39)
>  #define BNXT_RE_MAX_MR_SIZE		BNXT_RE_MAX_MR_SIZE_HIGH
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> index 22e3668..c4d7a9e 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -133,7 +133,7 @@ int bnxt_re_query_device(struct ib_device *ibdev,
>  	bnxt_qplib_get_guid(rdev->netdev->dev_addr,
>  			    (u8 *)&ib_attr->sys_image_guid);
>  	ib_attr->max_mr_size = BNXT_RE_MAX_MR_SIZE;
> -	ib_attr->page_size_cap = BNXT_RE_PAGE_SIZE_4K | BNXT_RE_PAGE_SIZE_2M;
> +	ib_attr->page_size_cap = BNXT_RE_PAGE_SIZE_SUPPORTED;
>  
>  	ib_attr->vendor_id = rdev->en_dev->pdev->vendor;
>  	ib_attr->vendor_part_id = rdev->en_dev->pdev->device;
> @@ -3807,7 +3807,7 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
>  
>  	mr->qplib_mr.va = virt_addr;
>  	page_size = ib_umem_find_best_pgsz(
> -		umem, BNXT_RE_PAGE_SIZE_4K | BNXT_RE_PAGE_SIZE_2M, virt_addr);
> +		umem, BNXT_RE_PAGE_SIZE_SUPPORTED, virt_addr);
>  	if (!page_size) {
>  		ibdev_err(&rdev->ibdev, "umem page size unsupported!");
>  		rc = -EFAULT;
> -- 
> 2.5.5
> 
