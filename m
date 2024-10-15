Return-Path: <linux-rdma+bounces-5405-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2368799DB22
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Oct 2024 03:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABDC11F22DC2
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Oct 2024 01:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7935713D53D;
	Tue, 15 Oct 2024 01:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lgx7Ucg6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300CE3BBF6;
	Tue, 15 Oct 2024 01:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728954626; cv=none; b=f8woOOtpGZLMnUdWD8zJKeaKMl6LWS6R18NvgjiBPiMoy7hpaHyJZwXZlwAyvKgZ4mdDfWkrsnSKi6W1IWb9Y9xrl3rD3z+FcNr9jJ+u0uNkpnin6cbAtV7SWJ/rpc3HPYyL5Az6uAx5FlP7opoJMybzKGNCTISSHx1IhUgZsOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728954626; c=relaxed/simple;
	bh=f3dwvBKGvFEEsvPqhMyxQVtJUS+PjOGaid6s3BccY34=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VSB6AK1fi+gA3ui4DPjlnpvP3n4MkjATPJ48nVTXZ8p82kqPvlxY0Dyhij6cztwOJKlpCr1sb2RaVJGp8OKnghXQbda8yXtTSPovBwFXnq1dfmJQzwitX494Casi00iFh/3mWFqzHLsPrcwgZm8Rl/lcP2F14vMgXDYOqkk10sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lgx7Ucg6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC2BC4CEC3;
	Tue, 15 Oct 2024 01:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728954625;
	bh=f3dwvBKGvFEEsvPqhMyxQVtJUS+PjOGaid6s3BccY34=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Lgx7Ucg6IXiOkkX6z+B0c/ENuAdJmSLPCfhOYgH6jVCsWB7Hu+lvDOjTOMRVWQhr0
	 2Vte+ijHtTG/uniE6F696TmwwFMhTHW4C3qwqGgZ8G3txf/+aJG/R9tr/d9Vl2RTc9
	 En9SKRbPGXw6E4seCxwdRtUZkAy9Fx3mS4pBACktwZactcSttL1WJvlf28en0CsR5c
	 vo/2XXm6yqEd2X56NuC3pNlSkmgkhbxnr87fFF/nS9mTdtf9kfLqGSIDSvK8/jwqHp
	 +retpcAbv6nN6RQ8fteagfT5XqRRPtRNL1wNFdEAcBdd1hOolxso4ZabLzokVkyZnS
	 zjXH17o4gXjZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEFB3822E4C;
	Tue, 15 Oct 2024 01:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/smc: Fix memory leak when using percpu refs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172895463077.686374.5703280844710549815.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 01:10:30 +0000
References: <20241010115624.7769-1-KaiShen@linux.alibaba.com>
In-Reply-To: <20241010115624.7769-1-KaiShen@linux.alibaba.com>
To: Kai Shen <KaiShen@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 guwen@linux.alibaba.com, kuba@kernel.org, davem@davemloft.net,
 tonylu@linux.alibaba.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Oct 2024 11:56:24 +0000 you wrote:
> This patch adds missing percpu_ref_exit when releasing percpu refs.
> When releasing percpu refs, percpu_ref_exit should be called.
> Otherwise, memory leak happens.
> 
> Fixes: 79a22238b4f2 ("net/smc: Use percpu ref for wr tx reference")
> Signed-off-by: Kai Shen <KaiShen@linux.alibaba.com>
> 
> [...]

Here is the summary with links:
  - [net] net/smc: Fix memory leak when using percpu refs
    https://git.kernel.org/netdev/net/c/25c12b459db8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



