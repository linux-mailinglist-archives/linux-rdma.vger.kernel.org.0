Return-Path: <linux-rdma+bounces-11952-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7668DAFC247
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 07:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDEDB4A3F18
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 05:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4083D21B9C3;
	Tue,  8 Jul 2025 05:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGlRj9Gb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3E3215F5C;
	Tue,  8 Jul 2025 05:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751953900; cv=none; b=RwUFubdYicORTa5jkKyze1ERk3HHo3FZ0x8X6AagMP6MtyV0NZSXPQTEgIv82f0etX9Ric8lyIVa1zI+zrqf9GBKb+oQuLCOBRWJ+nrlCR1aidjuJ/9pZEpGSnmC3P8wpYhWvqWDmexZEGZcWf0AEQJg3bE8PxaxivBy2sNKOoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751953900; c=relaxed/simple;
	bh=gEdd/6I4My3ZZFI4I2HJXKrc31rPhkt8Ri9M8kHQgYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1pylqIqE9Gy3XLAhVM8ofEWPo5B+PU5Dsbnn647ItRo5Njr7awIDGNkJpLXRAudoYU95QBbOK9VIGm4ZXXQa0zMt6NxnSZbpV3B3VL+nOXWehejwf5Grg7vxrYm+QIT/N8DUwCs2jTIySaFOXejrX0lBN8C/r2uPgPTyPHoJHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGlRj9Gb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E460DC4CEEF;
	Tue,  8 Jul 2025 05:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751953897;
	bh=gEdd/6I4My3ZZFI4I2HJXKrc31rPhkt8Ri9M8kHQgYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KGlRj9GbXxDHc8w8+ukJnFaJi2BOx7GytdphJ8gHBDrfOrYw05eJ6ZBAy5lqzCZTO
	 mfd6uqs0CNV9PNyJzTE+laSH2VXqQib+yhyHOVK57K1z0pl7iYmg+wDs/I1k05sYiX
	 0Q2MHxs5RKQCWuoInO34VP27zHi3HoRo4dFwf2VvkHJAOxW+L0bj7U+inkf2voDbp4
	 +s0DH6LphFatMbisKPAEke4WzZ8R8IaW1CiQN5zPV5F6IzMD0K2GQrKay5QssoFcP9
	 +ddGgb+v10Mq+uTE+jANlilkCM7enI3+4zX/DJB2aAP6EJ/2IrJmDpgwNU8HUulaJu
	 WRBIcUZYU0SPQ==
Date: Tue, 8 Jul 2025 08:51:33 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yishai Hadas <yishaih@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH mlx5-next 3/8] net/mlx5: Add support for device steering
 tag
Message-ID: <20250708055133.GD592765@unreal>
References: <cover.1751907231.git.leon@kernel.org>
 <dc4c7f6ba34e6beaf95a3c4f9c2e122925be97c9.1751907231.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc4c7f6ba34e6beaf95a3c4f9c2e122925be97c9.1751907231.git.leon@kernel.org>

On Mon, Jul 07, 2025 at 08:03:03PM +0300, Leon Romanovsky wrote:
> From: Yishai Hadas <yishaih@nvidia.com>
> 
> Background, from PCIe specification 6.2.
> 
> TLP Processing Hints (TPH)
> --------------------------
> TLP Processing Hints is an optional feature that provides hints in
> Request TLP headers to facilitate optimized processing of Requests that
> target Memory Space. These Processing Hints enable the system hardware
> (e.g., the Root Complex and/or Endpoints) to optimize platform
> resources such as system and memory interconnect on a per TLP basis.
> Steering Tags are system-specific values used to identify a processing
> resource that a Requester explicitly targets. System software discovers
> and identifies TPH capabilities to determine the Steering Tag allocation
> for each Function that supports TPH.
> 
> This patch adds steering tag support for mlx5 based NICs by:
> 
> - Enabling the TPH functionality over PCI if both FW and OS support it.
> - Managing steering tags and their matching steering indexes by
>   writing a ST to an ST index over the PCI configuration space.
> - Exposing APIs to upper layers (e.g.,mlx5_ib) to allow usage of
>   the PCI TPH infrastructure.
> 
> Further details:
> - Upon probing of a device, the feature will be enabled based
>   on both capability detection and OS support.
> 
> - It will retrieve the appropriate ST for a given CPU ID and memory
>   type using the pcie_tph_get_cpu_st() API.
> 
> - It will track available ST indices according to the configuration
>   space table size (expected to be 63 entries), reserving index 0 to
>   indicate non-TPH use.
> 
> - It will assign a free ST index with a ST using the
>   pcie_tph_set_st_entry() API.
> 
> - It will reuse the same index for identical (CPU ID + memory type)
>   combinations by maintaining a reference count per entry.
> 
> - It will expose APIs to upper layers (e.g., mlx5_ib) to allow usage of
>   the PCI TPH infrastructure.
> 
> - SF will use its parent PF stuff.
> 
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/Makefile  |   5 +
>  .../net/ethernet/mellanox/mlx5/core/lib/st.c  | 162 ++++++++++++++++++
>  .../net/ethernet/mellanox/mlx5/core/main.c    |   2 +
>  .../ethernet/mellanox/mlx5/core/mlx5_core.h   |   9 +
>  include/linux/mlx5/driver.h                   |  20 +++
>  5 files changed, 198 insertions(+)
>  create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/st.c

<...>

> +	if (mlx5_core_is_sf(dev))

Somehow this line was lost during rebase.
This should be if (IS_ENABLED(CONFIG_MLX5_SF) && mlx5_core_is_sf(dev)) 

Thanks

