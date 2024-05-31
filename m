Return-Path: <linux-rdma+bounces-2722-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AE38D57BD
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 03:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F245B22235
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 01:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FB9848D;
	Fri, 31 May 2024 01:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcthxgjL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25926AC0;
	Fri, 31 May 2024 01:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717118793; cv=none; b=tvI8jVg35qesxuZf2PP23o370soX8lsOh2QSCDDtEv9J/o4hf2o/GNUOyKL3i1IcUETSBB8cyUB4eKlmAudCK0RJps6ymuhjhIJdj2kfLHUcwBVeD8R6fIs2JRaOBMtCVlfPkFkpqOIQaMPkj3wv1m5ESB3Y78oi5AglsSKflFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717118793; c=relaxed/simple;
	bh=N9x3KJfZAFE+0hlOyg8a3tFKFVoKWKQbYsf4Mx27kGY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dq5U/ev2H98Pbht0Qj/WrEtlOe5Hnsw5mblV1zECug+uBHojNtU6UgBsSpEe7o9YtVVOX0I7SQWHHWG8NrZp/2c2vOLzqouJmg1Hvn0+PF7CstQksf4y8/sqCUC1S2hYws8ANybtCkusFsS9wI7BvZtTw7i2MPx1DSXd5ypXeFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcthxgjL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCA7C2BBFC;
	Fri, 31 May 2024 01:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717118792;
	bh=N9x3KJfZAFE+0hlOyg8a3tFKFVoKWKQbYsf4Mx27kGY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XcthxgjLWbApPwZx3iH/h/KsMGbl1GGmAo31uRRm0gZKT10BlU496elvwjsYuKiby
	 uK1axb0ZiTEGL9QA+xxORzFOyMy2gCdgRq1S1noPyFd5QZWODP3a6DGPHxnx4x81b7
	 Vtx6G6VRBZNEDquAyTMWBrsDDBUBr3obVnAIUTdowVloj5uxLKKLIVGsXRdOeSRWv6
	 gI19Q3BmsiQstL1KwzWmhmIzch++1bD3dSA+PwrvucY2JRZmBw3XyJXmFc6aVJHYnL
	 eJYK28h0RiRqMdaMnLpdW1JjqyOmU9tFlf7bXiR0TR06nFZE2w/4Dm8Nofod/pHP17
	 +kOur6nifFVkg==
Date: Thu, 30 May 2024 18:26:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 nalramli@fastly.com, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Leon Romanovsky <leon@kernel.org>, "open
 list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [RFC net-next v3 0/2] mlx5: Add netdev-genl queue stats
Message-ID: <20240530182630.55139604@kernel.org>
In-Reply-To: <Zlki09qJi4h4l5xS@LQ3V64L9R2>
References: <20240529031628.324117-1-jdamato@fastly.com>
	<20240530171128.35bd0ee2@kernel.org>
	<ZlkWnXirc-NhQERA@LQ3V64L9R2>
	<Zlki09qJi4h4l5xS@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 May 2024 18:07:31 -0700 Joe Damato wrote:
> Unless I am missing something, I think mlx5e_fold_sw_stats64 would
> need code similar to mlx5e_stats_grp_sw_update_stats_qos and then
> rtnl would account for htb stats.

Hm, I think you're right. I'm just surprised this could have gone
unnoticed for so long.

> That said: since it seems the htb numbers are not included right
> now, I was proposing adding that in later both to rtnl and
> netdev-genl together, hoping that would keep the proposed
> simpler/easier to get accepted.

SGTM.

