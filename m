Return-Path: <linux-rdma+bounces-4413-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B8495680B
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2024 12:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237491F22D13
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2024 10:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9E1C8CE;
	Mon, 19 Aug 2024 10:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3VfzCsZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1E1154C14;
	Mon, 19 Aug 2024 10:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062524; cv=none; b=lwM+80iJc9dNl/0X2iGmQtJKa0cdPvNQ9MFd9flJR6ImTUFXkcTzqpHje7K8SFXCBTKvAxbBozTNyGd3NqDHqgRefPGStoLoojJm7FUWmORcRuS80BlAmMBwDa8gJuW/ZE3HnD8WDXbgRnViQoHatk+TBB4GZMxUhlOUEz/dxnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062524; c=relaxed/simple;
	bh=W/4+G33wfJf0p9CZaMWO+T+vpkDN5h6TeXfT0inzY9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HWs6NFB9svzZjpcKD+KmH6sHQlwL0ev98Am7uquhVmPsaHYTYAiaUmpp4VhxQZWpxv4Iq1M18PtXyurZ3N8w8fjRl2HkqJDQbGPTeD8iNhJz5QeUXXKPth/RDZsvqeau+SlYSweRuHhl50CfQAp0E4wuRgbRoodEhKIUJg+rJm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3VfzCsZ; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-842efa905a5so634353241.0;
        Mon, 19 Aug 2024 03:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724062522; x=1724667322; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W/4+G33wfJf0p9CZaMWO+T+vpkDN5h6TeXfT0inzY9w=;
        b=K3VfzCsZc7Xon76Y3ngsIXFU6Bh2bGhyjLMCo5o3uiEMBoz50uciOpiK3ehoFtLtXT
         2UgzVViN2Nr4m3NAcxrT41jvvjmbAy9hxwycvwgX+1x2otm4VPnQxu9cAOqF+6jruYH7
         jURQ3m29pCtfs+iSDLEODAaqdI953KpyPQOSvcv7FfX23TRHlP7Fkzg0At1YKPavsyOM
         z6vwFpgpc1Gg97oBGfYr99nDR8i1kba7rctmfKyKGeXzYDX16gcLKmIc85k0tVkVoJRk
         0w+fv9SQneFypbTVvWMi58j7LQi8DjhyHV8w5U7X3IF41nvP+zc5x5rDkk6qQJyPN++n
         gnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724062522; x=1724667322;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/4+G33wfJf0p9CZaMWO+T+vpkDN5h6TeXfT0inzY9w=;
        b=lo2xSc6HnNpTHC1/KZWiacocuhYkmrZOQHu4rvWCwT9+IsREee9HIIs3Tx+hA/U1x1
         opGUZIPUH5RdTPmIttow0tNIjEJR8uoa3dDFEh2XzhX6bczkrfGYCYi30RIm/e6omOB8
         qEHBF31FDzJXsWe2sTqonqQvFT8AvORnFrV5crMAg1anGSeHvxMj1nh3Eqe959NKZMat
         LZ1oaPi/r7CJUtaXpPDI354QLBxYFPmWYoojp4E7F6UT9L6LXLkNJP/sVxHmvA344OxN
         dpgiVcKSZV1ymtmSclpk4104716/NERDeGL7nb4AfCn34nKy6NBbGxa8QZpwRvaLJKXA
         vhMA==
X-Forwarded-Encrypted: i=1; AJvYcCWYn/HgwEhGmTiJZSWDsDCy/lDpQ1JLmuXiym6Hwvc29m8YNnG+HwydytWoh6aK8ztdS6g7kFN4aY/zPKaWRTsrFM8k4uHGILVyBd/grJiCPqMDBX4jMnyhtWW460XXQxTcuHqqkXlQD+mlEWvAMx/1dPvI/OLytQX41Cfpp6OdnQ==
X-Gm-Message-State: AOJu0YwFghvaF6PwPtvj4gcTHNh5uSKT8GNbfyvMA4z4h6ED0g9hhQuB
	9NnZlDGDVzYTHJnoNQcSsAbx6pJtqQDgyxsqYEj+x9qeYl6cgD3VbvQW3J4T6BerT+W9kao1HJJ
	M5+RwusFfqSfBZaoGT/JPm9GbPyQ=
X-Google-Smtp-Source: AGHT+IHXHOPPMPnKTFNdZAQssubTi+UQ7lmwwpLHN3BOZzE/rZ7VSX2tKTOKODtEg68AABNXSWQ3/PEspkNtDhT5ALA=
X-Received: by 2002:a05:6102:304b:b0:493:e678:b760 with SMTP id
 ada2fe7eead31-4977999cba4mr12758058137.28.1724062521858; Mon, 19 Aug 2024
 03:15:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812082244.22810-1-e.velu@criteo.com> <3dcbfb0d-6e54-4450-a266-bf4701e77e08@gmail.com>
 <ZrzDAlMiEK4fnLmn@yury-ThinkPad>
In-Reply-To: <ZrzDAlMiEK4fnLmn@yury-ThinkPad>
From: Erwan Velu <erwanaliasr1@gmail.com>
Date: Mon, 19 Aug 2024 12:15:10 +0200
Message-ID: <CAL2JzuzEBAdkQfRPLXQHry2a2M7_EsScOV_kheo+oXUuKM9rWA@mail.gmail.com>
Subject: Re: [PATCH] net/mlx5: Use cpumask_local_spread() instead of custom code
To: Yury Norov <yury.norov@gmail.com>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>, Erwan Velu <e.velu@criteo.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Yury Norov <ynorov@nvidia.com>, Rahul Anand <raanand@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[...]
> You may be interested in siblings-aware CPU distribution I've made
> for mana ethernet driver in 91bfe210e196. This is also an example
> where using for_each_numa_hop_mask() over simple cpumask_local_spread()
> is justified.

That's clearly a topic I'd like to discuss because the allocation
strategy may vary depending on the hardware and/or usage.
I've been investigating a case where the default mlx5 allocation isn't
what I need.

1/ I noticed that using the smp_affinity in an RFS context didn't
change the IRQ allocation and I was wondering if that is an expected
behavior.
This prevents any later tuning that an application could require.
It would be super helpful to be able to influence the placement from
the host to avoid hardcoded allocators that may not match a particular
hardware configuration.

2/ I was also wondering if we shouldn't have a kernel module option to
choose the allocation algorithm (I have a POC in that direction).
The benefit could be allowing the platform owner to select the
allocation algorithm that sys-admin needs.
On single-package AMD EPYC servers, the numa topology is pretty handy
for mapping the L3 affinity but it doesn't provide any particular hint
about the actual "distance" to the network device.
You can have up to 12 NUMA nodes on a single package but the actual
distance to the nic is almost identical as each core needs to use the
IOdie to reach the PCI devices.
We can see in the NUMA allocation logic assumptions like "1 NUMA per
package" logic that the actual distance between nodes should be
considered in the allocation logic.

In my case, the NIC is reported to Numa node 6 (of 8) (inherited from
the PXM configuration).
With the current "proximity" logic all cores are consumed within this
numa domain before reaching the next ones and so on.
This leads to a very unbalanced configuration where a few numa domains
are fully allocated when others are free.
When SMT is enabled, consuming all cores from a NUMA domain also means
using hyperthreads which could be less optimal than using real cores
from adjacent nodes.

In a hypervisor-like use case, when multiple containers from various
users run on the same system, having RFS enabled helps to have each
user have its own toil of generating traffic.
In such a configuration, it'd be better to let the allocator consume
cores from each numa node of the same package one by one to get a
balanced configuration, that would also have the advantage of avoiding
consuming hyperthreads until at least 1 IRQ per physical core is
reached.

That allocation logic could be interesting to be shared between
various drivers to allow sys admins to get a balanced IRQ mapping on
modern, multi-nodes per socket, architecture.

WDYT of having selectable logic and add this type of
"package-balanced" allocator?
Erwan,

