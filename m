Return-Path: <linux-rdma+bounces-14209-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50620C2C54C
	for <lists+linux-rdma@lfdr.de>; Mon, 03 Nov 2025 15:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE853BE99E
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Nov 2025 13:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DFD30E843;
	Mon,  3 Nov 2025 13:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlQcXGbO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3E42F261D;
	Mon,  3 Nov 2025 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762178359; cv=none; b=vEGcqBobFElBFmfUKqJiosBFpThr/ojC6/Go/8cvfX0jJUsCeVvj4Zbk00EPi1GZUextuXzztn3WHzTNIGsRPlqU7f1ODj/lT7YL6vNGOUv8msec7l1SzVcZNxsD6cUY0TqzZVvdoJ3gyAgAdGKl6z/VBpiZ4LOb9PA5miNpqBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762178359; c=relaxed/simple;
	bh=0oAeYn4eoIt7fITYoXBYzp284ep+P4EZt8Gf1qpP4oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwusC/HxrM+bGzlCp8IHDBR4j4ubjQUFVX81ARPhmZua9/DEFiceeAH/mX5/osL2CdWxhm/Lj7xq2D4J0PsNVazVpQHpAUS2M/4PoEa72qrzfy5gSpC72g00vo1xHgN7tvS59jxy8sCJ50ItCYz++B6lfXN8xHTCR0MdTwQdPxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlQcXGbO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51F1C4CEE7;
	Mon,  3 Nov 2025 13:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762178359;
	bh=0oAeYn4eoIt7fITYoXBYzp284ep+P4EZt8Gf1qpP4oE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UlQcXGbOlyvxErBCoqLQNCaqrnB3NX4ocVQ0NFukMQ4J7KYEYmSnTe7tvzkWP85k0
	 u/XEb1YWQCZ0Hwec6BxB+bE8Hk1yAEj2rCAPM/9hg0N9nxhxeCQk4kwvuBBFBTRlp+
	 VW1Zxa3NVjB3sDQbIaW5QoVyQn1YV2mfT0KwLWAXvcCkpvlSkVeORAuzT9KRfG47ZB
	 fGGxQfPUjTgpHC3eoHV4fVq57uEt9OhoOT3JDbN63BtlDo8V4J4/vKlp6IqoOUjrhE
	 j0557nDKZmyELdfOXACTfXVlKifcKl3zTAxwMY2eMWJDUIYgncHY0B64PZ/y0ERNMO
	 zwnmRYll6LaUQ==
Date: Mon, 3 Nov 2025 13:59:14 +0000
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net-next V2 7/7] net/mlx5e: Defer channels closure to
 reduce interface down time
Message-ID: <aQi1MnDKke7XqA_y@horms.kernel.org>
References: <1761831159-1013140-1-git-send-email-tariqt@nvidia.com>
 <1761831159-1013140-8-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1761831159-1013140-8-git-send-email-tariqt@nvidia.com>

On Thu, Oct 30, 2025 at 03:32:39PM +0200, Tariq Toukan wrote:
> Cap bit tis_tir_td_order=1 indicates that an old firmware requirement /
> limitation no longer exists. When unset, the latency of several firmware
> commands significantly increases with the presence of high number of
> co-existing channels (both old and new sets). Hence, we used to close
> unneeded old channels before invoking those firmware commands.
> 
> Today, on capable devices, this is no longer the case. Minimize the
> interface down time by deferring the old channels closure, after the
> activation of the new ones.
> 
> Perf numbers:
> Measured the number of dropped packets in a simple ping flood test,
> during a configuration change operation, that switches the number of
> channels from 247 to 248.
> 
> Before: 71 packets lost
> After:  15 packets lost, ~80% saving.
> 
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


