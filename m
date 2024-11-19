Return-Path: <linux-rdma+bounces-6035-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140719D1F16
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2024 05:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB432280E9B
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2024 04:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B691199EAF;
	Tue, 19 Nov 2024 04:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmuWthTQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E8C14D2A2;
	Tue, 19 Nov 2024 04:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731988838; cv=none; b=p/SUPD9PdvkOH0hsW55zIcaYml6Z2XSrmlDISlPlpc6yTBPLMGXPrZw2tOM95Lb1DO6c7ERoBa+UkmzWlLXNxB/OKxqU69pbQS8RamFs+fOkAAzs/ush+fAQEerXG+WpqiRxTqSftvz5892HsJA3lq1RAHen3LlGfQj46Ufj4Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731988838; c=relaxed/simple;
	bh=CHJFJC1Ym8NOwi/BVEDKveea7wPnXbCgSgufrNMkOa8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JsGpeolyvd5DTT5u21fhBbezKbvHbViq6JDsUyCfyfcYo0y+ELDxV1ska6oNpjTxKv1gvdV+2Ti7RXvngic/ZYApB3Yd5RXoQXg2ZorECKJWmOboCjOogGexNVpfZXih3Pmb6jICTli/foOSTK4xn3HS/0G1kHexOR3Tew7tQL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmuWthTQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3798C4FDE2;
	Tue, 19 Nov 2024 04:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731988837;
	bh=CHJFJC1Ym8NOwi/BVEDKveea7wPnXbCgSgufrNMkOa8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BmuWthTQYRJlj9DhFLhki7dy6ZI+cTbMIR/WfEbwfgGS4ZFfogF4O3VSdoJAYnWQZ
	 LFF+9S2MhbSpPNIVFk8ggf1BZt3vG4jKbMfShmF9I8WnKC/pu0z0aoDKGX5k+Ko24u
	 kf/3ZSia+o9l8v2PtBTdh9LyN8RxzeJcLmZQIHKvbig53dWb+2WfKxNdvy4LGqe5PG
	 fnulH4tidakQLsPWby/qYNBHLJ7TIzQp6tcoUJBoqMBgSlg0cfVRXQJLRWzloM6hrc
	 JT5i+SIr1mCPyqTUhH7NBpxAOYDY2jQj46l4/IkHp24O9Tt0MciX0L2+1LkSrhlypY
	 W2YBGcJNVlDNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 714613809A80;
	Tue, 19 Nov 2024 04:00:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/smc: Run patches also by RDMA ML
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173198884899.97799.17903430632973334489.git-patchwork-notify@kernel.org>
Date: Tue, 19 Nov 2024 04:00:48 +0000
References: <20241115-smc_lists-v1-1-a0a438125f13@linux.ibm.com>
In-Reply-To: <20241115-smc_lists-v1-1-a0a438125f13@linux.ibm.com>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, leon@kernel.org,
 pasic@linux.ibm.com, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux390-list@tuxmaker.boeblingen.de.ibm.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 15 Nov 2024 18:44:57 +0100 you wrote:
> Commits for the SMC protocol usually get carried through the netdev
> mailing list. Some portions use InfiniBand verbs that are discussed on
> the RDMA mailing list. So run patches by that list too to increase the
> likelihood that all interested parties can see them.
> 
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net/smc: Run patches also by RDMA ML
    https://git.kernel.org/netdev/net-next/c/16a04d043baa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



