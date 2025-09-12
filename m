Return-Path: <linux-rdma+bounces-13300-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 01980B53F6F
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 02:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE4AC4E114B
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 00:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8094C6E;
	Fri, 12 Sep 2025 00:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g84ZqIXI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843132AD13;
	Fri, 12 Sep 2025 00:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757635890; cv=none; b=iy6I3i1aYFzhDs9KLruIYiZDv0mlgmg8i508vCHxI0WHG6OqfMdfCn8YNAgpLtMz/Vp4lks5zfe4mFwl+DsMwTuXYtjILXZYqzBOWkekdq/nImOCo/1ZOeB5k1YFQGkXBSmtAJ8Ifa1ZxlFT9+QtNOzr9Lg/KZ8bBqla8Fh4yHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757635890; c=relaxed/simple;
	bh=kMSq6f7BZjti9F7DmtATF2p14qNOOcc1t/6T4gwRn/4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KZBKfxtI9teAoVGKBo420nzpMlyqw0FOW2oXleW2fgp5lASskaU5+sLlFd9+0IQkT/x4LDy9vbHlj/r+1oV1G7bw0GmuCfy61iZWVDKnRQdcKtYn4ZiUBOKjMgh9/3unxYOcfC5o2xauJ3g/YQjBJIzmzRFa069q9Cvb6A4OHS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g84ZqIXI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A07C4CEF0;
	Fri, 12 Sep 2025 00:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757635890;
	bh=kMSq6f7BZjti9F7DmtATF2p14qNOOcc1t/6T4gwRn/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g84ZqIXIZfENDA5soIt+2NaCJegz3+0URbc+aM1Yo8uN7sBn/9RvaDjYL9uzNBLnx
	 nz+aXLKwTa8tfXfMhmjbtpw++Lga0s114XeJhENk0U9/xz7NHcsig1/Y4XGMwz9qR0
	 8k2DIvBA4wEmWM0xdVA7XMwEeH+bG6GBSXTPNxo3vAV5j/8NwERPew+n/qnNtfRyep
	 otTgVIet0JWK+Wpuu5wosY3h/7uXpLK36EgYjC2OqTTQto6fBuzI9aO7FcgUqjhyAx
	 jRzhnaJ8ue9LZdp6GUkCW/NxvBnxuEjNDtM0xIgoaoZ/QfE/YYnzJ01za+75xdeafG
	 PVsfp7a483Pzw==
Date: Thu, 11 Sep 2025 17:11:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jianbo Liu <jianbol@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Saeed Mahameed
 <saeedm@nvidia.com>, "Leon Romanovsky" <leon@kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, <netdev@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
 <gal@nvidia.com>
Subject: Re: [PATCH net 2/3] net/mlx5e: Prevent entering switchdev mode with
 inconsistent netns
Message-ID: <20250911171128.42d0b935@kernel.org>
In-Reply-To: <5fa69070-59e8-4eba-877e-f0728088fd48@nvidia.com>
References: <1757326026-536849-1-git-send-email-tariqt@nvidia.com>
	<1757326026-536849-3-git-send-email-tariqt@nvidia.com>
	<20250909182319.6bfa8511@kernel.org>
	<05a83eb7-7fb1-46ae-b7ba-bd366446b5f5@nvidia.com>
	<20250910174842.6c82fb0c@kernel.org>
	<5fa69070-59e8-4eba-877e-f0728088fd48@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Sep 2025 15:48:24 +0800 Jianbo Liu wrote:
> >> There is a requirement from customer who wants to manage openvswitch in
> >> a container. But he can't complete the steps (changing eswitch and
> >> configuring OVS) in the container if the netns are different.  
> > 
> > You're preventing a configuration which you think is "bad" (for a
> > reason unknown). How is _rejecting_ a config enabling you to fulfill
> > some "customer requirement" which sounds like having all interfaces
> > in a separate ns?
> 
> My apologies, I wasn't clear. The problem is specific to the OVS control 
> plane. ovs-vsctl cannot manage the switch if the PF uplink and VF 
> representors are in different namespaces. When the PF is in a container 
> while the devlink instance is bound to the host, enabling switchdev 
> creates this exact split: the PF uplink stays in the container, while 
> the VF representors are created on the host.

So you're saying the user can mess up the configuration in a way that'd
prevent them from using OVS. No strong objection to the patch (assuming
commit message is improved), but I don't see how this is a fix.

