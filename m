Return-Path: <linux-rdma+bounces-1012-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EAC852D0C
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Feb 2024 10:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F8B528B029
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Feb 2024 09:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013C8224E4;
	Tue, 13 Feb 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIfYe2ls"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1505383B2;
	Tue, 13 Feb 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817829; cv=none; b=C7zG31bdvmwWOqkOk8kCDYmanAb+2T9v283Gkl3cEpEJg2y1wlmUC8RWN1RQzsTGCWmVKca07eE0CQTgWKcjDLbh7NqVo89PG+dPeATcjHKxBC5nj8bx8d4Qzfd0GG0K4Rcaz238XNQo/MefEnLYoGvGNG0zaDZ++RmF34qV03Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817829; c=relaxed/simple;
	bh=HxHIduk7jDDE7gNUcS8lTml/M8eJJyezP8pBh6xSZl8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=InwoCfGEgyN5/qpzC/U7YsBN5QZzFQekU9gPkf83hPIzcAi0WZJkcyJwDjSYvCZZVawKz8/rFwwwPggA6eHQizU6uV7IsukdEky0M0T79fWC60kXd4sqmZZJcFjyfRe482iPzxrw7XGbe1Lz/7kqZCWl95bj4GFmjXEVHsXZsRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIfYe2ls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 372A5C43390;
	Tue, 13 Feb 2024 09:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707817829;
	bh=HxHIduk7jDDE7gNUcS8lTml/M8eJJyezP8pBh6xSZl8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gIfYe2lsve1kb4s31k5oWsmDdlMULBTWUlpcaccxZoibX+FCKGywr72YfVmEeWlLc
	 ou1qw5wD49458MqNmx/uyVlTvxLaEUwvldv6677AUUFnlu22zrgYhrIDnX49t/gngs
	 GFtE2kQHj/xvncRpRBP4istZUD8irwb2PgYE/wWcTMUP8vcGWV8PMkMzNPT6H6MxbZ
	 XQiBl3TQ7bM+JrYRU/luo9Ee2n71pa71qfwsy7N2M4OfBzakVSVJBwGbVlkP5luxKq
	 dyh4WDVKp9bMlvqzmi+ObRxmbO76flg1O9IN5LlIyiKOndbCoqtBME9SlrM/VZdrv4
	 sUnOGuOwyQ+7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F51EC1614E;
	Tue, 13 Feb 2024 09:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 1/1] net:rds: Fix possible deadlock in rds_message_put
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170781782912.7605.17185434722445722969.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 09:50:29 +0000
References: <20240209022854.200292-1-allison.henderson@oracle.com>
In-Reply-To: <20240209022854.200292-1-allison.henderson@oracle.com>
To: Allison Henderson <allison.henderson@oracle.com>
Cc: netdev@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-rdma@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, santosh.shilimkar@oracle.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  8 Feb 2024 19:28:54 -0700 you wrote:
> From: Allison Henderson <allison.henderson@oracle.com>
> 
> Functions rds_still_queued and rds_clear_recv_queue lock a given socket
> in order to safely iterate over the incoming rds messages. However
> calling rds_inc_put while under this lock creates a potential deadlock.
> rds_inc_put may eventually call rds_message_purge, which will lock
> m_rs_lock. This is the incorrect locking order since m_rs_lock is
> meant to be locked before the socket. To fix this, we move the message
> item to a local list or variable that wont need rs_recv_lock protection.
> Then we can safely call rds_inc_put on any item stored locally after
> rs_recv_lock is released.
> 
> [...]

Here is the summary with links:
  - [v4,1/1] net:rds: Fix possible deadlock in rds_message_put
    https://git.kernel.org/netdev/net/c/f1acf1ac84d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



