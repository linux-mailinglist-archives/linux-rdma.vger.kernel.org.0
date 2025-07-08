Return-Path: <linux-rdma+bounces-11949-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08610AFC0C7
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 04:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF3C23BF9EC
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 02:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CE72253BA;
	Tue,  8 Jul 2025 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0Z7yeAK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEC220766C;
	Tue,  8 Jul 2025 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751941230; cv=none; b=tpLf/kIu7M9UTFFvRY1WkETFl6AUczL9WWfkYmeZtyQPtoIqxN1e8lrYQ1VYX9FCL50Jn3+z2cMfmAVC88HFmmZgux1f+07unUc6q07j08n0JscxK0YvsCpUYCtkbtO45xdrGOhHC1wWopDCpoZh/iM0e+4bhHAwPVjCp7hHvOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751941230; c=relaxed/simple;
	bh=M1q9eKLn1p0r6Ruy94dsM/SECj373UWggsq9/COMgUc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e37xy/jpXxIHMFYzUExaMaOZxJPcnRGVr7TBsCnkgHQ1DqfcQY8+vZTXXGMCFSehWVZsZOpZWjio1X2UA5b/Mi3cHI8Cbx4T7w6dlKcjMFAaHlmy6UggTD5orvDz95dgmKSJcNIqtvFrBKUV0A3SbO96BkM662RVOIy9LT0KG6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0Z7yeAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E32C4CEE3;
	Tue,  8 Jul 2025 02:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751941230;
	bh=M1q9eKLn1p0r6Ruy94dsM/SECj373UWggsq9/COMgUc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t0Z7yeAKMH16T5HZNhuwBMKIgtgLhy0E6Utj6h8G00QNlY5BE/4RlpotEJMYv2kJQ
	 UQYSuRGGFwB85JSRi6Pt+FRle0Ok9b83vkyE5STSdUffU+y0dbAcgxQ8HG0rMEISxf
	 jq5piSaDVdops6i7NXbHjAe1/zkePp52eb5Tgej+sc+WiqbP9dCv1e4JYZxJusIrFI
	 M4cKPVMkmPEamQytK3AzIV4sUTk5hwN9xqIX8jNqKuH0W4AbTBUurEch3W/q9J+s8w
	 cFLmPiKndfibR93+MzjVwvG8hj4CzuAua9Zb7boFqpt7AoCC77aJXC+BCiw+TxlHVu
	 bjsxbw126OjfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E2338111DD;
	Tue,  8 Jul 2025 02:20:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 00/10] net/mlx5: HWS,
 Optimize matchers ICM usage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175194125285.3546943.3231273757948141290.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 02:20:52 +0000
References: <20250703185431.445571-1-mbloch@nvidia.com>
In-Reply-To: <20250703185431.445571-1-mbloch@nvidia.com>
To: Mark Bloch <mbloch@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
 saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com, tariqt@nvidia.com,
 leon@kernel.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 3 Jul 2025 21:54:21 +0300 you wrote:
> This series optimizes ICM usage for unidirectional rules and
> empty matchers and with the last patch we make hardware steering
> the default FDB steering provider for NICs that don't support software
> steering.
> 
> Hardware steering (HWS) uses a type of rule table container (RTC) that
> is unidirectional, so matchers consist of two RTCs to accommodate
> bidirectional rules.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,01/10] net/mlx5: HWS, remove unused create_dest_array parameter
    https://git.kernel.org/netdev/net-next/c/60afb51c8941
  - [net-next,v3,02/10] net/mlx5: HWS, remove incorrect comment
    https://git.kernel.org/netdev/net-next/c/26b06579d50d
  - [net-next,v3,03/10] net/mlx5: HWS, Export rule skip logic
    https://git.kernel.org/netdev/net-next/c/d8e7ab591b50
  - [net-next,v3,04/10] net/mlx5: HWS, Refactor rule skip logic
    https://git.kernel.org/netdev/net-next/c/3dcac700d20b
  - [net-next,v3,05/10] net/mlx5: HWS, Create STEs directly from matcher
    https://git.kernel.org/netdev/net-next/c/59807d071724
  - [net-next,v3,06/10] net/mlx5: HWS, Decouple matcher RX and TX sizes
    https://git.kernel.org/netdev/net-next/c/c8332ce09691
  - [net-next,v3,07/10] net/mlx5: HWS, Track matcher sizes individually
    https://git.kernel.org/netdev/net-next/c/6b44fffdc7b7
  - [net-next,v3,08/10] net/mlx5: HWS, Rearrange to prevent forward declaration
    https://git.kernel.org/netdev/net-next/c/29063103f864
  - [net-next,v3,09/10] net/mlx5: HWS, Shrink empty matchers
    https://git.kernel.org/netdev/net-next/c/96e4c4a1a5bc
  - [net-next,v3,10/10] net/mlx5: Add HWS as secondary steering mode
    https://git.kernel.org/netdev/net-next/c/a9aec713d0d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



