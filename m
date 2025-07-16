Return-Path: <linux-rdma+bounces-12224-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB62AB08068
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 00:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26804173BA5
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jul 2025 22:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DED528850E;
	Wed, 16 Jul 2025 22:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RInTtIp8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BE426A0DF;
	Wed, 16 Jul 2025 22:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752704391; cv=none; b=WUz2VcoeXMlVactl7En3M84ZmMqoI0wFeSsHOZWQLpuahsFqmPTbmTDru9v/oMcucUcVnXQjGL1LM9JkzOr/m93qnd00wEhTqKl0Ws8TWLY3pmOzPH/yPxpJdAAAR3c0qRevQVhv2aghb95clSK0TpXH9z/kIowFNETHVVsoEf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752704391; c=relaxed/simple;
	bh=ekOW3YV7E56R/GrM8UnsA6cNmI3lqcHEOswB0QXS9Sg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CEAFvzx6gvpDuPSfoQz8KhuNpyGDQuboGAkbLgp59p076dgAm0nGJfXfAaJZsB7mVpnwwdjQf6uKsLveL4DYPcw0lLP3/BLCwQt7I3u8nQAR09eTerrt/JCXP47WJkDJ9D8JmBLbA9sT4BDe9tAg9d/RDyY2bA0pMxtO7FARypE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RInTtIp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004AAC4CEE7;
	Wed, 16 Jul 2025 22:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752704391;
	bh=ekOW3YV7E56R/GrM8UnsA6cNmI3lqcHEOswB0QXS9Sg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RInTtIp8ls1Tiw/gIfN/IksTFXYPgJluylTaYdWyFoSWALIGST5P81X4PzO7olvN+
	 VOLKAxWLT3KtwCxSrpS9QJaqD2GAjfq3B85PDj4aIk6xAxbYjBsucm+/nj+oTaNHDL
	 CSJK9bntSM4FPUFFkBiwUSGavhPl/8iXtmKeQNTVy/Ir+mzOnEJywDFDAggo73Qjh+
	 69y4PUvmjauHXiPMBsonmFBgCAygJpSXMhzxMabT5RmzS4Zss33llyPkLrIdxr2gkA
	 IcJhJ2tF3XVwlv/aB9rIVbYZZMWDewGdq4+ufgUaJrmXLlvCzxhbhp5rWvZbBRU9rb
	 uLhtVrrPqm6EA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70ADF383BA38;
	Wed, 16 Jul 2025 22:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/mlx5: Correctly set gso_size when LRO is used
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175270441127.1344714.726257145525380082.git-patchwork-notify@kernel.org>
Date: Wed, 16 Jul 2025 22:20:11 +0000
References: 
 <20250715-cpaasch-pf-925-investigate-incorrect-gso_size-on-cx-7-nic-v2-1-e06c3475f3ac@openai.com>
In-Reply-To: 
 <20250715-cpaasch-pf-925-investigate-incorrect-gso_size-on-cx-7-nic-v2-1-e06c3475f3ac@openai.com>
To: Christoph Paasch <cpaasch@openai.com>
Cc: saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, gal@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Jul 2025 13:20:53 -0700 you wrote:
> From: Christoph Paasch <cpaasch@openai.com>
> 
> gso_size is expected by the networking stack to be the size of the
> payload (thus, not including ethernet/IP/TCP-headers). However, cqe_bcnt
> is the full sized frame (including the headers). Dividing cqe_bcnt by
> lro_num_seg will then give incorrect results.
> 
> [...]

Here is the summary with links:
  - [net,v2] net/mlx5: Correctly set gso_size when LRO is used
    https://git.kernel.org/netdev/net/c/531d0d32de3e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



