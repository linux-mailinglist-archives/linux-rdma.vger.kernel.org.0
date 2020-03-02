Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 482A917561B
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2020 09:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgCBIkG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Mar 2020 03:40:06 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:44658 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgCBIkF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Mar 2020 03:40:05 -0500
Received: by mail-io1-f65.google.com with SMTP id u17so5620870iog.11
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2020 00:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jze/FNhRDKWjQlWtmwCDYRnX1I7Prg2i7AZY5w7Cpnc=;
        b=L4hx1DGIp97F0xxeWLytLuL4nJiy+neZad2J/X/6mysuwRtntVOGCZ2Z8ePsY8+2LG
         rLHYtJKJK0K+vAZPGyGiB8sSUPeybyNDaLppd6wJUqMuXS9KiTrwLqPUCfJbV+hOTtpS
         lGZpF2q/BAEDhXtBG00f0LOlfd74B18n6EXVCJ/3hA8MVmju1WIfYzG8Vw6El2w3pss+
         kYpd+jUw/qEw24KZkssrZ3iwlq0kQo7QikDqKzA5y+AATKqj3/6S+jyyRzUttVhJwKsd
         ykVpohjBaF2bh147oajPIbD53I4wxK6IyRuYi3PrcuU9Xei3nCVDRYtLwINnKKEwnfhw
         O4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jze/FNhRDKWjQlWtmwCDYRnX1I7Prg2i7AZY5w7Cpnc=;
        b=O8+ngET/7kTiTo70rDE1axRgrQQCVHa/z2le5rzQDtKRDbfbFYkOWl/cgjow4uDP8b
         L8G2E/22SZHm50Ush3UkoHmIFt7+M71eP4wnnDGDt4A0hwcB6cKIRd3xqJXg9Dzd3ubn
         7tkirvLJxSlvPZ2PW1nVFJyCAlwRerPS+AbOPh0gz6zyGq8z5XiOQUcZTE87kGBOIUH/
         LlnNLu+u9IGqOiWc/x0TWGPiczSQ+hgQkinWqd6Zlw7TQyvQbIkrG7qo+LbXtSIsrdK2
         mrGxZfNAKaUz/P+MYandQidPuVLz3wtMCCvE1FqXZrKqLxuB4JRi6rPnds35PMYQgU4b
         TbiQ==
X-Gm-Message-State: APjAAAWRUEsK5y+kJHK7ddmasYIFcB6K9R/GQSpXAgxr8My69EvoIWmq
        fRig+FGyCWXSF3/7r/wlZ7Rr1zT3sYq4Ho4Pqs5J2Q==
X-Google-Smtp-Source: APXvYqwkAZnv7X7wfECu0vOH3IDGQx0c6Y1SH7wYI0ImzAr2Ut9SF0aBLXkSTjk245yZEeo6zHkpzb77qe6NwX/9Yz4=
X-Received: by 2002:a6b:6e02:: with SMTP id d2mr12431680ioh.22.1583138404966;
 Mon, 02 Mar 2020 00:40:04 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-3-jinpuwang@gmail.com>
 <e1d8d2ca-78cf-f3ee-2286-1c96e5cfefc7@acm.org>
In-Reply-To: <e1d8d2ca-78cf-f3ee-2286-1c96e5cfefc7@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 2 Mar 2020 09:39:56 +0100
Message-ID: <CAMGffE=X6s0DSKL2c-AmBa6_shvJggNJ0aqCx0C9SbLh-fR3nw@mail.gmail.com>
Subject: Re: [PATCH v9 02/25] RDMA/rtrs: public interface header to establish
 RDMA connections
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 1, 2020 at 1:31 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-02-21 02:46, Jack Wang wrote:
> > +/**
> > + * enum rtrs_clt_con_type() type of ib connection to use with a given
> > + * rtrs_permit
> > + * @USR_CON - use connection reserved vor "service" messages
> > + * @IO_CON - use a connection reserved for IO
> > + */
>
> vor -> for?

right, will fix. German version -.-
>
>
> > +enum rtrs_clt_con_type {
> > +     RTRS_USR_CON,
> > +     RTRS_IO_CON
> > +};
>
> The name "USR" is confusing. How about changing this into "ADMIN"?

Sounds good.
>
>
> > +/*
> > + * Here goes RTRS server API
> > + */
>
> How about splitting this header file into one header file for the client
> API and another header file for the server API? I expect that most users
> will only include one of these header files but not both.
The initial RFC, we did have 2 separate headers, one for the client
and one for the server, due to the fact most users
will only include one of the headers.
https://lore.kernel.org/linux-block/1490352343-20075-1-git-send-email-jinpu.wangl@profitbricks.com/

Later we've made rtrs can be more flexible, in a way user can load
client and server on the same server at the same time, and both
headers are merged to one.

I appreciate your feedback, thanks Bart!

Regards!
