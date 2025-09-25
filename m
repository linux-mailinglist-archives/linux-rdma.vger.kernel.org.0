Return-Path: <linux-rdma+bounces-13652-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBCCBA0232
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 17:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 392324E7CB0
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 15:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33CB30C604;
	Thu, 25 Sep 2025 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VO8f/5TT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0AD30C344;
	Thu, 25 Sep 2025 15:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812619; cv=none; b=MgQkf2ut5/z83VVA8YJ+qVP28d9SiZJXsmbDdNMEOzCRv5kjwbAcUp3mRPGmLyhKQJg7+Op2rFZ9nLZSBXgiALrQP1AUYnjROLhKPbrkMmoraFp3EjlbswMqKtd5aLxmHoLgrO83blKdElwQtyN+BACyiBXru8Nsxf7tw1HAstE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812619; c=relaxed/simple;
	bh=YLj9LQbtQI+tc2nPwoeJdg1nyNdISQl513AIqL0rMZc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M9+VGUiq+SYMCw0dEitQin85Y05fkZRW75lL9sCGzC3k0cOCtDmzdVV6fIiSJwOPRxYxnH26Xw4Z1ocItM8gzgtkMfnhvG+EGa094j/KnQ5HFrAnFH8gmXw0idPOsD9crRiWQfu6yOzztql4VxvoFeLRj5+vXOmczn/bsgm29LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VO8f/5TT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29311C4CEF0;
	Thu, 25 Sep 2025 15:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758812617;
	bh=YLj9LQbtQI+tc2nPwoeJdg1nyNdISQl513AIqL0rMZc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VO8f/5TT81srH94PJ4wDIphighkw3ad4wj6eTRqH6OwrA7c08bnQV3Hn6gaO1oDC1
	 jDfN8MhhfrgUoDXuDFwZPq2inY6SB2YQm10F1aEmn0uPViKhvkRb5Jw7bdKPFov4t3
	 U7gGMvjnyorGnsbpY6BbPa78ST0KC2NFiXxpl4Zj6wlmG5wkktGc26lgX0IYOvJzE1
	 0KgpeD47xOr4665RzzPUZB0sJCrCrI9V8De8lCe7qfn+ePmIWAOYwBStkyjNgGI72N
	 b35nuzBJPfbBPWSj5S2IDvpsLjzFr27UY4bdNBj2hA+RLI/O4K7AdF4GZe5LKYqjA5
	 fn0pKgMa072Yw==
Date: Thu, 25 Sep 2025 08:03:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Saeed Mahameed
 <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Gal Pressman
 <gal@nvidia.com>
Subject: Re: [PATCH net-next 2/2] net/mlx5e: Clamp page_pool size to max
Message-ID: <20250925080336.7c78a9e1@kernel.org>
In-Reply-To: <wjdkpgpgsoe2igbf7w5padgrbjbog6srktov37unmfouuwn6ox@its3txxslpe6>
References: <1758532715-820422-1-git-send-email-tariqt@nvidia.com>
	<1758532715-820422-3-git-send-email-tariqt@nvidia.com>
	<20250923072356.7e6c234f@kernel.org>
	<a5m5pobrmlrilms7q6latcmakhuectxma7j3u6jjnamcvwsrdb@3jxnbm2lo55s>
	<20250923082310.2316e34d@kernel.org>
	<20250923172305.0b0a235c@kernel.org>
	<wjdkpgpgsoe2igbf7w5padgrbjbog6srktov37unmfouuwn6ox@its3txxslpe6>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Sep 2025 10:25:40 +0000 Dragos Tatulea wrote:
> Should the page_pool should print a warning when it clamps?

I don't think so, goal is to avoid having all drivers copy the clamp on
their side. So if we still warn drivers will still have to worry.

> Also, checking for size > 32K and clamping to 16K looks a bit weird...
> Should the limit be lowered to 16K alltogether?

That's what I mean, replace the if (>32k) return E2BIG; with
size = min(size, 16k).

