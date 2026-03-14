Return-Path: <linux-rdma+bounces-18166-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NONGL3DtWkV4wAAu9opvQ
	(envelope-from <linux-rdma+bounces-18166-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Mar 2026 21:23:25 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BE228EE14
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Mar 2026 21:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E342303011E
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Mar 2026 20:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E22C37F737;
	Sat, 14 Mar 2026 20:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdJqR8X2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D124315F;
	Sat, 14 Mar 2026 20:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773519632; cv=none; b=B3/Kc40OtElfqzwRQhV3Wi4Osjbu0VkPHiYldxVOltkBKBUAzRarQSnI/hi4iCRCMqy0vPp7qzHSrrUQVe41LB+Qo2qlK23a4cK/6YD7I9EvVUmluicswocrNXbEgl/bXyeElbbMr2DaE4GR1C0OAqR44Xi5/oOU1ALSanVIkCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773519632; c=relaxed/simple;
	bh=dZ7TUltrsGQnkjHyx6uPFJSysa3z0NsdMkhYSIVZlgU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cp1xTW1bp0KgkNAIV9ioOaWTybJYj4o9MQNgunThb6ZqKgWdgd116UNpc6eoy4NFD9Zkt0DV3PhJWvkjvngYAM0DSCqHCENCDisC+zORa4PKMy0E6UtNT+5SwTVXWV7w/EcJJ3nGMSYXjb5xc+oq91CXbbu3gIeMKejC6qXnGcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdJqR8X2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31DFAC116C6;
	Sat, 14 Mar 2026 20:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773519632;
	bh=dZ7TUltrsGQnkjHyx6uPFJSysa3z0NsdMkhYSIVZlgU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HdJqR8X2SLbtNr28I19jzsOqhPhUyN9DvIpBPNgNE3OBDtV4RhJcouPowb6Uqxnez
	 Ve4ks8+dMYm9BIMr0WnHTltEHBmV4oRclBNoHf0b6l9V2JLFKs83Lawdb4W52210al
	 v+THkPxay8iLVet0kxhUlyQUfrgMSFZv1dpi2WhMSR3mZgMta2ctlQKUdLPVGWZrAt
	 lq9boFOdArGdKw9As8kO+ae8Zzxe5Vsan6Zohzz+FflwaCu7HB4K1UCwwHti0dW0EH
	 pFKVUP7gqsoCKvG4nz8GPd5QnZU4TMew7otPt7usiqrVN4H1FWZeIHsoyMTS6ELHDx
	 dsxBvK47zealw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF643808200;
	Sat, 14 Mar 2026 20:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 00/13] devlink: introduce shared devlink
 instance
 for PFs on same chip
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177351962627.1773477.8399936488095147761.git-patchwork-notify@kernel.org>
Date: Sat, 14 Mar 2026 20:20:26 +0000
References: <20260312100407.551173-1-jiri@resnulli.us>
In-Reply-To: <20260312100407.551173-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 donald.hunter@gmail.com, corbet@lwn.net, skhan@linuxfoundation.org,
 saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 przemyslaw.kitszel@intel.com, mschmidt@redhat.com, andrew+netdev@lunn.ch,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 chuck.lever@oracle.com, matttbe@kernel.org, cjubran@nvidia.com,
 daniel.zahka@gmail.com, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-trace-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18166-lists,linux-rdma=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F2BE228EE14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Mar 2026 11:03:54 +0100 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Multiple PFs on a network adapter often reside on the same physical
> chip, running a single firmware. Some resources and configurations
> are inherently shared among these PFs - PTP clocks, VF group rates,
> firmware parameters, and others. Today there is no good object in
> the devlink model to attach these chip-wide configuration knobs to.
> Drivers resort to workarounds like pinning shared state to PF0 or
> maintaining ad-hoc internal structures (e.g., ice_adapter) that are
> invisible to userspace.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,01/13] devlink: expose devlink instance index over netlink
    https://git.kernel.org/netdev/net-next/c/68deca0f0f4b
  - [net-next,v4,02/13] devlink: add helpers to get bus_name/dev_name
    https://git.kernel.org/netdev/net-next/c/0f5531879afb
  - [net-next,v4,03/13] devlink: avoid extra iterations when found devlink is not registered
    https://git.kernel.org/netdev/net-next/c/e2e3666fd360
  - [net-next,v4,04/13] devlink: allow to use devlink index as a command handle
    https://git.kernel.org/netdev/net-next/c/d85a8af57da8
  - [net-next,v4,05/13] devlink: support index-based lookup via bus_name/dev_name handle
    https://git.kernel.org/netdev/net-next/c/725d5fdb7b9c
  - [net-next,v4,06/13] devlink: support index-based notification filtering
    https://git.kernel.org/netdev/net-next/c/089aeb4f2218
  - [net-next,v4,07/13] devlink: introduce __devlink_alloc() with dev driver pointer
    https://git.kernel.org/netdev/net-next/c/eb32a6310a7b
  - [net-next,v4,08/13] devlink: add devlink_dev_driver_name() helper and use it in trace events
    https://git.kernel.org/netdev/net-next/c/20b0f383aae7
  - [net-next,v4,09/13] devlink: add devl_warn() helper and use it in port warnings
    https://git.kernel.org/netdev/net-next/c/104733e1303e
  - [net-next,v4,10/13] devlink: allow devlink instance allocation without a backing device
    https://git.kernel.org/netdev/net-next/c/a4c6d53e5fd6
  - [net-next,v4,11/13] devlink: introduce shared devlink instance for PFs on same chip
    https://git.kernel.org/netdev/net-next/c/1850e76b3804
  - [net-next,v4,12/13] documentation: networking: add shared devlink documentation
    https://git.kernel.org/netdev/net-next/c/63fff8c0f702
  - [net-next,v4,13/13] net/mlx5: Add a shared devlink instance for PFs on same chip
    https://git.kernel.org/netdev/net-next/c/2a8c8a03f306

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



