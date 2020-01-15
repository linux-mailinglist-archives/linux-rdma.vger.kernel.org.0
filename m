Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F81B13CD71
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2020 20:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbgAOTvG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jan 2020 14:51:06 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36452 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729398AbgAOTvG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jan 2020 14:51:06 -0500
Received: by mail-qt1-f196.google.com with SMTP id i13so16873069qtr.3
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jan 2020 11:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C2GpoeMTQ3C5/SVINlCr1nzgHAc/1dkran4u5LeNZ88=;
        b=Znvn5qEARetSUwwB8LYotuXnTuWwDA4GiC+sv7a/Hycrv/SxhV+6H6FvY31n68Lxes
         mI/SIsvVyXhMgDASbF1MPfSRkkGKr0ObX1T2xuq1iXrSAdym4Qht3bGx689lO8/Gt5s+
         ra6+Odj43XHAQ+xDanUB4D1iZjjCTPZM7bovzjVmybxPdGRVOYj6CrcyBKz/bRIXFx7s
         r9P5gW4f/uMYiAYzTefzdp6GozDnM7zvP6j9F+BGxvShcMwZK7uaDyr2wX+jHhZoJA08
         KcoOqgYAlryUYEOZNIQ+jBgtGc0VQWJwghJRL9DdFiarNViDr8ch+B+YsXjPSS1HEeZW
         UkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C2GpoeMTQ3C5/SVINlCr1nzgHAc/1dkran4u5LeNZ88=;
        b=N1+zKG+7QG7X/nxHvLuoPjq1MuijO3mYx9ICGLHmjzKbhuIMteatz8ehnv7W/hH0sr
         qzjbx0qTARbmNXgR/ivmfB9QTn5Pa+lVmS1A0Jc/H8vAR44EODjpAH0n0xyAbe8Ieddt
         p38gNejWwrmVpD7v6TRujlvWASoR3sD9PcKtZFa5bYzSqYhh5JVGg2hWDObOjiLMJlvh
         P+DbeqyoJxQBjts8AeYDdB/E6qFNxwVLfxjb/clKVzWT1zhGQddTVEILrnoSJjxnOlWd
         bZayxzYgBxu+tppf637FyRW3p2ullLIh+p0WEDChOt8/6JC19PuzMQaqRT1awU/1vmUi
         gXgg==
X-Gm-Message-State: APjAAAXyTR3FQpOf488UH/yY4QP4TtvWzcUvnuAop7eU5QHv2lAxToAA
        xnYXhs/4OLOeUNs64xvsSHWf1048q3I=
X-Google-Smtp-Source: APXvYqy4FiqNvuyrkWFC383VYYWvp2eMDuTQI/yB7yQUbHYQOWqpK+GAa5n9CanLH/BN9s794ZXiDQ==
X-Received: by 2002:ac8:5313:: with SMTP id t19mr236513qtn.375.1579117865477;
        Wed, 15 Jan 2020 11:51:05 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id g52sm10439241qta.58.2020.01.15.11.51.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jan 2020 11:51:04 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1irogy-0000QQ-GT; Wed, 15 Jan 2020 15:51:04 -0400
Date:   Wed, 15 Jan 2020 15:51:04 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next 6/6] RDMA/efa: Do not delay freeing of DMA pages
Message-ID: <20200115195104.GA929@ziepe.ca>
References: <20200114085706.82229-1-galpress@amazon.com>
 <20200114085706.82229-7-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114085706.82229-7-galpress@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 14, 2020 at 10:57:06AM +0200, Gal Pressman wrote:
> When destroying a DMA mmapped object, there is no need to delay the
> pages freeing to dealloc_ucontext as the kernel itself will keep
> reference count for these pages.

Why does the commit message talk about dealloc_ucontext but doesn't
change dealloc_ucontext?

> +	free_pages_exact(cq->cpu_addr, cq->size);
> 	rdma_user_mmap_entry_remove(cq->mmap_entry);

This is out of order, the pages can't be freed until the entry is
removed.

There is also a bug in rdma_user_mmap_entry_remove(),
entry->driver_removed needs to be set while holding the xa_lock or
this is not the required fence.

Jason
