Return-Path: <linux-rdma+bounces-6968-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4344A0A621
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jan 2025 22:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D510B1685F5
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jan 2025 21:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B289B1BC9F0;
	Sat, 11 Jan 2025 21:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpU+vRQH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581671BBBD7;
	Sat, 11 Jan 2025 21:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736630411; cv=none; b=Wa+1eYM38U7s1SncmVxCTKhavKtrOQCTxhKLtA7ntVT3eHvrHgr1EQjIIEsJ8ss0LrrVNZ9iJTw3nsrxtVh/G+IDH1JhzJRuS5JBMPRnaGdMbfaDlN4mzP6Ikx0sdpf2Al7VDCj8mQZsWbHQYOBoudjXwe7fQJObkv5FO1AcVns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736630411; c=relaxed/simple;
	bh=xRnRLoBesJG/EZ9jRC0T4oavXLsrIkvaL4M32cLMxDU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b3q+XxbxlK+4I6VzWLEH8RxuYgJ/W5fIVBM/NDE3+YS0OjN6bWASSHPrMhekxIOYOw1gOvBq58uNTy2gn/DHEuMScQaIU+dZQ24bkbkL3H7UMcd7Ju1yumvaTQmU+v0BPZVtT3S5I78AajaS3hTvtCAHmjRGfAG2Z/DOgijuMxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpU+vRQH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C41C4CEDF;
	Sat, 11 Jan 2025 21:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736630410;
	bh=xRnRLoBesJG/EZ9jRC0T4oavXLsrIkvaL4M32cLMxDU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dpU+vRQHaIVbANeRBu1UAL5ukcD+7okkV+cpnJwXbooQAqwY2kaJ0M0CYeDManon8
	 i87kEeEmpbTmRDIrO35E6YzF5FxJS4W4Tq83kuo4iOVlJhuDOFsTndIYktstAf9oXe
	 xEVA8mOr5K2imVXp20TE1BMvpOKpJiJTYe0LeQVA6d9iAR2Wf7t1CSDpGIweqv0kJ6
	 9eAeC1lsQUdaMe+oj0a+msJNf/61ShMUmFrBnXlTG6dYXQudc9vaIOF1kzkf4ZDfh3
	 UfuHlbqAdSDp1BYVglHFCvpqCyJImAiGqIIGzMkL1OUzAe37Yoe0Uw7KYgGkErHEsE
	 8+RgKSaAoX7ew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FDE380AA54;
	Sat, 11 Jan 2025 21:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/smc: delete pointless divide by one
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173663043299.2451513.4391354145760496406.git-patchwork-notify@kernel.org>
Date: Sat, 11 Jan 2025 21:20:32 +0000
References: <ee1a790b-f874-4512-b3ae-9c45f99dc640@stanley.mountain>
In-Reply-To: <ee1a790b-f874-4512-b3ae-9c45f99dc640@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 8 Jan 2025 12:26:06 +0300 you wrote:
> Here "buf" is a void pointer so sizeof(*buf) is one.  Doing a divide
> by one makes the code less readable.  Delete it.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  net/smc/smc_core.c | 2 +-
>  net/smc/smc_rx.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] net/smc: delete pointless divide by one
    https://git.kernel.org/netdev/net-next/c/10bc9761d12e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



