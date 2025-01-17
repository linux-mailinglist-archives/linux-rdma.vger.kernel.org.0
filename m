Return-Path: <linux-rdma+bounces-7068-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 170F8A14E0C
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Jan 2025 11:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8318F1886C68
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Jan 2025 10:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5614E1FCFE9;
	Fri, 17 Jan 2025 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrDdDMZA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050841FC7F4;
	Fri, 17 Jan 2025 10:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737111499; cv=none; b=Qnv8mIVUwH1c7kcqa7gpE98Yuf3ocNhe1vU9pJeDtwE9dvC3n5MdZRqk2AIxm2oJ7RhATyZS9DUfv2igH6JsGe4OzhzlaeDFO/4vHeBu/9lIhgpbsSevvg4H8j4wnrAZDtaR3XSAI9oXw4qSmki3GityMNMnIiHlQlw6Tla2Uas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737111499; c=relaxed/simple;
	bh=7PA/DGNZkrsM07dLTKwRGG7mNROsHN7+6G6LUEpoEMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAq/YCqYxPeprsKC8Tsa9ZD8/iuvoSnpo/xTqCG8sBK07hYqfsMKMxCl3EDTtuegTtdUGfy45gh+ydtVZMfDLAxqmDimDkh/Yii3fBSYlwGPjkCmYGZChQlBpOb6LKmDDnLi1HSwHQ7if/BDagO0hdTqQE7eLTed052CXbP6rMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrDdDMZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E658DC4CEDD;
	Fri, 17 Jan 2025 10:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737111498;
	bh=7PA/DGNZkrsM07dLTKwRGG7mNROsHN7+6G6LUEpoEMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IrDdDMZAgNi+UN8tD3G4UVC47i4AhiFfbTL/TsMuqLupr6Q6AfmdMTmiKyuek8hNB
	 G7dSR8Pmx2q17QkLjAO+gTdziWh/0XN+txAO3LBHVTYQLXxb4N70sSICdDayJKKbHB
	 QawvZfqKh5A7CxX9Ckghn/kdv143zLozRhRchlgIdkyBclzaB/HYi8c8Ugh4v4e5N9
	 z4iWMVbnVh9z5cA/Way5uTvMLO87OQcd6mwzWJQ5OoDY+t9/Kxckzs98QQGfxUAqIR
	 6I1MItNZMWGfOlfQSVj1MTOGhDVXG14n/4RC9R+yWMegMY0sczEyGGRzUYGJkVgiwS
	 skriheLh0VSuQ==
Date: Fri, 17 Jan 2025 10:58:13 +0000
From: Simon Horman <horms@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] net/mlx5: fix unintentional sign extension on
 shift of dest_attr->vport.vhca_id
Message-ID: <20250117105813.GL6206@kernel.org>
References: <20250116181700.96437-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116181700.96437-1-colin.i.king@gmail.com>

On Thu, Jan 16, 2025 at 06:17:00PM +0000, Colin Ian King wrote:
> Shifting dest_attr->vport.vhca_id << 16 results in a promotion from an
> unsigned 16 bit integer to a 32 bit signed integer, this is then sign
> extended to a 64 bit unsigned long on 64 bitarchitectures. If vhca_id is
> greater than 0x7fff then this leads to a sign extended result where all
> the upper 32 bits of idx are set to 1. Fix this by casting vhca_id
> to the same type as idx before performing the shift.
> 
> Fixes: 8e2e08a6d1e0 ("net/mlx5: fs, add support for dest vport HWS action")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


