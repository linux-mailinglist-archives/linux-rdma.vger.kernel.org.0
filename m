Return-Path: <linux-rdma+bounces-4170-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7926945032
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 18:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D7D281B4B
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 16:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C97A1B3F09;
	Thu,  1 Aug 2024 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlDrhQqq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2536213C3D5;
	Thu,  1 Aug 2024 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528634; cv=none; b=tR7KC5N9+loR4f3JzxS2tsqPdfe9o7Zs/4J3nHsGlLK0Y14BaudH2ECsNzGkN0hdflnumMqsJBDwiZWRb+E0rZIvZRJYXhwa3/jnV6RM335oIl5ENntnYUiL/OC6tD99YftO4k+qzS+3c6UAdieW9XkiSIYffvC2yxaRU6KixGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528634; c=relaxed/simple;
	bh=LQhUqFrwh8HIxQ9lXjnQQAlt76m7witeGbVDCLVWIOU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VaWeTKaZo+gru4BkDSBtP+PjnGWdB26+jvTgQhflm8gYoSIj4hcU6TpaOTsxHnyHZESxKyY1XonNVxtYw0abUCyU4+zm94YJaziUk+NEmejRzebJnv5ghEso6AM+t+2jj1CUy03SrgbYHSx6u4w5Rf9Pj5bW5cEaFQAK6cH9MYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlDrhQqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3704C4AF0F;
	Thu,  1 Aug 2024 16:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722528633;
	bh=LQhUqFrwh8HIxQ9lXjnQQAlt76m7witeGbVDCLVWIOU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DlDrhQqqGVRmW9nMfOrDzOhP0AgrS4VAaXxNr7E+msK5d8QLF0ZayutAbiszaS+E1
	 Hl8QG6o/0SmPhLhz6CMccAD8SdMMlsb/ExiMY7BUhHLxQPBjxkzTcK7aapjTazUMWM
	 M5ZW7yoFtJJmZ/4NRXIcR/e6SlvCkmQDH+rsTKJX8nUFwyjgHJMcujL+sqTk5OBLDl
	 ri2kunsSZovjD7O7IZvHX0DayAdaOel12HhzbidsOMAXa8crp8gTzSlYr9p0VQPws3
	 +cK+yiqT5iecludHqS22n06FwGFLPu/DYtxGKZtgZ5SvAFTREnZSlGUEzdY5UDkYqv
	 0gLbLQDHVxNCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B29E2E8877A;
	Thu,  1 Aug 2024 16:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] RDS: IB: Remove unused declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172252863372.25785.1423371386220625221.git-patchwork-notify@kernel.org>
Date: Thu, 01 Aug 2024 16:10:33 +0000
References: <20240731063630.3592046-1-yuehaibing@huawei.com>
In-Reply-To: <20240731063630.3592046-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: allison.henderson@oracle.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 31 Jul 2024 14:36:30 +0800 you wrote:
> Commit f4f943c958a2 ("RDS: IB: ack more receive completions to improve performance")
> removed rds_ib_recv_tasklet_fn() implementation but not the declaration.
> And commit ec16227e1414 ("RDS/IB: Infiniband transport") declared but never implemented
> other functions.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] RDS: IB: Remove unused declarations
    https://git.kernel.org/netdev/net-next/c/f9c141fc3339

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



