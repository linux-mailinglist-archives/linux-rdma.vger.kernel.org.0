Return-Path: <linux-rdma+bounces-22876-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 89nWGL8YTmqVDAIAu9opvQ
	(envelope-from <linux-rdma+bounces-22876-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 11:30:39 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E31CE723BFD
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 11:30:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=G2Qv3WY5;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22876-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22876-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32028300AB18
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2026 09:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA9A3F9F44;
	Wed,  8 Jul 2026 09:30:32 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA89409631;
	Wed,  8 Jul 2026 09:30:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783503031; cv=none; b=LyBpZG+4Z6SkZrwjqsea10dKnXaD1fkE1DqGU4v6luPCiAiP9bhf0bOY6JMDgazHYRt6fY/2RtsI3zZfBBzq/cm1kQNa00wOv1Enoy37Fnxt21ttf0I8cgi7n5Vd4uC6vybq1n//Cm17hge7h+wlyR163k+PCMxfBqF2+vbCwZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783503031; c=relaxed/simple;
	bh=/2j4cwYxuKWS4+udthx3B8WvhFnFUuf4/Mi2+zu589Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o+2Px81sdDcjKh6SLwiPsX6FQBBSB/1K7h7a2tvaqQr+zbUKGNiNYxG0l4IjeVp2x34Dk2k5q0I+vZYT0xFujKtGQGGAOzsiqkxtOMSTudaIaYffqir6xFF9elwPvZl3sUjfwru+ilhrSmO5MxxX9F1FZzyAQAJt5349fU265O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2Qv3WY5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F171F000E9;
	Wed,  8 Jul 2026 09:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783503029;
	bh=VOLjFkTtD2WeJzPh6YV7IO8zlHSCJPyGX+mnycJQSAU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=G2Qv3WY51e/EUcelScfmwcU6jqmBByjVehf8+5XpN3g9PwUwA8KLYl9ZoKsyuZ8jU
	 J/bvb9E8+jMLKe/RRZTjKbYsByknky8UNX2MdlcPbvCNNWbh1XD4i8ucUjnADo8lB0
	 56g8ufknvRkmPjVOBdVUEq5aSE3r3S1ItPaWo+ZlYKPtWKIMYtc5dDnvVcixy6BfdT
	 fQOCW6XKmDmRp5ZH8MtMfMazzN+LZT4S7zIxFc2sSgbejTRvAEpCtgWDfpl4KGEvaW
	 ntoCYHxb9/0RRkjvqYeWWodtH9dzsxJO9z1Xnty+iFS+jDoRjvPsGgK2OjUFgsmO1S
	 6DEFC+3E6TGwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93CA539263BF;
	Wed,  8 Jul 2026 09:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] devlink: extend phys_port_name controller
 prefix
 to non-external ports
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178350300814.2399537.7921578576105301581.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jul 2026 09:30:08 +0000
References: <20260702111726.816985-1-tariqt@nvidia.com>
In-Reply-To: <20260702111726.816985-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 ajayachandra@nvidia.com, cmi@nvidia.com, danielj@nvidia.com,
 jiri@resnulli.us, corbet@lwn.net, kees@kernel.org, leon@kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, mbloch@nvidia.com, moshe@nvidia.com,
 ohartoov@nvidia.com, parav@nvidia.com, saeedm@nvidia.com, shayd@nvidia.com,
 skhan@linuxfoundation.org, horms@kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22876-lists,linux-rdma=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:ajayachandra@nvidia.com,m:cmi@nvidia.com,m:danielj@nvidia.com,m:jiri@resnulli.us,m:corbet@lwn.net,m:kees@kernel.org,m:leon@kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:moshe@nvidia.com,m:ohartoov@nvidia.com,m:parav@nvidia.com,m:saeedm@nvidia.com,m:shayd@nvidia.com,m:skhan@linuxfoundation.org,m:horms@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E31CE723BFD

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 2 Jul 2026 14:17:24 +0300 you wrote:
> Hi,
> 
> This series by Moshe includes the controller number in phys_port_name
> for non-external ports with a non-zero controller, and updates the mlx5
> driver to mark satellite PFs as non-external.
> 
> The controller prefix (c) in phys_port_name was previously only included
> for ports marked as external. However, newer devices can have multiple
> controllers within the DPU itself, even within a single host
> environment. For example, a SmartNIC may have additional local PCI
> physical functions that are managed by the eswitch but are not on an
> external host. These ports use a non-zero controller number to
> distinguish them from the eswitch manager's own functions, while the
> external flag remains unset.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] devlink: print controller prefix for non-zero controller
    https://git.kernel.org/netdev/net-next/c/f6ec46b7e2b2
  - [net-next,2/2] net/mlx5: Set satellite PF devlink ports as non-external
    https://git.kernel.org/netdev/net-next/c/a49ea2e042af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



