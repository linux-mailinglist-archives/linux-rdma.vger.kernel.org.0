Return-Path: <linux-rdma+bounces-3308-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A38890E749
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 11:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C97282A7E
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2024 09:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C44F81219;
	Wed, 19 Jun 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csndO+5A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C244A7BB13;
	Wed, 19 Jun 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718790629; cv=none; b=D/Xocon5E+8m98L2hwq53l02r8jbLACTrb8wJ/9bxg1hII7S+d8npH0zJj+JgKzRpIlVCEjf6nYB2JhoeL4pSkhLGiLa7rFOdstRuvVq8oh3xOUs1uT6NSehomUNkGxIC+ymPzmlr/p4NkC2mk/i2lbFm9BUOPNNapInHC6aEZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718790629; c=relaxed/simple;
	bh=GlJMmIAEfpjewOs6ODwu8YfiHNryTzd+90PPz9YRuBo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y3Fe+2TgkWCtI5izk+VlIRt8A1uLP6DXlz4S+EdOOHKPHH6sA81GEYaBBxp38itgnNlcktg6NgQ6EpPYe9ya4wmeTg5VE/QQITHSyWQXuKBk502LWFjTogZXD/3zpGYXGQOz8S6UyNmXAVa1iag0hu2JyxBFK2khTdjuqUUSu1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csndO+5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54EC3C4AF51;
	Wed, 19 Jun 2024 09:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718790629;
	bh=GlJMmIAEfpjewOs6ODwu8YfiHNryTzd+90PPz9YRuBo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=csndO+5A9Zb+DzdccpWSsMtUf9g2I6Tl0tneOGbluTlWZ2xwomIbSrPPTN4tg806z
	 EJ8PggU9HFGszcssu8kdCMK58IPde2bCKMdAYMFnKhVkTl5f7xa+jZkCL2NI7cLjLC
	 f0qA6btGKpt7gLZ7LekXAi7CllMZ0ATB+tMA8FijWxaoUQSeCs5EqqqLEYUzs3KZuD
	 t98NqCBhLuaqpvJqp5yO+o73SHcMD4dGyoYXZkFrSpB8WK3olvlKwDq7Sn/CUQDhXM
	 a/RGixzuZ/FhynN3AJSBPGE4r86iEfog9VEdQaSui99ZuzjMFDlGwdrCyBZVGah8v5
	 ndNyIDglEj8TQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C011C4361B;
	Wed, 19 Jun 2024 09:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] rds:Simplify the allocation of slab caches
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171879062930.26288.9720056948729325015.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jun 2024 09:50:29 +0000
References: <20240617075435.110024-1-lihongfu@kylinos.cn>
In-Reply-To: <20240617075435.110024-1-lihongfu@kylinos.cn>
To: Hongfu Li <lihongfu@kylinos.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, allison.henderson@oracle.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 17 Jun 2024 15:54:35 +0800 you wrote:
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
> 
> Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
> ---
>  net/rds/tcp.c      | 4 +---
>  net/rds/tcp_recv.c | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)

Here is the summary with links:
  - rds:Simplify the allocation of slab caches
    https://git.kernel.org/netdev/net-next/c/9f1f70dd8500

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



