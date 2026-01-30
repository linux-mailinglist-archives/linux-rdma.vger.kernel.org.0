Return-Path: <linux-rdma+bounces-16212-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CKAHpMdfGmAKgIAu9opvQ
	(envelope-from <linux-rdma+bounces-16212-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 03:55:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0BEB69F2
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 03:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 807AD3036E80
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 02:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA3C34D3B1;
	Fri, 30 Jan 2026 02:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fko9zgbI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5DA34C128;
	Fri, 30 Jan 2026 02:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769741448; cv=none; b=Ld1DHDVzTMM2sgyTaF3xjm+M1hTffN9u6YaTmgywQAxGTMjurXUMEaC8Urw1+alEdUV56dm7hWnHdz/11Wisu5TMbLDWzuhHjNsFHPFRYDjWEJn9TSSFMSF6tBx33X+tyGv7BJFPUXQPRJq/FHAi0KRd5rsJDfHRmGVidzaTkA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769741448; c=relaxed/simple;
	bh=kbDgp/9oUx3zNEWhZFBn0BY0X6oyRhQRKHlObRZxJJo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S9Mmq7nOJdg9lK83surQUAcCM7INWStOB9BVGule4h4ztncFaX3DwLLqlGRKP37fFRZDT49wsRw8JN70a1YR2GFiPF/a7FxPWkeIKfQIPTmJkIZ6vsseVhS0/YwTz6tlpR658mCFzFcC+306h9OadSIEC5Df+JfRV+tRdnbFHE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fko9zgbI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783C0C4AF0F;
	Fri, 30 Jan 2026 02:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769741447;
	bh=kbDgp/9oUx3zNEWhZFBn0BY0X6oyRhQRKHlObRZxJJo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Fko9zgbIwk0+l3QMKDXyvaKZ9xQn8qT///vO1Og+sZn4RYb5+qPEM1WXpWvAhnUgs
	 KdNLce/Yw6sAf1vFeCqFr4pGOlYJCFmK3Oyx8y8cHXVDmE9x3a1Ghbfbfru3ViRsJH
	 8fUWm9n6D6M1vO/j4pMjiOptIu7TTsyC/r/QdB9AcbzU+Uz4Vd49ps06GMtiFPDXMX
	 5va7zehHlNVWKRd5z9Q93JrzW7zI+7Sl/OVaAJWEuuxhHo/z/aQrOouQecmEc0l6SB
	 UGO7k6RucDbtsvnruf5UcnFP1sAAjN8NbhU/r+U9dg94KPQvGK8aPVM6wLB8doNssF
	 4+uxP+2i4o3YQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EB1C380CEE0;
	Fri, 30 Jan 2026 02:50:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dpll: expose fractional frequency offset in ppt
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176974143985.3149010.12354728128408469050.git-patchwork-notify@kernel.org>
Date: Fri, 30 Jan 2026 02:50:39 +0000
References: <20260126162253.27890-1-ivecera@redhat.com>
In-Reply-To: <20260126162253.27890-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, donald.hunter@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com,
 jiri@resnulli.us, Prathosh.Satish@microchip.com, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com, andrew+netdev@lunn.ch,
 poros@redhat.com, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16212-lists,linux-rdma=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,davemloft.net,google.com,redhat.com,linux.dev,intel.com,resnulli.us,microchip.com,nvidia.com,lunn.ch];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B0BEB69F2
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Jan 2026 17:22:51 +0100 you wrote:
> Currently, the dpll subsystem exports the fractional frequency offset
> (FFO) in parts per million (ppm). This granularity is insufficient for
> high-precision synchronization scenarios which often require parts per
> trillion (ppt) resolution.
> 
> Add a new netlink attribute DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT
> to expose the FFO in ppt.
> 
> [...]

Here is the summary with links:
  - [net-next] dpll: expose fractional frequency offset in ppt
    https://git.kernel.org/netdev/net-next/c/bc443c253fcd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



