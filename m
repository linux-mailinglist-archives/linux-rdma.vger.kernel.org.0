Return-Path: <linux-rdma+bounces-12785-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54821B286AD
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Aug 2025 21:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47ED65E5C60
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Aug 2025 19:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344FC29B790;
	Fri, 15 Aug 2025 19:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSlnMD7L"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13A426A088;
	Fri, 15 Aug 2025 19:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755287405; cv=none; b=Ua1yD1rI+McZrZn4glSoDUnq96WxCNMvkdvXFgofbacuGUgsXzFOKrFVX+4SccQD+awNjscFq3UW4q/mHE+/rG6fz5lm19rC1OogUwPiEFKj1XBKV0+vx3x3kb9aZ6T5TOYtHVkM+lG7Ye9LlaM/RouHfqgha9v4Ci1k1Bjh960=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755287405; c=relaxed/simple;
	bh=e0jzt6J6vmxwqhPeZoIbQfaTuNCk0nUAqB7/DUg091Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Hw/eWwiX6+faRF95hG3ogsYvrTvEXj6/I8l1GM1zlO+/rkCN++DRp84s9vNN7XuYGie0pphUmJdf/3QUUfMo8EpA5qN9tuZmTDtIq0HUWHUsgFbqCa7pf0uZbj5bgDrOnSiU0gUE1F5bh7BHygDED7gutA1PBZ/2FrKeXqou8mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSlnMD7L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B833C4CEEB;
	Fri, 15 Aug 2025 19:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755287404;
	bh=e0jzt6J6vmxwqhPeZoIbQfaTuNCk0nUAqB7/DUg091Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qSlnMD7LbBHk6yGRSwlk7YKRQE3A+0DYlMenzLYOTDUpDSnM8TCA4nYlCM35RI5mG
	 HrON2mQjW0T4njfTnwWArSg312Dk5gntPcCNxVM5eejYy3dG+3ewdn9pbqUzgVdaUz
	 w94Ex8glVt5tDtwPH2pkP8sJ/6q9OBJf3jsaqaaKGbA7zSOICW8uinybnK08mL8nQd
	 bazqcCL2WkUJheymxFZVBA7O0LIGr+nibj+PDttFZZAfr2EuIUq85XEnbAQaWFkzxw
	 3MvX8HQKggFNyE0yXaX5gEOmpcY+16Jxys1YWG3Xu1kMfV07ZO9rs2bsGjNuh/3F7Y
	 GXu4Y9Ol1TbMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF4D39D0C3D;
	Fri, 15 Aug 2025 19:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net/mlx5: Support disabling host PFs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175528741548.1253623.12610948985665011253.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 19:50:15 +0000
References: <1755112796-467444-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1755112796-467444-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 dtatulea@nvidia.com, danielj@nvidia.com, witu@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Aug 2025 22:19:54 +0300 you wrote:
> Hi,
> 
> This small series by Daniel adds support for disabling host PFs.
> If device is capable and configured, the driver won't access vports of
> disabled host functions.
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net/mlx5: Query to see if host PF is disabled
    https://git.kernel.org/netdev/net-next/c/9e84de72aef9
  - [net-next,2/2] net/mlx5: Support disabling host PFs
    https://git.kernel.org/netdev/net-next/c/520369ef43a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



