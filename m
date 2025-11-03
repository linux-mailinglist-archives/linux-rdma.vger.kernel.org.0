Return-Path: <linux-rdma+bounces-14208-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2378EC2C552
	for <lists+linux-rdma@lfdr.de>; Mon, 03 Nov 2025 15:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCD603BDE6F
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Nov 2025 13:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF597309DB4;
	Mon,  3 Nov 2025 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIVjGxGO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE0F2D8DB8;
	Mon,  3 Nov 2025 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762178345; cv=none; b=tQDv68nALrsZOxSAtOolqzJmDFvBTu5eKwmeglmc1ckSV+rNhRevDtiQEb/Pg3jIZL7kJgfls4wSKpgBr2PR4M4R/djj4Elobyf+/np3SSSeyWv3xaoZtMq+5lXeyk8aAa+ju6CJ7PMuMtDeyN87DzLy65rhexciUmvr6RDVQBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762178345; c=relaxed/simple;
	bh=bHUqSoXdPBw74baU1jQGbsTdT7fsEa8wDhx+W47rnzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Seeszf3FQD91tUuLL4WGo7IQVoyGiqsC0aiuaJ7ZV6JDtDT48h9MTFO3qlG6joOxHQxng4LKimg1HNQ7+sbu7XKX+PbkeY6D8T63xAhDaY+QynlCVSft5QqAsDUA7j59eiy27lA02CRgfLtQItxFCoT4ZGnYi3qSb6hOyqs2Efs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIVjGxGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CBDC4CEE7;
	Mon,  3 Nov 2025 13:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762178345;
	bh=bHUqSoXdPBw74baU1jQGbsTdT7fsEa8wDhx+W47rnzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qIVjGxGO8IHZ/Wvw8SUcnKZVzfKQ1wjm8VMnd637RkEORi/Q/L2sngmpSCXU70/EZ
	 VWRLwSkkKRVawvbiUbUiqCxznT8eIdxqfKRwTlvYMje4w/4zw5MbIJbW9GUSOCK4oD
	 xY3Fu2onm+4tglzLk8KZig8hNfb0tqyG8dDJJrtZKI9Kzew5YBFsuZfvZ44HiBLL7q
	 YUTMUUOIff0JJ/fMkgadBpYd8+AAD/zt8GWA3BH1BQfEizpN/AxpYAsOjtP6Vx/1qh
	 /oHqXW0ISpQN9VLe4iDlawMvFZZQ3MUczcWIh7hlmWNlqxc810jFUUAkbM6W+XM87i
	 hK55hPnf0134g==
Date: Mon, 3 Nov 2025 13:59:00 +0000
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
Subject: Re: [PATCH net-next V2 6/7] net/mlx5e: Pass old channels as argument
 to mlx5e_switch_priv_channels
Message-ID: <aQi1JL2l3AL5-zLp@horms.kernel.org>
References: <1761831159-1013140-1-git-send-email-tariqt@nvidia.com>
 <1761831159-1013140-7-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1761831159-1013140-7-git-send-email-tariqt@nvidia.com>

On Thu, Oct 30, 2025 at 03:32:38PM +0200, Tariq Toukan wrote:
> Let the caller function mlx5e_safe_switch_params() maintain a copy
> of the old channels, and pass it to mlx5e_switch_priv_channels().
> 
> This is in preparation for the next patch.
> 
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


