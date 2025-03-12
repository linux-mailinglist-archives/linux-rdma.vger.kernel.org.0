Return-Path: <linux-rdma+bounces-8627-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8E1A5E580
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 21:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91CB178CC8
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 20:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F141EE7A8;
	Wed, 12 Mar 2025 20:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQUuts4c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406311EE00D;
	Wed, 12 Mar 2025 20:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741812002; cv=none; b=P4umwhnrcBkxlsVbDm/41eO5PpJ4fBYBDE/xAEdrUbw+Wyd4pWcqhBAtISMcnXKrZBw+kNPG+3tzmeMwKms9vD1aP85XEI01lNiaXyiVQLeDMrXEC8CgUQXOFthKPI9RzWPyMQAMpzWQQsmhkVA795QLm4hWZbeUSN7ucVRe12o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741812002; c=relaxed/simple;
	bh=UY+qjs9BhcwwDvow0Ain3NjALs1ERFIyXDfybEyb1TE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YlTklcfvSrfHC53CymqdMFd6rHKUhLVHM6XViDALLjKV6ssTTymNKUbLtvxzfAXxjJ1WulN4XZmfEV2rtLm/7nBTdtv+ukUuAgB5zjs65gMvCD6azw+8igD3q+ZL/9b2+TOcR9aycRpPWmlxYRFLwofaDeWRogT3+JtzPc8CZzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQUuts4c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A5BC4CEDD;
	Wed, 12 Mar 2025 20:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741812002;
	bh=UY+qjs9BhcwwDvow0Ain3NjALs1ERFIyXDfybEyb1TE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jQUuts4c5wPOKmECXgc+AlXtK6xntdNehzrWxtyZW3SQ9cmi1cas1kYxurghVwtrJ
	 F9rt0paNVmbMnvpKa7q6zOreNlAxw2cIygjFGtLp0Ad9lYSH7Sf/Taeo910NRgr9KF
	 i1IFG1VdL/tt8WsxMftjVEl4nklLg4/XTDxwP19a+/+RIIdM4tCaSYbOx55kpJL9Xt
	 e4Fh6z8s3wiBCpmd8DFjx91oML1jNe/oSpyU+3YlosqlDtqoHBrmJZloB5T6gljCfD
	 SoTYWy310Xoh4lWHAaKE1OMpOzBZY20stNjU05d9IVRnnHD7UV01q13G4Z28a27lp+
	 qbfEKBsq/Q4AQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE6FC380DBDF;
	Wed, 12 Mar 2025 20:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/mlx5: Avoid unnecessary use of comma operator
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174181203625.925252.18369584221189427923.git-patchwork-notify@kernel.org>
Date: Wed, 12 Mar 2025 20:40:36 +0000
References: <20250307-mlx5-comma-v1-1-934deb6927bb@kernel.org>
In-Reply-To: <20250307-mlx5-comma-v1-1-934deb6927bb@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, llvm@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 07 Mar 2025 12:39:33 +0000 you wrote:
> Although it does not seem to have any untoward side-effects,
> the use of ';' to separate to assignments seems more appropriate than ','.
> 
> Flagged by clang-19 -Wcomma
> 
> No functional change intended.
> Compile tested only.
> 
> [...]

Here is the summary with links:
  - [net-next] net/mlx5: Avoid unnecessary use of comma operator
    https://git.kernel.org/netdev/net-next/c/17fef2042338

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



