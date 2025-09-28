Return-Path: <linux-rdma+bounces-13692-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3821BA6A3C
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 09:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A19C717B329
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 07:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC0124635E;
	Sun, 28 Sep 2025 07:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWk9ZmNZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845E4824BD;
	Sun, 28 Sep 2025 07:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759045287; cv=none; b=Frw2JFF3QvKnVZbs938hF9tLH4a9QHjqabZYq+BVQZwz75L9Gjr+fmgDcUj1ympfDzUJ81qLMx08Eczwd+8z1vUmAH2i+cBQxXTHnMbZep2h8dtLuNIeM/muix0mC5/JvTlAVYOgipmUjlXGB0wl6zgCinCgsO109rQnpkVTRoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759045287; c=relaxed/simple;
	bh=bBOFmmieFxpywE8skbkqA5vvYU7CCOY+RQzMrilZhoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXXh1yurPvzivHdePxJTnWT+IXtsI+Aj5Py+cCLBiM80nGK0VfsUwl5vALaG7N8IG0MQ2RyjQEP5ZeKxqbFqu+CCXIler0bX6jwhNq7mx40EOJicW9tuhEvZ21U8XpdLUEGLcyBa0LmtBRYcd7wp/prRMvxIZPs2wvzcSAfZy3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWk9ZmNZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98677C4CEF0;
	Sun, 28 Sep 2025 07:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759045287;
	bh=bBOFmmieFxpywE8skbkqA5vvYU7CCOY+RQzMrilZhoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bWk9ZmNZbRuzxKU7mGCHNSZv22Y98kN5EEBIBdB7ywsjKsbmFl5RP5Bk9KMnj4mWr
	 /0ear5+ZTJX1e1w1XftqHiKs4BscuLBOiy5B2aCiseCEGKQsvvFodIbvqHPTNnhqHy
	 eM7RcV6/DkBueQULYzk30MzGy97HfNdU8S/cIBw6+5txgsqtKWZ9XYUyjTLrUMCn5Z
	 0ezxoLkL9Jtjs4gaj+5pE7hV6ZiNruvGIfFQNvrh7TDcJzamH+tBsrFGkoDvIsflJW
	 oeQml9Ns2FqMFI5CjTSligPXHgJNQ4JFWFs1IpMWoZddHD9KO9ZYj5E2oByBXi9IRz
	 XEbbYFJbPFTTw==
Date: Sun, 28 Sep 2025 10:41:22 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH mlx5-next 0/2] mlx5-next updates 2025-09-22
Message-ID: <20250928074122.GC12165@unreal>
References: <1758521191-814350-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1758521191-814350-1-git-send-email-tariqt@nvidia.com>

On Mon, Sep 22, 2025 at 09:06:29AM +0300, Tariq Toukan wrote:
> Hi,
> 
> This series contains mlx5 shared updates as preparation for upcoming
> features.
> 
> Regards,
> Tariq
> 
> Mark Bloch (1):
>   net/mlx5: IFC add balance ID and LAG per MP group bits
> 
> Tariq Toukan (1):
>   net/mlx5: Add IFC bit for TIR/SQ order capability
> 
>  include/linux/mlx5/mlx5_ifc.h | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Thanks, applied to mlx5-next.

> 
> 
> base-commit: a3d076b0567e729d5f21a95525c4d096b1f59e79
> -- 
> 2.31.1
> 
> 

