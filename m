Return-Path: <linux-rdma+bounces-18744-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NV7FFc7x2k+UgUAu9opvQ
	(envelope-from <linux-rdma+bounces-18744-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2026 03:22:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA81A34D0DA
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2026 03:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2262D30427FD
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Mar 2026 02:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08023314B77;
	Sat, 28 Mar 2026 02:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="2JF+WD79"
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FC4C2FD;
	Sat, 28 Mar 2026 02:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774664528; cv=none; b=WKHkmR7Ns6nA4n+y/0iRbgk2x9bEvDNCSXTQPuvpmIzFGmbhE4JstBEhGJUpf/R1c4KG69Q4oxRLwzSsTatM7UKC9KruXaVHSsqXhOuLHh3S3URvnrUM+deEfobY4E0LjszEfUfXN6zuyK4GrUBshe5In051h/brvuS5EiUE9qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774664528; c=relaxed/simple;
	bh=ilKV3fBIfOdo+efVbzrEw7HNYJHL5ePWB8l7pDMop2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=D+/qJLw1wwjBZ40P/aI6IJ5sATLeoB/kwxus0PNUSCEpuq5IuPHTT1L3eR/d7oceU+QRAVRZV5Bmfl+rpZcqeJoy48SU15tW552u/mbz6x4kqL1Hxfvgeq6W2vximhdVUUYPvTQ8jT8P0HrV+mBGEOvk+46BCPdmCFfYibRQA+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=2JF+WD79; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1OkLiW8Ed78xDJTW8wn1LfvAVL5T6iaxi219R/4j/pQ=;
	b=2JF+WD79kpjFM25pn6LCZ/yf1qTkA1lCV4qAW3Hli7RNh88wNlL/rQrdh3W/cX8hNZxHZ2lkE
	H8a4NvDibeihCShBjV0YH5znkUSkE+HPMlmAkPBcdlkb6oHMDLEHmW+jExzY7dk/sMbRagOAkdE
	jipw2J80WKKr6DZU8huwfzA=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fjLjW052Kz12LDV;
	Sat, 28 Mar 2026 10:16:31 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id C6AF52025F;
	Sat, 28 Mar 2026 10:21:56 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 28 Mar 2026 10:21:56 +0800
Message-ID: <04859df4-6fa4-4b2b-aef1-621f3c053c2e@huawei.com>
Date: Sat, 28 Mar 2026 10:21:55 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 1/2] vfio: add callback to get tph info for dmabuf
To: Zhiping Zhang <zhipingz@meta.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, Keith Busch
	<kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>, Yishai Hadas
	<yishaih@nvidia.com>
CC: Bjorn Helgaas <helgaas@kernel.org>
References: <20260324234615.3731237-1-zhipingz@meta.com>
 <20260324234615.3731237-2-zhipingz@meta.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260324234615.3731237-2-zhipingz@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk500009.china.huawei.com (7.202.194.94)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-18744-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fengchengwen@huawei.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA81A34D0DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Zhiping,

On 3/25/2026 7:46 AM, Zhiping Zhang wrote:
> This patch adds a callback to get the tph info on DMA buffer exporters.
> The tph info includes both the steering tag and the process hint (ph).
> 
> The steering tag and ph are encoded in the flags field of
> vfio_device_feature_dma_buf instead of adding new fields to the uapi
> struct, to preserve ABI compatibility.
> 
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> ---
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 26 ++++++++++++++++++++++++--
>  include/linux/dma-buf.h            | 30 ++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h          |  9 +++++++--
>  3 files changed, 61 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> index 478beafc6ac3..c45cb3884b85 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -17,6 +17,8 @@ struct vfio_pci_dma_buf {
>  	struct phys_vec *phys_vec;
>  	struct p2pdma_provider *provider;
>  	u32 nr_ranges;
> +	u16 steering_tag;
> +	u8 ph;
>  	u8 revoked : 1;
>  };
> 
> @@ -60,6 +62,15 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *attachment,
>  				       priv->size, dir);
>  }
> 
> +static int vfio_pci_dma_buf_get_tph(struct dma_buf *dmabuf, u16 *steering_tag,
> +				    u8 *ph)
> +{
> +	struct vfio_pci_dma_buf *priv = dmabuf->priv;
> +	*steering_tag = priv->steering_tag;
> +	*ph = priv->ph;

If the dmabuf exporter don't provide st&ph, this ops should return error

> +	return 0;
> +}
> +
>  static void vfio_pci_dma_buf_unmap(struct dma_buf_attachment *attachment,
>  				   struct sg_table *sgt,
>  				   enum dma_data_direction dir)
> @@ -90,6 +101,7 @@ static const struct dma_buf_ops vfio_pci_dmabuf_ops = {
>  	.unpin = vfio_pci_dma_buf_unpin,
>  	.attach = vfio_pci_dma_buf_attach,
>  	.map_dma_buf = vfio_pci_dma_buf_map,
> +	.get_tph = vfio_pci_dma_buf_get_tph,
>  	.unmap_dma_buf = vfio_pci_dma_buf_unmap,
>  	.release = vfio_pci_dma_buf_release,
>  };
> @@ -228,7 +240,10 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>  	if (copy_from_user(&get_dma_buf, arg, sizeof(get_dma_buf)))
>  		return -EFAULT;
> 
> -	if (!get_dma_buf.nr_ranges || get_dma_buf.flags)
> +	if (!get_dma_buf.nr_ranges ||
> +	    (get_dma_buf.flags & ~(VFIO_DMABUF_FL_TPH |
> +				   VFIO_DMABUF_TPH_PH_MASK |
> +				   VFIO_DMABUF_TPH_ST_MASK)))
>  		return -EINVAL;
> 
>  	/*
> @@ -285,7 +300,14 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>  		ret = PTR_ERR(priv->dmabuf);
>  		goto err_dev_put;
>  	}
> -
> +	if (get_dma_buf.flags & VFIO_DMABUF_FL_TPH) {
> +		priv->steering_tag = (get_dma_buf.flags &
> +				      VFIO_DMABUF_TPH_ST_MASK) >>
> +				     VFIO_DMABUF_TPH_ST_SHIFT;
> +		priv->ph = (get_dma_buf.flags &
> +			    VFIO_DMABUF_TPH_PH_MASK) >>
> +			   VFIO_DMABUF_TPH_PH_SHIFT;
> +	}
>  	/* dma_buf_put() now frees priv */
>  	INIT_LIST_HEAD(&priv->dmabufs_elm);
>  	down_write(&vdev->memory_lock);
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index 133b9e637b55..26705c83ad80 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -113,6 +113,36 @@ struct dma_buf_ops {
>  	 */
>  	void (*unpin)(struct dma_buf_attachment *attach);
> 
> +	/**
> +	 * @get_tph:
> +	 *
> +	 * Get the TPH (TLP Processing Hints) for this DMA buffer.
> +	 *
> +	 * This callback allows DMA buffer exporters to provide TPH including
> +	 * both the steering tag and the process hints (ph), which can be used
> +	 * to optimize peer-to-peer (P2P) memory access. The TPH info is typically
> +	 * used in scenarios where:
> +	 * - A PCIe device (e.g., RDMA NIC) needs to access memory on another
> +	 *   PCIe device (e.g., GPU),
> +	 * - The system supports TPH and can use steering tags / ph to optimize
> +	 *   cache placement and memory access patterns,
> +	 * - The memory is exported via DMABUF for cross-device sharing.
> +	 *
> +	 * @dmabuf: [in] The DMA buffer for which to retrieve TPH
> +	 * @steering_tag: [out] Pointer to store the 16-bit TPH steering tag value
> +	 * @ph: [out] Pointer to store the 8-bit TPH processing-hint value
> +	 *
> +	 * Returns:
> +	 * * 0 - Success, steering tag stored in @steering_tag
> +	 * * -EOPNOTSUPP - TPH steering tags not supported for this buffer
> +	 * * -EINVAL - Invalid parameters
> +	 *
> +	 * This callback is optional. If not implemented, the buffer does not
> +	 * support TPH.

It seemed already impl...

> +	 *
> +	 */
> +	int (*get_tph)(struct dma_buf *dmabuf, u16 *steering_tag, u8 *ph);
> +
>  	/**
>  	 * @map_dma_buf:
>  	 *
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index bb7b89330d35..e2a8962641d2 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1505,8 +1505,13 @@ struct vfio_region_dma_range {
>  struct vfio_device_feature_dma_buf {
>  	__u32	region_index;
>  	__u32	open_flags;
> -	__u32   flags;
> -	__u32   nr_ranges;
> +	__u32	flags;
> +#define VFIO_DMABUF_FL_TPH		(1U << 0) /* TPH info is present */
> +#define VFIO_DMABUF_TPH_PH_SHIFT	1         /* bits 1-2: PH (2-bit) */
> +#define VFIO_DMABUF_TPH_PH_MASK	0x6U
> +#define VFIO_DMABUF_TPH_ST_SHIFT	16        /* bits 16-31: steering tag */
> +#define VFIO_DMABUF_TPH_ST_MASK		0xffff0000U
> +	__u32	nr_ranges;
>  	struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
>  };

Another question:
1\ PCIE protocol define 8bit and 16bit ST
2\ In host-device ST impl, the ACPI will provide 8bit and 16bit ST, the choice of which
   one to use depends on the minimum supported range of the device and the RP.
3\ So in this P2P scene, although exporter (e.g. GPU) support 16bit ST, but the consumer
   (e.g. RDMA NIC) only support 8bit this may lead to mis-match

> 
> --
> 2.52.0
> 
> 
> 


