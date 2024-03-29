Return-Path: <linux-rdma+bounces-1686-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A82C98924BD
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 21:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632F5285368
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 20:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8867A13B584;
	Fri, 29 Mar 2024 20:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibdChtO/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1920A131E59;
	Fri, 29 Mar 2024 20:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711742437; cv=none; b=U+/SbMjZXFFV5DmCRmBAAN7gMYg3DReVOIIFVGEM1/cPwThxnzy9A03wNDMZOl2vR/DoXWfFAdUBgB23VhlT62a39SDnxtql4Y26Z8m+28xFqzSUgkFDLruM3/R0yMGgzHhPoE2hvwd96fiOjGyCXt+1v9kNkndBXOn8oEd2nZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711742437; c=relaxed/simple;
	bh=O10HO98LXxHRjwwegetD1LC2QarBz8wOkuidkGTxkic=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PnBmFAmNiNutZAk0OAiRfOfj4Z2HD6NoW97nrh2+lO5n6JMkXzTn3Ihn7SnnGPbDb9SMGZsG4adEqxuLnV30VfuxMDc4fgkYIMiyQCOsPWJT8o7iIwlxXVMZY4IqORrEwr2MotYud95+XXa7IkqNz6Nheiojtzqm8ru8lXqtTjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibdChtO/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88958C43399;
	Fri, 29 Mar 2024 20:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711742436;
	bh=O10HO98LXxHRjwwegetD1LC2QarBz8wOkuidkGTxkic=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ibdChtO/bXootBctSxklNeA7bYCBts1UgwUFhft4x2sjMGXGiyQ6xGf96V2e0eOA1
	 ODq9Ia/6579epCaP4lnUDfDLkut5fsOWeaFbJF7me6TstZSBLf3BMrkYDf55Adi731
	 zHrMkkINKMdPiMUb6gLSoTWBG++DiMupsV5KEmKMPytdOQEZ4kBSph0dMZLkdeLFkK
	 EbluA1me7aURKnJpRkImBfuddbCDZ41vUC7YUj2cCjTbvsHIIgprJTvRvr6boPp1Ff
	 UJoxCMbUZIsBcLic6mF8suqylfUb00h7TTGot8oyp8sxfTR9PMGMw0bRiDFpkQ8O6Y
	 waG7vYyhosOoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B142D84BAF;
	Fri, 29 Mar 2024 20:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/9] address remaining
 -Wtautological-constant-out-of-range-compare
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171174243650.4906.1760676317968487901.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 20:00:36 +0000
References: <20240328143051.1069575-1-arnd@kernel.org>
In-Reply-To: <20240328143051.1069575-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, idryomov@gmail.com,
 dongsheng.yang@easystack.cn, axboe@kernel.dk, jgg@ziepe.ca, leon@kernel.org,
 agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
 dm-devel@lists.linux.dev, saeedm@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, xiubli@redhat.com,
 jlayton@kernel.org, konishi.ryusuke@gmail.com, dvyukov@google.com,
 andreyknvl@gmail.com, dsahern@kernel.org, masahiroy@kernel.org,
 nathan@kernel.org, nicolas@fjasle.eu, ndesaulniers@google.com,
 morbo@google.com, justinstitt@google.com, keescook@chromium.org,
 gustavoars@kernel.org, tariqt@nvidia.com, ceph-devel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, linux-nilfs@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-kbuild@vger.kernel.org,
 llvm@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 Mar 2024 15:30:38 +0100 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The warning option was introduced a few years ago but left disabled
> by default. All of the actual bugs that this has found have been
> fixed in the meantime, and this series should address the remaining
> false-positives, as tested on arm/arm64/x86 randconfigs as well as
> allmodconfig builds for all architectures supported by clang.
> 
> [...]

Here is the summary with links:
  - [2/9] libceph: avoid clang out-of-range warning
    (no matching commit)
  - [5/9] ipv4: tcp_output: avoid warning about NET_ADD_STATS
    (no matching commit)
  - [8/9] mlx5: stop warning for 64KB pages
    https://git.kernel.org/netdev/net-next/c/a5535e533694

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



