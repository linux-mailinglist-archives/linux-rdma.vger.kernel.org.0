Return-Path: <linux-rdma+bounces-5020-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E58C97D5A9
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2024 14:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FADEB21365
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2024 12:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47ED621345;
	Fri, 20 Sep 2024 12:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WGJzajxu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166EB1E4B2
	for <linux-rdma@vger.kernel.org>; Fri, 20 Sep 2024 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726836338; cv=none; b=pVew9HTckevYOeW/wy7pYoayK34/srYNo6263QU80B+DgDfFdqObIQrHcu0B9Yk2eBXvh/PwXGnN1DGzu581JWfCkap9mEXHcGr8cXgS0Xf4nODY6ZT/c5XpJrqNeUgG5LSRt8+HINQ8SOd0cUKG/0micSpDBYl7IsJKyJ5Js2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726836338; c=relaxed/simple;
	bh=6MDUFAzEP285GCjmDxeM7QwhxpeCWlw3jw0rPZ3Umy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYnT4HPlDQp1barZe7gQQ+ZVq/F/rCQ/7hfBxp79ZiUtKEOSMl5Xt1ywYMxcdEzA5drMJwCZ2DtEZPAVbbF39i46T0u1o1kd4xs4zIwrTX8KLlrTSDQGPrFBcTlwoM/X3GMHQQtq6PkdRC3kjWlXeZKW3uNNNTqjQ70VgClTGB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WGJzajxu; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c50ea4419dso213081a12.0
        for <linux-rdma@vger.kernel.org>; Fri, 20 Sep 2024 05:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1726836334; x=1727441134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HfUzaSYfe7JzaUrsdtf4EvyOxWKOBY5So2dMJqZysKw=;
        b=WGJzajxutePOqx0tXftmz92CqyCZyJ/zo1k+cHYBgszh4orc5ldnUYKod1+aZgFWVP
         +BhpX0M6xOQIGL7H+xrEp5b8JSBg21eWnlzzmnVxz9S2aP2+ws0+heckxC9CLMA9nLZd
         Aj4/G/oXfkVirrLLYr80Zf2tnGtL+fdQk320hj/Lz11hCKixWnGtZgDgCIs4lnBKUdw1
         LlZZrxvGScnYHBVyJFyrUeEa59rN8hyYSPtSSb2X89Ux8QWUn1WbF1RnG8KQoUrzYLYc
         KMK//CDRPKheGqpTJEIqQGY6DE0Rb4hVa1Ototr/eyVDsMGF9dNCs2b4Xjam+LLzG2yJ
         4kbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726836334; x=1727441134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfUzaSYfe7JzaUrsdtf4EvyOxWKOBY5So2dMJqZysKw=;
        b=cIxlmuXgS3MgVbkNaW/m2tLsB/vkhCOuq2OYkuS9Cm5xlpQ12g0OEM6rnwsZx6QfF9
         eqnN0rrt6H4adt+8K1w5J1B98WTo6g6W9xgzI9cwxh4oZgz0f1SJXwmL9pcJW32KfTQP
         Z8QoxxZGzKpXUxm7ySgS1ZyNU00fr+K9yX7vJOxJhWG0wWF44lTmFvxM4I6f+cFhxLxu
         AiAfKfELvKeRDNlMiU8aDKvJOmDev08G4mRXh1KE6sgSKW0rTc6qHUvVTj57t6FIMjM3
         laKYbBWQNPPIz2lUF/UxdJ9TcE8E/Il2CeVSayANpbzGFIdUN4oXk8ANkI4s6lKasVJd
         ADRg==
X-Forwarded-Encrypted: i=1; AJvYcCXPfG4+5xzoyiy4+VUQtywvQJBbeYgaHo4gvG9ZXM/KrqYvBLctuH1eCetMprRQi7ldtB6dxbPV9aay@vger.kernel.org
X-Gm-Message-State: AOJu0YwXgmZwDqeDnHt9MYZLZribAiAE4c16hZsbzMdj8hAl+FuseEIk
	2a9pTxu/oMD8qTwGmZ1lPuIfssYddf/w819cZOsXaOikYqQ8bwLyiMf/ugc9E3w=
X-Google-Smtp-Source: AGHT+IHnxE0Z6K4I84qufCSrMPPeisIti4l1d+G0k2zgC2NYBBHsXD8nRxoNhdodGriQA9BfXK7vYA==
X-Received: by 2002:a05:6402:4588:b0:5c0:c223:48a1 with SMTP id 4fb4d7f45d1cf-5c464dbc322mr1735246a12.21.1726836334065;
        Fri, 20 Sep 2024 05:45:34 -0700 (PDT)
Received: from ziepe.ca ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb8a099sm7171675a12.59.2024.09.20.05.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 05:45:33 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1srd0u-000178-CL;
	Fri, 20 Sep 2024 09:45:32 -0300
Date: Fri, 20 Sep 2024 09:45:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Doug Miller <doug.miller@cornelisnetworks.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-remoteproc@vger.kernel.org,
	OFED mailing list <linux-rdma@vger.kernel.org>,
	"Dalessandro, Dennis" <dennis.dalessandro@cornelisnetworks.com>
Subject: Re: How to create/use RPMSG-over-VIRTIO devices in Linux
Message-ID: <Zu1ubAO8e8vNpC3A@ziepe.ca>
References: <70cf5f00-c4bf-483a-829e-c34362ba8a70@cornelisnetworks.com>
 <ZuBiLgxv6Axis3F/@p14s>
 <aff4e2e3-0cb9-4ca3-84f7-2ae1b62715e4@cornelisnetworks.com>
 <CANLsYkyuB=BsswRmbSbjDNMqz0iGHrviLMGfNJLx-HJ60JeEMA@mail.gmail.com>
 <591e01eb-a05b-43e6-a00a-8f6007e77930@cornelisnetworks.com>
 <ZuMEW9T2qSTIkqrp@p14s>
 <d8a4001c-d8c7-457a-a926-1d03e4f772fe@cornelisnetworks.com>
 <CANLsYkw-5i_4=UXwtG_SfR7rkjKEz3ieSOP2s4SOCozkWMct7w@mail.gmail.com>
 <20240915165800.GF869260@ziepe.ca>
 <0dda0411-22a3-4805-807b-0471f10c6468@cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dda0411-22a3-4805-807b-0471f10c6468@cornelisnetworks.com>

On Mon, Sep 16, 2024 at 08:38:42AM -0500, Doug Miller wrote:
> On 9/15/2024 11:58 AM, Jason Gunthorpe wrote:
> > On Fri, Sep 13, 2024 at 08:39:26AM -0600, Mathieu Poirier wrote:
> > > KVM has nothing to do with this.  The life of a virtio device starts
> > > in the VMM (Virtual Machine Manager) where a backend device is created
> > > and a virtio MMIO entry for that device is added to the device tree
> > > that is fed to the VM kernel.  When the VM kernel boots the virtio
> > > MMIO entry in the DT is parsed as part of the normal device discovery
> > > process and a virtio-device is instantiated, added to the virtio-bus
> > > and a driver is probed.
> > > 
> > > I suggest you start looking at that process using the kvmtool and a
> > > simple virtio device such as virtio-rng.
> > I would repeat again, I think trying to create a companion virtio
> > device to go along with a real vPCI device and then logically
> > associating both of them with a single driver is going to cause so
> > much pain you should not do it.
> > 
> > Find a way to send your RPCs through your own vPCI device.
> 
> When you say "your own vPCI device", are you referring to the virtual
> functions that are created by the adapter? Those are defined by the
> hardware specification and we don't have the ability to extend them.

Yes you do the VMM can extend them. You need some qemu code or a
vfio-cornelis or something like that.

> What we're investigating is using RPMSG-over-VIRTIO, not using virtio
> devices directly. 

I understand, and that will be very painful.

Jason

