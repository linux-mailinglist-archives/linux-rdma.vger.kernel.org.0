Return-Path: <linux-rdma+bounces-6527-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFAD9F262E
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Dec 2024 22:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4A5D1885C82
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Dec 2024 21:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DAE1BF804;
	Sun, 15 Dec 2024 21:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xya9Vtk5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F7F189F20;
	Sun, 15 Dec 2024 21:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734297141; cv=none; b=t+NvEz8AaoV5sR/Znv6lbFGu29SBurdvc+1KjpaidfwKYbG2h6pqLPY0ueG1zVXdopaKXUwiCJ1UdLzDx/rD3Usuiu0OgYEwH22c3fpuG3IZ5jO42iaGi0Gq1YlEIDYgmDWwazETPJ4w+GDAarGpzlf+rHVCTeZ4VsNxaEhTOb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734297141; c=relaxed/simple;
	bh=D31U1yjezZQ8gufsOjmvl7a6VTecr6RWAsPZT3BNrRg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iH92H6yLbcAV1U4lNbwt7P7TmtblqoY+e+/yFSl08hJxnrVVJ2+OL95QikrX/Y/kl7t9HaQXXnXJBnGIHyIql0EBu8MnGpA1RJot657t348RCBy2s5OYel4yBlBZ717zv4wvFA66QO+90N5BVIBhLlmrlpvAO0uY2tFVWfKhnvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xya9Vtk5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC67CC4CECE;
	Sun, 15 Dec 2024 21:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734297140;
	bh=D31U1yjezZQ8gufsOjmvl7a6VTecr6RWAsPZT3BNrRg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xya9Vtk5BtfCTyKKDlGYZTw88/7v/anzy2IoLNBBa8vtQoEDumHp+8Mvd8C+BOq8j
	 ojERMqjs2BeJW4W/GcNflNys6kNUgBTb9/OUWINeu4joZVeC/G8glhnuZ83AiDLRcG
	 /jY2PhJghmwDpuGzG4nA9gCqK5rpnnhrCQm07EwL/g0akag6Z0kfhG/Lfg8i2z3JEM
	 5bUoUcxYy+q+2g2jisCC+eGeQeYlMZHj1kFvRWEfOhj06K8B6c2qEeVgLdP+omCbT6
	 1hcHYuN8feeRr6G4O7CJVhB2XHdJPSXfl1KhMDO5jyLGSMeg3l38P5wPX8gTWbTUSh
	 NzcdGTlxpiYzQ==
Date: Sun, 15 Dec 2024 13:12:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Leon Romanovsky <leonro@nvidia.com>, netdev@vger.kernel.org, Saeed Mahameed
 <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 linux-rdma@vger.kernel.org, Itamar Gozlan <igozlan@nvidia.com>, Yevgeny
 Kliteynik <kliteyn@nvidia.com>
Subject: Re: [PATCH net-next 10/12] net/mlx5: DR, add support for ConnectX-8
 steering
Message-ID: <20241215131218.3d040ad8@kernel.org>
In-Reply-To: <1e8c075c-2fd0-4d10-887d-04a5fb15baa2@gmail.com>
References: <20241211134223.389616-1-tariqt@nvidia.com>
	<20241211134223.389616-11-tariqt@nvidia.com>
	<20241212173113.GF73795@kernel.org>
	<5b6c8feb-c779-428a-bcca-2febdae5bb0f@gmail.com>
	<20241212171134.52017f1e@kernel.org>
	<1e8c075c-2fd0-4d10-887d-04a5fb15baa2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Dec 2024 08:25:44 +0200 Tariq Toukan wrote:
> > What do you expect we'll do with this series?
> > 
> > If you expect it to be set to Awaiting Upstream - could you make sure
> > that the cover letter has "mlx5-next" in the subject? That will makes
> > it easier to automate in patchwork.
> 
> The relevant patches have mlx5-next in their topic.
> Should the cover letter as well?
> What about other non-IFC patches, keep them with net-next?
> 
> > If you expect the series to be applied / merged - LMK, I can try
> > to explain why that's impossible..  
> 
> The motivation is to avoid potential conflicts with rdma trees.
> AFAIK this is the agreed practice and is being followed for some time...
> 
> If not, what's the suggested procedure then?
> How do you suggest getting these IFC changes to both net and rdma trees?

You can post just the mlx5-next patches (preferably) or the combined
set (with mlx5-next in the cover letter tag). Wait a day or two (normal
review period, like netdev maintainers would when applying to
net-next). Apply the mlx5-next patches to mlx5-next. Send us a pull
request with just the mlx5-next stuff.

Post the net-next patches which depend on mlx5-next interface changes.

We can count this as the posting, so feel free to apply patch 1 to
mlx5-next and send the PR.

