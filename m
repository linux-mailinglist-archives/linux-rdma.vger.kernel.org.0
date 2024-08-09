Return-Path: <linux-rdma+bounces-4268-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A387A94CD3D
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 11:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5931C282AFA
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 09:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A711917CF;
	Fri,  9 Aug 2024 09:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Pqo+EPFj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81A2190047
	for <linux-rdma@vger.kernel.org>; Fri,  9 Aug 2024 09:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723195305; cv=none; b=FJu9hEkzc52ka2p0UQrwZKg+cmOqJd3FE6g8w6cSy/abVTDKsKMPxqHkCPMw8EtomTyP4DrXKkcull9A1BT1//NfAb9nziARXSVGq8CKFJq7n8/XIpMo6b1zs+0WM5EbmIFbYTrp5Z7Vu9wwsPkZn2300yUytaZE03idYI5/MIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723195305; c=relaxed/simple;
	bh=eFsm4S9EqzosCP9bpNxQD4ILIWCeGvlW6enxZm+5/Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6/69KfXKOK3L03E9LhE2ZrYb1HMsZKUim7W+g9q2E+ynGA+KXTl0gZXIrH7evV+Nd77I1VrUrts6652tR7pYHTzkupZXgnHAqvZc9D6LqBHnE1T9sRU5zOTwPJyB0QbnvMTEf22KWvsAeCGl6KXnqVJ5hCJ8oq8TGL0KN8QK8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=Pqo+EPFj; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5b1a00750a4so160769a12.2
        for <linux-rdma@vger.kernel.org>; Fri, 09 Aug 2024 02:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1723195302; x=1723800102; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ctzkc6mtL+qDk1dSTA7OI2DhOHGb0X4yhbNnieS8/yA=;
        b=Pqo+EPFjesUDp7sK7t5twX7npjIci9+wg/fvQ7802D7XwaiKFskTtw/hQKikisb/sk
         Aq+UwssN/JQgkmLWDpoAvCEutOs3L3ihnjKqB0p2yHMzPitCa2QyftC45JReD8rhhXXD
         FfNRh9VHTMF+5BEl/DY8yiYvoTTiTGg6U3Zdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723195302; x=1723800102;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ctzkc6mtL+qDk1dSTA7OI2DhOHGb0X4yhbNnieS8/yA=;
        b=hzueDEYqYIlUuScMsTp60UUlDugWq3vx2oEWJiv+GGV/yYg3cr3Fb7rE+k5wX34xFN
         E0YMDShNyN7LOUEEUmf8oCODwZrR5MArn34hX3dDb0/wSPQIioviMMppzx9NEF4a2SQR
         hjgFFod/HO0w1bFa+KohTtK8UBxLPTm+SY4GpF5YMnIUTB0O5nNtF9w9/mOva9m0V31g
         cMJJNiznv1oyT+wMSeKLCupJ8V7ypbtfw59AXSnIeKw3+UXEDyr7FcvoJTXMbNh8/wcU
         n5YkmLx1i52WHmC/xQywm6TXuuY21wJfIC0pR/BqJ99r7noVdTcb+LXmGJPuCtMs1iCm
         3iDg==
X-Forwarded-Encrypted: i=1; AJvYcCWCmvXN0+jMJDHB8pZdsC6u1i2RyafrrqIypYyxRBNEEL7KPbS44swabqUZaZ6gI3Nz7ndbH4pXXWa0BoMT+ggd+Hk9wEYoMhAWrA==
X-Gm-Message-State: AOJu0YyJGHQuahYsltNxdGSZ7th7IQRxwTxr7SOdhgVY83h8LXhFmuFn
	KWvAqBzz86oDFyMLdeqUFPzS/2sR+sLePsMPXzCT5VVQayN+FixVj52HjUPL+fY=
X-Google-Smtp-Source: AGHT+IHmHgIr2+mvCU3bZm/Dlajd6oKy6iQIpQANqx6M0y7hWXTKbRgbEICcCB1+aX5FyYyd9XqCQQ==
X-Received: by 2002:a17:906:c103:b0:a7a:a763:842a with SMTP id a640c23a62f3a-a80aa67d0c5mr31354166b.8.1723195302012;
        Fri, 09 Aug 2024 02:21:42 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d88741sm828593166b.150.2024.08.09.02.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 02:21:41 -0700 (PDT)
Date: Fri, 9 Aug 2024 11:21:39 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
	Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v2 6/8] fwctl: Add documentation
Message-ID: <ZrXfo4wFEiIc54U_@phenom.ffwll.local>
References: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <6-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <ZrHY2Bds7oF7KRGz@phenom.ffwll.local>
 <20240808122413.GB8378@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240808122413.GB8378@nvidia.com>
X-Operating-System: Linux phenom 6.9.10-amd64 

On Thu, Aug 08, 2024 at 09:24:13AM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 06, 2024 at 10:03:36AM +0200, Daniel Vetter wrote:
> > On Mon, Jun 24, 2024 at 07:47:30PM -0300, Jason Gunthorpe wrote:
> > > Document the purpose and rules for the fwctl subsystem.
> > > 
> > > Link in kdocs to the doc tree.
> > > 
> > > Nacked-by: Jakub Kicinski <kuba@kernel.org>
> > > Link: https://lore.kernel.org/r/20240603114250.5325279c@kernel.org
> > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > I think we'll need something like fwctl rather sooner than later for gpus
> > too, so for all the fwctl patches up to this one:
> 
> Yes, I think so as well. You can see it already in the various GPU out
> of tree stuff where there is usually some expansive
> monitoring/debug/provisioning tool there too.
> 
> > Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> Thanks!
>  
> > I both really liked the approach to fwctl_unregister and
> > copy_struct_from_user, and didn't spot anything offensive in the code.
> 
> It is copied from iommufd which copied concepts from the fixedup modern
> rdma :) Proven over a few years now.
> 
> > > +Further, within the function, devices often have RPC commands that fall within
> > > +some general scopes of action:
> > 
> > In your fwctl_rpc_scope you only have 4, not 5, and I think that's
> > clearer. Might also be good to put a kerneldoc link to the enum in here
> > for the details.
> 
> I bundled these two together in the enum FWCTL_RPC_CONFIGURATION:

Yeah I figured, but if you want to keep the split it might help that the
kerneldoc for FWCTL_RPC_CONFIGURATION mentions that it includes both
delayed configuration and runtimme configuration from the overview doc. Or
maybe group them here into 1a and 1b.

Also this one is an extremely minor bikeshed, feel free to ignore :-)
 
> > > + 1. Access to function & child configuration, FLASH, etc/ that becomes live at a
> > > +    function reset.
> > > +
> > > + 2. Access to function & child runtime configuration that kernel drivers can
> > > +    discover at runtime.
> > 
> > This one worries me, since it has potential for people to get it very
> > wrong and e.g. expose configuration where it's only safe if the driver
> > isn't bound, or at least no userspace is using it. 
> 
> The notion was "at runtime" meaning any active user of the device
> would either not be aware of whatever change or already have some way
> to learn about it.
> 
> Especially when we think about child configuration - ie configuration
> of a VF from the hypervisor while a VM is running - there can be
> useful things that fit under this category. For instance you might
> throttle the device to support live migration.
> 
> Throttling is a really complex topic for an autonomous device like
> GPU/RDMA.

Yeah these kind of things are imo fine. But when I read your description
of "can discover at runtime" I'm more thinking stuff like number of
compute cores, or channels for communication or whatever. Which you can
discover, but if you don't you discover it by failing because the thing
you thought was there is now suddenly gone.

Ofc the guest can discover throttling by noticing that its gpu suddenly
got a bit (or a lot) slower, but that's a different kind of discover imo.

> > I'd drop this and just
> > leave the one configuration rpc, with maybe more detail what exactly "When
> > configuration is written to the device remains in a fully supported
> > state." 
> 
> Ah, this language is incorporating the distro feedback around loosing
> the ability to support the system.

Maybe I'm just dense, but for me it'd be good to differentiate between
runtime changes like throttling, which generally shouldn't upset
drivers/guests. And changes which can if they don't go actively discover
them, and making it really clear the latter must be delayed until next
reset. Currently I read what you have as including the latter as allowed
without requiring reset, as long as the driver/guest _can_ discover the
change somehow.

So maybe something like this?

2. Access to function & child runtime configuration that are either
transparent to users of that function, or which can be discovered without
disruption (like when the fw/hw function interface makes provisions for
such runtime configuration changes in the programming model).

> > from the kerneldoc means. I think only safe options woulb be a)
> > applied on function reset b) transparent to both kernel and userspace
> > (beyond maybe device performance).
> 
> Let's lean into transparent more:
> 
>  1. Access to function & child configuration, FLASH, etc. that becomes live at a
>     function reset. Access to function & child runtime configuration that is
>     transparent or non-disruptive to any driver or VM.

Ack, sounds really clear to me now.

> 
> > That might not cut all configuration items, but for those I think it'd be
> > best if fwctl guarantees through the driver model that there's no driver
> > bound to that function (or used by vfio/kvm), to guarantee safety. So
> > explicitly split them out as runtime configuration with a distinct rpc
> > scope. Maybe an addition for later.
> 
> No driver bound is too strong. VFIO and even mlx5_core can trigger a
> FLR while still bound in a controlled way. Taking effect at FLR time
> is a reasonable restriction.
> 
> Like if you reconfigure a child VF and then start a VM there will be
> an automatic FLR in that process that can make the updated VF
> configuration active.

Ah yeah if the driver copes/initiates, then it's fine too. Maybe a case of
both hw reset and "no driver bound", but also a case of "details we can
figure out later".
 
> > > + 3. Directly configure or otherwise control kernel drivers. A subsystem kernel
> > > +    driver can react to the device configuration at function reset/driver load
> > > +    time, but otherwise should not be coupled to fwctl.
> > 
> > Kinda the same worry as above, I think this should be "... but otherwise
> > _must_ not be coupled to fwctl".
> 
> Yep
> 
> > > + 4. Operate the HW in a way that overlaps with the core purpose of another
> > > +    primary kernel subsystem, such as read/write to LBAs, send/receive of
> > > +    network packets, or operate an accelerator's data plane.
> > 
> > I still think some words about what to do when fwctl exposes some
> > functional which later on is covered by a newly added subsystem that
> > didn't yet exist. Also maybe adding some more examples from the RAS side
> > of things, since that's come up a few time in the ksummit-discuss thread,
> > plus I think it's where we'll most likely have a new subsystem or extended
> > functionality of an existing one pop up and cause conflicts with fwctl
> > rpcs that have landed earlier.
> 
> How about:
> 
> Operations exposed through fwctl's non-taining interfaces should be fully
> sharable with other users of the device. For instance exposing a RPC through
> fwctl should never prevent a kernel subsystem from also concurrently using that
> same RPC or hardware unit down the road. In such cases fwctl will be less
> important than proper kernel subsystems that eventually emerge. Mistakes in this
> area resulting in clashes will be resolved in favour of a kernel implementation.

Ack.

> 
> > > +fwctl Driver design
> > > +-------------------
> > > +
> > > +In many cases a fwctl driver is going to be part of a larger cross-subsystem
> > > +device possibly using the auxiliary_device mechanism. In that case several
> > > +subsystems are going to be sharing the same device and FW interface layer so the
> > > +device design must already provide for isolation and cooperation between kernel
> > > +subsystems. fwctl should fit into that same model.
> > > +
> > > +Part of the driver should include a description of how its scope restrictions
> > > +and security model work. The driver and FW together must ensure that RPCs
> > > +provided by user space are mapped to the appropriate scope. If the validation is
> > > +done in the driver then the validation can read a 'command effects' report from
> > > +the device, or hardwire the enforcement. If the validation is done in the FW,
> > > +then the driver should pass the fwctl_rpc_scope to the FW along with the command.
> > > +
> > > +The driver and FW must cooperate to ensure that either fwctl cannot allocate
> > > +any FW resources, or any resources it does allocate are freed on FD closure.  A
> > > +driver primarily constructed around FW RPCs may find that its core PCI function
> > > +and RPC layer belongs under fwctl with auxiliary devices connecting to other
> > > +subsystems.
> > > +
> > > +Each device type must represent a stable FW ABI, such that the userspace
> > > +components have the same general stability we expect from the kernel. FW upgrade
> > > +should not break the userspace tools.
> > 
> > I think an exception for the debug rpcs (or maybe only
> > FWCTL_DEBUG_WRITE_FULL if we're super strict) could really help the case
> > for fwctl. Still not allowing to break individual rpcs, but maybe allow fw
> > to remove outdated ones. 
> 
> I'm definitely mindful of Linus's pragmatic view of ABI stability, where
> existing tools that *people actually use* shouldn't break. You
> shouldn't have to upgrade your tools when you upgrade your FW.
> 
> I think it is important to convey that as a the gold standard here
> too.
> 
> > And especially for field and even more in-house debug tooling, you really
> > want the userspace version matching your fw anyway.
> 
> Yes, this is definately the case. But those tools are also private and
> I think fall under the *people actually use* exception.
> 
> So, lets try again:
> 
> Each device type must be mindful of Linux's philosophy for stable ABI. The FW
> RPC interface does not have to meet a strictly stable ABI, but it does need to
> meet an expectation that userspace tools that are deployed and in significant
> use don't needlessly break. FW upgrade and kernel upgrade should keep widely
> deployed tooling working.
> 
> Development and debugging focused RPCs under more permissive scopes can have
> less stablitiy if the tools using them are only run under exceptional
> circumstances and not for every day use of the device. Debugging tools may even
> require exact version matching as they may require something similar to DWARF
> debug information from the FW binary.

Perfect imo, ack.

> > Currently that mess tends to leave in debugfs and/or out-of-tree, so
> > there's no stable uapi guarantee anyway. And I don't see the point in
> > requiring it - if there is a need for stabling tooling, maybe that
> > indicates more the need for a new subsystem that standardized things
> > across devices/vendors.
> 
> Yes, fwctl needs to have both. I would expect things like the
> configuration to have a fairly stable ABI. Maybe the list of
> configurables will change but access to them should be ABI stable.
> 
> > > +Some examples:
> > > +
> > > + - HW RAID controllers. This includes RPCs to do things like compose drives into
> > > +   a RAID volume, configure RAID parameters, monitor the HW and more.
> > > +
> > > + - Baseboard managers. RPCs for configuring settings in the device and more
> > > +
> > > + - NVMe vendor command capsules. nvme-cli provides access to some monitoring
> > > +   functions that different products have defined, but more exists.
> > > +
> > > + - CXL also has a NVMe-like vendor command system.
> > > +
> > > + - DRM allows user space drivers to send commands to the device via kernel
> > > +   mediation
> > > +
> > > + - RDMA allows user space drivers to directly push commands to the device
> > > +   without kernel involvement
> > > +
> > > + - Various “raw” APIs, raw HID (SDL2), raw USB, NVMe Generic Interface, etc
> > > +
> > > +The first 4 are examples of areas that fwctl intends to cover.
> > 
> > Maybe add a sentence here why the latter 3 aren't, just to strengthen that
> > point?
> 
> How about:
> 
> The first 4 are examples of areas that fwctl intends to cover. The latter three
> are examples of denied behavior as they fully overlap with the primary purpose
> of a kernel subsystem.

Ack.

Cheers, Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

