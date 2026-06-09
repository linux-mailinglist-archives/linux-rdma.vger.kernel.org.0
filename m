Return-Path: <linux-rdma+bounces-22034-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ai1gHKWKKGrjFwMAu9opvQ
	(envelope-from <linux-rdma+bounces-22034-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 23:50:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CA26645A6
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 23:50:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=shazbot.org header.s=fm3 header.b=dAXXjj9F;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="Q o21B5L";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22034-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22034-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=shazbot.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68A193037E59
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 21:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51993DE429;
	Tue,  9 Jun 2026 21:46:40 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7132EEE79;
	Tue,  9 Jun 2026 21:46:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781041600; cv=none; b=Y7rjfFnlWi6Tq7v+4FkQsL8lTCMERjQzdg4LSZ+lpSINtzefhJhfYX/ZrXGCKN9zLzvUguaIJ6vwOL9EnNylKFRJg1xwPVekVulXfIa/VWomAb1lzDPoY59Ja7FWWUDLay8XG/201mlJH2oCWriZfjQly0mHf7wDgKkm6+qXcVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781041600; c=relaxed/simple;
	bh=BsLNVgcsHZe2ZdsnQZYPq8d5+s128ZmNZcF9+xivLx8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rxC0w1UQsIb/pML2ncJghJMWtdvf5NaxLYbyvZjux0qeLIV/niM09n+XR9enrBK6NficlZM5ydpAdgbpmiOSpgehlZb53irkxEzn7tUKOJODHUnlr/wrvTH2aEn9eSL1/VwZbznm8VbXw/P74zogt4fxCFUuEpxQCIB6Chrvfu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=dAXXjj9F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qo21B5LF; arc=none smtp.client-ip=103.168.172.149
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id E59C2EC021C;
	Tue,  9 Jun 2026 17:46:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 09 Jun 2026 17:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781041596;
	 x=1781127996; bh=Le4mzZitUOCcD3l+m59chdRcJdHFdgu8c/ZCYemC1C4=; b=
	dAXXjj9FfExLlbaZ9I2g8ETi3RfKBVVFAjpT64jfIpEeerruRAoxo75VuDeTTOYH
	C4WRuvCF61il3A6t7Vws5R6SpTeb1fv8D2rNZjTNLKjk15s/tfCHIqvyvQmSYPZM
	KD0rnyJJ/kdT6YI5kByaNcrVyal5Ck6YJl96vuVv3jRgrNvkprWnUX5FnIU6eqJi
	sQ4jreWBdxEs9n2gzMPa73E1wHEkoKP6VUDGj6arD4qir6OScDV/cw4Q3I+D55JZ
	Sve/4zBKcQkY0Opq0utfqXU6SBh9oCwVYW2UHmVHWzn0X8tZZeZ5iYD0Nqv201Wl
	d5pDFtoa32d4CB/TB+4skQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781041596; x=
	1781127996; bh=Le4mzZitUOCcD3l+m59chdRcJdHFdgu8c/ZCYemC1C4=; b=Q
	o21B5LF6+eVL0FrVT//T8T5IHgrmhItN0lO4QjPVCLE+55+XbYzUbECnJYNPnqpU
	oioIUooojwU//H0OdfrU9N8VGfPuvJs6tmJ3gTZ7oG+3LV/3BCgXj5FNuvzRMBag
	tm3Ebpy+m/Qyuiuy40/EYivPkRkLM1hMpzrqU0nT5My8eqDFJmfQqvzdjpxR3Qem
	74fcufgERoS35lQRLdwbMBhabC598IW/uiESIPIod9FPnLtKrh2ZzePOPRjRJgO8
	dahezYcPhB4IhzpYN0e6TSjqC/KWOyFXT7+QApoFjGly8i5lzGflLanrd/DSIK4j
	uKQSN0LlNpWkjX8Yyjk7w==
X-ME-Sender: <xms:vIkoav41sU7sUzGrTPA6Kff5nPOhMu_tjTb6AT9cHRwX6gkJpgJiVQ>
    <xme:vIkoascAsBg9rjm1TIvDQLPRmo3JsuqYZfKzLN0ep1brQTA-tc4ZUYEbdWsD3z4sh
    aHIQZtRYOWsFwwwsOypRNiBEEJ5CxLFFgBP3risaH7qSxWeUqtKxg>
X-ME-Received: <xmr:vIkoamEpwgfC3N0c3HCxtvQF2l3JuR_hnvE96yKATYM1_m9HJ5DCmtEPQLs>
X-ME-Proxy-Cause: dmFkZTGvUY/GUU1gU7Kcsq7cJWzYPAILCs/dFDD0hst22ThCwBi1vnbQlHAm+Nvcf7Bswg
    rV++wJ6ac08HqzD/HSLDgPd/SlMmTO3zNwe5YrT/8VO+Q+5wZNBDjXouEW7LFTFvz+RBQ+
    vlOKXPM6scyo8puzQmKqCveaX9HSJfQ2w2WRB0T912qT5whajjDBx3ext/e3Gh8OY/6MUC
    L+qEUjjfT1XOZefkH/n5nReGu6UoHEQ6moOujnT8WMFvSnEeVIVESzvcI7l9CFe7ru6XCJ
    PpRu4o7ejKUdJzxysGMIHOyfkdkThi58pkUt1P6FVOnn+7dGQIaw8N0aLCrRSRmWRM+PMh
    ikaLjSpPoBdefLsitXogYOQsUUb07nZmsb1VJhDUaUDxH2g0KjaBiKMbZc0jFPjleo2Iyk
    KfNbodWo8iutszHty+zZo5toIMA1VA6Xnvc8RtbExEfjg/4TDeUq67f9evEtZsA+7fBPzX
    0VkyVmm2fiI30Vh/OuKtzGGaGTHFiJyglA0jGoi5s3r1MCCtYucoekbpoJMAslDejOBC10
    QuX+elWdeC9DTHBdmtsu/M7La/kMfxu5OERbW+NMAVyH3lKzW/xMTCUanptzfek4kFoH9n
    IdQmZJA9vlrGsGhG/KUeVFv+Sy10TDmJQghO7iPWhZhw/IFBIKUt/tPJ4jIw
X-ME-Proxy: <xmx:vIkoas4j-LUxltDGhE3c2BEzr58JQdPq2sL1nVn3EGkTXjLWeiWMKg>
    <xmx:vIkoapvaCyVyJiLgHqTcdsrjJPegXxR_V8GvUKpBiytgnbZ4Ik0uDg>
    <xmx:vIkoag-U3Ty5QcEbjE9wXqfPiARWA8hlGVRxPn2FO4IGKLCUvbzTpw>
    <xmx:vIkoajmgLfPH9lLOmlpZjWXYSL7XQCMrbH6d9qhFwJ-yNqnrIzRVWw>
    <xmx:vIkoagld8r8MNa3yFhypdE_45wM3TTznM9aALYwL4tuY1ylX1DrQEkjw>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 17:46:35 -0400 (EDT)
Date: Tue, 9 Jun 2026 15:46:34 -0600
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
Subject: Re: [PATCH v6 4/5] vfio/pci: implement get_tph and DMA_BUF_TPH
 feature
Message-ID: <20260609154634.46ee8328@shazbot.org>
In-Reply-To: <20260608185646.4085127-5-zhipingz@meta.com>
References: <20260608185646.4085127-1-zhipingz@meta.com>
	<20260608185646.4085127-5-zhipingz@meta.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[shazbot.org:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22034-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:zhipingz@meta.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:sumit.semwal@linaro.org,m:christian.koenig@amd.com,m:helgaas@kernel.org,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:netdev@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:kbusch@kernel.org,m:yochai@nvidia.com,m:yishaih@nvidia.com,m:alex@shazbot.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,shazbot.org:dkim,shazbot.org:mid,shazbot.org:from_mime,messagingengine.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C1CA26645A6

On Mon, 8 Jun 2026 11:56:41 -0700
Zhiping Zhang <zhipingz@meta.com> wrote:
> @@ -327,12 +358,71 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>  err_free_phys:
>  	kfree(priv->phys_vec);
>  err_free_priv:
> +	mutex_destroy(&priv->tph_lock);
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
> +	if (!pcie_tph_supported(vdev->pdev))
> +		return -EOPNOTSUPP;

This tests for the TPH capability, but the TPH capability is only a
requirement for functions that generate TLPs with TPH, ie. a requester.
This feature is about providing TPH steering tags when the device is a
completer.  Bits 13:12 of the Device Capabilities 2 register indicate
if the device is supported as a TPH completer.

Additionally these bits indicate if the device supports standard and
extended TPH, which means we should not only fail if the device reports
00b, but should reject extended steering tags unless the device reports
11b.

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
> +	/* PCIe TLP Processing Hint is a 2-bit field. */
> +	if (set_tph.ph & ~0x3)
> +		return -EINVAL;

Sashiko notes what appears to be a false positive here, the uAPI states
ph is to be in the range [0, 3] and nowhere else says that it's allowed
to be garbage for a clear operation.

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

Sashiko notes this may need READ_ONCE()/WRITE_ONCE() semantics, but
that may get fixed as part of the resv lock usage.

> +
> +	scoped_guard(mutex, &priv->tph_lock) {
> +		priv->tph_st = set_tph.steering_tag;
> +		priv->tph_st_ext = set_tph.steering_tag_ext;
> +		priv->tph_ph = set_tph.ph;
> +		priv->tph_st_valid = !!(set_tph.flags & VFIO_DMA_BUF_TPH_ST);
> +		priv->tph_st_ext_valid =
> +			!!(set_tph.flags & VFIO_DMA_BUF_TPH_ST_EXT);
> +	}
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
...
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 5de618a3a5ee..0ca26721849b 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1534,6 +1534,51 @@ struct vfio_device_feature_dma_buf {
>   */
>  #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
>  
> +/**
> + * Upon VFIO_DEVICE_FEATURE_SET associate TPH (TLP Processing Hints) metadata
> + * with a vfio-exported dma-buf. The dma-buf must have been created by
> + * VFIO_DEVICE_FEATURE_DMA_BUF on this device, and the device must expose the
> + * TPH Extended Capability (otherwise the ioctl returns -EOPNOTSUPP).
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
> + * This publishes the PCI SIG-defined ST/PH tuple for a VFIO-owned PCIe
> + * completer. The dma-buf core treats the tuple as opaque completer-owned
> + * metadata; an importer simply requests the namespace it supports and places
> + * the returned value on generated TLPs.
> + *
> + * @flags == 0 clears any previously published metadata.

This is overselling the invalidation.  It only flags the fields as
invalid for future get_tph() requests, it does nothing to clear
previously published metadata from importers.  Thanks,

Alex


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
> +	__u16	steering_tag_ext;
> +	__u8	steering_tag;
> +	__u8	ph;
> +};
> +
>  /* -------- API for Type1 VFIO IOMMU -------- */
>  
>  /**


