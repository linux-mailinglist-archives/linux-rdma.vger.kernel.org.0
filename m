Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 590B32B9A9
	for <lists+linux-rdma@lfdr.de>; Mon, 27 May 2019 19:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfE0R7b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 May 2019 13:59:31 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45682 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfE0R7b (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 May 2019 13:59:31 -0400
Received: by mail-vs1-f66.google.com with SMTP id k187so11070446vsk.12
        for <linux-rdma@vger.kernel.org>; Mon, 27 May 2019 10:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eKGZjA4bqV/7eQg2v6SswOPXR8IjDHYXDfVlh0ptz4M=;
        b=DjWP4kmy6JWNpifT4rEb71oZgCUbR0mKqbHWs/AFRiLFADs8/PlnM+yFwFtLdbJEX8
         VxlS0tqPFC/H7pW1txa5kCeT6IA3rUtZY9n5EIGglCm3l8UYqIZApL5kJmm40PGuO0Wr
         gKxgp4fJ9QPRJ//nDgQWNTHElmRVEg1vvJRcX6o67s9sHnRxBTt4MLkfwMCbZ3UE1r2+
         tjE/1B8SyUO1NSnL7HCPh7DC18ox/eUUbfq2HwwmO44PBUziyahK3e2TinUa1qf/BqZm
         a56T0NdnN4bmamVy67Hzgn3SIZ76BSERfx7KSSpa9urNqbziEjGDNhG+eUyPSMgHAz2T
         7QYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eKGZjA4bqV/7eQg2v6SswOPXR8IjDHYXDfVlh0ptz4M=;
        b=btptYewshWRmG2MHGqV5iR0qqw+ag2yPDHcvg6wM37lW0WpOIxdC8r7Aoy/T+tTwXt
         PDUS6XejM3/iuZDfEbMRlHUUgrJjMLubtoIKBkKtgrbOQ6w6ywHW7XGmMLV+9vZQwkdT
         TPmNulONPcF+Yw+fESbPDJPrOthCrbmVVdIcbnw1TS0d5doOLi10VFmcMgDJy5EWDORI
         mPFnokCqldDYRl5a3WXVjKLFch9nU4zJ65dOCbbkHiex5dhoHbJGCLC94JUgroW5uvJg
         Ue7VdvZYJOVy+KmL4D7xRsRM+aOFhvjXg7Y44Tx8uE06IEpLyDmipkZE/NR4ieX3GxRu
         BhAw==
X-Gm-Message-State: APjAAAVuItAFqNQBt1e/N0sLbGRJ5SVn5cix0yPZwyrQZi9yzUYng2YF
        UkC9SSXKuIFFEPEux8Pxa8H+ZWGtHHE=
X-Google-Smtp-Source: APXvYqzcR+7HkEogk8hA4rTP7lcjk3WYlhwyNLY9V7Bw3sMAwOkm/dHnbtxDvkwRiQcnF/njQmenmQ==
X-Received: by 2002:a67:d702:: with SMTP id p2mr49923335vsj.36.1558979970177;
        Mon, 27 May 2019 10:59:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id u27sm1255527vkk.11.2019.05.27.10.59.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 10:59:29 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hVJuC-0002RS-VM; Mon, 27 May 2019 14:59:28 -0300
Date:   Mon, 27 May 2019 14:59:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nirranjan Kirubaharan <nirranjan@chelsio.com>
Cc:     bharat@chelsio.com, dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v5] iw_cxgb4: Fix qpid leak
Message-ID: <20190527175928.GA9364@ziepe.ca>
References: <815c6128bcd5a60949f2418db9c6c0d3925b06aa.1558592047.git.nirranjan@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <815c6128bcd5a60949f2418db9c6c0d3925b06aa.1558592047.git.nirranjan@chelsio.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 23, 2019 at 12:05:39AM -0700, Nirranjan Kirubaharan wrote:
> In iw_cxgb4, Added wait in destroy_qp() so that all references to
> qp are dereferenced and qp is freed in destroy_qp() itself.
> This ensures freeing of all QPs before invocation of
> dealloc_ucontext(), which prevents loss of in use qpids stored
> in ucontext.
> 
> Signed-off-by: Nirranjan Kirubaharan <nirranjan@chelsio.com>
> Reviewed-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
> v2:
> - Used kref instead of qid count.
> ---
> v3:
> - Ensured freeing of qp in destroy_qp() itself.
> ---
> v4:
> - Change c4iw_qp_rem_ref() to use a refcount not kref and trigger
> complete() when the refcount goes to 0.
> - Move all of queue_qp_free into c4iw_destroy_qp()
> ---
> v5:
> - Used refcount_t instead of atomic_t
> ---
>  drivers/infiniband/hw/cxgb4/iw_cxgb4.h |  4 +--
>  drivers/infiniband/hw/cxgb4/qp.c       | 48 ++++++++++++----------------------
>  2 files changed, 19 insertions(+), 33 deletions(-)

Applied to for-next

Thanks,
Jason
