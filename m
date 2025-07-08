Return-Path: <linux-rdma+bounces-11966-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C1BAFCF79
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 17:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7123B9470
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 15:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121742E424B;
	Tue,  8 Jul 2025 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+uU7OHC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86AB2E3AE8;
	Tue,  8 Jul 2025 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989193; cv=none; b=ARE7dFUVrpBUfwk6O9iWbkH8ZptYaTx9/eU+Tcmg3tySc1430CpP5hedJnXdBMdhq6JjCJ6B0AYL3JROv9gnOVAw4SCnaTygiRnY9UkRMDJJ7mBg7nTqKn1AzUlpceu5nLBLImwqtoPDDOzi6khcuvwnZLyXLqsQAsw5D9nwHmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989193; c=relaxed/simple;
	bh=B6kQ/kvW1FlzsCsJbUEB01K4BH5xVbKRi1mRZvTIHI8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ty3k6x/ToB7NYb94iacyYbh0ErhV6bx2NGwK+nEaHKfnZKR64aDYN1nmiLoezO8pE+aM7sJZmfF0STkUwZj1kOh3QhDpdxWZNxQoyD5JUM7kUmaQjFs3vPlwtYGzL9ICK+JdZ5mPUfOnVX+IeQSSm0RpfKXfLwUAeM+omgS7qoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+uU7OHC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D28C4CEF0;
	Tue,  8 Jul 2025 15:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751989193;
	bh=B6kQ/kvW1FlzsCsJbUEB01K4BH5xVbKRi1mRZvTIHI8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o+uU7OHCze/cS8ZQ8WkAB9p1XbiudAafqzX/2WYvlOK0x0THQalc2CBvgC78w7KGE
	 aUSCJzSthAjBAKnXjrfEse+PupQDlFLyF4/vP0zQrSJECbtNtFS91utiSDWYg7Is28
	 jyCfpE7i/W3x/uTCgyXbEs95jbLZQMRTGJaLFvFcmVRn7FNbHS92OA0EaJOejzI4s8
	 WKVr0rcI97HvLvkln1f+2HdF9pIksnhl30BWeJX2LXsb1EG8AMIz3DX24Uh8raVfy8
	 ue3yp3BWS03KUDj7yWXzh6H8H4vLMcz3x+h5331fwP8J6A/yMjRcVjbqs7yghVEq1E
	 DUJViXgUgJ2rw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DE3380DBEE;
	Tue,  8 Jul 2025 15:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] net/mlx5: Fix spelling mistake "disabliing" ->
 "disabling"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175198921600.4109948.12043108298445131464.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 15:40:16 +0000
References: <20250703102219.1248399-1-colin.i.king@gmail.com>
In-Reply-To: <20250703102219.1248399-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, cratiu@nvidia.com, cjubran@nvidia.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Jul 2025 11:22:19 +0100 you wrote:
> There is a spelling mistake in a NL_SET_ERR_MSG_MOD message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [next] net/mlx5: Fix spelling mistake "disabliing" -> "disabling"
    https://git.kernel.org/netdev/net-next/c/0e86f3eb83c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



