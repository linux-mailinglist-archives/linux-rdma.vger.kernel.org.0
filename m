Return-Path: <linux-rdma+bounces-5075-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DF1984AB8
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2024 20:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91F31F229FD
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2024 18:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E011AC45F;
	Tue, 24 Sep 2024 18:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeRiGlqn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5A511CA0;
	Tue, 24 Sep 2024 18:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727201502; cv=none; b=F8FaCbzD7UWUOXhIazHoaFheGyN6akYIR//li52DnEeTNlJvi/V8d1vj2eFuMQ1Zz1Z8wMEDoXbknymJssj4sPF+C7QEhSdYwYvQ13HFS7fYy43BvLaOJJuEZ2f6MwE28f8b1Q5Medr9KQtaJCmyCVXXN2MekoYoBw9dlnjn/jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727201502; c=relaxed/simple;
	bh=Q6cKGac19Epi6PE/5CV9WLYs/FDyjReAEU46i+1W+Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPleaMTRUhFxpx2BI+EiiUC629Cw2TLpKg5W7VPoXU2pMbSVXVGucioBsYgBEYRgcFzmf7ilpoQgwnHsjhjQlG1s1iwB3YvOjyfi8YfQGN+i/5qPBBfRLEDx50JHFZ98QUlzacn6hs/R8gXsL3NiKBCGR83e9b4ClMOrx7gKxQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeRiGlqn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FBCC4CEC4;
	Tue, 24 Sep 2024 18:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727201502;
	bh=Q6cKGac19Epi6PE/5CV9WLYs/FDyjReAEU46i+1W+Wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZeRiGlqnTO8vEq6wcr8zbHJy4Pwy1F2PKwMxyjueDCq05ZI/jgAb27GJdjxMJLjzw
	 Ka+vM1w15ZGMOc5GsRfrgt0/DSrjeaeKsSHoJqPEsMLLain32y1nGCzSC5WCbxeN6p
	 Dq15Gjmg/DS03y5cCOOlw+J6yJ/ykAFNKsEKz5iYsA4y3bNjM2cx/McTa+DFroXunD
	 ib+oNu+CVEddQQRZ2gD1xXjDVpp0op0qkFov8s5H2N3oX72FKo68QL5hSzOhcSd5y0
	 aeExHd9C+WLj7ofQ/psVdamgxfpgtugyTNw3jwJxSHW0OHiw9p7V4kxCv9PNBQra3g
	 3r52XhiDXEztQ==
Date: Tue, 24 Sep 2024 19:11:37 +0100
From: Simon Horman <horms@kernel.org>
To: Elena Salomatkina <esalomatkina@ispras.ru>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxim Mikityanskiy <maximmi@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Maor Dickman <maord@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net/mlx5e: Fix NULL deref in
 mlx5e_tir_builder_alloc()
Message-ID: <20240924181137.GS4029621@kernel.org>
References: <20240924160018.29049-1-esalomatkina@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924160018.29049-1-esalomatkina@ispras.ru>

On Tue, Sep 24, 2024 at 07:00:18PM +0300, Elena Salomatkina wrote:
> In mlx5e_tir_builder_alloc() kvzalloc() may return NULL
> which is dereferenced on the next line in a reference
> to the modify field.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: a6696735d694 ("net/mlx5e: Convert TIR to a dedicated object")
> Signed-off-by: Elena Salomatkina <esalomatkina@ispras.ru>
> ---
> v2: Fix tab, add blank line

Thanks for the update, this version looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

