Return-Path: <linux-rdma+bounces-8839-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0168DA697E4
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 19:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657361B63C9E
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 18:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B306720AF71;
	Wed, 19 Mar 2025 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="IwdnQzDj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FDC1DF996
	for <linux-rdma@vger.kernel.org>; Wed, 19 Mar 2025 18:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742408496; cv=none; b=rkd+82auCHfiVHKnbBgTCzDnaacElRsN6BfXu7bgDYgW00NPE2RAGXRVKaLllrYA/d55pFIdatd+3GDCOo0Ug7pTmbrnyskFLjGnpZAIfjLQ6YpppRjUmNyGwW+uhXg2osoYdPHqWfmkJa66lcfOSA5ytijoztUhNujYpez8Lqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742408496; c=relaxed/simple;
	bh=NtDAWduIJ0DMkA5XmREwx3R7wbLxEkO24PD+uuiHALU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tHoUIrhg3zm6eyzve+XztaLWug5KaShn2YMImySXfDWVb5HM0+fMMAteCFAbCEKM9p7AsPn0sRQtwcnaKRUUPqoEOfjq8ugMDC3PDco4RcVn6QsPw4r5yRh8JWiS+KnaNXa7JYyiy0gYmW7JU2ra6EA8D+b+vP2Vs91wWNIRyq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=IwdnQzDj; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22398e09e39so162274785ad.3
        for <linux-rdma@vger.kernel.org>; Wed, 19 Mar 2025 11:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1742408494; x=1743013294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtDAWduIJ0DMkA5XmREwx3R7wbLxEkO24PD+uuiHALU=;
        b=IwdnQzDjyArzY1vKPKagKLRwOvf+eWfEea9MZ1vLhlsRZOkUrYSPSf2f4XM5zzGYHQ
         TlMZ2MjZ+4nvaW6jhouAuGZjNu8aC5cKC5/K94JOw6Q9jpEfuOny6kXw9qWoaPSSwaAb
         NkzpxT6/WCwPv3O3XFl91Gc8f/8qrFpFz6JXemNLD4RFH+PySw6Ffr3CDOOzEvYWwzvi
         cR06WtXOlJ4HTBz7NqfW/HKPuz1JU5NV+AEdxgvvdmnQf50G/IATYQfeSxAX+8DQXQYv
         3/Khe4AF7BDb9P0taTs7agdXAmxLOwZSFI8kfNExiyR/ZyksusYPzAj2h0XYYDx2KG+v
         Qs2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742408494; x=1743013294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NtDAWduIJ0DMkA5XmREwx3R7wbLxEkO24PD+uuiHALU=;
        b=h8CU9f+W8LlRRo3AB/l+Qw4oDqjLoPL2VxRvwW1etqfslq1Uxyxk3fhsrO05oXRLbK
         IeGUMPyMvPzfX9u6j8QKBWAoDmYCnjqUEVGvi8vHHd6HSEdGJXfF0Hng245JyR6ANnaO
         GdH6wM5MNP5oxXCwWppeM1zVJjdT3sGSTVl8xAHzmuJGI/GaVZZvsnY0SGh0Z9gRdOkE
         HJU12aKAWfOvf3dAhQagBsgbFhtTWTzV9ThTuZQsALGXqSFT2/2B6EVwxCxjl85Wm9cK
         vimPN8bulm2UKAprpt8IlgAp/FlEIXbLT8d990jw+Aj5pJSuc0lLQWIYM4jYS2eI/+xe
         JXQw==
X-Forwarded-Encrypted: i=1; AJvYcCUQH8IFKii7OZAppok20XBGZWUxdXVXFpbnHovWo6r3G+mylzPlHl2iSpCKpAHsQw+ZQcTqZbV3I7cu@vger.kernel.org
X-Gm-Message-State: AOJu0YxcTJh18m+8lxfEm5EXBMWeoWWTGDZBN5MxOPeRuPBCsLL++B2n
	Y1lxqRJkh4FeDC/Sl9ljSscm9kSBZP9JlzLQYf+NaTv1mOOnqZxnPLgJ9jJe5KXtef8/y4VsEo+
	dPizBYZQg5jezFMfj4yACM9Uflzopq3V8r5Jm
X-Gm-Gg: ASbGncshl6JLJQf0bBH851/+lj1qxAxmJaYiqK9EBP6NiN7/uDpVyXroj0wnwqw+csa
	AtDLaxnkRQZqd0yrVWukZejYcszg2+L6bpxfepnqjuLfR/VXEkqXDppiodhRyUlFrfBg8gAlC+A
	I/1zCWvBKH8riITnAtvJjahrJS9Q==
X-Google-Smtp-Source: AGHT+IFopH9nZEZbQV7g62Dl17S0T6JheQrT+60dYsze0ZA1ycT5mvCSw+Ck4ZiinMyRDNO0eI3ozdD24VPjVb5R3VQ=
X-Received: by 2002:a05:6a00:18a7:b0:736:51a6:78af with SMTP id
 d2e1a72fcca58-7377a86691emr353303b3a.12.1742408494111; Wed, 19 Mar 2025
 11:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250308184650.GV1955273@unreal> <2f06a40d-2f14-439a-9c95-0231dce5772d@enfabrica.net>
 <20250312112921.GA1322339@unreal> <86af1a4b-e988-4402-aed2-60609c319dc1@enfabrica.net>
 <20250312151037.GE1322339@unreal> <CAM0EoMnJW7zJ2_DBm2geTpTnc5ZenNgvcXkLn1eXk4Tu0H0R+A@mail.gmail.com>
 <20250318224912.GB9311@nvidia.com>
In-Reply-To: <20250318224912.GB9311@nvidia.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 19 Mar 2025 14:21:23 -0400
X-Gm-Features: AQ5f1JpdU2ST-7Y6BksQjQ1exxLJY-6SC-lNCemGdebRpu7wkl_hr1UWdWM55xE
Message-ID: <CAM0EoMkVz8HfEUg33hptE91nddSrao7=6BzkUS-3YDyHQeOhVw@mail.gmail.com>
Subject: Re: Netlink vs ioctl WAS(Re: [RFC PATCH 00/13] Ultra Ethernet driver introduction
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Nikolay Aleksandrov <nikolay@enfabrica.net>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, Shrijeet Mukherjee <shrijeet@enfabrica.net>, alex.badea@keysight.com, 
	eric.davis@broadcom.com, rip.sohan@amd.com, David Ahern <dsahern@kernel.org>, 
	bmt@zurich.ibm.com, roland@enfabrica.net, 
	Winston Liu <winston.liu@keysight.com>, dan.mihailescu@keysight.com, kheib@redhat.com, 
	parth.v.parikh@keysight.com, davem@redhat.com, ian.ziemba@hpe.com, 
	andrew.tauferner@cornelisnetworks.com, welch@hpe.com, 
	rakhahari.bhunia@keysight.com, kingshuk.mandal@keysight.com, 
	linux-rdma@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 6:49=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Sat, Mar 15, 2025 at 04:49:20PM -0400, Jamal Hadi Salim wrote:
>
> > On "unreliable": This is typically a result of some request response
> > (or a subscribed to event) whose execution has failed to allocate
> > memory in the kernel or overrun some buffers towards user space;
> > however, any such failures are signalled to user space and can be
> > recovered from.
>
> No, they can't be recovered from in all cases.
> Randomly failing system
> calls because of memory pressure is a horrible foundation to build
> what something like RDMA needs. It is not acceptable that something
> like a destroy system call would just randomly fail because the kernel
> is OOMing. There is no recovery from this beyond leaking memory - the
> opposite of what you want in an OOM situation.
>

Curious how you guarantee that a "destroy" will not fail under OOM. Do
you have pre-allocated memory?
Note: Basic request-response netlink messaging like a destroy which
merely returns you a success/fail indication _should not fail_ once
that message hits the kernel consumer (example tc subsystem). A
request to destroy or create something in the kernel for example would
be a fit.
Things that may fail because of memory pressure are requests that
solicit data(typically lots of data) from the kernel, example if you
dump a large kernel table that wont fit in one netlink message, it
will be sent to you/user in multiple messages; somewhere after the
first chunk gets sent your way we may hit an oom issue. For these
sorts of message types, user space will be signalled so it can
recover. "Recover" could be to issue another message to continue where
we left off....

> > ioctl is synchronous which gives it the "reliability" and "speed".
> > iirc, if memory failure was to happen on ioctl it will block until it
> > is successful?
>
> It would fail back to userspace and unwind whatever it did.
>

Very similar with netlink.

> The unwinding is tricky and RDMA's infrastructure has alot of support
> to make it easier for driver writers to get this right in all the
> different error cases.
>
> Overall systems calls here should either succeed or fail and be the
> same as a NOP. No failure that actually did something and then creates
> some resource leak or something because userspace didn't know about
> it.
>

Yes, this is how netlink works as well. If a failure to delete an
object occurs then every transient state gets restored. This is always
the case for simple requests(a delete/create/update). For requests
that batch multiple objects there are cases where there is no
unwinding. Example you could send a request to create a bunch of
objects in the kernel and half way through the kernel fails for
whatever and has to bail out.
Most of the subsystems i have seen as such return a "success", even
though they only succeeded on the first half. Some return a success
with a count of how many objects were created.
It is feasible on a per subsystem level to set flags which would
instruct the kernel of which mode to use, etc.

> > Extensibility: ioctl take binary structs which make it much harder to
> > extend but adds to that "speed". Once you pick your struct, you are
> > stuck with it - as opposed to netlink which uses very extensible
> > formally defined TLVs that makes it highly extensible.
>
> RDMA uses TLVs now too. It has one of the largest uAPI surfaces in the
> kernel, TLVs were introduced for the same reason netlink uses them.
>

Makes sense. So ioctls with TLVs ;->
I am suspecting you don't have concepts of TLVs inside TLVs for
hierarchies within objects.

> RDMA also has special infrastructure to split up the TLV space between
> core code and HW driver code which is a key feature and necessary part
> of how you'd build a user/kernel split driver.
>

The T namespace is split between core code and driver code?
I can see that as being useful for debugging maybe? What else?

> > - And as Nik mentioned: The new (yaml)model-to-generatedcode approach
> > that is now common in generic netlink highly reduces developer effort.
> > Although in my opinion we really need this stuff integrated into tools
> > like iproute2..
>
> RDMA also has a DSL like scheme for defining schema, and centralized
> parsing and validation. IMHO it's capability falls someplace between
> the old netlink policy stuff and the new YAML stuff.
>

I meant the ability to start with a data model and generate code as
being useful.
Where can i find the RDMA DSL?

> But just focusing on schema and TLVs really undersells all the
> specialized infrastructure that exists for managing objects, security,
> HW pass through and other infrastructure things unique to RDMA.
>

I dont know enough about RDMA infra to comment but iiuc, you are
saying that it is the control infrastructure (that sits in
userspace?), that does all those things you mention, that is more
important.
IMO, when you start building complex systems that's always the case
(the "mechanism vs. policy" principle).


cheers,
jamal

