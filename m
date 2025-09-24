Return-Path: <linux-rdma+bounces-13608-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35477B97DAF
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 02:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D14EB7ABC30
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 00:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323CB13DDAE;
	Wed, 24 Sep 2025 00:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsHl+LM8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C046D78F36;
	Wed, 24 Sep 2025 00:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758673218; cv=none; b=iGhGPgb2PxVj+E5CYRapUw6YHn/ENZMXYVMgk7Nv8xyaitRGuKmy9uW1ZfgGQUzw0EgdeaQti1PGvxNOJ2oCXnGKWMfCURqHq2R+ExDhmu+OGL+q3vU/Z/YB1lynH166nM9YLh1fls/qQQ9811vbZ372dcRfXq/hyqoM1yYoAgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758673218; c=relaxed/simple;
	bh=1auLVJ7s7PzdO1Nyus0vxo6b3G1QtyEqRIbW7qlzRws=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mT0I2A82/4Ilng/M3abF5ZMvIU3RUADXChpDGxDkOVaQOevl/9GiL5Dxd/fLowfMBWQxkYNTeYpp2AVGEM2q0ppDmPJJXjCUbsLDRJJu+z+feQB1Etqs4qFmWbxbT5BmqHm5823mzvN3P6IyakRafz2QeVBrf2uXHVK6Iy/l7NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsHl+LM8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95EB2C4CEF5;
	Wed, 24 Sep 2025 00:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758673218;
	bh=1auLVJ7s7PzdO1Nyus0vxo6b3G1QtyEqRIbW7qlzRws=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SsHl+LM8HkvmjdRzsf7oNuVZU1m+I6v0cjdV+kzDJxBMelGi88G+PpVM8CDMVTw4g
	 rwC8J0+RfT/nyvS0bwJ+vK+gTV6yBzT1wSnbIj+ek9kNNC8Sb633axLuIhz/lbz/qu
	 HQaxvvADtL9ALXFANIbvPfho2bystVBGGiUTuVNpcO4oQd+YZIQXlE27F4EIWX6D7V
	 Rc7+m+CrmQuCid7pSbLZ0py3Rz99SZ0qJV3UNrnn5020sbf1AJ2fqWg+DIDL23z1yy
	 P5Aty2wc1U4ZBZrE05D/9COLIDiGc6ivo/YxUEcTFVQycm5LhRMODBn1kGq+O51LBI
	 pr77g6VxH4cFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCF239D0C20;
	Wed, 24 Sep 2025 00:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] mlx5 misc fixes 2025-09-22
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175867321524.1971872.14099732111728782116.git-patchwork-notify@kernel.org>
Date: Wed, 24 Sep 2025 00:20:15 +0000
References: <1758525094-816583-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1758525094-816583-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 mbloch@nvidia.com, leon@kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 moshe@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 22 Sep 2025 10:11:31 +0300 you wrote:
> Hi,
> 
> This patchset provides misc bug fixes from the team to the mlx5 Eth
> and core drivers.
> 
> Thanks,
> Tariq.
> 
> [...]

Here is the summary with links:
  - [net,1/3] net/mlx5: fs, fix UAF in flow counter release
    https://git.kernel.org/netdev/net/c/6043819e707c
  - [net,2/3] net/mlx5: HWS, ignore flow level for multi-dest table
    https://git.kernel.org/netdev/net/c/efb877cf27e3
  - [net,3/3] net/mlx5e: Fix missing FEC RS stats for RS_544_514_INTERLEAVED_QUAD
    https://git.kernel.org/netdev/net/c/6d0477d0d067

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



