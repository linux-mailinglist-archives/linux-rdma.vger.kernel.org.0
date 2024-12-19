Return-Path: <linux-rdma+bounces-6637-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 482C09F718A
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 02:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 709F97A23D8
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 01:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D7370809;
	Thu, 19 Dec 2024 01:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWypneW1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF835674D;
	Thu, 19 Dec 2024 01:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734570012; cv=none; b=QXwSnKD2WjcCCvZGThrANz7KDb1u2EVzdUl9VpsXaNzzrfRMRnVtNUiqfUX+sA59expo5VnnPi8nKXILaojcx7Dq0BmfUMjsvty84I5YMGnMShf9YoMWxgnisgREd03tf0XYTEe4W3OkIsOKWGNaM2Iy5FkCAJ6G2F8YMom9q1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734570012; c=relaxed/simple;
	bh=vLD1EqHF+ZDq8S/ebGt8PFQEMVsqIqfEnyszBr09Qss=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nXhLw8/o7lY7/40+Da09bg1Pw7UOulaeGOqsS8AGsiaNKHF3wHuUzq+noKFKrVfakMgSvH2X1VOWxARqWFkUQ7wnjR/zE+lNIopNG+61dD++RVLubnEXDt3Zsh+30ji/fwnmtiJpwDRuyo+VwOhcN1SEgzFLYUTIBjtqyu08IuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWypneW1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36424C4CECD;
	Thu, 19 Dec 2024 01:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734570012;
	bh=vLD1EqHF+ZDq8S/ebGt8PFQEMVsqIqfEnyszBr09Qss=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DWypneW1wOedmzqVkVXQAVYdxf4V/1qb+aTD8mwJAzy/I0QdMsZLVNNypyX9HyXsM
	 2w+YFRZFtFHg/CoPzBqDOgZk0jPjgNJzhX40rS9utDqp57eD1cEsJQjO7cgUa7j+Dk
	 rN7wgBaLViFh+YO5V3XWvfH79OXwQUhM+h7HzxCNkH1MbmNl3P7xw5OtIjU72FlpZX
	 aHYxGlNbpKSkAgB2eFqMFeQWkoxvDVJdUXTcRN56LsC6rNcl4hv3PmUpEngoK2u2f8
	 FAjCPzwdSZPzeoShEPpzjUA6Zixhu/Z0WckBY2UrFfSfFlcbVk3O9rtWF0h1+uohtY
	 wMUk9PLsr8ewg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB4A53805DB1;
	Thu, 19 Dec 2024 01:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net-next] net/mlx5e: Report rx_discards_phy via rx_dropped
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173457002977.1776609.4427230236566101128.git-patchwork-notify@kernel.org>
Date: Thu, 19 Dec 2024 01:00:29 +0000
References: <20241210022706.6665-1-laoar.shao@gmail.com>
In-Reply-To: <20241210022706.6665-1-laoar.shao@gmail.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: saeedm@nvidia.com, tariqt@nvidia.com, leon@kernel.org, gal@nvidia.com,
 kuba@kernel.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 ttoukan.linux@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Dec 2024 10:27:06 +0800 you wrote:
> We noticed a high number of rx_discards_phy events on certain servers while
> running `ethtool -S`. However, this critical counter is not currently
> included in the standard /proc/net/dev statistics file, making it difficult
> to monitor effectively—especially given the diversity of vendors across a
> large fleet of servers.
> 
> Let's report it via the standard rx_dropped metric.
> 
> [...]

Here is the summary with links:
  - [v4,net-next] net/mlx5e: Report rx_discards_phy via rx_dropped
    https://git.kernel.org/netdev/net-next/c/c9cfced17365

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



