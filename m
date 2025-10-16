Return-Path: <linux-rdma+bounces-13902-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 495CEBE43DB
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 17:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5C1C19C757F
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 15:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9600834AAF8;
	Thu, 16 Oct 2025 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mM2kYG/c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B503146593;
	Thu, 16 Oct 2025 15:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628637; cv=none; b=dIs+/QBSM2oVeScyz9jM5YgFKaMzdxtcZOSX4tgyhrjsk4MF6kFqj7oV5/XS7F/wC8mOU3iJcFkuZ12j5/2aP8YIkVcknmJR5lUXsUbbZJPr95I3eyvyiJFgENRkrPp+YdLpqwV/fWuiBprCO2Q+M+Zn88AMkTrLJTecuYZFeT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628637; c=relaxed/simple;
	bh=Lhmv6rdY0inxISSKl3n5Ag3krRvAQwi8tYbRqPlFiRw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EtuzRTLEP1unBIhqD6gjetOlfiMCQrSPWll18kPQZVB3vzWOWmrPKaidLYLyWMAN6Ji7Ay+aPhIw/5VyrQhDmtVEpLWXNr1TmdQPpAfyqxdabxyXrvPrhzsLYMX528nwXLPyGyqxba8F7cCbnosqGBD6B3JifmqJzE8epTtCA1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mM2kYG/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C135AC4CEF1;
	Thu, 16 Oct 2025 15:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760628636;
	bh=Lhmv6rdY0inxISSKl3n5Ag3krRvAQwi8tYbRqPlFiRw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mM2kYG/ctYhaif1cG5SztUq0dXFHL2ttCIEZm4W/LWT3W5lCF95ZHhCkv+pFP5Y+1
	 7CH8akgP3jalnoyWkdpeUe2PaVfTiyA0YC3t6VgMgB1T6c6MR7898gVXLl7CrkH9Bq
	 atlKUZhtgDpM1zC35NyCwlIGb0UdmF7a2A5jVFD4CWwQopBfWIATfzPZwXFg2v23Id
	 bFaurgEnXhtetT2U9//oEoOMOD+GMLzE5LlmuX+1XEF4cql1kb+g5d8Nbk7lr7dZDW
	 BFW7tIXN+8SiC0pM7bEdNFdLxjKqLgIt+4xJMbMlZ1eB7y+j+YRcVc+G2yhNim+pOc
	 /mFLnEeeLywgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E0A383BA32;
	Thu, 16 Oct 2025 15:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] devlink: Introduce burst period for health
 reporter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176062862101.1781559.6540317333890628904.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 15:30:21 +0000
References: <1759906638-867747-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1759906638-867747-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: stephen@networkplumber.org, dsahern@gmail.com, jiri@resnulli.us,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 moshe@nvidia.com, jiri@nvidia.com, cjubran@nvidia.com, shshitrit@nvidia.com

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed, 8 Oct 2025 09:57:18 +0300 you wrote:
> From: Shahar Shitrit <shshitrit@nvidia.com>
> 
> Add a new devlink health set option to configure the health
> reporter’s burst period. The burst period defines a time window
> during which recovery attempts for reported errors are allowed.
> Once this period expires, the configured grace period begins.
> 
> [...]

Here is the summary with links:
  - [iproute2-next] devlink: Introduce burst period for health reporter
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=56d3c9965850

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



