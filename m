Return-Path: <linux-rdma+bounces-10512-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3B9AC0329
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 05:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827314A839B
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 03:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2310E18785D;
	Thu, 22 May 2025 03:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClIP3Dli"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2E117B506;
	Thu, 22 May 2025 03:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747885810; cv=none; b=u/JDHz912yp9X+kAvIGcWIHPXv2Q5R3DLuEBA/kEqZ386pbhhNDGZSK1J3hlg0ApsIzm9GWesA7rWzJ/bSofvPo8mm9Tx8Iofth6CeoYbn0I7GNRfTuwheOpLRrDTSruUS2ylQ//SUv2w6ZEIAmmIt9tmC83Y5FZA/l4Ttwapzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747885810; c=relaxed/simple;
	bh=H5AedyMsGok87edc8NcohXrKHX1CUMasg3G1qzFoYAA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c5Cqq5+Qg+ulTDUO/xhr2Q7qyzdkTr/4I3U6QzJQlCdeUBCJSJLYWz4P6Y/Wcr5GhkAJzc7eXPfRgizAOc3qGRTz7/71fam3BOzYP08BQ4IboiyKDMUael74oaTCLNjU0OwGpYg/qWLqZm7r3t1TJviJzLDg5qQy6Ao144YTz0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClIP3Dli; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F690C4CEEF;
	Thu, 22 May 2025 03:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747885810;
	bh=H5AedyMsGok87edc8NcohXrKHX1CUMasg3G1qzFoYAA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ClIP3DlivxhtZGNTwtbFBSmZktU5VuGiQBf4xr/kVufjgHeeuff5JG21OWpApv4tD
	 OsF2QMs1iF6dg7LnvAdzkPgciVXp2E+W+AqtFsj82nuuvqYfxJsA5oxyriaEgXHUcE
	 RzXcgNHJ+QQVoHfIL1T96DdQL+8qemR4j91nT+OGRylxc0OIBRmk1iPLDAPc4IDacV
	 UYiWhfqd/qxPOP1sYgkjQjIbFkBZWv6AgOzMTBwy36SQ615gLG378jug6gDbr9uA3C
	 ajStzPCcdiUeF8tQzUQxP30X1mHxQa6YknVNzv1g6sNHW+9S075ccOipUBrjxheP+w
	 AIic+62BLFz1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FFF380AA7C;
	Thu, 22 May 2025 03:50:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] net/mlx5: HWS, set of fixes and adjustments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174788584599.2369658.11689090741333424954.git-patchwork-notify@kernel.org>
Date: Thu, 22 May 2025 03:50:45 +0000
References: <1747766802-958178-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1747766802-958178-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 leon@kernel.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, moshe@nvidia.com, mbloch@nvidia.com,
 vdogaru@nvidia.com, kliteyn@nvidia.com, gal@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 May 2025 21:46:38 +0300 you wrote:
> This patch series by Yevgeny and Vlad introduces a set of steering fixes
> and adjustments.
> 
> Regards,
> Tariq
> 
> Vlad Dogaru (2):
>   net/mlx5: SWS, fix reformat id error handling
>   net/mlx5: HWS, register reformat actions with fw
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] net/mlx5: SWS, fix reformat id error handling
    https://git.kernel.org/netdev/net-next/c/ca7690dae126
  - [net-next,2/4] net/mlx5: HWS, register reformat actions with fw
    https://git.kernel.org/netdev/net-next/c/b206d9ec19df
  - [net-next,3/4] net/mlx5: HWS, fix typo - 'nope' to 'nop'
    https://git.kernel.org/netdev/net-next/c/0b6e452caf03
  - [net-next,4/4] net/mlx5: HWS, handle modify header actions dependency
    https://git.kernel.org/netdev/net-next/c/01e035fd0380

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



