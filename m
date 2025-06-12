Return-Path: <linux-rdma+bounces-11247-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3338BAD6B1A
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 10:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308B02C02E4
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 08:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7623223DD1;
	Thu, 12 Jun 2025 08:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAd6rxJ8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F45722333B;
	Thu, 12 Jun 2025 08:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749717503; cv=none; b=cxb0Vshcutu/6hM7hmwTd57IRroUi1rEL4G/X4L0pC2MHaUtR2mzzAVYYrSfsVTSsN75Bi52wcyZe1Y0ztbbs8al6lCkcW8mFTFBaGjXc/4cEaH0eeCczyBh+WenugmUBG6b7QsRb3YWk0nvKYmzMHtROiV+CXUybMZ3KBQHiOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749717503; c=relaxed/simple;
	bh=4ct6BiKBaICofpIEcXSRhDFfH07G1Pyo/BYr6hTLbiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOyBGTP2BKHY8rDvPJ41SyGHXlFsNvze1TQOZFnhEYCiMuICzOFMgwOC4c1LTaRIFPJ60ILOJbO3PNPEjy3Aa621d/NRgUmJaaoTklXXpIrnw8GEf38OxB7LxnpQWRK9+plB3KoS2dXYMGD6Sb6PctlN8dnnahZtyufrSNT4Rvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAd6rxJ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59ADC4CEEA;
	Thu, 12 Jun 2025 08:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749717503;
	bh=4ct6BiKBaICofpIEcXSRhDFfH07G1Pyo/BYr6hTLbiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aAd6rxJ89s1iy4BW3eQdk52b8lpP48OcBH5ePouM1DLlV8DOKBGgQS3hRMtf2Uh+Y
	 XBdnmUiczflTCBTJuMMkWlSBiPuu+QKhGyLiEN/DPUxSWKriDSvTi2MIDk3QBKIH16
	 FsDXf5zeUAO2IxY4+tkZcZ2N/xWn24izb6/Fq6P/aTN+NBs72xIwPNzktYV1RvPlaw
	 Xs9T0s/pki4Pp4iX22rXYHIyOSmyNjN+ExS5GYeifPnxlOp+6vmGEsqxB/nyFI6Jge
	 X9pMxESmcRI833ngPYJIX66LXyE8t3MGpRxCUmMPGuPrXcVAxL1J9UOWJNtPMGYREq
	 LeJAlAVsse1vQ==
Date: Thu, 12 Jun 2025 11:38:19 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/cxgb4: Delete an unnecessary check before kfree()
 in c4iw_rdev_open()
Message-ID: <20250612083819.GS10669@unreal>
References: <cdc577a5-cebd-404a-b762-cc6fee0870dc@web.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cdc577a5-cebd-404a-b762-cc6fee0870dc@web.de>

On Tue, Jun 10, 2025 at 02:20:17PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 10 Jun 2025 14:14:09 +0200
> 
> It can be known that the function “kfree” performs a null pointer check
> for its input parameter.
> It is therefore not needed to repeat such a check before its call.
> 
> Thus remove a redundant pointer check.
> 
> The source code was transformed by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/infiniband/hw/cxgb4/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/cxgb4/device.c b/drivers/infiniband/hw/cxgb4/device.c
> index 034b85c42255..c0eb166a49b9 100644
> --- a/drivers/infiniband/hw/cxgb4/device.c
> +++ b/drivers/infiniband/hw/cxgb4/device.c
> @@ -905,7 +905,7 @@ static int c4iw_rdev_open(struct c4iw_rdev *rdev)
>  
>  	return 0;
>  err_free_status_page_and_wr_log:
> -	if (c4iw_wr_log && rdev->wr_log)
> +	if (c4iw_wr_log)

This is not needed too, fixed locally.

>  		kfree(rdev->wr_log);
>  	free_page((unsigned long)rdev->status_page);
>  destroy_ocqp_pool:
> -- 
> 2.49.0
> 
> 

