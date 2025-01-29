Return-Path: <linux-rdma+bounces-7307-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FE0A21DF3
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jan 2025 14:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5F23A60F7
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jan 2025 13:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD3A133987;
	Wed, 29 Jan 2025 13:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="LRbXARLx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769831BC20
	for <linux-rdma@vger.kernel.org>; Wed, 29 Jan 2025 13:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738157946; cv=none; b=JJ/S+9tdsehiI7n+Gm7viAP2b39Ueh7AbzAdY0w1phFjrUc285ms/8GHQ+TaBuOsyK12o4MP9jLKNfKi+oeM/dhZN/rwusrgHoOQaWBUq2IYw5/pAWzbIz8eT/bAxQi/wa9li7K/st3t1HCTM0mz59qDV5cJlDlmMRKF33ay5TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738157946; c=relaxed/simple;
	bh=RxH/qA/BgpYkjBVmBtOP+Wt33+Id7p5IBZ1sJh+PVe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkVYKm47AvBuh7Wn4Uw0iy4RsnZfAAvB79pYaJxf8+6+QchZWwBKPMSjn4R7QhaNVhg85kSuoXzkNIU9yhF6rn3yxuKVocw+G53+HfaoWCh87W3L1jI6WRXee/EGqh0rdwAG0RIdcLXbweEdw2cfIuZ5bU8mAL7A9gmrN1kH0W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=LRbXARLx; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-436281c8a38so48720385e9.3
        for <linux-rdma@vger.kernel.org>; Wed, 29 Jan 2025 05:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1738157942; x=1738762742; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ekPyuSS82CPNI1Lh/E6IsIbzoEEGT2LSw6fRdzUam+8=;
        b=LRbXARLxcVlSVLOIW9nPwxiGleXpTsHVUK1xrS0UwYak72R+r5JA7lmqK8UxnnQHw+
         hjfkoSJN3yj16qLBqvfCG4JqRqP92QoaOZ3ZY+1vjEGDAPpILcv+DlIlstdU29B49j00
         9/MvPxpeF0nk8EcLadAsFREGfVtX/6b+FsBDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738157942; x=1738762742;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ekPyuSS82CPNI1Lh/E6IsIbzoEEGT2LSw6fRdzUam+8=;
        b=ItgwQKfs5hFHx2NedC2gCGKUdhPwkmYiVUcGQiX7ruEaCgBFHqU/GFncLVW3MYxVL1
         75rhWw2q13DtYGkIGcS3di8vfQRoi7yv2PGNhELAQK9XMq2qLAdM9qDi99LtPs+nCIer
         mV6rw4qKfGxamaDfqUkAyL59wu95P/2U5eM/N+mmrgKgMP9cU5SahLLGYphhkDCpqpKe
         s4Jl+M1Vnj+5+4/8EhVriY6IZ5sltT6/IXn3cy1VxhY62kcHMgBlPEhDGdAUI6pSlI00
         WxlmFNmkPwbvHruBMGCt60aCKiub27B9UnxsgGG9YLxh1Lod5yO4FYOznCJc5dBn95vg
         H8cw==
X-Forwarded-Encrypted: i=1; AJvYcCWVWVfKHAiNbwWggmB0M5aCAziBPWUeMumTI4ppXB5+hByh6iEAbGZZtMMXWla/cB4G1E0mh7jytYtI@vger.kernel.org
X-Gm-Message-State: AOJu0YxiZw5j9vgxkvf+b2VtDatDeTKp/1QAfeEwyFrOUmUQNKJMvP7M
	ips6YTIksDuo/b2NsChmMawK5gYaQDsVcw4B3tDzqGf9nRKqcDYFrb/k6adHL+4=
X-Gm-Gg: ASbGncuo3CAjQ4Pul/h71j4m4eM8fcnewqjE+syeDN9SNqxnsgxr2n9dHvqoSIj6XHc
	JzJminUrbpwIPCDbDIj3Ay81rMJOno7QkZXqNExlaJY5ipMxpwBS3KE+0RMYN42Wc6qH/+78//x
	cpndKhXy+RnLvDHAPNyGSqK5j3fwCqtdnSJsCXJqZX95GD+cJRpBB5N5ZS/Q5HG4nCcNBAWlEdJ
	S7Nj9nov1bhpMtlrsJtuz7hseEKk5vVhr2mSkPPpTBXwD18lT9iurh5AyIvByIQx7yD7d8V36CY
	l0SVreGMONlVJGYb7OVR22plST0=
X-Google-Smtp-Source: AGHT+IFp40yYl/FrcEC18d1HA1Wbr1YBHRju+Twtn7vgv1BIenNhcb0w0RrYUn5K84MH3BCfQBYGmw==
X-Received: by 2002:a05:600c:5486:b0:433:c76d:d57e with SMTP id 5b1f17b1804b1-438dc3a40d3mr30211795e9.5.1738157942387;
        Wed, 29 Jan 2025 05:39:02 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc263f0sm23501465e9.9.2025.01.29.05.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 05:39:01 -0800 (PST)
Date: Wed, 29 Jan 2025 14:38:58 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Yonatan Maman <ymaman@nvidia.com>, kherbst@redhat.com,
	lyude@redhat.com, dakr@redhat.com, airlied@gmail.com,
	simona@ffwll.ch, leon@kernel.org, jglisse@redhat.com,
	akpm@linux-foundation.org, GalShalom@nvidia.com,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-mm@kvack.org, linux-tegra@vger.kernel.org
Subject: Re: [RFC 1/5] mm/hmm: HMM API to enable P2P DMA for device private
 pages
Message-ID: <Z5ovcnX2zVoqdomA@phenom.ffwll.local>
Mail-Followup-To: Jason Gunthorpe <jgg@ziepe.ca>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Yonatan Maman <ymaman@nvidia.com>, kherbst@redhat.com,
	lyude@redhat.com, dakr@redhat.com, airlied@gmail.com,
	simona@ffwll.ch, leon@kernel.org, jglisse@redhat.com,
	akpm@linux-foundation.org, GalShalom@nvidia.com,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-mm@kvack.org, linux-tegra@vger.kernel.org
References: <20241201103659.420677-1-ymaman@nvidia.com>
 <20241201103659.420677-2-ymaman@nvidia.com>
 <7282ac68c47886caa2bc2a2813d41a04adf938e1.camel@linux.intel.com>
 <20250128132034.GA1524382@ziepe.ca>
 <de293a7e9b4c44eab8792b31a4605cc9e93b2bf5.camel@linux.intel.com>
 <20250128151610.GC1524382@ziepe.ca>
 <b78d32e13811ef1fa57b0535749c811f2afb4dcd.camel@linux.intel.com>
 <20250128172123.GD1524382@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250128172123.GD1524382@ziepe.ca>
X-Operating-System: Linux phenom 6.12.11-amd64 

On Tue, Jan 28, 2025 at 01:21:23PM -0400, Jason Gunthorpe wrote:
> On Tue, Jan 28, 2025 at 05:32:23PM +0100, Thomas Hellström wrote:
> > > This series supports three case:
> > > 
> > >  1) pgmap->owner == range->dev_private_owner
> > >     This is "driver private fast interconnect" in this case HMM
> > > should
> > >     immediately return the page. The calling driver understands the
> > >     private parts of the pgmap and computes the private interconnect
> > >     address.
> > > 
> > >     This requires organizing your driver so that all private
> > >     interconnect has the same pgmap->owner.
> > 
> > Yes, although that makes this map static, since pgmap->owner has to be
> > set at pgmap creation time. and we were during initial discussions
> > looking at something dynamic here. However I think we can probably do
> > with a per-driver owner for now and get back if that's not sufficient.
> 
> The pgmap->owner doesn't *have* to fixed, certainly during early boot before
> you hand out any page references it can be changed. I wouldn't be
> surprised if this is useful to some requirements to build up the
> private interconnect topology?

The trouble I'm seeing is device probe and the fundemantal issue that you
never know when you're done. And so if we entirely rely on pgmap->owner to
figure out the driver private interconnect topology, that's going to be
messy. That's why I'm also leaning towards both comparing owners and
having an additional check whether the interconnect is actually there or
not yet.

You can fake that by doing these checks after hmm_range_fault returned,
and if you get a bunch of unsuitable pages, toss it back to
hmm_range_fault asking for an unconditional migration to system memory for
those. But that's kinda not great and I think goes at least against the
spirit of how you want to handle pci p2p in step 2 below?

Cheers, Sima

> > >  2) The page is DEVICE_PRIVATE and get_dma_pfn_for_device() exists.
> > >     The exporting driver has the option to return a P2P struct page
> > >     that can be used for PCI P2P without any migration. In a PCI GPU
> > >     context this means the GPU has mapped its local memory to a PCI
> > >     address. The assumption is that P2P always works and so this
> > >     address can be DMA'd from.
> > 
> > So do I understand it correctly, that the driver then needs to set up
> > one device_private struct page and one pcie_p2p struct page for each
> > page of device memory participating in this way?
> 
> Yes, for now. I hope to remove the p2p page eventually.
> 
> > > If you are just talking about your private multi-path, then that is
> > > already handled..
> > 
> > No, the issue I'm having with this is really why would
> > hmm_range_fault() need the new pfn when it could easily be obtained
> > from the device-private pfn by the hmm_range_fault() caller? 
> 
> That isn't the API of HMM, the caller uses hmm to get PFNs it can use.
> 
> Deliberately returning PFNs the caller cannot use is nonsensical to
> it's purpose :)
> 
> > So anyway what we'll do is to try to use an interconnect-common owner
> > for now and revisit the problem if that's not sufficient so we can come
> > up with an acceptable solution.
> 
> That is the intention for sure. The idea was that the drivers under
> the private pages would somehow generate unique owners for shared
> private interconnect segments.
> 
> I wouldn't say this is the end all of the idea, if there are better
> ways to handle accepting private pages they can certainly be
> explored..
> 
> Jason

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

