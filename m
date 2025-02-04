Return-Path: <linux-rdma+bounces-7408-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F50A27E35
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 23:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D717166E4D
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 22:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D4A21D581;
	Tue,  4 Feb 2025 22:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQAKQAf9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7B621C160;
	Tue,  4 Feb 2025 22:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738707623; cv=none; b=h0TpkIXBq8uWtsCKRnTQRNsZKga3P4ot4Yh2WTHAZXvy817zYrSeS+fBDXW3dLhXl1R1VASSVIuPN0pWbuI4wdqG9KVyQE1jo+qUnOmDFcW24MVV9PsbdVwMPBsFxtqOLYCCTo2CDvb6EbUPHbBwVjEull4yoMRwaLKJVWqk0Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738707623; c=relaxed/simple;
	bh=qU1SbJ9YmsXpzwJANU5KW+WfW5ZX0AyQzMbNExK2LV8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=shsOY8aWym6Y2sZ3mrQCfipLFjHm5VhNyBBOMbOp+Ol/ynfiImXHgP8GHoMKipEFyGww98C7jOpiYLvUkvHtZi0CNDpNfGv5L678zfs3XLxoYGeQL9G7rTINnRPbApiQt9QD8rLAfZAmK39McSX2yn/UbDDgUZx8IdHwhxKE3mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQAKQAf9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD6BC4AF0B;
	Tue,  4 Feb 2025 22:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738707622;
	bh=qU1SbJ9YmsXpzwJANU5KW+WfW5ZX0AyQzMbNExK2LV8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LQAKQAf904dPgUV8WHXrSUPhKaKlu4FR8imYxFpxHXZSdrFDnjQZw0u7YnpvoUu/l
	 XVT8cQ8KLLF9b9Urw/lsBLqHJAG2Hey348uu/NDnXiCivNPu0LYQkEOuLg39cAn9Se
	 JhNIHrKDzLKSxHhdFeiFBBh1oTOa9p0PSApHxIw6t7yfJ3rFpA14TwV1A51aC/Mu1+
	 ub5IqWGSoBfBvvgtDKKwNd39hHEtEQ0aobgKMGgnUvI801LQplM6+bw7nINP32d0cB
	 w+v69ZuLTfIm/xuOjUwsYkOsPNM7Dotxp+kAoDHTti+C19TSHVwx3K8t+b1/fMkCPf
	 Ft/7A/NVAyqnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEA8380AA7E;
	Tue,  4 Feb 2025 22:20:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mlx4: Remove unused functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173870764975.165851.12570827408207755201.git-patchwork-notify@kernel.org>
Date: Tue, 04 Feb 2025 22:20:49 +0000
References: <20250203185229.204279-1-linux@treblig.org>
In-Reply-To: <20250203185229.204279-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: tariqt@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, yishaih@nvidia.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Feb 2025 18:52:29 +0000 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The last use of mlx4_find_cached_mac() was removed in 2014 by
> commit 2f5bb473681b ("mlx4: Add ref counting to port MAC table for RoCE")
> 
> mlx4_zone_free_entries() was added in 2014 by
> commit 7a89399ffad7 ("net/mlx4: Add mlx4_bitmap zone allocator")
> but hasn't been used. (The _unique version is used)
> 
> [...]

Here is the summary with links:
  - [net-next] mlx4: Remove unused functions
    https://git.kernel.org/netdev/net-next/c/2cf424f5ac01

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



