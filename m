Return-Path: <linux-rdma+bounces-18851-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJAAHLDXy2mILwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18851-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 16:18:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFF736ACFD
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 16:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E6AD3099094
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 14:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DDB3F7875;
	Tue, 31 Mar 2026 14:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzRtQzHM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA843B388E;
	Tue, 31 Mar 2026 14:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774966440; cv=none; b=uj+KkhSBlw9Hik++lU1lMJnTecqnhshYd1/bkg4iaoHVT5Pi1yINuf0iBvLeHj1QW91EOBW6RFYUCQROmIU8mB/3L/vYdikrVLnai9Kqj2UJonQ9XeNa0GY4GVl01xehfB8WRr4UffDLbu0ckLL7ShLiZZaDl6yFibIQfA9nb7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774966440; c=relaxed/simple;
	bh=WuDTh1qvVfpreyA+FwkOQW5WOW/1M6AkJSQhmwhXYQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIti58WNiX734+ivxl0mt6ZsCsDj3OLcSnuKdWbt9Z+MFfUJBm5CGQk+m9vcCnOIJ+maW4UwrCyM8mQh/wTuzbYjJCBmn3gK+BmclrqT1TNiy454F1WuecIZML+rjSzDElibK9ZZLFVIFj/+KB1jwj2xfqq5PN/ecYrNnbXAQLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzRtQzHM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E590CC19423;
	Tue, 31 Mar 2026 14:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774966440;
	bh=WuDTh1qvVfpreyA+FwkOQW5WOW/1M6AkJSQhmwhXYQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LzRtQzHM+7ul0hm/xfo7NgRoHCrt2OsiKzgRPhjDXdWwcxZjjMA1P5HJP8+thKeSW
	 dCZGnt2cfmJYCJbx98mUnoWzGgRzMfMJF2stE704IIgW7Tbjgn72daUYEYUry8Gmdy
	 R8tCM+cdqhYylcd1eMFh+0+fIMAuEvhIYQC/4ADz7OL7uwS0JgIFfh9OJzC+/6zn/W
	 VLoTaYI7N0MTfj5Gy52dDY/TJpv4+V4DS/SkF8E1cEIMSB4RKLDsZKgG39HAc4uk5P
	 9MD72pRxxmuRylRmH+eDnH0Dyh7f1qRJkvRsUmOIpXJo9oT68WCv6AHCtRXSjeOilT
	 nobVfwLzY6fow==
Date: Tue, 31 Mar 2026 08:13:58 -0600
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Zhiping Zhang <zhipingz@meta.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [RFC v2 1/2] vfio: add callback to get tph info for dmabuf
Message-ID: <acvWplw67b3Gwlkc@kbusch-mbp>
References: <20260324234615.3731237-1-zhipingz@meta.com>
 <20260324234615.3731237-2-zhipingz@meta.com>
 <20260325082534.GN814676@unreal>
 <acW2BwQKaUbS3eL9@kbusch-mbp>
 <20260331083758.GA814676@unreal>
 <acvFV8c5QVxnt3Em@kbusch-mbp>
 <20260331132942.GC814676@unreal>
 <acvNsvS5ShlQlrox@kbusch-mbp>
 <20260331140309.GH814676@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331140309.GH814676@unreal>
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
	TAGGED_FROM(0.00)[bounces-18851-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 1CFF736ACFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 05:03:09PM +0300, Leon Romanovsky wrote:
> I understand, my proposal is always set TPH flag when new struct is
> used.

An existing application recompiled against the new kernel api implicitly
uses the new struct layout without setting the TPH flag, so kernel and
application are out of sync on where dma_ranges exists with your
proposal.

