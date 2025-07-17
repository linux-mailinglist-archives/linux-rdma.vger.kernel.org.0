Return-Path: <linux-rdma+bounces-12269-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E901B08FDD
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 16:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9021C43A4D
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 14:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C14B2F8C28;
	Thu, 17 Jul 2025 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dg1L8+LL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D652F85F7;
	Thu, 17 Jul 2025 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752763807; cv=none; b=X/KeHxYE2j6uiYPlJZIam72N0YkSu1aJA2bEJfWDaKA7gVGAYvwhJh5kZgabdzl+vY+LIR1ylluDGlJjn0LV0rx5zLEV5mIWtHKMlUUns10r59DOfHrXD54LUVeLn2I34JWx+0i/lTzTNmy4GVWNRgg6Y45GKIMqYQOxkmSLOrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752763807; c=relaxed/simple;
	bh=rq4OFP/a5VgeuDso392nppt16rzmrs1rVBaM2n7Zkg8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AIOoDiLG4juvFgIwhmhPaQrElmy+mY+nKTZQZZCLWNoKx8gb/NoZl/anIiVqihR4BkB3uxfCcKYbA3wIml684Zml6g+KGY66lx71fNoggzuB/ixfco258Pp29UPaSKG5IR3rVZKMxZVFYRNIa+eQfB6rGdqXKU2KURhiGqdtHhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dg1L8+LL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A346FC4CEEB;
	Thu, 17 Jul 2025 14:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752763806;
	bh=rq4OFP/a5VgeuDso392nppt16rzmrs1rVBaM2n7Zkg8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dg1L8+LL8arZtFTD1fDBzT4e6I3VYHrUPeegvq+qkeKOOOZlrAB0aIuX8BgYm7VrG
	 EepqUK3gG/meXNJ6Ly5usFhdQWhKDE1IlVoRKqUIJfXg62UZsSxvpDBe1bUG8oRnKG
	 r2ziaYMATrNtdDsDbBxhKpZ3tUmxAVj4AQC58Bex9Or/6hRvRurBavidnIw86oLHuC
	 nrQQRaAAs3SZ72ocbsOXiena5z19fWGsrGz1/K9h9OqjY2EeyzCB2cz4DOkm675zxq
	 JL6KwB0fZU9KYh/Nm+QHgeC8ez8xunKlKD5U7SULqeD2rMW3sPKPE33fAC5RvCTjlB
	 onbR5qsYctL0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE31383BF47;
	Thu, 17 Jul 2025 14:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/mlx5: Update the list of the PCI supported
 devices
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175276382650.1959085.11642486429320492224.git-patchwork-notify@kernel.org>
Date: Thu, 17 Jul 2025 14:50:26 +0000
References: <1752650969-148501-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1752650969-148501-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, maorg@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Jul 2025 10:29:29 +0300 you wrote:
> From: Maor Gottlieb <maorg@nvidia.com>
> 
> Add the upcoming ConnectX-10 device ID to the table of supported
> PCI device IDs.
> 
> Fixes: 7472d157cb80 ("net/mlx5: Update the list of the PCI supported devices")
> Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Reviewed-by: Eran Ben Elisha <eranbe@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net] net/mlx5: Update the list of the PCI supported devices
    https://git.kernel.org/netdev/net/c/ad4f6df4f384

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



