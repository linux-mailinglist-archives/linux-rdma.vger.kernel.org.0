Return-Path: <linux-rdma+bounces-4628-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7789640F9
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2024 12:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 529791F238CB
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2024 10:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7735418E025;
	Thu, 29 Aug 2024 10:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="scTuKq1U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3813C18DF67
	for <linux-rdma@vger.kernel.org>; Thu, 29 Aug 2024 10:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926201; cv=none; b=bu+O+TTpjgC7jgDcK6nDH5fAdaWmSQtBriLs9HfPfuSGBLqT3XmUaVIP/BPIjUyITDnZXFkncv9wqa7MNJ8ehaow3mfqCZHMZGb8K/L6aVft/mSZu6xyHznpdfDFUbNO5rBFHOeHX7/wetptYVcNe2DBhLDyIFOZyQJ2SWBtV+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926201; c=relaxed/simple;
	bh=399al0fbfYLXK9AjgfVXSKaQidRm2FRA4a4jxhwvSu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S82GvGRnPK0U1emIP6F3/Kv/dzDhlu/g1IE4C8vpWZEO+uRJr6rPwy5FOK8g0UMmOY4oT0P/Wb7hwQE4GR7UvlYWLQrqc5O02F+6G8jXLtCBIWeP+fKGMdUOmwaOiJRN8jMKzEw2PSErXDe85dy/3PshHD1g+ONSF92cLF3qoi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=scTuKq1U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394D2C4CEC1;
	Thu, 29 Aug 2024 10:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724926200;
	bh=399al0fbfYLXK9AjgfVXSKaQidRm2FRA4a4jxhwvSu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=scTuKq1UbOPZMJBzPI00jdD2XuyONMOcpYxTzjqsCEaIN7WZZ/6r4DDqZoc1TNbNP
	 RsdRuVjwFWX3U/xiFflb+msEKqZw1qIAaCXNM0NJr06b5HRPvdCpN2/S0Nrdj1gLnG
	 tPe4zZElS380b9Fbj3LL1mGwpHZ48rsymbWxfKYzkmleXR+8LHxpnABDLlz86NG6Vu
	 VPyk+mdicXxAPInEfeUtgE+4sLGkwRno90pdfyszj8jU0UKulHLxRXJ+Y0CMyXfXSS
	 UqCOfdD25xDSEY+VpoCxLDs6gr0SkaTHi2B+1RRcrLea0DuTpuxZ3qZfVzkj7f8nss
	 FoHDbrPS8EEHQ==
Date: Thu, 29 Aug 2024 13:09:55 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Cheng Xu <chengyou@linux.alibaba.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: Re: [PATCH for-next v2 1/4] RDMA/erdma: Make the device probe
 process more robust
Message-ID: <20240829100955.GB26654@unreal>
References: <20240828060944.77829-1-chengyou@linux.alibaba.com>
 <20240828060944.77829-2-chengyou@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828060944.77829-2-chengyou@linux.alibaba.com>

On Wed, Aug 28, 2024 at 02:09:41PM +0800, Cheng Xu wrote:
> Driver may probe again while hardware is destroying the internal
> resources allocated for previous probing

How is it possible?


> which will fail the device probe. To make it more robust, we always issue a reset at the
> beginning of the device probe process.
> 
> Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
> ---
>  drivers/infiniband/hw/erdma/erdma.h      |  1 +
>  drivers/infiniband/hw/erdma/erdma_main.c | 44 +++++++++++++++++++-----
>  2 files changed, 36 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/erdma/erdma.h b/drivers/infiniband/hw/erdma/erdma.h
> index c8bd698e21b0..b5c258f77ca0 100644
> --- a/drivers/infiniband/hw/erdma/erdma.h
> +++ b/drivers/infiniband/hw/erdma/erdma.h
> @@ -94,6 +94,7 @@ enum {
>  
>  #define ERDMA_CMDQ_TIMEOUT_MS 15000
>  #define ERDMA_REG_ACCESS_WAIT_MS 20
> +#define ERDMA_WAIT_DEV_REST_CNT 50
>  #define ERDMA_WAIT_DEV_DONE_CNT 500
>  
>  struct erdma_cmdq {
> diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
> index 7080f8a71ec4..9199058a0b29 100644
> --- a/drivers/infiniband/hw/erdma/erdma_main.c
> +++ b/drivers/infiniband/hw/erdma/erdma_main.c
> @@ -209,11 +209,30 @@ static void erdma_device_uninit(struct erdma_dev *dev)
>  	dma_pool_destroy(dev->resp_pool);
>  }
>  
> -static void erdma_hw_reset(struct erdma_dev *dev)
> +static int erdma_hw_reset(struct erdma_dev *dev, bool wait)
>  {
>  	u32 ctrl = FIELD_PREP(ERDMA_REG_DEV_CTRL_RESET_MASK, 1);
> +	int i;
>  
>  	erdma_reg_write32(dev, ERDMA_REGS_DEV_CTRL_REG, ctrl);
> +
> +	if (!wait)
> +		return 0;
> +
> +	for (i = 0; i < ERDMA_WAIT_DEV_REST_CNT; i++) {
> +		if (erdma_reg_read32_filed(dev, ERDMA_REGS_DEV_ST_REG,
> +					   ERDMA_REG_DEV_ST_RESET_DONE_MASK))
> +			break;
> +
> +		msleep(ERDMA_REG_ACCESS_WAIT_MS);
> +	}
> +
> +	if (i == ERDMA_WAIT_DEV_REST_CNT) {
> +		dev_err(&dev->pdev->dev, "wait reset done timeout.\n");
> +		return -ETIME;
> +	}
> +
> +	return 0;
>  }
>  
>  static int erdma_wait_hw_init_done(struct erdma_dev *dev)
> @@ -239,6 +258,17 @@ static int erdma_wait_hw_init_done(struct erdma_dev *dev)
>  	return 0;
>  }
>  
> +static int erdma_preinit_check(struct erdma_dev *dev)
> +{
> +	u32 version = erdma_reg_read32(dev, ERDMA_REGS_VERSION_REG);
> +
> +	/* we knows that it is a non-functional function. */
> +	if (version == 0)
> +		return -ENODEV;
> +
> +	return erdma_hw_reset(dev, true);
> +}
> +
>  static const struct pci_device_id erdma_pci_tbl[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_ALIBABA, 0x107f) },
>  	{}
> @@ -248,7 +278,6 @@ static int erdma_probe_dev(struct pci_dev *pdev)
>  {
>  	struct erdma_dev *dev;
>  	int bars, err;
> -	u32 version;
>  
>  	err = pci_enable_device(pdev);
>  	if (err) {
> @@ -287,12 +316,9 @@ static int erdma_probe_dev(struct pci_dev *pdev)
>  		goto err_release_bars;
>  	}
>  
> -	version = erdma_reg_read32(dev, ERDMA_REGS_VERSION_REG);
> -	if (version == 0) {
> -		/* we knows that it is a non-functional function. */
> -		err = -ENODEV;
> +	err = erdma_preinit_check(dev);
> +	if (err)
>  		goto err_iounmap_func_bar;
> -	}
>  
>  	err = erdma_device_init(dev, pdev);
>  	if (err)
> @@ -327,7 +353,7 @@ static int erdma_probe_dev(struct pci_dev *pdev)
>  	return 0;
>  
>  err_reset_hw:
> -	erdma_hw_reset(dev);
> +	erdma_hw_reset(dev, false);
>  
>  err_uninit_cmdq:
>  	erdma_cmdq_destroy(dev);
> @@ -364,7 +390,7 @@ static void erdma_remove_dev(struct pci_dev *pdev)
>  	struct erdma_dev *dev = pci_get_drvdata(pdev);
>  
>  	erdma_ceqs_uninit(dev);
> -	erdma_hw_reset(dev);
> +	erdma_hw_reset(dev, false);
>  	erdma_cmdq_destroy(dev);
>  	erdma_aeq_destroy(dev);
>  	erdma_comm_irq_uninit(dev);
> -- 
> 2.31.1
> 
> 

