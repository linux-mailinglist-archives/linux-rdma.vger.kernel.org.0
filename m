Return-Path: <linux-rdma+bounces-4926-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C07C3976D36
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Sep 2024 17:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5174B1F21B42
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Sep 2024 15:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D851C1A76DD;
	Thu, 12 Sep 2024 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gr9AsmAi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC031B12F8
	for <linux-rdma@vger.kernel.org>; Thu, 12 Sep 2024 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726153825; cv=none; b=hQPf4DIYKopVkWtIR+0JDQw0xlTot581q/NJvPlLibwhbi7cnKg07c8tR7ikVv2n9WZDpXmWya3iWI30akspRauVnLm2ZiDDL75xRP5cxTu7xZdUF46kDQWLhElMxlwpx2oKZRsoZt4nj0XEExPxt556l5S9L4XQsapfwvzMoz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726153825; c=relaxed/simple;
	bh=Tx6bI7lB7DWcB35YVE4oudgyEkx4c/nLQv3KoURkKKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDgO2dMWP8A4NguOS7tpmFb5bfrtHDyIH26fz/onlE5VmLVIJYHaDY27yFlufJV+qE15b12DbYWKqo4V2cD8jA/QiCtZ8H9TXcfOT/kjnPu7+9btYmkGYVrUkO+ri/N/pw4jTP03nxRyENqDFh232zCmMwkJMBzLO0YlEM6hzGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gr9AsmAi; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7191f58054aso922803b3a.0
        for <linux-rdma@vger.kernel.org>; Thu, 12 Sep 2024 08:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726153823; x=1726758623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1eoRVpeyi0ydxyjX/TDQEZn7LTegMKIFUHM1bCQCXy4=;
        b=Gr9AsmAi2yxlWjMU3HC2VPU2W4yv6nZDp8nZBjV/35KAR/dqtnrW/EzAQ0s+vdLs/1
         R9jghaSafWXx5WYABemcjQdTdBaiXJG1G9o6EEWHF39CB3We3k58kMVKaK9cuiLSs5C2
         WMMZbq7et1cwubdvI1mnDr38gmo3kC16/jDZ7mDmrmX9gHZdhRVA12lVhDZA1jkgGI3O
         6qVI5hEiUxRf29BLcjoVzlcIvkfsJfM+XbpxwGg2TsQhBlwAQNZMA+FC1CXcUGFldn5i
         Kj/1y/D4coKXuwP32nsK7QN9aGGEw3aEDiC9vEIesd10t7f1VzXUJqvDe+j8CMFN17+J
         bs/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726153823; x=1726758623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1eoRVpeyi0ydxyjX/TDQEZn7LTegMKIFUHM1bCQCXy4=;
        b=WOldC4dIJfawTbDke+8KGDOoARbW5TSNpi/9JmkZME3+zOlx2LrFog8R9WLOX6sP87
         kdeQxEiT21WHTdULl9/C7GTm7rIJE0vT1TUotvyDSjU5ryinbwgdv8EP7Vk5ajOn4FNJ
         lSbBD8r3uC/AqrMZglqBDybDQfNSZ9R1SnXPpVXNsiXCREAitCIImJcD46+JADIbXHLI
         5Iwty96jHCz3aat1x0qGfI7H9iu3VNI0Myb28jaPt6RboMgLADfsXUmQ6G31bS4RRmsu
         5CrbWrLE3AMTNbzReNOZkc9jtA9oXG39rfcFq2v5hVJzDu15/lQdOz0D3UCFR+M3NzZU
         JWAA==
X-Forwarded-Encrypted: i=1; AJvYcCXYHvOrQfoVTKF9vBnDxKlOXXC/YDFmOqHcMp/QZe4x+mwcrmRpDWIrMdu8cURuZd26f+nN/7tMYsI3@vger.kernel.org
X-Gm-Message-State: AOJu0YyJjN+q+FD2Ivogl4L7NkqdsicDABbewfocQv+kKs3sJ2WZ76/x
	ATEsrEX2lcfNMfHRs9vYOx1m/E+UClPmWgFboNndpDnhVeft5w/fk6JWDpP9Wjk=
X-Google-Smtp-Source: AGHT+IH7/BpcAQiTODsY3S6TXEWMyJWY/ootzos4Dq/YkVKmeQTGoEidw4UZsvt1mAkK8gGS6zlK5A==
X-Received: by 2002:a05:6a00:148d:b0:70d:2fb5:f996 with SMTP id d2e1a72fcca58-7192606e357mr4835439b3a.11.1726153823003;
        Thu, 12 Sep 2024 08:10:23 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:a82e:e104:d822:3d3c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fbc3cb5sm1867942a12.52.2024.09.12.08.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 08:10:22 -0700 (PDT)
Date: Thu, 12 Sep 2024 09:10:19 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Doug Miller <doug.miller@cornelisnetworks.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	linux-remoteproc@vger.kernel.org,
	OFED mailing list <linux-rdma@vger.kernel.org>,
	"Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>
Subject: Re: How to create/use RPMSG-over-VIRTIO devices in Linux
Message-ID: <ZuMEW9T2qSTIkqrp@p14s>
References: <cff37523-d400-4a40-8fd1-b041a9b550b5@cornelisnetworks.com>
 <70cf5f00-c4bf-483a-829e-c34362ba8a70@cornelisnetworks.com>
 <ZuBiLgxv6Axis3F/@p14s>
 <aff4e2e3-0cb9-4ca3-84f7-2ae1b62715e4@cornelisnetworks.com>
 <CANLsYkyuB=BsswRmbSbjDNMqz0iGHrviLMGfNJLx-HJ60JeEMA@mail.gmail.com>
 <591e01eb-a05b-43e6-a00a-8f6007e77930@cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <591e01eb-a05b-43e6-a00a-8f6007e77930@cornelisnetworks.com>

On Wed, Sep 11, 2024 at 12:24:07PM -0500, Doug Miller wrote:
> On 9/11/2024 11:12 AM, Mathieu Poirier wrote:
> > On Tue, 10 Sept 2024 at 09:43, Doug Miller
> > <doug.miller@cornelisnetworks.com> wrote:
> > > On 9/10/2024 10:13 AM, Mathieu Poirier wrote:
> > > > On Tue, Sep 10, 2024 at 08:12:07AM -0500, Doug Miller wrote:
> > > > > On 9/3/2024 10:52 AM, Doug Miller wrote:
> > > > > > I am trying to learn how to create an RPMSG-over-VIRTIO device
> > > > > > (service) in order to perform communication between a host driver and
> > > > > > a guest driver. The RPMSG-over-VIRTIO driver (client) side is fairly
> > > > > > well documented and there is a good example (starting point, at least)
> > > > > > in samples/rpmsg/rpmsg_client_sample.c.
> > > > > > 
> > > > > > I see that I can create an endpoint (struct rpmsg_endpoint) using
> > > > > > rpmsg_create_ept(), and from there I can use rpmsg_send() et al. and
> > > > > > the rpmsg_rx_cb_t cb to perform the communications. However, this
> > > > > > requires a struct rpmsg_device and it is not clear just how to get one
> > > > > > that is suitable for this purpose.
> > > > > > 
> > > > > > It appears that one or both of rpmsg_create_channel() and
> > > > > > rpmsg_register_device() are needed in order to obtain a device for the
> > > > > > specific host-guest communications channel. At some point, a "root"
> > > > > > device is needed that will use virtio (VIRTIO_ID_RPMSG) such that new
> > > > > > subdevices can be created for each host-guest pair.
> > > > > > 
> > > > > > In addition, building a kernel with CONFIG_RPMSG, CONFIG_RPMSG_VIRTIO,
> > > > > > and CONFIG_RPMSG_NS set, and doing a modprobe virtio_rpmsg_bus, seems
> > > > > > to get things setup but that does not result in creation of any "root"
> > > > > > rpmsg-over-virtio device. Presumably, any such device would have to be
> > > > > > setup to use a specific range of addresses and also be tied to
> > > > > > virtio_rpmsg_bus to ensure that virtio is used.
> > > > > > 
> > > > > > It is also not clear if/how register_rpmsg_driver() will be required
> > > > > > on the rpmsg driver side, even though the sample code does not use it.
> > > > > > 
> > > > > > So, first questions are:
> > > > > > 
> > > > > > * Am I looking at the correct interfaces in order to create the host
> > > > > > rpmsg device side?
> > > > > > * What needs to be done to get a "root" rpmsg-over-virtio device
> > > > > > created (if required)?
> > > > > > * How is a rpmsg-over-virtio device created for each host-guest driver
> > > > > > pair, for use with rpmsg_create_ept()?
> > > > > > * Does the guest side (rpmsg driver) require any special handling to
> > > > > > plug-in to the host driver (rpmsg device) side? Aside from using the
> > > > > > correct addresses to match device side.
> > > > > It looks to me as though the virtio_rpmsg_bus module can create a
> > > > > "rpmsg_ctl" device, which could be used to create channels from which
> > > > > endpoints could be created. However, when I load the virtio_rpmsg_bus,
> > > > > rpmsg_ns, and rpmsg_core modules there is no "rpmsg_ctl" device created
> > > > > (this is running in the host OS, before any VMs are created/run).
> > > > > 
> > > > At this time the modules stated above are all used when a main processor is
> > > > controlling a remote processor, i.e via the remoteproc subsystem.  I do not know
> > > > of an implementation where VIRTIO_ID_RPMSG is used in the context of a
> > > > host/guest scenario.  As such you will find yourself in uncharted territory.
> > > > 
> > > > At some point there were discussion via the OpenAMP body to standardize the
> > > > remoteproc's subsystem establishment of virtqueues to conform to a host/guest
> > > > scenario but was abandonned.  That would have been a step in the right direction
> > > > for what you are trying to do.
> > > I was looking at some existing rpmsg code, at it appeared to me that
> > > some adapters, like the "qcom", are creating an rpmsg device that
> > > provides specialized methods for talking to the remote processor(s). I
> > > have assumed this is because that hardware does not allow for running
> > > something remotely that can utilize the virtio queues directly, and so
> > > these rpmsg devices provide code to do the communication with their
> > > hardware. What's not clear is whether these devices are using
> > > rpmsg-over-virtio or if they are creating their own rpmsg facility (and
> > > whether they even support guest-host communication).
> > > 
> > The QC implementation is different and does not use virtio - there is
> > a special HW interface between the main and the remote processors.
> > That configuration is valid since RPMSG can be implemented over
> > anything.
> > 
> > > What I'm also wondering is what needs to be done differently for virtio
> > > when communicating guest-host vs local CPU to remote processor. I was
> >  From a kernel/guest perspective, not much should be needed.  That said
> > the VMM will need to be supplemented with extra configuration
> > capabilities to instantiate the virtio-rpmsg device.  But that is just
> > off the top of my head without seriously looking at the use case.
> >  From a virtio-bus perspective, there might be an issue if a platform
> > is using remote processors _and_ also instantiating VMs that
> > configures a virtio-rpmsg device.  Again, that is just off the top of
> > my head but needs to be taken into account.
> I am new to rpmsg and virtio, and so my understanding of internals is
> still very limited. Is there someone I can work with to determine what
> needs to be done here? I am guessing that virtio either automatically
> adapts to guest-host or rproc-host - in which case no changes may be
> required - or else it requires a different setup and rpmsg will need to
> be extended to allow for that. If there are changes to rpmsg required,
> we'll want to get those submitted as soon as possible. One complication
> for submitting our driver changes is that it is part of a much larger
> effort to support new hardware, and it may not be possible to submit
> them together with rpmsg changes.

The virtio part won't be a problem.  In your case what is missing is the glue
that will setup the virtqueues and install the RPMSG protocol on top of them.
The 'glue' is the new virtio-rpmsg device that needs to be created.  That part
includes the creation of a new virtio device by the VMM and a kernel driver that
can be called from the virtio_bus once it has been discovered.  

Everything in the virtio and RPMSG subsystems are aleady tailored to support all
this, so no changes should be needed.  As for the VMM, I suggest to start with
kvmtool.  Lastly, none of this requires "real" hardware or your specific
hardware - it can all be done from QEMU.

> > 
> > > hoping that RPMSG-over-VIRTIO would be easily adapted to what we need.
> > > If we have to create a new virtio device (that is nearly identical to
> > > rpmsg), that is going to push-out SR-IOV support a great deal, plus
> > > requiring cloning of a lot of existing code for a new purpose.
> > Duplication of code would not be a viable way forward.
> > Reusing/enhancing/fixing what is currently available is definitely a
> > better option.
> > 
> > > Our only other alternative is to do something to allow guest-host
> > > communication to use the fabric loopback, which is not at all desirable
> > > and has many issues of its own.
> > > 
> > > > > Is this the correct way to use RPMSG-over-VIRTIO? If so, what actions
> > > > > need to be taken to cause a "rpmsg_ctl" device to be created? What
> > > > > method would be used (in a kernel driver) to get a pointer to the
> > > > > "rpmsg_ctl" device, for use with rpmsg_create_channel()?
> > > > > 
> > > > > > Thanks,
> > > > > > Doug
> > > > > > 
> > > > > External recipient
> > > 
> > > External recipient
> 
> 
> External recipient

