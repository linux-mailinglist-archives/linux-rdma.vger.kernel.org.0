Return-Path: <linux-rdma+bounces-21141-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Lf+JDuGD2p0NAYAu9opvQ
	(envelope-from <linux-rdma+bounces-21141-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 00:24:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9595AC55A
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 00:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12769302BDE5
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 22:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD583624B8;
	Thu, 21 May 2026 22:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="mqaQyKe6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XVeaHwM6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2BC1A9B58;
	Thu, 21 May 2026 22:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779402284; cv=none; b=lGwDzrzQ5/yCdEGh6dEmp8iO8qH3csRBaF8ZKhcfgCd/qMXltuSrqol+v/N3Jed9ttmKK46HOfmw1yY+hwzWTThnTxUMqDMGn6sBL3V6a5dKx/K5aYTSTnf6q/Ld4Lesw6HToTCRUPoJVdO/N2wwlx5XP52qAJzfn+6Hu+XTa/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779402284; c=relaxed/simple;
	bh=ZkZNySfc+JZP7BIMuTVeYVh1G5jAV5afGX24S+rsrR0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q+NE3LGmCu7m55GuBreK7AQ2fVEKLhWyszawt8ZdTo7D4XCh2w3hYMEX7xKJ1c5Tkqsbh5+2zh6cczkHEZqNxn8dadpCXWFv1ay+K2sRkwsPdy9uecTT51oXFYcN4k260dRVOhzGFjz9pwcCgaCT/b9SnvsWBH+eSZ6Bh1NrxJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=mqaQyKe6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XVeaHwM6; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 3E7251D00081;
	Thu, 21 May 2026 18:24:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 21 May 2026 18:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779402280;
	 x=1779488680; bh=7jolSoc5xzaKtei7c0bKGfi2PyAu6NwKiCmKyaxCEFc=; b=
	mqaQyKe6C3vrBTmWJGh9fVaOWbgoWASNHGrIaJln7nXei7LRICrlbItUiPYkukg1
	AAbfL4nrYtcsVrohsWB4+Ybsh8WDrmTtIz3tEL2XDIe/XUElNL4d9ap1fGF3NNXz
	1aPOaWlnUHTK/iQt1ZEfL9DQexG1Yp/GM2ZjQ6jHEdjL66onnxRhKf//1yNBsw0N
	DdoNbmuWQP2k6sPhOlkReiwx+I0T80Vtq8fSsiKfL0/dV/CY/pgrrl8j7df03nKx
	fRWKJeDXJz62Y0GhWm1I11hzDW9+cZQ1RUozs3LUyMZj0talAcchAmsCzXX15laj
	BkffJRDPEkrhpPhjLwLDBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779402280; x=
	1779488680; bh=7jolSoc5xzaKtei7c0bKGfi2PyAu6NwKiCmKyaxCEFc=; b=X
	VeaHwM6BNeAxs5ldFBJ2txxXYsugjwMeP+mZhXhROxAb61Zag7GuW6Kphmj/uhUP
	qiWW9Zn85/QCQKVRVmvK7bHyTessZ+hE9/MK7v3kjvbn6u5PIlc2xcvE4oKVWnSf
	W2/QFm6UHjRcbGHpZGPxYL0bfaTuabCle+le9sDlqc/Zcp8BViOLEall91G0xLZk
	TD5pkJaDvifoa1AeQP3SwmOCn9ZOKvDfKyMCZwXJ0R44VJmxdWJDqKnXBEm3v5bW
	7cpG6ARCWYDzKFyXJjqQipLX2VoiRv4sXOj6CIE2HfGTB8exPTDYxUfLs8F1/F5s
	J1xsOoN2QIaNpXLAAUuLg==
X-ME-Sender: <xms:J4YPaukgnmNTcTKoOkzYsM8x2rn5vEp8nwqga_RzF2hj0c4tQ6koXw>
    <xme:J4YParCgMRH224NeIWGrVfL4OhR5KDzj25oOxFzxc6_dmuguFwSNQc9GtgJDO9-2o
    MzfjlT09Ld6d86MGgpKSyqZ0J0gfLC39nDXBoV-QYGCEUOiM0ReYA>
X-ME-Received: <xmr:J4YPagATKsrXswZA5KNXMLscqcNtCipUACZrGJr0JsvpY0_I0-PeY5DkPqk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeekjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepudefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopeiihhhiphhinhhgiiesmhgvthgrrdgtohhmpdhrtg
    hpthhtohepjhhgghesiihivghpvgdrtggrpdhrtghpthhtoheplhgvohhnsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehkvhhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqrhgumhgrsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurhhiqdguvghvvghlsehlih
    hsthhsrdhfrhgvvgguvghskhhtohhprdhorhhg
X-ME-Proxy: <xmx:J4YPaiFWGgOh0m_ohvj4pxxN7MaoiPkbDA2d7AdDOQG9jEfGDthQtQ>
    <xmx:J4YPan7lf-JmCAlDD58VwiWL1wTWROxTIOMOJoVbCRcagAuKJ44PvQ>
    <xmx:J4YPapRqrG0AHiU9lVPWXVGsjHb7jgK-oW2jejTixHMqwue0izHM4g>
    <xmx:J4YPai7qVXWjh-eIgNfe_XvB7Dud7ADmdVyKIx3P4tN5XynJDQkyUQ>
    <xmx:KIYPatD_uSA_QuIg5emqSgilXCTSNWmvMRjt-M012kvAZ13y2vVybVtU>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 18:24:38 -0400 (EDT)
Date: Thu, 21 May 2026 16:24:37 -0600
From: Alex Williamson <alex@shazbot.org>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Bjorn
 Helgaas <helgaas@kernel.org>, <kvm@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <netdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, Keith Busch
 <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>, Yishai Hadas
 <yishaih@nvidia.com>, alex@shazbot.org
Subject: Re: [PATCH v4 1/3] vfio: add dma-buf get_tph callback and
 DMA_BUF_TPH feature
Message-ID: <20260521162437.406085db@shazbot.org>
In-Reply-To: <20260521160412.4fa75406@shazbot.org>
References: <20260519201401.1558410-1-zhipingz@meta.com>
	<20260519201401.1558410-2-zhipingz@meta.com>
	<20260521160412.4fa75406@shazbot.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[shazbot.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[shazbot.org:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-21141-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[shazbot.org:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@shazbot.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shazbot.org:email,shazbot.org:mid,shazbot.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,meta.com:email,set_tph.ph:url,messagingengine.com:dkim]
X-Rspamd-Queue-Id: EC9595AC55A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026 16:04:12 -0600
Alex Williamson <alex@shazbot.org> wrote:

> On Tue, 19 May 2026 13:13:49 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
> 
> > Add a dma-buf get_tph callback for exporters to return TPH
> > (TLP Processing Hints) metadata, and add VFIO_DEVICE_FEATURE_DMA_BUF_TPH
> > so userspace can attach that metadata to a VFIO-exported dma-buf.  
> 
> This should be two patches, the first extending the dma-buf framework
> for the get_tph callback for explicit approval from dma-buf maintainers
> (who are not even copied here).  The second the vfio-pci implementation
> of get_tph.
>  
> > 8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces; the
> > uAPI carries both with explicit validity flags so importers get the
> > value matching their requested width. SET is write-once per dma-buf;
> > the existing VFIO_DEVICE_FEATURE_DMA_BUF uAPI is unchanged.  
> 
> I didn't see what motivated this write-once change, I thought we
> understood that it was a userspace problem that the tph values need to
> be set before providing the dma-buf fd to the importer and that races
> relative to that are a userspace ordering problem.  Write-once seems
> unnecessarily restrictive and there's no justification provided here.
>  
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_core.c   |   3 +
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 134 +++++++++++++++++++++++++++--
> >  drivers/vfio/pci/vfio_pci_priv.h   |  12 +++
> >  include/linux/dma-buf.h            |  21 +++++
> >  include/uapi/linux/vfio.h          |  35 ++++++++
> >  5 files changed, 198 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> > index 3f8d093aacf8..94aa6dd95701 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -1534,6 +1534,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
> >  		return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
> >  	case VFIO_DEVICE_FEATURE_DMA_BUF:
> >  		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
> > +	case VFIO_DEVICE_FEATURE_DMA_BUF_TPH:
> > +		return vfio_pci_core_feature_dma_buf_tph(vdev, flags, arg,
> > +							 argsz);
> >  	default:
> >  		return -ENOTTY;
> >  	}
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > index f87fd32e4a01..be1c65385670 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -19,7 +19,24 @@ struct vfio_pci_dma_buf {
> >  	u32 nr_ranges;
> >  	struct kref kref;
> >  	struct completion comp;
> > -	u8 revoked : 1;
> > +	/*
> > +	 * TPH metadata published by VFIO_DEVICE_FEATURE_DMA_BUF_TPH and
> > +	 * consumed by the @get_tph dma-buf callback.
> > +	 *
> > +	 * @tph_flags is the publish/consume gate: writers populate
> > +	 * @steering_tag, @steering_tag_ext and @ph first, then store
> > +	 * @tph_flags with smp_store_release(); readers do
> > +	 * smp_load_acquire(&tph_flags) before accessing the value fields.
> > +	 * @tph_flags == 0 means "TPH not set". Writers publish a non-zero
> > +	 * value only once per dma-buf and serialize via vdev->memory_lock;
> > +	 * readers stay lockless to avoid AB-BA against the dma_resv_lock held
> > +	 * by importers.
> > +	 */  
> 
> Can you outline the ABBA hazard, I'm not seeing it.  You're acquiring
> memory_lock in the feature SET and dma_resv_lock doesn't appear to be
> held when calling .get_tph().  There's a lot of lockless complication
> here balanced on this claim of avoiding a hazard that doesn't appear
> present.
> 
> > +	u32 tph_flags;
> > +	u16 steering_tag_ext;
> > +	u8 steering_tag;
> > +	u8 ph;
> > +	bool revoked;  
> 
> If we still used memory_lock for tph, these could be:
> 
> 	u8 tph_st_valid:1; /* memory_lock */
> 	u8 tph_st_ext_valid:1; /* memory_lock */
> 	u8 tph_ph:2; /* memory_lock */
> 	u8 tph_st;
> 	u16 tph_st_ext;
> 	u8 revoked:1; /* dma_resv_lock */
> 
> The existing change of @revoked from bitfield to bool has no rationale
> noted for it in the commit log.

On second thought, what dependency does anything here have on
memory_lock?  I think we're jumping through hoops to avoid a lock we
don't even need.  If we just want to serialize SET vs get_tph we could
have a mutex on the dma-buf structure, or use RCU if we want to manage
it locklessly and make sure get_tph always sees a fully consistent set
of values.  Thanks,

Alex

> >  };
> >  
> >  static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
> > @@ -69,6 +86,36 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *attachment,
> >  	return ret;
> >  }
> >  
> > +static int vfio_pci_dma_buf_get_tph(struct dma_buf *dmabuf, u16 *steering_tag,
> > +				    u8 *ph, u8 st_width)
> > +{
> > +	struct vfio_pci_dma_buf *priv = dmabuf->priv;
> > +	u32 flags;
> > +
> > +	/* Pair with the smp_store_release() in VFIO_DEVICE_FEATURE_DMA_BUF_TPH. */
> > +	flags = smp_load_acquire(&priv->tph_flags);
> > +	if (!flags)
> > +		return -EOPNOTSUPP;
> > +
> > +	switch (st_width) {
> > +	case 8:
> > +		if (!(flags & VFIO_DMA_BUF_TPH_ST))
> > +			return -EOPNOTSUPP;
> > +		*steering_tag = priv->steering_tag;
> > +		break;
> > +	case 16:
> > +		if (!(flags & VFIO_DMA_BUF_TPH_ST_EXT))
> > +			return -EOPNOTSUPP;
> > +		*steering_tag = priv->steering_tag_ext;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	*ph = priv->ph;
> > +	return 0;
> > +}
> > +
> >  static void vfio_pci_dma_buf_unmap(struct dma_buf_attachment *attachment,
> >  				   struct sg_table *sgt,
> >  				   enum dma_data_direction dir)
> > @@ -84,16 +131,17 @@ static void vfio_pci_dma_buf_unmap(struct dma_buf_attachment *attachment,
> >  static void vfio_pci_dma_buf_release(struct dma_buf *dmabuf)
> >  {
> >  	struct vfio_pci_dma_buf *priv = dmabuf->priv;
> > +	struct vfio_pci_core_device *vdev = READ_ONCE(priv->vdev);
> >  
> >  	/*
> >  	 * Either this or vfio_pci_dma_buf_cleanup() will remove from the list.
> >  	 * The refcount prevents both.
> >  	 */
> > -	if (priv->vdev) {
> > -		down_write(&priv->vdev->memory_lock);
> > +	if (vdev) {
> > +		down_write(&vdev->memory_lock);
> >  		list_del_init(&priv->dmabufs_elm);
> > -		up_write(&priv->vdev->memory_lock);
> > -		vfio_device_put_registration(&priv->vdev->vdev);
> > +		up_write(&vdev->memory_lock);
> > +		vfio_device_put_registration(&vdev->vdev);
> >  	}
> >  	kfree(priv->phys_vec);
> >  	kfree(priv);  
> 
> 
> This seems unnecessary.  I think this is just because priv->vdev is now
> (unnecessarily) set via WRITE_ONCE, right?  These are very well ordered
> paths, prior to exposing the dma-buf, while the device is opened, during
> release, after release. They don't seem to need the READ/WRITE_ONCE
> treatment.  This looks like noise from trying to make it lockless.
> 
> 
> > @@ -101,6 +149,7 @@ static void vfio_pci_dma_buf_release(struct dma_buf *dmabuf)
> >  
> >  static const struct dma_buf_ops vfio_pci_dmabuf_ops = {
> >  	.attach = vfio_pci_dma_buf_attach,
> > +	.get_tph = vfio_pci_dma_buf_get_tph,
> >  	.map_dma_buf = vfio_pci_dma_buf_map,
> >  	.unmap_dma_buf = vfio_pci_dma_buf_unmap,
> >  	.release = vfio_pci_dma_buf_release,
> > @@ -269,7 +318,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
> >  		goto err_free_priv;
> >  	}
> >  
> > -	priv->vdev = vdev;
> > +	WRITE_ONCE(priv->vdev, vdev);
> >  	priv->nr_ranges = get_dma_buf.nr_ranges;
> >  	priv->size = length;
> >  	ret = vdev->pci_ops->get_dmabuf_phys(vdev, &priv->provider,
> > @@ -331,6 +380,77 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
> >  	return ret;
> >  }
> >  
> > +int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vdev,
> > +				      u32 flags,
> > +				      struct vfio_device_feature_dma_buf_tph __user *arg,
> > +				      size_t argsz)
> > +{
> > +	struct vfio_device_feature_dma_buf_tph set_tph;
> > +	struct vfio_pci_dma_buf *priv;
> > +	struct dma_buf *dmabuf;
> > +	int ret;
> > +
> > +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
> > +				 sizeof(set_tph));
> > +	if (ret != 1)
> > +		return ret;
> > +
> > +	if (copy_from_user(&set_tph, arg, sizeof(set_tph)))
> > +		return -EFAULT;
> > +
> > +	if (set_tph.flags & ~(VFIO_DMA_BUF_TPH_ST | VFIO_DMA_BUF_TPH_ST_EXT))
> > +		return -EINVAL;
> > +
> > +	if (!set_tph.flags)
> > +		return -EINVAL;
> > +
> > +	/* PCIe TLP Processing Hint is a 2-bit field. */
> > +	if (set_tph.ph & ~0x3)
> > +		return -EINVAL;
> > +
> > +	dmabuf = dma_buf_get(set_tph.dmabuf_fd);
> > +	if (IS_ERR(dmabuf))
> > +		return PTR_ERR(dmabuf);
> > +
> > +	if (dmabuf->ops != &vfio_pci_dmabuf_ops) {
> > +		ret = -EINVAL;
> > +		goto out_put;
> > +	}
> > +
> > +	priv = dmabuf->priv;
> > +	down_write(&vdev->memory_lock);
> > +	if (READ_ONCE(priv->vdev) != vdev) {
> > +		ret = -EINVAL;
> > +		goto out_unlock;
> > +	}
> > +
> > +	/*
> > +	 * TPH metadata is write-once per dma-buf so that lockless readers only
> > +	 * have to observe a single release-published transition from 0 -> flags.
> > +	 */
> > +	if (READ_ONCE(priv->tph_flags)) {
> > +		ret = -EBUSY;
> > +		goto out_unlock;
> > +	}
> > +
> > +	priv->steering_tag = set_tph.steering_tag;
> > +	priv->steering_tag_ext = set_tph.steering_tag_ext;
> > +	priv->ph = set_tph.ph;
> > +	/*
> > +	 * Publish the TPH values before the gate flag, so that lockless
> > +	 * readers in vfio_pci_dma_buf_get_tph() see fully-initialized
> > +	 * fields once they observe a non-zero tph_flags.
> > +	 */
> > +	smp_store_release(&priv->tph_flags, set_tph.flags);
> > +	ret = 0;
> > +
> > +out_unlock:
> > +	up_write(&vdev->memory_lock);
> > +out_put:
> > +	dma_buf_put(dmabuf);
> > +	return ret;
> > +}
> > +
> >  void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
> >  {
> >  	struct vfio_pci_dma_buf *priv;
> > @@ -388,7 +508,7 @@ void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
> >  
> >  		dma_resv_lock(priv->dmabuf->resv, NULL);
> >  		list_del_init(&priv->dmabufs_elm);
> > -		priv->vdev = NULL;
> > +		WRITE_ONCE(priv->vdev, NULL);
> >  		priv->revoked = true;
> >  		dma_buf_invalidate_mappings(priv->dmabuf);
> >  		dma_resv_wait_timeout(priv->dmabuf->resv,
> > diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
> > index fca9d0dfac90..c58f369be4b3 100644
> > --- a/drivers/vfio/pci/vfio_pci_priv.h
> > +++ b/drivers/vfio/pci/vfio_pci_priv.h
> > @@ -118,6 +118,10 @@ static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
> >  int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
> >  				  struct vfio_device_feature_dma_buf __user *arg,
> >  				  size_t argsz);
> > +int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vdev,
> > +				      u32 flags,
> > +				      struct vfio_device_feature_dma_buf_tph __user *arg,
> > +				      size_t argsz);
> >  void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev);
> >  void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked);
> >  #else
> > @@ -128,6 +132,14 @@ vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
> >  {
> >  	return -ENOTTY;
> >  }
> > +
> > +static inline int
> > +vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vdev, u32 flags,
> > +				  struct vfio_device_feature_dma_buf_tph __user *arg,
> > +				  size_t argsz)
> > +{
> > +	return -ENOTTY;
> > +}
> >  static inline void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
> >  {
> >  }
> > diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> > index d1203da56fc5..49eb6ad644a2 100644
> > --- a/include/linux/dma-buf.h
> > +++ b/include/linux/dma-buf.h
> > @@ -113,6 +113,27 @@ struct dma_buf_ops {
> >  	 */
> >  	void (*unpin)(struct dma_buf_attachment *attach);
> >  
> > +	/**
> > +	 * @get_tph:
> > +	 * @dmabuf: DMA buffer for which to retrieve TPH metadata
> > +	 * @steering_tag: Returns the raw TPH steering tag for @st_width
> > +	 * @ph: Returns the TPH processing hint (2-bit value)
> > +	 * @st_width: Consumer's supported steering tag width in bits (8 or 16)
> > +	 *
> > +	 * Return the TPH (TLP Processing Hints) metadata associated with this
> > +	 * DMA buffer for the requested steering-tag width. 8-bit ST and 16-bit
> > +	 * Extended ST are distinct namespaces in the PCIe TPH ST table and may
> > +	 * both be present with different values, so the exporter must select the
> > +	 * value that matches @st_width and must not substitute one for the other.
> > +	 *
> > +	 * Return 0 on success, -EOPNOTSUPP if no metadata is available for the
> > +	 * requested width, or -EINVAL if @st_width is not 8 or 16.
> > +	 *
> > +	 * This callback is optional.
> > +	 */
> > +	int (*get_tph)(struct dma_buf *dmabuf, u16 *steering_tag, u8 *ph,
> > +		       u8 st_width);
> > +
> >  	/**
> >  	 * @map_dma_buf:
> >  	 *
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 5de618a3a5ee..a9cb6cbc6ade 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -1534,6 +1534,41 @@ struct vfio_device_feature_dma_buf {
> >   */
> >  #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
> >  
> > +/**
> > + * Upon VFIO_DEVICE_FEATURE_SET associate TPH (TLP Processing Hints) metadata
> > + * with a vfio-exported dma-buf. The dma-buf must have been created by
> > + * VFIO_DEVICE_FEATURE_DMA_BUF on this device.
> > + *
> > + * dmabuf_fd is the file descriptor returned by VFIO_DEVICE_FEATURE_DMA_BUF.
> > + *
> > + * 8-bit ST (steering_tag) and 16-bit Extended ST (steering_tag_ext) are
> > + * distinct namespaces in the PCIe TPH ST table and may both be present with
> > + * different values. Userspace should populate the value(s) it has from the
> > + * firmware ST table for this device and set the matching VFIO_DMA_BUF_TPH_ST /
> > + * VFIO_DMA_BUF_TPH_ST_EXT bit in @flags. An importer requests a specific
> > + * width and receives the matching value; if the requested width is not
> > + * present, the importer is told TPH is unavailable for this dma-buf.
> > + *
> > + * ph is the 2-bit TLP Processing Hint and must be in the range [0, 3].
> > + *
> > + * The user must set TPH on the dma-buf before the importer consumes it.
> > + * TPH metadata is write-once per dma-buf; a second SET returns -EBUSY.
> > + *
> > + * Return: 0 on success, -errno on failure.
> > + */
> > +#define VFIO_DEVICE_FEATURE_DMA_BUF_TPH 13
> > +
> > +#define VFIO_DMA_BUF_TPH_ST		(1 << 0)  /* steering_tag valid */
> > +#define VFIO_DMA_BUF_TPH_ST_EXT		(1 << 1)  /* steering_tag_ext valid */
> > +
> > +struct vfio_device_feature_dma_buf_tph {
> > +	__s32	dmabuf_fd;
> > +	__u32	flags;
> > +	__u8	steering_tag;
> > +	__u8	ph;
> > +	__u16	steering_tag_ext;
> > +};  
> 
> Sure is tempting to make the ph field the first 2-bits of u8 flags.
> Thanks,
> 
> Alex
> 
> > +
> >  /* -------- API for Type1 VFIO IOMMU -------- */
> >  
> >  /**  
> 


