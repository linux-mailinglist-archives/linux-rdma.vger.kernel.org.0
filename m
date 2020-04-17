Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49ED1AE21F
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2020 18:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730402AbgDQQVx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Apr 2020 12:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729581AbgDQQVw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 17 Apr 2020 12:21:52 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5A3C061A0C
        for <linux-rdma@vger.kernel.org>; Fri, 17 Apr 2020 09:21:52 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id o10so2401470qtr.6
        for <linux-rdma@vger.kernel.org>; Fri, 17 Apr 2020 09:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KZEM3VHHWOAu53wzIn/NK+OvBHnn8c+uwsWb/icHumA=;
        b=ibt+9FYthK5NqlrzaZdxU7Z7M1Y0ylq/2RV0G4Qhyusf1MkOozzXp14oPMIbnPyfk5
         wSlJ1X0+Jb57wvZZA82OIljHZ6/4UTbPSjt796y4mnEPx7ReQXIwWu/ag4UZ1O3G8ElT
         kYc3kcxWA/EeoxEGh/plK+jnVQed3Fb+L9lS5DlTl+Jri99aez6MVUnJ/0siNTGPRY+0
         4QAeqeA1NXFtBD5ltKyOMhQ1gBHd70yOsLQXkrD3nAUfo+EjO4+jt7EvgXY6al6fF4aK
         wS23FxbaEfVLTiXrPpxKPCAADMLLYSKpiM3VSxsNoplv6TZEbMuSZB1v2cSpHmxI6pbt
         1msA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KZEM3VHHWOAu53wzIn/NK+OvBHnn8c+uwsWb/icHumA=;
        b=mVvcr/mBCxwppVSr4ZeC1QxnP5323407bZSKb+3EnotEw11Il0ZY6lC2n+Y1Rv0P0O
         cBssQH9VExm+WvSmauC2Tk2eK4+c2j9//czCLvcNeSOE/EN9TFUpQ9GploWVpAVShRs+
         0sJ74+mLRBo/rgt6h/udw+/hJYbPaH0AvexwMMGaV9hhcjqzyvVQrEUanC8pT5Ny60N4
         vI3oSHwESMZ9TbL0Sd/7sf1S/dX7cLcHFOCOPfmff5IRzWmvKSVtEypAVAJXkvwXiohM
         mIjBNNruhErsshlsSy+ynHQbwyeCPbyeRI6tYv3524BYHSXT7E/i3Jh+bg8XQW4OXLBw
         S5aw==
X-Gm-Message-State: AGi0PuYgOadbVqnRhC9G8l05R4V28CSbh0X7ubNIcHCqVvcPBROc6xFs
        q7gRHoItqQmVFlegOdXsxpzz1DUuhYn6sw==
X-Google-Smtp-Source: APiQypLMp6CwxNd9sjwqVlbqrxgClWKdHsuJArxfLNxQT9gMDo1xiUilmsH96PrkODxCNQxoulf+fw==
X-Received: by 2002:ac8:7ca2:: with SMTP id z2mr3828086qtv.122.1587140511548;
        Fri, 17 Apr 2020 09:21:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id f130sm5353567qke.22.2020.04.17.09.21.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Apr 2020 09:21:50 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jPTkU-0002kC-FW; Fri, 17 Apr 2020 13:21:50 -0300
Date:   Fri, 17 Apr 2020 13:21:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: Can't build rdma-core's azp image
Message-ID: <20200417162150.GH26002@ziepe.ca>
References: <05382c9f-a58d-ba5a-02cd-c25aa3604e52@amazon.com>
 <20200407180658.GW20941@ziepe.ca>
 <67f9e08a-467c-34ce-e17e-816cb4bf03db@amazon.com>
 <ca41331c-3b53-fbb6-4543-bc960f796062@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca41331c-3b53-fbb6-4543-bc960f796062@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 16, 2020 at 10:05:11AM +0300, Gal Pressman wrote:
> On 08/04/2020 9:35, Gal Pressman wrote:
> > On 07/04/2020 21:06, Jason Gunthorpe wrote:
> >> On Tue, Apr 07, 2020 at 06:47:51PM +0300, Gal Pressman wrote:
> >>> I'm trying to build the azp image and it fails with the following error [1].
> >>> Anyone has an idea what went wrong?
> >>
> >>> Reading package lists...
> >>> W: http://apt.llvm.org/bionic/dists/llvm-toolchain-bionic-8/InRelease: No system
> >>> certificates available. Try installing ca-certificates.
> >>> W: http://apt.llvm.org/bionic/dists/llvm-toolchain-bionic-8/Release: No system
> >>> certificates available. Try installing ca-certificates.
> >>> E: The repository 'http://apt.llvm.org/bionic llvm-toolchain-bionic-8 Release'
> >>> does not have a Release file.
> >>
> >> Oh, there is lots going wrong here..
> >>
> >> Above is because llvm droped http support from their repo.. Bit
> >> annoying to fix..
> >>
> >>> The following packages have unmet dependencies:
> >>>  libc6-dev:arm64 : Depends: libc6:arm64 (= 2.27-3ubuntu1) but it is not going to
> >>> be installed
> >>>  libgcc-8-dev:arm64 : Depends: libgcc1:arm64 (>= 1:8.4.0-1ubuntu1~18.04)
> >>>                       Depends: libgomp1:arm64 (>= 8.4.0-1ubuntu1~18.04) but it
> >>> is not going to be installed
> >>>                       Depends: libitm1:arm64 (>= 8.4.0-1ubuntu1~18.04) but it is
> >>> not going to be installed
> >>>                       Depends: libatomic1:arm64 (>= 8.4.0-1ubuntu1~18.04) but it
> >>> is not going to be installed
> >>>                       Depends: libasan5:arm64 (>= 8.4.0-1ubuntu1~18.04) but it
> >>> is not going to be installed
> >>>                       Depends: liblsan0:arm64 (>= 8.4.0-1ubuntu1~18.04) but it
> >>> is not going to be installed
> >>>                       Depends: libtsan0:arm64 (>= 8.4.0-1ubuntu1~18.04) but it
> >>> is not going to be installed
> >>>                       Depends: libubsan1:arm64 (>= 8.4.0-1ubuntu1~18.04) but it
> >>> is not going to be installed
> >>>  libnl-3-dev:arm64 : Depends: libnl-3-200:arm64 (= 3.2.29-0ubuntu3) but it is
> >>> not going to be installed
> >>>  libnl-route-3-dev:arm64 : Depends: libnl-route-3-200:arm64 (= 3.2.29-0ubuntu3)
> >>> but it is not going to be installed
> >>>  libsystemd-dev:arm64 : Depends: libsystemd0:arm64 (= 237-3ubuntu10.39) but it
> >>> is not going to be installed
> >>>  libudev-dev:arm64 : Depends: libudev1:arm64 (= 237-3ubuntu10.39) but it is not
> >>> going to be installed
> >>
> >> Oh neat, that is a problem in the toolchain ppa:
> >>
> >> $ apt-get install libgcc-s1:arm64 gcc-7
> >>
> >> The following packages have unmet dependencies:
> >>  libgcc-s1:arm64 : Breaks: libgcc-7-dev (< 7.5.0-4) but 7.5.0-3ubuntu1~18.04 is to be installed
> >>
> >> The only ubuntu not broken right now is focal.. which is very new.
> >>
> >> Keep using the old docker image? Ask me in a week if it is still
> >> broken, we can probably fix this by updating to focal, it is the next
> >> LTS anyhow..
> > 
> > Thanks Jason, I'll keep tracking the issue.
> 
> Looks like the issue persists :\.

Are you sure? It seems fixed

root@069a1ad800ba:/# apt-get install libgcc-s1:arm64 gcc-7
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  binutils binutils-common binutils-x86-64-linux-gnu cpp-7 gcc-10-base gcc-10-base:arm64 gcc-7-base gcc-8-base libasan4
  libatomic1 libbinutils libc-dev-bin libc6:arm64 libc6-dev libcc1-0 libcilkrts5 libgcc-7-dev libgcc-s1 libgcc1 libgomp1
  libisl19 libitm1 liblsan0 libmpc3 libmpfr6 libmpx2 libquadmath0 libstdc++6 libtsan0 libubsan0 linux-libc-dev manpages
  manpages-dev
Suggested packages:
  binutils-doc gcc-7-locales gcc-7-multilib gcc-7-doc libgcc1-dbg libgomp1-dbg libitm1-dbg libatomic1-dbg libasan4-dbg
  liblsan0-dbg libtsan0-dbg libubsan0-dbg libcilkrts5-dbg libmpx2-dbg libquadmath0-dbg glibc-doc:arm64 locales:arm64
  glibc-doc man-browser
The following NEW packages will be installed:
  binutils binutils-common binutils-x86-64-linux-gnu cpp-7 gcc-10-base gcc-10-base:arm64 gcc-7 gcc-7-base libasan4
  libatomic1 libbinutils libc-dev-bin libc6:arm64 libc6-dev libcc1-0 libcilkrts5 libgcc-7-dev libgcc-s1 libgcc-s1:arm64
  libgomp1 libisl19 libitm1 liblsan0 libmpc3 libmpfr6 libmpx2 libquadmath0 libtsan0 libubsan0 linux-libc-dev manpages
  manpages-dev
The following packages will be upgraded:
  gcc-8-base libgcc1 libstdc++6
3 upgraded, 32 newly installed, 0 to remove and 9 not upgraded.
Need to get 35.2 MB of archives.
After this operation, 131 MB of additional disk space will be used.
Do you want to continue? [Y/n] 

I will look more later

Jason
