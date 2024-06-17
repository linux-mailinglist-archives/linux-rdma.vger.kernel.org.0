Return-Path: <linux-rdma+bounces-3203-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8997190ADD4
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 14:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B583B23DA7
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 12:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0891957F6;
	Mon, 17 Jun 2024 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sx7j8cLu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DFE1957E0;
	Mon, 17 Jun 2024 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718626830; cv=none; b=P9Hr0Jyh/vQowSqn0DDMPLHlok5SDGbjohtsMUoKdmBGU+W++qoN6npzs/WaD6+SaZ83SEwlceH1nPWnhfzfsccMMnrISys/xCezZd4Jlc3MgHpATrw9xw6D3fUOVoy+0Z0FXgV5gw82MzXA1cCyLS77OX7NY2qTNpy8KH7tKM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718626830; c=relaxed/simple;
	bh=4fHPDN5JIammBw7jv1D0hJOKHmpU3vwq+9qfinwxLBg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ptglLSsMZ7Mhepf/UTyeGuWCdJCZ8VHVLkeS2OM1dp8qHjLR2OW1Md8B7OaRq1ZIHnE+x+rIx1GcJ4uVyKmDvE2FQJve4RwRGaBnNegkDfwmj5MU0fy2KOOCWujwmpGanru2gg1I2iNy+5ae96P2ftguibzFIxi7PdId++1qu64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sx7j8cLu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64E3DC4AF1C;
	Mon, 17 Jun 2024 12:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718626830;
	bh=4fHPDN5JIammBw7jv1D0hJOKHmpU3vwq+9qfinwxLBg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Sx7j8cLua9VPiJ+D/ORWOZeaJkFQGTNylOo9Ql9/4wGwWHf3X3259/nIIV/WIAokr
	 cLnuWiE3K1Ok5kuVoPxa5S+q06t3ekl/Iajoa3Igc+P5YrJVD5XEkOVYYZOQNNSV1Y
	 7WGebBixqfywJX22y/VbZDjzWgnJlP6M5MzrtClajl5G/+ht+ZqWqE0xgslwRlw2xC
	 HLLb8BiyCEVhZMJjfGDuZ6vQXaNniawmvfF9pZcQpnsbuK+S4xqziXbdUOby/IsQr/
	 I1gguO0Vk07+RJkIZzFUnh/IEru5621ZXncQosNHN3qa1PLtpiZlXuMzRPl+OW3+ns
	 bsf8uL/RUK9NA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 50CEFC4332E;
	Mon, 17 Jun 2024 12:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8 0/3] Introduce IPPROTO_SMC
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171862683032.300.18237417031769140758.git-patchwork-notify@kernel.org>
Date: Mon, 17 Jun 2024 12:20:30 +0000
References: <1718301630-63692-1-git-send-email-alibuda@linux.alibaba.com>
In-Reply-To: <1718301630-63692-1-git-send-email-alibuda@linux.alibaba.com>
To: D. Wythe <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 wintera@linux.ibm.com, guwen@linux.alibaba.com, kuba@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, tonylu@linux.alibaba.com, pabeni@redhat.com,
 edumazet@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 14 Jun 2024 02:00:27 +0800 you wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> This patch allows to create smc socket via AF_INET,
> similar to the following code,
> 
> /* create v4 smc sock */
> v4 = socket(AF_INET, SOCK_STREAM, IPPROTO_SMC);
> 
> [...]

Here is the summary with links:
  - [net-next,v8,1/3] net/smc: refactoring initialization of smc sock
    https://git.kernel.org/netdev/net-next/c/d0e35656d834
  - [net-next,v8,2/3] net/smc: expose smc proto operations
    https://git.kernel.org/netdev/net-next/c/13543d02c90d
  - [net-next,v8,3/3] net/smc: Introduce IPPROTO_SMC
    https://git.kernel.org/netdev/net-next/c/d25a92ccae6b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



