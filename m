Return-Path: <linux-rdma+bounces-7074-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB615A15B5A
	for <lists+linux-rdma@lfdr.de>; Sat, 18 Jan 2025 05:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9966E168F9F
	for <lists+linux-rdma@lfdr.de>; Sat, 18 Jan 2025 04:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D5827466;
	Sat, 18 Jan 2025 04:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEloBdND"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354E013DDAA;
	Sat, 18 Jan 2025 04:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737172812; cv=none; b=tNBPycxRvame2vDcftaGDXbhTGCS7//qEi5SeNe5vloz/N4I/WfOiZmMw/oXzR03Szi2w+gpaGjyGcXuiXfzRLj8xlQ2SB04eYGUwom3F2kkkyK+b/c9Px9TsrEjmfpRZl67ivgYVmXyQZ7yKsMV51INiVtY2bdBvJbtGDNGKpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737172812; c=relaxed/simple;
	bh=jFv8EUCLu6ozxPuVJTFgfwgeNm5H76i/O7yykL5YHfY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H77OAQ0Q5tqK2arbU6Hptc4muAjkJAC8wraStCqsyl/b5fRF6DvgulCC3cHO9QgzssSjz9NLvw69edn5Tf0+b5FvGLZ+z/FZuCAXffCHG/cg4//liQHBchkmy0xGGwV0BVTrvkCb5biBomsMsNcBO5oLSBOde8xmbwqA+NyQ38Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEloBdND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3A0C4CED1;
	Sat, 18 Jan 2025 04:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737172811;
	bh=jFv8EUCLu6ozxPuVJTFgfwgeNm5H76i/O7yykL5YHfY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UEloBdNDm3PtybiuUjrI0tf6/ciu6iE6k7oHpvCis7qsJ00zxguqV5qLgGHFzJOut
	 Sm81r3ryuSopv4eIAbtczpqN3aFGrE53u3sOHXlVA4nOuiFxp7Xewsu/e0uh60r0oz
	 w5GRHOlAxTRlKlK8QgawxCmBm3mE/Q8qJlBJKRUuKhHzss7s7mErIHW84X4U16c0c9
	 02mV7faaIdetUhPuSJv/ntoKZId+giNGCymPTVjKjWGN+eltogj7cqqYUagjDzdoIx
	 9xT03wCNbYFbtnF2aDm7RdIYgyO8zYpvx7qPqsJmx+W2x8FSHIa46DoZxsHOkKgWi7
	 yQAHV5moij/xg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34166380AA62;
	Sat, 18 Jan 2025 04:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] net/mlx5: fix unintentional sign extension on shift of
 dest_attr->vport.vhca_id
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173717283499.2332438.5321768112783382973.git-patchwork-notify@kernel.org>
Date: Sat, 18 Jan 2025 04:00:34 +0000
References: <20250116181700.96437-1-colin.i.king@gmail.com>
In-Reply-To: <20250116181700.96437-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, moshe@nvidia.com, kliteyn@nvidia.com,
 mbloch@nvidia.com, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Jan 2025 18:17:00 +0000 you wrote:
> Shifting dest_attr->vport.vhca_id << 16 results in a promotion from an
> unsigned 16 bit integer to a 32 bit signed integer, this is then sign
> extended to a 64 bit unsigned long on 64 bitarchitectures. If vhca_id is
> greater than 0x7fff then this leads to a sign extended result where all
> the upper 32 bits of idx are set to 1. Fix this by casting vhca_id
> to the same type as idx before performing the shift.
> 
> [...]

Here is the summary with links:
  - [next] net/mlx5: fix unintentional sign extension on shift of dest_attr->vport.vhca_id
    https://git.kernel.org/netdev/net-next/c/41c5d104f338

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



