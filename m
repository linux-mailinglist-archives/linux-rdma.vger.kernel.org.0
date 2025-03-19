Return-Path: <linux-rdma+bounces-8837-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3074BA69679
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 18:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B3BD7A99F4
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 17:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51994207E02;
	Wed, 19 Mar 2025 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTUB2Byd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ED1207A2A;
	Wed, 19 Mar 2025 17:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742405403; cv=none; b=cx4dSrUDxu4x5izvTKLrPSKwwgV+ehvXvVUpjZcqqN87rg1R2JNEIi03iOWRkwO42MqLEcnedEWHQOg5nOHyyw6hm0vYjzDGKXAYh67+nc+wdMjMJxqFOhnRCpCnmAkODbxI7eRWPFjx+wFchkcjrkRzdxakJoax7esEHvOSL7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742405403; c=relaxed/simple;
	bh=t+CillHKE7HGhniDsHyI1yEiCWnxfgZ07vdfTmwzvRg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aQYaE3Unu5cDEFbTCR7MpDHToXpMvtyTBJLg/XfL3FhuWFJmG0debKrVx4v6T2Eism2HfbxVecNKGwoBr2Y6s0l54bYYiksHw9cNsZJWwK/xAA0NrvKOtoXGNblPxp/FWTJhwwYK454BYV0XUY+O1zCgS4ZT2O5C6oaHnwANW3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTUB2Byd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC96C4CEE4;
	Wed, 19 Mar 2025 17:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742405402;
	bh=t+CillHKE7HGhniDsHyI1yEiCWnxfgZ07vdfTmwzvRg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YTUB2BydQnZLwmztqELVEZAQjhOkGS7optwHDyzpxsxZHHstP5YjkYfyTblp4LJHN
	 PPb5jksp+UUopAJVAlFYu08/scVdB9gvpKa5FZUesJ8e99QdlnicjP5nvwI90bbj0g
	 96MMaIZVMh+6xc3Zn0UOH14/nep8j1KQ9Bgx1Ozyn3H8cP3ZrNAckaXeXULEKNaxbG
	 g0XnZwdk/MwfuL2UKoEfr0UeqBndHocUL2i34auwXeLc1YMooLehICZsRw6TFg/xqC
	 vKOZvGVqAGIOQ1uV2jBCMTJu2ziH52V9Q4gksYda3Jb/YLUJmTF3DZVYMGXIakoJgr
	 HOfQVu7TYMuxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE176380CFFE;
	Wed, 19 Mar 2025 17:30:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net/mlx5: HW Steering cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174240543853.1125754.1009178782663226932.git-patchwork-notify@kernel.org>
Date: Wed, 19 Mar 2025 17:30:38 +0000
References: <1741780194-137519-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1741780194-137519-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, gal@nvidia.com, mbloch@nvidia.com,
 moshe@nvidia.com, saeedm@nvidia.com, leon@kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 12 Mar 2025 13:49:51 +0200 you wrote:
> This short series by Yevgeny contains several small HW Steering cleanups:
> 
> - Patch 1: removing unused FW commands
> - Patch 2: using list_move() instead of list_del/add
> - Patch 3: printing the unsupported combination of match fields
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net/mlx5: HWS, remove unused code for alias flow tables
    https://git.kernel.org/netdev/net-next/c/eae1389ab2f5
  - [net-next,2/3] net/mlx5: HWS, use list_move() instead of del/add
    https://git.kernel.org/netdev/net-next/c/1a403ad383ab
  - [net-next,3/3] net/mlx5: HWS, log the unsupported mask in definer
    https://git.kernel.org/netdev/net-next/c/8389f2de903c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



