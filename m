Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E005C132E99
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2020 19:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgAGSkW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jan 2020 13:40:22 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]:38525 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgAGSkW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jan 2020 13:40:22 -0500
Received: by mail-qk1-f182.google.com with SMTP id k6so310880qki.5
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jan 2020 10:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7/esL9mofWs9OYTmbZfBJKn+KQ87u480WaBItFHVtYE=;
        b=bzwyVDK8029xBpMWbRXP8UTJa6tNKSCzT7nos9WNQRRE46ASqTWyQURdiDHw7Bu0in
         lrJIwiPt4FVsGJ4Hsuc3FmP5tpjaDiVLEVoDVh54rSwY2lsuZeWq2GC1SvGRP6jBGz+2
         vzMct/piu0XbI2vkv54UYktRzLuCyCBiq47VSfwl51M9lKb6ZZVbJPRYPjC416smAxOi
         iQD8Kk4239nMXVSJRHmZuUwy4SKxZNeImOR9QiK7vYR6mYjtGmO6mHQx67v+TN1QZm8W
         FeggC3bfrcipPkZLBsPEvuPVHSWhJwr80gGXIiibyMOV28G8NTE7LRP1ASwdhwMGKQhK
         vpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7/esL9mofWs9OYTmbZfBJKn+KQ87u480WaBItFHVtYE=;
        b=NstYk6O0IKcCl1qXYeNjvWvudiKP1QSl/+ZUkSA56/Qg+ptgHmgAo6Rzr+3cf0U88U
         UVwh3RbSRgxvWs+9kulvWgx5fF0X/whGk4kc36OgUkAMZr8Heg++Lemx119yn3r+RfIh
         3+dCybzJYVn+ZAM7N1MJ+y4dnKqgy50n06nS4JMaVh4E9VIAITeEv66+loTg5yKKwndV
         rWOH69HKk4NQug0usRNEkcP6Yg2iU5XvxqTp2d3SIcdCKoyzQoqBAqGfIF1cm8bRafRe
         KxgdtdB0umQccdcF0NRCvKoXBkXBC72CjqQoEoEzEDcQ3mlVaoUTj64IIqLXEg2Tc6tB
         YpJA==
X-Gm-Message-State: APjAAAWMe6SPwWHs+P8NDLGJANJkyzVL3ys9ZDiOJbLA2/659/bNAI0A
        zxOj5MxecIdO2uL8qlfIQMXIHQ==
X-Google-Smtp-Source: APXvYqwFJruY5b7E0qHhAp0zGNFbbUjoP42TkrsdNgZCfCosuMaeb9YpPpbBH5UW4qG/a8SbKf7DrQ==
X-Received: by 2002:ae9:ee11:: with SMTP id i17mr674188qkg.333.1578422420929;
        Tue, 07 Jan 2020 10:40:20 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id c6sm187277qka.111.2020.01.07.10.40.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 10:40:20 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iotm7-00025e-Ra; Tue, 07 Jan 2020 14:40:19 -0400
Date:   Tue, 7 Jan 2020 14:40:19 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: Re: [PATCH rdma-rc v2 00/48] Organize code according to IBTA layout
Message-ID: <20200107184019.GA20166@ziepe.ca>
References: <20191212093830.316934-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212093830.316934-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 12, 2019 at 11:37:42AM +0200, Leon Romanovsky wrote:
>   RDMA/cm: Delete unused CM LAP functions
>   RDMA/cm: Delete unused CM ARP functions

These are applied to for-next

> Leon Romanovsky (48):
>   RDMA/cm: Provide private data size to CM users
>   RDMA/srpt: Use private_data_len instead of hardcoded value
>   RDMA/ucma: Mask QPN to be 24 bits according to IBTA
>   RDMA/cm: Add SET/GET implementations to hide IBA wire format
>   RDMA/cm: Request For Communication (REQ) message definitions
>   RDMA/cm: Message Receipt Acknowledgment (MRA) message definitions
>   RDMA/cm: Reject (REJ) message definitions
>   RDMA/cm: Reply To Request for communication (REP) definitions
>   RDMA/cm: Ready To Use (RTU) definitions
>   RDMA/cm: Request For Communication Release (DREQ) definitions
>   RDMA/cm: Reply To Request For Communication Release (DREP) definitions
>   RDMA/cm: Load Alternate Path (LAP) definitions
>   RDMA/cm: Alternate Path Response (APR) message definitions
>   RDMA/cm: Service ID Resolution Request (SIDR_REQ) definitions
>   RDMA/cm: Service ID Resolution Response (SIDR_REP) definitions
>   RDMA/cm: Convert QPN and EECN to be u32 variables
>   RDMA/cm: Convert REQ responded resources to the new scheme
>   RDMA/cm: Convert REQ initiator depth to the new scheme
>   RDMA/cm: Convert REQ remote response timeout
>   RDMA/cm: Simplify QP type to wire protocol translation
>   RDMA/cm: Convert REQ flow control
>   RDMA/cm: Convert starting PSN to be u32 variable
>   RDMA/cm: Update REQ local response timeout
>   RDMA/cm: Convert REQ retry count to use new scheme
>   RDMA/cm: Update REQ path MTU field
>   RDMA/cm: Convert REQ RNR retry timeout counter
>   RDMA/cm: Convert REQ MAX CM retries
>   RDMA/cm: Convert REQ SRQ field
>   RDMA/cm: Convert REQ flow label field
>   RDMA/cm: Convert REQ packet rate
>   RDMA/cm: Convert REQ SL fields
>   RDMA/cm: Convert REQ subnet local fields
>   RDMA/cm: Convert REQ local ack timeout
>   RDMA/cm: Convert MRA MRAed field
>   RDMA/cm: Convert MRA service timeout
>   RDMA/cm: Update REJ struct to use new scheme
>   RDMA/cm: Convert REP target ack delay field
>   RDMA/cm: Convert REP failover accepted field
>   RDMA/cm: Convert REP flow control field
>   RDMA/cm: Convert REP RNR retry count field
>   RDMA/cm: Convert REP SRQ field
>   RDMA/cm: Convert LAP flow label field
>   RDMA/cm: Convert LAP fields
>   RDMA/cm: Convert SIDR_REP to new scheme
>   RDMA/cm: Add Enhanced Connection Establishment (ECE) bits
>   RDMA/cm: Convert private_date access

I spent a long, long time looking at this. Far too long.

The series is too big, and the patches make too many changes all at
once. There are also many problems with the IBA_GET/etc macros I gave
you. Finally, I didn't like that it only did half the job and still
left the old structs around.

I fixed it all up, and put it here:

https://github.com/jgunthorpe/linux/commits/cm_rework

I originaly started by just writing out the IBA_CHECK things in the
first patch. This showed that the IBA_ acessors were not working right
(I fixed all those too). At the end of that exercise I had full
confidence that the new macros and the field descriptors were OK.

When I started to look at the actual conversion patches and doing the
missing ones, I realized this whole thing was trivially done via
spatch. So I made a script that took the proven mapping of new names
to old names and had it code gen a spatch script which then was
applied.

I split the spatch rules into 4 patches bases on 'kind of thing' being
converted.

The first two can be diffed against your series. I didn't observe any
problems, so the conversion was probably good. However, it was hard to
tell as there was lots of functional changes mixed in your series,
like dropping more BE's and what not.

The last two complete the work and convert all the loose structure
members. The final one deletes most of cm_msgs.h

I have a pretty high confidence in the spatch process and the input
markup. But I didn't run sparse or test it.

While this does not do everything your series did, it gobbles up all
the high LOC stuff and the remaining things like dropping more of the
be's are best done as smaller followup patches which can be applied
right away.

The full diffstat is ridiculous:
 5 files changed, 852 insertions(+), 1253 deletions(-)

Please check the revised series and let me know.

Thanks,
Jason
