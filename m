Return-Path: <linux-rdma+bounces-7775-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2201A36BCC
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Feb 2025 04:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB2C171FD6
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Feb 2025 03:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322E315696E;
	Sat, 15 Feb 2025 03:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pluCi0kt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E0918D64B;
	Sat, 15 Feb 2025 03:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739591404; cv=none; b=D5IVKaGuY6JnUQwViLWwQpmfawZUvP82cDzywq2PPgtmCYaHUEDxR1tUqGRrQEB3uCnYQNeOVjPOZ1DQhLTqtk/Av2gpvId92J+g3DNVmbySOQaMbw9IK+wwaWzSJj8kbXuXzY0xbRWqQXx0dTWNv2tR+Ecy2xc/HHbl9yCG3NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739591404; c=relaxed/simple;
	bh=FpyI8Wt6Q2ENMERd1QNvyAvr8Jt3MeuGi90LPoPrC60=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=crv4CHaSEyNkDZV4kBkLnExfQKSpH7rmboljqRriwbbFAIO0OImgMW7GTsRiXAR/7t6GXCKhk2oEVikH3GFjdTKiHXqvH54IFuGJD7xc7J+NiTy7LhynyH+RFbX09fLxiG2WHJmdY6G9K3E2PQFCfnSxZ+NBgCSiFmlzyb0a+WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pluCi0kt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446E7C4CEE5;
	Sat, 15 Feb 2025 03:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739591403;
	bh=FpyI8Wt6Q2ENMERd1QNvyAvr8Jt3MeuGi90LPoPrC60=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pluCi0ktI/2o7cb1jtn9UhuZoAEn3cq1dtnaVR2cRoa11r6RDqa2+LfJEgATqy2wL
	 D9VfeNeIp2HyJe/BZHVMtALhiYk1Qdcy18lOSUP7KNvt9ih1GHo70js3uIGF8SCPV6
	 G9FRmcK9m3vkcGBRfru0wnCfq8sx2ji+19EPuV0qZ1yPOyxZWctcwGvt+M8LU7uCKi
	 LHVWg6bpT55OTwEUXESR7uzEHA/A7a+z+2bCdqakxlipE2LAxpaCiNNCfEBJHJtsJ0
	 w5Shs4v/zpEh3C8FBBj2CzJsQiuwm2V0ZV7+cVyNx8pguxC9nnyg2U6A6zfQQh4G6R
	 /aJpQFosq4kuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB505380CEE9;
	Sat, 15 Feb 2025 03:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/mlx4_core: Avoid impossible mlx4_db_alloc() order value
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173959143252.2183234.13500068544782550467.git-patchwork-notify@kernel.org>
Date: Sat, 15 Feb 2025 03:50:32 +0000
References: <20250210174504.work.075-kees@kernel.org>
In-Reply-To: <20250210174504.work.075-kees@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: tariqt@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, yishaih@nvidia.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Feb 2025 09:45:05 -0800 you wrote:
> GCC can see that the value range for "order" is capped, but this leads
> it to consider that it might be negative, leading to a false positive
> warning (with GCC 15 with -Warray-bounds -fdiagnostics-details):
> 
> ../drivers/net/ethernet/mellanox/mlx4/alloc.c:691:47: error: array subscript -1 is below array bounds of 'long unsigned int *[2]' [-Werror=array-bounds=]
>   691 |                 i = find_first_bit(pgdir->bits[o], MLX4_DB_PER_PAGE >> o);
>       |                                    ~~~~~~~~~~~^~~
>   'mlx4_alloc_db_from_pgdir': events 1-2
>   691 |                 i = find_first_bit(pgdir->bits[o], MLX4_DB_PER_PAGE >> o);                        |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                     |                         |                                                   |                     |                         (2) out of array bounds here
>       |                     (1) when the condition is evaluated to true                             In file included from ../drivers/net/ethernet/mellanox/mlx4/mlx4.h:53,
>                  from ../drivers/net/ethernet/mellanox/mlx4/alloc.c:42:
> ../include/linux/mlx4/device.h:664:33: note: while referencing 'bits'
>   664 |         unsigned long          *bits[2];
>       |                                 ^~~~
> 
> [...]

Here is the summary with links:
  - net/mlx4_core: Avoid impossible mlx4_db_alloc() order value
    https://git.kernel.org/netdev/net-next/c/4a6f18f28627

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



