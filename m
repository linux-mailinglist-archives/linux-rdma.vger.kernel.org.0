Return-Path: <linux-rdma+bounces-3089-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E7D906049
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 03:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8074E283959
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 01:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F684B647;
	Thu, 13 Jun 2024 01:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8wmudT/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459208C1D;
	Thu, 13 Jun 2024 01:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718241031; cv=none; b=HTnnJi5MeUbJB8fEObP8ZFIGos7mNzeCdrn/syJ6tkCjOzdA/o5gN9dTL6kZOIiIKOj2ZvZ/guvO9Tq6n3MUkZFzONAbyVPXeGukwlLVFmeOsqdMNT+h7APhcKxQE5MowEp/Rqw9eK2LmN0V63RPYs9L+GOK5I+KyrZA2wCJwTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718241031; c=relaxed/simple;
	bh=c0lZUPwRpq5mEKJuM9qgYgJrToeU1Q+bgLPAqjtxcfE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sCdrohVY0BfqsSXfZFtZZH/sojew0jCVJzNc6PMpiDHyfersfwLuFtie+FKoVhyCBZcawEk2IXAEUVl/G1WDh3b0MK6hy78qOfBl1awQ08WvykAcITyjDAKi3jZ/6ltEz7fbBESy5d65Rox7A1YBGd1/PmWUkl6aFuD/0Yce7+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8wmudT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0124CC3277B;
	Thu, 13 Jun 2024 01:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718241031;
	bh=c0lZUPwRpq5mEKJuM9qgYgJrToeU1Q+bgLPAqjtxcfE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F8wmudT/Tp5E7U+PbUtnv+Ijz5V2i5VX7aQ4f8oOpDJ7LYw80lmChazTNBC2JiAxs
	 ChkOc2hiozk5O4rUHpXNn4Kb7u4selmkawUHKYrEiVrIuN6UqbfI8TOLNtKKAkMBAu
	 ouGBYre+IYT5pjllBE7muFH10Us122oWCMm3aAiPuuwLLVbQwfrK0IuXkjpl/mnuO1
	 p8ZyJEzXo/W/a+YiSNwotoXvhrIyxb0ZaS8eTey6vWIAM9ZvD6teGtzm68sJDKqdoa
	 hQm+YxrmlyP0ugd06ax3KeCNz+iXETT+SQApE57ucxbQpuIhIxptpkLcTRO1VH3nSv
	 msOyyIcJd5b0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DCA08C43613;
	Thu, 13 Jun 2024 01:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] net: flower: validate encapsulation control
 flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171824103090.1775.1813584315398438736.git-patchwork-notify@kernel.org>
Date: Thu, 13 Jun 2024 01:10:30 +0000
References: <20240609173358.193178-1-ast@fiberby.net>
In-Reply-To: <20240609173358.193178-1-ast@fiberby.net>
To: =?utf-8?b?QXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+?=@codeaurora.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ecree.xilinx@gmail.com,
 habetsm.xilinx@gmail.com, linux-net-drivers@amd.com, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, linux-rdma@vger.kernel.org,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org, louis.peens@corigine.com,
 oss-drivers@corigine.com, linux-kernel@vger.kernel.org, dcaratti@redhat.com,
 i.maximets@ovn.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  9 Jun 2024 17:33:50 +0000 you wrote:
> Now that all drivers properly rejects unsupported flower control flags
> used with FLOW_DISSECTOR_KEY_CONTROL, then time has come to add similar
> checks to the drivers supporting FLOW_DISSECTOR_KEY_ENC_CONTROL.
> 
> There are currently just 4 drivers supporting this key, and
> 3 of those currently doesn't validate encapsulated control flags.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] flow_offload: add encapsulation control flag helpers
    https://git.kernel.org/netdev/net-next/c/b48a1540b73a
  - [net-next,2/5] sfc: use flow_rule_is_supp_enc_control_flags()
    https://git.kernel.org/netdev/net-next/c/2ede54f8786f
  - [net-next,3/5] net/mlx5e: flower: validate encapsulation control flags
    https://git.kernel.org/netdev/net-next/c/28d19ec91755
  - [net-next,4/5] nfp: flower: validate encapsulation control flags
    https://git.kernel.org/netdev/net-next/c/34cdd9847820
  - [net-next,5/5] ice: flower: validate encapsulation control flags
    https://git.kernel.org/netdev/net-next/c/5a1b015d521d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



