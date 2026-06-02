Return-Path: <linux-rdma+bounces-21651-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bnYrLzBMH2oxjwAAu9opvQ
	(envelope-from <linux-rdma+bounces-21651-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 23:33:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 335956321AB
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 23:33:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NGmp5p9v;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21651-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21651-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2C9C308EB87
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 21:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC9C3A9626;
	Tue,  2 Jun 2026 21:30:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732ED3A6B9D;
	Tue,  2 Jun 2026 21:30:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780435809; cv=none; b=uVFqO8WKDCX3VLYHOLHqD90heMv1VYMYiM9uEAmiptpOczspQSQvLl/U5OrOBGhkryX7rJa9HpF2UYqlNCdoFWvjke3qMtJ71nT0/KXlZtkPH19XOcmQptwO1RhaBdTwMZSBuAsfq/mRqN3zh15d0H39+CSapP6WlLiUqxVQGOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780435809; c=relaxed/simple;
	bh=EybQnBMoxL9pB6EZAAy755FMVg0F44AFTkBuy545DAw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qExRJoF7ZlBeu2RE4G/tkGV9Xv6XgW9wcMEMITd1BKJkXYpu56Y04f8wzBUo4mFEyg5XeBNJdxg0g+yMLkYabKUepArVvVPnEZIdynzbyEocBcsjJEZ1CQ/YD3dZrrT/tvIu21qw01gdDneXlp2SRF25mcuKF94AvVvGs6CstpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGmp5p9v; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F04D1F00893;
	Tue,  2 Jun 2026 21:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780435807;
	bh=fNztbHBTXfT03ZHeQleG2e86Ii5WrI1yJc7iP2ZJidc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NGmp5p9voh26f4zoK7UJWcX8n8YeIJk1Jcgx/48irsR5/ea1ktBQ0w/a0WhB1VdnT
	 r5XCwmFfhccSwOaLOqDkqBOTjM94bLQWsR5/2F6WakhAthcUJe5y4EdNHohKKxk6/Y
	 4/6VmWDYz9eatPmAJbDaLJjR5xSCjrYguy9/aZrtTD6vIua77UFHB6HpH2XTQEQqek
	 v4vmtsalNGasmwuiMpdjFB4WKSDyleGQlWNUeNwQBhTi4RkEJmeFABQnCJ3q9RIQf6
	 K8+6Z3nz1RI2MaXHEx8aDAo3DoYJ+wiz7lhIkp91vtwg8JSXg/QBHsH9hit0xtWc4e
	 Z2P9klkg/TmAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19AA53811A72;
	Tue,  2 Jun 2026 21:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V7 0/2] net/mlx5: Avoid payload in skb's linear
 part
 for better GRO-processing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178043580880.1057654.15648019430651033677.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 21:30:08 +0000
References: <20260601061522.398044-1-tariqt@nvidia.com>
In-Reply-To: <20260601061522.398044-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 mbloch@nvidia.com, leon@kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 ameryhung@gmail.com, david.laight.linux@gmail.com, cpaasch@openai.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21651-lists,linux-rdma=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,nvidia.com,vger.kernel.org,gmail.com,openai.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:mbloch@nvidia.com,m:leon@kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:ameryhung@gmail.com,m:david.laight.linux@gmail.com,m:cpaasch@openai.com,m:andrew@lunn.ch,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 335956321AB

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 1 Jun 2026 09:15:20 +0300 you wrote:
> Hi,
> 
> This is V7 of a series originally submitted by Christoph.
> 
> When LRO is enabled on the MLX, mlx5e_skb_from_cqe_mpwrq_nonlinear
> copies parts of the payload to the linear part of the skb.
> 
> [...]

Here is the summary with links:
  - [net-next,V7,1/2] net/mlx5e: DMA-sync earlier in mlx5e_skb_from_cqe_mpwrq_nonlinear
    https://git.kernel.org/netdev/net-next/c/34d8c91a3d39
  - [net-next,V7,2/2] net/mlx5e: Avoid copying payload to the skb's linear part
    https://git.kernel.org/netdev/net-next/c/399f030cd612

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



