Return-Path: <linux-rdma+bounces-7995-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 039E2A403E3
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Feb 2025 01:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E9133BCA76
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Feb 2025 00:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AC31372;
	Sat, 22 Feb 2025 00:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7DHbKB6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B7BEC4;
	Sat, 22 Feb 2025 00:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740183005; cv=none; b=erYr7rmbhVhvBMHOke6Ci3W6jLi1C6pShYnNYTt7q+gr42eV3Bo9UOoSYppT7iW3hYjWofElBbiDixexHR3szPCqNVL1MOq9ZIGlNOK3Nsm0a01MHDET1dTFOvkZXBfKsXAto0GT1tfnTva2aozjRiTQfjqAkcKlLl2J6Ya44XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740183005; c=relaxed/simple;
	bh=ufqPbEn1WJmaUW/hr5sj7ngYgOO92iLyjzLVnXeK+9g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ta5gwhKEYUz7PevU3EJggS9ba4k1yxs9rJaGUeuyxr10lmbCnYNx8DQhVGYTvBlnQrfaTaD+4igEtAtiLiZBUdAcYqOm/0qIj+CsktLzkI7ehqC1QamccSANJSHFRwpRjPNXOBXFzR3LT42ZsRjPH8mVYf3hdurpDIC/Uaulkhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7DHbKB6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819CAC4CED6;
	Sat, 22 Feb 2025 00:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740183004;
	bh=ufqPbEn1WJmaUW/hr5sj7ngYgOO92iLyjzLVnXeK+9g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i7DHbKB6NFWygo4TyWoeniWsCe3QpzanpPp6KSZkZYZnghds+qGQkDCnaNyMk0pF4
	 C1LzeG73BfzVjBQmtFtkyvVUSZMzyd2SqLSqVoyiJgao59IK3XOwgZvrU8yU+69Fbe
	 OxpvUo07WUEKjl6cRSZeFj30YX7taXyju+4vKrXuxWyQvNRTH8dP9PbAYAdyTJkR6E
	 m5m3A80pzEZECJjZL0nwxWb46Gmg/SKAKWIdp+bqhCQRRxQfPSI4KpsI266D73bthx
	 0YPk8H4z7VKWEFwPOwfmUSyWUuQbvL6JtgduxsZ6T7NWleyTONXWwGRn/1SPpMzvUk
	 UmVvO0l0ySymw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE070380CEEC;
	Sat, 22 Feb 2025 00:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/rds: Replace deprecated strncpy() with
 strscpy_pad()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174018303525.2244175.8423041588413050651.git-patchwork-notify@kernel.org>
Date: Sat, 22 Feb 2025 00:10:35 +0000
References: <20250219224730.73093-2-thorsten.blum@linux.dev>
In-Reply-To: <20250219224730.73093-2-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: allison.henderson@oracle.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Feb 2025 23:47:31 +0100 you wrote:
> strncpy() is deprecated for NUL-terminated destination buffers. Use
> strscpy_pad() instead and remove the manual NUL-termination.
> 
> Compile-tested only.
> 
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> 
> [...]

Here is the summary with links:
  - [net-next] net/rds: Replace deprecated strncpy() with strscpy_pad()
    https://git.kernel.org/netdev/net-next/c/c451715d78e3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



