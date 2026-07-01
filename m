Return-Path: <linux-rdma+bounces-22663-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kby1HlFXRWrm+goAu9opvQ
	(envelope-from <linux-rdma+bounces-22663-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 20:07:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF4E6F082E
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 20:07:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=shazbot.org header.s=fm1 header.b=gcvbEmFN;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="i OcyrwU";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22663-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22663-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=shazbot.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 28F843001A41
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 18:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1571E4C043A;
	Wed,  1 Jul 2026 18:07:08 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BB44BC00F;
	Wed,  1 Jul 2026 18:07:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782929227; cv=none; b=eBiIMo6m5xCpB5ChacZjuuhEBqmv2l7gF8eeNGXN0Ao7Vhn0JpALz11+mnrBT1jKM6ERznPcA6XTI2Iq3ETY0Rb76MWKXUXGjBvxV35k4BBD2guhFOsP8a5nB7eYUlCyXK2lg+8WjzHjxIVfLgyPaGGF65YNX3wm9onpBs88I8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782929227; c=relaxed/simple;
	bh=gwar5tNYM6be9xihwD/IsTkYs1Crb719n98SigRiw0o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oUughGA2tiUDS6p8e8TflRFSeWkr9U10yByZEPveLy0CsFy7YPiuvK8zA/DkqWNMuelTkWIWl5mjri39BSaOz9xIFNgQphyLAlSY6nrw7GEsAqP/XXFD+aPfb66jAnk1DnTK98dt9X8AJhyJEotwnporbrRZjf/jM6DIzdYr+Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=gcvbEmFN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iOcyrwU5; arc=none smtp.client-ip=103.168.172.151
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 27344EC00FB;
	Wed,  1 Jul 2026 14:07:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 01 Jul 2026 14:07:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782929224;
	 x=1783015624; bh=pcS+lZQq4yNpKC+RPjg+DV+HTSzs32SQph4KqdacYYM=; b=
	gcvbEmFNUOYmmRZUCYW4lLbB7Gx8bs4E60P5PsjgsM6G4bhqQ0YXuoFNICto7csV
	1KZu49kueMvqznGIi6M6ov/7xmapCpCsy5dBFleuZ0dXJBPaEsU9dBS/kC5l4W1t
	Dcmu9dgAKOK1x/mDq19yML9GsM7qbz6zvYFcIc9CqYXtSzrZNMh2VwTvHQtizUX6
	NP3ElZbO5e17bWlIbfRtK8R6KE8w1yB4xLf0mcL3tH4MdaQBtezH6qF1ZCLBVFqP
	sN0OJcE1aLBTJxq2epQ4vqfaCxXUbFFFd42JOfggPnYf/snzCK9Je9gyTjPX4Omj
	SjpElNkQuk3Qr7lN+K7sLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782929224; x=
	1783015624; bh=pcS+lZQq4yNpKC+RPjg+DV+HTSzs32SQph4KqdacYYM=; b=i
	OcyrwU5TIggvOJieta1y+pnDr8IlLsmAMmizOzvLsoGY4N/+S1NAsm5Fx/zcPQCY
	vjRanoGRTjSafIixteb4e3c8TlBNrJiZ2MGa9y3MKov9Zy0m0+RYBky/+WZjbfrv
	RMeUlV3lc6XSIzMN+RPMEOpIjSVCS63FI4e2LeBbraG+ooAt/sHS+U94XyqGmZ8q
	8gBPVozyj5bgQretznAMq3fbEPoEZ1WLLnPbqh1PbMlrcEeWSVcN4sSenJWjumRj
	Ya/gwRGbP+/XKJ4w2xhSGvy1vtU6qd8OBFZtSTdN2mozNrZxIg+Q+AsFKMIe6xnR
	pQFSDFsY+n+jEtTsavSlA==
X-ME-Sender: <xms:R1dFavy1rllvAqheCszWFioW3E1RJBsDYYwuG-d6Mgx_-arp5ulQbQ>
    <xme:R1dFatpinsUib8YbOcw7vSTTZ7UJf6iNEiPGRKqVBHjcUZttSgv4gSxMcDLnLvFGj
    ZCWzgscG2aRAehvi5YIGCUbiFCkgm1G19dGSizX0w7PolR6-IOr>
X-ME-Received: <xmr:R1dFalkUKBvnMGvUugt8UqwipjHBZpPl90E01aId7HiTTWIY6F4XbKWTsws>
X-ME-Proxy-Cause: dmFkZTEsqF3YcRMX1ZByFD9HqbYscsOK9I0FwN8j50pdfvmv36eqfHTwa4zN5nAQHA4qYk
    nPHLEFUu9x60BiC3L9ob5nuN7E3/c8akgg0Ie5g3eL7MpluAS/YEI81k0QPgOtmixhZ81T
    26gai6XxLr3SHT8j+tvMCFvHaOnK53LAUjqFN5ATPC1f+pac0e0HrR/0r9CHe77/OaIAQk
    ZGSmzgNY8j2m7cmK7kDESiGn3Z97yYDSB32vUMKD2SGVK7n4zbMJNLLIr9jgmBtR2AMrt/
    RdgmXmbfLC+ObQ2R83VT1Bu+PayFWHslz/SQmcMSjp34LRzvSLpXV2Rf3SCKgJLiCU0+qE
    uwYGBFspkiu6Yv6H1Dow08w9FnCa6Nn6J2wJPQn/mF5GbAkYUgwUvBQ8CMjwr4makqJTLH
    h8EOBsFy7ajCUOu9o50KtUD6DrWLr81ryvxzEBznUfO9271AKTRV7vX+A7ytkQYQ29FaiV
    YGDr+ZwndSGqrdsGZfJ6pDT4u7llRzaFmnqLQm6WSclAhJKBTl3gTr2ye8v75vm0Rhop89
    zLmTRkQUy3ZiOMLWuMYJxlQNFM2KzTLBRVfMAX1fdC5zMAjVJg7C9Wju+cxdJEghdA4FAn
    2J7hWB3AEn5WIBYtkg2gbojz2jXDEmyLh7mfI4fkjM0Wz1B7U2nl31ZZbloA
X-ME-Proxy: <xmx:R1dFanU_0ufR96_JOPu5jgonk_ZVxbfGoPQk31DYqoROb_zdFYGkGA>
    <xmx:R1dFapotTiiSf1Z1RHsjVw9R_vfbjkjZnizKXa77sk2YhJWOqA7T7g>
    <xmx:R1dFaoUS5AlUKIVQ7cjM_h5kfq__panLvdy4efT4EaDW7WtdbOF3kQ>
    <xmx:R1dFaqFDSQFuYaYkCih5eMAQCNN1zTtxQxW-uVVm4Tti6ZgMxr9OrQ>
    <xmx:SFdFahcwd0hPubhQt8LEeu4CzGRyQxeZc0n1ImdCnfgxJQC48l_ls4qj>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 14:07:02 -0400 (EDT)
Date: Wed, 1 Jul 2026 12:07:00 -0600
From: Alex Williamson <alex@shazbot.org>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Michael Guralnik <michaelgur@nvidia.com>, Sumit Semwal
 <sumit.semwal@linaro.org>, Christian Konig <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, <kvm@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, alex@shazbot.org
Subject: Re: [PATCH v10 3/4] vfio/pci: implement get_pci_tph and DMA_BUF_TPH
 feature
Message-ID: <20260701120700.58bcafa1@shazbot.org>
In-Reply-To: <20260630224328.3218796-4-zhipingz@meta.com>
References: <20260630224328.3218796-1-zhipingz@meta.com>
	<20260630224328.3218796-4-zhipingz@meta.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[shazbot.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[shazbot.org:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22663-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,messagingengine.com:dkim,meta.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7CF4E6F082E

On Tue, 30 Jun 2026 15:42:25 -0700
Zhiping Zhang <zhipingz@meta.com> wrote:

> Implement dma-buf get_pci_tph for vfio-pci exported dma-bufs and add
> VFIO_DEVICE_FEATURE_DMA_BUF_TPH so userspace can publish TPH metadata
> for a VFIO-owned device.
>=20
> 8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces; the
> uAPI carries both with explicit validity flags, and get_pci_tph()
> returns the value matching the importer's requested namespace or
> -EOPNOTSUPP.
>=20
> Publish and read the TPH descriptor under dmabuf->resv, matching the
> locking used for other importer-visible dma-buf state. The SET ioctl
> takes dma_resv_lock_interruptible(), while the callback runs under
> DMA-buf's asserted resv lock.
>=20
> Reject requests the device cannot consume as a completer:
> pcie_tph_completer_type() must report at least
> PCI_EXP_DEVCAP2_TPH_COMP_TPH_ONLY, and Extended ST requires
> PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH. Make PROBE follow the same hardware
> gate so the feature only probes as supported when the device can really
> consume it.
>=20
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c   |  3 +
>  drivers/vfio/pci/vfio_pci_dmabuf.c | 99 +++++++++++++++++++++++++++++-
>  drivers/vfio/pci/vfio_pci_priv.h   | 12 ++++
>  include/uapi/linux/vfio.h          | 43 +++++++++++++
>  4 files changed, 155 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index a28f1e99362c..c7d6902bc61b 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1572,6 +1572,9 @@ int vfio_pci_core_ioctl_feature(struct vfio_device =
*device, u32 flags,
>  		return vfio_pci_core_feature_token(vdev, flags, arg, argsz);
>  	case VFIO_DEVICE_FEATURE_DMA_BUF:
>  		return vfio_pci_core_feature_dma_buf(vdev, flags, arg, argsz);
> +	case VFIO_DEVICE_FEATURE_DMA_BUF_TPH:
> +		return vfio_pci_core_feature_dma_buf_tph(vdev, flags, arg,
> +							 argsz);
>  	default:
>  		return -ENOTTY;
>  	}
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_p=
ci_dmabuf.c
> index c16f460c01d6..8de72f9e7502 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -3,6 +3,7 @@
>   */
>  #include <linux/dma-buf-mapping.h>
>  #include <linux/pci-p2pdma.h>
> +#include <linux/pci-tph.h>
>  #include <linux/dma-resv.h>
> =20
>  #include "vfio_pci_priv.h"
> @@ -19,7 +20,14 @@ struct vfio_pci_dma_buf {
>  	u32 nr_ranges;
>  	struct kref kref;
>  	struct completion comp;
> -	u8 revoked : 1;
> +
> +	/* Protected by dmabuf->resv. */
> +	u16 tph_st_ext;
> +	u8 tph_st;
> +	bool revoked;
> +	u8 tph_st_valid:1;
> +	u8 tph_st_ext_valid:1;
> +	u8 tph_ph:2;

Since it seems there will be a v11, note again the comment made here on
v9:

On Tue, 23 Jun 2026 22:24:54 -0700
Zhiping Zhang <zhipingz@meta.com> wrote:
> On Tue, Jun 23, 2026 at 11:17=E2=80=AFAM Alex Williamson <alex@shazbot.or=
g> wrote:
> >
> > Nit, it would be more accurate to say:
> >
> >         /*
> >          * Updates protected by dmabuf->resv, @revoked additionally
> >          * protected by memory_lock.
> >          */
> >
> > revoked also has an unprotected read, but it's previously existing and
> > benign, and likely just needs a READ_ONCE() annotation.
> > =20
>=20
> Agreed, I'll update the comment and add READ_ONCE() as well.

The READ_ONCE was added, but the comment remains as in v9.  The
READ_ONCE rationale should be described in the commit log too.  Thanks,

Alex

