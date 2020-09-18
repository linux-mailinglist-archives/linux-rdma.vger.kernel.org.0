Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC4026FFA4
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Sep 2020 16:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgIROTM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Sep 2020 10:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgIROTM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Sep 2020 10:19:12 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BF6C0613CF
        for <linux-rdma@vger.kernel.org>; Fri, 18 Sep 2020 07:19:11 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n133so6154972qkn.11
        for <linux-rdma@vger.kernel.org>; Fri, 18 Sep 2020 07:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rIL2NLdhv8UHLyKk+/3ZeKf7PumiGUshneBVAsFC8RU=;
        b=eVHGRpfbvUHhJtCI7a/HSgEXHOeJRclCsPpPjilLr8bn/2ZDk8GvAIFpbxk25n+9Xi
         K3IK+i8bZFSDhCG+/nG3pA+5CTw185GsvFGV8z++As1EIj/4cf+YggG4C9L8bZqdBJSj
         ITJhPIx15YcGbgGfFyARD63vUBy80olD6Jrcyvk5Ks65wyv9+BRqKlYxLlR6/GrLN+9a
         2TCvLfXhOOokJYJnbWRf0Zt3c0HzAT9PTb2lxMsnT4FfQGkuE7J5zfDioCcwIVQr5tpG
         kSGG+Znr1Gf8ghHcLdFO4SMgKOxSVCOtx3PSULAjrSS50WKJwKxtKYvzomxrHKcsnH1M
         fYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rIL2NLdhv8UHLyKk+/3ZeKf7PumiGUshneBVAsFC8RU=;
        b=XioL65BuNPt/ZZqVT24eINdgLy66fu1Smvg/TyzDpq5GXIPfthUjKcuvBd8xVUZ0uC
         03wDzMh87N/p/U75sOOcvEjobyfor6wQ65AXgD9EX8iZ+EzVY7eQBcQYYvstJAE5HGbG
         wE1gkSjLgpYxm/ejLwTihfrvTIuQk+/C7TFl8fwp3VvveoGY7cHEnHFx9euQXI2FEyC+
         wpDKRM22YxkWYy6/68qP8SG+cxUs6P0Bpvq0WWr/RMRYouxgW9Pwq0Sf4VRdiBafkcS4
         WJQw9ch6xmxkTMUEo/Fku630rwHdy50garXJcUVC3qtHZDg+0kCnhtZiRTeYgAUZVLiT
         H9sg==
X-Gm-Message-State: AOAM531lVQ/XFWaoGqPcJLWEf5gJ52KpyFkfpooHJmErNPa1ssV0VrG8
        ++9YT9kxV7Obgvb5TTX8gVGIqg==
X-Google-Smtp-Source: ABdhPJxmmLPYBTxICIPihqUN8X52gX4di7sUDCFm6VN2R6Tj/8VNC0FpRZYY84lqjE61W0QaCLFSKw==
X-Received: by 2002:a37:4b84:: with SMTP id y126mr32518400qka.148.1600438750952;
        Fri, 18 Sep 2020 07:19:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id x197sm2183540qkb.17.2020.09.18.07.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 07:19:09 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kJHED-001HZ3-6r; Fri, 18 Sep 2020 11:19:09 -0300
Date:   Fri, 18 Sep 2020 11:19:09 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, izur@habana.ai,
        Gal Pressman <galpress@amazon.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, SW_Drivers <SW_Drivers@habana.ai>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rdma@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v3 00/14] Adding GAUDI NIC code to habanalabs driver
Message-ID: <20200918141909.GU8409@ziepe.ca>
References: <20200918115601.GP8409@ziepe.ca>
 <CAFCwf12G4FnhjzijZLh_=n59SQMcTnULTqp8DOeQGyX6_q_ayA@mail.gmail.com>
 <20200918121621.GQ8409@ziepe.ca>
 <CAFCwf12YBaka2w2cnTxyX9L=heMnaM6QN1_oJ7h7DxHDmy2Xng@mail.gmail.com>
 <20200918125014.GR8409@ziepe.ca>
 <CAFCwf12oK4RXYhgzXiN_YvXvjoW1Fwx1xBzR3Y5E4RLvzn_vhA@mail.gmail.com>
 <20200918132645.GS8409@ziepe.ca>
 <CAFCwf109t5=GuNvqTqLUCiYbjLC6o2xVoLY5C-SBqbN66f6wxg@mail.gmail.com>
 <20200918135915.GT8409@ziepe.ca>
 <CAFCwf13rJgb4=as7yW-2ZHvSnUd2NK1GP0UKKjyMfkB3vsnE5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf13rJgb4=as7yW-2ZHvSnUd2NK1GP0UKKjyMfkB3vsnE5w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 18, 2020 at 05:12:04PM +0300, Oded Gabbay wrote:
> On Fri, Sep 18, 2020 at 4:59 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Fri, Sep 18, 2020 at 04:49:25PM +0300, Oded Gabbay wrote:
> > > On Fri, Sep 18, 2020 at 4:26 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > >
> > > > On Fri, Sep 18, 2020 at 04:02:24PM +0300, Oded Gabbay wrote:
> > > >
> > > > > The problem with MR is that the API doesn't let us return a new VA. It
> > > > > forces us to use the original VA that the Host OS allocated.
> > > >
> > > > If using the common MR API you'd have to assign a unique linear range
> > > > in the single device address map and record both the IOVA and the MMU
> > > > VA in the kernel struct.
> > > >
> > > > Then when submitting work using that MR lkey the kernel will adjust
> > > > the work VA using the equation (WORK_VA - IOVA) + MMU_VA before
> > > > forwarding to HW.
> > > >
> > > We can't do that. That will kill the performance. If for every
> > > submission I need to modify the packet's contents, the throughput will
> > > go downhill.
> >
> > You clearly didn't read where I explained there is a fast path and
> > slow path expectation.
> >
> > > Also, submissions to our RDMA qmans are coupled with submissions to
> > > our DMA/Compute QMANs. We can't separate those to different API calls.
> > > That will also kill performance and in addition, will prevent us from
> > > synchronizing all the engines.
> >
> > Not sure I see why this is a problem. I already explained the fast
> > device specific path.
> >
> > As long as the kernel maintains proper security when it processes
> > submissions the driver can allow objects to cross between the two
> > domains.
> Can you please explain what you mean by "two domains" ?
> You mean the RDMA and compute domains ? Or something else ?

Yes

> What I was trying to say is that I don't want the application to split
> its submissions to different system calls.

If you can manage the security then you can cross them. Eg since The
RDMA PD would be created on top of the /dev/misc char dev then it is
fine for the /dev/misc char dev to access the RDMA objects as a 'dv
fast path'.

But now that you say everything is interconnected, I'm wondering,
without HW security how do you keep netdev isolated from userspace?

Can I issue commands to /dev/misc and write to kernel memory (does the
kernel put any pages into the single MMU?) or corrupt the netdev
driver operations in any way?

Jason
