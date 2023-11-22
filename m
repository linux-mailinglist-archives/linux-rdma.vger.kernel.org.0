Return-Path: <linux-rdma+bounces-38-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2997F45D9
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Nov 2023 13:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38BF91C208C6
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Nov 2023 12:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E364D56760;
	Wed, 22 Nov 2023 12:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6Nerh6X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2644AF66;
	Wed, 22 Nov 2023 12:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4948C433C8;
	Wed, 22 Nov 2023 12:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700655626;
	bh=hDmkA2kqfr7d07VIpNvRLQJelKYV1Jo1lOKxsInmw8o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z6Nerh6XBFkimNvlhPvegdyFqgIM4ZnW1Z/KLfBHh74LwsKLWH1k17WhRNjBujOb0
	 7IlYmwaPKNCkMNFyv/s++iQyw+ugVetPKrCBviPIiooimIfB77xbxFh8TDhGex4Tjf
	 lBX5XeIEHuQrIY/oq4KE+jkfVz2ZaABM7skLevgFo2RNQd4yM8W4g1YvIqp/D2RTzh
	 GptGir+T+qzv8lBtXL2fmPgAhHaCt+ZsR+Cz+j0YS+Xvw9E2O9sNnAdm2/MNcINlZL
	 hTirBAnL2NaZMBz4EeJJnNAIvv43ynEQl4W1Oz/eUCOMdnRcLq7dXADv/qKpqPFNIY
	 IK/mwHju2WkNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C400DC3959E;
	Wed, 22 Nov 2023 12:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] net/smc: avoid data corruption caused by decline
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170065562579.16844.343465516661196082.git-patchwork-notify@kernel.org>
Date: Wed, 22 Nov 2023 12:20:25 +0000
References: <1700620625-70866-1-git-send-email-alibuda@linux.alibaba.com>
In-Reply-To: <1700620625-70866-1-git-send-email-alibuda@linux.alibaba.com>
To: D. Wythe <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 wintera@linux.ibm.com, guwen@linux.alibaba.com, kuba@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, tonylu@linux.alibaba.com, pabeni@redhat.com,
 edumazet@google.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 22 Nov 2023 10:37:05 +0800 you wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> We found a data corruption issue during testing of SMC-R on Redis
> applications.
> 
> The benchmark has a low probability of reporting a strange error as
> shown below.
> 
> [...]

Here is the summary with links:
  - [net,v4] net/smc: avoid data corruption caused by decline
    https://git.kernel.org/netdev/net/c/e6d71b437abc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



