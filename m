Return-Path: <linux-rdma+bounces-17200-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YI97MKTHn2k8dwQAu9opvQ
	(envelope-from <linux-rdma+bounces-17200-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 05:10:12 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4381A0C89
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 05:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6873F30530FE
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 04:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0A4389462;
	Thu, 26 Feb 2026 04:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7uIsDYA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC253115B8;
	Thu, 26 Feb 2026 04:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772079007; cv=none; b=P6rhIGiQtgFLkn3YJx9M7ayXHiqGXK1G1N+N1wf9agmEXrR0Zc5PYhsD0yWbn6V0mpKV/+0w/niDkm8PygKGHJNWRE8dYR+/pjNu4gRQzxA/uQA2yoqTk0gO0fZHxV7PqQxooCAzzD1v6y8l4B8hYO1xMjLRpPIb25D3p2D/oMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772079007; c=relaxed/simple;
	bh=7wjETam1Ebkj5tWVJx+ZmMncZ3REwZp5reVUx0EMfFA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LYRnKGW6P5fENuUrNK70VminKjU8uowaddYlGEtE+9mOuy1aFcvdYp/F4/AjC20cMA+vpqCDVbovCuRxHAFERflQjs/v1S9Cjm2qfIa1SBcpF7GJpQCtAMTL+VRS9y/0Ad579uzNGrAXYVL8aGE8aJbmnH6xbxdDz17m32iFJCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7uIsDYA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B72AC19424;
	Thu, 26 Feb 2026 04:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772079006;
	bh=7wjETam1Ebkj5tWVJx+ZmMncZ3REwZp5reVUx0EMfFA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o7uIsDYA3c36vuAnz5JhKRbiFPkGK2ddty/5gH+P1yc8542MT31GqB4YHQUUar9UH
	 7OWo5KZNN/+f4Y4dOR27NGNlSgVp6e3mneEZyrGBE0jt8pvdUzzMMu/Ig2eIflWn9z
	 jvLnSwUN8H7BIioUp2m1Q9bT37Ir9h5HnOrqwHGJH+EL7fGoUR+2dC3sR5VTx5pdoF
	 slCgOQdgwmE0wMyjjYlf0Dtd1Arn6w/WUB6wUW5OQStH1FT85yBzB553Hs1hocUXJb
	 TNXlag8FRSvFmT6kI7AeBqQ/o6usKS5p43LUW15oPKAhc/N9QkvIfUI9fBA1GwK7Eo
	 A2xbmo30A1bHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE83380A94B;
	Thu, 26 Feb 2026 04:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] mlx5 misc fixes 2026-02-24
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177207901129.1032211.11120508499634928689.git-patchwork-notify@kernel.org>
Date: Thu, 26 Feb 2026 04:10:11 +0000
References: <20260224114652.1787431-1-tariqt@nvidia.com>
In-Reply-To: <20260224114652.1787431-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 dtatulea@nvidia.com, shayd@nvidia.com
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
	TAGGED_FROM(0.00)[bounces-17200-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D4381A0C89
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Feb 2026 13:46:47 +0200 you wrote:
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
  - [net,1/5] net/mlx5: DR, Fix circular locking dependency in dump
    https://git.kernel.org/netdev/net/c/2700b7e603af
  - [net,2/5] net/mlx5: LAG, disable MPESW in lag_disable_change()
    https://git.kernel.org/netdev/net/c/bd7b9f83fb9f
  - [net,3/5] net/mlx5: E-switch, Clear legacy flag when moving to switchdev
    https://git.kernel.org/netdev/net/c/d7073e8b978a
  - [net,4/5] net/mlx5: Fix missing devlink lock in SRIOV enable error path
    https://git.kernel.org/netdev/net/c/60253042c0b8
  - [net,5/5] net/mlx5e: Fix "scheduling while atomic" in IPsec MAC address query
    https://git.kernel.org/netdev/net/c/859380694f43

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



