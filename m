Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB613C3C17
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Jul 2021 14:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbhGKMDW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Jul 2021 08:03:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232575AbhGKMDW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 11 Jul 2021 08:03:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6790F6113C;
        Sun, 11 Jul 2021 12:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626004836;
        bh=V9x4y3prS2rQ90fcYA676jxtxzLD7JvIH+R0y7JrLRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=svAMMcTaGo93fBEZLri3H56pyAJD9Vxu9Ozb/iPryblwd8Bw69arAVJ12nZiKJjLR
         C02Nq9TQ7uZTvtMg3DEMxr0jXfA4npP0pAlwzu50JGd3hIQbLNg/kP7dE/a1UIkx9m
         MB/yu+30jxsr6GBpBv4oFp3HjhTCQXQz9SQCuz6v4NPF8aUm/wJxA9sWslbmjcUahf
         pSNM29FTPeFLN84HupMD3qLgyb5b0kWDOZuMm/1BBAPQmw0sC1jYIfBCi2vf7P42GS
         JI69CxrGXctAF5AsGWx3VrNdkAL/5hgQg6FAxXrdN6aeYYiVEYpbTOmjovzmBXdeIb
         7q2ahSOe+BbfA==
Date:   Sun, 11 Jul 2021 15:00:32 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     jgg@ziepe.ca, dledford@redhat.com, linux-rdma@vger.kernel.org,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
Subject: Re: [PATCH rdma-rc] RDMA/bnxt_re: Fix stats counters
Message-ID: <YOrdYGyJu/n6yWJ2@unreal>
References: <1625992490-5127-1-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1625992490-5127-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 11, 2021 at 01:34:50AM -0700, Selvin Xavier wrote:
> From: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
> 
> Stats counters are not incrementing in some adapter versions
> with newer FW. This is due to the stats context length mismatch
> between FW and driver. Since L2 driver updates the length correctly,
> use the stats length from L2 driver while allocating the DMA'able
> memory and creating the stats context.
> 
> Fixes:9d6b648c311(bnxt_en: Update firmware interface spec to 1.10.1.65)

This is wrong fixes line.

I recommend to add the line below to your gitaliases file
	fixes = "!git --no-pager log --abbrev=12 -1 --format='Fixes: %h (\"%s\")'"

and it will give you nice git fixes command with ready to copy string:
➜  kernel git:(rdma-next) git fixes 9d6b648c311
Fixes: 9d6b648c3112 ("bnxt_en: Update firmware interface spec to 1.10.1.65.")


> Signed-off-by: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/main.c      |  4 +++-
>  drivers/infiniband/hw/bnxt_re/qplib_res.c | 10 ++++------
>  drivers/infiniband/hw/bnxt_re/qplib_res.h |  1 +
>  3 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> index 04621ba..1fadca8 100644
> --- a/drivers/infiniband/hw/bnxt_re/main.c
> +++ b/drivers/infiniband/hw/bnxt_re/main.c
> @@ -119,6 +119,7 @@ static int bnxt_re_setup_chip_ctx(struct bnxt_re_dev *rdev, u8 wqe_mode)
>  	if (!chip_ctx)
>  		return -ENOMEM;
>  	chip_ctx->chip_num = bp->chip_num;
> +	chip_ctx->hw_stats_size = bp->hw_ring_stats_size;
>  
>  	rdev->chip_ctx = chip_ctx;
>  	/* rest members to follow eventually */
> @@ -507,6 +508,7 @@ static int bnxt_re_net_stats_ctx_alloc(struct bnxt_re_dev *rdev,
>  				       dma_addr_t dma_map,
>  				       u32 *fw_stats_ctx_id)
>  {
> +	struct bnxt_qplib_chip_ctx *chip_ctx = rdev->chip_ctx;
>  	struct hwrm_stat_ctx_alloc_output resp = {0};
>  	struct hwrm_stat_ctx_alloc_input req = {0};
>  	struct bnxt_en_dev *en_dev = rdev->en_dev;
> @@ -523,7 +525,7 @@ static int bnxt_re_net_stats_ctx_alloc(struct bnxt_re_dev *rdev,
>  	bnxt_re_init_hwrm_hdr(rdev, (void *)&req, HWRM_STAT_CTX_ALLOC, -1, -1);
>  	req.update_period_ms = cpu_to_le32(1000);
>  	req.stats_dma_addr = cpu_to_le64(dma_map);
> -	req.stats_dma_length = cpu_to_le16(sizeof(struct ctx_hw_stats_ext));
> +	req.stats_dma_length = cpu_to_le16(chip_ctx->hw_stats_size);
>  	req.stat_ctx_flags = STAT_CTX_ALLOC_REQ_STAT_CTX_FLAGS_ROCE;
>  	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
>  			    sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
> index fa78783..72be4fb 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
> @@ -56,6 +56,7 @@
>  static void bnxt_qplib_free_stats_ctx(struct pci_dev *pdev,
>  				      struct bnxt_qplib_stats *stats);
>  static int bnxt_qplib_alloc_stats_ctx(struct pci_dev *pdev,
> +				      struct bnxt_qplib_chip_ctx *cctx,
>  				      struct bnxt_qplib_stats *stats);
>  
>  /* PBL */
> @@ -559,7 +560,7 @@ int bnxt_qplib_alloc_ctx(struct bnxt_qplib_res *res,
>  		goto fail;
>  stats_alloc:
>  	/* Stats */
> -	rc = bnxt_qplib_alloc_stats_ctx(res->pdev, &ctx->stats);
> +	rc = bnxt_qplib_alloc_stats_ctx(res->pdev, res->cctx, &ctx->stats);
>  	if (rc)
>  		goto fail;
>  
> @@ -888,15 +889,12 @@ static void bnxt_qplib_free_stats_ctx(struct pci_dev *pdev,
>  }
>  
>  static int bnxt_qplib_alloc_stats_ctx(struct pci_dev *pdev,
> +				      struct bnxt_qplib_chip_ctx *cctx,
>  				      struct bnxt_qplib_stats *stats)
>  {
>  	memset(stats, 0, sizeof(*stats));
>  	stats->fw_id = -1;
> -	/* 128 byte aligned context memory is required only for 57500.
> -	 * However making this unconditional, it does not harm previous
> -	 * generation.
> -	 */
> -	stats->size = ALIGN(sizeof(struct ctx_hw_stats), 128);
> +	stats->size = cctx->hw_stats_size;
>  	stats->dma = dma_alloc_coherent(&pdev->dev, stats->size,
>  					&stats->dma_map, GFP_KERNEL);
>  	if (!stats->dma) {
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
> index 7a1ab38..58bad6f 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
> @@ -60,6 +60,7 @@ struct bnxt_qplib_chip_ctx {
>  	u16	chip_num;
>  	u8	chip_rev;
>  	u8	chip_metal;
> +	u16	hw_stats_size;
>  	struct bnxt_qplib_drv_modes modes;
>  };
>  
> -- 
> 2.5.5
> 
