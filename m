Return-Path: <linux-rdma+bounces-18832-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2K3xFNaIy2kuIwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18832-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 10:41:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B6336653E
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 10:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06ECA30AB167
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 08:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBC23E3143;
	Tue, 31 Mar 2026 08:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYOeSSSF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DD43BE649;
	Tue, 31 Mar 2026 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774946282; cv=none; b=bHVOjvKVxzi7H9xJyfWuE4vOAlZtqV6ir+sJzPuri5sc3YpnUgTjtiUaZ58pZl53eTOJpm8S6qk8wUK2nT9w1TIgVu0aj2I9S4xy3sxdkMB3fJUs2xDIrdw0OnYiuQcfQXfYfCbDTsUNivNbzvs7cE16adAq7No2n45UCIAYLsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774946282; c=relaxed/simple;
	bh=lkgsi7G8x5At2O5V1snIySUQ9gANaxTJ3/quUuCINCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLQSo5WdBGnlKPkKEOJLjF1rsTtlNFSUIdIB0arzu1jm6GcIiJ4f5tCVLtAYHq1WOjdR8zeb4aGF6PQO2C2h1JFkLlRVm4k0cSJ+V2ZFAcKbFkz87VlS4cZIQTG2xNoYxII/ZHNx5AdMZptakMDoudo8j1SmuXCzzbA6QBNdHQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYOeSSSF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CB8C19423;
	Tue, 31 Mar 2026 08:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774946282;
	bh=lkgsi7G8x5At2O5V1snIySUQ9gANaxTJ3/quUuCINCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eYOeSSSFW0WXX4mmb2MsptPkJdbl34XCp/M4zjYe56EoUT29R9MHtfTXKQPdaNTCC
	 km+65bU1EFEOKw5dFVpsTcaiMT//g3eVQ5wQFTIo/I7oJ/THNQwpC5I8OveBHsLJSv
	 3TLow+1Vv81z+6ZpRvaJ+yJWkL2V+tUPyY4nPDYssx0+yV1YmWFpME3575WC2Pv8mV
	 GFTL9SNY7QSYH4J+O7uv1C5fcawUeC5d6HW7UF+4i8Box0HYi2vuZ4MBWER521nK0Q
	 SenJKH1W+1P9Rtm0e28iNy23S+AdcNCUTs9CjfxLv0EdzgY1EGenaxFTOtyUWS9Nz4
	 6i/D/wPac9ByA==
Date: Tue, 31 Mar 2026 11:37:58 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Zhiping Zhang <zhipingz@meta.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RFC v2 1/2] vfio: add callback to get tph info for dmabuf
Message-ID: <20260331083758.GA814676@unreal>
References: <20260324234615.3731237-1-zhipingz@meta.com>
 <20260324234615.3731237-2-zhipingz@meta.com>
 <20260325082534.GN814676@unreal>
 <acW2BwQKaUbS3eL9@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acW2BwQKaUbS3eL9@kbusch-mbp>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18832-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E8B6336653E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 04:41:11PM -0600, Keith Busch wrote:
> On Wed, Mar 25, 2026 at 10:25:34AM +0200, Leon Romanovsky wrote:
> > On Tue, Mar 24, 2026 at 04:46:02PM -0700, Zhiping Zhang wrote:
> > >  struct vfio_device_feature_dma_buf {
> > >  	__u32	region_index;
> > >  	__u32	open_flags;
> > > -	__u32   flags;
> > > -	__u32   nr_ranges;
> > > +	__u32	flags;
> > > +#define VFIO_DMABUF_FL_TPH		(1U << 0) /* TPH info is present */
> > > +#define VFIO_DMABUF_TPH_PH_SHIFT	1         /* bits 1-2: PH (2-bit) */
> > > +#define VFIO_DMABUF_TPH_PH_MASK	0x6U
> > > +#define VFIO_DMABUF_TPH_ST_SHIFT	16        /* bits 16-31: steering tag */
> > > +#define VFIO_DMABUF_TPH_ST_MASK		0xffff0000U
> > 
> > This extension of flags is basically kills future extension of this
> > struct for anything that includes TPH.
> > 
> > Add new
> > enum vfio_device_feature_dma_buf_flags {
> >     VFIO_DMABUF_FL_TPH  = 1 << 0
> > }
> > 
> > > +	__u32	nr_ranges;
> > 
> > add your "__u16 steering_tag" and "__u8 ph" fields here.
> 
> You're suggesting that Ziping append the new fields to the end of this
> struct? I don't think we can modify the layout of a uapi.

He needs to add before flex array. This struct is submitted by the user
and kernel can easily calculate the position of that array.

Something like this:
diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index b1d658b8f7b51..d78d915992232 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -237,7 +237,11 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
        if (get_dma_buf.region_index >= VFIO_PCI_ROM_REGION_INDEX)
                return -ENODEV;

-       dma_ranges = memdup_array_user(&arg->dma_ranges, get_dma_buf.nr_ranges,
+       if (!tph_supplied)
+               dma_ranges = memdup_array_user(old_dma_ranges_pos, get_dma_buf.nr_ranges,
+                                      sizeof(*dma_ranges));
+       else
+               dma_ranges = memdup_array_user(&arg->dma_ranges, get_dma_buf.nr_ranges,
                                       sizeof(*dma_ranges));
        if (IS_ERR(dma_ranges))
                return PTR_ERR(dma_ranges);
~


Thanks

> 
> If we can't carve the space for this out of the existing unused flags
> field, I think we'd have to introduce a new vfio device feature that
> basically copies VFIO_DEVICE_FEATURE_DMA_BUF with the extra hints
> fields.
>  
> > >  	struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
> > >  };

