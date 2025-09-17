Return-Path: <linux-rdma+bounces-13431-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADE6B7D2FD
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 14:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D87C3188D3A1
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 00:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9991F1D61BC;
	Wed, 17 Sep 2025 00:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7nfDF/A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9201D5170;
	Wed, 17 Sep 2025 00:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758069008; cv=none; b=rbMNcUrKXDUyS9JaFOl7xFZLRZnhNiY3Fkz81EoF++D1+qUHh5yUY3fdcOiAA44kjFLtMMoDqYUnrfEmdxV6YkEkC4tHdQgHoo09Ak5PASvkM9W75XrpJeCUP7+LENju6kSDnECBQsbJcr1Yw/yxKCPhWShSWyAohZnCKqFDSHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758069008; c=relaxed/simple;
	bh=KJ6VAfAH7Wk3uo6UlNgWRvLun6k5q0iiGTieHPf+ads=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l1U0+uBdOk0FofeptvBU8sAnJVQyJjs/Da7v1gOJijppOM7RtG4zdhXmhTeDNkVgPXSpoRkLIsw4ApylCXrdpZcENlskDIIgZiONxdzbs0nhsT6QeleSjdKPqOwa3xfy9pf8KUO8BWTxET+luirN8rFB6CDeUPl4I7f2OuFbHTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7nfDF/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BD4C4CEEB;
	Wed, 17 Sep 2025 00:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758069007;
	bh=KJ6VAfAH7Wk3uo6UlNgWRvLun6k5q0iiGTieHPf+ads=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l7nfDF/AyIoIlabjctDp7PAMzC5k5cD4ZrYH2d/lIA0HAXyFKzYpGQmuRN+M6nDIm
	 G7v+Y2JEbp6AK4quJ01mv3fUJxZJmdJwXFZSlZUf+aEh86/Jh6N0XSMIJJzBT//Hzd
	 qF5jjuvxpj8iUFjBI0hdnVy6zIND81j43W3xfgPds3JR3dUO1LqNOAo5IVKe4LNOuw
	 4Q59qU+PRSHTlS/SbIyA0DoPumUWibRXflIHVBsOOSd2BfFBEgow/zIjJ9AjgAICw1
	 nb92L8UXNr6MUCb5jMDEzkGDwp0AjvMUUQFS+eHw6XE0LfQf3huC8WIfMF4qeI1NZL
	 2iMFuY3tJA9Nw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0F839D0C1A;
	Wed, 17 Sep 2025 00:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V2 0/3] mlx5e misc fixes 2025-09-15
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175806900878.1413145.9987654326424093380.git-patchwork-notify@kernel.org>
Date: Wed, 17 Sep 2025 00:30:08 +0000
References: <1757939074-617281-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1757939074-617281-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 15 Sep 2025 15:24:31 +0300 you wrote:
> Hi,
> 
> This patchset provides misc bug fixes from the team to the mlx5 Eth
> driver.
> 
> Find V1 here:
> https://lore.kernel.org/all/1757326026-536849-1-git-send-email-tariqt@nvidia.com/
> 
> [...]

Here is the summary with links:
  - [net,V2,1/3] net/mlx5e: Harden uplink netdev access against device unbind
    https://git.kernel.org/netdev/net/c/6b4be64fd9fe
  - [net,V2,2/3] net/mlx5e: Prevent entering switchdev mode with inconsistent netns
    (no matching commit)
  - [net,V2,3/3] net/mlx5e: Add a miss level for ipsec crypto offload
    https://git.kernel.org/netdev/net/c/7601a0a46216

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



