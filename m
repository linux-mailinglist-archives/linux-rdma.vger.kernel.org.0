Return-Path: <linux-rdma+bounces-19474-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id y/0XFfjn6Gl4RgIAu9opvQ
	(envelope-from <linux-rdma+bounces-19474-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 17:23:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7AD447D9B
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 17:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 60789302EDB8
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 15:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4BB332EBB;
	Wed, 22 Apr 2026 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="rUc2xiht";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QKfQ4zVP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A67621CC51;
	Wed, 22 Apr 2026 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871413; cv=none; b=UZLjBUhE+pPCrPxKi7VeuyOgFmv8CcGHh5/UE/g3dpgwdX1DM02sS8wc4GhBNhxcFID/xBRRDoPCGGLOIDZ7Iyoahwz5460nYrLjPxgE2jFfPDQdus8GEBsmPztg/z5BMyh66d4SufmWjZNpGBHXHXg7jsgvdgW3J1ZXCSyrfIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871413; c=relaxed/simple;
	bh=NsV+bBhHjOzB6IJQMX7cu6lNjhAwM7eboDvjOAiCCS0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V7P6a5CgCr2uqSgfuQdlOFmkg/7+G5EbXSKNK5Ocvl/PD6WE+yicMzhQfA6WuTwnEaksadcMlymI6KEcAcshG9ykI7CF2srP6U1RrkiyQ5UMPg6FqqrK9lplApB4mkofV1hb46nlWfXVo3tUhgHVIKA1dWrSCNq9hXxOWmkrsa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=rUc2xiht; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QKfQ4zVP; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6F5301400064;
	Wed, 22 Apr 2026 11:23:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 22 Apr 2026 11:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776871409;
	 x=1776957809; bh=hQMlk9Xq+ZB050Bu5h5Pj79B23kU/VRcG/nsXr+g5/Q=; b=
	rUc2xihtS2cQdAuSwUnr0y9hgq5IwBRt0Tsc8ILzmkJmagGjVApGux4WHK2ycA0K
	3IS7iCY8miyNBJfCA4fxgdr0GzuMGowKP3VSbdI74uFkrYLvcTNq2fFdsjs4wfjp
	29OkpB2eDocEBVWejYCaxAh9nsGQzIBCPissSi56G8Q6Upw8QKd5A0lr33z7CwQ+
	JutrxlpmR1oU+/sTRc00/T0wOFMU/EkFGEmWtacf3k8mI+4BdjJly7Zu3yca06NI
	O8u5maNR0b4k1ErHzlc7ecxIuTdkJvwnjP/+0Ynsn5BW2pvpL/hvpV2sAkF55Fay
	EoFPDNl0v0lQGE5hWIweHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776871409; x=
	1776957809; bh=hQMlk9Xq+ZB050Bu5h5Pj79B23kU/VRcG/nsXr+g5/Q=; b=Q
	KfQ4zVPMkiNPasEcIuOzqkJ6IyhtBK/0QDCAcy6He4QNOwK2Cb9B8mYpiy2tQNsZ
	/g12FdDPrpuLb6ND3dc5PpL2sDCPHe1+EC94Ltr6aPsPVMU/hm254xwGu93FijKX
	6kklVb7VCFSK3feEUb+yZE9XlCOOGmaiaKTQh/DkEbleHNDV8MDs/eq9tGYbOeA/
	WdqHwlp/Gm529uiII0FQl0Nd/Mr6XI4HbUd8ecf5ZEkVnIIoyKqkZn0UPgF4XYAk
	Grc/Mn4k48zei00i9tGR3/P3w3FUC++OZXHR/Ws2yvvB8n4ZUkXnftanCbLRmD1h
	Puj8udp4gf1zjyssWHLaA==
X-ME-Sender: <xms:8efoaRVM9j15U5FN97It6PPOed7eKcPS-2D9fypr3_rxwCt4Nv9tbw>
    <xme:8efoaVQ2W6El0ICXVel6Kmlv6SM6w-D1b7t5wVz_SqPhD4KLZ9D3xqPlIGID05jbq
    yuCfekr7Az6TojO2J5qjXsy5ihwxxM1Ti5ofo8vybAVxZBqpFFwyA>
X-ME-Received: <xmr:8efoaWDnjFvkN2nEp_g06_i1lvCZvWQeE6vm-Sc3XlQnFtSSNXqhsCt0rd4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeigeeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfgjfhfogggtgfesthejredtredtvdenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepvdekfeejkedvudfhudfhteekudfgudeiteetvdeukedvheetvdekgfdugeev
    ueeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopedufedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepiihhihhpihhnghiisehmvghtrgdrtghomhdprhgtph
    htthhopehsughfsehmvghtrgdrtghomhdprhgtphhtthhopehksghushgthheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepjhhgghesiihivghpvgdrtggrpdhrtghpthhtoheplh
    gvohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrughmrgesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:8efoaVsL30-Su4EHn6o1-1kxUePqFEnl0e0Q9han8VdJCNIZO5HbgQ>
    <xmx:8efoac8feudf5sBZX0d9MbXUD-5TarHV7tn1c18EQUbIymllH2nt_Q>
    <xmx:8efoaUTEhbrfTEuus2mOtj_Ysmuu-ybaNO1Yr76hqg-9Y5KWoucqHA>
    <xmx:8efoaWU8dWKKFCRUIRCIQDOfFzW-yhNTf9qKpNTV-wpL_lWXeig7aQ>
    <xmx:8efoaQze75CZ1fViASTOyrH-Gxcsrhd8qrd5j9hAHQr-9AEtcU9I-qNd>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Apr 2026 11:23:28 -0400 (EDT)
Date: Wed, 22 Apr 2026 09:23:27 -0600
From: Alex Williamson <alex@shazbot.org>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Stanislav Fomichev <sdf@meta.com>, Keith Busch <kbusch@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Bjorn
 Helgaas <helgaas@kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, Yochai Cohen <yochai@nvidia.com>, Yishai
 Hadas <yishaih@nvidia.com>, alex@shazbot.org
Subject: Re: [PATCH v1 1/2] vfio: add callback to get tph info for dma-buf
Message-ID: <20260422092327.3f629ad6@shazbot.org>
In-Reply-To: <20260420183920.3626389-2-zhipingz@meta.com>
References: <20260420183920.3626389-1-zhipingz@meta.com>
	<20260420183920.3626389-2-zhipingz@meta.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[shazbot.org:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-19474-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[shazbot.org:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@shazbot.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim,meta.com:email,shazbot.org:dkim,shazbot.org:mid]
X-Rspamd-Queue-Id: EC7AD447D9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 20 Apr 2026 11:39:15 -0700
Zhiping Zhang <zhipingz@meta.com> wrote:

> Add a dma-buf callback that returns raw TPH metadata from the exporter
> so peer devices can reuse the steering tag and processing hint
> associated with a VFIO-exported buffer.
> 
> Keep the existing VFIO_DEVICE_FEATURE_DMA_BUF uAPI layout intact by
> using a flag plus one extra trailing entries[] object for the optional
> TPH metadata. Rename the uAPI field dma_ranges to entries. The
> nr_ranges field remains the DMA range count; when VFIO_DMABUF_FLAG_TPH
> is set the kernel reads one extra entry beyond nr_ranges for the TPH
> metadata.
> 
> Add an st_width parameter to get_tph() so the exporter can reject
> steering tags that exceed the consumer's supported width (8 vs 16 bit).
> When no TPH metadata was supplied, make get_tph() return -EOPNOTSUPP.
> 
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> ---
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 62 +++++++++++++++++++++++-------
>  include/linux/dma-buf.h            | 17 ++++++++
>  include/uapi/linux/vfio.h          | 28 ++++++++++++--
>  3 files changed, 89 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> index b1d658b8f7b5..fdc05f9ab3ae 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -17,6 +17,9 @@ struct vfio_pci_dma_buf {
>  	struct phys_vec *phys_vec;
>  	struct p2pdma_provider *provider;
>  	u32 nr_ranges;
> +	u16 steering_tag;
> +	u8 ph;
> +	u8 tph_present : 1;
>  	u8 revoked : 1;
>  };
>  
> @@ -60,6 +63,22 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *attachment,
>  				       priv->size, dir);
>  }
>  
> +static int vfio_pci_dma_buf_get_tph(struct dma_buf *dmabuf, u16 *steering_tag,
> +				    u8 *ph, u8 st_width)
> +{
> +	struct vfio_pci_dma_buf *priv = dmabuf->priv;
> +
> +	if (!priv->tph_present)
> +		return -EOPNOTSUPP;
> +
> +	if (st_width < 16 && priv->steering_tag > ((1U << st_width) - 1))
> +		return -EINVAL;
> +
> +	*steering_tag = priv->steering_tag;
> +	*ph = priv->ph;
> +	return 0;
> +}
> +
>  static void vfio_pci_dma_buf_unmap(struct dma_buf_attachment *attachment,
>  				   struct sg_table *sgt,
>  				   enum dma_data_direction dir)
> @@ -89,6 +108,7 @@ static const struct dma_buf_ops vfio_pci_dmabuf_ops = {
>  	.pin = vfio_pci_dma_buf_pin,
>  	.unpin = vfio_pci_dma_buf_unpin,
>  	.attach = vfio_pci_dma_buf_attach,
> +	.get_tph = vfio_pci_dma_buf_get_tph,
>  	.map_dma_buf = vfio_pci_dma_buf_map,
>  	.unmap_dma_buf = vfio_pci_dma_buf_unmap,
>  	.release = vfio_pci_dma_buf_release,
> @@ -211,7 +231,9 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>  				  size_t argsz)
>  {
>  	struct vfio_device_feature_dma_buf get_dma_buf = {};
> -	struct vfio_region_dma_range *dma_ranges;
> +	bool tph_supplied;
> +	u32 tph_index;
> +	struct vfio_region_dma_range *entries;
>  	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>  	struct vfio_pci_dma_buf *priv;
>  	size_t length;
> @@ -228,7 +250,10 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>  	if (copy_from_user(&get_dma_buf, arg, sizeof(get_dma_buf)))
>  		return -EFAULT;
>  
> -	if (!get_dma_buf.nr_ranges || get_dma_buf.flags)
> +	tph_supplied = !!(get_dma_buf.flags & VFIO_DMABUF_FLAG_TPH);
> +	tph_index = get_dma_buf.nr_ranges;
> +	if (!get_dma_buf.nr_ranges ||
> +	    (get_dma_buf.flags & ~VFIO_DMABUF_FLAG_TPH))
>  		return -EINVAL;
>  
>  	/*
> @@ -237,19 +262,21 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>  	if (get_dma_buf.region_index >= VFIO_PCI_ROM_REGION_INDEX)
>  		return -ENODEV;
>  
> -	dma_ranges = memdup_array_user(&arg->dma_ranges, get_dma_buf.nr_ranges,
> -				       sizeof(*dma_ranges));
> -	if (IS_ERR(dma_ranges))
> -		return PTR_ERR(dma_ranges);
> +	entries = memdup_array_user(&arg->entries,
> +				    get_dma_buf.nr_ranges +
> +					(tph_supplied ? 1 : 0),
> +				    sizeof(*entries));
> +	if (IS_ERR(entries))
> +		return PTR_ERR(entries);
>  
> -	ret = validate_dmabuf_input(&get_dma_buf, dma_ranges, &length);
> +	ret = validate_dmabuf_input(&get_dma_buf, entries, &length);
>  	if (ret)
> -		goto err_free_ranges;
> +		goto err_free_entries;
>  
>  	priv = kzalloc_obj(*priv);
>  	if (!priv) {
>  		ret = -ENOMEM;
> -		goto err_free_ranges;
> +		goto err_free_entries;
>  	}
>  	priv->phys_vec = kzalloc_objs(*priv->phys_vec, get_dma_buf.nr_ranges);
>  	if (!priv->phys_vec) {
> @@ -260,15 +287,22 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>  	priv->vdev = vdev;
>  	priv->nr_ranges = get_dma_buf.nr_ranges;
>  	priv->size = length;
> +
> +	if (tph_supplied) {
> +		priv->steering_tag = entries[tph_index].tph.steering_tag;
> +		priv->ph = entries[tph_index].tph.ph;
> +		priv->tph_present = 1;
> +	}
> +
>  	ret = vdev->pci_ops->get_dmabuf_phys(vdev, &priv->provider,
>  					     get_dma_buf.region_index,
> -					     priv->phys_vec, dma_ranges,
> +					     priv->phys_vec, entries,
>  					     priv->nr_ranges);
>  	if (ret)
>  		goto err_free_phys;
>  
> -	kfree(dma_ranges);
> -	dma_ranges = NULL;
> +	kfree(entries);
> +	entries = NULL;
>  
>  	if (!vfio_device_try_get_registration(&vdev->vdev)) {
>  		ret = -ENODEV;
> @@ -311,8 +345,8 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>  	kfree(priv->phys_vec);
>  err_free_priv:
>  	kfree(priv);
> -err_free_ranges:
> -	kfree(dma_ranges);
> +err_free_entries:
> +	kfree(entries);
>  	return ret;
>  }
>  
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index 133b9e637b55..b0a79ccbe100 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -113,6 +113,23 @@ struct dma_buf_ops {
>  	 */
>  	void (*unpin)(struct dma_buf_attachment *attach);
>  
> +	/**
> +	 * @get_tph:
> +	 * @dmabuf: DMA buffer for which to retrieve TPH metadata
> +	 * @steering_tag: Returns the raw TPH steering tag
> +	 * @ph: Returns the TPH processing hint
> +	 * @st_width: Consumer's supported steering tag width in bits (8 or 16)
> +	 *
> +	 * Return the TPH (TLP Processing Hints) metadata associated with this
> +	 * DMA buffer. Exporters that do not provide TPH metadata should return
> +	 * -EOPNOTSUPP. If the steering tag exceeds @st_width bits, return
> +	 * -EINVAL.
> +	 *
> +	 * This callback is optional.
> +	 */
> +	int (*get_tph)(struct dma_buf *dmabuf, u16 *steering_tag, u8 *ph,
> +		       u8 st_width);
> +
>  	/**
>  	 * @map_dma_buf:
>  	 *
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index bb7b89330d35..a0bd24623c52 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1490,16 +1490,36 @@ struct vfio_device_feature_bus_master {
>   * open_flags are the typical flags passed to open(2), eg O_RDWR, O_CLOEXEC,
>   * etc. offset/length specify a slice of the region to create the dmabuf from.
>   * nr_ranges is the total number of (P2P DMA) ranges that comprise the dmabuf.
> + * When VFIO_DMABUF_FLAG_TPH is set, entries[] contains one extra trailing
> + * object after the nr_ranges DMA ranges carrying the TPH steering tag and
> + * processing hint.

I really don't think we want to design an API where entries is
implicitly one-off from what's actually there.  This feeds back into
the below removal of the __counted by attribute, which is a red flag
that this is the wrong approach.

In general though, I'm really hoping that someone interested in
enabling TPH as an interface through vfio actually decides to take
resource targeting and revocation seriously.  There's no validation of
the steering tag here relative to what the user has access to and no
mechanism to revoke those tags if access changes.  In fact, there's not
even a proposed mechanism allowing the user to derive valid steering
tags.  Does the user implicitly know the value and the kernel just
allows it because... yolo?  Thanks,

Alex

>   *
> - * flags should be 0.
> + * flags should be 0 or VFIO_DMABUF_FLAG_TPH.
>   *
>   * Return: The fd number on success, -1 and errno is set on failure.
>   */
>  #define VFIO_DEVICE_FEATURE_DMA_BUF 11
>  
> +enum vfio_device_feature_dma_buf_flags {
> +	VFIO_DMABUF_FLAG_TPH = 1 << 0,
> +};
> +
> +struct vfio_region_dma_tph {
> +	__u16 steering_tag;
> +	__u8 ph;
> +	__u8 reserved;
> +	__u32 reserved2;
> +};
> +
>  struct vfio_region_dma_range {
> -	__u64 offset;
> -	__u64 length;
> +	union {
> +		__u64 offset;
> +		struct vfio_region_dma_tph tph;
> +	};
> +	union {
> +		__u64 length;
> +		__u64 reserved;
> +	};
>  };
>  
>  struct vfio_device_feature_dma_buf {
> @@ -1507,7 +1527,7 @@ struct vfio_device_feature_dma_buf {
>  	__u32	open_flags;
>  	__u32   flags;
>  	__u32   nr_ranges;
> -	struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
> +	struct vfio_region_dma_range entries[];
>  };
>  
>  /* -------- API for Type1 VFIO IOMMU -------- */


