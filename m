Return-Path: <linux-rdma+bounces-3813-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8480492E3E3
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 11:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B66C01C20ABF
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 09:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5273D156F33;
	Thu, 11 Jul 2024 09:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DeFvvSd0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135134206C
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2024 09:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720691788; cv=none; b=XJAfkWfk/0j5s72NOKTFF0H4tWDBpXc9Tgmv98I3k3KtY6owyTYpXrOeuwQHVSkl1wPO2deN6gAzS4GdXGwvuseJyXex+9CwcJLNI+x0sdNypRoBJ+iv7yZgNYT9Rl8vwQMV0aw1/dzKeF46Q4HgQY+VVIwsq/bcIlRyRtf4a7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720691788; c=relaxed/simple;
	bh=xbcbq0VUVONBOquPYs0o8tyO0iR5cLlu7FcissIQlW4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EWI83ttpVkAEqo7ifnJwGzsrq5FuJrq02zaU+nMPiL0/7ssvb18WyLquw1Z2ui46mJ3FDlU/BmCK+1EVnBkltsn53Rl76OROI/pQulUwEIgkjp71Eh/JgX2tH+8mOpaHod39SDA6VKGN2saKQz2KG7/DE4AVW3wfkEneG4hb5IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DeFvvSd0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20936C116B1;
	Thu, 11 Jul 2024 09:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720691787;
	bh=xbcbq0VUVONBOquPYs0o8tyO0iR5cLlu7FcissIQlW4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DeFvvSd0UtNKSg7NMhHB7h2gEcTgU9/VL8N+7/C9Qa3Og++eWtbY0yER7ydPF6olc
	 8z/z1XqHyE3u0BS5agiuUbsFhDhy8Dvpq4OXyeGYZjsxBfAS4J3ApL2JVrGfwtCyrV
	 dtp7HpnE0B0Ip/VH+D26QVBawKmWiJ+VDsD0aq3+V/3I+ESUuj5tEnR5Fp9v90nFYt
	 6RS30AVJ9F7epcSbg8QaDIXGVk6ENjf93OeeMP/t0xbgamh9GimZOAXv7fzDv0km91
	 kW14d2AY8JcJ+AOD43v3nOGzGXD1wTQ+pQbKut8s4z0BQ8SMRSyvpWs7Y9dkJFM8wU
	 kmBgLQobsJ8Rw==
From: Leon Romanovsky <leon@kernel.org>
To: gg@ziepe.ca, nathan@kernel.org, flyingpenghao@gmail.com
Cc: linux-rdma@vger.kernel.org, Peng Hao <flyingpeng@tencent.com>
In-Reply-To: <20240710091657.26291-1-flyingpeng@tencent.com>
References: <20240710091657.26291-1-flyingpeng@tencent.com>
Subject: Re: [PATCH v2] infiniband/hw/ocrdma: fix the problem of KASAN
 causing the stack frame size to increase
Message-Id: <172069178325.1711020.4349851966212570627.b4-ty@kernel.org>
Date: Thu, 11 Jul 2024 12:56:23 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-13183


On Wed, 10 Jul 2024 17:16:57 +0800, flyingpenghao@gmail.com wrote:
> drivers/infiniband/hw/ocrdma/ocrdma_stats.c:686:16: error: stack frame size (20664) exceeds limit (8192) in 'ocrdma_dbgfs_ops_read' [-Werror,-Wframe-larger-than]
> static ssize_t ocrdma_dbgfs_ops_read(struct file *filp, char __user *buffer,
>                ^
> 
> Some functions called by ocrdma_dbgfs_ops_read occupy a lot of stack space.
> Mark these functions as noinline_for_stack to prevent them from accumulating
> in ocrdma_dbgfs_ops_read.
> 
> [...]

Applied, thanks!

[1/1] infiniband/hw/ocrdma: fix the problem of KASAN causing the stack frame size to increase
      https://git.kernel.org/rdma/rdma/c/15581c659a366e

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


