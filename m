Return-Path: <linux-rdma+bounces-18596-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JTnHHSiw2lssQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18596-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 09:53:08 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A549321ADC
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 09:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11C9030FA3F6
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 08:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C1139B974;
	Wed, 25 Mar 2026 08:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltb7Z1iY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8801A39A060;
	Wed, 25 Mar 2026 08:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774428573; cv=none; b=qixVhTI0SPMCrrZMMKZi3Ia+CladP9cpTUACTHeZxpH9ioOZQQYgZryfWxmrVkDY4lE9I7MaKc4ojE+A0vvyTWeCmE1SU8SmTnFw4oIzJXkVXmzjjMXro5J13f1pzNphIHVssi4srD/SXxfXbNzojB6WFhv9nmArPFKpnQyj/wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774428573; c=relaxed/simple;
	bh=oWiu4XCakpEEWouFgjSkDQdwlQEePei3CI0lNENWLjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JazSpMwnYNi/VQjKIb88H2WjIP2cIrLYntMm6G+h+vqtGmngwAQELdd17Vf2KbAZ2G/03hpdDcE010632nc/y0hdKaujs/PT+L3zol3rZ9/fLk96Z2PemcqEFgk6RrFdk1lxIBYuI5XY9bt6sPnZ0Eur3P77WTE8fVfWOpCBo1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltb7Z1iY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBF7C4CEF7;
	Wed, 25 Mar 2026 08:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774428573;
	bh=oWiu4XCakpEEWouFgjSkDQdwlQEePei3CI0lNENWLjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ltb7Z1iYmSiPVmQYAbIrLOoN+Nr2Z+YdWmZOZaSTD/tsGAbbSQRbqSofeHb6qkCbh
	 HKUW7VOg2Ihj0GIAPLLWBjynlKhsHh3Ys3KDc29Rem+kGcBhxtPhTWgQH2s4UvjB46
	 gz/mVcWtL9ytM4SfSAClINJgkRMfa7FQF0FvLbaDA1RbbtL3H2i5hOfKVAd/GhZh2M
	 /BV3cQA1QnK0kpl2xBsgdzcQdJUI1J7mUw8J3yUnCIGH3oxndxR9uhWCd629HuDhsK
	 r7tD79zZiypj5bDBgmOipZkFwp0QdNFlX71D9qbfujgxE19uX75sx/HMaKAn6au5kl
	 9EpfLDDNEDCJw==
Date: Wed, 25 Mar 2026 10:25:34 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RFC v2 1/2] vfio: add callback to get tph info for dmabuf
Message-ID: <20260325082534.GN814676@unreal>
References: <20260324234615.3731237-1-zhipingz@meta.com>
 <20260324234615.3731237-2-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324234615.3731237-2-zhipingz@meta.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18596-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A549321ADC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 04:46:02PM -0700, Zhiping Zhang wrote:
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

<...>

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

This extension of flags is basically kills future extension of this
struct for anything that includes TPH.

Add new
enum vfio_device_feature_dma_buf_flags {
    VFIO_DMABUF_FL_TPH  = 1 << 0
}

> +	__u32	nr_ranges;

add your "__u16 steering_tag" and "__u8 ph" fields here.

>  	struct vfio_region_dma_range dma_ranges[] __counted_by(nr_ranges);
>  };
> 
> --
> 2.52.0
> 
> 

