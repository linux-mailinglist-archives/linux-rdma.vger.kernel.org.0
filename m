Return-Path: <linux-rdma+bounces-10714-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B10AC3A48
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 08:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780A8172C65
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 06:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658481DC07D;
	Mon, 26 May 2025 06:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F5fb1/2Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5701D63C7;
	Mon, 26 May 2025 06:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748242637; cv=none; b=OO3NCvrt+x9McGhZ/OVu2F1IFybHucLn0Tisf4iNVCl3ZjuOi1M/7rPNi1DAONxMsK0cVU/0NnfdEorLfEofH1sLDKpaEsoGizBCAJj6rx6YjM45ZR/Pz5cDFGjfQTtMPiQn3YSQ90fU47SQiPl5n4YzX+j1w59EmYGGjmPrQ4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748242637; c=relaxed/simple;
	bh=xx1G0IYpkddJ0UURedTcGID3WAvrp5o/oNP8111w3E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQOZkl0s7LUOjSw7F3JG8DbLyAizaqFkmbMvnbe3gRFTSJd6aic4G+Wgg4ktSGNjLVQ2QVF3TemfqcAzFx4VT3zxWTZ/MfNWHAyBGHGc0rMAtfgEvYily4njE2ZF5LrhQbTclpKKoDoJeyAc497BHd7xwiHK3uounb6gbU0euVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F5fb1/2Q; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3N5HVYn95TiR6tJjSW/C9FetSHwnCCxJu25MIh3EBkc=; b=F5fb1/2QHKzRbttsGm0r+q54qI
	H7HZrcgE4M58see/1CKgkrCjrs2Ig/FYVJmX3ZsG2JQ6rkUYSV9UmD9v2nt+ibO0JZaej0rgB8xOR
	NG7I1BFqbpus+ljHBsviSXS0sPiLAo1knXvQZSeG1gXYwN99qC2J0cnGKcjREtniTiq1/MPvgl97m
	t6BShkxGpJSwirIzfwkUktj9kdttZ3lQZzd6fXVYzsujrogA2tn9UDEK1kBoVg6Zqv3Pr2BSnamw+
	yOZsCrEx1v6E8Gu1ZnbNqNGhNECMppJcjCbdArw8JQlTgaom8ZQI64pxslfI9DKjJf2Sk/jhyk9xd
	xoqZiueQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJRlq-00000008F7Y-3DxB;
	Mon, 26 May 2025 06:57:14 +0000
Date: Sun, 25 May 2025 23:57:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, jgg@ziepe.ca,
	zyjzyj2000@gmail.com, Daisuke Matsuda <dskmtsd@gmail.com>,
	hch@infradead.org
Subject: Re: [PATCH for-next v3] RDMA/core: Avoid hmm_dma_map_alloc() for
 virtual DMA devices
Message-ID: <aDQQyjJv9YKK_ZoV@infradead.org>
References: <20250524144328.4361-1-dskmtsd@gmail.com>
 <174815946854.1055673.18158398913709776499.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174815946854.1055673.18158398913709776499.b4-ty@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, May 25, 2025 at 03:51:08AM -0400, Leon Romanovsky wrote:
> 
> On Sat, 24 May 2025 14:43:28 +0000, Daisuke Matsuda wrote:
> > Drivers such as rxe, which use virtual DMA, must not call into the DMA
> > mapping core since they lack physical DMA capabilities. Otherwise, a NULL
> > pointer dereference is observed as shown below. This patch ensures the RDMA
> > core handles virtual and physical DMA paths appropriately.
> > 
> > This fixes the following kernel oops:
> > 
> > [...]
> 
> Applied, thanks!

So while this version look correct, the idea of open coding the
virtual device version of hmm_dma_map directly in the ODP code
is a nasty leaky abstraction.  Please pull it into a proper ib_dma_*
wrapper.


