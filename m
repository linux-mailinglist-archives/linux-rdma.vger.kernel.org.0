Return-Path: <linux-rdma+bounces-940-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0469184C2E4
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 04:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95D581F2926C
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 03:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA22F9C3;
	Wed,  7 Feb 2024 03:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwsnG9N+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0885C101CF;
	Wed,  7 Feb 2024 03:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707274831; cv=none; b=XjU3D8apE4QIzarqbYVDMLybTWFTR7PP5poaDDeDw4iUqkU2H8JPraS8qa4fwKQWsDDFGQol01mcIMm4jh34SXw8m9xbnQfj8MNno+2h6y+k/n7Sbrh3VoXTbdgMFyETAULd0memdjPhdnuXQhD/rh+QHFYtsZq72KvcvruSoto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707274831; c=relaxed/simple;
	bh=tk91TRH8Ea+h4r6N9HbOPYgOGl9bD0WzfFfdjhKr9b4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZDhsdP1kw1fcNp63J1s2M8iiFg6qxqLJvH5lXjdHMNziwt3kJpwTU9OFILEacL3wGbPdKNF1smgeXw7PA3DVL9HPxitJqgmdThhE4k8V9tsz28Ja+vOoBqAFVascRI6AAY2+XaFiXpgHNgzX9ZMVCdRyPRGHntdQNKh5JfuG1tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SwsnG9N+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7FDCC43394;
	Wed,  7 Feb 2024 03:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707274830;
	bh=tk91TRH8Ea+h4r6N9HbOPYgOGl9bD0WzfFfdjhKr9b4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SwsnG9N+/Esjd++Q5PH0S3DnF4kWRqa+8fkxlsqbUXO3zfiKLqBcShuGfVL5qs7aM
	 XC48asc0kT9Txe7Ebft0ikdLxXxvf3vfTUKNmWUYg5XAAUqoSP/hwPNiWH53/ZWTQv
	 k1Y9KVRf07BLHYvBSJvRUvggEg8rzwX+s4A0eeu7NnXicmXMvj47LrFZN5bMc1p1oy
	 VWNsei+MbWxcf5VIi9mSypPxBYpjJ1VYf7tnvMdUQ9qs/JZuxMBOgzvX1RmYqY9IoX
	 bfawIy36AvtTT+ya828rpaHp52SZA1u+nUpXzGDIsfLMCJf90a6sy444r5sEbv19qE
	 lkQd4eAbPl6OQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B321CE2F2ED;
	Wed,  7 Feb 2024 03:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-nex] mlx4: Address spelling errors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170727483072.2210.11358207425808660924.git-patchwork-notify@kernel.org>
Date: Wed, 07 Feb 2024 03:00:30 +0000
References: <20240205-mlx5-codespell-v1-1-63b86dffbb61@kernel.org>
In-Reply-To: <20240205-mlx5-codespell-v1-1-63b86dffbb61@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: tariqt@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, colin.i.king@gmail.com,
 rdunlap@infradead.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 05 Feb 2024 11:51:57 +0000 you wrote:
> Address spelling errors flagged by codespell.
> 
> This patch follows-up on an earlier patch by Colin Ian King,
> which addressed a spelling error in a user-visible log message [1].
> This patch includes that change.
> 
> [1] https://lore.kernel.org/netdev/20231209225135.4055334-1-colin.i.king@gmail.com/
> 
> [...]

Here is the summary with links:
  - [net-nex] mlx4: Address spelling errors
    https://git.kernel.org/netdev/net-next/c/6cc9c6fbc79f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



