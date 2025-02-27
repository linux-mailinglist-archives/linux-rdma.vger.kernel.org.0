Return-Path: <linux-rdma+bounces-8179-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7FAA473E1
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2025 05:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A9603ADE98
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2025 03:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5D81E1DEC;
	Thu, 27 Feb 2025 04:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qN6JZkkB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A5F270031;
	Thu, 27 Feb 2025 03:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740628800; cv=none; b=DXdXMeO6ns/vt/pELHMP8OpIV92Z9r+kYB1cX8YDYv+3avgQ82AYBzyO4WsZMZ4KTK0d8PnZN8WzWXxro1P+So25D5A0UDeW7ynbCkOW9DhTSeVvZpGJ3PScWYkt1dBg94cPRXzOndIGZqMyo1x03gDLP6m6RNCVu0JU+rszdbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740628800; c=relaxed/simple;
	bh=PXwwjYBG0TEbPFo6wPf+Qlk8kiWbzki99+R+i9PcAlw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I5/j3rGhqXUSOCM5nO0ODD71oYNEuYx6xc6b9s++psd0n0NsD1gkzvLbMxa6P9YolET0i8BbUMNvnW5M716b7+h/zf83lUH2NxqzDIdmYlcy7OgQ3mI/h9LNZRhfUtH8qG+wcvj0Wcn1X7hvCC6///Ox8bO2Vl1dpl7sVi7K4Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qN6JZkkB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0E1C4CEDD;
	Thu, 27 Feb 2025 03:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740628799;
	bh=PXwwjYBG0TEbPFo6wPf+Qlk8kiWbzki99+R+i9PcAlw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qN6JZkkBV5HIcGNQmUnMNUl0D/cnWKCb7pe8exBqMyO+R2lTfN5KxjWmBrY3IGs3l
	 rNR+8Hp721FwcsUszXwXtX0SBV+UUuXzet6UlldpXobJ5J7ECGAllxYdX44ypk4h2y
	 qO9PBKjGfxT6ZO8WyaTSt8KJpmgpd47H4uOX8X50GmoNGbGvJu+eCVwK4E5JHH2tFi
	 KaSsMQgxGyH33KUBQczz/qxM13TT6yUkmSzDcJ79umK/p+vC+j7RDdfF/L6baj506m
	 gKrvfKfYFdwLN9unOBdT7864ddEcrMA/y4U/YoRCN17uMbcxDJy5h/y7pR7ioyRszM
	 3gTzS4OHqbMZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE01E380CFE6;
	Thu, 27 Feb 2025 04:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] mlx5 misc fixes 2025-02-25
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174062883149.960972.10978491350422097713.git-patchwork-notify@kernel.org>
Date: Thu, 27 Feb 2025 04:00:31 +0000
References: <20250225072608.526866-1-tariqt@nvidia.com>
In-Reply-To: <20250225072608.526866-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, gal@nvidia.com,
 mbloch@nvidia.com, saeedm@nvidia.com, leon@kernel.org, cratiu@nvidia.com,
 cjubran@nvidia.com, shayd@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Feb 2025 09:26:05 +0200 you wrote:
> Hi,
> 
> This small patchset provides misc bug fixes from the team to the mlx5
> core driver.
> 
> Thanks,
> Tariq.
> 
> [...]

Here is the summary with links:
  - [net,1/3] net/mlx5: Fix vport QoS cleanup on error
    https://git.kernel.org/netdev/net/c/7f3528f7d2f9
  - [net,2/3] net/mlx5: Restore missing trace event when enabling vport QoS
    https://git.kernel.org/netdev/net/c/47bcd9bf3d23
  - [net,3/3] net/mlx5: IRQ, Fix null string in debug print
    https://git.kernel.org/netdev/net/c/2f5a6014eb16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



