Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F7B1E2DB8
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2020 21:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390554AbgEZTXn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 May 2020 15:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404495AbgEZTXi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 May 2020 15:23:38 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE72C03E96D
        for <linux-rdma@vger.kernel.org>; Tue, 26 May 2020 12:23:37 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b6so21819911qkh.11
        for <linux-rdma@vger.kernel.org>; Tue, 26 May 2020 12:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BrIRbwdLOJGiSr/UyIyH1GsImy1bBmUgkawahVcfgpI=;
        b=gpmSDHLNLnKF0OwsLS0OuLDgE6jRmBnALYBcPaF7dT9iAFMCCMH0UuO0S2M7ixqo6v
         YSVOAX5Urwr2SaR0iSdNF4K9ggOqXpzXwYOczu+K4D98aalO9AOXxXkq9LjJsVii0Ue6
         TzHM8KqMyzlHpOk4MzvPnc6t1kmzZ1FEJoggQmwdkxTZU2ba2gXeIhUWFGm5Ibg5/b+p
         ly08DxLPxaVDg2Ynn3TAr2WeIzDSAq+LaWwg4GNHqtIGWwTfZxzD5tUztZIYsp6TEReO
         oxfZsCnhRbnHASFUf8C/VzwktU7Oqz7qrnxLMsWhKYIFkKwVAMog4LMEL1x26aahz74V
         45ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BrIRbwdLOJGiSr/UyIyH1GsImy1bBmUgkawahVcfgpI=;
        b=Wd4yB0jIkvL3GQGuDrytCu9Ct88TbLnu9u3L7MT3sZKGv373hqWfslDKT0NOJGalbY
         EnHAVZAPw48CUtc+D9qvx8yeLt8FKoIu2gm3noQf6UPqbCYnyyVbRbCJMRYrWT3lJMeC
         MfYp/GnBptK81PoZnY+hTKxVQtNOACdzsfe1y77lNtH1z1JZddA44I/UcC+NAD1vRYHR
         riUNwH9UK4a5Tw4ko3FngNBLTl3/oO4EIwi4ROuG1VH/4FJ614NaGGSGckjOHkoERGcU
         dB3srTtKhl9QYo9xreH4ICz3GF7Is0s/bWCzZqaGLLAEX8O2PWlR31kwNGPdXM+Uqk1Q
         k1Cw==
X-Gm-Message-State: AOAM53015D0SLut7FoZ0Fz++KDoUdsbSAp6dtHs+5IDOwpqQiUvRgAtR
        SsKERaOQolQnK+xIJ1Jo4lnZvw==
X-Google-Smtp-Source: ABdhPJzDZQftWqebkCCWokg4aqEs0dGjElLBt8frNgFfTBFXJ3FkHULOBowthBKcumi+kPVvlt+gFQ==
X-Received: by 2002:a05:620a:4e2:: with SMTP id b2mr433125qkh.16.1590521017148;
        Tue, 26 May 2020 12:23:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id s42sm546542qtk.14.2020.05.26.12.23.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 May 2020 12:23:36 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jdfAl-0006mY-QJ; Tue, 26 May 2020 16:23:35 -0300
Date:   Tue, 26 May 2020 16:23:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: Can't build rdma-core's azp image
Message-ID: <20200526192335.GO744@ziepe.ca>
References: <05382c9f-a58d-ba5a-02cd-c25aa3604e52@amazon.com>
 <98b72450-1422-39ec-2f31-52a7dbaa57ea@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98b72450-1422-39ec-2f31-52a7dbaa57ea@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 26, 2020 at 09:25:30AM +0300, Gal Pressman wrote:
> On 07/04/2020 18:47, Gal Pressman wrote:
> > I'm trying to build the azp image and it fails with the following error [1].
> > Anyone has an idea what went wrong?
> 
> azp build broke again :(.
> 
> The last step
> Step 4/4 : RUN apt-get update && apt-get install -y --no-install-recommends libgcc-s1:i386 libgcc-s1:ppc64el && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends abi-compliance-checker abi-dumper ca-certificates clang-10 cmake cython3 debhelper dh-python dh-systemd dpkg-dev fakeroot gcc-10 gcc-9-aarch64-linux-gnu gcc-9-powerpc64le-linux-gnu git libc6-dev libc6-dev:arm64 libc6-dev:i386 libc6-dev:ppc64el libgcc-10-dev:i386 libgcc-9-dev:arm64 libgcc-9-dev:ppc64el libnl-3-dev libnl-3-dev:arm64 libnl-3-dev:i386 libnl-3-dev:ppc64el libnl-route-3-dev libnl-route-3-dev:arm64 libnl-route-3-dev:i386 libnl-route-3-dev:ppc64el libsystemd-dev libsystemd-dev:arm64 libsystemd-dev:i386 libsystemd-dev:ppc64el libudev-dev libudev-dev:arm64 libudev-dev:i386 libudev-dev:ppc64el lintian make ninja-build pandoc pkg-config python3 python3-dev python3-docutils python3-yaml sparse valgrind && apt-get clean && rm -rf /usr/share/doc/ /usr/lib/debug /var/lib/apt/lists/
> 
> Fails with
> W: https://apt.llvm.org/focal/pool/main/l/llvm-toolchain-10/libllvm10_10.0.1~++20200519100828+f79cd71e145-1~exp1~20200519201452.38_amd64.deb: No system certificates available. Try installing ca-certificates.
> E: Could not configure 'libc6:arm64'.
> E: Could not perform immediate configuration on 'libgcc-s1:arm64'. Please see man 5 apt.conf under APT::Immediate-Configure for details. (2)

couldn't reproduce

Jason
