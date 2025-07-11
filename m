Return-Path: <linux-rdma+bounces-12062-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB7BB027B1
	for <lists+linux-rdma@lfdr.de>; Sat, 12 Jul 2025 01:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6D9C1CA820D
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Jul 2025 23:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7037F225A3E;
	Fri, 11 Jul 2025 23:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlfxafgj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21159225417;
	Fri, 11 Jul 2025 23:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752276620; cv=none; b=Vo7oFPFK1ip5+ibLhnpjtRLJK06EEiC81m/a5yAHz2ABifYHiajdYI3e1i/DG7u8ixldlyb92f58f77UqcbNFFdG0qFBoGetN04gAtfOOkDCUkClutH/Mf0OqazJ9PXnrnxJIhnPer8+hDHpQCEOlJcrjmNrSwMYU80uykp9J4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752276620; c=relaxed/simple;
	bh=Z9S19ZAM3FOpSma84gdkSZ6yIMKHvVEULwM0Xhi86J0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=inWagsGaiaR7ryB6bi1CynI2LLChCMUoCBikiD7RZbI429mbZDyitgpESk+G7oBOhEwOISDW75Q7SiBGaWklEFYhXxLJJKlAqtgGMyFqJfEsVIwGfNmclJNCCxf8T8CGG6K6Iu9fG+NULwxc06ShqfrgiLFBsvyu/JuEkAFrr/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlfxafgj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D2DC4CEED;
	Fri, 11 Jul 2025 23:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752276619;
	bh=Z9S19ZAM3FOpSma84gdkSZ6yIMKHvVEULwM0Xhi86J0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hlfxafgjSTvX+OQIeYZoIvUcFH9HEihZ1vxo5L+adMfLV4JvUe17Ny0+kk5c0RR+P
	 RsGEjngGWoEyyflWhDyarlM+HH7Hts1DtyJdjq3VMXANLsl/Iho7Nwr/cH5Iod3MfH
	 BKtx0Y2T4lS6z1cKiy70cRS7k25mR36FcD1KPCVG4cpX5vyk/FHt+YyXRvzy6RUB+a
	 UNMeayzYcrRNydpijonRM56UFwXMxcjq/EIzO0Ea///OWExa9yhHty+N9MESkSovX9
	 GHrdbqc+wgxB/0+4eYPKqOW8rSLI2KWao7JyCgFF5gXTWIemnGiUoqAG4NoXp5yhnr
	 1YyWmuB7lP5yA==
Date: Fri, 11 Jul 2025 16:30:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeed@kernel.org>, Gal Pressman
 <gal@nvidia.com>, "Leon Romanovsky" <leon@kernel.org>, Saeed Mahameed
 <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Jonathan Corbet
 <corbet@lwn.net>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dragos Tatulea
 <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next V2 3/3] net/mlx5e: Make PCIe congestion event
 thresholds configurable
Message-ID: <20250711163018.335ea0f5@kernel.org>
In-Reply-To: <1752130292-22249-4-git-send-email-tariqt@nvidia.com>
References: <1752130292-22249-1-git-send-email-tariqt@nvidia.com>
	<1752130292-22249-4-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 09:51:32 +0300 Tariq Toukan wrote:
> Add a new sysfs entry for reading and configuring the PCIe congestion
> event thresholds. The format is the following:
> <inbound_low> <inbound_high> <outbound_low> <outbound_high>
> 
> Units are 0.01 %. Accepted values are in range (0, 10000].
> 
> When new thresholds are configured, a object modify operation will
> happen. The set function is updated accordingly to act as a modify
> as well.
> 
> The threshold configuration is stored and queried directly
> in the firmware.
> 
> To prevent fat fingering the numbers, read them initially as u64.

no sysfs, please :S Could you add these knobs to devlink?

> +	if (config) {
> +		*config = (struct mlx5e_pcie_cong_thresh) {
> +			.inbound_low = MLX5_GET(pcie_cong_event_obj, obj,
> +						inbound_cong_low_threshold),

Why are you overwriting the whole struct. It'd literally save you 
1 char of line length and 2 lines of LoC to pop a config-> in front
of each of these assignments...

The "whole struct assignment" really only makes sense when you
intentionally want to set the remaining members to 0 which is likely
very much _not_ what you want here, was the config struct ever to be
extended..

I know the cool new language features are cool but..

> +			.inbound_high = MLX5_GET(pcie_cong_event_obj, obj,
> +						inbound_cong_high_threshold),
> +			.outbound_low = MLX5_GET(pcie_cong_event_obj, obj,
> +						 outbound_cong_low_threshold),
> +			.outbound_high = MLX5_GET(pcie_cong_event_obj, obj,
> +						  outbound_cong_high_threshold),
> +		};
> +	}

