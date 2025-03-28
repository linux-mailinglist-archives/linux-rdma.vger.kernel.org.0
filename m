Return-Path: <linux-rdma+bounces-9026-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A95CCA74C46
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Mar 2025 15:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A3193AB488
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Mar 2025 14:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E661B4259;
	Fri, 28 Mar 2025 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LzJ9hYAu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C8F1AA1D2
	for <linux-rdma@vger.kernel.org>; Fri, 28 Mar 2025 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743171531; cv=none; b=NlrYufYwW5OlxwnxBk1J2R5TWKOUoq/z2T7Yj9hn43NS5Aakls2mF14e9plxV6Bo8FKpA4W1/nJlY1mks2ma+OG5mRRV14gAg5m1v3DmAfmxEcLFbZoxRmrdCjeHIe3K3qsIYYdXta1P2hDKCt4ey7/qgo+K2c0W2ErZ1gN4WEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743171531; c=relaxed/simple;
	bh=aRsjjWJzK8Szt9gdEbaPUx+/TAhrL4HukvLzIArcr1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=pQUoKMJQWVvqAvTBl7ZriVJA5DLkFMHkSNpCCErXC2mXYbJSVwNKwM4uO1gulshmsrXNcu5jHxlJ3ESIuL+oKP9Ma2qs6jX97yYEDtTpJfFhDPzTjjUpUbLLTsy2CAdtEcFW1ylWxSm6KuUrScpY29U0W37EWDbdupcx9wBlGko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=LzJ9hYAu; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250328141842euoutp0233eeb53b7f868cbfb04f8b23ba0e88f8~w-UOIhSFs2837928379euoutp02C
	for <linux-rdma@vger.kernel.org>; Fri, 28 Mar 2025 14:18:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250328141842euoutp0233eeb53b7f868cbfb04f8b23ba0e88f8~w-UOIhSFs2837928379euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1743171522;
	bh=lO48Yx1dRxN6L1ypDuwiGhfZgN4Rzqi6MuK49Ng7t8Q=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=LzJ9hYAuVORDdpPDNoaAsSxqQPvxAGN70JzbeWTmHFXBBQgApzHABzlGOwL7v/NTq
	 Bt8Py3MY06YHzpCwrOOD4l40Zl0MQ/FF8ERl5yImACnQCUZssD16PAHT56NCF007wz
	 90uDi0LLMtuZPUD23/QJMqJdaUkIsTHwBiJmT6tk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250328141841eucas1p1619292970847f923dcfe86bb5c47ab46~w-UNvtGSP2939129391eucas1p1d;
	Fri, 28 Mar 2025 14:18:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id C6.C6.20821.1CFA6E76; Fri, 28
	Mar 2025 14:18:41 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250328141841eucas1p246ea46aed1be0fbf2d32f4681bff0ebf~w-UNT_XZY0412104121eucas1p2i;
	Fri, 28 Mar 2025 14:18:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250328141841eusmtrp2242bde5cbf852d9b3900ec6a0b0bf6da~w-UNS7Wbt0154501545eusmtrp2_;
	Fri, 28 Mar 2025 14:18:41 +0000 (GMT)
X-AuditID: cbfec7f2-b11c470000005155-8c-67e6afc17b98
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id A7.C7.19920.1CFA6E76; Fri, 28
	Mar 2025 14:18:41 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250328141839eusmtip22afc9ba3e6f88769393f971c378bbae1~w-ULzCb-Z1176711767eusmtip2M;
	Fri, 28 Mar 2025 14:18:39 +0000 (GMT)
Message-ID: <c916a21e-2d95-476d-9895-4d91873fc5d5@samsung.com>
Date: Fri, 28 Mar 2025 15:18:39 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/17] Provide a new two step DMA mapping API
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Sagi Grimberg
	<sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, Yishai Hadas
	<yishaih@nvidia.com>, Shameer Kolothum
	<shameerali.kolothum.thodi@huawei.com>, Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, Randy
	Dunlap <rdunlap@infradead.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250322004130.GS126678@ziepe.ca>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0xTVxzuaW/vvTS2uxYmR6cjqWEPl7Uj2eMsoLJA3DViHHu4jOhYM+8K
	4aUtdUyTiQRhFiYVZYUWC4yCCAQEZlGUjVZmyxigAzbpamFZqQg0rMg2pWaM9uLGf9/5Hr/v
	/E4OyRNfwjeQqZnZjDJTni7BBZj5xsOhFy2tHsVLDyakqLK1GUd/LRXjqOlOCY5MeSnI3VMI
	0IWm77locQGhinI7QAbdFBedNFwkUKn1Z4DqvJcIVFl2CJ1drOOhbscLqKbAhKHhrkocuZqX
	+KiqfpJAA0YbjjzWLzFkOrGMvE4dhix/uPmoZWYOQ52jeXyU73wF1ZcJYjfSbouRSzcbmwHt
	GfUAurpdTQ+52jA6v9fLpzsattC11+5x6eEBNd3eeBKn2+dLCdpe7sfoDtMxeqqjAtBXx3Jx
	uvbUGf5bYUmCmANMeuphRinb9pEgxVVTzz9oF+cUjw2BXFAl0oAQElIvQ1/hKE8DBKSYagDw
	xm0bPyCIqQUA68oBK9wHUOe/Ax4nbk3cwljTeQAnF5JZkw9AX4WTCAhCahtsah4KTsKoSDhd
	6uCx/FrYV+EOhp+kIuC4ozzoD6XiYY/5dNATRkngt12nicBQHmUmoH7Kxw0IPCocOtxVQYxT
	UVDj1eABHELJoLHfxWc9EbDTWxncB1LdAjhWNsJnrx0PB4w/rKwQCqdt3xAs3giXrgSGBgKF
	AFb7x1cOWgBz7zpWEtHQObi4XEcuVzwPW7tkLP0GvPnnb0SAhpQI3vauZS8hgqVmHY+lhfCL
	AjHrfgbqbS3/1Vpu/sTTAol+1bvoV62pX7WO/v/eaoA1gnBGrcpQMKqoTOZTqUqeoVJnKqQf
	Z2W0g+Wf3f+Pbf4yODftk1oBlwRWAEmeJEy4fsStEAsPyD87wiizkpXqdEZlBU+RmCRc+PV3
	JxRiSiHPZtIY5iCjfKxyyZANudwd+2y1u+b6x/UciSlyZnechJIl1vSqZt3xYW+WvL6Gsz02
	YSH577vX7Rfn9xr2J3I+3AOjYyzJO1skv86F9l0w+jBfQbT/uPZHTsMnxLqxWUPao63D+4jo
	Pp9j73ZTI6mNsHlEZnlqvPq+9omchznvlnNadr+2xmI/luY8/JyhbZ1+fCDhF//+9WrzB73Z
	5DWdKi7JOfn5SIzrq9B3PC5r0YBXTt/Lcm4KGQlXOaHm2d8TwvqV08pXW+OSrh6dLYrdLNqE
	Py051/P+2WzDoevwvYnJK/NHyrr37Kiwt5XUDmYZNw++/WDnrqPFx21bTxX10ImyzsjzUzmX
	DdKZR/lTeRJMlSKP2sJTquT/AioQlFtIBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsVy+t/xe7oH1z9LN5hxkc9izvo1bBbf/vew
	Way+289msaQpw+LJgXZGi5WrjzJZ/PpiYTFzxglGi9nTXzBZdM7ewG4x6dA1Roulb7eyW8yZ
	Wmgx5ddSZou9t7QtFrYtYbG4vGsOm8W9Nf9ZLeYve8pucXbecTaLZ4d6WSyWtAJZb+9MZ7E4
	+OEJq8W61+9ZLLZfbWK1aLljarFsKpeDjMeTg/OYPNbMW8Po8ezqM0aPBZtKPc7f28ji0XLk
	LavH5hVaHov3vGTyuHy21GPTqk42j02fJrF7nJjxm8Vj85J6jxebZzJ67L7ZwOaxuG8ya4BI
	lJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7GvYXL
	WAtOCFX03DzP2MA4n6+LkZNDQsBE4uKDiyxdjFwcQgJLGSVamtqZIBIyEienNbBC2MISf651
	sUEUvWeUOHNsGSNIglfATmL1mvNgRSwCqhKvJt1ihogLSpyc+YQFxBYVkJe4f2sGO4gtLOAi
	cWDbRLAaEQEliX27JrKDDGUW2MEucXHXcSaIDc+ZJf52HwLrYBYQl7j1ZD7YSWwChhJdb0HO
	4OTgFNCXmHf6HitEjZlE19YuRghbXmL72znMExiFZiE5ZBaSUbOQtMxC0rKAkWUVo0hqaXFu
	em6xoV5xYm5xaV66XnJ+7iZGYJraduzn5h2M81591DvEyMTBeIhRgoNZSYRX8sqTdCHelMTK
	qtSi/Pii0pzU4kOMpsDQmMgsJZqcD0yUeSXxhmYGpoYmZpYGppZmxkrivG6Xz6cJCaQnlqRm
	p6YWpBbB9DFxcEo1MFldaJWPjrp8esKyTQs39a9UPna0699GGZvqxVrZ/Os/tK/rO79/ab2J
	le6Uzt+/AhhsVefceLSfwc2YK/L/qhsbJhX5r/apvuecIXGXNVfrpphdj+vqWS9UbEVy4h+d
	3tdz9A5zYfifi62yU6vfK7judn5w0HxL9cmj999GxvsVFSzI1Y3945SdYOV8c+HLvHPfmoML
	ub/+mO0treTxo55p5XXxsB2/whqjhP+eLsgL2tcUedx3oU79lK4bbzka1PjS7TU9NfVnBPuY
	TZ4n86Bp4enTZSr/Zq7ScXQ4yWjM6u63uHD9G/HCo4t4nQ7yRjFMZ4yT26/+vLKep6HxZe73
	Nk0v3w9bvGdOc/mrpcRSnJFoqMVcVJwIAGW+P3ncAwAA
X-CMS-MailID: 20250328141841eucas1p246ea46aed1be0fbf2d32f4681bff0ebf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250228195423eucas1p221736d964e9aeb1b055d3ee93a4d2648
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250228195423eucas1p221736d964e9aeb1b055d3ee93a4d2648
References: <cover.1738765879.git.leonro@nvidia.com>
	<20250220124827.GR53094@unreal>
	<CGME20250228195423eucas1p221736d964e9aeb1b055d3ee93a4d2648@eucas1p2.samsung.com>
	<1166a5f5-23cc-4cce-ba40-5e10ad2606de@arm.com>
	<d408b1c7-eabf-4a1e-861c-b2ddf8bf9f0e@samsung.com>
	<20250312193249.GI1322339@unreal>
	<adb63b87-d8f2-4ae6-90c4-125bde41dc29@samsung.com>
	<20250319175840.GG10600@ziepe.ca>
	<1034b694-2b25-4649-a004-19e601061b90@samsung.com>
	<20250322004130.GS126678@ziepe.ca>

On 22.03.2025 01:41, Jason Gunthorpe wrote:
> On Fri, Mar 21, 2025 at 12:52:30AM +0100, Marek Szyprowski wrote:
>>> Christoph's vision was to make a performance DMA API path that could
>>> be used to implement any scatterlist-like data structure very
>>> efficiently without having to teach the DMA API about all sorts of
>>> scatterlist-like things.
>> Thanks for explaining one more motivation behind this patchset!
> Sure, no problem.
>
> To close the loop on the bigger picture here..
>
> When you put the parts together:
>
>   1) dma_map_sg is the only API that is both performant and fully
>      functional
>
>   2) scatterlist is a horrible leaky design and badly misued all over
>      the place. When Logan added SG_DMA_BUS_ADDRESS it became quite
>      clear that any significant changes to scatterlist are infeasible,
>      or at least we'd break a huge number of untestable legacy drivers
>      in the process.
>
>   3) We really want to do full featured performance DMA *without* a
>      struct page. This requires changing scatterlist, inventing a new
>      scatterlist v2 and DMA map for it, or this idea here of a flexible
>      lower level DMA API entry point.
>
>      Matthew has been talking about struct-pageless for a long time now
>      from the block/mm direction using folio & memdesc and this is
>      meeting his work from the other end of the stack by starting to
>      build a way to do DMA on future struct pageless things. This is
>      going to be huge multi-year project but small parts like this need
>      to be solved and agreed to make progress.

Again, thanks for another summary!

>   4) In the immediate moment we still have problems in VFIO, RDMA, and
>      DRM managing P2P transfers because dma_map_resource/page() don't
>      properly work, and we don't have struct pages to use
>      dma_map_sg(). Hacks around the DMA API have been in the kernel for
>      a long time now, we want to see a properly architected solution.

What kind of a fix is needed to dma_map_resource()/dma_unmap_resource() 
API to make it usable with P2P DMA? It looks that this API is closest to 
the mentioned dma_map_phys() and has little clients, so potentially 
changing the function signature should be quite easy.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


