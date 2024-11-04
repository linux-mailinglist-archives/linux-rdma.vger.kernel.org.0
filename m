Return-Path: <linux-rdma+bounces-5729-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 583BC9BAE07
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Nov 2024 09:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105391F22E6B
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Nov 2024 08:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7002C1AAE2E;
	Mon,  4 Nov 2024 08:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8z6Nl+J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D3B18BC0E;
	Mon,  4 Nov 2024 08:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730708839; cv=none; b=d8umCQ+bneNQjM/tFN5x9ZgfE6zyNJzOaWt4LosP+YsHxjuFukI16IDjsmX0bOIqgcBYHtC3Cef1T/B2hlEi3+ASXjn+MkdP1KkwkXFbtxXAxK/ZZYBPdf3LCj1DNWEuujhK7S+DumO+J40IF0MNfQ+RJ98Z4wsGhpAdf+g+EHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730708839; c=relaxed/simple;
	bh=OTtLPqoJ6FCGvPLO0Kk2ILGo2IyH9hAY+6Hic5r0rYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaI7O9uc6ollNs/m8dRFBub7/Lr9BmymH6URlYR8UHKAVbbMVqd9Z17SwIatcoxU8CG4xi/foGqiLHNubkkdvqytDDVQiueOKLQxZpG6MpA3eBy8iuOBZejsXbIY8nSpK0lJS8/Ti4sZcl+76O5tShlZ+Ifygv27KhU85kMAjwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8z6Nl+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE584C4CECE;
	Mon,  4 Nov 2024 08:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730708838;
	bh=OTtLPqoJ6FCGvPLO0Kk2ILGo2IyH9hAY+6Hic5r0rYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N8z6Nl+JJkVg59R6R97DmusBAZrpSl8nx4bhv2nOAtnH9HnlhB7ewO77Z4AQhry2M
	 wFQ43vPU+pVPEhqMmjpYPC4vd7ShQ6f8SFhIyUoSFlIBpwlTHg8uu4A3YVdBd2FDn+
	 XH4OyMc7TMsLBbSgyp4K7JfcC4SCKFATIRfzVIDYXcv+vqLN/0VK7bDGVjeLS8u3jh
	 By4IsSQZLL9deCMnjJh3XXQ7TOC1Ly1ITMyGX4c2Cwbh0OCbXYVstllhrXqAVwroCK
	 iYy/4Wi8vpJmP80uh/JVMQyLk/RogYise5789tzWty611Ya8WY6klI24aO+Ko0roRv
	 LaYmMGOzx5Thw==
Date: Mon, 4 Nov 2024 10:27:10 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Edward Srouji <edwards@nvidia.com>, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next 0/2] Introduce mlx5 data direct placement (DDP)
Message-ID: <20241104082710.GB99170@unreal>
References: <cover.1725362773.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725362773.git.leon@kernel.org>

On Tue, Sep 03, 2024 at 02:37:50PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Hi,
> 
> This series from Edward introduces mlx5 data direct placement (DDP)
> feature. 
> 
> This feature allows WRs on the receiver side of the QP to be consumed
> out of order, permitting the sender side to transmit messages without
> guaranteeing arrival order on the receiver side.
> 
> When enabled, the completion ordering of WRs remains in-order,
> regardless of the Receive WRs consumption order.
> 
> RDMA Read and RDMA Atomic operations on the responder side continue to
> be executed in-order, while the ordering of data placement for RDMA
> Write and Send operations is not guaranteed.
> 
> Thanks
> 
> Edward Srouji (2):
>   net/mlx5: Introduce data placement ordering bits

Jakub,

We applied this series to RDMA and first patch generates merge conflicts
in include/linux/mlx5/mlx5_ifc.h between netdev and RDMA trees.

Can you please pull shared mlx5-next branch to avoid it?

Thanks


>   RDMA/mlx5: Support OOO RX WQE consumption
> 
>  drivers/infiniband/hw/mlx5/main.c    |  8 +++++
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 +
>  drivers/infiniband/hw/mlx5/qp.c      | 51 +++++++++++++++++++++++++---
>  include/linux/mlx5/mlx5_ifc.h        | 24 +++++++++----
>  include/uapi/rdma/mlx5-abi.h         |  5 +++
>  5 files changed, 78 insertions(+), 11 deletions(-)
> 
> -- 
> 2.46.0
> 
> 

