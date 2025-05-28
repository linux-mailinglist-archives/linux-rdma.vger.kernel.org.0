Return-Path: <linux-rdma+bounces-10776-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF26CAC5E88
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 02:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2F973B01F8
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 00:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C8F1F03D5;
	Wed, 28 May 2025 00:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ohzwb4ss"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407741EDA1A;
	Wed, 28 May 2025 00:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748393403; cv=none; b=ADyzDNURhOHl9rLAvAizxIFzG02c5l5LrV8dXXl3kuUGcuTKzFb1C9oLPtB6Nwra5OQ7ziTxFnWCOTIMNDnNEnCEkK2sEQfPM/SRbBQJ0/Q6Ap8ccUTfcCoxBXCZP/zQZEx+hmhceK5JQi8R0c5ErbfDBRtm2MDpZIUOiKsWyac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748393403; c=relaxed/simple;
	bh=BMCmWb2ynIXZqRnDMx69qdloJH8+yrmhOU04LrvIXjY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u7mjZdzSoUHCTTqMcvhtyEYe7ilMk1XzhFGdbUz2aMpZ3VS6Y6onbRzFKS1qovByt5pugVjozGdbDQgDZLd5yN0cg9VVoHNFuwJtdGl2QbNKgTA9jmctlpNGRyDckgu/dKNojnq1Dh16OK6mGK5RyGOxRxY+L5xzDsiPzMsT/p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ohzwb4ss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A901C4CEEF;
	Wed, 28 May 2025 00:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748393403;
	bh=BMCmWb2ynIXZqRnDMx69qdloJH8+yrmhOU04LrvIXjY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ohzwb4ssaJXThawsCmHOB7ANabKE32WukfoMPN7a/JadOevWTOic5DqTO1zvl/bm9
	 JJv362eA3diAtkwpm2hJTuA6xXHP30tQqvksOSdbwJFz6MuI9dv2MAr6DzasEc2Rwk
	 P/GxOZKVpSyzwncZzBkfFEGBBpTWux8cPbsG65YItUMtyY1j6sPNzkiQsvtG/N2KWj
	 T1+Sq/quFdek4HoVuXzAMqdIbbwa9axiF3qurn9lZP35mg/q8I0afoj7K6032imGdN
	 vbQ7ytNllhZ/8AOjzagaDbpPE+cB2TKLstzXX4906qqh92qBmcVofERy4nSySVXNcy
	 mVfVtTmJuZs1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 714A3380AAE2;
	Wed, 28 May 2025 00:50:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] net/mlx5: Add error handling in
 mlx5_query_nic_vport_node_guid()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174839343724.1843884.1696625892386200258.git-patchwork-notify@kernel.org>
Date: Wed, 28 May 2025 00:50:37 +0000
References: <20250524163425.1695-1-vulab@iscas.ac.cn>
In-Reply-To: <20250524163425.1695-1-vulab@iscas.ac.cn>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 25 May 2025 00:34:25 +0800 you wrote:
> The function mlx5_query_nic_vport_node_guid() calls the function
> mlx5_query_nic_vport_context() but does not check its return value.
> A proper implementation can be found in mlx5_nic_vport_query_local_lb().
> 
> Add error handling for mlx5_query_nic_vport_context(). If it fails, free
> the out buffer via kvfree() and return error code.
> 
> [...]

Here is the summary with links:
  - [net,v5] net/mlx5: Add error handling in mlx5_query_nic_vport_node_guid()
    https://git.kernel.org/netdev/net/c/c6bb8a21cdad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



