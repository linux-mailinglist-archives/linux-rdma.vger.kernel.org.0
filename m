Return-Path: <linux-rdma+bounces-12309-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445EBB0A687
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jul 2025 16:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29E0E16E1CB
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jul 2025 14:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF7A86352;
	Fri, 18 Jul 2025 14:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pPPMGymw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF712DCF63
	for <linux-rdma@vger.kernel.org>; Fri, 18 Jul 2025 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752849886; cv=none; b=WJ3JtmRwv/8ocWGbkqngMjrt3QuMH6GSv3FeG0tdtryD10srElMkneXVAPsdnQxK0q8sj/o2VFF/RcBd9fXoLc09vTxDyCXjLvYsmFWd41NWl9Ya7F8iKSDHCnDe92MD7E84YxV/AdjXtWdgeERYcqBssAmNw4r8mYl04cdax+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752849886; c=relaxed/simple;
	bh=57t08D0XBLsuBYTQTILMObpKWZEYbrXmLfmK6g9BlPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEQoO2G817Jqofo/ys5C/YqMKinIEvEqHcB07lcgaDw21l30c64C4DiWdiCC8bvgoag/wLs/StDImW7smu9LiqX4NHiLBWfyqItzMkCfcbbx2AwKGCXea2cZPkE33CiYMRU0AYFRHfnsYe3h7bg3X8J6J+lOLWCHTVzodldqq8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pPPMGymw; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ab61ecc1e8so16374881cf.1
        for <linux-rdma@vger.kernel.org>; Fri, 18 Jul 2025 07:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1752849884; x=1753454684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/JlY6wrS7xoiZAd1n9VylKL/5klHKuhmeV2q/x+jhjE=;
        b=pPPMGymwc8e4r7k4uixWz7VYtNrmEiCVnyG+fczy3nEPwPa/qOXlkLt1SNpG94Gjw4
         GGRWX426hSxyxk7uP/DtWeLq0YBRuh+poB84TDeqcJp6JNFIxfjkTuUNIPsobxuBEIzy
         3EG/5cxeXjT+xQyrNgXDpn2oczMq7CfP37DF/bHViZXVSEsaSjAwQPmvDLaPUr2N+xsi
         eIHgsBzfm7MpIas9e2ZlIUKXkOIRL1O0X+k5EehkQSlKSVN4KBJJc6X00/aSDWoivsvV
         /mGt5nGl8fH+jCLJ7dCBt+06AuVwFXJ4Y87uYG1VuhNRuqHZLVWOOGXxQEeyFLwHZB/c
         hCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752849884; x=1753454684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JlY6wrS7xoiZAd1n9VylKL/5klHKuhmeV2q/x+jhjE=;
        b=Wb7vxAt6bd7lU8zzTMghZW9h4aJJI0zQNBreGVErpdqJ1E7DOiN96GeBfpNzmW0wnh
         UdcsQdz4GTBwBlKxMy4q6XalgfKB9XmmPkR2h7teNhF/HaNkGBVXFE9SV5phgbm8dnh5
         R/Pg072t57Uwa7defiiKmCYqNVGaq8Y0qaIHbLYkh4uZN3FIwbqDRds7DEvLB/qQp9XM
         igPfB4lzji6O9N1jwqrWRwnig6xmGJauaFOv1GXgfvqBv0CIiQqYjycInuEd0ZQdRpFt
         /hhrQ3CcgMTJNluKGnEM1mLGG0aPRiMXhejnlFZlwqKaTjkxdX0uyk4Gs97QObaVE29A
         7xGA==
X-Forwarded-Encrypted: i=1; AJvYcCWWcgg716d2UYfXFYFD75Qb04uCgg9Hjxs5o/KJhxizmdTJrkoYVaqGmcPVMqawUPvhr+td1EXEUDgP@vger.kernel.org
X-Gm-Message-State: AOJu0Yx39jVO+P7GXdIO4IDeuVPOuEusiZpXWfdP+ejbFOytBtAIorSM
	VOSEZErNzmF9ULowmgMpmmioip6QiIvMQniG2a5/2qe0QHDORU4SFkvPHrMqFTsb2lE=
X-Gm-Gg: ASbGncv30NJ5LCapRwVxJG3ChK7HFHm0LQeRRHMJMyExi9VReIJSS3CDFukYLqqOOmq
	f2MTegXX6AoIdaGVDqdL5LZJKmUo+1+WjdRpCV/sheGmcr0CBwdxartD7srBNXDlUCTQ543+BJt
	9SFul5kbZaRDTzaPf0zSLrIS/CJ/f+YjeazgcL9Z7HN9BWOFwiYCgSOW0a5AHMHRxyYlyyohj1f
	P16DJNEHjGvR+AjQe93glO0D0gtpNycTwo7mzVHmEEvgIEz862fTl7dYWZUNZVd8q8bumNKCPwW
	k1Ep3a9L9bq9Ed0X7+QqNBZ8Fy2nFjqMpQ0VGLIV5t8C+PRbqiL5nfCuVDpf9prxJYQUvEuArVk
	jMX3RLtTOmuDKUOXCghf6mh7hALjbv1Fv/up+8HpZ2GbdW1Hd+AZXyiJ1/YW1jDTfGKbvwfjYJF
	B/qeLwfDnE
X-Google-Smtp-Source: AGHT+IEYd5qGIZ9KDhfEstxE616f9xXLY8QoZsrjUpURE5IRjE2GiKRGVckhayOKGta9pjoTuDB7PQ==
X-Received: by 2002:a05:622a:1448:b0:4a9:cff3:68a2 with SMTP id d75a77b69052e-4ab93d88915mr157868681cf.37.1752849883674;
        Fri, 18 Jul 2025 07:44:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051b8c04fdsm8211446d6.15.2025.07.18.07.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 07:44:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ucmKI-00000009zcK-2UVK;
	Fri, 18 Jul 2025 11:44:42 -0300
Date: Fri, 18 Jul 2025 11:44:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Matthew Wilcox <willy@infradead.org>
Cc: Yonatan Maman <ymaman@nvidia.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Leon Romanovsky <leon@kernel.org>, Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Alistair Popple <apopple@nvidia.com>,
	Ben Skeggs <bskeggs@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Daisuke Matsuda <dskmtsd@gmail.com>, Shay Drory <shayd@nvidia.com>,
	linux-mm@kvack.org, linux-rdma@vger.kernel.org,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Gal Shalom <GalShalom@nvidia.com>
Subject: Re: [PATCH v2 1/5] mm/hmm: HMM API to enable P2P DMA for device
 private pages
Message-ID: <20250718144442.GG2206214@ziepe.ca>
References: <20250718115112.3881129-1-ymaman@nvidia.com>
 <20250718115112.3881129-2-ymaman@nvidia.com>
 <aHpXXKTaqp8FUhmq@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHpXXKTaqp8FUhmq@casper.infradead.org>

On Fri, Jul 18, 2025 at 03:17:00PM +0100, Matthew Wilcox wrote:
> On Fri, Jul 18, 2025 at 02:51:08PM +0300, Yonatan Maman wrote:
> > +++ b/include/linux/memremap.h
> > @@ -89,6 +89,14 @@ struct dev_pagemap_ops {
> >  	 */
> >  	vm_fault_t (*migrate_to_ram)(struct vm_fault *vmf);
> >  
> > +	/*
> > +	 * Used for private (un-addressable) device memory only. Return a
> > +	 * corresponding PFN for a page that can be mapped to device
> > +	 * (e.g using dma_map_page)
> > +	 */
> > +	int (*get_dma_pfn_for_device)(struct page *private_page,
> > +				      unsigned long *dma_pfn);
> 
> This makes no sense.  If a page is addressable then it has a PFN.
> If a page is not addressable then it doesn't have a PFN.

The DEVICE_PRIVATE pages have a PFN, but it is not usable for
anything.

This is effectively converting from a DEVICE_PRIVATE page to an actual
DMA'able address of some kind. The DEVICE_PRIVATE is just a non-usable
proxy, like a swap entry, for where the real data is sitting.

Jason


