Return-Path: <linux-rdma+bounces-1071-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A5685B44C
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 08:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7852D1C22ABE
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Feb 2024 07:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44325BAEE;
	Tue, 20 Feb 2024 07:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvXRzcza"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990B75C5E3;
	Tue, 20 Feb 2024 07:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708415840; cv=none; b=QaRUDw0pzCBu6cLKgh1S1dygJrWWkps0cAXUsBNJ6srNvy4zKs72nxAHHjKT5bu7gnhVJtni3r7rTgY8tDfA3hOTpOvqygWB6OYCEKfoaVfSiQvF0RpD5XpwYQC7jBQ/3VBFqbVRMoj6xIFGNuW2RDOMO2x5lXNA8CCkZ92DQbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708415840; c=relaxed/simple;
	bh=1JAH+k0oC/h1bHslHgVC/nrMngLSq2FgOoqTHYPd184=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hw0rMDJy9Lhmud766KwLfx6V6SWCSMQjkPLw+shEpxCPrGB/i/3LWZsFjkmjGBYEXlao8tMKR8+b1ayf8pjIl7rhON+c8bz4wLntEZ89T2vCK+MeueYMoZoBNcZ73uetoyiWRx4Sduf3/P4hs/fZbaP4A+dCBKio1sc1zrXuxQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvXRzcza; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7734AC433C7;
	Tue, 20 Feb 2024 07:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708415840;
	bh=1JAH+k0oC/h1bHslHgVC/nrMngLSq2FgOoqTHYPd184=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cvXRzczaupLox1sUg0b9gC7YiQvGh3OvZuqQwbpkRJIrwdKvvp8F6UHt6StQ+yg1N
	 G2jcx7lJyUnCAHwHaYyJSMUH0obcu2xSs6NBay1qdrZnGa0qDZjpzXbTOCOLp3GmUg
	 Xty4aGH1n0BLB0libaPnj4G3mG+gIJy8lO8eI8wyGU2XuF9lDjICmxDPHr00OZ++ZN
	 0nZmDLp2NU+aDyrSPD2Ux+oB2gPNQ1psbaabu9at8v64rqBPwrA4xXLLurLkheyaIA
	 cJoqs3FJqCK4GqVNdq8R7UV4bf9nzWYjZF4HeA2eBYFeS/JRcbML+Z7sv3XRIl0yrm
	 K8e3mxKe63I1g==
Date: Tue, 20 Feb 2024 07:57:15 +0000
From: Simon Horman <horms@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Or Gerlitz <ogerlitz@mellanox.com>, Eli Cohen <eli@mellanox.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next] net/mlx5: Use kasprintf()
Message-ID: <20240220075715.GP40273@kernel.org>
References: <9bb8d927ec172df227f84694dfa5769623f48c89.1707562340.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bb8d927ec172df227f84694dfa5769623f48c89.1707562340.git.christophe.jaillet@wanadoo.fr>

On Sat, Feb 10, 2024 at 11:53:13AM +0100, Christophe JAILLET wrote:
> Use kasprintf() instead of open-coding it.
> This saves some lines of code, avoid a hard-coded magic number and is more
> robust.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> If you consider it as a bug fix, should 'name' overflow because of the
> hard-coded limit, then:
> Fixes: ac6ea6e81a80 ("net/mlx5_core: Use private health thread for each device")

TBH I am entirely unsure if an overflow can occur.
But in any case the change looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

