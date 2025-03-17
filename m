Return-Path: <linux-rdma+bounces-8754-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FF6A65BF8
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 19:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16C638808DB
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 18:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85471B3952;
	Mon, 17 Mar 2025 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o67oqCV1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D72D1527B4;
	Mon, 17 Mar 2025 18:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742234999; cv=none; b=d95OJVHh4Ka/2BmJAy4UsIc0F3pSbc36tyWwsOsDG31KZxAr6bjLIOqxoR/sllKhPLkdgIAxBXsmoaY7bgSpAhttADyQY9lh6aefq5YtfO9rPsqw2i/tI0NIISKzGJ6Ek+kx6wtwRlm4hcV4FD4SseZnL+x8N7h4xOgizkn0gLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742234999; c=relaxed/simple;
	bh=S61WwX5SYcFVNzBvRGsTiux8cCXQ2421uz6PYqITOes=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oMcbvyYcPGeUoTdl3+uidfLqZCrCRq27flD12YB8mjU/drLSLSCV/FN9gxPbdlK6dcgNKqEhJ86XDijUmMsG60Do6jm8Gu8dsrrNI25eEb7/PBNXXPww+uh+o2pwIoSq+7bTFn9xL0pJLYHnRAymOPatCJi1XGiRcEwLNngpLQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o67oqCV1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE77C4CEED;
	Mon, 17 Mar 2025 18:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742234999;
	bh=S61WwX5SYcFVNzBvRGsTiux8cCXQ2421uz6PYqITOes=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o67oqCV1PP9VCQRXJUZXANOao7HKeO8o0o5AjTmcbmE8hdgnio9qjKkdoKFVQm14e
	 LVLwssWBSgJuQqOWgWal00dYMnRoGIq21iwXmSNSi2KNdpfqUm9mdMAZPYrww/VG2+
	 7RYtr9xDi6HwophRftsbMVuZteBtb9urP0rgvpD4g8hcsaJFjUdsRkS/iG46RwEEd3
	 aEXH3RVQXNBsdsZQRm1sPdLOuBbGEhfrLtJgj4gVwHoDiMgiU1zyOLweUxqi9Uj1r2
	 76k1RpQF96prgBHSDQkzowyIstoV7FKkB7+QctboOPfJPElphukXCXjQjEicBNE+MS
	 UZnuHK305vrXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7108D380CFF7;
	Mon, 17 Mar 2025 18:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] mlx5: Support HWS flow meter/sampler actions in
 FS core
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174223503427.3862374.13525687285276014271.git-patchwork-notify@kernel.org>
Date: Mon, 17 Mar 2025 18:10:34 +0000
References: <1741543663-22123-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1741543663-22123-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, gal@nvidia.com, mbloch@nvidia.com,
 moshe@nvidia.com, saeedm@nvidia.com, leon@kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 9 Mar 2025 20:07:40 +0200 you wrote:
> Hi,
> 
> This series by Moshe adds support for flow meter and flow sampler HW
> Steering actions in FS core level. As these actions can be shared by
> multiple rules, these patches use refcounts to manage the HWS actions
> sharing in FS core level.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net/mlx5: fs, add API for sharing HWS action by refcount
    https://git.kernel.org/netdev/net-next/c/cc2cc56fc6e6
  - [net-next,2/3] net/mlx5: fs, add support for flow meters HWS action
    https://git.kernel.org/netdev/net-next/c/82d3639ef7dc
  - [net-next,3/3] net/mlx5: fs, add support for dest flow sampler HWS action
    https://git.kernel.org/netdev/net-next/c/32e658c84b6d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



