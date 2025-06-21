Return-Path: <linux-rdma+bounces-11512-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E28AE29B0
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Jun 2025 17:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21D73189BB94
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Jun 2025 15:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37627210184;
	Sat, 21 Jun 2025 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+OtdEy9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A0121ABC1;
	Sat, 21 Jun 2025 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750517993; cv=none; b=lSqQpcXmJB7XzywKhHTKtGBbvARq8QcaSPCn8D/PBF3FvAKOlErOMw8E3JXtF87azJ2HutCzVvWVi0DWFhvcnFbtJ1faF4ULwxefgRsfpxU7z0d9pd/RqZGQ34Ivz4Wlh6FiFFk44w+FFmBIaO2AB02drwy0vWiIPmI6p1ZJfs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750517993; c=relaxed/simple;
	bh=6a8Dvp49ElImNVjI6ZNvXoOKe6JQ+cckTuZyKY3B5/o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Hzga4mt3KQeS7kCvNtdD65PdBmPOSuFCKCVI5QySI0Ey7SvvvonefYJ7A9yNvsG6MQ3jrj7zuB6vmk84DyjgHkWg08FkxQj52ZXl2Rw/2qQ51EAGK2pa8bnqDx9CKUEXdUaj6+DX9+E3+Q0sI8RFZp7KOtvtdNk15K0qjBN4awc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+OtdEy9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9B7C4CEEE;
	Sat, 21 Jun 2025 14:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750517992;
	bh=6a8Dvp49ElImNVjI6ZNvXoOKe6JQ+cckTuZyKY3B5/o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s+OtdEy9GMqWCD4LnPSnKlkcKtgecbXmNQwr2ctyVUmWMZoveFC5Gv0QQdYgr2Mge
	 LkUg/NvhO+PIAAZlJ+jrtztzPwyFU64huEsLy5G79PHMtW3VQpXseiqYDbhcJapwSX
	 RMOeCt59ghTQCoJSZDft8LZw94bsMUHi7AT6jxj3xOXO/khoFZzsTRe325s2/MYUp3
	 ewhl0e9FcEuSzOJRrgtZDEq4105RQamApCbhCHYAroHBLHwndp/9UUbom/kVpeayJE
	 WyEls/d3SSMRwnMhCZhPY+V3tyiI7K2hzxVswNsZi4/kLqrOgx91H+GT8agDqY8EzV
	 Pdenadj6XxQJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3498D38111DD;
	Sat, 21 Jun 2025 15:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] rds: Minor updates for spelling and endian
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175051801974.1877807.9744009419522667514.git-patchwork-notify@kernel.org>
Date: Sat, 21 Jun 2025 15:00:19 +0000
References: <20250619-rds-minor-v1-0-86d2ee3a98b9@kernel.org>
In-Reply-To: <20250619-rds-minor-v1-0-86d2ee3a98b9@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: allison.henderson@oracle.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Jun 2025 14:58:31 +0100 you wrote:
> Hi,
> 
> This short series addressses some cosmetic issues in rds.
> 
> 1. Some spelling errors, as flagged by spellcheck
> 2. Some endianness annotation errors, which are not bugs,
>    flagged by Sparse
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] rds: Correct endian annotation of port and addr assignments
    https://git.kernel.org/netdev/net-next/c/6e307a873d30
  - [net-next,2/2] rds: Correct spelling
    https://git.kernel.org/netdev/net-next/c/433dce0692a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



