Return-Path: <linux-rdma+bounces-14671-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9734FC77057
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Nov 2025 03:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A8F6D4E68C6
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Nov 2025 02:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9676E27AC4C;
	Fri, 21 Nov 2025 02:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jN1W2uFn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E8222688C;
	Fri, 21 Nov 2025 02:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763692848; cv=none; b=ToqP7GXjY06HlY7Wj3gUzoMgh8efR7pw+mqoCjG4mPgIJzWTAIQRutYOFltETtD8x/ZFN+3LRb7HbJrkEpO81qDB1sYFQXNSvQOawulyWUPSYHyiPQj4hq7/epqzDRMWtqkbBSVoteDRjYxRzcpDSRoiwqv0SxqdLhd1vuMiQqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763692848; c=relaxed/simple;
	bh=cKhn9TvKH0Q3uksyhrpf7C/BJle5HWr4Ikjozz9L9ow=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s0xHyL9vbZ9QLRWZxCBYxNxw6Vkch/ntmEG929zWz873y8HkiDyHlTn59LfA9NiaZp0OgzpNOqkllCndn+qqksg2ncjOWOKHjGkA9tWc9Hde/2wSEBckq9NBqxdqNtgn6nBEUVrXpT0NNJXe/v3wYNNJk2GMz7PMNhW8nbbQFQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jN1W2uFn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C12C116B1;
	Fri, 21 Nov 2025 02:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763692846;
	bh=cKhn9TvKH0Q3uksyhrpf7C/BJle5HWr4Ikjozz9L9ow=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jN1W2uFn+WthorToE5sEpNk81LATQHtho/xvHNoEDf3u5Wxl8dRGnRdqGI68CudSm
	 BWYzrXvotAL+KG+pMOe6ZYF6PMzQenUdfrK1CFxqjM88LaqNAH1QtjTpggMkPlFLXm
	 P26dz9qAO3DJuiYnE2fvRH6Ajj8siL/Kap3gzNt+hSI/SGdv0ZbOprkrT/df3UQzPc
	 fOD5REVTXXVZ/yumqKuPkdutlJ7MWs0u7VYXI0yTmuiR8C5HMcD79Qc2fW6th+DstA
	 PbjUoiRAI0+m7dMlDEfIO0ws6HEhYXvQgAkh00+7QGZJw+3SwOqykw4wDV9JOIfHKG
	 ejwdVmuIsY+Gw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0323A41003;
	Fri, 21 Nov 2025 02:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V2 0/3] net: Add 1600Gbps (1.6T) link mode
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176369281176.1867628.13789111417642118505.git-patchwork-notify@kernel.org>
Date: Fri, 21 Nov 2025 02:40:11 +0000
References: <1763585297-1243980-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1763585297-1243980-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, jv@jvosburgh.net,
 saeedm@nvidia.com, mbloch@nvidia.com, leon@kernel.org, hkallweit1@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, gal@nvidia.com, moshe@nvidia.com,
 shshitrit@nvidia.com, ychemla@nvidia.com, dtatulea@nvidia.com,
 maxime.chevallier@bootlin.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Nov 2025 22:48:14 +0200 you wrote:
> This series by Yael adds 1600Gbps (1.6T) link mode support.
> See detailed description by Yael below.
> 
> Regards,
> Tariq
> 
> 
> [...]

Here is the summary with links:
  - [net-next,V2,1/3] net: ethtool: Add support for 1600Gbps speed
    https://git.kernel.org/netdev/net-next/c/491c5dc98b84
  - [net-next,V2,2/3] net/mlx5e: Add 1600Gbps link modes
    https://git.kernel.org/netdev/net-next/c/be3a435df74b
  - [net-next,V2,3/3] bonding: 3ad: Add support for 1600G speed
    https://git.kernel.org/netdev/net-next/c/5fb9a0b89e2a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



