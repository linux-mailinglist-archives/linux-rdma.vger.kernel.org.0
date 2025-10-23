Return-Path: <linux-rdma+bounces-14020-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADFCC017F2
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 15:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5EFAC4EA7AF
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 13:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6165314B89;
	Thu, 23 Oct 2025 13:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2qEoWid"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E42930B527;
	Thu, 23 Oct 2025 13:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761226687; cv=none; b=PjXVBFmU8f2+U+5RT0FxblSt0GAr4ArvOEmZ9arDbb3slmllJjVdBV9BfIKSRKKfq1prW7ekEci8prmuEjTKBe3pvIG0h2LJpzfC1JKezYOC4jsvDpE8ERcRmo2uiYNvW70apI/KvQ+H4juAxJ8DRY5KvsovGT2iyzGsfYBcHTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761226687; c=relaxed/simple;
	bh=hJRiIku0v3R2e9HuMOMNdKlo5Q2k1VCqpifdBakfjZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qjnx8IOKmjBrqezsTAGczVhAcZD0aQzjwyA2PanAnUw9sSSWG4hikmVsbI2loS7Wc2CJnfYijqehm71efjb7KAG+Im3WAs5w8eMsntCX7qJKrCNewKPufijzx0Hkx8zarvN4bv/G0KPVeuuzMskIVwAUi/gFFK8I54vhPCVl4fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2qEoWid; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DEBC4CEE7;
	Thu, 23 Oct 2025 13:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761226686;
	bh=hJRiIku0v3R2e9HuMOMNdKlo5Q2k1VCqpifdBakfjZ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f2qEoWidFhGQ35FvTPJO1wrglL6XxkIq+/SjZ7BvTsVJl5/z86DUOwzel49ph4u4M
	 VhJiBvbEO738scaxpn+/66u5FWJl4qANcCFdz0SmoAZP9gpN/p2IdysoJBjrDeT+zP
	 g6yJeoTzdIf5ku0myNdnG8udToIjh6TdBUx7vz4J71G6Atk+8tlC+hEXkGlzlywItT
	 ZrMHUyzFYOHAeauP2nuVfJ55hx0xv2mcX3Mk9mcU54rnvukXw8DV/zey9zrbQR0X50
	 kihNF0Q8wlALF77KVmH1NMEHY9qB+iWurTcPBA+nuuMq1vu7cZTtZks2HWDfiuQfu2
	 96NDWwVe4/BMA==
Date: Thu, 23 Oct 2025 06:38:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Leon Romanovsky <leon@kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Vlad Dumitrescu
 <vdumitrescu@nvidia.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next] net/mlx5: Implement swp_l4_csum_mode via
 devlink params
Message-ID: <20251023063805.5635e50e@kernel.org>
In-Reply-To: <uqbng3vzz2ybmrrhdcocsfjtfxitck2rs76hcrsk7aiddjssp2@haqcnmzrljws>
References: <20251022190932.1073898-1-daniel.zahka@gmail.com>
	<uqbng3vzz2ybmrrhdcocsfjtfxitck2rs76hcrsk7aiddjssp2@haqcnmzrljws>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Oct 2025 14:18:20 +0200 Jiri Pirko wrote:
> >+	DEVLINK_PARAM_DRIVER(MLX5_DEVLINK_PARAM_ID_SWP_L4_CSUM_MODE,  
> 
> Why this is driver specific? Isn't this something other drivers might
> eventually implement as well?

Seems highly unlikely, TBH.

