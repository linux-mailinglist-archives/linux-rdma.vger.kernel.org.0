Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F25004314A
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 22:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389908AbfFLU7V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 16:59:21 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42165 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389390AbfFLU7U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jun 2019 16:59:20 -0400
Received: by mail-qk1-f193.google.com with SMTP id b18so11304062qkc.9
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jun 2019 13:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rLkfwjLHjIhbUApAWXBAQZk41GKmCFYTOe41lCI5ZwA=;
        b=AoYCR3zmjWLlB6BwZGa3rY5CtYcLwvMEgRhOfj+04eaqXWfn02/1f+rHLLAkLDXZUJ
         5hSoonhxYPYT8gsyXcerm8Xz7U4ajEaI2DzA6zNVymh0Qrfq4Ey+JDgZ1nkDVf+AiBny
         57wCiVD3sY67ETmrY+8cHtRwCImfQRl+nFbxudlan9hztIXa7tHhex3IXdvGSGologFN
         phtvgkUdc48U+173JtJi9rX9K2VzVGQwa6Ghe9SIirTHBpUnbXOttIaWc0f0K2VwF2ST
         7Ml/8FDJrWVI8Ns7tjb0DUHFeJw/1sDvIvwVdezJW2WAeFbvTUBcY/DmJyRcQCwKnFK6
         P9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rLkfwjLHjIhbUApAWXBAQZk41GKmCFYTOe41lCI5ZwA=;
        b=lQ+SHpq6GrhpW/f8GZ+Mp2o6a4PEEmxakgavrmF+p5iPdS+gK7Iyh8p74oURXpqUbY
         rFUHwc+ExGsmrodQQauNJTQUeWxiDhA8WYxfs26FveTBBZY5E3EhVSQTG3inyQ73xa94
         WiJnnqvffwH4BFfEfJSN2LGFkdKAAU3gSaQ7DpLOnZA3gRrFE+G5RdJGRl4KuT6rwcjA
         bfJ0EbNo93vnB6AmqECW7pKYC6AUJhFiRiBa8KvqKEwxIFM0C1TLZKYOuM3uNpHJ56pX
         wQBL2SRps76VH7xaQu4kc9QxffCifiIPHVLfB53Z/Wm08VIksj176N1G56Ngg+wkqCDI
         ikkg==
X-Gm-Message-State: APjAAAXiGz9JUiKd7T6/4nZWi6dD88BbwfuVtZ8CAWSL9Aehua5Uc/oV
        RGlGvQNyTXMiHabZj5u25NBwdDwi7CT9aA==
X-Google-Smtp-Source: APXvYqxKARXNizVCeIdBJ1umAnt2d6PX1DtsaLs4IYGqIGxputLBZ/A+ZSv2wihMwsNQ2l3X+eBwCg==
X-Received: by 2002:a37:a5d5:: with SMTP id o204mr27811317qke.155.1560373159431;
        Wed, 12 Jun 2019 13:59:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id c184sm385444qkf.82.2019.06.12.13.59.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 13:59:18 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hbAKz-0005E9-QC; Wed, 12 Jun 2019 17:59:17 -0300
Date:   Wed, 12 Jun 2019 17:59:17 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tom Talpey <tom@talpey.com>
Cc:     Bernard Metzler <BMT@zurich.ibm.com>, linux-rdma@vger.kernel.org
Subject: Re: receive side CRC computation in siw.
Message-ID: <20190612205917.GQ3876@ziepe.ca>
References: <OFBD80408B.8C25683E-ON00258416.0047A63B-00258416.00495B83@notes.na.collabserv.com>
 <a84cd017-fe4c-fecf-6414-db6a3f98c09c@talpey.com>
 <20190612152116.GI3876@ziepe.ca>
 <ea1e140d-f1a7-5d63-8b6e-e99d57264178@talpey.com>
 <20190612201345.GP3876@ziepe.ca>
 <20bd1d9d-5ca7-abb0-2d66-ea765b03550e@talpey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20bd1d9d-5ca7-abb0-2d66-ea765b03550e@talpey.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 12, 2019 at 04:34:21PM -0400, Tom Talpey wrote:
> On 6/12/2019 4:13 PM, Jason Gunthorpe wrote:
> > On Wed, Jun 12, 2019 at 04:07:53PM -0400, Tom Talpey wrote:
> > > On 6/12/2019 11:21 AM, Jason Gunthorpe wrote:
> > > > On Tue, Jun 11, 2019 at 11:11:08AM -0400, Tom Talpey wrote:
> > > > > On 6/11/2019 9:21 AM, Bernard Metzler wrote:
> > > > > > Hi all,
> > > > > > 
> > > > > > If enabled for siw, during receive operation, a crc32c over
> > > > > > header and data is being generated and checked. So far, siw
> > > > > > was generating that CRC from the content of the just written
> > > > > > target buffer. What kept me busy last weekend were spurious
> > > > > > CRC errors, if running qperf. I finally found the application
> > > > > > is constantly writing the target buffer while data are placed
> > > > > > concurrently, which sometimes races with the CRC computation
> > > > > > for that buffer, and yields a broken CRC.
> > > > > 
> > > > > Well, that's a clear bug in the application, assuming siw has
> > > > > not yet delivered a send completion for the operation using
> > > > > the buffer. This is a basic Verbs API contract.
> > > > 
> > > > May be so, but a kernel driver must not make any assumptions about the
> > > > content of memory controlled by user. So it is clearly wrong to write
> > > > data to a user buffer and then read it again to compute a CRC.
> > > 
> > > But it's not a user buffer. It's been mapped into the kernel for the
> > > purpose of registering and performing data transfer This is standard
> > > i/o processing. Both kernel and user have access.
> > 
> > It is a user buffer because the user has access. In fact it may not
> > even be mapped into the kernel address space.
> 
> Belaboring this point a bit, but SIW certainly maps it, in order to
> copy. An adapter maps it, via dma_map, in order to do the same. My
> point is simply that if the kernel tried to prevent that, the whole
> i/o model would break down.
> 
> In other words, if a hardware adapter were doing this same thing,
> would you consider it out of spec? If so, why?

Yes.

HW placing/reading data in user controlled memory and requiring it not
to change dynamically is a security flaw.

It may not be expressly specified as part of the IBA, but it is
certainly wrong from a system design perspective.

Jason
