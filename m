Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE7722E33E
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jul 2020 01:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgGZXT2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Jul 2020 19:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgGZXT2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 26 Jul 2020 19:19:28 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0665C0619D2
        for <linux-rdma@vger.kernel.org>; Sun, 26 Jul 2020 16:19:27 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l23so13806235qkk.0
        for <linux-rdma@vger.kernel.org>; Sun, 26 Jul 2020 16:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3wvcm5XGDP126C584+OmUsMhd3p9O8mFPEcPGxtKyIg=;
        b=X+xiua+MThPBona162QCgPENkEB3WJtGLOgGns5lZwW5jo/pMPhUIjcN7e5vZ6AeR7
         C8jhaZ9MoqI8vLf4mBwHRLTAbrwwgbiM3JZ4ibaz3nVq3pKsPgBxXTqCnQXWf8OXqCqb
         jYfbgjmxGve9FwPdp6aP4nemQHAgyOOBxulwO1OxM2YpyERLEfntfP8XSuAVnXmrjPue
         p585RV3kYP5gtA7LORQ66vtvfEK5PDxPeBbaMeaNfInOEHf0YBbfp32GkCyrC4ghcpZO
         wvCTWLx8N0Aav4MV6U/fjyxgX9mUmSsvPeRYmoTWSZ50engP1KTMr36h8DNQRGgT/XRP
         ieBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3wvcm5XGDP126C584+OmUsMhd3p9O8mFPEcPGxtKyIg=;
        b=gkDTZZYW833acQqRlaJczT1qf8aiSD8MG1AbjxLmB9zqNGh8UM4hUv0W9uzWZ1jx8Z
         CuxxaVyCpbTtp/YFEsrh6qyZ5IWLHu0xQSTHYseWq23E8MhnUabxSAvOee9H3PcshhDe
         YXMluI0mIcfS5HsK3Jxy7/+ci5H39m7xSnkpJRPqEAwIzNr5xaz64YEirwrgKk6yt24O
         0VG7EVkXwfLogrGr3kkLFwpRhWNQDXNsd4Mxbx98cm7HM8qN9HXX7b8CDFZLK5hc2i3M
         YPKzwMXg+IMHzCJy2DqChIGvAsd3o4tF7nHTuIt6LGQyXeQWP4LGoxTByPX7QDdhyayI
         NyDw==
X-Gm-Message-State: AOAM532cNWFWTEHRQKTz2jW9Xsj7cFLhqbarK5wBrB0eIP3RpmyYIDJ1
        ABPqT4VNSpIbNZx4xUnzikRZs4b+2ud+eg==
X-Google-Smtp-Source: ABdhPJy8LiaD0LfdJx8cs7fS26iejakSrGwi3PBIWQDhUBv7kObvn3/xBllkyQocA9vvyQpLuASeAQ==
X-Received: by 2002:a05:620a:2230:: with SMTP id n16mr18077944qkh.268.1595805566891;
        Sun, 26 Jul 2020 16:19:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id b2sm16075919qkf.122.2020.07.26.16.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 16:19:25 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1jzpvR-00GGpT-1E; Sun, 26 Jul 2020 20:19:25 -0300
Date:   Sun, 26 Jul 2020 20:19:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: Can't build rdma-core's azp image
Message-ID: <20200726231925.GP25301@ziepe.ca>
References: <05382c9f-a58d-ba5a-02cd-c25aa3604e52@amazon.com>
 <98b72450-1422-39ec-2f31-52a7dbaa57ea@amazon.com>
 <20200526192335.GO744@ziepe.ca>
 <9f697fea-30e0-2a1f-3c9c-a2ae0100a8df@amazon.com>
 <221cbc21-f027-3312-5043-7622c7e854d3@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <221cbc21-f027-3312-5043-7622c7e854d3@amazon.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 26, 2020 at 10:05:59AM +0300, Gal Pressman wrote:
> On 27/05/2020 10:35, Gal Pressman wrote:
> > On 26/05/2020 22:23, Jason Gunthorpe wrote:
> >> On Tue, May 26, 2020 at 09:25:30AM +0300, Gal Pressman wrote:
> >>> On 07/04/2020 18:47, Gal Pressman wrote:
> >>>> I'm trying to build the azp image and it fails with the following error [1].
> >>>> Anyone has an idea what went wrong?
> >>>
> >>> azp build broke again :(.
> >>>
> >>> The last step
> >>> Step 4/4 : RUN apt-get update && apt-get install -y --no-install-recommends libgcc-s1:i386 libgcc-s1:ppc64el && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends abi-compliance-checker abi-dumper ca-certificates clang-10 cmake cython3 debhelper dh-python dh-systemd dpkg-dev fakeroot gcc-10 gcc-9-aarch64-linux-gnu gcc-9-powerpc64le-linux-gnu git libc6-dev libc6-dev:arm64 libc6-dev:i386 libc6-dev:ppc64el libgcc-10-dev:i386 libgcc-9-dev:arm64 libgcc-9-dev:ppc64el libnl-3-dev libnl-3-dev:arm64 libnl-3-dev:i386 libnl-3-dev:ppc64el libnl-route-3-dev libnl-route-3-dev:arm64 libnl-route-3-dev:i386 libnl-route-3-dev:ppc64el libsystemd-dev libsystemd-dev:arm64 libsystemd-dev:i386 libsystemd-dev:ppc64el libudev-dev libudev-dev:arm64 libudev-dev:i386 libudev-dev:ppc64el lintian make ninja-build pandoc pkg-config python3 python3-dev python3-docutils python3-yaml sparse valgrind && apt-get clean && rm -rf /usr/share/doc/ /usr/lib/debug /var/lib/apt/lists/
> >>>
> >>> Fails with
> >>> W: https://apt.llvm.org/focal/pool/main/l/llvm-toolchain-10/libllvm10_10.0.1~++20200519100828+f79cd71e145-1~exp1~20200519201452.38_amd64.deb: No system certificates available. Try installing ca-certificates.
> >>> E: Could not configure 'libc6:arm64'.
> >>> E: Could not perform immediate configuration on 'libgcc-s1:arm64'. Please see man 5 apt.conf under APT::Immediate-Configure for details. (2)
> >>
> >> couldn't reproduce
> > 
> > Maybe you have a cached image or something?
> > I just set up a clean instance and it reproduces immediately.
> 
> It was fixed at some point, and now it's back again:
> 
> Step 4/4 : RUN apt-get update && apt-get install -y --no-install-recommends libgcc-s1:i386 libgcc-s1:ppc64el && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends abi-compliance-checker abi-dumper ca-certificates clang-10 cmake cython3 debhelper dh-python dh-systemd dpkg-dev fakeroot gcc-10 gcc-9-aarch64-linux-gnu gcc-9-powerpc64le-linux-gnu git libc6-dev libc6-dev:arm64 libc6-dev:i386 libc6-dev:ppc64el libgcc-10-dev:i386 libgcc-9-dev:arm64 libgcc-9-dev:ppc64el libnl-3-dev libnl-3-dev:arm64 libnl-3-dev:i386 libnl-3-dev:ppc64el libnl-route-3-dev libnl-route-3-dev:arm64 libnl-route-3-dev:i386 libnl-route-3-dev:ppc64el libsystemd-dev libsystemd-dev:arm64 libsystemd-dev:i386 libsystemd-dev:ppc64el libudev-dev libudev-dev:arm64 libudev-dev:i386 libudev-dev:ppc64el lintian make ninja-build pandoc pkg-config python3 python3-dev python3-docutils python3-yaml sparse valgrind && apt-get clean && rm -rf /usr/share/doc/ /usr/lib/debug /var/lib/apt/lists/
> 
> [...]
> 
> W: https://apt.llvm.org/focal/pool/main/l/llvm-toolchain-10/libllvm10_10.0.1~++20200708122807+ef32c611aa2-1~exp1~20200707223407.61_amd64.deb: No system certificates available. Try installing ca-certificates.
> W: https://apt.llvm.org/focal/pool/main/l/llvm-toolchain-10/libclang1-10_10.0.1~++20200708122807+ef32c611aa2-1~exp1~20200707223407.61_amd64.deb: No system certificates available. Try installing ca-certificates.
> E: Could not configure 'libc6:arm64'.
> E: Could not perform immediate configuration on 'libgcc-s1:arm64'. Please see man 5 apt.conf under APT::Immediate-Configure for details. (2)
> 
> Maybe it's an issue with the llvm repo?

No idea. The reason we switched to AZP was to avoid the endless random
breakage by using pre-built containers. I think you need to do the
same..

Jason
