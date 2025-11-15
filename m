Return-Path: <linux-rdma+bounces-14494-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C13CC5FF22
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Nov 2025 04:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6644A420052
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Nov 2025 03:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9E0224244;
	Sat, 15 Nov 2025 03:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ttj+4t+x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6113221578;
	Sat, 15 Nov 2025 03:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763175649; cv=none; b=sYunoIQdCbobONaLx2/keAxhtVAY2hu21F3c83c05POMRRkaYmK5u4aWbGkErAo7EjuLVVumHQ6wShBh+syNyLnvuEn0gXAXXwmdzeS+0zIWSMHoAjSU/3p0sgyTLbkaienfMForPFdLgiLL0GTQH4Ne7BOiBDuoTljuJybfdwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763175649; c=relaxed/simple;
	bh=kSQV1JHX+bPeJlxX9g6ffRjwN8UhiARE11/+RwYGO0E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QSvDi1IgNLs6nbE8MYkVOdy7U+Ebs3Tx2EUdnai7lRLVRyeJWcjIm2W3l5tlrruJMjGuKO9XrYAdkDg13EcAbO+8dooNkVb+ZVAl7h1vC0NTMJoNkMIzFR91Qx9wIIjzHmNy1KfqwwcLzAsx5EjTv/ohEL977pqWm1TLgLI12ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ttj+4t+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C78C4CEF5;
	Sat, 15 Nov 2025 03:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763175648;
	bh=kSQV1JHX+bPeJlxX9g6ffRjwN8UhiARE11/+RwYGO0E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ttj+4t+xOfgxBUL4bnkXL7uq8SIx/hjt5QNIxKoZ8j6MmpJzADAf5cuceNueItJ7i
	 UGwClNOoVLTmLNk2K1fQQ3uzwP4saAVlQAPEnqfSDBSHom/8B6hnw4hXyu6j77vDzM
	 OOB2bGTrxaaYbB3zFN1sLBUT9tWtRMr7Z39KaX/gwF30Dh79o0CWMdRq/DerneXsaW
	 xTy8BE2wLO1K+LLXd8BcWm1stvssO10xC0DbuIexhy8UVPmKZaEcBG6oA45GoxURyE
	 Azu0pWDMsbiJdBdiTlACL6CC1QfGILTUgq9RNkUJ9RKBqEjQzJ03TyZzUeDH1vH/xS
	 MaK68m7327hMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB23B3A78A64;
	Sat, 15 Nov 2025 03:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [pull-request] mlx5-next updates 2025-11-13
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176317561649.1920041.13427299187169547504.git-patchwork-notify@kernel.org>
Date: Sat, 15 Nov 2025 03:00:16 +0000
References: <1763027252-1168760-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1763027252-1168760-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, saeedm@nvidia.com,
 leon@kernel.org, mbloch@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Nov 2025 11:47:32 +0200 you wrote:
> Hi,
> 
> The following pull-request contains common mlx5 updates
> for your *net-next* tree.
> Please pull and let me know of any problem.
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [pull-request] mlx5-next updates 2025-11-13
    https://git.kernel.org/netdev/net-next/c/c9dfb92de073

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



