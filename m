Return-Path: <linux-rdma+bounces-12165-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BC8B04CBC
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 02:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14C204A6EC9
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 00:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2903645BE3;
	Tue, 15 Jul 2025 00:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WU6YOocy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D495EDF76;
	Tue, 15 Jul 2025 00:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752538785; cv=none; b=K8/aEB5s82p6R5CFs15J9QRc16c3fWY8oFUuNXM7/221xQY2j2ibqgOxra61nMvmV4vt8cEBNpUvYyVxE4u3tc3swZongf/Dyz87F7yU3GUflIaMT0Dd+wQQ+0tKQaekysOGd9W0BZLXim/OuO2Ne/pKu/v0YS5FZBwBDQYbhag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752538785; c=relaxed/simple;
	bh=ltY2A4KH3G3OFLmTbyOOB5KI+LN0UKwnEXLqUcpbBlk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uNWZV7RD0v8igh3HxVdurZldyVTL1i0wxzT+96CA0WiyuQmDrnVDXYTBuz4lDxa7dQzPgdVojOAZF7UtO7CgmXBC51FgcvhSlPqAHOKn02qM9OIfIeTKvUHHRF6D3DKcxUUY/yjSkSW/+OFAr/zr+CDQm3dzSFNvP9y2blBPoXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WU6YOocy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6874BC4CEED;
	Tue, 15 Jul 2025 00:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752538785;
	bh=ltY2A4KH3G3OFLmTbyOOB5KI+LN0UKwnEXLqUcpbBlk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WU6YOocybrB0PZn3MMQCsHJGg7Hjpith3E562XuDDznDxiqYmyIeoTzSrdC5Exw7G
	 KWXfrnp4u+iouZKEl1BHrdFapvnI3cRIZtvd6NmhAmCqKtIKum5FZrENi9IBFsS0p0
	 KCkWC0yKbr7xy+ABNqdKTqdmEdgCdNISUnSQMGis+UM8NpqVhVc+jHP+gPDTuhN26r
	 JHoQD6U5hRACVEDQI3HceYi+6kMP3bbFluKRKHmGZj+09ggJQtiwvflImLivhED7wE
	 1EXfhZZzxIdRC0SBs8ZHDgHIxd6mltV63ZbwNbx6eugC9VBfE5n43t9jG7eRrNAQBC
	 rh7HfYTUj+jVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712C3383B276;
	Tue, 15 Jul 2025 00:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] smc: Fix various oops due to inet_sock type
 confusion.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175253880626.4035046.17250819591263209118.git-patchwork-notify@kernel.org>
Date: Tue, 15 Jul 2025 00:20:06 +0000
References: <20250711060808.2977529-1-kuniyu@google.com>
In-Reply-To: <20250711060808.2977529-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com,
 sidraya@linux.ibm.com, wenjia@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mjambigi@linux.ibm.com, tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
 horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com,
 syzbot+f22031fad6cbe52c70e7@syzkaller.appspotmail.com,
 syzbot+271fed3ed6f24600c364@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 11 Jul 2025 06:07:52 +0000 you wrote:
> syzbot reported weird splats [0][1] in cipso_v4_sock_setattr() while
> freeing inet_sk(sk)->inet_opt.
> 
> The address was freed multiple times even though it was read-only memory.
> 
> cipso_v4_sock_setattr() did nothing wrong, and the root cause was type
> confusion.
> 
> [...]

Here is the summary with links:
  - [v1,net] smc: Fix various oops due to inet_sock type confusion.
    https://git.kernel.org/netdev/net/c/60ada4fe644e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



