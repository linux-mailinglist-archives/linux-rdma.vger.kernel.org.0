Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8ED1D1CDE
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 20:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390075AbgEMSCs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 May 2020 14:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390060AbgEMSCs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 May 2020 14:02:48 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3B2C061A0C
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2020 11:02:47 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id 4so584810qtb.4
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2020 11:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G3My3QExRg+wMIkrZ40rkfhl/oO0vR5alF8uEdjWabw=;
        b=mptlr45TG0Baj+i55er6Q1RoiFO/NZNdl5Jm4Mm9PWKuDw7uHaVdpKTIjtPxOXxsX3
         pyP/S8ToPG1P8h8P4t2K+moJVqzDtzBK18XwKe0IBDwhSDbY7mQkO+jmZgRdbUf983aT
         yzRtTJpPuczPBfvlzG9A7Zq4YebHVWK8kyOa1IXl19xjVGEyx3tMD5poVQ1wkIySpR26
         AOFxP+PwtZqnawoYgj15olVObmqooYIO7Rsto6NBDs/jz8Ish0TphZjTWsdpFUuVCjjL
         qXTeIOgpl1TZfhI0Oto7TDJAMMYXJ+AHAPlS8pq+oroPpcZqqfrzMYHWCNRw2KX4phSX
         lZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G3My3QExRg+wMIkrZ40rkfhl/oO0vR5alF8uEdjWabw=;
        b=mqxc2R2EYdxgYWp5UreBxbtcweelcKE7lsmNG/2lL/SKzlvFcA+FlLL2kVNIpIQJFn
         EcGc0t/SSrE1XME8zuF2pJmTeXyaIfiWUABMKcfcyC3G+DnbbYkWh6Wmwha2hmIUOKbZ
         uuUzJgO5T0oFT5//SniZbz+oJZEsYySv3lR/qVNpqbXiOkyaDNqctsxh7u19GETRVORR
         WycD3LuLnpM0biLurvtoOQNE9jcGlDzI6SYz/YvievpP01YPUZOOrBZbE7TGcLBnC3He
         1EuXaaV8GrsZRQqExhzCXtO5VV8A5uHyS4U2XKMYfCXxwqdFPP+xYup895yVokTRkfNW
         j86g==
X-Gm-Message-State: AOAM533ChMEbXbCgzJ8yd3GEcAPQ6qGyn21dOZiOBgq7XPdhW9iN/1GZ
        STQuhdgY/bQx3dWhg14mpNdxBA==
X-Google-Smtp-Source: ABdhPJzNDTCbsMiWdWYhIyYQ5ZP6N9MAeNHhk3N2V9TbEmRgvNXA9h+lHcFfx3WqjwUXsWlSlUCGIQ==
X-Received: by 2002:ac8:27ef:: with SMTP id x44mr310556qtx.233.1589392967062;
        Wed, 13 May 2020 11:02:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id t21sm312324qtb.0.2020.05.13.11.02.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 May 2020 11:02:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jYviO-0005Ge-QL; Wed, 13 May 2020 15:02:44 -0300
Date:   Wed, 13 May 2020 15:02:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Kamal Heib <kamalheib1@gmail.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-rc] RDMA/srpt: Fix disabling device management
Message-ID: <20200513180244.GE29989@ziepe.ca>
References: <20200513072203.GR4814@unreal>
 <20200513100204.GA92901@kheib-workstation>
 <20200513102132.GW4814@unreal>
 <20200513104536.GA120318@kheib-workstation>
 <20200513105045.GX4814@unreal>
 <20200513111435.GA121070@kheib-workstation>
 <20200513113118.GY4814@unreal>
 <20200513123837.GA123854@kheib-workstation>
 <20200513124334.GA29989@ziepe.ca>
 <d3e729d7-97c0-607c-b1b3-80a2df47cbae@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3e729d7-97c0-607c-b1b3-80a2df47cbae@acm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 13, 2020 at 08:25:41AM -0700, Bart Van Assche wrote:
> On 2020-05-13 05:43, Jason Gunthorpe wrote:
> > On Wed, May 13, 2020 at 03:38:37PM +0300, Kamal Heib wrote:
> >>>> Correct me if I'm wrong, Do you mean check the return value from
> >>>> rdma_cap_ib_mad()?
> >>>
> >>> I think so.
> >>>
> >>> Thanks
> >>
> >> Well, this function will not help in the case of VFs, because the flag
> >> that is checked in rdma_cap_ib_mad() is RDMA_CORE_CAP_IB_MAD which is
> >> set almost for each create IB device as part of RDMA_CORE_PORT_IBA_IB or
> >> RDMA_CORE_PORT_IBA_ROCE or RDMA_CORE_PORT_IBA_ROCE_UDP_ENCAP.
> > 
> > AFAIK this case only happens for mlx4 devices that use the GUID table
> > to emulate virtual IB ports. In this case there is no bit to control.
> > 
> > I didn't quite understand why srpt has this stuff, does it mean it is
> > broken on mlx4 vports? Why allow the failure?
> 
> The commit message of the code that introduced the most recent
> IB_PORT_DEVICE_MGMT_SUP changes is as follows:
> 
> commit 09f8a1486dcaf69753961a6df6cffdaafc5ccbcb
> Author: Bart Van Assche <bvanassche@acm.org>
> Date:   Mon Sep 30 16:17:01 2019 -0700
> 
> RDMA/srpt: Fix handling of SR-IOV and iWARP ports
> 
> Management datagrams (MADs) are not supported by SR-IOV VFs nor by iWARP
> ports. Support SR-IOV VFs and iWARP ports by only logging an error
> message if MAD handler registration fails.
> 
> In other words, on my setup the ib_srpt driver was working find with SR-IOV.

But it won't be properly discoverable without the
IB_PORT_DEVICE_MGMT_SUP flag being set on the physical port?

Jason
