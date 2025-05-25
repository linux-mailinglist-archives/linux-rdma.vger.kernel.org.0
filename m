Return-Path: <linux-rdma+bounces-10673-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C26AC3290
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 08:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CEB3177906
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 06:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFE915C158;
	Sun, 25 May 2025 06:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iy7NjwQ6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ABC1805B;
	Sun, 25 May 2025 06:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748153154; cv=none; b=QTsZeet2LvGfSsSDAgg8K2uA0s6r9lz2yxpejRHnoaHLT1EoQQILMkxephklJSwksU6Ft0294v3l/7s1qDur/XC9IZI3jZdcdUQZQPAKQtOnf3c4FTL+nz8IFrcthsBKY4ZycOqWLvE0Fyc4t5igoCT4dULwO3CsdaeMHv6x5oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748153154; c=relaxed/simple;
	bh=iYGQjcQBB0QQivTFsyEcDx7K7yaosMFRSW4E0nqxogA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nz0lJadhME/f0vh81c7DxdTKHOgJlY547hcdwUG1mv8dKbdq3aoYR9fYBRzrUoO8/OD3f+itQ4u8Kez3sOkphxgvGR8aCN5e2sj9FSthqqKNTdnCPUQ7wz6vAJEcIK9i9Wre9b5nQhL7VnPrAroiB39On4XLPqYwLz/ZUqUmBQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iy7NjwQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D28C4CEEA;
	Sun, 25 May 2025 06:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748153153;
	bh=iYGQjcQBB0QQivTFsyEcDx7K7yaosMFRSW4E0nqxogA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iy7NjwQ6UAEhCs9vP0tG7ZIVpH0Mfh+HxwxSvnKvN9gEX7CAjPnGDbmDvmQ5vw+Td
	 +UZy2EjiNmR5pf/bB+niALXWx0H+teK5TRJBnCWboYQ1jQd9sW4pLlH8qlyo5O86Es
	 vsSw9D57DtVMnAyLA8ch4kmOPT4Qt+jfW9gmhLO+5vpd0yAaI8K8Uh0rf3RfmG2Y/M
	 106ArlYYRveAGsKZX/0eqOcFsAG1UzC4fkYhZ6OhjZqU4oIh28PIQuB02+mYKi08f6
	 kSmU1gHANoyDtiVL0VK/Wf9AkmohoMoLuYZOp81DBCHcc/bc///zFEl1u6YgmwmAmv
	 72qqRSKSWbyXg==
Date: Sun, 25 May 2025 09:05:49 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Greg Sword <gregsword0@gmail.com>
Cc: Daisuke Matsuda <dskmtsd@gmail.com>, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, jgg@ziepe.ca, zyjzyj2000@gmail.com,
	hch@infradead.org
Subject: Re: [PATCH for-next v3] RDMA/core: Avoid hmm_dma_map_alloc() for
 virtual DMA devices
Message-ID: <20250525060549.GV7435@unreal>
References: <20250524144328.4361-1-dskmtsd@gmail.com>
 <CAEz=LcsmU0A1oa40fVnh_rEDE+wxwfSo0HpKFa_1BzZGzGG71g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEz=LcsmU0A1oa40fVnh_rEDE+wxwfSo0HpKFa_1BzZGzGG71g@mail.gmail.com>

On Sun, May 25, 2025 at 05:27:23AM +0800, Greg Sword wrote:
> On Sat, May 24, 2025 at 10:43 PM Daisuke Matsuda <dskmtsd@gmail.com> wrote:
> >
> > Drivers such as rxe, which use virtual DMA, must not call into the DMA
> > mapping core since they lack physical DMA capabilities. Otherwise, a NULL
> > pointer dereference is observed as shown below. This patch ensures the RDMA
> > core handles virtual and physical DMA paths appropriately.

<...>

> > +EXPORT_SYMBOL(ib_dma_virt_map_alloc);
> >  #endif /* CONFIG_INFINIBAND_VIRT_DMA */
> >
> 
> Your ODP patches have caused significant issues, including system
> instability. The latest version of your patches has led to critical
> failures in our environment. Due to these ongoing problems, we have
> decided that our system will no longer incorporate your patches going
> forward.

Please be civil and appreciate the work done by other people. Daisuke
invested a lot of effort to implement ODP which is very non-trivial part
of RDMA HW.

If you can do it better, just do it, we will be happy to merge your
patches too.

At the end, we are talking about -next branch, which has potential to be
unstable, so next time provide detailed bug report to support your claims.

In addition, it was me who broke RXE.

Thanks

