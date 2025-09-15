Return-Path: <linux-rdma+bounces-13379-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22599B580F5
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 17:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA347189220A
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 15:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BC72288EE;
	Mon, 15 Sep 2025 15:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5NU4Ouk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96E32080C8;
	Mon, 15 Sep 2025 15:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950213; cv=none; b=SUDTu0gkDgdLSaxBv/BnBCZl9uN/d/27t/dQHTpFS3DqKV4aYuiGzFG3P8vA4w4Z841Se+Gy4XXTRZWXEUzQ3OR65J8Nv2EKCLFvBFFIO/+KKTG8cb3DSW/wK7Mfuck/6aXnJwjzxgHmX1Of5qBxH1KAdbN2Z3RD5P5vf9m475E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950213; c=relaxed/simple;
	bh=8fQJNYDWYxsvnPmW6n8ugy3dbIdKZRe3Y1byyWgEgx0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t8s/L0KDbaPtekINW29mbJuVn4iyKnCddOYaIcqPGLk4Ckx0PmhyRa5s0E+82y91kya7Kay9mqKKJL3aT/zs67HncqTwOVR7+Ya2AFx7L+iT6wE/jsO+RVdFUmjluPpjxvZ+dc8vz48gQ3+k4L67CDnuKWKHoHn0YobfFPQsVT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5NU4Ouk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46321C4CEF1;
	Mon, 15 Sep 2025 15:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757950213;
	bh=8fQJNYDWYxsvnPmW6n8ugy3dbIdKZRe3Y1byyWgEgx0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k5NU4OukNQH+RSBNAiK0rFU7wvINO+2vKXU9USkWvp3Mx/tPaWAIzO51mdAqj5Wq7
	 ljMFG+S/lKf628/KUQf0iNwFpkqLPc58Ke6lQ9nO9Wbk6epggZNfrcEmlprmCJdkrr
	 QXIzXYyutJJZZGsv7/5mteM9b+X5PwgCDZaILXqlcHPeuSpMBuodRjH1z02r2mYrov
	 j5E0JRPtv8kUVaHzYtpY38Rc3ljwMdEWLVutXXrsS/Li0JkiHEHxEbc9e4iiL1EDxX
	 PLn8JIF6fDcbbwQxswzNoNB9bSGGydsC2ThtjByniayY5WnCHuQROMnTaKzrcALLcI
	 JJ1Ce+sVgYoqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB19A39D0C18;
	Mon, 15 Sep 2025 15:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/mlx5: fix typo in pci_irq.c comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175795021449.29952.4463966275696334488.git-patchwork-notify@kernel.org>
Date: Mon, 15 Sep 2025 15:30:14 +0000
References: <20250912135050.3921116-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250912135050.3921116-1-alok.a.tiwari@oracle.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: mbloch@nvidia.com, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Sep 2025 06:50:44 -0700 you wrote:
> Fix a typo in a comment in pci_irq.c:
>  "ssigned" → "assigned"
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net/mlx5: fix typo in pci_irq.c comment
    https://git.kernel.org/netdev/net-next/c/c5e389cc6b36

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



