Return-Path: <linux-rdma+bounces-5810-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 542449BE899
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2024 13:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BEE11F224FB
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2024 12:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E55C1DFE10;
	Wed,  6 Nov 2024 12:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqgGJR2v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE0E1DED58;
	Wed,  6 Nov 2024 12:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730895945; cv=none; b=t/iZGgwf+zaWl53wpjwMlArQaII+B5Flsj+y8t5dEXUeHsjIO9IhbMlLFQAy4Da5E6l8SDdbCB1bHMToWT9vURZQ9BO0rKad/hRX5uLszeMqP4js1UN7c7nv6vV7EI8hZJy+84hmNq49DC3X1NpxGSlyWumXG6dEfWCICP4SdlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730895945; c=relaxed/simple;
	bh=Ql0f9QPXZsz6XdIg7YqDkg3ZcReNtMqKbXcsPh4THk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MeIJOy5aQ2yw/1yBEDM2TfZVTGE3KvCiFm6jsRtRMtzE76AYnqLbkWFynghQysSbuzrZX2eWdJKQUuLKM1iV+925Zw7jYkYld94TqnfKvIdqav3OGX4Vw6A9Dp8q0VzFvdmFJHixVifAx1h3OrW0/WmR5soMStG4vdnJUr7Z1U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqgGJR2v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FA1C4CED4;
	Wed,  6 Nov 2024 12:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730895945;
	bh=Ql0f9QPXZsz6XdIg7YqDkg3ZcReNtMqKbXcsPh4THk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kqgGJR2vg6yW0GbXr/07HyoG2ZjnHYy/zc/yUAZlM/n0M2PTrarAakyYsjTLoW+KL
	 UMynVwNeUTxUeXWk3IWVJjNtqGHy0+dhDsSmkip4sxV3BF4byKz40/7pgT8RD4vsAd
	 WLx89nIwsYKNmtMy9nEZuEXCkUyQj62VpIgHdmEfcm8VFi2d6JynDFhx36OjzFnL4n
	 hnkjZCVp4H4p7SNzN4d2EKY+L9s9C1Bm6yYNrhycI0w1JC2LRkT5F2/B1AqEKTGm/D
	 PmpCqHpqL42QbAjxsY6bd43j3kea3/gB80rTaKL3w0DWDCPLya6S+HADVw8cpb+Tz9
	 NHKQcuD5oxFIQ==
Date: Wed, 6 Nov 2024 14:25:41 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Jan Karcher <jaka@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Nils Hoppmann <niho@linux.ibm.com>,
	Niklas Schnell <schnelle@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Stefan Raspl <raspl@linux.ibm.com>, Aswin K <aswin@linux.ibm.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH net v2] net/smc: Fix lookup of netdev by using
 ib_device_get_netdev()
Message-ID: <20241106122541.GD5006@unreal>
References: <20241106082612.57803-1-wenjia@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106082612.57803-1-wenjia@linux.ibm.com>

On Wed, Nov 06, 2024 at 09:26:12AM +0100, Wenjia Zhang wrote:
> The SMC-R variant of the SMC protocol used direct call to function
> ib_device_ops.get_netdev() to lookup netdev. As we used mlx5 device
> driver to run SMC-R, it failed to find a device, because in mlx5_ib the
> internal net device management for retrieving net devices was replaced
> by a common interface ib_device_get_netdev() in commit 8d159eb2117b
> ("RDMA/mlx5: Use IB set_netdev and get_netdev functions").
> 
> Since such direct accesses to the internal net device management is not
> recommended at all, update the SMC-R code to use proper API
> ib_device_get_netdev().
> 
> Fixes: 54903572c23c ("net/smc: allow pnetid-less configuration")
> Reported-by: Aswin K <aswin@linux.ibm.com>
> Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> Reviewed-by: Wen Gu <guwen@linux.alibaba.com>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
> Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>
> ---
>  net/smc/smc_ib.c   | 8 ++------
>  net/smc/smc_pnet.c | 4 +---
>  2 files changed, 3 insertions(+), 9 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

