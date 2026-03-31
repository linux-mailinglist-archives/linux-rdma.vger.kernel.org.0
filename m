Return-Path: <linux-rdma+bounces-18845-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNDfIUfOy2luLwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18845-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 15:38:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3727736A5EB
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 15:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 308503035893
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 13:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50ADE32E6B4;
	Tue, 31 Mar 2026 13:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K81gF7XR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121BC3019A4;
	Tue, 31 Mar 2026 13:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774964149; cv=none; b=MWeDdKmHIOUqf6rhXshVIDodRRO+6GQ0+ove/PgadEmgSHoFkpiOXAtzD81fykLaxpkDDW0FS0q0pdB81I5VFflAuMblqw768KuEM73EHttQF+r2u2MmfwQK6EfjscleXlGpAEZyPPK57/AboYj3HzYt0nsVDf5kZEqz5UvKwqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774964149; c=relaxed/simple;
	bh=T7CKcWnw0/Y648smPZCLrFLT4ryWZtkgPW//JWGynMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRIXuF14A9dmEff/2ajIU/vgUEMpj2Rn5NvSOEwzJLoAk/h2kb248yN5NYacE9Y0w0b9gFQgnHqnMElHhX/spxLm1JZEaaZuCO+7BzQL0QY9oABVsp1mvzzFZa7CIq3h+N5zAInygAlsa0oNkNTtltsGMAtY2KnzDyvfq2oeo/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K81gF7XR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D6EC19423;
	Tue, 31 Mar 2026 13:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774964148;
	bh=T7CKcWnw0/Y648smPZCLrFLT4ryWZtkgPW//JWGynMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K81gF7XRIHDSqtDeXLYPJ49+bK0BxJmbsE9v1yZoU0aXCXcf96P4V2APhihTnCt0D
	 CZOIQQqb58JErx9VcfbX3QTfkyJlb01SNRArlqjjUIXfVGLYt7dPW95Pu2KsdmNwNR
	 4ycSoDd+/RPv701ksTbAW4Au8cr3OZ6ccMwL7zLJs9vwvFDWr9Cb0p6mjbIv6jds1V
	 ISGAxfZurcIMqWk02UViuL5pFtTZ7LEBH/Nbg4ODW4iH8gas8f/cz9wuerbJU+JFxy
	 8vTwwE1+2O+PEEyJSRDfcyZ43PerNEL+bUsfN06Z3IC2SVho9tK8ZuqvFYAQQJ1hfe
	 xkPhRr1qLLchw==
Date: Tue, 31 Mar 2026 07:35:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Zhiping Zhang <zhipingz@meta.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RFC v2 1/2] vfio: add callback to get tph info for dmabuf
Message-ID: <acvNsvS5ShlQlrox@kbusch-mbp>
References: <20260324234615.3731237-1-zhipingz@meta.com>
 <20260324234615.3731237-2-zhipingz@meta.com>
 <20260325082534.GN814676@unreal>
 <acW2BwQKaUbS3eL9@kbusch-mbp>
 <20260331083758.GA814676@unreal>
 <acvFV8c5QVxnt3Em@kbusch-mbp>
 <20260331132942.GC814676@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331132942.GC814676@unreal>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18845-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kbusch@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3727736A5EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 04:29:42PM +0300, Leon Romanovsky wrote:
> On Tue, Mar 31, 2026 at 07:00:07AM -0600, Keith Busch wrote:
> > On Tue, Mar 31, 2026 at 11:37:58AM +0300, Leon Romanovsky wrote:
> > > On Thu, Mar 26, 2026 at 04:41:11PM -0600, Keith Busch wrote:
> > > > 
> > > > You're suggesting that Ziping append the new fields to the end of this
> > > > struct? I don't think we can modify the layout of a uapi.
> > > 
> > > He needs to add before flex array. This struct is submitted by the user
> > > and kernel can easily calculate the position of that array.
> > 
> > No, you can't just do that. Existing applications would break when they
> > compile against the updated kernel header. They don't know about this
> > new "tph" supplied flag, but they'll all accidently use the new
> > dma_ranges offset. 
> 
> So we need to always pass TPH flag and treat 0 as do-nothing-field.

I don't think you're understanding the implications. If Zhiping appends
new fields in front of the flex array dma_ranges, then existing
applications will implicitly use the new offset if they are recompiled
against the new kernel header. But if the binary was compiled against
the older kernel header, then that application would use the previous
offset. Both applications have the TPH flag cleared to 0. How is the
kernel supposed to know which offset the application used?

