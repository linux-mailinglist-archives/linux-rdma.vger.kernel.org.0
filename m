Return-Path: <linux-rdma+bounces-816-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 332A78432A8
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 02:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29012877CD
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 01:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07CFA29;
	Wed, 31 Jan 2024 01:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kg/tKFk3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AF84C65;
	Wed, 31 Jan 2024 01:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706664026; cv=none; b=cX8JQjVIgnAgsBboesIyACAODpT2r6vAmDbNVu9Rt2py3X4ktT8Czz3nZgYi4PKz4QHKmLLejO5JbdTQHNYmB0B4YA9aOOqsSUmBriZYBTrIYtTz43eDNPElsGJXOuIbVRxnRpfnsCQiXL31HlP4jIcf3J4y14+NQ/xTqwq55mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706664026; c=relaxed/simple;
	bh=uDA455Pv69DDJHi8Ti0vcIAvDtygawzLM08+OuqQ/cw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ceVOHUWBzZU2RHwvPm3pFCed0ho8r3lWnsv7eWRhGDMvYnCuSymhENrXtfFBePshexUbKBCX//Q82E/KYu28d+T9PIPyB54NsN6wCe7UwRgQ3wo/gfK9rYsSlUBzLzyn3uUqkelZ0JK+MIn3c85hquhteN3P8GbIEuj85AmP0RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kg/tKFk3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFE88C43390;
	Wed, 31 Jan 2024 01:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706664025;
	bh=uDA455Pv69DDJHi8Ti0vcIAvDtygawzLM08+OuqQ/cw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Kg/tKFk32q01ka/Zw9x8SpNQx9EEXFf956jBIJmXfLV2onqGxMPA0JhwzPVPDucFT
	 noBO9hysv4tDOo7L+kc7Lx8ZUugiGyHNub9FutJMLLsz9KWXd3ZJhH41mi8IyIk23/
	 YtTl0P9cXiNQA6ertvC5bzOYQG5H7FY7qaqeB7Ro6Lgnrf9UgbaNLLmG87iHp+LlLk
	 Ay0oJBDQZyeFaA7C81FMB8im+pWU9Q8Kt94qCBWQZA+9RWD0F36h2xyEc3oyl2gkq3
	 tOHM1IWAo2KvqlYuFWRc3I+8Op7YKhQm1zZKuWlMrbswM3ef77hQQg9czJ59QUxIXb
	 YJ9qWHk7uL8fg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7025C4166F;
	Wed, 31 Jan 2024 01:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: rds: Simplify the allocation of slab caches in
 rds_conn_init
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170666402574.11970.2150907643973879045.git-patchwork-notify@kernel.org>
Date: Wed, 31 Jan 2024 01:20:25 +0000
References: <20240124075801.471330-1-chentao@kylinos.cn>
In-Reply-To: <20240124075801.471330-1-chentao@kylinos.cn>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: santosh.shilimkar@oracle.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Jan 2024 15:58:01 +0800 you wrote:
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  net/rds/connection.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Here is the summary with links:
  - net: rds: Simplify the allocation of slab caches in rds_conn_init
    https://git.kernel.org/netdev/net-next/c/047a7d261be6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



