Return-Path: <linux-rdma+bounces-18850-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sD92NV/Uy2mILwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18850-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 16:04:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AA836AA17
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 16:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2304430267BE
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 14:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5A43FB050;
	Tue, 31 Mar 2026 14:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTxfuMQN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226903FAE1A;
	Tue, 31 Mar 2026 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774965794; cv=none; b=In0p8Wns/gbB8jI9N5R9WVP56ryqVj2tGJcI2BY8h6IhPJJQRgrbi/tJMLNmPu+qwFZuh14faa5CKV7nTjmbaiL8WGrEfsryIFd3La7XcIS2PUXVRPGvlf7J3dFx2X/QqXOvgxH53h3t4EsCuqf3LU96YopRXETBIgV/2wfD+gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774965794; c=relaxed/simple;
	bh=IL6FrHP3uHz8//ln3rvV3AwE9xShRnaGlba1Swd/CcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8snW71rsKMSZTfrFtR3Tmq3YunfIIClXB869+BCaQRqFw24+GWkF1mKibrVMr1BGnOT0kBpskm3JWat8N1eEvcOVKnSLetBVkRCn2bM7EuHAcYO2CEV9+5juErZQ+7gKOYRL+DdIyhR+BznwqM66g/PTv9OFwWlnmA9TL7KVGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTxfuMQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1EFC19424;
	Tue, 31 Mar 2026 14:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774965793;
	bh=IL6FrHP3uHz8//ln3rvV3AwE9xShRnaGlba1Swd/CcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DTxfuMQNcKnBOZV95n5BWavkoaGlKAWWfExhRT+itzUFx5gqCaXswy6i02Gq73KjI
	 Q2IOghUst9Rx7ZdlOj9a3+Yj+GV9iSozAtDTP8PoHt9qa2MrX1RvEIsMbdGTwhd0R1
	 ps0sQQ/kfn+Pjmk+pwd970gylvPJW8FBSVzDD8ZaFefaI2BMXgPwcnOdiQEXGK7WII
	 AtzvVT2u9PcGxSOiIRMbs9DkNzB5Dmm2SK+2vEpVZPYRRXn+n5oGdU/JuF0PJqddAc
	 VW81dIkzz3F2ZAQtqeFBjWifnIQgDFyQuD0x4jf51t8xqI+vo+RPCbk1GA6ii4yPCN
	 OmwfmJsz6icIg==
Date: Tue, 31 Mar 2026 17:03:09 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Zhiping Zhang <zhipingz@meta.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RFC v2 1/2] vfio: add callback to get tph info for dmabuf
Message-ID: <20260331140309.GH814676@unreal>
References: <20260324234615.3731237-1-zhipingz@meta.com>
 <20260324234615.3731237-2-zhipingz@meta.com>
 <20260325082534.GN814676@unreal>
 <acW2BwQKaUbS3eL9@kbusch-mbp>
 <20260331083758.GA814676@unreal>
 <acvFV8c5QVxnt3Em@kbusch-mbp>
 <20260331132942.GC814676@unreal>
 <acvNsvS5ShlQlrox@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acvNsvS5ShlQlrox@kbusch-mbp>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18850-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B5AA836AA17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 07:35:46AM -0600, Keith Busch wrote:
> On Tue, Mar 31, 2026 at 04:29:42PM +0300, Leon Romanovsky wrote:
> > On Tue, Mar 31, 2026 at 07:00:07AM -0600, Keith Busch wrote:
> > > On Tue, Mar 31, 2026 at 11:37:58AM +0300, Leon Romanovsky wrote:
> > > > On Thu, Mar 26, 2026 at 04:41:11PM -0600, Keith Busch wrote:
> > > > > 
> > > > > You're suggesting that Ziping append the new fields to the end of this
> > > > > struct? I don't think we can modify the layout of a uapi.
> > > > 
> > > > He needs to add before flex array. This struct is submitted by the user
> > > > and kernel can easily calculate the position of that array.
> > > 
> > > No, you can't just do that. Existing applications would break when they
> > > compile against the updated kernel header. They don't know about this
> > > new "tph" supplied flag, but they'll all accidently use the new
> > > dma_ranges offset. 
> > 
> > So we need to always pass TPH flag and treat 0 as do-nothing-field.
> 
> I don't think you're understanding the implications. If Zhiping appends
> new fields in front of the flex array dma_ranges, then existing
> applications will implicitly use the new offset if they are recompiled
> against the new kernel header. But if the binary was compiled against
> the older kernel header, then that application would use the previous
> offset. Both applications have the TPH flag cleared to 0. How is the
> kernel supposed to know which offset the application used?

I understand, my proposal is always set TPH flag when new struct is
used. Everything will be much easier if we can add fields after flex
array.

Thanks

