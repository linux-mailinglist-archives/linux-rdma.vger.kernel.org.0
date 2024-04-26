Return-Path: <linux-rdma+bounces-2119-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23D58B4095
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 22:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA8A28BB28
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Apr 2024 20:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2947C2230C;
	Fri, 26 Apr 2024 20:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vex/dElv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D229D20B0E;
	Fri, 26 Apr 2024 20:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714161677; cv=none; b=qjCx2qvsCH6f8JXRbtO2Qj1WTI1qWgmRb2ex52najvOu6J6IsMEBS7Wu3vgdll+HzXw8GEmL2/G4sdyoNzpUM8zJ1kNHwebPqpd/JGMdW/0+O2WW4MGh8M+GhlcslBL5SjfSRbx/4F2nbg6gzLmHIY6ydxFAw4mm02zjmgNY8WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714161677; c=relaxed/simple;
	bh=DVeUtrzqwTvgJrEfMKAgDSqxptfRu/QsJkQduqT1yUE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GPLAZnVbWnTT2yac2/XrEAvipwhETLFyLdcPIW/pEfHK7hFF5496FelPZhjWEFEHmEUiQDGqhZBYwCJ7L8i6ybSULys/yJrs/Vf0nnQ2BfZ33vz1lmmAlYbn9245ziFcK26RODeRGykXR5UQcZxyKSkYtAToHFjc4vRAszxvecI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vex/dElv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16256C32782;
	Fri, 26 Apr 2024 20:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714161677;
	bh=DVeUtrzqwTvgJrEfMKAgDSqxptfRu/QsJkQduqT1yUE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vex/dElv0Qnb/JYiD/WpwoE0t4Ryct6JMzaoazn9k1V8NO950ZjW29/G9KCX9yICl
	 iHLnXiHpABX+nhUlADK++4AxWly/Q/ltu+2EPEWfyFQlQq33CK2PpXto49Jgw4U9a3
	 +wU0MNJ5ezi/LdMusre19VWfgMRixt+i9RPzl+FxB/fzLVDW9hF/OVAIMihRYnPWK+
	 N0VMnhmbGftBjpzqU4a+tr70MeZXpES7aSLM0sR01abF4ejaVS7IQkR54StuC0905f
	 D38E8jz6mWL23HMkEkJ9TN0Mz1jqXv9hR2JX+LMeoe1OP8TMrw2UKSreG3QF9RrYtD
	 bJxcIb//lnqOw==
Date: Fri, 26 Apr 2024 13:01:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tariqt@nvidia.com,
 saeedm@nvidia.com, mkarsten@uwaterloo.ca, gal@nvidia.com,
 nalramli@fastly.com, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver)
Subject: Re: [PATCH net-next v2 3/3] net/mlx4: support per-queue statistics
 via netlink
Message-ID: <20240426130116.7c265f8f@kernel.org>
In-Reply-To: <20240426183355.500364-4-jdamato@fastly.com>
References: <20240426183355.500364-1-jdamato@fastly.com>
	<20240426183355.500364-4-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Apr 2024 18:33:55 +0000 Joe Damato wrote:
> Make mlx4 compatible with the newly added netlink queue stats API.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>

Not sure what the "master" and "port_up" things are :) 
but the rest looks good:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

