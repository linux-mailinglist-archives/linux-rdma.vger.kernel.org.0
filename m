Return-Path: <linux-rdma+bounces-18937-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFTsF4XgzWlVigYAu9opvQ
	(envelope-from <linux-rdma+bounces-18937-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 05:20:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9FF3830EC
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Apr 2026 05:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 742873019C8F
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Apr 2026 03:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F41735A939;
	Thu,  2 Apr 2026 03:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GT5LUtEo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22862FE582;
	Thu,  2 Apr 2026 03:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775100032; cv=none; b=hGBGlz5AaA1wwiqGsGcaJeaEk7qlu+twGMegfmWrxfDf0cTowj5rS14b6RCpr2tnzqZ5ztebiFv0VPu/l0MRooObcjrxo3lP/xluPRkb9UDG6fJ8mUX7CkpNlXaKMuCn29n9iF+f7hpiYiV7nHavyOR9Sqdyrq1lPTxQaicrN5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775100032; c=relaxed/simple;
	bh=/icDXEXCSsMGYbLs4382CgPGNWLTHVFACiJ43AFQtM4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NVzoWOeZrFIvBnuSlBntmsvGEf+qHtavhRFKgoyKM5Q6RyeOhTMX1AcKvQuQ/6aVM/jgfr4hR4Aw2MBGmCYdf9oRfORWsVlHvx4tWPOkrwE8KwQGZ7xJfCFMGbYKdN1Cv6Bc2twHrdJ0FyC4lZWH7OyHEJeotIzG6ayXTbJ9sS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GT5LUtEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FED0C4CEF7;
	Thu,  2 Apr 2026 03:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775100032;
	bh=/icDXEXCSsMGYbLs4382CgPGNWLTHVFACiJ43AFQtM4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GT5LUtEofM8skT+uB4N7lmN/xdrKUsUmIbMD2q7zsLbcdUnPN0VvSzt3irWXimAtV
	 wixe0BuOgWKrl5ZNmG988XJM+3prmXeFghmGzPuW9LdQ9K1ybTL142HlWDoUhvKehW
	 IeOrL8lu3n2h01ukXycW13+xSs9DBzqDJkPxtDyvOWudrJrXjrzJfs1UkNOurHs5PO
	 O7urqjE2xv8zHajg/niDyd4P6xE809pspDg1IBqUfZRJ6XqQPC4IQKtkfnDoFfcTVs
	 HN3fTQAuA3aFpaHlafwe2wQqKikWw6qnGLYCF1K5wWYpAp4Zv/aeFKSQMHmR5NGaK+
	 M9zsnhV1XcJTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDE43808203;
	Thu,  2 Apr 2026 03:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] mlx5 misc fixes 2026-03-30
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177510001504.3972881.18083419303971331351.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 03:20:15 +0000
References: <20260330194015.53585-1-tariqt@nvidia.com>
In-Reply-To: <20260330194015.53585-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, shayd@nvidia.com, shayag@mellanox.com,
 saeedm@mellanox.com, jianbol@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, gal@nvidia.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-rdma@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-18937-lists,linux-rdma=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CB9FF3830EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Mar 2026 22:40:12 +0300 you wrote:
> Hi,
> 
> This patchset provides misc bug fixes from the team to the mlx5
> core driver.
> 
> Thanks,
> Tariq.
> 
> [...]

Here is the summary with links:
  - [net,1/3] net/mlx5: lag: Check for LAG device before creating debugfs
    https://git.kernel.org/netdev/net/c/bf16bca66536
  - [net,2/3] net/mlx5: Avoid "No data available" when FW version queries fail
    https://git.kernel.org/netdev/net/c/10dc35f6a443
  - [net,3/3] net/mlx5: Fix switchdev mode rollback in case of failure
    https://git.kernel.org/netdev/net/c/403186400a1a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



