Return-Path: <linux-rdma+bounces-12568-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B53CB1861B
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Aug 2025 18:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2C2E188EE11
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Aug 2025 16:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56E01DC99C;
	Fri,  1 Aug 2025 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dJfM2wc3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195E41D7E37
	for <linux-rdma@vger.kernel.org>; Fri,  1 Aug 2025 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754067473; cv=none; b=KnFFUlAzbdM+CEJo8h3oRefYnvIVwLLUjNJF+XVUhTUO/fUV8og9kVQUWwrbsYq4Vi/7nCEy5JXgoKnGZ/8dLHji7jO9R1UBaa9P4Ed6DKELG7mjVvq2K6jEUbymaV9wFuESPKwB8BREz/JHAb5eH6yJX2bdhoDnM2nv45mUtIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754067473; c=relaxed/simple;
	bh=vDejQUFTFKWHa1k801+hC0Yzdnwhqf+NoOVFx9dNlc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B81HcedExkXICQNrNMraqEAS+3BLgmNUe87ykmDa9WfIDbu3R9iihDBZ5g0asM9ep/CgzqlUpuC57OKLjrreb1mNrSnkLqBfMLXZ4pjBKcekIldxTt8F1/IJH3I3vijx1DZmIM2BalbJ/ojJHBtDYtJ/CactwsLdYpuLy5AQgDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dJfM2wc3; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e6696eb4bfso107924385a.2
        for <linux-rdma@vger.kernel.org>; Fri, 01 Aug 2025 09:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754067471; x=1754672271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PDG0NiUkE6aQQh2+3vtxR81GyiRPYX8OvGtHO76jA4Q=;
        b=dJfM2wc3j3H/mesSDcAy2ptGjlnL6BXpjsgyWzJDLDVFYdnsqt5oF97BRruv+vwT6a
         31HxaCw6qlqOJa2BYhAPUHFJ4SGKc+ojIMm2eUiCVZQP4WjaqwlZhrbKpyGk/vmrumbg
         9BWoqA6e4LwokCz9+z1VEnazea+g0p/XTPvpbw9HAxIR89DVJ0tO13hJxIWkYuJSFg7n
         xj+MP735juI0dVuhYEQwfU8ODF34Wn0nygN5D8gzlVXxuMrw7MUrs/0d4M2x9b5Rj2Rc
         F772guoSIihsoAWefuJGn/Il5QYW2hQyDqbrfk9xdBHB6bSJ69MB3qgOX7VSb7zl+U+G
         41pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754067471; x=1754672271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDG0NiUkE6aQQh2+3vtxR81GyiRPYX8OvGtHO76jA4Q=;
        b=UNNW/yvkkERAE/3lq1r00VFEvMkXI4LhjTbmH14pmgemgS4zA1LEznmbkaJ7p8Fh/1
         0gtHTeKOFVOTlCDtWOWl+qQPn7fYxRIe2ZfRRAx1O0bKs8SKqz/R72m+1SfH524wp8Xe
         R4mtE3lINhBbM0HX1xxorWOS0vpH43hY2zHIyM/2p2TYSsjSyRkWdX6kdTXJOhY/5er+
         TZOpaRhlbLudLX2ret+C3DoXpuZrPmz7M3a5ZCdoZoHB2NopoWm3H1f9aq/VnJNZtrTu
         4Etoj3pamm3zw5KvWN0KBIXVcsCYcREMQZh76dY7N9mu5y+Bp6/8bOG5+vOVLsbICglG
         owUA==
X-Forwarded-Encrypted: i=1; AJvYcCW0jOHqEguMyzgRcZpYKfJgx0TxHqYHGabvtyD+AwjD3/gO3Ty89+40oLvMX/RIZvr8nlwNabUNzKLf@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Z4/0K3TyboE9So3MvkhlBzoyAa7E3uC6gHBYrrKESTCki9g2
	aT3tbEmzllv5evSY6DBPMas5VHvXIbG8N7p4+/iqsnhQnECFInmJ9VEC6kbcG3imyG8=
X-Gm-Gg: ASbGncvx5W6xHFzwzI+57KM+jvJzIFAOHp62ec3Vd+f8eUIC9v1jHHobmsrJryDixU3
	+Tr4k5Z4/5OqOiiwL9Vuu2fESbLoB33q71vmhLgaDIU5tGo0imuVpkeFQDlq6uv4s2CyE+qk9dv
	+3ptaQ59n0LutkAA5x+zCtlulkOsy7xgXn536olnjeH8GmwBT6SELm+YiNdKgC5vIDMMNxghO44
	yWRZ0YXAwe7UbLY6H1pB/oePG18oXCo9MYMZb+UTH6RvSWob3iIib8RoWWo4w8fAyzXA59C3JBR
	X9hBdyuEB7S+72+8DIuBqZXOckt7fDnPTZFI7U2jlt5olIxsj/ycMmIrL1Yz0hCr2eQiSHzdhWi
	s8Jr+sHY0OPwfPrcbVoa7/u27V9Bucw/olVglmOXmDAKr9SeI/ENyQgMZJ1eAjLqu8dHu
X-Google-Smtp-Source: AGHT+IERBfIl6+3LPr31vnFrHmPwk8v4BHZ0fVqJ0PrqlgFbKe+fN+UuB/UkeSinm2wl6jaqpYu7OQ==
X-Received: by 2002:a05:620a:4093:b0:7e0:f7e3:7927 with SMTP id af79cd13be357-7e6962a98edmr81964885a.21.1754067470755;
        Fri, 01 Aug 2025 09:57:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f597e32sm234364185a.18.2025.08.01.09.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 09:57:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uht4n-000000013IN-2zx7;
	Fri, 01 Aug 2025 13:57:49 -0300
Date: Fri, 1 Aug 2025 13:57:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Hildenbrand <david@redhat.com>
Cc: Alistair Popple <apopple@nvidia.com>,
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
Message-ID: <20250801165749.GF26511@ziepe.ca>
References: <aHpXXKTaqp8FUhmq@casper.infradead.org>
 <20250718144442.GG2206214@ziepe.ca>
 <aH4_QaNtIJMrPqOw@casper.infradead.org>
 <7lvduvov3rvfsgixbkyyinnzz3plpp3szxam46ccgjmh6v5d7q@zoz4k723vs3d>
 <aIBcTpC9Te7YIe4J@ziepe.ca>
 <cn7hcxskr5prkc3jnd4vzzeau5weevzumcspzfayeiwdexkkfe@ovvgraqo7svh>
 <a3f1af02-ef3f-40f8-be79-4c3929a59bb7@redhat.com>
 <i5ya3n7bhhufpczprtp2ndg7bxtykoyjtsfae6dfdqk2rfz6ix@nzwnhqfwh6rq>
 <20250801164058.GD26511@ziepe.ca>
 <b8009500-8b0b-4bb9-ae5e-6d2135adbfdd@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8009500-8b0b-4bb9-ae5e-6d2135adbfdd@redhat.com>

On Fri, Aug 01, 2025 at 06:50:18PM +0200, David Hildenbrand wrote:
> On 01.08.25 18:40, Jason Gunthorpe wrote:
> > On Fri, Jul 25, 2025 at 10:31:25AM +1000, Alistair Popple wrote:
> > 
> > > The only issue would be if there were generic code paths that somehow have a
> > > raw pfn obtained from neither a page-table walk or struct page. My assumption
> > > (yet to be proven/tested) is that these paths don't exist.
> > 
> > hmm does it, it encodes the device private into a pfn and expects the
> > caller to do pfn to page.
> > 
> > This isn't set in stone and could be changed..
> > 
> > But broadly, you'd want to entirely eliminate the ability to go from
> > pfn to device private or from device private to pfn.
> > 
> > Instead you'd want to work on some (space #, space index) tuple, maybe
> > encoded in a pfn_t, but absolutely and typesafely distinct. Each
> > driver gets its own 0 based space for device private information, the
> > space is effectively the pgmap.
> > 
> > And if you do this, maybe we don't need struct page (I mean the type!)
> > backing device memory at all.... Which would be a very worthwhile
> > project.
> > 
> > Do we ever even use anything in the device private struct page? Do we
> > refcount it?
> 
> ref-counted and map-counted ...

Hm, so it would turn into another struct page split up where we get
ourselves a struct device_private and change all the places touching
its refcount and mapcount to use the new type.

If we could use some index scheme we could then divorce from struct
page and strink the struct size sooner.

Jason

