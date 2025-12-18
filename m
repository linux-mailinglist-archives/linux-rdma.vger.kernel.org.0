Return-Path: <linux-rdma+bounces-15073-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F171BCCC7B3
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 16:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9540A30E64CE
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 15:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E172A34E747;
	Thu, 18 Dec 2025 15:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbNCjhuk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C642D0C98;
	Thu, 18 Dec 2025 15:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766071136; cv=none; b=I5yTVDR70KyW1FTg1PJaeHMCYbm2aRM7UvSZp9l9Zsxw53Ns62NX1goeu16Bl2A+eIKCnkQnCO5ZO7OEI035LMNzpWTUVlIl+Tlx2Z9sqGL3FSWwcRaqItfmz5ZM9gsdhR74tanzQAlGUEZc64nfyLAQaC+LrYwIR+e2hIIosE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766071136; c=relaxed/simple;
	bh=X9mD7Qqt+1kagZLX96j5rdSIhGDXEx5R4B8ZYBP5tgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4XHJud83gDnW3gFmx0WCUnSv1fHv7i+vdFRFrv6kZzck5dbyt/fe0E1UZsm/cmuJZiIrQj48T6mcAm9l7B9rkloHwZV0UsB+WcieoK3Y7dlyR8vs/MrE1hgK3AkdZcAUUyJfJ7pUB5tZbl1KfjHIkXDZ2oG7wabrX4ilL0X5xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbNCjhuk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78167C4CEFB;
	Thu, 18 Dec 2025 15:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766071135;
	bh=X9mD7Qqt+1kagZLX96j5rdSIhGDXEx5R4B8ZYBP5tgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jbNCjhukWxxoiSxIlX7ORtzOcoLWO+IEtrR0DpwZmZhlpfF63bTe0c4YSEvROx5SH
	 OhNlT0/vU35NpEoQjNDmoZFFTzGBdjNfKHP6TLadToxOtAnufUIJtPISmsOkW9wZ1x
	 2yBi3I7xZuVKH3G0jIfTEZDrL+QYqH4iD6MfatgaD3DmVPG0tAVgMM3XDvl44Npyyq
	 LgtxzIsc4s0s/uwLmzXbbh9H9V7f9rqhZK0W2rZyENS0l/DJkW6m0tEcnRO/5bcd1m
	 PcrQ8/4yPhImQnF9I/pXeptcecolB224W/p7SYpoDL8YQYHdVwYyED+TFcD2FYPBCJ
	 pp7kBFXu6buiw==
Date: Thu, 18 Dec 2025 17:18:51 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/bnxt_re: Replace cpu_to_be64 + le64_to_cpu with
 swab64
Message-ID: <20251218151851.GA400630@unreal>
References: <20251210131528.569382-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210131528.569382-2-thorsten.blum@linux.dev>

On Wed, Dec 10, 2025 at 02:15:29PM +0100, Thorsten Blum wrote:
> Replace cpu_to_be64(le64_to_cpu()) with swab64() to simplify
> bnxt_re_assign_pma_port_ext_counters().  No functional changes.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/infiniband/hw/bnxt_re/hw_counters.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.c b/drivers/infiniband/hw/bnxt_re/hw_counters.c
> index 651cf9d0e0c7..bb1137ad84c0 100644
> --- a/drivers/infiniband/hw/bnxt_re/hw_counters.c
> +++ b/drivers/infiniband/hw/bnxt_re/hw_counters.c
> @@ -290,19 +290,12 @@ int bnxt_re_assign_pma_port_ext_counters(struct bnxt_re_dev *rdev, struct ib_mad
>  	pma_cnt_ext = (struct ib_pma_portcounters_ext *)(out_mad->data + 40);
>  	if ((bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx) && rdev->is_virtfn) ||
>  	    !bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx)) {
> -		pma_cnt_ext->port_xmit_data =
> -			cpu_to_be64(le64_to_cpu(hw_stats->tx_ucast_bytes) / 4);

> +		pma_cnt_ext->port_xmit_data = swab64(hw_stats->tx_ucast_bytes / 4);

Why do you think that the above two lines are equal?
hw_stats->tx_ucast_bytes is __le64 value and le64_to_cpu(hw_stats->tx_ucast_bytes) / 4) is not equal to
hw_stats->tx_ucast_bytes / 4.

Thanks

