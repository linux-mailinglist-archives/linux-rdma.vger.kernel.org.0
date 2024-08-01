Return-Path: <linux-rdma+bounces-4171-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0A0945034
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 18:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4FF1C243AE
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 16:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965C41B3F2F;
	Thu,  1 Aug 2024 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0KnIA42"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9621B32A8;
	Thu,  1 Aug 2024 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722528634; cv=none; b=oGr6qlT5v7+ibif/SA3RwoRy75bH08J36h5VHIhPBTKdUyXgS+3igy1jirpP7SFuLPuThl7iK8byNFtwLX90mrs7/Dw9jMVRCMBNlBjKgYllxz1+Ug6Yd+cMnpjLUB/L2RO3EvQEG1X6Mnrkt7NXL7l+oaes+Yc2HxOlNdWMhzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722528634; c=relaxed/simple;
	bh=3vJAHH8U7AJ7cUC8SUce3n7B+HWSJFdQwu4R2F6GBTI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mQYed6VK6D/JvylcddG+4zcioMhVEc6HA71yyrVzkW0AwuUZR45RpfHFdVClEHm0h4QXOWAomBjdmBJhKRa0fvDnQSGn4t8u2exmGguXseU+FbX+fLCfUYCNlG2Cj65jSer3MnvD0CluCYEgK25Rd/D82LZRvhfQ1CjWTaz7AYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0KnIA42; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCE29C4AF11;
	Thu,  1 Aug 2024 16:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722528633;
	bh=3vJAHH8U7AJ7cUC8SUce3n7B+HWSJFdQwu4R2F6GBTI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T0KnIA42FHNbGZ33e8Ck+INxvczlp+A8+xpfqTHHx/cF3xGzHoTzpagG8rTzVHrzS
	 vk1wTBTZZQEjUkGVO+Zy+rh790/NqxiDO9m2oK7fgow2PX7SKUCjVeFdTokp/x4Pe/
	 w86vVh3dZp4ChbXcB3xMSfSsEmuyj0sEK1zLkpNkVce8LM3lj90Mj2FGWVtGocEmSC
	 mg+jj5/Nl/KUzMx9qz9UrKWUlkwUkabtIKQNREsLwNy4ZF/tSW7NYOtsTCOZRp0ZIY
	 xN3j3GRiiy4j8wI7gifSilz0cEDQG0RMNZONkXTNZ5lD0QNg0/PoZJM4OMzR85aXPO
	 XX1OfAKqFS3xw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BCF2BE8877D;
	Thu,  1 Aug 2024 16:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7] net/mlx5: Reclaim max 50K pages at once
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172252863376.25785.1041968269400834638.git-patchwork-notify@kernel.org>
Date: Thu, 01 Aug 2024 16:10:33 +0000
References: <20240730073634.114407-1-anand.a.khoje@oracle.com>
In-Reply-To: <20240730073634.114407-1-anand.a.khoje@oracle.com>
To: Anand Khoje <anand.a.khoje@oracle.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, saeedm@mellanox.com, leon@kernel.org,
 tariqt@nvidia.com, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, rama.nichanamatlu@oracle.com,
 manjunath.b.patil@oracle.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Jul 2024 13:06:33 +0530 you wrote:
> In non FLR context, at times CX-5 requests release of ~8 million FW pages.
> This needs humongous number of cmd mailboxes, which to be released once
> the pages are reclaimed. Release of humongous number of cmd mailboxes is
> consuming cpu time running into many seconds. Which with non preemptible
> kernels is leading to critical process starving on that cpu’s RQ.
> On top of it, the FW does not use all the mailbox messages as it has a
> limit of releasing 50K pages at once per MLX5_CMD_OP_MANAGE_PAGES +
> MLX5_PAGES_TAKE device command. Hence, the allocation of these many
> mailboxes is extra and adds unnecessary overhead.
> To alleviate this, this change restricts the total number of pages
> a worker will try to reclaim to maximum 50K pages in one go.
> 
> [...]

Here is the summary with links:
  - [net-next,v7] net/mlx5: Reclaim max 50K pages at once
    https://git.kernel.org/netdev/net-next/c/501c3005f031

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



