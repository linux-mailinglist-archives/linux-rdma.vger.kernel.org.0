Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27C0B17958C
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2020 17:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbgCDQnj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Mar 2020 11:43:39 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:46312 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729926AbgCDQnj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Mar 2020 11:43:39 -0500
Received: by mail-il1-f195.google.com with SMTP id e8so2344030ilc.13
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2020 08:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wqbCXu/KKmiMpU4T8iDDRdWLLVu3lhm9UoyKsmBbWMo=;
        b=TlFRMurGebLe33t3WEwJ61mStlQ3L8kX3yamgTwx8mhIu+wneOYmjIhMuEKJ/tLCN0
         V46qJa10ygYGMEGMhxlIRS0d+jLoFMNLEwrTSBHo4luwzPlMjOUQeRiX8PapbhK8oliT
         Kf/yLXT9G5bup+iu+Vn47551IgCbH0670O4hLkl5bEJ2RyrBb6kLUDvvNsBDr6k11UII
         RqOwRc7HnyCOhQy09y9gPFm4SQsVzx8bXjczOR52lAu6B39BrcbCt71Jsnw9EGxghr/y
         esZ8ErtBl82FuKj7cJIekYVbZIJN/SMYk824Dh4kL7x2EAv2jBkFJNzvEtWaJoHgeI73
         AGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wqbCXu/KKmiMpU4T8iDDRdWLLVu3lhm9UoyKsmBbWMo=;
        b=TeEkp2WBZaiMTuBh1p1MgxLsown94CFOcO+ZiWKRnXfXBNxKsrPa6eZy6zitTsUmUS
         L6++WEtIFE/VS6B12/UpRGE80acKdCXyvh6wak+wlxW7H2kkk7++xAIo4tKappAHz2Xc
         mGD9Y7Z0nKPDY0GBZo193rYcSFnN9U7VsGbOGUA5xTni64FPKBaKCo8X+DpDFMn8kXrp
         kq/An1E0BzFVZmzt2D3/VjEZULwgyIhubvUuylvmkfxc1YbKkLDvW7x9R2g5sfwtqie7
         nA8sGZCOhZ6IrAHWpSKkMYQyB5PQi5/Nv/CgnOIOBkBl+ZArovcnZoTiBe4Xok4f1X/r
         YJrw==
X-Gm-Message-State: ANhLgQ29IMy9FJUUgyxmYPbJGWsVpXk9Ta2/duAMGQuBULseCw3yS+2r
        Wif3xYBUwlevEsUyifmNF8U/ec0yRUNEUhUkijV+Ng==
X-Google-Smtp-Source: ADFU+vt97TmkVOwBaxwgfwm/dt9xTkEhILmwVU3QYcnJLEJN71resSsqfLpEQ7FUyoumSOzlywGzaVpYg4Tyif1UnAw=
X-Received: by 2002:a92:351c:: with SMTP id c28mr3442806ila.217.1583340218543;
 Wed, 04 Mar 2020 08:43:38 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-7-jinpuwang@gmail.com>
 <c3c8fbcc-0028-9b23-8eff-3b5f1f60e652@acm.org> <CAHg0HuxJgjQca3Vy7nbcVKs0bUoj=-Uqoa5DOzYoqRHQ6Vph7A@mail.gmail.com>
 <597777e7-ac5a-5fc4-c1f7-3ffa5876a6f2@acm.org>
In-Reply-To: <597777e7-ac5a-5fc4-c1f7-3ffa5876a6f2@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 4 Mar 2020 17:43:24 +0100
Message-ID: <CAMGffEmbV1YL4O860EswBKm2UHBYP_cgqMFYFVc2AdHnAFeu+g@mail.gmail.com>
Subject: Re: [PATCH v9 06/25] RDMA/rtrs: client: main functionality
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 3, 2020 at 5:04 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 3/2/20 5:20 AM, Danil Kipnis wrote:
> > On Sun, Mar 1, 2020 at 2:33 AM Bart Van Assche <bvanassche@acm.org> wrote:
> >> On 2020-02-21 02:47, Jack Wang wrote:
> >>> +static struct rtrs_permit *
> >>> +__rtrs_get_permit(struct rtrs_clt *clt, enum rtrs_clt_con_type con_type)
> >>> +{
> >>> +     size_t max_depth = clt->queue_depth;
> >>> +     struct rtrs_permit *permit;
> >>> +     int cpu, bit;
> >>> +
> >>> +     /* Combined with cq_vector, we pin the IO to the the cpu it comes */
> >>
> >> This comment is confusing. Please clarify this comment. All I see below
> >> is that preemption is disabled. I don't see pinning of I/O to the CPU of
> >> the caller.
> > The comment is addressing a use-case of the driver: The user can
> > assign (under /proc/irq/) the irqs of the HCA cq_vectors "one-to-one"
> > to each cpu. This will "force" the driver to process io response on
> > the same cpu the io has been submitted on.
> > In the code below only preemption is disabled. This can lead to the
> > situation that callers from different cpus will grab the same bit,
> > since find_first_zero_bit is not atomic. But then the
> > test_and_set_bit_lock will fail for all the callers but one, so that
> > they will loop again. This way an explicit spinlock is not required.
> > Will extend the comment.
>
> If the purpose of get_cpu() and put_cpu() calls is to serialize code
> against other threads, please use locking instead of disabling
> preemption. This will help tools that verify locking like lockdep and
> the kernel thread sanitizer (https://github.com/google/ktsan/wiki).
We can look into it, but I'm afraid converting to spinlock might have
a performance impact.

>
> >>> +static int rtrs_post_send_rdma(struct rtrs_clt_con *con,
> >>> +                             struct rtrs_clt_io_req *req,
> >>> +                             struct rtrs_rbuf *rbuf, u32 off,
> >>> +                             u32 imm, struct ib_send_wr *wr)
> >>> +{
> >>> +     struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
> >>> +     enum ib_send_flags flags;
> >>> +     struct ib_sge sge;
> >>> +
> >>> +     if (unlikely(!req->sg_size)) {
> >>> +             rtrs_wrn(con->c.sess,
> >>> +                      "Doing RDMA Write failed, no data supplied\n");
> >>> +             return -EINVAL;
> >>> +     }
> >>> +
> >>> +     /* user data and user message in the first list element */
> >>> +     sge.addr   = req->iu->dma_addr;
> >>> +     sge.length = req->sg_size;
> >>> +     sge.lkey   = sess->s.dev->ib_pd->local_dma_lkey;
> >>> +
> >>> +     /*
> >>> +      * From time to time we have to post signalled sends,
> >>> +      * or send queue will fill up and only QP reset can help.
> >>> +      */
> >>> +     flags = atomic_inc_return(&con->io_cnt) % sess->queue_depth ?
> >>> +                     0 : IB_SEND_SIGNALED;
> >>> +
> >>> +     ib_dma_sync_single_for_device(sess->s.dev->ib_dev, req->iu->dma_addr,
> >>> +                                   req->sg_size, DMA_TO_DEVICE);
> >>> +
> >>> +     return rtrs_iu_post_rdma_write_imm(&con->c, req->iu, &sge, 1,
> >>> +                                         rbuf->rkey, rbuf->addr + off,
> >>> +                                         imm, flags, wr);
> >>> +}
> >>
> >> I don't think that posting a signalled send from time to time is
> >> sufficient to prevent send queue overflow. Please address Jason's
> >> comment from January 7th: "Not quite. If the SQ depth is 16 and you post
> >> 16 things and then signal the last one, you *cannot* post new work until
> >> you see the completion. More SQ space *ONLY* becomes available upon
> >> receipt of a completion. This is why you can't have an unsignaled SQ."
> >
> >> See also https://lore.kernel.org/linux-rdma/20200107182528.GB26174@ziepe.ca/
> > In our case we set the send queue of each QP belonging to one
> > "session" to the one supported by the hardware (max_qp_wr) which is
> > around 5K on our hardware. The queue depth of our "session" is 512.
> > Those 512 are "shared" by all the QPs (number of CPUs on client side)
> > belonging to that session. So we have at most 512 and 512/num_cpus on
> > average inflights on each QP. We never experienced send queue full
> > event in any of our performance tests or production usage. The
> > alternative would be to count submitted requests and completed
> > requests, check the difference before submission and wait if the
> > difference multiplied by the queue depth of "session" exceeds the max
> > supported by the hardware. The check will require quite some code and
> > will most probably affect performance. I do not think it is worth it
> > to introduce a code path which is triggered only on a condition which
> > is known to never become true.
> > Jason, do you think it's necessary to implement such tracking?
>
> Please either make sure that send queues do not overflow by providing
> enough space for 512 in-flight requests fit or implement tracking for
> the number of in-flight requests.
We do have enough space for send queue.
>
> Thanks,
>
> Bart.
>
Thanks Bart!
