Return-Path: <linux-rdma+bounces-13344-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 440A8B56B6E
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Sep 2025 21:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0234B1769C4
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Sep 2025 19:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CD22DA759;
	Sun, 14 Sep 2025 19:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6OiUtuV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5BC1A9FB5;
	Sun, 14 Sep 2025 19:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757876416; cv=none; b=LXVwL666QKCFaQ40HGQGgWiwwFK+d1JXN/rVRYN1KYPaDJiEqrv+pnXjuThpDPdm/jN6gtv0AhD6xyvdUDrOLfDyUpxDeWNSISenEWxZpVGGJZjfQ52973HYjGYkpArm7VqyGsDjrU4EXlQoAa+digBK7uftEwkPFdUxOWw4NB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757876416; c=relaxed/simple;
	bh=o07hps2pwSKAibnqP9x0ltQKVFPIMhLl/sMLgFNhBEE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TcympX3FngsJhlfjv7Ogm8BnbdxpH5EvZ9wXkwLS/pTr7ooeC4X3t4yCwRZ8Wa40B3ykaxBPtskctgziwCos7rg8Zlx1/8F6HUMihFmebFySAWeG0H5hCTS7FwwLKFqQgNeCp0fVVZZJxux1vC7HDQIwmrQq1zlwhPm1Gg6yRME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6OiUtuV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AD6C4CEF1;
	Sun, 14 Sep 2025 19:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757876415;
	bh=o07hps2pwSKAibnqP9x0ltQKVFPIMhLl/sMLgFNhBEE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k6OiUtuVn+a75vsC9duCl3l3YKVHSd2WLYfpb6EyyXpJ6RQcJEk6/2yqIkapZ4p3j
	 kq/FE/v5oV9iyuCyvc4QgFmYuQr4E+EEuy6R1CmaVCGRlszlvsovSKcBKXgjdPjMU0
	 kmGSfQ2bdcjoj7tJit0H2VCzeLcCPTKeb8eAM9vLWOEFutOuIqJ+9iv+ObdRTRxLVW
	 mbRxTNm5UVd/BSj9aXTaGqiu0Vrpoxq7iN9Y8AS0uV6HlcPHchvwX8naa8DeT6hVpf
	 8K1GO1OWw0tjV7vfOCWtslmu+bV/p979Jy7cdBqPAp7mF9upkDdRrrSgGXg/vHb6Ck
	 /O0KaUUZdGhyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C0739B167D;
	Sun, 14 Sep 2025 19:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/smc: Remove unused argument from 2 SMC
 functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175787641724.3528285.12239252710706994693.git-patchwork-notify@kernel.org>
Date: Sun, 14 Sep 2025 19:00:17 +0000
References: <20250910063125.2112577-1-mjambigi@linux.ibm.com>
In-Reply-To: <20250910063125.2112577-1-mjambigi@linux.ibm.com>
To: Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, alibuda@linux.alibaba.com,
 dust.li@linux.alibaba.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com,
 pasic@linux.ibm.com, horms@kernel.org, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Sep 2025 08:31:25 +0200 you wrote:
> The smc argument is not used in both smc_connect_ism_vlan_setup() &
> smc_connect_ism_vlan_cleanup(). Hence removing it.
> 
> Signed-off-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
> Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net/smc: Remove unused argument from 2 SMC functions
    https://git.kernel.org/netdev/net-next/c/010fe36ad2a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



