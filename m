Return-Path: <linux-rdma+bounces-13023-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5388AB3EF67
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Sep 2025 22:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BC9C7ABC14
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Sep 2025 20:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADB2270EA5;
	Mon,  1 Sep 2025 20:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwvSrVwA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B5D26F2B9;
	Mon,  1 Sep 2025 20:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756758004; cv=none; b=gduh6wfKccSecaQpeD2eMqyUzltvJMQn27PGQ42B6I4LEWRpdiXwGqd42M61QqHynBf+/IovAjvDIGcU9Tq/0J7LpsjOokgU49/hxwpt8UZ1USEalJwZOQDYY6G7L2DEIYNS1VVftGM3Befihin8bq9fM4MkXUeR0thFC3mfS0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756758004; c=relaxed/simple;
	bh=CUvyqMXLkegcPY7wjPaUHhglZxfLDtooX3LUdny42WU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KmfhuBTIvlUocuA5WXbzUZFx0Pn8bi3JGKTlPn31hO1/RRWQxIrHSaQr3lgqpnYIKgFp7vrFXSpCRMfIhMcxj4R95qWCds2IUiiTNzkmsy8+uIOh8eM14XfClbGHoNLnMFobUF4BU5lP/y4Y7rdfjArMx9S+jPoAgKSxsj5RBfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwvSrVwA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F59C4CEFC;
	Mon,  1 Sep 2025 20:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756758004;
	bh=CUvyqMXLkegcPY7wjPaUHhglZxfLDtooX3LUdny42WU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VwvSrVwAUr8wItZ8326jSbun3c/If4wjdW66EKN7Bmx1kWYVkWPI9Y+Y/ZtRi5yTn
	 J5Sm5cknJt6Bp/7oiwm+e4JW5EW8FhgDrDxRI//7hh/WzVvYTlashtwixyYiwYckWE
	 M06FHoUtWpxtVA0qg9gxXV4yl7mEAHE55GlzWLuDQH5oDu7ON/jW4GgnDzntQ9wzFX
	 eAIQgmczlloD0XvJxjKBh0vtyU6Ld6KTcpYqGIRfSieKMF/1LZA4no4F9gw5aBHmvd
	 p4VGrUp3AqW6wsO80qEBQx/t2TKnkFPxcyyFks+IuQZvf1rN3Z4kUbmWiwTK9/6lLI
	 qarkL571lo8GQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF15383BF4E;
	Mon,  1 Sep 2025 20:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] eth: mlx4: Fix IS_ERR() vs NULL check bug in
 mlx4_en_create_rx_ring
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175675800975.3872744.16746310043446983872.git-patchwork-notify@kernel.org>
Date: Mon, 01 Sep 2025 20:20:09 +0000
References: <20250828121858.67639-1-linmq006@gmail.com>
In-Reply-To: <20250828121858.67639-1-linmq006@gmail.com>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: tariqt@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 Aug 2025 20:18:58 +0800 you wrote:
> Replace NULL check with IS_ERR() check after calling page_pool_create()
> since this function returns error pointers (ERR_PTR).
> Using NULL check could lead to invalid pointer dereference.
> 
> Fixes: 8533b14b3d65 ("eth: mlx4: create a page pool for Rx")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v3] eth: mlx4: Fix IS_ERR() vs NULL check bug in mlx4_en_create_rx_ring
    https://git.kernel.org/netdev/net/c/e580beaf43d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



