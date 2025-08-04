Return-Path: <linux-rdma+bounces-12580-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4DEB19CE7
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Aug 2025 09:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCEB73A82AF
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Aug 2025 07:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0C3239E77;
	Mon,  4 Aug 2025 07:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="US9Yo25E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9BCB672
	for <linux-rdma@vger.kernel.org>; Mon,  4 Aug 2025 07:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754293705; cv=none; b=JVtC43yQfxucBHt3wIY1te/yBHb+omXzlYUokFo3FU2DThy54++OipvCLOH0o5K4i7r2bBxvedV9i8ymJe2jyxLHf7i2+smDn9YV+1qedTibDemGAQDqHZNR1Ae6cYXa3o0R6yysqBtX/ZIVP7T0XhYb0QS8YCbQB4y9QQdgXe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754293705; c=relaxed/simple;
	bh=AR+f5t6dziMhb8nTUFcr53heVFF9AWs16IRFsRILSHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cHNoJG00PLI5EKPpJG/2vwSzXs5hXAXy3TuOWknmtmx+SCf2eInEHLhQm8EVUv2HdjH8Rle6Px/HhvrUURUrt0NkFoZuDZ7jqb3awkp2gGJFlRZejG3NSI2AWPRq5QFJNZhvh+r8X1cfE6NlrgbM0WMQxU8DUfhB/55YqQFuQps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=US9Yo25E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754293702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CI9V5tQa/vNbUREhWfZQik4IRoDBf2O57MsxRr5DRVg=;
	b=US9Yo25E4ymWSjCeR3va7bJzoPBZ1c700GOfyzHBqaSsoezDnmKe1yBZ9dLtOaKPNGLq8Q
	0XE5UxED3gbuKs2QjLGcP/eYUFnqjsR6LOgGaRpFWN8jqpgjVoS1/Uu5yJ+6pXx+d7cJtf
	BYYzio73a+jzC7oLJz6qXeOldiDdI6A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-LZrFVE1aOA2WHMSNQjMaHQ-1; Mon, 04 Aug 2025 03:48:19 -0400
X-MC-Unique: LZrFVE1aOA2WHMSNQjMaHQ-1
X-Mimecast-MFC-AGG-ID: LZrFVE1aOA2WHMSNQjMaHQ_1754293698
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b79c28f8ceso3111382f8f.3
        for <linux-rdma@vger.kernel.org>; Mon, 04 Aug 2025 00:48:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754293698; x=1754898498;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CI9V5tQa/vNbUREhWfZQik4IRoDBf2O57MsxRr5DRVg=;
        b=n0d8ui9XD+pVPqB3ZqBVjuju9D5xYzgzOlfU1nhOKrqdhCLG73FgYfsi7vyDDxrrEm
         ax/ECOcHBFPRkxWqZ101vA3G26/N2UiZDs79Tj2G5P+KEUyoxBTExcz6v630SNnHo0Mp
         LsUkQvAqRCGxmciov6+0WE6dK3jdSQ/qzVg0M16txwvBoqZnBZAZhUq12H87lE2RHQtk
         61/MGb7/qA/d5YqxjPhza1tyyIJnFDDp1RC15czTJJ0Lz3JjlIoC053XLqwd3VZCS9Uh
         k0ul3cIlzfr/jWwzRQ5cgnsuye7ksfWKWo7wDbfnSu1XBgWNHHqncgYlz/A05tIh3PSg
         bhtg==
X-Forwarded-Encrypted: i=1; AJvYcCXKNNDZgOHPaT3IOayWY9DCtNWnc7j24gt6rnVXIH8oiZc8WRXCbaZyC1AzvAzmq28I/+A+/2rE+23y@vger.kernel.org
X-Gm-Message-State: AOJu0YyfTKaC+dXnTxfqzC8OD+2dgW7ddMJmfvBASQ7cBsiRpE0F5dZ1
	h/F6F4MWdwUk0WngiE6gf7U20nJAyKjDrFNH9pOTgW5QBYhdaVy3hn+5CkldfQgSlaQoZdniCk5
	u4Lw63BHskYJw/QKDjAFkp5y/b7a/4fIP/g4i8E+348KcmI01u+LcMrf937MmSEo=
X-Gm-Gg: ASbGncsjUCRNBPkDfEN9SsXjD7Xi+D5wsRCRLY4sRBxt3/wr1IjI+tGVn1WdU4meMFc
	8ASwmChIuOucz7+3A5tveZqpHGq5oxONaaxipJ4auUYR758eRzu4oH3/yWu404gbObtGAiYoxeW
	os/yENpis9NkQ+ynZ3w1fMfgzn80/k3RiG6bATAYHakls2jiABQzC5Z6smNG5VNd2pmHIK2LI8e
	jwqv6LACMnqyVj8lxWrp9UhGQYX0teCUJTivVghkpZ008aJMoQk1XCehvCy6W1H5yc/QlrpPnBG
	7v8VuI+xuXLcHb+ebUPpZQEsz3T9CKvi76JelPussnt0tpc/I0JhpVpT5uAVSxfnZTQtZ8fbK1q
	6T6/KMUaAtsr0gjJSMrI8B8Gzi6Gomo63iUtxVBcMRG0sHr9/DXE6L/dWpkA5msqRvrk=
X-Received: by 2002:a05:6000:2884:b0:3b7:90f3:cd8a with SMTP id ffacd0b85a97d-3b8d94c4a53mr6034046f8f.49.1754293698098;
        Mon, 04 Aug 2025 00:48:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfYT0lcXyX08bXfIENSYopKSKAxiPsmMGCtLCADlyGZAB/nU3jxTIAQ+97SAdwL4HDWRlAbw==
X-Received: by 2002:a05:6000:2884:b0:3b7:90f3:cd8a with SMTP id ffacd0b85a97d-3b8d94c4a53mr6034010f8f.49.1754293697653;
        Mon, 04 Aug 2025 00:48:17 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0e:2c00:d6bb:8859:fbbc:b8a9? (p200300d82f0e2c00d6bb8859fbbcb8a9.dip0.t-ipconnect.de. [2003:d8:2f0e:2c00:d6bb:8859:fbbc:b8a9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b95f4sm14512834f8f.23.2025.08.04.00.48.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 00:48:17 -0700 (PDT)
Message-ID: <16c98fa8-e85c-4aa2-bf53-ba070833661c@redhat.com>
Date: Mon, 4 Aug 2025 09:48:15 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] mm/hmm: HMM API to enable P2P DMA for device
 private pages
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alistair Popple <apopple@nvidia.com>, Matthew Wilcox
 <willy@infradead.org>, Yonatan Maman <ymaman@nvidia.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Leon Romanovsky
 <leon@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ben Skeggs <bskeggs@nvidia.com>,
 Michael Guralnik <michaelgur@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>,
 Daisuke Matsuda <dskmtsd@gmail.com>, Shay Drory <shayd@nvidia.com>,
 linux-mm@kvack.org, linux-rdma@vger.kernel.org,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Gal Shalom <GalShalom@nvidia.com>
References: <aHpXXKTaqp8FUhmq@casper.infradead.org>
 <20250718144442.GG2206214@ziepe.ca> <aH4_QaNtIJMrPqOw@casper.infradead.org>
 <7lvduvov3rvfsgixbkyyinnzz3plpp3szxam46ccgjmh6v5d7q@zoz4k723vs3d>
 <aIBcTpC9Te7YIe4J@ziepe.ca>
 <cn7hcxskr5prkc3jnd4vzzeau5weevzumcspzfayeiwdexkkfe@ovvgraqo7svh>
 <a3f1af02-ef3f-40f8-be79-4c3929a59bb7@redhat.com>
 <i5ya3n7bhhufpczprtp2ndg7bxtykoyjtsfae6dfdqk2rfz6ix@nzwnhqfwh6rq>
 <20250801164058.GD26511@ziepe.ca>
 <b8009500-8b0b-4bb9-ae5e-6d2135adbfdd@redhat.com>
 <20250801165749.GF26511@ziepe.ca>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250801165749.GF26511@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.08.25 18:57, Jason Gunthorpe wrote:
> On Fri, Aug 01, 2025 at 06:50:18PM +0200, David Hildenbrand wrote:
>> On 01.08.25 18:40, Jason Gunthorpe wrote:
>>> On Fri, Jul 25, 2025 at 10:31:25AM +1000, Alistair Popple wrote:
>>>
>>>> The only issue would be if there were generic code paths that somehow have a
>>>> raw pfn obtained from neither a page-table walk or struct page. My assumption
>>>> (yet to be proven/tested) is that these paths don't exist.
>>>
>>> hmm does it, it encodes the device private into a pfn and expects the
>>> caller to do pfn to page.
>>>
>>> This isn't set in stone and could be changed..
>>>
>>> But broadly, you'd want to entirely eliminate the ability to go from
>>> pfn to device private or from device private to pfn.
>>>
>>> Instead you'd want to work on some (space #, space index) tuple, maybe
>>> encoded in a pfn_t, but absolutely and typesafely distinct. Each
>>> driver gets its own 0 based space for device private information, the
>>> space is effectively the pgmap.
>>>
>>> And if you do this, maybe we don't need struct page (I mean the type!)
>>> backing device memory at all.... Which would be a very worthwhile
>>> project.
>>>
>>> Do we ever even use anything in the device private struct page? Do we
>>> refcount it?
>>
>> ref-counted and map-counted ...
> 
> Hm, so it would turn into another struct page split up where we get
> ourselves a struct device_private and change all the places touching
> its refcount and mapcount to use the new type.

We're already working with folios in all cases where we modify either 
refcount or mapcount IIUC.

The rmap handling (try to migrate, soon folio splitting) currently 
depends on the mapcount.

Not sure how that will all look like without a ... struct folio / struct 
page.

-- 
Cheers,

David / dhildenb


