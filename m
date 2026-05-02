Return-Path: <linux-rdma+bounces-19841-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EH8VAZJf9Wn7KgIAu9opvQ
	(envelope-from <linux-rdma+bounces-19841-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 02 May 2026 04:21:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC9A4B0ACC
	for <lists+linux-rdma@lfdr.de>; Sat, 02 May 2026 04:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 179893008682
	for <lists+linux-rdma@lfdr.de>; Sat,  2 May 2026 02:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0944528C2A1;
	Sat,  2 May 2026 02:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSpATaoL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4361FC7C5;
	Sat,  2 May 2026 02:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777688459; cv=none; b=GzrmNUBnu9y+o4qPLvdufDtB1NUvmTne9y0UmH9RVFZ9TaDG6lUj6Z4cQtJNpZb3IPSrtWPd4SJjfyUV+e1B2/5UX9tYyY17P8XZlzZL6pY2+oOMAT8ZMYnl8PDjqQYU5X6+Ja7zYSQvygZ5Jvpq3trLNj3N6DA6K42lGxg8XA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777688459; c=relaxed/simple;
	bh=gr2kTAxCHWFWL1S06vo4yD3YXRN4lrdENfmFJXsnmUM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kMDDj4IKgt46J9D99i1Pqzab8Bo9XtcvxAuSyqnVsiWq8mzirZDjE10VeiNh+XzxpCE3n3d0QNUjnZoNQroJ3bMhrYZU+zX/QxX7wJmYz1r/iajvGNzU2ZMsnW+/c4wNP6jW93sKjQ6vl72Z2sL80bQkfbyvqfkKKEoTWG0JlCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSpATaoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D637C2BCB4;
	Sat,  2 May 2026 02:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777688459;
	bh=gr2kTAxCHWFWL1S06vo4yD3YXRN4lrdENfmFJXsnmUM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HSpATaoL2mNXr08NBl5EU5hwSQMNaHzaO65sxN1VJE7rHNARGnq7WO7yC/k0O2zYg
	 W/ekCFIPDN7dCXzdRX3OBaOJpzPX5GYGtRR7SBxrpCAGPn/ai2naYGC9FQu0jI+2Fu
	 4Rrl6eCXxpOsxZEUKzsTvxiFZ4uNbAmkxq2tOxk1KgHrGUzHyaDcySmCoIZ0pNvwf+
	 MRXkkbolhCPeUvGquHwBICtXK5MN5+TiC10DgHATErj1nyzcqngnYNcg845SBnkx7K
	 vmGhhXlNM0zc9RCnDOiipc9Fc1Tv9whapYnx21bF8hB/jJEZBNw/MgxHYCXyXtdaP7
	 BS9/1iKv/lv/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEFC380CEF5;
	Sat,  2 May 2026 02:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V2 0/3] net/mlx5: enable sub-page allocations for
 mlx5_frag_buf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177768841230.3694990.18349750702169602745.git-patchwork-notify@kernel.org>
Date: Sat, 02 May 2026 02:20:12 +0000
References: <20260429201429.223809-1-tariqt@nvidia.com>
In-Reply-To: <20260429201429.223809-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com,
 dtatulea@nvidia.com, moshe@nvidia.com
X-Rspamd-Queue-Id: EFC9A4B0ACC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-19841-lists,linux-rdma=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Apr 2026 23:14:26 +0300 you wrote:
> Hi,
> 
> See detailed description by Nimrod below [1].
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [net-next,V2,1/3] net/mlx5: wire frag buf pools lifecycle hooks
    https://git.kernel.org/netdev/net-next/c/3796df7645e5
  - [net-next,V2,2/3] net/mlx5: add frag buf pools create/destroy paths
    https://git.kernel.org/netdev/net-next/c/3b16155425af
  - [net-next,V2,3/3] net/mlx5: use internal dma pools for frag buf alloc
    https://git.kernel.org/netdev/net-next/c/fbf6f64a4322

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



