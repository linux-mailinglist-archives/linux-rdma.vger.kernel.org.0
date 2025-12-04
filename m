Return-Path: <linux-rdma+bounces-14889-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5779CA360C
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Dec 2025 12:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21701313DBFB
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Dec 2025 11:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBBC2E2DDD;
	Thu,  4 Dec 2025 11:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVLUdq0A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AB62E282B;
	Thu,  4 Dec 2025 11:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764846192; cv=none; b=ZfKIiRy0qFXPbWvJhradSNGqH49K682lHNJq8nKjHmQPqg7yd+J3xZvSQXXkkfGUgV1gyUFLhymbiopU8PSPX7B75XUWkzlyX8N79aDebU0CzrPMk5VBIav7L23J4v3x3FmlG2hNoQfVMEKh/9X6TA++b9ZNN1ndpMSL5/EdF1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764846192; c=relaxed/simple;
	bh=n7ah62zk8gPH6xb1BH5GqmZb4VSNoiADEseLCPrjvDc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RUawEjoXreIu9A3Rafyh29fa3Atm7m6ID0qFOmfiVk+PoqHQH94aYeXThC2hUTaN82/G9GIT43w1ZfU2xFGyF5R+ggDcIRzpDnQRJwaFPoukpiGj5w9PW5F/VizqkC0WZYF4zb1jmCBOCfIOl4hlDRq5MbIcme5byS1WYVmR8hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVLUdq0A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF255C4CEFB;
	Thu,  4 Dec 2025 11:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764846191;
	bh=n7ah62zk8gPH6xb1BH5GqmZb4VSNoiADEseLCPrjvDc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nVLUdq0A7gpAjBUBbcpehJO63bxf3hy7Z+5KDj9G6QWSefLLMUQh3H+Vh6Yqnoyy0
	 P1fIMLX/YKuX74uDw9IGs96Id5H1cgHxXQpRXWrD3SFheoqsRKasPGdG4L+0lvolvD
	 p6Jv/yGmUUb5xqtpaFZCbvmFNzjqEj/xE+5BqXiqWdICMxlxpi/wBePdIo73lN/SLp
	 jPW6C0e6yt20UpVuFqqm6bJuFE/8Op4/6WHEyQ4mFKO1CrJXUpzOVkxfBOGWoLCd6j
	 axSoF1gO1W88pvBJ9JmJnH5Ey7VWWpSUi4I4OimpBvzC3gK1+hRghxpcKls55nsX3+
	 e0s61YQViUP6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78F7B3AA9A9C;
	Thu,  4 Dec 2025 11:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] mlx5 misc fixes 2025-12-01
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176484601029.732369.14722259255665486033.git-patchwork-notify@kernel.org>
Date: Thu, 04 Dec 2025 11:00:10 +0000
References: <1764602008-1334866-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1764602008-1334866-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 mbloch@nvidia.com, leon@kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 moshe@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 1 Dec 2025 17:13:26 +0200 you wrote:
> Hi,
> 
> This small patchset provides misc bug fixes from the team to the mlx5
> core and Eth drivers.
> 
> Thanks,
> Tariq.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net/mlx5: make enable_mpesw idempotent
    https://git.kernel.org/netdev/net/c/cd7671ef4cf2
  - [net,2/2] net/mlx5e: Avoid unregistering PSP twice
    https://git.kernel.org/netdev/net/c/35e93736f699

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



