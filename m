Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16FF62DE998
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Dec 2020 20:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgLRTJ5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Dec 2020 14:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgLRTJ4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Dec 2020 14:09:56 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8456C06138C
        for <linux-rdma@vger.kernel.org>; Fri, 18 Dec 2020 11:09:15 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id t30so3469884wrb.0
        for <linux-rdma@vger.kernel.org>; Fri, 18 Dec 2020 11:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DsPzYSmK1PzNzvrUgHsnSLZZOIK5NlSaB+JDZhlEtOQ=;
        b=KQQTxWZhnTj/uNvQiy5xn4LTnyxBdtGdpkYyOFIpxGKBvQ0jRZD0TcZ/LTAWdqpOMc
         iBcpeBjOV6WolPKdkW0k8N0vFjZSuoQjHFQImAfO7PL9uwRQteKZBpMRX1HBVjykkDEA
         U3qmmLIdCJs5EYo9f3hmuHygRAauxGP2e50tehtEmbR5vg9qpkq3aVmWqG/A+Y3wM9B5
         x2A2CCcjsXOySa5bkd3cVqt3gKt7Jjj6iBIA9+aTTnKeHl3699g09lg3tnN0bCuc9+Po
         MkaSkh0ais3cCFxxZPmnNI/HE5mGjItnY4PhUTeeO8CRkP8j2f19YX9GIjqHvIP3l0rR
         LM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DsPzYSmK1PzNzvrUgHsnSLZZOIK5NlSaB+JDZhlEtOQ=;
        b=CEW9vL37nEqolJoK1dliDEWzybRMax2flkd9qQ/QFcpBbyFyBJge5ULpgZRqiCyxQt
         YNdIcljXCdpvZYNG1DpdITXfDAHi2xnlYIBYS13hLJk4YYOISnrfpXaKyrrL9MKqdAAu
         rb5qkuuKN/yL6WfBVKmRUr3EXpT7t1UsN6lqIT/HVYNEM9gykT67kaEYJW5tU99z/f/V
         GTHNHhxCGL53XuMqWxEOHyYBHh6xMx7uwPBKPduFyTOJHxHaaEOnAhUaKfYeOLVZAWXw
         R/SXhubIS57SYC27JuJGAHn5ZYwVNJ+Qm06eJEk4SjMVmPRCBWmmbl9g/C3UofW+AuAM
         YF5A==
X-Gm-Message-State: AOAM530AwlGz4EcPwvS4a/j6E4WJDRxKpaAtlS9t1HWi8TnQNZuleGO9
        5tc3DFQCSwf9LcN+M/Z0m8pBFbAIJ7EJUTQE
X-Google-Smtp-Source: ABdhPJw2jm4Tmi76TPXnjr8OBHNcrvwwjBfCy+FlD9dVZuo+ZdRb6pVpABn/SW3x01x5YHD7dj9svw==
X-Received: by 2002:a5d:4d50:: with SMTP id a16mr5940186wru.43.1608318554221;
        Fri, 18 Dec 2020 11:09:14 -0800 (PST)
Received: from dell ([91.110.221.216])
        by smtp.gmail.com with ESMTPSA id s13sm12555285wmj.28.2020.12.18.11.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 11:09:13 -0800 (PST)
Date:   Fri, 18 Dec 2020 19:09:11 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, Kiran Patil <kiran.patil@intel.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Martin Habets <mhabets@solarflare.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        Dave Ertman <david.m.ertman@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Parav Pandit <parav@mellanox.com>
Subject: Re: [resend/standalone PATCH v4] Add auxiliary bus support
Message-ID: <20201218190911.GT207743@dell>
References: <CAPcyv4iLG7V9JT34La5PYfyM9378acbLnkShx=6pOmpPK7yg3A@mail.gmail.com>
 <X8usiKhLCU3PGL9J@kroah.com>
 <20201217211937.GA3177478@piout.net>
 <X9xV+8Mujo4dhfU4@kroah.com>
 <20201218131709.GA5333@sirena.org.uk>
 <20201218140854.GW552508@nvidia.com>
 <20201218155204.GC5333@sirena.org.uk>
 <20201218162817.GX552508@nvidia.com>
 <20201218180310.GD5333@sirena.org.uk>
 <20201218184150.GY552508@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201218184150.GY552508@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 18 Dec 2020, Jason Gunthorpe wrote:

> On Fri, Dec 18, 2020 at 06:03:10PM +0000, Mark Brown wrote:
> > On Fri, Dec 18, 2020 at 12:28:17PM -0400, Jason Gunthorpe wrote:
> > > On Fri, Dec 18, 2020 at 03:52:04PM +0000, Mark Brown wrote:
> > > > On Fri, Dec 18, 2020 at 10:08:54AM -0400, Jason Gunthorpe wrote:
> > 
> > > > > I thought the recent LWN article summed it up nicely, auxillary bus is
> > > > > for gluing to subsystems together using a driver specific software API
> > > > > to connect to the HW, MFD is for splitting a physical HW into disjoint
> > > > > regions of HW.
> > 
> > > > This conflicts with the statements from Greg about not using the
> > > > platform bus for things that aren't memory mapped or "direct firmware",
> > > > a large proportion of MFD subfunctions are neither at least in so far as
> > > > I can understand what direct firmware means.
> > 
> > > I assume MFD will keep existing and it will somehow stop using
> > > platform device for the children it builds.
> > 
> > If it's not supposed to use platform devices so I'm assuming that the
> > intention is that it should use aux devices, otherwise presumably it'd
> > be making some new clone of the platform bus but I've not seen anyone
> > suggesting this.
> 
> I wouldn't assume that, I certainly don't want to see all the HW
> related items in platform_device cloned roughly into aux device.
> 
> I've understood the bus type should be basically related to the thing
> that is creating the device. In a clean view platform code creates
> platform devices. DT should create DT devices, ACPI creates ACPI
> devices, PNP does pnp devices, etc
> 
> So, I strongly suspect, MFD should create mfd devices on a MFD bus
> type.
> 
> Alexandre's point is completely valid, and I think is the main
> challenge here, somehow avoiding duplication.
> 
> If we were to look at it with some OOP viewpoint I'd say the generic
> HW resource related parts should be some shared superclass between
> 'struct device' and 'struct platform/pnp/pci/acpi/mfd/etc_device'.

You're confusing things here.

ACPI, DT and MFD are not busses.  They are just methods to
describe/register devices which will operate on buses.

Busses include things like; I2C, SPI, PCI, USB and Platform (MMIO).

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
