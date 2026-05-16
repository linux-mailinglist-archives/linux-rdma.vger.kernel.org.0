Return-Path: <linux-rdma+bounces-20793-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLOTNIa6B2pjEgMAu9opvQ
	(envelope-from <linux-rdma+bounces-20793-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 02:29:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9795598A0
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 02:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C71B300ACBB
	for <lists+linux-rdma@lfdr.de>; Sat, 16 May 2026 00:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C33723C8AE;
	Sat, 16 May 2026 00:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2H38OEl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C274F23504B;
	Sat, 16 May 2026 00:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778891394; cv=none; b=fQiaelIaEZ1rdiC0F/Q7CGbLHn+jKJxfMbCD0gqti1I6R9mxAQbsujUcl6LnrGceL9r7W6MXyR4yKPmZPZbR2YA4AXYk3PtTf/oEnLJD+WLjwy6Yceah5LhlRmeuvAYMzGb2hg/If3/YgIgykDWdbj7tQ0LyEex5homargq57N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778891394; c=relaxed/simple;
	bh=uTepMk0K3F14iMTOK/Tlgs2iEIImTFgBRqDEkRQqDrw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k2HUZdx/yj/yGwkFv4ULJwnozsUtmtpGhjNJ8YflHNiC3wLb5BBBs+FN5B15wY6Mv2CZ1C2DjDH5umQk6qOuZLnghzSQFOhNLBQWry8jXMKdTFnPRGR1a1q4hZZEjoazcWotK4FOblw2wZrC2u2a7yPA2p7XR5PY/oHn81/M/MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2H38OEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9F9C2BCB0;
	Sat, 16 May 2026 00:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778891394;
	bh=uTepMk0K3F14iMTOK/Tlgs2iEIImTFgBRqDEkRQqDrw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d2H38OEl8uH1WGxfFLMet1ZQUMDAphvjVFtnogcy29vqrLa7KWXc8BKm6tcBxDu5v
	 IfnZDWqKgDcxM5XiZP88WQB0F4xVH1qox23MKFAooLj7zc/aBlqJ6bVW+wPrzHdwpD
	 TGxvVd+1HdDqiXGo5N+dAns4jFSMicmCXeWOoeVmjE258Wb/gepWTQmuliDaY7P92q
	 4bmh08zvswAwrXLcBzIrh+dmyuCMRchKD4X0WzVJv7nW55DCn6QxF0BKG53Oft1XFS
	 W7H6qz2J+dV9bmCgs7yEYm2j7YX9KlR2EvZMXcvBt8+XuGABtjPq3pk0P8o1DimXxv
	 YNVoO+tygEYcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09333930A23;
	Sat, 16 May 2026 00:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] IB/IPoIB: ndo_set_rx_mode_async conversion
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177889140739.207359.8985306017569918471.git-patchwork-notify@kernel.org>
Date: Sat, 16 May 2026 00:30:07 +0000
References: <20260513124519.3357165-1-dtatulea@nvidia.com>
In-Reply-To: <20260513124519.3357165-1-dtatulea@nvidia.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: jgg@ziepe.ca, leon@kernel.org, aleksandr.loktionov@intel.com,
 sdf.kernel@gmail.com, pabeni@redhat.com, tariqt@nvidia.com, sdf@fomichev.me,
 netdev@vger.kernel.org, cratiu@nvidia.com, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 7A9795598A0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20793-lists,linux-rdma=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[ziepe.ca,kernel.org,intel.com,gmail.com,redhat.com,nvidia.com,fomichev.me,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 May 2026 15:45:18 +0300 you wrote:
> The commit in the fixes tag added a warning for devices
> that are netdev ops locked that they should be converted
> to .ndo_set_rx_mode_async. IPoIB for mlx5 is such a
> driver which was missed during the conversion because the
> flow is more complex:
> - mlx5 part of IPoIB device was converted to ops-lock in commit [1].
> - ipoib_intf_init() then overrides netdev_ops with
>   ipoib_netdev_ops_{pf,vf}, which still wired ndo_set_rx_mode to the
>   legacy sync path -- tripping the new warning on every probe.
> 
> [...]

Here is the summary with links:
  - [net] IB/IPoIB: ndo_set_rx_mode_async conversion
    https://git.kernel.org/netdev/net/c/cfd08f09723c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



