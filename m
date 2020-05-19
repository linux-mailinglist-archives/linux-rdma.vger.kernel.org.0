Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73041DA5C5
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2020 01:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgESXqj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 May 2020 19:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgESXqj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 May 2020 19:46:39 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4159C061A0F
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2020 16:46:37 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 142so1843819qkl.6
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2020 16:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i8yHzIcvU7kcxD5lr3a/uRuPQvgGnnEv/vTfkxL8O4A=;
        b=SxZP0CdDu5+Jfp1yTnH8IqKG+reEa5xOff4F/NMP4hBG1TQuC5sAQEL0qyQAzDWdCG
         +zUiOtb81twOvpTFgw8H+k8Trwf/uqY3H8zIP2etXile4vmTUn72ez8B+QLg5wmxFSzs
         N4wUYzTGf7Oj8gmrgWALZXgJuTV8v6lxSH0076gZGyhHWLkJVBqXYmOmPsuf+yCFCzYf
         PKm/1moKOhSghhuPNVoV3+NPsYklLmxSumDhZC34C+AJ8zFDy+knKFQc0XL5/Kwg+/1r
         FJrqTCLgTrRxZBTFn/ZIH/vaKIGZ8qfaib6SFMRl0qOtUsuy/Y03me7u+Uf6/TEyNRSR
         QMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i8yHzIcvU7kcxD5lr3a/uRuPQvgGnnEv/vTfkxL8O4A=;
        b=WmDWWaNaZwvH93CwxW8kaE4CmGlnY/t+nnx3+bybIOWET6nED1bl4yfVzpMmtk61M6
         7sqlFT+iJ1XZxc7U+IxDGYHHPcR5GmHEn55YtpC7jUul400Ghw5iVONsKWg0hfPXYfuX
         usCsrRBMPoJoCA9Le6CLyD9abiQjKdTS8Lfqxut8TaOXLmeNXmUnWRU8zkMsGWQw3HR2
         xCOADlzp6jbYx3lz8sllL2Lc7atJHJd140Ob9KvLsUZjwl2A0xLrhn2ZgGJGnHlJ6hAP
         9TIeaiRr1O3u2KJt9KtEZsh7ok93k4sLkrzIYiuKE2xATlI2E/Ho2RsRJ2zhG7SAYvGk
         FNAQ==
X-Gm-Message-State: AOAM532lpUXxi2jecjf2n9mQdEQeHqIweiXWJUfB31xE1JDjWRvV3d7n
        nlD1cIoZJrbCUxtqgGdZRfRH6Q==
X-Google-Smtp-Source: ABdhPJwxGXFyRVOpy72mMQo+CyO1Bxym8J0vzykyk0oY4FXzFhU086d9riC4tHH/Kc5kpXfwsp0mbw==
X-Received: by 2002:a37:9d09:: with SMTP id g9mr2102772qke.154.1589931996798;
        Tue, 19 May 2020 16:46:36 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id x24sm1126310qth.57.2020.05.19.16.46.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 May 2020 16:46:36 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jbBwR-00080W-QN; Tue, 19 May 2020 20:46:35 -0300
Date:   Tue, 19 May 2020 20:46:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] RDMA/rtrs: Fix some signedness bugs in error handling
Message-ID: <20200519234635.GC30609@ziepe.ca>
References: <CAMGffEkkUVV9b=iMhP4C=ndBRcePcTQMiF4h-Et1DFEKYPA6mg@mail.gmail.com>
 <20200519133223.GN2078@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519133223.GN2078@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 19, 2020 at 04:32:23PM +0300, Dan Carpenter wrote:
> The problem is that "req->sg_cnt" is an unsigned int so if "nr" is
> negative, it gets type promoted to a high positive value and the
> condition is false.  This patch fixes it by handling negatives separately.
> 
> Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
> v2: propagate the correct error code instead of returning -EINVAL
> 
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 7 +++----
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 +-
>  2 files changed, 4 insertions(+), 5 deletions(-)

Applied to for-next, thanks

Jason
