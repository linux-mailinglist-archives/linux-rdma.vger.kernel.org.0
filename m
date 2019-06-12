Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2B4430DF
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 22:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfFLUNv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 16:13:51 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38417 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbfFLUNr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jun 2019 16:13:47 -0400
Received: by mail-qk1-f196.google.com with SMTP id a27so11233428qkk.5
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jun 2019 13:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z/Hy38PmGbeLPEKtAi7lfIoWl2YW+VhmRhGeF1qxS1M=;
        b=W8ZAeiiN1QfBbuQTmTvalzwYy8CQz6GEeJfBRzhkr4TbYi5b97Gt7Kwwts7mxscL91
         2U15oY/JNKpgtUxj0HlhOfMGk4lIPbxJUvxZdpVsueSKU6GoOZDLzCfylf7dhMKsccmz
         Fw80k0f9Q7ZXjeo88ZqHVVbIdqiJLNtCYZb520Dw6OgTgigAi2IVhakH0QgVWGCQBKQi
         vmad4egzYU0rd/9MaYvzGlvmrG7to1dclScTVcmYhgLZf+aE2bf+q7ee2Y4OMxwXB3lc
         jhL9zFOoZBkUbE/T4sVewwh2/draFtPd+sGOnyOf0enUKpnckEOjaPjIMvVJjw36PutS
         fbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z/Hy38PmGbeLPEKtAi7lfIoWl2YW+VhmRhGeF1qxS1M=;
        b=LE6wc8F2wxCnnVtk5DmGnTzBKpSOERIJ0aoW6NySMnAKq4EbmAojBC3cqoyM9kph0/
         C8G0Phtc7kKbTxadmYn5VYG2bRTbnBMMT2QssSRFy/wMsdnRJsGJWrYAoEf1Qps9No8O
         Ax/JcJQXNS90p+HUqh7Y9bLLCZ9uX8Ory2NwjhZEJjZnuKEw0yAiPZS49760z/zymuJk
         Gbq4/oWg4gWsm7slQZ0QJg8D/JBFQIUMH+I6XSJdswwtKE6AEVQWn37kFzx+YkTanJzY
         ksT8/5S/nBss4KOSOhUvpsRhuj7xGrZmX6lTLt3XDx86r2+vBXtZGdKrpE322p+YZVh1
         RwLg==
X-Gm-Message-State: APjAAAUXjdX7R0s5YWLMczXD3blVDtfALeCuwrwXPWGrfT/aKLITxmOr
        9n9RhFvFBPpzyx8sPri2NyAv0VJHjaaJPA==
X-Google-Smtp-Source: APXvYqzsYzc9V1Fp2rolpf7R/P9BXtHJ60RknqBOx4b5rfCFkT0BRIgDYgAR/ox7XlYwwcJKd5O/RA==
X-Received: by 2002:a37:a9c9:: with SMTP id s192mr67191340qke.335.1560370426760;
        Wed, 12 Jun 2019 13:13:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id c5sm326572qkb.41.2019.06.12.13.13.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 13:13:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hb9cv-0004nT-N7; Wed, 12 Jun 2019 17:13:45 -0300
Date:   Wed, 12 Jun 2019 17:13:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tom Talpey <tom@talpey.com>
Cc:     Bernard Metzler <BMT@zurich.ibm.com>, linux-rdma@vger.kernel.org
Subject: Re: receive side CRC computation in siw.
Message-ID: <20190612201345.GP3876@ziepe.ca>
References: <OFBD80408B.8C25683E-ON00258416.0047A63B-00258416.00495B83@notes.na.collabserv.com>
 <a84cd017-fe4c-fecf-6414-db6a3f98c09c@talpey.com>
 <20190612152116.GI3876@ziepe.ca>
 <ea1e140d-f1a7-5d63-8b6e-e99d57264178@talpey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea1e140d-f1a7-5d63-8b6e-e99d57264178@talpey.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 12, 2019 at 04:07:53PM -0400, Tom Talpey wrote:
> On 6/12/2019 11:21 AM, Jason Gunthorpe wrote:
> > On Tue, Jun 11, 2019 at 11:11:08AM -0400, Tom Talpey wrote:
> > > On 6/11/2019 9:21 AM, Bernard Metzler wrote:
> > > > Hi all,
> > > > 
> > > > If enabled for siw, during receive operation, a crc32c over
> > > > header and data is being generated and checked. So far, siw
> > > > was generating that CRC from the content of the just written
> > > > target buffer. What kept me busy last weekend were spurious
> > > > CRC errors, if running qperf. I finally found the application
> > > > is constantly writing the target buffer while data are placed
> > > > concurrently, which sometimes races with the CRC computation
> > > > for that buffer, and yields a broken CRC.
> > > 
> > > Well, that's a clear bug in the application, assuming siw has
> > > not yet delivered a send completion for the operation using
> > > the buffer. This is a basic Verbs API contract.
> > 
> > May be so, but a kernel driver must not make any assumptions about the
> > content of memory controlled by user. So it is clearly wrong to write
> > data to a user buffer and then read it again to compute a CRC.
> 
> But it's not a user buffer. It's been mapped into the kernel for the
> purpose of registering and performing data transfer This is standard
> i/o processing. Both kernel and user have access.

It is a user buffer because the user has access. In fact it may not
even be mapped into the kernel address space.

> Furthermore, an RDMA hardware adapter has zero notion of user buffers.
> All it gets is a registration, with memory described by dma addresses.
> It can perform whatever memory operations are required on them, and the
> kernel isn't even in the loop.

Adapters cannot make assumptions about data they place in memory
buffers - ie they cannot write something and then read it back on the
assumption it has not changed. They cannot read something twice on the
assumption it has not changed, etc. It is a security requirement.

> > All the applications touching buffers without waiting for a completion
> > are relying on some extended behavior outside the specification, but
> > they cannot cause the kernel to malfunction and report bogus data
> > integrity errors.
> 
> Ok, this I agree with, but the RDMA specifications were quite careful
> about it. And we *definitely* don't want to require that the providers
> all start double-buffering incoming data, in order to shield an
> uncomplying application from itself. To double buffer RDMA Writes (and
> Sends) would undo the entire direct data placement design!
> 
> Bernard, I'd still welcome your thoughts on whether you can compute
> the MPA CRC inline in SIW during the copy_to_user. Avoiding the overhead
> of reading back the data after copying could be a speedup for you?

Copy and CRC is obviously the right thing to do.

Jason
