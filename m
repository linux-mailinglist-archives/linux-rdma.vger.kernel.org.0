Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717F21DFB4C
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2020 00:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgEWWI2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 23 May 2020 18:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbgEWWI1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 23 May 2020 18:08:27 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3773C061A0E
        for <linux-rdma@vger.kernel.org>; Sat, 23 May 2020 15:08:27 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id dh1so6417357qvb.13
        for <linux-rdma@vger.kernel.org>; Sat, 23 May 2020 15:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HSxhxt9cXD+YKDYTcXaoCyqaEXMhueL5x5OdvF9BZlE=;
        b=dF1H3/lzjg+ZyIVWfjZV8uSzIx6PmtB+fSJtPQtiA30IXP0jd9/ixNG4Iy85mSttbA
         QcV/++woArZzNoEbTLek46W+Aa/0JjzjrASCBYNr7OI4PnX0NY+OXnpD8G1E4spdazOU
         oHUQgk9kLduR1fO0mVb0yWwZp8HQrTInAy3DReOu/vor0tqkxb+1wZ0s+k0SbC333jYG
         +U3qT8Fj1/afkLSOBO/2lBef+SEfP7bYA6+EFFb5FCMoG8gK6oLAFm7EISMWJJ2WwbIq
         E///X0cOatzVgSauJAAPy5ZsYtp7pdyfTWl7t5lDNeLuZ3ANhYl2y9ySSsW4P9zj+Ioi
         ERqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HSxhxt9cXD+YKDYTcXaoCyqaEXMhueL5x5OdvF9BZlE=;
        b=oTLPIFR6IY5l9qLrlpgMaRV4qPqrkfyk6nEZqf3bixU1Xqvaix/AR53ffAWZ1KQo2S
         Kt6RzK9V+vR8/AGM1R7TEoj2nxM+XnGeFkAinUfC+Dp5u1WFC5vaS6/jcGbqbyaoM9ZZ
         8rBluc/MiqEfXuzWoaat4tG5rwQUgZIgy8bMFzUJEePdo30HRyqfmRTf1+z39FmnaGTH
         +yUm5nzoPbC84D25A01hn4DaVr6h2RaKMytDXSwLR7/YBkz8kXMwd5FSv4F15VH8UMyh
         zkn0j2e1HuXfbAmgkimUy6F4wOZfW8TXZB6Sfsd+cDtglB55jKHurtao1e0aSV84+MTc
         BOSg==
X-Gm-Message-State: AOAM531+mOhEBdGQiDUU/ceyYm+M1DIx3vq2AfB5c0GGPWMlqh3bcz3m
        S+LGdhLGgNnz8q9locQAynv0sg==
X-Google-Smtp-Source: ABdhPJxM4b+mmVE1rgL1NMEP8LxgVQi6Vxm8Kb1y1ErqAIUIHX8r2u2nd5KYjQKdFWHgKXXYl6maog==
X-Received: by 2002:a05:6214:7cd:: with SMTP id bb13mr9785502qvb.17.1590271703484;
        Sat, 23 May 2020 15:08:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id h3sm10250844qkl.28.2020.05.23.15.08.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 May 2020 15:08:22 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jccJZ-0001sq-Fx; Sat, 23 May 2020 19:08:21 -0300
Date:   Sat, 23 May 2020 19:08:21 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>, bvanassche@acm.org,
        linux-rdma@vger.kernel.org, dledford@redhat.com, sagi@grimberg.me,
        israelr@mellanox.com, shlomin@mellanox.com,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
Subject: Re: [PATCH 0/8 v1] Remove FMR support from RDMA drivers
Message-ID: <20200523220821.GB744@ziepe.ca>
References: <20200514120305.189738-1-maxg@mellanox.com>
 <f2efe2df-14db-4e15-3807-f81b799cc0ec@intel.com>
 <20200518181035.GM24561@mellanox.com>
 <03238a7d-d3f3-7859-deb9-dd0a04fbe9ed@intel.com>
 <20200519135352.GV24561@mellanox.com>
 <20200519141927.GR188135@unreal>
 <774b4d00-ab2e-6f1a-eaa6-a7afadc3c44d@intel.com>
 <20200519143030.GA23839@mellanox.com>
 <5563b8da-faf3-1af5-33d0-fe5a6d7291a1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5563b8da-faf3-1af5-33d0-fe5a6d7291a1@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 19, 2020 at 10:37:07AM -0400, Dennis Dalessandro wrote:
> On 5/19/2020 10:30 AM, Jason Gunthorpe wrote:
> > On Tue, May 19, 2020 at 10:26:37AM -0400, Dennis Dalessandro wrote:
> > > On 5/19/2020 10:19 AM, Leon Romanovsky wrote:
> > > > On Tue, May 19, 2020 at 10:53:52AM -0300, Jason Gunthorpe wrote:
> > > > > On Tue, May 19, 2020 at 09:43:14AM -0400, Dennis Dalessandro wrote:
> > > > > > On 5/18/2020 2:10 PM, Jason Gunthorpe wrote:
> > > > > > > On Mon, May 18, 2020 at 11:20:04AM -0400, Dennis Dalessandro wrote:
> > > > > > > > On 5/14/2020 8:02 AM, Max Gurtovoy wrote:
> > > > > > > > > This series removes the support for FMR mode to register memory. This ancient
> > > > > > > > > mode is unsafe and not maintained/tested in the last few years. It also doesn't
> > > > > > > > > have any reasonable advantage over other memory registration methods such as
> > > > > > > > > FRWR (that is implemented in all the recent RDMA adapters). This series should
> > > > > > > > > be reviewed and approved by the maintainer of the effected drivers and I
> > > > > > > > > suggest to test it as well.
> > > > > > > > > 
> > > > > > > > > The tests that I made for this series (fio benchmarks and fio verify data):
> > > > > > > > > 1. iSER initiator on ConnectX-4
> > > > > > > > > 2. iSER initiator on ConnectX-3
> > > > > > > > > 3. SRP initiator on ConnectX-4 (loopback to SRP target)
> > > > > > > > > 4. SRP initiator on ConnectX-3
> > > > > > > > > 
> > > > > > > > > Not tested:
> > > > > > > > > 1. RDS
> > > > > > > > > 2. mthca
> > > > > > > > > 3. rdmavt
> > > > > > > > 
> > > > > > > > This will effectively kill qib which uses rdmavt. It's gonna have to be a
> > > > > > > > NAK from me.
> > > > > > > 
> > > > > > > Are you objecting the SRP and iSER changes too?
> > > > > > 
> > > > > > No, just want to keep basic verbs support at least. NFS already dropped,
> > > > > > similarly we are ok with dropping it from SRP/iSER as a next step.
> > > > > 
> > > > > So you see a major user in RDS for qib?
> > > > 
> > > > Didn't we agree to drop it from RDS too?
> > > > 
> > > 
> > > Just basic verbs application support is enough for qib I think. I don't see
> > > any major use of RDS.
> > 
> > Well, once the in-kernel users of an API are gone that API will be
> > purged. This is standard kernel policy.
> > 
> > So you can't NAK this series on the grounds you want to keep an API
> > without users, presumably for out of tree modules...
> > 
> 
> Maybe I need to look at this again. I thought it would kill off user access
> as well. We don't need any kernel ULPs.

Did you make a conclusion? Seems like everyone else is in agreement
here, if Max resends a v2 I'm inclined to take it unless RDS objects.

I did not think FMR or FRWR were available from userspace at all.

Jason
