Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27509189ECC
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 16:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgCRPEl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 11:04:41 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41531 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbgCRPEl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Mar 2020 11:04:41 -0400
Received: by mail-io1-f66.google.com with SMTP id y24so4626767ioa.8
        for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2020 08:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K7V57D5LKLD/makwBwGs+Nh4X2eF04Q8o8m9A5gDi7k=;
        b=L9KQnkzJOVeNGxUvACnsnuPM0B+emqMYZO5pvR9oadDVdJ8MQQY55uvRV+R1vprlFh
         MN/AVfCalBm4ZnfHwRupa5UirCNWVsiZll9jnXtaaJW2YWSrNuM3BVBoHkFM7UhbIMYD
         2eHV+t5kU+pyV6qUKPZT5UzYqa6AZSYgEDH2mtyJYnMxi0Gda+HyrlHQASsBLTk4vHJT
         SuZkhvG8dWEIR9zPQ5MHATUnodYULyO7fms1+6nycF+HqB3zfol3kRE8eL99SkDr+iQn
         a+kwRo32U01VbVaOki/LxXHI1+36KdxoyQznWJO3Q3zrkfniI8btJyAKyXR61xygIFMJ
         gBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K7V57D5LKLD/makwBwGs+Nh4X2eF04Q8o8m9A5gDi7k=;
        b=G89Nl1JnyGF+DbtESLhEEa1j2O9JmWCN32jn/rZdzESDweAT7FwRVVp3SeI3bHUQRZ
         QWLptJOo9j+TH+2iI4cC7AMZ8AYPCG6qJRtDHiKlukSeJtAOFDbe3B/+KIRAt+nmIOlB
         4OhbNnMLf5SJ+ghsjbKccQh3NmmSXKYGD9ZG171dtZFN0Id/fjPl9xfCsygZ1YBKXT0+
         f5h8HnAp7YQnlzx+FukX/ychuvVHJ6J+q4mlAa4uHDLsljv5Vt+mMFQnqE1LOebwndV/
         tM/ijErVQbdMvchLNwg+S9+rgt60WJoaCE6DKLyJpIo6k4pLY890phYddsdu42/MPpbj
         2M4Q==
X-Gm-Message-State: ANhLgQ2YZGXh2Q4xrtz37oN5s/X0bRjtnazreqv39kGzOIw+A+Bu3pzi
        s3EkvHOJYFITRiV63N6AoOtcOJ4xtaBf+H4jlM3b0ROQKDQ=
X-Google-Smtp-Source: ADFU+vsPU4sqnjw/Ln8NOvYRQp67bPCJ3jviKgPkXCwhrtBybp5GM9Cjwg2lfQ33S3vo3ycfFZHOCFR6GXhZeJMLvf0=
X-Received: by 2002:a02:a581:: with SMTP id b1mr5051956jam.10.1584543879155;
 Wed, 18 Mar 2020 08:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
 <20200311161240.30190-7-jinpu.wang@cloud.ionos.com> <20200311190156.GH31668@ziepe.ca>
 <CAHg0HuziyOuUZ48Rp5S_-A9osB==UFOTfWH0+35omiqVjogqww@mail.gmail.com>
 <20200312172517.GU31668@ziepe.ca> <CAHg0HuxmjWu2V6gN=OTsv3v6aYxDkQN=z4F4gMYAu5Wwvp1qGg@mail.gmail.com>
 <20200313122546.GC31668@ziepe.ca>
In-Reply-To: <20200313122546.GC31668@ziepe.ca>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 18 Mar 2020 16:04:28 +0100
Message-ID: <CAMGffEnyZBw+9RR0YDW7=wdEEFpfTx53iBJGBG8M-ZOM=RA-SA@mail.gmail.com>
Subject: Re: [PATCH v10 06/26] RDMA/rtrs: client: main functionality
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

snip
> > > > > > +static void rtrs_clt_add_path_to_arr(struct rtrs_clt_sess *sess,
> > > > > > +                                   struct rtrs_addr *addr)
> > > > > > +{
> > > > > > +     struct rtrs_clt *clt = sess->clt;
> > > > > > +
> > > > > > +     mutex_lock(&clt->paths_mutex);
> > > > > > +     clt->paths_num++;
> > > > > > +
> > > > > > +     /*
> > > > > > +      * Firstly increase paths_num, wait for GP and then
> > > > > > +      * add path to the list.  Why?  Since we add path with
> > > > > > +      * !CONNECTED state explanation is similar to what has
> > > > > > +      * been written in rtrs_clt_remove_path_from_arr().
> > > > > > +      */
> > > > > > +     synchronize_rcu();
> > > > >
> > > > > This makes no sense to me. RCU readers cannot observe the element in
> > > > > the list without also observing paths_num++
> > > > Paths_num is only used to make sure a reader doesn't look for a
> > > > CONNECTED path in the list for ever - instead he makes at most
> > > > paths_num attempts. The reader can in fact observe paths_num++ without
> > > > observing new element in the paths_list, but this is OK. When adding a
> > > > new path we first increase the paths_num and them add the element to
> > > > the list to make sure the reader will also iterate over it. When
> > > > removing the path - the logic is opposite: we first remove element
> > > > from the list and only then decrement the paths_num.
> > >
> > > I don't understand how this explains why synchronize_rcu would be need
> > > here.
> > It is needed here so that readers who read the old (smaller) value of
> > paths_num and are iterating over the list of paths will have a chance
> > to reach the new path we are about to insert. Basically it is here to
> > be symmetrical with the removal procedure: remove path,
> > syncronize_rcu, path_num--.
>
> How do readers see the paths_num before it is inserted into the list?
>
> Jason
We checked again, the synchronize_rcu indeed bogus, list_add_tail_rcu
has SMP barier,
so change will be visible to all CPU. We will remove it.

Thanks!
