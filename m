Return-Path: <linux-rdma+bounces-13581-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DB9B939F7
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 01:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5489219C1A80
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 23:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931BC313260;
	Mon, 22 Sep 2025 23:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcGnzvT1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203AF307AF2;
	Mon, 22 Sep 2025 23:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758584423; cv=none; b=A7OrgN3HkNNzruRlicLcV9bRS4+7qi6XpQ0bVwl9L1OsjAeBZS0cBq4CO+voElUt+EBIsIx//V2gCh+yDKLFvbHASZ16ytYg7zP4W0eB9kxnrUoCkBo73E1SSiu4vn1WfWpd0Mw/2peYTuWkWL5w9pP3CzlESlFTFanCokJZQtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758584423; c=relaxed/simple;
	bh=+jZWFLWHv69TbZUVIwzSdXjCI51nQ3r7VN1Hzi5otJ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jC/I7IHNKjJ2gG0grTJuU/RMZ5Nwx4IVt9lcvsSLNCLmQnpdWGp4D+d6dIs43ugEul+QvaLxIS97IciN3T7hGynJgpYAYCahwzZwxDJgIWhTk1NE0WWOmn12KVtn/f9FkmJFX3BUUGkIah8n0TKLaVn5EYMgHhxfCQ11C7g+QF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcGnzvT1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D9DC113D0;
	Mon, 22 Sep 2025 23:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758584421;
	bh=+jZWFLWHv69TbZUVIwzSdXjCI51nQ3r7VN1Hzi5otJ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OcGnzvT1rOPepEHATb9vwbMc6u3MdZhkNoPwKbFNiCj4flXe8Af7h4F8TZKhRymOt
	 3GtmpTl8AWiXh/sRM0mz6TZVRCWOL9rVXlS9Axrqf6r3aPkU8DwxMKH3FnP3k5lYeU
	 LQx+ClbCsmC0Q/vghFy6/TmLvNr57pWnkMbd8UhR3kveG9AP4P2bqzA6/gN3odAtto
	 ImY1QX3ZF6U8yYY+RMbYs3lhLlPRFzZGXGVcoATL2zFj5Tyn24o33frq8s+p0NJkGK
	 D3PFk1O70rxHazBMz4T7IvZDsoTimQ96XAodLmb1o+FnA3fOQJZSFmSljmvjT6QGxm
	 iBbi+4kwLDYhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DCA39D0C20;
	Mon, 22 Sep 2025 23:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [pull-request] mlx5-next updates 2025-09-21
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175858441899.1195312.8354463671118218585.git-patchwork-notify@kernel.org>
Date: Mon, 22 Sep 2025 23:40:18 +0000
References: <1758443940-708689-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1758443940-708689-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, moshe@nvidia.com,
 agoldberger@nvidia.com

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 21 Sep 2025 11:39:00 +0300 you wrote:
> Hi,
> 
> The following pull-request contains a common mlx5 update
> patch for your *net-next* tree.
> Please pull and let me know of any problem.
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [pull-request] mlx5-next updates 2025-09-21
    https://git.kernel.org/netdev/net-next/c/1bcce9ec189b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



