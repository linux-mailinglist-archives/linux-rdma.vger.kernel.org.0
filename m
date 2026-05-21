Return-Path: <linux-rdma+bounces-21092-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGFRLWLiDmrACwYAu9opvQ
	(envelope-from <linux-rdma+bounces-21092-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 12:45:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A6D5A38A1
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 12:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F35D313CF03
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 10:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E194E39BFFC;
	Thu, 21 May 2026 10:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDuCWhP0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E033384CEC;
	Thu, 21 May 2026 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779358808; cv=none; b=Xete1aMWzmRGpsvevnFCkVutje51Ayd6Gd+9GuPmxZaXNZW3UuV5QbKFyxT1PNaioHhKD+scCH64yGAs/TsFkW1BgxnuP1KYg3m04lo1vL/uqO8WGH785gRiKQCKk/xvz8O3iU7lrG2kOxoNxfnU7gBsvXFVMtlH7g58adobZjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779358808; c=relaxed/simple;
	bh=rEMZZhwAXoCug5lgIMCDd+Z0Nkvy4ekijw8jmTYbLVw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kn7X1kHOJvc0K/bqCPTtdltl8IvRIN+bIMTW4fc++4/75RK/2pGoyfXF0xhOPIxlKDvO2E5juxFUGjGS3h/igOE8ou2camDBzjcQyvTi5t+RxkH4T3zwtN/95LZcyX7g0Dcb2W4rfqrI7FKSOyTx80SRgGbBphUtLrl3w2ywc2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDuCWhP0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B6F1F000E9;
	Thu, 21 May 2026 10:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779358807;
	bh=lHF1duPnZnQu1Yy1kRBvTgpJD653i4LN75OI6zxDh1U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kDuCWhP062yDIkP4/R6EOdm7l0k6wD8bFHqRnEiRvQB17Qh4zHLX9eBQoLCaPZQAP
	 Ih7g7qRKbnJF7CZ8y/EQZ7rm/15VMggIB0kdQVK3uirjAY3f8VzCK0ZyQqeofjWLQj
	 2j26GZFVXXRx/qwkLZS8Ik/i9uL9JfKivEJf8um5sbeejIrOBiddtGQTgp1yzpQsgU
	 ++PONmtKgYNmcy98l8TPBR0p4vqMJKtb2BGpLzMq9J576eJYpicCJ98jsVbFlJY0SA
	 +gwNRGF3PZO4ciOHeHX+Fr4X5/XNKHB8b8hCjSMpqOtLflWTXZlQsu5Y84qp3jOUSs
	 kGzW8oiDpK+pQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56CB43930D21;
	Thu, 21 May 2026 10:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V2 0/8] net/mlx5: Prepare eswitch infrastructure
 for
 satellite PF support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177935881714.4017526.3447478285704976767.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 10:20:17 +0000
References: <20260518071356.345723-1-tariqt@nvidia.com>
In-Reply-To: <20260518071356.345723-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, moshe@nvidia.com, agoldberger@nvidia.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, gal@nvidia.com, dtatulea@nvidia.com,
 horms@kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21092-lists,linux-rdma=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 66A6D5A38A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 18 May 2026 10:13:48 +0300 you wrote:
> Hi,
> 
> See detailed description by Moshe below.
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [net-next,V2,1/8] net/mlx5: Use helper to parse host PF info
    https://git.kernel.org/netdev/net-next/c/920fdc4d21e3
  - [net-next,V2,2/8] net/mlx5: Use v1 response layout for query_esw_functions
    https://git.kernel.org/netdev/net-next/c/a4f75c4238b0
  - [net-next,V2,3/8] net/mlx5: Use mlx5_eswitch_is_vf_vport() for IPsec VF checks
    https://git.kernel.org/netdev/net-next/c/3fefa7e7c14b
  - [net-next,V2,4/8] net/mlx5: Switch vport HCA cap helpers to kvzalloc
    https://git.kernel.org/netdev/net-next/c/62af408fd772
  - [net-next,V2,5/8] net/mlx5: Add mlx5_vport_set_other_func_general_cap macro
    https://git.kernel.org/netdev/net-next/c/9244a323125c
  - [net-next,V2,6/8] net/mlx5: Refactor mlx5_set_msix_vec_count() SET_HCA_CAP
    https://git.kernel.org/netdev/net-next/c/fa2852a28c5b
  - [net-next,V2,7/8] net/mlx5: Use vport helper for IPsec eswitch set caps
    https://git.kernel.org/netdev/net-next/c/d7ec361003fa
  - [net-next,V2,8/8] net/mlx5: Generalize enable/disable HCA for any PF vport
    https://git.kernel.org/netdev/net-next/c/4a3b5efee2e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



