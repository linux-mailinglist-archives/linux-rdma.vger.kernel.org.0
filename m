Return-Path: <linux-rdma+bounces-10738-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5680BAC447F
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 22:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B236A3B78AE
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 20:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A639B23ED6A;
	Mon, 26 May 2025 20:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDc42CFH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E142147EF;
	Mon, 26 May 2025 20:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748291995; cv=none; b=XtEHhyVjQSQTaJZXWBKAMBlL2fKE65ZmDfzRbmseq6IxzT2zz+CJ0YWDPopsijjf61PBUZqPqhyB2O/OYSnkO/rrmuJ7V1DF49TiXoth6AQLhGajIPzL+dhlW/Azz7STo4gmsF8KzQQWc2a/DcIbU7cWLfhuoawsrNwKB2IRKgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748291995; c=relaxed/simple;
	bh=EEEQyHf81xh4XanVF972Z1UpwXEWm0dlmJQER+VPF9w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kKnFM+b3KlJ7UaGYrhY3+vlPZSNe4D7cae1tUGo9ISBEUM8B1Xt/Q/xVk378UG3Lq6qLj4LOBslOTpzC9EuyvNydpKUzcMBKs9A9k2bLJMedxs7n3ogZGyrHnvGlFFp+HIsihUq9QHsIGPaStcX6GBAK6ZuOn9+FNFHqIv+WbIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDc42CFH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39AEC4CEEF;
	Mon, 26 May 2025 20:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748291994;
	bh=EEEQyHf81xh4XanVF972Z1UpwXEWm0dlmJQER+VPF9w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kDc42CFH+RwMiM76q2KV+r6Jl6jilN7Xx5XQfcAmeJfK50dJcYBnMBHi16K5sPnLt
	 CjxcQKl81P3vKJxCwsxxspYFechiwfYxIDU2maDC+Nn07uP5t0YNr3nnCnvwP76CR6
	 5JbAk50rhOhiIuli5h/1eO8a0AXjVpIAJNCX603sVwsWSOTQg9xJxuS4Wj7ZIYHSqY
	 iZqI1CdPVG7OudywgqfUTX4bIkyRkKV8/kNgQH1s3+w+b1JnUOv+kzQqkQj4JfquYp
	 Vi8PsmE/2l+ppiUIGrcMkFkeU9cz+9CGW8G+bsDtt4hT9maczwmKYxivuJdCuS5m57
	 23iM1EDSG9sBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E673805D8E;
	Mon, 26 May 2025 20:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 net-next: rds] replace strncpy with strscpy_pad
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174829202904.1039758.3366879265618643528.git-patchwork-notify@kernel.org>
Date: Mon, 26 May 2025 20:40:29 +0000
References: <20250521161036.14489-1-goralbaris@gmail.com>
In-Reply-To: <20250521161036.14489-1-goralbaris@gmail.com>
To: Baris Can Goral <goralbaris@gmail.com>
Cc: allison.henderson@oracle.com, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, linux-rdma@vger.kernel.org,
 michal.swiatkowski@linux.intel.com, netdev@vger.kernel.org,
 pabeni@redhat.com, shankari.ak0208@gmail.com, skhan@linuxfoundation.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 21 May 2025 19:10:37 +0300 you wrote:
> The strncpy() function is actively dangerous to use since it may not
> NULL-terminate the destination string, resulting in potential memory
> content exposures, unbounded reads, or crashes.
> Link: https://github.com/KSPP/linux/issues/90
> 
> In addition, strscpy_pad is more appropriate because it also zero-fills
> any remaining space in the destination if the source is shorter than
> the provided buffer size.
> 
> [...]

Here is the summary with links:
  - [v5,net-next:,rds] replace strncpy with strscpy_pad
    https://git.kernel.org/netdev/net-next/c/5bccdc51f90c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



