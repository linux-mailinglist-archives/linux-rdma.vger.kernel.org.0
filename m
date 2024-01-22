Return-Path: <linux-rdma+bounces-674-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C75836209
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jan 2024 12:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B56B1F281BB
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jan 2024 11:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2871E4175E;
	Mon, 22 Jan 2024 11:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ok8iikra"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D8941747;
	Mon, 22 Jan 2024 11:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923024; cv=none; b=oVWsSQ5Wkih0nb52mERbDanrTz67a0nFclOVDGCIkyGg/I7wCt9cIIy9E37/UgtmBYOvftyWQVsVLjm77xJ0kPJrJaHuoroOt7KUVdh+dVRprC1nO9uazuh4rDGkxQbNtWYrU5D0cliJ7XJoxMZVX3CU942KqcEMx7Ww36Q9HEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923024; c=relaxed/simple;
	bh=RCvTGJ0GZvvie/GIf5ztPAc6OQbXT6q4EjuGKMpAvIE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h0epGzg4pGLkrpk2LPJhaxEEJDs+W3JrghPIQFztOpgcD/pg+irne56zO4iBl51ijJKEzyHL03dygV1p5KTGgDlVjqwQpsyiPakz9WvZ0fngvLyOuu6jUZob+q+vPodNjD0R4e2CEi3njTK3KTG3iVyfReKIlOI4bx0E+fdo21c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ok8iikra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53417C43390;
	Mon, 22 Jan 2024 11:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705923024;
	bh=RCvTGJ0GZvvie/GIf5ztPAc6OQbXT6q4EjuGKMpAvIE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ok8iikraMnHEgdhufQtdsZ33a6OYW6qFs5sNGxvO1e8PqDyQRHE++C7mh2pZKo5WF
	 Rm78kEfwi7UnwwzjTRazUpy8TA4/OCFoRIMKG6QEJ7CQC6G3X5HckrCIEEbGmjHghl
	 zJI68QeOW1rEaPgT8Q+V59StTRhNlja0q7BNp8M9KW7XooIlIMw/yEh7HhsWT3wcWZ
	 un+G6Y3DJ347t2JxsBQb/8XXQzSeXlpETrvZENaRNJFE9PujL2KlxXDfhR7vYc0OKz
	 FZyxmYvBH4vMiebLM/NER6+YNKKGYamYdDewOnYcXxNa0z7smlb+vNpo5JBt2oKI57
	 5d+BB2kJO1eFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3AC45D8C9A8;
	Mon, 22 Jan 2024 11:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/rds: Fix UBSAN: array-index-out-of-bounds in
 rds_cmsg_recv
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170592302423.23374.3289939463686065448.git-patchwork-notify@kernel.org>
Date: Mon, 22 Jan 2024 11:30:24 +0000
References: <1705715319-19199-1-git-send-email-sharath.srinivasan@oracle.com>
In-Reply-To: <1705715319-19199-1-git-send-email-sharath.srinivasan@oracle.com>
To: Sharath Srinivasan <sharath.srinivasan@oracle.com>
Cc: santosh.shilimkar@oracle.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, syzkaller@googlegroups.com,
 chenyuan0y@gmail.com, zzjas98@gmail.com, gerd.rausch@oracle.com,
 allison.henderson@oracle.com, aron.silverton@oracle.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 19 Jan 2024 17:48:39 -0800 you wrote:
> Syzcaller UBSAN crash occurs in rds_cmsg_recv(),
> which reads inc->i_rx_lat_trace[j + 1] with index 4 (3 + 1),
> but with array size of 4 (RDS_RX_MAX_TRACES).
> Here 'j' is assigned from rs->rs_rx_trace[i] and in-turn from
> trace.rx_trace_pos[i] in rds_recv_track_latency(),
> with both arrays sized 3 (RDS_MSG_RX_DGRAM_TRACE_MAX). So fix the
> off-by-one bounds check in rds_recv_track_latency() to prevent
> a potential crash in rds_cmsg_recv().
> 
> [...]

Here is the summary with links:
  - net/rds: Fix UBSAN: array-index-out-of-bounds in rds_cmsg_recv
    https://git.kernel.org/netdev/net/c/13e788deb734

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



