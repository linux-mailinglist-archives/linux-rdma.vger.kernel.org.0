Return-Path: <linux-rdma+bounces-10747-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4128AC4956
	for <lists+linux-rdma@lfdr.de>; Tue, 27 May 2025 09:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1CA11895F6F
	for <lists+linux-rdma@lfdr.de>; Tue, 27 May 2025 07:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE79248862;
	Tue, 27 May 2025 07:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="GyJpuDkM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C7E2AF10;
	Tue, 27 May 2025 07:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748331118; cv=none; b=YLelvytPFHfWA85tUml7D4w0dfl7THCYhKoD9M9Tx2bxR0WVCHy/k06db5cZKrjLSnfsNR/mPIfDViFbFuKiCTarbjkSpZn60A+vidTFcl6cBoNeOPftr5KeVqymOnFKlirH64TaKAlKqDTkF2dv6GVabRxAs1PFE97IjtHwLpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748331118; c=relaxed/simple;
	bh=uy90iF9tw2vE7SuCekeLDjRKm5mERvQ9+H/+C4NqjAg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Di8RQhG28DIuDX3VAfifRRH/HNNJmzq7pcnr7PiGEKanDXyczHo+/RkGXdjk5U8eZPCLfPoDWYXASJ9bXsuuPPSQPnQ/u/KffNlRn6+aUVG9uSdyHdQzNYLP6hVJsivQmgS+ovDHAQhOtsk4RDJqyLQMgioFfYeSpqddgyGaBXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=GyJpuDkM; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54R6Xngw024975;
	Tue, 27 May 2025 00:31:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=vgQ26jFz3G6RHRSYpIBIZXSpK
	H7CT5B/4mriOoW1rt0=; b=GyJpuDkMTOL4AMUon/eHNL2C6iCov4jsnLZy7lIKv
	lEsmeMhQcZF1ZAWW2qSjV3465ZDE9bJWipBvsxTScfpIvUW2aTyiHbGZm/3yfIsu
	hN26bJ/q/qG/pMSKbX1io6dnNJIu76nXeUFzIfFBupQCQ/NECCYUjEdD7czgqlkF
	idmlTbEiTLPgbZPXe0Y3Jd8UT1WcgjZe+HvIPDRzgLHnYr0YdDoUfhcavZNUIjRK
	4yEWqGMqJG6CDUygP4b5MT0mEFMRAPfdm20kIPkOpHx/j+5k33kER/T3VyK+2Tor
	8VYvBzjnfk2OWnV6/ozZ5sDrRYVp74xuZNSXiagnIohyQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46w880031h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 May 2025 00:31:30 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 May 2025 00:31:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 May 2025 00:31:29 -0700
Received: from b570aef45a5c (HY-LT91368.marvell.com [10.29.24.116])
	by maili.marvell.com (Postfix) with SMTP id 60B0E3F706A;
	Tue, 27 May 2025 00:31:24 -0700 (PDT)
Date: Tue, 27 May 2025 07:31:22 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Eugenia Emantayev <eugenia@mellanox.com>,
        Tariq Toukan
	<tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Or Gerlitz
	<ogerlitz@mellanox.com>,
        Matan Barak <matanb@mellanox.com>, <netdev@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH net] net/mlx4_en: Prevent potential integer overflow
 calculating Hz
Message-ID: <aDVqSjcpG3kvl-0g@b570aef45a5c>
References: <aDVS6vGV7N4UnqWS@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aDVS6vGV7N4UnqWS@stanley.mountain>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDA1OSBTYWx0ZWRfX4lfaHFGFwyn1 OIeJ7vSbaFna/eFE9Oxg7Vuzb1+woWDzkdDy3IN4FJvrZagiyWlKSIeDdfYdZ0E4dNwQLGMRr97 qRWrve/pEVTBsytl0JCjfCmA+F3QyozL2CDW0TMabzap0lcUdUi0PdWdXqq5PdlsqCnCLLi251S
 cZVFP4Cx4GC35deZgAqlse9oT6rI8X56upi1LxgZNYA4FybFp7/AK1sJZFa8q+KqfQjCkZy64L2 opOUsRv1uDJorYYKDn8wjWLHuCYrlo8gMqiaUBnuT7YRXoPKBASRucBnUYLRX8gFO39dpmuMJST TlALcRrh5IZ9Cq5bPPDfe+CMhui09H0O8Fj3v8f5f+JqOCk63a9pQzlajdgFYV98kxHtBH9zPlT
 J0nOZ7wMLhWIIOCJV7oB0LNS00IECzNerkwaYWgIFoC2t3YqE5CniYICL++1603ewdmPe9I1
X-Authority-Analysis: v=2.4 cv=LZ086ifi c=1 sm=1 tr=0 ts=68356a52 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=KKAkSRfTAAAA:8 a=aPZOCdfHzjhHKCp-osAA:9 a=CjuIK1q_8ugA:10
 a=cvBusfyB2V15izCimMoJ:22 a=yGmsW_zf-WRfUAWRrVPH:22
X-Proofpoint-ORIG-GUID: goaZm1hBinGupUf6L5h1VAf4KJaIbQjj
X-Proofpoint-GUID: goaZm1hBinGupUf6L5h1VAf4KJaIbQjj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_04,2025-05-26_02,2025-03-28_01

Hi,

On 2025-05-27 at 05:51:38, Dan Carpenter (dan.carpenter@linaro.org) wrote:
> The "freq" variable is in terms of MHz and "max_val_cycles" is in terms
> of Hz.  The fact that "max_val_cycles" is a u64 suggests that support
> for high frequency is intended but the "freq_khz * 1000" would overflow
> the u32 type if we went above 4GHz.  Use unsigned long type for the
> mutliplication to prevent that.
> 
> Fixes: 31c128b66e5b ("net/mlx4_en: Choose time-stamping shift value according to HW frequency")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/net/ethernet/mellanox/mlx4/en_clock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_clock.c b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
> index cd754cd76bde..7abd6a7c9ebe 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_clock.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
> @@ -249,7 +249,7 @@ static const struct ptp_clock_info mlx4_en_ptp_clock_info = {
>  static u32 freq_to_shift(u16 freq)
>  {
>  	u32 freq_khz = freq * 1000;
> -	u64 max_val_cycles = freq_khz * 1000 * MLX4_EN_WRAP_AROUND_SEC;
> +	u64 max_val_cycles = freq_khz * 1000UL * MLX4_EN_WRAP_AROUND_SEC;

1000ULL would be better then.

Thanks,
Sundeep

>  	u64 max_val_cycles_rounded = 1ULL << fls64(max_val_cycles - 1);
>  	/* calculate max possible multiplier in order to fit in 64bit */
>  	u64 max_mul = div64_u64(ULLONG_MAX, max_val_cycles_rounded);
> -- 
> 2.47.2
> 

