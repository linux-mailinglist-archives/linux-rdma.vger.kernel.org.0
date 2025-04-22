Return-Path: <linux-rdma+bounces-9662-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8046CA963BA
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Apr 2025 11:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EE54188BA3B
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Apr 2025 09:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FDA256C85;
	Tue, 22 Apr 2025 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqB6HV0a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225F5253947;
	Tue, 22 Apr 2025 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745312970; cv=none; b=Za88ygVONqf3KFCucxAkT7GsHNaj7If95p43mnXgkM/7FcaQ+26oy22VVypk9dDuBAwrV8Vhk4gUnBNI1qVyilh0fDg6PrS060x9Sn83bRsievj7AmBbU3e/fp6PuWly1RAkiw6BcmmD6lv/S617ldlBEpnFlezpGXo2nH5Nje8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745312970; c=relaxed/simple;
	bh=LWLwIWIREcnGHVr9V4bXSa6VdoUXdDgUQPuZFLtN2mE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ToUW/S2DdlIKc8E6/BvSNsBMpdelbxTViDf2cDcAmkZnB4u7KtWOZHrKV0RpXcy6q6ur1fBL+CtFlwXQOEYgnEh/0D607qxz+Z3lj9qbRZiWs5ox8NKqC8HwI532UiOQhm8ZD/ywh2TFD94S0vYEy4By0BuOlKCr9hsPl2rivk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqB6HV0a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F855C4CEE9;
	Tue, 22 Apr 2025 09:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745312969;
	bh=LWLwIWIREcnGHVr9V4bXSa6VdoUXdDgUQPuZFLtN2mE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VqB6HV0aqc+RSvcoU9WUo8DWCxt0Ccdy0uBbJENx3iH5+9Ohg6YQZYiDLIMDsvl6e
	 0n9oykz0PgHCuJlFYF2tO4l81reaL/2HXwylK01UIRrIKu+XzvVQcQRJk7qiiCjKbS
	 uq7tpZTFlDL6xK18yWTvNTCHIPLXrhmYhytfVVqbIxpbMOIZ/VI4Cg7sUzLEB9Fs0k
	 S7oumbvI+udWTuOvEAYiGSES0Z+QwpKadFnYnSByZMWFtuHTKd1fR2MI4w0vMhP7MN
	 spwfxsr7GBoYOAjPHYrmpbvJNwoRhiNeG/c65fZvbjA//uAwubZtLgdlFjOvbrS6ZM
	 3f99er/Ufla1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 342AA39D6546;
	Tue, 22 Apr 2025 09:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 0/2] net/mlx5: Fix NULL dereference and memory leak in
 ttc_table creation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174531300776.1477965.14714402895095610167.git-patchwork-notify@kernel.org>
Date: Tue, 22 Apr 2025 09:10:07 +0000
References: <20250418023814.71789-1-bsdhenrymartin@gmail.com>
In-Reply-To: <20250418023814.71789-1-bsdhenrymartin@gmail.com>
To: henry martin <bsdhenrymartin@gmail.com>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mbloch@nvidia.com, amirtz@nvidia.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 18 Apr 2025 10:38:12 +0800 you wrote:
> This patch series addresses two issues in the
> mlx5_create_inner_ttc_table() and mlx5_create_ttc_table() functions:
> 
> 1. A potential NULL pointer dereference if mlx5_get_flow_namespace()
> returns NULL.
> 
> 2. A memory leak in the error path when ttc_type is invalid (default:
> switch case).
> 
> [...]

Here is the summary with links:
  - [v7,1/2] net/mlx5: Fix null-ptr-deref in mlx5_create_{inner_,}ttc_table()
    https://git.kernel.org/netdev/net/c/91037037ee3d
  - [v7,2/2] net/mlx5: Move ttc allocation after switch case to prevent leaks
    https://git.kernel.org/netdev/net/c/fa8fd315127c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



