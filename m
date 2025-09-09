Return-Path: <linux-rdma+bounces-13198-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 319ABB4AD1A
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 14:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D636D188F08F
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 12:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D001322767;
	Tue,  9 Sep 2025 12:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dk8njxJ8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B588C280A5F;
	Tue,  9 Sep 2025 12:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419262; cv=none; b=jlq+7IyZLnaRsmZJvQdTyOPa280zsn9huPkcBdW9iCg0TqSA0q/BPwP1KutT7bcpYapT8LR2CBFeGzb+riGkk9/8FBBrGt8gZDjgPK1MB9Pwm0ftoMIyzCKKpFLyBUGKNOaUWh9A+PhQcwOe7cT4ihQC63wDS/T7EsG2W8Lh05g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419262; c=relaxed/simple;
	bh=1YJDWyOoueVjPjVtWTFDm9WtnwBeyicuWvBo9FBMBZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btfh+DWzvSzRcEPRbG6xHLhE8V138AWIvQOvVso4kdj3sKao10lAPKpLXeRFF0ITx3ggrw6r+Xuz4+T0h7GqQdlNjUCbqCAMuvyjHJp5li6sDUWpcGnCdTTp1EAN82EkSjzAUk7ApAzpIPEQ1Xgwp/WSVNmoukkn0+ZR1g9OVwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dk8njxJ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D37C4CEFA;
	Tue,  9 Sep 2025 12:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757419262;
	bh=1YJDWyOoueVjPjVtWTFDm9WtnwBeyicuWvBo9FBMBZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dk8njxJ8/I1tPVVmDVYzxmEWyC4xaoQ3ApzpN9Sayx+jsdv0ZgmPx+zeaBhI4G+zY
	 HxZDqHOLqYLeI7/Wabp8Z8rmb+0LTvld7czaykKwnSrzfrpf7+mtD4ttxIw7FzxOv3
	 l4MDkUAUlelh3TTCy6vD6/RH58ff89t7RzuLO32XaSpSxNZzKDVc5Z9DziOM965Y/k
	 lPJD84kY53LdQ/8nesvQzkbtA2jMynFKsdsP0D754gQiH5JdFwc9T/ybfGsRHm9kiz
	 Z4M9jzXUGDBujucJ5hOrXaPqZKGmgF6PlyO8jX6xhA8Ql/KuL3QyEY1ehiQ0xQJRxE
	 1/Z1mKoXM/2Wg==
Date: Tue, 9 Sep 2025 13:00:56 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next 1/2] net/mlx5e: Make PCIe congestion event
 thresholds configurable
Message-ID: <20250909120056.GA14415@horms.kernel.org>
References: <1757237976-531416-1-git-send-email-tariqt@nvidia.com>
 <1757237976-531416-2-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1757237976-531416-2-git-send-email-tariqt@nvidia.com>

On Sun, Sep 07, 2025 at 12:39:35PM +0300, Tariq Toukan wrote:
> From: Dragos Tatulea <dtatulea@nvidia.com>
> 
> Add devlink driverinit parameters for configuring the thresholds for
> PCIe congestion events. These parameters are registered only when the
> firmware supports this feature.
> 
> Update the mlx5 devlink docs as well on these new params.
> 
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Thanks,

Nice to see devlink coverage growing.

Reviewed-by: Simon Horman <horms@kernel.org>

