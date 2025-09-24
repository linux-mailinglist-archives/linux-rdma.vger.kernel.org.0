Return-Path: <linux-rdma+bounces-13609-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAD8B97DC4
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 02:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C36319C5374
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 00:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBCD139579;
	Wed, 24 Sep 2025 00:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FS2sc7H8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461D611713;
	Wed, 24 Sep 2025 00:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758673387; cv=none; b=OQBwqP+NbWpaDQ9AVUi2WLG5jhFLyPoxiz1PnVQoFhBTy7hUb862JvcJmHT0Rp1xOcoSXv4pbWngHSzqACWhhJk5Ozr+s5Ko53kR8DJPBMeFD6hVvyK8pz1N1wAUxqIhHsJz+J12wrJpzSag3tRQzNmX9vAqN8nvVZIOxYMVS1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758673387; c=relaxed/simple;
	bh=Q49ErjX63skoRzbRTKbC/mbHbaOv77wj5TsN6nz9RSo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ixbAbYmioaQ32cxp5sMQMT7kScfRQfUIUfC4XMZNgS3A3+TXXw7cDqcHI6fBy9NG60n8V0at/4CacTHoTAcP7MeJ6vQ4VFHH8XjTVDR7RO4nDnrjGTeezJTUpbdGiXrSrk2Fx7gvlgKM9BRUfYoJr3bnIKUBgCtCYrQ86LceMCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FS2sc7H8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F565C4CEF5;
	Wed, 24 Sep 2025 00:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758673387;
	bh=Q49ErjX63skoRzbRTKbC/mbHbaOv77wj5TsN6nz9RSo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FS2sc7H8x66n7f9HgirVBoMGdQz8mAFQjy50OnsqV8dHQsLJcmO0FNzKeXdxt8QA9
	 Zpw2PLZZ0o/Je17GMrw+GC4OXAWGCi6Zk6TSKjmPeh9+Io5M8mU5hKUkr2mPm9LMu/
	 gWcChmm6+PtM3iqRD4d6/QHPPYJ9qD8IbL9mWOak+J47WqWFevEeM1UzEZo8O8KGaZ
	 EBSTu9h8EVsuT5Q+BOWwtVk9hCj2BO+YkolCOTKdT4tW454Idq2Jx8vMiIE3WLKWCo
	 dJiRcNtGRTgf4C3C1ZFQPb5maF+VfgZx3RSf/wEM7nJOpfDqIsK/EhK/NxRDyL3Hik
	 /i7qu3M88Unmg==
Date: Tue, 23 Sep 2025 17:23:05 -0700
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
Message-ID: <20250923172305.0b0a235c@kernel.org>
In-Reply-To: <20250923082310.2316e34d@kernel.org>
References: <1758532715-820422-1-git-send-email-tariqt@nvidia.com>
	<1758532715-820422-3-git-send-email-tariqt@nvidia.com>
	<20250923072356.7e6c234f@kernel.org>
	<a5m5pobrmlrilms7q6latcmakhuectxma7j3u6jjnamcvwsrdb@3jxnbm2lo55s>
	<20250923082310.2316e34d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Sep 2025 08:23:10 -0700 Jakub Kicinski wrote:
> On Tue, 23 Sep 2025 15:12:33 +0000 Dragos Tatulea wrote:
> > On Tue, Sep 23, 2025 at 07:23:56AM -0700, Jakub Kicinski wrote:  
> > > Please do some testing. A PP cache of 32k is just silly, you should
> > > probably use a smaller limit.    
> > You mean clamping the pool_size to a certain limit so that the page_pool
> > ring size doesn't cover a full RQ when the RQ ring size is too large?  
> 
> Yes, 8k ring will take milliseconds to drain. We don't really need
> milliseconds of page cache. By the time the driver processed the full
> ring we must have gone thru 128 NAPI cycles, and the application
> most likely already stated freeing the pages.
> 
> If my math is right at 80Gbps per ring and 9k MTU it takes more than a
> 1usec to receive a frame. So 8msec to just _receive_ a full ring worth
> of data. At Meta we mostly use large rings to cover up scheduler and
> IRQ masking latency.

On second thought, let's just clamp it to 16k in the core and remove
the error. Clearly the expectations of the API are too intricate,
most drivers just use ring size as the cache size.

