Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78D7117A42D
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2020 12:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgCEL0P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Mar 2020 06:26:15 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:40465 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgCEL0P (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Mar 2020 06:26:15 -0500
Received: by mail-io1-f65.google.com with SMTP id d8so2875515ion.7
        for <linux-rdma@vger.kernel.org>; Thu, 05 Mar 2020 03:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LMFwKGCJmork/D34ePiU1Gk+yq0aYO7+KssBBPz9BoY=;
        b=ZXpXJ9VuT1+s587bYyN9TQN/vpGp1uggR49Kd4y+qJlUA0jmCkVVokmWTTHqJleo3v
         TDSW6O5Iak6Xw8H8yDvjLrpcLj7MLtby0Qjm7uOBAkNdk+WH+8NqPpDsneDGg688yGtz
         0YVaDm0+nJgUXSiFwjlpd2vFHzc/VqceoLMM43GpJz/8gjSSXL2ewhhHEBFl1NsbWDAi
         u20q2a6TzZebWwFzHdYjBNk93xIXbNpHf5mmv3uv6abOzA+8SedPUyRRPwNEfnC4lgZW
         W2s8V3WyIK3mlbNydAI3ZcCi9d3EWqmUpyb0ZYHt/AZchUybVTFZveAc2pk1G+ni0gYl
         +USg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LMFwKGCJmork/D34ePiU1Gk+yq0aYO7+KssBBPz9BoY=;
        b=BDN25KDYuvkJ+STDD0EMqSmb5/PkVkPiyHyi1IPynpBbcaWxmEnjLJC/p804HsLu9K
         i52XFUJ5bj1hKOUi3ZEY3/BwoX6tJJ35CsHAa9GBG0ucXkZSQUNxcrv6Mn/frB+wR616
         kXwRftB8THoP2WJSbMyBKWVgffo64nMvc9avp/imqfsXlblAEXTcCukQJYnVO4hmWof2
         99L+ZroF5+HHjIB79lRgEn0p/317TtBqbCgZUbv3xi7dUJJOmM1RWX8V0ogII80B74dE
         9eyX2wO+n6Codo3G6lDxAWBgkdNE82ovUyrvB+bsgP4pc98cIvl+1t+47GMPpzAQIDyg
         yQLw==
X-Gm-Message-State: ANhLgQ3cJFAeY/FPRi217eeZ6ezdfPV8SVGCgxH7NT/BQTzdARBAdn3h
        htGnrtdtasvekmb23ig8/71lpqwxYqmeh2hTeUMnag==
X-Google-Smtp-Source: ADFU+vtXjbGcb0DKhlaCszXkVvnK6QpDlV8W5GvHjv4GySpQgfC9oNsiivY5dsAyFymbC2m8WWsr0dcTFC6e+SbjMsY=
X-Received: by 2002:a05:6602:1508:: with SMTP id g8mr6134106iow.22.1583407573161;
 Thu, 05 Mar 2020 03:26:13 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-7-jinpuwang@gmail.com>
 <c3c8fbcc-0028-9b23-8eff-3b5f1f60e652@acm.org> <CAHg0HuxJgjQca3Vy7nbcVKs0bUoj=-Uqoa5DOzYoqRHQ6Vph7A@mail.gmail.com>
 <597777e7-ac5a-5fc4-c1f7-3ffa5876a6f2@acm.org> <CAMGffEmbV1YL4O860EswBKm2UHBYP_cgqMFYFVc2AdHnAFeu+g@mail.gmail.com>
 <20200304164903.GF31668@ziepe.ca>
In-Reply-To: <20200304164903.GF31668@ziepe.ca>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 5 Mar 2020 12:26:01 +0100
Message-ID: <CAMGffEncbGXhFLDxZJp957c7vmV4vCaTZFUVKwqDROFikCTLPg@mail.gmail.com>
Subject: Re: [PATCH v9 06/25] RDMA/rtrs: client: main functionality
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
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

On Wed, Mar 4, 2020 at 5:49 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Mar 04, 2020 at 05:43:24PM +0100, Jinpu Wang wrote:
> > On Tue, Mar 3, 2020 at 5:04 PM Bart Van Assche <bvanassche@acm.org> wrote:
> > >
> > > On 3/2/20 5:20 AM, Danil Kipnis wrote:
> > > > On Sun, Mar 1, 2020 at 2:33 AM Bart Van Assche <bvanassche@acm.org> wrote:
> > > >> On 2020-02-21 02:47, Jack Wang wrote:
> > > >>> +static struct rtrs_permit *
> > > >>> +__rtrs_get_permit(struct rtrs_clt *clt, enum rtrs_clt_con_type con_type)
> > > >>> +{
> > > >>> +     size_t max_depth = clt->queue_depth;
> > > >>> +     struct rtrs_permit *permit;
> > > >>> +     int cpu, bit;
> > > >>> +
> > > >>> +     /* Combined with cq_vector, we pin the IO to the the cpu it comes */
> > > >>
> > > >> This comment is confusing. Please clarify this comment. All I see below
> > > >> is that preemption is disabled. I don't see pinning of I/O to the CPU of
> > > >> the caller.
> > > > The comment is addressing a use-case of the driver: The user can
> > > > assign (under /proc/irq/) the irqs of the HCA cq_vectors "one-to-one"
> > > > to each cpu. This will "force" the driver to process io response on
> > > > the same cpu the io has been submitted on.
> > > > In the code below only preemption is disabled. This can lead to the
> > > > situation that callers from different cpus will grab the same bit,
> > > > since find_first_zero_bit is not atomic. But then the
> > > > test_and_set_bit_lock will fail for all the callers but one, so that
> > > > they will loop again. This way an explicit spinlock is not required.
> > > > Will extend the comment.
> > >
> > > If the purpose of get_cpu() and put_cpu() calls is to serialize code
> > > against other threads, please use locking instead of disabling
> > > preemption. This will help tools that verify locking like lockdep and
> > > the kernel thread sanitizer (https://github.com/google/ktsan/wiki).
> > We can look into it, but I'm afraid converting to spinlock might have
> > a performance impact.
>
> I very much dislike seeing people inventing locking, rarely is it done
> right. Making assumptions about IRQ scheduling in a driver seems
> really sketchy.
>
> Why do you need preemption disabled when using an atomic varient of
> test_and_set_bit anyhow? It is atomic, just loop?

We have to admit, the code snip is from null_blk, get_tag function,
not invented by us.
the get_cpu/put_cpu was added to get/save the current cpu_id, which
can be removed around the do-while loop.,
we only need to raw_smp_processor_id to get current cpu, we use it
later to pick which connection to use.

Bart asked in the past,  we missed that, thanks Jason for bringing up it.

>
> > > >> I don't think that posting a signalled send from time to time is
> > > >> sufficient to prevent send queue overflow. Please address Jason's
> > > >> comment from January 7th: "Not quite. If the SQ depth is 16 and you post
> > > >> 16 things and then signal the last one, you *cannot* post new work until
> > > >> you see the completion. More SQ space *ONLY* becomes available upon
> > > >> receipt of a completion. This is why you can't have an unsignaled SQ."
> > > >
> > > >> See also https://lore.kernel.org/linux-rdma/20200107182528.GB26174@ziepe.ca/
> > > > In our case we set the send queue of each QP belonging to one
> > > > "session" to the one supported by the hardware (max_qp_wr) which is
> > > > around 5K on our hardware. The queue depth of our "session" is 512.
> > > > Those 512 are "shared" by all the QPs (number of CPUs on client side)
> > > > belonging to that session. So we have at most 512 and 512/num_cpus on
> > > > average inflights on each QP. We never experienced send queue full
> > > > event in any of our performance tests or production usage. The
> > > > alternative would be to count submitted requests and completed
> > > > requests, check the difference before submission and wait if the
> > > > difference multiplied by the queue depth of "session" exceeds the max
> > > > supported by the hardware. The check will require quite some code and
> > > > will most probably affect performance. I do not think it is worth it
> > > > to introduce a code path which is triggered only on a condition which
> > > > is known to never become true.
> > > > Jason, do you think it's necessary to implement such tracking?
> > >
> > > Please either make sure that send queues do not overflow by providing
> > > enough space for 512 in-flight requests fit or implement tracking for
> > > the number of in-flight requests.
> > We do have enough space for send queue.
>
> You have to do something to provably guarantee the send q cannot
> overflow. send q overflow is defined as calling post_send before a
> poll_cq has confirmed space is available for send.
>
> Jason
Shouldn't the cq api handle that already,  with IB_POLL_SOFTIRQ,
poll cq is done on very softirq run, so send queue space should be reclaimed
fast enough, with IB_POLL_WORKQUEUE, when cq->com_handler get called,
the ib_cq_poll_work will do the poll_cq, together with extra
send_queue size reserved,
the send queue can not overflow!

Thanks Jason for your input!
