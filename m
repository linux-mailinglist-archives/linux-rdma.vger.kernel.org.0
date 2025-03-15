Return-Path: <linux-rdma+bounces-8723-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7BEA63285
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Mar 2025 21:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F9623B3B1C
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Mar 2025 20:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0992C1A00FE;
	Sat, 15 Mar 2025 20:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="GlnRKREM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AB819DF7A
	for <linux-rdma@vger.kernel.org>; Sat, 15 Mar 2025 20:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742071774; cv=none; b=oZ+SZWemJwErEi+eS5QwWY17Z+q3dglc7z1XxTBlFvZky96D8BgKtanoxmIh+NBNsFo8M8Mfzyrd0Kaf6p9WrVvx4GPpBBY0ahkI+YnvYrm0FprToB9gPQg4U6Y4muGaPcpDZWhfiFxNl6RunYYW2w/NkQbRhKHbRWkuzko6+yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742071774; c=relaxed/simple;
	bh=ICCCP2ODzu2DygdB49IkjulgNDHo870JBp88f2EADNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rncaj2L3Jz69QfBZp7g/WYYTwDa82P3OGckJg6BV43+yNXm5mOZ9D582wcXsUCvH7kUK7z0PT2QwfXYgyG8xTG7wxBnVgyX9MKmhDvfCk53f1we3xwiY/h03m9sgwFtPxBviPapxFLQrr985wzXz6e/DYwFJVaPUA64zavsSxTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=GlnRKREM; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2232aead377so71040875ad.0
        for <linux-rdma@vger.kernel.org>; Sat, 15 Mar 2025 13:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1742071771; x=1742676571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kKPpz/nYYIJlsV/329maujDFvEP7JP5/UWkW+NWn/M=;
        b=GlnRKREM1g8rQ43Bm2y6sTzB+gvZW3fv1BCxM1EM0jsKuTs7WPnJK9bNCJSxwmbQaJ
         z9LcA76oBgY2nFETPkCGCbS26nx8irDFe/22S67Ylih7vsbCMKfa0SkCQthrbHUgFXpC
         53XuzXGbMlE61syqSKHXCIp9sLtT7FIaW1pOVKAVf4fJ54tMD9zXQ/C5bS1Xqcr696bP
         Pmz6EsTx1fC/bwULJFkjfBGFoZgZE+O3gKYSSdXOA+HBE6RyC6t8zeqzE9JxKwkbHY2b
         iJ8SVWRGPYHER2MZdpQm6oD72sb3Jd69Hf0/qynAxIoAl3WStIsbpYmIELnk7/wCToYi
         1x2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742071771; x=1742676571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kKPpz/nYYIJlsV/329maujDFvEP7JP5/UWkW+NWn/M=;
        b=jwafQ7/aa1uyw96cthJajOn5uiikOvit08c++naDMOxcdL8tanOcdbBstqf/WA60Ey
         uiF7ALHQ+6O6lsbW0BUv3LlJCcvEYgC2JU0DMWPldHa0cgTHOWWQ38jtINetmZ+PFXZg
         Sz1DyuSJR0oDi6NHLdLaZDInT8b2ev4QIoJ6BSigp4WX2ufdlswNa8nKwYQnj641tTkU
         N3AJq+4481TbrPXW2nhOfOpFOMop28DSI7+v7G0xEKH9unqMlS7OcBjyBCVDppOsdLUs
         mok1SfftVW9951Rq8HIAmJmQtd8Y49ryLyIyJefSxkAGrfSbFMrsjdwMPyse9/aMV43v
         nWDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBKkZmaNvkVXzRRP7o2hz6bHaDSEXoylj8fBKphibmaX3U2XAJfHIuaztAG5iVjRYqLt4OamftY04U@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6spkTLNafevfIpPpexA1zRgJCXHlfMWA7V54a07KyO/uEqaPh
	zf+aKRHhaJV3f/Ot6rtdiN4N4x5tBTenMcV5Ccyo+1CwpVPAv1vpgqWxp537gva4+Cfjm190eEk
	iy4PdrE0IHx8mgZZMTTdKCAOPoA2NW5Z56UtQ
X-Gm-Gg: ASbGncufYgd4N37KyVCloPtQ4XzIZOhqoMDk9Wgy/ozd3WVes04JkODNJd83aAb+i7w
	OMbvCExJxYlaqmrv0lLjneuGrkX35uLpX+o2VHvEhDNr/zAMGiftLakREEb15pQCCG9KYv5Sig4
	tWXcCfZG4eD6r/fZeTKYiE2SaN
X-Google-Smtp-Source: AGHT+IFy5EqxLSGvqehk+I/TH6QIFDqt9RjCQ+ma8TbC4zlBEQJvTROzFrjJvr7/AzmfhZVfLYw/G+d6+lROazmqMXA=
X-Received: by 2002:a05:6a00:139a:b0:736:3d6c:aa64 with SMTP id
 d2e1a72fcca58-7372246183bmr8535931b3a.21.1742071771324; Sat, 15 Mar 2025
 13:49:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250308184650.GV1955273@unreal> <2f06a40d-2f14-439a-9c95-0231dce5772d@enfabrica.net>
 <20250312112921.GA1322339@unreal> <86af1a4b-e988-4402-aed2-60609c319dc1@enfabrica.net>
 <20250312151037.GE1322339@unreal>
In-Reply-To: <20250312151037.GE1322339@unreal>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 15 Mar 2025 16:49:20 -0400
X-Gm-Features: AQ5f1JoWXQWA1peF1RDhSlkJpuv3y29CGfV5JylPEHf5xJdEK2veozGkuNjBNtw
Message-ID: <CAM0EoMnJW7zJ2_DBm2geTpTnc5ZenNgvcXkLn1eXk4Tu0H0R+A@mail.gmail.com>
Subject: Netlink vs ioctl WAS(Re: [RFC PATCH 00/13] Ultra Ethernet driver introduction
To: Leon Romanovsky <leon@kernel.org>
Cc: Nikolay Aleksandrov <nikolay@enfabrica.net>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, Shrijeet Mukherjee <shrijeet@enfabrica.net>, alex.badea@keysight.com, 
	eric.davis@broadcom.com, rip.sohan@amd.com, David Ahern <dsahern@kernel.org>, 
	bmt@zurich.ibm.com, roland@enfabrica.net, 
	Winston Liu <winston.liu@keysight.com>, dan.mihailescu@keysight.com, kheib@redhat.com, 
	parth.v.parikh@keysight.com, davem@redhat.com, ian.ziemba@hpe.com, 
	andrew.tauferner@cornelisnetworks.com, welch@hpe.com, 
	rakhahari.bhunia@keysight.com, kingshuk.mandal@keysight.com, 
	linux-rdma@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 11:11=E2=80=AFAM Leon Romanovsky <leon@kernel.org> =
wrote:
>
> On Wed, Mar 12, 2025 at 04:20:08PM +0200, Nikolay Aleksandrov wrote:
> > On 3/12/25 1:29 PM, Leon Romanovsky wrote:
> > > On Wed, Mar 12, 2025 at 11:40:05AM +0200, Nikolay Aleksandrov wrote:
> > >> On 3/8/25 8:46 PM, Leon Romanovsky wrote:
> > >>> On Fri, Mar 07, 2025 at 01:01:50AM +0200, Nikolay Aleksandrov wrote=
:
> > [snip]
> > >> Also we have the ephemeral PDC connections>> that come and go as
> > needed. There more such objects coming with more
> > >> state, configuration and lifecycle management. That is why we added =
a
> > >> separate netlink family to cleanly manage them without trying to fit
> > >> a square peg in a round hole so to speak.
> > >
> > > Yeah, I saw that you are planning to use netlink to manage objects,
> > > which is very questionable. It is slow, unreliable, requires sockets,
> > > needs more parsing logic e.t.c

To chime in on the above re: netlink vs ioctl,
[this is going to be a long message - over caffeinated and stuck on a trip.=
...]

On "slow" - Mostly netlink can be deemed to "slow" for the following
reasons 1) locks - which over the last year have been highly reduced
2) crossing user/kernel - which i believe is fixable with some mmap
scheme (although past attempts at doing this have been unsuccessful)
3)async vs ioctl sync (more below)

On "unreliable": This is typically a result of some request response
(or a subscribed to event) whose execution has failed to allocate
memory in the kernel or overrun some buffers towards user space;
however, any such failures are signalled to user space and can be
recovered from.

ioctl is synchronous which gives it the "reliability" and "speed".
iirc, if memory failure was to happen on ioctl it will block until it
is successful? vs netlink which is async and will get signalled to
user space if data is lost or cant be fully delivered. Example, if a
user issued a dump of a very large amount of data from the kernel and
that data wasnt fully delivered perhaps because of memory pressure,
user space will be notified via socket errors and can use that info to
recover.

Extensibility: ioctl take binary structs which make it much harder to
extend but adds to that "speed". Once you pick your struct, you are
stuck with it - as opposed to netlink which uses very extensible
formally defined TLVs that makes it highly extensible. Yes,
extensibility requires more parsing as you stated above. Note: if you
have one-offs you could just hardcode a ioctl-like data structure into
a TLV and use blocking netlink sockets and that should get you pretty
close to ioctl "speed"

To build more on reliability: if you really cared, there are
mechanisms which can be used to build a fully reliable mechanism of
communication with the kernel since netlink is infact a wire protocol
(which alas has been broken for a while because you cant really use it
as a wire protocol across machines); see for example:
https://datatracker.ietf.org/doc/html/rfc3549#section-2.3.2.1
And if you dont really care about reliability you can just shoot
messages into the kernel and turn off the ACK flag (and then issue
requests when you feel you need to check on configuration).

Debuggability: extended ACKs(heavily used by networking) provide an
excellent operational information user space in fine grained details
on errors (famous EINVAL can tell you exactly what the EINVAL means
for example).

netlink has a multicast publish-subscribe mechanism. Multicast being
one-to-many means multi-user(important detail for both scaling and
independent debugging) interface. Meaning you can have multiple
processes subscribing to events that the kernel publishes. You dont
have to resort to polling the kernel for details of dynamic changes
(example "a new entry has been added to table foo" etc)
As a matter of fact, original design  used to allow user space to
advertise to both kernel and other user space apps (and unicast worked
to/from kernel/user and user/user). I haent looked at that recently,
so it could be broken.
Note: while these events are also subject to message loss - netlink
robustness described earlier is usable here as well (via socket
errors).
Example, if the kernel attempted to send an event which had the
misfortune of not making it - user will be notified and can recover by
requesting a related table dump, etc to see what changed..

- And as Nik mentioned: The new (yaml)model-to-generatedcode approach
that is now common in generic netlink highly reduces developer effort.
Although in my opinion we really need this stuff integrated into tools
like iproute2..

I am pretty sure i left out some important details (maybe i can write
a small doc when i am in better shape).

cheers,
jamal

