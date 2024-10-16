Return-Path: <linux-rdma+bounces-5416-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FE39A001A
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2024 06:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27131F25BCE
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2024 04:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A54217DFEC;
	Wed, 16 Oct 2024 04:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XMrPYYN4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3FC21E3BF;
	Wed, 16 Oct 2024 04:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729052617; cv=none; b=dEeRE+bQJaRy0SvPDfcTDY46ROklFXWrlrouKizLzisbtg33iYDPBD0PwWNJQKS3xS7ujqodhtJ/nFh3ICuHY+9BXGAnuXGolWNxCXTNlsQIZXFu7dP6RDIFO8KJQCf7jlCZEFvn3fKklAvztMY0y437wcLhgVTmoA7BRjLcu+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729052617; c=relaxed/simple;
	bh=3iDmzb+897ogEaNn30FRct+QBNc9fQ+RkDxReSKGAKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYeCTkwPT9NQHIdy5pMQKe0pja4CV6wTbcfSe/euTlVhDHNa2SRU9hdtD86Wpds+6cXnnH/1s+b+EsGjsH/AtigQmjVqLLugQips19rEFTAR/vrmrHyBxxwd3Nxgmqk1s3xxAO9RenJUxcp1KX2d6ETGRp+bAJOVGgalO/R3br8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XMrPYYN4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wcUcuFqqucU0QfpmucbUVnYkn1DlkvM9RvqFMIVSmEk=; b=XMrPYYN4JlgEsNYp5enHSSCYqc
	slPqPTHsUImSqs9uZ8tuYyXhELrUaS6vuT2LbM8FULVnhDRDoPSOxRbLnKrqxJfsCvxchsxh/xfob
	0jxLgRHk9r1FX9mmer/+2Ucyl4c1oTrRKxbH/As2LplkV5Gjew/zJSSu5OFowW/Weiqt76vsqH2A9
	6MbrkgNsbFAn+Tporc1RfAb4/ILFpusmDuVBiN5pgm9X1RX+ynSMCRzo+Q+/AfUBZdZWUByjngnW2
	ei6oY5Aqp6vTzzCz6nfRU2O8SbkuURienIz9CqtuMQy7BprJJHjiy4/VtFMpLlLWkZstEG8ckU9I1
	o4iGa1WQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t0vZP-0000000ASzs-0jKN;
	Wed, 16 Oct 2024 04:23:35 +0000
Date: Tue, 15 Oct 2024 21:23:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yonatan Maman <ymaman@nvidia.com>
Cc: nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-mm@kvack.org, herbst@redhat.com,
	lyude@redhat.com, dakr@redhat.com, airlied@gmail.com,
	simona@ffwll.ch, jgg@ziepe.ca, leon@kernel.org, jglisse@redhat.com,
	akpm@linux-foundation.org, dri-devel@lists.freedesktop.org,
	apopple@nvidia.com, bskeggs@nvidia.com
Subject: Re: [PATCH v1 0/4] GPU Direct RDMA (P2P DMA) for Device Private Pages
Message-ID: <Zw8_x0Tvux9IMbly@infradead.org>
References: <20241015152348.3055360-1-ymaman@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015152348.3055360-1-ymaman@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 15, 2024 at 06:23:44PM +0300, Yonatan Maman wrote:
> From: Yonatan Maman <Ymaman@Nvidia.com>
> 
> This patch series aims to enable Peer-to-Peer (P2P) DMA access in
> GPU-centric applications that utilize RDMA and private device pages. This
> enhancement is crucial for minimizing data transfer overhead by allowing
> the GPU to directly expose device private page data to devices such as
> NICs, eliminating the need to traverse system RAM, which is the native
> method for exposing device private page data.

Please tone down your marketing language and explain your factual
changes.  If you make performance claims back them by numbers.


