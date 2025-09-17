Return-Path: <linux-rdma+bounces-13430-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA985B7CC6C
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 14:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79D9E1B26FB1
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 00:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A0F1C3C18;
	Wed, 17 Sep 2025 00:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F80H6A7q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237B61A9FAC;
	Wed, 17 Sep 2025 00:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758068468; cv=none; b=rzHNMGMvanmDOQ7PKiwrPqsW4pbc7zFv1QEWapV1Cvh8UcnYFf7vz/HbORmQE3V5vLnZTiA7S8uD4eKrst7x/QrEVayiacyxG57U1+q4CTdEe7qmkAmkMM5re8mXjqEr/NWrOvS2hAIm9vjzhAThyeK7DQkafvrxiwV097C0E3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758068468; c=relaxed/simple;
	bh=PRTYnd5lGudq20AWRXWYzr0PRxeNiLfx6nr9sfjl3KA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HVTSy/6piiUb0Xo+ESp0SYwHLZ3NU0p9oboxsz/1XLBO68gtB3JRYIgZqxWUvroOqcE6OOJfb9DvI9CQSildswPhzDmuT2zWUePL1YDjItrzkQqLHFZtP7uxcNdGa/jNrN+xkag3+rDOAwQtYd+OlILlgKaunI3C7ZTR60wim3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F80H6A7q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B75C4CEEB;
	Wed, 17 Sep 2025 00:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758068467;
	bh=PRTYnd5lGudq20AWRXWYzr0PRxeNiLfx6nr9sfjl3KA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F80H6A7q1t5maM3Z/OJMUJ+LHvz6cNtar88kJ9lNHJHCl1xxHtQ5Rtx09c1u1GbzI
	 MWSB+W15h1SXyfhEXRr1TX9QgdRbVoBUQDfx+USvHOo6z9Zc7gEltkgQNH3eQhSKjc
	 Y+/e5+k5+tIKLDAfGShLrasKIOvMMj69BbyWfAVYGhd+CtOjyHMWmJHYbCT6L2OIso
	 k4pcgkU1mSkhNx2KKochXkrKP13P3fbTPABTaYK2vLj/LKM3XHwXJABt7ypcVA1wqD
	 YE5x0+BC9eHHugiVJHWx8uVihBadgS6MQVEEA5BkMKxxIvQR/FndeP9oOJuweUqGR5
	 Jb3gvh/ZeC71w==
Date: Tue, 16 Sep 2025 17:21:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Jianbo Liu
 <jianbol@nvidia.com>
Subject: Re: [PATCH net V2 2/3] net/mlx5e: Prevent entering switchdev mode
 with inconsistent netns
Message-ID: <20250916172106.593683a8@kernel.org>
In-Reply-To: <1757939074-617281-3-git-send-email-tariqt@nvidia.com>
References: <1757939074-617281-1-git-send-email-tariqt@nvidia.com>
	<1757939074-617281-3-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Sep 2025 15:24:33 +0300 Tariq Toukan wrote:
> If the PF's netns has been moved and differs from the devlink's netns,
> enabling switchdev mode would create a state where the OVS control
> plane (ovs-vsctl) cannot manage the switch because the PF uplink
> representor and the other representors are split across different
> namespaces.

I appreciate the extra paragraph of explanation but it's still not 
a fix. 

