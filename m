Return-Path: <linux-rdma+bounces-957-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BCC84CF6F
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 18:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 967D41C26AC9
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 17:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81060823D2;
	Wed,  7 Feb 2024 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZayXN/tQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32123823C3;
	Wed,  7 Feb 2024 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707325828; cv=none; b=tHNOvQEW7cy0UYemLfWT1pPD0OGJSCyYM2P70jOaFuYOOQ7eJNnkVfl4vNhsyE6qYrIRYWteGD9ZInW+vYfYC6nL7sr/kW1dA3absnUtxWLzMXsBlzkzubOmXtRFvVXwyXM0xQN5sTC2zPkqX8sm24i9fnEopHLJoc86SwaW5PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707325828; c=relaxed/simple;
	bh=+XDpYIVLWdRrV3018Nh+4d75s8c0kX/XZgHjojbaX9I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T4TYpJvC4qlbETw4gba2c0T8+jAcOFpVJOWaVwAMXYx+viWqMI7+/tgKr/MzVJW9nkhjx2pa7ordx0eTq1m76Mi0uv0RqbFHsS5husSYKiGNVmnLqi280e+Zi7vUmP3r0PSqVp+gMM1mKzaB4v5fqBDS/AFoSZeG5Fe5vG4qtHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZayXN/tQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98D17C43390;
	Wed,  7 Feb 2024 17:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707325827;
	bh=+XDpYIVLWdRrV3018Nh+4d75s8c0kX/XZgHjojbaX9I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZayXN/tQiqnyUlf5KEFImk/hN8OFDg0/ubLAKGKJdTbV9Gr+hXRv1D5MhsLay23Qa
	 7sZmC1RtZXOB21Nizng2ghs39FoH4XjZnXCy8vwIxdklQlSWQTjkLPOT+SB1JvUIMp
	 zY/S5iYDm3I0Wmxiu0+buDmLeGX/gW0L8xmeHs+17pktn1NK9FbAHSO7Ie0Rw4XpdQ
	 vcptBS5NvSgeI/Vx5232bPcSySx2P7wZUVlga/3b/jW42u4Gy/45+HHUACrNH59y6X
	 9YDkBe7q2IuE6XN8YBCpuyjXm7RuveNg3aeaLxk0urTFHmMe32KKneVZNmm47xebML
	 wmuEvrWGi55zw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7E8DFD8C96F;
	Wed,  7 Feb 2024 17:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] MAINTAINERS: Maintainer change for rds
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170732582751.14396.3479217370175793292.git-patchwork-notify@kernel.org>
Date: Wed, 07 Feb 2024 17:10:27 +0000
References: <20240205190343.112436-1-allison.henderson@oracle.com>
In-Reply-To: <20240205190343.112436-1-allison.henderson@oracle.com>
To: Allison Henderson <allison.henderson@oracle.com>
Cc: netdev@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-rdma@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, santosh.shilimkar@oracle.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Feb 2024 12:03:43 -0700 you wrote:
> From: Allison Henderson <allison.henderson@oracle.com>
> 
> At this point, Santosh has moved onto other things and I am happy
> to take over the role of rds maintainer. Update the MAINTAINERS
> accordingly.
> 
> Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
> 
> [...]

Here is the summary with links:
  - [1/1] MAINTAINERS: Maintainer change for rds
    https://git.kernel.org/netdev/net/c/5001bfe927b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



