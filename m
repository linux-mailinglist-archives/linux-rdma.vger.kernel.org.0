Return-Path: <linux-rdma+bounces-8163-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3957A463B0
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 15:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88AC27AB947
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 14:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B74D221736;
	Wed, 26 Feb 2025 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXaLZQ+S"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3986B1A238B;
	Wed, 26 Feb 2025 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581439; cv=none; b=KMruo9u4o+FU8EmXqgQ9VXLwNzPv079lGZA4oKNmYTY0b4E0FVCRTwcVZzAoADfgsasMXj1t/fxbE9dwbDX6dV5mpGwqfvZ7IkxBmuW3SPiJUhl+iY4uMjzPDPZ7vxAmfwcAZgFMGnMRZIL7S76ASt6rSf9lTzUAGcy5VIXYVpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581439; c=relaxed/simple;
	bh=Sg6xj1pSG77IZf0ZsBqSzs9LHoQ3MxtkB2O32en+7ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fydukjmCwZb1Lr0k84nhTvfjgFot8JwQuTQL2Elldjt21/N3STKkj670QpFhsl2w2hVpe7Frq50Dmw18ama5KudmSCxs2W51RLcyqvMy9Akkuod6x+ewCG/VneLLTV0ulARwSgjDPghPPrT8fV1zsnBuMBhf5Z7WhcFxyTo/ATo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXaLZQ+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE55C4CED6;
	Wed, 26 Feb 2025 14:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740581438;
	bh=Sg6xj1pSG77IZf0ZsBqSzs9LHoQ3MxtkB2O32en+7ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gXaLZQ+S2iMK89Oo3bdHI3PVdociGD0l6/8FLuJ7Gfylz8e0vHbMoSHUK+MA27Rv2
	 F6DLzG+WZZiBbwEtnHazQHAMO+01fcRJ4f2HfZLAwLhGAX0l46BD/INizN5KRcX1vw
	 ab5M2X71Aip/I4ecsHhCDQuOiTOkzv5nxIhefk3Z0I2n9fHHGu6rAJw6l3Es3Nalsz
	 74qt7adw0DWdM2JSDKhDIXiRt4jZFqMbtisptc2DR39m6Kp4R7RbYrTyF8ja4UeV/Y
	 Ga+covJgGxKnXELHKqnP2t6mwl1PGq8KZ8hTLM8A32Kb+E6sH8iC1bmhl4tSK+N8Ge
	 suQ8vkI0gVZig==
Date: Wed, 26 Feb 2025 16:50:34 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Maher Sanalla <msanalla@nvidia.com>,
	Parav Pandit <parav@mellanox.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: RDMA: explicitly enumerate ib_device attribute
 groups
Message-ID: <20250226145034.GK53094@unreal>
References: <20250226033526.2769817-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226033526.2769817-1-roman.gushchin@linux.dev>

On Wed, Feb 26, 2025 at 03:35:25AM +0000, Roman Gushchin wrote:
> Explicitly enumerate ib_device's attribute groups.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Maher Sanalla <msanalla@nvidia.com>
> Cc: Parav Pandit <parav@mellanox.com>
> Cc: linux-rdma@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/infiniband/core/device.c |  4 ++--
>  include/rdma/ib_verbs.h          | 14 ++++++++------
>  2 files changed, 10 insertions(+), 8 deletions(-)

Very minor comment as you will need to address Parav's comments anyway.
The title should be "RDMA/core: Explicitly ..." and not as it is written.

Thanks

