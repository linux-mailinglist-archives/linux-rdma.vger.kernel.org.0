Return-Path: <linux-rdma+bounces-12564-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE7BB185E9
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Aug 2025 18:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D463A4EE3
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Aug 2025 16:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2CD19F121;
	Fri,  1 Aug 2025 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UPzVD96y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBE41E50E
	for <linux-rdma@vger.kernel.org>; Fri,  1 Aug 2025 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754066463; cv=none; b=Yzjon7uFLk7cFCmMJkkQuySqUyFSBGbMuLiIuEOIU6FvOItBMgqwJ3f7t5WDxYqaakVC9+0AlRkvWvcmmFfx3RiDIGpgktaFJQV1U0jMV43qWq6xj9bdqX3DO/U+6Bu3KQ25xNj1p1PAdwiywReKqC/B1wocPimnsa4cDDI2in0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754066463; c=relaxed/simple;
	bh=B0ddBwnOmQZLVOzE3sU/BJSF1dO9mMLzFrijfMzZ/2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuT/PHB/QBkIetNlqNjOSTis1urG4uosY7WAC0JItwWsPiwGQCSqwwZd58aWsAV5FP8STBk6/mrmKW2vAHSqIb7hWmqx+16gHb/N79Y1VkEsxvoFYEI/rawsJ54BQIvPBdaSoXnV+SJnHvp0T0KsCUHjInMLy7Cp+TLqXB6RaPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UPzVD96y; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-7076eaa5febso4883656d6.2
        for <linux-rdma@vger.kernel.org>; Fri, 01 Aug 2025 09:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754066460; x=1754671260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B0ddBwnOmQZLVOzE3sU/BJSF1dO9mMLzFrijfMzZ/2w=;
        b=UPzVD96yMxeJOyx7VW2u7Yft/7Nth5wFR7zXP16u6Nir5Kwhn7PtQ6D12wfAsn1piZ
         Lbn2c4eMc9NPcZT/l13ROISmpjCcOPfga+IbEqZ3ndrZW8nJ83nYGiwBcNbVvgCGBl/z
         OO4QCigleC6JrIyVFx5y5qKUfdFy9TRLJcHCiNvn/iTDT+MLx+HmsjK+YdcdJsu44m8n
         BslmkMqqr+hIJFuDjgw4pzBnsmnlMxbpBJuXI87LFsmWq12jJYDc/vjFb8duVPuxV+Rs
         /ZaPpD82SXqVVAJwx5rgLCSY/VV9DCj+Na9znQ/So4j6kD6IMH+fjGex5lkRvQjU25sG
         Kdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754066460; x=1754671260;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0ddBwnOmQZLVOzE3sU/BJSF1dO9mMLzFrijfMzZ/2w=;
        b=HBmnU1FebSaGSBB6NZZ4SVoOCchwkcD+DBJvUgKFlYY19nXwNX7c0aJYIKsmTtCLH1
         fqWo/KZFpgjMRHqFlgKhwOcc038sRHZBnaqqii+WBhPBO5gLWOVGaHOycfVeVNr7CjJ9
         mw6B5fwKPYDlPWlc+phAdzziM+iXmR3zzkpwSWWruoLApbujalOzcXoywkWytWc/dnwO
         eaN7VpEWHttqm42WZunDpLyrCYYL4ORS0R/OECcUNH7vJVFNdk4oYtX28bGttUgnPDaG
         gQpEY8qMTV80d0Y5Anb/RfVhGDKDOG0liPFRnLNWCT8kVTkjmWDx3vbnBnwfEIAdCjr7
         Xejg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ0aGL78pRZDlcYM+1zm+O13lpxCUqqnbepxGqEunv7GZYQzy7BbtmLUz5ZuMzL3sWk5PrSeIKgnYU@vger.kernel.org
X-Gm-Message-State: AOJu0YzIY2zU3TfsXlpEyek/TALoMQxzjj2RxkIA2Ib5HdYe4B6NS7ck
	fz7mYZjV1rkCqCPvc8AVqVgohnnqgQWGYCa4Ylnv8cg9Dmui5bMxXuRivfdEBoBYIKA=
X-Gm-Gg: ASbGncudzvqH4FgcA6Xk33gi/dOjADl+XPtFY3DM7nCR+muRps8UhcX6WPZ6eMA5k2k
	w2TknQru6iEnrWjAZWXtUwkvRf9LnjhV39Xaq6lIE5jVnmIH2ilP78rTnPRWrnMac4RUpGhBWPO
	1I0gmFzV9oZGUgBrwvhYz+ZFcxftNNbjbwFhgr7BrXDRz4eIZ9e12/wj8goWNxWtrVa4rnl4014
	5kC63uNTPnB0onHwT7tw3RJKG/+UO2kPUWPCHm06+7RBLraof4JkKoi1VrvsonxaWiw3lfcQCoH
	NMQocOH2g4N3i8MuOLCT0JlDC98N/wfwtglUyiAU9Dpv+ekFEi/O5ej3yvjVQAqYrsrs+odzPCi
	DUXYgEg6fr+IDtxlJVeJPBtupUKBryEsCORrcTqqwgNtrIqcDRuJVMpE3mwVTiU+SXwaN
X-Google-Smtp-Source: AGHT+IEy3UJJEisaAsFYVle9oO+qAAIDl2Jx71tj+7ZpM48o/4SMC51lEI3qAmHkBEbK3gRlxWE1yw==
X-Received: by 2002:a05:6214:623:b0:707:641e:e4bb with SMTP id 6a1803df08f44-70935f66fcemr4291156d6.17.1754066460081;
        Fri, 01 Aug 2025 09:41:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ca5c23csm23275996d6.40.2025.08.01.09.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 09:40:59 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uhsoU-00000001379-3cXq;
	Fri, 01 Aug 2025 13:40:58 -0300
Date: Fri, 1 Aug 2025 13:40:58 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alistair Popple <apopple@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Yonatan Maman <ymaman@nvidia.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Leon Romanovsky <leon@kernel.org>, Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Ben Skeggs <bskeggs@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Daisuke Matsuda <dskmtsd@gmail.com>, Shay Drory <shayd@nvidia.com>,
	linux-mm@kvack.org, linux-rdma@vger.kernel.org,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Gal Shalom <GalShalom@nvidia.com>
Subject: Re: [PATCH v2 1/5] mm/hmm: HMM API to enable P2P DMA for device
 private pages
Message-ID: <20250801164058.GD26511@ziepe.ca>
References: <20250718115112.3881129-1-ymaman@nvidia.com>
 <20250718115112.3881129-2-ymaman@nvidia.com>
 <aHpXXKTaqp8FUhmq@casper.infradead.org>
 <20250718144442.GG2206214@ziepe.ca>
 <aH4_QaNtIJMrPqOw@casper.infradead.org>
 <7lvduvov3rvfsgixbkyyinnzz3plpp3szxam46ccgjmh6v5d7q@zoz4k723vs3d>
 <aIBcTpC9Te7YIe4J@ziepe.ca>
 <cn7hcxskr5prkc3jnd4vzzeau5weevzumcspzfayeiwdexkkfe@ovvgraqo7svh>
 <a3f1af02-ef3f-40f8-be79-4c3929a59bb7@redhat.com>
 <i5ya3n7bhhufpczprtp2ndg7bxtykoyjtsfae6dfdqk2rfz6ix@nzwnhqfwh6rq>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <i5ya3n7bhhufpczprtp2ndg7bxtykoyjtsfae6dfdqk2rfz6ix@nzwnhqfwh6rq>

On Fri, Jul 25, 2025 at 10:31:25AM +1000, Alistair Popple wrote:

> The only issue would be if there were generic code paths that somehow have a
> raw pfn obtained from neither a page-table walk or struct page. My assumption
> (yet to be proven/tested) is that these paths don't exist.

hmm does it, it encodes the device private into a pfn and expects the
caller to do pfn to page.

This isn't set in stone and could be changed..

But broadly, you'd want to entirely eliminate the ability to go from
pfn to device private or from device private to pfn.

Instead you'd want to work on some (space #, space index) tuple, maybe
encoded in a pfn_t, but absolutely and typesafely distinct. Each
driver gets its own 0 based space for device private information, the
space is effectively the pgmap.

And if you do this, maybe we don't need struct page (I mean the type!)
backing device memory at all.... Which would be a very worthwhile
project.

Do we ever even use anything in the device private struct page? Do we
refcount it?

Jason

