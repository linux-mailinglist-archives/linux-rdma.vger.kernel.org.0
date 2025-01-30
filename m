Return-Path: <linux-rdma+bounces-7344-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 003DDA23347
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2025 18:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E0D51883328
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2025 17:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FB91F03C4;
	Thu, 30 Jan 2025 17:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LfsE6GDQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD901EF0A1
	for <linux-rdma@vger.kernel.org>; Thu, 30 Jan 2025 17:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738258941; cv=none; b=V37xPvUaIpjjYqb2B55eAcAznvUhtRJ6cUMFItu79JAp7xTi6ero9W4oPawlzuePuVaD/XUTd5iRUjSrqfIXAzPlpUwX+Sn/ubyuwsxDFdu0qke9JvY5pKoQIBzoiPNv0LsUcS391zDEHfzVx0RoW/trQZo5esXZg0sg2HRTYIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738258941; c=relaxed/simple;
	bh=XtQCDwDTly37QPz8i9jNWoc4Mmbx4e+kSb49dC5tsSc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHg8nrbQSbkpPPxAk9tc17gEX/GOedqWyjkV0SbzeON+bbm8wRM+EWRW+cinrRKFi59QVKdwxpj51anvGMqTjBDg4mlcLM90ZDuzAEZjfMkldnpEXGDHBwicaxnWqPkBvQXEMMfB5Ew5lQ79di6JgpxrVAWonF16CrxfOkDXv5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LfsE6GDQ; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-467918c360aso11074421cf.0
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jan 2025 09:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1738258938; x=1738863738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CVNKXypQwOopSf1xgwOwZSkCQwewZeK8ItDq6p8m+EY=;
        b=LfsE6GDQbmYz3qyZKrOOziUjzv179Xd1geXzDq1D1pJ1I3nL4P/i9faJFv9Mafzuf/
         XRNY3NccZdtAfzb19CipjL0ZlTTuj41b8kkLmh59wxXq7OwNlsA7NfYC2BfcpG6umeYg
         30bih2wE91r8OTRvykqMRowpx4/Dzg4LgxeUuS9T/bMT/LUJcRBzJ3PgFfsL8ORdulNT
         M5awNuStAudAyLBH9Mgkjc7PXFTkNUS+xMtRI2wtWmXPucEQThOrrlqKvbnQ4QvEyUMH
         Qm8PlG/V7lW3XKxvJsTp9nco93OtVB8q7Uoa9c2xF1AQFDBp/hnCQe2wNcTaI+cWIv8P
         caxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738258938; x=1738863738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVNKXypQwOopSf1xgwOwZSkCQwewZeK8ItDq6p8m+EY=;
        b=tft96w+QeE6U2D/W3wgqI7Q6V8Z5XYR3sj3qgQKX3dUC9+uZ8WJDg5KNcj33xgU53w
         bniJEG/rOZSakkVBuGvOtyPAo4brcr1AXmkDBTi0+Wf75gQbH6PV7jS7FHa8aPOnORUN
         Wl1BLpnOaF8OHUwYM01JhymKeSMDvw/paBWuR1Dm6mMKzXf/uEtwWSnW2RuTldC/+j/V
         l5ugS65JyqzguqV0M6cZsUvXSgO5i4uI+AISmP2eNpbK25X9O+gRq7KnPSP0QjpOlGOy
         6lPBK1njsRiH1tEJd3oFtnmIab33JP8a8ght1cj0IH3jaNxsAejwuqTt90gemS98FEfZ
         aASQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5NdKxeeqLfLQp6cpYA+ejTJDCM3NZgNADrtubtrFhHhR6WX0fsWHaMKxHivGaqxtX0tObjVRbMC7Y@vger.kernel.org
X-Gm-Message-State: AOJu0YzqkC1qij2purYNI6AQ0sF7kPWgAKW6bMpHeblFqGyXKnQ4YEHC
	EF9L49LVyZC5uRdisX5J0X/Am7xYbAOLfkmstwi/ZFOiSXCbMYaChZTdIaoJwfw=
X-Gm-Gg: ASbGnctuWIbNHOoulAFECZQ55N0XhO9IWLvxhRCyuZ6hTP4Qew6J2SGYu14wdfI9gfj
	IxQbfJwmN5KlcjTGtbwJ6tzIl0M5PkWpXqBYIpa4yiQGoSaMChblAOk8lNLLAlNAdv+rvIv3oVy
	5UyUEzPCc9SobXPGfRc78Fzq5F+fADi2weFsyrlnlsvGYw2aDj0GivZpR3DS7gAhCNMxUtcPzW8
	2YwsJ3oSgX1wVYMptk2HQdm14tnIZt6eokdSP+tlqYl2Yze7452rKrhqqJn/6xMa1SbnKkpCDzG
	ZiLFrCDV7cdgDzpp6hjdsBRzDXVsFqpfBvihmOrab5oO817c2c9G/87xc5IwUgmO
X-Google-Smtp-Source: AGHT+IFnQ+3H7xNChFVcqgc9dwjk4L8UEnbD/nNL/ykdDG0Q22FK3UpLRKkWb0FWjYtvwvzMuLT+BQ==
X-Received: by 2002:a05:622a:4296:b0:467:451b:eba3 with SMTP id d75a77b69052e-46fd0a7fe1dmr108793531cf.8.1738258938311;
        Thu, 30 Jan 2025 09:42:18 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46fdf0ceacesm8793061cf.31.2025.01.30.09.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 09:42:17 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tdYYT-00000009ew4-0Jjs;
	Thu, 30 Jan 2025 13:42:17 -0400
Date: Thu, 30 Jan 2025 13:42:17 -0400
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
Message-ID: <20250130174217.GA2296753@ziepe.ca>
References: <20250128132034.GA1524382@ziepe.ca>
 <de293a7e9b4c44eab8792b31a4605cc9e93b2bf5.camel@linux.intel.com>
 <20250128151610.GC1524382@ziepe.ca>
 <b78d32e13811ef1fa57b0535749c811f2afb4dcd.camel@linux.intel.com>
 <20250128172123.GD1524382@ziepe.ca>
 <Z5ovcnX2zVoqdomA@phenom.ffwll.local>
 <20250129134757.GA2120662@ziepe.ca>
 <Z5tZc0OQukfZEr3H@phenom.ffwll.local>
 <20250130132317.GG2120662@ziepe.ca>
 <Z5ukSNjvmQcXsZTm@phenom.ffwll.local>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5ukSNjvmQcXsZTm@phenom.ffwll.local>

On Thu, Jan 30, 2025 at 05:09:44PM +0100, Simona Vetter wrote:

> > You could also use an integer instead of a pointer to indicate the
> > cluster of interconnect, I think there are many options..
> 
> Hm yeah I guess an integer allocater of the atomic_inc kind plus "surely
> 32bit is enough" could work. But I don't think it's needed, if we can
> reliable just unregister the entire dev_pagemap and then just set up a new
> one. Plus that avoids thinking about which barriers we might need where
> exactly all over mm code that looks at the owner field.

IMHO that is the best answer if it works for the driver.
> > ? It is supposed to work, it blocks until all the pages are freed, but
> > AFAIK ther is no fundamental life time issue. The driver is
> > responsible to free all its usage.
> 
> Hm I looked at it again, and I guess with the fixes to make migration to
> system memory work reliable in Matt Brost's latest series it should indeed
> work reliable. The devm_ version still freaks me out because of how easily
> people misuse these for things that are memory allocations.

I also don't like the devm stuff, especially in costly places like
this. Oh well.

> > > An optional callback is a lot less scary to me here (or redoing
> > > hmm_range_fault or whacking the migration helpers a few times) looks a lot
> > > less scary than making pgmap->owner mutable in some fashion.
> > 
> > It extra for every single 4k page on every user :\
> > 
> > And what are you going to do better inside this callback?
> 
> Having more comfy illusions :-P

Exactly!

> Slightly more seriously, I can grab some locks and make life easier,

Yes, but then see my concern about performance again. Now you are
locking/unlocking every 4k? And then it still races since it can
change after hmm_range_fault returns. That's not small, and not really
better.

> whereas sprinkling locking or even barriers over pgmap->owner in core mm
> is not going to fly. Plus more flexibility, e.g. when the interconnect
> doesn't work for atomics or some other funny reason it only works for some
> of the traffic, where you need to more dynamically decide where memory is
> ok to sit.

Sure, an asymmetric mess could be problematic, and we might need more
later, but lets get to that first..

> Or checking p2pdma connectivity and all that stuff.

Should be done in the core code, don't want drivers open coding this
stuff.

> Also note that fundamentally you can't protect against the hotunplug or
> driver unload case for hardware access. So some access will go to nowhere
> when that happens, until we've torn down all the mappings and migrated
> memory out.

I think a literal (safe!) hot unplug must always use the page map
revoke, and that should be safely locked between hmm_range_fault and
the notifier.

If the underlying fabric is loosing operations during an unplanned hot
unplug I expect things will need resets to recover..

Jason

