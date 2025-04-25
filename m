Return-Path: <linux-rdma+bounces-9815-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEF8A9D0F5
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 21:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 658543A79B2
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 19:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA61218AA0;
	Fri, 25 Apr 2025 19:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2B8hbDQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E103216399;
	Fri, 25 Apr 2025 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745607651; cv=none; b=KC7qF8RRNTM1vCMlmR5BoVPXg9swI9wqPTRxhtbzbMOsWWkwISTmPvUdwRWgXN8b7VsVvTgP7Yr0BWkrRoiWKzxPgQYCvgNEfvPTFEEtVpodd5grPeaEzHqu247AX05vm6s7P5tT6rz3TpkvQkdYhjAjVVwN1flWLcZyvLNNGFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745607651; c=relaxed/simple;
	bh=rcgUGGoTaQtiVKvvrkVXx2VJUfGZzIH2P/07pyV2u5o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eds2UwAXTDj20wVKMJd76o0ufH4l6QmWvlinPzR5vu+VjHUtuB/3sU7x8n7/lkqXlDSlChi/aipdKOXxwpTlE8DVl/2nm75lvmDDO812iou+QjtzyE058AVlXsgjPHS2DebhbREogl9sN+pTfTcSOuNjCYiTEpM+pHtpNb2GngY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2B8hbDQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC02CC4CEE4;
	Fri, 25 Apr 2025 19:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745607650;
	bh=rcgUGGoTaQtiVKvvrkVXx2VJUfGZzIH2P/07pyV2u5o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j2B8hbDQ0Q/D75S2UudrcasVh/x5d6ug5uJv3EvojNwzde8OHSrnnYfEDegQu05oB
	 rxj9W0sV4JsERitPanOWrK5OEdTF4Qouk4uqVRrK5+uJIhwv0kQtT3m15PAtqEC91V
	 89kxxJcEuute3WVM9baRc78loK5dg08tgWampY844AToInc9hsRLkYnS9xLCK1feK6
	 VbuEaFskcBOrYgOxkfrpN3UA4r+pfqHzikUpWy56t4AKt2n4BGWBH3NrBnCzUsJ2Fi
	 TVixzXwYhhahGOtM9UWI/1eUDE6PJ5J133K6KdAFdff3GnR0tiOKmvNyakM5qWuJSE
	 pe8lI6xOwdVJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE0E380CFD7;
	Fri, 25 Apr 2025 19:01:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] mlx5 misc fixes 2025-04-23
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174560768948.3803904.7560030217169177753.git-patchwork-notify@kernel.org>
Date: Fri, 25 Apr 2025 19:01:29 +0000
References: <20250423083611.324567-1-mbloch@nvidia.com>
In-Reply-To: <20250423083611.324567-1-mbloch@nvidia.com>
To: Mark Bloch <mbloch@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 tariqt@nvidia.com, leon@kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Apr 2025 11:36:06 +0300 you wrote:
> This patchset includes misc fixes from the team for the mlx5 core
> and Ethernet drivers.
> 
> Thanks,
> Mark
> 
> Chris Mi (1):
>   net/mlx5: E-switch, Fix error handling for enabling roce
> 
> [...]

Here is the summary with links:
  - [net,1/5] net/mlx5e: Use custom tunnel header for vxlan gbp
    https://git.kernel.org/netdev/net/c/eacc77a73275
  - [net,2/5] net/mlx5: E-Switch, Initialize MAC Address for Default GID
    https://git.kernel.org/netdev/net/c/5d1a04f347e6
  - [net,3/5] net/mlx5e: TC, Continue the attr process even if encap entry is invalid
    https://git.kernel.org/netdev/net/c/172c034264c8
  - [net,4/5] net/mlx5e: Fix lock order in mlx5e_tx_reporter_ptpsq_unhealthy_recover
    https://git.kernel.org/netdev/net/c/1c2940ec0ddf
  - [net,5/5] net/mlx5: E-switch, Fix error handling for enabling roce
    https://git.kernel.org/netdev/net/c/90538d23278a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



