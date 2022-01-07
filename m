Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E6E487D00
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jan 2022 20:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiAGT2Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jan 2022 14:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbiAGT2Z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Jan 2022 14:28:25 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0442FC061574
        for <linux-rdma@vger.kernel.org>; Fri,  7 Jan 2022 11:28:25 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id kk22so6445621qvb.0
        for <linux-rdma@vger.kernel.org>; Fri, 07 Jan 2022 11:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7L5P9kOajX3AoK3dDc6BBj92m8wb11iYnDlXl/jDE3c=;
        b=W06Zxbuzjl6O4bEddufugoNI2QihbAWaJNMCsjh1QD28737myg+nnRB2gCTAMcnoc0
         sULbaobgqRbA2z6BdN4B40RYxW2dIAc8r3nAeJWSO22Us+I15DsG3CVd+GOzNFtEFgXy
         pb5Jcqh3ONvqvzz51WzbCE/Nr3OzA7vneqLLR2xpNwBj9QTA33Ka9gD3hZq9oN47kzC5
         odpQUBHKpx2flo45WiG8X4gAsmK9f3KekV6uX3FDuFVqfDH6Nvy75xVfPckRvgJyTpU7
         uKPHScNBiMLw6Q5sskKGbfQJDbjDEO/T1LpXLtcULnbykq/6k83sfowRh/t4BOGrfcIc
         Usiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7L5P9kOajX3AoK3dDc6BBj92m8wb11iYnDlXl/jDE3c=;
        b=HWEQrJ8T9+UoMPr23VjbPbli9LlJuqrqYutqE0MOma4Vdm0nrFYq36rIRetG/bt2VP
         27tPUwaRB4KuSaTg9iOVB2RPGUDZH6ie6xl9JlB29sb6nk7deWBE7BcLBcmHmO9pOOWw
         qouYhMqg+/2qxBQb3R2K7gj98nm+Pab9L9wmF1JnJmFHs47ZI8TMV5XY9/ITfU5QGWPU
         aT6nNeDt0ItnNpaq1BnqE2uAEAbHgckrsi1ocD9JfU0p+GX4TBXA90fvn8fwQ9IE8Xkp
         D+U8DlX7uc3iB4VsBS3sKTCDatkzNDjIZBE9FlKK8Szs1GYADazs9ONiJz43Q6bgZpO9
         oR4A==
X-Gm-Message-State: AOAM5319bw9UAbjKvZBeDLMb/xx8Iy9ALfvcEVCzMzhXWbRoWIaxQjyb
        mq3sUexq8XaFVSdo4hi7QKsl+A==
X-Google-Smtp-Source: ABdhPJy4J0FTdEhrk5IHa7g1DJ22jnX2p68G9/nhqSmM1UOke0wFpcdSwkLXijz6be0/ssCYNIkk+A==
X-Received: by 2002:a05:6214:4119:: with SMTP id kc25mr59024734qvb.77.1641583704115;
        Fri, 07 Jan 2022 11:28:24 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id d3sm4297166qty.30.2022.01.07.11.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 11:28:23 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1n5uuU-00D0mo-Ps; Fri, 07 Jan 2022 15:28:22 -0400
Date:   Fri, 7 Jan 2022 15:28:22 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tom Talpey <tom@talpey.com>
Cc:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "tomasz.gromadzki@intel.com" <tomasz.gromadzki@intel.com>
Subject: Re: [RFC PATCH 2/2] RDMA/rxe: Add RDMA Atomic Write operation
Message-ID: <20220107192822.GC6467@ziepe.ca>
References: <20211230121423.1919550-1-yangx.jy@fujitsu.com>
 <20211230121423.1919550-3-yangx.jy@fujitsu.com>
 <b5860ad7-5d5a-76ba-a18e-da90e8652b08@talpey.com>
 <20220105235354.GV2328285@nvidia.com>
 <61D6C9F9.10808@fujitsu.com>
 <20220106130038.GB2328285@nvidia.com>
 <61D7A23B.40905@fujitsu.com>
 <20220107122244.GR2328285@nvidia.com>
 <472f1a2d-65de-91f7-35be-8338ec3c0635@talpey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <472f1a2d-65de-91f7-35be-8338ec3c0635@talpey.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 07, 2022 at 10:38:30AM -0500, Tom Talpey wrote:
> 
> On 1/7/2022 7:22 AM, Jason Gunthorpe wrote:
> > On Fri, Jan 07, 2022 at 02:15:25AM +0000, yangx.jy@fujitsu.com wrote:
> > > On 2022/1/6 21:00, Jason Gunthorpe wrote:
> > > > On Thu, Jan 06, 2022 at 10:52:47AM +0000, yangx.jy@fujitsu.com wrote:
> > > > > On 2022/1/6 7:53, Jason Gunthorpe wrote:
> > > > > > On Thu, Dec 30, 2021 at 04:39:01PM -0500, Tom Talpey wrote:
> > > > > > 
> > > > > > > Because RXE is a software provider, I believe the most natural approach
> > > > > > > here is to use an atomic64_set(dst, *src).
> > > > > > A smp_store_release() is most likely sufficient.
> > > > > Hi Jason, Tom
> > > > > 
> > > > > Is smp_store_mb() better here? It calls WRITE_ONCE + smb_mb/barrier().
> > > > > I think the semantics of 'atomic write' is to do atomic write and make
> > > > > the 8-byte data reach the memory.
> > > > No, it is not 'data reach memory' it is a 'release' in that if the CPU
> > > > later does an 'acquire' on the written data it is guarenteed to see
> > > > all the preceeding writes.
> > > Hi Jason, Tom
> > > 
> > > Sorry for the wrong statement. I mean that the semantics of 'atomic
> > > write' is to write an 8-byte value atomically and make the 8-byte value
> > > visible for all CPUs.
> > > 'smp_store_release' makes all the preceding writes visible for all CPUs
> > > before doing an atomic write. I think this guarantee should be done by
> > > the preceding 'flush'.
> 
> An ATOMIC_WRITE is not required to provide visibility for prior writes,
> but it *must* be ordered after those writes. 

It doesn't make much sense to really talk about "visibility", it is
very rare something would need something to fully stop until other
things can see it.

What we generally talk about these days is only order.

This is what release/acquire is about. smp_store_release() says that
someone doing smp_load_acquire() on the same data is guaranteed to
observe the previous writes if it observes the data that was written.

Eg if you release a head pointer in a queue then acquiring the new
head pointer value also guarentees that all data in the queue is
visible to you.

However, release doesn't say anything about *when* other observers may
have this visibility, and it certainly doesn't stop and wait until all
observers are guarenteed to see the new data.

> ATOMIC_WRITE, then there's nothing to do. But in other workloads, it is
> still mandatory to provide the ordering. It's probably easiest, and no
> less expensive, to just wmb() before processing the ATOMIC_WRITE.

Which is what smp_store_release() does:

#define __smp_store_release(p, v)                                       \
do {                                                                    \
        __smp_mb();                                                     \
        WRITE_ONCE(*p, v);                                              \
} while (0)

Notice this is the opposite of what smpt_store_mb() does:

#define __smp_store_mb(var, value)  \
do { \
        WRITE_ONCE(var, value); \
        __smp_mb(); \
} while (0)

Which is *not* a release and does *not* guarentee order properties. It
is very similar to what FLUSH would provide in IBA, and very few
things benefit from this. (Indeed, I suspect many of the users in the
kernel are wrong, looking at you SIW..)

> Xiao Yang - where do you see the spec requiring that the ATOMIC_WRITE
> 64-bit payload be made globally visible as part of its execution? 

I don't see this either. I don't think IBA contemplates something
analogous to 'sequentially consistent ordering'.

Jason
