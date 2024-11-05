Return-Path: <linux-rdma+bounces-5751-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346609BC36B
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 03:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B72EB21AAA
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2024 02:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E3D4D9FE;
	Tue,  5 Nov 2024 02:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="thpCjR7c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5F7282F1;
	Tue,  5 Nov 2024 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730775185; cv=none; b=fNuazJ37UPMuDMn264dZdSZjbSq8AaozEuuBqQ0Xp1f7N6lGY13DUmZpHKYJHDbm4fMai8RHvql8XDFxC+JUoBYMMLaR8SY65GgeE4ylHASYnnAXM7hNNAIrGlGmxr/x8a7y+ZeIPaInIa0xSKKGlTL0xQal6ToCiNEyQ2atYJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730775185; c=relaxed/simple;
	bh=1qmzJIwmE8WW1S+B7qOmsPydoNDODsO1wYlU0wp3Wtc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FYzZckdSwiVCWURJ+DAnbr/KjGixpOxgbk5Gk8IzajyNBQhKa4HMWdDltAZiqUcWgcR4h3uY598xWpDG02wVIzvS1JPaCKnNermISx3IjW48tMd12QB3LyKeHp7F2DuubgAXF121Qb6XgGZps/AOpsgL1iTV3WeCYEZ3OVY0YwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=thpCjR7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3274EC4CECE;
	Tue,  5 Nov 2024 02:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730775184;
	bh=1qmzJIwmE8WW1S+B7qOmsPydoNDODsO1wYlU0wp3Wtc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=thpCjR7cC0mu2lwBL6XNG5lP2KhFQiQ9i7YaK5hwBAwG8rPx39i2C8Z63pojdB8sq
	 odkssaSTOVf8gQFv6hx183Vqj0EMSQch3viNgdUPfV48L4O0a/znZDgOQWuZ9oj7Lu
	 3HqpKXTyKSX0P/oCLSj6wqJk/C0f/Nlrhpgb0DlZlVfVvdOJEs4DO+yk41sakMZ8QJ
	 zXDB4Deh9jpj3W14LioPo/v0WOargNhSFyS58IhxAn8EXm3rpRFaL2FGxZB0mWjSSq
	 X+UDGDW+elUAxHfcVKdCi1aJaUrEimUPFO0anZhOdLYNPH6WMm/Mvshfi6IkNEMGZM
	 jTVeWIHrPNaAw==
Date: Mon, 4 Nov 2024 18:53:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next 0/2] Introduce mlx5 data direct placement
 (DDP)
Message-ID: <20241104185303.1b83bf8a@kernel.org>
In-Reply-To: <20241104082710.GB99170@unreal>
References: <cover.1725362773.git.leon@kernel.org>
	<20241104082710.GB99170@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Nov 2024 10:27:10 +0200 Leon Romanovsky wrote:
> Jakub,
> 
> We applied this series to RDMA and first patch generates merge conflicts
> in include/linux/mlx5/mlx5_ifc.h between netdev and RDMA trees.
> 
> Can you please pull shared mlx5-next branch to avoid it?

Sorry I don't have the context, the thread looks 2 months old.
If you'd like us to pull something please sense a pull request
targeting net-next...

