Return-Path: <linux-rdma+bounces-22033-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Nf/cGflwKGpMEwMAu9opvQ
	(envelope-from <linux-rdma+bounces-22033-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 22:00:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B62F7663FF2
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 22:00:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QvSThxOG;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22033-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22033-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97051302D5F2
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 19:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3343EB0FA;
	Tue,  9 Jun 2026 19:56:15 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3848E3905F4;
	Tue,  9 Jun 2026 19:56:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781034975; cv=none; b=svhnITqJsNmIRiQ+WEzoHqixkuUWlAEComAeJO09BsOBKokgtE7G8Ec5rGpNmRMu2PIvqPUs6O+Ikc+ewwBAKC+Ko2vDw4Q/vVGTiJhiskRrijIWwJcag2Sv8GBnBW1f7+5tO9VF3x2SmwAkyj5a5GoYcG8kLDZGlIQvNpMTTgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781034975; c=relaxed/simple;
	bh=6NOGgMTwvpFK9y9CwWV59BdaEs794jRjbrN/rBHlaP0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YU0ADBRRaPzT773Fqhuu8aVRjuUaMdTy0AGJZ5Q5llobRIN/+vd5bnZTJgOhNH0UsItjQHgfM9ToxhwusEcny24BpIau6lDRO9OPsImpws9Y5SXnmEouf7AJMWhvmSHnmIbCK8NyZzVhJ3/EfSWABIejr/twIzCoSKJs2iGJAsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvSThxOG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A840F1F00893;
	Tue,  9 Jun 2026 19:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781034973;
	bh=y4iRsk+AhfxJSSqxKswZ1/phd34ipK67r/z1ycidumM=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=QvSThxOGvVJFNdr/naZAD6M8F4kr7tHnFy+Z5x0HnJL/H4yOVFl3qTjhpbbvPGMXQ
	 cXBHVIgTsrYY2nzaNrl7bYLp6vnklAFTnZQoIcYV9NGY/Efnk/tQmTYqAA9txv/DT8
	 QLQwMkUg9p9H7vm1ZqQ4AEd31RQjqayQa3zEkyboXBs7J1b/INwl2LvqmwkbktcPwY
	 rMxsJIWA5Fwt7aVHw7Tk6enfab2EDtBKPtxIAHQIs4X0WnrC/AwdOpKaAbq9Lr+rf/
	 BUyg3HdHYBXhG3pYTlAv3BqUpiW25/Fr1l0EXlFT6nTpJEpXw4jXyCecBwicC6NX39
	 dmlfW70iAH08w==
Date: Tue, 9 Jun 2026 14:56:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhiping Zhang <zhipingz@meta.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian Konig <christian.koenig@amd.com>, kvm@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH v6 2/5] PCI/TPH: expose enabled requester type and
 capability helpers
Message-ID: <20260609195612.GA85322@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608185646.4085127-3-zhipingz@meta.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:zhipingz@meta.com,m:alex@shazbot.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:sumit.semwal@linaro.org,m:christian.koenig@amd.com,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:netdev@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:kbusch@kernel.org,m:yochai@nvidia.com,m:yishaih@nvidia.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[helgaas@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22033-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bhelgaas:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,meta.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B62F7663FF2

On Mon, Jun 08, 2026 at 11:56:39AM -0700, Zhiping Zhang wrote:
> Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
> requester mode without reaching into pci_dev internals, and
> pcie_tph_supported() so they can test whether the device exposes the
> PCIe TPH Extended Capability without doing the same.

s/exposes/advertises/

> This keeps pci_dev::tph_req_type and pci_dev::tph_cap inside the
> PCI/TPH code and provides !CONFIG_PCIE_TPH stubs for callers.

Update subject line to match capitalization of history
(use "git log --oneline drivers/pci/tph.c")

s/expose/Add/ in subject.

("Expose" suggests that the interfaces already exist and we're just
exporting them, but these interfaces didn't exist at all before.)

> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

With the above,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/tph.c       | 25 +++++++++++++++++++++++++
>  include/linux/pci-tph.h |  7 +++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 91145e8d9d95..aa09113c46d4 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -174,6 +174,31 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
>  }
>  EXPORT_SYMBOL(pcie_tph_get_st_table_loc);
>  
> +/**
> + * pcie_tph_enabled_req_type - Return the device's enabled TPH requester type
> + * @pdev: PCI device to query
> + *
> + * Return: PCI_TPH_REQ_DISABLE, PCI_TPH_REQ_TPH_ONLY or PCI_TPH_REQ_EXT_TPH.
> + */
> +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
> +{
> +	return pdev->tph_req_type;
> +}
> +EXPORT_SYMBOL(pcie_tph_enabled_req_type);
> +
> +/**
> + * pcie_tph_supported - Whether the device advertises the TPH Extended Cap
> + * @pdev: PCI device to query
> + *
> + * Return: true when the device exposes the PCIe TPH Extended Capability,
> + * false otherwise.
> + */
> +bool pcie_tph_supported(struct pci_dev *pdev)
> +{
> +	return pdev->tph_cap != 0;
> +}
> +EXPORT_SYMBOL(pcie_tph_supported);
> +
>  /*
>   * Return the size of ST table. If ST table is not in TPH Requester Extended
>   * Capability space, return 0. Otherwise return the ST Table Size + 1.
> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> index be68cd17f2f8..2e07bce77038 100644
> --- a/include/linux/pci-tph.h
> +++ b/include/linux/pci-tph.h
> @@ -9,6 +9,8 @@
>  #ifndef LINUX_PCI_TPH_H
>  #define LINUX_PCI_TPH_H
>  
> +#include <linux/pci_regs.h>
> +
>  /*
>   * According to the ECN for PCI Firmware Spec, Steering Tag can be different
>   * depending on the memory type: Volatile Memory or Persistent Memory. When a
> @@ -30,6 +32,8 @@ void pcie_disable_tph(struct pci_dev *pdev);
>  int pcie_enable_tph(struct pci_dev *pdev, int mode);
>  u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
>  u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
> +u8 pcie_tph_enabled_req_type(struct pci_dev *pdev);
> +bool pcie_tph_supported(struct pci_dev *pdev);
>  #else
>  static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
>  					unsigned int index, u16 tag)
> @@ -41,6 +45,9 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev *dev,
>  static inline void pcie_disable_tph(struct pci_dev *pdev) { }
>  static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
>  { return -EINVAL; }
> +static inline u8 pcie_tph_enabled_req_type(struct pci_dev *pdev)
> +{ return PCI_TPH_REQ_DISABLE; }
> +static inline bool pcie_tph_supported(struct pci_dev *pdev) { return false; }
>  #endif
>  
>  #endif /* LINUX_PCI_TPH_H */
> -- 
> 2.53.0-Meta
> 

