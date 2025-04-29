Return-Path: <linux-rdma+bounces-9931-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA180AA1A63
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Apr 2025 20:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BCBF4E28BE
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Apr 2025 18:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAEA2550A2;
	Tue, 29 Apr 2025 18:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZddnE0aG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019C7254AFE;
	Tue, 29 Apr 2025 18:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745950798; cv=none; b=RhVOFYvl4FmLN4mN+QsNvkmvp4ZDAGa21hcWe3Ghh5clxUW2CplMvbHIZSW699vqQ9g1hZgdLjlB4pzHiYdQCgKcyN7Bg8Zz16AqNXuh/ULzJ1OTTuonBklZVpOLt4r3e9rnmLzoZ5tysayuB21e34WrYpjst7DVA445iSP+VA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745950798; c=relaxed/simple;
	bh=RM49TXnQw78taZu6JV+jQsXMLBvt4gq/jHR0fRKnJa4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DZgSM4hqaXVXcUw5OGCgVm500JHsd1Onc4kcJGwtVtPGT/TgcEbfdiL0sshQrvUGluQBZiy6eOyjUTFwRf64YSwstjrkX2sxP7ukrCzM+TeRyBKnGkfPfSqtJE3Zdy3OB9ODZ6K3Gv80CsiN0hXXPUY1kjrHjc6Oe88TJ6H+1bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZddnE0aG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9C6C4CEF1;
	Tue, 29 Apr 2025 18:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745950797;
	bh=RM49TXnQw78taZu6JV+jQsXMLBvt4gq/jHR0fRKnJa4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZddnE0aG19MBeG3iwNPD56/EK1LV8FbQ7jXbTaBbdQeLoRBEAutQMSQZbAavFy4Ue
	 Mjqa0cuPe6NG9NXwoX1e5yOVy7dcJlRngsxfIy5csC9VSjwKcwLoIh0gcl4WJy3CbK
	 i7ZteVL1PEBOZmga8r2uNpp1CdUH4S1bKnTu4Y8BQH3TQ5e6kp5cSFqcSt1IXfZEoc
	 wkuPrwJXLudstq0VizOp27EtMPyus7XGGA8bF8FnxndPdb+JMOO+l8mHfoLDVFywUq
	 icuQtRZgHIDthb+/UriUJyA8g8Ys3eZnZNDrb9v1JjH566P3L+uosRFhwkzpMChtOr
	 hDmhidjVMdFcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACFC3822D4C;
	Tue, 29 Apr 2025 18:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/mlx4_core: Adjust allocation type for buddy->bits
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174595083674.1759531.16211548496193467618.git-patchwork-notify@kernel.org>
Date: Tue, 29 Apr 2025 18:20:36 +0000
References: <20250426060757.work.865-kees@kernel.org>
In-Reply-To: <20250426060757.work.865-kees@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: tariqt@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Apr 2025 23:07:58 -0700 you wrote:
> In preparation for making the kmalloc family of allocators type aware,
> we need to make sure that the returned type from the allocation matches
> the type of the variable being assigned. (Before, the allocator would
> always return "void *", which can be implicitly cast to any pointer type.)
> 
> The assigned type is "unsigned long **", but the returned type will be
> "long **". These are the same size allocation (pointer size) but the
> types do not match. Adjust the allocation type to match the assignment.
> 
> [...]

Here is the summary with links:
  - net/mlx4_core: Adjust allocation type for buddy->bits
    https://git.kernel.org/netdev/net-next/c/01cbf838c775

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



