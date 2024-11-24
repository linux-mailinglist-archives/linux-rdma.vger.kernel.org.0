Return-Path: <linux-rdma+bounces-6082-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 858439D6C84
	for <lists+linux-rdma@lfdr.de>; Sun, 24 Nov 2024 03:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF4F281691
	for <lists+linux-rdma@lfdr.de>; Sun, 24 Nov 2024 02:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442611E531;
	Sun, 24 Nov 2024 02:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGrwmVgc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B03CA5B;
	Sun, 24 Nov 2024 02:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732416626; cv=none; b=Xz7hxbCiKdnZZdYZv6E8RtffCKoD95iYO4CVVMpVrP2KhojPNKXuD2FNDCD1gRQd0Fo1qMMmu3fwV2KSkrjJXo4SPgl5YT0+yRkrDeLbKsGUikMToHVeVsC6PCTqsQVPYd04Ypf2pp7QRhSLeKvylT9xOPjX1Cihu8M8ECgfmuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732416626; c=relaxed/simple;
	bh=4DAbBpdVZZkEgYhQTabwG+d43KbKpV7Qgo3qiACmb/E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qymtfc4FOFVX94SGPobM5d+rOCN+LTh7T4jnkt0hItEDWRcw/gWVtXHsKdyQODAcPwcYPJe4i8skpqGKQDxLeCMIPHLR6mXuVjmU4KIR/RXzhv9Cxj6Dy1GdMZpReqJEBfsheey2qA7vmqrVHkQ4L6kjMUO6hSJ1Bj3r926hH2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGrwmVgc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F3BC4CECD;
	Sun, 24 Nov 2024 02:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732416625;
	bh=4DAbBpdVZZkEgYhQTabwG+d43KbKpV7Qgo3qiACmb/E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jGrwmVgcyHHsUAw0W7wH/E0NiYPVUHIvX7ssRRu5X4Qk7jsakCZDhLy4M6OkrNBdo
	 Wy/CXWqhnXnaQgB3qUicfci31zWWbt+cT6BgyUEGZ59foxbb3dWt46WAuTasjlO7gT
	 BPX2aGKnH1nPlrZvc3NdPCwadYlPufbVnL/jCTiZbQIBIxEIaKzfr8BbPlCBGc8Sje
	 KMTyhB5V0uFq9RHKW1E5HucA3cKb1WRUNPA6JBHpGLCm3lGLYXI3dbx0p+MJxamfP/
	 3HXqfFfFwoj7uxq+RJtzmB2/SMmzSpe7yQ5Y91DC3ologXzO//LkfVpBxk0VVPjErV
	 jTM8stzATOjQg==
Date: Sat, 23 Nov 2024 18:50:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: Saeed Mahameed <saeed@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Yafang Shao <laoar.shao@gmail.com>, ttoukan.linux@gmail.com,
 tariqt@nvidia.com, leon@kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 net-next] net/mlx5e: Report rx_discards_phy via
 rx_fifo_errors
Message-ID: <20241123185024.21315d99@kernel.org>
In-Reply-To: <1060ac7d-ad76-4383-906f-9f20a7b8174a@nvidia.com>
References: <20241114021711.5691-1-laoar.shao@gmail.com>
	<20241114182750.0678f9ed@kernel.org>
	<CALOAHbCQeoPfQnXK-Zt6+Fc-UuNAn12UwgT_y11gzrmtnWWpUQ@mail.gmail.com>
	<20241114203256.3f0f2de2@kernel.org>
	<CALOAHbBJ2xWKZ5frzR5wKq1D7-mzS62QkWpxB5Q-A7dR-Djhnw@mail.gmail.com>
	<Zzb_7hXRPgYMACb9@x130>
	<20241115112443.197c6c4e@kernel.org>
	<Zzem_raXbyAuSyZO@x130>
	<20241115132519.03f7396c@kernel.org>
	<ZzfGfji0V2Xy4LAQ@x130>
	<20241115144214.03f17c16@kernel.org>
	<1060ac7d-ad76-4383-906f-9f20a7b8174a@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Nov 2024 08:04:35 +0200 Gal Pressman wrote:
> > The comment just says not to add what's already counted in missed,
> > because profcs adds the two and we'd end up double counting.  
> 
> So this is a procfs thing only?
> Does that mean that netlink's rx_dropped might be different than procfs'
> rx_dropped?

Yes, procfs and rtnl show "different" stats.
For more context on why I put the comment there -- some stats 
the drivers are supposed to fold (error stats from memory).

Legacy stats are tricky, it'd be a major review time investment 
to try to improve them..

