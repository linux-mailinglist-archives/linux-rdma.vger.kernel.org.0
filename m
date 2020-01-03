Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D78BE12F947
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jan 2020 15:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgACOjp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jan 2020 09:39:45 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:37740 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbgACOjp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Jan 2020 09:39:45 -0500
Received: by mail-io1-f67.google.com with SMTP id k24so11179303ioc.4
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jan 2020 06:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5RN9HFVC8/4wrj1xZ018jyfw28e2mD+SWO6pvdC3TeY=;
        b=F5lh6fALXVB6JryMbs6j1wFTsL3dfMRKZPyzu9ebay/+oey6DVPD0+rPS4cSzMHGKa
         io6VWPtzfdqgJwvPCdKQxNQqDwNnBwZpIPKEd1xfGVBqrko8Ek7SdHCQEb9uO3N4S162
         hcDT1AmnIjNuTjxS5jaNJHP0S4O2jAtLrP4wORPEGuTcSxfay/kW04NWlhjl8QtL8q2B
         WcwDLkzRIoKcy0f+3ESBM0QCqGPnOUIZZIiueWhKbh98kNGUJifm3fsFXpJzkjmphzb1
         zWgVHGqWZeA/jceOfDNRAfscjDNqaXoNoMDDvKK5VBfhRcVP/qM8Ox8XgaWW94QGZXbs
         Fciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5RN9HFVC8/4wrj1xZ018jyfw28e2mD+SWO6pvdC3TeY=;
        b=ipT3TsWMDyIW9Ibt6wEMi8ZRELRIQWWC3LGc/E1Y3MZ/689K+Sy7bVyNgxB1dUwGJK
         4vBTpCJcPTVYd1eBYEqICGR9YLwjFosGwL7tZ2NcnHd5haXKxDcrMkjoeUf0Hfde8pVz
         psR21piYquLtIisgTYAviWKuzEuGNRkaj3hHeXHYwiIb6OJlTX5HvdvEGx7qiuCIo7eT
         h3M+2/qZufAuBsCp7SE9Ct7uBzbjIzcLtGNOs7bOwUUHennOby+5FC8LazBKcGubH7AN
         p/6m+VXjpyWiPCkDJUBvq7929NkfEiCTuFOjSJTXy6DlSPWwEOm9bZ07j3vfwvucvhhc
         iANA==
X-Gm-Message-State: APjAAAWKI+4pO8n7LrNUwxj9wWjI87ygeVWBKiPrx2eK30HHotc1lfNh
        avGRnU2UTgwMShVWa4KW98vm6Td4rMkLBdpM/P15oQ==
X-Google-Smtp-Source: APXvYqwREroFheKRCPoBTx3GS/vRMEQRWhH66/SrZi370tBE90y7g9QKiwO0SgXi9HyiUH2cAN4Vvv2pAdufbHOLn/o=
X-Received: by 2002:a02:a610:: with SMTP id c16mr68588683jam.13.1578062384700;
 Fri, 03 Jan 2020 06:39:44 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-8-jinpuwang@gmail.com>
 <c4875699-68a6-9a82-4324-553f30504574@acm.org>
In-Reply-To: <c4875699-68a6-9a82-4324-553f30504574@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 3 Jan 2020 15:39:34 +0100
Message-ID: <CAMGffEn5D235q=6vV6nE2avvW3D7wwB4=BBn_5HcBbxH4WLyxQ@mail.gmail.com>
Subject: Re: [PATCH v6 07/25] rtrs: client: statistics functions
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 2, 2020 at 10:07 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 12/30/19 2:29 AM, Jack Wang wrote:
> > From: Jack Wang <jinpu.wang@cloud.ionos.com>
> >
> > This introduces set of functions used on client side to account
> > statistics of RDMA data sent/received, amount of IOs inflight,
> > latency, cpu migrations, etc.  Almost all statistics is collected
>                                                         ^^
>                                                         are?
will fix.
> > using percpu variables.
> > [ ... ]
> > +static inline int rtrs_clt_ms_to_id(unsigned long ms)
> > +{
> > +     int id = ms ? ilog2(ms) - MIN_LOG_LAT + 1 : 0;
> > +
> > +     return clamp(id, 0, LOG_LAT_SZ - 1);
> > +}
>
> I think it is unusual to call the returned value an "id" in this
> context. How about changing "id" into "bin" or "bucket"? See also
> https://en.wikipedia.org/wiki/Histogram.
will rename id to bin
>
> Thanks,
>
> Bart.
Thanks
