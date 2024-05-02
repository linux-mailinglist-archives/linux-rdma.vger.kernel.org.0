Return-Path: <linux-rdma+bounces-2205-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 390908B94EC
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2024 08:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5549B20E29
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2024 06:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F123B21A04;
	Thu,  2 May 2024 06:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="evq0rJY8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C9F1C693
	for <linux-rdma@vger.kernel.org>; Thu,  2 May 2024 06:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714632995; cv=none; b=ZAYoYCIUnI2Z8D4mxxbTvC8bbRNlt31Q0FP6Fy2Wgbjt5HciVYj5fZguztn/VzvXGUWrUo6/bk2t9ilskLhXoxh6j9nvTOOm0/PCqq5v9L2jxQFHBbY62iC23jVHDLqYco4RYZxJEZ9OjXfgNjnQjh+Vr+TvPCGTMiIbLowiVbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714632995; c=relaxed/simple;
	bh=EuChPRAm4oDIG6E11x0FkZXBAaBNnO9bzAQeZhVzVXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mmIeTzke8wcfYaJrgwaV8v6RS1/sK7EOZ7lv92boRJKl+9+DRekwcdgcjMuEtWDqr7G/ZuWP2Wo4IPvHgL6K2h59sBKxVE6s0afdC0EQY/P8AAAz3WInwdrB4/Gocb2mCpz/QqDrE1WnO52mmPt52mXIYGXusMog/RWoyqWM61Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=evq0rJY8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714632992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=a98A7PArdae3xZyGNJJv71/CegQfWFJVRXHCuxa9iGU=;
	b=evq0rJY8d7v0LPt8mOpt7LFUpz30edE3peKcOrNln21AC9y+Ul6HEgo7wO6+D5GsUKOLkZ
	Fih7u76nTokTih0Sfechn8OT/l+ztyrUgArOXpbu+rx5NG8JRRRC5RV2ajZ+PTvYLyDuL5
	1naKU+smZYbeMunOjGCKAGwB0Oki2m8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-07vK6KA4OpmAJdGAj3fC0Q-1; Thu, 02 May 2024 02:56:31 -0400
X-MC-Unique: 07vK6KA4OpmAJdGAj3fC0Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-41681022d82so33992735e9.1
        for <linux-rdma@vger.kernel.org>; Wed, 01 May 2024 23:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714632990; x=1715237790;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a98A7PArdae3xZyGNJJv71/CegQfWFJVRXHCuxa9iGU=;
        b=ZpZehvAEualDxJAAlDF1ntnz9GbaC2GZr0es8+zf1shi47lgQhJVec+j+ZyIPZLfB8
         4ZUUiwrt2w1IMhODtkiFxTClw0Q+bPKU7zYs8sE8VoXru/9jLGrCaAeHLvyL6jcGvGhA
         isCJP4L0LdUo0tI1t4bAuSUXIHIAfjfoLekrO+bVwAHt3KWZZnhCNl2GTAveRaycC5WM
         TMQf+AhiLkPNJjzqdxJby6hsbNdLWAOK4PCVPOU7cAceJmcQByV0nk709UrsZ7g+RYX+
         hhUxuaEfBm+oXNmbvka18Q0ZDsd5hQNrribR+HcAmZwfKW2+fTWWQYlR9JgLqtB2Npci
         6U7A==
X-Forwarded-Encrypted: i=1; AJvYcCX7UQwcbYZQzu3fmdVqadfpY3Kl7TcDdhnYkzZKcCjDBxxsodDDD8Tg2nsxHQ6EYauORTHiis3wqhigdVGZoQYwUuofm++zrQHWxg==
X-Gm-Message-State: AOJu0YzMF9nyf+kj2yQa6DaWV7hv2Qvd2dnECP12txHAXFROsQ78T/cK
	bGC7DnvML7uF+d9E/1P9OmIfTPmKO+wry0UDkIYtwVBMnAEywyxCKaGA7fBdxdoQGF/uQXIZvi1
	7DAmr5rysWI7LMJWn+uZeQIgL+Ct13ND8HWBkhzNlQMLW2Mf/+b6C6i/EBDM=
X-Received: by 2002:a05:600c:a46:b0:41b:f116:8c22 with SMTP id c6-20020a05600c0a4600b0041bf1168c22mr928814wmq.14.1714632990388;
        Wed, 01 May 2024 23:56:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0tjyuBHdY2T5BTC4Tlcnj+bXG2O5cvGW9HCXrSE3PGQy8+LgItEt/8T6nh1VX4d+C9KO7BQ==
X-Received: by 2002:a05:600c:a46:b0:41b:f116:8c22 with SMTP id c6-20020a05600c0a4600b0041bf1168c22mr928788wmq.14.1714632989855;
        Wed, 01 May 2024 23:56:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71e:bf00:eba1:3ab9:ab0f:d676? (p200300cbc71ebf00eba13ab9ab0fd676.dip0.t-ipconnect.de. [2003:cb:c71e:bf00:eba1:3ab9:ab0f:d676])
        by smtp.gmail.com with ESMTPSA id k6-20020a05600c478600b004185be4baefsm4614042wmo.0.2024.05.01.23.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 23:56:29 -0700 (PDT)
Message-ID: <92289167-5655-4c51-8dfc-df7ae53fdb7b@redhat.com>
Date: Thu, 2 May 2024 08:56:28 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] RDMA/umem: pin_user_pages*() can temporarily fail due to
 migration glitches
To: Alistair Popple <apopple@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Christoph Hellwig <hch@infradead.org>, John Hubbard
 <jhubbard@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Mike Marciniszyn <mike.marciniszyn@intel.com>,
 Leon Romanovsky <leon@kernel.org>, Artemy Kovalyov <artemyko@nvidia.com>,
 Michael Guralnik <michaelgur@nvidia.com>, Pak Markthub <pmarkthub@nvidia.com>
References: <20240501003117.257735-1-jhubbard@nvidia.com>
 <ZjHO04Rb75TIlmkA@infradead.org> <20240501121032.GA941030@nvidia.com>
 <87r0el3tfi.fsf@nvdebian.thelocal>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <87r0el3tfi.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.05.24 03:05, Alistair Popple wrote:
> 
> Jason Gunthorpe <jgg@nvidia.com> writes:
> 
>> On Tue, Apr 30, 2024 at 10:10:43PM -0700, Christoph Hellwig wrote:
>>>> +		pinned = -ENOMEM;
>>>> +		int attempts = 0;
>>>> +		/*
>>>> +		 * pin_user_pages_fast() can return -EAGAIN, due to falling back
>>>> +		 * to gup-slow and then failing to migrate pages out of
>>>> +		 * ZONE_MOVABLE due to a transient elevated page refcount.
>>>> +		 *
>>>> +		 * One retry is enough to avoid this problem, so far, but let's
>>>> +		 * use a slightly higher retry count just in case even larger
>>>> +		 * systems have a longer-lasting transient refcount problem.
>>>> +		 *
>>>> +		 */
>>>> +		static const int MAX_ATTEMPTS = 3;
>>>> +
>>>> +		while (pinned == -EAGAIN && attempts < MAX_ATTEMPTS) {
>>>> +			pinned = pin_user_pages_fast(cur_base,
>>>> +						     min_t(unsigned long,
>>>> +							npages, PAGE_SIZE /
>>>> +							sizeof(struct page *)),
>>>> +						     gup_flags, page_list);
>>>>   			ret = pinned;
>>>> -			goto umem_release;
>>>> +			attempts++;
>>>> +
>>>> +			if (pinned == -EAGAIN)
>>>> +				continue;
>>>>   		}
>>>> +		if (pinned < 0)
>>>> +			goto umem_release;
>>>
>>> This doesn't make sense.  IFF a blind retry is all that is needed it
>>> should be done in the core functionality.  I fear it's not that easy,
>>> though.
>>
>> +1
>>
>> This migration retry weirdness is a GUP issue, it needs to be solved
>> in the mm not exposed to every pin_user_pages caller.
>>
>> If it turns out ZONE_MOVEABLE pages can't actually be reliably moved
>> then it is pretty broken..
> 
> I wonder if we should remove the arbitrary retry limit in
> migrate_pages() entirely for ZONE_MOVEABLE pages and just loop until
> they migrate? By definition there should only be transient references on
> these pages so why do we need to limit the number of retries in the
> first place?

There are some weird things that still needs fixing: vmsplice() is the 
example that doesn't use FOLL_LONGTERM.

-- 
Cheers,

David / dhildenb


