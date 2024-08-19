Return-Path: <linux-rdma+bounces-4416-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20309956ED8
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2024 17:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531621C225BF
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2024 15:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACD760DCF;
	Mon, 19 Aug 2024 15:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PM5kY8Ah"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DB1335BA;
	Mon, 19 Aug 2024 15:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724081668; cv=none; b=hdG0rIMsYKVx/w+Nu42CUzU3IoYMaEjs+DWD1abkfY5+V3NSymemfdAx4CCcbvvrc3ZOvfDFVbfnne1dPq9Xx96TE+nLoleSUi/q10YjT/WuPteOgLTBLwHCrhh6/oEhyUF4nRS4S8mOkv0WTfZmKiiycWf5LLEN23yb2ff5TQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724081668; c=relaxed/simple;
	bh=4VrjSRXNUm0qxK9qDXOgGH/nx+QchNmk1s/6OZfvNV4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=buMjUp4eMJfQGA0M7vQD9YW/OfVkNVE91wi4wy6W0nJ+631ZWCVyRJK7N/DO889yJr/+bVoTmnUSEWgrkH9DU4r3TQniX4VlxTM5uVOB6wRqI5P1zcXMQwbaKXbWj6V3OJiLMubKcU6wJ5B3o0mnJtZzVITZYozNDorhJJv7e8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PM5kY8Ah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64669C32782;
	Mon, 19 Aug 2024 15:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724081667;
	bh=4VrjSRXNUm0qxK9qDXOgGH/nx+QchNmk1s/6OZfvNV4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PM5kY8Ahw+OIrEDWQ8tMat2J6tItd92GDnACtD3sm/S7CHbknbbM16IuAWOn9YBLX
	 vcreb29/dauJM4d922rdfNCAXKhkzm1bXiLNyVoG6rPLpEaGZnyDxUWfOOd3ZXUeP+
	 RbmIf1/jLqEiqHHzc2npfp22lzpQ1mdjNKOXrbhluzrzMvk18i9wn/qlNjUFrt7nnI
	 etXB8AFg4FHrFTDY+BPzBWXG78/384cTQE0UPXdcYQ6bn5r0j4Lb1fYewHFA1MN4Zn
	 17cQGl7VkNPnu4mIAIp/dgYfOVSDXxS7SpQ5EhN+TJHobxJ2EKNxgh6K5AOyDEf8Os
	 fT11CnZM3JlmQ==
Date: Mon, 19 Aug 2024 08:34:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Erwan Velu <erwanaliasr1@gmail.com>
Cc: Yury Norov <yury.norov@gmail.com>, Tariq Toukan
 <ttoukan.linux@gmail.com>, Erwan Velu <e.velu@criteo.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
 <tariqt@nvidia.com>, Yury Norov <ynorov@nvidia.com>, Rahul Anand
 <raanand@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx5: Use cpumask_local_spread() instead of custom
 code
Message-ID: <20240819083426.1aebc18f@kernel.org>
In-Reply-To: <CAL2JzuzEBAdkQfRPLXQHry2a2M7_EsScOV_kheo+oXUuKM9rWA@mail.gmail.com>
References: <20240812082244.22810-1-e.velu@criteo.com>
	<3dcbfb0d-6e54-4450-a266-bf4701e77e08@gmail.com>
	<ZrzDAlMiEK4fnLmn@yury-ThinkPad>
	<CAL2JzuzEBAdkQfRPLXQHry2a2M7_EsScOV_kheo+oXUuKM9rWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 12:15:10 +0200 Erwan Velu wrote:
> 2/ I was also wondering if we shouldn't have a kernel module option to
> choose the allocation algorithm (I have a POC in that direction).
> The benefit could be allowing the platform owner to select the
> allocation algorithm that sys-admin needs.
> On single-package AMD EPYC servers, the numa topology is pretty handy
> for mapping the L3 affinity but it doesn't provide any particular hint
> about the actual "distance" to the network device.
> You can have up to 12 NUMA nodes on a single package but the actual
> distance to the nic is almost identical as each core needs to use the
> IOdie to reach the PCI devices.
> We can see in the NUMA allocation logic assumptions like "1 NUMA per
> package" logic that the actual distance between nodes should be
> considered in the allocation logic.

I think user space has more information on what the appropriate
placement is than the kernel. We can have a reasonable default,
and maybe try not to stupidly reset the settings when config
changes (I don't think mlx5 does that but other drivers do);
but having a way to select algorithm would only work if there
was a well understood and finite set of algorithms.

IMHO we should try to sell this task to systemd-networkd or some other 
user space daemon. We now have netlink access to NAPI information,
including IRQ<>NAPI<>queue mapping. It's possible to implement a
completely driver-agnostic IRQ mapping support from user space
(without the need to grep irq names like we used to)

