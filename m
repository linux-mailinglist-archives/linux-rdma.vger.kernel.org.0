Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B32612EA85
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jan 2020 20:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgABTbT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jan 2020 14:31:19 -0500
Received: from mail-qv1-f45.google.com ([209.85.219.45]:35731 "EHLO
        mail-qv1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgABTbT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Jan 2020 14:31:19 -0500
Received: by mail-qv1-f45.google.com with SMTP id u10so15320812qvi.2
        for <linux-rdma@vger.kernel.org>; Thu, 02 Jan 2020 11:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RsyzjTZKKtt3mIf0plB5P+n1f+8a7BTDeZtjWgm3hpA=;
        b=dz2+3m0W404D8rZ3LfZHoEZDqBZ4YW0bl+j2j75vASr9w7MXOwy/EmaXAkE8uK6doD
         7O4eVdclt0NUGSKQW0K6HU4pdnyYJspaLPETTCR+b3eyABD3d0yHy0H5hXn5T66ou0k1
         GcmxnjBmIlDNf0x1c4mbN0JXCCebi7XUW3HBAKNEx30C3eHX71aDK3wSdfqECBfE5yQJ
         Z/+2QCRndIM99h0blS8Z12+/od+4SH/VaBSM6IecZY4rLCgomNdx59UwuBiK2c6W4EoA
         0ZZJb48KYb8M2i+EGMFCRcAaz0AGlKoUlneVS+0S5fmbaB4lMl8Da/RlLjkXLvwPnOQ1
         S92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RsyzjTZKKtt3mIf0plB5P+n1f+8a7BTDeZtjWgm3hpA=;
        b=Vcv6Tw540svjzAjezNCa7SSJ/cn7vJ8VQngVZVUdCt3CGqBImHeHjhd1x3OG8yyx+v
         fb3VzH5voH/t99p4+KjWgpVYDn4SxnVZH/iobDjVdiNG8kvAoFQiqkB2kt5sgkIAjehV
         6oqvyBi9xAKCpk46Zim8CXZ0xGiNMpINT5NF6OW/z4U9zI9FnkWWtIy9J5ZFS0mfDYCL
         8YKAtMd6GwclXOElBhfeZiF2f0biW8H8qivS4047hxpbG6CD9wooVG4p+ZPV/smipV4p
         XArY8+XRP5KvAH7W9MfTbBMrodHRoe0mg5OyzxQwtACenXvyyRU9p1AcmhX5Smh09+gm
         JzwQ==
X-Gm-Message-State: APjAAAWLXI4fkgk2QMR2Nzx43Ply22Ets8JSs6y9g7lepOjgyRoNvsJX
        zjf4VV43nLwuEFz8XDOgHHROKQ==
X-Google-Smtp-Source: APXvYqx3dhtrsk7K7hWdRTXwwXBFZhQvI/RyPR8kKMikGLAFU2Q+eaAJ47Wmq6738Ly7Fk/gTWl/Eg==
X-Received: by 2002:a0c:e1ce:: with SMTP id v14mr63537456qvl.39.1577993478178;
        Thu, 02 Jan 2020 11:31:18 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 124sm7432781qko.11.2020.01.02.11.31.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jan 2020 11:31:17 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1in6Bh-0005eu-4G; Thu, 02 Jan 2020 15:31:17 -0400
Date:   Thu, 2 Jan 2020 15:31:17 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Hefty, Sean" <sean.hefty@intel.com>
Cc:     Terry Toole <toole@photodiagnostic.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: Is it possible to transfer a large file between two computers
 using RDMA UD?
Message-ID: <20200102193117.GI9282@ziepe.ca>
References: <CADw-U9BHcoHy3WJ8iSdYjAw3RxQf2vhkOKyL7k0yJdR3mP7Mug@mail.gmail.com>
 <20200102182937.GG9282@ziepe.ca>
 <CADw-U9BTH1-2FztrKnC=tTTH93wOZg3FM2qJgjneNz-6-kywiw@mail.gmail.com>
 <CY4PR11MB14302D923E9CFF0665E67B3F9E200@CY4PR11MB1430.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR11MB14302D923E9CFF0665E67B3F9E200@CY4PR11MB1430.namprd11.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 02, 2020 at 07:25:34PM +0000, Hefty, Sean wrote:
> > > > Is it possible to transfer a large file, say 25GB, between two computers using
> > > > RDMA UD, and have an exact copy of the original file on the receiving side? My
> > > > understanding is that the order of the messages is not guaranteed with UD.
> > > > But I thought that if I only use one QP I could ensure that the ordering of the
> > > > data will be predictable.
> > >
> > > It is not guaranteed to be in order.
> > >
> > > Why would you do this anyhow? The overhead to use RC is pretty small
> > >
> > So even if I am using only 1 QP, it is still not guaranteed to be in
> > order. Ok. Thanks.
> 
> The spec doesn't guarantee ordering, though I doubt messages would
> ever be unordered in practice.  You could transfer a sequence number
> as immediate data to allow the receiver to verify (and correct)
> packet ordering, and detect lost packets.

They could always become lost though, due to a link BER or
something. And that is only on IB, not Ethernet.

I don't think you can avoid needing retransmit on the sender...

Jason
