Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D78E5132C9B
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2020 18:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgAGRJj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jan 2020 12:09:39 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:38592 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbgAGRJj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jan 2020 12:09:39 -0500
Received: by mail-io1-f67.google.com with SMTP id v3so84449ioj.5
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jan 2020 09:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yv1XK5ThTQl5/2gi+CzbYRWbQSxFPKCrKi3cSDeoMEQ=;
        b=cajYypVOAy5qs/R0oi/ZqQqlXJJhxcDDwCtaEps75K6bwPALzv15Wms2uxJbI18RCR
         mSQjjp1YgGHOu30eoiY6mIxKZ5EEb9yr2fX3L4K6xWX2VbHlhvKYQvXpH+z0dV/g+d0/
         d1uX5w6Y7xn0xO53mBa0FRo3A6L4L3f2la5DMsENrbI+CBIw9wMVzBJf7Z1BqMjBJ4LU
         F2vo1JUPGKsZdfALgx8Fy5RYjCFY9y9NYTbyZ0OZ75oKQu95Ugpof376Xgh3kROlNMMO
         7PVpfosg5jAmz4lcCaYu0S5JsD4IpOTY/B3PitSbRo661r6lXgmr19hD1i/sZ8sm0/5N
         2lJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yv1XK5ThTQl5/2gi+CzbYRWbQSxFPKCrKi3cSDeoMEQ=;
        b=YRzXU7lNcUYxC37NKw6hKG3ywzoYUBDOe+lFrFrJxCS4bWzLDfK1zrciHPO3IDS99L
         3wQrKPWgNK2KHn4gIu5CBXR87FGHBne5xrptEIGniENBcRT1Hx3q/rjKqPdFzIEKjZIb
         RtPAv+7FPw+Y5fQTMuDKnUcY6XzCLrZ9p9es0NZi4qQSSwzUJAN8HfYclAJ9AK3jwTzG
         dfMif03ulKmTqzr39z+4Qnn1/w4T2CqqcM3x7GLG0TZde7kLcga361SVJsOvbl/UgHdk
         qjqnbifcGJPEk/V/ULV+KBU7qcqIEROx/RK//thyCfcGCXYS/KKa+3aAseS0vOSyBPGG
         Giqw==
X-Gm-Message-State: APjAAAW24mIBRiZ84L9ZsdM2IhAH2q2izw542GxzUe/fg8D5vzGrOjG0
        rk+irRCX7ZBniELh7vcAJIB05O1bFf4qJNNoPpPSkA==
X-Google-Smtp-Source: APXvYqxFtPBCxkGh55CGADxqto7UfPsdjrHQHzjJyOSecGSo6YNOVZRCRngpQrZF+i9ZHq6bRXdcP1qVYw30wQljtK8=
X-Received: by 2002:a05:6638:72c:: with SMTP id j12mr493221jad.136.1578416978570;
 Tue, 07 Jan 2020 09:09:38 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-17-jinpuwang@gmail.com>
 <23dc5d7a-06e1-7ce4-3ab6-20cb6f49987a@acm.org>
In-Reply-To: <23dc5d7a-06e1-7ce4-3ab6-20cb6f49987a@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 7 Jan 2020 18:09:27 +0100
Message-ID: <CAMGffEkCRargsdZsbMHktU1mGHeaHVFiwEVP6b+7Mp+zJdKjUg@mail.gmail.com>
Subject: Re: [PATCH v6 16/25] rnbd: client: private header with client structs
 and functions
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

On Thu, Jan 2, 2020 at 11:37 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 12/30/19 2:29 AM, Jack Wang wrote:
> > +struct rnbd_iu {
> > +     union {
> > +             struct request *rq; /* for block io */
> > +             void *buf; /* for user messages */
> > +     };
> > +     struct rtrs_permit      *permit;
> > +     union {
> > +             /* use to send msg associated with a dev */
> > +             struct rnbd_clt_dev *dev;
> > +             /* use to send msg associated with a sess */
> > +             struct rnbd_clt_session *sess;
> > +     };
> > +     blk_status_t            status;
> > +     struct scatterlist      sglist[BMAX_SEGMENTS];
> > +     struct work_struct      work;
> > +     int                     errno;
> > +     struct rnbd_iu_comp     comp;
> > +     atomic_t                refcount;
> > +};
>
> This data structure includes both a blk_status_t and an errno value. Can
> these two members be combined into a single member?
I guess you were suggesting to remove status and use
errno_to_blk_status(iu->errno) to call into blk_mq_end_request.
will do.
>
> Thanks,
>
> Bart.
Thanks.
