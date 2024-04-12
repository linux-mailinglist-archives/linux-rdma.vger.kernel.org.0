Return-Path: <linux-rdma+bounces-1921-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E461E8A23E2
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Apr 2024 04:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7572B22B42
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Apr 2024 02:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC81E15AC4;
	Fri, 12 Apr 2024 02:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aR8A+kEm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FED7134BD;
	Fri, 12 Apr 2024 02:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712890231; cv=none; b=eqe9CjOLpsCBZBd4cqqbYF718mMCBrQWswqBq6QCjT0cutotJqL1DK3/svpS4VdBEv9Fs7Ak5ElbcSEYTmYcQdvejd1PCqi0vMvnR0y0pHqzRrUx+LUnHQbMnxZEphPJzTlRTyZ1Yhntd6q0f5eSdNOUx6jAokN0E1X8T/U3RKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712890231; c=relaxed/simple;
	bh=cdC80TaevqpFC4O1h6P6DJKVzJoTl6Gm4dF/Z8JWHYs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mpQg3WS8faj8TLRD2pQ980uTORimPT6/L0i5PSUWxkgOHFlO0905k7yvNDO7TXrZQoTLzjbdzK22sbN8i4HKwRjNid7dKunD4K79xmmugasbLmQFvc91GPZAAFe+CxJjgWbPsKocbxbdXtjeYp3J6W+6QAikz3glgxHkZGe32gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aR8A+kEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7F3FC2BD10;
	Fri, 12 Apr 2024 02:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712890231;
	bh=cdC80TaevqpFC4O1h6P6DJKVzJoTl6Gm4dF/Z8JWHYs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aR8A+kEm8u+wZpjAKGx7xspEABPb5lO7m0Y6peYlaE7CFDxM/eKZUsXR7nIDPePn+
	 jmScGbu2VfOxUA50YkrF4ct680lZLdTUZLiw9qMernKxpIByuXJu8J0ZVhlDDFVisu
	 BxPfVxSIOR2u4NM6X8TCzTmn4aYBpUOMTCtJ3bKaEiaq0ZmA1Sdsbkm8HcVkcmO0kl
	 8kh7FFaDv/30qfWdf/Hdb90THS75q1pyYglBXa7tzmMBlxzKw1CrojGaJ5m3IzpFpV
	 bIAXaA1LN3vyVYsEL+8956e3N3wi7kyY+qG2MING0+l2tUxFk2XMIbOiYtw+UEgldD
	 LJDXQpuKSHTng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D39FBC433E9;
	Fri, 12 Apr 2024 02:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/2] Minor cleanups to skb frag ref/unref
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171289023086.15367.8747822658877342896.git-patchwork-notify@kernel.org>
Date: Fri, 12 Apr 2024 02:50:30 +0000
References: <20240410190505.1225848-1-almasrymina@google.com>
In-Reply-To: <20240410190505.1225848-1-almasrymina@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, ayush.sawal@chelsio.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mlindner@marvell.com, stephen@networkplumber.org, tariqt@nvidia.com,
 wei.liu@kernel.org, paul@xen.org, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, dsahern@kernel.org, borisp@nvidia.com,
 john.fastabend@gmail.com, dtatulea@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Apr 2024 12:05:00 -0700 you wrote:
> v6:
> - Rebased on top of net-next; dropped the merged patches.
> - Move skb ref helpers to a new header file. (Jakub).
> 
> v5:
> - Applied feedback from Eric to inline napi_pp_get_page().
> - Applied Reviewed-By's.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/2] net: move skb ref helpers to new header
    https://git.kernel.org/netdev/net-next/c/f6d827b180bd
  - [net-next,v6,2/2] net: mirror skb frag ref/unref helpers
    https://git.kernel.org/netdev/net-next/c/a580ea994fd3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



