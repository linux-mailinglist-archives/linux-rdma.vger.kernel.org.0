Return-Path: <linux-rdma+bounces-20533-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGhZGhjVA2q5/AEAu9opvQ
	(envelope-from <linux-rdma+bounces-20533-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 03:34:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5FC52BEE6
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 03:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 577C9303972B
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 01:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1EF37FF5F;
	Wed, 13 May 2026 01:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="GpqnqSW9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A1137C0F3;
	Wed, 13 May 2026 01:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778636031; cv=none; b=gCyhdx6rDWZBxPXijBUBkwj1oM+tEcDzuUoLzUCW/lsDn7ROYoBHSr1gq8Ca6/p90EUGVrGOQObcTYjGgle4051fvsvLM2naAjzRrdqZ0yOP0xsYfPKGJ9NNZ88rNKik+dRKmRCSVcUYonKGxRo7YoeL5j/Xh8y0uUJG6ftlXMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778636031; c=relaxed/simple;
	bh=rcRXXg7UbH+EbZfmiUxU8wywsb+Gdo2u01va/RHA5bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dBYArhUbaYkdkMrATlmyxGMwU3cSfBIbrpOD8wcTP5W9bSnuQVI4wUJnvyFbfjjd9bahUCRdF5qNUQOsGIiTtHFclAFaRnCKcSgYbYMN9LKBLHlkXqpy5nFM2hSZBcwKfccMVdf1vcnQuR3k7qGfsUSHwPDjDatOmTvJ3bNrfCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=GpqnqSW9; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4MWMrthRhdSdwUjqWPGVf9+M+ttsxk6C6GE7zy72DVU=;
	b=GpqnqSW9DnQUvT/4OaKJjJbTQqrAQrBOKrhN5dxvRHERrIAOoabqj5gmZM7XwiyD022cWBNM4
	GmR0cyhybc6ygTmrymtmyisAD576FqZgPfX19Lj2UKO2borJwIraf81eNaOQK/UmSFFcrCjlGQD
	YPfvZ5rO27ylzaZIxcgMJho=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gFbQ15Ms5z1T4HC;
	Wed, 13 May 2026 09:26:01 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 9E81120104;
	Wed, 13 May 2026 09:33:42 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 May 2026 09:33:41 +0800
Message-ID: <e6928a10-77b1-4fdf-8bc3-cd0154b4d4c5@huawei.com>
Date: Wed, 13 May 2026 09:33:41 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] vfio: add dma-buf get_tph callback and DMA_BUF_TPH
 feature
To: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
CC: Bjorn Helgaas <helgaas@kernel.org>, <kvm@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, Keith Busch
	<kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>, Yishai Hadas
	<yishaih@nvidia.com>
References: <20260512184755.4137227-1-zhipingz@meta.com>
 <20260512184755.4137227-2-zhipingz@meta.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260512184755.4137227-2-zhipingz@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk500009.china.huawei.com (7.202.194.94)
X-Rspamd-Queue-Id: 0D5FC52BEE6
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
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-20533-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:mid,huawei.com:dkim]
X-Rspamd-Action: no action

Hi Zhiping,

I have several suggestions:

1. In struct vfio_device_feature_dma_buf_tph, steering_tag is defined as
   __u16, but PCIe TPH base steering tag is only 8-bit. We can use __u8
   for steering_tag to shrink structure size and reduce reserved padding.

2. The flags field seems unnecessary. We can use value 0 of steering_tag
   or steering_tag_ext to indicate the corresponding ST entry is not
   available, which simplifies the uAPI design.

3. All TPH metadata fields (st, ext st, ph) fit within 32 bits. We can
   wrap them into a union with atomic_t, then use atomic read/write
   instead of memory_lock plus smp_load_acquire/smp_store_release. This
   makes lockless access cleaner and avoids ordering maintenance.

For details, see the text.

On 5/13/2026 2:47 AM, Zhiping Zhang wrote:
> Add a dma-buf callback that returns raw TPH metadata from the exporter
> so peer devices can reuse the steering tag and processing hint
> associated with a VFIO-exported buffer. Add a new
> VFIO_DEVICE_FEATURE_DMA_BUF_TPH ioctl that takes the fd from
> VFIO_DEVICE_FEATURE_DMA_BUF along with the TPH values, validates the fd
> is a vfio-exported dma-buf belonging to this device, and stores the TPH
> metadata under memory_lock. The existing VFIO_DEVICE_FEATURE_DMA_BUF
> uAPI is unchanged.
> 
> 8-bit ST and 16-bit Extended ST are distinct namespaces in the PCIe TPH
> ST table (firmware reports them as separate fields with separate
> validity bits in the ACPI _DSM ST table), so the uAPI carries both
> values along with a flags field that indicates which value(s) are
> valid for this device. The exporter selects the value that matches the
> importer's requested width and returns -EOPNOTSUPP if that width is
> not present, instead of substituting a value across namespaces.
> 
> Publish the TPH fields under memory_lock and gate readers on a
> release/acquire on the flags field; this lets get_tph() run lockless
> and avoids inverting the memory_lock -> dma_resv_lock ordering set up
> by vfio_pci_dma_buf_move(). Convert the @revoked bitfield to a plain bool
> so concurrent updates of @revoked (under dma_resv_lock) and the new TPH
> fields (under memory_lock) cannot race on a shared bitfield byte.

The commit log includes many implementation details, why not remove or simply it.

> 
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> 
> ---
>  drivers/vfio/pci/vfio_pci_core.c   |   3 +
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 113 ++++++++++++++++++++++++++++-
>  drivers/vfio/pci/vfio_pci_priv.h   |  11 +++
>  include/linux/dma-buf.h            |  21 ++++++
>  include/uapi/linux/vfio.h          |  35 +++++++++
>  5 files changed, 182 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 3f8d093aacf8..94aa6dd95701 100644
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
> index f87fd32e4a01..28247602e359 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -19,7 +19,23 @@ struct vfio_pci_dma_buf {
>  	u32 nr_ranges;
>  	struct kref kref;
>  	struct completion comp;
> -	u8 revoked : 1;
> +	/*
> +	 * TPH metadata published by VFIO_DEVICE_FEATURE_DMA_BUF_TPH and
> +	 * consumed by the @get_tph dma-buf callback.
> +	 *
> +	 * @tph_flags is the publish/consume gate: writers populate
> +	 * @steering_tag, @steering_tag_ext and @ph first, then store
> +	 * @tph_flags with smp_store_release(); readers do
> +	 * smp_load_acquire(&tph_flags) before accessing the value fields.
> +	 * @tph_flags == 0 means "TPH not set". Writers serialize via
> +	 * vdev->memory_lock; readers are lockless to avoid AB-BA against
> +	 * the dma_resv_lock held by importers.
> +	 */
> +	u32 tph_flags;

As subsequent comments, can proceed without tph_flags

> +	u16 steering_tag;
> +	u16 steering_tag_ext;
> +	u8 ph;

struct dma_buf_tph {
        union {
                atomic_t val;
                struct {
                        u16 st_ext;
                        u8 st;
                        u8 ph;
                };
        };
};
Set and get are done with atomic operation, no need for lock

> +	bool revoked;
>  };
>  
>  static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
> @@ -69,6 +85,35 @@ vfio_pci_dma_buf_map(struct dma_buf_attachment *attachment,
>  	return ret;
>  }
>  

...

>  
> +	/**
> +	 * @get_tph:
> +	 * @dmabuf: DMA buffer for which to retrieve TPH metadata
> +	 * @steering_tag: Returns the raw TPH steering tag for @st_width
> +	 * @ph: Returns the TPH processing hint (2-bit value)
> +	 * @st_width: Consumer's supported steering tag width in bits (8 or 16)
> +	 *
> +	 * Return the TPH (TLP Processing Hints) metadata associated with this
> +	 * DMA buffer for the requested steering-tag width. 8-bit ST and 16-bit
> +	 * Extended ST are distinct namespaces in the PCIe TPH ST table, so the
> +	 * exporter must select the value that matches @st_width and must not
> +	 * substitute one for the other.
> +	 *
> +	 * Return 0 on success, -EOPNOTSUPP if no metadata is available for the
> +	 * requested width, or -EINVAL if @st_width is not 8 or 16.
> +	 *
> +	 * This callback is optional.
> +	 */
> +	int (*get_tph)(struct dma_buf *dmabuf, u16 *steering_tag, u8 *ph,
> +		       u8 st_width);

how about rename steering_tag to st?

> +
>  	/**
>  	 * @map_dma_buf:
>  	 *
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 5de618a3a5ee..53b2bbd9fc1e 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1534,6 +1534,41 @@ struct vfio_device_feature_dma_buf {
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
> + * distinct namespaces in the PCIe TPH ST table; userspace should populate
> + * the value(s) it has from the firmware ST table for this device and set
> + * the matching VFIO_DMA_BUF_TPH_ST / VFIO_DMA_BUF_TPH_ST_EXT bit in @flags.
> + * An importer requests a specific width and receives the matching value;
> + * if the requested width is not present, the importer is told TPH is
> + * unavailable for this dma-buf.
> + *
> + * ph is the 2-bit TLP Processing Hint and must be in the range [0, 3].
> + *
> + * The user must set TPH on the dma-buf before the importer consumes it.
> + *
> + * Return: 0 on success, -errno on failure.

-1 and errno is set on failure.

> + */
> +#define VFIO_DEVICE_FEATURE_DMA_BUF_TPH 13
> +
> +#define VFIO_DMA_BUF_TPH_ST		(1 << 0)  /* steering_tag valid */
> +#define VFIO_DMA_BUF_TPH_ST_EXT		(1 << 1)  /* steering_tag_ext valid */

It could be represented by judge whether steering_tag/ext == 0

> +
> +struct vfio_device_feature_dma_buf_tph {
> +	__s32	dmabuf_fd;
> +	__u32	flags;
> +	__u16	steering_tag;
> +	__u16	steering_tag_ext;
> +	__u8	ph;
> +	__u8	reserved[3];

How about:
struct vfio_device_feature_dma_buf_tph {
	__s32	dmabuf_fd;
	__u16	st_ext;
	__u8	st;
	__u8	ph;
}
If st_ext is not zero means it valid, and also with st field.

Thanks

> +};
> +
>  /* -------- API for Type1 VFIO IOMMU -------- */
>  
>  /**


