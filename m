Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88391E86C1
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2020 20:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgE2ShL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 May 2020 14:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727098AbgE2ShK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 May 2020 14:37:10 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33762C08C5C8
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2020 11:37:10 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id q14so2502468qtr.9
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2020 11:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OYQE0uvH3tzzpfHPwyVCPWLLHigSCaMjFXiFc2z8a/4=;
        b=ES2TDPWTNdU2r1JEiOfpkLv5famr8ht6/yykg49rfGIaayQnwia8ipnSs67ynZWTis
         PfZmkwimbmHtCKI74EPGH0DHKXgoOJ9bw9GMaZ5BsCfuGvKpPNKPZiDuEKjv7OHCNIcf
         h2n8g2bsztSlfNLV7Muc2JYi8hn2130s2YE6FlXMlBCozUABf5MIp1UOYH8dIqqaCgMj
         Tcvhngp0IcGEAVu5UPNihKvSk3Odb6RHhe6W8vaEHc7o2O50zrmxoeG+N0yUU6r4Kpa0
         kMgjnFr5K+bNcgZ64zLDAGYtj5NAO5iRE76dgN2RLghDo5o3ZSSoVJ9zK4Z8SomMFMK2
         X6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OYQE0uvH3tzzpfHPwyVCPWLLHigSCaMjFXiFc2z8a/4=;
        b=Ls5PmeEK9SamTdZNqQoXI8/Ka459alCNubCPbEB6nCOMU3uaJNwRbJSLScABu2cDEg
         rUEm8ohm0f9iifvCPDpbXrfACjQ4NaCXs48rZJ4Qjvubn0Q43+WrAPBcwE0l16TIJck9
         8Mszp+aLobYAKXR4rl7NWHJ++CW/V5mLuIHeu0xjRChDwjbUVuDOS2xd/lMnX9u3b4ew
         UBXz6nlfYF9mcSOswEOTN8RwPa/zHePcfbwS4rSFvFmpp03eDTwsI8g6msiZRf3IRf4c
         qkYAW6n2FFxYHESi0YW4Mv6aG19VGfSBHvlmtrxFgkUVAWujHKzlWSkwCc9VE5ZmuV8o
         yOBg==
X-Gm-Message-State: AOAM531QO2aL6z2ReiX/CbrQ3U6pXredzZa7tE7ca3Ozsu72mB73bK7X
        E85qbM8a5aAHUqSOHO6oQNmXXA==
X-Google-Smtp-Source: ABdhPJyxDRfEwqDYreu5u+2h/Arf3Y1u2mNSQnbp4bkUXNrP5IHBKWX1MKbvABtS8FHPghF+lYhWrA==
X-Received: by 2002:ac8:7383:: with SMTP id t3mr10938438qtp.221.1590777429365;
        Fri, 29 May 2020 11:37:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id a27sm8731357qtc.92.2020.05.29.11.37.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 May 2020 11:37:08 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jejsS-0006aK-Bo; Fri, 29 May 2020 15:37:08 -0300
Date:   Fri, 29 May 2020 15:37:08 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     wu000273@umn.edu
Cc:     kjlu@umn.edu, Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Kamal Heib <kamalheib1@gmail.com>,
        Mark Zhang <markz@mellanox.com>,
        Majd Dibbiny <majd@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/core: Fix several reference count leaks.
Message-ID: <20200529183708.GA25212@ziepe.ca>
References: <20200528030231.9082-1-wu000273@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528030231.9082-1-wu000273@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 27, 2020 at 10:02:30PM -0500, wu000273@umn.edu wrote:
> From: Qiushi Wu <wu000273@umn.edu>
> 
> kobject_init_and_add() takes reference even when it fails.
> If this function returns an error, kobject_put() must be called to
> properly clean up the memory associated with the object. Previous
> commit "b8eb718348b8" fixed a similar problem.
> 
> Signed-off-by: Qiushi Wu <wu000273@umn.edu>
> ---
>  drivers/infiniband/core/sysfs.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied to for-next, thanks

Jason
