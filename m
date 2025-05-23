Return-Path: <linux-rdma+bounces-10626-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD18AC26A0
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 17:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 581A11BA6766
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 15:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EB6293B67;
	Fri, 23 May 2025 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EhZXxL0G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E3D14286;
	Fri, 23 May 2025 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748014964; cv=none; b=N5FlSlgZSs5XEBOudD55UHz/BpCwqRgUGyXVT/fAXWR2mP4HsENJbhW2yJaPzxu+Lg7K8us1vu9G6H6l8AcWsVj93DZrGkHSW+6PnsN8AAiy8F8/evqYzq9OAtnpo4TUPe+oEM7Wkp5doTQsJEpecGE93tlTzBs+Nh8zUf12pB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748014964; c=relaxed/simple;
	bh=KVwP6ZaTXIHoBZVmEEJrV8NQeE4NX4pX/91S5eZzI1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYBsZMBw83ntgkFtFCgB7qwE2KzcWz1pu9HnSTZUTiOwIcgeeFKZooh0nn6O5o0dMLvYEeN0U2jiSB+/zkxrsTqGzfhZjT3+2kKoSjmmoB1lg3nHIvfzQ/PJxUy4jxAYWa7xr1MgHo4uOgVviuSAnWb0Jsgpv7ejGZAqi+rpVhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EhZXxL0G; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cWvExEmX2CXey0nsq/xA9W7LqAPoEJF71YAIT7PxRDc=; b=EhZXxL0GrKtd3iSJ+wPvrbA+m5
	PpjOO7lePi0JrCwZhX78wxsMvPt/LHuIREgspeBc5Qc+DXhrkEbkGpNvTwrh7u8pb1D8K8sJWiKZX
	OBfQXsavrfpWm3ai2iDsAgzOyzdrxcD2WtwhZG8tI/hplK+t/jUVOzTfi/Z2P/R0zTe8fyg5BDkJc
	SPYu1BIBZA0GuQ+/BjZL/J2Z25LiMrKmF493AnlgWmT1aWoNbSD1orK84KSwGUKX5COCj9/LMW8rr
	cKfL6Kc9kL+0kdRXh4qZHOP5blhDmaFRfwb2EM1j1+Efq0XX5EwCzivzAJ7UyJN/4U2m3zNSnO2nf
	QzX76JNg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIUXh-00000004HKU-1vig;
	Fri, 23 May 2025 15:42:41 +0000
Date: Fri, 23 May 2025 08:42:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Daisuke Matsuda <dskmtsd@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-rdma@vger.kernel.org,
	linux-mm@kvack.org, leon@kernel.org, jgg@ziepe.ca,
	akpm@linux-foundation.org, jglisse@redhat.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	zyjzyj2000@gmail.com
Subject: Re: [PATCH] mm/hmm: Allow hmm_dma_map_alloc() to tolerate NULL device
Message-ID: <aDCXcbKwTdG3w5ZW@infradead.org>
References: <20250523143537.10362-1-dskmtsd@gmail.com>
 <aDCKsK2-zRkqge64@infradead.org>
 <63702a66-4cc6-4562-89f4-857fe3f044e8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63702a66-4cc6-4562-89f4-857fe3f044e8@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Thank you very much, but I know rxe very well.  And given your apparent
knowledge of the rdma subsystem you should also know pretty well that
it does not otherwise call into the dma mapping core for virtual devices
because calling into the dma mapping code is not valid for the virtual
devices.

Please fix the rdma core to not call into the hmm dma mapping helpers
for the ib_uses_virt_dma() case.


