Return-Path: <linux-rdma+bounces-21398-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFN9MRQ0F2pF9AcAu9opvQ
	(envelope-from <linux-rdma+bounces-21398-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 20:12:36 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D305E8C27
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 20:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C9453037D53
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 18:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A5F4611EE;
	Wed, 27 May 2026 18:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="C0w+091K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ktr+UzGW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2367530F55F;
	Wed, 27 May 2026 18:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905175; cv=none; b=UK+YvUCVj5XFG5XPdbq8X1WGq3S73BaOGn9wB9tTqRrAVI7PaWSYhwPYKMFyWrZIf2lZ03M/lvVMzM9ilAwrciRIuws026/psnX510eeVZF3vg8NFSBSLKzwrxot/ZVCveB5LCVFX+kM6Ob8TiddESK5jfNgm42jKhxxrBaDB6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905175; c=relaxed/simple;
	bh=NePHdWtJYo4uu5Taf3t5REbllEZIBieR+PCYbuU5o0w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T+C9IcNKCv0vTDIDDa40EtcW/Fr3AD1RxBr7y8m3WjDi68Ezd6yVYxWjWglfvTbFG+mOBhSGyVLUgO5V1IHdtJu38cfFVQKViz+g819LKZ085WySC2JZHhphnuexAaZPvu3PAJjyhJtsLaS9ypYz5sEUjZc/ec2eWSeiyk7rpE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=C0w+091K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ktr+UzGW; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 42A5D1400085;
	Wed, 27 May 2026 14:06:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 27 May 2026 14:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779905171;
	 x=1779991571; bh=If8nEdIdnJc3yeIDwS3+Ms+eIoYh155YCijfwZGIk/c=; b=
	C0w+091KjiY90zo6qoUpL8ddXkCA2Ra9kswmLwl/94aMuWXFuvQFbwL3JnWHnZ94
	6yS+Rkj2HQol8/+yn//YHPL9qw9EzEGgEr491tv7g6ALEMfY7zT5y0tiQZ1a3Vj/
	/lShvrEG+GYuZeXlkEgyz/D1NaFvNFAgJ5pMpRD/X+23GgE98PsMW7/nq3iIXQgH
	7xghFoGK8WEKUFrWV5yL3YAP8g8g80U0XW2Z7M+oK4ThlNhBZRKD1DkxIei+gzqI
	oHDUTU5mW7vix+Bq5GkckhrAnBGFa9iPANk6FrxAqIHQTSmhzLA/VAmiAukrp9gD
	d4BpagX58pVLhfecyiwo3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779905171; x=
	1779991571; bh=If8nEdIdnJc3yeIDwS3+Ms+eIoYh155YCijfwZGIk/c=; b=k
	tr+UzGWajFCz58MFtEtRe1N6VQj3+eW4WLAatfiX6Y7c7GFHRh7mKRHPr214cUjG
	9bqR6qaNDDrbhNxuNWF3p3zUKGobiYhH430RaD0WiFLfhGHvDNNfeyfe/J31KiWT
	uYdmAtumjrLngvy+xg9+6kLl8YiBsrRVqCSHTuhudhgPfha1HS7dvwfH45CNdQk5
	DUSNTkvPBBcxlQEor9X7qatAfZ96FWMWC1CPxYG3rHgzoIp+UJABfNXXTESuwZ0X
	grTXV0ByXY/65PLnkDGl3VPxJunAtaS5shXh7qFNZ0t2iUDWwy3jRWXV7G3OBXV7
	4tZZ0lrQuO5AWhjtk1Wwg==
X-ME-Sender: <xms:kjIXap7-xlHPWmc8sjvqekW0QkErnYfI7FYkjgKAu0iZ7HosC7bSyg>
    <xme:kjIXaucstq4fP64CuXC9b4YyJuHaD4aYAi5sdaJtYd34wDBwGTillrZW6tBqwtIWV
    UYLi45MvoDNkolBdHwtDDmrHLlcbKfj_htE3d-lxZcW7I202UXGBQ>
X-ME-Received: <xmr:kjIXagGzh-HtPQp-hPf4-LkKtoe6N7thGvRFQHKiZ_GPSSXlLVVhwy2K6YY>
X-ME-Proxy-Cause: dmFkZTEF+fjtTbHDg7Gr1uRQhPx9yHJ9DX6kqEMc2wwQjv5v5HIeaMZyxan2Psmob/vm2R
    Ko3GhVtDNGwBBAGiNj9Xky3QpzrwETpn4UaEkCXcDdOIg+P0g4KDIdWsem6kF/ntYN5YJa
    vuM5qctd4xXfbZ7NP+8C0tKNnHoz7vVYJONSkMQYHpolGC9nvOgS6TTxaxonDYRPVo/03m
    mLFPX/xk96gxLc4IEHuS3dPHP8PS8PbhOAQu2DPE9ybD7UVbp+30TkLauBo9NuIK+Vvk5f
    /SDdiX8Wpmi3PvNNcWF56l2jLpFEwpCm5A8EIDXDotFOgkTZ2T3MIZ3stgNEhPHbNiUgI8
    yutGmhgODU9pOAGQokhroE9t3TA6AhpNOyfe1eUwny7nyt9SVtAL5GKGlNpr+u0rjauo/v
    biUmMu/9qoDL/ZcnO4vQDzzkL2ZydK5HpJrBFB2RR2Mym83D5pG6syrktUTX3fg3a7Tnet
    CGOmWtcRBcHVEgarJAGrna2YgQuMhPJsrhXoMTQEXpFdpBzn1Bglw1xViOgD+yA+2wj+4j
    K1/R+rBTTOTlREPrv2tbUW6kChuQsIIgGNyxrjrMMximMAPEKjiP9qvCa6mtbmabsJd8ko
    O3ZvAj685yLHlfBJbzydRlSbQq5hFdfB6HkenOJJCWhLwSFF3IW2agp7j1XA
X-ME-Proxy: <xmx:kjIXau58OYh4ojWsjz5horZPMLP1BQ041_SUOrhtx8KmGyS2-FuswA>
    <xmx:kjIXajuNcUq0Fm-dYuEzx738smHhgCtPHoUOFGvdDmkH2C60NmZVgg>
    <xmx:kjIXai9iJvMhQqUNnEnhK-mKGai-FrJpx1QgikKu1Fjuq73UKuITKQ>
    <xmx:kjIXatkj3r5HQg_D8dJj3_EdHhHgK3qFYqcEvo-bFubedE4R97OUQw>
    <xmx:kzIXaqkevAiMgtCi0nEDp8TG6JIs6dIgefg3ZDKnawZQNmdBMHO1aJey>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 14:06:09 -0400 (EDT)
Date: Wed, 27 May 2026 12:06:07 -0600
From: Alex Williamson <alex@shazbot.org>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Sumit
 Semwal <sumit.semwal@linaro.org>, Christian Konig
 <christian.koenig@amd.com>, Bjorn Helgaas <helgaas@kernel.org>,
 <kvm@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, Keith Busch <kbusch@kernel.org>, Yochai
 Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
 alex@shazbot.org
Subject: Re: [PATCH v5 3/4] vfio/pci: implement get_tph and DMA_BUF_TPH
 feature
Message-ID: <20260527120607.248867c1@shazbot.org>
In-Reply-To: <20260526144401.1485788-4-zhipingz@meta.com>
References: <20260526144401.1485788-1-zhipingz@meta.com>
	<20260526144401.1485788-4-zhipingz@meta.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
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
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-21398-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,set_tph.ph:url,shazbot.org:mid,shazbot.org:dkim,meta.com:email,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 08D305E8C27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 07:43:55 -0700
Zhiping Zhang <zhipingz@meta.com> wrote:

> Implement the dma-buf get_tph callback for vfio-pci-exported dma-bufs
> and add VFIO_DEVICE_FEATURE_DMA_BUF_TPH so userspace can attach TPH
> metadata to such a dma-buf.
> 
> 8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces; the
> uAPI carries both with explicit validity flags, and get_tph() returns
> the value matching the importer's requested width (or -EOPNOTSUPP).
> 
> The TPH descriptor is published under a new per-dma-buf mutex
> (priv->lock) and read by get_tph() under the same mutex. The same
> mutex serialises with the priv->vdev clear in
> vfio_pci_dma_buf_cleanup() so a SET racing with device teardown
> cannot observe a half-detached dma-buf. memory_lock remain on the
> existing dma-buf paths; the outer order is memory_lock -> priv->lock.
> 
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c   |   3 +
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 110 ++++++++++++++++++++++++++++-
>  drivers/vfio/pci/vfio_pci_priv.h   |  12 ++++
>  include/uapi/linux/vfio.h          |  37 ++++++++++
>  4 files changed, 161 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 050e7542952e..4fa36f2f7555 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1569,6 +1569,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>  		return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
>  	case VFIO_DEVICE_FEATURE_DMA_BUF:
>  		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
> +	case VFIO_DEVICE_FEATURE_DMA_BUF_TPH:
> +		return vfio_pci_core_feature_dma_buf_tph(vdev, flags, arg,
> +							 argsz);
>  	default:
>  		return -ENOTTY;
>  	}
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> index 1a177ce7de54..3ea2978c376c 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -19,7 +19,19 @@ struct vfio_pci_dma_buf {
>  	u32 nr_ranges;
>  	struct kref kref;
>  	struct completion comp;
> -	u8 revoked : 1;
> +	/*
> +	 * @lock serializes TPH SET vs get_tph and the priv->vdev clear in
> +	 * vfio_pci_dma_buf_cleanup(). It nests inside memory_lock:
> +	 * the outer order across these paths is
> +	 * memory_lock -> priv->lock.
> +	 */
> +	struct mutex lock;
> +	u8 tph_st_valid:1;	/* priv->lock */
> +	u8 tph_st_ext_valid:1;	/* priv->lock */
> +	u8 tph_ph:2;		/* priv->lock */
> +	u8 tph_st;		/* priv->lock */
> +	u16 tph_st_ext;		/* priv->lock */
> +	u8 revoked:1;		/* dma_resv_lock */
>  };
>  
>  static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
> @@ -69,6 +81,38 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *attachment,
>  	return ret;
>  }
>  
> +static int vfio_pci_dma_buf_get_tph(struct dma_buf *dmabuf, u16 *steering_tag,
> +				    u8 *ph, u8 st_width)
> +{
> +	struct vfio_pci_dma_buf *priv = dmabuf->priv;
> +	int ret = 0;
> +
> +	mutex_lock(&priv->lock);

Use guard semantics and drop ret, return from the error branch directly.

> +	switch (st_width) {
> +	case 8:
> +		if (!priv->tph_st_valid) {
> +			ret = -EOPNOTSUPP;
> +			break;
> +		}
> +		*steering_tag = priv->tph_st;
> +		*ph = priv->tph_ph;
> +		break;
> +	case 16:
> +		if (!priv->tph_st_ext_valid) {
> +			ret = -EOPNOTSUPP;
> +			break;
> +		}
> +		*steering_tag = priv->tph_st_ext;
> +		*ph = priv->tph_ph;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +	mutex_unlock(&priv->lock);
> +	return ret;
> +}
> +
>  static void vfio_pci_dma_buf_unmap(struct dma_buf_attachment *attachment,
>  				   struct sg_table *sgt,
>  				   enum dma_data_direction dir)
> @@ -95,12 +139,14 @@ static void vfio_pci_dma_buf_release(struct dma_buf *dmabuf)
>  		up_write(&priv->vdev->memory_lock);
>  		vfio_device_put_registration(&priv->vdev->vdev);
>  	}
> +	mutex_destroy(&priv->lock);
>  	kfree(priv->phys_vec);
>  	kfree(priv);
>  }
>  
>  static const struct dma_buf_ops vfio_pci_dmabuf_ops = {
>  	.attach = vfio_pci_dma_buf_attach,
> +	.get_tph = vfio_pci_dma_buf_get_tph,
>  	.map_dma_buf = vfio_pci_dma_buf_map,
>  	.unmap_dma_buf = vfio_pci_dma_buf_unmap,
>  	.release = vfio_pci_dma_buf_release,
> @@ -265,6 +311,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>  		ret = -ENOMEM;
>  		goto err_free_ranges;
>  	}
> +	mutex_init(&priv->lock);
>  	priv->phys_vec = kzalloc_objs(*priv->phys_vec, get_dma_buf.nr_ranges);
>  	if (!priv->phys_vec) {
>  		ret = -ENOMEM;
> @@ -327,12 +374,71 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>  err_free_phys:
>  	kfree(priv->phys_vec);
>  err_free_priv:
> +	mutex_destroy(&priv->lock);
>  	kfree(priv);
>  err_free_ranges:
>  	kfree(dma_ranges);
>  	return ret;
>  }
>  
> +int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vdev,
> +				      u32 flags,
> +				      struct vfio_device_feature_dma_buf_tph __user *arg,
> +				      size_t argsz)
> +{
> +	struct vfio_device_feature_dma_buf_tph set_tph;
> +	struct vfio_pci_dma_buf *priv;
> +	struct dma_buf *dmabuf;
> +	int ret;
> +
> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
> +				 sizeof(set_tph));
> +	if (ret != 1)
> +		return ret;

Don't we need to test whether the device supports the TPH capability
somewhere here?  AIUI the device must exposed a TPH capability to act
as a TPH completer.

> +
> +	if (copy_from_user(&set_tph, arg, sizeof(set_tph)))
> +		return -EFAULT;
> +
> +	if (set_tph.flags & ~(VFIO_DMA_BUF_TPH_ST | VFIO_DMA_BUF_TPH_ST_EXT))
> +		return -EINVAL;
> +
> +	if (!set_tph.flags)
> +		return -EINVAL;

This seems to block the path to marking both steering tags to invalid
without any particular reason to do so.

> +
> +	/* PCIe TLP Processing Hint is a 2-bit field. */
> +	if (set_tph.ph & ~0x3)
> +		return -EINVAL;
> +
> +	dmabuf = dma_buf_get(set_tph.dmabuf_fd);
> +	if (IS_ERR(dmabuf))
> +		return PTR_ERR(dmabuf);
> +
> +	if (dmabuf->ops != &vfio_pci_dmabuf_ops) {
> +		ret = -EINVAL;
> +		goto out_put;
> +	}
> +
> +	priv = dmabuf->priv;
> +	mutex_lock(&priv->lock);

Use guards.

> +	if (priv->vdev != vdev) {

For here and the next chunk, why is priv->vdev pulled into this lock?
We're calling an ioctl on the vdev, that's stable.  We have a reference
to the dma-buf, that's stable.  I think the ordering prevents this from
needing to be under the lock, which probably means it should be
s/lock/tph_lock/.

> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	priv->tph_st = set_tph.steering_tag;
> +	priv->tph_st_ext = set_tph.steering_tag_ext;
> +	priv->tph_ph = set_tph.ph;
> +	priv->tph_st_valid = !!(set_tph.flags & VFIO_DMA_BUF_TPH_ST);
> +	priv->tph_st_ext_valid = !!(set_tph.flags & VFIO_DMA_BUF_TPH_ST_EXT);
> +	ret = 0;
> +
> +out_unlock:
> +	mutex_unlock(&priv->lock);
> +out_put:
> +	dma_buf_put(dmabuf);
> +	return ret;
> +}
> +
>  void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
>  {
>  	struct vfio_pci_dma_buf *priv;
> @@ -398,7 +504,9 @@ void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
>  			continue;
>  
>  		list_del_init(&priv->dmabufs_elm);
> +		mutex_lock(&priv->lock);
>  		priv->vdev = NULL;
> +		mutex_unlock(&priv->lock);

As above, seems unnecessary.

>  		vfio_device_put_registration(&vdev->vdev);
>  		fput(priv->dmabuf->file);
>  	}
> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
> index fca9d0dfac90..c58f369be4b3 100644
> --- a/drivers/vfio/pci/vfio_pci_priv.h
> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> @@ -118,6 +118,10 @@ static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
>  int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>  				  struct vfio_device_feature_dma_buf __user *arg,
>  				  size_t argsz);
> +int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vdev,
> +				      u32 flags,
> +				      struct vfio_device_feature_dma_buf_tph __user *arg,
> +				      size_t argsz);
>  void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev);
>  void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked);
>  #else
> @@ -128,6 +132,14 @@ vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>  {
>  	return -ENOTTY;
>  }
> +
> +static inline int
> +vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vdev, u32 flags,
> +				  struct vfio_device_feature_dma_buf_tph __user *arg,
> +				  size_t argsz)
> +{
> +	return -ENOTTY;
> +}
>  static inline void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
>  {
>  }
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 5de618a3a5ee..55cac3b7122c 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1534,6 +1534,43 @@ struct vfio_device_feature_dma_buf {
>   */
>  #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
>  
> +/**
> + * Upon VFIO_DEVICE_FEATURE_SET associate TPH (TLP Processing Hints) metadata
> + * with a vfio-exported dma-buf. The dma-buf must have been created by
> + * VFIO_DEVICE_FEATURE_DMA_BUF on this device.
> + *
> + * dmabuf_fd is the file descriptor returned by VFIO_DEVICE_FEATURE_DMA_BUF.
> + *
> + * 8-bit ST (steering_tag) and 16-bit Extended ST (steering_tag_ext) are
> + * distinct namespaces in the PCIe TPH ST table and may both be present with
> + * different values. Userspace should populate the value(s) it has from the
> + * firmware ST table for this device and set the matching VFIO_DMA_BUF_TPH_ST /
> + * VFIO_DMA_BUF_TPH_ST_EXT bit in @flags. An importer requests a specific
> + * width and receives the matching value; if the requested width is not
> + * present, the importer is told TPH is unavailable for this dma-buf.
> + *
> + * ph is the 2-bit TLP Processing Hint and must be in the range [0, 3].
> + *
> + * Userspace is responsible for setting TPH on the dma-buf before handing the
> + * fd to the importer. Calling SET again replaces the previously published
> + * values; racing a SET against an importer that is already consuming the
> + * dma-buf is a userspace ordering problem.
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +#define VFIO_DEVICE_FEATURE_DMA_BUF_TPH 13
> +
> +#define VFIO_DMA_BUF_TPH_ST		(1 << 0)  /* steering_tag valid */
> +#define VFIO_DMA_BUF_TPH_ST_EXT		(1 << 1)  /* steering_tag_ext valid */
> +
> +struct vfio_device_feature_dma_buf_tph {
> +	__s32	dmabuf_fd;
> +	__u32	flags;
> +	__u8	steering_tag;
> +	__u8	ph;

Nit, I'd swap the order of these so the steering_tag fields are
back-to-back.  Thanks,

Alex

