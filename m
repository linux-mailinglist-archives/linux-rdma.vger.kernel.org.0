Return-Path: <linux-rdma+bounces-18844-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCSTF3zNy2luLwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18844-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 15:34:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCD936A52C
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 15:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 182FE3095C29
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 13:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140103E0C65;
	Tue, 31 Mar 2026 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdU2s016"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EF1393DD8;
	Tue, 31 Mar 2026 13:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774963790; cv=none; b=ZTg/trpMmAQNYZ22j1bobJVsZGGjrCS2gWZUJaTHayb+9zteHe656fx4iSPzwXLkKuGrDOF5uMtH1GAaLcvat5JsxukoxcL70oZUY6QV404mMFh/LrAd0K6rdDuHtl8fYxTEC0xHvgH3ZfgemjGKkxgo2FE1o1kM4b1ylEKu0sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774963790; c=relaxed/simple;
	bh=yOspeiVvS+gNtJplzbM2Dxr/WR4OJO96oQHUmIt9v0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDIvbEHbHPIdmwnSodqUqJ7QfndJdqtDNuaJ/SkmgbhPiiwgYewodcBZR1xRI0LG0iVZ+iNBHqri+PArt1xyCoV1IV2yGzOV36RdBofUoxSw0OdSwkONH7qWO+bkk8wKaTwUg88Cto5/59XWqo3dylzx8YQ1++Dc9c2j2CDDdbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdU2s016; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130B4C19423;
	Tue, 31 Mar 2026 13:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774963790;
	bh=yOspeiVvS+gNtJplzbM2Dxr/WR4OJO96oQHUmIt9v0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hdU2s016zAmRsWGzEOu4gpXir2KwMeVSQjx8oTukDGOEZ5d55Ib7wtjtIX6XCGH1p
	 2tHDRTfLxzvY+yUuDP+yN6a1Ef7FxclNurfMXNAXFvql5oDKubioR9l5thGX7x42QS
	 Tfj57n4w7/1pVYC6zdDTmDfUsUgt88IDR1g/mWSvZRE3MW0+tNxG54UGWDOKcQ/tSt
	 tQ1kBpDF8XU5i31oN0KdhMQdjEtGwz5vCrVgj/8TjL5xtChvGTutVbAmxnfrUrZNRt
	 hUGeAiYo/xIoX2g1a+/HqGzOBC8pXYDhzKZMcWT2NbSH5SCBjtNBURTKrNokktb6BR
	 OWC1YLGYTX5GQ==
Date: Tue, 31 Mar 2026 16:29:42 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Zhiping Zhang <zhipingz@meta.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RFC v2 1/2] vfio: add callback to get tph info for dmabuf
Message-ID: <20260331132942.GC814676@unreal>
References: <20260324234615.3731237-1-zhipingz@meta.com>
 <20260324234615.3731237-2-zhipingz@meta.com>
 <20260325082534.GN814676@unreal>
 <acW2BwQKaUbS3eL9@kbusch-mbp>
 <20260331083758.GA814676@unreal>
 <acvFV8c5QVxnt3Em@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acvFV8c5QVxnt3Em@kbusch-mbp>
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
	TAGGED_FROM(0.00)[bounces-18844-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0CCD936A52C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 07:00:07AM -0600, Keith Busch wrote:
> On Tue, Mar 31, 2026 at 11:37:58AM +0300, Leon Romanovsky wrote:
> > On Thu, Mar 26, 2026 at 04:41:11PM -0600, Keith Busch wrote:
> > > 
> > > You're suggesting that Ziping append the new fields to the end of this
> > > struct? I don't think we can modify the layout of a uapi.
> > 
> > He needs to add before flex array. This struct is submitted by the user
> > and kernel can easily calculate the position of that array.
> 
> No, you can't just do that. Existing applications would break when they
> compile against the updated kernel header. They don't know about this
> new "tph" supplied flag, but they'll all accidently use the new
> dma_ranges offset. 

So we need to always pass TPH flag and treat 0 as do-nothing-field.

Thanks

