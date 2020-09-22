Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8F52746FB
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Sep 2020 18:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgIVQwL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Sep 2020 12:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgIVQwL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Sep 2020 12:52:11 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9087AC061755
        for <linux-rdma@vger.kernel.org>; Tue, 22 Sep 2020 09:52:11 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id w12so19731793qki.6
        for <linux-rdma@vger.kernel.org>; Tue, 22 Sep 2020 09:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UW8UQhISUFkiKSe3z9186mRXQeii/XHHTh3pl00bIbE=;
        b=S4S1yu+0DdwteB1gK8Vw7Sirfx6bWa/xLWIPsdLuX1Bps9wYPzDFiWdNH0kTjgN29M
         TMvFXWvwsuK4mQntUtTNmNPqHcUp2Bt0UyAhSjDoR0w7I+1zs5PnGDwSjtvodQnfNSgu
         Fi3MyXpKQBsUyQvcqnEnnVuMHA7RhVsOiRzzvzuoN7XkXcdZBi0WwhS6kHB+yw1YZ5hm
         tL5kKLQRoVrbbjQRQu4OZ38NWMlSubrVENywqwisJ9uCPX4HoQYFXwV5wqv0PGaukqxI
         WjfJYMlX8PWi2A5M23siDPT67CovWFKOTdrEvHKEqln4v3lFsvC1XgcqsIHiMfxvB67K
         BX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UW8UQhISUFkiKSe3z9186mRXQeii/XHHTh3pl00bIbE=;
        b=ju14Nih9nYaX0M2BINNKE6wxEyLwRxL8sShAWPJxsCZUYVhUyolKvRdwbX37G7bcCy
         cjxnd23OwaKqiPWQpkl7OgO6HGA0oL6V7xK5tybct+r4RsGHOMxC0rh1nT7UsZCTO+dZ
         TVFWh5GeKGtKrWCisDzPCxL2GhfLB3iIjGVRVLRMKVOFr5rUbfMM6Da3AO9B3BrNBhYr
         k1nWfY0zokVwl7WtJTQ+8k6DRVn6TY6/40lL4Sn9UuY5i/xDytueUUoKymZ9k/pcLwqJ
         5g+W02QJf3xnt/QHWNgwyXkh5/U1SnPeOKvqNHD3J25Yxjng+PCmL/slri2NxDsvo6Mg
         5FBw==
X-Gm-Message-State: AOAM530CfOIG4MuN9G9HF4ftEPnaUAwrFH9fbaa3ib7z1URseSIvCNJO
        Zk9LEA1Ne4T39i4CcPVoWkEAhA==
X-Google-Smtp-Source: ABdhPJxmh2ODYVAVV5V1OHM0DbPqOPp70bzHRBRnt4lz3LGXVWYYfZGjCS0zSBO5X1zbygWZYdhOJA==
X-Received: by 2002:a37:a2d2:: with SMTP id l201mr5772720qke.454.1600793530818;
        Tue, 22 Sep 2020 09:52:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id k52sm13437898qtc.56.2020.09.22.09.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 09:52:10 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kKlWT-003CDZ-Jn; Tue, 22 Sep 2020 13:52:09 -0300
Date:   Tue, 22 Sep 2020 13:52:09 -0300
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
Message-ID: <20200922165209.GJ8409@ziepe.ca>
References: <20200918141909.GU8409@ziepe.ca>
 <CAFCwf121_UNivhfPfO6uFoHbF+2Odeb1c3+482bOXeOZUsEnug@mail.gmail.com>
 <20200918150735.GV8409@ziepe.ca>
 <CAFCwf13y1VVy90zAoBPC-Gfj6mwMVbefh3fxKDVneuscp4esqA@mail.gmail.com>
 <20200918152852.GW8409@ziepe.ca>
 <b0721756-d323-b95e-b2d2-ca3ce8d4a660@amazon.com>
 <20200922114101.GE8409@ziepe.ca>
 <a16802a2-4a36-e03d-a927-c5cb7c766b99@amazon.com>
 <20200922161429.GI8409@ziepe.ca>
 <e06c573a-99a7-906c-8197-847a61fba44a@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e06c573a-99a7-906c-8197-847a61fba44a@amazon.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 22, 2020 at 07:30:32PM +0300, Gal Pressman wrote:
> On 22/09/2020 19:14, Jason Gunthorpe wrote:
> > On Tue, Sep 22, 2020 at 03:46:29PM +0300, Gal Pressman wrote:
> > 
> >> I agree, that makes sense.
> >> But assuming Oded actually goes and implements all the needed verbs to get a
> >> basic functional libibverbs provider (assuming their HW can do it somehow), is
> >> it really useful if no one is going to use it?
> >> It doesn't sound like habanalabs want people to use GAUDI as an RDMA adapter,
> >> and I'm assuming the only real world use case is going to be using the hl stack,
> >> which means we're left with a lot of dead code that's not used/tested by anyone.
> >>
> >> Genuine question, wouldn't it be better if they only implement what's actually
> >> going to be used and tested by their customers?
> > 
> > The general standard for this 'accel' hardware, both in DRM and RDMA
> > is to present an open source userspace. Companies are encouraged to
> > use that as their main interface but I suppose are free to carry the
> > cost of dual APIs, and the community's wrath if they want.
> 
> I didn't mean they should maintain two interfaces.
> The question is whether they should implement libibverbs support that covers the
> cases used by their stack, or should they implement all "mandatory" verbs so
> they could be able to run libibverbs' examples/perftest/pyverbs as well, even
> though these will likely be the only apps covering these verbs.

As I said, the minimum standard is an open source user space that will
operate the NIC. For EFA we decided that was ibv_ud_pingpong, and now
parts of pyverbs. A similar decision would be needed here too. It is a
conversation that should start with a propsal from Oded.

The *point* is to have the open userspace, so I really don't care what
their proprietary universe does, and shrinking the opensource side
becuase it is "redundant" is completely backwards to what we want to
see.

Jason
