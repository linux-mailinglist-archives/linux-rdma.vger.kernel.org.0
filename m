Return-Path: <linux-rdma+bounces-18371-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEsoOa1Ku2kliQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18371-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 02:00:29 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6B42C4429
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 02:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AD9930BA371
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 01:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C718023D2B1;
	Thu, 19 Mar 2026 01:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQFcTOk8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899C628E0F;
	Thu, 19 Mar 2026 01:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773882018; cv=none; b=aCM2Ubf0x8d9qpI45zoC8moyUBP7DRBJKYCDPL6ZpXqAjbg5TltSclsI8G8WSCX0xQqkT6Seok/uzlksoWhZQ3VGzXkcdK82o0Fhs9izKCSynMV8jFF3n4Q03h3mQR9dTQbC1DO9SKHAz5MgmxULVz9Zj2/tcqU2c9ddUfncovU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773882018; c=relaxed/simple;
	bh=hmBd2DfgURFfkTWJuxwq7USEXF1nmZvNCT+/vThpeJY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bT9fehmc+wkSxUTIj24ClHa0fPq9R/NJw/YP/xGRCziBJ3KUWY8eAo1fyTu/ol4CfLsAzCVl/UFMsKGNTbkipIDBpfdY7+n5h8Quk2I/S2iajJpeEKj8DmvKEXpQC8pOmb+31qkkdZiDf3WNH01eVpCcmGa5jiRfvRvsbCMhuHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQFcTOk8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320B0C19421;
	Thu, 19 Mar 2026 01:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773882018;
	bh=hmBd2DfgURFfkTWJuxwq7USEXF1nmZvNCT+/vThpeJY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FQFcTOk8qZ+9OUbBj2CAygkoEzgzaxw0qGaMI0SDrcLrZKsbCK5pui6v8zFGReoBB
	 6EJv8Lff2QwchIfbGwrz3ebHupnB6e2AzWQ3Pvik7e74MkM1o3i6Ig32YVeZ8x51Rg
	 /x+gxo1olphE1kZsHMqwilW3X1PGjtrJoD+tm2/R5f/YgaXWkh2avA6EJwiBITjLpP
	 QjVDM67KmuZaUr/SvLi7nAZs78vORu0xgua4FkJuiOigstZk4y54ndKR5ufB/sQETt
	 cz+RGrA+J4FOB/MbZ1dDOjXPXaggOxfkprg9QTbaLDwI3LjSXkZSNXFv4PcF6+XugL
	 3SV2SSXMky45Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0023808200;
	Thu, 19 Mar 2026 01:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] mlx5 misc fixes 2026-03-16
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177388200954.971452.3408173969965476969.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 01:00:09 +0000
References: <20260316094603.6999-1-tariqt@nvidia.com>
In-Reply-To: <20260316094603.6999-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 moshe@nvidia.com, dtatulea@nvidia.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18371-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E6B42C4429
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Mar 2026 11:46:00 +0200 you wrote:
> Hi,
> 
> This patchset provides misc bug fixes from the team to the mlx5
> core and Eth drivers.
> 
> Thanks,
> Tariq.
> 
> [...]

Here is the summary with links:
  - [net,1/3] net/mlx5: qos: Restrict RTNL area to avoid a lock cycle
    https://git.kernel.org/netdev/net/c/b7e3a5d9c0d6
  - [net,2/3] net/mlx5e: Prevent concurrent access to IPSec ASO context
    https://git.kernel.org/netdev/net/c/99b36850d881
  - [net,3/3] net/mlx5e: Fix race condition during IPSec ESN update
    https://git.kernel.org/netdev/net/c/beb6e2e5976a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



