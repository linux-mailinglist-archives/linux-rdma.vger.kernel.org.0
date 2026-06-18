Return-Path: <linux-rdma+bounces-22337-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Pa7fJ2w6M2od+gUAu9opvQ
	(envelope-from <linux-rdma+bounces-22337-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 02:23:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D1369CDF1
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 02:23:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LFbIMWXw;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22337-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22337-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 801CB3091570
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 00:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2973D22ACEB;
	Thu, 18 Jun 2026 00:21:01 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9702405E1;
	Thu, 18 Jun 2026 00:20:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781742060; cv=none; b=mZMzD/wH8xLBT2KDookno3M/GQeXnxBWwJAZCbGqHodqd0D4AhS2UIcnjnd0KxP+RPoXsqiA2/zfWfDCzld9FFh2o6vADHD35fLZcFmt/YZkF8R0gYwCOxgBaqHXKjYrUIzwWwwtYV4e77kNAzeHbFYBPU6OxLYLusbUNOGpwn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781742060; c=relaxed/simple;
	bh=3arIVhF/67GS9jQgSZLvlfK9B/U7rRqaN5+cBGVj64M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QiakMh7BtFlBFtC/kqM95lppZGfeU2+Q70tW6cEWKR8xQ2kJjv+usNr01Rnmhu1NtHrW+J7rpPmXTsQ/PsVUZM9O+n7g3a+Wsjmy6oKLYFVTfHLb1KXkWyPs4g5y6nLyJPufsKAKEg198dsAuHEZsy579U9/H2iPXtus8Mzlzug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFbIMWXw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D7C1F000E9;
	Thu, 18 Jun 2026 00:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781742057;
	bh=UNPPRd8B/p+uiHWPr1nXLJji67eYPfdSiU/9mrxCDtU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LFbIMWXwaQcl5d+wzqdVj3SDIc6JIILH5RpXNWH4/kWSPDNHaFbIJQ4SnPwOIFMH1
	 kLPBVDc73afoZ6uGveGkjjtVeFVYB4PYNvUcb/9LUut67BJF0oRaAKeK89Mktf66DA
	 0zyf4g01j/h5vu0kQ4e8bLeef8PsX92Rp+mHnAb9jTrBF3c1g6TsFSRqPlpvFi9fDE
	 GEAdh6Acv/sMNkIid8bIigYM2eDZS1nPzmAoee2zY2jiLxcg56of7GzgkBratRiPcD
	 ydy2hGMwxCwwE0DX831YK3YnYNYjIl9vR1phcURtzkdjnc5PMXi2s58tf2nJyf0VNb
	 HERgt/R7+UcGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1985A393102B;
	Thu, 18 Jun 2026 00:20:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][net-next] net/mlx5: Remove broken and unused
 mlx5_query_mtppse()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178174205063.1875263.1756685428081420140.git-patchwork-notify@kernel.org>
Date: Thu, 18 Jun 2026 00:20:50 +0000
References: <20260615140406.1828-1-lirongqing@baidu.com>
In-Reply-To: <20260615140406.1828-1-lirongqing@baidu.com>
To: lirongqing <lirongqing@baidu.com>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, gal@nvidia.com,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22337-lists,linux-rdma=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lirongqing@baidu.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:gal@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 34D1369CDF1

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 15 Jun 2026 22:04:06 +0800 you wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> mlx5_query_mtppse() reads the Event Trigger Pin (MTPPSE) register but
> reads the returned arm and mode values from the input buffer 'in'
> instead of the output buffer 'out', so it always returns the values
> that were written rather than the actual hardware state, making the
> query useless.
> 
> [...]

Here is the summary with links:
  - [net-next] net/mlx5: Remove broken and unused mlx5_query_mtppse()
    https://git.kernel.org/netdev/net/c/b50fa1e07cf8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



