Return-Path: <linux-rdma+bounces-21608-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LwfM41HHmomiQkAu9opvQ
	(envelope-from <linux-rdma+bounces-21608-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 05:01:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD62627801
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 05:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9BC2300B9F6
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 03:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC74C367B75;
	Tue,  2 Jun 2026 03:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjRJsHkY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53C13624C9;
	Tue,  2 Jun 2026 03:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780369204; cv=none; b=kPIQ7250Cyna2hFvxgT/OHVr+XbE5+mk7nT6Hx7P3+JPoKW2iyv+JMe0NxrZV9K9W0R05kE/QY8ona6Mpk9wUI3dKQniPGD6SaOe0jiZyqRbree2EZKrYJK3DQ7nCofOq/vPyW2UASaDkN5RzhLIOcqUld4PeImzW1G7rWja3FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780369204; c=relaxed/simple;
	bh=hC08xzOFHhxSowpAYIos9qJAlKWBe6Yu5A/O0TX3C7o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DPOwuejv/utg9NMpk+B1XLdRI6nubrF7nKXQ+gW/oBb5rX/xaWVLq6j0YxV0ACAgbwZVVsbtUlzv1cKjWN0ycaPjhNldtrO5BuCEcwdOtb7+4juCi2h2vCqc6OWB1W4pNTG235y4SIBVMxCTE74b3ar+B31hcaTvNMSXco1sj9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjRJsHkY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57251F00893;
	Tue,  2 Jun 2026 03:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780369203;
	bh=N5fzIYW9khiUM9j67VS7FJ0b6D8zszEdG6lwHIDhecU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XjRJsHkYh+th7VPuLBapoL0fUGT9Aylj2XTNpY+Vr81FLZwK/7Wrk5HJoRN6UrzYJ
	 jsbnOV4ttJC+0AF8JfZuX4AWhdb1i00Sbo0B5HutdEJo1zhwCiyrMStRNqzn0BCSII
	 sFJ9+NF6MdAq1dGFrU7IEGF5NnGpY0n7PYmCJdYcDaaWBIgAkj90P+sGP0zvfQA0sF
	 nSLiTf0s8OEIz4Km/h7UnNaGFJ34mqaaNiWsSbwITGKb3tI02fYCxFEm9K74L7sF2W
	 TwQ7KxBMcA1Wn5uIvGB00zF8IAa0XoDFUGkEvI7I7cIHkDosJ5idbpT/zn4doxhxOF
	 lhRB1hacdBtnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 196F338119F9;
	Tue,  2 Jun 2026 03:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] devlink: Release nested relation on devlink free
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178036920566.221457.9205076512445402287.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 03:00:05 +0000
References: <20260528191411.3270532-1-mbloch@nvidia.com>
In-Reply-To: <20260528191411.3270532-1-mbloch@nvidia.com>
To: Mark Bloch <mbloch@nvidia.com>
Cc: jiri@nvidia.com, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, tariqt@nvidia.com,
 leon@kernel.org, saeedm@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 jiri@resnulli.us
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-21608-lists,linux-rdma=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EBD62627801
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 May 2026 22:14:10 +0300 you wrote:
> devlink relation state is normally released from devl_unregister(), which
> calls devlink_rel_put(). This misses devlink instances that get a nested
> relation before registration and then fail probe before devl_register() is
> reached.
> 
> That flow can happen for SFs. The child devlink gets linked to its
> parent before registration, then a later probe error calls devlink_free()
> directly. Since the instance was never registered, devl_unregister() is not
> called and devlink->rel is leaked.
> 
> [...]

Here is the summary with links:
  - [net] devlink: Release nested relation on devlink free
    https://git.kernel.org/netdev/net/c/3522b21fd7e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



