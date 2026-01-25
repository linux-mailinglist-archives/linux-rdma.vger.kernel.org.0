Return-Path: <linux-rdma+bounces-15989-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fi4DOVspdmm/MgEAu9opvQ
	(envelope-from <linux-rdma+bounces-15989-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 15:31:55 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B43E80FD1
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 15:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D987F30062F4
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 14:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EECA19D065;
	Sun, 25 Jan 2026 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTkvRXxY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F276911CBA;
	Sun, 25 Jan 2026 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769351509; cv=none; b=aGnMLeH3ZOIdU3U0nnSmdifzYLpM8WBNMBP/o/QTdWCf5hmw4a69G7Xs9cw7hj11ludw9osdMCoAu15OV+K12ONobXj0dZkn2Q7Lmz3thipLX3g8MrvL1LCOw77gHgWXMpIjqRZNGG3vvslgWo9Hg2Icn1fpmuO9CJgJ/3eepW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769351509; c=relaxed/simple;
	bh=zOgHA3zT5qhfU5Vq32Czc4u+R9VVf3Wq9HUKcNzPAUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmNHBKFKf+mczwHSOaSLZK3CxuGJnMmUWDW6pSflehLGLUsULX4+yI6gqzRRPh0ENIfgW3jnmqWBczBZgwSgX0JyXuiiX15yFINA5Rb1sE2S7ny5QXP4f1w15KSlya3qVR5oO9hmEXJzOKvoQUB01vvmVzGR369/iK96XNZN/ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTkvRXxY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA87C4CEF1;
	Sun, 25 Jan 2026 14:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769351508;
	bh=zOgHA3zT5qhfU5Vq32Czc4u+R9VVf3Wq9HUKcNzPAUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WTkvRXxYCq4rqRUu+Nur148XeKAbzwYqqq8/4hg4ggEgXsF+jL1OM7oJidh+/dg6C
	 daVMADVeejXPxRnV8zcl3+D83OEtOX43pZ8Ima/DfvRmwEiKYYZhPYl+Fwf2T7VZa7
	 iPrzbYqAQG+kUMC7eWSkJTjO2EoCAHTnrxob+QZ+JmLQYyLa7Pd5C1QmdP9eTj32Lg
	 /3ErVTrVEwYm8QER1ULPCTDnxeIFvlEIjc/jSqH0wcRlTwaWJmFSJpmRzY+8pLKD70
	 99rBtzDkK3iF7OOmyg90juuFBs0DSKYQmrOa3Mhu37AJHVuOgGmBesMjrKiCiwYJr0
	 Ni7TchE2YtFZg==
Date: Sun, 25 Jan 2026 16:31:43 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Edward Srouji <edwards@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next 1/2] RDMA/uverbs: Add DMABUF object type and
 operations
Message-ID: <20260125143143.GF13967@unreal>
References: <20260108-dmabuf-export-v1-0-6d47d46580d3@nvidia.com>
 <20260108-dmabuf-export-v1-1-6d47d46580d3@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260108-dmabuf-export-v1-1-6d47d46580d3@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15989-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B43E80FD1
X-Rspamd-Action: no action

On Thu, Jan 08, 2026 at 01:11:14PM +0200, Edward Srouji wrote:
> From: Yishai Hadas <yishaih@nvidia.com>
> 
> Expose DMABUF functionality to userspace through the uverbs interface,
> enabling InfiniBand/RDMA devices to export PCI based memory regions
> (e.g. device memory) as DMABUF file descriptors. This allows
> zero-copy sharing of RDMA memory with other subsystems that support the
> dma-buf framework.
> 
> A new UVERBS_OBJECT_DMABUF object type and allocation method were
> introduced.
> 
> During allocation, uverbs invokes the driver to supply the
> rdma_user_mmap_entry associated with the given page offset (pgoff).
> 
> Based on the returned rdma_user_mmap_entry, uverbs requests the driver
> to provide the corresponding physical-memory details as well as the
> driver’s PCI provider information.
> 
> Using this information, dma_buf_export() is called; if it succeeds,
> uobj->object is set to the underlying file pointer returned by the
> dma-buf framework.
> 
> The file descriptor number follows the standard uverbs allocation flow,
> but the file pointer comes from the dma-buf subsystem, including its own
> fops and private data.
> 
> Because of this, alloc_begin_fd_uobject() must handle cases where
> fd_type->fops is NULL, and both alloc_commit_fd_uobject() and
> alloc_abort_fd_uobject() must account for whether filp->private_data
> exists, since it is only populated after a successful dma_buf_export().
> 
> When an mmap entry is removed, uverbs iterates over its associated
> DMABUFs, marks them as revoked, and calls dma_buf_move_notify() so that
> their importers are notified.
> 
> The same procedure applies during the disassociate flow; final cleanup
> occurs when the application closes the file.
> 
> Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
> Signed-off-by: Edward Srouji <edwards@nvidia.com>
> ---
>  drivers/infiniband/core/Makefile                  |   1 +
>  drivers/infiniband/core/device.c                  |   2 +
>  drivers/infiniband/core/ib_core_uverbs.c          |  19 +++
>  drivers/infiniband/core/rdma_core.c               |  63 ++++----
>  drivers/infiniband/core/rdma_core.h               |   1 +
>  drivers/infiniband/core/uverbs.h                  |  10 ++
>  drivers/infiniband/core/uverbs_std_types_dmabuf.c | 172 ++++++++++++++++++++++
>  drivers/infiniband/core/uverbs_uapi.c             |   1 +
>  include/rdma/ib_verbs.h                           |   9 ++
>  include/rdma/uverbs_types.h                       |   1 +
>  include/uapi/rdma/ib_user_ioctl_cmds.h            |  10 ++
>  11 files changed, 263 insertions(+), 26 deletions(-)

<...>

> +static struct sg_table *
> +uverbs_dmabuf_map(struct dma_buf_attachment *attachment,
> +		  enum dma_data_direction dir)
> +{
> +	struct ib_uverbs_dmabuf_file *priv = attachment->dmabuf->priv;
> +
> +	dma_resv_assert_held(priv->dmabuf->resv);
> +
> +	if (priv->revoked)
> +		return ERR_PTR(-ENODEV);
> +
> +	return dma_buf_phys_vec_to_sgt(attachment, priv->provider,
> +				       &priv->phys_vec, 1, priv->phys_vec.len,
> +				       dir);
> +}
> +
> +static void uverbs_dmabuf_unmap(struct dma_buf_attachment *attachment,
> +				struct sg_table *sgt,
> +				enum dma_data_direction dir)
> +{
> +	dma_buf_free_sgt(attachment, sgt, dir);
> +}

Unfortunately, it is not enough. Exporters should count their
map<->unmap calls and make sure that they are equal.

See this VFIO change https://lore.kernel.org/kvm/20260124-dmabuf-revoke-v5-4-f98fca917e96@nvidia.com/

Thanks

