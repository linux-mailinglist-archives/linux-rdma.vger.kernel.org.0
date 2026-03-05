Return-Path: <linux-rdma+bounces-17544-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMvgF4KmqWnwBgEAu9opvQ
	(envelope-from <linux-rdma+bounces-17544-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 16:51:30 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E0F214DDF
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 16:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48F4631A9BE0
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 15:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02963CA4B5;
	Thu,  5 Mar 2026 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ek4Qj6YO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B4E39A056;
	Thu,  5 Mar 2026 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772725216; cv=none; b=RYswBdY/jH7y/fYqUwwwWJ7FDCLqAgNwRvHxdwm9pX9vw1llQXkaCM/h9eY/jEv3jEO6vHo6B5OEVKnhUAv9kgxnQNXk13a5o0LpKqj8MxtSLc3QSHkU7VQv7Pl5HOfZSrotGA5epZdA8WlEklwKSH3IkfRlqCNuzMJfv/1Lm1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772725216; c=relaxed/simple;
	bh=scBpvNSW67GWlfBLLCZLlHXu0Zb4PC8him4Vw+6v29Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JaRC43rhwT3Lead5g57vkb+29FWr9+Z24U2acnppldg4GTBESMayn3T04IgHd241o9pb+qO0wtCDHLG8ckcoAAvGdr8FRqqEDI+VtOFHgn9dn/sGzUf2sgGYnKTXNZhXOwf0T7mJ7ThCsV1L0/QegieDzw8b932bokFzVorlhpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ek4Qj6YO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2F5C116C6;
	Thu,  5 Mar 2026 15:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772725216;
	bh=scBpvNSW67GWlfBLLCZLlHXu0Zb4PC8him4Vw+6v29Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ek4Qj6YOvCQtw7OPvXwmd4vFXqj7ne2771lLRj1YgSWZpSEy9V1JKSRsLly92jV2J
	 BzttnQTrenn/0ibeM81DxVCZTsvwC+37Qp14/L2GPDvo3hNRPg55UQHitKK0tbX7hs
	 AiHZl4R1jUJVfs7VJimQq366tdZNkw3Babx/majUEhdFVCYuQhinyLx1yXaUQIFJBp
	 jD6DQp0L5UI/PQYm38D5At3gGzPIAdfUPWNiIsCyIlQ78oZEw//n0B46g3PCrHlDFP
	 ACzoMDH7stcYFEYu1VBkwqBnR9aXBChltqYktCc7Hon60rjnqg9feBYwcW2GDSvHGR
	 A3jAAdqYDS4vA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FEA33808200;
	Thu,  5 Mar 2026 15:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next V4 0/5] net: ethtool: Track TX pause storm
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177272521605.3175356.3608317280940155593.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 15:40:16 +0000
References: <20260302230149.1580195-1-mohsin.bashr@gmail.com>
In-Reply-To: <20260302230149.1580195-1-mohsin.bashr@gmail.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, alok.a.tiwari@oracle.com,
 andrew+netdev@lunn.ch, andrew@lunn.ch, davem@davemloft.net,
 dg573847474@gmail.com, donald.hunter@gmail.com, edumazet@google.com,
 gal@nvidia.com, horms@kernel.org, idosch@nvidia.com,
 jacob.e.keller@intel.com, kernel-team@meta.com, kory.maincent@bootlin.com,
 kuba@kernel.org, lee@trager.us, leon@kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux@armlinux.org.uk, mbloch@nvidia.com, mike.marciniszyn@gmail.com,
 o.rempel@pengutronix.de, pabeni@redhat.com, saeedm@nvidia.com,
 tariqt@nvidia.com, vadim.fedorenko@linux.dev
X-Rspamd-Queue-Id: C5E0F214DDF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17544-lists,linux-rdma=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,fb.com,oracle.com,lunn.ch,davemloft.net,gmail.com,google.com,nvidia.com,kernel.org,intel.com,meta.com,bootlin.com,trager.us,armlinux.org.uk,pengutronix.de,redhat.com,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  2 Mar 2026 15:01:44 -0800 you wrote:
> With TX pause enabled, if a device cannot deliver received frames to
> the stack (e.g., during a system hang), it may generate excessive pause
> frames causing a pause storm. This series updates the uAPI to track TX
> pause storm events as part of the pause stats (p1), proposes using the
> existing pfc-prevention-tout knob to configure the storm watchdog (p2),
> adds pause storm protection support for fbnic (p3), and leverages p1
> to provide observability into these events for the fbnic (p4) and mlx5
> (p5) drivers.
> 
> [...]

Here is the summary with links:
  - [net-next,V4,1/5] net: ethtool: Track pause storm events
    https://git.kernel.org/netdev/net-next/c/cc39325f9278
  - [net-next,V4,2/5] net: ethtool: Update doc for tunable
    https://git.kernel.org/netdev/net-next/c/817de93c348a
  - [net-next,V4,3/5] eth: fbnic: Add protection against pause storm
    https://git.kernel.org/netdev/net-next/c/9b7c8728f53a
  - [net-next,V4,4/5] eth: fbnic: Fetch TX pause storm stats
    https://git.kernel.org/netdev/net-next/c/8d282b680c72
  - [net-next,V4,5/5] eth: mlx5: Move pause storm errors to pause stats
    https://git.kernel.org/netdev/net-next/c/cc663d3fed06

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



