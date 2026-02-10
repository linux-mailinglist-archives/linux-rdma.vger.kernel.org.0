Return-Path: <linux-rdma+bounces-16708-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JVEGINMi2mWTwAAu9opvQ
	(envelope-from <linux-rdma+bounces-16708-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 16:19:31 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 024F511C68F
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 16:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C5F03032CFB
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 15:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3038A327C1C;
	Tue, 10 Feb 2026 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="X9HR9Zvz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CADB67E;
	Tue, 10 Feb 2026 15:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770736762; cv=none; b=NANDzYjzmxfYD09G/hdAdOwLlBTjNqE775xPdwyhGKDyGOs3zYYYJxjABIsWQ8Fs07nDR4cI0ptUZ+Nvu8LMG8Q0HNnQE7Ibxchk5qQHgjmQaH36AS+g6ohSdMbkY83pgeJ8aF3nP+PofPo7AjPuVeLZ8wVnqZHVw4h4mtgIZpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770736762; c=relaxed/simple;
	bh=cIifu87CNyPJVLlB/RlNpFS13N1yF4sq1z+QgICwMeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNhm9TtK1k9Xkc0WEKKzK500yyq5VFTPv5fZj5hjmJXCI4JX7ONDHiaBvbcuOjiMBQWPVTZm6ZGbpJbtbIabQVknY/qc+w4jhZG9SPqgUyzKff21SC4jVH0zIt2mdD2kHx4X3V4aoVtDEPao+7AG/3WKzMavhKDTcHnO7MrwLdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=X9HR9Zvz; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=urcuhDVp7Oul0ufIx3aZnCiehPqHUufYMHJ5jXHBg4U=; b=X9HR9ZvzAXGXJ9I0eL7kb/WMeW
	iusmt9LYTf5JtnFNzXMHReZVV147+jHgRkL6GWyGb644VpI7vaPOt63NOe/Cc1FrQngRVAmbkNNf5
	7mCIBw6rixY4jMW/NfYQ2205W3xg6pXDVflI29xqYh1Pec7RDdw+9K5oZZ3JMfFW/l2Eqk3EsT8Zl
	mD9nbqWebkUDEhuNRGpoy8G7B19MoJMxTfKkHzHn83jkSQg5D24HIbEgT4DWVPLU/6l4sN/DQ2RYU
	pHwn0TqUrlaGQ3WMOaw2VFiqAXLw0ORoz5yDkU/rU++Krqy1X0AW6rQe2TRL+u919/bH6x2iJnmvr
	guIWdJ5g==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vppVo-00ALkf-QI; Tue, 10 Feb 2026 15:18:49 +0000
Date: Tue, 10 Feb 2026 07:18:43 -0800
From: Breno Leitao <leitao@debian.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Amir Vadai <amirv@mellanox.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, dcostantino@meta.com, 
	rneu@meta.com, kernel-team@meta.com
Subject: Re: [PATCH net] net/mlx5e: Skip NAPI polling when PCI channel is
 offline
Message-ID: <aYtIrl01U0uHo7RP@gmail.com>
References: <20260209-mlx5_iommu-v1-1-b17ae501aeb2@debian.org>
 <49fe0af5-7dcf-42e0-bd73-0bd42c067d26@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49fe0af5-7dcf-42e0-bd73-0bd42c067d26@huawei.com>
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-16708-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 024F511C68F
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 10:19:46AM +0800, Jijie Shao wrote:
> 
> on 2026/2/10 2:01, Breno Leitao wrote:
> > When a PCI error (e.g. AER error or DPC containment) marks the PCI
> > channel as frozen or permanently failed, the IOMMU mappings for the
> > device may already be torn down. If mlx5e_napi_poll() continues
> > processing CQEs in this state, every call to dma_unmap_page() triggers
> > a WARN_ON in iommu_dma_unmap_phys().
> 
> Hi:
>   My comment has nothing to do with the changes made in this patch itself.
> 
> 
> I am more interested in this error itself.
> 1. If there is an issue with dma_unmp, does dma_map in tx have a similar problem?

I suspect that dma_map will succeed in such a case (when the DMA maps are
gone). 

dma_map_single/dma_map_page creates new page table entries — it doesn't look up
existing ones. Even if existing mappings are gone, new mappings succeed !?

I haven't seen this instance on the TX path as well.

> 2. Can this error be detected by mlx5_pci_err_detected()? If not, does this mean that all PCIe NIC drivers might have similar issues?

mlx5_pci_err_detected() is called for the device under DPC — that's not the
issue.

From my naive view, the issue seems to be timing: there's a potential race
between DPC setting the PCI channel to frozen and the error handler completing
(which eventually calls napi_disable_locked).

During that window, NAPI poll can still fire and process CQEs, triggering the
dma_unmap WARN_ON storm, and crash.

>    Do other drivers need to do similar checks?

I really don't know, honestly. Are other drivers solving the problem
differently?! 

Thanks for the question,
--breno

