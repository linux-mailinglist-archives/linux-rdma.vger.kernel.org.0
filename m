Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9CC84BA3
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 14:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbfHGMaN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 08:30:13 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:41682 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729408AbfHGMaN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Aug 2019 08:30:13 -0400
Received: by mail-qt1-f176.google.com with SMTP id d17so9139448qtj.8
        for <linux-rdma@vger.kernel.org>; Wed, 07 Aug 2019 05:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6wTAdX0WLwYu5u/Cj3Hj57BRWNSp4K7ptHmyygtZtXA=;
        b=MfQqtG6GhK5razwTOBk5cOAzJPC53KdgDLQ3mVbnb+rkc+ZcGE1HzCAdx/KWR9Gps1
         wFFG1AdN7TMY9BjC5iJf3RiXSh3FPBs7qlsO1tsSGH4Gdyvhcjw4ImzN7YEQ4R3wqzJV
         EZPh/5L8eaLCwP/PMZnjpP20mRKildgIzamhU060dTZButnZ73qMFjbjdC2NhTjdRyYr
         Nq1NBDdeP17ENjNPmJta2EaAgvc5yVvHsAiKVj9VMxMSRG0aKwVEmSsxyqjld6Pc5NJB
         7zALSkOWI/i5fbqPbK8x8IUIxA2ACs2rEHYdWYW1qCxFzunxTWp1brl/7DMPUgZVipJt
         CQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6wTAdX0WLwYu5u/Cj3Hj57BRWNSp4K7ptHmyygtZtXA=;
        b=WMm5gOpVI1Hpzv3p4TQtXeQ2Pw6q6tatvg2yb7PqiAESJjGbQVCuEbvh6wZRjJ0DK+
         R0u/Hjv6fCjJThvK/RPEJqfVhqxEZNxnyAKByip+dmrJoa7ZJdELEcC+cZBLyo0DmNlJ
         P+cXadaztwD8GoSg3TrfRqocOARTXISKqzQAqqAde1F6qkcOrQrJ9CHZeZ1+e+pEx2JZ
         fqI4drBpIk1z2zqEfipi/abJaDhBbuFFvzx1wZmTelFvWyZGNioTa3kw/Sah69x5tF7Y
         Gul6PdYOO7X4XJ5aHxLjRUjl6NNOa2fcRALfsmJWYot4fhQ7t5uKkiAZEqqZvZlC4PGH
         wX5A==
X-Gm-Message-State: APjAAAVDcBRs4FNsgsyzNsvc0dtYajYyqrF2k3YdfJt5koQQZQ+dQrwd
        7Y1xunvi+DA0slxxzScw1esO9g==
X-Google-Smtp-Source: APXvYqzTeWdse7V+ZaEPT9aS7QWA1Z7YZUOjHmgZcIZjsoLXj9lD9pMJrcAc7/bxrTsR7qYzKEwk1w==
X-Received: by 2002:ac8:6786:: with SMTP id b6mr5148149qtp.17.1565181011893;
        Wed, 07 Aug 2019 05:30:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id s11sm37375688qkm.51.2019.08.07.05.30.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Aug 2019 05:30:11 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hvL50-0001HZ-NV; Wed, 07 Aug 2019 09:30:10 -0300
Date:   Wed, 7 Aug 2019 09:30:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     James Harvey <jamespharvey20@gmail.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: rdma-core and infiniband-diags -- so number rollback -- wrong
 perl module location
Message-ID: <20190807123010.GE1557@ziepe.ca>
References: <CA+X5Wn7kHqGvvyh72MTMo2ACcOe4MXWiD0ZSYCJgM4xCysyBNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+X5Wn7kHqGvvyh72MTMo2ACcOe4MXWiD0ZSYCJgM4xCysyBNw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 07, 2019 at 04:21:09AM -0400, James Harvey wrote:
> Looks like rdma-core 25 swallowed infiniband-diags.  Would be nice if
> the release notes mentioned that.  (They do include "ibdiags: ..."
> style changes, but nothing jumping out that it's been pulled in -
> especially like a summary up top for important changes.)  (I do see
> the infiniband-diags repo does mention deprecated, use rdma-core.)
> 
> I see 2 issues.
> 
> 
> (1) so number rollback
> 
> The last actual version of infiniband-diags, v2.2.0, released May 12, builds:
> * libibmad.so.5.5.0
> * libibnetdisc.so.5.3.0
> 
> The subsequent version of rdma-core, 25.0, released Jul 29, builds
> older so numbers:
> * libibmad.so.5.3.25.0
> * libibnetdisc.so.5.0.25.0
> 
> Weird for newer versions have older so numbers.

rdma-core has a strict policy that the so.X.Y represents the latest
symbol version in the library, in this case 5.3 - for whatever reason
the old ibdiags had this wrong.

> (2) wrong perl module location
> 
> infiniband-diags correctly installed to
> /usr/share/perl5/vendor_perl/IBswcountlimits.pm
> 
> rdma-core dropped "vendor_perl" and incorrectly installs to
> /usr/share/perl5/IBswcountlimits.pm
> 
> I can work around this by adding
> "-DCMAKE_INSTALL_PERLDIR='/usr/share/perl5/vendor_perl' \" but wanted
> to mention this, since AFAIK the proper location is in "vendor_perl",
> where it used to be.

This is a distro specific quirk, you are correct to override it in the
packaging with your distro's policy.

Looks like the cmake default is set for debian:

https://packages.debian.org/search?searchon=contents&keywords=IBswcountlimits.pm&mode=path&suite=stable&arch=any

Jason
