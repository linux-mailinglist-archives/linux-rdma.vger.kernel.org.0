Return-Path: <linux-rdma+bounces-8576-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 522D8A5BE16
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 11:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91D5B16C51A
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 10:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA1723F37A;
	Tue, 11 Mar 2025 10:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1Yz4+TB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43FA23F295;
	Tue, 11 Mar 2025 10:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741689689; cv=none; b=ZBZGOPgC79HzQD4NeQnSYHpyaScsU4joFjyRdeADIHQVGgMxbcznJA6J7QspbDg2zav5lJvebrvBxdkY1tG4kDvz2xQBp2BD2biY9/cS6fdBWu/OuPgrr6zpLvWGtRvQRIhrJtSVFDXGere7C8BW3pW7pJk7UURgZjmVLlNgtmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741689689; c=relaxed/simple;
	bh=fpddIlI64VwTiXXAVu6C6c7JwBDTHZAHucfgSzF2Ljw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L0jcxTVEBl9xc5mDBgciUcQHe3N3GpG5dl4Vqz5fVayZIJai7yTpYMokuHOZ+/u1QY8AKvyvIt+05FCnypMMDHfOC/bs7e4kRJnFKx/cmhcW5xlzFeOhKDCNQTgDD0YPJ/WKj+eQFdW5oOps+L9laG9Z2LHgx6NMX1Pu6UquNiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1Yz4+TB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C6AC4CEE9;
	Tue, 11 Mar 2025 10:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741689689;
	bh=fpddIlI64VwTiXXAVu6C6c7JwBDTHZAHucfgSzF2Ljw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G1Yz4+TBF1BKh139U3jdqAiRLh81pSif82+O+O0fs+RyWLV0Ant1sjVvl3Gkd55u1
	 /51raWGKV0OaN5+JBlu6Yo3nH4tP+XvgJlve3JPDPuyYYdVMFRMwMwNp78O5jx4kmL
	 ATJOmgyW7W8TMIFEqz6RVuqWdE4j5liDiCEuDeenos41vsL6BQu0MCnmaGDO4DoHjS
	 gbtXyp+56G4ZtOxVnqVWqczArzWdWuGr39Q29ds7jkq042GfogUPp8vM64p52fnAKZ
	 ew0Z2bjEcd76XbM0YVprsIHKGZIj7qSAYAPhydOgddejwvoVGhCkXsCKyMx1qNgze/
	 337IM0WL1A0SA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D31380AC1D;
	Tue, 11 Mar 2025 10:42:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [pull-request] mlx5-next updates 2025-03-10
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174168972325.3890771.16087738431627229920.git-patchwork-notify@kernel.org>
Date: Tue, 11 Mar 2025 10:42:03 +0000
References: <1741608293-41436-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1741608293-41436-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, leon@kernel.org, saeedm@nvidia.com,
 gal@nvidia.com, mbloch@nvidia.com, moshe@nvidia.com,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, leonro@nvidia.com, ychemla@nvidia.com

Hello:

This pull request was applied to bpf/bpf-next.git (net)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Mar 2025 14:04:53 +0200 you wrote:
> Hi,
> 
> The following pull-request contains common mlx5 updates for your *net-next* tree.
> Please pull and let me know of any problem.
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [pull-request] mlx5-next updates 2025-03-10
    https://git.kernel.org/bpf/bpf-next/c/ef4a47a8abb3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



