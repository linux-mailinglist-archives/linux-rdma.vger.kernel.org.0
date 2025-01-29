Return-Path: <linux-rdma+bounces-7308-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD247A21E23
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jan 2025 14:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6343A5F8B
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jan 2025 13:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B10712E1CD;
	Wed, 29 Jan 2025 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HGdV6S4n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269F53C38
	for <linux-rdma@vger.kernel.org>; Wed, 29 Jan 2025 13:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738158481; cv=none; b=F1zlm6ZN1yGMYZSH+C5UKkCvuTlaobzVAxxKmmYUGxryMe66QjV6NjEKFEi5i/fJoOKn9cx7F6wxdlFWRr+x/DIPsw2XxFf9bBUOdIc3HsDH1OjNU+RSY6xxLxfpvfZaJrpJ2J0xYggumPoFi1f6MkysML+8vCMUq3EMAc9cO3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738158481; c=relaxed/simple;
	bh=4p5V8MeeXoHZimLX86DEqr7isEbN5AK9qq48FtatG0c=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwiIHmnkX6rjTnmvC4s/ycMb+IgVLuhciICffZINAepzXIHtqc1VgHMlkm/0N0PjZMQNL2jp5aG5E96IGNIyi7dawot0gFN++jcVg36jUDYS3Nqo1jMqnlRxOhqXfaROVZCNdPiDYnf25GV1pfZI/dqYQLF/3CuhtdfVZuHydFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HGdV6S4n; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4679eacf25cso40051081cf.3
        for <linux-rdma@vger.kernel.org>; Wed, 29 Jan 2025 05:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1738158479; x=1738763279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TGxs1D5kHZWfV3TMw8ydKze6LYDZn037JbgBy8rBgVo=;
        b=HGdV6S4nUFZxmhXDs7awIf2kGvYN68fgxC7JmV36Qhk4/9FruV2YgpuCyKsY5Ra0hd
         JfgEZUp8oseQ3RlKPNFY4CnvKCrDEaHhNrK6/eRgvElFo8mxoek++GIE2itG74BSmP6k
         VB3Tal1clOyaiHL4920xmNAizQxnS02sE7d58ouhi0fjvtEhTFaed3muC9RlBe+ZbGP2
         yFGRLkxYuqE8SMoxWKrmquIiVP33KKbFeQHoei/OO7PZ1H8mgOSHOX0vU7NJcFOG05UL
         63QKyad5ykGWf0n88K4AMzCGSY6foiHmZHTxfYQDTBgmAevtEu+DjuytkhyKdNT70tdi
         C1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738158479; x=1738763279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TGxs1D5kHZWfV3TMw8ydKze6LYDZn037JbgBy8rBgVo=;
        b=FFxmrcF9DnJjXAmkPvkhwfFQEtyv2+K96gkHfKP4Gh1ygF9w2VbT+uDfPAmetU3hF7
         Wr+lGl9i4hrNrL2eBI3NtXtShRzIG3x1TsUdNI18TXfQQSR9jtO6xqidbxWcd3m99POK
         8J1CJYr92aVTcUlJ3dtIdPWCQU0KRQshFraMUnt5Hib29TLD6/1OUt8fLPcmJowjNDlW
         ASDHZQ9o6j2W1pvbYxzFadOCfMBGf34G6VXuFJty5qH0Tty5H2M8iQX5kerW8CwAduOl
         bAXJ+gq9v2jYrSaDy17E+IMEq5wIMJBd8rhyAf/oq5Df4+r3wLcSXuEjxwvHctADYyK/
         qgQA==
X-Forwarded-Encrypted: i=1; AJvYcCUCTrPh3yM/18pZO1Lv8AxkRARcVUfOpFBYnBf1TfwTUUJYxviPRhsx9NdCeN3FX9SpVQKJwG3VeyUL@vger.kernel.org
X-Gm-Message-State: AOJu0YxnpeAM4dmMqXVZwfzhBjTQmbKQcq2MttNv9RUb8/hoie5Yt2wP
	63jwLsFeptNRQjj3hQM3su/2KVv6eqlF0aVei9NxrNyD6hXWxT9tTy9U3d10lrM=
X-Gm-Gg: ASbGncstc0dwxqp4kqlagY+w6/Y4OTG4GNLd2AutfZOyxQsrIQuILWF8QlVK6UQbxl1
	uzl4+mpWF46HDOsS8KVrW5q4DoFjw5MO9UfU+yPCncpJ0Gp0qBOxojabiTWKzW1MKCOIMsfeRjX
	5tHHChnkPDSEFkWaxM9v+UBfUNMP5aCmSChYAhqvy6uB5RjVRDz/irzM7C+lbu7AfcBjj3Xq1cV
	/JTFe2hNS5E+bVOmWsJ/iJPmtAo8retHVsfnc4aPmfjUjOqDxBj2aQuSDAzGNvHj+YwYPfGnr+L
	MvEflRGkWWuRBr2twy7pjUyARG8WSdE91Ka6JnZgN0mgNdRZXqjCDxXuzKyv3EsV
X-Google-Smtp-Source: AGHT+IHuYCAk+wYHqjFRDvmI1uuhKYfRXYz+H9jof+ajiAjSs3miFEirWAObJrrIBPKksD6vvP2lVg==
X-Received: by 2002:ac8:5a08:0:b0:46c:782f:5f85 with SMTP id d75a77b69052e-46fd0b98596mr53288201cf.52.1738158478735;
        Wed, 29 Jan 2025 05:47:58 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e66b67680sm62281881cf.60.2025.01.29.05.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 05:47:58 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1td8Q9-00000009BlF-1by8;
	Wed, 29 Jan 2025 09:47:57 -0400
Date: Wed, 29 Jan 2025 09:47:57 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Yonatan Maman <ymaman@nvidia.com>, kherbst@redhat.com,
	lyude@redhat.com, dakr@redhat.com, airlied@gmail.com,
	simona@ffwll.ch, leon@kernel.org, jglisse@redhat.com,
	akpm@linux-foundation.org, GalShalom@nvidia.com,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-mm@kvack.org, linux-tegra@vger.kernel.org
Subject: Re: [RFC 1/5] mm/hmm: HMM API to enable P2P DMA for device private
 pages
Message-ID: <20250129134757.GA2120662@ziepe.ca>
References: <20241201103659.420677-1-ymaman@nvidia.com>
 <20241201103659.420677-2-ymaman@nvidia.com>
 <7282ac68c47886caa2bc2a2813d41a04adf938e1.camel@linux.intel.com>
 <20250128132034.GA1524382@ziepe.ca>
 <de293a7e9b4c44eab8792b31a4605cc9e93b2bf5.camel@linux.intel.com>
 <20250128151610.GC1524382@ziepe.ca>
 <b78d32e13811ef1fa57b0535749c811f2afb4dcd.camel@linux.intel.com>
 <20250128172123.GD1524382@ziepe.ca>
 <Z5ovcnX2zVoqdomA@phenom.ffwll.local>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5ovcnX2zVoqdomA@phenom.ffwll.local>

On Wed, Jan 29, 2025 at 02:38:58PM +0100, Simona Vetter wrote:

> > The pgmap->owner doesn't *have* to fixed, certainly during early boot before
> > you hand out any page references it can be changed. I wouldn't be
> > surprised if this is useful to some requirements to build up the
> > private interconnect topology?
> 
> The trouble I'm seeing is device probe and the fundemantal issue that you
> never know when you're done. And so if we entirely rely on pgmap->owner to
> figure out the driver private interconnect topology, that's going to be
> messy. That's why I'm also leaning towards both comparing owners and
> having an additional check whether the interconnect is actually there or
> not yet.

Hoenstely, I'd rather invest more effort into being able to update
owner for those special corner cases than to slow down the fast path
in hmm_range_fault..

The notion is that owner should represent a contiguous region of
connectivity. IMHO you can always create this, but I suppose there
could be corner cases where you need to split/merge owners.

But again, this isn't set in stone, if someone has a better way to
match the private interconnects without going to driver callbacks then
try that too.

I think driver callbacks inside hmm_range_fault should be the last resort..

> You can fake that by doing these checks after hmm_range_fault returned,
> and if you get a bunch of unsuitable pages, toss it back to
> hmm_range_fault asking for an unconditional migration to system memory for
> those. But that's kinda not great and I think goes at least against the
> spirit of how you want to handle pci p2p in step 2 below?

Right, hmm_range_fault should return pages that can be used and you
should not call it twice.

Jason

