Return-Path: <linux-rdma+bounces-12353-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAA7B0BD0A
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 08:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B671761AD
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 06:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35E927FD54;
	Mon, 21 Jul 2025 06:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2Slrllw8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8FA19924D;
	Mon, 21 Jul 2025 06:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753080899; cv=none; b=FgDP7FoPrt7yPAJUSdWRp886Sd8jv1IXn1DkjY3WSdznPgNIKKWK8eJxuZFpU5yiVwRaozfqbwbrMA6JhR9qA6CCWNu9qFDUSirBp20wpqp/A4O/EggR+UQyGHZ3Ot/qcKDQfTr75QkN83xLw9eVuvKl0HaQtSIq1QBBNKntFZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753080899; c=relaxed/simple;
	bh=NGqcCf7cNZII9mAVD9ujBwqeeDMSf0fMAAcXfxzox/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqckG/ZRGE8RlbdAsUv7tbS+vtBCuXdoKQd58McyB/HQz4zLdjIRl7l3jMalUCBuz19DTlCL1xma687Q91jm2dcU4jBAoiZNeobVJpnj3XESPxsey8uBJyDp0t5lDHSbxgqgZciDFOUXMZbRjGSSD3zUwpGepAC955YnDaad/ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2Slrllw8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=b8hAqmUWcLCER3Gxp9ORr+fqqobyAf1tNV1G2vwl6ZI=; b=2Slrllw8E3hjuZHrS409Tn5B32
	U0oxGQ34aTw+BAFe3HvE9yyisKSW+fvg1mi33jgyxDjwYQtPKcCSqxM7vbafFJyk+tEcdufErFl5d
	3/RST1IYHZwVJXvuJyHpVWW5qCed3C0yUhbl/loTSYG+ZHvuKvAT9ssa5bq+p1YdPBKvcC1eyDBBI
	vCJuDMu5QKlXUUnaYkt7ruApHnzUd54JQYgLSA+Gq2Gtj7QrksUig9LcyicNjLErG9UH2K3D7aOIH
	MicXk93nCe8KwYiFSKfHyEFCc//m8iVId8UzftV+xnVtV4P8bwY5p0YhueVGaN3RsUAwtvqG4blBD
	0jsF0jNA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udkQI-0000000GQzM-2EiH;
	Mon, 21 Jul 2025 06:54:54 +0000
Date: Sun, 20 Jul 2025 23:54:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yonatan Maman <ymaman@nvidia.com>
Cc: =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Alistair Popple <apopple@nvidia.com>,
	Ben Skeggs <bskeggs@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Daisuke Matsuda <dskmtsd@gmail.com>, Shay Drory <shayd@nvidia.com>,
	linux-mm@kvack.org, linux-rdma@vger.kernel.org,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] *** GPU Direct RDMA (P2P DMA) for Device Private
 Pages ***
Message-ID: <aH3kPrkZaaO9_esO@infradead.org>
References: <20250718115112.3881129-1-ymaman@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718115112.3881129-1-ymaman@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Please use a more suitable name for your series.  There's absolutle
nothing GPU-specific here, and reusing the name from a complete
trainwreck that your company pushed over the last few years doesn't
help either.


