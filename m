Return-Path: <linux-rdma+bounces-3198-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B5290AB72
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 12:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60AB0285AD1
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 10:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6555219414D;
	Mon, 17 Jun 2024 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ms94PKPn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAFB61FCA;
	Mon, 17 Jun 2024 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718620830; cv=none; b=ZPYH9M8mkjjACCRwyvikgvkfgiu5OPisGMcQ2zFYjVrEiX8yMH42kfyz7c01aygFHvv5dxZFCN0tKJNmTHWUtlXh+Y/Xrqr6LstOp8geXb+2TC8LXNyYECmyKyqsS0lzBk8dohN+DULXlIQTY5US2dA0fqF5HHb7pk+QuW267vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718620830; c=relaxed/simple;
	bh=/YeVRc5sA8W64kYZ5SXwoCKhOR+BzHU525YdNCIta/I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NPre8Zseq5uTUZo2+AbEb6u5b/GK4PpGtIK2QrlcPIYSCmXdB/vzYCPpdEQGQWUdnULzwtQFurDc6rlgBMHB8pm+P6NR/jjD7dIlAFrSMACysQ+U3NPKpsQlyaiOJp+2tPoa7ewkwFBIOPx6Wr8ACAgA0sx62fpAACTKdIljX/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ms94PKPn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA217C4AF1D;
	Mon, 17 Jun 2024 10:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718620829;
	bh=/YeVRc5sA8W64kYZ5SXwoCKhOR+BzHU525YdNCIta/I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ms94PKPnsMz6JikGONqrMeb9QeVhJd6Fh1Sw5nUGl6QDy0OqvwUVhAsBLxEAXpFbA
	 EHDZnPMYgo4CWUO784dnVt8LL2MzDwhw2rX64bncDqVT/BZuFahxk8iyPF2lOWDJMX
	 IqufLeB6iuMArvvxF61FTYggEuTDke7LNXpMX0XjOVDvNdtL+C2q7fiaiS/jB5+28P
	 7+T/J8kcSgJMBXHpKbjgIBXl1xPPZsLs9eJsA3kbLLbDqOoy6o4rfycu4+6CD4YBfZ
	 S88zOc9gS+KRnp1QNsWut3ZJk7u28RgGLkRq5ANSfOUomdsoso0n3jst454gVpIM5M
	 e75g6+tW98mmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7B4FC4936D;
	Mon, 17 Jun 2024 10:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v5 0/2] mlx5: Add netdev-genl queue stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171862082974.4522.13019612823624585192.git-patchwork-notify@kernel.org>
Date: Mon, 17 Jun 2024 10:40:29 +0000
References: <20240612200900.246492-1-jdamato@fastly.com>
In-Reply-To: <20240612200900.246492-1-jdamato@fastly.com>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, nalramli@fastly.com,
 cjubran@nvidia.com, davem@davemloft.net, dtatulea@nvidia.com,
 edumazet@google.com, gal@nvidia.com, kuba@kernel.org, leon@kernel.org,
 linux-rdma@vger.kernel.org, naveenm@marvell.com, pabeni@redhat.com,
 richardcochran@gmail.com, saeedm@nvidia.com, tariqt@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 12 Jun 2024 20:08:55 +0000 you wrote:
> Greetings:
> 
> Welcome to v5.
> 
> Switched from RFC to just a v5, because I think this is pretty close.
> Minor changes from v4 summarized below in the changelog.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] net/mlx5e: Add txq to sq stats mapping
    https://git.kernel.org/netdev/net-next/c/0a3e5c1b670f
  - [net-next,v5,2/2] net/mlx5e: Add per queue netdev-genl stats
    https://git.kernel.org/netdev/net-next/c/7b66ae536a78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



