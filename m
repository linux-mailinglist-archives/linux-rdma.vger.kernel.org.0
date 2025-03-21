Return-Path: <linux-rdma+bounces-8898-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1F9A6C427
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Mar 2025 21:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16B837A696F
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Mar 2025 20:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51511230270;
	Fri, 21 Mar 2025 20:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCN0azzy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0255D4A00;
	Fri, 21 Mar 2025 20:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742588999; cv=none; b=umQdNM4NeWZMz9w6ddYTtbTuJrNz7XIycnPArKVrnRf0tIq2wHsXKRkIXqIX/ei7uCPR1unB/d6PuiNxmxFUEUpU4HslAy95C6ZYpD56EMggESX6r9/pzjOGiSgD9F6FIUcRrGTvKoifNYkAexgcn6hHThteleqc0LWHU3e3x+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742588999; c=relaxed/simple;
	bh=ZZLmMZ289rqQhcr8NBJny5fTTa8Eof8bLWxFOCYlhbk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ItfqXLo65RWV5M7d+3zRxPm60IJh6S0HcHU7fC6zpVrQBF0P86K2+yKLfY4F5eKiSvRut+l53MqG5RRvbrPPW+U4WJn+dYh5+fK4F80JnCqEOqgpjKcflbu7OIp097q0bnBR0TQH1Ga1DbVGczAq/klQeq8d3x6pqdNklADY4ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCN0azzy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D0FC4CEE3;
	Fri, 21 Mar 2025 20:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742588997;
	bh=ZZLmMZ289rqQhcr8NBJny5fTTa8Eof8bLWxFOCYlhbk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MCN0azzyrqFhyjlSjdnAvdsMtpD4lNBu9VbwIFxtdXCBamCC4AFQj0VCPr/4EJFVm
	 mnUnlZgemakyQq3+pvW5F/01Bfl2Qg3u49OT0Eb/zwThTy2j/LmrlXBA8eclFoS5nP
	 wHiydX3EyeqcmKOKN5Gt3zZc0WahQq0Vo1BEtxuMoYd7Ae2R5sPJDFyj+/TlJsBm/X
	 ZKQqZXTVu5V21d0ChRTgzOOLgZBNVHzoW/MNVi934TsnSHmgRoo63Q7TTeoKlXXARO
	 1NgCCZrmpn41L5yQCBUo6z55GrCAq9/AV+TYzfcgd5Xmb5uZ9GFdwGzfZrwtXBnp5J
	 g4+AjfQXr3e/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEAF03806659;
	Fri, 21 Mar 2025 20:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V2 0/4] mlx5e: Support recovery counter in reset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174258903353.2613064.2638906472683771245.git-patchwork-notify@kernel.org>
Date: Fri, 21 Mar 2025 20:30:33 +0000
References: <1742112876-2890-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1742112876-2890-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, gal@nvidia.com,
 leonro@nvidia.com, ychemla@nvidia.com, saeedm@nvidia.com, leon@kernel.org,
 corbet@lwn.net, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kalesh-anakkur.purayil@broadcom.com, jacob.e.keller@intel.com,
 stfomichev@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 16 Mar 2025 10:14:32 +0200 you wrote:
> Hi,
> 
> This series by Yael adds a recovery counter in ethtool, for any recovery
> type during port reset cycle.
> Series starts with some cleanup and refactoring patches.
> New counter is added and exposed to ethtool stats in patch #4.
> 
> [...]

Here is the summary with links:
  - [net-next,V2,1/4] net/mlx5e: Ensure each counter group uses its PCAM bit
    https://git.kernel.org/netdev/net-next/c/8e6f6e92d3fe
  - [net-next,V2,2/4] net/mlx5e: Access PHY layer counter group as other counter groups
    https://git.kernel.org/netdev/net-next/c/da4fa5d8817d
  - [net-next,V2,3/4] net/mlx5e: Get counter group size by FW capability
    https://git.kernel.org/netdev/net-next/c/4c737ceb690c
  - [net-next,V2,4/4] net/mlx5e: Expose port reset cycle recovery counter via ethtool
    https://git.kernel.org/netdev/net-next/c/c3b999cad7ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



