Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 284D11795A6
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2020 17:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbgCDQtG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Mar 2020 11:49:06 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:34351 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729739AbgCDQtF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Mar 2020 11:49:05 -0500
Received: by mail-qv1-f65.google.com with SMTP id o18so1083095qvf.1
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2020 08:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mjXBqK43ZhRFhOl4roKv5ZY/OevXO+FWZo5TDXRyTWw=;
        b=MkE8KxkoTCxMz5+lI8ntS7GzkHQpz2coaGggdUcnf4X1ficOE+PAAwgz6CrncYH/8a
         D2S71endvyGQbasc6sVlZiq3Kedz3W3TtBeLNtSVx2QpD0k5ghgQ3UG+fq2NYTFhP5jV
         eIdT/dXZDlvdEVo92e0dnId+uoNhIo4pcrl4N4L6P3YivTuDmz6PAv26Pm6zHFLL6NKv
         /aZlmRDWSDncUAUPY7mHW/HeR8wHxsY4pv2ci441TiefrWRYJeIDTt30W4U7n5U1n73g
         iNR7cfiOBIsxAS4+I4t1/dJuqdUMuCGpjReKvlWNaSGU83xDyTuIh4iI6l+lOca5nPIR
         xDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mjXBqK43ZhRFhOl4roKv5ZY/OevXO+FWZo5TDXRyTWw=;
        b=Ld+oimJEpv9oaypAe+zDi279nTGg9Ib9reDRDegPiyuP98MH16cH3Ud8bhHDM4NEAj
         KLK9QPRs8BERmvvTH4qKTi+6lsMwHTEang5U7zkbT6IWGUPhNYKqJ8E3k+WRNRfBkiw/
         KfShqXTGWn0i4xmLItSxuCJ3Rlz5Zqa8dQvXxml2dN9VIQUfna8GUJbiwTCggIpv4GlI
         3CtmGHzdnrqxaKjxKGpAnYdNMcnKoE90rcHPksTwtOa88L3Qzi6TloXtroZIoseFdmZu
         7vNibI1HvoXr0kg7P53CdplmxAmuiOzvvgKr8JdH/9KlG/cDOObSTrtYuVOY38fJdPKc
         9ZEg==
X-Gm-Message-State: ANhLgQ2+nPk8dCIrnmZLARm2q4KqY1SJnHEnDDo8n5V5vJ5LraUHrj/X
        IJrOli3zB6CRaCWo/kCRQ92/AQ==
X-Google-Smtp-Source: ADFU+vsYqXXZmOKRzrCnklEhovyvImbBUZisnYjuoF1r4DFjOl+XSXzvWHQiQ3MIq2Yn/7JA5lXyYA==
X-Received: by 2002:a05:6214:3cc:: with SMTP id ce12mr2728886qvb.169.1583340544736;
        Wed, 04 Mar 2020 08:49:04 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id d137sm8124466qkc.99.2020.03.04.08.49.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Mar 2020 08:49:04 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j9XCh-0005SZ-Ko; Wed, 04 Mar 2020 12:49:03 -0400
Date:   Wed, 4 Mar 2020 12:49:03 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
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
Subject: Re: [PATCH v9 06/25] RDMA/rtrs: client: main functionality
Message-ID: <20200304164903.GF31668@ziepe.ca>
References: <20200221104721.350-1-jinpuwang@gmail.com>
 <20200221104721.350-7-jinpuwang@gmail.com>
 <c3c8fbcc-0028-9b23-8eff-3b5f1f60e652@acm.org>
 <CAHg0HuxJgjQca3Vy7nbcVKs0bUoj=-Uqoa5DOzYoqRHQ6Vph7A@mail.gmail.com>
 <597777e7-ac5a-5fc4-c1f7-3ffa5876a6f2@acm.org>
 <CAMGffEmbV1YL4O860EswBKm2UHBYP_cgqMFYFVc2AdHnAFeu+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEmbV1YL4O860EswBKm2UHBYP_cgqMFYFVc2AdHnAFeu+g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 04, 2020 at 05:43:24PM +0100, Jinpu Wang wrote:
> On Tue, Mar 3, 2020 at 5:04 PM Bart Van Assche <bvanassche@acm.org> wrote:
> >
> > On 3/2/20 5:20 AM, Danil Kipnis wrote:
> > > On Sun, Mar 1, 2020 at 2:33 AM Bart Van Assche <bvanassche@acm.org> wrote:
> > >> On 2020-02-21 02:47, Jack Wang wrote:
> > >>> +static struct rtrs_permit *
> > >>> +__rtrs_get_permit(struct rtrs_clt *clt, enum rtrs_clt_con_type con_type)
> > >>> +{
> > >>> +     size_t max_depth = clt->queue_depth;
> > >>> +     struct rtrs_permit *permit;
> > >>> +     int cpu, bit;
> > >>> +
> > >>> +     /* Combined with cq_vector, we pin the IO to the the cpu it comes */
> > >>
> > >> This comment is confusing. Please clarify this comment. All I see below
> > >> is that preemption is disabled. I don't see pinning of I/O to the CPU of
> > >> the caller.
> > > The comment is addressing a use-case of the driver: The user can
> > > assign (under /proc/irq/) the irqs of the HCA cq_vectors "one-to-one"
> > > to each cpu. This will "force" the driver to process io response on
> > > the same cpu the io has been submitted on.
> > > In the code below only preemption is disabled. This can lead to the
> > > situation that callers from different cpus will grab the same bit,
> > > since find_first_zero_bit is not atomic. But then the
> > > test_and_set_bit_lock will fail for all the callers but one, so that
> > > they will loop again. This way an explicit spinlock is not required.
> > > Will extend the comment.
> >
> > If the purpose of get_cpu() and put_cpu() calls is to serialize code
> > against other threads, please use locking instead of disabling
> > preemption. This will help tools that verify locking like lockdep and
> > the kernel thread sanitizer (https://github.com/google/ktsan/wiki).
> We can look into it, but I'm afraid converting to spinlock might have
> a performance impact.

I very much dislike seeing people inventing locking, rarely is it done
right. Making assumptions about IRQ scheduling in a driver seems
really sketchy.

Why do you need preemption disabled when using an atomic varient of
test_and_set_bit anyhow? It is atomic, just loop?

> > >> I don't think that posting a signalled send from time to time is
> > >> sufficient to prevent send queue overflow. Please address Jason's
> > >> comment from January 7th: "Not quite. If the SQ depth is 16 and you post
> > >> 16 things and then signal the last one, you *cannot* post new work until
> > >> you see the completion. More SQ space *ONLY* becomes available upon
> > >> receipt of a completion. This is why you can't have an unsignaled SQ."
> > >
> > >> See also https://lore.kernel.org/linux-rdma/20200107182528.GB26174@ziepe.ca/
> > > In our case we set the send queue of each QP belonging to one
> > > "session" to the one supported by the hardware (max_qp_wr) which is
> > > around 5K on our hardware. The queue depth of our "session" is 512.
> > > Those 512 are "shared" by all the QPs (number of CPUs on client side)
> > > belonging to that session. So we have at most 512 and 512/num_cpus on
> > > average inflights on each QP. We never experienced send queue full
> > > event in any of our performance tests or production usage. The
> > > alternative would be to count submitted requests and completed
> > > requests, check the difference before submission and wait if the
> > > difference multiplied by the queue depth of "session" exceeds the max
> > > supported by the hardware. The check will require quite some code and
> > > will most probably affect performance. I do not think it is worth it
> > > to introduce a code path which is triggered only on a condition which
> > > is known to never become true.
> > > Jason, do you think it's necessary to implement such tracking?
> >
> > Please either make sure that send queues do not overflow by providing
> > enough space for 512 in-flight requests fit or implement tracking for
> > the number of in-flight requests.
> We do have enough space for send queue.

You have to do something to provably guarantee the send q cannot
overflow. send q overflow is defined as calling post_send before a
poll_cq has confirmed space is available for send.

Jason
