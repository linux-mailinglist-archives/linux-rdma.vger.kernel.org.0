Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0A9B139ACE
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jan 2020 21:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgAMUhe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Jan 2020 15:37:34 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:46678 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgAMUhe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Jan 2020 15:37:34 -0500
Received: by mail-qv1-f66.google.com with SMTP id u1so4641394qvk.13
        for <linux-rdma@vger.kernel.org>; Mon, 13 Jan 2020 12:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SGgdPDefMJK2lhDCjkXGy1jhZMgV6SkbIVU9ARWklK0=;
        b=XahzZdHppA3ZV2qBIT5KKmNxr58i6C9LXbpPw8baRRtwc3LIEvoorax0JWF0jrQ8Kg
         ibWHKgZnrDu1IDbI7uYRDdjPNJh2CgffepUqQGYWU9AUwoJHKnFgFEA2/fJrXlsYPz3d
         LRT+mPS7wgS/hPvSIWCmznv4ktIeZQYOWhYrXq7VI9yGDc99kf5r+6sJmuJef9p0CnjA
         Uz4isFHE4THGCLth0fmh+utHb66+lXrB4OQor+S/88GqsEqFUuGpSXUtc91v7MQ/AbVV
         kXQ81ZOqoi6mYVHD9guFgrFu2ZTM1greK3toFxqVHqQgQ1cVk/7lzDJlox41eVFfNH5c
         lbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SGgdPDefMJK2lhDCjkXGy1jhZMgV6SkbIVU9ARWklK0=;
        b=BY12VEjaBY+MfBWvktspjScQgyI7i7OMvMq952cwZ8jS2wRX6qF/G/CRW7JNdevZW3
         GrO/03xG3A0+aR31Mq96B508x9850hKCJ1IVZFy9/Kla8qlKm8JTM7LzeKLIs4CMrl84
         xm0UpYKhw699afptYKtUX53AQV6ps+5yC9qNfChs9GKPsqzmHeFn4+P/ZPLvrQmOITno
         a1N0y82ajVETTFVcWUfMpJFO+IcYgJyG21AXXlUim6nXVRdI5NKFEd7vS0BHZXHfzyQA
         dkwnVeNgn0ECwnDYA+pngVIr4LHmL49aaX+cfO6Opp63Bcvgj+xkf7T5/q/bs8r91W2M
         F2sg==
X-Gm-Message-State: APjAAAXWp8Si+p0Tj6z6ZOUmJ/wD72/Sv+dPFqxxOHp2gnD1ChewkOZl
        003JP+q9zViqqOpJguCElYlw+Q==
X-Google-Smtp-Source: APXvYqztt/9mNY4Hw1BnjA849nlHZ0wWGkxC6KrJb3jDbbwUjabjQ42aRG3i9U+LmI/4oczJ4wTbDQ==
X-Received: by 2002:a0c:e1ce:: with SMTP id v14mr13171721qvl.39.1578947853039;
        Mon, 13 Jan 2020 12:37:33 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id w60sm6263680qte.39.2020.01.13.12.37.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Jan 2020 12:37:32 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ir6Sq-0001x3-9F; Mon, 13 Jan 2020 16:37:32 -0400
Date:   Mon, 13 Jan 2020 16:37:32 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yishai Hadas <yishaih@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, dledford@redhat.com,
        maorg@mellanox.com, michaelgur@mellanox.com
Subject: Re: [PATCH rdma-next 00/14] Refactoring FD usage
Message-ID: <20200113203732.GB7112@ziepe.ca>
References: <1578504126-9400-1-git-send-email-yishaih@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578504126-9400-1-git-send-email-yishaih@mellanox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 08, 2020 at 07:21:52PM +0200, Yishai Hadas wrote:
> This series refactors the usage of FDs in both IB core and mlx5 driver.
> It includes:
> - Simplify destruction of FD uobjects by making them pure uobjects and use
>    a generic release method for all struct file operations.
> - Make ib_uverbs_async_event_file into a uobject.
> - Improve locking in few related areas.
> - Simplify type usage for ib_uverbs_async_handler().
> 
> This refactoring series may be followed by some other series that will allow
> the async FD to be allocated separately from the context and then enables
> having the alloc_context command over ioctl.
> 
> Yishai
> 
> Jason Gunthorpe (14):
>   RDMA/mlx5: Use RCU and direct refcounts to keep memory alive
>   RDMA/core: Simplify destruction of FD uobjects
>   RDMA/mlx5: Simplify devx async commands
>   RDMA/core: Do not allow alloc_commit to fail
>   RDMA/core: Make ib_ucq_object use ib_uevent_object
>   RDMA/core: Do not erase the type of ib_cq.uobject
>   RDMA/core: Do not erase the type of ib_qp.uobject
>   RDMA/core: Do not erase the type of ib_srq.uobject
>   RDMA/core: Do not erase the type of ib_wq.uobject
>   RDMA/core: Simplify type usage for ib_uverbs_async_handler()
>   RDMA/core: Fix locking in ib_uverbs_event_read
>   RDMA/core: Remove the ufile arg from rdma_alloc_begin_uobject
>   RDMA/core: Make ib_uverbs_async_event_file into a uobject
>   RDMA/core: Use READ_ONCE for ib_ufile.async_file

Applied to for-next

Jason
