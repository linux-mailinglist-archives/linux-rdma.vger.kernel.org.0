Return-Path: <linux-rdma+bounces-8703-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9839A611DD
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Mar 2025 14:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FCBD7A5077
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Mar 2025 12:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD241FF1CC;
	Fri, 14 Mar 2025 13:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6lEetIp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F431DD0F6;
	Fri, 14 Mar 2025 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741957199; cv=none; b=jq5MGILspW875c+q3O+X0VjZJdipQ7sgp81S8N+1Txiy0zu7TlZwB9iS/CNCaJi684/BkDvYY8gmYN625OQQXMrvBuX/3WqujszhKLmDPJ9V8yTRAMCy2Bh8EaplFvxR8Luod0tNmR21xmr1BAmPSG22PYi9K46theMKi5OgLAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741957199; c=relaxed/simple;
	bh=S0HqySVuO5WiYhgCIb/zMBQSPibu+lJKpZPHlZpJH4Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WW4IoQf3CfStxUP1ZNRbcwAAEBkFaxtd+gXR+mkIymXkSChmA3q6mxxoYNdIJAh2sUJOJ03uuUOFfe+hPZFpnySHLjzb5tNQTBRlzRNQZTKIPmgIczEsQC/xVhRe6XF0RY/Najc6cPI8TfXYlCpNWKTKQvzlC08LLJ51ciB1+GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6lEetIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A075C4CEEB;
	Fri, 14 Mar 2025 12:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741957199;
	bh=S0HqySVuO5WiYhgCIb/zMBQSPibu+lJKpZPHlZpJH4Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c6lEetIpMA8eTmxrerCnwktVrU/72fW9+g8ebVhJMRj44/rdzJY0xGw3BfrkzCUp9
	 mLh3lbd3p8f+f9ic3FZ4JsRGElug0gRXGDuG+pCSKG/YQCpIqnr9nFGg4p1AVoMs2A
	 CytBeLuHsUCfVt5h7qEeN8K6TH5mmO1YEc0nXy6NPt9cglsj1nF+1bUc6bJk3QxOiT
	 RMuGNg/Zf6KOWdzE4Un0OzSdG80TUQ+nEgDT/rnbxj1yRZJQKa24FnDFZC3IssensX
	 NyKBgGrvOQ/GH6d3CWS1bkHlRfgxOi4hRdhMQfMUV4mHMpUdifQMeyVez45lyCOpTu
	 vEe3frLUcncwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 347D6380CEE2;
	Fri, 14 Mar 2025 13:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net/smc: use the correct ndev to find pnetid by
 pnetid table
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174195723401.2241450.4794096109279890304.git-patchwork-notify@kernel.org>
Date: Fri, 14 Mar 2025 13:00:34 +0000
References: <20250304124304.13732-1-guangguan.wang@linux.alibaba.com>
In-Reply-To: <20250304124304.13732-1-guangguan.wang@linux.alibaba.com>
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc: wenjia@linux.ibm.com, pasic@linux.ibm.com, jaka@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  4 Mar 2025 20:43:04 +0800 you wrote:
> When using smc_pnet in SMC, it will only search the pnetid in the
> base_ndev of the netdev hierarchy(both HW PNETID and User-defined
> sw pnetid). This may not work for some scenarios when using SMC in
> container on cloud environment.
> In container, there have choices of different container network,
> such as directly using host network, virtual network IPVLAN, veth,
> etc. Different choices of container network have different netdev
> hierarchy. Examples of netdev hierarchy show below. (eth0 and eth1
> in host below is the netdev directly related to the physical device).
>             _______________________________
>            |   _________________           |
>            |  |POD              |          |
>            |  |                 |          |
>            |  | eth0_________   |          |
>            |  |____|         |__|          |
>            |       |         |             |
>            |       |         |             |
>            |   eth1|base_ndev| eth0_______ |
>            |       |         |    | RDMA  ||
>            | host  |_________|    |_______||
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net/smc: use the correct ndev to find pnetid by pnetid table
    https://git.kernel.org/netdev/net-next/c/bfc6c67ec2d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



