Return-Path: <linux-rdma+bounces-5049-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 440FE97EC6F
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2024 15:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65D2E1C21616
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Sep 2024 13:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB40199952;
	Mon, 23 Sep 2024 13:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="exbAb8sZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768C419993F
	for <linux-rdma@vger.kernel.org>; Mon, 23 Sep 2024 13:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727098767; cv=none; b=AOFTX0zXyBiZqz36er+8aEaDTrDriCMixWTUA0uIPXumwCRGN1HCaK6elSQ0y3eDQILBQI6bYEmDUVmL7xzuBnbRl7DUagDswNSa1YKS/QsqWUUagYTXae2p0+SBm0iuTAQv5HSyBhEjqkvpv/jLPEVZJMGzyTEHFBBYoZsirOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727098767; c=relaxed/simple;
	bh=gRqfy/JcNCBgrdItbN/fMbb2LmflfS7dub2nPExB6xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8YuotqGxCbrwZrO4jNzCM0ou79qFI2dZPbby/PMnf0zP8f9mtKojalws/7hOTcFyPp1Z0L4diYSFtxXgrigdxrte98sTTIgd8QWPuMdwv/cWWIJbNL4MxsgelcktNUgDUhfuV1t14JrWFeypwGi7fufVDMdIc+SZU1EpZOXM4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=exbAb8sZ; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6c54b1f52f7so28571746d6.3
        for <linux-rdma@vger.kernel.org>; Mon, 23 Sep 2024 06:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1727098764; x=1727703564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=saUDSovGweiUkNKFMnzn53j2Di6/S71CVq58sxnbqVA=;
        b=exbAb8sZqZjAMzHhp+X/x+DKVKfUN0KIPAzZg7FQVOC+8vS5DWJSLCKcSrZg5d02YE
         5Wh9bUtvbf/yzJnbrtJGgZgc8p7vkHAQlaw3natt1T1G4uHta7WMC7VJQvJqJOBUjFaT
         pD4Ik7KEB0gVSSoD3PXq3Jq8AYmW2evw1vwaHexZThis/1fXUFTIh7AyjcBhDDcLHKJ9
         h7g2VW8DVgqzDam5HkFBn9oxU2oNLfJ4nYPEqLwJjLDGC1gZe2WOK2YccOtkS6e72KO4
         oAwEgEp+cM5vw6PuURS/cti+i5oS/13rTpk+LBFcKMnJWEBoL0QwynRVRVJ9THRlOgIl
         QR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727098764; x=1727703564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=saUDSovGweiUkNKFMnzn53j2Di6/S71CVq58sxnbqVA=;
        b=WeVmq/OXB+zUIiZR15qkkWUkbasvJBgR/osd1PIpm44YwHzQKxvSvth96ULUp/txwm
         3kwdYYNU8ZsLCT5tK3LYj7s5/l6OJc1apGp6vYep1byZLSeJG35Z2KUfasyvJY9oWvW1
         pj3VZdiM5jlUTGZjyfiVQSn8ubEY5JEe/r2VOj36OP97eBBsj1RYQdIp9rqp/5JDZA8J
         tZVLrN5OJm2SYAEmQhG4+AJt4BCebIdJhrswRC8lU/jaX0+oxsIA66Zk/Cwu5TaQsGSn
         j5hZbMYWNTFy+xokLY+7+DsZ+Z0EVV6MRsJVgoWuN2tZW1RMUmviWc13YR2bkOMBg+4Y
         YWfw==
X-Forwarded-Encrypted: i=1; AJvYcCWmAtnEyn5FnzIAlpCCG/KhYfCgX1Te6zJEV1xPeC+v0aPJ3bPLowMjGo0hh2UrPLliDGlJeu0Bj02C@vger.kernel.org
X-Gm-Message-State: AOJu0YxZH/tHsfY2JP/eXM+B3cOwbRcIKBXWAx68xIuT5HAEf/K6Gys9
	Ukd0pat11tiWgJDhnDCy7jxu3LOil1FQ2rdL6AbLx7hI5IrERqPGBABkLQEVbWI=
X-Google-Smtp-Source: AGHT+IEzbaJy42pYd8EFVMy6DLVlQmMR7Oq0DrzlOtL41kNA3Z9bwGQvMxezRNid/5tVNgd4mVrFRw==
X-Received: by 2002:a05:6214:5d11:b0:6c5:13f0:240d with SMTP id 6a1803df08f44-6c7bc7ec77cmr161182396d6.38.1727098764068;
        Mon, 23 Sep 2024 06:39:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c75e46147csm47530936d6.44.2024.09.23.06.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 06:39:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ssjHf-0002g8-2G;
	Mon, 23 Sep 2024 10:39:23 -0300
Date: Mon, 23 Sep 2024 10:39:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Doug Miller <doug.miller@cornelisnetworks.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-remoteproc@vger.kernel.org,
	OFED mailing list <linux-rdma@vger.kernel.org>,
	"Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>
Subject: Re: How to create/use RPMSG-over-VIRTIO devices in Linux
Message-ID: <20240923133923.GB9634@ziepe.ca>
References: <aff4e2e3-0cb9-4ca3-84f7-2ae1b62715e4@cornelisnetworks.com>
 <CANLsYkyuB=BsswRmbSbjDNMqz0iGHrviLMGfNJLx-HJ60JeEMA@mail.gmail.com>
 <591e01eb-a05b-43e6-a00a-8f6007e77930@cornelisnetworks.com>
 <ZuMEW9T2qSTIkqrp@p14s>
 <d8a4001c-d8c7-457a-a926-1d03e4f772fe@cornelisnetworks.com>
 <CANLsYkw-5i_4=UXwtG_SfR7rkjKEz3ieSOP2s4SOCozkWMct7w@mail.gmail.com>
 <20240915165800.GF869260@ziepe.ca>
 <0dda0411-22a3-4805-807b-0471f10c6468@cornelisnetworks.com>
 <Zu1ubAO8e8vNpC3A@ziepe.ca>
 <9c79dcce-39dc-498e-ad41-f50fe2752582@cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c79dcce-39dc-498e-ad41-f50fe2752582@cornelisnetworks.com>

On Fri, Sep 20, 2024 at 08:56:07AM -0500, Doug Miller wrote:
> On 9/20/2024 7:45 AM, Jason Gunthorpe wrote:
> > On Mon, Sep 16, 2024 at 08:38:42AM -0500, Doug Miller wrote:
> > > On 9/15/2024 11:58 AM, Jason Gunthorpe wrote:
> > > > On Fri, Sep 13, 2024 at 08:39:26AM -0600, Mathieu Poirier wrote:
> > > > > KVM has nothing to do with this.  The life of a virtio device starts
> > > > > in the VMM (Virtual Machine Manager) where a backend device is created
> > > > > and a virtio MMIO entry for that device is added to the device tree
> > > > > that is fed to the VM kernel.  When the VM kernel boots the virtio
> > > > > MMIO entry in the DT is parsed as part of the normal device discovery
> > > > > process and a virtio-device is instantiated, added to the virtio-bus
> > > > > and a driver is probed.
> > > > > 
> > > > > I suggest you start looking at that process using the kvmtool and a
> > > > > simple virtio device such as virtio-rng.
> > > > I would repeat again, I think trying to create a companion virtio
> > > > device to go along with a real vPCI device and then logically
> > > > associating both of them with a single driver is going to cause so
> > > > much pain you should not do it.
> > > > 
> > > > Find a way to send your RPCs through your own vPCI device.
> > > When you say "your own vPCI device", are you referring to the virtual
> > > functions that are created by the adapter? Those are defined by the
> > > hardware specification and we don't have the ability to extend them.
> > Yes you do the VMM can extend them. You need some qemu code or a
> > vfio-cornelis or something like that.

> We can't require that SR-IOV customers use one specific VMM (qemu). 

No matter what you do, you will require some modification. The other
end of any imagined virtio will be in qemu too after all.

> you're talking about modifying the kernel virtio_pci facility, that may
> be a worthwhile effort long term but I suspect it will take a longer
> time to get adopted. Using an existing kernel facility as-is would be
> the most practical solution.

There is really nothing.

> > > What we're investigating is using RPMSG-over-VIRTIO, not using virtio
> > > devices directly.
> > I understand, and that will be very painful.
> Can you expand on what you mean by "painful"? Are you speaking from
> experience with the rpmsg interfaces (can you point to problem areas)?
> Or is this based on the fact that, as of yet, no one has come forward to
> explain exactly how to do this?

From understanding how vfio works and knowing that if you try to tie w
virtio and your PCI together it will be a huge mess.

Jason

