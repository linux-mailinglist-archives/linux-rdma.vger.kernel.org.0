Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22B30103D49
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Nov 2019 15:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731181AbfKTOa5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Nov 2019 09:30:57 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44641 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730952AbfKTOa5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Nov 2019 09:30:57 -0500
Received: by mail-qt1-f196.google.com with SMTP id o11so29086001qtr.11
        for <linux-rdma@vger.kernel.org>; Wed, 20 Nov 2019 06:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qFog+YvhASaLqT/ReeSMx1fMaqvhH0iNVVW28c/WLoE=;
        b=V90BkQYZx694+cYQzV+12mnMzB4rvwTVSL531dPwldTmN40zOSo8vtI17ULgI9iV1G
         d6w8nfqV4nRQ4iAABdVVvTt+jH5bsF2ld371y0T8+Ews0h8zZSOEfhdj4lKL6v3mHVBd
         QC2Fir248pTW0cfxLSDfXCv0Xjy0RT0IArmQKd4a60qCI6mY+RauFuJmgBP8oF3XmPJl
         JFYvyGrA5KXaIeMIXYgiPBCqNSWRbxA3jeRrYEFHsXD2vrjsmMMYGDB+iMrQaQaikZPs
         kuI2APdGVbeHNN/iGaZ7tCJcMQQjkc4sgtuFSX3YbH7w/2DC0//e2Bg+CdJC42aW7/O9
         Wwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qFog+YvhASaLqT/ReeSMx1fMaqvhH0iNVVW28c/WLoE=;
        b=S8kkM3Dvuvufe71MWiII/45cWgbzkiSSjxTICGPM+vkBexpTyAjZbSYNI4Eg8CamIp
         k2ZLKgPC/gGatJqVPwSX/4mY4kG6ckgLDFrYej6EaXsva4HkJPCWeGsfGQwjWPsjRAj9
         R+ClTiixKL8oeJUuX9hgCESW51F+JyyJVOP7xP3JNhFU47wA/SrrNQeEuJLQah34M1Lf
         P7Y41K41qRGECVAUvjjsaHsf64qICdV1XLhVQaq4cYYrpWefp9mNvTBymEbBfl2TIry0
         105yyHdxoIRuVxYY56fV3b2IQXWXxcHUwBvbJr2Q6yfWtdUOblTx/S9majFGZqHhVHi2
         KOdw==
X-Gm-Message-State: APjAAAVUEq+FhGv6cFWkXjj5TBejXged0vGm5ZT0u23bCwcBgjqw2oN/
        Cii+UK9oyB43rr9puW+0RXTcLQ==
X-Google-Smtp-Source: APXvYqxkSLPZKhcx3oFV8puZ8cUO+WnEtyVyuwoo1SsoIXgnA7yJnf7OSkSxpOvcpUJSp/jczjDJ9Q==
X-Received: by 2002:ac8:424d:: with SMTP id r13mr2900493qtm.111.1574260255890;
        Wed, 20 Nov 2019 06:30:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id w20sm11618284qkj.87.2019.11.20.06.30.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Nov 2019 06:30:55 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iXR0Q-0006xX-Ob; Wed, 20 Nov 2019 10:30:54 -0400
Date:   Wed, 20 Nov 2019 10:30:54 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Dave Ertman <david.m.ertman@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "nhorman@redhat.com" <nhorman@redhat.com>,
        "sassmann@redhat.com" <sassmann@redhat.com>,
        Kiran Patil <kiran.patil@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Bie, Tiwei" <tiwei.bie@intel.com>
Subject: Re: [net-next v2 1/1] virtual-bus: Implementation of Virtual Bus
Message-ID: <20191120143054.GF22515@ziepe.ca>
References: <20191119164632.GA4991@ziepe.ca>
 <20191119134822-mutt-send-email-mst@kernel.org>
 <20191119191547.GL4991@ziepe.ca>
 <20191119163147-mutt-send-email-mst@kernel.org>
 <20191119231023.GN4991@ziepe.ca>
 <20191119191053-mutt-send-email-mst@kernel.org>
 <20191120014653.GR4991@ziepe.ca>
 <20191120022141-mutt-send-email-mst@kernel.org>
 <20191120130319.GA22515@ziepe.ca>
 <20191120083908-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120083908-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 20, 2019 at 08:43:20AM -0500, Michael S. Tsirkin wrote:
> On Wed, Nov 20, 2019 at 09:03:19AM -0400, Jason Gunthorpe wrote:
> > On Wed, Nov 20, 2019 at 02:38:08AM -0500, Michael S. Tsirkin wrote:
> > > > > I don't think that extends as far as actively encouraging userspace
> > > > > drivers poking at hardware in a vendor specific way.  
> > > > 
> > > > Yes, it does, if you can implement your user space requirements using
> > > > vfio then why do you need a kernel driver?
> > > 
> > > People's requirements differ. You are happy with just pass through a VF
> > > you can already use it. Case closed. There are enough people who have
> > > a fixed userspace that people have built virtio accelerators,
> > > now there's value in supporting that, and a vendor specific
> > > userspace blob is not supporting that requirement.
> > 
> > I have no idea what you are trying to explain here. I'm not advocating
> > for vfio pass through.
> 
> You seem to come from an RDMA background, used to userspace linking to
> vendor libraries to do basic things like push bits out on the network,
> because users live on the performance edge and rebuild their
> userspace often anyway.
> 
> Lots of people are not like that, they would rather have the
> vendor-specific driver live in the kernel, with userspace being
> portable, thank you very much.

You are actually proposing a very RDMA like approach with a split
kernel/user driver design. Maybe the virtio user driver will turn out
to be 'portable'.

Based on the last 20 years of experience, the kernel component has
proven to be the larger burden and drag than the userspace part. I
think the high interest in DPDK, SPDK and others show this is a common
principle.

At the very least for new approaches like this it makes alot of sense
to have a user space driver until enough HW is available that a
proper, well thought out kernel side can be built.

For instance, this VFIO based approach might be very suitable to the
intel VF based ICF driver, but we don't yet have an example of non-VF
HW that might not be well suited to VFIO.

Jason
