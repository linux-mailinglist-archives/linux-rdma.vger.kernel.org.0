Return-Path: <linux-rdma+bounces-4940-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DDA9782C8
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Sep 2024 16:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 167B71F22CE9
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Sep 2024 14:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781A01F5FA;
	Fri, 13 Sep 2024 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xoPiWtfn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D28B1BC2A
	for <linux-rdma@vger.kernel.org>; Fri, 13 Sep 2024 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726238383; cv=none; b=Sr5mi6um7JoD6WweLXwogrTpv+Hxk9MOaQz2BiGa/xEKDz1ytdLIeCGfkFTKglvAK+xxY1ihtYfqGn4JDSRif0/VZZCZvbagXooTBlk0WT0E8LQbp6HA0hH0gnFPUIBPOPpkVSYzx86V7h2Ou7T26gwcyKcMhh4wKiL+ZaScafs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726238383; c=relaxed/simple;
	bh=DMVnHjaZoKsJJOEcksxHz5xq+N7voX3xwFr5CHnA5K0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCItoZZg7lv290CZf09whFgXY/1jASlEaNf+41KitfZ0hQ5YEAPDHdllYdv2dDAGLucN5VBjrV5mpf4B1Lf6iG0ooBm8twUJ1egWzNqHnZT/hIaL1u9/EAX5cRuML1QoL4Sp1TEP2zGdFNQVab2TeD3Z3AaUr61SPjieWlMZ59A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xoPiWtfn; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c3d20eed0bso2573427a12.0
        for <linux-rdma@vger.kernel.org>; Fri, 13 Sep 2024 07:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726238379; x=1726843179; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r25IDaEB4v3w5xEh5qNDALrjM6XlHTd9SpiRAy71qmE=;
        b=xoPiWtfn7j8dICPuGnaouPt0xxd5f4Ld/NyCj6+wiftswUm6d03UEOkNriR7gSt1fk
         AGwuDr5lP7kSZAUoeSsi+eacRJJ6ab2+du/BWKo82l/938at/UD0BMnDXz2HJzWImpax
         97kc+UKMjR7V31Dg98T/tahkFO47G4v2AwJfkSq3bLJexASFhrd6VHkSuLsXgQD1RMro
         2++8xuLtKxwiP1OKkdgvOU+JCq6J1qsRDD0BFBgjhHrOyStDxXLeLsWGtax5rgXZLS63
         Z5UIisDv+u9RUgNA+BHTPAouruOUQj5Z5UtGtRBhhehoMLMmaaiLUz24j7EHsCmOTT5p
         RGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726238379; x=1726843179;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r25IDaEB4v3w5xEh5qNDALrjM6XlHTd9SpiRAy71qmE=;
        b=cs+S3+GWZrA3TfdVNnUcCdvKWVRK0VoG6d0Q7HYL1F2Ai+jyOK/Awy+2XJQpLSVlwq
         B0e/Y7pkIvuAiEooiRtkB+l/FXYRcrFZw8V6EaExrbrYdENU5lbgHqJzysmBlGU/EiEX
         kYAJ48URlES+cj4CUbsK9jX0qAeopzHdoG12uVmVd3WaO8+4D+MZ4zvXABh0gpjaAf4+
         M8oKKaoVQcA3MgkY08b1PRyPqHReOPxKO9dgBAhRLWSz2gblw4sjArdAZgmUz/csqVnI
         v6VX0fON9SQBrWAlACymbewielzgcNZ2kmZTRzcMib5ELJEuLPGBmSwVFPqxT1fTgcsc
         TLSw==
X-Forwarded-Encrypted: i=1; AJvYcCXjhv6i7igPoUKfvR/naRdYLC3lYmU3bQsOKM6ev7B8rzNcvZR1NPdiWt/6B2DR0Z4zFfxQgDXkEHLX@vger.kernel.org
X-Gm-Message-State: AOJu0YwJZE/NtLjWPc//1VdoRcymme1jlXVZnwfTh16UImKqfOKfC+AG
	2t4f7vMuYmvvN7WJ3UMkbUlne72DZbLY1oMEnOfL+kPFrZnOn3hKZ9rlBSZhiV8HLEFbc+YMMSw
	x/AasvwZ6n4Bm0ahuBQw5PbBTb3VC1rI+KUhuUA==
X-Google-Smtp-Source: AGHT+IFJqrDjSCJ5ny3P0SXV8SrwbnvYWxGzKgN9JNyLptiuHGx75oCRfTkbu1clnu6rAUwilfBEglOTgqxPYW50ljY=
X-Received: by 2002:a05:6402:3506:b0:5c4:95b:b150 with SMTP id
 4fb4d7f45d1cf-5c413cbd9e5mr5119904a12.0.1726238379030; Fri, 13 Sep 2024
 07:39:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cff37523-d400-4a40-8fd1-b041a9b550b5@cornelisnetworks.com>
 <70cf5f00-c4bf-483a-829e-c34362ba8a70@cornelisnetworks.com>
 <ZuBiLgxv6Axis3F/@p14s> <aff4e2e3-0cb9-4ca3-84f7-2ae1b62715e4@cornelisnetworks.com>
 <CANLsYkyuB=BsswRmbSbjDNMqz0iGHrviLMGfNJLx-HJ60JeEMA@mail.gmail.com>
 <591e01eb-a05b-43e6-a00a-8f6007e77930@cornelisnetworks.com>
 <ZuMEW9T2qSTIkqrp@p14s> <d8a4001c-d8c7-457a-a926-1d03e4f772fe@cornelisnetworks.com>
In-Reply-To: <d8a4001c-d8c7-457a-a926-1d03e4f772fe@cornelisnetworks.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Fri, 13 Sep 2024 08:39:26 -0600
Message-ID: <CANLsYkw-5i_4=UXwtG_SfR7rkjKEz3ieSOP2s4SOCozkWMct7w@mail.gmail.com>
Subject: Re: How to create/use RPMSG-over-VIRTIO devices in Linux
To: Doug Miller <doug.miller@cornelisnetworks.com>
Cc: Bjorn Andersson <andersson@kernel.org>, linux-remoteproc@vger.kernel.org, 
	OFED mailing list <linux-rdma@vger.kernel.org>, 
	"Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Sept 2024 at 05:46, Doug Miller
<doug.miller@cornelisnetworks.com> wrote:
>
> On 9/12/2024 10:10 AM, Mathieu Poirier wrote:
> > On Wed, Sep 11, 2024 at 12:24:07PM -0500, Doug Miller wrote:
> >> On 9/11/2024 11:12 AM, Mathieu Poirier wrote:
> >>> On Tue, 10 Sept 2024 at 09:43, Doug Miller
> >>> <doug.miller@cornelisnetworks.com> wrote:
> >>>> On 9/10/2024 10:13 AM, Mathieu Poirier wrote:
> >>>>> On Tue, Sep 10, 2024 at 08:12:07AM -0500, Doug Miller wrote:
> >>>>>> On 9/3/2024 10:52 AM, Doug Miller wrote:
> >>>>>>> I am trying to learn how to create an RPMSG-over-VIRTIO device
> >>>>>>> (service) in order to perform communication between a host driver and
> >>>>>>> a guest driver. The RPMSG-over-VIRTIO driver (client) side is fairly
> >>>>>>> well documented and there is a good example (starting point, at least)
> >>>>>>> in samples/rpmsg/rpmsg_client_sample.c.
> >>>>>>>
> >>>>>>> I see that I can create an endpoint (struct rpmsg_endpoint) using
> >>>>>>> rpmsg_create_ept(), and from there I can use rpmsg_send() et al. and
> >>>>>>> the rpmsg_rx_cb_t cb to perform the communications. However, this
> >>>>>>> requires a struct rpmsg_device and it is not clear just how to get one
> >>>>>>> that is suitable for this purpose.
> >>>>>>>
> >>>>>>> It appears that one or both of rpmsg_create_channel() and
> >>>>>>> rpmsg_register_device() are needed in order to obtain a device for the
> >>>>>>> specific host-guest communications channel. At some point, a "root"
> >>>>>>> device is needed that will use virtio (VIRTIO_ID_RPMSG) such that new
> >>>>>>> subdevices can be created for each host-guest pair.
> >>>>>>>
> >>>>>>> In addition, building a kernel with CONFIG_RPMSG, CONFIG_RPMSG_VIRTIO,
> >>>>>>> and CONFIG_RPMSG_NS set, and doing a modprobe virtio_rpmsg_bus, seems
> >>>>>>> to get things setup but that does not result in creation of any "root"
> >>>>>>> rpmsg-over-virtio device. Presumably, any such device would have to be
> >>>>>>> setup to use a specific range of addresses and also be tied to
> >>>>>>> virtio_rpmsg_bus to ensure that virtio is used.
> >>>>>>>
> >>>>>>> It is also not clear if/how register_rpmsg_driver() will be required
> >>>>>>> on the rpmsg driver side, even though the sample code does not use it.
> >>>>>>>
> >>>>>>> So, first questions are:
> >>>>>>>
> >>>>>>> * Am I looking at the correct interfaces in order to create the host
> >>>>>>> rpmsg device side?
> >>>>>>> * What needs to be done to get a "root" rpmsg-over-virtio device
> >>>>>>> created (if required)?
> >>>>>>> * How is a rpmsg-over-virtio device created for each host-guest driver
> >>>>>>> pair, for use with rpmsg_create_ept()?
> >>>>>>> * Does the guest side (rpmsg driver) require any special handling to
> >>>>>>> plug-in to the host driver (rpmsg device) side? Aside from using the
> >>>>>>> correct addresses to match device side.
> >>>>>> It looks to me as though the virtio_rpmsg_bus module can create a
> >>>>>> "rpmsg_ctl" device, which could be used to create channels from which
> >>>>>> endpoints could be created. However, when I load the virtio_rpmsg_bus,
> >>>>>> rpmsg_ns, and rpmsg_core modules there is no "rpmsg_ctl" device created
> >>>>>> (this is running in the host OS, before any VMs are created/run).
> >>>>>>
> >>>>> At this time the modules stated above are all used when a main processor is
> >>>>> controlling a remote processor, i.e via the remoteproc subsystem.  I do not know
> >>>>> of an implementation where VIRTIO_ID_RPMSG is used in the context of a
> >>>>> host/guest scenario.  As such you will find yourself in uncharted territory.
> >>>>>
> >>>>> At some point there were discussion via the OpenAMP body to standardize the
> >>>>> remoteproc's subsystem establishment of virtqueues to conform to a host/guest
> >>>>> scenario but was abandonned.  That would have been a step in the right direction
> >>>>> for what you are trying to do.
> >>>> I was looking at some existing rpmsg code, at it appeared to me that
> >>>> some adapters, like the "qcom", are creating an rpmsg device that
> >>>> provides specialized methods for talking to the remote processor(s). I
> >>>> have assumed this is because that hardware does not allow for running
> >>>> something remotely that can utilize the virtio queues directly, and so
> >>>> these rpmsg devices provide code to do the communication with their
> >>>> hardware. What's not clear is whether these devices are using
> >>>> rpmsg-over-virtio or if they are creating their own rpmsg facility (and
> >>>> whether they even support guest-host communication).
> >>>>
> >>> The QC implementation is different and does not use virtio - there is
> >>> a special HW interface between the main and the remote processors.
> >>> That configuration is valid since RPMSG can be implemented over
> >>> anything.
> >>>
> >>>> What I'm also wondering is what needs to be done differently for virtio
> >>>> when communicating guest-host vs local CPU to remote processor. I was
> >>>   From a kernel/guest perspective, not much should be needed.  That said
> >>> the VMM will need to be supplemented with extra configuration
> >>> capabilities to instantiate the virtio-rpmsg device.  But that is just
> >>> off the top of my head without seriously looking at the use case.
> >>>   From a virtio-bus perspective, there might be an issue if a platform
> >>> is using remote processors _and_ also instantiating VMs that
> >>> configures a virtio-rpmsg device.  Again, that is just off the top of
> >>> my head but needs to be taken into account.
> >> I am new to rpmsg and virtio, and so my understanding of internals is
> >> still very limited. Is there someone I can work with to determine what
> >> needs to be done here? I am guessing that virtio either automatically
> >> adapts to guest-host or rproc-host - in which case no changes may be
> >> required - or else it requires a different setup and rpmsg will need to
> >> be extended to allow for that. If there are changes to rpmsg required,
> >> we'll want to get those submitted as soon as possible. One complication
> >> for submitting our driver changes is that it is part of a much larger
> >> effort to support new hardware, and it may not be possible to submit
> >> them together with rpmsg changes.
> > The virtio part won't be a problem.  In your case what is missing is the glue
> > that will setup the virtqueues and install the RPMSG protocol on top of them.
> > The 'glue' is the new virtio-rpmsg device that needs to be created.  That part
> > includes the creation of a new virtio device by the VMM and a kernel driver that
> > can be called from the virtio_bus once it has been discovered.
> I don't completely follow. Is there some KVM configuration option that
> causes the virtio-rpmsg device to be created? And then our host driver
> will need to be able to respond to some notification and dynamically
> adapt to each VMM being started? I'm not getting a clear picture of how
> this works. I'm also not clear on the responsibilities of our guest
> driver(s) vs. our host driver. For virtio I saw there was the concept of
> a "driver" side and a "device" side, and the guest seemed to be creating
> the driver and the host created the device. The rpmsg layer seems to be
> more complex in that area, so I'm not sure what actions our guest driver
> with take vs. our host driver.
> >

KVM has nothing to do with this.  The life of a virtio device starts
in the VMM (Virtual Machine Manager) where a backend device is created
and a virtio MMIO entry for that device is added to the device tree
that is fed to the VM kernel.  When the VM kernel boots the virtio
MMIO entry in the DT is parsed as part of the normal device discovery
process and a virtio-device is instantiated, added to the virtio-bus
and a driver is probed.

I suggest you start looking at that process using the kvmtool and a
simple virtio device such as virtio-rng.

> > Everything in the virtio and RPMSG subsystems are aleady tailored to support all
> > this, so no changes should be needed.  As for the VMM, I suggest to start with
> > kvmtool.  Lastly, none of this requires "real" hardware or your specific
> > hardware - it can all be done from QEMU.
> >
> >>>> hoping that RPMSG-over-VIRTIO would be easily adapted to what we need.
> >>>> If we have to create a new virtio device (that is nearly identical to
> >>>> rpmsg), that is going to push-out SR-IOV support a great deal, plus
> >>>> requiring cloning of a lot of existing code for a new purpose.
> >>> Duplication of code would not be a viable way forward.
> >>> Reusing/enhancing/fixing what is currently available is definitely a
> >>> better option.
> >>>
> >>>> Our only other alternative is to do something to allow guest-host
> >>>> communication to use the fabric loopback, which is not at all desirable
> >>>> and has many issues of its own.
> >>>>
> >>>>>> Is this the correct way to use RPMSG-over-VIRTIO? If so, what actions
> >>>>>> need to be taken to cause a "rpmsg_ctl" device to be created? What
> >>>>>> method would be used (in a kernel driver) to get a pointer to the
> >>>>>> "rpmsg_ctl" device, for use with rpmsg_create_channel()?
> >>>>>>
> >>>>>>> Thanks,
> >>>>>>> Doug
> >>>>>>>
> >>>>>> External recipient
> >>>> External recipient
> >>
> >> External recipient
>
>
> External recipient

