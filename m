Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDD81076E9
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Nov 2019 19:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfKVSCS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Nov 2019 13:02:18 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:41071 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfKVSCR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Nov 2019 13:02:17 -0500
Received: by mail-qv1-f65.google.com with SMTP id g18so3230698qvp.8
        for <linux-rdma@vger.kernel.org>; Fri, 22 Nov 2019 10:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hsXnD7kK3zrOkwDTJ2cHioZGS4xoTdgUqdl7VTQnApI=;
        b=ooYwEgXuTRLH49nlRv3s3cuNcbiGvCmEW7MGlX8PknB2E8i09YJSnpEPol6nXsRWp+
         rEc+bNMvmqfbsjh7hUKl86dXILkgUILJIUt8GTvjfTTwgqvs/9Ft4GpP4j/wXxcfIFMg
         9QjfFDVmE7l10MQkBT54EzHxkMatOGSADp8IajT/ovuLS8by3di5ERKr2jRVN1oribtG
         0+9aosDiwsQTYk6kEvAuhAzspySZMQPY0QuHpekq/nH+Ou9TWRCmDMFkLvr4hZKWOjsT
         e2NAzeOIiJ4th1lINXtjjBJTSB7gagAf7Y6+aUfDh95gcY7MFe8huOUFIffE68W+Mi4E
         Sa1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hsXnD7kK3zrOkwDTJ2cHioZGS4xoTdgUqdl7VTQnApI=;
        b=DobQBZyTZ7cPPavPC2N6/GCwq/VSU9A7Lva7GYHpncrBoEwgKBiL6DsAOotKtEa5E2
         uEbqhIa6AkSj6+6UBSdyBm/CRsSfSk1LF+vnYk8frNZgOLzA/8TUaCmOXnrNrrAHpQ7o
         GGIZZqUOFupv585x4V+VanitHmvNcpz7TZ07sId6O6iVwvrT1FWL6EUUj0NB287glKGR
         LX51v8yn3yWttRM0QUsgHReq07bD6WNAR1us5V9SX5LZUaeCGIfHNsKnbcjg5vSZAdF1
         6mFW93GIrG30l0gcLOGSMHlR3+rxQPa2o5ok5Dgw0kmd0r1S92dKDxJYpSogHtuamla0
         jVSw==
X-Gm-Message-State: APjAAAXHgCs1VSJqccYuj35zO6eWGjmKimPW2JZKA8XAIoQlIGaquQZ0
        kUf1/gPyR6Q5yukbw38ie4Kjig==
X-Google-Smtp-Source: APXvYqysJEbPMoT6CM40ePfhk5Y1fEYY/st9Q8OlCJRYGMOT04XtXFthx3nNeqvNLtutEI3X1FYVZw==
X-Received: by 2002:a05:6214:1104:: with SMTP id e4mr4846273qvs.124.1574445736265;
        Fri, 22 Nov 2019 10:02:16 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id z70sm3294156qkb.60.2019.11.22.10.02.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Nov 2019 10:02:15 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iYDG2-0000UA-Gt; Fri, 22 Nov 2019 14:02:14 -0400
Date:   Fri, 22 Nov 2019 14:02:14 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        Dave Ertman <david.m.ertman@intel.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, nhorman@redhat.com,
        sassmann@redhat.com, Kiran Patil <kiran.patil@intel.com>,
        Tiwei Bie <tiwei.bie@intel.com>
Subject: Re: [net-next v2 1/1] virtual-bus: Implementation of Virtual Bus
Message-ID: <20191122180214.GD7448@ziepe.ca>
References: <20191120014653.GR4991@ziepe.ca>
 <134058913.35624136.1574222360435.JavaMail.zimbra@redhat.com>
 <20191120133835.GC22515@ziepe.ca>
 <20191120102856.7e01e2e2@x1.home>
 <20191120181108.GJ22515@ziepe.ca>
 <20191120150732.2fffa141@x1.home>
 <20191121030357.GB16914@ziepe.ca>
 <5dcef4ab-feb5-d116-b2a9-50608784a054@redhat.com>
 <20191121141732.GB7448@ziepe.ca>
 <721e49c2-a2e1-853f-298b-9601c32fcf9e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <721e49c2-a2e1-853f-298b-9601c32fcf9e@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 22, 2019 at 04:45:38PM +0800, Jason Wang wrote:
> 
> On 2019/11/21 下午10:17, Jason Gunthorpe wrote:
> > On Thu, Nov 21, 2019 at 03:21:29PM +0800, Jason Wang wrote:
> > > > The role of vfio has traditionally been around secure device
> > > > assignment of a HW resource to a VM. I'm not totally clear on what the
> > > > role if mdev is seen to be, but all the mdev drivers in the tree seem
> > > > to make 'and pass it to KVM' a big part of their description.
> > > > 
> > > > So, looking at the virtio patches, I see some intended use is to map
> > > > some BAR pages into the VM.
> > > Nope, at least not for the current stage. It still depends on the
> > > virtio-net-pci emulatio in qemu to work. In the future, we will allow such
> > > mapping only for dorbell.
> > There has been a lot of emails today, but I think this is the main
> > point I want to respond to.
> > 
> > Using vfio when you don't even assign any part of the device BAR to
> > the VM is, frankly, a gigantic misuse, IMHO.
> 
> That's not a compelling point. 

Well, this discussion is going nowhere.

> > Just needing userspace DMA is not, in any way, a justification to use
> > vfio.
> > 
> > We have extensive library interfaces in the kernel to do userspace DMA
> > and subsystems like GPU and RDMA are full of example uses of this kind
> > of stuff.
> 
> I'm not sure which library did you mean here. Is any of those library used
> by qemu? If not, what's the reason?

I mean the library functions in the kernel that vfio uses to implement
all the user dma stuff. Other subsystems use them too, it is not
exclusive to vfio.

> > Further, I do not think it is wise to design the userspace ABI around
> > a simplistict implementation that can't do BAR assignment,
> 
> Again, the vhost-mdev follow the VFIO ABI, no new ABI is invented, and
> mmap() was kept their for mapping device regions.

The patches have a new file in include/uapi.

Everything in include/api is considered new user ABI.

> > My advice is to proceed as a proper subsystem with your own chardev,
> > own bus type, etc and maybe live in staging for a bit until 2-3
> > drivers are implementing the ABI (or at the very least agreeing with),
> > as is the typical process for Linux.
> 
> I'm open to comments for sure, but looking at all the requirement for vDPA,
> most of the requirement could be settled through existed modules, that's not
> only a simplification for developing but also for management layer or
> userspace drivers.

We've already got disagreement that the GUID based mdev approach is
desirable for management.

Performing userspace DMA from a kernel driver is absolutely not a
reason to use VFIO.

Is there any technical justification?

Jason
