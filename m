Return-Path: <linux-rdma+bounces-22437-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zDbxIc7NOmqiHQgAu9opvQ
	(envelope-from <linux-rdma+bounces-22437-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2026 20:17:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB1C6B967F
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2026 20:17:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=shazbot.org header.s=fm3 header.b=Br4rKaNW;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="h WTEdnx";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22437-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22437-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=shazbot.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C50B8303C035
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2026 18:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC04238E129;
	Tue, 23 Jun 2026 18:17:44 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E08B175A67;
	Tue, 23 Jun 2026 18:17:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782238664; cv=none; b=CNOxXKfyX9Lcm8SmR6ru/lTClO0/fHn8+aLFmD+Q3kpVZOjfos6dbG52NnKPtCxXmcy+uYPn2hg9JAwCW0q29rcT0m4DpTQzAqerlnDNTFxA/rPd4rQCBMxsEMwRmuVmBMYYKzNNUMgXvRugrzxbwMJ4xIX9bwspOZObRvX87xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782238664; c=relaxed/simple;
	bh=iUvpSiJn348z+xGT2jd2xklbQLkJa/MVABMpzt/E/Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oz4NkcK2UZiFlLCN8OQmQunPca+dl6y/opIu8swanTjhsCxb3XDwop2TrDgOSkRoLwj9NDVlOladeXTSga6ROriuX7DXC4PLw2CTZ1pOYqcBFN0tEm9825wQzqecA/ij+PmxtumBf4pEaxaU52a2GRa+fly6fEsl/VhrERY2Uz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=Br4rKaNW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hWTEdnxK; arc=none smtp.client-ip=103.168.172.148
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 49254EC02D1;
	Tue, 23 Jun 2026 14:17:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 23 Jun 2026 14:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1782238660;
	 x=1782325060; bh=Sj1SnG8wgmD6FqcVumX9KYEM4P8DEWyQcCqQNAcBYVs=; b=
	Br4rKaNWrUxObjLWbsZrmJ6uJgkIZNnPXZNiOmg7zHsDw7mZA1ISU8IuKjOwFXS2
	Bsy8cuKD/Wrq+nqBJae3XX6mKWl6eULt3Z0bswaVxDqPpvrlG651CCqWk9RQKeQm
	z/M0ySScjJUa+Jmn9U8H915N7HQHNV3a2P/zBD0QbcxnYFBw579K2d3XqbWRjVEN
	WIWJuu8KzuLTFpUSfAEL3iyPGmpWLLXN8PfFzHjWv6p2oCsutiLenMJ+BnRLUL5F
	JLzXrpnHx62ei8S629wTHWMuEVPR0dBUN7HrJiUzdU5Wfe0GhO1nLWC/qHEUozuL
	yCmDjfnkgbQPOI6sXJ72mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782238660; x=
	1782325060; bh=Sj1SnG8wgmD6FqcVumX9KYEM4P8DEWyQcCqQNAcBYVs=; b=h
	WTEdnxKHc6dgyqth4FYHuKGrq6bqziO5Ww0y9bTEEuL60nwhUDtxOymOFvFPa0x7
	CBoeQQMbeZTg6htZNh+ZnOImUPi2QXc7AshZ/vSNkWZMmE5RdiOCgGZktRwtqU7N
	vUrZknkvbtt7BshuNFe+XHdZfjTb/dvm7bEEqE0AImrYz3ObSl1anIHPfVcFEPyf
	SNV7bSY41mmYLMprKwhgejuA/knHs9pNIR0OdCx3Hdr1fLcgxLh4XRLlaxPSUUKX
	VCX6OvpKHXpgUafF98JSbB1tFvT4u4qrxOIpyPunF8/BL0+TZ2nMf0YHXOdmbPAY
	k+ZGerrIzn7f6XfvcNvdw==
X-ME-Sender: <xms:w806anfp0mutTTFpDFeUpuyVHWep-YPV2glDT6SACvFHraIWhXBSTA>
    <xme:w806ajnQrCRuUtx8tDhSWS7PKRa5OZBv_-Li9GmCPcZ0DMrLFZhvBnOkF7mCG_wO1
    2XaPj9uEJ9lyKaKF3S2fu6IomQtsM6WqRJBpKJW0z1nT-tzZ0O2VA>
X-ME-Received: <xmr:w806asz_I8CedBmyN4ke3AyZqa_VcAwNwuJ-RFbQIWC6an68jXkYXAbZQN8>
X-ME-Proxy-Cause: dmFkZTFwRukWK6LHpRv1dlQXVP+RHoSsx9S4XR1otDkyXrwiDIOs4np7kPjKMqXWjFmuEU
    tEySCHmFmyO1Jo95cbYld1vI+mrzB+rN1uba3i7HSSzXjrcoWChXIvlQhkTjJ0Owm6bszC
    4VjfKNsF/CZeyu5o8efMctxWXJMYpbhAHnghcaNvtQ1x1wMNxw9+t6LXF/HDA9gXjTrEp2
    H4aI5wf6/s0LZblVCfcd4cQ5fWmAyoqySaVLFys4TastGdGU3tFQ6YRTKI3cCGLjUyXh/f
    /khZBHxKMg9sKo4vpXchNvftdGpFuuxAAR6xfHKfiZZ6hbefE9Kti2WHplt+wXvS3Sh7C9
    cyOCZo6fxAFZN1ZnbcOlVuYwxpnTmrWHQcAhwsnC5LIJn6rMVspBAg6C2RBscdctr7U2LI
    tq6K9LzZmLAt8t0aAYI/Dd0/clq3lnRDSnXlyg5k/2HJwpahQC8nn8VCXbbkRkH0tkTaWN
    8Gm0xNQalwhmyl1+WLUMRAJ/ue1DCBmcDX80uqe2N0FckOjt7b8rmwmx3qNAgY05kDCW7K
    tUUXdTnb9i2H92bYuq4zpLnkKAKOlviaB8v+JAV0vAWl2Fk8CpVOu6lFe/iBTlNlUe7Csa
    s5e1aHGRElcJMcyT0y0m47MlgK4jho+Uu1SvuksNQB412fts+5XqmIBdEwiQ
X-ME-Proxy: <xmx:w806amzRokRAerraTfgOcqc1E90kq8ybgEjvfH_KJ4oTfF-JVrQpIA>
    <xmx:w806asU99NHLQYuUrGMPsK-0cKe8CNOBBWrh6fwxLUx3B6atV0AaZw>
    <xmx:w806atSWw6n-KtO9E9KdlmdxwSF8VtRe46dzJvtWx6LAlyLKloBYAw>
    <xmx:w806akSTJ1_58dWwpxb1CoMdOz5_RLiXQ4OhjIU4pyMrwprYv8M3pw>
    <xmx:xM06aqbnnXKnTMOinT4ywTBWXnuJ4pTqxNRz-U7kKqeK07Szc6HXmcuE>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jun 2026 14:17:38 -0400 (EDT)
Date: Tue, 23 Jun 2026 12:17:36 -0600
From: Alex Williamson <alex@shazbot.org>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Michael Guralnik <michaelgur@nvidia.com>, Sumit Semwal
 <sumit.semwal@linaro.org>, Christian Konig <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, <kvm@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, alex@shazbot.org
Subject: Re: [PATCH v9 3/4] vfio/pci: implement get_pci_tph and DMA_BUF_TPH
 feature
Message-ID: <20260623121736.4d9e38b9@shazbot.org>
In-Reply-To: <20260622184211.2229399-4-zhipingz@meta.com>
References: <20260622184211.2229399-1-zhipingz@meta.com>
	<20260622184211.2229399-4-zhipingz@meta.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[shazbot.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[shazbot.org:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22437-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:zhipingz@meta.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:michaelgur@nvidia.com,m:sumit.semwal@linaro.org,m:christian.koenig@amd.com,m:bhelgaas@google.com,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:alex@shazbot.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[alex@shazbot.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[shazbot.org:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@shazbot.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,messagingengine.com:dkim,shazbot.org:dkim,shazbot.org:mid,shazbot.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DFB1C6B967F

On Mon, 22 Jun 2026 11:41:36 -0700
Zhiping Zhang <zhipingz@meta.com> wrote:

> Implement dma-buf get_pci_tph for vfio-pci exported dma-bufs and add
> VFIO_DEVICE_FEATURE_DMA_BUF_TPH so userspace can publish TPH metadata
> for a VFIO-owned device.
> 
> 8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces; the
> uAPI carries both with explicit validity flags, and get_pci_tph()
> returns the value matching the importer's requested namespace or
> -EOPNOTSUPP.
> 
> Publish and read the TPH descriptor under dmabuf->resv, matching the
> locking used for other importer-visible dma-buf state. The SET ioctl
> takes dma_resv_lock_interruptible(), while the callback runs under
> DMA-buf's asserted resv lock.
> 
> Reject requests the device cannot consume as a completer:
> pcie_tph_completer_type() must report at least
> PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY, and Extended ST requires
> PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH. Make PROBE follow the same hardware
> gate so the feature only probes as supported when the device can really
> consume it.
> 
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c   |  3 +
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 97 +++++++++++++++++++++++++++++-
>  drivers/vfio/pci/vfio_pci_priv.h   | 12 ++++
>  include/uapi/linux/vfio.h          | 37 ++++++++++++
>  4 files changed, 148 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index a28f1e99362c..c7d6902bc61b 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1572,6 +1572,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
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
> index c16f460c01d6..d6f5dd321000 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -3,6 +3,7 @@
>   */
>  #include <linux/dma-buf-mapping.h>
>  #include <linux/pci-p2pdma.h>
> +#include <linux/pci-tph.h>
>  #include <linux/dma-resv.h>
>  
>  #include "vfio_pci_priv.h"
> @@ -19,7 +20,14 @@ struct vfio_pci_dma_buf {
>  	u32 nr_ranges;
>  	struct kref kref;
>  	struct completion comp;
> -	u8 revoked : 1;
> +
> +	/* Protected by dmabuf->resv. */

Nit, it would be more accurate to say:

	/*
	 * Updates protected by dmabuf->resv, @revoked additionally
	 * protected by memory_lock.
	 */

revoked also has an unprotected read, but it's previously existing and
benign, and likely just needs a READ_ONCE() annotation.

> +	u16 tph_st_ext;
> +	u8 tph_st;
> +	u8 revoked:1;
> +	u8 tph_st_valid:1;
> +	u8 tph_st_ext_valid:1;
> +	u8 tph_ph:2;
>  };
>  
>  static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
> @@ -69,6 +77,26 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *attachment,
>  	return ret;
>  }
>  
> +static int vfio_pci_dma_buf_get_pci_tph(struct dma_buf *dmabuf, bool extended,
> +					u16 *steering_tag, u8 *ph)
> +{
> +	struct vfio_pci_dma_buf *priv = dmabuf->priv;
> +
> +	dma_resv_assert_held(dmabuf->resv);
> +
> +	if (extended) {
> +		if (!priv->tph_st_ext_valid)
> +			return -EOPNOTSUPP;
> +		*steering_tag = priv->tph_st_ext;
> +	} else {
> +		if (!priv->tph_st_valid)
> +			return -EOPNOTSUPP;
> +		*steering_tag = priv->tph_st;
> +	}
> +	*ph = priv->tph_ph;
> +	return 0;
> +}
> +
>  static void vfio_pci_dma_buf_unmap(struct dma_buf_attachment *attachment,
>  				   struct sg_table *sgt,
>  				   enum dma_data_direction dir)
> @@ -101,6 +129,7 @@ static void vfio_pci_dma_buf_release(struct dma_buf *dmabuf)
>  
>  static const struct dma_buf_ops vfio_pci_dmabuf_ops = {
>  	.attach = vfio_pci_dma_buf_attach,
> +	.get_pci_tph = vfio_pci_dma_buf_get_pci_tph,
>  	.map_dma_buf = vfio_pci_dma_buf_map,
>  	.unmap_dma_buf = vfio_pci_dma_buf_unmap,
>  	.release = vfio_pci_dma_buf_release,
> @@ -333,6 +362,72 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
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
> +	u8 comp;
> +	int ret;
> +
> +	comp = pcie_tph_completer_type(vdev->pdev);
> +	if (comp == PCI_EXP_DEVCAP2_TPH_COMP_NONE)
> +		return -EOPNOTSUPP;
> +
> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
> +				 sizeof(set_tph));
> +	if (ret != 1)
> +		return ret;
> +
> +	if (copy_from_user(&set_tph, arg, sizeof(set_tph)))
> +		return -EFAULT;
> +
> +	if (set_tph.flags & ~(VFIO_DMA_BUF_TPH_ST | VFIO_DMA_BUF_TPH_ST_EXT))
> +		return -EINVAL;
> +
> +	if (set_tph.ph & ~0x3)
> +		return -EINVAL;
> +
> +	if ((set_tph.flags & VFIO_DMA_BUF_TPH_ST_EXT) &&
> +	    comp != PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH)
> +		return -EOPNOTSUPP;
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
> +	if (priv->vdev != vdev) {
> +		ret = -EINVAL;
> +		goto out_put;
> +	}
> +
> +	ret = dma_resv_lock_interruptible(dmabuf->resv, NULL);
> +	if (ret)
> +		goto out_put;
> +
> +	priv->tph_st         = set_tph.steering_tag;
> +	priv->tph_st_ext     = set_tph.steering_tag_ext;
> +	priv->tph_ph         = set_tph.ph;
> +	priv->tph_st_valid   = !!(set_tph.flags & VFIO_DMA_BUF_TPH_ST);
> +	priv->tph_st_ext_valid =
> +		!!(set_tph.flags & VFIO_DMA_BUF_TPH_ST_EXT);
> +	dma_resv_unlock(dmabuf->resv);
> +	ret = 0;
> +
> +out_put:
> +	dma_buf_put(dmabuf);
> +	return ret;
> +}
> +
>  void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
>  {
>  	struct vfio_pci_dma_buf *priv;
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
> index 5de618a3a5ee..2d30ba43e2cf 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1534,6 +1534,43 @@ struct vfio_device_feature_dma_buf {
>   */
>  #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
>  
> +/**
> + * Upon VFIO_DEVICE_FEATURE_SET associate TPH (TLP Processing Hints) metadata
> + * with a vfio-exported dma-buf. The dma-buf must have been created by
> + * VFIO_DEVICE_FEATURE_DMA_BUF on this device, and the device must report
> + * TPH Completer support in Device Capabilities 2 (bits 13:12); requests
> + * carrying VFIO_DMA_BUF_TPH_ST_EXT additionally require the device to
> + * report the Extended TPH Completer encoding. Otherwise the ioctl
> + * returns -EOPNOTSUPP.
> + *
> + * dmabuf_fd is the file descriptor returned by VFIO_DEVICE_FEATURE_DMA_BUF.
> + *
> + * 8-bit ST (steering_tag) and 16-bit Extended ST (steering_tag_ext) are
> + * distinct namespaces. Userspace supplies whichever values are valid and sets
> + * the matching VFIO_DMA_BUF_TPH_ST / VFIO_DMA_BUF_TPH_ST_EXT bits in @flags;
> + * an importer requests one namespace and receives the matching value.
> + *
> + * @flags == 0 marks any previously published ST / Extended-ST as invalid
> + * for future PCI TPH queries on this dma-buf.

I think we should avoid "published" as it still suggests we're somehow
able to invalidate what was previously reported and consumed.  It's
offset by the trailing clause here, but that's absent below.

Also, we're noting @flags == 0 as if it's a special case, but we really
need the clarity that if either flag bit is not set, the corresponding
field is marked invalid for future queries.  Perhaps something like:

   * @flags is the authoritative validity for each namespace: when
   * VFIO_DMA_BUF_TPH_ST is set, @steering_tag becomes the valid 8-bit ST; when
   * VFIO_DMA_BUF_TPH_ST_EXT is set, @steering_tag_ext becomes the valid 16-bit
   * Extended ST.  A namespace whose bit is clear is marked invalid and
   * reported as unsupported to importers requesting it.
   *
   * Each SET fully replaces the dma-buf's TPH state: any namespace not selected
   * in @flags is left invalid, so @flags == 0 marks both ST and Extended ST
   * invalid.  This only affects TPH queries made after the SET completes; an
   * importer that has already retrieved a value is unaffected.  Userspace must
   * therefore configure TPH before handing the dma-buf fd to an importer.

> + *
> + * ph is the 2-bit TLP Processing Hint and must be in the range [0, 3].

Slight inconsistency here, @ph.  We might also help to silence the
Sashiko warning to note:

   * Undefined @flags and @ph bits must always be zero.

> + *
> + * Userspace must publish TPH before handing the dma-buf fd to an importer.
> + * Calling SET again replaces the published values.

The above suggestion is meant to replace this as well.

> + */
> +#define VFIO_DEVICE_FEATURE_DMA_BUF_TPH 13

There are several series in-flight contending for device feature
indexes, so this should really go in through the vfio tree to reduce
the risk of duplicates.  We also still need acks from the relevant
maintainers for PCI, dma-buf, and mlx5 before this can be queued for
v7.3.  Thanks,

Alex

> +
> +#define VFIO_DMA_BUF_TPH_ST		(1 << 0)
> +#define VFIO_DMA_BUF_TPH_ST_EXT		(1 << 1)
> +
> +struct vfio_device_feature_dma_buf_tph {
> +	__s32	dmabuf_fd;
> +	__u32	flags;
> +	__u16	steering_tag_ext;
> +	__u8	steering_tag;
> +	__u8	ph;
> +};
> +
>  /* -------- API for Type1 VFIO IOMMU -------- */
>  
>  /**


