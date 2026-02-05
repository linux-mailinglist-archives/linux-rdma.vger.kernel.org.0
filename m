Return-Path: <linux-rdma+bounces-16598-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMoEFxC0hGk54wMAu9opvQ
	(envelope-from <linux-rdma+bounces-16598-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 16:15:28 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 026AEF47E9
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 16:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9966B3045222
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 15:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0634741C317;
	Thu,  5 Feb 2026 15:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNsEOqd/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAEA1ACED5;
	Thu,  5 Feb 2026 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770304219; cv=none; b=EMg7NI8Y6Cp54AEtucGvtequBYPtjk8ZLIaL7BJJfqaHZTTz/dHkGjTF2G7Bv8zMy02DmsZ23sRHi03D7HNwzGOnkm5OmnUxw/B0TDKlxdy6xEAGWIWD5G3KEk+1wFg30Gmrh0HJ99wwImkqQgqkNybPexFUSafowiPuedLSdzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770304219; c=relaxed/simple;
	bh=VeYMHdnKfPv54A8U9mPwiib6zhPfIcEkcUaDZYvk7xQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cvRw2fX6uORWSnykMyAUYYifzBqCSzjj1wCJaJ+Z4mSuD+F4vqyaCFqvsqodvPdTxEI0Fz6cE1cAeCANS4kJQrzq8pURCxmIELs7vEEFqviz4K1HPw2QY4hpInJMro9t46jD2VYBDzj0aiN8ApgSbTCyxZA2orbeyRnvmJc0iLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNsEOqd/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F532C4CEF7;
	Thu,  5 Feb 2026 15:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770304219;
	bh=VeYMHdnKfPv54A8U9mPwiib6zhPfIcEkcUaDZYvk7xQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bNsEOqd/D0WbPvbvhpNW8Oi8MvEVrx0k7s8eCItOfz3WEHl/YBnrOIyVQoR2TC2fk
	 JxS1oPlrwZj5YQREz5cDlRbfUvg2sy7HDDEkOYZJkB/Y8swytDxUsBPTrIG8jSpXJo
	 I5ZsWtKcNgv+whp2eVYoGrTXx5NPB8h3j5KVy99Ud9ZMlKRAKOSlQqxQDw2pEdamYh
	 5Ol9Ve9ORYMFCjmn5nwo28POQqYswmuP8Bta4LIAGY6UIJVdARqVgDQ/ViIkZv5scD
	 4GKt+Ng7ubfci9POrdU72wYksAypsZbJMHZmHeFdnr2sOou1Da3MShZqPsvzGnGB5j
	 5Nq7vqDPmp38A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 486033808200;
	Thu,  5 Feb 2026 15:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/9] dpll: Core improvements and ice E825-C
 SyncE
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177030421708.447604.18321209785815350003.git-patchwork-notify@kernel.org>
Date: Thu, 05 Feb 2026 15:10:17 +0000
References: <20260203174002.705176-1-ivecera@redhat.com>
In-Reply-To: <20260203174002.705176-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, aleksander.lobakin@intel.com,
 andrew+netdev@lunn.ch, arkadiusz.kubalewski@intel.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, jiri@resnulli.us,
 jonathan.lemon@gmail.com, leon@kernel.org, mbloch@nvidia.com,
 pabeni@redhat.com, Prathosh.Satish@microchip.com,
 przemyslaw.kitszel@intel.com, richardcochran@gmail.com, saeedm@nvidia.com,
 tariqt@nvidia.com, anthony.l.nguyen@intel.com, vadim.fedorenko@linux.dev,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
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
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,resnulli.us,gmail.com,nvidia.com,redhat.com,microchip.com,linux.dev,lists.osuosl.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-16598-lists,linux-rdma=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 026AEF47E9
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  3 Feb 2026 18:39:53 +0100 you wrote:
> This series introduces Synchronous Ethernet (SyncE) support for the Intel
> E825-C Ethernet controller. Unlike previous generations where DPLL
> connections were implicitly assumed, the E825-C architecture relies
> on the platform firmware (ACPI) to describe the physical connections
> between the Ethernet controller and external DPLLs (such as the ZL3073x).
> 
> To accommodate this, the series extends the DPLL subsystem to support
> firmware node (fwnode) associations, asynchronous discovery via notifiers,
> and dynamic pin management. Additionally, a significant refactor of
> the DPLL reference counting logic is included to ensure robustness and
> debuggability.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/9] dpll: Allow associating dpll pin with a firmware node
    https://git.kernel.org/netdev/net-next/c/d0f4771e2bef
  - [net-next,v5,2/9] dpll: zl3073x: Associate pin with fwnode handle
    https://git.kernel.org/netdev/net-next/c/e6dc7727b608
  - [net-next,v5,3/9] dpll: Add notifier chain for dpll events
    https://git.kernel.org/netdev/net-next/c/2be467588d6b
  - [net-next,v5,4/9] dpll: Support dynamic pin index allocation
    https://git.kernel.org/netdev/net-next/c/711696b3e168
  - [net-next,v5,5/9] dpll: zl3073x: Add support for mux pin type
    https://git.kernel.org/netdev/net-next/c/fdad05ed4ec2
  - [net-next,v5,6/9] dpll: Enhance and consolidate reference counting logic
    https://git.kernel.org/netdev/net-next/c/729f5e0153bd
  - [net-next,v5,7/9] dpll: Add reference count tracking support
    https://git.kernel.org/netdev/net-next/c/3c0da1030c58
  - [net-next,v5,8/9] drivers: Add support for DPLL reference count tracking
    https://git.kernel.org/netdev/net-next/c/085ca5d20171
  - [net-next,v5,9/9] ice: dpll: Support E825-C SyncE and dynamic pin discovery
    https://git.kernel.org/netdev/net-next/c/ad1df4f2d591

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



