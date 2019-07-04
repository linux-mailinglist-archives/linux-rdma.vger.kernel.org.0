Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 308C35F83A
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2019 14:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfGDMfP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Jul 2019 08:35:15 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37871 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbfGDMfP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Jul 2019 08:35:15 -0400
Received: by mail-qt1-f196.google.com with SMTP id y57so5618044qtk.4
        for <linux-rdma@vger.kernel.org>; Thu, 04 Jul 2019 05:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IVY1pcyCJulBaS/fc7mcf7xjVKtIv4rSr6Am9jZ+u08=;
        b=lWnmRVP45blMUF3fqTmFaqZrncVfwoIRbYlGtI+jvxXK1xsN4tlVv3p9+3F8pxoBqZ
         nqBhhm8ksFyoD9Z01+8cWLoLiR4ON5gAzH5xhSpXE6exww3cznn0lGYFQQS6BBufQW4w
         TcjUfLTzobl4qIcmkoIYyEcWvb4O3B9/R3Y03LQmipK7jryvfzgIOQKebDn37IIminG0
         I2+Z0Q20m5nBG0MxW3mDQWomikNHnerrudldSXm06YtnUPiWJd1TdLqUvo+2vnpGS6dT
         NlHrcHlk5XQ8wMDfnr5zlml6ey7BLRTwR0gF120yOo5D3qj47QjPS6HC5t2WnWhZR0lK
         adFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IVY1pcyCJulBaS/fc7mcf7xjVKtIv4rSr6Am9jZ+u08=;
        b=pfO5XPBnCPyuodaIGPXalYvuOsRMfHkzoODZoIIuvPxYpw9TKRx9nDWXl80BiHkkah
         nSUihsyIoyGxni4Mj7z9b8j9C8+D9CSyQ23YhuxAMi8mx6yqqVSTz+H6KDu2O1HkfE/7
         ztyd+hj9vMrWZAUaWlCftBd/t6tdJzDWpWV2TpY5rm+MCzzmHycuuRoZdvezB8qwsT5Y
         5xCPP6gOmCm7blFKP8QpdyfZrGospAE6HUddpUf5PgGAHZAbW6DIECKeTBaw5D/H6rEF
         GNhwJuKDQ4SLEOSE+R/pL1q9hDSwykZyKYwe04IHorwZUBGHvF2wVfc+NLOk/IY1LuiL
         oZDw==
X-Gm-Message-State: APjAAAXN4Ka12v7/UoREqMApfjk6G9NT3neibwzZE0Csnl0x2JOveYaS
        Gozul2fmm1uPgO0HQat7Ah9R/Q==
X-Google-Smtp-Source: APXvYqwROslVKirIM99mu8mzmZacyZTPcc9uMCwNJZx0fAlSXAv5+BJw6UBJ57BhmaQyHUlSUByLMw==
X-Received: by 2002:ac8:156:: with SMTP id f22mr34479950qtg.58.1562243714162;
        Thu, 04 Jul 2019 05:35:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id v2sm2355479qtf.24.2019.07.04.05.35.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jul 2019 05:35:12 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hj0xD-0001K7-Ny; Thu, 04 Jul 2019 09:35:11 -0300
Date:   Thu, 4 Jul 2019 09:35:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Michal Kalderon <mkalderon@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        Ariel Elior <aelior@marvell.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [RFC rdma 1/3] RDMA/core: Create a common mmap function
Message-ID: <20190704123511.GA3447@ziepe.ca>
References: <20190627135825.4924-1-michal.kalderon@marvell.com>
 <20190627135825.4924-2-michal.kalderon@marvell.com>
 <d6e9bc3b-215b-c6ea-11d2-01ae8f956bfa@amazon.com>
 <20190627155219.GA9568@ziepe.ca>
 <14e60be7-ae3a-8e86-c377-3bf126a215f0@amazon.com>
 <MN2PR18MB318228F0D3DA5EA03A56573DA1FC0@MN2PR18MB3182.namprd18.prod.outlook.com>
 <MN2PR18MB3182EC9EA3E330E0751836FDA1F80@MN2PR18MB3182.namprd18.prod.outlook.com>
 <20190702223126.GA11860@ziepe.ca>
 <85247f12-1d78-0e66-fadc-d04862511ca7@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85247f12-1d78-0e66-fadc-d04862511ca7@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 03, 2019 at 11:19:34AM +0300, Gal Pressman wrote:
> On 03/07/2019 1:31, Jason Gunthorpe wrote:
> >> Seems except Mellanox + hns the mmap flags aren't ABI. 
> >> Also, current Mellanox code seems like it won't benefit from 
> >> mmap cookie helper functions in any case as the mmap function is very specific and the flags used indicate 
> >> the address and not just how to map it.
> > 
> > IMHO, mlx5 has a goofy implementaiton here as it codes all of the object
> > type, handle and cachability flags in one thing.
> 
> Do we need object type flags as well in the generic mmap code?

At the end of the day the driver needs to know what page to map during
the mmap syscall.

mlx5 does this by encoding the page type in the address, and then many
types have seperate lookups based onthe offset for the actual page.

IMHO the single lookup and opaque offset is generally better..

Since the mlx5 scheme is ABI it can't be changed unfortunately.

If you want to do user controlled cachability flags, or not, is a fair
question, but they still become ABI..

I'm wondering if it really makes sense to do that during the mmap, or
if the cachability should be set as part of creating the cookie?

> Another issue is that these flags aren't exposed in an ABI file, so
> a userspace library can't really make use of it in current state.

Woops.

Ah, this is all ABI so you need to dig out of this hole ASAP :)

Jason
