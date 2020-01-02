Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6D9112E9D3
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jan 2020 19:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgABSTB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jan 2020 13:19:01 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35814 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbgABSTB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Jan 2020 13:19:01 -0500
Received: by mail-qk1-f193.google.com with SMTP id z76so32347737qka.2
        for <linux-rdma@vger.kernel.org>; Thu, 02 Jan 2020 10:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Csv9RkX+btH1fRvzYebWxmzJI2nh5n+bdHJt7GV96bk=;
        b=W19s5UfI8xZ/KO3HJhNiipzFAQm8HdoBFEioSovzaBQGcMrkij9Zry71gOHhhjEsTv
         EuCDhVZ4WV4J89gBeFPXT3UpATus3af+NNO2ZBSp8SW4bvqE1fIFbcmf37j9iOMM2l11
         nCTvXyz9+k/KPxMTX9P5uvXQyaLmGgiWftoyTFbPL3O8c0jLc0v0M6jsZ/nmBGNqVT2T
         5xpCkienhd7S2T9spuZf36ZEijYdIuv59dth99wcPdONRyywUMVeQGu4pCk1fkwRIJ2d
         xu+Wz47RGcibYzzNO86ju4eYU830dhb8KeyBx8V7MtuEi16tB84f8GWPXpxpIPceQANQ
         o0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Csv9RkX+btH1fRvzYebWxmzJI2nh5n+bdHJt7GV96bk=;
        b=JDmbSTJHTtmn70hVe9vHrF1la0SiQZi30Qcx6TduZpp0K4pYP8pVf0T7iMfHTNJBx6
         4JPzcT3BJn/LnO+kSrn8rQCnDOIw4uTCTV2DtF6ETuheH0J+qHjr6BVjov0xQXLhEmJV
         ahDRPyTaqOZ/IyV/yuHF3/tmBkU7bG9qQg8IcnDEdWISu+l8t1Rt5tsleOo6AfN1B4wj
         +NQlGp0+sb+X1rotCgyobv8nZ1am1uBHpTZgRz2ygHYFE+4Y6sNGuRPbM4YsD5EMk7EI
         eCL5l9NG4iW2dZf2huLWXBzFm8h7MZALMmLZHUt7QuY86wnrKpPPNrJF0sNBWoSHKQwn
         ozEg==
X-Gm-Message-State: APjAAAXAD3432KxMykVyppSnLhL42GL6sj2epeiO7WvGwqmjQZou9udT
        pOqJct+BwlSKql795fMHVO+nSg==
X-Google-Smtp-Source: APXvYqz4IehmERvZkSLn4dv0AlZiLqxjIhUPXsfbcmH1QR56baIC/yZYOdzyT1EtgjA6A3n0bzymnw==
X-Received: by 2002:a37:9f41:: with SMTP id i62mr65840276qke.272.1577989140443;
        Thu, 02 Jan 2020 10:19:00 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id q25sm15412176qkq.88.2020.01.02.10.18.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jan 2020 10:18:59 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1in53j-0003H7-CA; Thu, 02 Jan 2020 14:18:59 -0400
Date:   Thu, 2 Jan 2020 14:18:59 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jack Wang <jinpuwang@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de
Subject: Re: [PATCH v5 00/25] RTRS (former IBTRS) rdma transport library and
 the corresponding RNBD (former IBNBD) rdma network block device
Message-ID: <20200102181859.GC9282@ziepe.ca>
References: <20191220155109.8959-1-jinpuwang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220155109.8959-1-jinpuwang@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 20, 2019 at 04:50:44PM +0100, Jack Wang wrote:
> Hi all,
> 
> here is V5 of the RTRS (former IBTRS) rdma transport library and the 
> corresponding RNBD (former IBNBD) rdma network block device.
> 
> Main changes are the following:
> 1. Fix the security problem pointed out by Jason
> 2. Implement code-style/readability/API/etc suggestions by Bart van Assche
> 3. Rename IBTRS and IBNBD to RTRS and RNBD accordingly
> 4. Fileio mode support in rnbd-srv has been removed.
> 
> The main functional change is a fix for the security problem pointed out by 
> Jason and discussed both on the mailing list and during the last LPC RDMA MC 2019.
> On the server side we now invalidate in RTRS each rdma buffer before we hand it
> over to RNBD server and in turn to the block layer. A new rkey is generated and
> registered for the buffer after it returns back from the block layer and RNBD
> server. The new rkey is sent back to the client along with the IO result.
> The procedure is the default behaviour of the driver. This invalidation and
> registration on each IO causes performance drop of up to 20%. A user of the
> driver may choose to load the modules with this mechanism switched
> off

So, how does this compare now to nvme over fabrics?

I recall there were questiosn why we needed yet another RDMA block
transport?

Jason
