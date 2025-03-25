Return-Path: <linux-rdma+bounces-8934-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA7CA703B8
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Mar 2025 15:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D12A1888BDB
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Mar 2025 14:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC1C258CFD;
	Tue, 25 Mar 2025 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+12mC25"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0337225A355;
	Tue, 25 Mar 2025 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742913006; cv=none; b=UU+jsiN8WBNQnlvRPfWuuAQyZjtD+sli6AaDlMwgPBDlljs5jiYz6erY/KCbowXrCCcC8acfyHJLnqhUOljoUHv9rLdZS+WGMKtmlWdlJmDSRclKyIS9E1gvj8zVfu+guL6clcveahc4KHl4e7Mneg7SdW1yNkoV5s2uCDuUFeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742913006; c=relaxed/simple;
	bh=nr9g1Wfd45MUL8j7kWkgO7JoktpaX26KTQBj59zmnkg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cyM2b/PsulEKnq+bPP6lM/Tj3Jy5g+pL1NVb2WngJtSpqmwsrfLlm8GCdAVUewkCxBPz90z1OOUNmWpoZJWwr+JAh+s8izIr5fmaeskGKTvMMzGHoEXKWg9n717PbEore1JsqUPQfD1E3SftwR1mcXFn/lyikUrbUT45qwtIhkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+12mC25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C419C4CEE4;
	Tue, 25 Mar 2025 14:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742913005;
	bh=nr9g1Wfd45MUL8j7kWkgO7JoktpaX26KTQBj59zmnkg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S+12mC25+shaBe7nPNIJF0/WA/VDMkfvFYwhKvW42PST1iEM6K2VYdFV/WQfEqAaE
	 oKfvrLwr312wlDq9rH4d60n6BLZFya7Fh32mPrb6nrYOo6noh+MzcHuDT+z4H4qID3
	 bnnleFyQGO20u+e5VRVZlvvHmdinClnPtlwmdWjAu3EcEISIm6VCpto6RurX/T67Mp
	 4B/m1y9kdqzl/XkDV8gapIhnWKosMbR+YHq90zGYDo2kPQCIc/VH12STNgDK26itFh
	 5rv5VN3eQmm+MsKK08qQs9mt1+cewb5bW1dTnLZuWiza3jmQe7G2n3a/lcDkIE5/p4
	 WLd/R6nmICZdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD63380CFE7;
	Tue, 25 Mar 2025 14:30:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/mlx5e: TX,
 Utilize WQ fragments edge for multi-packet WQEs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174291304175.595107.13297084085489474396.git-patchwork-notify@kernel.org>
Date: Tue, 25 Mar 2025 14:30:41 +0000
References: <1742391746-118647-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1742391746-118647-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, gal@nvidia.com,
 leonro@nvidia.com, dtatulea@nvidia.com, saeedm@nvidia.com, leon@kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, moshe@nvidia.com, mbloch@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Mar 2025 15:42:26 +0200 you wrote:
> For simplicity reasons, the driver avoids crossing work queue fragment
> boundaries within the same TX WQE (Work-Queue Element). Until today, as
> the number of packets in a TX MPWQE (Multi-Packet WQE) descriptor is not
> known in advance, the driver pre-prepared contiguous memory for the
> largest possible WQE. For this, when getting too close to the fragment
> edge, having no room for the largest WQE possible, the driver was
> filling the fragment remainder with NOP descriptors, aligning the next
> descriptor to the beginning of the next fragment.
> 
> [...]

Here is the summary with links:
  - [net-next] net/mlx5e: TX, Utilize WQ fragments edge for multi-packet WQEs
    https://git.kernel.org/netdev/net-next/c/9da10c2d69c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



