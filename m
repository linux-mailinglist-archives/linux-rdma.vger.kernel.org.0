Return-Path: <linux-rdma+bounces-12401-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C343B0E84E
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 03:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C0C1C25CD5
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 01:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66F319CC11;
	Wed, 23 Jul 2025 01:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHPkuMq+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7041FB3;
	Wed, 23 Jul 2025 01:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753235395; cv=none; b=FDPhNVB/13pAOq7FL1qHCxhBNFN4gksYCxEJfsIUB20V8cAfvdzGPDeiKmYYWFiLb4S/OU18e52/B+TGKMX/u1orH/VTfHe5A0fgko3iGWdS1OcIv6vKZPuzn3gp5K1eCaqTf/sedQkv2rkXZ4d21rU9aHTT1xJrEsW9tNNEq20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753235395; c=relaxed/simple;
	bh=TWWP5UC0hl2kMWCVnIXPI8WlY1NR78JudHF5e6wlwdM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MXlK/mCxHwZ53G6e7SFBMVE196cOY5dApK/GiJCELifig6F0qiPetEGd6ZmcPn7nrHZu/KSIM9mI4we2OSBJ0BIOqB4o6oxoJTbOAjgAgk5a00nKtNnXuY06PvYNow28cCl6tkx7kbk4OtIndxACZluZBgrWcUGyWxAfrttPcj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHPkuMq+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222D9C4CEEB;
	Wed, 23 Jul 2025 01:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753235395;
	bh=TWWP5UC0hl2kMWCVnIXPI8WlY1NR78JudHF5e6wlwdM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cHPkuMq+uDnLJgjjdEi10acprytyO7c2jBESQjdNfA3uEbAoymSOeFYDwtxlbBpXm
	 K8JvB1GDJlYlXIzz16wE2HwG3rg4+Z9o/aQIPOPVtFLUZu6rh+HD8rr7pMrDMG78Ci
	 l0FptGsMmqrhMhQRdxxVBtnYZ308pugQ6N3yVIpzpgWBsnDHg9fpce4FG1oA0YUSTH
	 1N6F6IFOuMtvUPTwJmjz40f8g8Z7JECRIpIH46pv++PjmHp6wTePCeVg0VexuIOsHh
	 aXUXDxD5gvQ/eei/ysWYTzTdr/BzhIwnO0YuL0ogqsBHljkYxLfqxX+G1AC2cKk+zL
	 XOr9azYckNvdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCA9383BF5D;
	Wed, 23 Jul 2025 01:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [pull-request] mlx5-next updates 2025-07-22
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175323541324.1021632.17931149096787900898.git-patchwork-notify@kernel.org>
Date: Wed, 23 Jul 2025 01:50:13 +0000
References: <1753175048-330044-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1753175048-330044-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Jul 2025 12:04:08 +0300 you wrote:
> Hi,
> 
> The following pull-request contains common mlx5 updates
> for your *net-next* tree.
> Please pull and let me know of any problem.
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [pull-request] mlx5-next updates 2025-07-22
    https://git.kernel.org/netdev/net-next/c/56613001dfc9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



