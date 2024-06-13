Return-Path: <linux-rdma+bounces-3143-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA82B907EEA
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Jun 2024 00:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D1741F2227F
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 22:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3840814C585;
	Thu, 13 Jun 2024 22:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsZ/UpTm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56CA1411C3;
	Thu, 13 Jun 2024 22:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718318176; cv=none; b=GNgd9RSJw5nEeGUYoMJczyicYuD8m9tnYO12v7Tu6mGwE1vTyWcAJ6CSyMZ55nBHUea+lUiv6LVcVxzseD/DR+DLkuOqUKHG0fsFzHLvXcjCsFuvpIL090D1ndc7Vfpuj3EcZcLmbtplDyk8YlqjnK6FLwReuL4W1PPNX+ssY1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718318176; c=relaxed/simple;
	bh=tmRXKHGJ5fDdBPnMsyaNw7YI1zgFugypm9sz3cbHjFE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LspTJCKkLKZbEXu4gDBk6AwBAarnatDljwkG+HYN3eR0KsRwx8YqYlEmQ/BwgmOCjaUPtf3X7G7Cl5sEZegtg/WBSUyonJGG5mLeRWINoQE9Eu01l8gCzAZgpsxroDyq8ejmXoktWz+R5kaj0jgAGjd7UAEg6DNWjtSvyvxX+Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsZ/UpTm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC97C2BBFC;
	Thu, 13 Jun 2024 22:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718318175;
	bh=tmRXKHGJ5fDdBPnMsyaNw7YI1zgFugypm9sz3cbHjFE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EsZ/UpTmdTpmlzJrmLGauQmNp1wqpFuK4EfgJbCcFTBaZyqMGn3p21OI1OlVtrJF7
	 dquyLfoz0lxw8qZIU9vxm65oIvTztGQ24Q7DrCTZ/1Y3etpzBqR22fWZKB6bF12jEJ
	 m+WbafKBGD3tf+MwsZqpyBxrll46jQF5oXJ4dOgFecK1jZ9DZWw0+r3vau9MEDxxL4
	 JD7/ZoDKyJtiKJVW99adbE7QRrf0HvPS72Mu8SAkTvAFNmCi3qvP0hxfqj1DCFt3w6
	 TmJNtvItpc/85a6+Mz7/RKmxZuK36tz2DZV/btow5v8YY9geRXQ1K+XHfllE578Efu
	 SQXtedxndxwSQ==
Date: Thu, 13 Jun 2024 15:36:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, nalramli@fastly.com, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, "open
 list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>
Subject: Re: [net-next v5 2/2] net/mlx5e: Add per queue netdev-genl stats
Message-ID: <20240613153614.3d758093@kernel.org>
In-Reply-To: <ZmtusKxkPzSTkMxo@LQ3V64L9R2>
References: <20240612200900.246492-1-jdamato@fastly.com>
	<20240612200900.246492-3-jdamato@fastly.com>
	<0a38f58a-2b1e-4d78-90e1-eb8539f65306@gmail.com>
	<20240613145817.32992753@kernel.org>
	<ZmtusKxkPzSTkMxo@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 15:12:00 -0700 Joe Damato wrote:
> If you have a moment could you take a look and let me know if I've
> gotten it wrong in my explanation/walk through?

No lies detected :)

