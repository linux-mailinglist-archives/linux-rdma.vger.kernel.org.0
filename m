Return-Path: <linux-rdma+bounces-12167-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A26B04D11
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 02:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D56AE7A7808
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 00:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AEE1B4248;
	Tue, 15 Jul 2025 00:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXm5q5qc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB511A83F8;
	Tue, 15 Jul 2025 00:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752539999; cv=none; b=VC66c1Gk0w55N7GuBSH4pQ6KrFELY55ANY+vnDNDmChp6S8PwsfJp+YosHXxx4OpqaLq4bqYouJTa73pCS1kNtTtkJT8dkN4gqCeayYMItz5KqIX76f2tO7l5OogCcafg4UuJDGn1K2mPHmA3QxAFxzoEN+1adA2sSKo3KVa+c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752539999; c=relaxed/simple;
	bh=CrHiF8PKaUNTRhE8iGDTKs4Yqu86OLZWnacNnmMUNeE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NvtRGc8BJg1ugXUGi8T6jSs4IyVaBSkyv4v3xK6MJFVLtyqePY8M5vIcmOQ++yNa+NN54mhTHGbVJg64fglUntRC7aa1eukuC7zJZlvM/RHtuQOJw4viO3YiBdvmapw9J0Dnwqn0+A8Pug6ID8z/44Rg2gvboFwgSJBQfic8yDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXm5q5qc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64ECEC4CEED;
	Tue, 15 Jul 2025 00:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752539998;
	bh=CrHiF8PKaUNTRhE8iGDTKs4Yqu86OLZWnacNnmMUNeE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kXm5q5qcipOJ71OlegvwYZqW/X1kAHs/zc0aPlEBuLdWBW+EbWgmeAi1xc+1Fywca
	 OA7rFLz1sEG9G/G0YftPywBX3G2rF0sSunf6GSlrplgVsXvzaSYm0oqEYz3PnPfraN
	 spKDKTXHtdXcz1bZLSjkWSOijBurq6Lnx+DbyLU64nJJ6Ps5F282pzCZzcJuBbTL0E
	 PwhRfonufbSgWSZSIOPENXHwe9Di1/67K/z//A+c03J0/BSYs1YtvzwT0Atu+GiPK/
	 C7JTYvZ8aTF/MlHAAM/viNyzQdL9kC36i9gyZ0NVQiCEuRJKhvJ0vfySjGmRGxHFha
	 e9TjkhDwobLYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D90383B276;
	Tue, 15 Jul 2025 00:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [pull-request] mlx5-next updates 2025-07-14
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175254001900.4040142.4020209946156928576.git-patchwork-notify@kernel.org>
Date: Tue, 15 Jul 2025 00:40:19 +0000
References: <1752481357-34780-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1752481357-34780-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, leon@kernel.org, jgg@ziepe.ca,
 saeedm@nvidia.com, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, mbloch@nvidia.com

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Jul 2025 11:22:37 +0300 you wrote:
> Hi,
> 
> The following pull-request contains common mlx5 updates
> for your *net-next* tree.
> Please pull and let me know of any problem.
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [pull-request] mlx5-next updates 2025-07-14
    https://git.kernel.org/netdev/net-next/c/2f4053db0b13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



