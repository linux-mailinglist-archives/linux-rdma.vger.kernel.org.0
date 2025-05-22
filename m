Return-Path: <linux-rdma+bounces-10542-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FEEAC1020
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 17:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4147C17C888
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 15:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A2329993C;
	Thu, 22 May 2025 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smsGvCSU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE006539A;
	Thu, 22 May 2025 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747928462; cv=none; b=caUxyYmW05VWek5Jo6pCYfdyebSNzURJWi8BWyH1fWiOVlgNZZdKQSSXYHBwFJTRPdWD1rXdWfBEAsQICr9bhm2Q6r+BRKapjD9eCNXM+CAlXYwKcYyV6TF+Nqo9wJX1iz5MGmm6b0o6tRWdMcbgt21HEI+ofPjdN5jcaJoCHFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747928462; c=relaxed/simple;
	bh=lCue99gfK3k3Le4BsyR2Ad8jnJGdsOlLpAI71GbiBR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3+BltNt6wAYa8TQjJ/DvLoglSlGbwwNqUPZcVrKpqualRHJElL2Puu9n03wl009OwrsfSvebmbzh7DzmpeqrhomUDSBEHzEBrMs09N569JaJ7KOolJg0Ts5t2Zijvnky/lj0McIdRAGDxOalQp7WoL5+wMRnNzztYEEjBdlo8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smsGvCSU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED3FC4CEE4;
	Thu, 22 May 2025 15:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747928462;
	bh=lCue99gfK3k3Le4BsyR2Ad8jnJGdsOlLpAI71GbiBR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=smsGvCSUA9wUvoiQNY6Tp7JkMd8h/QpRkrFNQEZRU9UYoZ4p6bNfujf1ZaK0w4GLO
	 zK/3uZU/TckfBhku9QH5YUHp+PUabazi/p9pIsVukWV4TvJ8dpT61na02rm4Si/8rJ
	 SN5qZvrBPQ4ZQf4w+VPHQRprp5BMomuxN27EKekbOzG9qSAKS+JDjEfcf3UxuzydBV
	 geEzhorVxxqp+2F2P/PE2RrwkmdKcn7ppjDTkkhgjrDv0tag92Ea4vk6RKYyemUeTd
	 rpJeid25KQeBd3SvVdtx6t+Pb9lEz4UOkT4de2cvSgxdq5og/VY7mtnlwo4qglUEz8
	 i09Xz58XH8sLw==
Date: Thu, 22 May 2025 16:40:57 +0100
From: Simon Horman <horms@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] net/mlx5: Add error handling in
 mlx5_query_nic_vport_node_guid()
Message-ID: <20250522154057.GI365796@horms.kernel.org>
References: <20250521132343.844-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521132343.844-1-vulab@iscas.ac.cn>

On Wed, May 21, 2025 at 09:23:43PM +0800, Wentao Liang wrote:
> The function mlx5_query_nic_vport_node_guid() calls the function
> mlx5_query_nic_vport_context() but does not check its return value.
> A proper implementation can be found in mlx5_nic_vport_query_local_lb().
> 
> Add error handling for mlx5_query_nic_vport_context(). If it fails, free
> the out buffer via kvfree() and return error code.
> 
> Fixes: 9efa75254593 ("net/mlx5_core: Introduce access functions to query vport RoCE fields")
> Cc: stable@vger.kernel.org # v4.5
> Target: net

I don't think Target is a standard tag, so please omit it in v4.
The correct way to target a Networking tree is to put the tree name
in the subject line. Like this:

  Subject: [PATCH net v4] ...

> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
> v3: Explicitly mention target branch. Change improper code.
> v2: Remove redundant reassignment. Fix typo error.

