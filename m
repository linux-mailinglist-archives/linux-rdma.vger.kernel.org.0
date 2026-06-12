Return-Path: <linux-rdma+bounces-22183-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cIonJK09LGrkOAQAu9opvQ
	(envelope-from <linux-rdma+bounces-22183-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 19:11:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E98367B3CB
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 19:11:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=shazbot.org header.s=fm3 header.b=MNb6Ua7Y;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="j bCkp2g";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22183-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22183-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=shazbot.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 791C731DD7D5
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 17:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14B732A3C8;
	Fri, 12 Jun 2026 17:10:10 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5073B403E9C;
	Fri, 12 Jun 2026 17:10:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781284210; cv=none; b=V+zbgf/dEkdQW0TkIyCqs+EtR8qQLF3npYoUxwzSviuCtN3vSzhEWqxcp52h5BmwSuiHv+Cikefvbse/DlGq9GEOj331yTDy3kUDvan3vHg3rorz1kKgq6hHGI1h7BwCaNPyh/u+7ui86O5/9bGIOb1rTw2ZLKVdmCejsQ0SeXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781284210; c=relaxed/simple;
	bh=fG+XmCzE45XW0FY4ebe02cN/lSzEKhscc7vqLY4vsbw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q0IN0mUguxL339F6dpxgzeEaTyurLy3ZbdwQa/MlVToWXx3mImzG9/YBprTUKtQbicSHBxr5YaA923oTpRI5NxFMLePn66Gov12ETrcbmm+yOVLHHeu9tQwWeVg7+DdiOU6GpbbcJ5l7e2NY/eU7tMY7QBZKnQZllmuKuKNmH+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=MNb6Ua7Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jbCkp2gL; arc=none smtp.client-ip=103.168.172.158
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8B83D1400093;
	Fri, 12 Jun 2026 13:10:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 12 Jun 2026 13:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781284207;
	 x=1781370607; bh=uXPu8m1b4LfsdazZMZSxqNEOeTjV++CgcADUhsyfUeM=; b=
	MNb6Ua7YSu32IApBA5mRd7kQOUSLa5/s3TA3r7AL09THGdZ4eUyQuHYJyfeizhNY
	WHLd/AeTmGmkLS5jU9UMuVe0DtfmKybvzS/wt/BDVhLqCirqtOqfGmasbirgubnK
	sKjsUlFgc+W25QTOeO8L60bxX5NqXA4yAKS/4cF/OIS1b+9CIjJCaA/AwRr0zobC
	g7nULtbDR35uZFm1Dx9HlAtEa7XdYzw5kGRaCc/RLVPskCpHsNSADP5w58ONIXjF
	Sh5tyRM8InYSFZ5GtpYDx0ZEhwCgEzKpwEnbiz2mvn13t0ktxdtkv24JYiWDPVHx
	WtdgVyXnJWaLeVQFGndDXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781284207; x=
	1781370607; bh=uXPu8m1b4LfsdazZMZSxqNEOeTjV++CgcADUhsyfUeM=; b=j
	bCkp2gLg6Hj0/adO0GXnpecpBWhL2Yp4hm9hpDZPMN0aoTfX7zS6n5QllELA1VSd
	X42f9X7vcjOuiKi/jbZY71p6QpoJM5ZR/OpMBJfdka9seTyqyNJFQ8Tg+NLDI/6Q
	qpIr4dnm5V8Rz85jkUoPhV2WisSuahFlnD1XHfayVIQe5/a3HHFPFofAEuZWiqP3
	KgBzPl3+wUW3kl/0p/bd2/WZEksLY4sfBJCWVQY/9V1Bb2WEoX3wN1sDySKPmOi9
	NhGY/Xf3ay+94cwPPR1tqoCTUXuq6LeUfMO7xsCGxQXDiDy7HmfUTPL0FjbFratk
	FziaYsnePaQRPbyxSW8MQ==
X-ME-Sender: <xms:bj0sajOjKj_TAl1L9--J7mGO49zQgCFQSykkn1A0KM4KyyBVo0T01g>
    <xme:bj0san9stFVx11t1qgq2L5flwXSXDgchRBqVlbOKu2D25fWO56JfTjp-s7gqwAao8
    YyIWeQ3ExX_eYz60Qjk31adNqxk5CFAAw1gwAT_bsaH448GXdwwGA>
X-ME-Received: <xmr:bj0sao7anuaFR8uSNLIywxQ6tO8L2YxbQSZMHQn8-sFVJ4lAqx-JLAbA740>
X-ME-Proxy-Cause: dmFkZTFq8oIRNnYTRa5VsIWKAotKciRe7g5kPPez2qGfRxO7xJ2ESUxldZb++Gn240UZJG
    cN9mBkn5NoSA+Cl+XRikFU9KyryI5lA5oLityp4dVYPDM282yKokcsWwNrnETMgeummea3
    tsE43v7JVYidxlFiWvgxVCrT8em5Fj+uvkqhLE7qKQUPlASOf9+wd3+h5CvfGiYCR8x6fE
    k0MBl0k3btXl+aepFawep9OOkzzfBK8iEcXwvwW+yZ0INKrpUrGT3/ki9bvxvUe2pc9OM5
    3BVue8yJ4jd/tFQSApCl9nS4QOGrvZxdbeAK6kBOKS7qHOEtLTGQG2LIeZxCeTOkhCN+I+
    8ozEiY1pKdMidmH/GP7/DQfPKt9jPG7+yivnAtxqbHlQGbfItHpUuw6hnUiKsOjP+dfCDR
    tvt0wviDwWGXTnOuRDqVsPQ1PXD6TDsYfFfH9FsaKypsvlt+wRZDjxz/non5FqgUCbv9ev
    Kv2bYThO7HwikI4T6dWFlaM4+9cD99pIJGO06ZfBtI+0Tb/WNOpI96uinZ8zgdln/W7oFf
    FKxs10RLKq0xe7nXfRmwMfthJOtxlWURiTZwSFY6HPAo+8UNRp27RprLLj09CpspHa2vuU
    UV9aUaVO4s5e4htTv6x6QkRLanXDa8L8i4+OwCI0FOFypQeK7YdlYRLCaAFA
X-ME-Proxy: <xmx:bj0sal6gnmkK_RtnXhqBMdsT3UiwI-d8aHF_C-wdQYPfyWqYNsqylQ>
    <xmx:bj0sapoMCloFMcnly2OyJDDg5XH4nvaEi6JmValIKjBgNtt1fGQ_wg>
    <xmx:bj0sauOZRbrLkITgz7UJeBeSc4_SvHSQkibge7BUvgA-oHe3fCWK5g>
    <xmx:bj0sap1MRha2KEF3R9tOy3k4bVhFCCCzUurzeP8yVsqpKtXnDHl2vw>
    <xmx:bz0sanHXQSl09-4_NdiCZ1zJ2yyhNsoyFiOAaA5KIKwABvqWpB-xTUNl>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 13:10:05 -0400 (EDT)
Date: Fri, 12 Jun 2026 11:10:01 -0600
From: Alex Williamson <alex@shazbot.org>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: <netdev@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, alex@shazbot.org
Subject: Re: [PATCH v7 4/5] vfio/pci: implement get_tph and DMA_BUF_TPH
 feature
Message-ID: <20260612111001.5b7206eb@shazbot.org>
In-Reply-To: <20260611161546.4075580-5-zhipingz@meta.com>
References: <20260611161546.4075580-1-zhipingz@meta.com>
	<20260611161546.4075580-5-zhipingz@meta.com>
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[shazbot.org:+,messagingengine.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22183-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[alex@shazbot.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:zhipingz@meta.com,m:netdev@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:alex@shazbot.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@shazbot.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,messagingengine.com:dkim,shazbot.org:dkim,shazbot.org:mid,shazbot.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,set_tph.ph:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E98367B3CB

On Thu, 11 Jun 2026 09:11:19 -0700
Zhiping Zhang <zhipingz@meta.com> wrote:

> Implement dma-buf get_tph for vfio-pci exported dma-bufs and add
> VFIO_DEVICE_FEATURE_DMA_BUF_TPH so userspace can publish TPH metadata
> for a VFIO-owned device.
> 
> 8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces; the
> uAPI carries both with explicit validity flags, and get_tph() returns
> the value matching the importer's requested namespace or -EOPNOTSUPP.
> 
> Publish and read the TPH descriptor under dmabuf->resv, matching the
> locking used for other importer-visible dma-buf state. The SET ioctl
> takes dma_resv_lock_interruptible(), while the callback runs under
> DMA-buf's asserted resv lock.
> 
> Reject requests the device cannot consume as a completer:
> pcie_tph_completer_type() must report at least
> PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY, and Extended ST requires
> PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH. Validate fields before the completer
> check so userspace gets the narrowest errno.
> 
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c   |  3 +
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 94 +++++++++++++++++++++++++++++-
>  drivers/vfio/pci/vfio_pci_priv.h   | 12 ++++
>  include/uapi/linux/vfio.h          | 37 ++++++++++++
>  4 files changed, 145 insertions(+), 1 deletion(-)
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
> index 1a177ce7de54..0a0705c8dbea 100644
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
> @@ -19,7 +20,12 @@ struct vfio_pci_dma_buf {
>  	u32 nr_ranges;
>  	struct kref kref;
>  	struct completion comp;
> -	u8 revoked : 1;
> +	u8 tph_st_valid:1;
> +	u8 tph_st_ext_valid:1;
> +	u8 tph_ph:2;
> +	u8 tph_st;
> +	u16 tph_st_ext;
> +	u8 revoked:1;

If these bitfields are now all protected under dma_resv_lock they
should be grouped together with a comment to that effect, no need for
revoked to get kicked out to its own storage unit.  In [1] I'm
proposing runtime modified flags each get their own storage unit, but
for more isolated cases, so long as we keep track and enforce serialized
updates, I'm ok with runtime bitfields.  Thanks,

Alex

[1]https://lore.kernel.org/all/20260611213539.4100590-1-alex.williamson@nvidia.com/

>  };
>  
>  static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
> @@ -69,6 +75,26 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *attachment,
>  	return ret;
>  }
>  
> +static int vfio_pci_dma_buf_get_tph(struct dma_buf *dmabuf, bool extended,
> +				    u16 *steering_tag, u8 *ph)
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
> @@ -101,6 +127,7 @@ static void vfio_pci_dma_buf_release(struct dma_buf *dmabuf)
>  
>  static const struct dma_buf_ops vfio_pci_dmabuf_ops = {
>  	.attach = vfio_pci_dma_buf_attach,
> +	.get_tph = vfio_pci_dma_buf_get_tph,
>  	.map_dma_buf = vfio_pci_dma_buf_map,
>  	.unmap_dma_buf = vfio_pci_dma_buf_unmap,
>  	.release = vfio_pci_dma_buf_release,
> @@ -333,6 +360,71 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
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
> +	comp = pcie_tph_completer_type(vdev->pdev);
> +	if (comp == PCI_EXP_DEVCAP2_TPH_COMP_NONE)
> +		return -EOPNOTSUPP;
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
> index 5de618a3a5ee..5dd693220a0d 100644
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
> + * for future get_tph() requests on this dma-buf.
> + *
> + * ph is the 2-bit TLP Processing Hint and must be in the range [0, 3].
> + *
> + * Userspace must publish TPH before handing the dma-buf fd to an importer.
> + * Calling SET again replaces the published values.
> + */
> +#define VFIO_DEVICE_FEATURE_DMA_BUF_TPH 13
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


