Return-Path: <linux-rdma+bounces-5846-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A90C39C0F26
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 20:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60CAF1F243C8
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 19:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D158B2185A7;
	Thu,  7 Nov 2024 19:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibUGZtWH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B5C21859E;
	Thu,  7 Nov 2024 19:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731008425; cv=none; b=c6sfnSQVmhG/0fm8ZTFT/o78iOAbF5A8bGH3JxUuvQAW7F/mtEqiHw/wXKVyzv3HFMfzV740Jv4FGEg1tSKAZu7IlRxW2XJtObDJoXLLFFP404kXXOKfS4eleC1+D0TbyYAyfGPnQhkaqLYWW/ryU8FBbc3l6zbyufz9NM9Lawc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731008425; c=relaxed/simple;
	bh=sTmizrCUjlvYCQAiHErIWBZ84osWqGQ3MzmDSa7wwyM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n7UqBEnPLB6z9Z352a9T/GfSxKpy94GLJrPKJf51WRefVSEKtAWm6+OhhcUiqwD4t3QSmaKSuQt7CKKZ5HLhwdg+QPcuKj9fe4M6+PdY2KpBTXV3N2XKPxuugTHttGMhBGgHtN7Dl0hjCKs5ZJjChihMStOa/E5vble2Zo8G7WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibUGZtWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03715C4CECC;
	Thu,  7 Nov 2024 19:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731008425;
	bh=sTmizrCUjlvYCQAiHErIWBZ84osWqGQ3MzmDSa7wwyM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ibUGZtWHi0/35oOoJRYTNPPRDl198+FHWBVrDk4vtZVzw33Q42t3zuXyYOmUoyj2i
	 VmdCR5XRDkMWWDmSojuXEmo2CxyC4Qyqie2PYs6O35sgeceruKYR3LAwSKyx4rpCXA
	 0lgAoTMzVNf4gLvfCheaLayb08GK0DYp62QiY9diODtxeXT2s/Px7rVvmIiMQALRbF
	 PEwxrCM+w2wVbzl8rooxyxswKhpnnKYRmDxiJ7Na4hqvbFTxynZqvgmgQm3OEB71vd
	 OPgJyFlLinVML+W8jncJlZsofhapDQLwzUn3dicF1pRGxSEcmCWZFCDeobrGSj0+MG
	 WzmxYwNk48BCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7169B3809A80;
	Thu,  7 Nov 2024 19:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/smc: Fix lookup of netdev by using
 ib_device_get_netdev()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173100843399.2072933.10805730213693897963.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 19:40:33 +0000
References: <20241106082612.57803-1-wenjia@linux.ibm.com>
In-Reply-To: <20241106082612.57803-1-wenjia@linux.ibm.com>
To: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, horms@kernel.org, leon@kernel.org,
 michaelgur@nvidia.com, hca@linux.ibm.com, guwen@linux.alibaba.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com, jaka@linux.ibm.com,
 gbayer@linux.ibm.com, wintera@linux.ibm.com, pasic@linux.ibm.com,
 niho@linux.ibm.com, schnelle@linux.ibm.com, twinkler@linux.ibm.com,
 kgraul@linux.ibm.com, raspl@linux.ibm.com, aswin@linux.ibm.com,
 dust.li@linux.alibaba.com, yanjun.zhu@linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Nov 2024 09:26:12 +0100 you wrote:
> The SMC-R variant of the SMC protocol used direct call to function
> ib_device_ops.get_netdev() to lookup netdev. As we used mlx5 device
> driver to run SMC-R, it failed to find a device, because in mlx5_ib the
> internal net device management for retrieving net devices was replaced
> by a common interface ib_device_get_netdev() in commit 8d159eb2117b
> ("RDMA/mlx5: Use IB set_netdev and get_netdev functions").
> 
> [...]

Here is the summary with links:
  - [net,v2] net/smc: Fix lookup of netdev by using ib_device_get_netdev()
    https://git.kernel.org/netdev/net/c/de88df01796b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



