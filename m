Return-Path: <linux-rdma+bounces-11483-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D12AE1001
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jun 2025 01:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06C814A2AAA
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 23:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79471298274;
	Thu, 19 Jun 2025 23:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T26uVoHH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C0A2980A2;
	Thu, 19 Jun 2025 23:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750375202; cv=none; b=Az8e9ECr9aNridRpaN1NN4NQYxXz9TSfT12iSrpkr0NmQ7RA03cGlv22vw8vqaGP4zfkiFZ3XpVQDm0hEyAf5q3eFIppgG4++1NYbY7gZVw6FTzcWQQqTSENqLIkSI9nQ50XKgfsOXnyKup5kH0xDolI57qW11fNDFnTc5uLNBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750375202; c=relaxed/simple;
	bh=j6/M6lV5AgkmjUTUcqy+FGFH7p1rumsUY4miWwtlLPs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r/uQMfubWQhQfCmHpm3UhtAIiL5gLnxqZb36j+pPlv9FMykSv2YbXBK1wN99Kgs32wztmRaGIe2ZT2iIH9H6ocPt0KwDmA8MmtZr2QHAy76ddwmd3SL49cxP5pkY4GjLLCePfwI5X1t5QFiBGYYOkPa1Ziy0YSODUIcdpO/8ZtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T26uVoHH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35F6C4CEF8;
	Thu, 19 Jun 2025 23:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750375202;
	bh=j6/M6lV5AgkmjUTUcqy+FGFH7p1rumsUY4miWwtlLPs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T26uVoHHXD8fwNi39piwckyrUqyver196+QfUiG5WkoU6Grf7ri8ozUlACNwJ/0lT
	 rfctU19R1CfkaP+hP2HmfwFMP2xyT6wqU2tlOvZnHTHcpFrGGxRyReCnVa+aeqOokZ
	 ltEWPtHuiBOOeV19TjLle09GgB3whTkq+ziDZP4YKmSH5RXgEHMjJdGOYR0+Ooo1XK
	 wiFC0eX+CXHpTwkANWgUdrSmxeoeZ6FXxVxb3ysUiLyyWFsNqW0in6w7WfwLElH6KL
	 cTKckAefKJ6tvCGB59C+SKok1T/wi9alPzkK9D226L20qz2aBECf0aDr7Sdq5hD7gs
	 L85KdEhQAwIPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C7E38111DD;
	Thu, 19 Jun 2025 23:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/smc: remove unused input parameters in
 smc_buf_get_slot
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175037522974.1016629.11778548886817850645.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 23:20:29 +0000
References: <20250618103342.1423913-1-wangliang74@huawei.com>
In-Reply-To: <20250618103342.1423913-1-wangliang74@huawei.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 yuehaibing@huawei.com, zhangchangzhong@huawei.com,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Jun 2025 18:33:42 +0800 you wrote:
> The input parameter "compressed_bufsize" of smc_buf_get_slot is unused,
> remove it.
> 
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>  net/smc/smc_core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [net-next] net/smc: remove unused input parameters in smc_buf_get_slot
    https://git.kernel.org/netdev/net-next/c/c3ee72ded0d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



