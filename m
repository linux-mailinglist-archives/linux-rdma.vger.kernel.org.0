Return-Path: <linux-rdma+bounces-10526-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DC7AC0A63
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 13:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FD411BC68C9
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 11:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C9228A1C0;
	Thu, 22 May 2025 11:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5yVYn8H"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999A0289E2E;
	Thu, 22 May 2025 11:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747912399; cv=none; b=Ia9aE04X4fkGuh0bxLXmRM0MPYjXJdR1ls3GXQHe9yeMXtJPlsL/G2BxzsRuATUnalZQTj+Ca+qg0kvAkbfe5bhGcpxGEROXJLnoUoPvZAE7sexeHOWvw7jDn02W0uLGE0ajFmB+PB3MtauzrWOO375yHcrWUrZFyGr91lE1Kag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747912399; c=relaxed/simple;
	bh=ZwwA/o/TNYA7wSsv0NgGXFCsUAhB5QwH83/RnKb7DYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnDs4G7P/JUkQTRtpgTeWQdUikayc34K+2sgb3Xhw64e5/BfKKIIi3HnOq95/tT3rSGSlBqFIvzDKMJfJ48IH1U5tJEJkXd1qx+p4p8GjSswwlBzmklIzueR2DsR/LQ4IuC62TCcf4Lrykr7VUccJu5H49zGmQ1egvjQXbnbDt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5yVYn8H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC52C4CEE4;
	Thu, 22 May 2025 11:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747912399;
	bh=ZwwA/o/TNYA7wSsv0NgGXFCsUAhB5QwH83/RnKb7DYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C5yVYn8HreJgTH33PXjnbBBlHtspTRcIoZvg7x1kenTpEI+EElvo3BunlubUiNJsS
	 BBQamlF5UAU+Y+nmklNwtkf2+zxaHIKFcyqI+M3hzHXfZt8zvenBHTgGKZ3UZJbOzX
	 07CNZ0fTJb/7a81OoY74/wn03oRHMML7AEHP0tV/xLUg24YgINWIxsQU+rXbY1RgGp
	 ZuT7wo3XREgNxfdufgV4xB0JWIpz7I90eVqjlbDpRNfdilAVbTm0VCw6pT7tDoI/JP
	 CzNDBqFVSeddFCK3NUlF8eaGdwDSz4VStU3K3wNwOh1LYVRrVZQjfWgmAVyxiom9uC
	 4IwWUZKZXsaKw==
Date: Thu, 22 May 2025 14:13:14 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: saeedm@nvidia.com, tariqt@nvidia.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] net/mlx5_core: Add error handling
 inmlx5_query_nic_vport_qkey_viol_cntr()
Message-ID: <20250522111314.GP7435@unreal>
References: <20250521133620.912-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521133620.912-1-vulab@iscas.ac.cn>

On Wed, May 21, 2025 at 09:36:20PM +0800, Wentao Liang wrote:
> The function mlx5_query_nic_vport_qkey_viol_cntr() calls the function
> mlx5_query_nic_vport_context() but does not check its return value. This
> could lead to undefined behavior if the query fails. A proper
> implementation can be found in mlx5_nic_vport_query_local_lb().
> 
> Add error handling for mlx5_query_nic_vport_context(). If it fails, free
> the out buffer via kvfree() and return error code.
> 
> Fixes: 9efa75254593 ("net/mlx5_core: Introduce access functions to query vport RoCE fields")
> Cc: stable@vger.kernel.org # v4.5
> Target: net

"net" should be written in subject and not like keyword.
[PATCH v3] net/mlx5_core: Add error handling
->
[PATCH net v3] net/mlx5_core: Add error handling

Thanks

