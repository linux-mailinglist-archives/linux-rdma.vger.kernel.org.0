Return-Path: <linux-rdma+bounces-11605-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B97AAE73ED
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 02:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239E6192265D
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 00:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D07B72639;
	Wed, 25 Jun 2025 00:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uaZ5hUDh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62B31EEE6;
	Wed, 25 Jun 2025 00:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750812326; cv=none; b=CMDEU75tlnPHPAN7JhIbrod1JM4OpjNSiPdKKdrTHM4sU9Q57fXfeaEUGId1T426BLvr7YXohzWvisiS6xVRNkZ9KEoqaPzFm2SKstztsiN29/ExKja+aDx9N3Dy4IxqBU88Ydsf8xELlmouyCRBqlqIirCgPCldY7nSdeiWDRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750812326; c=relaxed/simple;
	bh=eRlCeZDC/evhY2Cx5J9+VqYhSZFBFgu/rZvpddXONDI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rlZV4hO0348Dis1ojueXhCqvg2ZXTvkaHsNfPbe70FN3QFL5TF2YPp0oz3OI9WjIbt2sYF2B8WLASAAzWnVFBH4lGjxKFBLEdHFZMwB5Uvle53cS6Azlu0lLY4hrCMCQBr68ruT21h0mcznr57LoOOqkAxisQR7XykA1ab+a07k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uaZ5hUDh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A736C4CEE3;
	Wed, 25 Jun 2025 00:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750812326;
	bh=eRlCeZDC/evhY2Cx5J9+VqYhSZFBFgu/rZvpddXONDI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uaZ5hUDh9nDsLPEBof49fExd7ukHQip1e0CJ2NXNFmJub91Pz54F5jSEnfOxskRgJ
	 cFTA7+as3bmOWQWL45D9YlQClS1wQ61w5ta67g8jlKXOgR8b76KqN9WFrJmU0Lx2XG
	 7V1+KVRJXsE7PUTWMNn2GXl92Ln6XAVk/HebbGP2lR+XXVEz6XwosQH3hn1bIiEaO/
	 SHtixl2/mu0gGNY8mZu4oLUFeTwbiF9ddoWnVe6FVD6nb0OFyg9Q+f6CmkIHvWBPob
	 xP3XbsGHEKwo9GyytkzkGzmDZCC+Js9HsaA/9fxFxPCft8CRCQ7BskPFeyXK2Q0RI2
	 Vz00B0274N6HA==
Date: Tue, 24 Jun 2025 17:45:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yevgeny Kliteynik <kliteyn@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Mark Bloch <mbloch@nvidia.com>, "David
 S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric
 Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com, tariqt@nvidia.com,
 Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, moshe@nvidia.com,
 Vlad Dogaru <vdogaru@nvidia.com>
Subject: Re: [PATCH net-next v2 3/8] net/mlx5: HWS, Refactor and export rule
 skip logic
Message-ID: <20250624174524.62bc82e6@kernel.org>
In-Reply-To: <dff4ea02-4adc-4044-a18a-ee884abc0053@nvidia.com>
References: <20250622172226.4174-1-mbloch@nvidia.com>
	<20250622172226.4174-4-mbloch@nvidia.com>
	<20250624183832.GF1562@horms.kernel.org>
	<dff4ea02-4adc-4044-a18a-ee884abc0053@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Jun 2025 03:35:52 +0300 Yevgeny Kliteynik wrote:
> >> The bwc layer will use `mlx5hws_rule_skip` to keep track of numbers of
> >> RX and TX rules individually, so export this function for future usage.
> >>
> >> While we're in there, reduce nesting by adding a couple of early return
> >> statements.  
> > 
> > I'm all for reducing nesting. But this patch has two distinct changes.
> > Please consider splitting it into two patches.  
> 
> Not sure I'd send the refactor thing alone - it isn't worth the effort
> IMHO... But since I'm already in here - sure, will sent it in a separate
> patch.

FWIW having a function which returns void but with 2 output parameters
is in itself a bit awkward. I'd personally return a 2 bit bitmask of
which mode is enabled. But there's no accounting for taste.

