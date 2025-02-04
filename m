Return-Path: <linux-rdma+bounces-7407-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AF4A27E34
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 23:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8AD61887D61
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 22:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5BD21CA0F;
	Tue,  4 Feb 2025 22:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phv1x3Jf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557601FAC5C;
	Tue,  4 Feb 2025 22:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738707621; cv=none; b=dw1+R/uDgLrc4GNr7BTBaThNJu5FLJELq+y6GeXh2gyb7jwC+Zw8MeLNLcpr1s1EXlZhyIz4cm2a/hSO4gTNUyHG6ZOtKm+pxX6JZlG5gYNJoPm1Z7pSm9GfEAS6RS/n0tYxKGInQUoqzYWRc2MMd8MSmPX1cWWu0O/UNK5o31k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738707621; c=relaxed/simple;
	bh=p+3BhT2PElmTLnZdi7Jk/dsHXLSTDRcbipJPsT9en6E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IX1+eQ34GJHOcMs59ZwpKYa4MlL6qrCc87BgRiqPEUtKiKS4ymiqHG71I0sw5i+jz5hwVScYp/3Pu+t9nrOIGefBsVAETjkXNmqsDajsKLk4FL8xO+3VypDDNmJBi4oyCiXwNDMGNbcMWXBEdJdjsvyJSpTaY2q2yY/uZEvIIuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phv1x3Jf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330EEC4CEDF;
	Tue,  4 Feb 2025 22:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738707621;
	bh=p+3BhT2PElmTLnZdi7Jk/dsHXLSTDRcbipJPsT9en6E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=phv1x3Jf6hU82bSYHUjiiv5iSUi9owUMgeLNCU+VX2Fo4MjxNDlqvAmS8g6WN2U1Q
	 +Ra8bkRYOC8oCdFzLANjeNH7CGgawDQ1Os2nMyW4TdQPlZjgab6h8NkF9E1wRfviMg
	 TxF5J33tJFrU1UjPqBVXE2GHj7p9ODGi4qZFC0pqNv4Ehl5k40TeYiR8HNIocVq4j0
	 cY3YzMrjj63/7m/vv7MO+PjICQDMH7NxdSxfK2FORp0dDDriqbj8yo8sF/H1DHYNhx
	 wukeAHT4VpY9NUBU3eBntLjdhCyeFZUU29j8yG6yVDKq6JT5KWFzbIRa7REo0DTqMz
	 Zu98U90l6bwfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE4D9380AA7E;
	Tue,  4 Feb 2025 22:20:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/mlx5: Remove unused mlx5dr_domain_sync
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173870764825.165851.79407350191519708.git-patchwork-notify@kernel.org>
Date: Tue, 04 Feb 2025 22:20:48 +0000
References: <20250203185958.204794-1-linux@treblig.org>
In-Reply-To: <20250203185958.204794-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: leon@kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Feb 2025 18:59:58 +0000 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> mlx5dr_domain_sync() was added in 2019 by
> commit 70605ea545e8 ("net/mlx5: DR, Expose APIs for direct rule managing")
> but hasn't been used.
> 
> Remove it.
> 
> [...]

Here is the summary with links:
  - [net-next] net/mlx5: Remove unused mlx5dr_domain_sync
    https://git.kernel.org/netdev/net-next/c/15c51f17bdc4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



