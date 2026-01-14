Return-Path: <linux-rdma+bounces-15536-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B3AD1BFF7
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 02:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85DED3023541
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 01:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DA12F0C76;
	Wed, 14 Jan 2026 01:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMjPHHOr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4054B20DD72;
	Wed, 14 Jan 2026 01:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768355617; cv=none; b=nCKV96azgaDG58Sa2eC5I4K5Bjd/vr8Jp7Wl64Z+meN1Dsv4eab45+jSWOOyqwSfnAvRvkebS7CmqK71lqBdQmpnxCbbkP1zaQ/sSt60OeNywZaXLJ3c1+go0C9OYTgUeB00X9lFky3I0UiaqIO5jAqWtSlR89fRFKT162JO+Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768355617; c=relaxed/simple;
	bh=tAioXXnB0EhJKHYUca62Zhwl2ZlhEDoiIYO6MG1gMq0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GTteRhhLBFaov3+1bm3+Ywj9y9OchozgmVimbqejWYPoWYXBEFp+59RzPNvk8SEE+Zc/FB1gM+HgFUsch1hrTqF7e1B00eAJ9YxncC4YTcwAmgpG8BMudup3P25wZMM8xRPfW0ptDCJaGOeKEJQR0McCmU8l8aiNJ6QhJI56Hy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMjPHHOr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61BFC116C6;
	Wed, 14 Jan 2026 01:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768355616;
	bh=tAioXXnB0EhJKHYUca62Zhwl2ZlhEDoiIYO6MG1gMq0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iMjPHHOr7zHdosUAL50Kf0xtHN19eu8jVCcQlJM1bjb8nL6wLepFSjHQyJlvSzwCs
	 8UaGCp5kV233Qmt+W/aw5KoptDXiuBdIl2o7bfSDR86yYPJ1gwkUl0FShwH9A87Job
	 pcigFdOnGwoOexf8tVXRRGyh1mYvSmgSCHrEtKLrM7O0DNL23mO08QuL27FOkddIG+
	 NJDIz8WXLzxTFTcqd+/6yAxUAlkMkLIL+gQv+MVwAJpxHSzVM88km5QeazSk1aiGIh
	 VP70SxDp7Yhj17dVmv4qmcM9FRth6R4Ah/IYr+rPHq2N1XHgxLo2TecYpm5QQIWUmR
	 a9diaH/iDyL0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B6E53808200;
	Wed, 14 Jan 2026 01:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [pull-request] mlx5-next updates 2026-01-13
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176835541007.2550630.2698145120983484966.git-patchwork-notify@kernel.org>
Date: Wed, 14 Jan 2026 01:50:10 +0000
References: <1768299471-1603093-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1768299471-1603093-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 alazar@nvidia.com, ohartoov@nvidia.com

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Jan 2026 12:17:51 +0200 you wrote:
> Hi,
> 
> The following pull-request contains common mlx5 updates
> for your *net-next* tree.
> Please pull and let me know of any problem.
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [pull-request] mlx5-next updates 2026-01-13
    https://git.kernel.org/netdev/net-next/c/9d405911a577

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



