Return-Path: <linux-rdma+bounces-15483-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA450D155B0
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 22:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 715B03010500
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 21:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D170331A5D;
	Mon, 12 Jan 2026 21:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVxttgCZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C01C352958;
	Mon, 12 Jan 2026 21:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768251668; cv=none; b=JyuNa5XH5zEoS4MAosQ3pK2FJtpoakNvwNTMXWJ8QSmpY0JJS/Uabux3sdUvJJo+lex+ZVdFwH1CaXoaRGzekNUj2wmhlNiz0z0YrBHGdaBuKoYVBLJVmM+x8nCfyKbdU6yT6kQutyaPAqGkf9YHTJzCIgoM10YlUAIdlWuu0jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768251668; c=relaxed/simple;
	bh=oYGgPwCp9bwycFvTMDbDwtf22jM1fd9ZfEYy5KMlk54=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WndaRd9akeJFNRQGxbYs29Jq3E7DLHAc0ClTSfNP/GnSWkfuHynOIz1zLuRCP7Vte/VtBZLUvITL8h3aT/AUPoqhf7wGy/Zo56Z36LKgXgrk86m8wX/zxxkS9k/m2zcWfcBLHCgxlwPYOZpcrc6w/DkapqjsbHPs+DBOWadPrss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVxttgCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACF5C19422;
	Mon, 12 Jan 2026 21:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768251667;
	bh=oYGgPwCp9bwycFvTMDbDwtf22jM1fd9ZfEYy5KMlk54=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EVxttgCZt2Z/GSndfdnODeuxrWieKYQnaZiVwdp2BxsimeULNrQXZreXzLjjeKLMv
	 DwtJoCE/lWb2keVK1yWz16lDYKjeVz0ASh/3YR1tyyKpqD5htgj3Jy8ibNPP+3wRYA
	 QIjf6HojSMch3zu0Hcz/YrIcJMAkFfgAioe0p3lBikaoe+BNt2Zy5cyGx/+GSwNW1O
	 RH1S+alMx2FfxbFhuDZ2V/ICap5YdfyXKMA+HhFnMPkaOyDAjDp6MDbC711wQMdpvy
	 YiLA1AdcvzTyLRVCg8gGhHgD2UIWQZw91+lwJ75nfQsZUJJIgh7bBDh1F4bFA4T2h4
	 Z7hPABXXWNhOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2FAB380CFD5;
	Mon, 12 Jan 2026 20:57:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] mlx5: Add TSO support for UDP over GRE over
 VLAN
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176825146153.1092878.6612557868063451825.git-patchwork-notify@kernel.org>
Date: Mon, 12 Jan 2026 20:57:41 +0000
References: <20260107091848.621884-1-mbloch@nvidia.com>
In-Reply-To: <20260107091848.621884-1-mbloch@nvidia.com>
To: Mark Bloch <mbloch@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 tariqt@nvidia.com, leon@kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 7 Jan 2026 11:18:45 +0200 you wrote:
> Hi,
> 
> The following 3 small patches by Gal add support for TSO for
> UDP over GRE over VLAN packets.
> 
> Gal Pressman (3):
>   net/mlx5e: TSO for GRE over vlan
>   net/mlx5e: TSO for UDP over GRE over vlan packets
>   net/mlx5e: Remove GSO_PARTIAL for non _CSUM GRE
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net/mlx5e: TSO for GRE over vlan
    https://git.kernel.org/netdev/net-next/c/6e6c751b41a8
  - [net-next,2/3] net/mlx5e: TSO for UDP over GRE over vlan packets
    https://git.kernel.org/netdev/net-next/c/5f410e1224e4
  - [net-next,3/3] net/mlx5e: Remove GSO_PARTIAL for non _CSUM GRE
    https://git.kernel.org/netdev/net-next/c/b30ba673058d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



