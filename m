Return-Path: <linux-rdma+bounces-9759-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C61A99805
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 20:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49FD54A365F
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 18:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95F028EA70;
	Wed, 23 Apr 2025 18:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OKUWjwQ3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D9427F756
	for <linux-rdma@vger.kernel.org>; Wed, 23 Apr 2025 18:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745433454; cv=none; b=H6/P73rYkWGU/Z9PJM8H7hqUpUqHb2+GAutxXLuAvqr4uLATlhUmmMqFPerj7FyxPaFbMpIMsP2ub+jysH3RuXOn1fr1gIAnkg4yKrjinwZavYBGmQBGdkoPO6Rxol4MpiroBed2d+5pAfAPbYf0IVeQnkHO3FvP8dlUvRhBHRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745433454; c=relaxed/simple;
	bh=gh76Cwi537UAiZiZzvQ7qO7K4eMJvXZ5GcYqQsv4qVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZ57ZW7QzCJ/50sOIoFKQ1VYTf4jyraYqKGcueVgL5M0qfZB+sWb/vzRgN6V8RPHl4Oh3zpsIa3Vis5bmhJcYxNzQ3gqnR5esXHUfUzYzfDamWT2AS6fL8Zt9YcxW4bY4I9zCCJYmueLqRM4qr7a4xtfJHTKc4mM65nrN1oHp1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OKUWjwQ3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745433450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y6pwEnRnhkHgazDgVxPbcQpa5mERaCMyYK1dziw6UIo=;
	b=OKUWjwQ33Y3CEfmRTPWjnwt/Yv203NbMviwGsEIX5vlv3km9tJAPGMUScqJkZoTfWyi0A6
	5C7qCbb6z2B+SlphsXI9N8SnmX2CEnsvo3VybIrBdBIt1mrUEnp5/dejjff+fsoniQPaLa
	WB5ZI4VXF9/XN+dqbo0XFtw/ZFCT4Ns=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-EPTE9lVyMGy1djYfZwagSQ-1; Wed, 23 Apr 2025 14:37:28 -0400
X-MC-Unique: EPTE9lVyMGy1djYfZwagSQ-1
X-Mimecast-MFC-AGG-ID: EPTE9lVyMGy1djYfZwagSQ_1745433447
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-30bfaec88edso5898291fa.1
        for <linux-rdma@vger.kernel.org>; Wed, 23 Apr 2025 11:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745433447; x=1746038247;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6pwEnRnhkHgazDgVxPbcQpa5mERaCMyYK1dziw6UIo=;
        b=MdHykIYUW0XuoqDioQFj55+8Az4W/WGj97llTm7SRfywGu+ba509AzhcwwgI/cHnK+
         kHKKOTIsCIcCgQtOO5gEO/d7ACubCKGLcT2o94IXvGFuexsLDUU9sjFHcm/WE/DOC4qg
         qux2EGAJT7a6y59ZBR6YhCgRTJz0Jq4x3errOqdAC/CLucNoN9UUNjTpUoUE0PrPYkxG
         xBpsIxRDN+ZabP2/dkJgi/VJiuwBwLqTc5Bs430IAZjUMFTyS/HxnEdS/QmQtzgBqkkE
         zzo0CniMGMBRtsM5KaRJ/7Loa3dFJkVYdu4/3PrPFkNyhRU6D6f7Ej2XFOJ2BTD/9UbU
         p0Yg==
X-Forwarded-Encrypted: i=1; AJvYcCVuqm78Ra6zMuQ/4YR31+01V32S2FPvkc4T8tlSPiIwDYVHQr+Laz+/q/ESPU4dCUS0s9dBFRihus5+@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz2zhBFBiHHPyrhopRjxu0b+BPYm37qu0JmYj9CFqCdQ8bOORK
	EFMoF7ADCsXbT/dacKUI084yPWYBUiRA+Fm1GeZqecpU/i/7Ke0uIhAddhc/EDymtnVpzrj27JI
	3e/XIaPmF7uSeEUjTr6Q7ccz0gLmhqac/ys6eRKVDNA9TUvqnYCwA5/KS0A==
X-Gm-Gg: ASbGncspFmx7TCIJaYoKixXI9amenJUd3twRYKOtSZWp8f5OsjtGREo2uwJOjL4Vdhg
	nE+yPbCSNV3U6fZRaNMZY/gsJxv6/UQr+cQMV5PlfAfCi4HxxV3iVZAL5NDzgEGAdsBVWaA7m8x
	Lru97pf1lEoygSA4vlokgyX5ewlg+8Rrm6W9Axejm9EVs9lgtP8C03LJVZLENXwk5FHblT4DSs3
	xm+M+K40Vg6HnLXzHW8KaICg/i4ezwJpuBir63BIbp581dRQlqpuYJZ7PrZmbi1FwI3FOZbK8ON
	p4GG4Km06MwM3U4anTb1xvUlk6qhU3n65l0uBA==
X-Received: by 2002:a2e:8818:0:b0:308:e956:66e with SMTP id 38308e7fff4ca-3179449456amr499851fa.0.1745433446929;
        Wed, 23 Apr 2025 11:37:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeLX03zhP8nSlFHqNWBiKFBjf3MShxZQb8tc2EeW+8vLK6+b+87nnEoR+0vFre3XFcDl9w4g==
X-Received: by 2002:a2e:8818:0:b0:308:e956:66e with SMTP id 38308e7fff4ca-3179449456amr499761fa.0.1745433446435;
        Wed, 23 Apr 2025 11:37:26 -0700 (PDT)
Received: from [192.168.1.86] (85-23-48-6.bb.dnainternet.fi. [85.23.48.6])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3109075e8e9sm19833701fa.12.2025.04.23.11.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 11:37:26 -0700 (PDT)
Message-ID: <36891b0e-d5fa-4cf8-a181-599a20af1da3@redhat.com>
Date: Wed, 23 Apr 2025 21:37:24 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/24] mm/hmm: let users to tag specific PFN with DMA
 mapped bit
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Leon Romanovsky <leonro@nvidia.com>, Jake Edge <jake@lwn.net>,
 Jonathan Corbet <corbet@lwn.net>, Zhu Yanjun <zyjzyj2000@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
 kvm@vger.kernel.org, linux-mm@kvack.org,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Chuck Lever <chuck.lever@oracle.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Dan Williams
 <dan.j.williams@intel.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <cover.1745394536.git.leon@kernel.org>
 <0a7c1e06269eee12ff8912fe0da4b7692081fcde.1745394536.git.leon@kernel.org>
 <7185c055-fc9e-4510-a9bf-6245673f2f92@redhat.com>
 <20250423181706.GT1213339@ziepe.ca>
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <20250423181706.GT1213339@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/23/25 21:17, Jason Gunthorpe wrote:
> On Wed, Apr 23, 2025 at 08:54:05PM +0300, Mika Penttilä wrote:
>>> @@ -36,6 +38,13 @@ enum hmm_pfn_flags {
>>>  	HMM_PFN_VALID = 1UL << (BITS_PER_LONG - 1),
>>>  	HMM_PFN_WRITE = 1UL << (BITS_PER_LONG - 2),
>>>  	HMM_PFN_ERROR = 1UL << (BITS_PER_LONG - 3),
>>> +
>>> +	/*
>>> +	 * Sticky flags, carried from input to output,
>>> +	 * don't forget to update HMM_PFN_INOUT_FLAGS
>>> +	 */
>>> +	HMM_PFN_DMA_MAPPED = 1UL << (BITS_PER_LONG - 7),
>>> +
>> How is this playing together with the mapped order usage?
> Order shift starts at bit 8, DMA_MAPPED is at bit 7

hmm bits are the high bits, and order is 5 bits starting from
(BITS_PER_LONG - 8)


> The pfn array is linear and simply indexed. The order is intended for
> page table like HW to be able to build larger entries from the hmm
> data without having to scan for contiguity.
>
> Even if order is present the entry is still replicated across all the
> pfns that are inside the order.
>
> At least this series should replicate the dma_mapped flag as well as
> it doesn't pay attention to order.
>
> I suspect a page table implementation may need to make some small
> changes. Indeed with guarenteed contiguous IOVA there may be a
> significant optimization available to have the HW page table cover all
> the contiguous present pages in the iommu, which would be a higher
> order than the pages themselves. However this would require being able
> to punch non-present holes into contiguous mappings...
>
> Jason
>
--Mika



