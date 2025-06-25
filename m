Return-Path: <linux-rdma+bounces-11634-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F48CAE88D5
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 17:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2BAB188E5BB
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 15:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6A229B771;
	Wed, 25 Jun 2025 15:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="her2VXI5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C85289823;
	Wed, 25 Jun 2025 15:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750866781; cv=none; b=jtnLbfTrKBoEllersvlj4jVgesGPMgR8jVQQmHMHV7zqMA86e3N1ihtekVk+k5Zhm9P2PA5AfxTp2GNPiPmqBXaS2xIlYRR1Ql5jKd/Yh/MhAdQO6bdYcXza07y77VC1yroHBwaMj/JJ5KrtWWAQAj2HtLGVibK6FVf4sNVew7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750866781; c=relaxed/simple;
	bh=wJr3lTEcACk8ZgTOHu4mBJSTq5WxmTVcgVswph5NjNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sayZU2ElrZP0LTChXiEG/7nHsQyvHskqBTRuHM0pOIgSkuQXRVM5aB3T6nPfYxEV7untTaO/1itVFk07EqebEMmrZ92DSVX6q8bkqWCn6R0Av1Sa3IqOe0SP7A4gXhTmIE9RIEQT79tLRy5o9PpOXPOlVckNT60hNhnV9AEciWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=her2VXI5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFADC4CEEA;
	Wed, 25 Jun 2025 15:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750866778;
	bh=wJr3lTEcACk8ZgTOHu4mBJSTq5WxmTVcgVswph5NjNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=her2VXI5T6fidaQBCNMSBb69v/Bo9nnng0ImJm2/lLK1YezmAfAduVpvP+el48wVC
	 vA6+Bgd9D+Mz24BbHSDkYTuHfILhw+CEHKwfG0iEXV3vguarzkFK/Hkbfuwt8lKWzh
	 wqV6GtC74va2jFQZgTRS1bQ6JcZrSiD76fEChDuQIXQfT/oqjn3LdaxfLJWsARGwi1
	 DsJp+kXR0z+Su1xK1gol9zp0T96iDIbjdJ6iGv/e5WUAwbQL6KvwOK0h+k2OGHfT5Y
	 pSZb3HPHW9qRkFCInPjFBH7/QoxpQIIl+mUePaoUrNOsUHFDeD0lv4QjLCq2M6UKHv
	 7+vqgsDrtY+eA==
Date: Wed, 25 Jun 2025 16:52:54 +0100
From: Simon Horman <horms@kernel.org>
To: Fushuai Wang <wangfushuai@baidu.com>
Cc: saeedm@nvidia.com, tariqt@nvidia.com, leon@kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net/mlx5e: Fix error handling in RQ memory
 model registration
Message-ID: <20250625155254.GF1562@horms.kernel.org>
References: <20250624140730.67150-1-wangfushuai@baidu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624140730.67150-1-wangfushuai@baidu.com>

On Tue, Jun 24, 2025 at 10:07:30PM +0800, Fushuai Wang wrote:
> Currently when xdp_rxq_info_reg_mem_model() fails in the XSK path, the
> error handling incorrectly jumps to err_destroy_page_pool. While this
> may not cause errors, we should make it jump to the correct location.
> 
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>

Hi Fushuai,

Unfortunately this series does not apply cleanly on current net-next.
Please rebase and post a v2 so that the patch can run through
the Netdev CI (aka NIPA) which is part of the process for patch acceptance.

Please include the tags provided by Dragos and Zhu in v2
unless you make material changes to the patch.

Thanks!

-- 
pw-bot: changes-requested

