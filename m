Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F44D1A134D
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2020 20:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgDGSHB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Apr 2020 14:07:01 -0400
Received: from mail-qv1-f50.google.com ([209.85.219.50]:44146 "EHLO
        mail-qv1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgDGSHB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Apr 2020 14:07:01 -0400
Received: by mail-qv1-f50.google.com with SMTP id ef12so2266445qvb.11
        for <linux-rdma@vger.kernel.org>; Tue, 07 Apr 2020 11:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vlIJyAk9fhkb7fDf5GFtGsGGIxix3xLtpQ4+bHU/G4Y=;
        b=PL9uee3TdL4TVfPAmQfbdTyTKc1KWRSoBpGkeQu7mPe7rMveuDUoQdM+wLT1tuaQpI
         o2m6ZztWwEHu0II4AQoUWaSDtgE5ZKYDDsgRF6/nsqietAhMzD4CsMSeu6kJZaRKtsSi
         6n6YWaAd7+1EuTiAonXHbQnKZ5hNcspvaGzaoe5T+KyXoRWsH5H5I98Q+sxzPHjm3cjX
         VmX8keFXMOxRn+qE7ygNTfYcFreEzv3cVTViLw7uWixczB3kyMG2GUorirK3o+OZUmrI
         z//IvPfs1NK2aAR6EElnir7wzJ9UDfuDEM5Ouia9KV0HAc3QgLHHIn/+AlEsj1+9/ltI
         mvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vlIJyAk9fhkb7fDf5GFtGsGGIxix3xLtpQ4+bHU/G4Y=;
        b=OAt6ZYml4uWtwOes8NfX048Qdr4/tpPLljnTP8y8LxNIWqskkduFj1pgxaMMG0XGJm
         KbRudjmNrNW3ZWXb54gb0On2SNYnZAcsmw821k6hD5AXgcfdnCMq70HqrN96Zc9D9Os4
         Ba45xg/iMoI75oAS0JZyPRZgRjZwbp1z2yMojH2HA2GFFZBU//ljG8AUd+pEEUHyTzip
         hW6eA6xEGpPd2pqVMVRaAhXD/SNbSba4oZdyiHnAyEurunKt4WJZFoeNRFRuKLMq8S2C
         B/EGl6i6DQZCtpLhV9uZ/BBh1rnR8rbLfdI1c7RUE6sm27tIejLNovKfCIt04x+SSHJ/
         aMSw==
X-Gm-Message-State: AGi0PuYms8qdtI8o/yYt7DW+OxMTl7gX+nzRVibvnkpytZavvCRy+Jh7
        LsnFtSnVQftUQpMp7+wP/szEHUIP9BcNpQ==
X-Google-Smtp-Source: APiQypKEiqXRrw72ANQfWgJswIKdp5CXRvYIqXF9it7FZfsJe0ZvxPVCSoFK5e2i918uhPV3ODV7pg==
X-Received: by 2002:ad4:5141:: with SMTP id g1mr3375832qvq.79.1586282820029;
        Tue, 07 Apr 2020 11:07:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id b195sm1171481qkg.108.2020.04.07.11.06.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Apr 2020 11:06:59 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jLsck-0005Um-RD; Tue, 07 Apr 2020 15:06:58 -0300
Date:   Tue, 7 Apr 2020 15:06:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: Can't build rdma-core's azp image
Message-ID: <20200407180658.GW20941@ziepe.ca>
References: <05382c9f-a58d-ba5a-02cd-c25aa3604e52@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05382c9f-a58d-ba5a-02cd-c25aa3604e52@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 07, 2020 at 06:47:51PM +0300, Gal Pressman wrote:
> I'm trying to build the azp image and it fails with the following error [1].
> Anyone has an idea what went wrong?

> Reading package lists...
> W: http://apt.llvm.org/bionic/dists/llvm-toolchain-bionic-8/InRelease: No system
> certificates available. Try installing ca-certificates.
> W: http://apt.llvm.org/bionic/dists/llvm-toolchain-bionic-8/Release: No system
> certificates available. Try installing ca-certificates.
> E: The repository 'http://apt.llvm.org/bionic llvm-toolchain-bionic-8 Release'
> does not have a Release file.

Oh, there is lots going wrong here..

Above is because llvm droped http support from their repo.. Bit
annoying to fix..

> The following packages have unmet dependencies:
>  libc6-dev:arm64 : Depends: libc6:arm64 (= 2.27-3ubuntu1) but it is not going to
> be installed
>  libgcc-8-dev:arm64 : Depends: libgcc1:arm64 (>= 1:8.4.0-1ubuntu1~18.04)
>                       Depends: libgomp1:arm64 (>= 8.4.0-1ubuntu1~18.04) but it
> is not going to be installed
>                       Depends: libitm1:arm64 (>= 8.4.0-1ubuntu1~18.04) but it is
> not going to be installed
>                       Depends: libatomic1:arm64 (>= 8.4.0-1ubuntu1~18.04) but it
> is not going to be installed
>                       Depends: libasan5:arm64 (>= 8.4.0-1ubuntu1~18.04) but it
> is not going to be installed
>                       Depends: liblsan0:arm64 (>= 8.4.0-1ubuntu1~18.04) but it
> is not going to be installed
>                       Depends: libtsan0:arm64 (>= 8.4.0-1ubuntu1~18.04) but it
> is not going to be installed
>                       Depends: libubsan1:arm64 (>= 8.4.0-1ubuntu1~18.04) but it
> is not going to be installed
>  libnl-3-dev:arm64 : Depends: libnl-3-200:arm64 (= 3.2.29-0ubuntu3) but it is
> not going to be installed
>  libnl-route-3-dev:arm64 : Depends: libnl-route-3-200:arm64 (= 3.2.29-0ubuntu3)
> but it is not going to be installed
>  libsystemd-dev:arm64 : Depends: libsystemd0:arm64 (= 237-3ubuntu10.39) but it
> is not going to be installed
>  libudev-dev:arm64 : Depends: libudev1:arm64 (= 237-3ubuntu10.39) but it is not
> going to be installed

Oh neat, that is a problem in the toolchain ppa:

$ apt-get install libgcc-s1:arm64 gcc-7

The following packages have unmet dependencies:
 libgcc-s1:arm64 : Breaks: libgcc-7-dev (< 7.5.0-4) but 7.5.0-3ubuntu1~18.04 is to be installed

The only ubuntu not broken right now is focal.. which is very new.

Keep using the old docker image? Ask me in a week if it is still
broken, we can probably fix this by updating to focal, it is the next
LTS anyhow..

Jason
