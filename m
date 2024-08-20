Return-Path: <linux-rdma+bounces-4426-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D892957AA7
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2024 03:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C78711F2394C
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2024 01:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49432101C4;
	Tue, 20 Aug 2024 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Flxh8eoY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002F3E56A;
	Tue, 20 Aug 2024 01:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724115635; cv=none; b=Vy4mgLdiBPeRpUX3ZjXWD+phrCONukPHfJnyt/uhYvydecOe+kc4u+Z47ySP2z7G31T+1dPuGWqCw1NPGH+N/nKNl0i9ZlWBz3c0Cen1FxNyxyihrEc4agoFgshUyRddGXD+2GQnCg/auXbvHxuCGmQdu0UuowTqH6rUvrZqvno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724115635; c=relaxed/simple;
	bh=nwSc6nqgHfyIYCninkawFA7YY4oRCj6DoHPifoTDmEg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qfy90qRQE+JrkPs9gtq/OBefGw7r5+cGOQfj1ibkAJsm8UOvseKsW8LcqKvXTPrZWr1KaqQbrl9cBmMmEFIbbFi47LaAQoxCbum2BALH1b2D7/q2UT3hJDfq6jalQTV5x/fquBgd8sv7r9EjHPgs+D12U+CYtx65ff+4bqO0s1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Flxh8eoY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCF2C32782;
	Tue, 20 Aug 2024 01:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724115634;
	bh=nwSc6nqgHfyIYCninkawFA7YY4oRCj6DoHPifoTDmEg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Flxh8eoYCdfYgT/YLVPG9mtrAl29UMaM3g8Mf9XyNyFT95OeGM3/OMhYAndkmsmKz
	 peDNGRghpr8X+t9zsPp6j+Ggzn4OdQI0Hgef/7uftlLA06gLws586SRD/KJGwspEQn
	 Q344DCtrHYEZuSyRS2EL3OfkiSXzlqSFx2JTDj9UvKrQS2Vc35p1I7DBk6JdMuO7k8
	 RzU8kz+GzSWHBG5TtgoTNDooUZipfayA2FBJ3CeLJdCpeLQm21cE5heQktZnCIk4AD
	 VKuzgLgOlEdApV+rO0tQIUZZp1Ud0a9K0K23GJFmNjKyF5cKsKp48oEn707+QM7ekx
	 ig7V9MM6ZgYVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 343A73823271;
	Tue, 20 Aug 2024 01:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/mlx5: E-Switch, Remove unused declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172411563374.698489.9171722655816032992.git-patchwork-notify@kernel.org>
Date: Tue, 20 Aug 2024 01:00:33 +0000
References: <20240816101550.881844-1-yuehaibing@huawei.com>
In-Reply-To: <20240816101550.881844-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 Aug 2024 18:15:50 +0800 you wrote:
> These are never implenmented since commit b691b1116e82 ("net/mlx5: Implement
> devlink port function cmds to control ipsec_packet").
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/eswitch.h | 3 ---
>  1 file changed, 3 deletions(-)

Here is the summary with links:
  - [net-next] net/mlx5: E-Switch, Remove unused declarations
    https://git.kernel.org/netdev/net-next/c/c5e2a1b06760

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



