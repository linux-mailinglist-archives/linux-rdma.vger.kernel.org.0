Return-Path: <linux-rdma+bounces-18863-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBxiGCAkzGnHPgYAu9opvQ
	(envelope-from <linux-rdma+bounces-18863-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 21:44:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC14370C1B
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 21:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7D3930458CA
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 19:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF73426EA8;
	Tue, 31 Mar 2026 19:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3/LFlfZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5080D3A75A8;
	Tue, 31 Mar 2026 19:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986245; cv=none; b=VOxIcjkU0eba2qskcSrnNd4D1UBrPA6rjfU4h76bZRMxKM2dKPAzFkwP9w+OPAzJeRxGUfQacNRbw5MTVoF9GJ44SR7yVxPjj+jW4CYNgR9sNHr49kM6MH0ZSkhNgJCYK1WeOfKZcHgq2iy8AkBfNY9IzH6tZyDnh85+nPaAGlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986245; c=relaxed/simple;
	bh=jGGUJKYrNdV8MrZToA2w5hj3QV82YHccM4CmlfqrLZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjodHXR8mOEzrzyR8QXkdBauEsq1LG3GOZdeFkQKcRb3eG+WiMOAof10RhEplvGOA0RTHZf0E7olkmdQ155jSoAHEg9IZHmsoLn7ycJCAfu2HyalSRglSO2nqZ6O5qlSYJQpgHfEsr/x3cOrC2cDFk75HHqjy+sco5q9EZd5bOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3/LFlfZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F5EC2BCB2;
	Tue, 31 Mar 2026 19:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774986245;
	bh=jGGUJKYrNdV8MrZToA2w5hj3QV82YHccM4CmlfqrLZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q3/LFlfZuSyNzsTx+6YfPrMA8hjusRnQdSbDNm1uLtyw2tdOl0S/wuHE+sPFUrKHx
	 vBNdpyBqm5EjQXRbJgCLoKwCwUAA15df0M2MJ4HLq0fsV83v8LW5RC2oDT7aAA8UJX
	 8bwdTpDVolQoPS0sF48lnz0DXH2mUiVAMxuLpmkeg+L/uviUi4p2NGmHjqjTk1cKzT
	 bHeWYYJNPnXHa7hhXi9pjF0M2I52ntniXF0Q2sYFxQHqZxfNtd+0ftCaxZ222xj++W
	 XZDKarZ7rwu30MFv95BHt8xBnzedg3sCeHRf8SxbEAoBXu9PHr+rCW/ubZAfxD4z+g
	 4RbgcSXcTlBRA==
Date: Tue, 31 Mar 2026 13:44:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Zhiping Zhang <zhipingz@meta.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RFC v2 1/2] vfio: add callback to get tph info for dmabuf
Message-ID: <acwkAo2k41xaxdTS@kbusch-mbp>
References: <20260324234615.3731237-2-zhipingz@meta.com>
 <20260325082534.GN814676@unreal>
 <acW2BwQKaUbS3eL9@kbusch-mbp>
 <20260331083758.GA814676@unreal>
 <acvFV8c5QVxnt3Em@kbusch-mbp>
 <20260331132942.GC814676@unreal>
 <acvNsvS5ShlQlrox@kbusch-mbp>
 <20260331140309.GH814676@unreal>
 <acvWplw67b3Gwlkc@kbusch-mbp>
 <20260331190220.GI814676@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331190220.GI814676@unreal>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18863-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kbusch@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3DC14370C1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 10:02:20PM +0300, Leon Romanovsky wrote:
> 
> Right, what about adding TPH fields to struct vfio_region_dma_range
> instead of struct vfio_device_feature_dma_buf?

You might have to show me with code what you're talking about because I
can't see any way we can add fields to any struct here without breaking
backward compatibility.

If we can't claim bits out of the unused "flags" field for this feature,
then my initial reply is the only sane approach: we can introduce a new
feature and struct for it that closely mirrors the existing one, but
with the extra hint fields.

