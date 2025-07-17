Return-Path: <linux-rdma+bounces-12251-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C891AB08A86
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 12:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B30373A99FD
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 10:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059F0298CBB;
	Thu, 17 Jul 2025 10:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULmvBXO7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B7227602B;
	Thu, 17 Jul 2025 10:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752748192; cv=none; b=QwwQOvhkSkBj/J2MMYxok4bsHLgmqkUVeQBNgs8K0bvbhnJAMeVW5b7cYJ/SB3VBirANOrq/AuC9OdPrZ2j7Tx7PxSpKCOyZQIk7Z8u3+94CMmHWGx1Z3e1xO2vuyzKUDFp0GopGgbc7QtGUF8Gb/pIAobtvWToPp9sPsRQM5zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752748192; c=relaxed/simple;
	bh=Ico/eA4/WsijYV/FhwdtOBIPuHNRgLvso4QC9S553jg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T3s64f7BekJACErr+ZS1ucFYM+F7+tVv65dfOKoa0P+JhiryZY+ksJ9aS8rjYys3dZcnTemxNFalYBtcN74L4XwTIWWZGff/AvGQQpFw8GsqZgIPwpTLiz6pXt2eQhP1bP9Sv5JfZwU/qfPKQo/UjPF4zgQlEoy30uuZ/Mc1/+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULmvBXO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242A2C4CEE3;
	Thu, 17 Jul 2025 10:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752748192;
	bh=Ico/eA4/WsijYV/FhwdtOBIPuHNRgLvso4QC9S553jg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ULmvBXO78pN1Z+JfLMoxncAsorV7OCsLfFPejO6tlYZWKH8BUXAQq2UkvKnIRGoda
	 1hzHFiQaFXthhEgAbQ+TJBM90Xtno32ltvdX8gH8QQdO/RRefv5Wn2aWWRFsHq7tb4
	 t/NmdV1jhIqXmZTLTWvwCB9QFiW+Loe4+K+QfKsNyzBY9ziZ2GOikz7HyBp/g0l2H9
	 bRgZwMeniGYS7zOWax4LnKG7w6sNkUGMVsly6+hywTkeRnqyoENjl45cBe/Cm1uzDg
	 Hq24hLfrSMih2y6PvB7XM8JzzmrFPO/YMQOwpZK+SlYBzoq50d0vgyyfqZ/ytWrqyv
	 ZMyoEX4k71foQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713DC383BA38;
	Thu, 17 Jul 2025 10:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next,rdma-next 1/6] idpf: use reserved RDMA vectors
 from
 control plane
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175274821227.1880155.10165413541509982414.git-patchwork-notify@kernel.org>
Date: Thu, 17 Jul 2025 10:30:12 +0000
References: <20250714181002.2865694-2-anthony.l.nguyen@intel.com>
In-Reply-To: <20250714181002.2865694-2-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, jgg@ziepe.ca, leon@kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, joshua.a.hay@intel.com,
 tatyana.e.nikolova@intel.com, madhu.chittim@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon, 14 Jul 2025 11:09:56 -0700 you wrote:
> From: Joshua Hay <joshua.a.hay@intel.com>
> 
> Fetch the number of reserved RDMA vectors from the control plane.
> Adjust the number of reserved LAN vectors if necessary. Adjust the
> minimum number of vectors the OS should reserve to include RDMA; and
> fail if the OS cannot reserve enough vectors for the minimum number of
> LAN and RDMA vectors required. Create a separate msix table for the
> reserved RDMA vectors, which will just get handed off to the RDMA core
> device to do with what it will.
> 
> [...]

Here is the summary with links:
  - [net-next,rdma-next,1/6] idpf: use reserved RDMA vectors from control plane
    https://git.kernel.org/netdev/net-next/c/bfc5cc8b5aec
  - [net-next,rdma-next,2/6] idpf: implement core RDMA auxiliary dev create, init, and destroy
    https://git.kernel.org/netdev/net-next/c/f4312e6bfa2a
  - [net-next,rdma-next,3/6] idpf: implement RDMA vport auxiliary dev create, init, and destroy
    https://git.kernel.org/netdev/net-next/c/be91128c579c
  - [net-next,rdma-next,4/6] idpf: implement remaining IDC RDMA core callbacks and handlers
    https://git.kernel.org/netdev/net-next/c/bf86a012e676
  - [net-next,rdma-next,5/6] idpf: implement IDC vport aux driver MTU change handler
    https://git.kernel.org/netdev/net-next/c/ed6e1c8796a4
  - [net-next,rdma-next,6/6] idpf: implement get LAN MMIO memory regions
    https://git.kernel.org/netdev/net-next/c/6aa53e861c1a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



