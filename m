Return-Path: <linux-rdma+bounces-12253-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D74B08B88
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 13:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331C516722D
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 11:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE291F9F73;
	Thu, 17 Jul 2025 11:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t53Mbc7B"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4BE219EB
	for <linux-rdma@vger.kernel.org>; Thu, 17 Jul 2025 11:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752750495; cv=none; b=CpxVRqj/ISH6XRy2tkqRB79yAmdgdHmtGXQET1KtHNGCFoT+rdBg8WsqY8fJBHGYqqxBuvcHK+2OyFEJWMVZay/2l67waEeUgqMdrYby+8memI6TXi54Y6ERUR1GkgbAc2DTY51/WBeoFJOHkP1vWEJG+XyTj27EA7eR3NI9OA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752750495; c=relaxed/simple;
	bh=RfTysmgM7qK4hqMy3krQGDFnJYSaC/LIR9pdVqhn8JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DspiW0vF383Cca20CNFJfLXft77bjQfHy5MM20Q5yOui6xfZ6enHVwGyOpmy7/mnHvJ+yi6P2MBscExssRJlq6fA0/WLtQ+YCNSqatu4KhKjN3KloH5lh0qIBr4kEdF2vMQ/41Y4LEd6tFbj6t6qbl1AvzPq6biG6lPt25VJDgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t53Mbc7B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FA7C4CEE3;
	Thu, 17 Jul 2025 11:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752750494;
	bh=RfTysmgM7qK4hqMy3krQGDFnJYSaC/LIR9pdVqhn8JA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t53Mbc7B26nXitz3hrV8x9SY7XmmyAR5/y5Ix62V8Yc8s3CphQegiI7bOd93hFoIL
	 /baMOZYQZIUKA2wQa0of3POsdGlCOZacPqdMWqe3j4oiC8vuxzl444HiXpuJ4gdeAY
	 d0EqT5aepp5elY1ImyXRdb0jYgNryHcXp3QfDQCwrgnzX691UlCg50CdM+adyiY1QB
	 SCdBKaHVqMo9m+VvttOxha9jofOysAEYM3K1/Csld6Q11tDI+tU8FA6+atT9To2pC2
	 y0bFv4i6nfmdTa6uVNfMDUiTlp1K7+15iC194PxjAPI3f8j3mRPjaOjYGE8fi3qKCF
	 SVQmj4WBr/S6g==
Date: Thu, 17 Jul 2025 14:08:10 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Wathsala Wathawana Vithanage <wathsala.vithanage@arm.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v1 5/8] RDMA/core: Introduce a DMAH object and
 its alloc/free APIs
Message-ID: <20250717110810.GA402218@unreal>
References: <cover.1752388126.git.leon@kernel.org>
 <b1ff9b142f785a52009b288567bf4e15dd34ecb8.1752388126.git.leon@kernel.org>
 <PAWPR08MB89096EE77AA03539FEDFEBD19F56A@PAWPR08MB8909.eurprd08.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAWPR08MB89096EE77AA03539FEDFEBD19F56A@PAWPR08MB8909.eurprd08.prod.outlook.com>

On Wed, Jul 16, 2025 at 03:58:03AM +0000, Wathsala Wathawana Vithanage wrote:
> Hi Jason,
> 
> > +/* bit values to mark existence of ib_dmah fields */ enum {
> > +     IB_DMAH_CPU_ID_EXISTS,
> > +     IB_DMAH_MEM_TYPE_EXISTS,
> > +     IB_DMAH_PH_EXISTS,
> > +};
> > +
> > +struct ib_dmah {
> > +     struct ib_device *device;
> > +     u32 cpu_id;
> 
> Is this a logical CPU id?

Yes, this is an input to cpumask..., which operates on logical CPU IDs.

Thanks

> 
> --wathsala
> 
> 
> 
> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

