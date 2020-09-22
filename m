Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31C4274118
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Sep 2020 13:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgIVLmN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Sep 2020 07:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbgIVLlb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Sep 2020 07:41:31 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D7BC061755
        for <linux-rdma@vger.kernel.org>; Tue, 22 Sep 2020 04:41:03 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id v123so18573897qkd.9
        for <linux-rdma@vger.kernel.org>; Tue, 22 Sep 2020 04:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yhD10jJduf1dgKkP68ou+U9mMDBt7tD8b18c/5OZcv0=;
        b=oLM4ZSFXdQRQNrMGFA4YSb6qTb/uhf0RGHa3k3SHj0ZvzobirHOgZvwEubXTdnmD8X
         g0x2RU5kwhc8KV33C74sw3XINlT28bOzpw2rBecqgyf3FXT7ZXS47XhIkkoeQL9f2Jfe
         EIQqCmlHxu3fRAjdPUH9yINPWViY4hmkzh5lHkLBKDKogJ630hwcVUz6cn09PmzhnOO/
         KL+VM28MhtYEZFAeBEVy/+CFbM/Pi3l7fJJG1rbNdVoWuN35JeMvqO0PShhsgCysTdlE
         HRLoZtFkdaOnoxgQxky1XAaqQenuLuplSVwOQa/0fViN1SStlWfN6no7PzOe/A2XUkfw
         P8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yhD10jJduf1dgKkP68ou+U9mMDBt7tD8b18c/5OZcv0=;
        b=pyy88w2Rqx30ImXPBX0MvvEODszD0HLu7lLrHiOfQ+k4KaZ6MmpRoO9eip6omNKRk1
         6uGuu2IYVMbWpvEdJDaEEA+pGRbOR1vJhYvP99xnyfEjQPtXQ6IqQlMbYQdzpF0Ka6Fn
         G06uCILJ4ZN78uuayT/GazUFAW8Fsfq+ixDCgJWc1oZlTOUPYLdtoVJHGC8prhRDhP44
         wHtVY4aVgzanHxWg5gksW33kXe01+mP9ysQbWzTVtwinq6ELCgH9boRNNnt88Jezq5OE
         DMUTaR6nNwzmnpHX25oMgo3bTO94OdYUR2WHByxRQBqVPF4lBTIswDfHb+mw/GRCW3+2
         aKLw==
X-Gm-Message-State: AOAM530QSVv3M9kdSt1DRj70LMEu8VcwoTPiyfFRETsJXRrRW/uWQC1U
        j12BdduWyG6DMe6eb4o315t7cw==
X-Google-Smtp-Source: ABdhPJxoKo95FitIWDwXAcSfyfcOjyXkE53rqNXh2wpAj0K7EF3gP3JDLJjqBxC4M8Uz6fncjY2f4g==
X-Received: by 2002:a37:7f82:: with SMTP id a124mr4296755qkd.70.1600774862931;
        Tue, 22 Sep 2020 04:41:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 192sm11863559qkn.9.2020.09.22.04.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 04:41:02 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kKgfN-0030RG-Hf; Tue, 22 Sep 2020 08:41:01 -0300
Date:   Tue, 22 Sep 2020 08:41:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Oded Gabbay <oded.gabbay@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        izur@habana.ai, Jakub Kicinski <kuba@kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, SW_Drivers <SW_Drivers@habana.ai>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rdma@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v3 00/14] Adding GAUDI NIC code to habanalabs driver
Message-ID: <20200922114101.GE8409@ziepe.ca>
References: <20200918132645.GS8409@ziepe.ca>
 <CAFCwf109t5=GuNvqTqLUCiYbjLC6o2xVoLY5C-SBqbN66f6wxg@mail.gmail.com>
 <20200918135915.GT8409@ziepe.ca>
 <CAFCwf13rJgb4=as7yW-2ZHvSnUd2NK1GP0UKKjyMfkB3vsnE5w@mail.gmail.com>
 <20200918141909.GU8409@ziepe.ca>
 <CAFCwf121_UNivhfPfO6uFoHbF+2Odeb1c3+482bOXeOZUsEnug@mail.gmail.com>
 <20200918150735.GV8409@ziepe.ca>
 <CAFCwf13y1VVy90zAoBPC-Gfj6mwMVbefh3fxKDVneuscp4esqA@mail.gmail.com>
 <20200918152852.GW8409@ziepe.ca>
 <b0721756-d323-b95e-b2d2-ca3ce8d4a660@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0721756-d323-b95e-b2d2-ca3ce8d4a660@amazon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 21, 2020 at 02:22:02PM +0300, Gal Pressman wrote:

> What is considered a RoCE port in this case if it's not compliant with RoCE?
> Sounds like it's an implementation of RDMA over ethernet, not RoCE.
> Does GAUDI support UD/RC/.. QPs? Is it using a proprietary wire protocol?
> (BTW, Oded claims it's similar to nvlink, how is nvlink's implementation
> exposed? Or is it closed source?)

I think Oded was drawing a parallel to how nvlink is integral with the
compute element. From Oded's descriptions I don't think it is much
like nvlink at all.

> Jason, how do you imagine GAUDI in the RDMA subsystem? Userspace control path
> verbs (used by hl-thunk?) and all data path verbs exposed as kverbs (used by
> habanalabs driver)?
> So neither any userspace verbs apps could use it nor kernel ULPs?

Based on what Oded described it seems like a reasonable RDMA device
with some limitations around MR IOVA.

Looks like the desire is to create a RDMA WR and CQ ring in userspace,
and then co-mingle that with the compute side of the device.

So instead of doing the special IOCTL and mmap against the compute FD
it would create a RDMA QP and RDMA CQ, use dv to access the raw
internals, and the propritary stack would have exactly the same stuff
it would have had with the misc ioctl.

But, completely separately, they'd also have to implement some of
verbs which serves as the open source userspace showing how this HW
works. What that is depends largely on what their HW can do, and if
they want to connect to UCX/mpi/libfabric/etc

A bunch of ioctl stubs or a few tests is far below our standard in
RDMA.

There may have been some argument that the compute side of this device
has no industry standards so should be a drivers/misc, but HPC
networking *does* have extensive standards and extensive open source
software stacks. It is very hard for me to see how a device in this
market could be competitive without integrating with that stuff.

Jason
