Return-Path: <linux-rdma+bounces-13077-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30768B42E39
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 02:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E32E93AA6C2
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 00:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523071A238C;
	Thu,  4 Sep 2025 00:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVlw2gtw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88C619E96D;
	Thu,  4 Sep 2025 00:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756945805; cv=none; b=UetU4srgHtBvtU+f9cN10dz65OqolKIJd7QneihaD2qUEoI8vgsKtczXM9lnvhiSXL95j4OofPRehdSc7MB0Iut4EDHkC660bRlEzXGmMlKgrmO0svIT3MRc1lvsiq1S0K4GXik5TphouZSw3M3RTE2JqX/qiHLQjY0RT6kLEfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756945805; c=relaxed/simple;
	bh=Jt5BxfC9AdoWo/tt/7PhWNgM5pWcgyLzZAXgTg7XXQU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f60Kogib+FxcHPjkYdbYE+nvv6j3b+mR+3vRzEI0ICHxSaXCLn5+VhsJlc4XaQKVMMfuDab9hM3KdmUY18E+a/bEF+nDCgACv7N+HS3vlMqorbM2EzKIn2cgCpvXa5hVjQlu/K21ZEEuRonsC8OcDh+bicWz/Yf88gFvF93yQHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVlw2gtw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F60C4CEF0;
	Thu,  4 Sep 2025 00:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756945804;
	bh=Jt5BxfC9AdoWo/tt/7PhWNgM5pWcgyLzZAXgTg7XXQU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gVlw2gtwtW3PwssdbN7fqxSD10Y5lnGosw5+wdGY7Vaqo4MYyd75i77058M5fQWb8
	 uN/VUYMFN86Mt/bcuvyNz/rs2Dgtofl7/N04dvchi+lReZFxlm+no9P8EVoh7ruqOM
	 oTCLYiN52XJ682FP2JyzLEI/r5gvjMs+jJTCCHP8n5mxnPZyJIxrqpGmYEhwR/ke2n
	 rSjgPclqGkJhy54Irm8Kq3JtwRUcNYK6A64jE3UhfEHck4Z7lBq/u8WWuRRS3lIZmt
	 o4guFTV78rUimaWkgJ6L29A2b/twhK/UJFh1yOR859Su5PHISvz5f/U6IE2vD59lSf
	 1sq95piXUrWGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDF5383C259;
	Thu,  4 Sep 2025 00:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/smc: Remove validation of reserved bits in CLC
 Decline message
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175694580949.1248581.9851608945779739639.git-patchwork-notify@kernel.org>
Date: Thu, 04 Sep 2025 00:30:09 +0000
References: <20250902082041.98996-1-mjambigi@linux.ibm.com>
In-Reply-To: <20250902082041.98996-1-mjambigi@linux.ibm.com>
To: Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, alibuda@linux.alibaba.com,
 dust.li@linux.alibaba.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com,
 pasic@linux.ibm.com, horms@kernel.org, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, wintera@linux.ibm.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Sep 2025 10:20:41 +0200 you wrote:
> Currently SMC code is validating the reserved bits while parsing the incoming
> CLC decline message & when this validation fails, its treated as a protocol
> error. As a result, the SMC connection is terminated instead of falling back to
> TCP. As per RFC7609[1] specs we shouldn't be validating the reserved bits that
> is part of CLC message. This patch fixes this issue.
> 
> CLC Decline message format can viewed here[2].
> 
> [...]

Here is the summary with links:
  - [net,v2] net/smc: Remove validation of reserved bits in CLC Decline message
    https://git.kernel.org/netdev/net/c/cc282f73bc0c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



