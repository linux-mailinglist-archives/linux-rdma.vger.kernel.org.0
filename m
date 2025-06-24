Return-Path: <linux-rdma+bounces-11599-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08443AE6EBC
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 20:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA801175B35
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 18:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83E32E62BE;
	Tue, 24 Jun 2025 18:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yxj/vyUs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC5E2C3278;
	Tue, 24 Jun 2025 18:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750790319; cv=none; b=fg5l47pM5QfVfweyBS+XIhhAIu5D9KmSYiwwa/r4GlDT8qGHYd9l4LeWeR+lwccmV0264TLKRrCehR961JLc689vbG36KKnSZoFoLUx+9xRkTMYr9Yi7nKcx/PL6crP7aj9pNfYyjARRktXZgKlUg3WOqsHfwHyLVa5rBMFsTB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750790319; c=relaxed/simple;
	bh=12MGJ3lrmmFf8OkAfAXMJKKOW6XXzpBxQ94ei8UVurU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZ5gEBRXZcP7l2+Klrbx69giLrm4s/mo1hBZIFQI0/jYe5twTO6EBQejRK2QaD+84bUHw3p8H4HP6mLh6SBDJuGdSM1jxzqxVfEy///o/3z2RGT+lf2IM5zUEhFV2txbgH1Ku6mh8PjL+3ku2jeC2sBYyCsHPmBtdQglRSiLt3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yxj/vyUs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19231C4CEE3;
	Tue, 24 Jun 2025 18:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750790318;
	bh=12MGJ3lrmmFf8OkAfAXMJKKOW6XXzpBxQ94ei8UVurU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yxj/vyUsUz73mlrmv3JeBmXcjnkGJ0jnZacKsBhZJ8WQRgH4235IgO0KlAt6D1/Bz
	 Zlnx4NAZiPzM6ap6/MV7xyVcvv463zsW6pQZtE5iAgV9eg8hYTT3A2iG69RwSEp4VK
	 DxcYUiYbfo6GDIzh25HzxYN9+l5ZAwLWGfeNnBysOlaYz5RUFIaRI059VTO2339iM2
	 8o107MHcvLdTn3ANXS0e0GGKVPyos7HOh8I8PHYwU+Eu1du85YTZIQCSQ0DksFLKUp
	 0AdRT8Hrnpv+ZKqvnT9tyOu7H3pDUcs3DI9UGoA/6fJwAtkhO9AhZUw9IF8F+rdNv/
	 xMjJj7qJBMJGA==
Date: Tue, 24 Jun 2025 19:38:32 +0100
From: Simon Horman <horms@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, saeedm@nvidia.com,
	gal@nvidia.com, leonro@nvidia.com, tariqt@nvidia.com,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	moshe@nvidia.com, Vlad Dogaru <vdogaru@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: Re: [PATCH net-next v2 3/8] net/mlx5: HWS, Refactor and export rule
 skip logic
Message-ID: <20250624183832.GF1562@horms.kernel.org>
References: <20250622172226.4174-1-mbloch@nvidia.com>
 <20250622172226.4174-4-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250622172226.4174-4-mbloch@nvidia.com>

On Sun, Jun 22, 2025 at 08:22:21PM +0300, Mark Bloch wrote:
> From: Vlad Dogaru <vdogaru@nvidia.com>
> 
> The bwc layer will use `mlx5hws_rule_skip` to keep track of numbers of
> RX and TX rules individually, so export this function for future usage.
> 
> While we're in there, reduce nesting by adding a couple of early return
> statements.

I'm all for reducing nesting. But this patch has two distinct changes.
Please consider splitting it into two patches.

> 
> Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>

...

