Return-Path: <linux-rdma+bounces-14206-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25005C2C54F
	for <lists+linux-rdma@lfdr.de>; Mon, 03 Nov 2025 15:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DD5D3BCFAB
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Nov 2025 13:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E64306B0F;
	Mon,  3 Nov 2025 13:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohAwUuwB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C1826B75B;
	Mon,  3 Nov 2025 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762178315; cv=none; b=U383VLZuPrWEi2SnFLyvrYCMpCqhF9TOu2hgMZvsCpyKvFo1W1uTgdYThcX4QQtN+9EgXOeTTsocx96qz+Mgf/dm5O6hZNSYfICvAL3LUF+oB8rXhHt45S2LzH0s7vIVat6nQ4Yfn5yXDcnEWai2/MQRqt2O0mz05wC90PxAOno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762178315; c=relaxed/simple;
	bh=/hK1RB0wAhEaoAegnALpBsHj7bt0H2aEonUwdIVDULM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVgTjriJfSofiOiJvOTXI1L/CqMT/MIklPE13I2WAbWAe7w6aqMEyVijB2ESI4s99RXIEv0KFDeCrwi7TcuIvMJ4BYu5wSRr8v8HaNaaTxswFO2QPKuIM0agdvGjAg2pLZMOaXH6FZ5duWlKkX1j5Ir2rtEiA1GCdcJTrWmtCeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohAwUuwB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D59C4CEFD;
	Mon,  3 Nov 2025 13:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762178313;
	bh=/hK1RB0wAhEaoAegnALpBsHj7bt0H2aEonUwdIVDULM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ohAwUuwBx6VU0+KKcmW8Z2HHgIO8rtfepopcN97qHRQiHeCub/sYGZrDqwtucegNa
	 EGAkucV7YM9RsPrvoP0OtGO/gTcfHeL3iYPunWlAiVqFYKcHxYNh+XOFhNJWf/WfCH
	 1DozvxkDkn8SImzwPrgNRbi23q4+fYFRJllTqOONOajPNjUAHPyrZ0ok/4fzHg7ytx
	 Q6JAW9Y26t62zqSN3ePsxk+PlptdAtO+8jfOF31kUq6e8hejV5xoOYOlRnY844UfTO
	 n8XZZHI18H9BhgpqP9N4rc3jYi4ncBkrv971Q8iujWCirqCsXNmU+Vypubw8c+Enjc
	 r93FCpQNe+w8g==
Date: Mon, 3 Nov 2025 13:58:28 +0000
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
Subject: Re: [PATCH net-next V2 4/7] net/mlx5: IPoIB, set self loopback
 prevention in TIR init
Message-ID: <aQi1BFHJzE3sNyzi@horms.kernel.org>
References: <1761831159-1013140-1-git-send-email-tariqt@nvidia.com>
 <1761831159-1013140-5-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1761831159-1013140-5-git-send-email-tariqt@nvidia.com>

On Thu, Oct 30, 2025 at 03:32:36PM +0200, Tariq Toukan wrote:
> In IPoIB, the self loopback prevention configuration apply in activation
> stage has two roles: fulfill a firmware requirement for old firmware
> (tis_tir_td_order=0), and update the proper configuration as it was not
> set in init.
> 
> Here we set the proper configuration in init, to allow skipping the
> modify_tirs commands on new firmware in a downstream patch.
> 
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


