Return-Path: <linux-rdma+bounces-1483-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0C887FCCE
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Mar 2024 12:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5A4F1C225DB
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Mar 2024 11:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8E47EEF6;
	Tue, 19 Mar 2024 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnFN57yh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BC17BAFB;
	Tue, 19 Mar 2024 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710847828; cv=none; b=pYefHA5ld9oN3y/Yh401KvORFv/R+fKNyiFqSNRGNvrbvr4xME83pp1qtNlVW91PkT9nFYRPCxwiWGwyUniGywoKNukIgz8Ai9VYiH59PTpoOBNOgijBFu7zqMhFG9K0UwU6WETW8SN55PCoYMA9tgf3GhcfTAHfLIPVU8hdTNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710847828; c=relaxed/simple;
	bh=dnqTXQz32jKrSI6GbKSQRO/rglIIbJZjU6uIXfVIv24=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tGbSoeOvgQkZF8saShZaHIeL/cdyVu1bTu52BgLDQhdIGjgaH3n0qmQ/ZvkXzY8hEPbN3oTuventPSRdjG+9yR8GO8J/ItZXENdqCPZw4IjPGIt9VkGXAIJuDG9uj+dE3gL/8UCsNrJ5+d9OkXPxnFq3l3OBuOeQqdTm3LlrGSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnFN57yh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA443C433C7;
	Tue, 19 Mar 2024 11:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710847827;
	bh=dnqTXQz32jKrSI6GbKSQRO/rglIIbJZjU6uIXfVIv24=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EnFN57yh7tts4vSMWeMyQaIuUk2IdRewsVKIed1jARE7ms6p+gTfC3sCwnHciq2Aj
	 Y0MUqZ0U3awUDn5MPEiLPFff/rVnFnDnAtlNDBvL9U6UxNf7vQ3E37cI2LtX8fnv7i
	 wGcY2v/rRbMp9kDLTq8m0AprJAD8BhuXhR0TUJ3prf+0a9ujJR55ktGnZz1f5/5UVw
	 MZNV7TV4q0JIS8BoNO3tA1uTIhmSfejvDVIjsg+/eAu6K7Tnhn28L1LjapV/xFGp4y
	 RLMQ8a+8rDUl+F6gBRlP20i048uAaQj0t5UzThxe5LoQwJ0x+kQ/Uz3gaT9BEGGIfK
	 +vXI4crY71u9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C653DD982E0;
	Tue, 19 Mar 2024 11:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] rds: introduce acquire/release ordering in
 acquire/release_in_xmit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171084782780.9693.3451064874189878588.git-patchwork-notify@kernel.org>
Date: Tue, 19 Mar 2024 11:30:27 +0000
References: <ZfQUxnNTO9AJmzwc@libra05>
In-Reply-To: <ZfQUxnNTO9AJmzwc@libra05>
To: Yewon Choi <woni9911@gmail.com>
Cc: allison.henderson@oracle.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-kernel@vger.kernel.org, threeearcat@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 15 Mar 2024 18:28:38 +0900 you wrote:
> acquire/release_in_xmit() work as bit lock in rds_send_xmit(), so they
> are expected to ensure acquire/release memory ordering semantics.
> However, test_and_set_bit/clear_bit() don't imply such semantics, on
> top of this, following smp_mb__after_atomic() does not guarantee release
> ordering (memory barrier actually should be placed before clear_bit()).
> 
> Instead, we use clear_bit_unlock/test_and_set_bit_lock() here.
> 
> [...]

Here is the summary with links:
  - [net,v2] rds: introduce acquire/release ordering in acquire/release_in_xmit()
    https://git.kernel.org/netdev/net/c/1422f28826d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



