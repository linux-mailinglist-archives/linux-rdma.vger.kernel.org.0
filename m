Return-Path: <linux-rdma+bounces-19954-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJWnOWYT+WnV5AIAu9opvQ
	(envelope-from <linux-rdma+bounces-19954-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 23:45:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC8C4C433A
	for <lists+linux-rdma@lfdr.de>; Mon, 04 May 2026 23:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26190301468B
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 21:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685663630AC;
	Mon,  4 May 2026 21:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="u2WYQ6Uu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aKlRNK6C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BCE3630B2;
	Mon,  4 May 2026 21:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777931107; cv=none; b=jbqoQyyqg+zUy8Z9edg8HbOCN584kH8wyXy4kS5maC9+FD1EUZfe3oydChQNlmQ7bbNP5KbZdoUTRMy23Rb/VjLVfNsFGaFYki4wxN/u8yfWSxeqoUFOX+wPiyvpy8uibou6FKCTzUD/fUYmhTrEh8iX2MT1Wb/w00CIgFYTUSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777931107; c=relaxed/simple;
	bh=2V0GjmRpASTcxDhwzO1jdLMdFPf0GxO5qhZOBZdEFmg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RaUu9vDz6Xz/8EeNCYftKRrS2lUnqGGnErkrNcHSo6ymFsWP4RwdJh48yqf42gbFQOK1Z49msFREUdsHz3p4KpPGhjn+L8D9rYDbQIpzL04SjH2EZs9w3SmJogHkpGvmOrRz4E8wSmOrhReXmUWE+Bonrnp+jSR7Gw81jlO8En8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=u2WYQ6Uu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aKlRNK6C; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2DFFD7A00E1;
	Mon,  4 May 2026 17:45:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 04 May 2026 17:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777931103;
	 x=1778017503; bh=OlSrzNwR1CmvKwsGitkBEdA3NqGhfCJH662kCZt/3r0=; b=
	u2WYQ6Uu2KBrknnMFCQlgjyWBH5bLy2MKSnl9TL87RibXUahAgyKLZQz/sscqRng
	hKQHdRwLh1RL158ZjL3IPdSZHHIbxX8nSpyDNQai8Rf2wdrKozW1W9F5GqzQSnQE
	uKOq+WQr5rKq9uifY/F0VIaHDmmqHySIQ7Y6zBya/laY0e+UK+JhVG8L6C+sEuBQ
	TrVDfVA6kpKBu/ciRky42FfOsLpdX2YLCizuh2pB2mJnTwo/G+t2ne2WOvwjkuAW
	lGqWQSDUe67s2cL4Ae/nr3M5P084kiwDr6I/fhW2EDLFSyT1iTVsDMdOoFvjl4VI
	d8jgFikcBoRdWyTvw+mCKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777931103; x=
	1778017503; bh=OlSrzNwR1CmvKwsGitkBEdA3NqGhfCJH662kCZt/3r0=; b=a
	KlRNK6CDog0qPrHp2p3/xHIFC6EAUPUwTgZfc6zyZIugdY2hoDC+C5o9CCg0oSC/
	xkdSBhEOr8zX4lHUUWFNMs51R3R98/vLgIulIliN8aehif8/3TSU3h1rCQAZk0s3
	EqKTDGxg0XXR/ns+S8j1zgZzKpx1RkvXOCN0/yVd72zfop1rqCaJkKB+2HezFA/u
	AVfxnu97ysc2gaTfIhNVglneNkfjnBSuybXPizAl6gRcUCrRn2pO7gsw/pTH25w+
	48MiCuy5J83ZMKvpC3BV5sP4S+jsl47vlXCnMJjSpN2jBXk/OQ5arksBN/Wq5R3n
	2g4iB+MUCj3QRW39pW38g==
X-ME-Sender: <xms:XxP5abNp_6jzROaygyUxuZIi2Sfe9p9hH9fCqo7KYS4ZVEalARZ87Q>
    <xme:XxP5acVRJWvhqDkKINawXeGKvu29RbXTAx_TLFsm63ETyLKo_5f_DmN8Vm7uekHXO
    29Qa6zpc8IN4VBE1PvbATfeUunP4drZ8ReM9Cya1PYkU5jpJtvqVw>
X-ME-Received: <xmr:XxP5aWjw5togl-E-fvGwT1lgnhNB50KrU8cG8NFcARCOdN7PwcL8KBQ7Uas>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelleelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfgjfhfogggtgfesthejredtredtvdenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepkeelffevieeuheeiieeifeelteffheeiffekledvleejgedthfdvjeehudff
    ledvnecuffhomhgrihhnpehsrghshhhikhhordguvghvnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhg
    pdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepii
    hhihhpihhnghiisehmvghtrgdrtghomhdprhgtphhtthhopehjghhgseiiihgvphgvrdgt
    rgdprhgtphhtthhopehlvghonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgvlh
    hgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrhgumhgrsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvg
    guvghskhhtohhprdhorhhgpdhrtghpthhtohepkhgsuhhstghhsehkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:XxP5adhrn-X3lMuQKFhBxNc05YU7BNl-iLyjUMQ5ANsGEhJua-JtQg>
    <xmx:XxP5acEFz1M3kD8WF8YH1HN2mgUFzmuFGgW1BHE9gppL4vbipx5RWg>
    <xmx:XxP5aSAl52d32IoyjnYnW-0WGkwRxr_6Duss9bz4vMn9gu1Iclsucg>
    <xmx:XxP5aaBxM1wcE8nEMklL4h8FOTerGFfDxsGx2GtGHkdGlHJOdrvaXw>
    <xmx:XxP5aaCL4_QhABUW956FJqUirCoMKNMZoo1aDA6d0eZOFbJYiH530tSq>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 May 2026 17:45:00 -0400 (EDT)
Date: Mon, 4 May 2026 15:44:59 -0600
From: Alex Williamson <alex@shazbot.org>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Bjorn
 Helgaas <helgaas@kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, Keith Busch <kbusch@kernel.org>, Yochai
 Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
 alex@shazbot.org
Subject: Re: [PATCH v2 1/2] vfio: add dma-buf get_tph callback and
 DMA_BUF_TPH feature
Message-ID: <20260504154459.77b8153d@shazbot.org>
In-Reply-To: <20260430200704.352228-2-zhipingz@meta.com>
References: <20260430200704.352228-1-zhipingz@meta.com>
	<20260430200704.352228-2-zhipingz@meta.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5CC8C4C433A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[shazbot.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[shazbot.org:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19954-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[shazbot.org:+,messagingengine.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@shazbot.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shazbot.org:dkim,shazbot.org:mid,meta.com:email,sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim]

On Thu, 30 Apr 2026 13:06:56 -0700
Zhiping Zhang <zhipingz@meta.com> wrote:

> Add a dma-buf callback that returns raw TPH metadata from the exporter
> so peer devices can reuse the steering tag and processing hint
> associated with a VFIO-exported buffer.
> 
> Add a new VFIO_DEVICE_FEATURE_DMA_BUF_TPH ioctl that takes the fd from
> VFIO_DEVICE_FEATURE_DMA_BUF along with a steering tag and processing
> hint, validates the fd is a vfio-exported dma-buf belonging to this
> device, and stores the TPH values under memory_lock. This keeps the
> existing VFIO_DEVICE_FEATURE_DMA_BUF uAPI completely unchanged.
> 
> The user sequences setting TPH on the dma-buf before the importer
> consumes it.
> 
> Add an st_width parameter to get_tph() so the exporter can reject
> steering tags that exceed the consumer's supported width (8 vs 16 bit).
> When no TPH metadata was supplied, get_tph() returns -EOPNOTSUPP.
> 
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

The uAPI is better, but sashiko has some review comments[1] for you.

Please also copy the kvm list for vfio related development.  Thanks,

Alex

[1]https://sashiko.dev/#/patchset/20260430200704.352228-1-zhipingz@meta.com

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1534,6 +1534,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
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
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -19,6 +19,9 @@ struct vfio_pci_dma_buf {
>  	u32 nr_ranges;
>  	struct kref kref;
>  	struct completion comp;
> +	u16 steering_tag;
> +	u8 ph;
> +	u8 tph_present : 1;
>  	u8 revoked : 1;
>  };
>  
> @@ -69,6 +72,22 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *attachment,
>  	return ret;
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
> @@ -101,6 +120,7 @@ static void vfio_pci_dma_buf_release(struct dma_buf *dmabuf)
>  
>  static const struct dma_buf_ops vfio_pci_dmabuf_ops = {
>  	.attach = vfio_pci_dma_buf_attach,
> +	.get_tph = vfio_pci_dma_buf_get_tph,
>  	.map_dma_buf = vfio_pci_dma_buf_map,
>  	.unmap_dma_buf = vfio_pci_dma_buf_unmap,
>  	.release = vfio_pci_dma_buf_release,
> @@ -331,6 +351,55 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
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
> +
> +	if (copy_from_user(&set_tph, arg, sizeof(set_tph)))
> +		return -EFAULT;
> +
> +	if (set_tph.reserved)
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
> +	down_write(&vdev->memory_lock);
> +	if (priv->vdev != vdev) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	priv->steering_tag = set_tph.steering_tag;
> +	priv->ph = set_tph.ph;
> +	priv->tph_present = 1;
> +	ret = 0;
> +
> +out_unlock:
> +	up_write(&vdev->memory_lock);
> +out_put:
> +	dma_buf_put(dmabuf);
> +	return ret;
> +}
> +
>  void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
>  {
>  	struct vfio_pci_dma_buf *priv;
> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
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
> @@ -128,6 +132,13 @@ vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>  {
>  	return -ENOTTY;
>  }
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
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
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
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1534,6 +1534,28 @@ struct vfio_device_feature_dma_buf {
>   */
>  #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
>  
> +/**
> + * Upon VFIO_DEVICE_FEATURE_SET associate TPH (TLP Processing Hints) metadata
> + * with a vfio-exported dma-buf. The dma-buf must have been created by
> + * VFIO_DEVICE_FEATURE_DMA_BUF on this device.
> + *
> + * dmabuf_fd is the file descriptor returned by VFIO_DEVICE_FEATURE_DMA_BUF.
> + * steering_tag and ph are the raw TPH values that importing drivers should use
> + * when accessing the buffer.
> + *
> + * The user must set TPH on the dma-buf before the importer consumes it.
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +#define VFIO_DEVICE_FEATURE_DMA_BUF_TPH 13
> +
> +struct vfio_device_feature_dma_buf_tph {
> +	__s32	dmabuf_fd;
> +	__u16	steering_tag;
> +	__u8	ph;
> +	__u8	reserved;
> +};
> +
>  /* -------- API for Type1 VFIO IOMMU -------- */
>  
>  /**


