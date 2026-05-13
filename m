Return-Path: <linux-rdma+bounces-20535-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MeEKrTYA2ol/AEAu9opvQ
	(envelope-from <linux-rdma+bounces-20535-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 03:49:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCA952C12B
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 03:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAAD3300D87F
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 01:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A60382379;
	Wed, 13 May 2026 01:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="imxPtnhJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65335379980;
	Wed, 13 May 2026 01:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778636972; cv=none; b=sbwB4uOFyN2KhOarmulZPN3fvWXzS7t4h0fUyWJa0xPk4QQ3gG4s4pRe3kDpE4fapVT8+8zy0wLyF62e9ps4/NV9LSNfwtmvWxE15xDwb6DNh8pM0Q58LJshmmznYcVWVcDB0kK2j+3PbMcdeLDCDUXq/Zcg5Z/QCLzJFIKTkIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778636972; c=relaxed/simple;
	bh=HV+ii9VjDFnBttMvyLtOoXmLfYTvcvs3OJ+uR1uFXsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EoDmhXCgKkqBXebxPLYusErnUjL7MZVwL1mvd22Yrgtdhcfj0yqlkpPBwqUgGXyMo0e2Qlh0lm8Gmk5DbBT9AUIrBMTWaIq0qxtooKs5z0GB5b5xUwGpHV0T4FE8NSYZcNc/r6o7YTwmY781udKS8RgNSZ1Nn/MEwziwWAjJn9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=imxPtnhJ; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1QPd0/wQRL2rpFFHXggBsfXQ3q5bbcdXUBEQwFMmobY=;
	b=imxPtnhJl4i9km34mrSU/FVG1amcCI38T36mo7t9LLstpZydxhK7KB1glydHi/bBXzTxSAAue
	3/hqS6kWUqZmevDluMwfuIwdaAJ9hxBbKMwjwREu3LjCo414BQRw5ANwONpfB5FdMHRJt14nnNP
	gb/22009IDDfzp/PuEt2YL0=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gFbm96x0BzmV9L;
	Wed, 13 May 2026 09:41:45 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 0BE44402AB;
	Wed, 13 May 2026 09:49:24 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 May 2026 09:49:23 +0800
Message-ID: <d5b26695-f1fd-4cb6-8e19-201f689eceaf@huawei.com>
Date: Wed, 13 May 2026 09:49:22 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] RDMA/mlx5: get tph for p2p access when registering
 dma-buf mr
To: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, <kvm@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, Keith Busch
	<kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>, Yishai Hadas
	<yishaih@nvidia.com>
References: <20260512184755.4137227-1-zhipingz@meta.com>
 <20260512184755.4137227-3-zhipingz@meta.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260512184755.4137227-3-zhipingz@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk500009.china.huawei.com (7.202.194.94)
X-Rspamd-Queue-Id: 0BCA952C12B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-20535-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fengchengwen@huawei.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:mid,huawei.com:dkim,meta.com:email]
X-Rspamd-Action: no action

On 5/13/2026 2:47 AM, Zhiping Zhang wrote:
> Query dma-buf TPH metadata when registering a dma-buf MR for peer to
> peer access and translate the raw steering tag into an mlx5 steering
> tag index. Factor mlx5_st_alloc_index() so callers that already have a
> raw steering tag can allocate the corresponding mlx5 index directly.
> Keep the DMAH path as the first priority and only fall back to dma-buf
> metadata when no DMAH is supplied.
> 
> Add pcie_tph_get_st_width() so the mlx5 IB driver can query the
> device's negotiated ST width without poking pci_dev::tph_req_type
> directly (that field is gated by CONFIG_PCIE_TPH and would otherwise
> break !CONFIG_PCIE_TPH builds). Pass the width to the dma-buf
> get_tph() callback so the exporter can return the value that matches
> the consumer's capability.

1\ Recommend the PCI/TPH modification be committed separately.
2\ How about rename it to pcie_tph_enabled_req_type() ? so we could
   use already defined macro:
#define   PCI_TPH_REQ_DISABLE		0x0 /* No TPH requests allowed */
#define   PCI_TPH_REQ_TPH_ONLY		0x1 /* TPH only requests allowed */
#define   PCI_TPH_REQ_EXT_TPH		0x3 /* Extended TPH requests allowed */

> 
> Pass the dma_buf pointer that the umem already resolved into
> get_tph_mr_dmabuf() instead of re-resolving the user-supplied fd.
> Re-resolving opens a TOCTOU where a concurrent dup2() can substitute a
> different dma_buf between umem creation and TPH lookup.
> 
> Track the per-MR ownership of the allocated mlx5 ST index on
> mlx5_ib_mr (dmabuf_st_index / dmabuf_st_owned) and release it once the
> firmware mkey no longer references it. Both the cached path
> (mlx5r_umr_revoke_mr_with_lock + ib_frmr_pool_push) and the
> destroy_mkey path call mlx5_ib_mr_put_dmabuf_st() so the ST index does
> not leak when the MR is reused from the FRMR pool.
> 
> Initialize ret in mlx5_st_create() so the cached steering-tag path
> returns success cleanly under clang builds.
> 
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> ---
>  drivers/infiniband/hw/mlx5/mlx5_ib.h          |  6 ++
>  drivers/infiniband/hw/mlx5/mr.c               | 72 ++++++++++++++++++-
>  .../net/ethernet/mellanox/mlx5/core/lib/st.c  | 27 ++++---
>  drivers/pci/tph.c                             | 20 ++++++
>  include/linux/mlx5/driver.h                   |  7 ++
>  include/linux/pci-tph.h                       |  2 +
>  6 files changed, 124 insertions(+), 10 deletions(-)
> 

...

