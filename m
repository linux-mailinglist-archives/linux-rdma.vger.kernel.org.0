Return-Path: <linux-rdma+bounces-8176-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1807DA4715A
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2025 02:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93AA218943E3
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2025 01:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53CB51C5A;
	Thu, 27 Feb 2025 01:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2vu70uD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543B9270038;
	Thu, 27 Feb 2025 01:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740619521; cv=none; b=gkWkyWt4M8VQJDW/CfFWHr2mpbPShLiFZdCD/O+5Yxnysmsvxm0dcwHeK0mKFtwQtwVZvTusuZl1e8Qd4LxdSs4ZFfPoPrlQuJ6bVK1d3ICdUnPqu/OAR531tVDrYNgfF43t3PItznwhMyugCbFRC0ibhIU01AqTk/KN86lLOpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740619521; c=relaxed/simple;
	bh=m62/7SvmUtw757E6Jq7wZPq5s4GWXKsm4qNDnbp74IU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmpByWWNv8vkiflPFAq1bSw8f9KB0k9mlZ9w5vg23fQm3zWzuQrUa3WEf2+vKXYJ3bTYYGWHpI8L3wzOJLca0VLKB8b/VKmusDIuCDU16mLBH+aJMXqITzGCpoatBY8//SUnr5KitzYIDrzzGR6PCMGH7jKdV5m1+kIoJoY/dTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2vu70uD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67EAC4CEE2;
	Thu, 27 Feb 2025 01:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740619521;
	bh=m62/7SvmUtw757E6Jq7wZPq5s4GWXKsm4qNDnbp74IU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t2vu70uDJTXI0YfIToAq3wGTPusu3xpdKEzw9GotT/k7G05qRLfVp5gSTNVv5WJa1
	 cJul9GlwKfq2SYLd9Aiin+EXrp/pIThCt4cY7VlJWHSorhjcQSIRyZf8E6XdIgqnFK
	 HNyf+gypQ8D9AjzVgSkjpeGSW0f1eeWVeevo0Irs+USVjZnthYvohFWiS+ZGgqCFbi
	 F/RN9FfPTJy5b2YW6uty5hHqGv1O/U+SaHOgpVnJPzr0/jOpnJXPms/Juecuy4QDPF
	 XYs+V8IfEE788Os5veaxTS9Dg1pjh1nHrCKx/JGPlhNlCrN2bS0CdpLGNkVcepPIqZ
	 lzfwMJgIStBWA==
Date: Wed, 26 Feb 2025 17:25:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
 <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3][next] net/mlx5e: Avoid a hundred
 -Wflex-array-member-not-at-end warnings
Message-ID: <20250226172519.11767ac9@kernel.org>
In-Reply-To: <Z79iP0glNCZOznu4@x130>
References: <Z76HzPW1dFTLOSSy@kspp>
	<Z79iP0glNCZOznu4@x130>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 10:49:35 -0800 Saeed Mahameed wrote:
> On 26 Feb 13:47, Gustavo A. R. Silva wrote:
> >-struct mlx5e_umr_wqe {
> >+struct mlx5e_umr_wqe_hdr {
> > 	struct mlx5_wqe_ctrl_seg       ctrl;
> > 	struct mlx5_wqe_umr_ctrl_seg   uctrl;
> > 	struct mlx5_mkey_seg           mkc;
> >+};
> >+
> >+struct mlx5e_umr_wqe {
> >+	struct mlx5e_umr_wqe_hdr hdr;  
> 
> You missed or ignored my comment on v0, anyway:
> 
> Can we have struct mlx5e_umr_wq_hdr defined anonymously within
> mlx5e_umr_wqe? Let's avoid namespace pollution.

It's also used in struct mlx5e_rq, I don't think it can be anonymous?

