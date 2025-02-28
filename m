Return-Path: <linux-rdma+bounces-8203-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB56CA48DF3
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2025 02:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED673A8FBB
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Feb 2025 01:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392D07081F;
	Fri, 28 Feb 2025 01:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBovp95j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E169A42A83;
	Fri, 28 Feb 2025 01:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740706122; cv=none; b=OEMrrlshu1rR2rczafyfVYpa9UnHmtinHQ/KtL7+E8kZZ2Z73i3YyheOhdxZC33OsjA+EUT/ZmaXFE+56Q57S4UWMi2MfIHQiINN3unBDya9DGr6OSi0oWRNyJG1sNiBmrtMGwf9AkbuTFJL21nuLmtnX/69yk9jBT8tsdfm56k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740706122; c=relaxed/simple;
	bh=gL+75XNK+rhXzDnrXbU1NvzPSATq1+PzZn61HvSOuOM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ev8UBlxMW77c9o/70QxhatM+CVjuXGYFhmOq+1/U8Qq9HBxIC78+3hz23Ksi4HcMaohyZRRdN+RpXo87/PrScXMCuxmpLxIMxzFYs3s/Uxheju6jp8f6tPm8znJ9cdlIfLr7ivs42CdZTzGD837Uay1PSTeUdFNjWBPy89FSBwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBovp95j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61660C4CEE7;
	Fri, 28 Feb 2025 01:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740706121;
	bh=gL+75XNK+rhXzDnrXbU1NvzPSATq1+PzZn61HvSOuOM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hBovp95jkZ/rzAyW6VMW/XovrVUBHqUgTVGgaAv/JPp05RteBpJygkZupdIrpEZp+
	 ACVlsQYIhJawcvmvvAQp4DLJmU4113gR015oUoemB0wcw8trbLwcrMELfeTMsnXfzy
	 V1/qUNYVhxk6rN0a0qijq93Qie9QEdT5dzxipQma/pFJWWGM7j9YnfKjlK4bkPTb6F
	 EdnleZuo0g6gstU7sT6235nasp2pcXcQSgpXqB5plDMJTaDBLuk82aGoIGu0EaZd37
	 1oDPefk8qZr9Vmyo+7t9A1efbKKSpX+26HidYlrkNd9pM55OPX7BzRiMj0tawAewp6
	 G6zyGpClXebqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD4B380AACB;
	Fri, 28 Feb 2025 01:29:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3][next] net/mlx5e: Avoid a hundred
 -Wflex-array-member-not-at-end warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174070615348.1621364.6459318760619423212.git-patchwork-notify@kernel.org>
Date: Fri, 28 Feb 2025 01:29:13 +0000
References: <Z76HzPW1dFTLOSSy@kspp>
In-Reply-To: <Z76HzPW1dFTLOSSy@kspp>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Feb 2025 13:47:32 +1030 you wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> So, in this particular case, we create a new `struct mlx5e_umr_wqe_hdr`
> to enclose the header part of flexible structure `struct mlx5e_umr_wqe`.
> This is, all the members except the flexible arrays `inline_mtts`,
> `inline_klms` and `inline_ksms` in the anonymous union. We then replace
> the header part with `struct mlx5e_umr_wqe_hdr hdr;` in `struct
> mlx5e_umr_wqe`, and change the type of the object currently causing
> trouble `umr_wqe` from `struct mlx5e_umr_wqe` to `struct
> mlx5e_umr_wqe_hdr` --this last bit gets rid of the flex-array-in-the-middle
> part and avoid the warnings.
> 
> [...]

Here is the summary with links:
  - [v3,next] net/mlx5e: Avoid a hundred -Wflex-array-member-not-at-end warnings
    https://git.kernel.org/netdev/net-next/c/bf08fd32cc55

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



