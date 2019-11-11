Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA185F7684
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Nov 2019 15:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfKKOhT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Nov 2019 09:37:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46201 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfKKOhT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Nov 2019 09:37:19 -0500
Received: by mail-wr1-f65.google.com with SMTP id b3so14854234wrs.13
        for <linux-rdma@vger.kernel.org>; Mon, 11 Nov 2019 06:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vWmsvXOxLILOeMxH5L7QAWLc3/R25fgjknw/j9uIX0A=;
        b=YmVQjaG9yNNiUeYFoYLzLvy8mhdFOEAhi88nkdZRHSViKfUQXC69VHPP/R4M9sTDES
         FBZVb56mqMQQo3wxdusd/ckD4yqsurYYD/RxuVL5Yg4eYviajjgLWhWh4m4lCxWWx3zP
         2+VwRsIYPWnfgCeEwHOu70hGr/E/KB6+iliSSOiDd4CMAH9z0AvjYSH4n/kj4gThAPQ5
         3vknbqnJBybiu8sNS0nBsqdNeOqzwcLoYttNwPwTrG72LPBzpIXhFKYPbhYNmOBAIadO
         pLTqBOvTglY5SWA6ERFWEFxOgxJ/0MeIQStcFNUUlFbRXqLA5lESw1FafaiQUxZUQ4kI
         uz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vWmsvXOxLILOeMxH5L7QAWLc3/R25fgjknw/j9uIX0A=;
        b=FUiN3tr8CtjlsMs2dUP8yxZJldI38cGsfVh0KidQPlxk2EqU16PYEcoDBicKnb5T3x
         AEEGGUAXaVszUOTv+2PsWVaGc/q2qxMm55ppmjeuFED2aaJYu0oSZBuRnmbuUs+roLsR
         ZQFLo9eTtpmzyXqqG34udAJaNYsfatm+MEUcP9E7Q8MhUm7EzVYQkSnQLhds04QbN3M+
         /eJcUXKlCUcFeq1F41VGMcw/VOeMsVskrwYxee2cBbucM47StvYU8d81tnwIhGpSal8C
         GrftCUKFOwPiW0grKfwEWj8ZYeGAOyWyibCx+Z5vY8cGkZDo//7KzfuNQKJ19p4+P6kw
         4/FQ==
X-Gm-Message-State: APjAAAXoiPI8EJ8WrGFOOj7GgGypbK8PULWPiMRpHs/hLzh3xCMOC+p5
        USfV5JlBO0odMEj+ReM5TRzmEg==
X-Google-Smtp-Source: APXvYqzOaLjQQaYGN5JkRRxujp+prfgCYrtUbv69efERk6stRxI4fRDhwend3GXBqSpfYglDZN1y9Q==
X-Received: by 2002:a5d:522e:: with SMTP id i14mr8748558wra.27.1573483036582;
        Mon, 11 Nov 2019 06:37:16 -0800 (PST)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id b8sm14931767wrt.39.2019.11.11.06.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 06:37:15 -0800 (PST)
Date:   Mon, 11 Nov 2019 15:37:14 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Parav Pandit <parav@mellanox.com>,
        David M <david.m.ertman@intel.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Or Gerlitz <gerlitz.or@gmail.com>
Subject: Re: [PATCH net-next 00/19] Mellanox, mlx5 sub function support
Message-ID: <20191111143714.GC2202@nanopsycho>
References: <AM0PR05MB486658D1D2A4F3999ED95D45D17B0@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <20191108111238.578f44f1@cakuba>
 <20191108201253.GE10956@ziepe.ca>
 <20191108134559.42fbceff@cakuba>
 <20191109004426.GB31761@ziepe.ca>
 <20191109092747.26a1a37e@cakuba>
 <20191110091855.GE1435668@kroah.com>
 <20191110194601.0d6ed1a0@cakuba>
 <20191111133026.GA2202@nanopsycho>
 <20191111141430.GB585609@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111141430.GB585609@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Mon, Nov 11, 2019 at 03:14:30PM CET, gregkh@linuxfoundation.org wrote:
>On Mon, Nov 11, 2019 at 02:30:26PM +0100, Jiri Pirko wrote:
>> Mon, Nov 11, 2019 at 04:46:01AM CET, jakub.kicinski@netronome.com wrote:
>> >On Sun, 10 Nov 2019 10:18:55 +0100, gregkh@linuxfoundation.org wrote:
>> >> > What I'm missing is why is it so bad to have a driver register to
>> >> > multiple subsystems.  
>> >> 
>> >> Because these PCI devices seem to do "different" things all in one PCI
>> >> resource set.  Blame the hardware designers :)
>> >
>> >See below, I don't think you can blame the HW designers in this
>> >particular case :)
>> >
>> >> > For the nfp I think the _real_ reason to have a bus was that it
>> >> > was expected to have some out-of-tree modules bind to it. Something 
>> >> > I would not encourage :)  
>> >> 
>> >> That's not ok, and I agree with you.
>> >> 
>> >> But there seems to be some more complex PCI devices that do lots of
>> >> different things all at once.  Kind of like a PCI device that wants to
>> >> be both a keyboard and a storage device at the same time (i.e. a button
>> >> on a disk drive...)
>> >
>> >The keyboard which is also a storage device may be a clear cut case
>> >where multiple devices were integrated into one bus endpoint.
>> 
>> Also, I think that very important differentiator between keyboard/button
>> and NIC is that keyboard/button is fixed. You have driver bus with 2
>> devices on constant addresses.
>> 
>> However in case of NIC subfunctions. You have 0 at he beginning and user
>> instructs to create more (maybe hundreds). Now important questions
>> appear:
>> 
>> 1) How to create devices (what API) - mdev has this figured out
>> 2) How to to do the addressing of the devices. Needs to be
>>    predictable/defined by the user - mdev has this figured out
>> 3) Udev names of netdevices - udev names that according to the
>>    bus/address. That is straightforeward with mdev.
>>    I can't really see how to figure this one in particular with
>>    per-driver busses :/
>
>Are network devices somehow only allowed to be on mdev busses?

Of course not. But there is a difference if we are talking about:
a) "the usual" network devices, like PF, VF. - They are well defined and
   they have well defined lifecycle (pci probe, sriov sysfs for number
   of VFs, etc). I this world all works fine. Even if a device has 100
   static subdevices (bus or no bus).
b) dynamically created sub-bar-devices or subfunctions. Could be created
   by user. This is not handled now in kernel, we have to find correct iface.
   I don't really care it it is fakebus, driverbus, etc. I'm just concerned
   about how to handle 1), 2), 3) above.

>
>No, don't be silly, userspace handles this just fine today on any type
>of bus, it's not an issue.
>
>You don't have to like individual "driver busses", but you had better
>not be using a fake platform device to use mdev.  That's my main
>objection...

Okay, I understand your objection. Do you have suggestion how to handle
1) 2) 3) from above?



>
>thanks,
>
>greg k-h
