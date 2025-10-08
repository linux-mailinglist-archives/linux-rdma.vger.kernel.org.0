Return-Path: <linux-rdma+bounces-13795-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61297BC31ED
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Oct 2025 03:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A27554E4BF1
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Oct 2025 01:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B069C299A85;
	Wed,  8 Oct 2025 01:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6GQFWEc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5D8298991;
	Wed,  8 Oct 2025 01:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759888219; cv=none; b=lTxs++pYlfwJJBaPBFndzX49Ea/z4Ee/uXoMGsYGO0hr5+Py1urIjPZ/l2+Ieys3CQYe261lFrZ+E00C6/5Q28lgnQuyVbxpznCCwdrIKVSUCrxCnyO967nptB1AVsXq7XL0V2uZERdMEVzrZu8LlU3quxgChufodBPd6blxOA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759888219; c=relaxed/simple;
	bh=1IqwI5RHVzUA0XtfTZBm9YqmfBtxd3vrlgcnanUuDzU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W+1UMn43ArJCskkzNuIj0p+e+zieIjV2lorndCQqDTUMWHNLD68pDvnpIrkMKDzc3pPy87Fqkg2Mvfnl4OhcirgnhZkEim5y/wLO1UmLa3nOB9tbpwPHczzuEsxeOMS8EVm/y6l00p02GNSNUhXQ8yP/tSqVTCWemmGnvhURfy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6GQFWEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3449C4CEF1;
	Wed,  8 Oct 2025 01:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759888219;
	bh=1IqwI5RHVzUA0XtfTZBm9YqmfBtxd3vrlgcnanUuDzU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b6GQFWEcYD65sYtuTSt9we005rLoEQZ8uYAVQ87hRFs4uSAK1EPha1zwzXV4j3jNV
	 VirryGZNwAXE+r0EOtFkgEeEt4JqWC21v8eJpd5p1Dlhinyv9zm58tY0qPJ6Bf4v5t
	 K8moKH99EREmOJe4cU6QB33xUjv298W15kPyc93DJDhHJKUNcPcb5+iJJKnDrb844f
	 AHB0HL6N/NlahIPfNz8gnwdXohgNNbsd4hH83Vt4jPhJwsI8gYJRha7K8MD5tbYtw4
	 7Br8BXxaVIrYnSCLnk9ugJt/P6WMnXezs+beWqxEzu0eXHYB8Ubt+Rq1PVnvBII+4o
	 ZlJ+XhSYj9nqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 061D039FEB7E;
	Wed,  8 Oct 2025 01:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/mlx5: fix pre-2.40 binutils assembler error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175988820785.2858427.9317548513066573467.git-patchwork-notify@kernel.org>
Date: Wed, 08 Oct 2025 01:50:07 +0000
References: <20251006115640.497169-1-arnd@kernel.org>
In-Reply-To: <20251006115640.497169-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, phaddad@nvidia.com, moshe@nvidia.com,
 michaelgur@nvidia.com, arnd@arndb.de, naresh.kamboju@linaro.org,
 nathan@kernel.org, horms@kernel.org, cratiu@nvidia.com, yishaih@nvidia.com,
 maorg@nvidia.com, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  6 Oct 2025 13:56:34 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Old binutils versions require a slightly stricter syntax for the .arch_extension
> directive and fail with the extra semicolon:
> 
> /tmp/cclfMnj9.s:656: Error: unknown architectural extension `simd;'
> 
> [...]

Here is the summary with links:
  - net/mlx5: fix pre-2.40 binutils assembler error
    https://git.kernel.org/netdev/net/c/e475fa420e6c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



