Return-Path: <linux-rdma+bounces-15491-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F63D175B7
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 09:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D302A300EF7A
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 08:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108232EFDA2;
	Tue, 13 Jan 2026 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6mnuSUj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C744F3803ED;
	Tue, 13 Jan 2026 08:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768293908; cv=none; b=FNuqB26EMDnJcpql/VUWcOq+TvoWKPZctcXn0pqJ+tg15YR8k6De6O1mozcs9YRPowQEvY6IRNRs6BamfJbtt/lWB/gaEghAgeuVOSM0L73b0t8I3vUG9B1d2ZZ7wTK29Ueydw0tlYrD4HyJ1/H3zXS19r6jsKASEvCGLGgKtyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768293908; c=relaxed/simple;
	bh=nheAFaGFwtc5FUWcP2LHUe151FQqDsW7ybvknJZ3duc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nKbLQICQwcVso5zYPwo4BjANUIj8m6/c6J1HRmsQnBeSciUBuWuhhjcCAjjwFLQqgU6Tk1/ZJFU1ew3sDadU0e29+RHPN3f91NJEwYhjew6fnK6Phw/CUmEF/4d1sQCvNRd7cCK21q550GKJcpH3YI0xBR1F9c3m/+9ny7Spv5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6mnuSUj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03366C116C6;
	Tue, 13 Jan 2026 08:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768293908;
	bh=nheAFaGFwtc5FUWcP2LHUe151FQqDsW7ybvknJZ3duc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=d6mnuSUjHLln//XyfayAEHF9xmS//fYl8TOMqqLu4828xGyXSKIVmmWtmGJUxulMf
	 BIQ83uTmLDwvFKoxxstyTxVXg+VjmtK0MnhtAySwSsC9p5e9OWBgIrsGdemCsn6zPL
	 64MXuv/3v6glu9snzN7Y12NJshE0hAjrjn3WLFtzNypC6YwtMBnB/WeiCMmamd8g1J
	 /ZmFcd4NeXTUYXMK9KWNZ7ZXl0UArOUhwr0rRlLIHJHvghAu49Oxo9di2lrnkgNtye
	 1rqVW1gBigi0H2ZuEgCjukuriqs4O/ZD5jBnf6ndbO+I8VQMsyQJnM0P+rSPybr5pZ
	 ZKilgbDe28mKw==
From: Leon Romanovsky <leon@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Gal Pressman <gal@nvidia.com>, 
 Moshe Shemesh <moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
 Alexei Lazar <alazar@nvidia.com>
In-Reply-To: <1768200608-1543180-1-git-send-email-tariqt@nvidia.com>
References: <1768200608-1543180-1-git-send-email-tariqt@nvidia.com>
Subject: Re: [PATCH mlx5-next] net/mlx5: Add IFC bits for extended ETS rate
 limit bandwidth value
Message-Id: <176829390536.417489.9284250472543536413.b4-ty@kernel.org>
Date: Tue, 13 Jan 2026 03:45:05 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Mon, 12 Jan 2026 08:50:08 +0200, Tariq Toukan wrote:
> Add hardware interface definitions to support extended bandwidth rate
> limiting in the QoS Enhanced Transmission Selection (ETS) configuration.
> 
> The new fields include:
> - max_bw_value: extended from 8-bit to 16-bit in ets_tcn_config_reg,
>   simplifying the implementation by using a single field instead of
>   separate MSB/LSB fields.
> - qetcr_qshr_max_bw_val_msb: capability bit in qcam_qos_feature_cap_mask
>   indicating device support for the extended 16-bit max_bw_value field.
> 
> [...]

Applied, thanks!

[1/1] net/mlx5: Add IFC bits for extended ETS rate limit bandwidth value
      https://git.kernel.org/rdma/rdma/c/49e41f3ea3f754

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


