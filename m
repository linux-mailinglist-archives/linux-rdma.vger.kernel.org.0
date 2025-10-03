Return-Path: <linux-rdma+bounces-13771-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DA533BB7D20
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Oct 2025 20:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C1F4D34719A
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Oct 2025 18:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AD32C08D5;
	Fri,  3 Oct 2025 18:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrGBwjGL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F912DCF71;
	Fri,  3 Oct 2025 18:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759514421; cv=none; b=osF6IXCrSEGGr7nlq7TQRfaVbptrnzaErM9EeAUAuIyb2bZLOCYfnYxXAxQiDEaXK3akmFAE0Iam437deW/d4UQkVmZGO1Sy9+8QjsdtlQmHVLm73hlE+aAL6Xy7h0t4lzDgQUfBZI6TEOdqGnY9wcZaQY0hpcZXqC1qEhIgwyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759514421; c=relaxed/simple;
	bh=yfWkw1eJRdgMFAVUHp1HPAsHB8VP3RjWjRR3B4uC/OY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d5lqUqJJAMHEiDzeGyJRGOfRdOdf/lNS+zmQPSAYGdKKT7FmdZaBha+TXBPsEIhEnkodHhUZZWzw9WKN9F6XusV3E7N+4Ednv79734s8UgdphWYCOuKIDgENKHgJDbuY1xjOce9ZQJr6g19Es3eFJc8MNSyMVq6guDbcw+6l4FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrGBwjGL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1908C4CEFB;
	Fri,  3 Oct 2025 18:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759514420;
	bh=yfWkw1eJRdgMFAVUHp1HPAsHB8VP3RjWjRR3B4uC/OY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MrGBwjGLfR4uMhLcJU9FA7rJWOo9z+BxdF32WHyKTnoLKpGJqPnqQCovQJHJqiL8l
	 rODHXEI/2yZ7f8KNY9PL3c4QJWmOoXZIDxZPRnOxUVyqF7sdTKN4F0nZFNIH9NusAk
	 RZ1qNUJZLT3Xwmlg5T/0VOulGeVvN8EiP3Q5r5SCGGIBB7P7C3amviTLyoDZWxR9Wx
	 i2YKAgqFuuiAK5f7DS2kH6noWdN9djKA2eeMWVVme1NFRn17xT4ox1aN57HaGxnwc2
	 B+CE/80W4LEXoteTY62N1Y0MS4g//4fcJ43DFbmTLn3mQE48rD4n3FkZKJgMVVtsJ6
	 YIaUpilhEHBTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E1F39D0C1A;
	Fri,  3 Oct 2025 18:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/mlx4: prevent potential use after free in
 mlx4_en_do_uc_filter()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175951441174.20895.398410972294228091.git-patchwork-notify@kernel.org>
Date: Fri, 03 Oct 2025 18:00:11 +0000
References: <aNvMHX4g8RksFFvV@stanley.mountain>
In-Reply-To: <aNvMHX4g8RksFFvV@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: yanb@mellanox.com, tariqt@nvidia.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 amirv@mellanox.com, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Sep 2025 15:25:01 +0300 you wrote:
> Print "entry->mac" before freeing "entry".  The "entry" pointer is
> freed with kfree_rcu() so it's unlikely that we would trigger this
> in real life, but it's safer to re-order it.
> 
> Fixes: cc5387f7346a ("net/mlx4_en: Add unicast MAC filtering")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net] net/mlx4: prevent potential use after free in mlx4_en_do_uc_filter()
    https://git.kernel.org/netdev/net/c/4f0d91ba7281

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



