Return-Path: <linux-rdma+bounces-18843-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENwZHXXGy2mnLgYAu9opvQ
	(envelope-from <linux-rdma+bounces-18843-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 15:04:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 241FA369EA6
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 15:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A6DA30338A5
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 13:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A463E3D82;
	Tue, 31 Mar 2026 13:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1GvVZwr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427153E3C56;
	Tue, 31 Mar 2026 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774962010; cv=none; b=LwmYFPa2sGIEXL/P1Mn+H145iQOM9NxKP6D2kI5ZQ2rSA7FB4Bvc0wz5S+860UigggeohwJ/gd9XtVJf+cF3RZVn8RjpPKE7vVLsdSdTch6X44wBdHx2WuYXevTBy8sS1RebLFV/47OCOH91A4FKmEYtdd+xIp4aNyPvgAj/kOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774962010; c=relaxed/simple;
	bh=Aid6A4kU1rFuiXFfYoqlUcE12Y1zwl4OGNPuijYgxwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXwv8iogwHKgw71VKhGcEcC56jx9bnBZQjdMU+DR1dYPaezl+2XQAh6z+sRmEnDq+OI2sqiS+vVmSttUX/1uHeTljEqgp0B5NsGlmyAl3NJ5PU0Gm/CPiC/y1+Crfc+pJGmXmTJNKr8ptCz72to1kaTgGHK7GRxdeamGARQwsVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1GvVZwr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5715FC19423;
	Tue, 31 Mar 2026 13:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774962009;
	bh=Aid6A4kU1rFuiXFfYoqlUcE12Y1zwl4OGNPuijYgxwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D1GvVZwrBJF+RmNmadu1Zd61sTNOaNDCVjyCiMVFWQWQUMH+6Zzw1Hz9oznH2f3ks
	 ljnsOTeYS0CRUSQrFS62kxo3o64EI2TpzBCxN9YSxtR1BxnimRdrdbRJ8y+vT/5pXU
	 6ieoDwrOo6tkLAJP7hqhT7bXIx4yxGfg/E4FdIipIi1mejoJD0XpfZrs6bQnMwQFfB
	 uiHpGijKiTtJ/HdI8OxLMiqKha8jj/0Mbfxjx5oCFIwRfLoyLosrSvvdg42a1BQ87h
	 ASGO07Q6376XU49mwx6thSd118eOZPEc3avvWEdnznnVHDetxJ5BpVRMlfQAqSb+Dz
	 9S//mLmMysm2g==
Date: Tue, 31 Mar 2026 07:00:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Zhiping Zhang <zhipingz@meta.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RFC v2 1/2] vfio: add callback to get tph info for dmabuf
Message-ID: <acvFV8c5QVxnt3Em@kbusch-mbp>
References: <20260324234615.3731237-1-zhipingz@meta.com>
 <20260324234615.3731237-2-zhipingz@meta.com>
 <20260325082534.GN814676@unreal>
 <acW2BwQKaUbS3eL9@kbusch-mbp>
 <20260331083758.GA814676@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331083758.GA814676@unreal>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18843-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kbusch@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 241FA369EA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 11:37:58AM +0300, Leon Romanovsky wrote:
> On Thu, Mar 26, 2026 at 04:41:11PM -0600, Keith Busch wrote:
> > 
> > You're suggesting that Ziping append the new fields to the end of this
> > struct? I don't think we can modify the layout of a uapi.
> 
> He needs to add before flex array. This struct is submitted by the user
> and kernel can easily calculate the position of that array.

No, you can't just do that. Existing applications would break when they
compile against the updated kernel header. They don't know about this
new "tph" supplied flag, but they'll all accidently use the new
dma_ranges offset. 
 
> Something like this:
> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
> index b1d658b8f7b51..d78d915992232 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -237,7 +237,11 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>         if (get_dma_buf.region_index >= VFIO_PCI_ROM_REGION_INDEX)
>                 return -ENODEV;
> 
> -       dma_ranges = memdup_array_user(&arg->dma_ranges, get_dma_buf.nr_ranges,
> +       if (!tph_supplied)
> +               dma_ranges = memdup_array_user(old_dma_ranges_pos, get_dma_buf.nr_ranges,
> +                                      sizeof(*dma_ranges));
> +       else
> +               dma_ranges = memdup_array_user(&arg->dma_ranges, get_dma_buf.nr_ranges,
>                                        sizeof(*dma_ranges));
>         if (IS_ERR(dma_ranges))
>                 return PTR_ERR(dma_ranges);
> ~

