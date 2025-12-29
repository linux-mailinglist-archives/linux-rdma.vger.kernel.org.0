Return-Path: <linux-rdma+bounces-15233-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F127CE5C27
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Dec 2025 03:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 299AF30024F5
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Dec 2025 02:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE7D22F177;
	Mon, 29 Dec 2025 02:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="P0n3Yux+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD59F145B27;
	Mon, 29 Dec 2025 02:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766976761; cv=none; b=AZrSpZxqnvo2CsjMszrp01vBdkvi5y8C3QAtTyR1z6azqtP5DmAqM0DRMbQu32Hy2XC90ToWazzUrnZEuAX0uMopksW6t5W0bIm64IPA6n+hIyqTRGa9Pw+os5lSINUKtlJzid5C+YdIfdz3XFSw1l3SDnOvgsgzLMm4+Z2M3tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766976761; c=relaxed/simple;
	bh=fqSq9l8myi3AOkZP1l8+SQtFYtcI1gg63YeB41f95SY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=td2KQn3nOSjPqQe8ByACK9rDzgeERvLZQ2/wwGEwl5Sd7YjptrOXVttVVW8aNhSwyh8teioMcc2S6CahlPk0jUunilYVm4RE18ItUYgUKz8sUtaTYOM7IkjPBoYq1OSmyahRAmZlnNw0kci996kuI+5WyJflX0xpkoOu01cUhRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=P0n3Yux+; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=4MqlCW5uQhFN1yeXUj8BXQ8ms71f1OW/AMW7qsF1Buc=;
	b=P0n3Yux+WGmyFg8pPWMuQZvpt0J6ns8Hn0wAXJcUhes1Z2rNc6T3oABOrgl5BM
	Z08JrL+/7vmCUg8If83eOtO+L2uFeHsxYMfWqEu0KqqOByMA09Jjvus4gxI44uqg
	GB+XaEzzJy3eVCZkbtUv9wzYljVDDAAEIRKabTbGAZ8/E=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAXKwkr7FFphUWTCw--.4421S2;
	Mon, 29 Dec 2025 10:49:17 +0800 (CST)
Date: Mon, 29 Dec 2025 10:49:15 +0800
From: Honggang LI <honggangli@163.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
	danil.kipnis@cloud.ionos.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RDMA/rtrs: client: Fix clt_path::max_pages_per_mr
 calculation
Message-ID: <aVHsK0D_SpJcn9wu@fedora>
References: <20251224095030.156465-1-honggangli@163.com>
 <20251225123332.GI11869@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251225123332.GI11869@unreal>
X-CM-TRANSID:_____wAXKwkr7FFphUWTCw--.4421S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RR_MaDUUUU
X-CM-SenderInfo: 5krqwwxdqjzxi6rwjhhfrp/xtbC7A30OmlR7C0wOgAA3c

On Thu, Dec 25, 2025 at 02:33:32PM +0200, Leon Romanovsky wrote:
> Please put changelog under --- marker, below Signed-off-by tags.

OK.
 
> >  	do_div(max_pages_per_mr, (1ull << mr_page_shift));
> > +	if ((u32)max_pages_per_mr == 0)
> > +		max_pages_per_mr = U32_MAX;
> 
> It is "max_pages_per_mr = min_not_zero((u32)max_pages_per_mr, U32_MAX)"
> 

Will replace it with `min_not_zero` in v3.

Thanks


