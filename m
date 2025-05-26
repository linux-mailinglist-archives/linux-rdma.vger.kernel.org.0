Return-Path: <linux-rdma+bounces-10717-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F5FAC3C5C
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 11:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E28BB1892079
	for <lists+linux-rdma@lfdr.de>; Mon, 26 May 2025 09:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404AA1E8324;
	Mon, 26 May 2025 09:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5tZaT4h"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09E853A7;
	Mon, 26 May 2025 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748250447; cv=none; b=mnt8y/n4zrN6rZ5pr6RVBBIolB+g0njjLJLtBIFNDCIE/JtMDeR3xXVjmGyfkp3fx8NpbOp7p2Yo4AQcndsXdjup7NgAag4GvN2dvosJ4I8eA5RmQX5SFaVG/hnigfaxQ1q+FxSMvBOEYjqorFu++cp1xpbiYkl5cFGX0+5p4ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748250447; c=relaxed/simple;
	bh=porOjdZ2lQuSg6mMXbJffwG6qck2syE0nNBjtW/CVzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnuvLF9vP/p6ZBMlQkEiPPgaeoqiz/uD33/k+FCk8dFEFN1cbkBABPpoOutM41MHGuDxL6WQXbYbrNngqkJI9cqlo3UHe1Yy/xjzwFR1Ek0crnc7iWqbazb7xmnuh7uhY6LV6q/O2zgZ6f2wiNjEGg1QyDqrlvnDgWTRT2uuGzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5tZaT4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E4BC4CEEE;
	Mon, 26 May 2025 09:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748250446;
	bh=porOjdZ2lQuSg6mMXbJffwG6qck2syE0nNBjtW/CVzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q5tZaT4h+cN2e4iwJpaAcrrJ6ku6xQazJCOTh65cc8vUpn2Mq1CV9KaqGwo9RGJJ4
	 TlpR2fcrn4IjWX9tIKr7tAJenRuns4qbjQcMI4Lf/3BUueLvNQwg4Q/Qk/n5OiZCxM
	 LKra1qnA2Ifa6CxhzkGSStRBgefeHdNzP1/r2ATlunFZzHHzebtWk08MKEN/g9KUD9
	 FVnkcTXEEQvCSQS1DdkzNPcNN1RcV5vtP0gVNPWHQdUYDxNYMxoNIv1iHegUOZg6zD
	 7APqf7ys7wDaAuI52KdbUyTcrx1ela+T1JUwdWgJaj6633vdCyr2kuENWULLs13Guq
	 A8bubTL6gV8VQ==
Date: Mon, 26 May 2025 12:07:22 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, jgg@ziepe.ca,
	zyjzyj2000@gmail.com, Daisuke Matsuda <dskmtsd@gmail.com>
Subject: Re: [PATCH for-next v3] RDMA/core: Avoid hmm_dma_map_alloc() for
 virtual DMA devices
Message-ID: <20250526090722.GY7435@unreal>
References: <20250524144328.4361-1-dskmtsd@gmail.com>
 <174815946854.1055673.18158398913709776499.b4-ty@kernel.org>
 <aDQQyjJv9YKK_ZoV@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDQQyjJv9YKK_ZoV@infradead.org>

On Sun, May 25, 2025 at 11:57:14PM -0700, Christoph Hellwig wrote:
> On Sun, May 25, 2025 at 03:51:08AM -0400, Leon Romanovsky wrote:
> > 
> > On Sat, 24 May 2025 14:43:28 +0000, Daisuke Matsuda wrote:
> > > Drivers such as rxe, which use virtual DMA, must not call into the DMA
> > > mapping core since they lack physical DMA capabilities. Otherwise, a NULL
> > > pointer dereference is observed as shown below. This patch ensures the RDMA
> > > core handles virtual and physical DMA paths appropriately.
> > > 
> > > This fixes the following kernel oops:
> > > 
> > > [...]
> > 
> > Applied, thanks!
> 
> So while this version look correct, the idea of open coding the
> virtual device version of hmm_dma_map directly in the ODP code
> is a nasty leaky abstraction.  Please pull it into a proper ib_dma_*
> wrapper.

I did it on purpose as these ib_dma_* are used by all IB users (core, drivers
and ULPs) and at this point I don't want them to use any of that specific API.

Thanks 

