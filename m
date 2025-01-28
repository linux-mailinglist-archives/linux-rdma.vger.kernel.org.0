Return-Path: <linux-rdma+bounces-7267-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBF6A20B3C
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jan 2025 14:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461721884D23
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jan 2025 13:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E71D1A3A8D;
	Tue, 28 Jan 2025 13:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Y/iX5bAQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B315713C682
	for <linux-rdma@vger.kernel.org>; Tue, 28 Jan 2025 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738070438; cv=none; b=gojJYfBupTvKDue8xmKdqRQFO5+uLGsNwGYA/YUekSTPGBb4VyfqjITS6LLVzTbAH4yqKMq26k3UoCfMo0E5/jH6NQ6FZdWsAZ4MoLyVTA9Zfd6fNuj9Z6HHdjUaEGmIwa08Y+cR5ZCbyUXvsatsTuAdEuqnFqt73ptgIfF3+LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738070438; c=relaxed/simple;
	bh=U4suS5LTaOVNoqADNqMm3cSIM2A9q2pA52JYTTgCklY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQsi01ySg7rPUl4kKLRbRUdYGJ7wu4wEr9Fnicfv5eFYa/1BSrZWbpACLsKnf7RqbEuBc44JnDFGdVadxhb5mO23mROGcmGySV922t9ItmV5h1qLonjng0QhA1ynWwPiTy0amL/Fw+xD0grKDtWxkDqYomiiP6KXZXfhM606XXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Y/iX5bAQ; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b6e9317a2aso575991285a.0
        for <linux-rdma@vger.kernel.org>; Tue, 28 Jan 2025 05:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1738070435; x=1738675235; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GOWXoYYRnWMsoeKK+VVuf/lMuv2V7GO+mfTTLFXfUSE=;
        b=Y/iX5bAQEEByiwQNOJDftwrQx7wHO5Y9UA51pkGWXkj2Mk83CmggJLSEd8babLOV8V
         nVlKo7Wns1lCfcty0PWvoFrTXhTdsasEBN3dPYCngRp2hxwOwTKvnQ5TiSV3u109RY3W
         bOWQsvooFLysWzmORdltM2sACdf2ED1vJs4gJueCSgiW8OxSLiVU2XqEbYZi6BbbMJXj
         pUz0qZYrwOBJ8fCSWH0vj++MlDlDfljZ9LCMPHIoCZsmsfTzCBvUSYaELvTA2gitzqpX
         GrXl9drRu0M6N5D+z7h4AK2ssMcwZ1baH3PleulmHmLYnpTHJzV5RftTvqdp0g2oJj6+
         ZtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738070435; x=1738675235;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GOWXoYYRnWMsoeKK+VVuf/lMuv2V7GO+mfTTLFXfUSE=;
        b=Oy3yfhqmUhnuvpzmbBrtYtnlY/W3CRSEaOSKFtz+f67VUIlI/AtyqZHWWzCblEWI9O
         yXUbSYaTLXCiB1HgShWYPEM3qLcSa42eOToiFrnMuikeE41rGztF0Dyik9T208eORPMO
         uTlk2iECd4LrKbCtZHO8BJ5ToBF2uZiVmyUXR69p03Y/xxtgeDADKhCeKrVzYMkQMKUt
         iev1OtsznMCR4ZiPVs/mo8KXUPQNBigi+nzOavHaOiNGugYxqgBUNasNmLEeqjf1+Fnj
         NmcBVd0anXAVSRDHLB+/Tct1525nk/Hn/meKJsphIgisl1ACEGYCRUhzSIz+F/2/ynmd
         AamQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkMRcb7odv8/oSd3MohNkX5C99N4IE8ZjoSx9hPos2w6KoZISy8Zd/hQWddknutP8/g5zVji1iypt8@vger.kernel.org
X-Gm-Message-State: AOJu0YyhrFOV5Hiut22Gdczj4mAKDTo1XkUq0uauPQiPCelAExT5NlOv
	FFt2wdOsrfDKn2o/rPb/AY0CCdfm21paAXuuxnZ1+E+2CFAhbqaNS8xAy5pPOjVA10siJfn44aR
	F
X-Gm-Gg: ASbGncuN62ww88kEBePS2PdrzXocsAsDzc9i3tIchPhxmKoWnS6aPmDhEUiILVasL4E
	PIiqbRDAEA432K7XVqADy0SVmo+mFuaVxDXrGembvya9Lx9u5JtRp9vXxe7Zs4dmYI+EbRK04+d
	f5LO88DvcJPGCroVKnxD/FFW+q03aviLhJR0Mh2j0vE/p93+ZcefcjQu02vRZ+/boWeCxd39zuI
	nBxAhS8Amj6kEWmIc0PDSzIxAdLF8UliYifPN3iKdI4RaZ7N189XZSAKIWxK5FwoDu2z+i3w1jn
	jYmVDRfFc2uQvSnI25Bj4CeE18V+n0vxCdA3twRcG77JFx5CRDoPRBvyOoGCoAlTn23N9y3fl1c
	=
X-Google-Smtp-Source: AGHT+IFfqsRD0FOVkdIg887UXRm977J4ky26yoqHXaGeXqELEj2EneWq+CuXUYKkdzvufPHaZSVAIg==
X-Received: by 2002:a05:620a:3910:b0:7b7:142d:53a8 with SMTP id af79cd13be357-7bff3fb4946mr402618885a.19.1738070435489;
        Tue, 28 Jan 2025 05:20:35 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9aeedc68sm512887085a.74.2025.01.28.05.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 05:20:34 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tclW6-00000007TbE-14aw;
	Tue, 28 Jan 2025 09:20:34 -0400
Date: Tue, 28 Jan 2025 09:20:34 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Yonatan Maman <ymaman@nvidia.com>, kherbst@redhat.com, lyude@redhat.com,
	dakr@redhat.com, airlied@gmail.com, simona@ffwll.ch,
	leon@kernel.org, jglisse@redhat.com, akpm@linux-foundation.org,
	GalShalom@nvidia.com, dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-mm@kvack.org,
	linux-tegra@vger.kernel.org
Subject: Re: [RFC 1/5] mm/hmm: HMM API to enable P2P DMA for device private
 pages
Message-ID: <20250128132034.GA1524382@ziepe.ca>
References: <20241201103659.420677-1-ymaman@nvidia.com>
 <20241201103659.420677-2-ymaman@nvidia.com>
 <7282ac68c47886caa2bc2a2813d41a04adf938e1.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7282ac68c47886caa2bc2a2813d41a04adf938e1.camel@linux.intel.com>

On Tue, Jan 28, 2025 at 09:51:52AM +0100, Thomas Hellström wrote:

> How would the pgmap device know whether P2P is actually possible
> without knowing the client device, (like calling pci_p2pdma_distance)
> and also if looking into access control, whether it is allowed?

The DMA API will do this, this happens after this patch is put on top
of Leon's DMA API patches. The mapping operation will fail and it will
likely be fatal to whatever is going on.
 
get_dma_pfn_for_device() returns a new PFN, but that is not a DMA
mapped address, it is just a PFN that has another struct page under
it.

There is an implicit assumption here that P2P will work and we don't
need a 3rd case to handle non-working P2P..

> but leaves any dma- mapping or pfn mangling to be done after the
> call to hmm_range_fault(), since hmm_range_fault() really only needs
> to know whether it has to migrate to system or not.

See above, this is already the case..

> One benefit of using this alternative
> approach is that struct hmm_range can be subclassed by the caller and
> for example cache device pairs for which p2p is allowed.

If you want to directly address P2P non-uniformity I'd rather do it
directly in the core code than using a per-driver callback. Every
driver needs exactly the same logic for such a case.

Jason

