Return-Path: <linux-rdma+bounces-14617-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 055BDC6C973
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Nov 2025 04:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EF4D934DE47
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Nov 2025 03:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB462EBDCD;
	Wed, 19 Nov 2025 03:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMd6259V"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E619C1C861A;
	Wed, 19 Nov 2025 03:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763522457; cv=none; b=CLkAqXtLgnjLWvS+FuhAkbrQXTJKXwuFzZjmUna4fguN6T+mQYpHzczATLZjsNlo/1FryJC6VdQuXVykySQb9op9Z2PKu6Sj7YQkVtrBIF99fNPDXcLjnzG2rDWUL05B8rw4MlasuQFZ3Z2H1D7Vt+346gUq6T+sOR9phTg0h9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763522457; c=relaxed/simple;
	bh=eWcQfUXFcstGpwOUaOnYmWP5KYZxhUIwy0AJAkJhDLo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iMXj4JwQYq7PzKgICYOshOqSunz8Wnb8R2ubtGvXKazYiMuB/oBPxwCsJAnXCPooLTrAgqm6Y1Oj/vxvEms9mTwcMMYkat2+NNfWsgMVv1z3J+hdzDGp2nwnnX46cfm/enlhLqyjmNOPfoDaVSVm3s6EQntk/9Cjqv2MsKDyEwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMd6259V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10226C19421;
	Wed, 19 Nov 2025 03:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763522456;
	bh=eWcQfUXFcstGpwOUaOnYmWP5KYZxhUIwy0AJAkJhDLo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bMd6259VjoNfBBFU88cBg5afDws4q1s+LbHwibflzkeD5yjUh84w2diC4u5ob0QAj
	 a2rFzD2ACd0ar02TaYzSrpQnU4K307tGaOj/rE5sBEMfBC3Vi72s2eVDvtmDClwYeW
	 td+Z+BjZkaZ8r6HhTFuu8iAcdfXy0BRORf/9Y/t5XapKL+5cCKGwzIz/3hK+/0P8Jz
	 qbM5KruWCoB59RJ1q/1QR5yF97nI55iGHI0gm8m+Gw3Z05W4meyeMQz5iIuzndATvP
	 uc/3Qt7XOmLhSoNxaRSZYBNeXXoGlGsuHrZiolplxrTsuLr2YSvAr4JRPQGRtnj2jZ
	 O8I/gjyl1Keug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACF9380A954;
	Wed, 19 Nov 2025 03:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] net/mlx5: misc changes 2025-11-17
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176352242149.205878.14124712790930552629.git-patchwork-notify@kernel.org>
Date: Wed, 19 Nov 2025 03:20:21 +0000
References: <1763415729-1238421-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1763415729-1238421-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, richardcochran@gmail.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, gal@nvidia.com, moshe@nvidia.com,
 dtatulea@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Nov 2025 23:42:04 +0200 you wrote:
> Hi,
> 
> This series contains misc enhancements to the mlx5 driver.
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] net/mlx5: Refactor EEPROM query error handling to return status separately
    https://git.kernel.org/netdev/net-next/c/2e4c44b12f4d
  - [net-next,2/5] net/mlx5e: Recover SQ on excessive PTP TX timestamp delta
    https://git.kernel.org/netdev/net-next/c/391dad2e686f
  - [net-next,3/5] net/mlx5: Remove redundant bw_share minimal value assignment
    https://git.kernel.org/netdev/net-next/c/ea3270351c79
  - [net-next,4/5] net/mlx5: Abort new commands if all command slots are stalled
    https://git.kernel.org/netdev/net-next/c/fbb9933666e3
  - [net-next,5/5] net/mlx5: Use EOPNOTSUPP instead of ENOTSUPP
    https://git.kernel.org/netdev/net-next/c/70ca239b612c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



