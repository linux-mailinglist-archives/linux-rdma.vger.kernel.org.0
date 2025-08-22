Return-Path: <linux-rdma+bounces-12884-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FD6B32579
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Aug 2025 01:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2D531D23A07
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 23:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882E42D6E73;
	Fri, 22 Aug 2025 23:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZ19qIHO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3601B041A;
	Fri, 22 Aug 2025 23:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755906602; cv=none; b=jUwksJ2FtfEW/iPWzU8YcGXfPRKKARXTjb2JdPZS44c/KDyEsm3yY0zj0AhQCOoI38hNrQbtvcsps7jyepFDkHHme5BnyC2ql4gszTXg5h0nSXngvmS/vFEWkL7KH/8PWovIIVsmKC25445arnLCYxqpueZxLkS4/4/GwehZyv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755906602; c=relaxed/simple;
	bh=BtHoDzLsQtbabuODA9kZ9CcqFcM6FFS7ZUaUTqJRMwE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JepbhulNNCnxBxRsjh+rC4UgnC8i5q7EwyeVJNRlqbAewsixYJGkK67dNL2aLGolvVbXQljOVjy0bITsgMcj6eOPYlAx+ChXyWXtFRd1z6LVWHbEi+ORw/O2RftZpT07yPWXhZCRsWXOJeViaR0D3faKms194+TLMWqw3n4Posw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZ19qIHO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF51C4CEED;
	Fri, 22 Aug 2025 23:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755906601;
	bh=BtHoDzLsQtbabuODA9kZ9CcqFcM6FFS7ZUaUTqJRMwE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sZ19qIHOkWq6ssyeESgt4eSiUijQFAuhVPbXFQhE7b+HBetZ0TifnJDf0ZtS4rIXt
	 VpFCDF4oHcQVsUPbU0n8hNLg5rU7hR0Rj5aCeMVnluF7+3OF3TXeph1ZqlYrBoNcoM
	 XJQK28Us/3JK/m/nGMeWML78fdilJAxvPExHYfbt4S7hLLGqtILXIy9l/hVILQUnBD
	 6TMv5CWfFJl7v9dDotCBIrTPOtra7/p08AvDcsyi3FnyRPvffFdnshjICoQKLm1mxD
	 lEdTPRnGTCkDj6b3MV52WecCK25409HVMHnzsx8T/P+crez+jWfmuXOqKzGzjrZ+1o
	 pV4RwZ7yyCT6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF69383BF69;
	Fri, 22 Aug 2025 23:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] rds: Fix semantic annotations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175590661050.2033886.2550638437250545892.git-patchwork-notify@kernel.org>
Date: Fri, 22 Aug 2025 23:50:10 +0000
References: <20250820175550.498-1-ujwal.kundur@gmail.com>
In-Reply-To: <20250820175550.498-1-ujwal.kundur@gmail.com>
To: Ujwal Kundur <ujwal.kundur@gmail.com>
Cc: allison.henderson@oracle.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 Aug 2025 23:25:46 +0530 you wrote:
> This patchset addresses all semantic warnings flagged by Sparse for
> net/rds.
> 
> v1:
>  - https://lore.kernel.org/all/20250810171155.3263-1-ujwal.kundur@gmail.com/
> 
> Ujwal Kundur (4):
>   rds: Replace POLLERR with EPOLLERR
>   rds: Fix endianness annotation of jhash wrappers
>   rds: Fix endianness annotation for RDS_MPATH_HASH
>   rds: Fix endianness annotations for RDS extension headers
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] rds: Replace POLLERR with EPOLLERR
    https://git.kernel.org/netdev/net-next/c/9308987803bb
  - [net-next,v2,2/4] rds: Fix endianness annotation of jhash wrappers
    https://git.kernel.org/netdev/net-next/c/92b925297a2f
  - [net-next,v2,3/4] rds: Fix endianness annotation for RDS_MPATH_HASH
    https://git.kernel.org/netdev/net-next/c/77907a068717
  - [net-next,v2,4/4] rds: Fix endianness annotations for RDS extension headers
    https://git.kernel.org/netdev/net-next/c/bcb28bee987a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



