Return-Path: <linux-rdma+bounces-10623-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FCEAC2566
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 16:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA45A45497
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 14:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482C5296D01;
	Fri, 23 May 2025 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vQdQ1RoX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F02E296165;
	Fri, 23 May 2025 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748011700; cv=none; b=T/ccbTibU0hspjyA6682iGO7ne0Cp9s/HfWSN0NFHzoXcJvjDJLl/m/vfbpJpruJ2tv0L0CfL4c6brN5De9vzAQ47mC+bLKgmF2ozcfSf5JLKP/X+jvgVAxU03wgsXC+yGVLUZm7YzlYb5JeGqHeAe+PEbjkCn47wtu2fPJXNT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748011700; c=relaxed/simple;
	bh=U/DPtAhSxRUSHKCuPN/qlB8/BV8UFN2vQbLacjwKTUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuRD7+0i9FCNR80Dhjp/LzvdrQbgbe2UPZdvhmUsTgBX6hIHUiqMVupSrDhfdh8a+QHoQe7UNYNlCRZzwZog9coiZXQqT/FCPBChO8dWh4bOKrT+qDAbPgBB/aZhqj4JWNahx4oWfFve39YQW3g4PGNtsOTsdDP7gn6lN9C3YjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vQdQ1RoX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rui7bylO1304WkfAB2bQLvabtQVIai2NVBo/GdoR6eE=; b=vQdQ1RoXhaYHKj5zMddG7xCP8k
	2Dj25u5cwsjiJZN5nBt5Enf9eVcbOe7vfW4+VDrUow0b5rrQg2L2nRYSO3Aq722ILgVSYemgmK+lX
	tgppwoXyUtQARQ1CE7iBpPd/oWA08prYIw3KNOP/IKgHeJcq1On1fx1zdid6pbxjcbmWI5Y9J7EcV
	GLcfP5nzBD3V9lsXskZ74+EQPVgVYxuo0vM6dqC5tDs+DWSOJk3VfSGoJwe0/rsmH5+sQ6LIaO62f
	7Trm98t0ul+p4l1bwY4GzZxgB0uj0ofFCd89kZgVbQBeHxAUNP0FrMRAg2kshuWvXu+jUHA6BDEVG
	+DV4MFjg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uITh2-000000048gS-1zXZ;
	Fri, 23 May 2025 14:48:16 +0000
Date: Fri, 23 May 2025 07:48:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Daisuke Matsuda <dskmtsd@gmail.com>
Cc: linux-rdma@vger.kernel.org, linux-mm@kvack.org, leon@kernel.org,
	jgg@ziepe.ca, akpm@linux-foundation.org, jglisse@redhat.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	zyjzyj2000@gmail.com
Subject: Re: [PATCH] mm/hmm: Allow hmm_dma_map_alloc() to tolerate NULL device
Message-ID: <aDCKsK2-zRkqge64@infradead.org>
References: <20250523143537.10362-1-dskmtsd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523143537.10362-1-dskmtsd@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, May 23, 2025 at 02:35:37PM +0000, Daisuke Matsuda wrote:
> Some drivers (such as rxe) may legitimately call hmm_dma_map_alloc() with a
> NULL device pointer,

No, they may not.  If something has no device with physical DMA
capabilities, it has not business calling into it.


