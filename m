Return-Path: <linux-rdma+bounces-14104-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA00C14B49
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 13:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 464F5346B9D
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Oct 2025 12:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C1B32E12B;
	Tue, 28 Oct 2025 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHkghORT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE352AD32;
	Tue, 28 Oct 2025 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761655829; cv=none; b=SFtaAwjH7NrpPTbycJIoYJGIgz2JrGNftuv/S1wG1kDQQ3pSrAT0rQHblJF93HCKfEwgh2JZwsVGhMk8Gx6G9Qp9zX92mjuLY9yxxLnUNFNw+0ttZoAqnwLdf5Tq++0F6ynSbJk8s8RQfHMhDOOsWmnJotzOoaxCRATrllR3AGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761655829; c=relaxed/simple;
	bh=+CiiunMoVpeI8cxdBqRRiQIth1oS/X1pgb1Aic35eq4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KoSkUlCrHD62uV5X2OvULMSdpc5Dr+OGw9osURPmt1uTbPehSprE1vNn1zYUMmQtn4dKASTHrGecelHydvh+i2DXMqEinCLSDHbd7IbTzKDn+RgUwER8gRolSuc+IElOwLUBCxN2HIu1mc+i3Jysb6OmOOPEdXWa7MRjRvGODj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHkghORT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32823C4CEE7;
	Tue, 28 Oct 2025 12:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761655829;
	bh=+CiiunMoVpeI8cxdBqRRiQIth1oS/X1pgb1Aic35eq4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FHkghORTJGuKfTNLdQnMZz/g8sKQ6xJJbqc2Qx7yeR7T3yKJAQ7IkEPDH3hJ1kS4+
	 JA6RyxkYUiM2vrqx9lKkmNkrTaaawxxcwJmgzhFsFfLF2+1+n6PTpu/TcvnsmZfr4e
	 9W6nFy4Mw5eQAhjzO+CX4qfJeGLPO8n/sc8RAOVTr4pdbYa7p8kVOzmhPCMYpdOJMR
	 pQTLe74nkAQVPTATuoefYgAkEP0JrUZiK0HFEFeYooYu81Wfv96lSiyuVS9hopUHtm
	 IwE4YpZ0CuObhxBGfkbJPcRQeYJqUwDb/FdXa7AWjZv83PK3isfLYYQjtEX3+qGbAS
	 o+7aRKeKStB4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D2C39EFA52;
	Tue, 28 Oct 2025 12:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] dibs: Remove reset of static vars in
 dibs_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176165580700.2220263.5302164789020156629.git-patchwork-notify@kernel.org>
Date: Tue, 28 Oct 2025 12:50:07 +0000
References: <20251023150636.3995476-1-wintera@linux.ibm.com>
In-Reply-To: <20251023150636.3995476-1-wintera@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: julianr@linux.ibm.com, meted@linux.ibm.com, alibuda@linux.alibaba.com,
 dust.li@linux.alibaba.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, mjambigi@linux.ibm.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 23 Oct 2025 17:06:35 +0200 you wrote:
> 'clients' and 'max_client' are static variables and therefore don't need to
> be initialized.
> 
> Reported-by: Mete Durlu <meted@linux.ibm.com>
> Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
> ---
>  drivers/dibs/dibs_main.c | 3 ---
>  1 file changed, 3 deletions(-)

Here is the summary with links:
  - [net-next,1/2] dibs: Remove reset of static vars in dibs_init()
    https://git.kernel.org/netdev/net-next/c/182663bbff78
  - [net-next,2/2] dibs: Use subsys_initcall()
    https://git.kernel.org/netdev/net-next/c/968822086b74

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



