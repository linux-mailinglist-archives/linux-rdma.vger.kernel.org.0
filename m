Return-Path: <linux-rdma+bounces-4884-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02353975800
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 18:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEB6AB21F39
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Sep 2024 16:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29A02B9A2;
	Wed, 11 Sep 2024 16:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gK2pc/HU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7FF192D74
	for <linux-rdma@vger.kernel.org>; Wed, 11 Sep 2024 16:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726071193; cv=none; b=S85f/ZT7DSsels6qV7UVxvFzs92igJwiG15MllQnoFiLyje8r0rESPS6XoCHpBI84gyRT1Yb73QU6TaN4fveU07z4HAfMktP/GW6kpHVz+XMYBhUtPyQS5LmvGzQHtemk9pft+SfWj2EqqbTJNsBaOT8tZebBVpEu2g06uY3wsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726071193; c=relaxed/simple;
	bh=DS52PHaPfdGbq8FbQORvglthepUotuCOZUj5qbJmcyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GxRBkqBuONdnHiZXEd2cr6uOU/IuS2K3b5WM8Hu12OJpMEC43A7j2amgiyDZmkB8YZomOcZsr05MCMC0ZHUhzTPH1XUExUM2L6sWCEEv0AyOWKzVdevge7gqTzPKCrh2L/bVOyTLf9VqMwL4E0o0Ga9+E8uAYhuMoKPja++HXd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gK2pc/HU; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8d3e662791so268366b.1
        for <linux-rdma@vger.kernel.org>; Wed, 11 Sep 2024 09:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726071190; x=1726675990; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o+3SFWpbOXAsP+3LWGZZpQzbhpnQaZ0Vnig0HkZ7UnM=;
        b=gK2pc/HUXfF3AbMr8Y6usC+rSxZegmJNqA4qPv/PcWzY3QnZmovhW1LGHWFb1kJmoZ
         VI9L1m2mdDu05NMX2OQMT1qRSh+9WKkBvhFv09jqRKRN7VKwihmTV+n7GjwAsSweoQf4
         5T0pwDVH79Y+W963EIsEY/1gtLTbDWDaE0Y349e1vmP/37F8FqPS6t5GxcsPBsGrj8RN
         7JMmdpgRU3NjpsbToruSIZ0CH/1zu2tePYDcl08fvjszdEWu37DnjQAb4NGxkDnBiqxH
         VX7KEFCahXgyBT7nZHZ++g88QjFh/eiYV/hs5T/b19rqdUIgGMhv/UhURyeXmWmoCkPP
         RbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726071190; x=1726675990;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o+3SFWpbOXAsP+3LWGZZpQzbhpnQaZ0Vnig0HkZ7UnM=;
        b=Y/xalYj8hUYZT4nQBzeLHZgeDPLNPqsgmPaVHgRT1cP9KxkXudhoWl3ogGdwzCWmIm
         UOAaISHzCxqjaQ48L4Gr1KCIG7EUiyVVUSV5bG8OpT+mT+4vgQkygnccQd9Areth/5GA
         gJvY/2pA9ijl4Qa5Lqtnym+XM+oyPdzWAmYb2JViG88to590RN+s4arbgXfMXfq/OANy
         3/MJor9vmXwKdQ4kYxaKCAWIS370xUYq6uPlf7Pj/JsTWu6UIGEx2/LmIvRMIt4qlK0F
         bc+6SiWHBZzMoBXGG8UDG9wmzAzUw3b9GDypSLG73jxOI/9JBetaIgqitkSZJlK6090f
         0C4g==
X-Forwarded-Encrypted: i=1; AJvYcCXbmkpuJ5E3e1ECIHzmQdn/qO7afY7/izJaPh9n2jBMidEUNw2KiZVdy7YZJ9QzhXC76yGVxAXTcPjH@vger.kernel.org
X-Gm-Message-State: AOJu0YwdWl6kds+qSllnrAE0Pv1DLIrc4DrQyoSbUaxkNb+hQe4dVtaT
	2fjU9EQ10IuI9QD85eHZE0TBRQeOWu804t9Ze8gCNcXJOZSkAkncbYqRFxCj1+8MnHGJBz70kQu
	FLZ5U3IrAKAMg0zJkrHo7W5r2/rfG12mFW5zjuQ==
X-Google-Smtp-Source: AGHT+IEaGUovfpWkQxfKlUwLh3Dn+38bKgABk4jLLf66L+Ivh//ExxES/9ba+wTbxNa0efELJvZwz4lcg2o3sZPCFGg=
X-Received: by 2002:a05:6402:40cc:b0:5be:9bc5:f6b4 with SMTP id
 4fb4d7f45d1cf-5c413e0f631mr29554a12.8.1726071189946; Wed, 11 Sep 2024
 09:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cff37523-d400-4a40-8fd1-b041a9b550b5@cornelisnetworks.com>
 <70cf5f00-c4bf-483a-829e-c34362ba8a70@cornelisnetworks.com>
 <ZuBiLgxv6Axis3F/@p14s> <aff4e2e3-0cb9-4ca3-84f7-2ae1b62715e4@cornelisnetworks.com>
In-Reply-To: <aff4e2e3-0cb9-4ca3-84f7-2ae1b62715e4@cornelisnetworks.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Wed, 11 Sep 2024 10:12:58 -0600
Message-ID: <CANLsYkyuB=BsswRmbSbjDNMqz0iGHrviLMGfNJLx-HJ60JeEMA@mail.gmail.com>
Subject: Re: How to create/use RPMSG-over-VIRTIO devices in Linux
To: Doug Miller <doug.miller@cornelisnetworks.com>
Cc: Bjorn Andersson <andersson@kernel.org>, linux-remoteproc@vger.kernel.org, 
	OFED mailing list <linux-rdma@vger.kernel.org>, 
	"Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Sept 2024 at 09:43, Doug Miller
<doug.miller@cornelisnetworks.com> wrote:
>
> On 9/10/2024 10:13 AM, Mathieu Poirier wrote:
> > On Tue, Sep 10, 2024 at 08:12:07AM -0500, Doug Miller wrote:
> >> On 9/3/2024 10:52 AM, Doug Miller wrote:
> >>> I am trying to learn how to create an RPMSG-over-VIRTIO device
> >>> (service) in order to perform communication between a host driver and
> >>> a guest driver. The RPMSG-over-VIRTIO driver (client) side is fairly
> >>> well documented and there is a good example (starting point, at least)
> >>> in samples/rpmsg/rpmsg_client_sample.c.
> >>>
> >>> I see that I can create an endpoint (struct rpmsg_endpoint) using
> >>> rpmsg_create_ept(), and from there I can use rpmsg_send() et al. and
> >>> the rpmsg_rx_cb_t cb to perform the communications. However, this
> >>> requires a struct rpmsg_device and it is not clear just how to get one
> >>> that is suitable for this purpose.
> >>>
> >>> It appears that one or both of rpmsg_create_channel() and
> >>> rpmsg_register_device() are needed in order to obtain a device for the
> >>> specific host-guest communications channel. At some point, a "root"
> >>> device is needed that will use virtio (VIRTIO_ID_RPMSG) such that new
> >>> subdevices can be created for each host-guest pair.
> >>>
> >>> In addition, building a kernel with CONFIG_RPMSG, CONFIG_RPMSG_VIRTIO,
> >>> and CONFIG_RPMSG_NS set, and doing a modprobe virtio_rpmsg_bus, seems
> >>> to get things setup but that does not result in creation of any "root"
> >>> rpmsg-over-virtio device. Presumably, any such device would have to be
> >>> setup to use a specific range of addresses and also be tied to
> >>> virtio_rpmsg_bus to ensure that virtio is used.
> >>>
> >>> It is also not clear if/how register_rpmsg_driver() will be required
> >>> on the rpmsg driver side, even though the sample code does not use it.
> >>>
> >>> So, first questions are:
> >>>
> >>> * Am I looking at the correct interfaces in order to create the host
> >>> rpmsg device side?
> >>> * What needs to be done to get a "root" rpmsg-over-virtio device
> >>> created (if required)?
> >>> * How is a rpmsg-over-virtio device created for each host-guest driver
> >>> pair, for use with rpmsg_create_ept()?
> >>> * Does the guest side (rpmsg driver) require any special handling to
> >>> plug-in to the host driver (rpmsg device) side? Aside from using the
> >>> correct addresses to match device side.
> >> It looks to me as though the virtio_rpmsg_bus module can create a
> >> "rpmsg_ctl" device, which could be used to create channels from which
> >> endpoints could be created. However, when I load the virtio_rpmsg_bus,
> >> rpmsg_ns, and rpmsg_core modules there is no "rpmsg_ctl" device created
> >> (this is running in the host OS, before any VMs are created/run).
> >>
> > At this time the modules stated above are all used when a main processor is
> > controlling a remote processor, i.e via the remoteproc subsystem.  I do not know
> > of an implementation where VIRTIO_ID_RPMSG is used in the context of a
> > host/guest scenario.  As such you will find yourself in uncharted territory.
> >
> > At some point there were discussion via the OpenAMP body to standardize the
> > remoteproc's subsystem establishment of virtqueues to conform to a host/guest
> > scenario but was abandonned.  That would have been a step in the right direction
> > for what you are trying to do.
> I was looking at some existing rpmsg code, at it appeared to me that
> some adapters, like the "qcom", are creating an rpmsg device that
> provides specialized methods for talking to the remote processor(s). I
> have assumed this is because that hardware does not allow for running
> something remotely that can utilize the virtio queues directly, and so
> these rpmsg devices provide code to do the communication with their
> hardware. What's not clear is whether these devices are using
> rpmsg-over-virtio or if they are creating their own rpmsg facility (and
> whether they even support guest-host communication).
>

The QC implementation is different and does not use virtio - there is
a special HW interface between the main and the remote processors.
That configuration is valid since RPMSG can be implemented over
anything.

> What I'm also wondering is what needs to be done differently for virtio
> when communicating guest-host vs local CPU to remote processor. I was

From a kernel/guest perspective, not much should be needed.  That said
the VMM will need to be supplemented with extra configuration
capabilities to instantiate the virtio-rpmsg device.  But that is just
off the top of my head without seriously looking at the use case.
From a virtio-bus perspective, there might be an issue if a platform
is using remote processors _and_ also instantiating VMs that
configures a virtio-rpmsg device.  Again, that is just off the top of
my head but needs to be taken into account.

> hoping that RPMSG-over-VIRTIO would be easily adapted to what we need.
> If we have to create a new virtio device (that is nearly identical to
> rpmsg), that is going to push-out SR-IOV support a great deal, plus
> requiring cloning of a lot of existing code for a new purpose.

Duplication of code would not be a viable way forward.
Reusing/enhancing/fixing what is currently available is definitely a
better option.

>
> Our only other alternative is to do something to allow guest-host
> communication to use the fabric loopback, which is not at all desirable
> and has many issues of its own.
>
> >
> >> Is this the correct way to use RPMSG-over-VIRTIO? If so, what actions
> >> need to be taken to cause a "rpmsg_ctl" device to be created? What
> >> method would be used (in a kernel driver) to get a pointer to the
> >> "rpmsg_ctl" device, for use with rpmsg_create_channel()?
> >>
> >>> Thanks,
> >>> Doug
> >>>
> >> External recipient
>
>
> External recipient

