Return-Path: <linux-rdma+bounces-14396-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2B6C4E516
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 15:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1E9D1886AA1
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 14:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CBD334C39;
	Tue, 11 Nov 2025 14:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSes4h+q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A11E32D0C0;
	Tue, 11 Nov 2025 14:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762870245; cv=none; b=s5cB3dSVLPFpQFNImbuETjFDzm0VtkY1iU5TuyowsjiMxUDmizb3zdmL+xxrcX5hzt7KHnf9pARqz0FMRUxjgAkN+pSVxCtbuxRMSdqYo0oaaO9pAnwcdi9+2EC7IQLaD6572OSBzVQx46P1MlAZcLaw+qHDZRfD60GZhqMWiiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762870245; c=relaxed/simple;
	bh=c2JxMe0Ll+HQtPVbv5Ys63HP4gmrS1IoooEa3rm6o7g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U6sPmo0/yekuZ+1BG2Q9Wa/53GWbGOVGvzIUMLW1w2YAfeOukfx7r9VgwG9p+dm0RpUl6D1MfAPcONkWub/RPS0RFc8wD5o1m00vxyOeVmx2tY93GH55OFCFtIAXU6GeQoicuccSKzxpUcRedS9S+Oa1EXNpzZs6XEfSTSwGUJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSes4h+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0531C4CEF5;
	Tue, 11 Nov 2025 14:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762870245;
	bh=c2JxMe0Ll+HQtPVbv5Ys63HP4gmrS1IoooEa3rm6o7g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JSes4h+qb6XoYDRT6MZDlWtKJKb0l+ZFUMmGkTTvyKcu/hU3qF0PPKykTdq9tjJia
	 4QTYkFyYd2CIa9rwCW65QiPvzb34oXxP8tR56idLspGavJJfV/HQvQzacDIwiNMSck
	 C7XjwfL5uSUErjdcJt52opMTYNrFRykMwWrNgVSc42MnZLs/yos6M1YGWdo2nbP8Xx
	 c0Qsa7W3r431kXSXJFfHLPEkSEq8smfvOPjB1M2HiU2cMUclphblLgxozAw6RilItV
	 9utpT6TWNPz1lZRBzzGWNQoFhZXfNWA4pHLjDAO5GN+t8m+zvqJDHf3xGmgUbN41Pp
	 pUrOymLrWBW2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CD7380CFFB;
	Tue, 11 Nov 2025 14:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] mlx5e misc fixes 2025-11-09
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176287021525.3454241.13761058812147958076.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 14:10:15 +0000
References: <1762681073-1084058-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1762681073-1084058-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 9 Nov 2025 11:37:48 +0200 you wrote:
> Hi,
> 
> This patchset provides misc bug fixes from the team to the mlx5 Eth
> driver.
> 
> Thanks,
> Tariq.
> 
> [...]

Here is the summary with links:
  - [net,1/5] net/mlx5e: Fix missing error assignment in mlx5e_xfrm_add_state()
    https://git.kernel.org/netdev/net/c/0bcd5b3b50cc
  - [net,2/5] net/mlx5e: Trim the length of the num_doorbell error
    https://git.kernel.org/netdev/net/c/2dc768c05217
  - [net,3/5] net/mlx5e: Fix maxrate wraparound in threshold between units
    https://git.kernel.org/netdev/net/c/a7bf4d5063c7
  - [net,4/5] net/mlx5e: Fix wraparound in rate limiting for values above 255 Gbps
    https://git.kernel.org/netdev/net/c/43b27d1bd88a
  - [net,5/5] net/mlx5e: Fix potentially misleading debug message
    https://git.kernel.org/netdev/net/c/9fcc2b6c1052

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



