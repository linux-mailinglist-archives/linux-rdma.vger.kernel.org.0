Return-Path: <linux-rdma+bounces-8747-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F815A64FF0
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 13:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4B2D1713C7
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 12:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04525238169;
	Mon, 17 Mar 2025 12:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q47tLn9a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A5121D58B;
	Mon, 17 Mar 2025 12:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742216276; cv=none; b=jNxLcw6x4bseyJPkUIvTrT398ZI9xzdb4Zb6Zj0ZRrYRVLkO39xNKIvGI+9ihXDO6fztO31k4rzVWUBevrFwf7h1GtoMhnUiB4C9aVxM3nB90dhpH1uCUW6HOBmZIeZBrlhL01/kl3xIXFrbBnW+hDcjsXDrOIzmoAv06QsxjcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742216276; c=relaxed/simple;
	bh=tie5cNQNNOKAGGpjnb7yYKZDXUV1cbmjGmDxzDB6ffE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hyG1mODrMawZdEg/gYNjwDIpvblvplN/EZtIprjV2Y3bnd64+BacKlRaLjdAQLABjBnnQDGWcQu25Bl6g8Cx9k0TY8Iqhu0NEiLE8nxe0EIXhDXfgeKb6pUA+6aVryP2PjFBmfvTi4/3cRNWJJig/5zMC/QDsHat7R9/YxJZOLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q47tLn9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56566C4CEE9;
	Mon, 17 Mar 2025 12:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742216276;
	bh=tie5cNQNNOKAGGpjnb7yYKZDXUV1cbmjGmDxzDB6ffE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q47tLn9aSACDRnunoRptzxtbJBYpQboecp1cqJpIzy9YcudznxqRhb4dBU8wWi09D
	 hNKxixH+7/0sj+V8Zsm/Vy9kSkNaVJTh+N7yqlx2BnVLneNC0ytl88g08W2BbMWYO4
	 KOJBwAaDypIVMm+ebWYU7p+Alg3Z/sYktvjypIUtF1lZe00HqIWyjwmaFBDKbXUZQr
	 Kx/as4W5GkaU0ksOzHKng+quZjC7JOQ/7Ne+WugIAhCDozqtg5lMsmtAeWqmlFIOWN
	 7qo5HA+s65Bmsd5PShbgsazqNkQeYIsI/UtD7Ekcb0j/4El+frwAygnw2GgEP28kg2
	 kw/6GyeAd3znA==
Date: Mon, 17 Mar 2025 14:57:51 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Nikolay Aleksandrov <nikolay@enfabrica.net>,
	Linux Kernel Network Developers <netdev@vger.kernel.org>,
	Shrijeet Mukherjee <shrijeet@enfabrica.net>,
	alex.badea@keysight.com, eric.davis@broadcom.com, rip.sohan@amd.com,
	David Ahern <dsahern@kernel.org>, bmt@zurich.ibm.com,
	roland@enfabrica.net, Winston Liu <winston.liu@keysight.com>,
	dan.mihailescu@keysight.com, kheib@redhat.com,
	parth.v.parikh@keysight.com, davem@redhat.com, ian.ziemba@hpe.com,
	andrew.tauferner@cornelisnetworks.com, welch@hpe.com,
	rakhahari.bhunia@keysight.com, kingshuk.mandal@keysight.com,
	linux-rdma@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: Netlink vs ioctl WAS(Re: [RFC PATCH 00/13] Ultra Ethernet driver
 introduction
Message-ID: <20250317125751.GW1322339@unreal>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250308184650.GV1955273@unreal>
 <2f06a40d-2f14-439a-9c95-0231dce5772d@enfabrica.net>
 <20250312112921.GA1322339@unreal>
 <86af1a4b-e988-4402-aed2-60609c319dc1@enfabrica.net>
 <20250312151037.GE1322339@unreal>
 <CAM0EoMnJW7zJ2_DBm2geTpTnc5ZenNgvcXkLn1eXk4Tu0H0R+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMnJW7zJ2_DBm2geTpTnc5ZenNgvcXkLn1eXk4Tu0H0R+A@mail.gmail.com>

On Sat, Mar 15, 2025 at 04:49:20PM -0400, Jamal Hadi Salim wrote:
> On Wed, Mar 12, 2025 at 11:11 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Wed, Mar 12, 2025 at 04:20:08PM +0200, Nikolay Aleksandrov wrote:
> > > On 3/12/25 1:29 PM, Leon Romanovsky wrote:
> > > > On Wed, Mar 12, 2025 at 11:40:05AM +0200, Nikolay Aleksandrov wrote:
> > > >> On 3/8/25 8:46 PM, Leon Romanovsky wrote:
> > > >>> On Fri, Mar 07, 2025 at 01:01:50AM +0200, Nikolay Aleksandrov wrote:
> > > [snip]
> > > >> Also we have the ephemeral PDC connections>> that come and go as
> > > needed. There more such objects coming with more
> > > >> state, configuration and lifecycle management. That is why we added a
> > > >> separate netlink family to cleanly manage them without trying to fit
> > > >> a square peg in a round hole so to speak.
> > > >
> > > > Yeah, I saw that you are planning to use netlink to manage objects,
> > > > which is very questionable. It is slow, unreliable, requires sockets,
> > > > needs more parsing logic e.t.c
> 
> To chime in on the above re: netlink vs ioctl,
> [this is going to be a long message - over caffeinated and stuck on a trip....]
> 
> On "slow" - Mostly netlink can be deemed to "slow" for the following
> reasons 1) locks - which over the last year have been highly reduced
> 2) crossing user/kernel - which i believe is fixable with some mmap
> scheme (although past attempts at doing this have been unsuccessful)
> 3)async vs ioctl sync (more below)
> 
> On "unreliable": This is typically a result of some request response
> (or a subscribed to event) whose execution has failed to allocate
> memory in the kernel or overrun some buffers towards user space;
> however, any such failures are signalled to user space and can be
> recovered from.
> 
> ioctl is synchronous which gives it the "reliability" and "speed".
> iirc, if memory failure was to happen on ioctl it will block until it
> is successful? vs netlink which is async and will get signalled to
> user space if data is lost or cant be fully delivered. Example, if a
> user issued a dump of a very large amount of data from the kernel and
> that data wasnt fully delivered perhaps because of memory pressure,
> user space will be notified via socket errors and can use that info to
> recover.
> 
> Extensibility: ioctl take binary structs which make it much harder to
> extend but adds to that "speed". Once you pick your struct, you are
> stuck with it - as opposed to netlink which uses very extensible
> formally defined TLVs that makes it highly extensible. Yes,
> extensibility requires more parsing as you stated above. Note: if you
> have one-offs you could just hardcode a ioctl-like data structure into
> a TLV and use blocking netlink sockets and that should get you pretty
> close to ioctl "speed"
> 
> To build more on reliability: if you really cared, there are
> mechanisms which can be used to build a fully reliable mechanism of
> communication with the kernel since netlink is infact a wire protocol
> (which alas has been broken for a while because you cant really use it
> as a wire protocol across machines); see for example:
> https://datatracker.ietf.org/doc/html/rfc3549#section-2.3.2.1
> And if you dont really care about reliability you can just shoot
> messages into the kernel and turn off the ACK flag (and then issue
> requests when you feel you need to check on configuration).
> 
> Debuggability: extended ACKs(heavily used by networking) provide an
> excellent operational information user space in fine grained details
> on errors (famous EINVAL can tell you exactly what the EINVAL means
> for example).
> 
> netlink has a multicast publish-subscribe mechanism. Multicast being
> one-to-many means multi-user(important detail for both scaling and
> independent debugging) interface. Meaning you can have multiple
> processes subscribing to events that the kernel publishes. You dont
> have to resort to polling the kernel for details of dynamic changes
> (example "a new entry has been added to table foo" etc)
> As a matter of fact, original design  used to allow user space to
> advertise to both kernel and other user space apps (and unicast worked
> to/from kernel/user and user/user). I haent looked at that recently,
> so it could be broken.
> Note: while these events are also subject to message loss - netlink
> robustness described earlier is usable here as well (via socket
> errors).
> Example, if the kernel attempted to send an event which had the
> misfortune of not making it - user will be notified and can recover by
> requesting a related table dump, etc to see what changed..
> 
> - And as Nik mentioned: The new (yaml)model-to-generatedcode approach
> that is now common in generic netlink highly reduces developer effort.
> Although in my opinion we really need this stuff integrated into tools
> like iproute2..
> 
> I am pretty sure i left out some important details (maybe i can write
> a small doc when i am in better shape).

Thanks for such a detailed answer. I'm not against netlink, I'm against
netlink to configure complex HW objects.

Thanks

> 
> cheers,
> jamal
> 

