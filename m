Return-Path: <linux-rdma+bounces-20053-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECqEHrLm+mnZTwMAu9opvQ
	(envelope-from <linux-rdma+bounces-20053-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 08:58:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF344D6E20
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 08:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 196AB300788E
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 06:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE51368282;
	Wed,  6 May 2026 06:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="rY2rX3cL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AE9367F5B;
	Wed,  6 May 2026 06:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778050733; cv=none; b=HjX2dY1N22/jib2V/i4wAuddnG+nLSWFm0ZaQI/E+JBPFu+kM40EuwSkkbTS+nGfkR1PnlonBefqMXzwFDZ1RueVRMqa0I3ZxipuQ5Pkk11ffV2gf5XDUi6F3NdTslO0bSRuLg12dfIKmtSrDUdhKZZadN5GEKhrufmSWKcZYog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778050733; c=relaxed/simple;
	bh=sY5tng38gcB9d6yfv3moDi7zkrwX/tSnnQN2YfeTxTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BuhEV6eG7C9Mj80QlK/CYRAC/9qmiZgwRfb1/bQ3rDChvMY6O4FVMQJDBGUQU2svq577hwFtkbfMwklMP6gcvfEVPSmhR+sDhb20mB90Cxer3oj9GWYSxb9f/n0kjA6zFlWRuU+StpbFuwug+pGsHZzTFXshNpW1riB7NPeiAqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=rY2rX3cL; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=G+HgQJkz+cXLEu0vkzPQS/AfVAtum3DymBhzhdmqjVs=;
	b=rY2rX3cL84ykQx4bxmZDkhviFef06MCpPOpPN/6UkenY5nWH5h/U4p1LKj/2mpw0dC1/MB0HE
	hqH2vyo0WbUM5fEsGK7zR5cE6xmrv0anu8sHiIWRifN57edlqcXoCcY838w05MWV0kTMzsmw/qG
	u+PDj81kbdjK1hd/OUJbjwU=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4g9QzT0pKszKm4C;
	Wed,  6 May 2026 14:52:05 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 1AEBB402AB;
	Wed,  6 May 2026 14:58:38 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 May 2026 14:58:37 +0800
Message-ID: <09995589-b81d-4cb7-a313-15a943d8b28d@huawei.com>
Date: Wed, 6 May 2026 14:58:36 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] vfio: add dma-buf get_tph callback and DMA_BUF_TPH
 feature
To: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dri-devel@lists.freedesktop.org>, Keith Busch <kbusch@kernel.org>, Yochai
 Cohen <yochai@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
References: <20260430200704.352228-1-zhipingz@meta.com>
 <20260430200704.352228-2-zhipingz@meta.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260430200704.352228-2-zhipingz@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk500009.china.huawei.com (7.202.194.94)
X-Rspamd-Queue-Id: 1FF344D6E20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-20053-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fengchengwen@huawei.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:dkim,huawei.com:mid,meta.com:email]

On 5/1/2026 4:06 AM, Zhiping Zhang wrote:
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
> 
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

The checker will failed in following cases:
1. If the exporter passed 8bit st, and importer support 16bit st, then it will pass
   the checker.
2. The exporter enabled 16bit st and its st is < 256 (note: the pcie protocol doesn't
   restrict 16bit-st must >=256), and importer only support 8bit st, then it will also
   pass the checker

Suggest userspace passing both st(8bit) and extend-st(16bit), and importer chose the
right one.

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
> 
> 


