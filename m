Return-Path: <linux-rdma+bounces-19598-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDySAbCs72lIDwEAu9opvQ
	(envelope-from <linux-rdma+bounces-19598-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 20:36:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B4A478AEB
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 20:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9321C30277E4
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 18:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AB43EBF06;
	Mon, 27 Apr 2026 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1pRr7EI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2D435F8C9;
	Mon, 27 Apr 2026 18:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777314922; cv=none; b=TbxVWDTXN/AnZqBX4svTev63SRWCgjDMegyjfElNkDA2VL8+gTx6C4QZ5D4ZEiykcdYa6yYrOW8dfUnktcwq/HyfpoWd/jpxEOiRGUpwTjTYJcdzP7xSfNE/z9RF1jml+dhDUXqbUouxi8mPs/WAMOLPvhJaLkALp8Ou3H3Sm4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777314922; c=relaxed/simple;
	bh=dt17/Yw/X7ftyXzeJoajfSmoBv1aq9SCt2MF5Y2JdVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3xipk+L30p/bfFK++jhyiI4jW9xR0FUb2qtsasAtf/UxzUN2/Tn+lQS8xLgrkBV1SN7FwZNv5cNlU5BiE+iVT6LHFhhxCsxPNujKnsMlUJwCRqYDw6JM4j1glwUzdQIYK0JlGUdsJMtEsk0nnIcz0VmwuZSZHTK4zPc+UO6z2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1pRr7EI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1CFEC19425;
	Mon, 27 Apr 2026 18:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777314921;
	bh=dt17/Yw/X7ftyXzeJoajfSmoBv1aq9SCt2MF5Y2JdVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O1pRr7EI1PG1hjtjKdpAdfc+2s7DW0qoJ5kB20Ugw89Jv80juk123xO1KqCYRJP62
	 i1fX+6A1M+MoaYEi705G2F+4y73YfmHnG+UYMTpX8UCi5kh9q6fI3dlsDXg6ykxjjO
	 bnECLzldef1WsMK+ZycKb8ibIoPXIPgZ9PK4xnuQ7JThI9vBxqJAXtG6zLt8N/jYGQ
	 +mRl8XWRM2a1bPrYVRemksBiIcZUBV2udHlt7IQVsC8VfIGj/3wpN++CXKC1TUxDPE
	 YcB/RMUHxzycUhlVghl/khiwAz5yC1ETvZpkenO/AJgRmoecHc6DRHmd5Ii60qwPXU
	 5Cmi32sxE5O6A==
Date: Mon, 27 Apr 2026 21:35:13 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Alex Williamson <alex@shazbot.org>, Stanislav Fomichev <sdf@meta.com>,
	Keith Busch <kbusch@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Bjorn Helgaas <helgaas@kernel.org>, linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH v1 1/2] vfio: add callback to get tph info for dma-buf
Message-ID: <20260427183513.GK440345@unreal>
References: <20260420183920.3626389-1-zhipingz@meta.com>
 <20260420183920.3626389-2-zhipingz@meta.com>
 <20260422092327.3f629ad6@shazbot.org>
 <20260427133746.GJ440345@unreal>
 <CAH3zFs2Sy0mv=QkK4VSV+MVR=ef_CdoxMhTFgzaqoZ+uSOpxoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH3zFs2Sy0mv=QkK4VSV+MVR=ef_CdoxMhTFgzaqoZ+uSOpxoQ@mail.gmail.com>
X-Rspamd-Queue-Id: 67B4A478AEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19598-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 07:28:57AM -0700, Zhiping Zhang wrote:
> On Mon, Apr 27, 2026 at 6:37 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > >
> > On Wed, Apr 22, 2026 at 09:23:27AM -0600, Alex Williamson wrote:
> > > On Mon, 20 Apr 2026 11:39:15 -0700
> > > Zhiping Zhang <zhipingz@meta.com> wrote:
> > >
> > > > Add a dma-buf callback that returns raw TPH metadata from the exporter
> > > > so peer devices can reuse the steering tag and processing hint
> > > > associated with a VFIO-exported buffer.
> > > >
> > > > Keep the existing VFIO_DEVICE_FEATURE_DMA_BUF uAPI layout intact by
> > > > using a flag plus one extra trailing entries[] object for the optional
> > > > TPH metadata. Rename the uAPI field dma_ranges to entries. The
> > > > nr_ranges field remains the DMA range count; when VFIO_DMABUF_FLAG_TPH
> > > > is set the kernel reads one extra entry beyond nr_ranges for the TPH
> > > > metadata.
> > > >
> > > > Add an st_width parameter to get_tph() so the exporter can reject
> > > > steering tags that exceed the consumer's supported width (8 vs 16 bit).
> > > > When no TPH metadata was supplied, make get_tph() return -EOPNOTSUPP.
> > > >
> > > > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > > > ---
> > > >  drivers/vfio/pci/vfio_pci_dmabuf.c | 62 +++++++++++++++++++++++-------
> > > >  include/linux/dma-buf.h            | 17 ++++++++
> > > >  include/uapi/linux/vfio.h          | 28 ++++++++++++--
> > > >  3 files changed, 89 insertions(+), 18 deletions(-)
> >
> > <...>
> >
> > > > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > > > index bb7b89330d35..a0bd24623c52 100644
> > > > --- a/include/uapi/linux/vfio.h
> > > > +++ b/include/uapi/linux/vfio.h
> > > > @@ -1490,16 +1490,36 @@ struct vfio_device_feature_bus_master {
> > > >   * open_flags are the typical flags passed to open(2), eg O_RDWR, O_CLOEXEC,
> > > >   * etc. offset/length specify a slice of the region to create the dmabuf from.
> > > >   * nr_ranges is the total number of (P2P DMA) ranges that comprise the dmabuf.
> > > > + * When VFIO_DMABUF_FLAG_TPH is set, entries[] contains one extra trailing
> > > > + * object after the nr_ranges DMA ranges carrying the TPH steering tag and
> > > > + * processing hint.
> > >
> > > I really don't think we want to design an API where entries is
> > > implicitly one-off from what's actually there.  This feeds back into
> > > the below removal of the __counted by attribute, which is a red flag
> > > that this is the wrong approach.
> >
> > I believe removing `__counted` is a mistake. In my proposal, the intent
> > was to adjust the meaning of the storage object based on the flag bit.
> > The size of the array should still be represented correctly.
> >
> > Thanks
> 
> Thanks Leon — you're right that __counted_by should be preserved. In
> your approach, when the flag is set, the last entry in the array
> carries the TPH data, so the effective DMA range count is nr_ranges -
> 1.

It is correct only if you keep the original name *nr_range*. However, the
variable name is worth changing to something clearer, such as
*nr_array_elements*.

> 
> That said, after discussing internally, we're leaning toward
> introducing a new VFIO device feature with dedicated TPH fields (as
> Alex suggested too), to avoid overloading vfio_region_dma_range with a
> union that changes semantics based on position.
> 
> Would you have concerns with that direction? I'll post a v3 with the
> new approach.

I don’t have any concerns. My only worry was about “stealing” too many  
bits from the flags variable, and you’ve avoided that here.

Thanks

