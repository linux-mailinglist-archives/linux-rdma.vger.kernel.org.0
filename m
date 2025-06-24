Return-Path: <linux-rdma+bounces-11559-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D60AE5844
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 02:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EA054460FD
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 00:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3D933DF;
	Tue, 24 Jun 2025 00:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="An/Cht6b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDD4136E;
	Tue, 24 Jun 2025 00:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750723794; cv=none; b=KfUMdK1b5mUi0slIx+tDBUrGjip3Ev4YqSXoxdHQKCM0+aUtn3/8VCrUec7AmUHhAmT1uEEba4lOCrFLKG3Viz8vmgd/4j92lxvHa7p9RqMzXP8k7QeA8YuQIcMvHPgEkWHr35roJn5k9X1E8ofmOGZhJHdnGHIegORscLbx59k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750723794; c=relaxed/simple;
	bh=j11/ciCuhRoDr2ClyRyAZr7gXWei/2uKPJ+siviuBqM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fFJ0e6sZzN1VPIcnaw5oDpZiagELPUqSKVd7FHkGXdrzzLJ1OB9oTST6eG9M1l79sx9HCZbcJ6yvQ75PYdw3CuO2bTrsd7p62UgdqcosuGp2Qb4oXPMMv+ixCbnzYzPsxsws2npO7L90OsLGlWuE0je677WoTAlpwHDxNNs+0iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=An/Cht6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6225C4CEEA;
	Tue, 24 Jun 2025 00:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750723793;
	bh=j11/ciCuhRoDr2ClyRyAZr7gXWei/2uKPJ+siviuBqM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=An/Cht6bS1Pt763i9NNU03BuRs6LDxXt9gT8VM+wUt1KEzKXELHUs89EXh3im7JQ9
	 TygkS+UoGuMqnQN38Rns+vUyOBNlpIJGsmLyzcPUUGGgGO0R/MNspcOR1uXZng1xG6
	 M1TK+waHji8meIdA0bvPzRXbvlic9Dao9dWfbyPe9mjK+xkt+36YrT53pB+CAJh3L9
	 r7xbcJGafVGoiHc0UYWziwqU+Vz9txXCsPW5Cy5GrRlLTYSer3gs6ghU5uHrkj3c8/
	 ua8/83fCKq8vBl7GlzArBMUNOPsBeZJLZCVMjkhsBwLcrlwwFS+LI1+bazc249BIzW
	 sQ4fu36e1K/2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3FB39FEB7D;
	Tue, 24 Jun 2025 00:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net/smc: replace strncpy with strscpy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175072382074.3339593.8252198682877965206.git-patchwork-notify@kernel.org>
Date: Tue, 24 Jun 2025 00:10:20 +0000
References: <20250620102559.6365-1-pranav.tyagi03@gmail.com>
In-Reply-To: <20250620102559.6365-1-pranav.tyagi03@gmail.com>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
 horms@kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Jun 2025 15:55:59 +0530 you wrote:
> Replace the deprecated strncpy() with two-argument version of
> strscpy() as the destination is an array
> and should be NUL-terminated.
> 
> Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> ---
>  net/smc/smc_pnet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [v2] net/smc: replace strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/ae2402bf882b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



