Return-Path: <linux-rdma+bounces-21258-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJuuDgu9FGp1PwcAu9opvQ
	(envelope-from <linux-rdma+bounces-21258-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 23:20:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9130B5CED95
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 23:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A5903006B26
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 21:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741BB38C42B;
	Mon, 25 May 2026 21:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhTLduo/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327E51FDE31;
	Mon, 25 May 2026 21:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779744005; cv=none; b=sXrcjBRobSSeDGb+A+lAaCB8QbkCOGJLF5/hxckWpF0RtgIjS9DArUKa12YBI8ovi6b7Gluuflj38rC1Ha+9d86Vb/xyozuzNrUVEnuspSiwZr52Y2kdCpkTZEFrdQFuId6LyirWWksaMMA0JVypCMvp/pGzpasBoH6bRP8quhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779744005; c=relaxed/simple;
	bh=LN2dRJ7yVrNP7yxIah/U/xei+R3GLx1w8LABCfzHcbE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JXEuQIJNpktSjOoxMfuQb3nsej/S6Mq083V7+jWOuk1iFBPEexNXudLASA17cFXA0QX7CLWCmjW/tAXZZfbtK7NaEXF6L5f2I+P7e/FbTKqc8gj5LvK0kmOzU+NebSQ2kBBcWZJ5JKnlKxaddkLj9ovnXcyxZtyv3EyolUZnukI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhTLduo/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60D41F000E9;
	Mon, 25 May 2026 21:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779744003;
	bh=Wvu8FqFU2M+kxGlMQrMRRPYcqPazeZSRxIHtjb/FEQk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dhTLduo/TAywqwokywEm2JV9AR/NN5wE4xSfPGGpmyLiomo99gA4ijkGqY2z4n9Er
	 CnHuGW1Cq37wsIr1JcLHcWyU4sKOpaz0a9bZs4DvWJ70R4XGkNrzZ3FNWDOl1qfNW1
	 4vg2J68EyEiXU7GxENwhRX1RN0OGF04WL5+FV0N18pqlO9TgRJwXOO+IuVcejuQtzB
	 JGOy8ql5y+YddKnHmKdeMr9ujDXQrfAEM7ogYllKlmAJUPaWrm3fVBxDtb2Amv+/Qe
	 SwpKI2fhdz4HkuEPIWxFIG4++EUFpSnjGBFR30XAHzPqn3Y3tOqAGnZpHSiPkZ96su
	 kcfeCXb5qC/Tw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93C91380AA76;
	Mon, 25 May 2026 21:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v16 net-next 0/9] octeontx2-af: npc: Enhancements.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177974401040.3119043.5181275756301070393.git-patchwork-notify@kernel.org>
Date: Mon, 25 May 2026 21:20:10 +0000
References: <20260521095303.2395584-1-rkannoth@marvell.com>
In-Reply-To: <20260521095303.2395584-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, oss-drivers@corigine.com, akiyano@amazon.com,
 andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com,
 arkadiusz.kubalewski@intel.com, brett.creeley@amd.com, darinzon@amazon.com,
 davem@davemloft.net, donald.hunter@gmail.com, edumazet@google.com,
 horms@kernel.org, idosch@nvidia.com, ivecera@redhat.com, jiri@resnulli.us,
 kuba@kernel.org, leon@kernel.org, mbloch@nvidia.com,
 michael.chan@broadcom.com, pabeni@redhat.com, pavan.chebbi@broadcom.com,
 petrm@nvidia.com, Prathosh.Satish@microchip.com,
 przemyslaw.kitszel@intel.com, saeedm@nvidia.com, sgoutham@marvell.com,
 tariqt@nvidia.com, vadim.fedorenko@linux.dev
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,corigine.com,amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-21258-lists,linux-rdma=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9130B5CED95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 May 2026 15:22:54 +0530 you wrote:
> This series extends Marvell octeontx2-af support for CN20K NPC (MCAM
> debuggability, allocation policy, default-rule lifetime, optional KPU
> profiles from firmware files, X2/X4 MCAM keyword handling in flows and
> defaults, and dynamic CN20K NPC private state), adds a devlink mechanism
> for multi-value parameters, and adjusts devlink param netlink helpers
> and mlx5 so stack usage stays within -Wframe-larger-than limits once union
> devlink_param_value grows.
> 
> [...]

Here is the summary with links:
  - [v16,net-next,1/9] octeontx2-af: npc: cn20k: debugfs enhancements
    (no matching commit)
  - [v16,net-next,2/9] net/mlx5e: Reduce stack use reading PCIe congestion thresholds
    https://git.kernel.org/netdev/net-next/c/e57516529a5b
  - [v16,net-next,3/9] devlink: pass param values by pointer
    https://git.kernel.org/netdev/net-next/c/d603517771d8
  - [v16,net-next,4/9] devlink: Implement devlink param multi attribute nested data values
    (no matching commit)
  - [v16,net-next,5/9] octeontx2-af: npc: cn20k: add subbank search order control
    (no matching commit)
  - [v16,net-next,6/9] octeontx2: cn20k: Coordinate default rules with NIX LF lifecycle
    (no matching commit)
  - [v16,net-next,7/9] octeontx2-af: npc: Support for custom KPU profile from filesystem
    (no matching commit)
  - [v16,net-next,8/9] octeontx2: cn20k: Respect NPC MCAM X2/X4 profile in flows and DFT alloc
    (no matching commit)
  - [v16,net-next,9/9] octeontx2-af: npc: cn20k: Allocate npc_priv and dstats dynamically.
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



